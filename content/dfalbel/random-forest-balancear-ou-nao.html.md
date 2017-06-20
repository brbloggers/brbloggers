+++
title = "Random Forest: Balancear a base ou não?"
date = "2016-07-27"
categories = ["dfalbel"]
original_url = "http://dfalbel.github.io/2016/07/random-forest-balancear-ou-nao.html"
+++

<p class="post">
<article class="post-content">
<p>
Em alguns problemas, a taxa de resposta é muito pequena então, para
possuir uma quantidade suficiente de resposta é necessário um banco de
dados muito grande. Por exemplo, imagine um problema de classificação em
que a taxa de resposta é de apenas 0,1%. Para termos pelo menos 1000
respostas precisamos de uma base de dados de no mínimo 1.000.000
indivíduos. Ainda poderíamos dizer que 1000 respostas é pouco e dessa
forma precisaríamos de uma base ainda maior.
</p>
<p>
Uma possível solução para este problema é balancear a base, ou seja:
pegar todas as respostas e uma amostra de não-respostas.
</p>
<p>
Neste post, gostaria de avaliar o impacto do balanceamento no desempenho
do modelo.
</p>
<h2 id="simulando-um-banco-de-dados">
Simulando um banco de dados
</h2>
<p>
Os dados foram simulados usando o seguinte código. Ele cria variáveis
aleatórias uniformes e uma variável resposta de forma que quanto maior
cada uma das variáves, maior a probabilidade de resposta. Considerei um
valor
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
<h2 id="treinando">
Treinando
</h2>
<p>
Vamos comparar alguns modelos treinados em diferentes taxas de
balanceamento com o modelo treinado na base inteira. Os resultados
sempre serão avaliados na base de dados chamada teste.
</p>
<p>
Primeiramente vamos definir uma função balancear, que equilibra a taxa
de respostas na base de acordo com um parâmetro
<code class="highlighter-rouge">p</code>.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">suppressPackageStartupMessages</span><span class="p">(</span><span class="n">library</span><span class="p">(</span><span class="n">dplyr</span><span class="p">))</span><span class="w">
</span><span class="n">balancear</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">df</span><span class="p">,</span><span class="w"> </span><span class="n">p</span><span class="p">){</span><span class="w"> </span><span class="n">n_resposta</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="nf">sum</span><span class="p">(</span><span class="n">df</span><span class="o">$</span><span class="n">Y</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="s2">&quot;1&quot;</span><span class="p">)</span><span class="w"> </span><span class="n">n_n_resposta</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="nf">floor</span><span class="p">((</span><span class="m">1</span><span class="w"> </span><span class="o">-</span><span class="w"> </span><span class="n">p</span><span class="p">)</span><span class="o">*</span><span class="n">n_resposta</span><span class="o">/</span><span class="n">p</span><span class="p">)</span><span class="w"> </span><span class="n">bind_rows</span><span class="p">(</span><span class="w"> </span><span class="n">df</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">filter</span><span class="p">(</span><span class="n">Y</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="s2">&quot;1&quot;</span><span class="p">),</span><span class="w"> </span><span class="n">df</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">filter</span><span class="p">(</span><span class="n">Y</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="s2">&quot;0&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">sample_n</span><span class="p">(</span><span class="n">n_n_resposta</span><span class="p">)</span><span class="w"> </span><span class="p">)</span><span class="w">
</span><span class="p">}</span></code></pre>
</figure>
<p>
Agora vamos rodar o modelo para algumas taxas de desbalanceamento para
ver o que acontece com o desempenho. O modelo treinado será o random
forest usando o pacote
<code class="highlighter-rouge">randomForest</code>. A classificação
será avaliada com base na base de treino que está na proporção original
da base de treino (com 1% approx. de resposta).
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">suppressPackageStartupMessages</span><span class="p">(</span><span class="n">library</span><span class="p">(</span><span class="n">randomForest</span><span class="p">))</span><span class="w">
</span><span class="n">taxas</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="m">0.05</span><span class="p">,</span><span class="w"> </span><span class="m">0.1</span><span class="p">,</span><span class="w"> </span><span class="m">0.25</span><span class="p">,</span><span class="w"> </span><span class="m">0.5</span><span class="p">)</span><span class="w">
</span><span class="n">desempenhos</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">plyr</span><span class="o">::</span><span class="n">laply</span><span class="p">(</span><span class="n">taxas</span><span class="p">,</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">taxa</span><span class="p">){</span><span class="w"> </span><span class="n">df</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">balancear</span><span class="p">(</span><span class="n">treino</span><span class="p">,</span><span class="w"> </span><span class="n">p</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">taxa</span><span class="p">)</span><span class="w"> </span><span class="n">modelo</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">randomForest</span><span class="p">(</span><span class="n">Y</span><span class="w"> </span><span class="o">~</span><span class="n">.</span><span class="p">,</span><span class="w"> </span><span class="n">data</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">df</span><span class="p">,</span><span class="w"> </span><span class="n">ntree</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">100</span><span class="p">,</span><span class="w"> </span><span class="n">mtry</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">floor</span><span class="p">(</span><span class="nf">sqrt</span><span class="p">(</span><span class="m">10</span><span class="p">)),</span><span class="w"> </span><span class="n">nodesize</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">100</span><span class="w"> </span><span class="p">)</span><span class="w"> </span><span class="n">pred_base</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">predict</span><span class="p">(</span><span class="n">modelo</span><span class="p">,</span><span class="w"> </span><span class="n">df</span><span class="p">,</span><span class="w"> </span><span class="n">type</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;prob&quot;</span><span class="p">)[,</span><span class="m">2</span><span class="p">]</span><span class="w"> </span><span class="n">cortes</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">plyr</span><span class="o">::</span><span class="n">laply</span><span class="p">(</span><span class="n">sort</span><span class="p">(</span><span class="n">pred_base</span><span class="p">),</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">p</span><span class="p">){</span><span class="w"> </span><span class="n">tabela</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">table</span><span class="p">(</span><span class="n">pred_base</span><span class="w"> </span><span class="o">&gt;</span><span class="w"> </span><span class="n">p</span><span class="p">,</span><span class="w"> </span><span class="n">df</span><span class="o">$</span><span class="n">Y</span><span class="p">,</span><span class="w"> </span><span class="n">useNA</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;always&quot;</span><span class="p">)</span><span class="w"> </span><span class="n">ks</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">tabela</span><span class="p">[</span><span class="m">1</span><span class="p">,</span><span class="m">1</span><span class="p">]</span><span class="o">/</span><span class="nf">sum</span><span class="p">(</span><span class="n">tabela</span><span class="p">[,</span><span class="m">1</span><span class="p">])</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">tabela</span><span class="p">[</span><span class="m">2</span><span class="p">,</span><span class="m">2</span><span class="p">]</span><span class="o">/</span><span class="nf">sum</span><span class="p">(</span><span class="n">tabela</span><span class="p">[,</span><span class="m">2</span><span class="p">])</span><span class="w"> </span><span class="o">-</span><span class="w"> </span><span class="m">1</span><span class="w"> </span><span class="n">ks</span><span class="w"> </span><span class="p">})</span><span class="w"> </span><span class="n">corte</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="nf">max</span><span class="p">((</span><span class="n">sort</span><span class="p">(</span><span class="n">pred_base</span><span class="p">)[</span><span class="n">cortes</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="nf">max</span><span class="p">(</span><span class="n">cortes</span><span class="p">)]))</span><span class="w"> </span><span class="n">pred_teste</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">predict</span><span class="p">(</span><span class="n">modelo</span><span class="p">,</span><span class="w"> </span><span class="n">teste</span><span class="p">,</span><span class="w"> </span><span class="n">type</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;prob&quot;</span><span class="p">)[,</span><span class="m">2</span><span class="p">]</span><span class="w"> </span><span class="o">&gt;</span><span class="w"> </span><span class="n">corte</span><span class="w"> </span><span class="n">tabela</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">table</span><span class="p">(</span><span class="n">pred_teste</span><span class="p">,</span><span class="w"> </span><span class="n">teste</span><span class="o">$</span><span class="n">Y</span><span class="p">,</span><span class="w"> </span><span class="n">useNA</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;always&quot;</span><span class="p">)</span><span class="w"> </span><span class="n">tabela</span><span class="p">[</span><span class="m">1</span><span class="p">,</span><span class="m">1</span><span class="p">]</span><span class="o">/</span><span class="nf">sum</span><span class="p">(</span><span class="n">tabela</span><span class="p">[,</span><span class="m">1</span><span class="p">])</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">tabela</span><span class="p">[</span><span class="m">2</span><span class="p">,</span><span class="m">2</span><span class="p">]</span><span class="o">/</span><span class="nf">sum</span><span class="p">(</span><span class="n">tabela</span><span class="p">[,</span><span class="m">2</span><span class="p">])</span><span class="w"> </span><span class="o">-</span><span class="w"> </span><span class="m">1</span><span class="w">
</span><span class="p">})</span><span class="w">
</span><span class="nf">names</span><span class="p">(</span><span class="n">desempenhos</span><span class="p">)</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">taxas</span><span class="w">
</span><span class="n">desempenhos</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## 0.05 0.1 0.25 0.5 ## 0.4942124 0.5859000 0.6220510 0.6143771</code></pre>
</figure>
<p>
A tabela acima mostra o desempenho do modelo em cada uma das taxas de
desbalanceamento. Veja que o modelo desbanaceado com taxa de 25% ficou
melhor na base de teste do que o modelo construído com a taxa de 5%,
mais próximo da taxa original da base. Claro que isso é uma simulação
com apenas uma repetição, e o correto seria repetir o experimento para
diversas bases diversas vezes, mas acredito que já é possível ter uma
ideia do que acontece.
</p>
<blockquote>
<p>
Por esse estudo, parece que balancear a base melhora o desempenho do
modelo. Parece que para taxas acima de 25% de resposta o desempenho já é
muito semelhante.
</p>
</blockquote>
<p>
Com esse resultado, acredito que treinar o modelo em uma base com 50% de
resposta seja melhor, pois você terá uma base menor. Neste caso, um
modelo treinado com 2% da base foi tão eficaz quanto um modelo treinado
em toda a base.
</p>
<h2 id="mas-e-quando-estamos-estimando-probabilidades">
Mas e quando estamos estimando probabilidades?
</h2>
<p>
Em muitos problemas, estamos estimando probabilidades ao invés de
classificar observações. Neste caso esbarramos em um outro problema.
Como voltar a probabilidade à escala original. Nesta simulação seria
estimar a probabilidade de Y = 1 dados todas as covariáveis X.
</p>
<p>
Por exemplo compare as probabilidades pelo modelo balanceado com taxa de
50% de resposta e a probabilidade real de resposta (dada pela
simulação).
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">treino_bal</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">balancear</span><span class="p">(</span><span class="n">treino</span><span class="p">,</span><span class="w"> </span><span class="m">0.5</span><span class="p">)</span><span class="w">
</span><span class="n">modelo</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">randomForest</span><span class="p">(</span><span class="n">Y</span><span class="w"> </span><span class="o">~</span><span class="n">.</span><span class="p">,</span><span class="w"> </span><span class="n">data</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">treino_bal</span><span class="p">,</span><span class="w"> </span><span class="n">ntree</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">100</span><span class="p">,</span><span class="w"> </span><span class="n">mtry</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">floor</span><span class="p">(</span><span class="nf">sqrt</span><span class="p">(</span><span class="m">10</span><span class="p">)),</span><span class="w"> </span><span class="n">nodesize</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">100</span><span class="w"> </span><span class="p">)</span><span class="w">
</span><span class="n">prob_real_teste</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">apply</span><span class="p">(</span><span class="n">teste</span><span class="p">[,</span><span class="m">1</span><span class="o">:</span><span class="m">10</span><span class="p">],</span><span class="w"> </span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="n">sum</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">pnorm</span><span class="p">(</span><span class="m">8</span><span class="p">)</span><span class="w">
</span><span class="n">prob_modelo</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">predict</span><span class="p">(</span><span class="n">modelo</span><span class="p">,</span><span class="w"> </span><span class="n">teste</span><span class="p">,</span><span class="w"> </span><span class="n">type</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;prob&quot;</span><span class="p">)[,</span><span class="m">2</span><span class="p">]</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">ggplot2</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## ## Attaching package: &apos;ggplot2&apos;</code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## The following object is masked from &apos;package:randomForest&apos;:
## ## margin</code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-r"><span class="n">data.frame</span><span class="p">(</span><span class="n">prob_real_teste</span><span class="p">,</span><span class="w"> </span><span class="n">prob_modelo</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">ggplot</span><span class="p">(</span><span class="n">aes</span><span class="p">(</span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">prob_modelo</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">prob_real_teste</span><span class="p">))</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">geom_point</span><span class="p">(</span><span class="n">size</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">0.1</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">stat_smooth</span><span class="p">()</span></code></pre>
</figure>
<p>
<img src="http://dfalbel.github.io/images/2016-07-27-random-forest-balancear-ou-nao/unnamed-chunk-5-1.png" alt="plot of chunk unnamed-chunk-5">
</p>
<p>
As probabilidades não estão relacionadas linearmente. Ainda não
encontrei uma solução para retornar à escala original de uma forma
simples.
</p>
<p>
Assim que eu encontrar, será o assunto de um outro post.
</p>
</article>
<br> <ins class="adsbygoogle"></ins> <br>
</p>

