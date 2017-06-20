+++
title = "Ocupação na UFMG e intervenção policial - Twitter"
date = "2016-11-18 02:00:00"
categories = ["r-python-e-redes"]
original_url = "http://neylsoncrepalde.github.io/2016-11-18-ocupacao-na-ufmg-e-interevencao-policial/"
+++

<article class="blog-post">
<p>
É do conhecimento de todos que hoje, 18/11/2016, a PM de Minas Gerais
reprimiu com violência (balas de borracha e gás lacrimogênio)
manifestantes que bloqueavam a Avenida Antônio Carlos na frente da UFMG.
O fato está sendo sendo bastante comentado nas mídias sociais embora não
receba atenção da grande mídia. Utilizando ferramentas de <em>Big
Data</em>, investiguei como o fato está circulando no Twitter. Hoje às
20:50 a palavra <strong>UFMG</strong> constava como <em>trending
topic</em>. Fizemos uma busca por 3 mil tweets com a palavra UFMG.
</p>
<pre class="highlight"><code><span class="n">library</span><span class="p">(</span><span class="n">twitteR</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">wordcloud</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">tm</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">plyr</span><span class="p">)</span><span class="w"> </span><span class="n">consumer_key</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="s2">&quot;XXXXXXXXXXXXXXXXXXXXXX&quot;</span><span class="w">
</span><span class="n">consumer_secret</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="s2">&quot;XXXXXXXXXXXXXXXXXXXXXX&quot;</span><span class="w">
</span><span class="n">access_token</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="s2">&quot;XXXXXXXXXXXXXXXXXXXXXX&quot;</span><span class="w">
</span><span class="n">access_secret</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="s2">&quot;XXXXXXXXXXXXXXXXXXXXXX&quot;</span><span class="w"> </span><span class="n">setup_twitter_oauth</span><span class="p">(</span><span class="n">consumer_key</span><span class="p">,</span><span class="w"> </span><span class="n">consumer_secret</span><span class="p">,</span><span class="w"> </span><span class="n">access_token</span><span class="p">,</span><span class="w"> </span><span class="n">access_secret</span><span class="p">)</span><span class="w"> </span><span class="n">tweets</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">searchTwitter</span><span class="p">(</span><span class="s2">&quot;UFMG&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">n</span><span class="o">=</span><span class="m">3000</span><span class="p">)</span><span class="w">
</span><span class="n">bd</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">ldply</span><span class="p">(</span><span class="n">tweets</span><span class="p">,</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">t</span><span class="p">)</span><span class="w"> </span><span class="n">t</span><span class="o">$</span><span class="n">toDataFrame</span><span class="p">()</span><span class="w"> </span><span class="p">)</span><span class="w">
</span></code></pre>

<p>
Vamos realizar uma investigação preliminar nos tweets através de uma
nuvem de palavras.
</p>
<pre class="highlight"><code><span class="n">text</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">sapply</span><span class="p">(</span><span class="n">tweets</span><span class="p">,</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">x</span><span class="p">)</span><span class="w"> </span><span class="n">x</span><span class="o">$</span><span class="n">getText</span><span class="p">())</span><span class="w">
</span></code></pre>

<pre class="highlight"><code><span class="n">corpus</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">Corpus</span><span class="p">(</span><span class="n">VectorSource</span><span class="p">(</span><span class="n">text</span><span class="p">))</span><span class="w">
</span><span class="n">f</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">content_transformer</span><span class="p">(</span><span class="k">function</span><span class="p">(</span><span class="n">x</span><span class="p">)</span><span class="w"> </span><span class="n">iconv</span><span class="p">(</span><span class="n">x</span><span class="p">,</span><span class="w"> </span><span class="n">to</span><span class="o">=</span><span class="s1">&apos;latin1&apos;</span><span class="p">,</span><span class="w"> </span><span class="n">sub</span><span class="o">=</span><span class="s1">&apos;byte&apos;</span><span class="p">))</span><span class="w">
</span><span class="n">corpus</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">tm_map</span><span class="p">(</span><span class="n">corpus</span><span class="p">,</span><span class="w"> </span><span class="n">f</span><span class="p">)</span><span class="w">
</span><span class="n">corpus</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">tm_map</span><span class="p">(</span><span class="n">corpus</span><span class="p">,</span><span class="w"> </span><span class="n">content_transformer</span><span class="p">(</span><span class="n">tolower</span><span class="p">))</span><span class="w">
</span><span class="n">corpus</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">tm_map</span><span class="p">(</span><span class="n">corpus</span><span class="p">,</span><span class="w"> </span><span class="n">removePunctuation</span><span class="p">)</span><span class="w">
</span><span class="n">corpus</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">tm_map</span><span class="p">(</span><span class="n">corpus</span><span class="p">,</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">x</span><span class="p">)</span><span class="n">removeWords</span><span class="p">(</span><span class="n">x</span><span class="p">,</span><span class="n">stopwords</span><span class="p">(</span><span class="s2">&quot;pt&quot;</span><span class="p">)))</span><span class="w">
</span><span class="n">pal2</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">brewer.pal</span><span class="p">(</span><span class="m">8</span><span class="p">,</span><span class="s2">&quot;Dark2&quot;</span><span class="p">)</span><span class="w">
</span><span class="n">wordcloud</span><span class="p">(</span><span class="n">corpus</span><span class="p">,</span><span class="w"> </span><span class="n">min.freq</span><span class="o">=</span><span class="m">2</span><span class="p">,</span><span class="n">max.words</span><span class="o">=</span><span class="m">100</span><span class="p">,</span><span class="w"> </span><span class="n">random.order</span><span class="o">=</span><span class="nb">F</span><span class="p">,</span><span class="w"> </span><span class="n">colors</span><span class="o">=</span><span class="n">pal2</span><span class="p">)</span><span class="w">
</span><span class="n">title</span><span class="p">(</span><span class="n">xlab</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Twitter, 18/11/2016, 20:58&quot;</span><span class="p">)</span><span class="w">
</span></code></pre>

<p>
<img src="http://neylsoncrepalde.github.io/img/twitter_UFMG_files/figure-markdown_github/unnamed-chunk-6-1.png" alt="">
</p>
<p>
A maioria das palavras mais usadas parece se posicionar contra o fato.
Palavras como <strong>invadir, atirando, gás, bombas</strong> aparecem.
</p>
<p>
Vamos investigar a emergência de alguns assuntos através da
clusterização hierárquica.
</p>
<pre class="highlight"><code><span class="n">tdm</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">TermDocumentMatrix</span><span class="p">(</span><span class="n">corpus</span><span class="p">)</span><span class="w">
</span><span class="n">tdm</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">removeSparseTerms</span><span class="p">(</span><span class="n">tdm</span><span class="p">,</span><span class="w"> </span><span class="n">sparse</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">0.94</span><span class="p">)</span><span class="w">
</span><span class="n">df</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">as.data.frame</span><span class="p">(</span><span class="n">inspect</span><span class="p">(</span><span class="n">tdm</span><span class="p">))</span><span class="w">
</span><span class="nf">dim</span><span class="p">(</span><span class="n">df</span><span class="p">)</span><span class="w">
</span></code></pre>

<pre class="highlight"><code><span class="n">df.scale</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">scale</span><span class="p">(</span><span class="n">df</span><span class="p">)</span><span class="w">
</span><span class="n">d</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">dist</span><span class="p">(</span><span class="n">df.scale</span><span class="p">,</span><span class="w"> </span><span class="n">method</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;euclidean&quot;</span><span class="p">)</span><span class="w">
</span><span class="n">fit.ward2</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">hclust</span><span class="p">(</span><span class="n">d</span><span class="p">,</span><span class="w"> </span><span class="n">method</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;ward.D2&quot;</span><span class="p">)</span><span class="w">
</span><span class="n">plot</span><span class="p">(</span><span class="n">fit.ward2</span><span class="p">)</span><span class="w"> </span><span class="n">rect.hclust</span><span class="p">(</span><span class="n">fit.ward2</span><span class="p">,</span><span class="w"> </span><span class="n">k</span><span class="o">=</span><span class="m">8</span><span class="p">)</span><span class="w">
</span></code></pre>

<p>
<img src="http://neylsoncrepalde.github.io/img/twitter_UFMG_files/figure-markdown_github/unnamed-chunk-9-1.png" alt="">
</p>
<p>
Vamos tentar aprofundar nossas investigações gerando uma rede semântica
com essas palavras. Para facilitar a análise vamos retirar a palavra
UFMG.
</p>
<pre class="highlight"><code><span class="n">matriz</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">as.matrix</span><span class="p">(</span><span class="n">df</span><span class="p">)</span><span class="w"> </span><span class="n">library</span><span class="p">(</span><span class="n">igraph</span><span class="p">)</span><span class="w">
</span><span class="n">g</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">graph_from_incidence_matrix</span><span class="p">(</span><span class="n">matriz</span><span class="p">)</span><span class="w">
</span><span class="n">p</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">bipartite_projection</span><span class="p">(</span><span class="n">g</span><span class="p">,</span><span class="w"> </span><span class="n">which</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;FALSE&quot;</span><span class="p">)</span><span class="w">
</span><span class="n">V</span><span class="p">(</span><span class="n">p</span><span class="p">)</span><span class="o">$</span><span class="n">shape</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;none&quot;</span><span class="w">
</span><span class="n">deg</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">degree</span><span class="p">(</span><span class="n">p</span><span class="p">)</span><span class="w">
</span><span class="n">p</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">delete_vertices</span><span class="p">(</span><span class="n">p</span><span class="p">,</span><span class="w"> </span><span class="s1">&apos;ufmg&apos;</span><span class="p">)</span><span class="w"> </span><span class="n">plot</span><span class="p">(</span><span class="n">p</span><span class="p">,</span><span class="w"> </span><span class="n">vertex.label.cex</span><span class="o">=</span><span class="n">deg</span><span class="o">/</span><span class="m">20</span><span class="p">,</span><span class="w"> </span><span class="n">edge.width</span><span class="o">=</span><span class="p">(</span><span class="n">E</span><span class="p">(</span><span class="n">p</span><span class="p">)</span><span class="o">$</span><span class="n">weight</span><span class="p">)</span><span class="o">/</span><span class="m">100</span><span class="p">,</span><span class="w"> </span><span class="n">edge.color</span><span class="o">=</span><span class="n">adjustcolor</span><span class="p">(</span><span class="s2">&quot;grey60&quot;</span><span class="p">,</span><span class="w"> </span><span class="m">.5</span><span class="p">),</span><span class="w"> </span><span class="n">vertex.label.color</span><span class="o">=</span><span class="n">adjustcolor</span><span class="p">(</span><span class="s2">&quot;#005d26&quot;</span><span class="p">,</span><span class="w"> </span><span class="m">.7</span><span class="p">),</span><span class="w"> </span><span class="n">main</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Twitter - UFMG&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">xlab</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;18/11/2016, 20:58&quot;</span><span class="p">)</span><span class="w">
</span></code></pre>

<p>
<img src="http://neylsoncrepalde.github.io/img/twitter_UFMG_files/figure-markdown_github/unnamed-chunk-10-1.png" alt="">
</p>
<p>
Observando o dendograma é possível identicar três assuntos principais: o
primeiro, ocupando a posição mais central do grafo, relaciona-se ao
confronto da polícia com os estudantes. Palavras como <strong>balas,
borracha, estudantes, contra, polícia</strong> e
<strong>midianinja</strong> aparecem conectadas aqui. A parte de cima
com palavras com ligações mais fortes parecem ser de tweets que fazem
denúncia no momento em que o evento estava acontecendo. Palavras como
<strong>urgente, jogando, invadindo, entraram</strong> aparecem aqui. Na
parte inferior do grafo, parece emergir um terceiro assunto relacionado
à nota de repúdio divulgada pela UFMG à ação policial.
</p>
</article>
<p class="blog-tags">
Tags: rstats, Social Network Analysis, Igraph, PEC 55, MP Ensino Médio,
PMMG
</p>

