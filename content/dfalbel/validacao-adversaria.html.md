+++
title = "Validação Adversária"
date = "2016-06-12"
categories = ["dfalbel"]
original_url = "http://dfalbel.github.io/2016/06/validacao-adversaria.html"
+++

<article class="post-content">
<p>
<a href="http://fastml.com/adversarial-validation-part-one/">Esse
post</a> do <a href="http://fastml.com/">FastML</a> fez uma análise bem
interessante sobre como são as bases de validação/avaliação de torneios
de Machine Learning como os que aparecem no
<a href="https://www.kaggle.com/">Kaggle</a> ou o do
<a href="https://numer.ai/">Numerai</a>. Ele comenta como em algumas
competições, a base de validação (base em que são avaliadas as predições
para o cálculo do seu score) possuem comportamento diferente da base
utilizada para treino. Nesse post, que é a primeira parte da análise do
Zygmund, ele mostra o exemplo de uma competição do Santander, que
aconteceu no Kaggle em que as duas bases de treino e teste possuem o
mesmo comportamento.
</p>
<p>
Na <a href="http://fastml.com/adversarial-validation-part-two/">parte 2
do post</a>, ele mostra que a base de treino do
<a href="https://numer.ai/">Numerai</a>, aquela da qual eles deixam a
variável <code class="highlighter-rouge">target</code> disponível é bem
diferente do banco de teste, que eles chamam de <em>tournament
dataset</em>. Até o próprio Numerai, recomendou a leitura deste post no
twitter.
</p>
<blockquote class="twitter-tweet">
<p>
Interesting idea on adversarial validation with Numerai data on
<a href="https://twitter.com/fastml">@fastml</a>
<a href="https://t.co/dqb0WupiMH">https://t.co/dqb0WupiMH</a>
</p>
— Numerai (@numerai)
<a href="https://twitter.com/numerai/status/740709465964478464">June 9,
2016</a>
</blockquote>
<p>
Resolvi replicar o experimento para verificar o resultado encontrado
pelo blog. Utilizei a mesma idéia proposta pelo FastMl: Empilhar a base
do torneio e a base de treino e tentar criar um modelo para prever se
uma observação é da base de treino. Se o acerto do modelo for perto de
50%, quer dizer que as bases são muito parecidas. Se o modelo conseguir
acertar de qual base de dados a observação é proveniente, significa que
os bancos de dados possuem características muito diferentes.
</p>
<h2 id="leitura-das-bases">
Leitura das bases
</h2>
<p>
Usei as bases que estão disponíveis no Numerai neste
<a href="https://numer.ai/">link</a>. Também as deixei dispoíveis no
<a href="https://github.com/dfalbel/dfalbel.github.io/tree/master/data/numerai-datasets">repositório
do blog</a>.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">library</span><span class="p">(</span><span class="n">dplyr</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## ## Attaching package: &apos;dplyr&apos;
## ## The following objects are masked from &apos;package:stats&apos;:
## ## filter, lag
## ## The following objects are masked from &apos;package:base&apos;:
## ## intersect, setdiff, setequal, union</code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-r"><span class="n">train_data</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">read.csv</span><span class="p">(</span><span class="s2">&quot;../data/numerai-datasets/numerai_training_data.csv&quot;</span><span class="p">)</span><span class="w">
</span><span class="n">test_data</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">read.csv</span><span class="p">(</span><span class="s2">&quot;../data/numerai-datasets/numerai_tournament_data.csv&quot;</span><span class="p">)</span></code></pre>
</figure>
<p>
Empilhando as duas e criando a resposta.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">data</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">bind_rows</span><span class="p">(</span><span class="w"> </span><span class="n">train_data</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">select</span><span class="p">(</span><span class="o">-</span><span class="n">target</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">mutate</span><span class="p">(</span><span class="n">TRAIN</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">TRUE</span><span class="p">),</span><span class="w"> </span><span class="n">test_data</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">select</span><span class="p">(</span><span class="o">-</span><span class="n">t_id</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">mutate</span><span class="p">(</span><span class="n">TRAIN</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">FALSE</span><span class="p">)</span><span class="w">
</span><span class="p">)</span><span class="w">
</span><span class="n">data</span><span class="o">$</span><span class="n">TRAIN</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">as.factor</span><span class="p">(</span><span class="n">data</span><span class="o">$</span><span class="n">TRAIN</span><span class="p">)</span></code></pre>
</figure>
<h2 id="visualizao">
Visualização
</h2>
<p>
Para visualizar as possíveis diferenças entre a base de treino e de
torneio, utilizamos componentes principais para reduzir a
dimensionalidade. Com isso, das 21 variáveis que possíamos inicialmente,
obtivemos 2, que podem ser facilmente ser representadas em um gráfico de
dispersão.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">pca</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">princomp</span><span class="p">(</span><span class="n">data</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">select</span><span class="p">(</span><span class="o">-</span><span class="n">TRAIN</span><span class="p">))</span><span class="w">
</span><span class="n">pca_df</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">pca</span><span class="o">$</span><span class="n">scores</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">data.frame</span><span class="p">()</span><span class="w">
</span><span class="n">pca_df</span><span class="o">$</span><span class="n">TRAIN</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">data</span><span class="o">$</span><span class="n">TRAIN</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-r"><span class="n">library</span><span class="p">(</span><span class="n">ggplot2</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## Warning: package &apos;ggplot2&apos; was built under R version 3.2.3</code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-r"><span class="n">pca_df</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">arrange</span><span class="p">(</span><span class="n">runif</span><span class="p">(</span><span class="n">nrow</span><span class="p">(</span><span class="n">.</span><span class="p">)))</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">ggplot</span><span class="p">(</span><span class="n">aes</span><span class="p">(</span><span class="n">Comp.1</span><span class="p">,</span><span class="w"> </span><span class="n">Comp.2</span><span class="p">))</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">geom_point</span><span class="p">(</span><span class="n">aes</span><span class="p">(</span><span class="n">color</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">TRAIN</span><span class="p">),</span><span class="w"> </span><span class="n">size</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">0.2</span><span class="p">,</span><span class="w"> </span><span class="n">alpha</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">0.3</span><span class="p">)</span></code></pre>
</figure>
<p>
<img src="http://dfalbel.github.io/images/2016-06-09-validacao-adversaria/unnamed-chunk-4-1.png" alt="plot of chunk unnamed-chunk-4">
</p>
<p>
Note que com essas duas dimensões não é perceptível a diferença entre os
dois bancos de dados.
</p>
<h2 id="ajustando-o-modelo">
Ajustando o modelo
</h2>
<p>
Aqui usei um modelo de random forest por meio do pacote
<code class="highlighter-rouge">caret</code>.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">library</span><span class="p">(</span><span class="n">randomForest</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## randomForest 4.6-12
## Type rfNews() to see new features/changes/bug fixes.
## ## Attaching package: &apos;randomForest&apos;
## ## The following object is masked from &apos;package:ggplot2&apos;:
## ## margin
## ## The following object is masked from &apos;package:dplyr&apos;:
## ## combine</code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-r"><span class="n">modelo</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">randomForest</span><span class="p">(</span><span class="n">TRAIN</span><span class="w"> </span><span class="o">~</span><span class="w"> </span><span class="n">.</span><span class="p">,</span><span class="w"> </span><span class="n">data</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">data</span><span class="p">,</span><span class="w"> </span><span class="n">ntree</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">100</span><span class="p">,</span><span class="w"> </span><span class="n">mtry</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">sqrt</span><span class="p">(</span><span class="m">21</span><span class="p">))</span><span class="w">
</span><span class="n">modelo</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## ## Call:
## randomForest(formula = TRAIN ~ ., data = data, ntree = 100, mtry = sqrt(21)) ## Type of random forest: classification
## Number of trees: 100
## No. of variables tried at each split: 5
## ## OOB estimate of error rate: 20.54%
## Confusion matrix:
## FALSE TRUE class.error
## FALSE 6007 25770 0.810963905
## TRUE 545 95775 0.005658223</code></pre>
</figure>
<p>
Na tabela acima, as linhas repesentam os valores verdadeiros e as
colunas as categorias previstas pelo modelo de random forest. Note que
das 96.320 observações da base de treino, o modelo classifica apenas 589
(menos de 1%) como base de teste.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">library</span><span class="p">(</span><span class="n">ROCR</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## Carregando pacotes exigidos: gplots</code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## Warning: package &apos;gplots&apos; was built under R version 3.2.4</code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## ## Attaching package: &apos;gplots&apos;
## ## The following object is masked from &apos;package:stats&apos;:
## ## lowess
## ## Carregando pacotes exigidos: methods</code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-r"><span class="n">pred</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">prediction</span><span class="p">(</span><span class="n">predict</span><span class="p">(</span><span class="n">modelo</span><span class="p">,</span><span class="w"> </span><span class="n">type</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;prob&quot;</span><span class="p">)[,</span><span class="m">2</span><span class="p">],</span><span class="w"> </span><span class="n">data</span><span class="o">$</span><span class="n">TRAIN</span><span class="p">)</span><span class="w">
</span><span class="nf">as.numeric</span><span class="p">(</span><span class="n">performance</span><span class="p">(</span><span class="n">pred</span><span class="w"> </span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;auc&quot;</span><span class="p">)</span><span class="o">@</span><span class="n">y.values</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## [1] 0.8364159</code></pre>
</figure>
<p>
Veja também que o AUC (área sobre a curva ROC) foi de 0.84, muito
próxima da relatada no post do FastML. Se a base de testes fosse
realmente uma amostra aleatória da base de treino, esse número deveria
ser próximo de 0.5.
</p>
<p>
Enfim, esse resultado é importante pois, se as duas bases possuem
comportamentos diferentes, é difícil saber qual o score que você teria
no final do torneio, apenas avaliando o seu erro na base de treino. A
recomendação do FastMl é validar o seu modelo nestas observações da base
de treini que o modelo de random forest classificou errôneamente como
base de teste, desta forma você teria uma estimativa mais precisa do
erro no final do torneio.
</p>
</article>

