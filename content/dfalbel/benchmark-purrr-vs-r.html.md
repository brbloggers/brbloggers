+++
title = "Benchmark do pacote purrr e funções naturais do base R"
date = "2015-10-20"
categories = ["dfalbel"]
original_url = "http://dfalbel.github.io/2015/10/benchmark-purrr-vs-r.html"
+++

<article class="post-content">
<p>
No mês passado o Hadley fez o lançamento de uma nova versão do pacote
<code class="highlighter-rouge">purrr</code>, este pacote tem como
objetivo completar a interface de programação funcional do R. Desta
forma, tudo que o <code class="highlighter-rouge">purrr</code> faz,
também pode ser feito usando o
<code class="highlighter-rouge">base</code> R, porém com um código muito
maior. Surgiu, então, a pergunta: o que é mais rápido?
<code class="highlighter-rouge">purrr</code> ou
<code class="highlighter-rouge">base</code>?
</p>
<p>
Antes de ver os resultados, vale ressaltar que este é apenas um teste de
velocidade. Tão, ou mais importante do que a velocidade está leitura do
código e a consistência da interface. Então não use isso para aprender
um ou outro jeito de fazer.
</p>
<p>
No teste vamos usar os seguintes pacotes:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">library</span><span class="p">(</span><span class="n">microbenchmark</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">purrr</span><span class="p">)</span></code></pre>
</figure>
<h2 id="map">
Map
</h2>
<figure class="highlight">
<pre><code class="language-r"><span class="n">vetor</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="m">1</span><span class="o">:</span><span class="m">100</span><span class="w">
</span><span class="n">microbenchmark</span><span class="p">(</span><span class="w"> </span><span class="n">purr</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">map</span><span class="p">(</span><span class="n">vetor</span><span class="p">,</span><span class="w"> </span><span class="n">sqrt</span><span class="p">),</span><span class="w"> </span><span class="n">base_lapply</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">lapply</span><span class="p">(</span><span class="n">vetor</span><span class="p">,</span><span class="w"> </span><span class="n">sqrt</span><span class="p">),</span><span class="w"> </span><span class="n">base_funprog</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">Map</span><span class="p">(</span><span class="n">sqrt</span><span class="p">,</span><span class="w"> </span><span class="n">vetor</span><span class="p">)</span><span class="w">
</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## Unit: microseconds
## expr min lq mean median uq max
## purr 115.347 132.8405 230.65570 152.1910 255.8315 3696.554
## base_lapply 36.571 42.7445 57.57207 48.9665 65.7170 135.173
## base_funprog 48.345 58.3950 112.11341 66.4450 89.3160 3045.689
## neval
## 100
## 100
## 100</code></pre>
</figure>
<p>
Observamos que nesta operação, os dois métodos usando as funções
<code class="highlighter-rouge">base</code> tiveram resultados parecidos
(apesar do <code class="highlighter-rouge">lapply</code> ser um pouco
mais rápido), o <code class="highlighter-rouge">purrr::map</code> teve
velocidade um pouco menos que 4x pior.
</p>
<p>
Abaixo está a verificação de que as três formas retornam exatamente o
mesmo resultado.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">purr</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">map</span><span class="p">(</span><span class="n">vetor</span><span class="p">,</span><span class="w"> </span><span class="n">sqrt</span><span class="p">)</span><span class="w">
</span><span class="n">base_lapply</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">lapply</span><span class="p">(</span><span class="n">vetor</span><span class="p">,</span><span class="w"> </span><span class="n">sqrt</span><span class="p">)</span><span class="w">
</span><span class="n">base_funprog</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">Map</span><span class="p">(</span><span class="n">sqrt</span><span class="p">,</span><span class="w"> </span><span class="n">vetor</span><span class="p">)</span><span class="w"> </span><span class="n">identical</span><span class="p">(</span><span class="n">purr</span><span class="p">,</span><span class="w"> </span><span class="n">base_lapply</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## [1] TRUE</code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-r"><span class="n">identical</span><span class="p">(</span><span class="n">purr</span><span class="p">,</span><span class="w"> </span><span class="n">base_funprog</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## [1] TRUE</code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-r"><span class="n">identical</span><span class="p">(</span><span class="n">base_lapply</span><span class="p">,</span><span class="w"> </span><span class="n">base_funprog</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## [1] TRUE</code></pre>
</figure>
<p>
Agora vamos comparar <code class="highlighter-rouge">base</code> e
<code class="highlighter-rouge">purrr</code> quando simplificamos os
resultados para um vetor de números.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">microbenchmark</span><span class="p">(</span><span class="w"> </span><span class="n">purr</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">map_dbl</span><span class="p">(</span><span class="n">vetor</span><span class="p">,</span><span class="w"> </span><span class="n">sqrt</span><span class="p">),</span><span class="w"> </span><span class="n">base_lapply</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">unlist</span><span class="p">(</span><span class="n">lapply</span><span class="p">(</span><span class="n">vetor</span><span class="p">,</span><span class="w"> </span><span class="n">sqrt</span><span class="p">)),</span><span class="w"> </span><span class="n">base_sqrt</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">sqrt</span><span class="p">(</span><span class="n">vetor</span><span class="p">)</span><span class="w">
</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## Unit: nanoseconds
## expr min lq mean median uq max neval
## purr 35795 37453.5 44759.95 39774.0 46158.5 97679 100
## base_lapply 36232 37285.5 42635.48 38486.0 46114.5 99180 100
## base_sqrt 619 665.0 791.23 729.5 809.0 2065 100</code></pre>
</figure>
<p>
Veja então que ao usar a versão
<code class="highlighter-rouge">map\_dbl</code> que simplifica os
resultados para um vetor numérico do R, a versão usando
<code class="highlighter-rouge">lapply</code> e usando o
<code class="highlighter-rouge">purrr</code> tornam-se equivalentes.
</p>
<p>
Obviamente, a versão vetorizada de
<code class="highlighter-rouge">sqrt</code> é muito mais rápida.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">purr</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">map_dbl</span><span class="p">(</span><span class="n">vetor</span><span class="p">,</span><span class="w"> </span><span class="n">sqrt</span><span class="p">)</span><span class="w">
</span><span class="n">base_lapply</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">unlist</span><span class="p">(</span><span class="n">lapply</span><span class="p">(</span><span class="n">vetor</span><span class="p">,</span><span class="w"> </span><span class="n">sqrt</span><span class="p">))</span><span class="w">
</span><span class="n">base_sqrt</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="nf">sqrt</span><span class="p">(</span><span class="n">vetor</span><span class="p">)</span><span class="w">
</span><span class="n">identical</span><span class="p">(</span><span class="n">purr</span><span class="p">,</span><span class="w"> </span><span class="n">base_lapply</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## [1] TRUE</code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-r"><span class="n">identical</span><span class="p">(</span><span class="n">purr</span><span class="p">,</span><span class="w"> </span><span class="n">base_sqrt</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## [1] TRUE</code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-r"><span class="n">identical</span><span class="p">(</span><span class="n">base_lapply</span><span class="p">,</span><span class="w"> </span><span class="n">base_sqrt</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## [1] TRUE</code></pre>
</figure>
<p>
Enfim, concluí que usando
<code class="highlighter-rouge">purr::map</code>, sabendo qual é a
classe do objeto retornado conseguimos praticamente a mesma performance
do <code class="highlighter-rouge">base</code>.
</p>
<h2 id="reduce">
Reduce
</h2>
<p>
Reduce aplica uma função binária recursivamente por um vetor ou lista.
Um exemplo simples de uso pode ser encontrar a soma de todos elementos
de um vetor. Faremos aqui então de duas maneiras: usando o
<code class="highlighter-rouge">base::Reduce</code> e o
<code class="highlighter-rouge">purrr::reduce</code>.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">vetor</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="m">1</span><span class="o">:</span><span class="m">100</span><span class="w">
</span><span class="n">microbenchmark</span><span class="p">(</span><span class="w"> </span><span class="n">base</span><span class="o">::</span><span class="n">Reduce</span><span class="p">(</span><span class="n">sum</span><span class="p">,</span><span class="w"> </span><span class="n">vetor</span><span class="p">),</span><span class="w"> </span><span class="n">purrr</span><span class="o">::</span><span class="n">reduce</span><span class="p">(</span><span class="n">vetor</span><span class="p">,</span><span class="w"> </span><span class="n">sum</span><span class="p">)</span><span class="w">
</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## Unit: microseconds
## expr min lq mean median
## base::Reduce(sum, vetor) 67.078 74.762 93.57927 79.3760
## purrr::reduce(vetor, sum) 116.191 121.019 193.58939 133.1125
## uq max neval
## 96.6310 221.952 100
## 184.9765 1651.187 100</code></pre>
</figure>
<p>
Veja que neste caso o
<code class="highlighter-rouge">purrr::reduce</code> foi um menos de 2x
mais lento.
</p>
<p>
Vejamos um exemplo um pouco mais complexo em que temos uma lista de
vetores numéricos e queremos encontrar os valores que aparecem em todas
os vetores.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">l</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">replicate</span><span class="p">(</span><span class="m">5</span><span class="p">,</span><span class="w"> </span><span class="n">sample</span><span class="p">(</span><span class="m">1</span><span class="o">:</span><span class="m">10</span><span class="p">,</span><span class="w"> </span><span class="m">15</span><span class="p">,</span><span class="w"> </span><span class="n">replace</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nb">T</span><span class="p">),</span><span class="w"> </span><span class="n">simplify</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">FALSE</span><span class="p">)</span><span class="w">
</span><span class="n">str</span><span class="p">(</span><span class="n">l</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## List of 5
## $ : int [1:15] 6 10 7 3 2 6 1 7 7 3 ...
## $ : int [1:15] 1 1 7 6 4 6 9 2 4 3 ...
## $ : int [1:15] 4 10 7 5 2 5 2 4 7 3 ...
## $ : int [1:15] 4 3 6 10 3 3 3 4 4 5 ...
## $ : int [1:15] 4 4 7 5 8 3 9 1 6 2 ...</code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-r"><span class="n">microbenchmark</span><span class="p">(</span><span class="w"> </span><span class="n">base</span><span class="o">::</span><span class="n">Reduce</span><span class="p">(</span><span class="n">intersect</span><span class="p">,</span><span class="w"> </span><span class="n">l</span><span class="p">),</span><span class="w"> </span><span class="n">purrr</span><span class="o">::</span><span class="n">reduce</span><span class="p">(</span><span class="n">l</span><span class="p">,</span><span class="w"> </span><span class="n">intersect</span><span class="p">)</span><span class="w">
</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## Unit: microseconds
## expr min lq mean median uq
## base::Reduce(intersect, l) 43.076 44.7460 49.44164 45.8995 54.1695
## purrr::reduce(l, intersect) 49.104 50.7265 56.60058 51.8865 61.2550
## max neval
## 138.075 100
## 156.936 100</code></pre>
</figure>
<p>
Note que agora a performance das duas abordagens fica muito parecida, o
<code class="highlighter-rouge">purrr</code> sendo muito pouco mais
lento.
</p>
<h2 id="concluso">
Conclusão
</h2>
<p>
Ainda não comparei todas as funções do
<code class="highlighter-rouge">purrr</code> com as funções equivalentes
do <code class="highlighter-rouge">base</code>, mas o que deu para
perceber é que para operações muito simples o
<code class="highlighter-rouge">base</code> se sai melhor. No entanto,
quando as operações são mais complexas, as duas abordagens tornam-se
equivalentes em termos de velocidade.
</p>
</article>

