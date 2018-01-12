+++
title = "INTRODUÇÃO AO R - Aula 1"
date = "2016-09-26 03:00:00"
categories = ["r-python-e-redes"]
original_url = "http://neylsoncrepalde.github.io/2016-09-26-introducao-ao-r-aula-1/"
+++

<article class="blog-post">
<p>
Olá! Esta é a primeira aula do curso <strong>Introdução ao R</strong> do
MQuinho 2016. Este material foi amplamente inspirado no curso homônimo
do <a href="https://www.facebook.com/rogerio.barbosa.7528">Rogério
Barbosa</a> e no curso <em>Introduction to Statistical Learning with
Applications in R</em> de Trevor Hastie e Robert Tibshirani (livro
disponibilizado pelos autores
<a href="http://www-bcf.usc.edu/~gareth/ISL/">aqui</a>). Vamos começar!
</p>
<h2 id="comandos-básicos">
Comandos básicos
</h2>
<p>
Podemos usar o R como calculadora:
</p>
<p>
Resto da divisão
</p>
<h3 id="raiz-e-potência">
Raiz e potência
</h3>
<p>
A maioria dos comandos no R tem esse formato:
<code class="highlighter-rouge">função()</code>. Para tirar a raiz
usamos o comando <code class="highlighter-rouge">sqrt()</code>
</p>
<p>
Raiz cúbica
</p>
<p>
Exponencial e log natural(base e)
</p>
<h2 id="linguagem-de-programação-orientada-a-objetos">
Linguagem de programação orientada a objetos
</h2>
<p>
O <strong>R</strong> é uma linguagem de programação orientada a objetos.
Em linguagem muito coloquial, isso quer dizer que podemos atribuir
números, textos e resultados a um objeto criado. Vamos construir um
objeto chamado <code class="highlighter-rouge">x</code> com o valor 5 e
um objeto <code class="highlighter-rouge">y</code> com o valor 7:
</p>
<p>
Podemos fazer também operações com objetos
</p>
<p>
O comando <code class="highlighter-rouge">c()</code> significa
<em>concatenar</em>, ou seja, juntar os valores. Vamos construir um
objeto <code class="highlighter-rouge">x</code> e atribuir a ele um
vetor de números:
</p>
<p>
Se eu atribuir outro vetor ao objeto
<code class="highlighter-rouge">x</code>, ele será sobrescrito.
</p>
<p>
Podemos verificar o tamanho do vetor com o comando
<code class="highlighter-rouge">length()</code>:
</p>
<pre class="highlight"><code>## [1] 1.0000000 1.5000000 0.6666667
</code></pre>

<p>
Outros comandos úteis:
</p>
<pre class="highlight"><code><span class="n">ls</span><span class="p">()</span><span class="w"> </span><span class="c1">#este comando lista os objetos no ambiente
</span></code></pre>

<pre class="highlight"><code><span class="n">rm</span><span class="p">(</span><span class="n">x</span><span class="p">,</span><span class="n">y</span><span class="p">)</span><span class="w"> </span><span class="c1">#este comando remove objetos
</span><span class="n">ls</span><span class="p">()</span><span class="w">
</span></code></pre>

<pre class="highlight"><code><span class="n">rm</span><span class="p">(</span><span class="n">list</span><span class="o">=</span><span class="n">ls</span><span class="p">())</span><span class="w"> </span><span class="c1"># para limpar tudo no ambiente
</span><span class="n">ls</span><span class="p">()</span><span class="w">
</span></code></pre>

<h2 id="classes-de-vetores">
Classes de vetores
</h2>
<p>
Os vetores podem ser numéricos, inteiros, lógicos, ou
<em>character</em>, isto é, vetores de texto.
</p>
<p>
Para descobrir a classe de um vetor, usamos o comando
<code class="highlighter-rouge">class()</code>
</p>
<pre class="highlight"><code><span class="n">numeros</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="m">13</span><span class="p">,</span><span class="m">15</span><span class="p">,</span><span class="m">24</span><span class="p">,</span><span class="m">17</span><span class="p">,</span><span class="m">12</span><span class="p">)</span><span class="w">
</span><span class="n">nomes</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="s2">&quot;Neylson&quot;</span><span class="p">,</span><span class="s2">&quot;&#xCD;talo&quot;</span><span class="p">,</span><span class="s2">&quot;Silvio&quot;</span><span class="p">,</span><span class="s2">&quot;Rog&#xE9;rio&quot;</span><span class="p">,</span><span class="s2">&quot;Marcelo&quot;</span><span class="p">)</span><span class="w"> </span><span class="nf">class</span><span class="p">(</span><span class="n">numeros</span><span class="p">)</span><span class="w"> </span><span class="c1"># vetor num&#xE9;rico
</span></code></pre>

<pre class="highlight"><code><span class="nf">class</span><span class="p">(</span><span class="n">nomes</span><span class="p">)</span><span class="w"> </span><span class="c1"># vetor de texto ou string
</span></code></pre>

<pre class="highlight"><code><span class="n">inteiros</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="m">5L</span><span class="p">,</span><span class="w"> </span><span class="m">7L</span><span class="p">,</span><span class="w"> </span><span class="m">45L</span><span class="p">,</span><span class="w"> </span><span class="m">9L</span><span class="p">,</span><span class="w"> </span><span class="m">2L</span><span class="p">)</span><span class="w">
</span><span class="nf">class</span><span class="p">(</span><span class="n">inteiros</span><span class="p">)</span><span class="w"> </span><span class="c1"># vetor de n&#xFA;meros inteiros
</span></code></pre>

<pre class="highlight"><code><span class="c1">#podemos converter um vetor num&#xE9;rico para um vetor de inteiros
</span><span class="n">peso</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="m">60.45</span><span class="p">,</span><span class="w"> </span><span class="m">78.9</span><span class="p">,</span><span class="w"> </span><span class="m">45.7</span><span class="p">,</span><span class="w"> </span><span class="m">98.654</span><span class="p">,</span><span class="w"> </span><span class="m">69.324</span><span class="p">)</span><span class="w">
</span><span class="nf">class</span><span class="p">(</span><span class="n">peso</span><span class="p">)</span><span class="w">
</span></code></pre>

<p>
Uma função bastante útil para vetores numéricos é a
<code class="highlighter-rouge">paste()</code>. Esta função junta os
diversos componentes de um vetor separando-os com um espaço. Se quero
que seja separada por outro elemento qualquer, uso a opção
<code class="highlighter-rouge">sep</code>. A função
<code class="highlighter-rouge">paste0()</code> não usa separador.
</p>
<pre class="highlight"><code><span class="n">paste</span><span class="p">(</span><span class="s2">&quot;Eu&quot;</span><span class="p">,</span><span class="s2">&quot;gosto&quot;</span><span class="p">,</span><span class="s2">&quot;de&quot;</span><span class="p">,</span><span class="s2">&quot;p&#xE3;o&quot;</span><span class="p">,</span><span class="s2">&quot;de&quot;</span><span class="p">,</span><span class="s2">&quot;queijo!&quot;</span><span class="p">)</span><span class="w">
</span></code></pre>

<pre class="highlight"><code>## [1] &quot;Eu gosto de p&#xE3;o de queijo!&quot;
</code></pre>

<pre class="highlight"><code><span class="n">paste</span><span class="p">(</span><span class="s2">&quot;Eu&quot;</span><span class="p">,</span><span class="s2">&quot;gosto&quot;</span><span class="p">,</span><span class="s2">&quot;de&quot;</span><span class="p">,</span><span class="s2">&quot;p&#xE3;o&quot;</span><span class="p">,</span><span class="s2">&quot;de&quot;</span><span class="p">,</span><span class="s2">&quot;queijo!&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">sep</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;|&quot;</span><span class="p">)</span><span class="w">
</span></code></pre>

<pre class="highlight"><code>## [1] &quot;Eu|gosto|de|p&#xE3;o|de|queijo!&quot;
</code></pre>

<pre class="highlight"><code><span class="n">paste0</span><span class="p">(</span><span class="s2">&quot;&#xCA;s&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;pens&quot;</span><span class="p">,</span><span class="s2">&quot;cu&quot;</span><span class="p">,</span><span class="s2">&quot;ons&quot;</span><span class="p">,</span><span class="s2">&quot;&#xE9;&quot;</span><span class="p">,</span><span class="s2">&quot;d&#xEA;s&quot;</span><span class="p">)</span><span class="w"> </span><span class="c1">#S&#xF3; os mineiros entender&#xE3;o!
</span></code></pre>

<h2 id="vetores-lógicos">
Vetores Lógicos
</h2>
<p>
Vetores lógicos assumem apenas dois valores:
<code class="highlighter-rouge">TRUE</code> e
<code class="highlighter-rouge">FALSE</code>. Eles são importantes para
testes no R.
</p>
<pre class="highlight"><code><span class="n">logicos</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="nb">T</span><span class="p">,</span><span class="nb">F</span><span class="p">,</span><span class="nb">F</span><span class="p">,</span><span class="nb">T</span><span class="p">,</span><span class="nb">T</span><span class="p">)</span><span class="w">
</span><span class="nf">class</span><span class="p">(</span><span class="n">logicos</span><span class="p">)</span><span class="w">
</span></code></pre>

<pre class="highlight"><code><span class="nf">is.numeric</span><span class="p">(</span><span class="n">logicos</span><span class="p">)</span><span class="w"> </span><span class="c1"># o vetor &quot;logicos&quot; &#xE9; numeric?
</span></code></pre>

<h3 id="sequências">
Sequências
</h3>
<p>
Sequências são bastante úteis em programação. Podemos criá-las de
algumas maneiras no R:
</p>
<pre class="highlight"><code>## [1] 1 2 3 4 5 6 7 8 9 10
</code></pre>

<pre class="highlight"><code>## [1] 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26
## [24] 27 28 29 30 31 32 33 34 35 36 37 38 39 40
</code></pre>

<pre class="highlight"><code>## [1] 2.5 3.5 4.5 5.5 6.5 7.5 8.5
</code></pre>

<pre class="highlight"><code>## [1] 7 6 5 4 3 2 1 0 -1 -2 -3 -4 -5 -6 -7
</code></pre>

<p>
A função <code class="highlighter-rouge">seq()</code> permite algumas
opções mais elaboradas:
</p>
<pre class="highlight"><code>## [1] 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30
</code></pre>

<pre class="highlight"><code><span class="n">seq</span><span class="p">(</span><span class="n">from</span><span class="o">=</span><span class="m">15</span><span class="p">,</span><span class="w"> </span><span class="n">to</span><span class="o">=</span><span class="m">30</span><span class="p">,</span><span class="w"> </span><span class="n">by</span><span class="o">=</span><span class="m">3</span><span class="p">)</span><span class="w">
</span></code></pre>

<pre class="highlight"><code><span class="n">seq</span><span class="p">(</span><span class="n">from</span><span class="o">=</span><span class="m">15</span><span class="p">,</span><span class="w"> </span><span class="n">to</span><span class="o">=</span><span class="m">30</span><span class="p">,</span><span class="w"> </span><span class="n">by</span><span class="o">=</span><span class="w"> </span><span class="m">0.5</span><span class="p">)</span><span class="w">
</span></code></pre>

<pre class="highlight"><code>## [1] 15.0 15.5 16.0 16.5 17.0 17.5 18.0 18.5 19.0 19.5 20.0 20.5 21.0 21.5
## [15] 22.0 22.5 23.0 23.5 24.0 24.5 25.0 25.5 26.0 26.5 27.0 27.5 28.0 28.5
## [29] 29.0 29.5 30.0
</code></pre>

<pre class="highlight"><code><span class="n">seq</span><span class="p">(</span><span class="n">from</span><span class="o">=</span><span class="m">15</span><span class="p">,</span><span class="w"> </span><span class="n">to</span><span class="o">=</span><span class="m">30</span><span class="p">,</span><span class="w"> </span><span class="n">length</span><span class="o">=</span><span class="m">10</span><span class="p">)</span><span class="w"> </span><span class="c1">#tamanho da sequ&#xEA;ncia definida
</span></code></pre>

<pre class="highlight"><code>## [1] 15.00000 16.66667 18.33333 20.00000 21.66667 23.33333 25.00000
## [8] 26.66667 28.33333 30.00000
</code></pre>

<pre class="highlight"><code><span class="n">seq</span><span class="p">(</span><span class="n">from</span><span class="o">=</span><span class="m">15</span><span class="p">,</span><span class="w"> </span><span class="n">to</span><span class="o">=</span><span class="m">5</span><span class="p">,</span><span class="w"> </span><span class="n">by</span><span class="o">=</span><span class="m">-.5</span><span class="p">)</span><span class="w">
</span></code></pre>

<pre class="highlight"><code>## [1] 15.0 14.5 14.0 13.5 13.0 12.5 12.0 11.5 11.0 10.5 10.0 9.5 9.0 8.5
## [15] 8.0 7.5 7.0 6.5 6.0 5.5 5.0
</code></pre>

<p>
Podemos ainda criar repetições com a função
<code class="highlighter-rouge">rep()</code>:
</p>
<pre class="highlight"><code>## [1] 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3
</code></pre>

<pre class="highlight"><code>## [1] 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 3 3 3 3 3 3 3 3 3 3
</code></pre>

<h3 id="missing-data">
Missing data
</h3>
<p>
No <code class="highlighter-rouge">R</code> o valor <em>missing</em>, ou
<strong>não resposta</strong> é representado por
<code class="highlighter-rouge">NA</code>.
</p>
<pre class="highlight"><code><span class="nf">is.na</span><span class="p">(</span><span class="n">x</span><span class="p">)</span><span class="w"> </span><span class="c1">#No vetor x h&#xE1; um NA?
</span></code></pre>

<pre class="highlight"><code>## [1] FALSE FALSE TRUE FALSE FALSE
</code></pre>

<pre class="highlight"><code><span class="nf">is.nan</span><span class="p">(</span><span class="n">x</span><span class="p">)</span><span class="w"> </span><span class="c1">#No vetor x h&#xE1; um NaN (not a number)?
</span></code></pre>

<pre class="highlight"><code>## [1] FALSE FALSE FALSE FALSE FALSE
</code></pre>

<p>
Veja bem que NaN (<em>not a number</em>) é um caso especial de
<em>missing values</em>.
</p>
<h3 id="matrizes">
Matrizes
</h3>
<p>
Matrizes são objetos que assumem duas dimensões, ou seja, vetores
organizados em linhas e colunas. As matrizes podem armazenar dados de
apenas um tipo. Esta é uma característica importante para lembrarmos.
</p>
<p>
Podemos criar uma matriz no <code class="highlighter-rouge">R</code> com
o comando <code class="highlighter-rouge">matrix()</code> e definindo o
número de linhas e colunas:
</p>
<pre class="highlight"><code><span class="n">matrix</span><span class="p">(</span><span class="m">1</span><span class="o">:</span><span class="m">40</span><span class="p">,</span><span class="w"> </span><span class="n">nrow</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">10</span><span class="p">,</span><span class="w"> </span><span class="n">ncol</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">4</span><span class="p">)</span><span class="w">
</span></code></pre>

<pre class="highlight"><code>## [,1] [,2] [,3] [,4]
## [1,] 1 11 21 31
## [2,] 2 12 22 32
## [3,] 3 13 23 33
## [4,] 4 14 24 34
## [5,] 5 15 25 35
## [6,] 6 16 26 36
## [7,] 7 17 27 37
## [8,] 8 18 28 38
## [9,] 9 19 29 39
## [10,] 10 20 30 40
</code></pre>

<pre class="highlight"><code><span class="n">matrix</span><span class="p">(</span><span class="m">1</span><span class="o">:</span><span class="m">40</span><span class="p">,</span><span class="w"> </span><span class="n">nrow</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">10</span><span class="p">,</span><span class="w"> </span><span class="n">ncol</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">4</span><span class="p">,</span><span class="w"> </span><span class="n">byrow</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nb">T</span><span class="p">)</span><span class="w">
</span></code></pre>

<pre class="highlight"><code>## [,1] [,2] [,3] [,4]
## [1,] 1 2 3 4
## [2,] 5 6 7 8
## [3,] 9 10 11 12
## [4,] 13 14 15 16
## [5,] 17 18 19 20
## [6,] 21 22 23 24
## [7,] 25 26 27 28
## [8,] 29 30 31 32
## [9,] 33 34 35 36
## [10,] 37 38 39 40
</code></pre>

<p>
Podemos também fazer operações com matrizes:
</p>
<pre class="highlight"><code><span class="n">X</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">matrix</span><span class="p">(</span><span class="m">21</span><span class="o">:</span><span class="m">40</span><span class="p">,</span><span class="w"> </span><span class="m">5</span><span class="p">,</span><span class="w"> </span><span class="m">4</span><span class="p">)</span><span class="w">
</span><span class="n">X</span><span class="w">
</span></code></pre>

<pre class="highlight"><code>## [,1] [,2] [,3] [,4]
## [1,] 21 26 31 36
## [2,] 22 27 32 37
## [3,] 23 28 33 38
## [4,] 24 29 34 39
## [5,] 25 30 35 40
</code></pre>

<pre class="highlight"><code>## [,1] [,2] [,3] [,4]
## [1,] 4.582576 5.099020 5.567764 6.000000
## [2,] 4.690416 5.196152 5.656854 6.082763
## [3,] 4.795832 5.291503 5.744563 6.164414
## [4,] 4.898979 5.385165 5.830952 6.244998
## [5,] 5.000000 5.477226 5.916080 6.324555
</code></pre>

<pre class="highlight"><code>## [,1] [,2] [,3] [,4]
## [1,] 441 676 961 1296
## [2,] 484 729 1024 1369
## [3,] 529 784 1089 1444
## [4,] 576 841 1156 1521
## [5,] 625 900 1225 1600
</code></pre>

<p>
Para selecionar um elemento qualquer de uma matriz, usamos
<code class="highlighter-rouge">\[\]</code>:
</p>
<p>
Para selecionar por linhas e colunas use a fórmula
<code class="highlighter-rouge">\[linha , coluna\]</code>.
</p>
<p>
Para investigar as dimensões de uma matriz, usamos o comando
<code class="highlighter-rouge">dim()</code>.
<code class="highlighter-rouge">nrow()</code> e
<code class="highlighter-rouge">ncol()</code> retornam o número de
linhas e o número de colunas.
</p>
<h3 id="data-frames">
Data Frames
</h3>
<p>
Os <em>data frames</em> são os objetos do tipo <strong>banco de
dados</strong> do R. Eles também são organizados em linhas e colunas
mas, diferente das matrizes, os <em>data frames</em> podem conter
colunas de diferentes classes. Uma coluna pode ser <em>numeric</em>,
outra <em>character</em> e outra <em>integer</em>, por exemplo. Os
<em>data frames</em> são, portanto, estruturas semelhantes aos bancos de
dados convencionais usados em outros pacotes estatísticos como SPSS ou
STATA onde as colunas são as variáveis e as linhas, os casos.
</p>
<p>
Podemos criar um banco de dados com o comando
<code class="highlighter-rouge">data.frame()</code>. É necessário dizer
ao R o nome das variáveis:
</p>
<pre class="highlight"><code><span class="n">dados</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">data.frame</span><span class="p">(</span><span class="n">Nomes</span><span class="o">=</span><span class="nf">c</span><span class="p">(</span><span class="s2">&quot;Antonio&quot;</span><span class="p">,</span><span class="s2">&quot;Gilberto&quot;</span><span class="p">,</span><span class="s2">&quot;Mauricio&quot;</span><span class="p">,</span><span class="s2">&quot;Isabela&quot;</span><span class="p">),</span><span class="w"> </span><span class="n">Profissoes</span><span class="o">=</span><span class="nf">c</span><span class="p">(</span><span class="s2">&quot;Video Maker&quot;</span><span class="p">,</span><span class="s2">&quot;Comerciante&quot;</span><span class="p">,</span><span class="s2">&quot;Bancario&quot;</span><span class="p">,</span><span class="s2">&quot;Estudante&quot;</span><span class="p">),</span><span class="w"> </span><span class="n">Cidades</span><span class="o">=</span><span class="nf">c</span><span class="p">(</span><span class="s2">&quot;Belo Horizonte&quot;</span><span class="p">,</span><span class="s2">&quot;Sao Paulo&quot;</span><span class="p">,</span><span class="s2">&quot;Belo Horizonte&quot;</span><span class="p">,</span><span class="s2">&quot;Sao Paulo&quot;</span><span class="p">),</span><span class="w"> </span><span class="n">Idades</span><span class="o">=</span><span class="nf">c</span><span class="p">(</span><span class="m">65</span><span class="p">,</span><span class="m">50</span><span class="p">,</span><span class="m">67</span><span class="p">,</span><span class="m">19</span><span class="p">),</span><span class="w"> </span><span class="n">stringsAsFactors</span><span class="o">=</span><span class="nb">F</span><span class="p">)</span><span class="w">
</span><span class="n">dados</span><span class="w">
</span></code></pre>

<pre class="highlight"><code>## Nomes Profissoes Cidades Idades
## 1 Antonio Video Maker Belo Horizonte 65
## 2 Gilberto Comerciante Sao Paulo 50
## 3 Mauricio Bancario Belo Horizonte 67
## 4 Isabela Estudante Sao Paulo 19
</code></pre>

<p>
Podemos selecionar itens específicos de cada <em>data frame</em> de
várias maneiras.
</p>
<pre class="highlight"><code>## Idades
## 1 65
## 2 50
## 3 67
## 4 19
</code></pre>

<pre class="highlight"><code><span class="nf">class</span><span class="p">(</span><span class="n">dados</span><span class="p">[</span><span class="m">4</span><span class="p">])</span><span class="w"> </span><span class="c1"># retorna um data.frame
</span></code></pre>

<pre class="highlight"><code><span class="nf">class</span><span class="p">(</span><span class="n">dados</span><span class="p">[[</span><span class="m">4</span><span class="p">]])</span><span class="w"> </span><span class="c1"># [[]] retorna um numeric
</span></code></pre>

<pre class="highlight"><code><span class="nf">class</span><span class="p">(</span><span class="n">dados</span><span class="p">[</span><span class="s2">&quot;Idades&quot;</span><span class="p">])</span><span class="w"> </span><span class="c1"># retorna um data.frame
</span></code></pre>

<pre class="highlight"><code><span class="nf">class</span><span class="p">(</span><span class="n">dados</span><span class="p">[[</span><span class="s2">&quot;Idades&quot;</span><span class="p">]])</span><span class="w"> </span><span class="c1"># retorna um numeric
</span></code></pre>

<pre class="highlight"><code><span class="nf">class</span><span class="p">(</span><span class="n">dados</span><span class="o">$</span><span class="n">Idades</span><span class="p">)</span><span class="w"> </span><span class="c1"># Usando o operador $ retorna sempre um numeric
</span></code></pre>

<p>
Também podemos selecionar itens específicos de um <em>data frame</em>:
</p>
<pre class="highlight"><code><span class="n">dados</span><span class="p">[</span><span class="m">2</span><span class="p">,</span><span class="m">4</span><span class="p">]</span><span class="w"> </span><span class="c1"># linha 2, coluna 4
</span></code></pre>

<pre class="highlight"><code><span class="n">dados</span><span class="p">[</span><span class="m">3</span><span class="p">,</span><span class="m">1</span><span class="p">]</span><span class="w"> </span><span class="c1"># linha 3, coluna 1
</span></code></pre>

<pre class="highlight"><code><span class="n">dados</span><span class="p">[,</span><span class="m">2</span><span class="p">]</span><span class="w"> </span><span class="c1"># toda a coluna 2
</span></code></pre>

<pre class="highlight"><code>## [1] &quot;Video Maker&quot; &quot;Comerciante&quot; &quot;Bancario&quot; &quot;Estudante&quot;
</code></pre>

<pre class="highlight"><code><span class="n">dados</span><span class="p">[</span><span class="m">3</span><span class="p">,]</span><span class="w"> </span><span class="c1"># toda a linha 3
</span></code></pre>

<pre class="highlight"><code>## Nomes Profissoes Cidades Idades
## 3 Mauricio Bancario Belo Horizonte 67
</code></pre>

<p>
Podemos combinar essas formas de selecao:
</p>
<pre class="highlight"><code><span class="n">dados</span><span class="p">[[</span><span class="s2">&quot;Idades&quot;</span><span class="p">]][</span><span class="m">1</span><span class="p">]</span><span class="w"> </span><span class="c1">#Primeiro elemento da variavel idade
</span></code></pre>

<pre class="highlight"><code><span class="n">dados</span><span class="p">[[</span><span class="s2">&quot;Idades&quot;</span><span class="p">]][</span><span class="m">2</span><span class="o">:</span><span class="m">4</span><span class="p">]</span><span class="w"> </span><span class="c1"># Elementos 2,3 e 4 da variavel idade
</span></code></pre>

<p>
Podemos ainda especificar critérios de seleção. Neste exemplo, vamos
extrair todos os casos em que a pessoa tenha mais de 30 anos:
</p>
<pre class="highlight"><code><span class="c1"># dados fazendo subsetting pelas linhas em que a vari&#xE1;vel Idades seja maior que 30
</span><span class="n">dados</span><span class="p">[</span><span class="n">dados</span><span class="o">$</span><span class="n">Idades</span><span class="o">&gt;</span><span class="m">30</span><span class="p">,]</span><span class="w">
</span></code></pre>

<pre class="highlight"><code>## Nomes Profissoes Cidades Idades
## 1 Antonio Video Maker Belo Horizonte 65
## 2 Gilberto Comerciante Sao Paulo 50
## 3 Mauricio Bancario Belo Horizonte 67
</code></pre>

<p>
Para acrescentar novas informações aos bancos de dados, usamos os
comandos <code class="highlighter-rouge">rbind()</code> para acrescentar
linhas e <code class="highlighter-rouge">cbind()</code> para acrescentar
colunas.
</p>
<pre class="highlight"><code><span class="n">rbind</span><span class="p">(</span><span class="n">dados</span><span class="p">,</span><span class="w"> </span><span class="n">data.frame</span><span class="p">(</span><span class="n">Nomes</span><span class="o">=</span><span class="s2">&quot;Fernando&quot;</span><span class="p">,</span><span class="n">Profissoes</span><span class="o">=</span><span class="s2">&quot;Bancario&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">Cidades</span><span class="o">=</span><span class="s2">&quot;Belo Horizonte&quot;</span><span class="p">,</span><span class="n">Idades</span><span class="o">=</span><span class="m">28</span><span class="p">))</span><span class="w">
</span></code></pre>

<pre class="highlight"><code>## Nomes Profissoes Cidades Idades
## 1 Antonio Video Maker Belo Horizonte 65
## 2 Gilberto Comerciante Sao Paulo 50
## 3 Mauricio Bancario Belo Horizonte 67
## 4 Isabela Estudante Sao Paulo 19
## 5 Fernando Bancario Belo Horizonte 28
</code></pre>

<pre class="highlight"><code><span class="n">cbind</span><span class="p">(</span><span class="n">dados</span><span class="p">,</span><span class="w"> </span><span class="n">Time</span><span class="o">=</span><span class="nf">c</span><span class="p">(</span><span class="s2">&quot;Cruzeiro&quot;</span><span class="p">,</span><span class="s2">&quot;Galo Doido&quot;</span><span class="p">,</span><span class="s2">&quot;Cruzeiro&quot;</span><span class="p">,</span><span class="s2">&quot;Galo Doido&quot;</span><span class="p">))</span><span class="w">
</span></code></pre>

<pre class="highlight"><code>## Nomes Profissoes Cidades Idades Time
## 1 Antonio Video Maker Belo Horizonte 65 Cruzeiro
## 2 Gilberto Comerciante Sao Paulo 50 Galo Doido
## 3 Mauricio Bancario Belo Horizonte 67 Cruzeiro
## 4 Isabela Estudante Sao Paulo 19 Galo Doido
</code></pre>

<p>
Podemos ainda criar uma matriz ou um <em>data frame</em> com os comandos
<code class="highlighter-rouge">rbind()</code> e
<code class="highlighter-rouge">cbind()</code> a partir de vetores. Por
exemplo:
</p>
<pre class="highlight"><code><span class="n">pessoas</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="s2">&quot;Neylson&quot;</span><span class="p">,</span><span class="s2">&quot;&#xCD;talo&quot;</span><span class="p">,</span><span class="s2">&quot;Vicky&quot;</span><span class="p">,</span><span class="s2">&quot;Mel&quot;</span><span class="p">,</span><span class="s2">&quot;Leonardo&quot;</span><span class="p">)</span><span class="w">
</span><span class="n">idades</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="m">29</span><span class="p">,</span><span class="w"> </span><span class="m">23</span><span class="p">,</span><span class="w"> </span><span class="m">21</span><span class="p">,</span><span class="w"> </span><span class="m">49</span><span class="p">,</span><span class="w"> </span><span class="m">27</span><span class="p">)</span><span class="w">
</span><span class="n">grupos_pesquisa</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="s2">&quot;GIARS&quot;</span><span class="p">,</span><span class="s2">&quot;GIARS&quot;</span><span class="p">,</span><span class="s2">&quot;GIARS&quot;</span><span class="p">,</span><span class="s2">&quot;CPEQS&quot;</span><span class="p">,</span><span class="s2">&quot;CPEQS&quot;</span><span class="p">)</span><span class="w">
</span><span class="n">colegas</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">cbind</span><span class="p">(</span><span class="n">pessoas</span><span class="p">,</span><span class="w"> </span><span class="n">idades</span><span class="p">,</span><span class="w"> </span><span class="n">grupos_pesquisa</span><span class="p">)</span><span class="w">
</span><span class="n">colegas</span><span class="w">
</span></code></pre>

<pre class="highlight"><code>## pessoas idades grupos_pesquisa
## [1,] &quot;Neylson&quot; &quot;29&quot; &quot;GIARS&quot; ## [2,] &quot;&#xCD;talo&quot; &quot;23&quot; &quot;GIARS&quot; ## [3,] &quot;Vicky&quot; &quot;21&quot; &quot;GIARS&quot; ## [4,] &quot;Mel&quot; &quot;49&quot; &quot;CPEQS&quot; ## [5,] &quot;Leonardo&quot; &quot;27&quot; &quot;CPEQS&quot;
</code></pre>

<pre class="highlight"><code><span class="n">sapply</span><span class="p">(</span><span class="n">colegas</span><span class="p">,</span><span class="w"> </span><span class="n">class</span><span class="p">)</span><span class="w"> </span><span class="c1"># aplica a fun&#xE7;&#xE3;o class para cada elemento da matriz
</span></code></pre>

<pre class="highlight"><code>## Neylson &#xCD;talo Vicky Mel Leonardo 29 ## &quot;character&quot; &quot;character&quot; &quot;character&quot; &quot;character&quot; &quot;character&quot; &quot;character&quot; ## 23 21 49 27 GIARS GIARS ## &quot;character&quot; &quot;character&quot; &quot;character&quot; &quot;character&quot; &quot;character&quot; &quot;character&quot; ## GIARS CPEQS CPEQS ## &quot;character&quot; &quot;character&quot; &quot;character&quot;
</code></pre>

<pre class="highlight"><code><span class="n">colegas</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">cbind.data.frame</span><span class="p">(</span><span class="n">pessoas</span><span class="p">,</span><span class="w"> </span><span class="n">idades</span><span class="p">,</span><span class="w"> </span><span class="n">grupos_pesquisa</span><span class="p">)</span><span class="w">
</span><span class="n">colegas</span><span class="w">
</span></code></pre>

<pre class="highlight"><code>## pessoas idades grupos_pesquisa
## 1 Neylson 29 GIARS
## 2 &#xCD;talo 23 GIARS
## 3 Vicky 21 GIARS
## 4 Mel 49 CPEQS
## 5 Leonardo 27 CPEQS
</code></pre>

<pre class="highlight"><code><span class="n">sapply</span><span class="p">(</span><span class="n">colegas</span><span class="p">,</span><span class="w"> </span><span class="n">class</span><span class="p">)</span><span class="w"> </span><span class="c1"># aplica a fun&#xE7;&#xE3;o class para cada elemento do data.frame (colunas)
</span></code></pre>

<pre class="highlight"><code>## pessoas idades grupos_pesquisa ## &quot;factor&quot; &quot;numeric&quot; &quot;factor&quot;
</code></pre>

<h3 id="listas">
Listas
</h3>
<p>
Uma lista é uma classe de objetos mais complexa do que o <em>data
frame</em> porque pode conter quaisquer outras classes em sua
composição. Podemos montar uma lista com um vetor numérico, um vetor
character, uma matriz e um data.frame:
</p>
<pre class="highlight"><code><span class="n">lista</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="nf">list</span><span class="p">(</span><span class="n">numerico</span><span class="o">=</span><span class="nf">c</span><span class="p">(</span><span class="m">4</span><span class="p">,</span><span class="m">6</span><span class="p">,</span><span class="m">78</span><span class="p">,</span><span class="m">9.5</span><span class="p">,</span><span class="m">3.465</span><span class="p">,</span><span class="m">1098</span><span class="p">),</span><span class="w"> </span><span class="n">vetor_character</span><span class="o">=</span><span class="nf">c</span><span class="p">(</span><span class="s2">&quot;M&#xE1;rcio&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;Cl&#xE9;ber&quot;</span><span class="p">),</span><span class="w"> </span><span class="n">matriz</span><span class="o">=</span><span class="n">matrix</span><span class="p">(</span><span class="m">101</span><span class="o">:</span><span class="m">200</span><span class="p">,</span><span class="w"> </span><span class="m">20</span><span class="p">,</span><span class="w"> </span><span class="m">5</span><span class="p">),</span><span class="w"> </span><span class="n">bd</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">data.frame</span><span class="p">(</span><span class="n">nomes</span><span class="o">=</span><span class="nf">c</span><span class="p">(</span><span class="s2">&quot;C&#xE9;sar&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;Daniel&quot;</span><span class="p">,</span><span class="s2">&quot;Cec&#xED;lia&quot;</span><span class="p">),</span><span class="w"> </span><span class="n">idades</span><span class="o">=</span><span class="nf">c</span><span class="p">(</span><span class="m">19</span><span class="p">,</span><span class="m">22</span><span class="p">,</span><span class="m">24</span><span class="p">),</span><span class="w"> </span><span class="n">raca</span><span class="o">=</span><span class="nf">c</span><span class="p">(</span><span class="s2">&quot;Branco&quot;</span><span class="p">,</span><span class="s2">&quot;Pardo&quot;</span><span class="p">,</span><span class="s2">&quot;Preto&quot;</span><span class="p">),</span><span class="w"> </span><span class="n">stringsAsFactors</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nb">F</span><span class="p">))</span><span class="w">
</span><span class="n">lista</span><span class="w">
</span></code></pre>

<pre class="highlight"><code>## $numerico
## [1] 4.000 6.000 78.000 9.500 3.465 1098.000
## ## $vetor_character
## [1] &quot;M&#xE1;rcio&quot; &quot;Cl&#xE9;ber&quot;
## ## $matriz
## [,1] [,2] [,3] [,4] [,5]
## [1,] 101 121 141 161 181
## [2,] 102 122 142 162 182
## [3,] 103 123 143 163 183
## [4,] 104 124 144 164 184
## [5,] 105 125 145 165 185
## [6,] 106 126 146 166 186
## [7,] 107 127 147 167 187
## [8,] 108 128 148 168 188
## [9,] 109 129 149 169 189
## [10,] 110 130 150 170 190
## [11,] 111 131 151 171 191
## [12,] 112 132 152 172 192
## [13,] 113 133 153 173 193
## [14,] 114 134 154 174 194
## [15,] 115 135 155 175 195
## [16,] 116 136 156 176 196
## [17,] 117 137 157 177 197
## [18,] 118 138 158 178 198
## [19,] 119 139 159 179 199
## [20,] 120 140 160 180 200
## ## $bd
## nomes idades raca
## 1 C&#xE9;sar 19 Branco
## 2 Daniel 22 Pardo
## 3 Cec&#xED;lia 24 Preto
</code></pre>

<p>
Podemos fazer <em>subsetting</em> com listas do mesmo modo que fazemos
com <em>data frames</em>:
</p>
<pre class="highlight"><code><span class="c1"># Com colchetes simples
</span><span class="nf">class</span><span class="p">(</span><span class="n">lista</span><span class="p">[</span><span class="m">3</span><span class="p">])</span><span class="w">
</span></code></pre>

<pre class="highlight"><code><span class="c1"># Com colchetes duplas
</span><span class="nf">class</span><span class="p">(</span><span class="n">lista</span><span class="p">[[</span><span class="m">3</span><span class="p">]])</span><span class="w">
</span></code></pre>

<pre class="highlight"><code><span class="c1"># Subsettings mais precisos
</span><span class="nf">class</span><span class="p">(</span><span class="n">lista</span><span class="p">[[</span><span class="m">4</span><span class="p">]][</span><span class="m">2</span><span class="p">,</span><span class="m">1</span><span class="p">])</span><span class="w">
</span></code></pre>

</article>
<p class="blog-tags">
Tags: R programming, rstats
</p>

