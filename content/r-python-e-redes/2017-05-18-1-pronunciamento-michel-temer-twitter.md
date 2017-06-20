+++
title = "O Pronunciamento de Michel Temer no Twitter"
date = "2017-05-18 03:00:00"
categories = ["r-python-e-redes"]
original_url = "http://neylsoncrepalde.github.io/2017-05-18-1-pronunciamento-michel-temer-twitter/"
+++

<article class="blog-post">
<p>
Hoje foi um dia bastante importante no Brasil, o dia em que o atual
presidente Michel Temer quaaaaaaaase renunciou após o vazamento de
vídeos em que ele combina propina para Eduardo Cunha, ex-presidente da
Câmara dos Deputados que está preso, para que fique calado. O assunto é
<em>trending topic</em> mundial no twitter. Uma hora após seu
pronunciamento, vamos investigar rapidamente o que está sendo falado
sobre Temer nessa mídia social. Para isso, coletamos 10000 tweets com as
palavras-chave “michel temer”.
</p>
<p>
Em
<a href="http://neylsoncrepalde.github.io/2016-03-18-analise-de-conteudo-twitter/">outro
post</a> mostramos como fazer a coleta dos dados na API do twitter. Vou
apenas postar um exemplo de como fica o código.
</p>
<pre class="highlight"><code><span class="n">library</span><span class="p">(</span><span class="n">twitteR</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">wordcloud</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">tm</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">plyr</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">stringr</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">magrittr</span><span class="p">)</span><span class="w"> </span><span class="n">consumer_key</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="s2">&quot;XXXXXXXXXXXXXXXXXXXXXXXXXXXX&quot;</span><span class="w">
</span><span class="n">consumer_secret</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="s2">&quot;XXXXXXXXXXXXXXXXXXXXXXXXXXXX&quot;</span><span class="w">
</span><span class="n">access_token</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="s2">&quot;XXXXXXXXXXXXXXXXXXXXXXXXXXXX-XXXXXXXXXXXXXXXXXXXXXXXXXXXX&quot;</span><span class="w">
</span><span class="n">access_secret</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="s2">&quot;XXXXXXXXXXXXXXXXXXXXXXXXXXXX&quot;</span><span class="w"> </span><span class="n">setup_twitter_oauth</span><span class="p">(</span><span class="n">consumer_key</span><span class="p">,</span><span class="w"> </span><span class="n">consumer_secret</span><span class="p">,</span><span class="w"> </span><span class="n">access_token</span><span class="p">,</span><span class="w"> </span><span class="n">access_secret</span><span class="p">)</span><span class="w"> </span><span class="n">tweets</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">searchTwitter</span><span class="p">(</span><span class="s2">&quot;Michel Temer&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">n</span><span class="o">=</span><span class="m">10000</span><span class="p">)</span><span class="w">
</span><span class="n">bd</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">ldply</span><span class="p">(</span><span class="n">tweets</span><span class="p">,</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">t</span><span class="p">)</span><span class="w"> </span><span class="n">t</span><span class="o">$</span><span class="n">toDataFrame</span><span class="p">()</span><span class="w"> </span><span class="p">)</span><span class="w"> </span><span class="c1"># Salvando os tweets num banco de dados
</span><span class="n">View</span><span class="p">(</span><span class="n">bd</span><span class="p">)</span><span class="w"> </span><span class="c1"># Ver o banco
</span><span class="w">
</span><span class="n">text</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">sapply</span><span class="p">(</span><span class="n">tweets</span><span class="p">,</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">x</span><span class="p">)</span><span class="w"> </span><span class="n">x</span><span class="o">$</span><span class="n">getText</span><span class="p">())</span><span class="w">
</span></code></pre>

<p>
Vamos às análises. Quais são as palavras mais faladas nos tweets
contendo “Michel Temer”? Depois de ter os dados no ambiente do R, vamos
tranformá-lo num <em>corpus</em> textual para análise, retirar os
<em>emojis</em> com um regex, transformar todas as palavras em
minúsculas, retirar pontuação, retirar palavras que não são
interessantes para a análise (preposições, conectivos, etc.) e,
obviamente, retirar as palavras “michel” e “temer”.
</p>
<pre class="highlight"><code><span class="n">corpus</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">Corpus</span><span class="p">(</span><span class="n">VectorSource</span><span class="p">(</span><span class="n">enc2native</span><span class="p">(</span><span class="n">text</span><span class="p">)))</span><span class="w">
</span><span class="n">corpus</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">tm_map</span><span class="p">(</span><span class="n">corpus</span><span class="p">,</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">x</span><span class="p">)</span><span class="w"> </span><span class="n">gsub</span><span class="p">(</span><span class="s2">&quot;[^[:alpha:][:space:]]*&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">x</span><span class="p">))</span><span class="w">
</span><span class="n">corpus</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">tm_map</span><span class="p">(</span><span class="n">corpus</span><span class="p">,</span><span class="w"> </span><span class="n">content_transformer</span><span class="p">(</span><span class="n">tolower</span><span class="p">))</span><span class="w">
</span><span class="n">corpus</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">tm_map</span><span class="p">(</span><span class="n">corpus</span><span class="p">,</span><span class="w"> </span><span class="n">removePunctuation</span><span class="p">)</span><span class="w">
</span><span class="n">corpus</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">tm_map</span><span class="p">(</span><span class="n">corpus</span><span class="p">,</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">x</span><span class="p">)</span><span class="n">removeWords</span><span class="p">(</span><span class="n">x</span><span class="p">,</span><span class="n">stopwords</span><span class="p">(</span><span class="s2">&quot;pt&quot;</span><span class="p">)))</span><span class="w">
</span><span class="n">corpus</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">tm_map</span><span class="p">(</span><span class="n">corpus</span><span class="p">,</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">x</span><span class="p">)</span><span class="n">removeWords</span><span class="p">(</span><span class="n">x</span><span class="p">,</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="s2">&quot;michel&quot;</span><span class="p">,</span><span class="s2">&quot;temer&quot;</span><span class="p">)))</span><span class="w">
</span></code></pre>

<p>
Agora, vamos plotar uma nuvem de palavras:
</p>
<pre class="highlight"><code><span class="n">library</span><span class="p">(</span><span class="n">RColorBrewer</span><span class="p">)</span><span class="w">
</span><span class="n">pal2</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">brewer.pal</span><span class="p">(</span><span class="m">9</span><span class="p">,</span><span class="s2">&quot;YlGnBu&quot;</span><span class="p">)</span><span class="w">
</span><span class="n">pal2</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">pal2</span><span class="p">[</span><span class="m">5</span><span class="o">:</span><span class="m">9</span><span class="p">]</span><span class="w">
</span><span class="n">wordcloud</span><span class="p">(</span><span class="n">corpus</span><span class="p">,</span><span class="w"> </span><span class="n">min.freq</span><span class="o">=</span><span class="m">2</span><span class="p">,</span><span class="n">max.words</span><span class="o">=</span><span class="m">100</span><span class="p">,</span><span class="w"> </span><span class="n">random.order</span><span class="o">=</span><span class="nb">F</span><span class="p">,</span><span class="w"> </span><span class="n">colors</span><span class="o">=</span><span class="n">pal2</span><span class="p">)</span><span class="w">
</span></code></pre>

<p>
<img src="http://neylsoncrepalde.github.io/img/post_twitter_temer_files/figure-markdown_github/unnamed-chunk-2-1.png" alt="">
</p>
<p>
Agora vamos investigar quem são as pessoas que mais aparecem nesses
tweets, ou seja, quais são as contas mais retweetadas:
</p>
<pre class="highlight"><code><span class="n">pessoas</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">str_extract_all</span><span class="p">(</span><span class="n">text</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;@\\w+&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">unlist</span><span class="w">
</span><span class="n">wordcloud</span><span class="p">(</span><span class="n">pessoas</span><span class="p">,</span><span class="w"> </span><span class="n">min.freq</span><span class="o">=</span><span class="m">2</span><span class="p">,</span><span class="n">max.words</span><span class="o">=</span><span class="m">100</span><span class="p">,</span><span class="w"> </span><span class="n">random.order</span><span class="o">=</span><span class="nb">F</span><span class="p">,</span><span class="w"> </span><span class="n">colors</span><span class="o">=</span><span class="n">pal2</span><span class="p">)</span><span class="w">
</span></code></pre>

<p>
<img src="http://neylsoncrepalde.github.io/img/post_twitter_temer_files/figure-markdown_github/unnamed-chunk-3-1.png" alt="">
</p>
<p>
Agora, vamos investigar quais são as hashtags mais usadas:
</p>
<pre class="highlight"><code><span class="n">hastags</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">str_extract_all</span><span class="p">(</span><span class="n">text</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;#\\w+&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">unlist</span><span class="w">
</span><span class="n">wordcloud</span><span class="p">(</span><span class="n">hastags</span><span class="p">,</span><span class="w"> </span><span class="n">min.freq</span><span class="o">=</span><span class="m">2</span><span class="p">,</span><span class="n">max.words</span><span class="o">=</span><span class="m">100</span><span class="p">,</span><span class="w"> </span><span class="n">random.order</span><span class="o">=</span><span class="nb">F</span><span class="p">,</span><span class="w"> </span><span class="n">colors</span><span class="o">=</span><span class="n">pal2</span><span class="p">)</span><span class="w">
</span></code></pre>

<p>
<img src="http://neylsoncrepalde.github.io/img/post_twitter_temer_files/figure-markdown_github/unnamed-chunk-4-1.png" alt="">
</p>
<p>
Por hoje é só. Aguardem cenas dos próximos capítulos de
\#BRASILIAOFCARDS!!!
</p>
</article>
<p class="blog-tags">
Tags: R, Wordloud, Twitter, Data Mining
</p>

