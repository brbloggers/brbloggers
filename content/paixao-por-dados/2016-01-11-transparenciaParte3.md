+++
title = "Transparência (3): Em quais estados os salários são mais mal distribuídos?"
date = "2016-01-11 03:00:00"
categories = ["paixao-por-dados"]
original_url = "http://sillasgonzaga.github.io/2016-01-11-transparenciaParte3/"
+++

<article class="blog-post">
<figure class="highlight">
<pre><code class="language-r"><span class="n">library</span><span class="p">(</span><span class="n">ggplot</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## Error in library(ggplot): there is no package called &apos;ggplot&apos;</code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-r"><span class="n">library</span><span class="p">(</span><span class="n">ggrepel</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">ggthemes</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">dplyr</span><span class="p">)</span></code></pre>
</figure>
<p>
Este post funciona como um adendo ao anterior, portanto recomendo o ler
antes de prosseguir com a leitura.
</p>
<p>
Assim que eu publiquei o último post, percebi que perdi a oportunidade
de analisar o quão diferente são as distribuições dos salários nos
estados brasileiros e não só nas regiões. Voltando ao nosso dataset, que
dessa vez carrego apenas as colunas de salários e UFs:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">df</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">read.csv2</span><span class="p">(</span><span class="s2">&quot;/home/sillas/R/data/transparenciaComSalarios.csv&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">stringsAsFactors</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">FALSE</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">select</span><span class="p">(</span><span class="n">uf</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">UF_EXERCICIO</span><span class="p">,</span><span class="w"> </span><span class="n">salario</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">SALARIO</span><span class="p">)</span></code></pre>
</figure>
<p>
Quais são, então, os estados com as maiores assimetria e curtoses em sua
distribuição de salário?
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">temp</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">df</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">group_by</span><span class="p">(</span><span class="n">uf</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">summarise</span><span class="p">(</span><span class="n">assimetria</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">skewness</span><span class="p">(</span><span class="n">salario</span><span class="p">),</span><span class="w"> </span><span class="n">curtose</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">kurtosis</span><span class="p">(</span><span class="n">salario</span><span class="p">))</span><span class="w"> </span><span class="n">ggplot</span><span class="p">(</span><span class="n">temp</span><span class="p">,</span><span class="w"> </span><span class="n">aes</span><span class="p">(</span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">assimetria</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">curtose</span><span class="p">))</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">geom_point</span><span class="p">()</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">geom_text_repel</span><span class="p">(</span><span class="n">aes</span><span class="p">(</span><span class="n">label</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">uf</span><span class="p">))</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">theme_few</span><span class="p">()</span></code></pre>
</figure>
<p>
<img src="http://sillasgonzaga.github.io/figs/transparenciaParte3/unnamed-chunk-3-1.png" alt="center">
</p>
<p>
Do gráfico de cima tiramos duas conclusões:
</p>
<ul>
<li>
A disparidade do Amapá e, principalmente, de Roraima em relação aos
outros estados é colossal.
</li>
<li>
Existe uma correlação linear entre assimetria e curtose, algo que eu não
esperava muito. Podemos checar este dado:
</li>
</ul>
<figure class="highlight">
<pre><code class="language-r"><span class="n">cor</span><span class="p">(</span><span class="n">temp</span><span class="o">$</span><span class="n">assimetria</span><span class="p">,</span><span class="w"> </span><span class="n">temp</span><span class="o">$</span><span class="n">curtose</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## [1] 0.9850373</code></pre>
</figure>
<p>
Realmente, a correlação é muito alta.
</p>
<p>
Voltando aos estados, nada melhor do que plotar uma comparação entre os
estados mais díspares e os que a distribuição mais se aproxima do normal
(SP e DF):
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">temp</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">filter</span><span class="p">(</span><span class="n">df</span><span class="p">,</span><span class="w"> </span><span class="n">uf</span><span class="w"> </span><span class="o">%in%</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="s2">&quot;RR&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;AP&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;DF&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;SP&quot;</span><span class="p">))</span><span class="w"> </span><span class="c1"># Necess&#xE1;rio para mudar a ordem dos estados no gr&#xE1;fico
</span><span class="n">temp</span><span class="o">$</span><span class="n">uf</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">factor</span><span class="p">(</span><span class="n">temp</span><span class="o">$</span><span class="n">uf</span><span class="p">,</span><span class="w"> </span><span class="n">levels</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="s2">&quot;RR&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;AP&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;DF&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;SP&quot;</span><span class="p">))</span><span class="w"> </span><span class="n">ggplot</span><span class="p">(</span><span class="n">temp</span><span class="p">,</span><span class="w"> </span><span class="n">aes</span><span class="p">(</span><span class="n">salario</span><span class="p">))</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">geom_histogram</span><span class="p">()</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">facet_grid</span><span class="p">(</span><span class="n">uf</span><span class="w"> </span><span class="o">~</span><span class="n">.</span><span class="p">,</span><span class="w"> </span><span class="n">scales</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;free&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">scale_x_continuous</span><span class="p">(</span><span class="n">breaks</span><span class="o">=</span><span class="n">seq</span><span class="p">(</span><span class="m">0</span><span class="p">,</span><span class="w"> </span><span class="m">50000</span><span class="p">,</span><span class="w"> </span><span class="n">by</span><span class="o">=</span><span class="m">5000</span><span class="p">))</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">theme_few</span><span class="p">()</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">labs</span><span class="p">(</span><span class="n">title</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Distribui&#xE7;&#xE3;o do sal&#xE1;rio dos servidores em certas UFs&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Faixa salarial&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Frequ&#xEA;ncia&quot;</span><span class="p">)</span></code></pre>
</figure>
<p>
<img src="http://sillasgonzaga.github.io/figs/transparenciaParte3/unnamed-chunk-5-1.png" alt="center">
</p>
<p>
Agora fica tudo muito claro: Existe uma concentração estranhamente
grande de pessoas que ganham cerca de R$5000,00 mensais em comparação
com o resto dos servidores do estado.
</p>
<p>
A presença de outliers que ganha mais de 25000 reais distorce o gráfico,
então vale a pena olhar para a mesma distribuição sem eles:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">ggplot</span><span class="p">(</span><span class="n">subset</span><span class="p">(</span><span class="n">temp</span><span class="p">,</span><span class="w"> </span><span class="n">salario</span><span class="w"> </span><span class="o">&lt;=</span><span class="w"> </span><span class="m">25000</span><span class="p">),</span><span class="w"> </span><span class="n">aes</span><span class="p">(</span><span class="n">salario</span><span class="p">))</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">geom_histogram</span><span class="p">(</span><span class="n">binwidth</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">1000</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">facet_grid</span><span class="p">(</span><span class="n">uf</span><span class="w"> </span><span class="o">~</span><span class="n">.</span><span class="p">,</span><span class="w"> </span><span class="n">scales</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;free&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">scale_x_continuous</span><span class="p">(</span><span class="n">breaks</span><span class="o">=</span><span class="n">seq</span><span class="p">(</span><span class="m">0</span><span class="p">,</span><span class="w"> </span><span class="m">50000</span><span class="p">,</span><span class="w"> </span><span class="n">by</span><span class="o">=</span><span class="m">5000</span><span class="p">))</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">theme_few</span><span class="p">()</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">labs</span><span class="p">(</span><span class="n">title</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Distribui&#xE7;&#xE3;o do sal&#xE1;rio dos servidores em certas UFs&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Faixa salarial&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Frequ&#xEA;ncia&quot;</span><span class="p">)</span></code></pre>
</figure>
<p>
<img src="http://sillasgonzaga.github.io/figs/transparenciaParte3/unnamed-chunk-6-1.png" alt="center">
</p>
<p>
Temos agora ainda mais evidência de um fenômeno muito interessante: os
salários em RR e AP são muito mais distribuídos. Na verdade, o que
acontece é que a grande maioria dos servidores roraimenses e amapaenses
ganham até R$5000,00 e muito poucos ganham mais de R$15000,00.
</p>
</article>

