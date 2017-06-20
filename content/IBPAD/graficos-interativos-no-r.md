+++
title = "Gráficos Interativos no R"
date = "2016-10-15 20:52:20"
categories = ["IBPAD"]
original_url = "http://www.ibpad.com.br/blog/analise-de-dados/graficos-interativos-no-r/"
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
Uma área em que a análise de dados vem se expandindo nos últimos tempos
são os gráficos interativos. Há alguns exemplos realmente excelentes na
web, tais como Gráficos D3 do
<a href="http://rpsychologist.com/d3/CI/" target="_blank">R Psychologist
</a> e do
<a href="http://ibpad.com.br/index.php/2016/08/30/comex-vis-plataforma-interativa-de-dados-de-comercio-exterior/" target="_blank">Comex
Vis</a>. O que esses gráficos interativos possuem em comum é a
utilização de um navegador para a visualização. Um pacote que é
particularmente fácil de usar é
<pre class="crayon-plain-tag">ggiraph</pre>
 que interage com o pacote ggplot do R.
</p>
<p>
Vou mostrar aqui como nós podemos utilizar o
<pre class="crayon-plain-tag">ggiraph</pre>
 para criar de forma muito rápida gráficos interativos no R. Primeiro,
vamos instalar o pacote e carregá-lo:
</p>
<pre class="crayon-plain-tag"># install.packages("ggiraph") #se você não tiver o pacote instalado 
library(ggiraph)</pre>
<p>
Eu vou utilizar um banco de dados que normalmente é utilizado nos
exemplos
<a href="https://cran.r-project.org/web/packages/ggiraph/vignettes/ggiraph.html" target="_blank" class="broken_link">do
pacote</a>. O 
<pre class="crayon-plain-tag">dataset</pre>
  se chama “USArrests” que já vem com o R. Nesse banco de dados, os
nomes dos estados dos EUA são os nomes das linhas do “dataframe”, o que
não é necessariamente o ideal.  Vamos aqui criar um uma variável chamada
<pre class="crayon-plain-tag">State</pre>
, com o nome das linhas.
</p>
<pre class="crayon-plain-tag">crimes &lt;- data.frame(state = rownames(USArrests), USArrests)
row.names(crimes) &lt;- NULL
head(crimes)</pre>
<p>
 
</p>
<pre class="crayon-plain-tag">##        state Murder Assault UrbanPop Rape
## 1    Alabama   13.2     236       58 21.2
## 2     Alaska   10.0     263       48 44.5
## 3    Arizona    8.1     294       80 31.0
## 4   Arkansas    8.8     190       50 19.5
## 5 California    9.0     276       91 40.6
## 6   Colorado    7.9     204       78 38.7</pre>
<p>
Vou utilizar o
<pre class="crayon-plain-tag">ggplot2</pre>
 e o 
<pre class="crayon-plain-tag">ggiraph</pre>
 para construir um gráfico para entender como a quantidade de
assassinatos se comporta com o tamanho da população urbana. Para fazer
isso, será necessário salvar o gráfico como um objeto e depois chamar o
comando 
<pre class="crayon-plain-tag">ggiraph()</pre>
 . Observe que os argumentos 
<pre class="crayon-plain-tag">data_id</pre>
 e 
<pre class="crayon-plain-tag">tooltip</pre>
 controlam o que será visto quando passarmos o mouse sobre o ponto no
gráfico.
</p>
<pre class="crayon-plain-tag">murder_plot &lt;- ggplot(crimes, aes(x = UrbanPop, y = Murder)) + 
geom_point_interactive(aes(data_id = state, tooltip = state), size = 3) + 
scale_colour_gradient(low = "#999999", high = "#FF3333") + 
theme_minimal()

ggiraph(code = print(murder_plot))</pre>
<p>
</p>
<p style="text-align: center;">
<iframe style="border: 0px #ffffff none;" src="http://ibpad.com.br/lib/grafico1/grafico1.html" name="grafico1" width="600px" height="400px" frameborder="0" marginwidth="0px" marginheight="0px" scrolling="no" allowfullscreen="allowfullscreen">
</iframe>
</p>
<p>
Você visualizará esse gráfico no painel “Viewer” do RStudio ou em um
navegador como o Chrome, clicando em visualizar em uma nova janela.
</p>
<p>
<img class="size-medium wp-image-1605 aligncenter" src="https://i1.wp.com/ibpad.com.br/wp-content/uploads/2016/10/aba-viewer-300x245.png?resize=300%2C245" alt="aba-viewer" data-recalc-dims="1" /><br />
O gráfico está ok, mas ele pode ser um pouco mais interessante. Por
exemplo: e se analisássemos a correlação de estupros e assaltos e como
eles se comportam com o aumento populacional nos EUA?
</p>
<pre class="crayon-plain-tag">assault_plot geom_point_interactive(aes(data_id = state, tooltip = state), size = 3) +
scale_colour_gradient(low = "#CAE1FF", high = "#4682B4") +
theme_minimal()

ggiraph(code = print(assault_plot))</pre>
<p>
</p>
<p style="text-align: center;">
<iframe style="border: 0px #ffffff none;" src="http://ibpad.com.br/lib/grafico1/grafico2.html" name="grafico1" width="600px" height="400px" frameborder="0" marginwidth="0px" marginheight="0px" scrolling="no" allowfullscreen="allowfullscreen">
</iframe>
</p>
<p>
Existem vários outros pacotes para criar gráficos interativos no R, como
o <a href="http://rpubs.com/bhaskarvk/tilegramsR" target="_blank">tilegramsR</a> ou
o ggviz. Entretanto, o 
<pre class="crayon-plain-tag">ggiraph</pre>
 é definitivamente um dos mais fáceis de ser utilizados.
</p>
<p style="text-align: center;">
<a href="http://www.ibpad.com.br/produto/programacao-em-r/">Quer
aprender R? Conheça nosso curso!
</a><a href="http://www.ibpad.com.br/produto/programacao-em-r/" target="_blank">Turmas
abertas em São Paulo e no Rio de Janeiro.</a>
</p>
<p>
\[:en\]One area in which data analysis has been expanding in recent
times is interactive graphics. There are some truly excellent examples
on the web, such as R
Psychologist’s<a href="http://rpsychologist.com/d3/CI/" target="_blank">
d3 graphics</a> and those built to interact with R’s ggplot2 package,
such as <a href="https://plot.ly/ggplot2/" target="_blank">plotly</a>.
What these have in common is the use of a modern browser. RStudio
already comes with its own browser, so we can build interactive graphics
right inside RStudio. One package that is particularly easy to use is
<pre class="crayon-plain-tag">ggiraph</pre>
 .
</p>
<p>
We can use
<pre class="crayon-plain-tag">ggiraph</pre>
 to quickly create an interactive graphic in R. First, let’s install and
load the package:
</p>
<pre class="crayon-plain-tag"># install.packages("ggiraph") if you don't have the package installed
library(ggiraph)</pre>
<p>
We can use a dataset, as in the
<pre class="crayon-plain-tag">ggiraph</pre>
 package vignette, to make our graph. The
<pre class="crayon-plain-tag">dataset</pre>
 is “USArrests” from the datasets package, which comes with R. In this
dataset, the names of the US states are the row names of the dataframe,
which is not ideal. We can first create a new variable,
<pre class="crayon-plain-tag">State</pre>
 , which is made of these row names.
</p>
<pre class="crayon-plain-tag">crimes &lt;- data.frame(state = rownames(USArrests), USArrests)
row.names(crimes) &lt;- NULL
head(crimes)</pre>
<p>
 
</p>
<pre class="crayon-plain-tag">##        state Murder Assault UrbanPop Rape
## 1    Alabama   13.2     236       58 21.2
## 2     Alaska   10.0     263       48 44.5
## 3    Arizona    8.1     294       80 31.0
## 4   Arkansas    8.8     190       50 19.5
## 5 California    9.0     276       91 40.6
## 6   Colorado    7.9     204       78 38.7</pre>
<p>
We can use
<pre class="crayon-plain-tag">ggplot2</pre>
 and
<pre class="crayon-plain-tag">ggiraph</pre>
 to build a plot of how murder changes with urban population. It
involves saving the plot as an object and then sending to the call to
<pre class="crayon-plain-tag">ggiraph()</pre>
 . The
<pre class="crayon-plain-tag">data_id</pre>
  and tooltip arguments control what we see when we hover over the data
point.
</p>
<pre class="crayon-plain-tag">murder_plot &lt;- ggplot(crimes, aes(x = UrbanPop, y = Murder)) + 
geom_point_interactive(aes(data_id = state, tooltip = state), size = 3) + 
scale_colour_gradient(low = "#999999", high = "#FF3333") + 
theme_minimal()

ggiraph(code = print(murder_plot))</pre>
<p>
</p>
<p style="text-align: center;">
<iframe style="border: 0px #ffffff none;" src="http://ibpad.com.br/lib/grafico1/grafico1.html" name="grafico1" width="600px" height="400px" frameborder="0" marginwidth="0px" marginheight="0px" scrolling="no" allowfullscreen="allowfullscreen">
</iframe>
</p>
<p>
You can view this graphic either in the “Viewer” pane in RStudio or in a
browser such as Chrome (the browser is better, click on the little white
arrow and square in the Viewer pane of RStudio).
</p>
<p>
This graphic is okay, but we could make some that are a little more
interesting. For example, are rapes and assaults correlated? And how do
they change as population increases?
</p>
<pre class="crayon-plain-tag">assault_plot geom_point_interactive(aes(data_id = state, tooltip = state), size = 3) +
scale_colour_gradient(low = "#CAE1FF", high = "#4682B4") +
theme_minimal()

ggiraph(code = print(assault_plot))</pre>
<p>
</p>
<p style="text-align: center;">
<iframe style="border: 0px #ffffff none;" src="http://ibpad.com.br/lib/grafico1/grafico2.html" name="grafico1" width="600px" height="400px" frameborder="0" marginwidth="0px" marginheight="0px" scrolling="no" allowfullscreen="allowfullscreen">
</iframe>
</p>
<p>
There are of course other interactive graphics packages, such as
<a href="http://rpubs.com/bhaskarvk/tilegramsR" target="_blank">tilegramsR</a>
or ggviz, however,
<pre class="crayon-plain-tag">ggiraph</pre>
 is definitely one of the easiest to use.
</p>
<p>
O post
<a rel="nofollow" href="http://www.ibpad.com.br/blog/analise-de-dados/graficos-interativos-no-r/">Gráficos
Interativos no R</a> apareceu primeiro em
<a rel="nofollow" href="http://www.ibpad.com.br">IBPAD</a>.
</p>

