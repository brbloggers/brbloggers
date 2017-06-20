+++
title = "Nuvens de palavras dinâmicas com wordcloud2 e corrigindo encoding"
date = "2017-03-20 03:00:00"
categories = ["r-python-e-redes"]
original_url = "http://neylsoncrepalde.github.io/2017-03-20-nuvens-de-palavras-dinamicas/"
+++

<article class="blog-post">
<p>
Olá. Hoje vamos utilizar o pacote wordloud2 para plotar nuvens de
palavras dinâmicas em html. Esse recurso é bastante útil numa análise
preliminar/descritiva de <em>corpora</em> textuais. Para isso, vamos
utilizar uma pergunta aberta de um questionário de pesquisa.
</p>
<p>
A empresários de um determinado local de Belo Horizonte, foi perguntado
quais são as principais dificuldades encontradas na contratação de
jovens. Ao trabalhar com análise de textos, é muito comum nos depararmos
com problemas de encoding. Palavras com acentos, cedilha (ç) ficam
desconfiguradas comprometendo a apresentação dos resultados. Eu e meu
parceiro Marcus encontramos uma “funçãozinha mágica” no R que nos ajuda
a resolver esse problema -&gt;
<code class="highlighter-rouge">enc2native</code>.
</p>
<p>
A função <code class="highlighter-rouge">enc2native()</code> preserva o
encoding original dos dados quando há mudanças de encoding internas nos
códigos (é o caso da função Corpus do pacote tm). Costumo sempre
trabalhar com o encoding “UTF-8”, um encoding universal que facilita o
uso de caracteres especiais. Vamos carregar primeiro os dados
</p>
<pre class="highlight"><code><span class="n">library</span><span class="p">(</span><span class="n">data.table</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">bit64</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">magrittr</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">tm</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">wordcloud</span><span class="p">)</span><span class="w">
</span></code></pre>

<pre class="highlight"><code><span class="n">setwd</span><span class="p">(</span><span class="s2">&quot;C:/Users/Neylson/Documents/rpythoneredes/&quot;</span><span class="p">)</span><span class="w">
</span><span class="n">dados</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">fread</span><span class="p">(</span><span class="s1">&apos;dados.csv&apos;</span><span class="p">,</span><span class="w"> </span><span class="n">encoding</span><span class="o">=</span><span class="s2">&quot;UTF-8&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">as.data.frame</span><span class="p">(</span><span class="n">.</span><span class="p">,</span><span class="w"> </span><span class="n">stringsAsFactors</span><span class="o">=</span><span class="nb">F</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">.</span><span class="p">[</span><span class="m">-2</span><span class="p">,]</span><span class="w"> </span><span class="n">pal2</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">brewer.pal</span><span class="p">(</span><span class="m">8</span><span class="p">,</span><span class="s1">&apos;Dark2&apos;</span><span class="p">)</span><span class="w"> </span><span class="n">dificuldades</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">dados</span><span class="p">[,</span><span class="m">48</span><span class="p">]</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">tolower</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">removePunctuation</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">removeWords</span><span class="p">(</span><span class="n">.</span><span class="p">,</span><span class="w"> </span><span class="n">stopwords</span><span class="p">(</span><span class="s1">&apos;pt&apos;</span><span class="p">))</span><span class="w">
</span></code></pre>

<p>
Vejamos como ficam as nuvens de palavras sem a utilização da função.
</p>
<pre class="highlight"><code><span class="n">wordcloud</span><span class="p">(</span><span class="n">dificuldades</span><span class="p">,</span><span class="w"> </span><span class="n">min.freq</span><span class="o">=</span><span class="m">3</span><span class="p">,</span><span class="n">max.words</span><span class="o">=</span><span class="m">100</span><span class="p">,</span><span class="w"> </span><span class="n">random.order</span><span class="o">=</span><span class="nb">F</span><span class="p">,</span><span class="w"> </span><span class="n">colors</span><span class="o">=</span><span class="n">pal2</span><span class="p">)</span><span class="w">
</span></code></pre>

<p>
<img src="http://neylsoncrepalde.github.io/img/post_wordcloud2_files/figure-markdown_github/wordcloud%20sem-1.png" alt="">
</p>
<p>
Imagine apresentar para seu chefe ou colegas de trabalho uma nuvem de
palavras cheia de erros de encoding como essa!!!
</p>
<p>
A função <code class="highlighter-rouge">enc2native()</code> resolve o
problema!
</p>
<pre class="highlight"><code><span class="n">wordcloud</span><span class="p">(</span><span class="n">enc2native</span><span class="p">(</span><span class="n">dificuldades</span><span class="p">),</span><span class="w"> </span><span class="n">min.freq</span><span class="o">=</span><span class="m">3</span><span class="p">,</span><span class="n">max.words</span><span class="o">=</span><span class="m">100</span><span class="p">,</span><span class="w"> </span><span class="n">random.order</span><span class="o">=</span><span class="nb">F</span><span class="p">,</span><span class="w"> </span><span class="n">colors</span><span class="o">=</span><span class="n">pal2</span><span class="p">)</span><span class="w">
</span></code></pre>

<p>
<img src="http://neylsoncrepalde.github.io/img/post_wordcloud2_files/figure-markdown_github/unnamed-chunk-2-1.png" alt="">
</p>
<p>
Agora vamos deixar essa nuvem realmente atrativa usando o pacote
wordcloud2 para gerar um html interativo. Para isso, é preciso algum
trabalho transformando o vetor de texto num data.frame com duas colunas:
palavras e contagem
</p>
<pre class="highlight"><code><span class="n">library</span><span class="p">(</span><span class="n">wordcloud2</span><span class="p">)</span><span class="w"> </span><span class="n">corpus</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">Corpus</span><span class="p">(</span><span class="n">VectorSource</span><span class="p">(</span><span class="n">enc2native</span><span class="p">(</span><span class="n">dificuldades</span><span class="p">)))</span><span class="w">
</span><span class="c1">#preparando o df para wordcloud2
</span><span class="n">tdm.word</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">TermDocumentMatrix</span><span class="p">(</span><span class="n">corpus</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">as.matrix</span><span class="w">
</span><span class="n">tdm.df</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">data.frame</span><span class="p">(</span><span class="n">words</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">rownames</span><span class="p">(</span><span class="n">tdm.word</span><span class="p">),</span><span class="w"> </span><span class="n">freq</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">apply</span><span class="p">(</span><span class="n">tdm.word</span><span class="p">,</span><span class="m">1</span><span class="p">,</span><span class="n">sum</span><span class="p">))</span><span class="w">
</span><span class="n">wordcloud2</span><span class="p">(</span><span class="n">tdm.df</span><span class="p">,</span><span class="w"> </span><span class="n">size</span><span class="o">=</span><span class="m">.6</span><span class="p">)</span><span class="w">
</span></code></pre>

<iframe src="http://neylsoncrepalde.github.io/word2.html" width="850" height="500" class=""></iframe>
<p>
Muito elegante, hum? É possível ainda plotar wordclouds em letras
específicas ou dentro de uma figura. Para mais informações, veja este
link:
<a href="https://cran.r-project.org/web/packages/wordcloud2/vignettes/wordcloud.html">https://cran.r-project.org/web/packages/wordcloud2/vignettes/wordcloud.html</a>
</p>
<p>
Até a próxima!
</p>
</article>
<p class="blog-tags">
Tags: R, Wordloud2, Encoding
</p>

