+++
title = "Pacotes brasileiros de R: SciencesPo e SoundexBR do Daniel Marcelino"
date = "2017-02-10 14:36:02"
categories = ["IBPAD"]
original_url = "https://www.ibpad.com.br/blog/analise-de-dados/pacotes-brasileiros-do-r-parte-1-sciencespo-e-soundexbr-do-daniel-marcelino/"
+++

<div class="post-inner-content">
<p>
<img class="size-thumbnail wp-image-4329 alignleft" src="https://www.ibpad.com.br/wp-content/uploads/2017/02/Pacotes-br-1-card-1-120x120.png" alt="" width="120" height="120" srcset="https://www.ibpad.com.br/wp-content/uploads/2017/02/Pacotes-br-1-card-1-120x120.png 120w, https://www.ibpad.com.br/wp-content/uploads/2017/02/Pacotes-br-1-card-1-180x180.png 180w, https://www.ibpad.com.br/wp-content/uploads/2017/02/Pacotes-br-1-card-1-300x300.png 300w, https://www.ibpad.com.br/wp-content/uploads/2017/02/Pacotes-br-1-card-1-100x100.png 100w, https://www.ibpad.com.br/wp-content/uploads/2017/02/Pacotes-br-1-card-1-70x70.png 70w, https://www.ibpad.com.br/wp-content/uploads/2017/02/Pacotes-br-1-card-1-160x160.png 160w, https://www.ibpad.com.br/wp-content/uploads/2017/02/Pacotes-br-1-card-1-320x320.png 320w" sizes="(max-width: 120px) 100vw, 120px">Iniciamos com
esse artigo uma série de postagens sobre Pacotes e programadores
brasileiros. Nosso objetivo aqui é mostrar o grande desenvolvimento que
o R tem tido aqui no Brasil.
</p>
<p>
Começaremos, então, com o cientista
político <a href="https://danielmarcelino.github.io/" target="_blank">Daniel
Marcelino</a> , o autor de dois pacotes para R: o
<a href="https://cran.r-project.org/web/packages/SciencesPo/index.html" target="_blank">SciencesPo</a>
e o
<a href="https://github.com/danielmarcelino/soundexBR" target="_blank">SoundexBR</a>.
Neste post nós vamos dar uma olhada nesses pacotes mostrando uns
destaques interessantes e como utilizá-los nas suas análises.
</p>
<p>
Primeiro, é preciso instalar eles no R e os carregar:
</p>
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
install.packages("SciencesPo") install.packages("SoundexBR")

library("SciencesPo") library("SoundexBR")
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

</td>
<td class="crayon-code">
<span class="crayon-v">install</span><span
class="crayon-sy">.</span><span class="crayon-e">packages</span><span
class="crayon-sy">(</span><span
class="crayon-s">"SciencesPo"</span><span class="crayon-sy">)</span>

<span class="crayon-v">install</span><span
class="crayon-sy">.</span><span class="crayon-e">packages</span><span
class="crayon-sy">(</span><span class="crayon-s">"SoundexBR"</span><span
class="crayon-sy">)</span>

 

<span class="crayon-e">library</span><span
class="crayon-sy">(</span><span
class="crayon-s">"SciencesPo"</span><span class="crayon-sy">)</span>

<span class="crayon-e">library</span><span
class="crayon-sy">(</span><span class="crayon-s">"SoundexBR"</span><span
class="crayon-sy">)</span>

 

</td>
</tr>
</table>

<p>
Para conhecer todas as funções do pacote, basta usar o comando
<code>help(package = "")</code> e nome do pacote entre aspas.
</p>
<hr>
<blockquote>
<p style="text-align: right;">
<a href="https://www.ibpad.com.br/blog/formacao-em-r/" target="_blank"><br></a><a href="https://www.ibpad.com.br/blog/formacao-em-r/" target="_blank"><img class="aligncenter wp-image-4138 size-medium" src="https://www.ibpad.com.br/wp-content/uploads/2017/02/Vitrine-R-260x241.png" width="260" height="241" srcset="https://www.ibpad.com.br/wp-content/uploads/2017/02/Vitrine-R-260x241.png 260w, https://www.ibpad.com.br/wp-content/uploads/2017/02/Vitrine-R-768x711.png 768w, https://www.ibpad.com.br/wp-content/uploads/2017/02/Vitrine-R-1024x948.png 1024w, https://www.ibpad.com.br/wp-content/uploads/2017/02/Vitrine-R-100x93.png 100w, https://www.ibpad.com.br/wp-content/uploads/2017/02/Vitrine-R.png 1225w" sizes="(max-width: 260px) 100vw, 260px"></a>
</p>
<p style="text-align: center;">
<a href="https://www.ibpad.com.br/blog/formacao-em-r/" target="_blank">Conheça
a Formação em R do IBPAD</a>
</p>
<hr>
</blockquote>
<h2 id="sciencespo">
SciencesPo
</h2>
<p>
SciencesPo tem muitas funções ligadas a área de Ciência Política, em
particular aos temas de distribuição dos resultados de uma eleição. O
pacote também tem algumas bases de dados que você pode utilizar para
explorar – e que podem ser vistos com <code>data(package =
"SciencesPo")</code>.
</p>
<p>
Uma função que achei bem interessante é a
<code>PoliticalDiversity()</code>, que calcula a medida de competição
política num território, ou seja, quão perto ou longe de monopolia é o
“mercado” político. Primeiro, eu vou usar o pacote tidyverse para
importar e arrumar uns dados brasileiros, da eleição 2016, disponível do
<a href="http://www.tse.jus.br/eleicoes/estatisticas/estatisticas-eleitorais-2016/resultados" target="_blank">TSE</a>.
</p>
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
library(tidyverse) tse &lt;-
read\_csv("<https://raw.githubusercontent.com/RobertMyles/Various_R-Scripts/master/data/quadro_partido_x_cargo.csv>")
%&gt;% filter(Partido != "Subtotal", Partido != "Total Geral") %&gt;%
mutate(total = 39623213, prop = `Qt Votos Validos`/total)
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

</td>
<td class="crayon-code">
<span class="crayon-e">library</span><span
class="crayon-sy">(</span><span class="crayon-v">tidyverse</span><span
class="crayon-sy">)</span>

<span class="crayon-v">tse</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-e">read\_csv</span><span
class="crayon-sy">(</span><span
class="crayon-s">"<https://raw.githubusercontent.com/RobertMyles/Various_R-Scripts/master/data/quadro_partido_x_cargo.csv>"</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&gt;</span><span
class="crayon-o">%</span><span class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">filter</span><span class="crayon-sy">(</span><span
class="crayon-v">Partido</span><span class="crayon-h"> </span><span
class="crayon-o">!=</span><span class="crayon-h"> </span><span
class="crayon-s">"Subtotal"</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">Partido</span><span
class="crayon-h"> </span><span class="crayon-o">!=</span><span
class="crayon-h"> </span><span class="crayon-s">"Total
Geral"</span><span class="crayon-sy">)</span><span class="crayon-h">
</span><span class="crayon-o">%</span><span
class="crayon-o">&gt;</span><span class="crayon-o">%</span><span
class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">mutate</span><span class="crayon-sy">(</span><span
class="crayon-v">total</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-cn">39623213</span><span class="crayon-sy">,</span>

<span class="crayon-h">         </span><span
class="crayon-v">prop</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-sy">`</span><span class="crayon-e">Qt </span><span class="crayon-e">Votos </span><span class="crayon-v">Validos</span><span class="crayon-sy">`</span><span
class="crayon-o">/</span><span class="crayon-v">total</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span>

 

</td>
</tr>
</table>

<p>
33 partidos conseguiram representação nessas eleições. A função
<code>PolticalDiversity()</code> nos ajuda a ver o <em>peso</em> destes
partidos no sistema, considerando que uns partidos têm muitos membros
eleitos enquanto outros têm poucos.
</p>
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
PoliticalDiversity(tse$prop, index = "golosov")

\[1\] 27.89
-----------

</textarea>

<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
1

2

3

4

</td>
<td class="crayon-code">
<span class="crayon-e">PoliticalDiversity</span><span
class="crayon-sy">(</span><span class="crayon-v">tse</span><span
class="crayon-sy">$</span><span class="crayon-v">prop</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">index</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"golosov"</span><span class="crayon-sy">)</span><span
class="crayon-h">  </span>

 

<span class="crayon-p">\#\# \[1\] 27.89</span>

 

</td>
</tr>
</table>

<p>
A função mostra que é melhor pensar que os sistemas têm 28 partidos
efetivos, o que ainda é um número grande em comparação com outros
países. Por exemplo, podemos fazer a mesma coisa com dados dos Estados
Unidos:
</p>
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
usa &lt;-
read\_csv("<https://raw.githubusercontent.com/RobertMyles/Various_R-Scripts/master/data/tables2014.csv>")
%&gt;% slice(58) %&gt;% select(-1) %&gt;% gather(partido, prop)

PoliticalDiversity(usa$prop, index = "golosov")

\[1\] 2.299
-----------

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

</td>
<td class="crayon-code">
<span class="crayon-v">usa</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-e">read\_csv</span><span
class="crayon-sy">(</span><span
class="crayon-s">"<https://raw.githubusercontent.com/RobertMyles/Various_R-Scripts/master/data/tables2014.csv>"</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&gt;</span><span
class="crayon-o">%</span><span class="crayon-h"> </span>

<span class="crayon-h">  </span><span class="crayon-e">slice</span><span
class="crayon-sy">(</span><span class="crayon-cn">58</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&gt;</span><span
class="crayon-o">%</span><span class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">select</span><span class="crayon-sy">(</span><span
class="crayon-o">-</span><span class="crayon-cn">1</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&gt;</span><span
class="crayon-o">%</span>

<span class="crayon-h">  </span><span
class="crayon-e">gather</span><span class="crayon-sy">(</span><span
class="crayon-v">partido</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">prop</span><span
class="crayon-sy">)</span>

 

<span class="crayon-e">PoliticalDiversity</span><span
class="crayon-sy">(</span><span class="crayon-v">usa</span><span
class="crayon-sy">$</span><span class="crayon-v">prop</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">index</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"golosov"</span><span class="crayon-sy">)</span>

 

<span class="crayon-p">\#\# \[1\] 2.299</span>

 

</td>
</tr>
</table>

<p>
Ou França, usando dados do governo francês que podemos “scrapear” do
website:
</p>
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
library(rvest) fr &lt;-
read\_html("<http://www.interieur.gouv.fr/Elections/Les-resultats/Legislatives/elecresult__LG2012/(path)/LG2012//FE.html>")
%&gt;% html\_node(css = "\#content-wrap &gt; div &gt;
table:nth-child(15)") %&gt;% html\_table(header = T, dec = ",", trim =
T) %&gt;% select(1, prop = 3)

PoliticalDiversity(fr$prop, index = "golosov")

\[1\] 15.325
------------

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

</td>
<td class="crayon-code">
<span class="crayon-e">library</span><span
class="crayon-sy">(</span><span class="crayon-v">rvest</span><span
class="crayon-sy">)</span>

<span class="crayon-v">fr</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-e">read\_html</span><span
class="crayon-sy">(</span><span
class="crayon-s">"<http://www.interieur.gouv.fr/Elections/Les-resultats/Legislatives/elecresult__LG2012/(path)/LG2012//FE.html>"</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&gt;</span><span
class="crayon-o">%</span>

<span class="crayon-h">  </span><span
class="crayon-e">html\_node</span><span class="crayon-sy">(</span><span
class="crayon-v">css</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"\#content-wrap &gt; div &gt;
table:nth-child(15)"</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">%</span><span
class="crayon-o">&gt;</span><span class="crayon-o">%</span>

<span class="crayon-h">  </span><span
class="crayon-e">html\_table</span><span class="crayon-sy">(</span><span
class="crayon-v">header</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">T</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">dec</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-s">","</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">trim</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">T</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">%</span><span
class="crayon-o">&gt;</span><span class="crayon-o">%</span>

<span class="crayon-h">  </span><span
class="crayon-e">select</span><span class="crayon-sy">(</span><span
class="crayon-cn">1</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">prop</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-cn">3</span><span
class="crayon-sy">)</span>

 

<span class="crayon-e">PoliticalDiversity</span><span
class="crayon-sy">(</span><span class="crayon-v">fr</span><span
class="crayon-sy">$</span><span class="crayon-v">prop</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">index</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"golosov"</span><span class="crayon-sy">)</span>

 

<span class="crayon-p">\#\# \[1\] 15.325</span>

 

</td>
</tr>
</table>

<p>
Vamos visualizar tudo isso:
</p>
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
prop &lt;- data\_frame(prop = c(27.89, 2.299, 15.325), pais =
c("brasil", "usa", "france")) ggplot(prop, aes(x = pais, y = prop)) +
geom\_bar(color = "black", stat="identity", width=.5, aes(fill = pais))
+ theme\_classic() + scale\_fill\_manual(values = c("\#007600",
"\#E0162B", "\#0052A5")) + ylab("proporção") + xlab("país")
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

</td>
<td class="crayon-code">
<span class="crayon-v">prop</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-e">data\_frame</span><span
class="crayon-sy">(</span><span class="crayon-v">prop</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-e">c</span><span
class="crayon-sy">(</span><span class="crayon-cn">27.89</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-cn">2.299</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-cn">15.325</span><span
class="crayon-sy">)</span><span class="crayon-sy">,</span>

<span class="crayon-h">                   </span><span
class="crayon-v">pais</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-e">c</span><span class="crayon-sy">(</span><span
class="crayon-s">"brasil"</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-s">"usa"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-s">"france"</span><span class="crayon-sy">)</span><span
class="crayon-sy">)</span>

<span class="crayon-e">ggplot</span><span
class="crayon-sy">(</span><span class="crayon-v">prop</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-e">aes</span><span class="crayon-sy">(</span><span
class="crayon-v">x</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">pais</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">y</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-v">prop</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">+</span><span
class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">geom\_bar</span><span class="crayon-sy">(</span><span
class="crayon-v">color</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"black"</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">stat</span><span
class="crayon-o">=</span><span class="crayon-s">"identity"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">width</span><span class="crayon-o">=</span><span
class="crayon-sy">.</span><span class="crayon-cn">5</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span>

<span class="crayon-h">           </span><span
class="crayon-e">aes</span><span class="crayon-sy">(</span><span
class="crayon-v">fill</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">pais</span><span class="crayon-sy">)</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">+</span>

<span class="crayon-h">  </span><span
class="crayon-e">theme\_classic</span><span
class="crayon-sy">(</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">+</span>

<span class="crayon-h">  </span><span
class="crayon-e">scale\_fill\_manual</span><span
class="crayon-sy">(</span><span class="crayon-v">values</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-e">c</span><span
class="crayon-sy">(</span><span class="crayon-s">"\#007600"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-s">"\#E0162B"</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-s">"\#0052A5"</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">+</span>

<span class="crayon-h">  </span><span class="crayon-e">ylab</span><span
class="crayon-sy">(</span><span class="crayon-s">"proporção"</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">+</span><span class="crayon-h"> </span><span
class="crayon-e">xlab</span><span class="crayon-sy">(</span><span
class="crayon-s">"país"</span><span class="crayon-sy">)</span>

 

</td>
</tr>
</table>

<p>
<img src="https://www.ibpad.com.br/wp-content/uploads/2017/02/ibpad_BR_paises.png" alt="">
</p>
<h3 id="proporcionalidade-pol-tica">
Proporcionalidade Política
</h3>
<p>
Uma outra questão de interesse na área de Ciência Política é a de
proporcionalidade, ou seja, a quantidade de cadeiras que um partido
ganha numa eleição referente à proporção de votos ganhados pelo partido.
Um sistema no qual um partido ganha 30% das cadeiras depois ganha 30%
dos votos seria perfeitamente proporcional, por exemplo.
</p>
<p>
Podemos investigar este tema usando SciencesPo, com a função
<code>Proportionality()</code>. Vamos usar dados da Irlanda, de novo
tirando os dados da Wikipedia, que é bom para este tipo de análise.
Pegar dados da internet sempre envolve trabalho para arrumar, mas com
tidyverse essa tarefa vira simples. Depois fazemos a mesma coisa com
dados do Brasil para comparação.
</p>
<span class="crayon-title"></span>
<span class="crayon-mixed-highlight"
title="Contem Várias Linguagens"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
ire &lt;-
read\_html("<https://en.wikipedia.org/wiki/Irish_general_election,_2016>")
%&gt;% html\_node(css = "\#mw-content-text &gt; table:nth-child(41)")
%&gt;% html\_table(header = F) %&gt;% t() %&gt;% as\_data\_frame()
%&gt;% select(-2, -5, -7)

colnames(ire) &lt;- ire\[1, \]

ire &lt;- ire %&gt;% slice(-1) %&gt;% rename(Votes = `Votes,1st pref.`)
%&gt;% separate(Votes, into = c("perc\_votes", "total\_votes"), sep =
",") %&gt;% separate(Seats, into = c("total\_seats", "perc\_seats"), sep
= "\\(") %&gt;% distinct(Party, Leader, .keep\_all = T) %&gt;%
mutate(perc\_votes = as.numeric(gsub("%", "", perc\_votes)), perc\_seats
= as.numeric(gsub("%\\)", "", perc\_seats)))

Proportionality(ire*p**e**r**c*<sub>*v*</sub>*o**t**e**s*, *i**r**e*perc\_seats)

Gallagher's Index : 0.045
-------------------------

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

12

13

14

15

16

17

18

19

20

21

22

23

</td>
<td class="crayon-code">
<span class="crayon-v">ire</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-e">read\_html</span><span
class="crayon-sy">(</span><span
class="crayon-s">"<https://en.wikipedia.org/wiki/Irish_general_election,_2016>"</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&gt;</span><span
class="crayon-o">%</span><span class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">html\_node</span><span class="crayon-sy">(</span><span
class="crayon-v">css</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"\#mw-content-text &gt;
table:nth-child(41)"</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">%</span><span
class="crayon-o">&gt;</span><span class="crayon-o">%</span><span
class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">html\_table</span><span class="crayon-sy">(</span><span
class="crayon-v">header</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">F</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">%</span><span
class="crayon-o">&gt;</span><span class="crayon-o">%</span><span
class="crayon-h"> </span>

<span class="crayon-h">  </span><span class="crayon-e">t</span><span
class="crayon-sy">(</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">%</span><span
class="crayon-o">&gt;</span><span class="crayon-o">%</span>

<span class="crayon-h">  </span><span
class="crayon-e">as\_data\_frame</span><span
class="crayon-sy">(</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">%</span><span
class="crayon-o">&gt;</span><span class="crayon-o">%</span>

<span class="crayon-h">  </span><span
class="crayon-e">select</span><span class="crayon-sy">(</span><span
class="crayon-o">-</span><span class="crayon-cn">2</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-o">-</span><span class="crayon-cn">5</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-o">-</span><span class="crayon-cn">7</span><span
class="crayon-sy">)</span>

 

<span class="crayon-e">colnames</span><span
class="crayon-sy">(</span><span class="crayon-v">ire</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-v">ire</span><span
class="crayon-sy">\[</span><span class="crayon-cn">1</span><span
class="crayon-sy">,</span><span class="crayon-h">
</span><span class="crayon-sy">\]</span>

 

<span class="crayon-v">ire</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-v">ire</span><span
class="crayon-h"> </span><span class="crayon-o">%</span><span
class="crayon-o">&gt;</span><span class="crayon-o">%</span>

<span class="crayon-h">  </span><span class="crayon-e">slice</span><span
class="crayon-sy">(</span><span class="crayon-o">-</span><span
class="crayon-cn">1</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">%</span><span
class="crayon-o">&gt;</span><span class="crayon-o">%</span>

<span class="crayon-h">  </span><span
class="crayon-e">rename</span><span class="crayon-sy">(</span><span
class="crayon-v">Votes</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-sy">`</span><span class="crayon-v">Votes</span><span class="crayon-sy">,</span><span class="crayon-cn">1st</span><span class="crayon-h"> </span><span class="crayon-v">pref</span><span class="crayon-sy">.</span><span class="crayon-sy">`</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&gt;</span><span
class="crayon-o">%</span>

<span class="crayon-h">  </span><span
class="crayon-e">separate</span><span class="crayon-sy">(</span><span
class="crayon-v">Votes</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">into</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-e">c</span><span
class="crayon-sy">(</span><span
class="crayon-s">"perc\_votes"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-s">"total\_votes"</span><span
class="crayon-sy">)</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">sep</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-s">","</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&gt;</span><span
class="crayon-o">%</span>

<span class="crayon-h">  </span><span
class="crayon-e">separate</span><span class="crayon-sy">(</span><span
class="crayon-v">Seats</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">into</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-e">c</span><span
class="crayon-sy">(</span><span
class="crayon-s">"total\_seats"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-s">"perc\_seats"</span><span
class="crayon-sy">)</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">sep</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-s">"&lt;span
class="crayon-sy"&gt;&lt;/span&gt;<span class="crayon-sy">(</span>"<span
class="crayon-sy">)</span> %&gt;%</span>

<span class="crayon-s">  distinct(Party, Leader, .keep\_all = T) %&gt;%
</span>

<span class="crayon-s">  mutate(perc\_votes =
as.numeric(gsub("</span><span class="crayon-o">%</span><span
class="crayon-s">", "</span><span class="crayon-s">",
perc\_votes)),</span>

<span class="crayon-s">         perc\_seats =
as.numeric(gsub("</span><span
class="crayon-o">%</span><span class="crayon-sy">&lt;/span&gt;<span class="crayon-sy">&lt;/span&gt;<span
class="crayon-sy">)</span><span class="crayon-s">", "</span>"<span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">perc\_seats</span><span class="crayon-sy">)</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span>

 

<span class="crayon-e">Proportionality</span><span
class="crayon-sy">(</span><span class="crayon-v">ire</span><span
class="crayon-sy">$&lt;/span&gt;&lt;span class="crayon-v"&gt;perc\_votes&lt;/span&gt;&lt;span class="crayon-sy"&gt;,&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-v"&gt;ire&lt;/span&gt;&lt;span class="crayon-sy"&gt;$</span><span
class="crayon-v">perc\_seats</span><span class="crayon-sy">)</span>

 

<span class="crayon-p">\#\# </span>

<span class="crayon-p">\#\# Gallagher's Index :  0.045</span>

 

</td>
</tr>
</table>

<p>
 
</p>
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
br &lt;-
read\_html("<https://en.wikipedia.org/wiki/Brazilian_general_election,_2014>")
%&gt;% html\_nodes("table") %&gt;% html\_table(fill = T) br &lt;-
br\[\[11\]\] br &lt;- br\[-1, c(3, 5, 7)\]

colnames(br)\[2:3\] &lt;- c("perc\_votos", "perc\_cadeiras")

'%ni%' &lt;- Negate('%in%')

br &lt;- br %&gt;% filter(Parties %ni% c("Total", "Total valid votes"))
%&gt;% mutate(perc\_cadeiras = gsub("%", "", perc\_cadeiras),
perc\_cadeiras = as.numeric(gsub(",", "\\.", perc\_cadeiras)),
perc\_votos = gsub("%", "", perc\_votos), perc\_votos =
as.numeric(gsub(",", "\\.", perc\_votos)))

Proportionality(br*p**e**r**c*<sub>*v*</sub>*o**t**o**s*, *b**r*perc\_cadeiras)

Gallagher's Index : 0.022
-------------------------

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

12

13

14

15

16

17

18

19

20

21

22

23

</td>
<td class="crayon-code">
 

<span class="crayon-v">br</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-e">read\_html</span><span
class="crayon-sy">(</span><span
class="crayon-s">"<https://en.wikipedia.org/wiki/Brazilian_general_election,_2014>"</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&gt;</span><span
class="crayon-o">%</span><span class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">html\_nodes</span><span class="crayon-sy">(</span><span
class="crayon-s">"table"</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">%</span><span
class="crayon-o">&gt;</span><span class="crayon-o">%</span>

<span class="crayon-h">  </span><span
class="crayon-e">html\_table</span><span class="crayon-sy">(</span><span
class="crayon-v">fill</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">T</span><span class="crayon-sy">)</span>

<span class="crayon-v">br</span><span class="crayon-h"> </span><span
class="crayon-o">&</span><span class="crayon-v">lt</span><span
class="crayon-sy">;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-v">br</span><span
class="crayon-sy">\[</span><span class="crayon-sy">\[</span><span
class="crayon-cn">11</span><span class="crayon-sy">\]</span><span class="crayon-sy">\]</span>

<span class="crayon-v">br</span><span class="crayon-h"> </span><span
class="crayon-o">&</span><span class="crayon-v">lt</span><span
class="crayon-sy">;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-v">br</span><span
class="crayon-sy">\[</span><span class="crayon-o">-</span><span
class="crayon-cn">1</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-e">c</span><span
class="crayon-sy">(</span><span class="crayon-cn">3</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-cn">5</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-cn">7</span><span
class="crayon-sy">)</span><span class="crayon-sy">\]</span>

 

<span class="crayon-e">colnames</span><span
class="crayon-sy">(</span><span class="crayon-v">br</span><span
class="crayon-sy">)</span><span class="crayon-sy">\[</span><span
class="crayon-cn">2</span><span class="crayon-o">:</span><span
class="crayon-cn">3</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-o">&</span><span
class="crayon-v">lt</span><span class="crayon-sy">;</span><span
class="crayon-o">-</span><span class="crayon-h"> </span><span
class="crayon-e">c</span><span class="crayon-sy">(</span><span
class="crayon-s">"perc\_votos"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-s">"perc\_cadeiras"</span><span class="crayon-sy">)</span>

 

<span class="crayon-s">'%ni%'</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-e">Negate</span><span
class="crayon-sy">(</span><span class="crayon-s">'%in%'</span><span
class="crayon-sy">)</span>

 

<span class="crayon-v">br</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-v">br</span><span
class="crayon-h"> </span><span class="crayon-o">%</span><span
class="crayon-o">&gt;</span><span class="crayon-o">%</span><span
class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">filter</span><span class="crayon-sy">(</span><span
class="crayon-v">Parties</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-v">ni</span><span
class="crayon-o">%</span><span class="crayon-h"> </span><span
class="crayon-e">c</span><span class="crayon-sy">(</span><span
class="crayon-s">"Total"</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-s">"Total valid
votes"</span><span class="crayon-sy">)</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&gt;</span><span
class="crayon-o">%</span><span class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">mutate</span><span class="crayon-sy">(</span><span
class="crayon-v">perc\_cadeiras</span><span class="crayon-h">
</span><span class="crayon-o">=</span><span class="crayon-h">
</span><span class="crayon-e">gsub</span><span
class="crayon-sy">(</span><span class="crayon-s">"%"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-s">""</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span
class="crayon-v">perc\_cadeiras</span><span
class="crayon-sy">)</span><span class="crayon-sy">,</span>

<span class="crayon-h">         </span><span
class="crayon-v">perc\_cadeiras</span><span class="crayon-h">
</span><span class="crayon-o">=</span><span class="crayon-h">
</span><span class="crayon-st">as</span><span
class="crayon-sy">.</span><span class="crayon-e">numeric</span><span
class="crayon-sy">(</span><span class="crayon-e">gsub</span><span
class="crayon-sy">(</span><span class="crayon-s">","</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-s">"\\."</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span
class="crayon-v">perc\_cadeiras</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span><span
class="crayon-sy">,</span>

<span class="crayon-h">         </span><span
class="crayon-v">perc\_votos</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-e">gsub</span><span class="crayon-sy">(</span><span
class="crayon-s">"%"</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-s">""</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">perc\_votos</span><span class="crayon-sy">)</span><span
class="crayon-sy">,</span>

<span class="crayon-h">         </span><span
class="crayon-v">perc\_votos</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-st">as</span><span class="crayon-sy">.</span><span
class="crayon-e">numeric</span><span class="crayon-sy">(</span><span
class="crayon-e">gsub</span><span class="crayon-sy">(</span><span
class="crayon-s">","</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-s">"\\."</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">perc\_votos</span><span class="crayon-sy">)</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span>

 

<span class="crayon-e">Proportionality</span><span
class="crayon-sy">(</span><span class="crayon-v">br</span><span
class="crayon-sy">$&lt;/span&gt;&lt;span class="crayon-v"&gt;perc\_votos&lt;/span&gt;&lt;span class="crayon-sy"&gt;,&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-v"&gt;br&lt;/span&gt;&lt;span class="crayon-sy"&gt;$</span><span
class="crayon-v">perc\_cadeiras</span><span class="crayon-sy">)</span>

 

<span class="crayon-p">\#\# </span>

<span class="crayon-p">\#\# Gallagher's Index :  0.022</span>

 

</td>
</tr>
</table>

<p>
Dado que zero é perfeitamente proporcional, parece que o sistema
brasileiro é mais justo do que o sistema irlandês neste aspecto. Uma
visualização simples:
</p>
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
ire\_br &lt;- data\_frame(pais = c("irlanda", "brasil"), perc = c(0.045,
0.022))

ggplot(ire\_br, aes(x = pais, y = perc)) + geom\_point(size = 3) +
geom\_segment(aes(x = pais, xend = pais, y = -Inf, yend = perc)) +
labs(x = "país", y = "", caption="source: Wikipedia") + coord\_flip() +
theme\_classic() + theme(axis.ticks.y = element\_blank())
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

12

13

</td>
<td class="crayon-code">
<span class="crayon-v">ire\_br</span><span class="crayon-h">
</span><span class="crayon-o">&lt;</span><span
class="crayon-o">-</span><span class="crayon-h"> </span><span
class="crayon-e">data\_frame</span><span class="crayon-sy">(</span><span
class="crayon-v">pais</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-e">c</span><span class="crayon-sy">(</span><span
class="crayon-s">"irlanda"</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-s">"brasil"</span><span
class="crayon-sy">)</span><span class="crayon-sy">,</span>

<span class="crayon-h">                     </span><span
class="crayon-v">perc</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-e">c</span><span class="crayon-sy">(</span><span
class="crayon-cn">0.045</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-cn">0.022</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span>

 

<span class="crayon-e">ggplot</span><span
class="crayon-sy">(</span><span class="crayon-v">ire\_br</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-e">aes</span><span class="crayon-sy">(</span><span
class="crayon-v">x</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">pais</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">y</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-v">perc</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">+</span><span
class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">geom\_point</span><span class="crayon-sy">(</span><span
class="crayon-v">size</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-cn">3</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">+</span><span
class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">geom\_segment</span><span
class="crayon-sy">(</span><span class="crayon-e">aes</span><span
class="crayon-sy">(</span><span class="crayon-v">x</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-v">pais</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">xend</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">pais</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span>

<span class="crayon-h">                   </span><span
class="crayon-v">y</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-o">-</span><span class="crayon-v">Inf</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">yend</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">perc</span><span class="crayon-sy">)</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">+</span><span class="crayon-h"> </span>

<span class="crayon-h">  </span><span class="crayon-e">labs</span><span
class="crayon-sy">(</span><span class="crayon-v">x</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-s">"país"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">y</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">""</span><span class="crayon-sy">,</span>

<span class="crayon-h">       </span><span
class="crayon-v">caption</span><span class="crayon-o">=</span><span
class="crayon-s">"source: Wikipedia"</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">+</span><span class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">coord\_flip</span><span class="crayon-sy">(</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">+</span><span class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">theme\_classic</span><span
class="crayon-sy">(</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">+</span>

<span class="crayon-h">  </span><span class="crayon-e">theme</span><span
class="crayon-sy">(</span><span class="crayon-v">axis</span><span
class="crayon-sy">.</span><span class="crayon-v">ticks</span><span
class="crayon-sy">.</span><span class="crayon-v">y</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span
class="crayon-e">element\_blank</span><span
class="crayon-sy">(</span><span class="crayon-sy">)</span><span
class="crayon-sy">)</span>

 

</td>
</tr>
</table>

<p>
<img src="https://www.ibpad.com.br/wp-content/uploads/2017/02/IBPAD_BR_ire_br.png" alt="">
</p>
<p>
O pacote SciencesPo é somente um dos ótimos pacotes feitos por
brasileiros que nós vamos explorar, e é só um dos pacotes feito por
Daniel. Veja
<a href="https://github.com/danielmarcelino/SciencesPo" target="_blank">o
site</a> do pacote para ver mais.
</p>
<h2 id="soundexbr">
SoundexBR
</h2>
<p>
A ideia do pacote SoundexBR, que é uma versão para português brasileiro
do algoritmo Soundex, disponível no R para a língua inglesa no pacote
<a href="http://www.markvanderloo.eu/yaRb/2014/08/22/stringdist-0-8-now-with-soundex/" target="_blank">stringdist</a>,
é identificar palavras que têm o mesmo som, dando a elas o mesmo código.
Por exemplo, as palavras “seção” e “sessão” retornam o mesmo código:
</p>
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
soundexBR(term = c("seção", "sessão"))

\[1\] "S200" "S200"
-------------------

</textarea>

<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
1

2

3

4

</td>
<td class="crayon-code">
<span class="crayon-e">soundexBR</span><span
class="crayon-sy">(</span><span class="crayon-v">term</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-e">c</span><span
class="crayon-sy">(</span><span class="crayon-s">"seção"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-s">"sessão"</span><span class="crayon-sy">)</span><span
class="crayon-sy">)</span>

 

<span class="crayon-p">\#\# \[1\] "S200" "S200"</span>

 

</td>
</tr>
</table>

<p>
Alguém que já tentou reunir bases de dados com soletragem diferentes já
vê o valor neste pacote!! É muito comum que você tenha uma base com
diferenças pequenas que podem estragar o seu dia. Por exemplo, eu tive
este problema quando eu estava fazendo um mapa do Brasil, com duas bases
no qual os nomes dos municípios eram diferentes, por muito pouco, como
no exemplo em baixo:
</p>
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
primeiros &lt;- c("ASSIS BRAZIL", "JOINVILE", "SAO GABRIEL DE CAHOEIRA",
"NOVO BRAZIL", "SEM-PEIXE") segundos &lt;- c("ASSIS BRASIL",
"JOINVILLE", "SAO GABRIEL DA CACHOEIRA", "NOVO BRASIL", "SEM PEIXE")

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

</td>
<td class="crayon-code">
<span class="crayon-v">primeiros</span><span class="crayon-h">
</span><span class="crayon-o">&lt;</span><span
class="crayon-o">-</span><span class="crayon-h"> </span><span
class="crayon-e">c</span><span class="crayon-sy">(</span><span
class="crayon-s">"ASSIS BRAZIL"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-s">"JOINVILE"</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-s">"SAO GABRIEL DE
CAHOEIRA"</span><span class="crayon-sy">,</span><span class="crayon-h">
</span>

<span class="crayon-h">               </span><span
class="crayon-s">"NOVO BRAZIL"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-s">"SEM-PEIXE"</span><span class="crayon-sy">)</span>

<span class="crayon-v">segundos</span><span class="crayon-h">
</span><span class="crayon-o">&lt;</span><span
class="crayon-o">-</span><span class="crayon-h"> </span><span
class="crayon-e">c</span><span class="crayon-sy">(</span><span
class="crayon-s">"ASSIS BRASIL"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-s">"JOINVILLE"</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-s">"SAO GABRIEL DA
CACHOEIRA"</span><span class="crayon-sy">,</span>

<span class="crayon-h">              </span><span class="crayon-s">"NOVO
BRASIL"</span><span class="crayon-sy">,</span><span class="crayon-h">
</span><span class="crayon-s">"SEM PEIXE"</span><span
class="crayon-sy">)</span>

 

 

</td>
</tr>
</table>

<p>
</p>
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
soundexBR(primeiros)

\[1\] "A221" "J514" "S216" "N116" "S512"
----------------------------------------

</textarea>

<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
1

2

3

4

5

</td>
<td class="crayon-code">
 

<span class="crayon-e">soundexBR</span><span
class="crayon-sy">(</span><span class="crayon-v">primeiros</span><span
class="crayon-sy">)</span>

 

<span class="crayon-p">\#\# \[1\] "A221" "J514" "S216" "N116"
"S512"</span>

 

</td>
</tr>
</table>

<p>
</p>
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
soundexBR(segundos)

\[1\] "A221" "J514" "S216" "N116" "S512"
----------------------------------------

</textarea>

<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
1

2

3

4

5

</td>
<td class="crayon-code">
 

<span class="crayon-e">soundexBR</span><span
class="crayon-sy">(</span><span class="crayon-v">segundos</span><span
class="crayon-sy">)</span>

 

<span class="crayon-p">\#\# \[1\] "A221" "J514" "S216" "N116"
"S512"</span>

 

</td>
</tr>
</table>

<p>
E podemos ver que o pacote SoundexBR resolve este problema facilmente!
</p>
<p>
Você pode conferir mais sobre como a Ciência Política pode utilizar o R
para análise de dados na palestra de Daniel Marcelino em evento do IBPAD
no ano passado em Brasília:
</p>
<p>
<iframe width="900" height="506" src="https://www.youtube.com/embed/oCYWNQ6e4LQ?feature=oembed" frameborder="0" gesture="media" allow="encrypted-media" allowfullscreen>
</iframe>
</p>
</div>

