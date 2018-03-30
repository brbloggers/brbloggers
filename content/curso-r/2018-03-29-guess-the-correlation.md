+++
title = "Chamada pra briga - Competição Kaggle Guess The Correlation"
date = "2018-03-29"
categories = ["curso-r"]
original_url = "http://curso-r.com/blog/2018/03/29/2018-03-29-guess-the-correlation/"
+++

<p class="text-muted text-uppercase mb-small text-right">
Por <a href="http://curso-r.com/author/athos">Athos</a> 29/03/2018
</p>
<p>
Alô alôww Comunidade
</p>
<p>
Lançamos <a href="https://www.kaggle.com/c/guess-the-correlation/">uma
competição Kaggle</a> e agora é a hora de você mostrar que é Jedi em
DATA SCIENCE! =D
</p>
<p>
Link:
<a href="https://www.kaggle.com/c/guess-the-correlation/" class="uri">https://www.kaggle.com/c/guess-the-correlation/</a>
</p>
<p>
A gente fez isso por esporte, favor não tentar achar utilidade nessa
aplicação =P.
</p>
<p>
O site <a href="http://guessthecorrelation.com/">Guess The
Correlation</a> coloca o ser humano frente a frente com um gráfico de
dispersão, em que este é em seguida desafiado a adivinhar respectiva a
correlação linear.
</p>
<p>
No nosso desafio Kaggle, desafio similar foi construído. Foram geradas
200 mil imagens em png como as abaixo:
</p>
<center>
<img src="http://curso-r.com/img/blog/2018-03-29-guess-the-correlation/exemplo_img.png">
</center>
<p>
e cada uma dessas imagens tem a sua correleção anotada para treinarmos
um modelinho.
</p>

<p>
O objetivo é simples e direto: construir um robô que calcula a
correlação (linear) apenas vendo o gráfico de dispersão.
</p>
<p>
Em <em>machine lârnês</em>, queremos
</p>
<center>
<img src="http://curso-r.com/img/blog/2018-03-29-guess-the-correlation/f_img_92.png">
</center>
<p>
em que essa <strong>f</strong> seja digna de ser <strong>f</strong> de
<strong><F@!#></strong>.
</p>

<p>
O <a href="https://github.com/jtrecenti">Julião</a> já andou trabalhando
nesse problema e deu um chute inicial nos códigos pra vocês se
inspirarem. Aliás, “inicial” numas, porque ele já saiu fazendo um CNN
com a ajuda do pacote
<a href="https://github.com/decryptr/decryptr">decryptr</a>:
</p>
<pre class="r"><code>library(keras)
library(tidyverse)
library(decryptr) path &lt;- &quot;./&quot; arqs &lt;- dir(paste0(path, &quot;/train_imgs&quot;), full.names = TRUE)
resp &lt;- readr::read_csv(paste0(path, &quot;/train_responses.csv&quot;)) set.seed(4747)
i_train &lt;- sample(1:nrow(resp), 10000)
d_train &lt;- resp[i_train,] %&gt;% arrange(id)
d_test &lt;- resp[-i_train,] %&gt;% arrange(id) nm_files &lt;- arqs %&gt;% basename() %&gt;% tools::file_path_sans_ext() nm_files_train &lt;- nm_files[tolower(nm_files) %in% d_train$id]
nm_files_test &lt;- nm_files[tolower(nm_files) %in% d_test$id] nm_files_train_complete &lt;- stringr::str_glue(&quot;{path}/train_imgs/{nm_files_train}.png&quot;)
imgs &lt;- decryptr::read_captcha(nm_files_train_complete) # Check whether frac_test is less than or equal to 100% # Convert list of captchas to expected format
captchas_t &lt;- purrr::transpose(imgs)
xs &lt;- captchas_t$x
xs &lt;- abind::abind(xs, along = 0.1)
data &lt;- list(n = length(imgs), y = d_train$corr, x = xs)
n_units &lt;- 1000
# Get absolute numbers
n_tot &lt;- data$n # Create model
model &lt;- keras_model_sequential()
model %&gt;% layer_conv_2d( input_shape = dim(data$x)[-1], filters = 16, kernel_size = c(5, 5), padding = &quot;same&quot;, activation = &quot;relu&quot;) %&gt;% layer_max_pooling_2d() %&gt;% layer_conv_2d( filters = 32, kernel_size = c(5, 5), padding = &quot;same&quot;, activation = &quot;relu&quot;) %&gt;% layer_max_pooling_2d() %&gt;% layer_conv_2d( filters = 64, kernel_size = c(5, 5), padding = &quot;same&quot;, activation = &quot;relu&quot;) %&gt;% layer_max_pooling_2d() %&gt;% layer_flatten() %&gt;% layer_dense(units = 100) %&gt;% layer_dropout(.1) %&gt;% layer_dense(units = 1, activation = &quot;tanh&quot;) # Compile and fit model
model %&gt;% compile( optimizer = &quot;sgd&quot;, loss = &quot;mean_squared_error&quot;, metrics = &quot;accuracy&quot;) model %&gt;% fit( x = data$x, y = data$y, batch_size = 100, epochs = 10, shuffle = TRUE, validation_data = list(data$x, data$y) )</code></pre>
<p>
E aí? Será que dá pra acertar 100%? Ou será impossível?
</p>
<p>
Boa R’ada!
</p>

