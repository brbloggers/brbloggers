+++
title = "Escrevendo um pequeno sistema de computação simbólica em R (Parte 2/4)"
date = "2017-05-20 00:38:00"
categories = ["lurodrigo"]
original_url = "https://lurodrigo.github.io/2017/05/computacao-simbolica-R-2-4"
+++

<p class="page__inner-wrap">
<header>
<p class="page__meta">
<i class="fa fa-clock-o"></i> 19 minutos de leitura
</p>
</header>
<section class="page__content">
<p>
<em>An english version of this post is available
<a href="http://lurodrigo.com/2017/05/symbolic-computation-R-2-4/">here</a>.</em>
</p>
<p>
No post de hoje irei mostrar como estender a pequena linguagem
desenvolvida no post anterior para que possamos definir novas funções a
partir das existentes usando somas, produtos e composições.
</p>
<p>
Como ponto de partida, é útil pegar o código como foi finalizado no
último post. Ele está disponível
<a href="https://github.com/lurodrigo/symbolic/blob/master/R/symbolic_01.R">aqui</a>.
</p>
<h2 id="definindo-soma-e-produto">
Definindo soma e produto
</h2>
<p>
Os operadores <code class="highlighter-rouge">+</code> e
<code class="highlighter-rouge">\*</code> são funções genéricas. Isso
significa que podemos definir como eles devem funcionar quando os
operandos são de uma classe que definimos. No nosso caso, podemos
definir métodos para esses operadores quando aplicados em argumentos do
tipo <code class="highlighter-rouge">symbolic</code>. Isso permite que
manipulemos nossas funções com a mesma naturalidade com que manipulamos
vetores.
</p>
<p>
Sabendo disso, podemos definir o primeiro rascunho do método para somar
funções. Já é possível implementar, também, uma simplificação: quando um
dos operandos for nulo, retornamos o outro operando. Também é fácil
implementar uma conveniência: quando um operando for um valor numérico,
podemos convertê-lo a uma função constante do nosso sistema. Desse modo,
podemos evitar algumas chamadas desnecessárias a
<code class="highlighter-rouge">Const()</code>.
</p>
<pre class="highlight"><code><span class="c1"># adicionei a compara&#xE7;&#xE3;o is_symbolic(x) nas fun&#xE7;&#xF5;es is_{tipo}() para evitar
# erros no caso em que o objeto sequer &#xE9; da classe symbolic
</span><span class="n">is_nullf</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">x</span><span class="p">)</span><span class="w"> </span><span class="n">is_symbolic</span><span class="p">(</span><span class="n">x</span><span class="p">)</span><span class="w"> </span><span class="o">&amp;&amp;</span><span class="w"> </span><span class="n">x</span><span class="o">%@%</span><span class="s2">&quot;type&quot;</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="s2">&quot;null&quot;</span><span class="w"> </span><span class="c1"># etc
</span><span class="w">
</span><span class="n">`+.symbolic`</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">f</span><span class="p">,</span><span class="w"> </span><span class="n">g</span><span class="p">)</span><span class="w"> </span><span class="p">{</span><span class="w"> </span><span class="c1"># checamos o tamanho do vetor porque, no caso em que n&#xE3;o &#xE9; um escalar,
</span><span class="w"> </span><span class="c1"># n&#xE3;o h&#xE1; uma ideia intuitiva do que deve ser feito
</span><span class="w"> </span><span class="k">if</span><span class="w"> </span><span class="p">(</span><span class="nf">is.numeric</span><span class="p">(</span><span class="n">f</span><span class="p">)</span><span class="w"> </span><span class="o">&amp;&amp;</span><span class="w"> </span><span class="nf">length</span><span class="p">(</span><span class="n">f</span><span class="p">)</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="m">1</span><span class="p">)</span><span class="w"> </span><span class="nf">return</span><span class="p">(</span><span class="n">Const</span><span class="p">(</span><span class="n">f</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">g</span><span class="p">)</span><span class="w"> </span><span class="k">if</span><span class="w"> </span><span class="p">(</span><span class="nf">is.numeric</span><span class="p">(</span><span class="n">g</span><span class="p">)</span><span class="w"> </span><span class="o">&amp;&amp;</span><span class="w"> </span><span class="nf">length</span><span class="p">(</span><span class="n">g</span><span class="p">)</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="m">1</span><span class="p">)</span><span class="w"> </span><span class="nf">return</span><span class="p">(</span><span class="n">f</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">Const</span><span class="p">(</span><span class="n">g</span><span class="p">))</span><span class="w"> </span><span class="k">if</span><span class="w"> </span><span class="p">(</span><span class="n">is_nullf</span><span class="p">(</span><span class="n">f</span><span class="p">))</span><span class="w"> </span><span class="nf">return</span><span class="p">(</span><span class="n">g</span><span class="p">)</span><span class="w"> </span><span class="k">if</span><span class="w"> </span><span class="p">(</span><span class="n">is_nullf</span><span class="p">(</span><span class="n">g</span><span class="p">))</span><span class="w"> </span><span class="nf">return</span><span class="p">(</span><span class="n">f</span><span class="p">)</span><span class="w"> </span><span class="n">symbolic</span><span class="p">(</span><span class="w"> </span><span class="n">f</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">x</span><span class="p">)</span><span class="w"> </span><span class="n">f</span><span class="p">(</span><span class="n">x</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">g</span><span class="p">(</span><span class="n">x</span><span class="p">),</span><span class="w"> </span><span class="n">repr</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">glue</span><span class="p">(</span><span class="s2">&quot;{f} + {g}&quot;</span><span class="p">),</span><span class="w"> </span><span class="n">df</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">D</span><span class="p">(</span><span class="n">f</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">D</span><span class="p">(</span><span class="n">g</span><span class="p">),</span><span class="w"> </span><span class="n">type</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;sum&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">params</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">list</span><span class="p">(</span><span class="n">f</span><span class="p">,</span><span class="w"> </span><span class="n">g</span><span class="p">)</span><span class="w"> </span><span class="p">)</span><span class="w">
</span><span class="p">}</span><span class="w">
</span></code></pre>

<pre class="highlight"><code><span class="n">Mono</span><span class="p">(</span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="m">2</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">Mono</span><span class="p">(</span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="m">1</span><span class="p">)</span><span class="w">
</span><span class="c1">#&gt; x -&gt; 1*x^2 + 1*x^1
</span><span class="n">D</span><span class="p">(</span><span class="n">Mono</span><span class="p">(</span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="m">2</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">Mono</span><span class="p">(</span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="m">1</span><span class="p">))</span><span class="w">
</span><span class="c1">#&gt; x -&gt; 2*x^1 + 1
</span><span class="n">Mono</span><span class="p">(</span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="m">2</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">Log</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="m">4</span><span class="w">
</span><span class="c1">#&gt; x -&gt; 1*x^2 + log(x) + 4
</span><span class="n">D</span><span class="p">(</span><span class="n">Mono</span><span class="p">(</span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="m">2</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">Log</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="m">4</span><span class="p">)</span><span class="w">
</span><span class="c1">#&gt; x -&gt; 2*x^1 + 1*x^-1
</span><span class="n">Mono</span><span class="p">(</span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="m">2</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="m">0</span><span class="w">
</span><span class="c1">#&gt; x -&gt; 1*x^2
</span><span class="m">3</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">Mono</span><span class="p">(</span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="m">1</span><span class="p">)</span><span class="w">
</span><span class="c1">#&gt; x -&gt; 3 + 1*x^1
</span><span class="m">0</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">Mono</span><span class="p">(</span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="m">2</span><span class="p">)</span><span class="w">
</span><span class="c1">#&gt; x -&gt; 1*x^2
</span></code></pre>

<p>
Observe a naturalidade com que criamos a função soma e a sua derivada. É
praticamente uma definição matemática :)
</p>
<p>
Uma conveniência interessante é criar um método
<code class="highlighter-rouge">Sum</code> para quando quisermos somar
uma lista de funções. Desse modo, podemos operá-las em cadeias
construídas com o operador
<code class="highlighter-rouge">%&gt;%</code>. Nem precisamos escrever
muito código para isso: basta usar a função
<code class="highlighter-rouge">reduce</code>, do pacote
<code class="highlighter-rouge">purrr</code>\[1\]. Nela, você passa uma
lista de argumentos e uma função com dois operandos. Ela aplica a
operação nos dois primeiros elementos da lista, guarda o resultado,
aplica com o terceiro elemento, e assim sucessivamente.
</p>
<pre class="highlight"><code><span class="n">Sum</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">l</span><span class="p">)</span><span class="w"> </span><span class="n">reduce</span><span class="p">(</span><span class="n">l</span><span class="p">,</span><span class="w"> </span><span class="n">`+.symbolic`</span><span class="p">)</span><span class="w">
</span></code></pre>

<pre class="highlight"><code><span class="n">Sum</span><span class="p">(</span><span class="nf">list</span><span class="p">(</span><span class="m">3</span><span class="p">,</span><span class="w"> </span><span class="n">Mono</span><span class="p">(</span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="m">2</span><span class="p">),</span><span class="w"> </span><span class="n">Log</span><span class="p">,</span><span class="w"> </span><span class="n">Exp</span><span class="p">))</span><span class="w">
</span><span class="c1">#&gt; x -&gt; 3 + 1*x^2 + log(x) + exp(x)
</span></code></pre>

<p>
Agora podemos definir com facilidade uma classe de funções importante:
polinômios. Polinômios são apenas somas de monômios, então não há grande
dificuldade em criar uma função auxiliar para criá-los. Usamos mais duas
funções auxiliares do pacote
<code class="highlighter-rouge">purrr</code>.
<code class="highlighter-rouge">as\_vector</code> converte uma lista em
um vetor, e <code class="highlighter-rouge">map2</code> é uma espécie de
<code class="highlighter-rouge">lapply</code> para funções com dois
parâmetros.
</p>
<pre class="highlight"><code><span class="n">Poly</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">...</span><span class="p">)</span><span class="w"> </span><span class="p">{</span><span class="w"> </span><span class="n">coef</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">as_vector</span><span class="p">(</span><span class="nf">list</span><span class="p">(</span><span class="n">...</span><span class="p">))</span><span class="w"> </span><span class="n">degree</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">length</span><span class="p">(</span><span class="n">coef</span><span class="p">)</span><span class="w"> </span><span class="o">-</span><span class="w"> </span><span class="m">1</span><span class="w"> </span><span class="n">map2</span><span class="p">(</span><span class="n">coef</span><span class="p">,</span><span class="w"> </span><span class="n">degree</span><span class="o">:</span><span class="m">0</span><span class="p">,</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">a</span><span class="p">,</span><span class="w"> </span><span class="n">n</span><span class="p">)</span><span class="w"> </span><span class="n">Mono</span><span class="p">(</span><span class="n">a</span><span class="p">,</span><span class="w"> </span><span class="n">n</span><span class="p">))</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">Sum</span><span class="w">
</span><span class="p">}</span><span class="w">
</span></code></pre>

<pre class="highlight"><code><span class="n">Poly</span><span class="p">(</span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="m">-5</span><span class="p">,</span><span class="w"> </span><span class="m">6</span><span class="p">)</span><span class="w">
</span><span class="c1">#&gt; x -&gt; 1*x^2 + -5*x^1 + 6
</span><span class="n">Poly</span><span class="p">(</span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="m">3</span><span class="p">,</span><span class="w"> </span><span class="m">3</span><span class="p">,</span><span class="w"> </span><span class="m">1</span><span class="p">)</span><span class="w">
</span><span class="c1">#&gt; x -&gt; 1*x^3 + 3*x^2 + 3*x^1 + 1
# as representa&#xE7;&#xF5;es est&#xE3;o claramente insatisfat&#xF3;rias, mas isso &#xE9; algo a ser
# resolvido no &#xFA;ltimo post da s&#xE9;rie
</span></code></pre>

<p>
Definir o produto é análogo a definir a soma. A diferença maior reside
no fato de que há duas simplificações elementares que podem ser feitas:
os casos onde um dos operandos é 0 ou 1.
</p>
<pre class="highlight"><code><span class="n">`*.symbolic`</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">f</span><span class="p">,</span><span class="w"> </span><span class="n">g</span><span class="p">)</span><span class="w"> </span><span class="p">{</span><span class="w"> </span><span class="k">if</span><span class="w"> </span><span class="p">(</span><span class="nf">is.numeric</span><span class="p">(</span><span class="n">f</span><span class="p">)</span><span class="w"> </span><span class="o">&amp;&amp;</span><span class="w"> </span><span class="nf">length</span><span class="p">(</span><span class="n">f</span><span class="p">)</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="m">1</span><span class="p">)</span><span class="w"> </span><span class="nf">return</span><span class="p">(</span><span class="n">Const</span><span class="p">(</span><span class="n">f</span><span class="p">)</span><span class="w"> </span><span class="o">*</span><span class="w"> </span><span class="n">g</span><span class="p">)</span><span class="w"> </span><span class="k">if</span><span class="w"> </span><span class="p">(</span><span class="nf">is.numeric</span><span class="p">(</span><span class="n">g</span><span class="p">)</span><span class="w"> </span><span class="o">&amp;&amp;</span><span class="w"> </span><span class="nf">length</span><span class="p">(</span><span class="n">g</span><span class="p">)</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="m">1</span><span class="p">)</span><span class="w"> </span><span class="nf">return</span><span class="p">(</span><span class="n">f</span><span class="w"> </span><span class="o">*</span><span class="w"> </span><span class="n">Const</span><span class="p">(</span><span class="n">g</span><span class="p">))</span><span class="w"> </span><span class="k">if</span><span class="w"> </span><span class="p">(</span><span class="n">is_nullf</span><span class="p">(</span><span class="n">f</span><span class="p">)</span><span class="w"> </span><span class="o">||</span><span class="w"> </span><span class="n">is_nullf</span><span class="p">(</span><span class="n">g</span><span class="p">))</span><span class="w"> </span><span class="nf">return</span><span class="p">(</span><span class="n">Null</span><span class="p">)</span><span class="w"> </span><span class="k">if</span><span class="w"> </span><span class="p">(</span><span class="n">is_const</span><span class="p">(</span><span class="n">f</span><span class="p">)</span><span class="w"> </span><span class="o">&amp;&amp;</span><span class="w"> </span><span class="nf">attr</span><span class="p">(</span><span class="n">f</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;params&quot;</span><span class="p">)</span><span class="o">$</span><span class="n">c</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="m">1</span><span class="p">)</span><span class="w"> </span><span class="nf">return</span><span class="p">(</span><span class="n">g</span><span class="p">)</span><span class="w"> </span><span class="k">if</span><span class="w"> </span><span class="p">(</span><span class="n">is_const</span><span class="p">(</span><span class="n">g</span><span class="p">)</span><span class="w"> </span><span class="o">&amp;&amp;</span><span class="w"> </span><span class="nf">attr</span><span class="p">(</span><span class="n">g</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;params&quot;</span><span class="p">)</span><span class="o">$</span><span class="n">c</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="m">1</span><span class="p">)</span><span class="w"> </span><span class="nf">return</span><span class="p">(</span><span class="n">f</span><span class="p">)</span><span class="w"> </span><span class="n">symbolic</span><span class="p">(</span><span class="w"> </span><span class="n">f</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">x</span><span class="p">)</span><span class="w"> </span><span class="n">f</span><span class="p">(</span><span class="n">x</span><span class="p">)</span><span class="w"> </span><span class="o">*</span><span class="w"> </span><span class="n">g</span><span class="p">(</span><span class="n">x</span><span class="p">),</span><span class="w"> </span><span class="n">repr</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">glue</span><span class="p">(</span><span class="s2">&quot;({f})*({g})&quot;</span><span class="p">),</span><span class="w"> </span><span class="n">df</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">D</span><span class="p">(</span><span class="n">f</span><span class="p">)</span><span class="o">*</span><span class="n">g</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">f</span><span class="o">*</span><span class="n">D</span><span class="p">(</span><span class="n">g</span><span class="p">),</span><span class="w"> </span><span class="c1"># regra do produto
</span><span class="w"> </span><span class="n">type</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;product&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">params</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">list</span><span class="p">(</span><span class="n">f</span><span class="p">,</span><span class="w"> </span><span class="n">g</span><span class="p">)</span><span class="w"> </span><span class="p">)</span><span class="w">
</span><span class="p">}</span><span class="w"> </span><span class="n">Prod</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">l</span><span class="p">)</span><span class="w"> </span><span class="n">reduce</span><span class="p">(</span><span class="n">l</span><span class="p">,</span><span class="w"> </span><span class="n">`*.symbolic`</span><span class="p">)</span><span class="w">
</span></code></pre>

<pre class="highlight"><code><span class="n">Mono</span><span class="p">()</span><span class="w"> </span><span class="o">*</span><span class="w"> </span><span class="n">Exp</span><span class="w">
</span><span class="c1">#&gt; x -&gt; (1*x^1)*(exp(x))
</span><span class="n">D</span><span class="p">(</span><span class="n">Mono</span><span class="p">()</span><span class="w"> </span><span class="o">*</span><span class="w"> </span><span class="n">Exp</span><span class="p">)</span><span class="w">
</span><span class="c1">#&gt; x -&gt; exp(x) + (1*x^1)*(exp(x))
</span><span class="n">Log</span><span class="w"> </span><span class="o">*</span><span class="w"> </span><span class="n">Mono</span><span class="p">()</span><span class="w">
</span><span class="c1">#&gt; x -&gt; (log(x))*(1*x^1)
</span><span class="n">D</span><span class="p">(</span><span class="n">Log</span><span class="w"> </span><span class="o">*</span><span class="w"> </span><span class="n">Mono</span><span class="p">())</span><span class="w">
</span><span class="c1">#&gt; x -&gt; (1*x^-1)*(1*x^1) + log(x)
</span></code></pre>

<h2 id="definindo-composições">
Definindo composições
</h2>
<p>
A composição de funções é a operação que a apresenta o maior número de
sutilezas. Comecemos pela mais simples: representação. Até agora
estávamos definindo as expressões de uma forma que envolvia diretamente
“x”. É interessante redefini-las em termos de um <em>placeholder</em>,
que pode vir a ser “x” ou um “f(x)”, no caso de uma composição de
funções. Para isso, basta definirmos o atributo
<code class="highlighter-rouge">repr</code> em termos de
<code class="highlighter-rouge"><span class="p">{</span><span
class="err">x</span><span class="p">}</span></code>: a função
<code class="highlighter-rouge">glue</code> cuidará do resto. Atenção
especial deve ser tomada no caso em que
<code class="highlighter-rouge">repr</code> é parametrizado. Quando isto
ocorre, deve-se usar <code>{{x}}</code>, pois
<code class="highlighter-rouge">glue</code> será avaliada duas vezes, em
dois momentos diferentes: uma com os parâmetros usuais de
<code class="highlighter-rouge">repr</code>, logo que a função é
definida, e outra com o placeholder no lugar de
<code class="highlighter-rouge">x</code>, quando o método
<code class="highlighter-rouge">as.character</code> for executado.
</p>
<p>
Seguem as modificações que devem ser feitas:
</p>
<pre class="highlight"><code><span class="c1"># Representa&#xE7;&#xE3;o de Mono: linha 68
# antes: </span><span class="w"> </span><span class="n">repr</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">glue</span><span class="p">(</span><span class="s2">&quot;{a}*x^{n}&quot;</span><span class="p">)</span><span class="w">
</span><span class="c1"># depois:
</span><span class="w"> </span><span class="n">repr</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">glue</span><span class="p">(</span><span class="s2">&quot;{a}**^{n}&quot;</span><span class="p">)</span><span class="w"> </span><span class="c1"># Representa&#xE7;&#xE3;o de Log: linha 79
# antes:
</span><span class="w"> </span><span class="n">repr</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;log({x})&quot;</span><span class="w">
</span><span class="c1"># depois:
</span><span class="w"> </span><span class="n">repr</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;log({x})&quot;</span><span class="w"> </span><span class="c1"># Representa&#xE7;&#xE3;o de Exp: Linha 89
# antes:
</span><span class="w"> </span><span class="n">repr</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;exp(x)&quot;</span><span class="w">
</span><span class="c1"># depois:
</span><span class="w"> </span><span class="n">repr</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;exp({x})&quot;</span><span class="w"> </span><span class="c1"># Representa&#xE7;&#xE3;o de `+`: # antes:
</span><span class="w"> </span><span class="n">repr</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">glue</span><span class="p">(</span><span class="s2">&quot;{f} + {g}&quot;</span><span class="p">)</span><span class="w">
</span><span class="c1"># depois:
</span><span class="w"> </span><span class="n">repr</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">glue</span><span class="p">(</span><span class="s1">&apos;{f%@%&quot;repr&quot;} + {g%@%&quot;repr&quot;}&apos;</span><span class="p">)</span><span class="w"> </span><span class="c1"># Representa&#xE7;&#xE3;o de `*`: # antes:
</span><span class="w"> </span><span class="n">repr</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">glue</span><span class="p">(</span><span class="s2">&quot;({f})*({g})&quot;</span><span class="p">)</span><span class="w">
</span><span class="c1"># depois:
</span><span class="w"> </span><span class="n">repr</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">glue</span><span class="p">(</span><span class="s1">&apos;({f%@%&quot;repr&quot;})*({g%@%&quot;repr&quot;})&apos;</span><span class="p">)</span><span class="w"> </span><span class="c1"># Mudan&#xE7;a no as.character: linha 19
# antes:
</span><span class="w"> </span><span class="n">as.character.symbolic</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">f</span><span class="p">)</span><span class="w"> </span><span class="n">f</span><span class="o">%@%</span><span class="s2">&quot;repr&quot;</span><span class="w">
</span><span class="c1"># depois:
</span><span class="w"> </span><span class="n">as.character.symbolic</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">f</span><span class="p">)</span><span class="w"> </span><span class="n">glue</span><span class="p">(</span><span class="n">f</span><span class="o">%@%</span><span class="s2">&quot;repr&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;x&quot;</span><span class="p">)</span><span class="w">
</span></code></pre>

<p>
Agora a representação de composições de funções se torna trivial. Se
<code class="highlighter-rouge">f%@%"repr"</code> é
<code class="highlighter-rouge">1\*{x}^2 + exp({x})</code>, por exemplo,
a linha <code class="highlighter-rouge">glue(f%@%"repr", x =
"sin(x)")</code> dará a representação desta função composta com a função
seno.
</p>
<p>
Segundo problema: Não há nenhum operador definido como função genérica
no R que seja intuitivo o suficiente para usarmos para a composição, não
existe um operador <code>°</code>. Resta nos contentar com uma função
chamada <code class="highlighter-rouge">Compose</code> ou algo do tipo.
Ou não! Seria interessante que pudéssemos compor as funções usando uma
notação como <code class="highlighter-rouge">Log(Sin)</code>. Isso é
possível? Sim!
</p>
<p>
Precisaremos, no entanto, modificar a função
<code class="highlighter-rouge">symbolic()</code>. Atualmente ela
simplesmente preserva a função f passada como parâmetro. Podemos fazer
melhor. Podemos criar uma função nova, g, a partir dela, de modo que
g(x) é f(x) em todos os casos normais (isto é, quando o parâmetro é
numérico), mas g(x) é uma composição de funções no caso em que x é, ela
mesma, uma função simbólica. Por exemplo,
<code class="highlighter-rouge">Log(4)</code> será avaliada como um
número, mas <code class="highlighter-rouge">Log(Sin)</code> como uma
composição de funções.
</p>
<p>
Um detalhe um tanto inconveniente é que, para fazer isso, precisaremos
ter a variável ou função auxiliar
(<code class="highlighter-rouge">Mono</code>,
<code class="highlighter-rouge">Exp</code>, etc) que gera as funções.
Será necessário, para guardá-la, mais um argumento em
<code class="highlighter-rouge">symbolic()</code>, o qual chamaremos de
<code class="highlighter-rouge">this</code>. Naturalmente, teremos que
adicionar um parâmetro <code class="highlighter-rouge">this</code> na
chamada a <code class="highlighter-rouge">symbolic()</code> das funções
que definimos anteriormente.
</p>
<p>
O novo código para <code class="highlighter-rouge">symbolic()</code> e o
código para a função <code class="highlighter-rouge">Compose()</code> se
encontram abaixo. O funcionamento delas é um tanto sofisticado.
Portanto, recomendo que passe um tempinho testando e tentando entender o
que acontece durante a execução delas.
</p>
<pre class="highlight"><code><span class="n">symbolic</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">f</span><span class="p">,</span><span class="w"> </span><span class="n">repr</span><span class="p">,</span><span class="w"> </span><span class="n">df</span><span class="p">,</span><span class="w"> </span><span class="n">type</span><span class="p">,</span><span class="w"> </span><span class="n">this</span><span class="p">,</span><span class="w"> </span><span class="n">params</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">list</span><span class="p">(),</span><span class="w"> </span><span class="n">inverse</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">NULL</span><span class="p">)</span><span class="w"> </span><span class="p">{</span><span class="w"> </span><span class="n">this</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">lazy</span><span class="p">(</span><span class="n">this</span><span class="p">)</span><span class="w"> </span><span class="c1"># guarda a express&#xE3;o
</span><span class="w"> </span><span class="n">g</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">x</span><span class="p">)</span><span class="w"> </span><span class="p">{</span><span class="w"> </span><span class="k">if</span><span class="w"> </span><span class="p">(</span><span class="n">is_symbolic</span><span class="p">(</span><span class="n">x</span><span class="p">))</span><span class="w"> </span><span class="p">{</span><span class="w"> </span><span class="n">this</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">lazy_eval</span><span class="p">(</span><span class="n">this</span><span class="p">)</span><span class="w"> </span><span class="c1"># executa
</span><span class="w"> </span><span class="c1"># se vem de uma fun&#xE7;&#xE3;o que n&#xE3;o toma par&#xE2;metros (Sin ou Exp, por ex)
</span><span class="w"> </span><span class="k">if</span><span class="w"> </span><span class="p">(</span><span class="n">is_symbolic</span><span class="p">(</span><span class="n">this</span><span class="p">))</span><span class="w"> </span><span class="nf">return</span><span class="p">(</span><span class="n">Compose</span><span class="p">(</span><span class="n">this</span><span class="p">,</span><span class="w"> </span><span class="n">x</span><span class="p">))</span><span class="w"> </span><span class="c1"># pode us&#xE1;-la diretamente na composi&#xE7;&#xE3;o
</span><span class="w"> </span><span class="c1"># se ainda h&#xE1; par&#xE2;metros a serem chamados, chama a fun&#xE7;&#xE3;o criadora
</span><span class="w"> </span><span class="c1"># com esses par&#xE2;metros
</span><span class="w"> </span><span class="n">s</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">do.call</span><span class="p">(</span><span class="n">this</span><span class="p">,</span><span class="w"> </span><span class="n">params</span><span class="p">)</span><span class="w"> </span><span class="nf">return</span><span class="p">(</span><span class="n">Compose</span><span class="p">(</span><span class="n">s</span><span class="p">,</span><span class="w"> </span><span class="n">x</span><span class="p">))</span><span class="w"> </span><span class="p">}</span><span class="w"> </span><span class="c1"># se x n&#xE3;o for symbolic, simplesmente calcula o valor num&#xE9;rico da fun&#xE7;&#xE3;o
</span><span class="w"> </span><span class="n">f</span><span class="p">(</span><span class="n">x</span><span class="p">)</span><span class="w"> </span><span class="p">}</span><span class="w"> </span><span class="nf">class</span><span class="p">(</span><span class="n">g</span><span class="p">)</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="s2">&quot;symbolic&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;function&quot;</span><span class="p">)</span><span class="w"> </span><span class="nf">attr</span><span class="p">(</span><span class="n">g</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;repr&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">repr</span><span class="w"> </span><span class="c1"># uma representa&#xE7;&#xE3;o da fun&#xE7;&#xE3;o, como string
</span><span class="w"> </span><span class="nf">attr</span><span class="p">(</span><span class="n">g</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;df&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">lazy</span><span class="p">(</span><span class="n">df</span><span class="p">)</span><span class="w"> </span><span class="c1"># a derivada da fun&#xE7;&#xE3;o
</span><span class="w"> </span><span class="nf">attr</span><span class="p">(</span><span class="n">g</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;inverse&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">lazy</span><span class="p">(</span><span class="n">inverse</span><span class="p">)</span><span class="w"> </span><span class="c1"># a inversa da fun&#xE7;&#xE3;o. n&#xE3;o ser&#xE1; usada ainda.
</span><span class="w"> </span><span class="nf">attr</span><span class="p">(</span><span class="n">g</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;type&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">type</span><span class="w"> </span><span class="c1"># que tipo de fun&#xE7;&#xE3;o isso &#xE9;
</span><span class="w"> </span><span class="nf">attr</span><span class="p">(</span><span class="n">g</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;params&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">params</span><span class="w"> </span><span class="c1"># os par&#xE2;metros que definem uma fun&#xE7;&#xE3;o daquele tipo
</span><span class="w"> </span><span class="n">g</span><span class="w">
</span><span class="p">}</span><span class="w"> </span><span class="n">has_inverse</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">f</span><span class="p">)</span><span class="w"> </span><span class="o">!</span><span class="nf">is.null</span><span class="p">(</span><span class="n">f</span><span class="o">%@%</span><span class="s2">&quot;inverse&quot;</span><span class="p">)</span><span class="w">
</span><span class="n">inverse</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">f</span><span class="p">)</span><span class="w"> </span><span class="n">lazy_eval</span><span class="p">(</span><span class="n">f</span><span class="o">%@%</span><span class="s2">&quot;inverse&quot;</span><span class="p">)</span><span class="w"> </span><span class="n">Compose</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">f</span><span class="p">,</span><span class="w"> </span><span class="n">g</span><span class="p">)</span><span class="w"> </span><span class="p">{</span><span class="w"> </span><span class="k">if</span><span class="w"> </span><span class="p">(</span><span class="n">is_nullf</span><span class="p">(</span><span class="n">f</span><span class="p">)</span><span class="w"> </span><span class="o">||</span><span class="w"> </span><span class="n">is_const</span><span class="p">(</span><span class="n">f</span><span class="p">))</span><span class="w"> </span><span class="nf">return</span><span class="p">(</span><span class="n">f</span><span class="p">)</span><span class="w"> </span><span class="c1"># se g(x) = c, f(g(x)) = f(c)
</span><span class="w"> </span><span class="k">if</span><span class="w"> </span><span class="p">(</span><span class="n">is_nullf</span><span class="p">(</span><span class="n">g</span><span class="p">))</span><span class="w"> </span><span class="nf">return</span><span class="p">(</span><span class="n">Const</span><span class="p">(</span><span class="n">f</span><span class="p">(</span><span class="m">0</span><span class="p">)))</span><span class="w"> </span><span class="k">if</span><span class="w"> </span><span class="p">(</span><span class="n">is_const</span><span class="p">(</span><span class="n">g</span><span class="p">))</span><span class="w"> </span><span class="nf">return</span><span class="p">(</span><span class="n">Const</span><span class="p">(</span><span class="n">f</span><span class="p">(</span><span class="nf">attr</span><span class="p">(</span><span class="n">g</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;params&quot;</span><span class="p">)</span><span class="o">$</span><span class="n">c</span><span class="p">)))</span><span class="w"> </span><span class="n">symbolic</span><span class="p">(</span><span class="w"> </span><span class="n">f</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">x</span><span class="p">)</span><span class="w"> </span><span class="n">f</span><span class="p">(</span><span class="n">g</span><span class="p">(</span><span class="n">x</span><span class="p">)),</span><span class="w"> </span><span class="c1"># um par de par&#xEA;nteses a mais por precau&#xE7;&#xE3;o. Por enquanto, &#xE9; prefer&#xED;vel
</span><span class="w"> </span><span class="c1"># mais par&#xEA;nteses que menos
</span><span class="w"> </span><span class="n">repr</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">glue</span><span class="p">(</span><span class="n">f</span><span class="o">%@%</span><span class="s2">&quot;repr&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">glue</span><span class="p">(</span><span class="s2">&quot;({g})&quot;</span><span class="p">)),</span><span class="w"> </span><span class="n">df</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">D</span><span class="p">(</span><span class="n">f</span><span class="p">)(</span><span class="n">g</span><span class="p">)</span><span class="w"> </span><span class="o">*</span><span class="w"> </span><span class="n">D</span><span class="p">(</span><span class="n">g</span><span class="p">),</span><span class="w"> </span><span class="c1"># regra da cadeia
</span><span class="w"> </span><span class="n">type</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;composition&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">this</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">Compose</span><span class="p">,</span><span class="w"> </span><span class="n">params</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">list</span><span class="p">(</span><span class="n">f</span><span class="p">,</span><span class="w"> </span><span class="n">g</span><span class="p">),</span><span class="w"> </span><span class="n">inverse</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="k">if</span><span class="w"> </span><span class="p">(</span><span class="n">has_inverse</span><span class="p">(</span><span class="n">f</span><span class="p">)</span><span class="w"> </span><span class="o">&amp;&amp;</span><span class="w"> </span><span class="n">has_inverse</span><span class="p">(</span><span class="n">g</span><span class="p">))</span><span class="w"> </span><span class="n">inverse</span><span class="p">(</span><span class="n">g</span><span class="p">)(</span><span class="n">inverse</span><span class="p">(</span><span class="n">f</span><span class="p">))</span><span class="w"> </span><span class="k">else</span><span class="w"> </span><span class="kc">NULL</span><span class="w"> </span><span class="p">)</span><span class="w">
</span><span class="p">}</span><span class="w">
</span></code></pre>

<p>
Lembre-se de inserir o parâmetro
<code class="highlighter-rouge">this</code>! Por exemplo, a nova
definição de <code class="highlighter-rouge">Null</code> é:
</p>
<pre class="highlight"><code><span class="n">Null</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">symbolic</span><span class="p">(</span><span class="w"> </span><span class="n">f</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">x</span><span class="p">)</span><span class="w"> </span><span class="m">0</span><span class="p">,</span><span class="w"> </span><span class="n">repr</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;0&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">df</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">Null</span><span class="p">,</span><span class="w"> </span><span class="n">type</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;null&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">this</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">Null</span><span class="w">
</span><span class="p">)</span><span class="w">
</span></code></pre>

<p>
Façamos agora alguns testes:
</p>
<pre class="highlight"><code><span class="n">Mono</span><span class="p">(</span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="m">2</span><span class="p">)</span><span class="w">
</span><span class="c1">#&gt; x -&gt; 1*x^2
</span><span class="n">Mono</span><span class="p">(</span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="m">2</span><span class="p">)(</span><span class="m">3</span><span class="p">)</span><span class="w">
</span><span class="c1">#&gt; [1] 9
</span><span class="n">Mono</span><span class="p">(</span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="m">2</span><span class="p">)(</span><span class="n">Const</span><span class="p">(</span><span class="m">3</span><span class="p">))</span><span class="w">
</span><span class="c1">#&gt; x -&gt; 9
</span><span class="n">Mono</span><span class="p">(</span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="m">2</span><span class="p">)(</span><span class="n">Exp</span><span class="p">)</span><span class="w">
</span><span class="c1">#&gt; x -&gt; 1*(exp(x))^2
</span><span class="n">D</span><span class="p">(</span><span class="n">Mono</span><span class="p">(</span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="m">2</span><span class="p">)(</span><span class="n">Exp</span><span class="p">))</span><span class="w">
</span><span class="c1">#&gt; x -&gt; (2*(exp(x))^1)*(exp(x))
</span><span class="n">Poly</span><span class="p">(</span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="m">2</span><span class="p">,</span><span class="w"> </span><span class="m">3</span><span class="p">)</span><span class="w">
</span><span class="c1">#&gt; x -&gt; 1*x^2 + 2*x^1 + 3
</span><span class="n">Poly</span><span class="p">(</span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="m">2</span><span class="p">,</span><span class="w"> </span><span class="m">3</span><span class="p">)(</span><span class="m">0</span><span class="p">)</span><span class="w">
</span><span class="c1">#&gt; [1] 3
</span><span class="n">Poly</span><span class="p">(</span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="m">2</span><span class="p">,</span><span class="w"> </span><span class="m">3</span><span class="p">)(</span><span class="n">Null</span><span class="p">)</span><span class="w">
</span><span class="c1">#&gt; x -&gt; 3
</span><span class="n">Poly</span><span class="p">(</span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="m">2</span><span class="p">,</span><span class="w"> </span><span class="m">3</span><span class="p">)(</span><span class="n">Log</span><span class="p">)</span><span class="w">
</span><span class="c1">#&gt; x -&gt; 1*(log(x))^2 + 2*(log(x))^1 + 3
</span><span class="n">D</span><span class="p">(</span><span class="n">Poly</span><span class="p">(</span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="m">2</span><span class="p">,</span><span class="w"> </span><span class="m">3</span><span class="p">)(</span><span class="n">Log</span><span class="p">))</span><span class="w">
</span><span class="c1">#&gt; x -&gt; (2*(log(x))^1 + 2)*(1*x^-1)
</span><span class="n">D</span><span class="p">(</span><span class="n">Poly</span><span class="p">(</span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="m">2</span><span class="p">,</span><span class="w"> </span><span class="m">3</span><span class="p">)(</span><span class="n">Log</span><span class="p">),</span><span class="w"> </span><span class="m">2</span><span class="p">)</span><span class="w">
</span><span class="c1">#&gt; x -&gt; ((2)*(1*x^-1))*(1*x^-1) + (2*(log(x))^1 + 2)*(-1*x^-2)
</span></code></pre>

<p>
Exceto pelas representações extremamente prolixas, tudo parece estar em
seu lugar! :)
</p>
<h2 id="novas-funções">
Novas funções
</h2>
<p>
Antes de atacar os problemas de representação e simplificação, há mais
coisas que podemos adicionar sem muito trabalho. Podemos definir, por
exemplo, operadores de subtração e divisão. Por motivos que ficarão mais
claros mais tarde, representaremos -g como a composição de
<code class="highlighter-rouge">x -&gt; -x</code> (isto é,
<code class="highlighter-rouge">Mono(a = -1)</code>) com g, e f - g como
f + (-g), com -g seguindo a definição anterior. Analogamente, definimos
f / g como a f multiplicado pela composição de
<code class="highlighter-rouge">Mono(n = -1)</code> com g, isto é, a
recíproca de g.
</p>
<pre class="highlight"><code><span class="n">`-.symbolic`</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">f</span><span class="p">,</span><span class="w"> </span><span class="n">g</span><span class="p">)</span><span class="w"> </span><span class="p">{</span><span class="w"> </span><span class="c1"># caso do - un&#xE1;rio
</span><span class="w"> </span><span class="k">if</span><span class="w"> </span><span class="p">(</span><span class="nf">missing</span><span class="p">(</span><span class="n">g</span><span class="p">))</span><span class="w"> </span><span class="p">{</span><span class="w"> </span><span class="n">Mono</span><span class="p">(</span><span class="n">a</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">-1</span><span class="p">)(</span><span class="n">f</span><span class="p">)</span><span class="w"> </span><span class="p">}</span><span class="w"> </span><span class="k">else</span><span class="w"> </span><span class="p">{</span><span class="w"> </span><span class="n">f</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="p">(</span><span class="o">-</span><span class="n">g</span><span class="p">)</span><span class="w"> </span><span class="p">}</span><span class="w">
</span><span class="p">}</span><span class="w"> </span><span class="n">`/.symbolic`</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">f</span><span class="p">,</span><span class="w"> </span><span class="n">g</span><span class="p">)</span><span class="w"> </span><span class="n">f</span><span class="w"> </span><span class="o">*</span><span class="w"> </span><span class="n">Mono</span><span class="p">(</span><span class="n">n</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">-1</span><span class="p">)(</span><span class="n">g</span><span class="p">)</span><span class="w">
</span></code></pre>

<pre class="highlight"><code><span class="n">Log</span><span class="w"> </span><span class="o">-</span><span class="w"> </span><span class="n">Exp</span><span class="w">
</span><span class="c1">#&gt; x -&gt; log(x) + -1*(exp(x))^1
</span><span class="n">Log</span><span class="w"> </span><span class="o">/</span><span class="w"> </span><span class="n">Exp</span><span class="w">
</span><span class="c1">#&gt; x -&gt; (log(x))*(1*(exp(x))^-1)
</span></code></pre>

<p>
Agora podemos definir as funções trigonométricas:
</p>
<pre class="highlight"><code><span class="n">Sin</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">symbolic</span><span class="p">(</span><span class="w"> </span><span class="n">f</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">sin</span><span class="p">,</span><span class="w"> </span><span class="n">repr</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;sin({x})&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">df</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">Cos</span><span class="p">,</span><span class="w"> </span><span class="n">type</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;sin&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">this</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">Sin</span><span class="w">
</span><span class="p">)</span><span class="w"> </span><span class="n">Cos</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">symbolic</span><span class="p">(</span><span class="w"> </span><span class="n">f</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">cos</span><span class="p">,</span><span class="w"> </span><span class="n">repr</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;cos({x})&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">df</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="o">-</span><span class="n">Sin</span><span class="p">,</span><span class="w"> </span><span class="n">type</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;cos&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">this</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">Cos</span><span class="w">
</span><span class="p">)</span><span class="w">
</span></code></pre>

<pre class="highlight"><code><span class="n">Sin</span><span class="p">(</span><span class="m">0</span><span class="p">)</span><span class="w">
</span><span class="c1">#&gt; [1] 0
</span><span class="n">Cos</span><span class="p">(</span><span class="m">0</span><span class="p">)</span><span class="w">
</span><span class="c1">#&gt; [1] 1
</span><span class="n">D</span><span class="p">(</span><span class="n">Sin</span><span class="p">)</span><span class="w">
</span><span class="c1">#&gt; x -&gt; cos(x)
</span><span class="n">D</span><span class="p">(</span><span class="n">Sin</span><span class="p">,</span><span class="w"> </span><span class="m">2</span><span class="p">)</span><span class="w">
</span><span class="c1">#&gt; x -&gt; -1*(sin(x))^1
</span><span class="n">D</span><span class="p">(</span><span class="n">Sin</span><span class="p">,</span><span class="w"> </span><span class="m">3</span><span class="p">)</span><span class="w">
</span><span class="c1">#&gt; x -&gt; (-1)*(cos(x))
</span><span class="n">D</span><span class="p">(</span><span class="n">Sin</span><span class="p">,</span><span class="w"> </span><span class="m">4</span><span class="p">)</span><span class="w">
</span><span class="c1">#&gt; x -&gt; (-1)*(-1*(sin(x))^1)
</span></code></pre>

<p>
Claro, já podemos definir as funções tangente, secante e até as
trigonométricas inversas, como arco-tangente. Isto fica como exercício
para o leitor (<em>risos</em>). Até o próximo post!
</p>
<p>
O código como encontrado ao final deste post pode ser visto
<a href="https://github.com/lurodrigo/symbolic/blob/master/R/symbolic_02.R">aqui</a>.
</p>
<p>
\[1\] Há uma função <code class="highlighter-rouge">Reduce</code> no
base-R cumprindo o mesmo papel, mas acho as funções do pacote
<code class="highlighter-rouge">purrr</code> mais consistentes e
convenientes.
</p>
</section>
<footer class="page__meta">
<p class="page__taxonomy">
<strong><i class="fa fa-fw fa-tags"></i> Tags: </strong> <span>
<a href="https://lurodrigo.github.io/tags/#computa&#xE7;&#xE3;o-simb&#xF3;lica" class="page__taxonomy-item">Computação
simbólica</a><span class="sep">, </span>
<a href="https://lurodrigo.github.io/tags/#lazyeval" class="page__taxonomy-item">lazyeval</a><span
class="sep">, </span>
<a href="https://lurodrigo.github.io/tags/#metaprograma&#xE7;&#xE3;o" class="page__taxonomy-item">Metaprogramação</a><span
class="sep">, </span>
<a href="https://lurodrigo.github.io/tags/#programa&#xE7;&#xE3;o-funcional" class="page__taxonomy-item">Programação
funcional</a><span class="sep">, </span>
<a href="https://lurodrigo.github.io/tags/#purrr" class="page__taxonomy-item">purrr</a><span
class="sep">, </span>
<a href="https://lurodrigo.github.io/tags/#r" class="page__taxonomy-item">R</a>
</span>
</p>
<p class="page__taxonomy">
<strong><i class="fa fa-fw fa-folder-open"></i> Categorias: </strong>
<span>
<a href="https://lurodrigo.github.io/categories/#portugu&#xEA;s" class="page__taxonomy-item">Português</a><span
class="sep">, </span>
<a href="https://lurodrigo.github.io/categories/#r" class="page__taxonomy-item">R</a><span
class="sep">, </span>
<a href="https://lurodrigo.github.io/categories/#r-pt" class="page__taxonomy-item">R\_pt</a>
</span>
</p>
<p class="page__date">
<strong><i class="fa fa-fw fa-calendar"></i> Atualizado em:</strong>
<time>May 19, 2017</time>
</p>
</footer>
<section class="page__share">
<a href="https://twitter.com/intent/tweet?via=lu_rodrigo&amp;text=Escrevendo%20um%20pequeno%20sistema%20de%20computa&#xE7;&#xE3;o%20simb&#xF3;lica%20em%20R%20(Parte%202/4)%20https://lurodrigo.github.io/2017/05/computacao-simbolica-R-2-4/" class="btn btn--twitter"><i class="fa fa-fw fa-twitter"></i><span>
Twitter</span></a>
<a href="https://www.facebook.com/sharer/sharer.php?u=https://lurodrigo.github.io/2017/05/computacao-simbolica-R-2-4/" class="btn btn--facebook"><i class="fa fa-fw fa-facebook"></i><span>
Facebook</span></a>
<a href="https://plus.google.com/share?url=https://lurodrigo.github.io/2017/05/computacao-simbolica-R-2-4/" class="btn btn--google-plus"><i class="fa fa-fw fa-google-plus"></i><span>
Google+</span></a>
<a href="https://www.linkedin.com/shareArticle?mini=true&amp;url=https://lurodrigo.github.io/2017/05/computacao-simbolica-R-2-4/" class="btn btn--linkedin"><i class="fa fa-fw fa-linkedin"></i><span>
LinkedIn</span></a>
</section>
</p>

