+++
title = "Matrizes Esparsas no R"
date = "2017-11-16 11:25:00"
categories = ["curso-r"]
original_url = "http://curso-r.com/blog/2017/11/16/2017-11-16-matrizes-esparsas/"
+++

<p>
Matrizes esparsas são matrizes em que a maior parte dos elementos é
igual a zero. Matrizes dessa forma surgem em diversos problemas
relacionados a Machine Learning e análise de dados.
</p>
<p>
Por exemplo, é comum em <em>text mining</em> representar os documentos
usando o chamado
<a href="https://en.wikipedia.org/wiki/Bag-of-words_model"><em>Bag of
Words</em></a>. <em>Bag of Words</em> nada mais é do que listar as
palavras que aparecem em todos os documentos e em seguida criar uma
matriz em que cada linha é um documento e cada coluna é uma palavra que
foi listada anteriormente. Cada elemento <span
class="math inline">(*i*, *j*)</span> desssa matriz é 1 se a palavra
<span class="math inline">*j*</span> aparace no documento <span
class="math inline">*i*</span> e 0 caso contrário. Naturalmente, o
número de palavras que podem aparecer é muito maior do que o número de
palavras que de fato aparecem em um documento, por isso a maioria dos
elementos dessa matriz será 0.
</p>
<p>
Matrizes esparsas também aparecem muito em problemas de recomendação.
Nesse tipo de aplciação representamos as transações em uma matriz em que
cada linha é um cliente e cada coluna um produto que ele poderia ter
comprado. Para recomendar filmes no Netflix, por exemplo, cada linha
seria um cliente e cada coluna um filme que está no catálogo do Netflix.
Em seguida marcaríamos cada elemento <span
class="math inline">(*i*, *j*)</span> dessa matriz com 1 se o cliente
<span class="math inline">*i*</span> assistiu o filme <span
class="math inline">*j*</span> e 0 caso contrário. Como o catálogo de
filmes é muito grande, a mairoia dos elementos dessa matriz será 0.
</p>
<p>
Essa
<a href="https://www.quora.com/What-is-the-significance-of-sparse-matrices-What-are-some-common-applications-in-computer-science">pergunta
do Quora</a> tem mais algumas aplicações importantes de matrizes
esparsas.
</p>
<p>
Note que nos problemas que eu mencionei, encontramos dimensões muito
altas. O número de palavras distintas em um conjunto de documentos pode
facilmente passar de 20.000. O número de filmes no catálogo do netflix
pode passar de 100.000. Agora vamos definir uma matriz como esta no R da
forma usual. Vou preenchê-la aleatoriamente com 0’s e 1’s, sendo 1’s
aproximadamente 1%. Considere que essa matriz seria utilizada em um
problema de classificação de textos com 1 milhão de documentos com
apenas 500 palavras distintas. Veja que aqui estou reduzindo bastante o
número de palavras possíveis, na prática esse número é muito maior.
</p>
<pre class="r"><code>nrow &lt;- 1e6
ncol &lt;- 500
x &lt;- matrix(sample(c(0,1), size = nrow*ncol, replace = TRUE,prob = c(0.99, 0.1)), nrow = nrow, ncol = ncol)</code></pre>
<p>
Se você tiver um computador com bastante RAM, talvez consiga rodar isso,
mas provavelmente você terá um erro do tipo <code>Error: cannot allocate
vector of size 74.5 Gb</code>.
</p>
<p>
De fato, essa matriz ocupa bastante memória:
</p>
<pre class="r"><code>pryr::object_size(x)
#&gt; 4 GB</code></pre>
<p>
Será que existe uma forma mais eficiente de representar essa matriz na
memória do computador? A resposta é sim! E no R vamos usar o pacote
<code>Matrix</code>.
</p>
<p>
Existem diversas formas de transformar a matriz <code>x</code> em uma
matriz esparsa, a forma mais simples é:
</p>
<pre class="r"><code>library(Matrix)
x_s &lt;- Matrix(x)
pryr::object_size(x_s)
#&gt; 550 MB</code></pre>
<p>
Ou seja, a matriz esparsa ocupa quase 1/8 menos memória do que a matriz
densa. A maioria dos métodos para matrizes no R estão também
implementados para matrizes esparsas. Isso quer dizer que você pode
fazer <code>x*y</code>, <code>x+y</code>, <code>x/y</code>,
<code>x%*%y</code>, <code>x\[1,1\]</code>, etc. como se fossem matrizes
normais. Na prática o pacote <code>Matrix</code> representa as matrizes
esparsas internamente de uma forma muito mais inteligente, sem gastar
memória com os valores nulos.
</p>
<p>
Uma outra grande vantagem é que muitos pacotes possuem implementações
mais eficientes (tanto em tempo de execução quanto em memória utilizada)
para matrizes esparsas, por exemplo o
<a href="https://cran.r-project.org/web/packages/glmnet/"><code>glmnet</code></a>
muito usado para fazer regressão do tipo LASSO. O
<a href="https://github.com/mhahsler/recommenderlab"><code>recommenderlab</code></a>
que implementa alguns algoritmos de recomendação também é inteiramente
baseado em matrizes esparsas. O pacote
<a href="http://text2vec.org/index.html"><code>text2vec</code></a> que
implementa algoritmos como GloVe também usa muito esse tipo de matrizes.
</p>
<p>
Vale lembrar que na maioria das vezes você possui uma base
<em>transacional</em> que precisa ser representada como uma matriz. Algo
mais ou menos assim:
</p>
<pre class="r"><code>bd &lt;- data.frame( cliente = c(1,1,1,2,2,3,3,4,5,6,7,7,8,8,8,8,9,9,9,9), itens = sample(1:50, 20) )</code></pre>
<table>
<thead>
</thead>
<tbody>
<tr class="odd">
<td>
1
</td>
<td>
15
</td>
</tr>
<tr class="even">
<td>
1
</td>
<td>
50
</td>
</tr>
<tr class="odd">
<td>
1
</td>
<td>
5
</td>
</tr>
<tr class="even">
<td>
2
</td>
<td>
8
</td>
</tr>
<tr class="odd">
<td>
2
</td>
<td>
30
</td>
</tr>
<tr class="even">
<td>
3
</td>
<td>
46
</td>
</tr>
<tr class="odd">
<td>
3
</td>
<td>
42
</td>
</tr>
<tr class="even">
<td>
4
</td>
<td>
27
</td>
</tr>
<tr class="odd">
<td>
5
</td>
<td>
9
</td>
</tr>
<tr class="even">
<td>
6
</td>
<td>
31
</td>
</tr>
<tr class="odd">
<td>
7
</td>
<td>
33
</td>
</tr>
<tr class="even">
<td>
7
</td>
<td>
20
</td>
</tr>
<tr class="odd">
<td>
8
</td>
<td>
28
</td>
</tr>
<tr class="even">
<td>
8
</td>
<td>
35
</td>
</tr>
<tr class="odd">
<td>
8
</td>
<td>
48
</td>
</tr>
<tr class="even">
<td>
8
</td>
<td>
7
</td>
</tr>
<tr class="odd">
<td>
9
</td>
<td>
34
</td>
</tr>
<tr class="even">
<td>
9
</td>
<td>
17
</td>
</tr>
<tr class="odd">
<td>
9
</td>
<td>
22
</td>
</tr>
<tr class="even">
<td>
9
</td>
<td>
41
</td>
</tr>
</tbody>
</table>
<p>
Nesse caso, faz mais sentido criar a matriz esparsa usando a função
<code>sparseMatrix</code>. Assim, você só especifica as coordenadas da
matriz que têm algum 1.
</p>
<pre class="r"><code>library(Matrix)
sparseMatrix(bd$cliente, bd$itens)
## 9 x 50 sparse Matrix of class &quot;ngCMatrix&quot;
## ## [1,] . . . . | . . . . . . . . . | . . . . . . . . . . . . . . . . . . .
## [2,] . . . . . . . | . . . . . . . . . . . . . . . . . . . . . | . . . .
## [3,] . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
## [4,] . . . . . . . . . . . . . . . . . . . . . . . . . . | . . . . . . .
## [5,] . . . . . . . . | . . . . . . . . . . . . . . . . . . . . . . . . .
## [6,] . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . | . . .
## [7,] . . . . . . . . . . . . . . . . . . . | . . . . . . . . . . . . | .
## [8,] . . . . . . | . . . . . . . . . . . . . . . . . . . . | . . . . . .
## [9,] . . . . . . . . . . . . . . . . | . . . . | . . . . . . . . . . . |
## ## [1,] . . . . . . . . . . . . . . . |
## [2,] . . . . . . . . . . . . . . . .
## [3,] . . . . . . . | . . . | . . . .
## [4,] . . . . . . . . . . . . . . . .
## [5,] . . . . . . . . . . . . . . . .
## [6,] . . . . . . . . . . . . . . . .
## [7,] . . . . . . . . . . . . . . . .
## [8,] | . . . . . . . . . . . . | . .
## [9,] . . . . . . | . . . . . . . . .</code></pre>
<p>
Outra função importante é a <code>sparse.model.matrix</code>. Ela é
equivalente à função <code>model.matrix</code> mas cria uma matriz de
modelo esparsa o que pode ser útil quando você tem um fator que possui
muitos níveis no seu modelo. A vignette
<a href="https://cran.r-project.org/web/packages/Matrix/vignettes/sparseModels.pdf"><em>Sparse
Model Matrices</em></a> fala sobre isso.
</p>
<p>
Também é possível programar em Rcpp usando matrizes esparsas usando o
RcppArmadillo, veja
<a href="http://gallery.rcpp.org/articles/armadillo-sparse-matrix/">esse
exemplo</a> para mais detalhes.
</p>
<p>
Para saber mais leia as vignettes do pacote
<a href="https://cran.r-project.org/web/packages/Matrix/index.html">Matrix</a>.
Em especial, vale a pena ler as seguintes
<a href="https://cran.r-project.org/web/packages/Matrix/vignettes/Intro2Matrix.pdf">2nd
Introduction to the Matrix Package</a>.
</p>
<p>
PS: a inspiração para esse texto foi
<a href="http://www.johnmyleswhite.com/notebook/2011/10/31/using-sparse-matrices-in-r/">esse
post</a> de 2011 do John Myles White
</p>

