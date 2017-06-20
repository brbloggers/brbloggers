+++
title = "Udacity Deep Learning Parte 1: Manipulação de dados"
date = "2017-01-07"
categories = ["dfalbel"]
original_url = "http://dfalbel.github.io/2017/01/udacity-deep-learning-01.html"
+++

<article class="post-content">
<p>
Faz algum tempo tenho praticado Deep Learnig, fazendo o curso disponível
na
<a href="https://br.udacity.com/course/deep-learning--ud730/">Udacity</a>.
O curso é muito bom, o professor é um dos pesquisadores do Google Brain!
</p>
<p>
Fiz alguns exercícios do curso, e gostaria de divulgar as minhas
soluções aqui no blog. O primeiro exercício, pouco tem a ver com Deep
Learning, na verdade a tarefa é organizar todas as imagens
disponibilizadas
<a href="http://yaroslavvb.blogspot.com.br/2011/09/notmnist-dataset.html">aqui</a>.
Esse conjunto de dados é chamado notMINIST.
</p>
<p>
<img src="http://dfalbel.github.io/images/nmn.png" alt="">
</p>
<p>
Vamos lá!
</p>
<h2 id="download-dos-dados">
Download dos dados
</h2>
<p>
O primeiro passo é fazer o download dos dados para a nossa máquina.
Temos dois aquivos, um de treino e um de teste. A diferença é que no
conjunto de imagens de teste, elas foram verificadas de que estava
corretamente classificadas, no de treino não.
</p>
<p>
Os arquivos são baixados e extraídos com o código a seguir.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">library</span><span class="p">(</span><span class="n">httr</span><span class="p">)</span><span class="w">
</span><span class="n">url</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="s1">&apos;http://commondatastorage.googleapis.com/books1000/&apos;</span><span class="w">
</span><span class="c1"># download traning data
</span><span class="n">GET</span><span class="p">(</span><span class="n">paste0</span><span class="p">(</span><span class="n">url</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;notMNIST_large.tar.gz&quot;</span><span class="p">),</span><span class="w"> </span><span class="n">write_disk</span><span class="p">(</span><span class="s2">&quot;notMNIST_large.tar.gz&quot;</span><span class="p">))</span><span class="w">
</span><span class="c1"># download test data
</span><span class="n">GET</span><span class="p">(</span><span class="n">paste0</span><span class="p">(</span><span class="n">url</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;notMNIST_small.tar.gz&quot;</span><span class="p">),</span><span class="w"> </span><span class="n">write_disk</span><span class="p">(</span><span class="s2">&quot;notMNIST_small.tar.gz&quot;</span><span class="p">))</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-r"><span class="n">untar</span><span class="p">(</span><span class="s2">&quot;notMNIST_large.tar.gz&quot;</span><span class="p">)</span><span class="w">
</span><span class="n">untar</span><span class="p">(</span><span class="s2">&quot;notMNIST_small.tar.gz&quot;</span><span class="p">)</span></code></pre>
</figure>
<p>
Com isso você terá dois diretórios, cada um deles com mais diretórios
representando as letras A a J.
</p>
<p>
O primeiro problema pedido nos exercícios da Udacity era, abrir algumas
imagens e verificar que são letras de A a J em diferentes fontes.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">library</span><span class="p">(</span><span class="n">purrr</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">magick</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">magrittr</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-r"><span class="n">files</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="s1">&apos;notMNIST_large/&apos;</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">list.dirs</span><span class="p">(</span><span class="n">full.names</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">TRUE</span><span class="p">,</span><span class="w"> </span><span class="n">recursive</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">FALSE</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">map</span><span class="p">(</span><span class="o">~</span><span class="n">list.files</span><span class="p">(</span><span class="n">.x</span><span class="p">,</span><span class="w"> </span><span class="n">full.names</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">TRUE</span><span class="p">,</span><span class="w"> </span><span class="n">recursive</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">FALSE</span><span class="p">))</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">map_chr</span><span class="p">(</span><span class="o">~</span><span class="n">sample</span><span class="p">(</span><span class="n">.x</span><span class="p">,</span><span class="w"> </span><span class="m">1</span><span class="p">))</span><span class="w"> </span><span class="n">par</span><span class="p">(</span><span class="n">mfrow</span><span class="o">=</span><span class="nf">c</span><span class="p">(</span><span class="m">5</span><span class="p">,</span><span class="m">2</span><span class="p">),</span><span class="w"> </span><span class="n">mar</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">rep</span><span class="p">(</span><span class="m">0</span><span class="p">,</span><span class="w"> </span><span class="m">4</span><span class="p">))</span><span class="w">
</span><span class="k">for</span><span class="p">(</span><span class="n">i</span><span class="w"> </span><span class="k">in</span><span class="w"> </span><span class="m">1</span><span class="o">:</span><span class="m">10</span><span class="p">)</span><span class="w"> </span><span class="n">plot</span><span class="p">(</span><span class="n">image_read</span><span class="p">(</span><span class="n">files</span><span class="p">[</span><span class="n">i</span><span class="p">]))</span></code></pre>
</figure>
<p>
<img src="http://dfalbel.github.io/images/2017-01-07-udacity-deep-learning-01/unnamed-chunk-2-1.png" alt="plot of chunk unnamed-chunk-2">
</p>
<p>
Ok, aparentemente está correto. As imagens estão da forma esperada.
</p>
<h2 id="transformar-os-dados-para-anlise">
Transformar os dados para análise
</h2>
<p>
O próximo problema era deixar o banco de dados em um formato melhor para
a análise. Como são muitas imagens, cerca de 52.000 por letra. Vamos
pegar uma amostra de 10.000 imagens de cada classe possível e
transformar em um banco de dados.
</p>
<p>
Vamos usar o formato de array multidimensional do R. Eu,
particularmente, nunca tinha utilizado esse formato de dados do R, na
maioria das vezes usei
<code class="highlighter-rouge">data.frame</code>s ou
<code class="highlighter-rouge">matrix</code>s mas como neste caso, os
dados são imagens, faz mais sentido representá-los dessa forma.
</p>
<p>
Note que criamos a função
<code class="highlighter-rouge">pre\_process</code> que deixa a imagem
na forma que queremos guardá-la no R. Como algumas imagens estão com
problema e não podem ser lidas, fizemos com que essa função fosse
tolerante a erros usando a função
<code class="highlighter-rouge">failwith</code>.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">set.seed</span><span class="p">(</span><span class="m">88320</span><span class="p">)</span><span class="w"> </span><span class="n">train_files</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="s1">&apos;notMNIST_large/&apos;</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">list.dirs</span><span class="p">(</span><span class="n">full.names</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">TRUE</span><span class="p">,</span><span class="w"> </span><span class="n">recursive</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">FALSE</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">map</span><span class="p">(</span><span class="o">~</span><span class="n">list.files</span><span class="p">(</span><span class="n">.x</span><span class="p">,</span><span class="w"> </span><span class="n">full.names</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">TRUE</span><span class="p">,</span><span class="w"> </span><span class="n">recursive</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">FALSE</span><span class="p">))</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">map</span><span class="p">(</span><span class="o">~</span><span class="n">sample</span><span class="p">(</span><span class="n">.x</span><span class="p">,</span><span class="w"> </span><span class="m">10000</span><span class="p">))</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">unlist</span><span class="p">()</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">setNames</span><span class="p">(</span><span class="n">stringr</span><span class="o">::</span><span class="n">str_sub</span><span class="p">(</span><span class="n">.</span><span class="p">,</span><span class="w"> </span><span class="m">17</span><span class="p">,</span><span class="w"> </span><span class="m">17</span><span class="p">))</span><span class="w"> </span><span class="n">test_files</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="s1">&apos;notMNIST_small/&apos;</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">list.dirs</span><span class="p">(</span><span class="n">full.names</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">TRUE</span><span class="p">,</span><span class="w"> </span><span class="n">recursive</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">FALSE</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">map</span><span class="p">(</span><span class="o">~</span><span class="n">list.files</span><span class="p">(</span><span class="n">.x</span><span class="p">,</span><span class="w"> </span><span class="n">full.names</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">TRUE</span><span class="p">,</span><span class="w"> </span><span class="n">recursive</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">FALSE</span><span class="p">))</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">unlist</span><span class="p">()</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">setNames</span><span class="p">(</span><span class="n">stringr</span><span class="o">::</span><span class="n">str_sub</span><span class="p">(</span><span class="n">.</span><span class="p">,</span><span class="w"> </span><span class="m">17</span><span class="p">,</span><span class="w"> </span><span class="m">17</span><span class="p">))</span><span class="w"> </span><span class="n">pre_process</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">.</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">map</span><span class="p">(</span><span class="n">plyr</span><span class="o">::</span><span class="n">failwith</span><span class="p">(</span><span class="kc">NULL</span><span class="p">,</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">x</span><span class="p">)</span><span class="w"> </span><span class="p">{</span><span class="w"> </span><span class="n">x</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">x</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">image_read</span><span class="p">()</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">as.raster</span><span class="p">()</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">apply</span><span class="p">(</span><span class="nf">c</span><span class="p">(</span><span class="m">1</span><span class="p">,</span><span class="m">2</span><span class="p">),</span><span class="w"> </span><span class="n">col2rgb</span><span class="p">)</span><span class="w"> </span><span class="n">x</span><span class="p">[</span><span class="m">1</span><span class="p">,,,</span><span class="n">drop</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">FALSE</span><span class="p">]</span><span class="w"> </span><span class="p">}))</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">abind</span><span class="o">::</span><span class="n">abind</span><span class="p">(</span><span class="n">along</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">1</span><span class="p">)</span><span class="w"> </span><span class="n">train_data</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">pre_process</span><span class="p">(</span><span class="n">train_files</span><span class="p">)</span><span class="w">
</span><span class="n">test_data</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">pre_process</span><span class="p">(</span><span class="n">test_files</span><span class="p">)</span><span class="w"> </span><span class="n">saveRDS</span><span class="p">(</span><span class="n">train_data</span><span class="p">,</span><span class="w"> </span><span class="s1">&apos;train_dataset.rds&apos;</span><span class="p">)</span><span class="w">
</span><span class="n">saveRDS</span><span class="p">(</span><span class="n">test_data</span><span class="p">,</span><span class="w"> </span><span class="s1">&apos;test_dataset.rds&apos;</span><span class="p">)</span></code></pre>
</figure>
<p>
Esse trecho de código leva cerca de 2h para terminar de rodar no meu
computador (MacBook Air 4GB RAM). Se no seu computador não rodar, você
sempre pode diminuir o tamanho da amostra utilizada.
</p>
<p>
No final desse processo você terá dois arquivos
<code class="highlighter-rouge">.rds</code>. Cada um deles é um array
3-dimensional. As labels estão guardadas nas dimensões do array.
</p>
<p>
Vamos verificar que os dados foram transformados corretamente. Para isso
vamos plotar uma amostra das imagens.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">amostra</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">sample</span><span class="p">(</span><span class="m">1</span><span class="o">:</span><span class="nf">dim</span><span class="p">(</span><span class="n">train_data</span><span class="p">)[</span><span class="m">1</span><span class="p">],</span><span class="w"> </span><span class="n">size</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">10</span><span class="p">)</span><span class="w"> </span><span class="n">amostra</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">train_data</span><span class="p">[</span><span class="n">amostra</span><span class="p">,,]</span><span class="w"> </span><span class="n">par</span><span class="p">(</span><span class="n">mfrow</span><span class="o">=</span><span class="nf">c</span><span class="p">(</span><span class="m">5</span><span class="p">,</span><span class="m">2</span><span class="p">),</span><span class="w"> </span><span class="n">mar</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">rep</span><span class="p">(</span><span class="m">0</span><span class="p">,</span><span class="w"> </span><span class="m">4</span><span class="p">))</span><span class="w">
</span><span class="k">for</span><span class="p">(</span><span class="n">i</span><span class="w"> </span><span class="k">in</span><span class="w"> </span><span class="m">1</span><span class="o">:</span><span class="m">10</span><span class="p">)</span><span class="w"> </span><span class="n">plot</span><span class="p">(</span><span class="n">as.raster</span><span class="p">(</span><span class="n">amostra</span><span class="p">[</span><span class="n">i</span><span class="p">,,]</span><span class="o">/</span><span class="m">255</span><span class="p">))</span></code></pre>
</figure>
<p>
<img src="http://dfalbel.github.io/images/2017-01-07-udacity-deep-learning-01/unnamed-chunk-5-1.png" alt="plot of chunk unnamed-chunk-5">
</p>
<p>
Também vamos verificar a distribuição das letras, ver se temos maisou
menos a mesma quantidade de cada uma, tanto na base de testes como da na
de treino.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">table</span><span class="p">(</span><span class="nf">dimnames</span><span class="p">(</span><span class="n">train_data</span><span class="p">)[[</span><span class="m">1</span><span class="p">]])</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## ## A B C D E F G H I J ## 9998 10000 10000 10000 10000 10000 10000 10000 10000 10000</code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-r"><span class="n">table</span><span class="p">(</span><span class="nf">dimnames</span><span class="p">(</span><span class="n">test_data</span><span class="p">)[[</span><span class="m">1</span><span class="p">]])</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## ## A B C D E F G H I J ## 1872 1873 1873 1873 1873 1872 1872 1872 1872 1872</code></pre>
</figure>
<p>
Ok. Tudo parece correto.
</p>
<p>
Por considerações a respeito de otimização, é melhor que os valores das
matrizes estejam entre -1 e 1 ao invés de 0 a 255 como é a forma gerada
pelo R.
</p>
<p>
Para fazer a conversão usamos a função uma função bem simples.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">train_data</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="p">(</span><span class="n">train_data</span><span class="w"> </span><span class="o">-</span><span class="w"> </span><span class="p">(</span><span class="m">255</span><span class="o">/</span><span class="m">2</span><span class="p">))</span><span class="o">/</span><span class="p">(</span><span class="m">255</span><span class="o">/</span><span class="m">2</span><span class="p">)</span><span class="w">
</span><span class="n">test_data</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="p">(</span><span class="n">test_data</span><span class="w"> </span><span class="o">-</span><span class="w"> </span><span class="p">(</span><span class="m">255</span><span class="o">/</span><span class="m">2</span><span class="p">))</span><span class="o">/</span><span class="p">(</span><span class="m">255</span><span class="o">/</span><span class="m">2</span><span class="p">)</span></code></pre>
</figure>
<h2 id="ajuste-um-off-the-shelf-classifier">
Ajuste um off-the-shelf classifier
</h2>
<p>
Neste exercício o objetivo era treinar um classificador
<em>off-the-shelf</em>. Resolvi utilizar o
<code class="highlighter-rouge">xgboost</code> (Gradient Boosted Trees),
pois estudei essa técnica a pouco tempo e ela é fácil de utilizar, e não
é necessário alterar os parâmetros para obter um resultado satisfatório.
</p>
<p>
Em primeiro lugar, como o <code class="highlighter-rouge">xgboost</code>
precisa de uma matriz, vamos transformar os nossos dados de um array
3-dimensional para uma matriz. Basicamente vamos representar cada um dos
784 pixels por uma coluna diferente. As classes precisam ser passadas ao
algoritmo em um vetor numérico de 0 ao número de categorias.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="c1"># Tranformar em matriz
</span><span class="n">train_x</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">t</span><span class="p">(</span><span class="n">apply</span><span class="p">(</span><span class="n">train_data</span><span class="p">,</span><span class="w"> </span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="n">c</span><span class="p">))</span><span class="w">
</span><span class="n">train_y</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="nf">as.numeric</span><span class="p">(</span><span class="n">as.factor</span><span class="p">(</span><span class="nf">dimnames</span><span class="p">(</span><span class="n">train_data</span><span class="p">)[[</span><span class="m">1</span><span class="p">]]))</span><span class="w"> </span><span class="o">-</span><span class="w"> </span><span class="m">1</span><span class="w"> </span><span class="n">test_x</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">t</span><span class="p">(</span><span class="n">apply</span><span class="p">(</span><span class="n">test_data</span><span class="p">,</span><span class="w"> </span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="n">c</span><span class="p">))</span><span class="w">
</span><span class="n">test_y</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="nf">as.numeric</span><span class="p">(</span><span class="n">as.factor</span><span class="p">(</span><span class="nf">dimnames</span><span class="p">(</span><span class="n">test_data</span><span class="p">)[[</span><span class="m">1</span><span class="p">]]))</span><span class="w"> </span><span class="o">-</span><span class="w"> </span><span class="m">1</span></code></pre>
</figure>
<p>
Agora o treino do algoritmo. O único parâmetro que alterei foi o número
de iterações para que não demorasse muito para treinar.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">library</span><span class="p">(</span><span class="n">xgboost</span><span class="p">)</span><span class="w">
</span><span class="n">xg</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">xgboost</span><span class="p">(</span><span class="n">data</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">train_x</span><span class="p">,</span><span class="w"> </span><span class="n">label</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">train_y</span><span class="p">,</span><span class="w"> </span><span class="n">nrounds</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">10</span><span class="p">,</span><span class="w"> </span><span class="n">objective</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s1">&apos;multi:softmax&apos;</span><span class="p">,</span><span class="w"> </span><span class="n">num_class</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">10</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-r"><span class="c1"># Accuracy Train
</span><span class="n">train_pred</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">predict</span><span class="p">(</span><span class="n">xg</span><span class="p">,</span><span class="w"> </span><span class="n">newdata</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">train_x</span><span class="p">)</span><span class="w">
</span><span class="nf">sum</span><span class="p">(</span><span class="n">train_pred</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="n">train_y</span><span class="p">)</span><span class="o">/</span><span class="nf">length</span><span class="p">(</span><span class="n">train_y</span><span class="p">)</span><span class="w"> </span><span class="c1"># Accuracy Test
</span><span class="n">test_pred</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">predict</span><span class="p">(</span><span class="n">xg</span><span class="p">,</span><span class="w"> </span><span class="n">newdata</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">test_x</span><span class="p">)</span><span class="w">
</span><span class="nf">sum</span><span class="p">(</span><span class="n">test_pred</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="n">test_y</span><span class="p">)</span><span class="o">/</span><span class="nf">length</span><span class="p">(</span><span class="n">test_y</span><span class="p">)</span></code></pre>
</figure>
<p>
Com esse algoritmo obtive o seguinte resultado:
</p>
<ul>
<li>
Acerto na base de treino: 88,45%
</li>
<li>
Acerto na base de teste: 91,87%
</li>
</ul>
<p>
Nos próximos posts, vamos ajustar modelos mais complexos que terão
acerto superior ao obtido aqui. No entanto, note que o acerto aqui já
foi bem satisfatório! 90% das imagens estão sendo classificadas
corretamente!
</p>
</article>

