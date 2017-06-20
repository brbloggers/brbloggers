+++
title = "Two Hidden Layer Perceptrons no Tensorflow pelo R"
date = "2016-10-02"
categories = ["dfalbel"]
original_url = "http://dfalbel.github.io/2016/10/two-layer-perceptron-tensorflow.html"
+++

<article class="post-content">
<p>
Em novembro de 2015, a Google abriu o código do
<a href="https://www.tensorflow.org/">Tensorflow</a> que pelo próprio
site diz ser:
</p>
<blockquote>
<p>
TensorFlow™ is an open source software library for numerical computation
using data flow graphs. Nodes in the graph represent mathematical
operations, while the graph edges represent the multidimensional data
arrays (tensors) communicated between them.
</p>
</blockquote>
<p>
O TensorFlow é usado dentro de equipes de ponta do Google como o
<a href="https://research.google.com/teams/brain/">Google Brain</a> em
pesquisas sobre machine learning e <em>deep neural networks</em>
</p>
<p>
Na semana passada o Rstudio abriu o código de um
<a href="https://github.com/rstudio/tensorflow">pacote do R chamado
<code class="highlighter-rouge">tensorflow</code></a> escrito, na sua
maior parte pelo fundador do Rstudio,
<a href="https://github.com/jjallaire">JJ Allaire</a>.
</p>
<p>
Esse post o meu primeiro passo com esse pacote. Note que ele é um pouco
mais avançado do que o
<a href="https://rstudio.github.io/tensorflow/tutorial_mnist_beginners.html"><em>MNIST
For ML Beginners</em></a> do próprio tensorflow, e um pouco menos
avançado que o
<a href="https://rstudio.github.io/tensorflow/tutorial_mnist_pros.html"><em>Deep
MNIST for Experts</em></a>. Reproduzi, no R, o
<a href="https://github.com/aymericdamien/TensorFlow-Examples/blob/master/notebooks/3_NeuralNetworks/multilayer_perceptron.ipynb">notebook</a>
do <a href="https://github.com/aymericdamien">Aymeric Damien</a> que
implementa uma <code class="highlighter-rouge">multilayer
perceptron</code> usando TensorFlow no python.
</p>
<p>
Não vou entrar em detalhes em como instalar o pacote
<code class="highlighter-rouge">tensorflow</code>. Você pode encontrar
facilmente as instruções
<a href="https://rstudio.github.io/tensorflow/">aqui</a>.
</p>
<p>
Você passa dados para o tensorflow no formato de <em>multidimensional
data arrays</em>, quando traduzimos isso para o R, chegamos no formato
de matrizes (<code class="highlighter-rouge">matrix</code>). Portanto,
antes de mais nada, precisamos processar os dados, que geralmente estão
no formato de <code class="highlighter-rouge">data.frames</code>.
</p>
<p>
Disponibilizei uma parte do banco de dados mnist
<a href="https://github.com/dfalbel/dfalbel.github.io/tree/master/data">aqui</a>.
O mnist é um famoso banco de dados de imagens 28x28 de dígitos escritos
à mão já marcadas com o número que representam.
</p>
<p>
<img src="http://dfalbel.github.io/images/mnistExamples.png" alt="mnistExamples">
</p>
<p>
Para ler no R use o seguinte comando:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">library</span><span class="p">(</span><span class="n">tidyverse</span><span class="p">)</span><span class="w">
</span><span class="n">mnist</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">read_csv</span><span class="p">(</span><span class="s2">&quot;https://github.com/dfalbel/dfalbel.github.io/blob/master/data/train.csv?raw=true&quot;</span><span class="p">)</span></code></pre>
</figure>
<p>
Vamos tranformar o <code class="highlighter-rouge">mnist</code> em uma
matriz <code class="highlighter-rouge">X</code> com uma coluna para cada
pixel e uma matriz <code class="highlighter-rouge">Y</code> com uma
coluna para cada valor possível do label. Essa transformação para a
matriz Y é chamada de
<a href="https://en.wikipedia.org/wiki/One-hot"><em>one hot
encoding</em></a> e é bem comum na preparação dos bancos de dados para
machine learning.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">X</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">mnist</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">select</span><span class="p">(</span><span class="n">starts_with</span><span class="p">(</span><span class="s2">&quot;pixel&quot;</span><span class="p">))</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">as.matrix</span><span class="p">()</span><span class="w">
</span><span class="n">Y</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">mnist</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">select</span><span class="p">(</span><span class="n">label</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">mutate</span><span class="p">(</span><span class="n">id</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">row_number</span><span class="p">(),</span><span class="w"> </span><span class="n">value</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">1</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">spread</span><span class="p">(</span><span class="n">label</span><span class="p">,</span><span class="w"> </span><span class="n">value</span><span class="p">,</span><span class="w"> </span><span class="n">fill</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">0</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">select</span><span class="p">(</span><span class="o">-</span><span class="n">id</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">as.matrix</span><span class="p">()</span></code></pre>
</figure>
<p>
Assim temos os nossos dois principais inputs para o TensorFlow. Vou
ainda separar esses bancos em duas partes. Uma para treino e outra para
teste.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">indices_train</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">sample</span><span class="p">(</span><span class="m">1</span><span class="o">:</span><span class="n">nrow</span><span class="p">(</span><span class="n">X</span><span class="p">),</span><span class="w"> </span><span class="n">size</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">37000L</span><span class="p">)</span><span class="w"> </span><span class="n">X_train</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">X</span><span class="p">[</span><span class="n">indices_train</span><span class="p">,</span><span class="w"> </span><span class="p">]</span><span class="w">
</span><span class="n">Y_train</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">Y</span><span class="p">[</span><span class="n">indices_train</span><span class="p">,</span><span class="w"> </span><span class="p">]</span><span class="w"> </span><span class="n">X_test</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">X</span><span class="p">[</span><span class="o">-</span><span class="n">indices_train</span><span class="p">,</span><span class="w"> </span><span class="p">]</span><span class="w">
</span><span class="n">Y_test</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">Y</span><span class="p">[</span><span class="o">-</span><span class="n">indices_train</span><span class="p">,</span><span class="w"> </span><span class="p">]</span></code></pre>
</figure>
<p>
Agora vamos definir o modelo de two hidden layers perceptrons usando a
interface do TensorFlow no R. Para facilitar o código, estamos usando
apenas 2 camadas ocultas, mas isso pode ser facilmente generalizável
para quem entendeu este exemplo mais simples.
</p>
<p>
Vamos ajustar uma rede neural parecida com a do esquema abaixo, porém
com mais neurônios e com duas camadas.
</p>
<p>
<img src="http://dfalbel.github.io/images/neural-net.png" alt="Neuralnet">
<a href="http://neuralnetworksanddeeplearning.com/chap1.html">Fonte</a>
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">library</span><span class="p">(</span><span class="n">tensorflow</span><span class="p">)</span></code></pre>
</figure>
<p>
Em primeiro lugar definimos as propriedades da rede neural.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="c1"># Network Parameters
</span><span class="n">n_hidden_1</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">256L</span><span class="w"> </span><span class="c1"># 1st layer number of features
</span><span class="n">n_hidden_2</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">256L</span><span class="w"> </span><span class="c1"># 2nd layer number of features
</span><span class="n">n_input</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">as.integer</span><span class="p">(</span><span class="n">ncol</span><span class="p">(</span><span class="n">X</span><span class="p">))</span><span class="w"> </span><span class="c1"># MNIST data input (img shape: 28*28)
</span><span class="n">n_classes</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">as.integer</span><span class="p">(</span><span class="n">ncol</span><span class="p">(</span><span class="n">Y</span><span class="p">))</span><span class="w"> </span><span class="err">#</span><span class="w"> </span><span class="n">MNIST</span><span class="w"> </span><span class="n">total</span><span class="w"> </span><span class="n">classes</span><span class="w"> </span><span class="p">(</span><span class="m">0-9</span><span class="w"> </span><span class="n">digits</span><span class="p">)</span></code></pre>
</figure>
<p>
Esta rede terá duas camadas ocultas, cada uma delas com 256 neurônios. O
parâmetro <code class="highlighter-rouge">n\_input</code> indica o
tamanho do vetor que representa cada imagem. Neste caso ele possui
dimensão 784 (28x28: o número de pixels da imagem). O
<code class="highlighter-rouge">n\_classes</code> representa a
quantidade de classificações possíveis: 10, uma para cada número de 0 a
9.
</p>
<p>
No <code class="highlighter-rouge">tensorflow</code>, vamos definir o
formato dos inputs, por meio de placeholders.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">x</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">tf</span><span class="o">$</span><span class="n">placeholder</span><span class="p">(</span><span class="n">tf</span><span class="o">$</span><span class="n">float32</span><span class="p">,</span><span class="w"> </span><span class="n">shape</span><span class="p">(</span><span class="kc">NULL</span><span class="p">,</span><span class="w"> </span><span class="n">n_input</span><span class="p">))</span><span class="w">
</span><span class="n">y</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">tf</span><span class="o">$</span><span class="n">placeholder</span><span class="p">(</span><span class="n">tf</span><span class="o">$</span><span class="n">float32</span><span class="p">,</span><span class="w"> </span><span class="n">shape</span><span class="p">(</span><span class="kc">NULL</span><span class="p">,</span><span class="w"> </span><span class="n">n_classes</span><span class="p">))</span></code></pre>
</figure>
<p>
Estamos definindo <code class="highlighter-rouge">x</code> e
<code class="highlighter-rouge">y</code> como arrays bidimensionais. Com
<code class="highlighter-rouge">NULL</code> linhas e
<code class="highlighter-rouge">n\_input</code> ou
<code class="highlighter-rouge">n\_classes</code> colunas.
<code class="highlighter-rouge">NULL</code> indica que não sabemos
inicialmente a quantidade de linahs que vamos mandar.
</p>
<p>
Agora precisamos definir as matrizes de pesos e de viéses. Não quero
entrar em muitos detalhes teóricos sobre redes neurais, por isso
recomendo, para quem não estiver muito confortável com a estrutura de
uma rede neural, a leitura
<a href="http://neuralnetworksanddeeplearning.com/chap1.html">deste
capítulo</a> do livro de Michael Nielsen.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="c1"># Weights
</span><span class="n">w_h1</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">tf</span><span class="o">$</span><span class="n">Variable</span><span class="p">(</span><span class="n">tf</span><span class="o">$</span><span class="n">random_normal</span><span class="p">(</span><span class="n">shape</span><span class="p">(</span><span class="n">n_input</span><span class="p">,</span><span class="w"> </span><span class="n">n_hidden_1</span><span class="p">)))</span><span class="w">
</span><span class="n">w_h2</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">tf</span><span class="o">$</span><span class="n">Variable</span><span class="p">(</span><span class="n">tf</span><span class="o">$</span><span class="n">random_normal</span><span class="p">(</span><span class="n">shape</span><span class="p">(</span><span class="n">n_hidden_1</span><span class="p">,</span><span class="w"> </span><span class="n">n_hidden_2</span><span class="p">)))</span><span class="w">
</span><span class="n">w_out</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">tf</span><span class="o">$</span><span class="n">Variable</span><span class="p">(</span><span class="n">tf</span><span class="o">$</span><span class="n">random_normal</span><span class="p">(</span><span class="n">shape</span><span class="p">(</span><span class="n">n_hidden_2</span><span class="p">,</span><span class="w"> </span><span class="n">n_classes</span><span class="p">)))</span><span class="w"> </span><span class="c1"># Biases
</span><span class="n">b_h1</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">tf</span><span class="o">$</span><span class="n">Variable</span><span class="p">(</span><span class="n">tf</span><span class="o">$</span><span class="n">random_normal</span><span class="p">(</span><span class="n">shape</span><span class="p">(</span><span class="n">n_hidden_1</span><span class="p">)))</span><span class="w">
</span><span class="n">b_h2</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">tf</span><span class="o">$</span><span class="n">Variable</span><span class="p">(</span><span class="n">tf</span><span class="o">$</span><span class="n">random_normal</span><span class="p">(</span><span class="n">shape</span><span class="p">(</span><span class="n">n_hidden_2</span><span class="p">)))</span><span class="w">
</span><span class="n">b_out</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">tf</span><span class="o">$</span><span class="n">Variable</span><span class="p">(</span><span class="n">tf</span><span class="o">$</span><span class="n">random_normal</span><span class="p">(</span><span class="n">shape</span><span class="p">(</span><span class="n">n_classes</span><span class="p">)))</span></code></pre>
</figure>
<p>
<code class="highlighter-rouge">Variables</code> no TensorFlow são uma
forma de definir os parâmetros de um modelo. Elas podem ser usadas e
modificadas dentro do chamado <em>computation graph</em>. Inicializamos
todos as variáveis com um número aleatório com dstribuição normal.
</p>
<p>
Definimos agora a arquitetura de cada uma das camadas do modelo a partir
dos pesos e dos inputs.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">layer_1</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">tf</span><span class="o">$</span><span class="n">matmul</span><span class="p">(</span><span class="n">x</span><span class="p">,</span><span class="w"> </span><span class="n">w_h1</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">b_h1</span><span class="w">
</span><span class="n">layer_1</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">tf</span><span class="o">$</span><span class="n">nn</span><span class="o">$</span><span class="n">relu</span><span class="p">(</span><span class="n">layer_1</span><span class="p">)</span><span class="w"> </span><span class="n">layer_2</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">tf</span><span class="o">$</span><span class="n">matmul</span><span class="p">(</span><span class="n">layer_1</span><span class="p">,</span><span class="w"> </span><span class="n">w_h2</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">b_h2</span><span class="w">
</span><span class="n">layer_2</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">tf</span><span class="o">$</span><span class="n">nn</span><span class="o">$</span><span class="n">relu</span><span class="p">(</span><span class="n">layer_2</span><span class="p">)</span><span class="w"> </span><span class="n">out_layer</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">tf</span><span class="o">$</span><span class="n">matmul</span><span class="p">(</span><span class="n">layer_2</span><span class="p">,</span><span class="w"> </span><span class="n">w_out</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">b_out</span></code></pre>
</figure>
<p>
Aqui utilizamos a função de ativação
<a href="https://en.wikipedia.org/wiki/Rectifier_(neural_networks)"><code class="highlighter-rouge">rectifier</code></a>.
Por isso definimos cada camada usando o
<code class="highlighter-rouge">tf*n**n*relu()</code>. O
<code class="highlighter-rouge">tf$matmul()&lt;/code&gt; apenas multiplica as duas matrizes dentro do TensorFlow. Na &\#xFA;ltima camada usamos &lt;em&gt;linear activation&lt;/em&gt; que &\#xE9; o padr&\#xE3;o do &lt;code class="highlighter-rouge"&gt;tensorflow&lt;/code&gt;.&lt;/p&gt; &lt;p&gt;Agora vamos definir a fun&\#xE7;&\#xE3;o de custo e o algoritmos usado para a minimiza&\#xE7;&\#xE3;o.&lt;/p&gt; &lt;figure class="highlight"&gt;&lt;pre&gt;&lt;code class="language-r"&gt;&lt;span class="n"&gt;cost&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="o"&gt;&lt;-&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="n"&gt;tf&lt;/span&gt;&lt;span class="o"&gt;$</span><span
class="n">reduce\_mean</span><span class="p">(</span><span
class="n">tf</span><span
class="o">$&lt;/span&gt;&lt;span class="n"&gt;nn&lt;/span&gt;&lt;span class="o"&gt;$</span><span
class="n">softmax\_cross\_entropy\_with\_logits</span><span
class="p">(</span><span class="n">out\_layer</span><span
class="p">,</span><span class="w"> </span><span class="n">y</span><span
class="p">))</span><span class="w"> </span><span
class="n">optimizer</span><span class="w"> </span><span
class="o">&lt;-</span><span class="w"> </span><span
class="n">tf</span><span
class="o">$&lt;/span&gt;&lt;span class="n"&gt;train&lt;/span&gt;&lt;span class="o"&gt;$</span><span
class="n">AdamOptimizer</span><span class="p">(</span><span
class="n">learning\_rate</span><span class="w"> </span><span
class="o">=</span><span class="w"> </span><span
class="m">0.001</span><span class="p">)</span><span class="w">
</span><span class="n">train\_step</span><span class="w"> </span><span
class="o">&lt;-</span><span class="w"> </span><span
class="n">optimizer</span><span
class="o">$&lt;/span&gt;&lt;span class="n"&gt;minimize&lt;/span&gt;&lt;span class="p"&gt;(&lt;/span&gt;&lt;span class="n"&gt;cost&lt;/span&gt;&lt;span class="p"&gt;)&lt;/span&gt;&lt;/code&gt;&lt;/pre&gt;&lt;/figure&gt; &lt;p&gt;Definimos o custo como m&\#xE9;dia da &lt;em&gt;softmax cross entropy&lt;/em&gt; entre os logitos e os labels. De novo, n&\#xE3;o vou explicar exatamente o que &\#xE9; isso, mas acho que &lt;a href="http://stackoverflow.com/a/34243720/3297472"&gt;essa &\#xE9; uma boa refer&\#xEA;ncia&lt;/a&gt;. Usamos tamb&\#xE9;m o &lt;a href="https://arxiv.org/pdf/1412.6980v8.pdf"&gt;Adam Optimizer&lt;/a&gt;, uma explica&\#xE7;&\#xE3;o mais simples do porque est&\#xE1; &lt;a href="http://stats.stackexchange.com/a/184497/44359"&gt;aqui&lt;/a&gt;. A &\#xFA;ltima linha &\#xE9; a que conecta o &lt;em&gt;optimizer&lt;/em&gt; com a fun&\#xE7;&\#xE3;o de custo. A cada passo do treino, estamos dizendo para otimizador minimizar o custo.&lt;/p&gt; &lt;p&gt;At&\#xE9; agora, definimos qual seria o &lt;em&gt;computation graph&lt;/em&gt; para este modelo. Chegou a hora de iniciar o treino do modelo.&lt;/p&gt; &lt;figure class="highlight"&gt;&lt;pre&gt;&lt;code class="language-r"&gt;&lt;span class="n"&gt;training\_epochs&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="o"&gt;&lt;-&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="m"&gt;30&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="c1"&gt;\# n&\#xFA;mero de vezes que passamos pelo banco inteiro &lt;/span&gt;&lt;span class="n"&gt;batch\_size&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="o"&gt;&lt;-&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="m"&gt;100&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="c1"&gt;\# n&\#xFA;mero de observa&\#xE7;&\#xF5;es por batch &lt;/span&gt;&lt;span class="n"&gt;display\_step&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="o"&gt;&lt;-&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="m"&gt;5&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="err"&gt;\#&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="n"&gt;a&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="n"&gt;cada&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="n"&gt;quantos&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="n"&gt;passos&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="n"&gt;voc&lt;/span&gt;&lt;span class="err"&gt;&\#xEA;&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="n"&gt;quer&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="n"&gt;mostrar&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="n"&gt;os&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="n"&gt;resultados&lt;/span&gt;&lt;span class="o"&gt;?&lt;/span&gt;&lt;/code&gt;&lt;/pre&gt;&lt;/figure&gt; &lt;p&gt;Dado estes par&\#xE2;metros, a seguir fazemos o loop de treino. &\#xC9; comum fazer treinos em &lt;em&gt;batches&lt;/em&gt; em &lt;em&gt;deep learning&lt;/em&gt;. Voc&\#xEA; poderia usar todos os seus dados em cada itera&\#xE7;&\#xE3;o do algoritmo, mas isso ficaria bem mais caro computacionalmente, por isso usa-se uma pequena parte dos dados aleatoriamente em cada itere&\#xE7;&\#xE3;o.&lt;/p&gt; &lt;figure class="highlight"&gt;&lt;pre&gt;&lt;code class="language-r"&gt;&lt;span class="n"&gt;sess&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="o"&gt;&lt;-&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="n"&gt;tf&lt;/span&gt;&lt;span class="o"&gt;$</span><span
class="n">Session</span><span class="p">()</span><span class="w">
</span><span class="n">sess</span><span
class="o">$&lt;/span&gt;&lt;span class="n"&gt;run&lt;/span&gt;&lt;span class="p"&gt;(&lt;/span&gt;&lt;span class="n"&gt;tf&lt;/span&gt;&lt;span class="o"&gt;$</span><span
class="n">initialize\_all\_variables</span><span
class="p">())</span><span class="w"> </span><span
class="k">for</span><span class="w"> </span><span
class="p">(</span><span class="n">i</span><span class="w"> </span><span
class="k">in</span><span class="w"> </span><span class="m">1</span><span
class="o">:</span><span class="n">training\_epochs</span><span
class="p">){</span><span class="w"> </span><span
class="n">avg\_cost</span><span class="w"> </span><span
class="o">&lt;-</span><span class="w"> </span><span
class="m">0</span><span class="w"> </span><span
class="n">total\_batch</span><span class="w"> </span><span
class="o">&lt;-</span><span class="w"> </span><span
class="nf">floor</span><span class="p">(</span><span
class="n">nrow</span><span class="p">(</span><span
class="n">X\_train</span><span class="p">)</span><span
class="o">/</span><span class="n">batch\_size</span><span
class="p">)</span><span class="w"> </span><span
class="n">shuffle\_index</span><span class="w"> </span><span
class="o">&lt;-</span><span class="w"> </span><span
class="n">order</span><span class="p">(</span><span
class="n">runif</span><span class="p">(</span><span
class="n">n</span><span class="w"> </span><span class="o">=</span><span
class="w"> </span><span class="n">nrow</span><span
class="p">(</span><span class="n">X\_train</span><span
class="p">)))</span><span class="w"> </span><span
class="n">X\_train</span><span class="w"> </span><span
class="o">&lt;-</span><span class="w"> </span><span
class="n">X\_train</span><span class="p">\[</span><span
class="n">shuffle\_index</span><span class="p">,\]</span><span
class="w"> </span><span class="n">Y\_train</span><span class="w">
</span><span class="o">&lt;-</span><span class="w"> </span><span
class="n">Y\_train</span><span class="p">\[</span><span
class="n">shuffle\_index</span><span class="p">,\]</span><span
class="w"> </span><span class="k">for</span><span
class="p">(</span><span class="n">j</span><span class="w"> </span><span
class="k">in</span><span class="w"> </span><span class="m">1</span><span
class="o">:</span><span class="n">total\_batch</span><span
class="p">){</span><span class="w"> </span><span
class="n">batch\_x</span><span class="w"> </span><span
class="o">&lt;-</span><span class="w"> </span><span
class="n">X\_train</span><span class="p">\[((</span><span
class="n">j</span><span class="m">-1</span><span class="p">)</span><span
class="o">*</span><span class="n">batch\_size</span><span class="w">
</span><span class="o">+</span><span class="w"> </span><span
class="m">1</span><span class="p">)</span><span class="o">:</span><span
class="p">(</span><span class="n">j</span><span class="o">*</span><span
class="n">batch\_size</span><span class="p">),\]</span><span class="w">
</span><span class="n">batch\_y</span><span class="w"> </span><span
class="o">&lt;-</span><span class="w"> </span><span
class="n">Y\_train</span><span class="p">\[((</span><span
class="n">j</span><span class="m">-1</span><span class="p">)</span><span
class="o">*</span><span class="n">batch\_size</span><span class="w">
</span><span class="o">+</span><span class="w"> </span><span
class="m">1</span><span class="p">)</span><span class="o">:</span><span
class="p">(</span><span class="n">j</span><span class="o">*</span><span
class="n">batch\_size</span><span class="p">),\]</span><span class="w">
</span><span class="n">sess</span><span
class="o">$&lt;/span&gt;&lt;span class="n"&gt;run&lt;/span&gt;&lt;span class="p"&gt;(&lt;/span&gt;&lt;span class="n"&gt;train\_step&lt;/span&gt;&lt;span class="p"&gt;,&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="n"&gt;feed\_dict&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="o"&gt;=&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="n"&gt;dict&lt;/span&gt;&lt;span class="p"&gt;(&lt;/span&gt;&lt;span class="n"&gt;x&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="o"&gt;=&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="n"&gt;batch\_x&lt;/span&gt;&lt;span class="p"&gt;,&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="n"&gt;y&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="o"&gt;=&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="n"&gt;batch\_y&lt;/span&gt;&lt;span class="p"&gt;))&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="n"&gt;avg\_cost&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="o"&gt;&lt;-&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="n"&gt;avg\_cost&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="o"&gt;+&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="n"&gt;sess&lt;/span&gt;&lt;span class="o"&gt;$</span><span
class="n">run</span><span class="p">(</span><span
class="n">cost</span><span class="p">,</span><span class="w">
</span><span class="n">feed\_dict</span><span class="w"> </span><span
class="o">=</span><span class="w"> </span><span
class="n">dict</span><span class="p">(</span><span
class="n">x</span><span class="w"> </span><span class="o">=</span><span
class="w"> </span><span class="n">batch\_x</span><span
class="p">,</span><span class="w"> </span><span class="n">y</span><span
class="w"> </span><span class="o">=</span><span class="w"> </span><span
class="n">batch\_y</span><span class="p">))</span><span
class="o">/</span><span class="n">total\_batch</span><span class="w">
</span><span class="p">}</span><span class="w"> </span><span
class="k">if</span><span class="w"> </span><span class="p">(</span><span
class="n">i</span><span class="w"> </span><span class="o">%%</span><span
class="w"> </span><span class="n">display\_step</span><span class="w">
</span><span class="o">==</span><span class="w"> </span><span
class="m">0</span><span class="p">){</span><span class="w"> </span><span
class="n">print</span><span class="p">(</span><span
class="n">sprintf</span><span class="p">(</span><span class="s2">"Epoch
= %02d - Avg. Cost = %f"</span><span class="p">,</span><span class="w">
</span><span class="n">i</span><span class="p">,</span><span class="w">
</span><span class="n">avg\_cost</span><span class="p">))</span><span
class="w"> </span><span class="p">}</span><span class="w"> </span><span
class="p">}</span></code>
</pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## [1] &quot;Epoch = 05 - Avg. Cost = 4242.010991&quot;
## [1] &quot;Epoch = 10 - Avg. Cost = 882.411263&quot;
## [1] &quot;Epoch = 15 - Avg. Cost = 147.514608&quot;
## [1] &quot;Epoch = 20 - Avg. Cost = 35.560549&quot;
## [1] &quot;Epoch = 25 - Avg. Cost = 20.462326&quot;
## [1] &quot;Epoch = 30 - Avg. Cost = 19.004497&quot;</code></pre>
</figure>
<p>
Podemos calcular o acerto do modelo na base de teste com o código a
seguir.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">prediction</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">tf</span><span class="o">$</span><span class="n">argmax</span><span class="p">(</span><span class="n">out_layer</span><span class="p">,</span><span class="w"> </span><span class="m">1L</span><span class="p">)</span><span class="w"> </span><span class="c1"># indice da coluna com &gt; evidencia
</span><span class="n">prediction</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">sess</span><span class="o">$</span><span class="n">run</span><span class="p">(</span><span class="n">prediction</span><span class="p">,</span><span class="w"> </span><span class="n">feed_dict</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">dict</span><span class="p">(</span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">X_test</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">Y_test</span><span class="p">))</span><span class="w"> </span><span class="c1"># obter isso para a base de validacao
# pegar o true label da matriz (meio complicadinho,mas &#xE9; isso)
</span><span class="n">true_label</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">Y_test</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">as.data.frame</span><span class="p">()</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">mutate</span><span class="p">(</span><span class="n">id</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">row_number</span><span class="p">())</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">gather</span><span class="p">(</span><span class="n">key</span><span class="p">,</span><span class="w"> </span><span class="n">value</span><span class="p">,</span><span class="w"> </span><span class="o">-</span><span class="n">id</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">filter</span><span class="p">(</span><span class="n">value</span><span class="w"> </span><span class="o">!=</span><span class="w"> </span><span class="m">0</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">arrange</span><span class="p">(</span><span class="n">id</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">with</span><span class="p">(</span><span class="n">key</span><span class="p">)</span><span class="w">
</span><span class="c1"># Cruzando o predito com o verdadeiro:
</span><span class="nf">sum</span><span class="p">(</span><span class="n">diag</span><span class="p">(</span><span class="n">table</span><span class="p">(</span><span class="n">true_label</span><span class="p">,</span><span class="w"> </span><span class="n">prediction</span><span class="p">)))</span><span class="o">/</span><span class="n">nrow</span><span class="p">(</span><span class="n">X_test</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## [1] 0.9456</code></pre>
</figure>
</article>

