+++
title = "Gráficos Interativos no R"
date = "2016-10-15 20:52:20"
categories = ["IBPAD"]
original_url = "https://www.ibpad.com.br/blog/analise-de-dados/graficos-interativos-no-r/"
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
Uma área em que a análise de dados vem se expandindo nos últimos tempos
são os gráficos interativos. Há alguns exemplos realmente excelentes na
web, tais como Gráficos D3 do
<a href="http://rpsychologist.com/d3/CI/" target="_blank">R Psychologist
</a> e do
<a href="http://ibpad.com.br/index.php/2016/08/30/comex-vis-plataforma-interativa-de-dados-de-comercio-exterior/" target="_blank">Comex
Vis</a>. O que esses gráficos interativos possuem em comum é a
utilização de um navegador para a visualização. Um pacote que é
particularmente fácil de usar é <span id="crayon-5a5818d56e799642954704"
class="crayon-syntax crayon-syntax-inline crayon-theme-github crayon-theme-github-inline crayon-font-monaco"
style="font-size: 12px !important; line-height: 15px !important;font-size: 12px !important;"><span
class="crayon-pre crayon-code"
style="font-size: 12px !important; line-height: 15px !important;font-size: 12px !important; -moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4;"><span
class="crayon-v">ggiraph</span></span></span> que interage com o pacote
ggplot do R.
</p>
<p>
Vou mostrar aqui como nós podemos utilizar o <span
id="crayon-5a5818d56e7a0000680801"
class="crayon-syntax crayon-syntax-inline crayon-theme-github crayon-theme-github-inline crayon-font-monaco"
style="font-size: 12px !important; line-height: 15px !important;font-size: 12px !important;"><span
class="crayon-pre crayon-code"
style="font-size: 12px !important; line-height: 15px !important;font-size: 12px !important; -moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4;"><span
class="crayon-v">ggiraph</span></span></span> para criar de forma muito
rápida gráficos interativos no R. Primeiro, vamos instalar o pacote e
carregá-lo:
</p>
<span class="crayon-title"></span>

<span class="crayon-language">R</span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
install.packages("ggiraph") \#se você não tiver o pacote instalado
==================================================================

library(ggiraph)
</textarea>

<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
1

2

</td>
<td class="crayon-code">
<span class="crayon-c">\# install.packages("ggiraph") \#se você não
tiver o pacote instalado </span>

<span class="crayon-r">library</span><span
class="crayon-sy">(</span><span class="crayon-v">ggiraph</span><span
class="crayon-sy">)</span>

</td>
</tr>
</table>

<p>
Eu vou utilizar um banco de dados que normalmente é utilizado nos
exemplos
<a href="https://cran.r-project.org/web/packages/ggiraph/vignettes/ggiraph.html" target="_blank">do
pacote</a>. O  <span id="crayon-5a5818d56e7a5615743066"
class="crayon-syntax crayon-syntax-inline crayon-theme-github crayon-theme-github-inline crayon-font-monaco"
style="font-size: 12px !important; line-height: 15px !important;font-size: 12px !important;"><span
class="crayon-pre crayon-code"
style="font-size: 12px !important; line-height: 15px !important;font-size: 12px !important; -moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4;"><span
class="crayon-v">dataset</span></span></span>  se chama “USArrests” que
já vem com o R. Nesse banco de dados, os nomes dos estados dos EUA são
os nomes das linhas do “dataframe”, o que não é necessariamente o ideal.
 Vamos aqui criar um uma variável chamada <span
id="crayon-5a5818d56e7a7063546071"
class="crayon-syntax crayon-syntax-inline crayon-theme-github crayon-theme-github-inline crayon-font-monaco"
style="font-size: 12px !important; line-height: 15px !important;font-size: 12px !important;"><span
class="crayon-pre crayon-code"
style="font-size: 12px !important; line-height: 15px !important;font-size: 12px !important; -moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4;"><span
class="crayon-v">State</span></span></span>, com o nome das linhas.
</p>
<span class="crayon-title"></span>

<span class="crayon-language">R</span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
crimes &lt;- data.frame(state = rownames(USArrests), USArrests)
row.names(crimes) &lt;- NULL head(crimes)
</textarea>

<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
1

2

3

</td>
<td class="crayon-code">
<span class="crayon-v">crimes</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-v">data</span><span
class="crayon-sy">.</span><span class="crayon-e">frame</span><span
class="crayon-sy">(</span><span class="crayon-v">state</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-e">rownames</span><span
class="crayon-sy">(</span><span class="crayon-v">USArrests</span><span
class="crayon-sy">)</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">USArrests</span><span
class="crayon-sy">)</span>

<span class="crayon-v">row</span><span class="crayon-sy">.</span><span
class="crayon-e">names</span><span class="crayon-sy">(</span><span
class="crayon-v">crimes</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">&lt;</span><span
class="crayon-o">-</span><span class="crayon-h"> </span><span
class="crayon-t">NULL</span>

<span class="crayon-e">head</span><span class="crayon-sy">(</span><span
class="crayon-v">crimes</span><span class="crayon-sy">)</span>

</td>
</tr>
</table>

<p>
 
</p>
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
state Murder Assault UrbanPop Rape
----------------------------------

1 Alabama 13.2 236 58 21.2
--------------------------

2 Alaska 10.0 263 48 44.5
-------------------------

3 Arizona 8.1 294 80 31.0
-------------------------

4 Arkansas 8.8 190 50 19.5
--------------------------

5 California 9.0 276 91 40.6
----------------------------

\#\# 6 Colorado 7.9 204 78 38.7
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
<span class="crayon-p">\#\#        state Murder Assault UrbanPop
Rape</span>

<span class="crayon-p">\#\# 1    Alabama   13.2     236       58
21.2</span>

<span class="crayon-p">\#\# 2     Alaska   10.0     263       48
44.5</span>

<span class="crayon-p">\#\# 3    Arizona    8.1     294       80
31.0</span>

<span class="crayon-p">\#\# 4   Arkansas    8.8     190       50
19.5</span>

<span class="crayon-p">\#\# 5 California    9.0     276       91
40.6</span>

<span class="crayon-p">\#\# 6   Colorado    7.9     204       78
38.7</span>

</td>
</tr>
</table>

<p>
Vou utilizar o <span id="crayon-5a5818d56e7ad859834852"
class="crayon-syntax crayon-syntax-inline crayon-theme-github crayon-theme-github-inline crayon-font-monaco"
style="font-size: 12px !important; line-height: 15px !important;font-size: 12px !important;"><span
class="crayon-pre crayon-code"
style="font-size: 12px !important; line-height: 15px !important;font-size: 12px !important; -moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4;"><span
class="crayon-v">ggplot2</span></span></span> e o  <span
id="crayon-5a5818d56e7af844167277"
class="crayon-syntax crayon-syntax-inline crayon-theme-github crayon-theme-github-inline crayon-font-monaco"
style="font-size: 12px !important; line-height: 15px !important;font-size: 12px !important;"><span
class="crayon-pre crayon-code"
style="font-size: 12px !important; line-height: 15px !important;font-size: 12px !important; -moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4;"><span
class="crayon-v">ggiraph</span></span></span> para construir um gráfico
para entender como a quantidade de assassinatos se comporta com o
tamanho da população urbana. Para fazer isso, será necessário salvar o
gráfico como um objeto e depois chamar o comando  <span
id="crayon-5a5818d56e7b0200417118"
class="crayon-syntax crayon-syntax-inline crayon-theme-github crayon-theme-github-inline crayon-font-monaco"
style="font-size: 12px !important; line-height: 15px !important;font-size: 12px !important;"><span
class="crayon-pre crayon-code"
style="font-size: 12px !important; line-height: 15px !important;font-size: 12px !important; -moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4;"><span
class="crayon-e">ggiraph</span><span class="crayon-sy">(</span><span
class="crayon-sy">)</span></span></span> . Observe que os argumentos 
<span id="crayon-5a5818d56e7b2248768889"
class="crayon-syntax crayon-syntax-inline crayon-theme-github crayon-theme-github-inline crayon-font-monaco"
style="font-size: 12px !important; line-height: 15px !important;font-size: 12px !important;"><span
class="crayon-pre crayon-code"
style="font-size: 12px !important; line-height: 15px !important;font-size: 12px !important; -moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4;"><span
class="crayon-v">data\_id</span></span></span> e  <span
id="crayon-5a5818d56e7b4762972148"
class="crayon-syntax crayon-syntax-inline crayon-theme-github crayon-theme-github-inline crayon-font-monaco"
style="font-size: 12px !important; line-height: 15px !important;font-size: 12px !important;"><span
class="crayon-pre crayon-code"
style="font-size: 12px !important; line-height: 15px !important;font-size: 12px !important; -moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4;"><span
class="crayon-v">tooltip</span></span></span> controlam o que será visto
quando passarmos o mouse sobre o ponto no gráfico.
</p>
<span class="crayon-title"></span>

<span class="crayon-language">R</span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
murder\_plot &lt;- ggplot(crimes, aes(x = UrbanPop, y = Murder)) +
geom\_point\_interactive(aes(data\_id = state, tooltip = state), size =
3) + scale\_colour\_gradient(low = "\#999999", high = "\#FF3333") +
theme\_minimal()

ggiraph(code = print(murder\_plot))
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
<span class="crayon-v">murder\_plot</span><span class="crayon-h">
</span><span class="crayon-o">&lt;</span><span
class="crayon-o">-</span><span class="crayon-h"> </span><span
class="crayon-e">ggplot</span><span class="crayon-sy">(</span><span
class="crayon-v">crimes</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-e">aes</span><span
class="crayon-sy">(</span><span class="crayon-v">x</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-v">UrbanPop</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">y</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">Murder</span><span class="crayon-sy">)</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">+</span><span class="crayon-h"> </span>

<span class="crayon-e">geom\_point\_interactive</span><span
class="crayon-sy">(</span><span class="crayon-e">aes</span><span
class="crayon-sy">(</span><span class="crayon-v">data\_id</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-v">state</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">tooltip</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">state</span><span class="crayon-sy">)</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">size</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-cn">3</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">+</span><span
class="crayon-h"> </span>

<span class="crayon-e">scale\_colour\_gradient</span><span
class="crayon-sy">(</span><span class="crayon-v">low</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-s">"\#999999"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">high</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"\#FF3333"</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">+</span><span
class="crayon-h"> </span>

<span class="crayon-e">theme\_minimal</span><span
class="crayon-sy">(</span><span class="crayon-sy">)</span>

 

<span class="crayon-e">ggiraph</span><span
class="crayon-sy">(</span><span class="crayon-v">code</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-e">print</span><span
class="crayon-sy">(</span><span
class="crayon-v">murder\_plot</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span>

</td>
</tr>
</table>

<p>
</p>
<p style="text-align: center;">
<iframe style="border: 0px #ffffff none;" src="https://ibpad.com.br/lib/grafico1/grafico1.html" name="grafico1" width="600px" height="400px" frameborder="0" marginwidth="0px" marginheight="0px" scrolling="no" allowfullscreen="allowfullscreen">
</iframe>
</p>
<p>
Você visualizará esse gráfico no painel “Viewer” do RStudio ou em um
navegador como o Chrome, clicando em visualizar em uma nova janela.
</p>
<p>
<img class="size-medium wp-image-1605 aligncenter" src="https://ibpad.com.br/wp-content/uploads/2016/10/aba-viewer-300x245.png" alt="aba-viewer" width="300" height="245"><br>
O gráfico está ok, mas ele pode ser um pouco mais interessante. Por
exemplo: e se analisássemos a correlação de estupros e assaltos e como
eles se comportam com o aumento populacional nos EUA?
</p>
<span class="crayon-title"></span>

<span class="crayon-language">R</span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
assault\_plot geom\_point\_interactive(aes(data\_id = state, tooltip =
state), size = 3) + scale\_colour\_gradient(low = "\#CAE1FF", high =
"\#4682B4") + theme\_minimal()

ggiraph(code = print(assault\_plot))
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
<span class="crayon-e">assault\_plot </span><span
class="crayon-e">geom\_point\_interactive</span><span
class="crayon-sy">(</span><span class="crayon-e">aes</span><span
class="crayon-sy">(</span><span class="crayon-v">data\_id</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-v">state</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">tooltip</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">state</span><span class="crayon-sy">)</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">size</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-cn">3</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">+</span>

<span class="crayon-e">scale\_colour\_gradient</span><span
class="crayon-sy">(</span><span class="crayon-v">low</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-s">"\#CAE1FF"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">high</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"\#4682B4"</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">+</span>

<span class="crayon-e">theme\_minimal</span><span
class="crayon-sy">(</span><span class="crayon-sy">)</span>

 

<span class="crayon-e">ggiraph</span><span
class="crayon-sy">(</span><span class="crayon-v">code</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-e">print</span><span
class="crayon-sy">(</span><span
class="crayon-v">assault\_plot</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span>

</td>
</tr>
</table>

<p>
</p>
<p style="text-align: center;">
<iframe style="border: 0px #ffffff none;" src="https://ibpad.com.br/lib/grafico1/grafico2.html" name="grafico1" width="600px" height="400px" frameborder="0" marginwidth="0px" marginheight="0px" scrolling="no" allowfullscreen="allowfullscreen">
</iframe>
</p>
<p>
Existem vários outros pacotes para criar gráficos interativos no R, como
o <a href="http://rpubs.com/bhaskarvk/tilegramsR" target="_blank">tilegramsR</a> ou
o ggviz. Entretanto, o  <span id="crayon-5a5818d56e7b9881872345"
class="crayon-syntax crayon-syntax-inline crayon-theme-github crayon-theme-github-inline crayon-font-monaco"
style="font-size: 12px !important; line-height: 15px !important;font-size: 12px !important;"><span
class="crayon-pre crayon-code"
style="font-size: 12px !important; line-height: 15px !important;font-size: 12px !important; -moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4;"><span
class="crayon-v">ggiraph</span></span></span> é definitivamente um dos
mais fáceis de ser utilizados.
</p>
<p style="text-align: center;">
<a href="https://www.ibpad.com.br/produto/programacao-em-r/">Quer
aprender R? Conheça nosso curso!
</a><a href="https://www.ibpad.com.br/produto/programacao-em-r/" target="_blank">Turmas
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
<span id="crayon-5a5818d56e7bc611491415"
class="crayon-syntax crayon-syntax-inline crayon-theme-github crayon-theme-github-inline crayon-font-monaco"
style="font-size: 12px !important; line-height: 15px !important;font-size: 12px !important;"><span
class="crayon-pre crayon-code"
style="font-size: 12px !important; line-height: 15px !important;font-size: 12px !important; -moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4;"><span
class="crayon-v">ggiraph</span></span></span> .
</p>
<p>
We can use <span id="crayon-5a5818d56e7bf703135854"
class="crayon-syntax crayon-syntax-inline crayon-theme-github crayon-theme-github-inline crayon-font-monaco"
style="font-size: 12px !important; line-height: 15px !important;font-size: 12px !important;"><span
class="crayon-pre crayon-code"
style="font-size: 12px !important; line-height: 15px !important;font-size: 12px !important; -moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4;"><span
class="crayon-v">ggiraph</span></span></span> to quickly create an
interactive graphic in R. First, let’s install and load the package:
</p>
<span class="crayon-title"></span>

<span class="crayon-language">R</span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
install.packages("ggiraph") if you don't have the package installed
===================================================================

library(ggiraph)
</textarea>

<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
1

2

</td>
<td class="crayon-code">
<span class="crayon-c">\# install.packages("ggiraph") if you don't have
the package installed</span>

<span class="crayon-r">library</span><span
class="crayon-sy">(</span><span class="crayon-v">ggiraph</span><span
class="crayon-sy">)</span>

</td>
</tr>
</table>

<p>
We can use a dataset, as in the <span id="crayon-5a5818d56e7c2833095494"
class="crayon-syntax crayon-syntax-inline crayon-theme-classic crayon-theme-classic-inline crayon-font-monaco"
style="font-size: 12px !important; line-height: 15px !important;font-size: 12px !important;"><span
class="crayon-pre crayon-code"
style="font-size: 12px !important; line-height: 15px !important;font-size: 12px !important; -moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4;"><span
class="crayon-v">ggiraph</span></span></span> package vignette, to make
our graph. The <span id="crayon-5a5818d56e7c4301830709"
class="crayon-syntax crayon-syntax-inline crayon-theme-github crayon-theme-github-inline crayon-font-monaco"
style="font-size: 12px !important; line-height: 15px !important;font-size: 12px !important;"><span
class="crayon-pre crayon-code"
style="font-size: 12px !important; line-height: 15px !important;font-size: 12px !important; -moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4;"><span
class="crayon-v">dataset</span></span></span> is “USArrests” from the
datasets package, which comes with R. In this dataset, the names of the
US states are the row names of the dataframe, which is not ideal. We can
first create a new variable, <span id="crayon-5a5818d56e7c6100689054"
class="crayon-syntax crayon-syntax-inline crayon-theme-github crayon-theme-github-inline crayon-font-monaco"
style="font-size: 12px !important; line-height: 15px !important;font-size: 12px !important;"><span
class="crayon-pre crayon-code"
style="font-size: 12px !important; line-height: 15px !important;font-size: 12px !important; -moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4;"><span
class="crayon-v">State</span></span></span> , which is made of these row
names.
</p>
<span class="crayon-title"></span>

<span class="crayon-language">R</span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
crimes &lt;- data.frame(state = rownames(USArrests), USArrests)
row.names(crimes) &lt;- NULL head(crimes)
</textarea>

<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
1

2

3

</td>
<td class="crayon-code">
<span class="crayon-v">crimes</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-v">data</span><span
class="crayon-sy">.</span><span class="crayon-e">frame</span><span
class="crayon-sy">(</span><span class="crayon-v">state</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-e">rownames</span><span
class="crayon-sy">(</span><span class="crayon-v">USArrests</span><span
class="crayon-sy">)</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">USArrests</span><span
class="crayon-sy">)</span>

<span class="crayon-v">row</span><span class="crayon-sy">.</span><span
class="crayon-e">names</span><span class="crayon-sy">(</span><span
class="crayon-v">crimes</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">&lt;</span><span
class="crayon-o">-</span><span class="crayon-h"> </span><span
class="crayon-t">NULL</span>

<span class="crayon-e">head</span><span class="crayon-sy">(</span><span
class="crayon-v">crimes</span><span class="crayon-sy">)</span>

</td>
</tr>
</table>

<p>
 
</p>
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
state Murder Assault UrbanPop Rape
----------------------------------

1 Alabama 13.2 236 58 21.2
--------------------------

2 Alaska 10.0 263 48 44.5
-------------------------

3 Arizona 8.1 294 80 31.0
-------------------------

4 Arkansas 8.8 190 50 19.5
--------------------------

5 California 9.0 276 91 40.6
----------------------------

\#\# 6 Colorado 7.9 204 78 38.7
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
<span class="crayon-p">\#\#        state Murder Assault UrbanPop
Rape</span>

<span class="crayon-p">\#\# 1    Alabama   13.2     236       58
21.2</span>

<span class="crayon-p">\#\# 2     Alaska   10.0     263       48
44.5</span>

<span class="crayon-p">\#\# 3    Arizona    8.1     294       80
31.0</span>

<span class="crayon-p">\#\# 4   Arkansas    8.8     190       50
19.5</span>

<span class="crayon-p">\#\# 5 California    9.0     276       91
40.6</span>

<span class="crayon-p">\#\# 6   Colorado    7.9     204       78
38.7</span>

</td>
</tr>
</table>

<p>
We can use <span id="crayon-5a5818d56e7cb744352049"
class="crayon-syntax crayon-syntax-inline crayon-theme-github crayon-theme-github-inline crayon-font-monaco"
style="font-size: 12px !important; line-height: 15px !important;font-size: 12px !important;"><span
class="crayon-pre crayon-code"
style="font-size: 12px !important; line-height: 15px !important;font-size: 12px !important; -moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4;"><span
class="crayon-v">ggplot2</span></span></span> and <span
id="crayon-5a5818d56e7cd768783429"
class="crayon-syntax crayon-syntax-inline crayon-theme-github crayon-theme-github-inline crayon-font-monaco"
style="font-size: 12px !important; line-height: 15px !important;font-size: 12px !important;"><span
class="crayon-pre crayon-code"
style="font-size: 12px !important; line-height: 15px !important;font-size: 12px !important; -moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4;"><span
class="crayon-v">ggiraph</span></span></span> to build a plot of how
murder changes with urban population. It involves saving the plot as an
object and then sending to the call to <span
id="crayon-5a5818d56e7cf044983612"
class="crayon-syntax crayon-syntax-inline crayon-theme-github crayon-theme-github-inline crayon-font-monaco"
style="font-size: 12px !important; line-height: 15px !important;font-size: 12px !important;"><span
class="crayon-pre crayon-code"
style="font-size: 12px !important; line-height: 15px !important;font-size: 12px !important; -moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4;"><span
class="crayon-e">ggiraph</span><span class="crayon-sy">(</span><span
class="crayon-sy">)</span></span></span> . The <span
id="crayon-5a5818d56e7d0070857668"
class="crayon-syntax crayon-syntax-inline crayon-theme-github crayon-theme-github-inline crayon-font-monaco"
style="font-size: 12px !important; line-height: 15px !important;font-size: 12px !important;"><span
class="crayon-pre crayon-code"
style="font-size: 12px !important; line-height: 15px !important;font-size: 12px !important; -moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4;"><span
class="crayon-v">data\_id</span></span></span>  and tooltip arguments
control what we see when we hover over the data point.
</p>
<span class="crayon-title"></span>

<span class="crayon-language">R</span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
murder\_plot &lt;- ggplot(crimes, aes(x = UrbanPop, y = Murder)) +
geom\_point\_interactive(aes(data\_id = state, tooltip = state), size =
3) + scale\_colour\_gradient(low = "\#999999", high = "\#FF3333") +
theme\_minimal()

ggiraph(code = print(murder\_plot))
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
<span class="crayon-v">murder\_plot</span><span class="crayon-h">
</span><span class="crayon-o">&lt;</span><span
class="crayon-o">-</span><span class="crayon-h"> </span><span
class="crayon-e">ggplot</span><span class="crayon-sy">(</span><span
class="crayon-v">crimes</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-e">aes</span><span
class="crayon-sy">(</span><span class="crayon-v">x</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-v">UrbanPop</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">y</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">Murder</span><span class="crayon-sy">)</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">+</span><span class="crayon-h"> </span>

<span class="crayon-e">geom\_point\_interactive</span><span
class="crayon-sy">(</span><span class="crayon-e">aes</span><span
class="crayon-sy">(</span><span class="crayon-v">data\_id</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-v">state</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">tooltip</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">state</span><span class="crayon-sy">)</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">size</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-cn">3</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">+</span><span
class="crayon-h"> </span>

<span class="crayon-e">scale\_colour\_gradient</span><span
class="crayon-sy">(</span><span class="crayon-v">low</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-s">"\#999999"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">high</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"\#FF3333"</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">+</span><span
class="crayon-h"> </span>

<span class="crayon-e">theme\_minimal</span><span
class="crayon-sy">(</span><span class="crayon-sy">)</span>

 

<span class="crayon-e">ggiraph</span><span
class="crayon-sy">(</span><span class="crayon-v">code</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-e">print</span><span
class="crayon-sy">(</span><span
class="crayon-v">murder\_plot</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span>

</td>
</tr>
</table>

<p>
</p>
<p style="text-align: center;">
<iframe style="border: 0px #ffffff none;" src="https://ibpad.com.br/lib/grafico1/grafico1.html" name="grafico1" width="600px" height="400px" frameborder="0" marginwidth="0px" marginheight="0px" scrolling="no" allowfullscreen="allowfullscreen">
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
<span class="crayon-title"></span>

<span class="crayon-language">R</span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
assault\_plot geom\_point\_interactive(aes(data\_id = state, tooltip =
state), size = 3) + scale\_colour\_gradient(low = "\#CAE1FF", high =
"\#4682B4") + theme\_minimal()

ggiraph(code = print(assault\_plot))
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
<span class="crayon-e">assault\_plot </span><span
class="crayon-e">geom\_point\_interactive</span><span
class="crayon-sy">(</span><span class="crayon-e">aes</span><span
class="crayon-sy">(</span><span class="crayon-v">data\_id</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-v">state</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">tooltip</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">state</span><span class="crayon-sy">)</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">size</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-cn">3</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">+</span>

<span class="crayon-e">scale\_colour\_gradient</span><span
class="crayon-sy">(</span><span class="crayon-v">low</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-s">"\#CAE1FF"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">high</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"\#4682B4"</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">+</span>

<span class="crayon-e">theme\_minimal</span><span
class="crayon-sy">(</span><span class="crayon-sy">)</span>

 

<span class="crayon-e">ggiraph</span><span
class="crayon-sy">(</span><span class="crayon-v">code</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-e">print</span><span
class="crayon-sy">(</span><span
class="crayon-v">assault\_plot</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span>

</td>
</tr>
</table>

<p>
</p>
<p style="text-align: center;">
<iframe style="border: 0px #ffffff none;" src="https://ibpad.com.br/lib/grafico1/grafico2.html" name="grafico1" width="600px" height="400px" frameborder="0" marginwidth="0px" marginheight="0px" scrolling="no" allowfullscreen="allowfullscreen">
</iframe>
</p>
<p>
There are of course other interactive graphics packages, such as
<a href="http://rpubs.com/bhaskarvk/tilegramsR" target="_blank">tilegramsR</a>
or ggviz, however, <span id="crayon-5a5818d56e7d7123003540"
class="crayon-syntax crayon-syntax-inline crayon-theme-github crayon-theme-github-inline crayon-font-monaco"
style="font-size: 12px !important; line-height: 15px !important;font-size: 12px !important;"><span
class="crayon-pre crayon-code"
style="font-size: 12px !important; line-height: 15px !important;font-size: 12px !important; -moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4;"><span
class="crayon-v">ggiraph</span></span></span> is definitely one of the
easiest to use.
</p>

