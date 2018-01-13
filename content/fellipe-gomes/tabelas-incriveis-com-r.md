+++
title = "Tabelas incriveis com R"
date = "2018-01-12"
categories = ["fellipe-gomes"]
original_url = "https://gomesfellipe.github.io/post/2018-01-12-tabelas-incriveis-com-r/tabelas-incriveis-com-r/"
+++

<p id="main">
<article class="post">
<header>
<p>
Alguns pacotes que serão bem úteis na hora de criar tabelas lindas e
informativas!
</p>

</header>
<a href="https://gomesfellipe.github.io/post/2018-01-12-tabelas-incriveis-com-r/tabelas-incriveis-com-r/" class="image featured">
<img src="https://gomesfellipe.github.io/img/2018/01/tabelas-incriveis2.jpg" alt="">
</a>
<p>
O trabalho do estatístico vai muito além do planejamento, sumarização e
interpretação de observações para fornecer a melhor informação possível
a partir do dados disponíveis. O processo de analises deve ser tratado
na etapa final de todo projeto ou pesquisa que envolva apresentação dos
resultados, não é atoa que já até existem áreas dentro da ciência de
dados focada nesta tarefa, recebendo o título de “Data Artist”.
</p>
<p>
Além da variedade de pacotes que auxiliam na apresentação das figuras
geradas nas análises(como já foi visto em alguns posts como estes
<a href="https://gomesfellipe.github.io/post/2017-12-24-diagnostico-de-modelo/diagnostico-de-modelos/">para
visualizar a qualidade do ajuste de modelos</a> ou
<a href="https://gomesfellipe.github.io/post/2017-12-18-bayesiana-jags-mcmcplot/bayesiana-jags-mcmcplot/">este
para valiar ajuste de modelos pela abordagem bayesiana</a>), também
contamos com alguns pacotes que possibilitam a apresentação de tabelas
de maneira bastante satisfatória (de forma elegante e até interativa)
</p>
<p>
Seja escrevendo relatórios em <span
class="math inline">$\\LaTeX$</span>, Rmarkdown ou até mesmo um
aplicativo shiny , este posta tem a finalidade de trazer algumas
alternativas para a boa apresentação dos resultados.
</p>
<p>
Como de costume vou apresentar alguns pacotes que serão bem úteis na
hora de criar aquelas tabelas lindas e informativas que qualquer cliente
adora.
</p>

<p>
O pacote <code>DT</code> é uma excelente opção quando se trata de
incluir tabelas de dados em relatórios Rmarkdown, o pacote esta
hospedado neste <a href="https://rstudio.github.io/DT/">link no
github</a>, veja a seguir um simples exemplo de uso:
</p>
<pre class="r"><code># install.packages(&quot;DT&quot;) #caso ainda nao tenha o pacote instalado
DT::datatable(iris[1:20, c(5, 1:4)], rownames = FALSE)</code></pre>
<img src="https://gomesfellipe.github.io/img/2018-01-12-tabelas-incriveis-com-r/img1.png">

<p>
Com este
<a href="https://cran.r-project.org/web/packages/DT/vignettes/DT.html">link
do manual no CRAN</a> é possível entender melhor o funcionamento do
pacote e conferir mais exemplos de uso.
</p>

<p>
Este pacote é repleto de funcionalidades interessantes para a formatação
dos resultados dispostos em tabelas, também está
<a href="https://github.com/renkun-ken/formattable">hospedado no
github</a>, podendo ser instalado pelo CRAN ou com os comandos:
</p>
<pre class="r"><code># Instalando pelo github
# library(devtools)
# devtools::install_github(&quot;renkun-ken/formattable&quot;)
suppressMessages(library(formattable))</code></pre>
<p>
Com o pacote carregado vamos conferir algumas das funcionalidades
básicas:
</p>
<pre class="r"><code>#Exemplo de formata&#xE7;&#xE3;o para resultados de porcentagem:
percent(c(0.1, 0.02, 0.03, 0.12))</code></pre>
<pre><code>## [1] 10.00% 2.00% 3.00% 12.00%</code></pre>
<pre class="r"><code>#Exemplo de formata&#xE7;&#xE3;o para resultados de na casa do milhar:
accounting(c(1000, 500, 200, -150, 0, 1200))</code></pre>
<pre><code>## [1] 1,000.00 500.00 200.00 (150.00) 0.00 1,200.00</code></pre>
<p>
Vamos criar um <code>data.frame</code> para ilustrar algumas das
funcionalidades do pacote:
</p>
<pre class="r"><code>#criando um data.frame
df &lt;- data.frame( id = 1:10, Nomes = c(&quot;Sofia&quot;, &quot;Kiara&quot;, &quot;Dunki&quot;, &quot;Edgar&quot;, &quot;Aline&quot;,&quot;Gertrudes&quot;, &quot;Genovena&quot;, &quot;Champanhe&quot;, &quot;P&#xE9;rola&quot;, &quot;Penelope&quot;), Kilos = accounting(c(20000, 30000, 50000, 70000, 47000,80000,45000,35000,20000,25000), format = &quot;d&quot;), Crescimento = percent(c(0.1, 0.2, 0.5, 0.95, 0.97,0.45,0.62,0.57,0.37, 0.3), format = &quot;d&quot;), Suficiente = formattable(c(T, F, T, F, T,F,F,T,T,F), &quot;Sim&quot;, &quot;N&#xE3;o&quot;))</code></pre>
<p>
Com esses resultados, vejamos um exemplo de tabela que pode ser criada
para apresentar esses resultados com o pacote:
</p>
<pre class="r"><code>formattable(df, list( id = color_tile(&quot;white&quot;, &quot;orange&quot;), Suficiente = formatter(&quot;span&quot;, style = x ~ ifelse(x == T, style(color = &quot;green&quot;, font.weight = &quot;bold&quot;), NA)), area(col = c(Kilos)) ~ normalize_bar(&quot;lightgrey&quot;, 0.2), Crescimento = formatter(&quot;span&quot;, style = x ~ style(color = ifelse(rank(-x) &lt;= 3, &quot;green&quot;, &quot;gray&quot;)), x ~ sprintf(&quot;%.2f (rank: %02g)&quot;, x, rank(-x)))
))</code></pre>
<table class="table table-condensed">
<thead>
<tr>
<th>
id
</th>
<th>
Nomes
</th>
<th>
Kilos
</th>
<th>
Crescimento
</th>
<th>
Suficiente
</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<span>1</span>
</td>
<td>
Sofia
</td>
<td>
<span>20,000</span>
</td>
<td>
<span>0.10 (rank: 10)</span>
</td>
<td>
<span>Sim</span>
</td>
</tr>
<tr>
<td>
<span>2</span>
</td>
<td>
Kiara
</td>
<td>
<span>30,000</span>
</td>
<td>
<span>0.20 (rank: 09)</span>
</td>
<td>
<span>Não</span>
</td>
</tr>
<tr>
<td>
<span>3</span>
</td>
<td>
Dunki
</td>
<td>
<span>50,000</span>
</td>
<td>
<span>0.50 (rank: 05)</span>
</td>
<td>
<span>Sim</span>
</td>
</tr>
<tr>
<td>
<span>4</span>
</td>
<td>
Edgar
</td>
<td>
<span>70,000</span>
</td>
<td>
<span>0.95 (rank: 02)</span>
</td>
<td>
<span>Não</span>
</td>
</tr>
<tr>
<td>
<span>5</span>
</td>
<td>
Aline
</td>
<td>
<span>47,000</span>
</td>
<td>
<span>0.97 (rank: 01)</span>
</td>
<td>
<span>Sim</span>
</td>
</tr>
<tr>
<td>
<span>6</span>
</td>
<td>
Gertrudes
</td>
<td>
<span>80,000</span>
</td>
<td>
<span>0.45 (rank: 06)</span>
</td>
<td>
<span>Não</span>
</td>
</tr>
<tr>
<td>
<span>7</span>
</td>
<td>
Genovena
</td>
<td>
<span>45,000</span>
</td>
<td>
<span>0.62 (rank: 03)</span>
</td>
<td>
<span>Não</span>
</td>
</tr>
<tr>
<td>
<span>8</span>
</td>
<td>
Champanhe
</td>
<td>
<span>35,000</span>
</td>
<td>
<span>0.57 (rank: 04)</span>
</td>
<td>
<span>Sim</span>
</td>
</tr>
<tr>
<td>
<span>9</span>
</td>
<td>
Pérola
</td>
<td>
<span>20,000</span>
</td>
<td>
<span>0.37 (rank: 07)</span>
</td>
<td>
<span>Sim</span>
</td>
</tr>
<tr>
<td>
<span>10</span>
</td>
<td>
Penelope
</td>
<td>
<span>25,000</span>
</td>
<td>
<span>0.30 (rank: 08)</span>
</td>
<td>
<span>Não</span>
</td>
</tr>
</tbody>
</table>
<p>
Para entender melhor o funcionamento do pacote e conferir mais exemplo
de uso confira o
<a href="https://cran.r-project.org/web/packages/formattable/vignettes/introduction.html">manual
de introdução ao pacote</a> e
<a href="https://cran.r-project.org/web/packages/formattable/vignettes/formattable-data-frame.html">manual
do pacote</a>, ambos disponíveis no CRAN.
</p>

<p>
O sparklike é um pacote ótimo para enriquecer as aprestações de forma
que possibilita incluir “mini gráficos” como boxplots, gráfico de linhas
ou barras diretamente nas tabelas, como se fosse uma coluna do
<code>data.frame</code>!
</p>
<p>
Seu funcionamento é bem simples e poderoso, apresento aqui alguns
exemplo de uso, caso queira conferir mais detalhes, pode conferir o
<a href="https://cran.r-project.org/web/packages/sparkline/vignettes/intro_sparkline.html">manual
do pacote no CRAN</a> ou
<a href="https://omnipotent.net/jquery.sparkline/#s-about">esta
página</a>.
</p>
<pre class="r"><code># library(devtools)
# install_github(&apos;htmlwidgets/sparkline&apos;) #Carregando o pacote:
library(htmlwidgets)
library(sparkline) #Exemplos de uso:
x = rnorm(20)
sparkline(x)
sparkline(x, type = &apos;bar&apos;)
sparkline(x, type = &apos;box&apos;)</code></pre>
<img src="https://gomesfellipe.github.io/img/2018-01-12-tabelas-incriveis-com-r/img2.png">

<p>
Exemplo de tabela para rmarkdown, a partir dessa sequência de códigos
markdown e R:
</p>
<pre class="r"><code>#Seja:
set.seed(1234)
x = rnorm(10)
y = rnorm(10) #Ao digitar isso: | Var. | Sparkline | Boxplot | Bar |-------|-------------------|-------------------------------|------------------------------
| x | `r sparkline(x)` | `r sparkline(x, type =&apos;box&apos;)` |`r sparkline(x, type = &apos;bar&apos;)`
| y | `r sparkline(y)` | `r sparkline(y, type =&apos;box&apos;)` |`r sparkline(y, type = &apos;bar&apos;)`</code></pre>
<p>
Exibe isso:
</p>
<img src="https://gomesfellipe.github.io/img/2018-01-12-tabelas-incriveis-com-r/img4.png">

<p>
Mais um pacote repleto de funcionalidades que permitem a implementação
de tabelas elegantes para a apresentação de projetos e pesquisas. Por se
tratar de um
<a href="https://gomesfellipe.github.io/post/2018-01-12-tabelas-incriveis-com-r/tabelas-incriveis-com-r/www.htmlwidgets.org">htmlwidgets</a>,
este pacote em especial é uma boa opção quando deseja-se apresentar
tabela sem documentos no formato html ou com aplicativos shiny por
exemplo.
</p>
<p>
Primeiramente apresentarei aqui primeiramente um exemplo com tabela de
correlações utilizando formatação condicional:
</p>
<pre class="r"><code>#Carregando o pacote:
suppressMessages(library(rhandsontable)) #Tabela para correla&#xE7;&#xF5;es
rhandsontable(cor(iris[,-5]), readOnly = TRUE, width = 750, height = 300) %&gt;% hot_cols(renderer = &quot; function (instance, td, row, col, prop, value, cellProperties) { Handsontable.renderers.TextRenderer.apply(this, arguments); if (row == col) { td.style.background = &apos;lightgrey&apos;; } else if (col &gt; row) { td.style.background = &apos;grey&apos;; td.style.color = &apos;grey&apos;; } else if (value &lt; -0.75) { td.style.background = &apos;pink&apos;; } else if (value &gt; 0.75) { td.style.background = &apos;lightgreen&apos;; } }&quot;)</code></pre>
<img src="https://gomesfellipe.github.io/img/2018-01-12-tabelas-incriveis-com-r/img4.png">

<p>
Como este pacote possui muitas funcionalidades, apresentarei mais três
exemplos baseados nas instruções do pacote e caso queira entender melhor
o funcionamento e obter mais exemplos, consultar o
<a href="https://cran.r-project.org/web/packages/rhandsontable/vignettes/intro_rhandsontable.html">manual
no CRAN</a>
</p>
<pre class="r"><code>#Tabela com mini gr&#xE1;ficos
#criando um data.frame
df &lt;- data.frame( id = 1:10, Nomes = c(&quot;Sofia&quot;, &quot;Kiara&quot;, &quot;Dunki&quot;, &quot;Edgar&quot;, &quot;Aline&quot;,&quot;Gertrudes&quot;, &quot;Genovena&quot;, &quot;Champanhe&quot;, &quot;P&#xE9;rola&quot;, &quot;Penelope&quot;), Kilos = accounting(c(20000, 30000, 50000, 70000, 47000,80000,45000,35000,20000,25000), format = &quot;d&quot;), Crescimento = percent(c(0.1, 0.2, 0.5, 0.95, 0.97,0.45,0.62,0.57,0.37, 0.3), format = &quot;d&quot;), Suficiente = c(T, F, T, F, T,F,F,T,T,F)) #E os gr&#xE1;ficos de barra:
df$chart = c(sapply(1:5, function(x) jsonlite::toJSON(list(values=rnorm(10,10,10), options = list(type = &quot;bar&quot;)))), sapply(1:5, function(x) jsonlite::toJSON(list(values=rnorm(10,10,10), options = list(type = &quot;line&quot;)))))
rhandsontable(df, rowHeaders = NULL, width = 550, height = 300) %&gt;% hot_col(&quot;chart&quot;, renderer = htmlwidgets::JS(&quot;renderSparkline&quot;))</code></pre>
<img src="https://gomesfellipe.github.io/img/2018-01-12-tabelas-incriveis-com-r/img5.png">

<p>
Também podemos incluir comentários em células específicas da tabela
utilizando este pacote, veja:
</p>
<p>
(Para ver os comentários basta passar o mouse sobre a célula com a
marcação vermelha na borda)
</p>
<pre class="r"><code>#Incluindo comentarios:
comments = matrix(ncol = ncol(df), nrow = nrow(df))
comments[1, 1] = &quot;Exemplo de coment&#xE1;rio&quot;
comments[2, 2] = &quot;Outro exemplo de comentario&quot; rhandsontable(df, comments = comments, width = 550, height = 300)%&gt;% hot_col(&quot;chart&quot;, renderer = htmlwidgets::JS(&quot;renderSparkline&quot;))</code></pre>
<img src="https://gomesfellipe.github.io/img/2018-01-12-tabelas-incriveis-com-r/img6.png">

<p>
Caso a tabela dos dados seja muito grande, também podemos utilizar o
pacote para gerar a tabela com a barra de rolar
</p>
<pre class="r"><code>#Tabela com barra de rolar para grande base de dados
rhandsontable(mtcars, rowHeaderWidth = 200, width = 700, height = 550)</code></pre>

<p>
Com essas lindas tabelas seus relatórios serão irresistíveis, até quem
não entende de estatística vai passar a gostar depois de ver tanta
beleza com números! Espero que tenha gostado do conteúdo, caso queira
acrescentar ou reportar algo basta entrar em contato.
</p>

<footer>
<ul class="stats">
<li>
Categories
</li>
<li>
<a href="https://gomesfellipe.github.io/categories/ggplot">ggplot</a>
</li>
<li>
<a href="https://gomesfellipe.github.io/categories/utilidades">utilidades</a>
</li>
<li>
<a href="https://gomesfellipe.github.io/categories/package">package</a>
</li>
<li>
<a href="https://gomesfellipe.github.io/categories/r">R</a>
</li>
<li>
<a href="https://gomesfellipe.github.io/categories/pr%C3%A1tica">Prática</a>
</li>
<li>
<a href="https://gomesfellipe.github.io/categories/multivariada">multivariada</a>
</li>
<li>
<a href="https://gomesfellipe.github.io/categories/tabelas">tabelas</a>
</li>
</ul>
</footer>
</article>
<article class="post">
<a href="https://disqus.com/" class="dsq-brlink">comments powered by
</a>
</article>
</p>

