+++
title = "Comparando os pacotes ranger e randomForest"
date = "2016-07-27"
categories = ["dfalbel"]
original_url = "http://dfalbel.github.io/2016/07/comparando-ranger-e-randomForest.html"
+++

<article class="post-content">
<p>
Este post tem o objetivo de comparar os pacotes
<a href="https://github.com/imbs-hl/ranger"><code class="highlighter-rouge">ranger</code></a>
e <code class="highlighter-rouge">randomForest</code> para treinar
modelos de Random Forest (Durd!). A motivação de fazer esta análise foi
observar que os dois pacotes têm resultados muitos distintos quando
estava usando-os para prever a probabilidade de um evento. Esta é uma
análise de simulação, portanto trata de um problema muito específico e
não deve ser considerado um resultado para qualquer banco de dados.
</p>
<h2 id="simulando-um-banco-de-dados">
Simulando um banco de dados
</h2>
<p>
Os dados foram simulados usando o seguinte código. Ele cria variáveis
aleatórias uniformes e uma variável resposta de forma que quanto maior
cada uma das variáves, maior a probabilidade de resposta.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">library</span><span class="p">(</span><span class="n">magrittr</span><span class="p">)</span><span class="w">
</span><span class="n">simulate_data</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">n</span><span class="p">){</span><span class="w"> </span><span class="n">X</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">data.frame</span><span class="p">(</span><span class="n">matrix</span><span class="p">(</span><span class="n">runif</span><span class="p">(</span><span class="n">n</span><span class="o">*</span><span class="m">10</span><span class="p">),</span><span class="w"> </span><span class="n">ncol</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">10</span><span class="p">))</span><span class="w"> </span><span class="n">Y</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">data.frame</span><span class="p">(</span><span class="n">Y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">rbinom</span><span class="p">(</span><span class="n">n</span><span class="p">,</span><span class="w"> </span><span class="n">size</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="n">prob</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">apply</span><span class="p">(</span><span class="n">X</span><span class="p">,</span><span class="w"> </span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="n">sum</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">pnorm</span><span class="p">(</span><span class="n">mean</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">5</span><span class="p">)</span><span class="w"> </span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">as.factor</span><span class="p">()</span><span class="w"> </span><span class="p">)</span><span class="w"> </span><span class="n">dplyr</span><span class="o">::</span><span class="n">bind_cols</span><span class="p">(</span><span class="n">X</span><span class="p">,</span><span class="w"> </span><span class="n">Y</span><span class="p">)</span><span class="w">
</span><span class="p">}</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-r"><span class="n">set.seed</span><span class="p">(</span><span class="m">98123</span><span class="p">)</span><span class="w">
</span><span class="n">treino</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">simulate_data</span><span class="p">(</span><span class="m">10000</span><span class="p">)</span><span class="w">
</span><span class="n">teste</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">simulate_data</span><span class="p">(</span><span class="m">10000</span><span class="p">)</span></code></pre>
</figure>
<h2 id="treinando">
Treinando
</h2>
<p>
Para comparar os dois pacotes vou treinar dois modelos usando os mesmos
parâmetros. Note que a probabilidade de *Y* = 1 é
<code class="highlighter-rouge">pnorm(X1 + ... + X10, mean = 5)</code>.
É esse valor que quero estimar com os dois pacotes.
</p>
<p>
Usando o <code class="highlighter-rouge">ranger</code> o modelo foi
treinado assim:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">library</span><span class="p">(</span><span class="n">ranger</span><span class="p">)</span><span class="w">
</span><span class="n">modelo_ranger</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">ranger</span><span class="p">(</span><span class="n">Y</span><span class="w"> </span><span class="o">~</span><span class="n">.</span><span class="p">,</span><span class="w"> </span><span class="n">data</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">treino</span><span class="p">,</span><span class="w"> </span><span class="n">num.trees</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">100</span><span class="p">,</span><span class="w"> </span><span class="n">mtry</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">floor</span><span class="p">(</span><span class="nf">sqrt</span><span class="p">(</span><span class="m">10</span><span class="p">)),</span><span class="w"> </span><span class="n">write.forest</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nb">T</span><span class="p">,</span><span class="w"> </span><span class="n">min.node.size</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">100</span><span class="p">,</span><span class="w"> </span><span class="n">probability</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nb">T</span><span class="w"> </span><span class="p">)</span></code></pre>
</figure>
<p>
Usando o <code class="highlighter-rouge">randomForest</code>:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">suppressPackageStartupMessages</span><span class="p">(</span><span class="n">library</span><span class="p">(</span><span class="n">randomForest</span><span class="p">))</span><span class="w">
</span><span class="n">modelo_randomForest</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">randomForest</span><span class="p">(</span><span class="n">Y</span><span class="w"> </span><span class="o">~</span><span class="n">.</span><span class="p">,</span><span class="w"> </span><span class="n">data</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">treino</span><span class="p">,</span><span class="w"> </span><span class="n">ntree</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">100</span><span class="p">,</span><span class="w"> </span><span class="n">mtry</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">floor</span><span class="p">(</span><span class="nf">sqrt</span><span class="p">(</span><span class="m">10</span><span class="p">)),</span><span class="w"> </span><span class="n">nodesize</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">100</span><span class="w"> </span><span class="p">)</span></code></pre>
</figure>
<h2 id="comparando-as-probabilidades-estimadas">
Comparando as probabilidades estimadas
</h2>
<p>
Vamos agora comparar as probabilidades estimadas na base de treino pelos
dois modelos. O seguinte código foi utilziado para calcular as
probabilidades preditas para cada um dos pacotes, além da probabilidade
real de resposta.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">pred_ranger</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">predict</span><span class="p">(</span><span class="n">modelo_ranger</span><span class="p">,</span><span class="w"> </span><span class="n">teste</span><span class="p">)</span><span class="o">$</span><span class="n">predictions</span><span class="p">[,</span><span class="m">2</span><span class="p">]</span><span class="w">
</span><span class="n">pred_randomForest</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">predict</span><span class="p">(</span><span class="n">modelo_randomForest</span><span class="p">,</span><span class="w"> </span><span class="n">teste</span><span class="p">,</span><span class="w"> </span><span class="n">type</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;prob&quot;</span><span class="p">)[,</span><span class="m">2</span><span class="p">]</span><span class="w">
</span><span class="n">prob_real</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">apply</span><span class="p">(</span><span class="n">teste</span><span class="p">[,</span><span class="m">1</span><span class="o">:</span><span class="m">10</span><span class="p">],</span><span class="w"> </span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="n">sum</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">pnorm</span><span class="p">(</span><span class="n">mean</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">5</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-r"><span class="n">library</span><span class="p">(</span><span class="n">ggplot2</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## ## Attaching package: &apos;ggplot2&apos;</code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## The following object is masked from &apos;package:randomForest&apos;:
## ## margin</code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-r"><span class="n">data.frame</span><span class="p">(</span><span class="n">pred_ranger</span><span class="p">,</span><span class="w"> </span><span class="n">pred_randomForest</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">ggplot</span><span class="p">(</span><span class="n">aes</span><span class="p">(</span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">pred_ranger</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">pred_randomForest</span><span class="p">))</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">geom_point</span><span class="p">(</span><span class="n">size</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">0.5</span><span class="p">)</span></code></pre>
</figure>
<p>
<img src="http://dfalbel.github.io/images/2016-07-27-comparando-ranger-e-randomForest/unnamed-chunk-6-1.png" alt="plot of chunk unnamed-chunk-6">
</p>
<p>
As probabilidades estimadas até são bastante relacionadas, no entanto os
dois modelos foram treinados no mesmo banco de dados e com os mesmos
parâmetros para o algoritmo. Será que isso é esperado?
</p>
<p>
Veja também a relação da probabilidade estimada pelo
<code class="highlighter-rouge">ranger</code> e pelo
<code class="highlighter-rouge">randomForest</code> quando comparada com
a probabilidade real.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">data.frame</span><span class="p">(</span><span class="n">prob_real</span><span class="p">,</span><span class="w"> </span><span class="n">pred_ranger</span><span class="p">,</span><span class="w"> </span><span class="n">pred_randomForest</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">tidyr</span><span class="o">::</span><span class="n">gather</span><span class="p">(</span><span class="n">pacote</span><span class="p">,</span><span class="w"> </span><span class="n">prob</span><span class="p">,</span><span class="w"> </span><span class="o">-</span><span class="n">prob_real</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">ggplot</span><span class="p">(</span><span class="n">aes</span><span class="p">(</span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">prob</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">prob_real</span><span class="p">))</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">geom_point</span><span class="p">(</span><span class="n">size</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">0.1</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">facet_wrap</span><span class="p">(</span><span class="o">~</span><span class="n">pacote</span><span class="p">)</span></code></pre>
</figure>
<p>
<img src="http://dfalbel.github.io/images/2016-07-27-comparando-ranger-e-randomForest/unnamed-chunk-7-1.png" alt="plot of chunk unnamed-chunk-7">
</p>
<p>
O que mais me chamou atenção é que a probabilidade estimada pelo
<code class="highlighter-rouge">randomForest</code> é muito mais
linearmente relacionada à probabilidade real de Y = 1, enquanto a
probabilidade estimada pelo
<code class="highlighter-rouge">ranger</code> apresenta uma curva no
formato de <em>logito</em>. Isso é relfletido no erro absoluto médio que
fica maior com o pacote <code class="highlighter-rouge">ranger</code>.
</p>
<p>
O erro médio absoluto nas probabilidades foi calculado abaixo para cada
um dos pacotes:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">mean</span><span class="p">(</span><span class="nf">abs</span><span class="p">(</span><span class="n">prob_real</span><span class="w"> </span><span class="o">-</span><span class="w"> </span><span class="n">pred_ranger</span><span class="p">))</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## [1] 0.09555774</code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-r"><span class="n">mean</span><span class="p">(</span><span class="nf">abs</span><span class="p">(</span><span class="n">prob_real</span><span class="w"> </span><span class="o">-</span><span class="w"> </span><span class="n">pred_randomForest</span><span class="p">))</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## [1] 0.07355277</code></pre>
</figure>
<h2 id="por-que-ocorre-esta-diferena">
Por que ocorre esta diferença?
</h2>
<p>
Provavelmente essa diferença está relacionada à forma com que cada
pacote estima a probabilidade de Y = 1. O
<code class="highlighter-rouge">ranger</code> fala explicitamente em
usar <em>probability forests</em> conforme aparece na
<a href="http://www.inside-r.org/packages/cran/ranger/docs/ranger">documentação</a>:
</p>
<blockquote>
<p>
Grow a probability forest as in Malley et al. (2012).
</p>
</blockquote>
<p>
Já para o <code class="highlighter-rouge">randomForest</code> não
encontrei a forma com que eles estima as probabilidades. Até fiz uma
<a href="http://stackoverflow.com/q/38618955/3297472">pergunta no SO</a>
mas ainda não responderam :(
</p>
</article>

