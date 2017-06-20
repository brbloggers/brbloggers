+++
title = "Pacote rslp"
date = "2016-07-15"
categories = ["dfalbel"]
original_url = "http://dfalbel.github.io/2016/07/rslp-pacote.html"
+++

<p class="post">
<article class="post-content">
<p>
No <a href="https://github.com/dfalbel/">meu github</a> você pode
encontrar o pacote
<a href="https://github.com/dfalbel/rslp"><code class="highlighter-rouge">rslp</code></a>.
</p>
<p>
Esse pacote implementa o algoritmo <em>Stemming Algorithm for the
Portuguese Language</em> descrito
<a href="http://homes.dcc.ufba.br/~dclaro/download/mate04/Artigo%20Erick.pdf">neste
artigo</a> escrito por Viviane Moreira Orengo e Christian Huyck.
</p>
<p>
A ideia do algoritmo de stemming é muito bem explciada pelo diagrama
abaixo.
</p>
<p>
<img src="http://dfalbel.github.io/images/schema-rslp.PNG" alt="Schema">
</p>
<h2 id="instalando">
Instalando
</h2>
<p>
O pacote pode ser instalado usando o
<code class="highlighter-rouge">devtools</code>, pois ainda não está
disponível no CRAN.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">devtools</span><span class="o">::</span><span class="n">install_github</span><span class="p">(</span><span class="s2">&quot;dfalbel/rslp&quot;</span><span class="p">)</span></code></pre>
</figure>
<h2 id="usando">
Usando
</h2>
<p>
As únicas funções importantes do pacote são:
<code class="highlighter-rouge">rslp</code> e
<code class="highlighter-rouge">rslp\_doc</code>. A primeira, recebe um
vetor de palavras e retorna um vetor de palavras <em>stemizadas</em>. Já
a segunda recebe um vetor de sentenças e retorna o mesmo vetor com as
palavras <em>stemizadas</em>.
</p>
<p>
Veja os exemplos abaixo:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">library</span><span class="p">(</span><span class="n">rslp</span><span class="p">)</span><span class="w">
</span><span class="n">words</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="s2">&quot;bal&#xF5;es&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;avi&#xF5;es&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;avi&#xE3;o&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;gostou&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;gosto&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;gostaram&quot;</span><span class="p">)</span><span class="w">
</span><span class="n">rslp</span><span class="p">(</span><span class="n">words</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## [1] &quot;bal&quot; &quot;avi&quot; &quot;avi&quot; &quot;gost&quot; &quot;gost&quot; &quot;gost&quot;</code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-r"><span class="n">docs</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="w"> </span><span class="s2">&quot;coma frutas pois elas fazem bem para a sa&#xFA;de.&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;n&#xE3;o coma doces, eles fazem mal para os dentes.&quot;</span><span class="w"> </span><span class="p">)</span><span class="w">
</span><span class="n">rslp_doc</span><span class="p">(</span><span class="n">docs</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## [1] &quot;com frut poi el faz bem par a saud.&quot; ## [2] &quot;nao com doc, ele faz mal par os dent.&quot;</code></pre>
</figure>
<p>
Esse pacote agora está no
<a href="https://cran.r-project.org/web/packages/rslp/index.html">CRAN</a>!!
Em breve ele poderá ser instalado usando
<code class="highlighter-rouge">install.packages("rslp")</code>.
</p>
</article>
<br> <ins class="adsbygoogle"></ins> <br>
</p>

