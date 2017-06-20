+++
title = "Udacity Deep Learning Parte 2: Fully Connected"
date = "2017-01-08"
categories = ["dfalbel"]
original_url = "http://dfalbel.github.io/2017/01/udacity-deep-learning-02.html"
+++

<article class="post-content">
<p>
No
<a href="http://dfalbel.github.io/2017/01/udacity-deep-learning-01.html">primeiro
post dessa série</a> montamos um banco de dados de imagens que está
pronto para a modelagem. Também ajustamos um classificador
<em>off-the-shelf</em>, o <code class="highlighter-rouge">xgboost</code>
nesses dados e obtivemos acerto de 91% de classificação na base de
testes.
</p>
<p>
Agora vamos ajustar modelos que começam a fazer parte do mundo deep
learning. Um deles é a regressão logística, que neste mundo é mais
conhecida como softmax regression. Neste post vamos ajustar essa
regressão logística e em seguida uma redeu neural com mais camadas.
</p>
<p>
Para treinar esses modelos vamos ustilizar o TensorFlow, uma biblioteca
open source concebida pelo Google especialmente para ajustar modelos
deste tipo. Já falamos dela
<a href="http://dfalbel.github.io/2016/10/two-layer-perceptron-tensorflow.html">aqui</a>
e neste post, vamos usar uma interface de maior nível, para que seja
mais fácil explicitar esses modelos no código.
</p>
<p>
O pacote do R que será utilizado, tem o mesmo nome que a biblioteca
feita pelo Google: <code class="highlighter-rouge">tensorflow</code> e
pode ser instalada usando o comando
<code class="highlighter-rouge">devtools::install\_github('rstudio/tensorflow')</code>.
Talvez você tenha que instalar o TensorFlow do Google antes, mas nao é
nada de outro mundo.
</p>
<h2 id="carregando-o-banco-de-dados">
Carregando o banco de dados
</h2>
<p>
No
<a href="http://dfalbel.github.io/2017/01/udacity-deep-learning-01.html">post
anterior</a> criamos o banco de dados, portanto se você ainda não criou,
volte lá.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">train_data</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">readRDS</span><span class="p">(</span><span class="s1">&apos;train_dataset.rds&apos;</span><span class="p">)</span><span class="w">
</span><span class="n">test_data</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">readRDS</span><span class="p">(</span><span class="s1">&apos;test_dataset.rds&apos;</span><span class="p">)</span></code></pre>
</figure>
<h2 id="regresso-softmax">
Regressão Softmax
</h2>
<p>
O TensorFlow trabalha com a definição de grafos de operações. Primeiro
você define esses grafos e depois os executa por meio de um objeto de
classe <code class="highlighter-rouge">Session</code>.
</p>
<p>
Sem mais detalhes, vamos ao código:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">library</span><span class="p">(</span><span class="n">tensorflow</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">magrittr</span><span class="p">)</span><span class="w"> </span><span class="c1"># criar sess&#xE3;o
</span><span class="n">session</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">tf</span><span class="o">$</span><span class="n">Session</span><span class="p">()</span><span class="w"> </span><span class="c1"># definir o placeholder dos inputs
</span><span class="n">x</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">tf</span><span class="o">$</span><span class="n">placeholder</span><span class="p">(</span><span class="n">tf</span><span class="o">$</span><span class="n">float32</span><span class="p">,</span><span class="w"> </span><span class="n">shape</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">shape</span><span class="p">(</span><span class="kc">NULL</span><span class="p">,</span><span class="w"> </span><span class="m">784L</span><span class="p">))</span><span class="w"> </span><span class="c1"># 784 &#xE9; o n&#xFA;mero de pixels de cada imagem.
</span><span class="n">y</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">tf</span><span class="o">$</span><span class="n">placeholder</span><span class="p">(</span><span class="n">tf</span><span class="o">$</span><span class="n">float32</span><span class="p">,</span><span class="w"> </span><span class="n">shape</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">shape</span><span class="p">(</span><span class="kc">NULL</span><span class="p">,</span><span class="w"> </span><span class="m">10L</span><span class="p">))</span><span class="w"> </span><span class="c1"># 10 &#xE9; o n&#xFA;mero de classes distintas
</span><span class="w">
</span><span class="c1"># definir o modelo
</span><span class="n">logits</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">tf</span><span class="o">$</span><span class="n">contrib</span><span class="o">$</span><span class="n">layers</span><span class="o">$</span><span class="n">linear</span><span class="p">(</span><span class="n">x</span><span class="p">,</span><span class="w"> </span><span class="m">10L</span><span class="p">)</span><span class="w">
</span><span class="n">y_</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">tf</span><span class="o">$</span><span class="n">nn</span><span class="o">$</span><span class="n">softmax</span><span class="p">(</span><span class="n">logits</span><span class="p">)</span><span class="w"> </span><span class="c1"># definir a fun&#xE7;&#xE3;o de perda
</span><span class="n">loss</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">tf</span><span class="o">$</span><span class="n">reduce_mean</span><span class="p">(</span><span class="n">tf</span><span class="o">$</span><span class="n">nn</span><span class="o">$</span><span class="n">softmax_cross_entropy_with_logits</span><span class="p">(</span><span class="n">logits</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="p">))</span><span class="w"> </span><span class="c1"># definir o m&#xE9;todo de optimiza&#xE7;&#xE3;o
</span><span class="n">optmizer</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">tf</span><span class="o">$</span><span class="n">train</span><span class="o">$</span><span class="n">GradientDescentOptimizer</span><span class="p">(</span><span class="m">0.5</span><span class="p">)</span><span class="w">
</span><span class="n">train_step</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">optmizer</span><span class="o">$</span><span class="n">minimize</span><span class="p">(</span><span class="n">loss</span><span class="p">)</span><span class="w"> </span><span class="n">init</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">tf</span><span class="o">$</span><span class="n">initialize_all_variables</span><span class="p">()</span></code></pre>
</figure>
<p>
Em todo bloco acima definimos o grafo do modelo que iremos treinar na
sequência. Definimos:
</p>
<ul>
<li>
x: placeholder do input com valores do tipo float e com n linhas e 784
colunas
</li>
<li>
y: palceholder dos labels com valores do tipo int e com n linhas e 10
colunas
</li>
<li>
logits: a forma de cálculo dos logitos: uma camada inteiramente ligada
</li>
<li>
out: a forma de cálculodas probabilidades de cada classe. Aplicando a
função <em>softmax</em>
</li>
<li>
loss: a função de perda <em>cross entropy</em>
</li>
<li>
optmizer e train\_step: método de otimização: <em>Gradien Descent</em>
</li>
<li>
init: operação para inicializar as variáveis
</li>
</ul>
<p>
Certo! Antes de partir para a parte de ajuste do modelo vamos deixar o
banco de dados exatamente da forma que precisamos para o tensorflow.
Assim como para o <code class="highlighter-rouge">xgboost</code> no post
anterior, vamos precisar de uma matriz com cada linha uma imagem e 784
colunas: uma para cada píxel. Para os labels, vamos aplicar a
transformação <em>one hot encode</em> que nada mais é do que cada linha
ser uma imagem e cada coluna uma das possíveis classes. Essa matriz tem
valor 1 quando a imagem é daquela classe e 0 nas demais colunas. Assim
como no post anterior, também vamos transformar previamente os valores
de 0 a 255 para valores de -1 a 1.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">train_data</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="p">(</span><span class="n">train_data</span><span class="w"> </span><span class="o">-</span><span class="w"> </span><span class="p">(</span><span class="m">255</span><span class="o">/</span><span class="m">2</span><span class="p">))</span><span class="o">/</span><span class="p">(</span><span class="m">255</span><span class="o">/</span><span class="m">2</span><span class="p">)</span><span class="w">
</span><span class="n">test_data</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="p">(</span><span class="n">test_data</span><span class="w"> </span><span class="o">-</span><span class="w"> </span><span class="p">(</span><span class="m">255</span><span class="o">/</span><span class="m">2</span><span class="p">))</span><span class="o">/</span><span class="p">(</span><span class="m">255</span><span class="o">/</span><span class="m">2</span><span class="p">)</span><span class="w"> </span><span class="n">train_x</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">t</span><span class="p">(</span><span class="n">apply</span><span class="p">(</span><span class="n">train_data</span><span class="p">,</span><span class="w"> </span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="n">c</span><span class="p">))</span><span class="w">
</span><span class="n">train_y</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">model.matrix</span><span class="p">(</span><span class="o">~</span><span class="w"> </span><span class="m">0</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">as.factor</span><span class="p">(</span><span class="nf">dimnames</span><span class="p">(</span><span class="n">train_data</span><span class="p">)[[</span><span class="m">1</span><span class="p">]]))</span><span class="w"> </span><span class="n">test_x</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">t</span><span class="p">(</span><span class="n">apply</span><span class="p">(</span><span class="n">test_data</span><span class="p">,</span><span class="w"> </span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="n">c</span><span class="p">))</span><span class="w">
</span><span class="n">test_y</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">model.matrix</span><span class="p">(</span><span class="o">~</span><span class="w"> </span><span class="m">0</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">as.factor</span><span class="p">(</span><span class="nf">dimnames</span><span class="p">(</span><span class="n">test_data</span><span class="p">)[[</span><span class="m">1</span><span class="p">]]))</span></code></pre>
</figure>
<p>
Pronto! Agora podemos partir para o ajuste do algoritmo. Uma dos
diferenciais dos modelos de deep learning, é a otimização por meio do
<em>Stochastic Gradient Descent</em>, esse método permite a agilidade
para treinar os algoritmos e consiste em ao invés de ajustar os pesos do
modelo a cada iteração usando a base inteira, usa-se <em>batches</em>:
pequenas parcelas dos dados. Isso faz com que sejam necessárias muito
mais iterações até conseguir a convergência, no entanto cada iteração
demora muito menos. Na prática o <em>trade-off</em> vale a pena, ou
seja, fica mais rápido fazer muitas iterações pequenas do que poucas
grandes.
</p>
<p>
Agora veja o código usado para treinar o modelo.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">session</span><span class="o">$</span><span class="n">run</span><span class="p">(</span><span class="n">init</span><span class="p">)</span><span class="w">
</span><span class="n">n_steps</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="m">10000L</span><span class="w">
</span><span class="n">batch_size</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="m">128L</span><span class="w">
</span><span class="n">acc_loss</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="kc">NULL</span><span class="w">
</span><span class="n">indices_possiveis</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="kc">NULL</span><span class="w"> </span><span class="k">for</span><span class="p">(</span><span class="n">step</span><span class="w"> </span><span class="k">in</span><span class="w"> </span><span class="m">1</span><span class="o">:</span><span class="n">n_steps</span><span class="p">){</span><span class="w"> </span><span class="k">if</span><span class="p">(</span><span class="nf">length</span><span class="p">(</span><span class="n">indices_possiveis</span><span class="p">)</span><span class="w"> </span><span class="o">&lt;</span><span class="w"> </span><span class="n">batch_size</span><span class="p">){</span><span class="w"> </span><span class="n">indices_possiveis</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="m">1</span><span class="o">:</span><span class="n">nrow</span><span class="p">(</span><span class="n">train_x</span><span class="p">)</span><span class="w"> </span><span class="p">}</span><span class="w"> </span><span class="n">indices</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">sample</span><span class="p">(</span><span class="n">indices_possiveis</span><span class="p">,</span><span class="w"> </span><span class="n">batch_size</span><span class="p">)</span><span class="w"> </span><span class="n">indices_possiveis</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">indices_possiveis</span><span class="p">[</span><span class="o">!</span><span class="w"> </span><span class="n">indices_possiveis</span><span class="w"> </span><span class="o">%in%</span><span class="w"> </span><span class="n">indices</span><span class="p">]</span><span class="w"> </span><span class="n">batch_x</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">train_x</span><span class="p">[</span><span class="n">indices</span><span class="p">,]</span><span class="w"> </span><span class="n">batch_y</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">train_y</span><span class="p">[</span><span class="n">indices</span><span class="p">,]</span><span class="w"> </span><span class="n">result</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">session</span><span class="o">$</span><span class="n">run</span><span class="p">(</span><span class="nf">list</span><span class="p">(</span><span class="n">loss</span><span class="p">,</span><span class="w"> </span><span class="n">train_step</span><span class="p">),</span><span class="w"> </span><span class="n">feed_dict</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">dict</span><span class="p">(</span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">batch_x</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">batch_y</span><span class="p">))</span><span class="w"> </span><span class="n">acc_loss</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="n">acc_loss</span><span class="p">,</span><span class="w"> </span><span class="n">result</span><span class="p">[[</span><span class="m">1</span><span class="p">]])</span><span class="w"> </span><span class="k">if</span><span class="p">(</span><span class="n">step</span><span class="w"> </span><span class="o">%%</span><span class="w"> </span><span class="m">1000</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="m">0</span><span class="p">){</span><span class="w"> </span><span class="n">cat</span><span class="p">(</span><span class="n">sprintf</span><span class="p">(</span><span class="s1">&apos;Step: %04d Loss: %5.5f \n&apos;</span><span class="p">,</span><span class="w"> </span><span class="n">step</span><span class="p">,</span><span class="w"> </span><span class="n">mean</span><span class="p">(</span><span class="n">acc_loss</span><span class="p">)))</span><span class="w"> </span><span class="p">}</span><span class="w">
</span><span class="p">}</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## Step: 1000 Loss: 1.47180 ## Step: 2000 Loss: 1.41761 ## Step: 3000 Loss: 1.39570 ## Step: 4000 Loss: 1.38201 ## Step: 5000 Loss: 1.37048 ## Step: 6000 Loss: 1.36435 ## Step: 7000 Loss: 1.36048 ## Step: 8000 Loss: 1.35529 ## Step: 9000 Loss: 1.34832 ## Step: 10000 Loss: 1.34424</code></pre>
</figure>
<p>
A seguir definimos uma função que calcula a acurácia e a calculamos para
as bases de treino e de teste. Basicamente, essa função pega da matriz
de probabilidades, o número da coluna que possui maior probabildiade.
Eem seguida compara se essa coluna é a mesma que possui o 1, na mariz de
inputs verdadeiros.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">accuracy</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">x_</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="p">){</span><span class="w"> </span><span class="n">pred</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">session</span><span class="o">$</span><span class="n">run</span><span class="p">(</span><span class="n">y_</span><span class="p">,</span><span class="w"> </span><span class="n">feed_dict</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">dict</span><span class="p">(</span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">x_</span><span class="p">))</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">apply</span><span class="p">(</span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">x</span><span class="p">)</span><span class="w"> </span><span class="p">{</span><span class="w"> </span><span class="p">(</span><span class="m">1</span><span class="o">:</span><span class="m">10</span><span class="p">)[</span><span class="n">order</span><span class="p">(</span><span class="o">-</span><span class="n">x</span><span class="p">)][</span><span class="m">1</span><span class="p">]</span><span class="w"> </span><span class="p">})</span><span class="w"> </span><span class="n">real</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">apply</span><span class="p">(</span><span class="n">y</span><span class="p">,</span><span class="w"> </span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">x</span><span class="p">)</span><span class="w"> </span><span class="p">{</span><span class="w"> </span><span class="p">(</span><span class="m">1</span><span class="o">:</span><span class="m">10</span><span class="p">)[</span><span class="n">order</span><span class="p">(</span><span class="o">-</span><span class="n">x</span><span class="p">)][</span><span class="m">1</span><span class="p">]</span><span class="w"> </span><span class="p">})</span><span class="w"> </span><span class="nf">sum</span><span class="p">(</span><span class="n">real</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="n">pred</span><span class="p">)</span><span class="o">/</span><span class="nf">length</span><span class="p">(</span><span class="n">real</span><span class="p">)</span><span class="w">
</span><span class="p">}</span><span class="w"> </span><span class="n">accuracy</span><span class="p">(</span><span class="n">train_x</span><span class="p">,</span><span class="w"> </span><span class="n">train_y</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## [1] 0.8083162</code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-r"><span class="n">accuracy</span><span class="p">(</span><span class="n">test_x</span><span class="p">,</span><span class="w"> </span><span class="n">test_y</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## [1] 0.862743</code></pre>
</figure>
<p>
O modelo de regressão logística foi treinado e está acertando neste caso
80% das iamgens na base de treino e 86% na base de teste. Esse número
pode variar um pouco.
</p>
<p>
Agora vamos adaptar o exemplo acima para uma rede neural com uma camada
oculta. Você verá que pouco muda no código! Isso deve melhorar um pouco
o acerto do modelo.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="c1"># criar sess&#xE3;o
</span><span class="n">session</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">tf</span><span class="o">$</span><span class="n">Session</span><span class="p">()</span><span class="w"> </span><span class="c1"># definir o placeholder dos inputs
</span><span class="n">x</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">tf</span><span class="o">$</span><span class="n">placeholder</span><span class="p">(</span><span class="n">tf</span><span class="o">$</span><span class="n">float32</span><span class="p">,</span><span class="w"> </span><span class="n">shape</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">shape</span><span class="p">(</span><span class="kc">NULL</span><span class="p">,</span><span class="w"> </span><span class="m">784L</span><span class="p">))</span><span class="w"> </span><span class="c1"># 784 &#xE9; o n&#xFA;mero de pixels de cada imagem.
</span><span class="n">y</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">tf</span><span class="o">$</span><span class="n">placeholder</span><span class="p">(</span><span class="n">tf</span><span class="o">$</span><span class="n">float32</span><span class="p">,</span><span class="w"> </span><span class="n">shape</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">shape</span><span class="p">(</span><span class="kc">NULL</span><span class="p">,</span><span class="w"> </span><span class="m">10L</span><span class="p">))</span><span class="w"> </span><span class="c1"># 10 &#xE9; o n&#xFA;mero de classes distintas
</span><span class="w">
</span><span class="c1"># definir o modelo
</span><span class="n">layer1</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">tf</span><span class="o">$</span><span class="n">contrib</span><span class="o">$</span><span class="n">layers</span><span class="o">$</span><span class="n">fully_connected</span><span class="p">(</span><span class="n">x</span><span class="p">,</span><span class="w"> </span><span class="m">1024L</span><span class="p">,</span><span class="w"> </span><span class="n">activation_fn</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">tf</span><span class="o">$</span><span class="n">nn</span><span class="o">$</span><span class="n">relu</span><span class="p">)</span><span class="w"> </span><span class="c1"># s&#xF3; essa e a pr&#xF3;xima linha mudam
</span><span class="n">logits</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">tf</span><span class="o">$</span><span class="n">contrib</span><span class="o">$</span><span class="n">layers</span><span class="o">$</span><span class="n">linear</span><span class="p">(</span><span class="n">layer1</span><span class="p">,</span><span class="w"> </span><span class="m">10L</span><span class="p">)</span><span class="w">
</span><span class="n">y_</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">tf</span><span class="o">$</span><span class="n">nn</span><span class="o">$</span><span class="n">softmax</span><span class="p">(</span><span class="n">logits</span><span class="p">)</span><span class="w"> </span><span class="c1"># definir a fun&#xE7;&#xE3;o de perda
</span><span class="n">loss</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">tf</span><span class="o">$</span><span class="n">reduce_mean</span><span class="p">(</span><span class="n">tf</span><span class="o">$</span><span class="n">nn</span><span class="o">$</span><span class="n">softmax_cross_entropy_with_logits</span><span class="p">(</span><span class="n">logits</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="p">))</span><span class="w"> </span><span class="c1"># definir o m&#xE9;todo de optimiza&#xE7;&#xE3;o
</span><span class="n">optmizer</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">tf</span><span class="o">$</span><span class="n">train</span><span class="o">$</span><span class="n">GradientDescentOptimizer</span><span class="p">(</span><span class="m">0.5</span><span class="p">)</span><span class="w">
</span><span class="n">train_step</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">optmizer</span><span class="o">$</span><span class="n">minimize</span><span class="p">(</span><span class="n">loss</span><span class="p">)</span><span class="w"> </span><span class="n">init</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">tf</span><span class="o">$</span><span class="n">initialize_all_variables</span><span class="p">()</span></code></pre>
</figure>
<p>
O código para treinar o modelo é idêntico!
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">session</span><span class="o">$</span><span class="n">run</span><span class="p">(</span><span class="n">init</span><span class="p">)</span><span class="w">
</span><span class="n">n_steps</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="m">10000L</span><span class="w">
</span><span class="n">batch_size</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="m">128L</span><span class="w">
</span><span class="n">acc_loss</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="kc">NULL</span><span class="w">
</span><span class="n">indices_possiveis</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="kc">NULL</span><span class="w"> </span><span class="k">for</span><span class="p">(</span><span class="n">step</span><span class="w"> </span><span class="k">in</span><span class="w"> </span><span class="m">1</span><span class="o">:</span><span class="n">n_steps</span><span class="p">){</span><span class="w"> </span><span class="k">if</span><span class="p">(</span><span class="nf">length</span><span class="p">(</span><span class="n">indices_possiveis</span><span class="p">)</span><span class="w"> </span><span class="o">&lt;</span><span class="w"> </span><span class="n">batch_size</span><span class="p">){</span><span class="w"> </span><span class="n">indices_possiveis</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="m">1</span><span class="o">:</span><span class="n">nrow</span><span class="p">(</span><span class="n">train_x</span><span class="p">)</span><span class="w"> </span><span class="p">}</span><span class="w"> </span><span class="n">indices</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">sample</span><span class="p">(</span><span class="n">indices_possiveis</span><span class="p">,</span><span class="w"> </span><span class="n">batch_size</span><span class="p">)</span><span class="w"> </span><span class="n">indices_possiveis</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">indices_possiveis</span><span class="p">[</span><span class="o">!</span><span class="w"> </span><span class="n">indices_possiveis</span><span class="w"> </span><span class="o">%in%</span><span class="w"> </span><span class="n">indices</span><span class="p">]</span><span class="w"> </span><span class="n">batch_x</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">train_x</span><span class="p">[</span><span class="n">indices</span><span class="p">,]</span><span class="w"> </span><span class="n">batch_y</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">train_y</span><span class="p">[</span><span class="n">indices</span><span class="p">,]</span><span class="w"> </span><span class="n">result</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">session</span><span class="o">$</span><span class="n">run</span><span class="p">(</span><span class="nf">list</span><span class="p">(</span><span class="n">loss</span><span class="p">,</span><span class="w"> </span><span class="n">train_step</span><span class="p">),</span><span class="w"> </span><span class="n">feed_dict</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">dict</span><span class="p">(</span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">batch_x</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">batch_y</span><span class="p">))</span><span class="w"> </span><span class="n">acc_loss</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="n">acc_loss</span><span class="p">,</span><span class="w"> </span><span class="n">result</span><span class="p">[[</span><span class="m">1</span><span class="p">]])</span><span class="w"> </span><span class="k">if</span><span class="p">(</span><span class="n">step</span><span class="w"> </span><span class="o">%%</span><span class="w"> </span><span class="m">1000</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="m">0</span><span class="p">){</span><span class="w"> </span><span class="n">cat</span><span class="p">(</span><span class="n">sprintf</span><span class="p">(</span><span class="s1">&apos;Step: %04d Loss: %5.5f \n&apos;</span><span class="p">,</span><span class="w"> </span><span class="n">step</span><span class="p">,</span><span class="w"> </span><span class="n">mean</span><span class="p">(</span><span class="n">acc_loss</span><span class="p">)))</span><span class="w"> </span><span class="p">}</span><span class="w">
</span><span class="p">}</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## Step: 1000 Loss: 0.62297 ## Step: 2000 Loss: 0.56271 ## Step: 3000 Loss: 0.52699 ## Step: 4000 Loss: 0.49942 ## Step: 5000 Loss: 0.47542 ## Step: 6000 Loss: 0.45846 ## Step: 7000 Loss: 0.44240 ## Step: 8000 Loss: 0.42757 ## Step: 9000 Loss: 0.41236 ## Step: 10000 Loss: 0.39926</code></pre>
</figure>
<p>
Com a mesma função calculamos a acurácia do modelo.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">accuracy</span><span class="p">(</span><span class="n">train_x</span><span class="p">,</span><span class="w"> </span><span class="n">train_y</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## [1] 0.9323186</code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-r"><span class="n">accuracy</span><span class="p">(</span><span class="n">test_x</span><span class="p">,</span><span class="w"> </span><span class="n">test_y</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## [1] 0.9235206</code></pre>
</figure>
<p>
O resultado agora foi de 90% das imagens classificadas corretamente! Se
comparado à regressão logística, já melhoramos 10 pontos percentuais.
Ficamos também muito próximos do resultado do
<code class="highlighter-rouge">xgboost</code>. No próximo post você
verá como melhorar ainda mais os resultados obtidos aqui com técnicas
simples como regularização e dropout.
</p>
</article>

