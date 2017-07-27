+++
title = "Regressão Logística em: a menor deep learning do mundo"
date = "2017-07-29 07:12:00"
categories = ["curso-r"]
original_url = "http://curso-r.com/blog/2017/07/29/2017-07-29-segundo-menor-dl/"
+++

<p>
Vamos montar nossa hipótese para <span
class="math inline">*E*\[*Y*<sub>1</sub>|*x*\]</span>.
</p>
<pre class="r"><code># modelo keras 1 -------------------------------------------------------
# input: 1 vari&#xE1;vel: o x.
input_keras_1 &lt;- layer_input(1, name = &quot;modelo_keras_1&quot;) # output: n&#xE3;o h&#xE1; camadas escondidas, apenas a fun&#xE7;&#xE3;o de liga&#xE7;&#xE3;o logit diretamente.
output_keras_1 &lt;- input_keras_1 %&gt;% layer_dense(units = 1, name = &quot;camada_unica&quot;) %&gt;% layer_activation(&quot;sigmoid&quot;, input_shape = 1, name = &quot;link_logistic&quot;) # sigmoid no tensorflow &#xE9; a logistic # keras_model &#xE9; o que constr&#xF3;i a nossa hip&#xF3;tese f(x) (da E[y] = f(x))
modelo_keras_1 &lt;- keras_model(input_keras_1, output_keras_1) # summary(modelo_keras_1)</code></pre>
<pre><code>Model
_____________________________________________________________
Layer (type) Output Shape Param # =============================================================
modelo_keras_1 (InputLayer) (None, 1) 0 _____________________________________________________________
camada_unica (Dense) (None, 1) 2 _____________________________________________________________
link_logistic (Activation) (None, 1) 0 =============================================================
Total params: 2
Trainable params: 2
Non-trainable params: 0
_____________________________________________________________</code></pre>
<p>
A hipótese construída tem 2 parâmetros. Parece que está certo! <span
class="math inline">*β*<sub>0</sub></span> e <span
class="math inline">*β*<sub>1</sub></span>.
</p>
<p>
<strong>Agora é a vez da função de perda.</strong>
</p>
<p>
Como nosso objetivo é construir uma regressão logística, nós vamos
escolher a função de perda
<a href="http://deeplearning.net/software/theano/library/tensor/nnet/nnet.html#theano.tensor.nnet.nnet.binary_crossentropy">binary\_crossentropy</a>
que é sinônimo de
<a href="https://en.wikipedia.org/wiki/Deviance_(statistics)">deviance</a>
da logística, termo mais comum no mundo da estatística.
</p>
<p>
A métrica <code>'accuracy'</code> não entra no otimizador da função de
perda, a gente usa ela para comparar os modelos que criamos. No caso
vamos comparar com o modelo <code>glm</code> ajustado acima (mas, por
exemplo, em caso de eventos raros a <code>'accuracy'</code> não vai ser
muito informativa, daí poderíamos usar <code>'auc'</code>,
<code>'gini'</code>, etc.).
</p>
<pre class="r"><code># coefficients
modelo_keras_1 %&gt;% get_layer(&quot;camada_unica&quot;) %&gt;% get_weights # [[1]]
# [,1]
# [1,] 2.000054
# # [[2]]
# [1] -1.015561 # accuracy
loss_and_metrics_1 &lt;- modelo_keras_1 %&gt;% evaluate(df$x, df$y_1, batch = 100000, verbose = 0)
loss_and_metrics_1[[2]] # [1] 0.85053</code></pre>
<p>
Resultados idênticos! Era para assim ser porque construímos a mesma
hipótese e a memsa função de perda do <code>glm</code>.
</p>

<p>
Hipótese para <span
class="math inline">*E*\[*Y*<sub>2</sub>|*x*\]</span>.
</p>
<pre class="r"><code># modelo keras 2 -------------------------------------------------------
input_keras_2 &lt;- layer_input(1, name = &quot;modelo_keras_2&quot;) output_keras_2 &lt;- input_keras_2 %&gt;% layer_dense(units = 1, name = &quot;camada_um&quot;) %&gt;% layer_activation(&quot;tanh&quot;, input_shape = 1, name = &quot;tanh_de_dentro&quot;) %&gt;% layer_dense(units = 1, input_shape = 1, name = &quot;camada_dois&quot;) %&gt;% layer_activation(&quot;sigmoid&quot;, input_shape = 1, name = &quot;link_logistic&quot;) modelo_keras_2 &lt;- keras_model(input_keras_2, output_keras_2) summary(modelo_keras_2)</code></pre>
<pre><code>Model
_____________________________________________________________
Layer (type) Output Shape Param # =============================================================
modelo_keras_2 (InputLayer) (None, 1) 0 _____________________________________________________________
camada_um (Dense) (None, 1) 2 _____________________________________________________________
tanh_de_dentro (Activation) (None, 1) 0 _____________________________________________________________
camada_dois (Dense) (None, 1) 2 _____________________________________________________________
link_logistic (Activation) (None, 1) 0 =============================================================
Total params: 4.0
Trainable params: 4.0
Non-trainable params: 0.0
_____________________________________________________________
</code></pre>
<p>
Quatro parâmetros ‘treináveis’, é isso aí! Dois parâmetros de dentro do
<code>tanh</code> e os dois parâmetros de fora. Precisamos que o keras
nos devolva -1, 2, -1 e 2 do jeito que geramos os dados.
</p>
<p>
<strong>Função de custo</strong>
</p>
<pre class="r"><code>modelo_keras_2 %&gt;% compile( loss = &apos;binary_crossentropy&apos;, optimizer = optimizer_sgd(lr = 0.1), metrics = c(&apos;accuracy&apos;)
) modelo_keras_2_fit &lt;- modelo_keras_2 %&gt;% fit( x = df$x, y = df$y_2, epochs = 20, batch_size = 100, verbose = 0
) # coefficients
modelo_keras_2 %&gt;% get_layer(&quot;camada_um&quot;) %&gt;% get_weights # [[1]]
# [,1]
# [1,] 2.012015
# # [[2]]
# [1] -1.058052 modelo_keras_2 %&gt;% get_layer(&quot;camada_dois&quot;) %&gt;% get_weights # [[1]]
# [,1]
# [1,] 1.981977
# # [[2]]
# [1] -1.006567 # accuracy
loss_and_metrics_2 &lt;- modelo_keras_2 %&gt;% evaluate(df$x, df$y_2, batch_size = 100000)
loss_and_metrics_2[[2]] # [1] 0.82221</code></pre>
<p>
Precisão de <strong>82%</strong> também, mas agora os parâmetros estão
bem próximos daqueles que geraram os dados! Acabamos de ver um conjunto
de parâmetros sendo encontrados mesmo com relação não linear entre eles
e a média.
</p>
<p>
A precisão entre os dois modelos até que se equiparou, mas o gráfico das
hipóteses encontradas (abaixo) mostra que a curva do <code>glm</code>
está pior do que a curva do <code>keras</code>.
</p>
<pre class="r"><code>df %&gt;% select(x, y_2) %&gt;% mutate(x_cat = cut_number(x, n = 50)) %&gt;% group_by(x_cat) %&gt;% summarise(p = mean(y_2), x = mean(x), keras = logistic(-1.006567 + 1.981977 * tanh(-1.058052 + 2.012015 * x)), glm = logistic(-1.6698641 + 0.3043212*x + 2.0936353 * tanh(x)), n = n()) %&gt;% mutate(logit_p = logit(p)) %&gt;% gather(Modelo, estimativa, keras, glm) %&gt;% ggplot() + geom_point(aes(x = x_cat, y = p)) + geom_line(aes(x = x_cat, y = estimativa, colour = Modelo, group = Modelo)) + theme_minimal() + theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5)) + labs(x = &quot;x&quot;, colour = &quot;resposta&quot;)</code></pre>
<p>
<img src="http://curso-r.com/blog/2017-07-29-segundo-menor-dl_files/figure-html/unnamed-chunk-14-1.png" width="672">
</p>

