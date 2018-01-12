+++
title = "Criando GIFs no R"
date = "2016-09-19 16:59:38"
categories = ["IBPAD"]
original_url = "https://www.ibpad.com.br/blog/analise-de-dados/criando-gifs-no-r/"
+++

<p>
 
</p>
<p style="text-align: right;">
<em>\[Texto do prof.
<a href="https://www.ibpad.com.br/team-member/robert-mcdonnell/">Robert
McDonnell</a>, responsável pelo curso de
<a href="https://www.ibpad.com.br/produto/programacao-em-r/">Programação
em R</a> do IBPAD\]</em>
</p>
<p>
 
</p>
<p>
<img class="alignleft" src="https://ibpad.com.br/wp-content/uploads/2016/09/download-2.gif" width="203" height="282">R
é famoso por suas capacidades gráficas, mas podemos integrá-lo com
browsers modernos da internet para criar gráficos cada vez mais úteis.
Por exemplo, podemos mostrar a mudança numa variável sobre valores de
duas outras variáveis usando gifs. Neste post, eu vou mostrar como criar
um gráfico gif no R que demostra os preços
de<a href="http://seriesestatisticas.ibge.gov.br/series.aspx?vcodigo=PRECO415" target="_blank">
casas e construção </a>no Brasil de 2000 até 2016 por cada estado. O
formato gif nos permite fazer isso num gráfico só; senão, precisaríamos
de 27 gráficos separados ou um gráfico muito confuso.<br> Primeiro,
vamos importar os dados, que são do IBGE, no R. Nós vamos ler do meu
github, usando uma função que organiza os dados e arrumá-los do jeito
que precisamos. (Para saber mais da função, simplesmente digite o nome
dela no console do R.) Se você não tem algum dos pacotes que eu uso
abaixo, vai precisar o instalar com a função install.packages(” “), com
o nome do pacote entre aspas.
</p>
<p>
 
</p>
<span class="crayon-title"></span>

<span class="crayon-language">R</span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
library(tidyverse) library(devtools) library(lubridate) library(stringr)
preco &lt;-
read\_csv("<https://raw.githubusercontent.com/RobertMyles/various/master/data/series_historicas.csv>")
source\_gist("82320196db01c1c95e152955e5de9edc", filename =
"clean\_ibge.R", sha1 = "c18480aa7c67ccc9ae6756310e41bcb3351d455f")
preco &lt;- clean\_ibge(preco)
</textarea>

<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
1

2

3

4

5

6

7

8

</td>
<td class="crayon-code">
<span class="crayon-r">library</span><span
class="crayon-sy">(</span><span class="crayon-v">tidyverse</span><span
class="crayon-sy">)</span>

<span class="crayon-r">library</span><span
class="crayon-sy">(</span><span class="crayon-v">devtools</span><span
class="crayon-sy">)</span>

<span class="crayon-r">library</span><span
class="crayon-sy">(</span><span class="crayon-v">lubridate</span><span
class="crayon-sy">)</span>

<span class="crayon-r">library</span><span
class="crayon-sy">(</span><span class="crayon-v">stringr</span><span
class="crayon-sy">)</span>

<span class="crayon-v">preco</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-e">read\_csv</span><span
class="crayon-sy">(</span><span
class="crayon-s">"<https://raw.githubusercontent.com/RobertMyles/various/master/data/series_historicas.csv>"</span><span
class="crayon-sy">)</span>

<span class="crayon-e">source\_gist</span><span
class="crayon-sy">(</span><span
class="crayon-s">"82320196db01c1c95e152955e5de9edc"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">filename</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"clean\_ibge.R"</span><span class="crayon-sy">,</span>

<span class="crayon-h">            </span><span
class="crayon-v">sha1</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"c18480aa7c67ccc9ae6756310e41bcb3351d455f"</span><span
class="crayon-sy">)</span>

<span class="crayon-v">preco</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-e">clean\_ibge</span><span
class="crayon-sy">(</span><span class="crayon-v">preco</span><span
class="crayon-sy">)</span>

</td>
</tr>
</table>

<p>
Agora os dados estão no formato que precisamos. Para criar o gif, vamos
usar mais três pacotes do R. Neste primeiro gif, o intervalo entre
transições é controlado pelo interval.
</p>
<span class="crayon-title"></span>

<span class="crayon-language">R</span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
library(ggplot2) library(scales) library(gganimate)

p &lt;- ggplot(preco, aes(time, sum, color = UF, frame = UF)) +
geom\_line(aes(cumulative = FALSE)) + theme\_minimal() +
theme(legend.position="none") +
scale\_y\_continuous(labels=dollar\_format(prefix="R$"))

gg\_animate(p, title\_frame = T, interval=3)
</textarea>

<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
1

2

3

4

5

6

7

8

9

10

11

</td>
<td class="crayon-code">
<span class="crayon-r">library</span><span
class="crayon-sy">(</span><span class="crayon-v">ggplot2</span><span
class="crayon-sy">)</span>

<span class="crayon-r">library</span><span
class="crayon-sy">(</span><span class="crayon-v">scales</span><span
class="crayon-sy">)</span>

<span class="crayon-r">library</span><span
class="crayon-sy">(</span><span class="crayon-v">gganimate</span><span
class="crayon-sy">)</span>

 

<span class="crayon-v">p</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-e">ggplot</span><span
class="crayon-sy">(</span><span class="crayon-v">preco</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-e">aes</span><span class="crayon-sy">(</span><span
class="crayon-v">time</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">sum</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">color</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">UF</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">frame</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-v">UF</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">+</span>

<span class="crayon-h">  </span><span
class="crayon-e">geom\_line</span><span class="crayon-sy">(</span><span
class="crayon-e">aes</span><span class="crayon-sy">(</span><span
class="crayon-v">cumulative</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-t">FALSE</span><span class="crayon-sy">)</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">+</span><span class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">theme\_minimal</span><span
class="crayon-sy">(</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">+</span><span
class="crayon-h"> </span>

<span class="crayon-h">  </span><span class="crayon-e">theme</span><span
class="crayon-sy">(</span><span class="crayon-v">legend</span><span
class="crayon-sy">.</span><span class="crayon-v">position</span><span
class="crayon-o">=</span><span class="crayon-s">"none"</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">+</span><span class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">scale\_y\_continuous</span><span
class="crayon-sy">(</span><span class="crayon-v">labels</span><span
class="crayon-o">=</span><span
class="crayon-e">dollar\_format</span><span
class="crayon-sy">(</span><span class="crayon-v">prefix</span><span
class="crayon-o">=</span><span class="crayon-s">"R$"</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span>

 

<span class="crayon-e">gg\_animate</span><span
class="crayon-sy">(</span><span class="crayon-v">p</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">title\_frame</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-t">T</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">interval</span><span
class="crayon-o">=</span><span class="crayon-cn">3</span><span
class="crayon-sy">)</span>

</td>
</tr>
</table>

<p>
 
</p>
<p>
<img class="aligncenter" src="https://ibpad.com.br/wp-content/uploads/2016/09/download.gif" alt="download.gif (480×480)">
</p>
<p>
 
</p>
<p>
 
</p>
<p>
E neste segundo, usamos <span id="crayon-5a5818d8a2b54598968585"
class="crayon-syntax crayon-syntax-inline crayon-theme-classic crayon-theme-classic-inline crayon-font-monaco"
style="font-size: 12px !important; line-height: 15px !important;font-size: 12px !important;"><span
class="crayon-pre crayon-code"
style="font-size: 12px !important; line-height: 15px !important;font-size: 12px !important; -moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4;"><span
class="crayon-v">cumulative</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-t">TRUE</span></span></span>  para colocar as linhas dos
preços uma em cima da outra.
</p>
<span class="crayon-title"></span>

<span class="crayon-language">R</span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
q &lt;- ggplot(preco, aes(time, sum, color = UF, frame = UF)) +
geom\_line(aes(cumulative = TRUE)) + theme\_minimal() +
theme(legend.position="none") +
scale\_y\_continuous(labels=dollar\_format(prefix="R$"))

gg\_animate(q, title\_frame = T, interval=2)
</textarea>

<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
1

2

3

4

5

6

7

</td>
<td class="crayon-code">
<span class="crayon-v">q</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-e">ggplot</span><span
class="crayon-sy">(</span><span class="crayon-v">preco</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-e">aes</span><span class="crayon-sy">(</span><span
class="crayon-v">time</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">sum</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">color</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">UF</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">frame</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-v">UF</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">+</span>

<span class="crayon-h">  </span><span
class="crayon-e">geom\_line</span><span class="crayon-sy">(</span><span
class="crayon-e">aes</span><span class="crayon-sy">(</span><span
class="crayon-v">cumulative</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-t">TRUE</span><span class="crayon-sy">)</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">+</span><span class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">theme\_minimal</span><span
class="crayon-sy">(</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">+</span><span
class="crayon-h"> </span>

<span class="crayon-h">  </span><span class="crayon-e">theme</span><span
class="crayon-sy">(</span><span class="crayon-v">legend</span><span
class="crayon-sy">.</span><span class="crayon-v">position</span><span
class="crayon-o">=</span><span class="crayon-s">"none"</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">+</span><span class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">scale\_y\_continuous</span><span
class="crayon-sy">(</span><span class="crayon-v">labels</span><span
class="crayon-o">=</span><span
class="crayon-e">dollar\_format</span><span
class="crayon-sy">(</span><span class="crayon-v">prefix</span><span
class="crayon-o">=</span><span class="crayon-s">"R$"</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span>

 

<span class="crayon-e">gg\_animate</span><span
class="crayon-sy">(</span><span class="crayon-v">q</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">title\_frame</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-t">T</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">interval</span><span
class="crayon-o">=</span><span class="crayon-cn">2</span><span
class="crayon-sy">)</span>

</td>
</tr>
</table>

<p>
 
</p>
<p>
<img class="aligncenter" src="https://ibpad.com.br/wp-content/uploads/2016/09/download-2.gif">
</p>
<p>
 
</p>
<p>
Com o pacote ggplot2 e tudo que pode-se construir cima dele, é muito
fácil customizar os gráficos. Exemplos podem ser vistos
<a href="https://github.com/dgrtwo/gganimate">aqui</a> e as opções de
animação podem ser estendidas com o pacote tweenr.
</p>
<p>
 
</p>
<p>
—
</p>
<p>
 
</p>
<p>
<a href="https://www.ibpad.com.br/produto/programacao-em-r/">Quer
aprender R? Conheça nosso curso!
</a><a href="https://www.ibpad.com.br/produto/programacao-em-r/" target="_blank">Turmas
abertas em São Paulo e no Rio de Janeiro.</a>
</p>

