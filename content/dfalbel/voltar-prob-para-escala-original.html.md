+++
title = "Prevendo probabilidades em bases balanceadas"
date = "2016-08-01"
categories = ["dfalbel"]
original_url = "http://dfalbel.github.io/2016/08/voltar-prob-para-escala-original.html"
+++

<article class="post-content">
<p>
No
<a href="http://dfalbel.github.io/2016/07/random-forest-balancear-ou-nao.html">post
anterior</a> comentei sobre construir modelos em bases balanceadas para
prever eventos em que a base real é desbalanceada. Vimos que para
classificação, o modelo construido na base balanceada ficou um pouco
melhor. O problema é que quando estamos prevendo probabilidades, fica
difícil voltar a probabilidade para a escala original.
</p>
<p>
Fiz uma pergunta do Stack Exchange de Data Science e me sugeriram
pesquisar por
<a href="https://en.wikipedia.org/wiki/Platt_scaling">Platt Scaling</a>.
Ele sugere usar um modelo logístico para prever a probabilidade de
resposta usando o score do modelo original como covariável. Isso na
mesma base de dados. No estudo, Platt trata do SVM, em que o score é um
número de -1 a 1 e o score é transformado em classificação usando a
função <code class="highlighter-rouge">sign</code>. No meu caso, meu
mododelo já prevê uma probabilidade de resposta, ela apenas não está na
escala correta, mas achei a ideia interessante.
</p>
<p>
Um outro resultado que eu conhecia era a possibilidade de voltar a
probabilidade para a escala original quando o modelo ajustado foi uma
regressão logística. Esse resultado é apresentado na página 215 do
<a href="https://www.ime.usp.br/~giapaula/texto_2013.pdf">livro do
Gilberto A. Paula</a>.
</p>
<p>
Resolvi juntar os dois métodos. Vou ajustar um modelo de random forest,
usar a sua probabilidade estimada para prever a probabilidade de
resposta na base desbalanceada. Em seguida, vou usar o resultado do
livro do Gilberto para ajustar o intercepto do modelo e voltá-las para a
escala original.
</p>
<p>
Uma outra abordagem é descrita
<a href="https://www.researchgate.net/publication/283349138_Calibrating_Probability_with_Undersampling_for_Unbalanced_Classification">neste
artigo</a> de leitura razoavelmente simples. Aiás, é bom saber o nome
deste problema em ingês: Calibrating Probability with Undersampling for
Unbalanced Classification.
</p>
<h2 id="simulando-um-banco-de-dados">
Simulando um banco de dados
</h2>
<p>
Vou simular os dados usando o mesmo código do post anterior. A função
<code class="highlighter-rouge">simulate</code> definida a seguir gera
10 variáveis aleatórias com distribuição uniforme para serem usadas como
covariáveis. Em seguida soma todas essas probabilidades e compara define
que a probabilidade de Y = 1 é o quantil da normal de média 8. Depois
simulamos Y, usando a distribuição de bernoulli.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">library</span><span class="p">(</span><span class="n">magrittr</span><span class="p">)</span><span class="w">
</span><span class="n">simulate_data</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">n</span><span class="p">){</span><span class="w"> </span><span class="n">X</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">data.frame</span><span class="p">(</span><span class="n">matrix</span><span class="p">(</span><span class="n">runif</span><span class="p">(</span><span class="n">n</span><span class="o">*</span><span class="m">10</span><span class="p">),</span><span class="w"> </span><span class="n">ncol</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">10</span><span class="p">))</span><span class="w"> </span><span class="n">Y</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">data.frame</span><span class="p">(</span><span class="n">Y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">rbinom</span><span class="p">(</span><span class="n">n</span><span class="p">,</span><span class="w"> </span><span class="n">size</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="n">prob</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">apply</span><span class="p">(</span><span class="n">X</span><span class="p">,</span><span class="w"> </span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="n">sum</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">pnorm</span><span class="p">(</span><span class="n">mean</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">8</span><span class="p">)</span><span class="w"> </span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">as.factor</span><span class="p">()</span><span class="w"> </span><span class="p">)</span><span class="w"> </span><span class="n">dplyr</span><span class="o">::</span><span class="n">bind_cols</span><span class="p">(</span><span class="n">X</span><span class="p">,</span><span class="w"> </span><span class="n">Y</span><span class="p">)</span><span class="w">
</span><span class="p">}</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-r"><span class="n">set.seed</span><span class="p">(</span><span class="m">98123</span><span class="p">)</span><span class="w">
</span><span class="n">treino</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">simulate_data</span><span class="p">(</span><span class="m">100000</span><span class="p">)</span><span class="w">
</span><span class="n">teste</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">simulate_data</span><span class="p">(</span><span class="m">100000</span><span class="p">)</span></code></pre>
</figure>
<p>
Esse código gerou duas bases de dados com aproximadamente 1% de
respostas ou seja 1% de Y = 1.
</p>
<h2 id="ajustando-os-modelos">
Ajustando os modelos
</h2>
<p>
A função <code class="highlighter-rouge">balancear</code> faz com que o
banco de dados tenha <code class="highlighter-rouge">p</code> de
resposta e <code class="highlighter-rouge">1-p</code> de não resposta.
Vou treinar o modelo numa base balanceada com
<code class="highlighter-rouge">p = 50%</code>.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">suppressPackageStartupMessages</span><span class="p">(</span><span class="n">library</span><span class="p">(</span><span class="n">dplyr</span><span class="p">))</span><span class="w">
</span><span class="n">balancear</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">df</span><span class="p">,</span><span class="w"> </span><span class="n">p</span><span class="p">){</span><span class="w"> </span><span class="n">n_resposta</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="nf">sum</span><span class="p">(</span><span class="n">df</span><span class="o">$</span><span class="n">Y</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="s2">&quot;1&quot;</span><span class="p">)</span><span class="w"> </span><span class="n">n_n_resposta</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="nf">floor</span><span class="p">((</span><span class="m">1</span><span class="w"> </span><span class="o">-</span><span class="w"> </span><span class="n">p</span><span class="p">)</span><span class="o">*</span><span class="n">n_resposta</span><span class="o">/</span><span class="n">p</span><span class="p">)</span><span class="w"> </span><span class="n">bind_rows</span><span class="p">(</span><span class="w"> </span><span class="n">df</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">filter</span><span class="p">(</span><span class="n">Y</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="s2">&quot;1&quot;</span><span class="p">),</span><span class="w"> </span><span class="n">df</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">filter</span><span class="p">(</span><span class="n">Y</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="s2">&quot;0&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">sample_n</span><span class="p">(</span><span class="n">n_n_resposta</span><span class="p">)</span><span class="w"> </span><span class="p">)</span><span class="w">
</span><span class="p">}</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-r"><span class="n">suppressPackageStartupMessages</span><span class="p">(</span><span class="n">library</span><span class="p">(</span><span class="n">randomForest</span><span class="p">))</span><span class="w">
</span><span class="n">df</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">balancear</span><span class="p">(</span><span class="n">treino</span><span class="p">,</span><span class="w"> </span><span class="m">0.5</span><span class="p">)</span><span class="w">
</span><span class="n">modelo_rf</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">randomForest</span><span class="p">(</span><span class="n">Y</span><span class="w"> </span><span class="o">~</span><span class="w"> </span><span class="n">.</span><span class="p">,</span><span class="w"> </span><span class="n">data</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">df</span><span class="p">)</span></code></pre>
</figure>
<p>
Vou ajustar um modelo na base de treino full para poder comparar os dois
métodos (corrigir a probabilidade vs. ajustar na base full).
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">modelo_full</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">randomForest</span><span class="p">(</span><span class="n">Y</span><span class="w"> </span><span class="o">~</span><span class="w"> </span><span class="n">.</span><span class="p">,</span><span class="w"> </span><span class="n">data</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">treino</span><span class="p">)</span></code></pre>
</figure>
<p>
Usando a função <code class="highlighter-rouge">predict</code> podemos
obter a probabilidade de Y = 1 para cada uma das observações. São essas
probabilidades que vamos utilizar como covariável no modelo de regressão
logística.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">df_prob</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">data.frame</span><span class="p">(</span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">predict</span><span class="p">(</span><span class="n">modelo_rf</span><span class="p">,</span><span class="w"> </span><span class="n">type</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;prob&quot;</span><span class="p">)[,</span><span class="m">2</span><span class="p">],</span><span class="w"> </span><span class="n">Y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">df</span><span class="o">$</span><span class="n">Y</span><span class="w"> </span><span class="p">)</span><span class="w">
</span><span class="n">modelo_log</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">glm</span><span class="p">(</span><span class="n">Y</span><span class="o">~</span><span class="n">.</span><span class="p">,</span><span class="w"> </span><span class="n">data</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">df_prob</span><span class="p">,</span><span class="w"> </span><span class="n">family</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;binomial&quot;</span><span class="p">)</span><span class="w">
</span><span class="n">summary</span><span class="p">(</span><span class="n">modelo_log</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## ## Call:
## glm(formula = Y ~ ., family = &quot;binomial&quot;, data = df_prob)
## ## Deviance Residuals: ## Min 1Q Median 3Q Max ## -2.7229 -0.5224 0.0086 0.5908 2.5794 ## ## Coefficients:
## Estimate Std. Error z value Pr(&gt;|z|) ## (Intercept) -3.8514 0.1533 -25.12 &lt;2e-16 ***
## x 7.6192 0.2766 27.54 &lt;2e-16 ***
## ---
## Signif. codes: 0 &apos;***&apos; 0.001 &apos;**&apos; 0.01 &apos;*&apos; 0.05 &apos;.&apos; 0.1 &apos; &apos; 1
## ## (Dispersion parameter for binomial family taken to be 1)
## ## Null deviance: 3510.1 on 2531 degrees of freedom
## Residual deviance: 2033.9 on 2530 degrees of freedom
## AIC: 2037.9
## ## Number of Fisher Scoring iterations: 5</code></pre>
</figure>
<p>
Agora vamos comparar a probabilidade estimada pelo modelo de regressão
logística e pelo modelo de random forest na base que utilizamos para
treinar os modelos.
</p>
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
<pre><code class="language-r"><span class="n">data.frame</span><span class="p">(</span><span class="w"> </span><span class="n">prob_log</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">predict</span><span class="p">(</span><span class="n">modelo_log</span><span class="p">,</span><span class="w"> </span><span class="n">newdata</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">df_prob</span><span class="p">,</span><span class="w"> </span><span class="n">type</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;response&quot;</span><span class="p">),</span><span class="w"> </span><span class="n">prob_rf</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">predict</span><span class="p">(</span><span class="n">modelo_rf</span><span class="p">,</span><span class="w"> </span><span class="n">type</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;prob&quot;</span><span class="p">)[,</span><span class="m">2</span><span class="p">]</span><span class="w"> </span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">ggplot</span><span class="p">(</span><span class="n">aes</span><span class="p">(</span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">prob_log</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">prob_rf</span><span class="p">))</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">geom_point</span><span class="p">(</span><span class="n">size</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">0.1</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">stat_smooth</span><span class="p">()</span></code></pre>
</figure>
<p>
<img src="http://dfalbel.github.io/images/2016-08-01-voltar-prob-para-escala-original/unnamed-chunk-7-1.png" alt="plot of chunk unnamed-chunk-7">
</p>
<p>
Agora vamos aplicar a correção no intercepto do modelo de regressão
logística, assim vamos obter a probabilidade de resposta na escala
original. O novo intercepto deve ser calculado da seguinte forma:
</p>
<p>
Essa fórmula é reproduzida no código abaixo:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">modelo_log</span><span class="o">$</span><span class="n">coefficients</span><span class="p">[</span><span class="m">1</span><span class="p">]</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">modelo_log</span><span class="o">$</span><span class="n">coefficients</span><span class="p">[</span><span class="m">1</span><span class="p">]</span><span class="w"> </span><span class="o">-</span><span class="w"> </span><span class="nf">log</span><span class="p">(</span><span class="nf">sum</span><span class="p">(</span><span class="n">treino</span><span class="o">$</span><span class="n">Y</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="s2">&quot;0&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">/</span><span class="w"> </span><span class="nf">sum</span><span class="p">(</span><span class="n">treino</span><span class="o">$</span><span class="n">Y</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="s2">&quot;1&quot;</span><span class="p">))</span></code></pre>
</figure>
<h2 id="resultados">
Resultados
</h2>
<p>
Agora vamos aplicar os modelos em uma base de teste para verificar o
acerto do modelo. Nenhuma observação da base de teste foi utilizada na
construção do modelo.
</p>
<p>
Primeiro aplciamos o modelo de random forest:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">teste</span><span class="o">$</span><span class="n">x</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">predict</span><span class="p">(</span><span class="n">modelo_rf</span><span class="p">,</span><span class="w"> </span><span class="n">newdata</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">teste</span><span class="p">,</span><span class="w"> </span><span class="n">type</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;prob&quot;</span><span class="p">)[,</span><span class="m">2</span><span class="p">]</span></code></pre>
</figure>
<p>
Aqui <code class="highlighter-rouge">x</code> é a probabilidade de
<code class="highlighter-rouge">Y = 1</code> estimada pelo random
forest. Veja agora a comparação das duas probabilidades:
</p>
<ul>
<li>
prob\_real: probabilidade real de <code class="highlighter-rouge">Y =
1</code> determinada pela simulação e,
</li>
<li>
prob\_teste: probabilidade de <code class="highlighter-rouge">Y =
1</code> estimada pelos modelos combinados
</li>
</ul>
<figure class="highlight">
<pre><code class="language-r"><span class="n">prob_teste</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">predict</span><span class="p">(</span><span class="n">modelo_log</span><span class="p">,</span><span class="w"> </span><span class="n">teste</span><span class="p">,</span><span class="w"> </span><span class="n">type</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;response&quot;</span><span class="p">)</span><span class="w">
</span><span class="n">prob_real</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">apply</span><span class="p">(</span><span class="n">teste</span><span class="p">[,</span><span class="w"> </span><span class="m">1</span><span class="o">:</span><span class="m">10</span><span class="p">],</span><span class="w"> </span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="n">sum</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">pnorm</span><span class="p">(</span><span class="n">mean</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">8</span><span class="p">)</span><span class="w"> </span><span class="n">summary</span><span class="p">(</span><span class="nf">abs</span><span class="p">(</span><span class="n">prob_teste</span><span class="w"> </span><span class="o">-</span><span class="w"> </span><span class="n">prob_real</span><span class="p">))</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## Min. 1st Qu. Median Mean 3rd Qu. Max. ## 0.0000000 0.0004345 0.0009987 0.0062730 0.0040100 0.4889000</code></pre>
</figure>
<p>
Veja agora o erro quando o modelo for ajustado na base inteira:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">prob_full</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">predict</span><span class="p">(</span><span class="n">modelo_full</span><span class="p">,</span><span class="w"> </span><span class="n">newdata</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">teste</span><span class="p">,</span><span class="w"> </span><span class="n">type</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;prob&quot;</span><span class="p">)[,</span><span class="m">2</span><span class="p">]</span><span class="w">
</span><span class="n">summary</span><span class="p">(</span><span class="nf">abs</span><span class="p">(</span><span class="n">prob_full</span><span class="w"> </span><span class="o">-</span><span class="w"> </span><span class="n">prob_real</span><span class="p">))</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## Min. 1st Qu. Median Mean 3rd Qu. Max. ## 0.0000000 0.0005009 0.0027270 0.0090880 0.0090680 0.3561000 </code></pre>
</figure>
<p>
Veja tamb´me um gráfico das probabilidades estimadas pelo método das
bases balanceadas e as probabilidades reais. A reta em vermelho, é a
reta esperada se a probabilidade real estivesse sendo perfeitamente
estimada pelo modelo. A reta azul é a reta estimada usando os dados
obtidos.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">data.frame</span><span class="p">(</span><span class="w"> </span><span class="n">prob_teste</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">prob_teste</span><span class="p">,</span><span class="w"> </span><span class="n">prob_real</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">prob_real</span><span class="w"> </span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">ggplot</span><span class="p">(</span><span class="n">aes</span><span class="p">(</span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">prob_teste</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">prob_real</span><span class="p">))</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">geom_point</span><span class="p">(</span><span class="n">size</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">0.1</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">stat_smooth</span><span class="p">(</span><span class="n">method</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;lm&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">geom_abline</span><span class="p">(</span><span class="n">intercept</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">0</span><span class="p">,</span><span class="w"> </span><span class="n">slope</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="n">colour</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;red&quot;</span><span class="p">)</span></code></pre>
</figure>
<p>
<img src="http://dfalbel.github.io/images/2016-08-01-voltar-prob-para-escala-original/unnamed-chunk-12-1.png" alt="plot of chunk unnamed-chunk-12">
</p>
<h2 id="concluso">
Conclusão
</h2>
<p>
Neste estudo de simulação, a probabilidade estimada usando o modelo na
base balanceada e depois reajustada usando uma mistura do <em>Platt
Scaling</em> com a reponderação da amostra retrospectiva obteve bons
resultados. Além de aproximar bem a probabilidade real, aproximou-se
mais desta do que o modelo de random forest ajustado na base full. Se
comparar-mos a média, esse método teve erros cerca de 30% menores e se
compararmos a mediana, os erros foram aproximadamente 63% menores!
</p>
</article>

