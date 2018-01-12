+++
title = "Meu primeiro passo com d3"
date = "2015-11-17"
categories = ["dfalbel"]
original_url = "http://dfalbel.github.io/2015/11/primeiro-passo-d3.html"
+++

<p class="post">
<article class="post-content">
<p>
A maioria das visualizações originais feitas atualmente são feitas
usando o <a href="http://d3js.org/">d3.js</a>. Existem diversos exemplos
na internet, mas gosto especialmente desses aqui:
</p>
<ul>
<li>
<a href="http://www.nytimes.com/interactive/2012/09/06/us/politics/convention-word-counts.html?_r=0#Better">At
the National Conventions, the Words They Used</a>
</li>
<li>
<a href="http://bost.ocks.org/mike/algorithms/">Visualizing
Algorithms</a>
</li>
</ul>
<p>
Essas duas foram feitas pelo Mike Bostock, criador do
<a href="http://d3js.org/">d3.js</a>.
</p>
<p>
Neste post vou colar meu primeiro passo com essa ferramente. Realmente o
primeiro passo! Coloquei no meio da tela, alguns círculos, cujo tamanho
e posição são determinados por um banco de dados. Veja o script:
</p>
<post>
<figure class="highlight">
<pre><code class="language-js"><span class="c1">// meus dados</span>
<span class="kd">var</span> <span class="nx">array</span> <span class="o">=</span> <span class="p">[</span> <span class="p">{</span><span class="s2">&quot;x&quot;</span><span class="p">:</span> <span class="mi">10</span><span class="p">,</span> <span class="s2">&quot;y&quot;</span><span class="p">:</span> <span class="mi">20</span><span class="p">,</span> <span class="s2">&quot;r&quot;</span><span class="p">:</span> <span class="mi">10</span><span class="p">},</span> <span class="p">{</span><span class="s2">&quot;x&quot;</span><span class="p">:</span> <span class="mi">10</span><span class="p">,</span> <span class="s2">&quot;y&quot;</span><span class="p">:</span> <span class="mi">70</span><span class="p">,</span> <span class="s2">&quot;r&quot;</span><span class="p">:</span> <span class="mi">10</span><span class="p">},</span> <span class="p">{</span><span class="s2">&quot;x&quot;</span><span class="p">:</span> <span class="mi">50</span><span class="p">,</span> <span class="s2">&quot;y&quot;</span><span class="p">:</span> <span class="mi">40</span><span class="p">,</span> <span class="s2">&quot;r&quot;</span><span class="p">:</span> <span class="mi">10</span><span class="p">},</span> <span class="p">{</span><span class="s2">&quot;x&quot;</span><span class="p">:</span> <span class="mi">30</span><span class="p">,</span> <span class="s2">&quot;y&quot;</span><span class="p">:</span> <span class="mi">10</span><span class="p">,</span> <span class="s2">&quot;r&quot;</span><span class="p">:</span> <span class="mi">10</span><span class="p">},</span> <span class="p">{</span><span class="s2">&quot;x&quot;</span><span class="p">:</span> <span class="mi">170</span><span class="p">,</span> <span class="s2">&quot;y&quot;</span><span class="p">:</span> <span class="mi">140</span><span class="p">,</span> <span class="s2">&quot;r&quot;</span><span class="p">:</span> <span class="mi">20</span><span class="p">},</span> <span class="p">{</span><span class="s2">&quot;x&quot;</span><span class="p">:</span> <span class="mi">300</span><span class="p">,</span> <span class="s2">&quot;y&quot;</span><span class="p">:</span> <span class="mi">100</span><span class="p">,</span> <span class="s2">&quot;r&quot;</span><span class="p">:</span> <span class="mi">30</span><span class="p">},</span> <span class="p">];</span> <span class="c1">// O SVG Container</span>
<span class="kd">var</span> <span class="nx">svgContainer</span> <span class="o">=</span> <span class="nx">d3</span><span class="p">.</span><span class="nx">select</span><span class="p">(</span><span class="s2">&quot;post&quot;</span><span class="p">).</span><span class="nx">append</span><span class="p">(</span><span class="s2">&quot;svg&quot;</span><span class="p">)</span> <span class="p">.</span><span class="nx">attr</span><span class="p">(</span><span class="s2">&quot;width&quot;</span><span class="p">,</span> <span class="mi">350</span><span class="p">)</span> <span class="p">.</span><span class="nx">attr</span><span class="p">(</span><span class="s2">&quot;height&quot;</span><span class="p">,</span> <span class="mi">200</span><span class="p">);</span> <span class="c1">// O gr&#xE1;fico</span>
<span class="nx">svgContainer</span> <span class="p">.</span><span class="nx">selectAll</span><span class="p">(</span><span class="s2">&quot;circles&quot;</span><span class="p">)</span> <span class="p">.</span><span class="nx">data</span><span class="p">(</span><span class="nx">array</span><span class="p">)</span> <span class="p">.</span><span class="nx">enter</span><span class="p">()</span> <span class="p">.</span><span class="nx">append</span><span class="p">(</span><span class="s2">&quot;circle&quot;</span><span class="p">)</span> <span class="p">.</span><span class="nx">attr</span><span class="p">(</span><span class="s2">&quot;cx&quot;</span><span class="p">,</span> <span class="kd">function</span><span class="p">(</span><span class="nx">d</span><span class="p">)</span> <span class="p">{</span><span class="k">return</span> <span class="nx">d</span><span class="p">.</span><span class="nx">x</span><span class="p">})</span> <span class="p">.</span><span class="nx">attr</span><span class="p">(</span><span class="s2">&quot;cy&quot;</span><span class="p">,</span> <span class="kd">function</span><span class="p">(</span><span class="nx">d</span><span class="p">)</span> <span class="p">{</span><span class="k">return</span> <span class="nx">d</span><span class="p">.</span><span class="nx">y</span><span class="p">})</span> <span class="p">.</span><span class="nx">attr</span><span class="p">(</span><span class="s2">&quot;r&quot;</span><span class="p">,</span> <span class="kd">function</span><span class="p">(</span><span class="nx">d</span><span class="p">)</span> <span class="p">{</span><span class="k">return</span> <span class="nx">d</span><span class="p">.</span><span class="nx">r</span><span class="p">});</span></code></pre>
</figure>
Bonitinho né? Ainda vou estudar bastante essa ferramenta, mas por
enquanto estou achando a forma de construção das visualizações muito
interessante! </post>
</article>
<br> <ins class="adsbygoogle"></ins> <br>
</p>

