+++
title = "Transparência (6): Quem são os 1% do funcionalismo público?"
date = "2016-01-24 03:00:00"
categories = ["paixao-por-dados"]
original_url = "http://sillasgonzaga.github.io/2016-01-24-transparenciaParte6_2/"
+++

<article class="blog-post">
<p>
<a href="https://en.wikipedia.org/wiki/We_are_the_99%25">Para quem não
entendeu a referência.</a>
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">library</span><span class="p">(</span><span class="n">ggplot2</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">dplyr</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">reshape2</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">lubridate</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">htmlTable</span><span class="p">)</span><span class="w">
</span><span class="n">df</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">read.csv2</span><span class="p">(</span><span class="s2">&quot;/home/sillas/R/data/transparenciaComSalarios.csv&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">stringsAsFactors</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">FALSE</span><span class="p">,</span><span class="w"> </span><span class="n">fileEncoding</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;ISO-8859-15&quot;</span><span class="p">)</span></code></pre>
</figure>
<p>
Você já teve curiosidade em saber quem são os funcionários públicos mais
ricos do Brasil? O sexto post da série de artigos sobre dados do Portal
da Transparência será dedicado a eles.
</p>
<p>
Primeiramente, quantos servidores compõem o 1%?
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">paste0</span><span class="p">(</span><span class="s2">&quot;O n&#xFA;mero total de servidores &#xE9;: &quot;</span><span class="p">,</span><span class="w"> </span><span class="n">nrow</span><span class="p">(</span><span class="n">df</span><span class="p">))</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## [1] &quot;O n&#xFA;mero total de servidores &#xE9;: 518270&quot;</code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-r"><span class="n">print</span><span class="p">(</span><span class="s2">&quot;\n&quot;</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## [1] &quot;\n&quot;</code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-r"><span class="n">paste0</span><span class="p">(</span><span class="s2">&quot;A quantidade de servidores do 1% &#xE9;: &quot;</span><span class="p">,</span><span class="w"> </span><span class="nf">round</span><span class="p">(</span><span class="n">nrow</span><span class="p">(</span><span class="n">df</span><span class="p">)</span><span class="o">*</span><span class="m">0.01</span><span class="p">))</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## [1] &quot;A quantidade de servidores do 1% &#xE9;: 5183&quot;</code></pre>
</figure>
<p>
Temos, então, que classificar os servidores em ordem decrescente de
salário e criar um data frame separado para os servidores do 1%
selecionando as primeiras 5183 linhas.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">umPorCento</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">df</span><span class="p">[</span><span class="n">order</span><span class="p">(</span><span class="o">-</span><span class="n">df</span><span class="o">$</span><span class="n">SALARIO</span><span class="p">),]</span><span class="w">
</span><span class="n">umPorCento</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">umPorCento</span><span class="p">[</span><span class="m">1</span><span class="o">:</span><span class="m">5183</span><span class="p">,]</span></code></pre>
</figure>
<p>
Todo o movimento do Occupy Wall Street começou baseado no fato que 1% da
população americana detem cerca de 25% da massa salarial dos Estados
Unidos. Quanto deve ser esse valor tomando no contexto do funcionalismo
federal?
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="c1"># Sal&#xE1;rio dos 1%</span><span class="w">
</span><span class="nf">sum</span><span class="p">(</span><span class="n">umPorCento</span><span class="o">$</span><span class="n">SALARIO</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## [1] 146524625</code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-r"><span class="c1"># Sal&#xE1;rio total</span><span class="w">
</span><span class="nf">sum</span><span class="p">(</span><span class="n">df</span><span class="o">$</span><span class="n">SALARIO</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## [1] 4377796333</code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-r"><span class="c1"># Porcentagem</span><span class="w">
</span><span class="nf">round</span><span class="p">(</span><span class="m">100</span><span class="o">*</span><span class="p">(</span><span class="nf">sum</span><span class="p">(</span><span class="n">umPorCento</span><span class="o">$</span><span class="n">SALARIO</span><span class="p">)</span><span class="o">/</span><span class="nf">sum</span><span class="p">(</span><span class="n">df</span><span class="o">$</span><span class="n">SALARIO</span><span class="p">)),</span><span class="m">2</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## [1] 3.35</code></pre>
</figure>
<p>
Os 1% dos servidores mais ricos detem 3,35% dos salários somados de
todos os servidores federais. Comparado com a população americana,
estamos mais distribuídos.
</p>
<p>
Estados Unidos a parte, quem são os 1%? Para traçar o perfil médio dos
servidores do grupo, vamos analisar:
</p>
<h2 id="1-onde-eles-est&#xE3;o">
1.  Onde eles estão?
    </h2>
    <figure class="highlight">
    <pre><code class="language-r"><span class="n">temp</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">umPorCento</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">group_by</span><span class="p">(</span><span class="n">UF_EXERCICIO</span><span class="p">,</span><span class="w"> </span><span class="n">REGIAO</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">summarise</span><span class="p">(</span><span class="n">quantidade</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">n</span><span class="p">())</span><span class="w"> </span><span class="n">ggplot</span><span class="p">(</span><span class="n">temp</span><span class="p">,</span><span class="w"> </span><span class="n">aes</span><span class="p">(</span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">reorder</span><span class="p">(</span><span class="n">UF_EXERCICIO</span><span class="p">,</span><span class="w"> </span><span class="o">-</span><span class="n">quantidade</span><span class="p">),</span><span class="w"> </span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">quantidade</span><span class="p">,</span><span class="w"> </span><span class="n">fill</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">REGIAO</span><span class="p">))</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">geom_bar</span><span class="p">(</span><span class="n">stat</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;identity&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">labs</span><span class="p">(</span><span class="n">title</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Quantidade de\n servidores por estado&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">theme</span><span class="p">(</span><span class="n">legend.position</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;bottom&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">legend.title</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">element_blank</span><span class="p">())</span></code></pre>
    </figure>
    <p>
    <img src="http://sillasgonzaga.github.io/figs/transparenciaParte6/unnamed-chunk-5-1.png" alt="center">
    </p>
    <p>
    Melhor do que apresentar esses resultados isolados é comparar com os
    resultados apresentados no
    <a href="http://sillasgonzaga.github.io/blog/transparencia1/">primeiro
    post</a> desta série. Para isso, ao invés de trabalhar com
    quantidade, veremos o porcentual de servidores que está alocado em
    cada UF.
    </p>
    <figure class="highlight">
    <pre><code class="language-r"><span class="n">temp2</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">df</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">group_by</span><span class="p">(</span><span class="n">UF_EXERCICIO</span><span class="p">,</span><span class="w"> </span><span class="n">REGIAO</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">summarise</span><span class="p">(</span><span class="n">quantidadeNormal</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">n</span><span class="p">())</span><span class="w"> </span><span class="c1"># transformar quantidade em porcentagem do total</span><span class="w">
    </span><span class="n">temp</span><span class="o">$</span><span class="n">quantidade</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="m">100</span><span class="o">*</span><span class="n">temp</span><span class="o">$</span><span class="n">quantidade</span><span class="o">/</span><span class="nf">sum</span><span class="p">(</span><span class="n">temp</span><span class="o">$</span><span class="n">quantidade</span><span class="p">)</span><span class="w">
    </span><span class="n">temp2</span><span class="o">$</span><span class="n">quantidadeNormal</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="m">100</span><span class="o">*</span><span class="n">temp2</span><span class="o">$</span><span class="n">quantidadeNormal</span><span class="o">/</span><span class="nf">sum</span><span class="p">(</span><span class="n">temp2</span><span class="o">$</span><span class="n">quantidadeNormal</span><span class="p">)</span><span class="w"> </span><span class="n">comparacao</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">merge</span><span class="p">(</span><span class="n">temp</span><span class="p">,</span><span class="w"> </span><span class="n">temp2</span><span class="p">,</span><span class="w"> </span><span class="n">by</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;UF_EXERCICIO&quot;</span><span class="p">)</span><span class="w"> </span><span class="n">temp3</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">select</span><span class="p">(</span><span class="n">comparacao</span><span class="p">,</span><span class="w"> </span><span class="n">UF_EXERCICIO</span><span class="p">,</span><span class="w"> </span><span class="n">REGIAO</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">REGIAO.x</span><span class="p">,</span><span class="w"> </span><span class="n">quantidade1</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">quantidade</span><span class="p">,</span><span class="w"> </span><span class="n">quantidadeNormal</span><span class="p">)</span><span class="w"> </span><span class="n">temp3</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">melt</span><span class="p">(</span><span class="n">temp3</span><span class="p">,</span><span class="w"> </span><span class="n">id.vars</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="s2">&quot;UF_EXERCICIO&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;REGIAO&quot;</span><span class="p">))</span><span class="w"> </span><span class="c1">#mudar nome do fator para aparecer bonito no gr&#xE1;fico</span><span class="w">
    </span><span class="n">levels</span><span class="p">(</span><span class="n">temp3</span><span class="o">$</span><span class="n">variable</span><span class="p">)</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="s2">&quot;Grupo dos 1%&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;Total geral&quot;</span><span class="p">)</span><span class="w"> </span><span class="n">ggplot</span><span class="p">(</span><span class="n">temp3</span><span class="p">,</span><span class="w"> </span><span class="n">aes</span><span class="p">(</span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">UF_EXERCICIO</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">value</span><span class="p">,</span><span class="w"> </span><span class="n">fill</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">variable</span><span class="p">))</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">geom_bar</span><span class="p">(</span><span class="n">stat</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;identity&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">position</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;dodge&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">labs</span><span class="p">(</span><span class="n">title</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Porcentual da quantidade de\n servidores por estado&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;%&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">theme</span><span class="p">(</span><span class="n">legend.position</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;bottom&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">legend.title</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">element_blank</span><span class="p">())</span></code></pre>
    </figure>
    <p>
    <img src="http://sillasgonzaga.github.io/figs/transparenciaParte6/unnamed-chunk-6-1.png" alt="center">
    </p>
    <p>
    Mais uma vez o DF desponta como anomalia, onde mais de 35% dos
    servidores mais ricos estão alocados.
    </p>
    <h2 id="2-em-quais-cargos-trabalham">
    1.  Em quais cargos trabalham?
        </h2>
        <figure class="highlight">
        <pre><code class="language-r"><span class="n">temp</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">umPorCento</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">group_by</span><span class="p">(</span><span class="n">ORG_LOTACAO</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">summarise</span><span class="p">(</span><span class="n">quantidade</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">n</span><span class="p">())</span><span class="w"> </span><span class="n">temp2</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">df</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">group_by</span><span class="p">(</span><span class="n">ORG_LOTACAO</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">summarise</span><span class="p">(</span><span class="n">quantidadeNormal</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">n</span><span class="p">())</span><span class="w"> </span><span class="c1"># transformar quantidade em porcentagem do total</span><span class="w">
        </span><span class="n">temp</span><span class="o">$</span><span class="n">quantidade</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="m">100</span><span class="o">*</span><span class="n">temp</span><span class="o">$</span><span class="n">quantidade</span><span class="o">/</span><span class="nf">sum</span><span class="p">(</span><span class="n">temp</span><span class="o">$</span><span class="n">quantidade</span><span class="p">)</span><span class="w">
        </span><span class="n">temp2</span><span class="o">$</span><span class="n">quantidadeNormal</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="m">100</span><span class="o">*</span><span class="n">temp2</span><span class="o">$</span><span class="n">quantidadeNormal</span><span class="o">/</span><span class="nf">sum</span><span class="p">(</span><span class="n">temp2</span><span class="o">$</span><span class="n">quantidadeNormal</span><span class="p">)</span><span class="w"> </span><span class="c1"># filtrar 20 maiores de cada</span><span class="w">
        </span><span class="n">temp</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">temp</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">top_n</span><span class="p">(</span><span class="m">20</span><span class="p">)</span><span class="w"> </span><span class="n">temp2</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">temp2</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">top_n</span><span class="p">(</span><span class="m">20</span><span class="p">)</span><span class="w"> </span><span class="n">comparacao</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">merge</span><span class="p">(</span><span class="n">temp</span><span class="p">,</span><span class="w"> </span><span class="n">temp2</span><span class="p">,</span><span class="w"> </span><span class="n">by</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;ORG_LOTACAO&quot;</span><span class="p">)</span><span class="w">
        </span><span class="n">temp3</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">select</span><span class="p">(</span><span class="n">comparacao</span><span class="p">,</span><span class="w"> </span><span class="n">ORG_LOTACAO</span><span class="p">,</span><span class="w"> </span><span class="n">quantidade1</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">quantidade</span><span class="p">,</span><span class="w"> </span><span class="n">quantidadeNormal</span><span class="p">)</span><span class="w"> </span><span class="n">temp3</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">melt</span><span class="p">(</span><span class="n">temp3</span><span class="p">,</span><span class="w"> </span><span class="n">id.vars</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;ORG_LOTACAO&quot;</span><span class="p">)</span><span class="w"> </span><span class="c1">#mudar nome do fator para aparecer bonito no gr&#xE1;fico</span><span class="w">
        </span><span class="n">levels</span><span class="p">(</span><span class="n">temp3</span><span class="o">$</span><span class="n">variable</span><span class="p">)</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="s2">&quot;Grupo dos 1%&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;Total geral&quot;</span><span class="p">)</span><span class="w"> </span><span class="n">ggplot</span><span class="p">(</span><span class="n">temp3</span><span class="p">,</span><span class="w"> </span><span class="n">aes</span><span class="p">(</span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">ORG_LOTACAO</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">value</span><span class="p">,</span><span class="w"> </span><span class="n">fill</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">variable</span><span class="p">))</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">geom_bar</span><span class="p">(</span><span class="n">stat</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;identity&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">position</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;dodge&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">labs</span><span class="p">(</span><span class="n">title</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Porcentual da quantidade de\n servidores por &#xF3;rg&#xE3;o&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;%&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">coord_flip</span><span class="p">()</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">theme</span><span class="p">(</span><span class="n">legend.position</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;bottom&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">legend.title</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">element_blank</span><span class="p">())</span></code></pre>
        </figure>
        <p>
        <img src="http://sillasgonzaga.github.io/figs/transparenciaParte6/unnamed-chunk-7-1.png" alt="center">
        </p>
        <p>
        Também há uma discrepância notável aqui: Enquanto que apenas
        1,5% dos servidores federais trabalha na AGU, no grupo dos 1%
        esse percentual sobe para 9%.
        </p>
        <h2 id="3-qual-cargo-desempenham">
        1.  Qual cargo desempenham?
            </h2>
            <figure class="highlight">
            <pre><code class="language-r"><span class="n">umPorCento</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">group_by</span><span class="p">(</span><span class="n">DESCRICAO_CARGO</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">summarise</span><span class="p">(</span><span class="n">quantidade</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">n</span><span class="p">())</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">mutate</span><span class="p">(</span><span class="n">percentual</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">100</span><span class="o">*</span><span class="n">quantidade</span><span class="o">/</span><span class="nf">sum</span><span class="p">(</span><span class="n">quantidade</span><span class="p">))</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">na.omit</span><span class="p">()</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">top_n</span><span class="p">(</span><span class="m">20</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">ggplot</span><span class="p">(</span><span class="n">aes</span><span class="p">(</span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">reorder</span><span class="p">(</span><span class="n">DESCRICAO_CARGO</span><span class="p">,</span><span class="w"> </span><span class="n">percentual</span><span class="p">),</span><span class="w"> </span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">percentual</span><span class="p">))</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">labs</span><span class="p">(</span><span class="n">title</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Porcentual da quantidade de\n servidores por cargo&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;%&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">coord_flip</span><span class="p">()</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">geom_bar</span><span class="p">(</span><span class="n">stat</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;identity&quot;</span><span class="p">)</span></code></pre>
            </figure>
            <p>
            <img src="http://sillasgonzaga.github.io/figs/transparenciaParte6/unnamed-chunk-8-1.png" alt="center">
            </p>
            <p>
            Curiosamente, a maioria dos 1% são professores de
            universidades federais. Pelo visto não é todo professor que
            ganha pouco…
            </p>
            <h2 id="4-a-quanto-tempo-est&#xE3;o-no-cargo">
            1.  A quanto tempo estão no cargo?
                </h2>
                <figure class="highlight">
                <pre><code class="language-r"><span class="n">CalcAnos</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">t</span><span class="m">0</span><span class="p">,</span><span class="w"> </span><span class="n">t</span><span class="o">=</span><span class="n">today</span><span class="p">())</span><span class="w"> </span><span class="p">{</span><span class="w"> </span><span class="n">x</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">interval</span><span class="p">(</span><span class="n">t</span><span class="m">0</span><span class="p">,</span><span class="w"> </span><span class="n">t</span><span class="p">)</span><span class="w"> </span><span class="n">x</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">as.period</span><span class="p">(</span><span class="n">x</span><span class="p">)</span><span class="w"> </span><span class="n">x</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="nf">ceiling</span><span class="p">(</span><span class="n">year</span><span class="p">(</span><span class="n">x</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">month</span><span class="p">(</span><span class="n">x</span><span class="p">)</span><span class="o">/</span><span class="m">12</span><span class="p">)</span><span class="w"> </span><span class="nf">return</span><span class="p">(</span><span class="n">x</span><span class="p">)</span><span class="w">
                </span><span class="p">}</span><span class="w"> </span><span class="n">umPorCento</span><span class="o">$</span><span class="n">anos</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">umPorCento</span><span class="o">$</span><span class="n">DATA_DIPLOMA_INGRESSO_SERVICOPUBLICO</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">dmy</span><span class="p">()</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">CalcAnos</span><span class="w">
                </span><span class="n">df</span><span class="o">$</span><span class="n">anos</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">df</span><span class="o">$</span><span class="n">DATA_DIPLOMA_INGRESSO_SERVICOPUBLICO</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">dmy</span><span class="p">()</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">CalcAnos</span><span class="w"> </span><span class="n">par</span><span class="p">(</span><span class="n">mfrow</span><span class="o">=</span><span class="nf">c</span><span class="p">(</span><span class="m">2</span><span class="p">,</span><span class="m">2</span><span class="p">))</span><span class="w">
                </span><span class="n">hist</span><span class="p">(</span><span class="n">umPorCento</span><span class="o">$</span><span class="n">anos</span><span class="p">,</span><span class="w"> </span><span class="n">main</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Tempo trabalhando para o Estado\n(Grupo dos 1%)&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">xlab</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Anos&quot;</span><span class="p">)</span><span class="w">
                </span><span class="n">hist</span><span class="p">(</span><span class="n">df</span><span class="o">$</span><span class="n">anos</span><span class="p">,</span><span class="w"> </span><span class="n">main</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Tempo trabalhando para o Estado\n(Geral)&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">xlab</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Anos&quot;</span><span class="p">)</span><span class="w">
                </span><span class="n">boxplot</span><span class="p">(</span><span class="n">umPorCento</span><span class="o">$</span><span class="n">anos</span><span class="p">,</span><span class="w"> </span><span class="n">main</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Tempo trabalhando para o Estado\n(Grupo dos 1%)&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">ylab</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Anos&quot;</span><span class="p">)</span><span class="w">
                </span><span class="n">boxplot</span><span class="p">(</span><span class="n">df</span><span class="o">$</span><span class="n">anos</span><span class="p">,</span><span class="w"> </span><span class="n">main</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Tempo trabalhando para o Estado\n(Geral)&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">ylab</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Anos&quot;</span><span class="p">)</span></code></pre>
                </figure>
                <p>
                <img src="http://sillasgonzaga.github.io/figs/transparenciaParte6/unnamed-chunk-9-1.png" alt="center">
                </p>
                <p>
                Aqui temos o esperado: O tempo médio e mediano no
                funcionalismo público é maior para os 1% do que para o
                geral.
                </p>
                <figure class="highlight">
                <pre><code class="language-r"><span class="n">temp</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">umPorCento</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">group_by</span><span class="p">(</span><span class="n">SITUACAO_VINCULO</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">summarise</span><span class="p">(</span><span class="n">quantidade</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">n</span><span class="p">())</span><span class="w"> </span><span class="n">temp2</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">df</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">group_by</span><span class="p">(</span><span class="n">SITUACAO_VINCULO</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">summarise</span><span class="p">(</span><span class="n">quantidadeNormal</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">n</span><span class="p">())</span><span class="w"> </span><span class="c1"># transformar quantidade em porcentagem do total</span><span class="w">
                </span><span class="n">temp</span><span class="o">$</span><span class="n">quantidade</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="m">100</span><span class="o">*</span><span class="n">temp</span><span class="o">$</span><span class="n">quantidade</span><span class="o">/</span><span class="nf">sum</span><span class="p">(</span><span class="n">temp</span><span class="o">$</span><span class="n">quantidade</span><span class="p">)</span><span class="w">
                </span><span class="n">temp2</span><span class="o">$</span><span class="n">quantidadeNormal</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="m">100</span><span class="o">*</span><span class="n">temp2</span><span class="o">$</span><span class="n">quantidadeNormal</span><span class="o">/</span><span class="nf">sum</span><span class="p">(</span><span class="n">temp2</span><span class="o">$</span><span class="n">quantidadeNormal</span><span class="p">)</span><span class="w"> </span><span class="c1"># filtrar 20 maiores de cada</span><span class="w">
                </span><span class="n">temp</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">temp</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">top_n</span><span class="p">(</span><span class="m">20</span><span class="p">)</span><span class="w"> </span><span class="n">temp2</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">temp2</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">top_n</span><span class="p">(</span><span class="m">20</span><span class="p">)</span><span class="w"> </span><span class="n">comparacao</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">merge</span><span class="p">(</span><span class="n">temp</span><span class="p">,</span><span class="w"> </span><span class="n">temp2</span><span class="p">,</span><span class="w"> </span><span class="n">by</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;SITUACAO_VINCULO&quot;</span><span class="p">)</span><span class="w">
                </span><span class="n">temp3</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">select</span><span class="p">(</span><span class="n">comparacao</span><span class="p">,</span><span class="w"> </span><span class="n">SITUACAO_VINCULO</span><span class="p">,</span><span class="w"> </span><span class="n">quantidade1</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">quantidade</span><span class="p">,</span><span class="w"> </span><span class="n">quantidadeNormal</span><span class="p">)</span><span class="w"> </span><span class="n">temp3</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">melt</span><span class="p">(</span><span class="n">temp3</span><span class="p">,</span><span class="w"> </span><span class="n">id.vars</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;SITUACAO_VINCULO&quot;</span><span class="p">)</span><span class="w"> </span><span class="c1">#mudar nome do fator para aparecer bonito no gr&#xE1;fico</span><span class="w">
                </span><span class="n">levels</span><span class="p">(</span><span class="n">temp3</span><span class="o">$</span><span class="n">variable</span><span class="p">)</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="s2">&quot;Grupo dos 1%&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;Total geral&quot;</span><span class="p">)</span><span class="w"> </span><span class="n">ggplot</span><span class="p">(</span><span class="n">temp3</span><span class="p">,</span><span class="w"> </span><span class="n">aes</span><span class="p">(</span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">SITUACAO_VINCULO</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">value</span><span class="p">,</span><span class="w"> </span><span class="n">fill</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">variable</span><span class="p">))</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">geom_bar</span><span class="p">(</span><span class="n">stat</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;identity&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">position</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;dodge&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">labs</span><span class="p">(</span><span class="n">title</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Porcentual da quantidade de\n servidores por situa&#xE7;&#xE3;o do v&#xED;nculo&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;%&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">coord_flip</span><span class="p">()</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">theme</span><span class="p">(</span><span class="n">legend.position</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;bottom&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">legend.title</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">element_blank</span><span class="p">())</span></code></pre>
                </figure>
                <p>
                <img src="http://sillasgonzaga.github.io/figs/transparenciaParte6/unnamed-chunk-10-1.png" alt="center">
                </p>
                <p>
                <strong>Mais uma grande descoberta</strong>: O
                porcentual de servidores das categorias
                <em>“APOSENTADO”</em>, <em>“EXERC DESCENT CARREI”</em>
                (que são servidores das carreiras típicas de Estado
                vinculadas aos Ministérios do Planejamento, Orçamento e
                Gestão e Ministério da Fazenda que exercem as suas
                atividades na UJ mediante exercício descentralizado de
                atividade) e <em>“REQUISITADO”</em> (servidores que
                exercem atividades na UJ em razão de haverem sido
                requisitados conforme previsão do art. 93, inciso II, da
                Lei n.º 8.112/90) é muito maior no grupo dos 1% do que
                no geral.
                </p>
                <p>
                É só ver o resultado acima para o grupo dos aposentados
                para saber o que tem de errado com nossa previdência.
                </p>
                <h2 id="6-afinal-de-contas-quem-&#xE9;-o-que-ganha-mais">
                1.  Afinal de contas, quem é o que ganha mais?
                    </h2>
                    <figure class="highlight">
                    <pre><code class="language-r"><span class="n">umPorCento</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">select</span><span class="p">(</span><span class="o">-</span><span class="n">ID_SERVIDOR_PORTAL</span><span class="p">,</span><span class="w"> </span><span class="o">-</span><span class="n">V</span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="o">-</span><span class="n">x</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">top_n</span><span class="p">(</span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="n">SALARIO</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">t</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">htmlTable</span><span class="p">()</span></code></pre>
                    </figure>
                    <table class="gmisc_table">
                    <tbody>
                    <tr>
                    <td>
                    UF\_EXERCICIO
                    </td>
                    <td>
                    DF
                    </td>
                    </tr>
                    <tr>
                    <td>
                    NOME
                    </td>
                    <td>
                    MANOEL DIAS
                    </td>
                    </tr>
                    <tr>
                    <td>
                    DESCRICAO\_CARGO
                    </td>
                    <td>
                    MINISTRO DE ESTADO
                    </td>
                    </tr>
                    <tr>
                    <td>
                    ATIVIDADE
                    </td>
                    <td>
                    </td>
                    </tr>
                    <tr>
                    <td>
                    UORG\_LOTACAO
                    </td>
                    <td>
                    MINISTERIO DO TRABALHO E EMPREGO
                    </td>
                    </tr>
                    <tr>
                    <td>
                    ORG\_LOTACAO
                    </td>
                    <td>
                    MINISTERIO DO TRABALHO E EMPREGO
                    </td>
                    </tr>
                    <tr>
                    <td>
                    ORGSUP\_LOTACAO
                    </td>
                    <td>
                    MINISTERIO DO TRABALHO E EMPREGO
                    </td>
                    </tr>
                    <tr>
                    <td>
                    UORG\_EXERCICIO
                    </td>
                    <td>
                    MINISTERIO DO TRABALHO E EMPREGO
                    </td>
                    </tr>
                    <tr>
                    <td>
                    ORG\_EXERCICIO
                    </td>
                    <td>
                    MINISTERIO DO TRABALHO E EMPREGO
                    </td>
                    </tr>
                    <tr>
                    <td>
                    ORGSUP\_EXERCICIO
                    </td>
                    <td>
                    MINISTERIO DO TRABALHO E EMPREGO
                    </td>
                    </tr>
                    <tr>
                    <td>
                    SITUACAO\_VINCULO
                    </td>
                    <td>
                    NATUREZA ESPECIAL
                    </td>
                    </tr>
                    <tr>
                    <td>
                    REGIME\_JURIDICO
                    </td>
                    <td>
                    NATUREZA ESPECIAL
                    </td>
                    </tr>
                    <tr>
                    <td>
                    JORNADA\_DE\_TRABALHO
                    </td>
                    <td>
                    40 HORAS SEMANAIS
                    </td>
                    </tr>
                    <tr>
                    <td>
                    DATA\_INGRESSO\_CARGOFUNCAO
                    </td>
                    <td>
                    16/03/2013
                    </td>
                    </tr>
                    <tr>
                    <td>
                    DATA\_INGRESSO\_ORGAO
                    </td>
                    <td>
                    15/03/2013
                    </td>
                    </tr>
                    <tr>
                    <td>
                    DATA\_DIPLOMA\_INGRESSO\_SERVICOPUBLICO
                    </td>
                    <td>
                    15/03/2013
                    </td>
                    </tr>
                    <tr>
                    <td>
                    REGIAO
                    </td>
                    <td>
                    Centro-Oeste
                    </td>
                    </tr>
                    <tr>
                    <td>
                    SALARIO
                    </td>
                    <td>
                    52808.24
                    </td>
                    </tr>
                    <tr>
                    <td>
                    anos
                    </td>
                    <td>
                    3
                    </td>
                    </tr>
                    </tbody>
                    </table>
                    <p>
                    <strong>Por hoje, é só!</strong>
                    </p>
                    </article>

