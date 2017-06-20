+++
title = "Quantidade de perguntas sobre R no pt.stackoverflow"
date = "2016-09-22"
categories = ["dfalbel"]
original_url = "http://dfalbel.github.io/2016/09/stackoverflow-pt-r.html"
+++

<p class="post">
<article class="post-content">
<p>
Veja o gráfico do número de perguntas com a tag
<code class="highlighter-rouge">R</code> no pt.stackoverflow por mês.
Será que está crescendo?
</p>
<p>
<img src="http://dfalbel.github.io/images/2016-09-22-stackoverflow-pt-r/unnamed-chunk-1-1.png" alt="plot of chunk unnamed-chunk-1">
</p>
<p>
Abaixo o código para reproduzir:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">library</span><span class="p">(</span><span class="n">dplyr</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">lubridate</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">ggplot2</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">stackr</span><span class="p">)</span><span class="w">
</span><span class="n">stack_search</span><span class="p">(</span><span class="n">tagged</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;r&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">site</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;pt.stackoverflow&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">pagesize</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">100</span><span class="p">,</span><span class="w"> </span><span class="n">num_pages</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">5</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">group_by</span><span class="p">(</span><span class="n">ano</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">year</span><span class="p">(</span><span class="n">creation_date</span><span class="p">),</span><span class="w"> </span><span class="n">mes</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">month</span><span class="p">(</span><span class="n">creation_date</span><span class="p">))</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">summarise</span><span class="p">(</span><span class="n">n</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">n</span><span class="p">())</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">mutate</span><span class="p">(</span><span class="n">date</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">ymd</span><span class="p">(</span><span class="n">paste</span><span class="p">(</span><span class="n">ano</span><span class="p">,</span><span class="w"> </span><span class="n">mes</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;01&quot;</span><span class="p">)))</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">ggplot</span><span class="p">(</span><span class="n">aes</span><span class="p">(</span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">date</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">n</span><span class="p">))</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">geom_line</span><span class="p">()</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">geom_smooth</span><span class="p">(</span><span class="n">method</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;lm&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">labs</span><span class="p">(</span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;M&#xEA;s&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Qtd. Perguntas&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">scale_x_date</span><span class="p">(</span><span class="n">date_breaks</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;8 months&quot;</span><span class="p">)</span></code></pre>
</figure>
</article>
<br> <ins class="adsbygoogle"></ins> <br>
</p>

