+++
title = "INTRODUÇÃO AO R - Aula 4"
date = "2016-10-04 03:00:00"
categories = ["r-python-e-redes"]
original_url = "http://neylsoncrepalde.github.io/2016-10-04-introducao-ao-r-aula4/"
+++

<article class="blog-post">
<p>
A programação de funções marca a passagem do usuário para o
desenvolvedor de R. As funções podem ser bastante úteis na automatização
de tarefas e na implamentação de novas análises. Funções são escritas no
R com a seguinte sintaxe:
</p>
<pre class="highlight"><code><span class="n">nome_da_funcao</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">argumentos</span><span class="p">){</span><span class="w"> </span><span class="n">acoes_a_serem_executadas</span><span class="w"> </span><span class="nf">return</span><span class="p">(</span><span class="n">valor_final_retornado</span><span class="p">)</span><span class="w">
</span><span class="p">}</span><span class="w">
</span></code></pre>

<p>
As funções possuem classe própria (class <em>function</em>) e podem ser
executadas de forma aninhada. Vamos programar uma função que calcula a
média e retorna uma frase legal na apresentação.
</p>
<pre class="highlight"><code><span class="n">media</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">x</span><span class="p">){</span><span class="w"> </span><span class="n">cat</span><span class="p">(</span><span class="s2">&quot;Fun&#xE7;&#xE3;o legal de m&#xE9;dia\n&quot;</span><span class="p">)</span><span class="w"> </span><span class="n">med</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">sum</span><span class="p">(</span><span class="n">x</span><span class="p">)</span><span class="o">/</span><span class="nf">length</span><span class="p">(</span><span class="n">x</span><span class="p">)</span><span class="w"> </span><span class="nf">return</span><span class="p">(</span><span class="n">med</span><span class="p">)</span><span class="w">
</span><span class="p">}</span><span class="w">
</span></code></pre>

<p>
Vamos ver se funciona?
</p>
<pre class="highlight"><code><span class="n">vetor</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="m">1</span><span class="p">,</span><span class="m">5</span><span class="p">,</span><span class="m">4</span><span class="p">,</span><span class="m">7</span><span class="p">,</span><span class="m">6</span><span class="p">,</span><span class="m">4</span><span class="p">,</span><span class="m">22</span><span class="p">,</span><span class="m">4</span><span class="p">,</span><span class="m">33</span><span class="p">,</span><span class="m">678</span><span class="p">,</span><span class="m">8.665</span><span class="p">,</span><span class="m">3</span><span class="p">)</span><span class="w">
</span><span class="n">media</span><span class="p">(</span><span class="n">vetor</span><span class="p">)</span><span class="w">
</span></code></pre>

<pre class="highlight"><code>## Fun&#xE7;&#xE3;o legal de m&#xE9;dia ## [1] 64.63875
</code></pre>

<p>
Vamos agora programar uma função de desvio padrão.
</p>
<pre class="highlight"><code><span class="n">desvio_pad</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">vetor</span><span class="p">,</span><span class="w"> </span><span class="n">na.rm</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">TRUE</span><span class="p">){</span><span class="w"> </span><span class="n">cat</span><span class="p">(</span><span class="s2">&quot;Fun&#xE7;&#xE3;o legal de Desvio Padr&#xE3;o\n&quot;</span><span class="p">)</span><span class="w"> </span><span class="k">if</span><span class="w"> </span><span class="p">(</span><span class="n">na.rm</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="kc">TRUE</span><span class="p">){</span><span class="w"> </span><span class="n">vetor</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">vetor</span><span class="p">[</span><span class="o">!</span><span class="nf">is.na</span><span class="p">(</span><span class="n">vetor</span><span class="p">)]</span><span class="w"> </span><span class="p">}</span><span class="w"> </span><span class="n">n</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">length</span><span class="p">(</span><span class="n">vetor</span><span class="p">)</span><span class="w"> </span><span class="n">med</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">sum</span><span class="p">(</span><span class="n">vetor</span><span class="p">)</span><span class="o">/</span><span class="n">n</span><span class="w"> </span><span class="n">desv</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">vetor</span><span class="w"> </span><span class="o">-</span><span class="w"> </span><span class="n">med</span><span class="w"> </span><span class="n">desv2</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">desv</span><span class="o">^</span><span class="m">2</span><span class="w"> </span><span class="n">desv.p</span><span class="o">=</span><span class="w"> </span><span class="nf">sqrt</span><span class="p">(</span><span class="nf">sum</span><span class="p">(</span><span class="n">desv2</span><span class="o">/</span><span class="p">(</span><span class="n">n</span><span class="w"> </span><span class="o">-</span><span class="w"> </span><span class="m">1</span><span class="p">)))</span><span class="w"> </span><span class="nf">return</span><span class="p">(</span><span class="n">desv.p</span><span class="p">)</span><span class="w">
</span><span class="p">}</span><span class="w">
</span></code></pre>

<p>
Vamos testar:
</p>
<pre class="highlight"><code><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">rnorm</span><span class="p">(</span><span class="m">20</span><span class="p">)</span><span class="w">
</span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="n">x</span><span class="p">,</span><span class="w"> </span><span class="kc">NA</span><span class="p">)</span><span class="w">
</span><span class="n">desvio_pad</span><span class="p">(</span><span class="n">x</span><span class="p">)</span><span class="w">
</span></code></pre>

<pre class="highlight"><code>## Fun&#xE7;&#xE3;o legal de Desvio Padr&#xE3;o ## [1] 1.076367
</code></pre>

<p>
Como exercício, vamos programar a sequência de Fibonacci usando apenas
um for loop e gerando um vetor de tamanho 10:
</p>
<pre class="highlight"><code><span class="n">fib</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="m">1</span><span class="p">,</span><span class="m">1</span><span class="p">)</span><span class="w">
</span><span class="k">for</span><span class="w"> </span><span class="p">(</span><span class="n">i</span><span class="w"> </span><span class="k">in</span><span class="w"> </span><span class="m">3</span><span class="o">:</span><span class="m">10</span><span class="p">){</span><span class="w"> </span><span class="n">fib</span><span class="p">[</span><span class="n">i</span><span class="p">]</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">fib</span><span class="p">[</span><span class="n">i</span><span class="m">-1</span><span class="p">]</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">fib</span><span class="p">[</span><span class="n">i</span><span class="m">-2</span><span class="p">]</span><span class="w">
</span><span class="p">}</span><span class="w">
</span><span class="n">fib</span><span class="w">
</span></code></pre>

<pre class="highlight"><code>## [1] 1 1 2 3 5 8 13 21 34 55
</code></pre>

<p>
Agora vamos colocar a sequência numa função em que possamos dar como
argumento o tamanho do vetor que desejamos que seja criado.
</p>
<pre class="highlight"><code><span class="n">fibonacci</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">x</span><span class="p">){</span><span class="w">
</span><span class="n">fib</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="m">1</span><span class="p">,</span><span class="m">1</span><span class="p">)</span><span class="w">
</span><span class="k">for</span><span class="w"> </span><span class="p">(</span><span class="n">i</span><span class="w"> </span><span class="k">in</span><span class="w"> </span><span class="m">3</span><span class="o">:</span><span class="n">x</span><span class="p">){</span><span class="w"> </span><span class="n">fib</span><span class="p">[</span><span class="n">i</span><span class="p">]</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">fib</span><span class="p">[</span><span class="n">i</span><span class="m">-1</span><span class="p">]</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">fib</span><span class="p">[</span><span class="n">i</span><span class="m">-2</span><span class="p">]</span><span class="w">
</span><span class="p">}</span><span class="w">
</span><span class="nf">return</span><span class="p">(</span><span class="n">fib</span><span class="p">)</span><span class="w">
</span><span class="p">}</span><span class="w"> </span><span class="n">fibonacci</span><span class="p">(</span><span class="m">10</span><span class="p">)</span><span class="w">
</span></code></pre>

<pre class="highlight"><code>## [1] 1 1 2 3 5 8 13 21 34 55
</code></pre>

<pre class="highlight"><code>## [1] 1 1 2 3 5 8 13 21 34 55 89 144 233 377
## [15] 610 987 1597 2584 4181 6765
</code></pre>

<h2 id="análise-de-redes-sociais">
Análise de Redes Sociais
</h2>
<p>
Num curso ministrado por um membro do
<a href="http://www.giars.ufmg.br/">GIARS</a> não poderia faltar uma
seção introdutória sobre análise de redes!
</p>
<p>
Veja como o R executa bem funções de estudos em redes:
</p>
<pre class="highlight"><code><span class="n">library</span><span class="p">(</span><span class="n">igraph</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">sand</span><span class="p">)</span><span class="w">
</span><span class="n">lazega</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">upgrade_graph</span><span class="p">(</span><span class="n">lazega</span><span class="p">)</span><span class="w">
</span><span class="n">plot</span><span class="p">(</span><span class="n">lazega</span><span class="p">,</span><span class="w"> </span><span class="n">vertex.size</span><span class="o">=</span><span class="m">12</span><span class="p">,</span><span class="w"> </span><span class="n">vertex.color</span><span class="o">=</span><span class="s2">&quot;red&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">edge.arrow.size</span><span class="o">=</span><span class="m">.3</span><span class="p">,</span><span class="w"> </span><span class="n">vertex.label.color</span><span class="o">=</span><span class="s2">&quot;black&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">main</span><span class="o">=</span><span class="s2">&quot;Lazega&apos;s lawyers&quot;</span><span class="p">)</span><span class="w">
</span></code></pre>

<p>
<img src="http://neylsoncrepalde.github.io/img/intro_r_aula4_files/figure-markdown_github/unnamed-chunk-8-1.png" alt="">
</p>
<h3 id="segue-no-post-workshop-r-e-redes-01">
Segue no post
<a href="http://neylsoncrepalde.github.io/2016-04-23-workshop-r-e-redes-01/">Workshop
R e Redes 01</a>.
</h3>
</article>
<p class="blog-tags">
Tags: R programming, rstats
</p>

