+++
title = "Construindo Autoencoders"
date = "2017-06-26 07:12:00"
categories = ["curso-r"]
original_url = "http://curso-r.com/blog/2017/06/26/2017-06-26-construindo-autoencoders/"
+++

<p>
<a href="https://en.wikipedia.org/wiki/Autoencoder">Autoencoders</a> são
redes neurais treinadas com o objetivo de copiar o seu <em>input</em>
para o seu <em>output</em>. Esse interesse pode parecer meio estranho,
mas na prática o objetivo é <em>aprender</em> representações
(<em>encodings</em>) dos dados, que poodem ser usadas para redução de
dimensionalidade ou até mesmo
<a href="https://research.googleblog.com/2016/09/image-compression-with-neural-networks.html">compressão
de arquivos</a>.
</p>
<p>
Basicamente, um <em>autoencoder</em> é dividido em duas partes:
</p>
<p>
Nesse pequeno tutorial, vou usar o <code>keras</code> para definir e
treinar os nossos autoencoders. Como base de dados vou usar algumas
simulações e o banco de dados <code>mnist</code> (famoso para todos que
já mexeram um pouco com deep learning). O mnist é um banco de dados de
imagens de tamanho 28x28 de dígitos escritos à mão. Esse dataset
promoveu grandes avanços na área de reconhecimento de imagens.
</p>
<pre class="r"><code>library(keras) encoding_dim &lt;- 32 # definindo o input
input &lt;- layer_input(shape = 784)
# definindo o encoder
encoded &lt;- layer_dense(input, encoding_dim, activation = &quot;relu&quot;)
# definindo o decoder
decoded &lt;- layer_dense(encoded, 784, activation = &quot;sigmoid&quot;) autoencoder &lt;- keras_model(input, decoded)
encoder &lt;- keras_model(input, encoded) # definindo o decoder
encoded_input &lt;- layer_input(shape = encoding_dim)
decoder_layer &lt;- autoencoder$get_layer(index = -1L) # &#xFA;ltima camada do autoencoder
decoder &lt;- keras_model(encoded_input, decoder_layer(encoded_input))</code></pre>
<p>
Com esse código definimos um modelo da seguinte forma:
</p>
<p>
<span class="math display">
*X* = (*X* \* *W*<sub>1</sub> + *b*<sub>1</sub>)\**W*<sub>2</sub> + *b*<sub>2</sub>
</span>
</p>
<p>
Em que:
</p>
<ul>
<li>
<span class="math inline">*X*</span> é o nosso input com dimensão (?,
784)
</li>
<li>
<span class="math inline">*W*<sub>1</sub></span> é uma matriz de pesos
com dimensões (784, 32)
</li>
<li>
<span class="math inline">*b*<sub>1</sub></span> é uma matriz de forma
(?, 32)
</li>
<li>
<span class="math inline">*W*<sub>2</sub></span> é uma matriz de pesos
com dimensões (32, 784)
</li>
<li>
<span class="math inline">*b*<sub>2</sub></span> é uma matriz de forma
(?, 784)
</li>
</ul>
<p>
Note que <code>?</code> aqui é o número de observaçãoes da base de
dados. Agora vamos estimar <span
class="math inline">*W*<sub>1</sub></span>, <span
class="math inline">*W*<sub>2</sub></span>, <span
class="math inline">*b*<sub>1</sub></span> e <span
class="math inline">*b*<sub>2</sub></span> de modo a minimizar algua
função de perda.
</p>
<p>
Inicialmente vamos usar a <em>binary crossentropy</em> por pixel que é
definida por:
</p>
<p>
<span class="math display">
$$-\\sum\_{i=1}y\_i\*log(\\hat{y}\_i)$$
</span>
</p>
<p>
Isso é definido no <code>keras</code> usando:
</p>
<pre class="r"><code>autoencoder %&gt;% compile(optimizer=&apos;adadelta&apos;, loss=&apos;binary_crossentropy&apos;)</code></pre>
<p>
Não vou entrar em detalhes do que é o <code>adadelta</code>, mas é uma
variação do método de otimização conhecido como <em>gradient
descent</em>.
</p>
<p>
Agora vamos carregar a base de dados e em seguida treinar o nosso
àutoencoder\`.
</p>
<pre class="r"><code>mnist &lt;- dataset_mnist()
# o mnist &#xE9; um banco de imagens 28x28, vamos transformar cada imagem em um vetor
# de tamanho 784, cada elemento representado um pixel.
x_train &lt;- mnist$train$x %&gt;% apply(1, as.numeric) %&gt;% t()
x_test &lt;- mnist$test$x %&gt;% apply(1, as.numeric) %&gt;% t()
# vamos transformar as imagens p/ o intervalo 0-1 para que
# a fun&#xE7;&#xE3;o de perda funcione corretamente.
x_train &lt;- x_train/255
x_test &lt;- x_test/255</code></pre>
<p>
Estimamos os parâmetros desse modelo no <code>keras</code> fazendo:
</p>
<pre class="r"><code>autoencoder %&gt;% fit( x_train, x_train, epochs = 50, batch_size = 256, shuffle = TRUE, validation_data = list(x_test, x_test)
)</code></pre>
<p>
Depois de rodar todas as iterações, você poderá usar o seu
<code>encoder</code> e o seu <code>decoder</code> para entender o que
eles fazem com as imagens.
</p>
<p>
Veja o exemplo a seguir em que vamos obter os <code>encodings</code>
para as 10 primeiras imagens da base de teste e depois
<em>reconstruir</em> a imagem usando o decoder.
</p>
<pre class="r"><code>encoded_imgs &lt;- predict(encoder, x_test[1:10,])
dim(encoded_imgs)
encoded_imgs[1,] # representa&#xE7;&#xE3;o vetorial de uma imagem.</code></pre>
<pre><code>## [1] 10 32
## [1] 0.0000000 10.1513205 3.5742311 2.6635208 6.3097358 3.4840517
## [7] 9.1041250 6.6329145 1.6385922 9.8017225 9.5529270 1.6670935
## [13] 5.7208562 4.8035479 3.9149191 0.6408147 1.2716029 3.1215091
## [19] 13.7575903 0.0000000 1.8692881 3.2142215 0.7444992 5.0728440
## [25] 8.2932110 9.9866810 2.7651572 11.1291723 5.2460670 5.6875997
## [31] 10.6097431 3.6338394</code></pre>
<p>
O <em>encoder</em> transforma a matriz de (10, 784) para uma matriz com
dimensao (10, 2). Podemos reconstruir a imagem, a pardir da imagem que
foi <em>comprimida</em> usando o nosso <code>decoder</code>.
</p>
<pre class="r"><code>predict(decoder, encoded_imgs) %&gt;% split(1:10) %&gt;% lapply(matrix, ncol = 28) %&gt;% Reduce(cbind, .) %&gt;% as.raster() %&gt;% plot()</code></pre>
<p>
<img src="http://curso-r.com/blog/2017-06-26-construindo-autoencoders_files/figure-html/unnamed-chunk-8-1.png" width="672">
</p>
<p>
Compare as reconstruções com as imagens originais abaixo:
</p>
<pre class="r"><code>x_test[1:10,] %&gt;% split(1:10) %&gt;% lapply(matrix, ncol = 28) %&gt;% Reduce(cbind, .) %&gt;% as.raster() %&gt;% plot()</code></pre>
<p>
<img src="http://curso-r.com/blog/2017-06-26-construindo-autoencoders_files/figure-html/unnamed-chunk-10-1.png" width="672">
</p>
<p>
Um ponto interessante é que esse modelo faz uma
<a href="https://stats.stackexchange.com/a/120096/44359">aproximação da
solução por componentes principais</a>! Na verdade, a definição do
quanto são parecidos é <em>quase-equivalente</em>. Isso quer dizer que
os pesos <span class="math inline">*W*</span> encontrados pelo PCA e
pelo autoencoder serão diferentes, mas o sub-espaço criado pelos mesmos
será equivalente.
</p>
<p>
Se são equivalentes, qual a vantagem de usar autoencoders ao invés de
PCA? O PCA para por aqui, você define que serão apenas relações
lineares, e você reduz dimensão apenas reduzindo o tamanho da matriz. Em
autoencoders você tem diversas outras saídas para aprimorar o método.
</p>
<p>
A primeira delas é simplesmente adicionar uma condição de esparsidade
nos pesos. Isso vai reduzir o tamanho do vetor latente (como é chamada a
camada do meio do autoencoder) também, pois ele terá mais zeros.
</p>
<p>
Isso pode ser feito rapidamente com o <code>keras</code>. Basta
adicionar um <code>activity\_regularizer</code> em nossa camada de
encoding. Isso vai adicionar na função de perda um termo que toma conta
do valor dos outputs da camada intermediária.
</p>
<pre class="r"><code># definindo o input
input &lt;- layer_input(shape = 784)
# definindo o encoder
encoded &lt;- layer_dense(input, encoding_dim, activation = &quot;relu&quot;, activity_regularizer = regularizer_l1(l = 10e-5))
# definindo o decoder
decoded &lt;- layer_dense(encoded, 784, activation = &quot;sigmoid&quot;) autoencoder &lt;- keras_model(input, decoded)
autoencoder %&gt;% compile(optimizer=&apos;adadelta&apos;, loss=&apos;binary_crossentropy&apos;)
autoencoder %&gt;% fit( x_train, x_train, epochs = 50, batch_size = 256, shuffle = TRUE, validation_data = list(x_test, x_test)
)</code></pre>
<p>
Outra forma de melhorar o seu autoencoder é permitir que o encoder e o
decoder sejam redes neurais profundas. Com isso, ao invés de tentar
encontrar transformações lineares, você permitirá que o autoencoder
encontre transformações não lineares.
</p>
<p>
Mais uma vez fazemos isso com o keras:
</p>
<pre class="r"><code>input &lt;- layer_input(shape = 784) encoded &lt;- layer_dense(input, 128, activation = &quot;relu&quot;) %&gt;% layer_dense(64, activation = &quot;relu&quot;) %&gt;% layer_dense(32, activation = &quot;relu&quot;) decoded &lt;- layer_dense(encoded, 64, activation = &quot;relu&quot;) %&gt;% layer_dense(128, activation = &quot;relu&quot;) %&gt;% layer_dense(784, activation = &quot;sigmoid&quot;) autoencoder &lt;- keras_model(input, decoded)
autoencoder %&gt;% compile(optimizer=&apos;adadelta&apos;, loss=&apos;binary_crossentropy&apos;)
autoencoder %&gt;% fit( x_train, x_train, epochs = 50, batch_size = 256, shuffle = TRUE, validation_data = list(x_test, x_test)
)</code></pre>
<p>
Existem formas ainda mais inteligentes de construir esses autoencoders,
mas o post iria ficar muito longo e não ia sobrar asssunto para o
próximo. Se você quiser saber mais, recomendo fortemente a leitura deste
artigo do
<a href="https://blog.keras.io/building-autoencoders-in-keras.html">blog
do Keras</a> e desse
<a href="http://www.deeplearningbook.org/contents/autoencoders.html">capítulo</a>.
</p>
<p>
Uma família bem moderna de autoencoders são os VAE (Variational
Autoencoders). Esses autoencoders aprendem
<a href="https://en.wikipedia.org/wiki/Latent_variable_model">modelos de
variáveis latentes</a>. Isso é interessante porque permite que você gere
novos dados, parecidos com os que você usou para treinar o seu
autoencoder. Você pode encontrar uma implementação desse modelo
<a href="https://rstudio.github.io/keras/articles/examples/variational_autoencoder.html">aqui</a>.
</p>
<p>
É isso! Abraços
</p>

