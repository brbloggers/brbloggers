+++
title = "Transição Demográfica no Brasil"
date = "2016-10-11 03:00:00"
categories = ["r-python-e-redes"]
original_url = "http://neylsoncrepalde.github.io/2016-10-11-transicao-demografica-no-brasil/"
+++

<article class="blog-post">
<p>
Vamos usar o pacote <code class="highlighter-rouge">rChart</code> de
Ramnath Vaidyanathan para montar um gráfico animado da pirâmide etária
no Brasil desde 1970 até o ano 2050. É necessário ter os pacotes
<code class="highlighter-rouge">devtools</code>,
<code class="highlighter-rouge">reshape2</code>,
<code class="highlighter-rouge">plyr</code> e
<code class="highlighter-rouge">XML</code> instalados. Se não, execute
esta linha de comando
</p>
<pre class="highlight"><code><span class="n">install.packages</span><span class="p">(</span><span class="nf">c</span><span class="p">(</span><span class="s1">&apos;XML&apos;</span><span class="p">,</span><span class="w"> </span><span class="s1">&apos;reshape2&apos;</span><span class="p">,</span><span class="w"> </span><span class="s1">&apos;devtools&apos;</span><span class="p">,</span><span class="w"> </span><span class="s1">&apos;plyr&apos;</span><span class="p">))</span><span class="w">
</span></code></pre>

<p>
Depois disso, carregue o pacote
<code class="highlighter-rouge">devtools</code> para que façamos a
instalação do pacote.
</p>
<pre class="highlight"><code><span class="n">install_github</span><span class="p">(</span><span class="s1">&apos;ramnathv/rCharts@dev&apos;</span><span class="p">)</span><span class="w">
</span></code></pre>

<p>
Agora, vamos carregar algumas funções para raspagem e plotagem desses
dados escritas por Kyle Walker. Se você estiver usando o RStudio
(altamente recomendável), use este comando:
</p>
<pre class="highlight"><code><span class="n">source</span><span class="p">(</span><span class="s1">&apos;https://raw.githubusercontent.com/walkerke/teaching-with-datavis/master/pyramids/rcharts_pyramids.R&apos;</span><span class="p">)</span><span class="w">
</span></code></pre>

<p>
Para um tutorial completo do uso do pacote, acesse
<a href="http://walkerke.github.io/2014/06/rcharts-pyramids/">este
post</a>. Por ora, vamos focar apenas em nosso objetivo: plotar a
transição demográfica no Brasil. Vamos plotar as pirâmides etárias do
Brasil do ano 1970 até 2050 com intervalos de 5 anos. Veja como a
população brasileira se comporta no período.
</p>
<pre class="highlight"><code><span class="n">dPyramid</span><span class="p">(</span><span class="s1">&apos;BR&apos;</span><span class="p">,</span><span class="w"> </span><span class="n">seq</span><span class="p">(</span><span class="m">1970</span><span class="p">,</span><span class="w"> </span><span class="m">2050</span><span class="p">,</span><span class="w"> </span><span class="m">5</span><span class="p">),</span><span class="w"> </span><span class="n">colors</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="s1">&apos;blue&apos;</span><span class="p">,</span><span class="w"> </span><span class="s1">&apos;red&apos;</span><span class="p">))</span><span class="w">
</span></code></pre>

<iframe src="http://neylsoncrepalde.github.io/img/brasil_trasicao_demografica.html" width="850" height="425" class=""></iframe>
</article>
<p class="blog-tags">
Tags: R programming, rstats, Transição Demográfica, Pirâmide etária
</p>

