+++
title = "INTRODUÇÃO AO R - Aula 3"
date = "2016-09-29 03:00:00"
categories = ["r-python-e-redes"]
original_url = "http://neylsoncrepalde.github.io/2016-09-29-introducao-ao-r-aula3/"
+++

<article class="blog-post">
<p>
Adaptado dos materiais de aula do
<a href="https://www.facebook.com/rogerio.barbosa.7528">Rogério
Barbosa</a>.
</p>
<h2 id="loops-e-estruturas-de-controle">
Loops e Estruturas de controle
</h2>
<p>
Loops são funções de iteração que nos permitem realizar tarefas
repetidas de forma automatizada. Os loops estão presentes em qualquer
linguagem de programação.
</p>
<p>
As três principais funções de loop são
<code class="highlighter-rouge">for</code>,
<code class="highlighter-rouge">while</code> e
<code class="highlighter-rouge">repeat</code>.
</p>
<h3 id="loop-for">
Loop For
</h3>
<p>
A estrutura do loop for é esta:
</p>
<pre class="highlight"><code><span class="k">for</span><span class="w"> </span><span class="p">(</span><span class="n">contador</span><span class="w"> </span><span class="k">in</span><span class="w"> </span><span class="n">conjunto_de_valores</span><span class="p">){</span><span class="w"> </span><span class="n">funcao_a_executar1</span><span class="w"> </span><span class="n">funcao_a_executar2</span><span class="w"> </span><span class="n">funcao_a_executar3</span><span class="w">
</span><span class="p">}</span><span class="w">
</span></code></pre>

<p>
Vamos começar. Podemos ler o comando abaixo da seguinte forma: para cada
número no conjunto de números de um a 10, “imprima” o número.
</p>
<pre class="highlight"><code><span class="k">for</span><span class="w"> </span><span class="p">(</span><span class="n">i</span><span class="w"> </span><span class="k">in</span><span class="w"> </span><span class="m">1</span><span class="o">:</span><span class="m">10</span><span class="p">){</span><span class="w"> </span><span class="n">print</span><span class="p">(</span><span class="n">i</span><span class="p">)</span><span class="w">
</span><span class="p">}</span><span class="w">
</span></code></pre>

<pre class="highlight"><code>## [1] 1
## [1] 2
## [1] 3
## [1] 4
## [1] 5
## [1] 6
## [1] 7
## [1] 8
## [1] 9
## [1] 10
</code></pre>

<p>
No comando acima, o “contador” e a expressao i e o “conjunto de valores”
e o vetor numerico c(1,2,3,4,5,6,7,8,9,10). O numero de elementos do
conjunto de valores determina quantas vezes as tarefas serao repetidas
Nesse caso, esse vetor tem 10 elementos. Entao, o loop sera executado 10
vezes.
</p>
<p>
Na primeira iteracao, i assume o valor do primeiro elemento do conjunto.
No caso, “1”. E entao executamos uma funcao: print(i). Com isso, o valor
de i sera apresentado na tela. Na segunda iteracao, i assume o valor do
segundo elemento; no caso, 2… e assim por diante.
</p>
<p>
Podemos fazer o mesmo modificando a saída para
<code class="highlighter-rouge">i^2</code>.
</p>
<pre class="highlight"><code><span class="k">for</span><span class="w"> </span><span class="p">(</span><span class="n">numero</span><span class="w"> </span><span class="k">in</span><span class="w"> </span><span class="m">1</span><span class="o">:</span><span class="m">10</span><span class="p">){</span><span class="w"> </span><span class="n">print</span><span class="p">(</span><span class="n">numero</span><span class="o">^</span><span class="m">2</span><span class="p">)</span><span class="w">
</span><span class="p">}</span><span class="w">
</span></code></pre>

<pre class="highlight"><code>## [1] 1
## [1] 4
## [1] 9
## [1] 16
## [1] 25
## [1] 36
## [1] 49
## [1] 64
## [1] 81
## [1] 100
</code></pre>

<p>
podemos executar várias coisas dentro de um loop. Vamos pedir uma média
para todas as variáveis numéricas do banco <strong>iris</strong>.
</p>
<pre class="highlight"><code><span class="n">data</span><span class="p">(</span><span class="n">iris</span><span class="p">)</span><span class="w">
</span><span class="k">for</span><span class="w"> </span><span class="p">(</span><span class="n">var</span><span class="w"> </span><span class="k">in</span><span class="w"> </span><span class="m">1</span><span class="o">:</span><span class="m">4</span><span class="p">){</span><span class="w"> </span><span class="n">print</span><span class="p">(</span><span class="w"> </span><span class="n">mean</span><span class="p">(</span><span class="n">iris</span><span class="p">[,</span><span class="n">var</span><span class="p">])</span><span class="w"> </span><span class="p">)</span><span class="w">
</span><span class="p">}</span><span class="w">
</span></code></pre>

<pre class="highlight"><code>## [1] 5.843333
## [1] 3.057333
## [1] 3.758
## [1] 1.199333
</code></pre>

<p>
Podemos ainda fazer loops dentro de loops. Vamos preencher, com uma
estrutura de loops aninhados, uma matriz. Primeiro criamos uma matriz
com 10 colunas e 20 linhas. Todas as entradas sao zero:
</p>
<pre class="highlight"><code><span class="n">A</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">matrix</span><span class="p">(</span><span class="m">0</span><span class="p">,</span><span class="n">ncol</span><span class="o">=</span><span class="m">10</span><span class="p">,</span><span class="n">nrow</span><span class="o">=</span><span class="m">20</span><span class="p">)</span><span class="w">
</span><span class="n">A</span><span class="w">
</span></code></pre>

<pre class="highlight"><code>## [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10]
## [1,] 0 0 0 0 0 0 0 0 0 0
## [2,] 0 0 0 0 0 0 0 0 0 0
## [3,] 0 0 0 0 0 0 0 0 0 0
## [4,] 0 0 0 0 0 0 0 0 0 0
## [5,] 0 0 0 0 0 0 0 0 0 0
## [6,] 0 0 0 0 0 0 0 0 0 0
## [7,] 0 0 0 0 0 0 0 0 0 0
## [8,] 0 0 0 0 0 0 0 0 0 0
## [9,] 0 0 0 0 0 0 0 0 0 0
## [10,] 0 0 0 0 0 0 0 0 0 0
## [11,] 0 0 0 0 0 0 0 0 0 0
## [12,] 0 0 0 0 0 0 0 0 0 0
## [13,] 0 0 0 0 0 0 0 0 0 0
## [14,] 0 0 0 0 0 0 0 0 0 0
## [15,] 0 0 0 0 0 0 0 0 0 0
## [16,] 0 0 0 0 0 0 0 0 0 0
## [17,] 0 0 0 0 0 0 0 0 0 0
## [18,] 0 0 0 0 0 0 0 0 0 0
## [19,] 0 0 0 0 0 0 0 0 0 0
## [20,] 0 0 0 0 0 0 0 0 0 0
</code></pre>

<p>
Agora vamos substituir os valores de cada celula usando loops:
</p>
<pre class="highlight"><code><span class="k">for</span><span class="p">(</span><span class="n">i</span><span class="w"> </span><span class="k">in</span><span class="w"> </span><span class="m">1</span><span class="o">:</span><span class="n">nrow</span><span class="p">(</span><span class="n">A</span><span class="p">)){</span><span class="w"> </span><span class="k">for</span><span class="p">(</span><span class="n">j</span><span class="w"> </span><span class="k">in</span><span class="w"> </span><span class="m">1</span><span class="o">:</span><span class="n">ncol</span><span class="p">(</span><span class="n">A</span><span class="p">)){</span><span class="w"> </span><span class="n">A</span><span class="p">[</span><span class="n">i</span><span class="p">,</span><span class="n">j</span><span class="p">]</span><span class="o">=</span><span class="n">i</span><span class="o">*</span><span class="n">j</span><span class="w"> </span><span class="p">}</span><span class="w"> </span><span class="p">}</span><span class="w">
</span><span class="n">A</span><span class="w">
</span></code></pre>

<pre class="highlight"><code>## [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10]
## [1,] 1 2 3 4 5 6 7 8 9 10
## [2,] 2 4 6 8 10 12 14 16 18 20
## [3,] 3 6 9 12 15 18 21 24 27 30
## [4,] 4 8 12 16 20 24 28 32 36 40
## [5,] 5 10 15 20 25 30 35 40 45 50
## [6,] 6 12 18 24 30 36 42 48 54 60
## [7,] 7 14 21 28 35 42 49 56 63 70
## [8,] 8 16 24 32 40 48 56 64 72 80
## [9,] 9 18 27 36 45 54 63 72 81 90
## [10,] 10 20 30 40 50 60 70 80 90 100
## [11,] 11 22 33 44 55 66 77 88 99 110
## [12,] 12 24 36 48 60 72 84 96 108 120
## [13,] 13 26 39 52 65 78 91 104 117 130
## [14,] 14 28 42 56 70 84 98 112 126 140
## [15,] 15 30 45 60 75 90 105 120 135 150
## [16,] 16 32 48 64 80 96 112 128 144 160
## [17,] 17 34 51 68 85 102 119 136 153 170
## [18,] 18 36 54 72 90 108 126 144 162 180
## [19,] 19 38 57 76 95 114 133 152 171 190
## [20,] 20 40 60 80 100 120 140 160 180 200
</code></pre>

<h3 id="usando-condicionais">
Usando condicionais
</h3>
<p>
O uso de condicionais é essencial em computação. Condicionais indicam
que uma ação só será realizada se uma determinada condição for cumprida.
</p>
<pre class="highlight"><code><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">10</span><span class="w">
</span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">15</span><span class="w">
</span><span class="k">if</span><span class="p">(</span><span class="n">x</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="m">10</span><span class="p">){</span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">x</span><span class="o">^</span><span class="m">2</span><span class="p">}</span><span class="w"> </span><span class="k">if</span><span class="p">(</span><span class="n">y</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="m">20</span><span class="p">){</span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">y</span><span class="o">^</span><span class="m">2</span><span class="p">}</span><span class="w">
</span><span class="n">x</span><span class="w">
</span></code></pre>

<p>
Podemos ler os comandos acima da seguinte maneira: uma vez que
atribuímos o valor 10 ao x e 15 ao y, colocamos o condicional se x for
igual a 10, x deverá receber um novo valor, x ao quadrado. Se y for
igual a 20, y deverá receber um novo valor, y ao quadrado. Como apenas a
primeira condicional é satisfeita, apenas o valor de x é modificado.
</p>
<p>
Podemos usar uma estrutura de loop for com condicional para classificar,
por exemplo, adultos num banco de dados.
</p>
<pre class="highlight"><code><span class="n">banco</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">data.frame</span><span class="p">(</span><span class="n">sexo</span><span class="o">=</span><span class="nf">c</span><span class="p">(</span><span class="s2">&quot;feminino&quot;</span><span class="p">,</span><span class="s2">&quot;masculino&quot;</span><span class="p">,</span><span class="s2">&quot;feminino&quot;</span><span class="p">,</span><span class="s2">&quot;masculino&quot;</span><span class="p">,</span><span class="s2">&quot;masculino&quot;</span><span class="p">,</span><span class="s2">&quot;feminino&quot;</span><span class="p">,</span><span class="s2">&quot;masculino&quot;</span><span class="p">,</span><span class="s2">&quot;feminino&quot;</span><span class="p">,</span><span class="s2">&quot;masculino&quot;</span><span class="p">,</span><span class="s2">&quot;feminino&quot;</span><span class="p">,</span><span class="s2">&quot;feminino&quot;</span><span class="p">,</span><span class="s2">&quot;masculino&quot;</span><span class="p">),</span><span class="w"> </span><span class="n">idade</span><span class="o">=</span><span class="nf">c</span><span class="p">(</span><span class="m">20</span><span class="p">,</span><span class="m">21</span><span class="p">,</span><span class="m">19</span><span class="p">,</span><span class="m">19</span><span class="p">,</span><span class="m">22</span><span class="p">,</span><span class="m">23</span><span class="p">,</span><span class="m">18</span><span class="p">,</span><span class="m">25</span><span class="p">,</span><span class="m">19</span><span class="p">,</span><span class="m">21</span><span class="p">,</span><span class="m">22</span><span class="p">,</span><span class="m">26</span><span class="p">),</span><span class="w"> </span><span class="n">stringsAsFactors</span><span class="o">=</span><span class="kc">FALSE</span><span class="p">)</span><span class="w"> </span><span class="n">banco</span><span class="o">$</span><span class="n">adulto</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">NA</span><span class="w">
</span><span class="k">for</span><span class="w"> </span><span class="p">(</span><span class="n">i</span><span class="w"> </span><span class="k">in</span><span class="w"> </span><span class="m">1</span><span class="o">:</span><span class="n">nrow</span><span class="p">(</span><span class="n">banco</span><span class="p">)){</span><span class="w"> </span><span class="k">if</span><span class="w"> </span><span class="p">(</span><span class="n">banco</span><span class="o">$</span><span class="n">idade</span><span class="p">[</span><span class="n">i</span><span class="p">]</span><span class="w"> </span><span class="o">&gt;=</span><span class="m">21</span><span class="p">){</span><span class="w"> </span><span class="n">banco</span><span class="o">$</span><span class="n">adulto</span><span class="p">[</span><span class="n">i</span><span class="p">]</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Adulto&quot;</span><span class="w"> </span><span class="p">}</span><span class="w"> </span><span class="k">else</span><span class="w"> </span><span class="p">{</span><span class="w"> </span><span class="n">banco</span><span class="o">$</span><span class="n">adulto</span><span class="p">[</span><span class="n">i</span><span class="p">]</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Jovem&quot;</span><span class="w"> </span><span class="p">}</span><span class="w">
</span><span class="p">}</span><span class="w">
</span><span class="n">banco</span><span class="w">
</span></code></pre>

<pre class="highlight"><code>## sexo idade adulto
## 1 feminino 20 Jovem
## 2 masculino 21 Adulto
## 3 feminino 19 Jovem
## 4 masculino 19 Jovem
## 5 masculino 22 Adulto
## 6 feminino 23 Adulto
## 7 masculino 18 Jovem
## 8 feminino 25 Adulto
## 9 masculino 19 Jovem
## 10 feminino 21 Adulto
## 11 feminino 22 Adulto
## 12 masculino 26 Adulto
</code></pre>

<p>
Aqui, criamos uma nova variável <strong>adulto</strong> e a
recodificamos segundo criterio de idade ser maior ou igual a 21 anos.
</p>
<p>
Outro exemplo de recodificação com o banco de dados do Enade (que
trabalhamos na aula 2). Sabemos, consultando o questionário do aluno,
que as variáveis 101 até 142 (organização didático-pedagógica) tem as
opções 7 e 8 codificadas respectivamente como “não sei responder” e “não
se aplica”. Precisamos recodificá-las como NA’s para que nossa análise
fique correta. Para fazer isso de modo bem fácil, podemos utilizar a
função <code class="highlighter-rouge">recode</code> do pacote
<code class="highlighter-rouge">car</code>. Podemos fazer:
</p>
<pre class="highlight"><code><span class="n">library</span><span class="p">(</span><span class="n">readr</span><span class="p">)</span><span class="w">
</span><span class="n">enade</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">read_csv2</span><span class="p">(</span><span class="s2">&quot;/home/neylson/enade.csv&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">col_names</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nb">T</span><span class="p">)</span><span class="w"> </span><span class="n">library</span><span class="p">(</span><span class="n">descr</span><span class="p">)</span><span class="w">
</span><span class="n">freq</span><span class="p">(</span><span class="n">enade</span><span class="p">[,</span><span class="m">101</span><span class="p">],</span><span class="w"> </span><span class="n">plot</span><span class="o">=</span><span class="nb">F</span><span class="p">)</span><span class="w"> </span><span class="c1"># verificando as categorias da vari&#xE1;vel 101
</span></code></pre>

<pre class="highlight"><code>## enade[, 101] ## Frequ&#xEA;ncia Percentual % V&#xE1;lido
## 1 56 0.56 0.6444
## 2 110 1.10 1.2658
## 3 292 2.92 3.3602
## 4 1065 10.65 12.2555
## 5 2028 20.28 23.3372
## 6 4983 49.83 57.3418
## 7 97 0.97 1.1162
## 8 59 0.59 0.6789
## NA&apos;s 1310 13.10 ## Total 10000 100.00 100.0000
</code></pre>

<pre class="highlight"><code><span class="n">library</span><span class="p">(</span><span class="n">plyr</span><span class="p">)</span><span class="w"> </span><span class="k">for</span><span class="w"> </span><span class="p">(</span><span class="n">i</span><span class="w"> </span><span class="k">in</span><span class="w"> </span><span class="m">101</span><span class="o">:</span><span class="m">142</span><span class="p">){</span><span class="w"> </span><span class="n">print</span><span class="p">(</span><span class="n">i</span><span class="p">)</span><span class="w"> </span><span class="n">enade</span><span class="p">[,</span><span class="n">i</span><span class="p">]</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">mapvalues</span><span class="p">(</span><span class="n">enade</span><span class="p">[,</span><span class="n">i</span><span class="p">],</span><span class="w"> </span><span class="n">from</span><span class="o">=</span><span class="nf">c</span><span class="p">(</span><span class="m">7</span><span class="p">,</span><span class="m">8</span><span class="p">),</span><span class="w"> </span><span class="n">to</span><span class="o">=</span><span class="nf">c</span><span class="p">(</span><span class="kc">NA</span><span class="p">,</span><span class="kc">NA</span><span class="p">))</span><span class="w">
</span><span class="p">}</span><span class="w">
</span></code></pre>

<pre class="highlight"><code>## [1] 101
## [1] 102
## [1] 103
## [1] 104
## [1] 105
## [1] 106
## [1] 107
## [1] 108
## [1] 109
## [1] 110
## [1] 111
## [1] 112
## [1] 113
## [1] 114
## [1] 115
## [1] 116
## [1] 117
## [1] 118
## [1] 119
## [1] 120
## [1] 121
## [1] 122
## [1] 123
## [1] 124
## [1] 125
## [1] 126
## [1] 127
## [1] 128
## [1] 129
## [1] 130
## [1] 131
## [1] 132
## [1] 133
## [1] 134
## [1] 135
## [1] 136
## [1] 137
## [1] 138
## [1] 139
## [1] 140
## [1] 141
## [1] 142
</code></pre>

<pre class="highlight"><code><span class="n">freq</span><span class="p">(</span><span class="n">enade</span><span class="p">[,</span><span class="m">101</span><span class="p">],</span><span class="w"> </span><span class="n">plot</span><span class="o">=</span><span class="nb">F</span><span class="p">)</span><span class="w"> </span><span class="c1"># ap&#xF3;s a recodifica&#xE7;&#xE3;o
</span></code></pre>

<pre class="highlight"><code>## enade[, 101] ## Frequ&#xEA;ncia Percentual % V&#xE1;lido
## 1 56 0.56 0.6562
## 2 110 1.10 1.2890
## 3 292 2.92 3.4216
## 4 1065 10.65 12.4795
## 5 2028 20.28 23.7638
## 6 4983 49.83 58.3900
## NA&apos;s 1466 14.66 ## Total 10000 100.00 100.0000
</code></pre>

<h3 id="loop-while">
Loop While
</h3>
<p>
O loop while é executado até que uma condição seja satisfeita.
</p>
<pre class="highlight"><code><span class="n">x</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="m">10</span><span class="w">
</span><span class="n">numero_da_iteracao</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="m">0</span><span class="w"> </span><span class="k">while</span><span class="p">(</span><span class="n">x</span><span class="w"> </span><span class="o">&gt;</span><span class="w"> </span><span class="m">-2</span><span class="p">){</span><span class="w"> </span><span class="n">print</span><span class="p">(</span><span class="n">paste</span><span class="p">(</span><span class="s2">&quot;Esta &#xE9; a itera&#xE7;&#xE3;o&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">numero_da_iteracao</span><span class="p">))</span><span class="w"> </span><span class="n">x</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">rnorm</span><span class="p">(</span><span class="m">1</span><span class="p">)</span><span class="w"> </span><span class="n">numero_da_iteracao</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">numero_da_iteracao</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="m">1</span><span class="w">
</span><span class="p">}</span><span class="w">
</span></code></pre>

<pre class="highlight"><code>## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 0&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 1&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 2&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 3&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 4&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 5&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 6&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 7&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 8&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 9&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 10&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 11&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 12&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 13&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 14&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 15&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 16&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 17&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 18&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 19&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 20&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 21&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 22&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 23&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 24&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 25&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 26&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 27&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 28&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 29&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 30&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 31&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 32&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 33&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 34&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 35&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 36&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 37&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 38&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 39&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 40&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 41&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 42&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 43&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 44&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 45&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 46&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 47&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 48&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 49&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 50&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 51&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 52&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 53&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 54&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 55&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 56&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 57&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 58&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 59&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 60&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 61&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 62&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 63&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 64&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 65&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 66&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 67&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 68&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 69&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 70&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 71&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 72&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 73&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 74&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 75&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 76&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 77&quot;
## [1] &quot;Esta &#xE9; a itera&#xE7;&#xE3;o 78&quot;
</code></pre>

<h3 id="loop-repeat">
Loop Repeat
</h3>
<p>
O loop repeat é executado infinitamente. É bom que coloquemos uma
condição para que ele pare usando a função
<code class="highlighter-rouge">break</code>.
</p>
<pre class="highlight"><code><span class="n">i</span><span class="o">=</span><span class="m">0</span><span class="w">
</span><span class="k">repeat</span><span class="p">{</span><span class="w"> </span><span class="n">print</span><span class="p">(</span><span class="n">i</span><span class="p">)</span><span class="w"> </span><span class="n">i</span><span class="o">=</span><span class="n">i</span><span class="m">+1</span><span class="w"> </span><span class="k">if</span><span class="p">(</span><span class="n">i</span><span class="w"> </span><span class="o">&gt;</span><span class="w"> </span><span class="m">1000</span><span class="p">)</span><span class="w"> </span><span class="p">{</span><span class="w"> </span><span class="k">break</span><span class="w"> </span><span class="p">}</span><span class="w">
</span><span class="p">}</span><span class="w">
</span></code></pre>

<h2 id="a-família-apply-intro">
A família APPLY (INTRO)
</h2>
<p>
O R possui uma família de funções chamada
<code class="highlighter-rouge">apply()</code> para realizar loops de
forma intuitiva e com muita eficiência computacional.
</p>
<p>
A família possui a função genérica
<code class="highlighter-rouge">apply()</code> e suas variações
<code class="highlighter-rouge">sapply()</code>,
<code class="highlighter-rouge">lapply()</code>,
<code class="highlighter-rouge">tapply()</code>,
<code class="highlighter-rouge">mapply()</code>, dentre outras. Hoje
vamos trabalhar com lapply e sapply.
</p>
<p>
Podemos executar um comando para várias variáveis de uma só vez, por
exemplo, tirar a média. Lapply recebe uma lista como argumento e retorna
uma nova lista.
</p>
<pre class="highlight"><code><span class="n">x</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="nf">list</span><span class="p">(</span><span class="n">Componente1</span><span class="o">=</span><span class="m">1</span><span class="o">:</span><span class="m">50</span><span class="p">,</span><span class="w"> </span><span class="n">Componente2</span><span class="o">=</span><span class="n">seq</span><span class="p">(</span><span class="m">2</span><span class="p">,</span><span class="m">10</span><span class="p">,</span><span class="n">by</span><span class="o">=</span><span class="m">.2</span><span class="p">))</span><span class="w">
</span><span class="n">x</span><span class="w">
</span></code></pre>

<pre class="highlight"><code>## $Componente1
## [1] 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23
## [24] 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46
## [47] 47 48 49 50
## ## $Componente2
## [1] 2.0 2.2 2.4 2.6 2.8 3.0 3.2 3.4 3.6 3.8 4.0 4.2 4.4 4.6
## [15] 4.8 5.0 5.2 5.4 5.6 5.8 6.0 6.2 6.4 6.6 6.8 7.0 7.2 7.4
## [29] 7.6 7.8 8.0 8.2 8.4 8.6 8.8 9.0 9.2 9.4 9.6 9.8 10.0
</code></pre>

<pre class="highlight"><code>## $Componente1
## [1] 25.5
## ## $Componente2
## [1] 6
</code></pre>

<p>
Sapply retorna os valores simplificados.
</p>
<pre class="highlight"><code>## Sepal.Length Sepal.Width Petal.Length Petal.Width ## 5.843333 3.057333 3.758000 1.199333
</code></pre>

<p>
Tapply executa uma função por grupos.
</p>
<pre class="highlight"><code><span class="c1"># Sem tapply
</span><span class="n">mean</span><span class="p">(</span><span class="n">iris</span><span class="o">$</span><span class="n">Petal.Width</span><span class="p">[</span><span class="n">iris</span><span class="o">$</span><span class="n">Species</span><span class="o">==</span><span class="s2">&quot;virginica&quot;</span><span class="p">])</span><span class="w">
</span></code></pre>

<pre class="highlight"><code><span class="n">mean</span><span class="p">(</span><span class="n">iris</span><span class="o">$</span><span class="n">Petal.Width</span><span class="p">[</span><span class="n">iris</span><span class="o">$</span><span class="n">Species</span><span class="o">==</span><span class="s2">&quot;setosa&quot;</span><span class="p">])</span><span class="w">
</span></code></pre>

<pre class="highlight"><code><span class="n">mean</span><span class="p">(</span><span class="n">iris</span><span class="o">$</span><span class="n">Petal.Width</span><span class="p">[</span><span class="n">iris</span><span class="o">$</span><span class="n">Species</span><span class="o">==</span><span class="s2">&quot;versicolor&quot;</span><span class="p">])</span><span class="w">
</span></code></pre>

<pre class="highlight"><code><span class="c1"># Com tapply...
</span><span class="n">tapply</span><span class="p">(</span><span class="n">iris</span><span class="o">$</span><span class="n">Petal.Width</span><span class="p">,</span><span class="w"> </span><span class="n">iris</span><span class="o">$</span><span class="n">Species</span><span class="p">,</span><span class="w"> </span><span class="n">mean</span><span class="p">)</span><span class="w">
</span></code></pre>

<pre class="highlight"><code>## setosa versicolor virginica ## 0.246 1.326 2.026
</code></pre>

</article>
<p class="blog-tags">
Tags: R programming, rstats
</p>

