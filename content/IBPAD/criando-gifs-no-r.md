+++
title = "Criando GIFs no R"
date = "2016-09-19 16:59:38"
categories = ["IBPAD"]
original_url = "http://www.ibpad.com.br/blog/analise-de-dados/criando-gifs-no-r/"
+++

<p>
 
</p>
<p style="text-align: right;">
<em>\[Texto do prof.
<a href="http://www.ibpad.com.br/team-member/robert-mcdonnell/">Robert
McDonnell</a>, responsável pelo curso de
<a href="http://www.ibpad.com.br/produto/programacao-em-r/">Programação
em R</a> do IBPAD\]</em>
</p>
<p>
 
</p>
<p>
<img class="alignleft" src="https://i1.wp.com/ibpad.com.br/wp-content/uploads/2016/09/download-2.gif?resize=203%2C282" data-recalc-dims="1" />R
é famoso por suas capacidades gráficas, mas podemos integrá-lo com
browsers modernos da internet para criar gráficos cada vez mais úteis.
Por exemplo, podemos mostrar a mudança numa variável sobre valores de
duas outras variáveis usando gifs. Neste post, eu vou mostrar como criar
um gráfico gif no R que demostra os preços
de<a href="http://seriesestatisticas.ibge.gov.br/series.aspx?vcodigo=PRECO415" target="_blank">
casas e construção </a>no Brasil de 2000 até 2016 por cada estado. O
formato gif nos permite fazer isso num gráfico só; senão, precisaríamos
de 27 gráficos separados ou um gráfico muito confuso.<br /> Primeiro,
vamos importar os dados, que são do IBGE, no R. Nós vamos ler do meu
github, usando uma função que organiza os dados e arrumá-los do jeito
que precisamos. (Para saber mais da função, simplesmente digite o nome
dela no console do R.) Se você não tem algum dos pacotes que eu uso
abaixo, vai precisar o instalar com a função install.packages(” “), com
o nome do pacote entre aspas.
</p>
<p>
 
</p>
<pre class="crayon-plain-tag">library(tidyverse)
library(devtools)
library(lubridate)
library(stringr)
preco &lt;- read_csv("https://raw.githubusercontent.com/RobertMyles/various/master/data/series_historicas.csv")
source_gist("82320196db01c1c95e152955e5de9edc", filename = "clean_ibge.R",
            sha1 = "c18480aa7c67ccc9ae6756310e41bcb3351d455f")
preco &lt;- clean_ibge(preco)</pre>
<p>
Agora os dados estão no formato que precisamos. Para criar o gif, vamos
usar mais três pacotes do R. Neste primeiro gif, o intervalo entre
transições é controlado pelo interval.
</p>
<pre class="crayon-plain-tag">library(ggplot2)
library(scales)
library(gganimate)

p &lt;- ggplot(preco, aes(time, sum, color = UF, frame = UF)) +
  geom_line(aes(cumulative = FALSE)) + 
  theme_minimal() + 
  theme(legend.position="none") + 
  scale_y_continuous(labels=dollar_format(prefix="R$"))

gg_animate(p, title_frame = T, interval=3)</pre>
<p>
 
</p>
<p>
<img class="aligncenter" src="https://i2.wp.com/ibpad.com.br/wp-content/uploads/2016/09/download.gif?w=900" alt="download.gif (480×480)" data-recalc-dims="1" />
</p>
<p>
 
</p>
<p>
 
</p>
<p>
E neste segundo, usamos
<pre class="crayon-plain-tag">cumulative = TRUE</pre>
  para colocar as linhas dos preços uma em cima da outra.
</p>
<pre class="crayon-plain-tag">q &lt;- ggplot(preco, aes(time, sum, color = UF, frame = UF)) +
  geom_line(aes(cumulative = TRUE)) + 
  theme_minimal() + 
  theme(legend.position="none") + 
  scale_y_continuous(labels=dollar_format(prefix="R$"))

gg_animate(q, title_frame = T, interval=2)</pre>
<p>
 
</p>
<p>
<img class="aligncenter" src="https://i1.wp.com/ibpad.com.br/wp-content/uploads/2016/09/download-2.gif?w=900" data-recalc-dims="1" />
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
<a href="http://www.ibpad.com.br/produto/programacao-em-r/">Quer
aprender R? Conheça nosso curso!
</a><a href="http://www.ibpad.com.br/produto/programacao-em-r/" target="_blank">Turmas
abertas em São Paulo e no Rio de Janeiro.</a>
</p>
<p>
O post
<a rel="nofollow" href="http://www.ibpad.com.br/blog/analise-de-dados/criando-gifs-no-r/">Criando
GIFs no R</a> apareceu primeiro em
<a rel="nofollow" href="http://www.ibpad.com.br">IBPAD</a>.
</p>

