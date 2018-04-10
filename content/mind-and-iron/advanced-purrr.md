+++
title = ""
date = "1-01-01"
categories = ["mind-and-iron"]
original_url = "http://ctlente.com/pt/teaching/advanced-purrr/"
+++

<p>
O <code>purrr</code> é dividido em 23 famílias. Cada seção deste arquivo
corresponde a uma ou mais destas famílias; as primeiras 3 são o que
podemos considerar “<code>purrr</code> básico” e as outras 20 são o que,
para o propósito desta aula, chamaremos de “<code>purrr</code>
avançado”.
</p>
<p>
Vamos entrar em mais detalhes logo menos, mas ficam aqui as famílias e
as funções que as compõem respectivamente:
</p>
<ul>
<li>
Família map
<ul>
<li>
<code>map()</code>
</li>
<li>
<code>walk()</code>
</li>
<li>
<code>map\_chr()</code>
</li>
<li>
<code>map\_dbl()</code>
</li>
<li>
<code>map\_int()</code>
</li>
<li>
<code>map\_lgl()</code>
</li>
<li>
<code>map\_dfc()</code>
</li>
<li>
<code>map\_dfr()</code>
</li>
<li>
<code>map\_at()</code>
</li>
<li>
<code>map\_if()</code>
</li>
</ul>
</li>
<li>
Família flatten
<ul>
<li>
<code>flatten\_chr()</code>
</li>
<li>
<code>flatten\_dbl()</code>
</li>
<li>
<code>flatten\_int()</code>
</li>
<li>
<code>flatten\_lgl()</code>
</li>
<li>
<code>flatten\_dfc()</code>
</li>
<li>
<code>flatten\_dfr()</code>
</li>
<li>
<code>flatten()</code>
</li>
</ul>
</li>
<li>
Família map2
<ul>
<li>
<code>map2()</code>
</li>
<li>
<code>walk2()</code>
</li>
<li>
<code>map2\_chr()</code>
</li>
<li>
<code>map2\_dbl()</code>
</li>
<li>
<code>map2\_int()</code>
</li>
<li>
<code>map2\_lgl()</code>
</li>
<li>
<code>map2\_dfc()</code>
</li>
<li>
<code>map2\_dfr()</code>
</li>
</ul>
</li>
<li>
Família pmap
<ul>
<li>
<code>pmap()</code>
</li>
<li>
<code>pwalk()</code>
</li>
<li>
<code>pmap\_chr()</code>
</li>
<li>
<code>pmap\_dbl()</code>
</li>
<li>
<code>pmap\_int()</code>
</li>
<li>
<code>pmap\_lgl()</code>
</li>
<li>
<code>pmap\_dfc()</code>
</li>
<li>
<code>pmap\_dfr()</code>
</li>
</ul>
</li>
<li>
Família imap
<ul>
<li>
<code>imap()</code>
</li>
<li>
<code>iwalk()</code>
</li>
<li>
<code>imap\_chr()</code>
</li>
<li>
<code>imap\_dbl()</code>
</li>
<li>
<code>imap\_int()</code>
</li>
<li>
<code>imap\_lgl()</code>
</li>
<li>
<code>imap\_dfc()</code>
</li>
<li>
<code>imap\_dfr()</code>
</li>
</ul>
</li>
<li>
Família lmap
<ul>
<li>
<code>lmap()</code>
</li>
<li>
<code>lmap\_at()</code>
</li>
<li>
<code>lmap\_if()</code>
</li>
</ul>
</li>
<li>
Família reduce
<ul>
<li>
<code>accumulate()</code>
</li>
<li>
<code>accumulate\_right()</code>
</li>
<li>
<code>reduce()</code>
</li>
<li>
<code>reduce\_right()</code>
</li>
<li>
<code>reduce2()</code>
</li>
<li>
<code>reduce2\_right()</code>
</li>
</ul>
</li>
<li>
Família keep
<ul>
<li>
<code>compact()</code>
</li>
<li>
<code>discard()</code>
</li>
<li>
<code>keep()</code>
</li>
</ul>
</li>
<li>
Família pluck
</li>
<li>
Família modify
<ul>
<li>
<code>modify()</code>
</li>
<li>
<code>modify\_at()</code>
</li>
<li>
<code>modify\_if()</code>
</li>
<li>
<code>modify\_depth()</code>
</li>
</ul>
</li>
<li>
Família list
<ul>
<li>
<code>set\_names()</code>
</li>
<li>
<code>prepend()</code>
</li>
<li>
<code>transpose()</code>
</li>
<li>
<code>list\_along()</code>
</li>
<li>
<code>rep\_along()</code>
</li>
<li>
<code>splice()</code>
</li>
<li>
<code>list\_merge()</code>
</li>
<li>
<code>list\_modify()</code>
</li>
<li>
<code>update\_list()</code>
</li>
</ul>
</li>
<li>
Família detect
<ul>
<li>
<code>detect()</code>
</li>
<li>
<code>detect\_index()</code>
</li>
<li>
<code>has\_element()</code>
</li>
<li>
<code>head\_while()</code>
</li>
<li>
<code>tail\_while()</code>
</li>
</ul>
</li>
<li>
Família cross
<ul>
<li>
<code>cross()</code>
</li>
<li>
<code>cross2()</code>
</li>
<li>
<code>cross3()</code>
</li>
<li>
<code>cross\_df()</code>
</li>
</ul>
</li>
<li>
Família is
<ul>
<li>
<code>is\_character()</code>
</li>
<li>
<code>is\_double()</code>
</li>
<li>
<code>is\_formula()</code>
</li>
<li>
<code>is\_function()</code>
</li>
<li>
<code>is\_integer()</code>
</li>
<li>
<code>is\_list()</code>
</li>
<li>
<code>is\_logical()</code>
</li>
<li>
<code>is\_numeric()</code>
</li>
<li>
<code>is\_atomic()</code>
</li>
<li>
<code>is\_empty()</code>
</li>
<li>
<code>is\_null()</code>
</li>
<li>
<code>is\_vector()</code>
</li>
<li>
<code>is\_scalar\_atomic()</code>
</li>
<li>
<code>is\_scalar\_character()</code>
</li>
<li>
<code>is\_scalar\_double()</code>
</li>
<li>
<code>is\_scalar\_integer()</code>
</li>
<li>
<code>is\_scalar\_list()</code>
</li>
<li>
<code>is\_scalar\_logical()</code>
</li>
<li>
<code>is\_scalar\_numeric()</code>
</li>
<li>
<code>is\_scalar\_vector()</code>
</li>
<li>
<code>is\_bare\_atomic()</code>
</li>
<li>
<code>is\_bare\_character()</code>
</li>
<li>
<code>is\_bare\_double()</code>
</li>
<li>
<code>is\_bare\_integer()</code>
</li>
<li>
<code>is\_bare\_list()</code>
</li>
<li>
<code>is\_bare\_logical()</code>
</li>
<li>
<code>is\_bare\_numeric()</code>
</li>
<li>
<code>is\_bare\_vector()</code>
</li>
</ul>
</li>
<li>
Família as
<ul>
<li>
<code>as\_function()</code>
</li>
<li>
<code>as\_mapper()</code>
</li>
</ul>
</li>
<li>
Família invoke
<ul>
<li>
<code>invoke()</code>
</li>
<li>
<code>invoke\_map()</code>
</li>
<li>
<code>invoke\_map\_chr()</code>
</li>
<li>
<code>invoke\_map\_dbl()</code>
</li>
<li>
<code>invoke\_map\_int()</code>
</li>
<li>
<code>invoke\_map\_lgl()</code>
</li>
<li>
<code>invoke\_map\_dfc()</code>
</li>
<li>
<code>invoke\_map\_dfr()</code>
</li>
</ul>
</li>
<li>
Família simplify
<ul>
<li>
<code>as\_vector()</code>
</li>
<li>
<code>simplify()</code>
</li>
<li>
<code>simplify\_all()</code>
</li>
</ul>
</li>
<li>
Família tree
<ul>
<li>
<code>array\_branch()</code>
</li>
<li>
<code>array\_tree()</code>
</li>
</ul>
</li>
<li>
Família compose
</li>
<li>
Família lift
<ul>
<li>
<code>lift()</code>
</li>
<li>
<code>lift\_dl()</code>
</li>
<li>
<code>lift\_dv()</code>
</li>
<li>
<code>lift\_ld()</code>
</li>
<li>
<code>lift\_lv()</code>
</li>
<li>
<code>lift\_vd()</code>
</li>
<li>
<code>lift\_vl()</code>
</li>
</ul>
</li>
<li>
Família capture
<ul>
<li>
<code>possibly()</code>
</li>
<li>
<code>quietly()</code>
</li>
<li>
<code>safely()</code>
</li>
<li>
<code>auto\_browse()</code>
</li>
</ul>
</li>
<li>
Família logic
<ul>
<li>
<code>every()</code>
</li>
<li>
<code>some()</code>
</li>
<li>
<code>negate()</code>
</li>
<li>
<code>when()</code>
</li>
</ul>
</li>
<li>
Família misc
<ul>
<li>
<code>["%@%](mailto:%22%@%)()"</code>
</li>
<li>
<code>"%||%()"</code>
</li>
<li>
<code>vec\_depth()</code>
</li>
<li>
<code>rbernoulli()</code>
</li>
<li>
<code>rdunif()</code>
</li>
<li>
<code>rerun()</code>
</li>
</ul>
</li>
</ul>

<p>
Não vamos entrar em detalhes nesta seção, pois assume-se que todos já
saibam como as funções básicas do <code>purrr</code> trabalham. Em todo
caso, seguem alguns exemplos simples:
</p>
<pre class="sourceCode r"><code class="sourceCode r"><span class="co"># Duas fun&#xE7;&#xF5;es bem simples</span>
f &lt;-<span class="st"> </span><span class="cf">function</span>(a) { a<span class="op">*</span><span class="dv">2</span> <span class="op">+</span><span class="st"> </span><span class="dv">1</span> }
g &lt;-<span class="st"> </span><span class="cf">function</span>(a, b) { a<span class="op">*</span><span class="dv">2</span> <span class="op">+</span><span class="st"> </span>b<span class="op">*</span><span class="dv">2</span> <span class="op">+</span><span class="st"> </span><span class="dv">1</span> } <span class="co"># Map simples</span>
<span class="kw">map</span>(<span class="dv">1</span><span class="op">:</span><span class="dv">5</span>, f)</code></pre>

<pre><code>#&gt; [[1]]
#&gt; [1] 3
#&gt; #&gt; [[2]]
#&gt; [1] 5
#&gt; #&gt; [[3]]
#&gt; [1] 7
#&gt; #&gt; [[4]]
#&gt; [1] 9
#&gt; #&gt; [[5]]
#&gt; [1] 11</code></pre>
<pre><code>#&gt; [[1]]
#&gt; [1] 9
#&gt; #&gt; [[2]]
#&gt; [1] 11
#&gt; #&gt; [[3]]
#&gt; [1] 13
#&gt; #&gt; [[4]]
#&gt; [1] 15
#&gt; #&gt; [[5]]
#&gt; [1] 17</code></pre>
<pre class="sourceCode r"><code class="sourceCode r"><span class="co"># Achatamento</span>
<span class="dv">1</span><span class="op">:</span><span class="dv">5</span> <span class="op">%&gt;%</span><span class="st"> </span><span class="kw">map</span>(f) <span class="op">%&gt;%</span><span class="st"> </span><span class="kw">flatten_dbl</span>()</code></pre>

<pre><code>#&gt; [1] 3 5 7 9 11</code></pre>
<pre><code>#&gt; [1] 3 5 7 9 11</code></pre>
<pre class="sourceCode r"><code class="sourceCode r"><span class="co"># Varia&#xE7;&#xF5;es</span>
<span class="kw">map2</span>(<span class="dv">1</span><span class="op">:</span><span class="dv">5</span>, <span class="dv">6</span><span class="op">:</span><span class="dv">10</span>, g)</code></pre>

<pre><code>#&gt; [[1]]
#&gt; [1] 15
#&gt; #&gt; [[2]]
#&gt; [1] 19
#&gt; #&gt; [[3]]
#&gt; [1] 23
#&gt; #&gt; [[4]]
#&gt; [1] 27
#&gt; #&gt; [[5]]
#&gt; [1] 31</code></pre>
<pre><code>#&gt; [1] 15 19 23 27 31</code></pre>
<pre class="sourceCode r"><code class="sourceCode r"><span class="co"># Muito mais...</span>
<span class="kw">map_dbl</span>(<span class="dv">1</span><span class="op">:</span><span class="dv">5</span>, <span class="op">~</span>.x<span class="op">*</span><span class="dv">2</span> <span class="op">+</span><span class="st"> </span><span class="dv">1</span>)</code></pre>

<pre><code>#&gt; [1] 3 5 7 9 11</code></pre>
<pre class="sourceCode r"><code class="sourceCode r"><span class="kw">walk</span>(<span class="dv">1</span><span class="op">:</span><span class="dv">5</span>, <span class="cf">function</span>(a) { <span class="kw">print</span>(a); <span class="kw">return</span>(a<span class="op">+</span><span class="dv">2</span>) })</code></pre>

<pre><code>#&gt; [1] 1
#&gt; [1] 2
#&gt; [1] 3
#&gt; [1] 4
#&gt; [1] 5</code></pre>
<p>
Nas próprias funções do <code>purrr</code> básico já podemos ter um
gostinho de técnicas mais complexas: condicionais e achatamento para
tabelas.
</p>
<pre class="sourceCode r"><code class="sourceCode r"><span class="co"># Uma fun&#xE7;&#xE3;o predicado</span>
p &lt;-<span class="st"> </span><span class="cf">function</span>(a) { <span class="kw">return</span>(a <span class="op">&gt;</span><span class="st"> </span><span class="dv">3</span>) } <span class="co"># Condicionais</span>
<span class="kw">map_if</span>(<span class="dv">1</span><span class="op">:</span><span class="dv">5</span>, p, f)</code></pre>

<pre><code>#&gt; [[1]]
#&gt; [1] 1
#&gt; #&gt; [[2]]
#&gt; [1] 2
#&gt; #&gt; [[3]]
#&gt; [1] 3
#&gt; #&gt; [[4]]
#&gt; [1] 9
#&gt; #&gt; [[5]]
#&gt; [1] 11</code></pre>
<pre><code>#&gt; [[1]]
#&gt; [1] 1
#&gt; #&gt; [[2]]
#&gt; [1] 5
#&gt; #&gt; [[3]]
#&gt; [1] 3
#&gt; #&gt; [[4]]
#&gt; [1] 4
#&gt; #&gt; [[5]]
#&gt; [1] 11</code></pre>
<pre class="sourceCode r"><code class="sourceCode r"><span class="co"># Fun&#xE7;&#xF5;es que retornam tabelas</span>
ftab &lt;-<span class="st"> </span><span class="cf">function</span>(a) { tibble<span class="op">::</span><span class="kw">tibble</span>(<span class="dt">col1 =</span> a, <span class="dt">col2 =</span> <span class="op">-</span>a) }
gtab &lt;-<span class="st"> </span><span class="cf">function</span>(name, a) { tibble<span class="op">::</span><span class="kw">tibble</span>(<span class="op">!!</span>name <span class="op">:</span><span class="er">=</span><span class="st"> </span>a) } <span class="co"># Achatamento em tabelas</span>
<span class="kw">map_dfr</span>(<span class="kw">list</span>(<span class="dv">1</span><span class="op">:</span><span class="dv">5</span>, <span class="dv">6</span><span class="op">:</span><span class="dv">10</span>), ftab)</code></pre>

<pre><code>#&gt; # A tibble: 10 x 2
#&gt; col1 col2
#&gt; &lt;int&gt; &lt;int&gt;
#&gt; 1 1 - 1
#&gt; 2 2 - 2
#&gt; 3 3 - 3
#&gt; 4 4 - 4
#&gt; 5 5 - 5
#&gt; 6 6 - 6
#&gt; 7 7 - 7
#&gt; 8 8 - 8
#&gt; 9 9 - 9
#&gt; 10 10 -10</code></pre>
<pre class="sourceCode r"><code class="sourceCode r"><span class="kw">map2_dfc</span>(<span class="kw">list</span>(<span class="st">&quot;coluna1&quot;</span>, <span class="st">&quot;coluna2&quot;</span>), <span class="kw">list</span>(<span class="dv">1</span><span class="op">:</span><span class="dv">5</span>, <span class="dv">6</span><span class="op">:</span><span class="dv">10</span>), gtab)</code></pre>

<pre><code>#&gt; # A tibble: 5 x 2
#&gt; coluna1 coluna2
#&gt; &lt;int&gt; &lt;int&gt;
#&gt; 1 1 6
#&gt; 2 2 7
#&gt; 3 3 8
#&gt; 4 4 9
#&gt; 5 5 10</code></pre>

<p>
Ainda existem 3 variações da <code>map()</code> padrão, cada uma com
suas variações internas (<code>\_dbl</code>, <code>\_chr</code>,
<code>\_if</code>, <code>\_at</code>, …):
</p>
<pre class="sourceCode r"><code class="sourceCode r"><span class="co"># Fun&#xE7;&#xE3;o que recebe 4 argumentos</span>
f4 &lt;-<span class="st"> </span><span class="cf">function</span>(a, b, c, d) { a <span class="op">+</span><span class="st"> </span>b <span class="op">-</span><span class="st"> </span>c <span class="op">+</span><span class="st"> </span>d } <span class="co"># Map 3, 4, 5...</span>
<span class="kw">pmap</span>(<span class="kw">list</span>(<span class="dv">1</span><span class="op">:</span><span class="dv">3</span>, <span class="dv">4</span><span class="op">:</span><span class="dv">6</span>, <span class="dv">7</span><span class="op">:</span><span class="dv">9</span>, <span class="dv">10</span><span class="op">:</span><span class="dv">12</span>), f4)</code></pre>

<pre><code>#&gt; [[1]]
#&gt; [1] 8
#&gt; #&gt; [[2]]
#&gt; [1] 10
#&gt; #&gt; [[3]]
#&gt; [1] 12</code></pre>
<pre class="sourceCode r"><code class="sourceCode r"><span class="co"># Fun&#xE7;&#xE3;o que usa um &#xED;ndice</span>
fi &lt;-<span class="st"> </span><span class="cf">function</span>(a, i, b) { a <span class="op">+</span><span class="st"> </span>b[<span class="kw">length</span>(b)<span class="op">-</span>i<span class="op">+</span><span class="dv">1</span>] } <span class="co"># &#xCD;ndice sendo passado implicitamente</span>
<span class="kw">imap</span>(<span class="dv">1</span><span class="op">:</span><span class="dv">5</span>, fi, <span class="dt">b =</span> <span class="dv">6</span><span class="op">:</span><span class="dv">10</span>)</code></pre>

<pre><code>#&gt; [[1]]
#&gt; [1] 11
#&gt; #&gt; [[2]]
#&gt; [1] 11
#&gt; #&gt; [[3]]
#&gt; [1] 11
#&gt; #&gt; [[4]]
#&gt; [1] 11
#&gt; #&gt; [[5]]
#&gt; [1] 11</code></pre>
<pre class="sourceCode r"><code class="sourceCode r"><span class="co"># Ao inv&#xE9;s de operar em .x[[i]], operar em .x[i]</span>
<span class="kw">lmap</span>(<span class="kw">list</span>(<span class="dv">1</span><span class="op">:</span><span class="dv">3</span>, <span class="dv">4</span><span class="op">:</span><span class="dv">6</span>), <span class="op">~</span><span class="kw">list</span>(<span class="kw">length</span>(.x)))</code></pre>

<pre><code>#&gt; [[1]]
#&gt; [1] 1
#&gt; #&gt; [[2]]
#&gt; [1] 1</code></pre>

<p>
Essa família tem muitas semelhanças com as anteriores, mas com alguns
detalhes a mais:
</p>
<pre class="sourceCode r"><code class="sourceCode r"><span class="co"># Acumular e reduzir</span>
<span class="kw">accumulate</span>(<span class="kw">c</span>(<span class="st">&quot;a&quot;</span>, <span class="st">&quot;b&quot;</span>, <span class="st">&quot;c&quot;</span>, <span class="st">&quot;d&quot;</span>), paste)</code></pre>

<pre><code>#&gt; [1] &quot;a&quot; &quot;a b&quot; &quot;a b c&quot; &quot;a b c d&quot;</code></pre>
<pre class="sourceCode r"><code class="sourceCode r"><span class="kw">reduce</span>(<span class="kw">c</span>(<span class="st">&quot;a&quot;</span>, <span class="st">&quot;b&quot;</span>, <span class="st">&quot;c&quot;</span>, <span class="st">&quot;d&quot;</span>), paste)</code></pre>

<pre><code>#&gt; [1] &quot;a b c d&quot;</code></pre>
<pre class="sourceCode r"><code class="sourceCode r"><span class="co"># E mais...</span>
<span class="kw">accumulate_right</span>(<span class="kw">c</span>(<span class="st">&quot;a&quot;</span>, <span class="st">&quot;b&quot;</span>, <span class="st">&quot;c&quot;</span>, <span class="st">&quot;d&quot;</span>), paste)</code></pre>

<pre><code>#&gt; [1] &quot;d c b a&quot; &quot;d c b&quot; &quot;d c&quot; &quot;d&quot;</code></pre>
<pre class="sourceCode r"><code class="sourceCode r"><span class="kw">reduce2</span>(<span class="kw">c</span>(<span class="st">&quot;a&quot;</span>, <span class="st">&quot;b&quot;</span>, <span class="st">&quot;c&quot;</span>, <span class="st">&quot;d&quot;</span>), <span class="kw">c</span>(<span class="st">&quot;-&quot;</span>, <span class="st">&quot;.&quot;</span>, <span class="st">&quot;-&quot;</span>), paste)</code></pre>

<pre><code>#&gt; [1] &quot;a b - c . d -&quot;</code></pre>

<p>
As funções dessas famílias ajudam a selecionar subconjuntos de elementos
de uma lista:
</p>
<pre class="sourceCode r"><code class="sourceCode r"><span class="co"># Manter ou descartar os ementos que atendem um predicado</span>
<span class="kw">keep</span>(<span class="kw">list</span>(<span class="dv">1</span>, <span class="dv">2</span>, <span class="st">&quot;c&quot;</span>, <span class="dv">4</span>, <span class="st">&quot;e&quot;</span>), is.character)</code></pre>

<pre><code>#&gt; [[1]]
#&gt; [1] &quot;c&quot;
#&gt; #&gt; [[2]]
#&gt; [1] &quot;e&quot;</code></pre>
<pre class="sourceCode r"><code class="sourceCode r"><span class="kw">discard</span>(<span class="kw">list</span>(<span class="dv">1</span>, <span class="dv">2</span>, <span class="st">&quot;c&quot;</span>, <span class="dv">4</span>, <span class="st">&quot;e&quot;</span>), is.character)</code></pre>

<pre><code>#&gt; [[1]]
#&gt; [1] 1
#&gt; #&gt; [[2]]
#&gt; [1] 2
#&gt; #&gt; [[3]]
#&gt; [1] 4</code></pre>
<pre class="sourceCode r"><code class="sourceCode r"><span class="co"># Atalho para discard(x, is.null)</span>
<span class="kw">compact</span>(<span class="kw">list</span>(<span class="ot">NULL</span>, <span class="ot">NULL</span>, <span class="dv">3</span>, <span class="ot">NULL</span>, <span class="dv">5</span>))</code></pre>

<pre><code>#&gt; [[1]]
#&gt; [1] 3
#&gt; #&gt; [[2]]
#&gt; [1] 5</code></pre>
<pre class="sourceCode r"><code class="sourceCode r"><span class="co"># Uma lista com sub listas</span>
lista &lt;-<span class="st"> </span><span class="kw">list</span>( <span class="dt">a =</span> <span class="kw">list</span>(<span class="dt">c =</span> <span class="dv">1</span>, <span class="dt">d =</span> <span class="dv">2</span>), <span class="dt">b =</span> <span class="kw">list</span>(<span class="dt">c =</span> <span class="dv">3</span>, <span class="dt">d =</span> <span class="dv">4</span>)) <span class="co"># Selecionar elementos por nome e &#xED;ndica</span>
<span class="kw">pluck</span>(lista, <span class="st">&quot;a&quot;</span>, <span class="dv">2</span>)</code></pre>

<pre><code>#&gt; [1] 2</code></pre>
<pre><code>#&gt; [1] 5</code></pre>
<pre class="sourceCode r"><code class="sourceCode r"><span class="co"># Lista de elementos com atributos</span>
lista_attr &lt;-<span class="st"> </span><span class="kw">list</span>( <span class="kw">structure</span>(<span class="st">&quot;a&quot;</span>, <span class="dt">atributo =</span> <span class="st">&quot;attr_c&quot;</span>), <span class="kw">structure</span>(<span class="st">&quot;b&quot;</span>, <span class="dt">atributo =</span> <span class="st">&quot;attr_d&quot;</span>)) <span class="co"># Selecionar atributo ao fim do pluck()</span>
<span class="kw">pluck</span>(lista_attr, <span class="dv">1</span>, <span class="kw">attr_getter</span>(<span class="st">&quot;atributo&quot;</span>))</code></pre>

<pre><code>#&gt; [1] &quot;attr_c&quot;</code></pre>

<p>
<code>modify()</code> parece muito com <code>map()</code>, mas ela
modifica um elemento no seu lugar:
</p>
<pre><code>#&gt; Sepal.Length Sepal.Width Petal.Length Petal.Width Species
#&gt; 1 5.1 3.5 1.4 0.2 setosa
#&gt; 2 4.9 3.0 1.4 0.2 setosa
#&gt; 3 4.7 3.2 1.3 0.2 setosa
#&gt; 4 4.6 3.1 1.5 0.2 setosa
#&gt; 5 5.0 3.6 1.4 0.2 setosa
#&gt; 6 5.4 3.9 1.7 0.4 setosa
#&gt; 7 4.6 3.4 1.4 0.3 setosa
#&gt; 8 5.0 3.4 1.5 0.2 setosa
#&gt; 9 4.4 2.9 1.4 0.2 setosa
#&gt; 10 4.9 3.1 1.5 0.1 setosa
#&gt; 11 5.4 3.7 1.5 0.2 setosa
#&gt; 12 4.8 3.4 1.6 0.2 setosa
#&gt; 13 4.8 3.0 1.4 0.1 setosa
#&gt; 14 4.3 3.0 1.1 0.1 setosa
#&gt; 15 5.8 4.0 1.2 0.2 setosa
#&gt; [ reached getOption(&quot;max.print&quot;) -- omitted 135 rows ]</code></pre>
<pre class="sourceCode r"><code class="sourceCode r"><span class="co"># Modificar colunas sem alterar as outras</span>
<span class="kw">modify_if</span>(iris, is.factor, as.character)</code></pre>

<pre><code>#&gt; Sepal.Length Sepal.Width Petal.Length Petal.Width Species
#&gt; 1 5.1 3.5 1.4 0.2 setosa
#&gt; 2 4.9 3.0 1.4 0.2 setosa
#&gt; 3 4.7 3.2 1.3 0.2 setosa
#&gt; 4 4.6 3.1 1.5 0.2 setosa
#&gt; 5 5.0 3.6 1.4 0.2 setosa
#&gt; 6 5.4 3.9 1.7 0.4 setosa
#&gt; 7 4.6 3.4 1.4 0.3 setosa
#&gt; 8 5.0 3.4 1.5 0.2 setosa
#&gt; 9 4.4 2.9 1.4 0.2 setosa
#&gt; 10 4.9 3.1 1.5 0.1 setosa
#&gt; 11 5.4 3.7 1.5 0.2 setosa
#&gt; 12 4.8 3.4 1.6 0.2 setosa
#&gt; 13 4.8 3.0 1.4 0.1 setosa
#&gt; 14 4.3 3.0 1.1 0.1 setosa
#&gt; 15 5.8 4.0 1.2 0.2 setosa
#&gt; [ reached getOption(&quot;max.print&quot;) -- omitted 135 rows ]</code></pre>
<pre class="sourceCode r"><code class="sourceCode r"><span class="kw">modify_at</span>(iris, <span class="dv">1</span><span class="op">:</span><span class="dv">4</span>, as.integer)</code></pre>

<pre><code>#&gt; Sepal.Length Sepal.Width Petal.Length Petal.Width Species
#&gt; 1 5 3 1 0 setosa
#&gt; 2 4 3 1 0 setosa
#&gt; 3 4 3 1 0 setosa
#&gt; 4 4 3 1 0 setosa
#&gt; 5 5 3 1 0 setosa
#&gt; 6 5 3 1 0 setosa
#&gt; 7 4 3 1 0 setosa
#&gt; 8 5 3 1 0 setosa
#&gt; 9 4 2 1 0 setosa
#&gt; 10 4 3 1 0 setosa
#&gt; 11 5 3 1 0 setosa
#&gt; 12 4 3 1 0 setosa
#&gt; 13 4 3 1 0 setosa
#&gt; 14 4 3 1 0 setosa
#&gt; 15 5 4 1 0 setosa
#&gt; [ reached getOption(&quot;max.print&quot;) -- omitted 135 rows ]</code></pre>
<pre class="sourceCode r"><code class="sourceCode r"><span class="co"># Uma lista profunda</span>
lista_prof &lt;-<span class="st"> </span><span class="kw">list</span>( <span class="dt">a =</span> <span class="kw">list</span>( <span class="dt">c =</span> <span class="kw">list</span>(<span class="dv">1</span><span class="op">:</span><span class="dv">3</span>, <span class="dv">4</span><span class="op">:</span><span class="dv">6</span>), <span class="dt">d =</span> <span class="kw">list</span>(<span class="dv">7</span><span class="op">:</span><span class="dv">9</span>, <span class="dv">10</span><span class="op">:</span><span class="dv">12</span>)), <span class="dt">b =</span> <span class="kw">list</span>( <span class="dt">e =</span> <span class="kw">list</span>(<span class="dv">13</span><span class="op">:</span><span class="dv">15</span>, <span class="dv">16</span><span class="op">:</span><span class="dv">18</span>), <span class="dt">f =</span> <span class="kw">list</span>(<span class="dv">19</span><span class="op">:</span><span class="dv">21</span>, <span class="dv">22</span><span class="op">:</span><span class="dv">24</span>))) <span class="co"># Modificar em uma profundidade espec&#xED;fica</span>
<span class="kw">str</span>(lista_prof)</code></pre>

<pre><code>#&gt; List of 2
#&gt; $ a:List of 2
#&gt; ..$ c:List of 2
#&gt; .. ..$ : int [1:3] 1 2 3
#&gt; .. ..$ : int [1:3] 4 5 6
#&gt; ..$ d:List of 2
#&gt; .. ..$ : int [1:3] 7 8 9
#&gt; .. ..$ : int [1:3] 10 11 12
#&gt; $ b:List of 2
#&gt; ..$ e:List of 2
#&gt; .. ..$ : int [1:3] 13 14 15
#&gt; .. ..$ : int [1:3] 16 17 18
#&gt; ..$ f:List of 2
#&gt; .. ..$ : int [1:3] 19 20 21
#&gt; .. ..$ : int [1:3] 22 23 24</code></pre>
<pre class="sourceCode r"><code class="sourceCode r"><span class="kw">modify_depth</span>(lista_prof, <span class="dv">3</span>, sum) <span class="op">%&gt;%</span><span class="st"> </span><span class="kw">str</span>()</code></pre>

<pre><code>#&gt; List of 2
#&gt; $ a:List of 2
#&gt; ..$ c:List of 2
#&gt; .. ..$ : int 6
#&gt; .. ..$ : int 15
#&gt; ..$ d:List of 2
#&gt; .. ..$ : int 24
#&gt; .. ..$ : int 33
#&gt; $ b:List of 2
#&gt; ..$ e:List of 2
#&gt; .. ..$ : int 42
#&gt; .. ..$ : int 51
#&gt; ..$ f:List of 2
#&gt; .. ..$ : int 60
#&gt; .. ..$ : int 69</code></pre>

<p>
A família list tem funções interessantes para trabalhar com listas no
geral:
</p>
<pre class="sourceCode r"><code class="sourceCode r"><span class="co"># Opera&#xE7;&#xF5;es boas para vetores</span>
<span class="kw">set_names</span>(<span class="kw">c</span>(<span class="st">&quot;a&quot;</span>, <span class="st">&quot;b&quot;</span>, <span class="st">&quot;c&quot;</span>), <span class="kw">c</span>(<span class="st">&quot;nome1&quot;</span>, <span class="st">&quot;nome2&quot;</span>, <span class="st">&quot;nome3&quot;</span>))</code></pre>

<pre><code>#&gt; nome1 nome2 nome3 #&gt; &quot;a&quot; &quot;b&quot; &quot;c&quot;</code></pre>
<pre><code>#&gt; [1] 6 7 8 9 10 1 2 3 4 5</code></pre>
<pre class="sourceCode r"><code class="sourceCode r"><span class="co"># Uma lista com sub listas</span>
lista &lt;-<span class="st"> </span><span class="kw">list</span>( <span class="dt">a =</span> <span class="kw">list</span>(<span class="dt">c =</span> <span class="dv">1</span>, <span class="dt">d =</span> <span class="dv">2</span>), <span class="dt">b =</span> <span class="kw">list</span>(<span class="dt">c =</span> <span class="dv">3</span>, <span class="dt">d =</span> <span class="dv">4</span>)) <span class="co"># Transposi&#xE7;&#xE3;o</span>
<span class="kw">str</span>(lista)</code></pre>

<pre><code>#&gt; List of 2
#&gt; $ a:List of 2
#&gt; ..$ c: num 1
#&gt; ..$ d: num 2
#&gt; $ b:List of 2
#&gt; ..$ c: num 3
#&gt; ..$ d: num 4</code></pre>
<pre class="sourceCode r"><code class="sourceCode r"><span class="kw">transpose</span>(lista) <span class="op">%&gt;%</span><span class="st"> </span><span class="kw">str</span>()</code></pre>

<pre><code>#&gt; List of 2
#&gt; $ c:List of 2
#&gt; ..$ a: num 1
#&gt; ..$ b: num 3
#&gt; $ d:List of 2
#&gt; ..$ a: num 2
#&gt; ..$ b: num 4</code></pre>
<pre class="sourceCode r"><code class="sourceCode r"><span class="co"># Juntar listas</span>
purrr<span class="op">::</span><span class="kw">splice</span>(<span class="kw">list</span>(<span class="dt">a =</span> <span class="dv">1</span>, <span class="dt">b =</span> <span class="dv">2</span>), <span class="dt">c =</span> <span class="dv">3</span><span class="op">:</span><span class="dv">4</span>, <span class="dt">z =</span> <span class="kw">list</span>(<span class="dt">d =</span> <span class="dv">2</span><span class="op">:</span><span class="dv">5</span>, <span class="dt">e =</span> <span class="dv">3</span>)) <span class="op">%&gt;%</span><span class="st"> </span><span class="kw">str</span>()</code></pre>

<pre><code>#&gt; List of 5
#&gt; $ a: num 1
#&gt; $ b: num 2
#&gt; $ c: int [1:2] 3 4
#&gt; $ d: int [1:4] 2 3 4 5
#&gt; $ e: num 3</code></pre>
<pre class="sourceCode r"><code class="sourceCode r"><span class="kw">list_merge</span>(<span class="kw">list</span>(<span class="dt">a =</span> <span class="dv">1</span>, <span class="dt">b =</span> <span class="dv">2</span>), <span class="dt">c =</span> <span class="dv">3</span><span class="op">:</span><span class="dv">4</span>, <span class="dt">z =</span> <span class="kw">list</span>(<span class="dt">d =</span> <span class="dv">2</span><span class="op">:</span><span class="dv">5</span>, <span class="dt">e =</span> <span class="dv">3</span>)) <span class="op">%&gt;%</span><span class="st"> </span><span class="kw">str</span>()</code></pre>

<pre><code>#&gt; List of 4
#&gt; $ a: num 1
#&gt; $ b: num 2
#&gt; $ c: int [1:2] 3 4
#&gt; $ z:List of 2
#&gt; ..$ d: int [1:4] 2 3 4 5
#&gt; ..$ e: num 3</code></pre>
<pre class="sourceCode r"><code class="sourceCode r"><span class="co"># Alterar um elemento</span>
<span class="kw">list_modify</span>(lista, <span class="dt">b =</span> <span class="dv">20</span>) <span class="op">%&gt;%</span><span class="st"> </span><span class="kw">str</span>()</code></pre>

<pre><code>#&gt; List of 2
#&gt; $ a:List of 2
#&gt; ..$ c: num 1
#&gt; ..$ d: num 2
#&gt; $ b: num 20</code></pre>

<p>
Esta família serve para detectar elementos em uma lista, possivelmente
com algum truque adicional na manga:
</p>
<pre class="sourceCode r"><code class="sourceCode r"><span class="co"># Qual &#xE9; o primeiro elemento que atende ao predicado</span>
<span class="kw">detect</span>(<span class="dv">3</span><span class="op">:</span><span class="dv">6</span>, <span class="op">~</span>.x <span class="op">%%</span><span class="st"> </span><span class="dv">2</span> <span class="op">==</span><span class="st"> </span><span class="dv">0</span>)</code></pre>

<pre><code>#&gt; [1] 4</code></pre>
<pre class="sourceCode r"><code class="sourceCode r"><span class="kw">detect_index</span>(<span class="dv">3</span><span class="op">:</span><span class="dv">6</span>, <span class="op">~</span>.x <span class="op">%%</span><span class="st"> </span><span class="dv">2</span> <span class="op">==</span><span class="st"> </span><span class="dv">0</span>)</code></pre>

<pre><code>#&gt; [1] 2</code></pre>
<pre class="sourceCode r"><code class="sourceCode r"><span class="co"># Uma lista com sub listas</span>
lista &lt;-<span class="st"> </span><span class="kw">list</span>( <span class="dt">a =</span> <span class="kw">list</span>(<span class="dt">c =</span> <span class="dv">1</span>, <span class="dt">d =</span> <span class="dv">2</span>), <span class="dt">b =</span> <span class="kw">list</span>(<span class="dt">c =</span> <span class="dv">3</span>, <span class="dt">d =</span> <span class="dv">4</span>)) <span class="co"># Verifica&#xE7;&#xE3;o forte dos elementos</span>
<span class="kw">has_element</span>(lista, <span class="kw">list</span>(<span class="dt">c =</span> <span class="dv">3</span>, <span class="dt">d =</span> <span class="dv">4</span>))</code></pre>

<pre><code>#&gt; [1] TRUE</code></pre>
<pre class="sourceCode r"><code class="sourceCode r"><span class="co"># Absta&#xE7;&#xE3;o de while</span>
<span class="kw">head_while</span>(<span class="dv">5</span><span class="op">:-</span><span class="dv">5</span>, <span class="op">~</span>.x <span class="op">&gt;</span><span class="st"> </span><span class="dv">0</span>)</code></pre>

<pre><code>#&gt; [1] 5 4 3 2 1</code></pre>
<pre class="sourceCode r"><code class="sourceCode r"><span class="kw">tail_while</span>(<span class="dv">5</span><span class="op">:-</span><span class="dv">5</span>, <span class="op">~</span>.x <span class="op">&lt;</span><span class="st"> </span><span class="dv">0</span>)</code></pre>

<pre><code>#&gt; [1] -1 -2 -3 -4 -5</code></pre>

<p>
Como seu próprio nome indica, essa família faz cruzamentos de listas:
</p>
<pre class="sourceCode r"><code class="sourceCode r"><span class="co"># Uma lista de cumprimentos</span>
lista_ola &lt;-<span class="st"> </span><span class="kw">list</span>( <span class="dt">nome =</span> <span class="kw">c</span>(<span class="st">&quot;Jo&#xE3;o&quot;</span>, <span class="st">&quot;Joana&quot;</span>), <span class="dt">ola =</span> <span class="kw">c</span>(<span class="st">&quot;Oi.&quot;</span>, <span class="st">&quot;Ol&#xE1;.&quot;</span>), <span class="dt">sep =</span> <span class="kw">c</span>(<span class="st">&quot;! &quot;</span>, <span class="st">&quot;... &quot;</span>)) <span class="co"># Todos os cruzamento da lista</span>
<span class="kw">cross</span>(lista_ola) <span class="op">%&gt;%</span><span class="st"> </span><span class="kw">str</span>()</code></pre>

<pre><code>#&gt; List of 8
#&gt; $ :List of 3
#&gt; ..$ nome: chr &quot;Jo&#xE3;o&quot;
#&gt; ..$ ola : chr &quot;Oi.&quot;
#&gt; ..$ sep : chr &quot;! &quot;
#&gt; $ :List of 3
#&gt; ..$ nome: chr &quot;Joana&quot;
#&gt; ..$ ola : chr &quot;Oi.&quot;
#&gt; ..$ sep : chr &quot;! &quot;
#&gt; $ :List of 3
#&gt; ..$ nome: chr &quot;Jo&#xE3;o&quot;
#&gt; ..$ ola : chr &quot;Ol&#xE1;.&quot;
#&gt; ..$ sep : chr &quot;! &quot;
#&gt; $ :List of 3
#&gt; ..$ nome: chr &quot;Joana&quot;
#&gt; ..$ ola : chr &quot;Ol&#xE1;.&quot;
#&gt; ..$ sep : chr &quot;! &quot;
#&gt; $ :List of 3
#&gt; ..$ nome: chr &quot;Jo&#xE3;o&quot;
#&gt; ..$ ola : chr &quot;Oi.&quot;
#&gt; ..$ sep : chr &quot;... &quot;
#&gt; $ :List of 3
#&gt; ..$ nome: chr &quot;Joana&quot;
#&gt; ..$ ola : chr &quot;Oi.&quot;
#&gt; ..$ sep : chr &quot;... &quot;
#&gt; $ :List of 3
#&gt; ..$ nome: chr &quot;Jo&#xE3;o&quot;
#&gt; ..$ ola : chr &quot;Ol&#xE1;.&quot;
#&gt; ..$ sep : chr &quot;... &quot;
#&gt; $ :List of 3
#&gt; ..$ nome: chr &quot;Joana&quot;
#&gt; ..$ ola : chr &quot;Ol&#xE1;.&quot;
#&gt; ..$ sep : chr &quot;... &quot;</code></pre>
<pre><code>#&gt; # A tibble: 8 x 3
#&gt; sep nome sep ola #&gt; sep &lt;chr&gt;sep &lt;chr&gt;
#&gt; 1&quot;! &quot; Jo&#xE3;o &quot;! &quot; Oi. #&gt; 2&quot;! &quot; Joana&quot;! &quot; Oi. #&gt; 3&quot;! &quot; Jo&#xE3;o &quot;! &quot; Ol&#xE1;. #&gt; 4&quot;! &quot; Joana&quot;! &quot; Ol&#xE1;. #&gt; 5&quot;! &quot; Jo&#xE3;o &quot;! &quot; Oi. #&gt; 6&quot;! &quot; Joana&quot;! &quot; Oi. #&gt; 7&quot;! &quot; Jo&#xE3;o &quot;! &quot; Ol&#xE1;. #&gt; 8&quot;! &quot; Joana&quot;! &quot; Ol&#xE1;.</code></pre>
<pre class="sourceCode r"><code class="sourceCode r"><span class="co"># Cruzando mais de um objeto e usando filtros</span>
<span class="kw">cross2</span>(<span class="kw">seq_len</span>(<span class="dv">3</span>), <span class="kw">seq_len</span>(<span class="dv">3</span>), <span class="dt">.filter =</span> <span class="st">`</span><span class="dt">==</span><span class="st">`</span>) <span class="op">%&gt;%</span><span class="st"> </span><span class="kw">str</span>()</code></pre>

<pre><code>#&gt; List of 6
#&gt; $ :List of 2
#&gt; ..$ : int 2
#&gt; ..$ : int 1
#&gt; $ :List of 2
#&gt; ..$ : int 3
#&gt; ..$ : int 1
#&gt; $ :List of 2
#&gt; ..$ : int 1
#&gt; ..$ : int 2
#&gt; $ :List of 2
#&gt; ..$ : int 3
#&gt; ..$ : int 2
#&gt; $ :List of 2
#&gt; ..$ : int 1
#&gt; ..$ : int 3
#&gt; $ :List of 2
#&gt; ..$ : int 2
#&gt; ..$ : int 3</code></pre>

<p>
Estas funções são bastante simples e servem para verificar/mudar o tipo
dos objetos:
</p>
<pre><code>#&gt; [1] TRUE</code></pre>
<pre><code>#&gt; [1] FALSE</code></pre>
<pre><code>#&gt; [1] TRUE</code></pre>
<pre><code>#&gt; [1] FALSE</code></pre>
<pre class="sourceCode r"><code class="sourceCode r"><span class="co"># As</span>
<span class="kw">as_function</span>(<span class="op">~</span>.x <span class="op">+</span><span class="st"> </span><span class="dv">1</span>)(<span class="dv">2</span>)</code></pre>

<pre><code>#&gt; [1] 3</code></pre>

<p>
<code>invoke()</code> e suas variações permite que chamemos funções a
partir de listas de argumentos:
</p>
<pre class="sourceCode r"><code class="sourceCode r"><span class="kw">invoke</span>(runif, <span class="kw">list</span>(<span class="dt">n =</span> <span class="dv">3</span>, <span class="dt">max =</span> <span class="dv">2</span>))</code></pre>

<pre><code>#&gt; [1] 1.9000418 0.5048949 0.4812034</code></pre>
<pre class="sourceCode r"><code class="sourceCode r"><span class="co"># Aplicar uma ou mais listas de argumentos em uma ou mais fun&#xE7;&#xF5;es</span>
<span class="kw">invoke_map</span>(runif, <span class="kw">list</span>(<span class="kw">list</span>(<span class="dt">n =</span> <span class="dv">2</span>), <span class="kw">list</span>(<span class="dt">n =</span> <span class="dv">4</span>)))</code></pre>

<pre><code>#&gt; [[1]]
#&gt; [1] 0.7236003 0.6300159
#&gt; #&gt; [[2]]
#&gt; [1] 0.5805828 0.4086842 0.3266907 0.6376649</code></pre>
<pre class="sourceCode r"><code class="sourceCode r"><span class="kw">invoke_map</span>(<span class="kw">list</span>(runif, rnorm), <span class="kw">list</span>(<span class="kw">list</span>(<span class="dt">n =</span> <span class="dv">2</span>), <span class="kw">list</span>(<span class="dt">n =</span> <span class="dv">4</span>)))</code></pre>

<pre><code>#&gt; [[1]]
#&gt; [1] 0.01122804 0.43480434
#&gt; #&gt; [[2]]
#&gt; [1] 0.1194085 0.5797116 -0.7544495 0.2237387</code></pre>
<pre class="sourceCode r"><code class="sourceCode r"><span class="co"># E assim por diante...</span>
<span class="kw">invoke_map_dbl</span>(<span class="kw">list</span>(<span class="dt">m1 =</span> mean, <span class="dt">m2 =</span> median) , <span class="dt">x =</span> <span class="kw">rcauchy</span>(<span class="dv">100</span>))</code></pre>

<pre><code>#&gt; m1 m2 #&gt; -0.18213999 -0.01205544</code></pre>

<p>
Essa pequena família simplifica vetores e listas:
</p>
<pre class="sourceCode r"><code class="sourceCode r"><span class="co"># Achatar mantendo os nomes</span>
<span class="kw">as_vector</span>(<span class="kw">list</span>(<span class="dt">a =</span> <span class="dv">1</span>, <span class="dt">b =</span> <span class="dv">2</span>))</code></pre>

<pre><code>#&gt; a b #&gt; 1 2</code></pre>
<pre class="sourceCode r"><code class="sourceCode r"><span class="co"># Aplicar simplify() em cada elemento de uma lista</span>
<span class="kw">simplify_all</span>(lista) <span class="op">%&gt;%</span><span class="st"> </span><span class="kw">str</span>()</code></pre>

<pre><code>#&gt; List of 2
#&gt; $ a: Named num [1:2] 1 2
#&gt; ..- attr(*, &quot;names&quot;)= chr [1:2] &quot;c&quot; &quot;d&quot;
#&gt; $ b: Named num [1:2] 3 4
#&gt; ..- attr(*, &quot;names&quot;)= chr [1:2] &quot;c&quot; &quot;d&quot;</code></pre>

<p>
É raro precisarmos usar essas duas funções, mas podem vir a calhar
quando usando arrays:
</p>
<pre class="sourceCode r"><code class="sourceCode r"><span class="co"># Uma array</span>
arr &lt;-<span class="st"> </span><span class="kw">array</span>(<span class="dv">1</span><span class="op">:</span><span class="dv">12</span>, <span class="kw">c</span>(<span class="dv">2</span>, <span class="dv">2</span>, <span class="dv">3</span>)) <span class="co"># Transformando a array em uma lista (&#xE1;rvore)</span>
<span class="kw">array_tree</span>(arr) <span class="op">%&gt;%</span><span class="st"> </span><span class="kw">str</span>()</code></pre>

<pre><code>#&gt; List of 2
#&gt; $ :List of 2
#&gt; ..$ :List of 3
#&gt; .. ..$ : int 1
#&gt; .. ..$ : int 5
#&gt; .. ..$ : int 9
#&gt; ..$ :List of 3
#&gt; .. ..$ : int 3
#&gt; .. ..$ : int 7
#&gt; .. ..$ : int 11
#&gt; $ :List of 2
#&gt; ..$ :List of 3
#&gt; .. ..$ : int 2
#&gt; .. ..$ : int 6
#&gt; .. ..$ : int 10
#&gt; ..$ :List of 3
#&gt; .. ..$ : int 4
#&gt; .. ..$ : int 8
#&gt; .. ..$ : int 12</code></pre>
<pre class="sourceCode r"><code class="sourceCode r"><span class="kw">array_tree</span>(arr, <span class="kw">c</span>(<span class="dv">1</span>, <span class="dv">3</span>)) <span class="op">%&gt;%</span><span class="st"> </span><span class="kw">str</span>()</code></pre>

<pre><code>#&gt; List of 2
#&gt; $ :List of 3
#&gt; ..$ : int [1:2] 1 3
#&gt; ..$ : int [1:2] 5 7
#&gt; ..$ : int [1:2] 9 11
#&gt; $ :List of 3
#&gt; ..$ : int [1:2] 2 4
#&gt; ..$ : int [1:2] 6 8
#&gt; ..$ : int [1:2] 10 12</code></pre>
<pre class="sourceCode r"><code class="sourceCode r"><span class="co"># Cria uma lista achatada (um ramo)</span>
<span class="kw">array_branch</span>(arr, <span class="kw">c</span>(<span class="dv">1</span>, <span class="dv">3</span>)) <span class="op">%&gt;%</span><span class="st"> </span><span class="kw">str</span>()</code></pre>

<pre><code>#&gt; List of 6
#&gt; $ : int [1:2] 1 3
#&gt; $ : int [1:2] 2 4
#&gt; $ : int [1:2] 5 7
#&gt; $ : int [1:2] 6 8
#&gt; $ : int [1:2] 9 11
#&gt; $ : int [1:2] 10 12</code></pre>

<p>
Essas duas famílias são um pouco obscuras, mas têm propriedades
interessantes para trabalhar com funções
</p>
<pre class="sourceCode r"><code class="sourceCode r"><span class="co"># Preencher os argumentos de uma fun&#xE7;&#xE3;o</span>
runif_com_max &lt;-<span class="st"> </span><span class="kw">partial</span>(runif, <span class="dt">max =</span> <span class="dv">10</span>)
<span class="kw">runif_com_max</span>(<span class="dv">3</span>)</code></pre>

<pre><code>#&gt; [1] 2.519351 6.554200 2.708141</code></pre>
<pre class="sourceCode r"><code class="sourceCode r"><span class="co"># Compor fun&#xE7;&#xF5;es</span>
runif_sum &lt;-<span class="st"> </span><span class="kw">compose</span>(sum, runif)
<span class="kw">runif_sum</span>(<span class="dv">3</span>)</code></pre>

<pre><code>#&gt; [1] 1.916666</code></pre>
<pre class="sourceCode r"><code class="sourceCode r"><span class="co"># Trocar o que uma fun&#xE7;&#xE3;o recebe (dots -&gt; list)</span>
mean_list &lt;-<span class="st"> </span><span class="kw">lift_dl</span>(mean)
<span class="kw">mean_list</span>(<span class="kw">list</span>(<span class="dt">x =</span> <span class="dv">1</span><span class="op">:</span><span class="dv">10</span>, <span class="dt">na.rm =</span> <span class="ot">TRUE</span>))</code></pre>

<pre><code>#&gt; [1] 5.5</code></pre>
<pre class="sourceCode r"><code class="sourceCode r"><span class="co"># E fazer o contr&#xE1;rio</span>
mean_dots &lt;-<span class="st"> </span><span class="kw">lift_ld</span>(mean_list)
<span class="kw">mean_dots</span>(<span class="dv">1</span><span class="op">:</span><span class="dv">10</span>, <span class="ot">NA</span>, <span class="dt">na.rm =</span> <span class="ot">TRUE</span>, <span class="dt">trim =</span> <span class="dv">0</span>)</code></pre>

<pre><code>#&gt; [1] 5.5</code></pre>

<p>
Apesar de estar perto do final, esta é uma das famílias mais
importantes! Ela captura erros e permite que o seu map rode sem ter
problemas:
</p>
<pre class="sourceCode r"><code class="sourceCode r"><span class="co"># Capturando erros na fun&#xE7;&#xE3;o runif</span>
runif_p &lt;-<span class="st"> </span><span class="kw">possibly</span>(runif, <span class="dt">otherwise =</span> <span class="st">&quot;Erro&quot;</span>)
mean_q &lt;-<span class="st"> </span><span class="kw">quietly</span>(mean)
runif_s &lt;-<span class="st"> </span><span class="kw">safely</span>(runif) <span class="co"># Aplicando fun&#xE7;&#xF5;es que v&#xE3;o dar errado</span>
<span class="kw">runif_p</span>(<span class="st">&quot;abc&quot;</span>)</code></pre>

<pre><code>#&gt; [1] &quot;Erro&quot;</code></pre>
<pre><code>#&gt; $result
#&gt; [1] NA
#&gt; #&gt; $output
#&gt; [1] &quot;&quot;
#&gt; #&gt; $warnings
#&gt; [1] &quot;argument is not numeric or logical: returning NA&quot;
#&gt; #&gt; $messages
#&gt; character(0)</code></pre>
<pre><code>#&gt; $result
#&gt; NULL
#&gt; #&gt; $error
#&gt; &lt;simpleError in .f(...): invalid arguments&gt;</code></pre>

<p>
Algumas abstrações de funções lógicas úteis para quando precisamos
pipear alguma verificação:
</p>
<pre class="sourceCode r"><code class="sourceCode r"><span class="co"># Todos e alguns</span>
<span class="kw">every</span>(<span class="dv">1</span><span class="op">:</span><span class="dv">5</span>, <span class="op">~</span>.x <span class="op">&gt;</span><span class="st"> </span><span class="dv">2</span>)</code></pre>

<pre><code>#&gt; [1] FALSE</code></pre>
<pre><code>#&gt; [1] TRUE</code></pre>
<pre class="sourceCode r"><code class="sourceCode r"><span class="co"># Criar um predicado negando outro</span>
<span class="kw">keep</span>(<span class="dv">1</span><span class="op">:</span><span class="dv">5</span>, <span class="kw">negate</span>(<span class="op">~</span>.x <span class="op">&gt;</span><span class="st"> </span><span class="dv">2</span>))</code></pre>

<pre><code>#&gt; [1] 1 2</code></pre>
<pre class="sourceCode r"><code class="sourceCode r"><span class="co"># Abstra&#xE7;&#xE3;o de if-else</span>
<span class="dv">1</span><span class="op">:</span><span class="dv">10</span> <span class="op">%&gt;%</span><span class="st"> </span><span class="kw">when</span>( <span class="kw">sum</span>(.) <span class="op">&lt;=</span><span class="st"> </span><span class="dv">50</span> <span class="op">~</span><span class="st"> </span><span class="kw">sum</span>(.), <span class="kw">sum</span>(.) <span class="op">&lt;=</span><span class="st"> </span><span class="dv">100</span> <span class="op">~</span><span class="st"> </span><span class="kw">sum</span>(.)<span class="op">/</span><span class="dv">2</span>, <span class="op">~</span><span class="st"> </span><span class="dv">0</span>)</code></pre>

<pre><code>#&gt; [1] 27.5</code></pre>

<p>
Nessa família residem algumas funções miscelâneas que não se encaixam em
nenhuma outra família:
</p>
<pre class="sourceCode r"><code class="sourceCode r"><span class="co"># OR com NULL</span>
<span class="ot">TRUE</span> <span class="op">%||%</span><span class="st"> </span><span class="ot">NULL</span></code></pre>

<pre><code>#&gt; [1] TRUE</code></pre>
<pre><code>#&gt; [1] FALSE</code></pre>
<pre class="sourceCode r"><code class="sourceCode r"><span class="co"># Seletor de atributos</span>
a &lt;-<span class="st"> </span><span class="kw">structure</span>(<span class="st">&quot;a&quot;</span>, <span class="dt">atributo =</span> <span class="st">&quot;b&quot;</span>)
a <span class="op">%@%</span><span class="st"> &quot;atributo&quot;</span></code></pre>

<pre><code>#&gt; [1] &quot;b&quot;</code></pre>
<pre class="sourceCode r"><code class="sourceCode r"><span class="co"># Outras distribui&#xE7;&#xF5;es</span>
<span class="kw">rbernoulli</span>(<span class="dv">5</span>)</code></pre>

<pre><code>#&gt; [1] FALSE TRUE FALSE FALSE TRUE</code></pre>
<pre><code>#&gt; [1] 4 2 7 7 5</code></pre>
<pre class="sourceCode r"><code class="sourceCode r"><span class="co"># Rodar v&#xE1;rias vezes</span>
<span class="kw">rerun</span>(<span class="dv">5</span>, <span class="kw">runif</span>(<span class="dv">3</span>))</code></pre>

<pre><code>#&gt; [[1]]
#&gt; [1] 0.1127942 0.6949582 0.6494539
#&gt; #&gt; [[2]]
#&gt; [1] 0.1771876 0.1202818 0.5430234
#&gt; #&gt; [[3]]
#&gt; [1] 0.4268469 0.4710781 0.2223345
#&gt; #&gt; [[4]]
#&gt; [1] 0.01703616 0.65161687 0.22971180
#&gt; #&gt; [[5]]
#&gt; [1] 0.5358678 0.7776529 0.3097722</code></pre>

