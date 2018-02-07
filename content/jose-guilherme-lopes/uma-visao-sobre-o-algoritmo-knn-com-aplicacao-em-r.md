+++
title = "Uma visão sobre o algoritmo kNN, com aplicação em R"
date = "2018-02-07 14:37:19"
categories = ["jose-guilherme-lopes"]
original_url = "http://joseguilhermelopes.com.br/uma-visao-sobre-o-algoritmo-knn-com-aplicacao-em-r/"
+++

<div class="entry-content">
<p>
O kNN é um dos algoritmos mais simples de
<a href="http://joseguilhermelopes.com.br/introducao-ao-machine-learning-e-seus-principais-algoritmos/">Machine
Learning</a> e é uma abreviação
para <em>k-nearest neighbors </em>(k-vizinhos mais próximos). Este
algoritmo implementa o aprendizado baseado em instâncias
(<em>instance-based learning</em>). Isso significa que a classificação
de um exemplar cuja classe é desconhecida é realizada a partir da
comparação desse exemplar com aqueles que possuem uma classe já
conhecida.
</p>
<p>
Em outras palavras, se temos um dataset com as variáveis A, B e C e
outro dataset apenas com as variáveis A e B, o algoritmo kNN pode fazer
uma predição sobre as classes/valores da variável C para o segundo
dataset.
</p>
<p>
O kNN pode ser utilizado para predição de classes ou valores
(regressão).
</p>
<p>
Na classificação, o resultado é uma associação de classe. Um objeto é
classificado pela classe mais comum entre seus vizinhos mais
próximos.<br> Na regressão, a saída é um valor numérico. Este valor será
uma medida de posição dos valores dos seus vizinhos mais próximos, por
exemplo a média ou mediana.
</p>
<h3>
<strong>Como o kNN funciona</strong>
</h3>
<p>
Um exemplar é classificado de acordo com a maioria dos k exemplares mais
próximos.
</p>
<p>
Em geral, a métrica de distância utilizada no kNN é a
<a href="https://pt.wikipedia.org/wiki/Dist%C3%A2ncia_euclidiana">distância
euclidiana</a>, mas também pode-se utilizar outras métricas como a
<a href="https://en.wikipedia.org/wiki/Taxicab_geometry">Manhattan</a> e
a <a href="https://en.wikipedia.org/wiki/Hamming_distance">Hamming</a>.
</p>
<p>
<img class="size-full wp-image-582 aligncenter" src="http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/download.png" alt="" width="277">
</p>
<p>
Utilizando a imagem abaixo como exemplo, o ponto verde é desconhecido e
queremos saber se ele pertence à classe <em>quadrado azul</em>
ou <em>triângulo vermelho</em>.
</p>
<p>
Se utilizamos o algoritmo kNN com um k = 3 (círculo em linha), temos que
a maioria dos exemplares dentro desta área são vermelhos (2 vermelhos
contra 1 azul) e assim classificaríamos o ponto desconhecido como
triângulo vermelho.
</p>
<p>
Entretanto, se utilizamos um k = 5 (círculo tracejado), a maioria dos
exemplares dentro desta área são azuis (3 azuis contra 2 vermelhos) e
assim classificaríamos o ponto desconhecido como quadrado azul.
</p>
<p>
<img class="size-medium wp-image-576 aligncenter" src="http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/KnnClassification.svg_-300x271.png%20300w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/KnnClassification.svg_.png%20419w" alt="" width="300" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/KnnClassification.svg_-300x271.png 300w, http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/KnnClassification.svg_.png 419w">
</p>
<p>
Escolher o número de vizinhos mais próximos, ou seja, determinar o valor
do parâmetro k, é o que determina a eficácia do modelo. Assim, o valor
selecionado para k determinará a forma como os dados serão utilizados
para generalizar os resultados do algoritmo.
</p>
<p>
De modo a evitar “empates”, o parâmetro k é, em geral, um valor ímpar.
</p>
<p>
Um grande valor de k pode reduzir a variância devido aos dados ruidosos.
Porém, um k grande pode gerar um viés em sua classificação, pois padrões
menores que podem vir a conter insights úteis, serão ignorados.
</p>
<p>
A animação a seguir, feita pela
<a href="http://datacamp.com/">DataCamp</a>, mostra os efeitos da
escolha do k:
</p>
<div class="wp-video">
<video class="wp-video-shortcode" id="video-571-1" width="708" height="398">
<source src="http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/knn.mp4?_=1">
<a href="http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/knn.mp4">http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/knn.mp4</a></video>
</div>
<p>
Mais à frente apresentarei um método para validação da performance do
modelo.
</p>
<h3>
<strong>Normalização</strong>
</h3>
<p>
Muitas vezes temos que normalizar os nossos dados para que eles
apresentem maior consistência e assim facilitem a
implementação/aprendizado do kNN.
</p>
<p>
Se os valores de uma variável apresentarem uma amplitude (valor máximo –
valor mínimo) muito alta, é boa prática normalizar os dados. Ou ainda,
se as métricas das variáveis diferirem muito entre si. Por exemplo, se X
varia de 0 a 100 e Y varia de 0 a 1.000, a influência de Y na função de
distância será muito alta.
</p>
<p>
Quando você normalizar, você ajusta o intervalo de todos os recursos, de
modo que as distâncias entre variáveis ​​com intervalos maiores não
serão enfatizadas demais.
</p>
<p>
Existem diferentes
<a href="https://en.wikipedia.org/wiki/Normalization_(statistics)">formas
para normalização</a>, cada uma se adequa melhor à cada caso.
</p>
<p>
Um bom formato de normalização, é aplicar para cada valor x a função:
</p>
<p>
<em> (x – min(x)) / (max(x) – min(x))</em>
</p>
<p>
Assim, os valores das observações se convertem para um intervalo entre 0
e 1 e a sua variável estará normalizada.
</p>
<h3>
<strong>Dados para treinamento x Dados para teste</strong>
</h3>
<p>
Para avaliar o desempenho do seu modelo, você precisará dividir o
conjunto de dados em duas partes: um conjunto de treinamento e um
conjunto de testes.
</p>
<p>
O conjunto de treinamento é usado para construir o modelo e implementar
o algoritmo, enquanto o conjunto de teste é usado para avaliar a
eficácia do seu modelo. Utilize o conjunto de teste para tornar o seu
modelo o mais eficiente possível.
</p>
<p>
A divisão de seu conjunto de dados entre conjunto teste e conjunto
treinamento é disjunta: a escolha de divisão mais comum é tomar 2/3 do
seu conjunto para  treinamento e o 1/3 restante para teste.
</p>
<p>
Mas atenção! Não é recomendável simplesmente fatiar o seu conjunto de
dados em 2/3 para realizar a divisão treinamento/teste. Se as linhas do
seu conjunto de dados estiverem organizadas por determinadas categorias
de uma variável, por exemplo, se você fatiar o conjunto de dados, você
irá perder muita informação útil e o poder preditivo do algoritmo será
ineficiente.
</p>
<p>
Para evitar esse erro, faça a divisão do seu conjunto de dados a partir
de uma amostra aleatória. Mais à frente mostro como fazer essa divisão
aleatória utilizando o R.
</p>
<h3>
<strong>Avaliando a performance do modelo</strong>
</h3>
<p>
Um passo essencial em Machine Learning é a avaliação do desempenho do
seu modelo. Em outras palavras, você deseja analisar o grau de correção
das previsões do modelo.
</p>
<p>
Se o seu conjunto de dados não for muito grande, você pode fazer essa
avaliação comparando se cada resultado da predição feita pelo algoritmo
está de acordo com o valor real, disponível no conjunto teste.
</p>
<p>
Para uma avaliação mais analítica, você pode utilizar tabelas de
contingência (ou tabelas cruzadas). Estas tabelas são muito utilizadas
para entender a relação entre 2 variáveis, que no caso serão as
variáveis do resultado do algoritmo e do conjunto teste.
</p>
<h3>
<strong>Implementação do algoritmo em R</strong>
</h3>
<p>
Para exemplificar a implementação do kNN, utilizarei um dataset clássico
do RStudio e que é muito utilizado para fins didáticos em análise de
dados e Machine Learning.
</p>
<p>
O dataset se chama <strong>iris</strong>, se trata de um estudo sobre
flores e é composto por 150 observações (linhas) e 5 variáveis
(colunas), que são:
</p>
<ul>
<li>
<em>Sepal.Length: </em>comprimento da sépala
</li>
<li>
<em> Sepal.Width: </em>largura da sépala
</li>
<li>
<em>Petal.Length: </em>comprimento da pétala
</li>
<li>
<em>Petal.Width: </em>largura da pétala
</li>
<li>
<em>Species:</em> espécie da flor (Versicolor, Setosa ou Virginica)
</li>
</ul>
<p>
Existem 50 observações para cada uma das três espécies.
</p>
<p>
<img class="aligncenter" src="https://s3.amazonaws.com/assets.datacamp.com/blog_assets/Machine+Learning+R/iris-machinelearning.png" width="695">
</p>
<p>
Nosso caso aqui será o de construir um modelo kNN que prevê a espécie
(<em>Species</em>) da flor, tomando como parâmetros apenas as variáveis
numéricas do conjunto.
</p>
<p>
O dataset já vem dentro do RStudio, você pode ver o conjunto de dados
executando-o pelo seu nome ou importando do
<a href="http://archive.ics.uci.edu/ml/datasets/Iris">repositório
UCI</a>.
</p>
<p>
<em><strong>\# Abrindo pelo RStudio:</strong></em>
</p>
<p>
<strong><em>iris  </em></strong>
</p>
<p>
<em><strong>\# Importando da UCI:</strong></em>
</p>
<p>
<strong><em>iris
&lt;- read.csv(url(“[http://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data”](http://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data”)),
header = FALSE)</em></strong>
</p>
<p>
<em><strong>names(iris) &lt;- c(“Sepal.Length”, “Sepal.Width”,
“Petal.Length”, “Petal.Width”, “Species”)</strong></em>
</p>
<p>
<img class="aligncenter wp-image-590 size-large" src="http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/1-1024x384.png%201024w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/1-300x113.png%20300w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/1-768x288.png%20768w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/1.png%201040w" alt="" width="708" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/1-1024x384.png 1024w, http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/1-300x113.png 300w, http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/1-768x288.png 768w, http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/1.png 1040w">
</p>
<p>
Apenas para ter uma visão do comportamento das variáveis, segue o código
para o gráfico de dispersão categorizado pelas espécies:
</p>
<p>
<em><strong>library(tidyverse)</strong></em>
</p>
<p>
<em><strong>iris %&gt;% </strong></em><br> <em><strong>    ggplot(aes(x
= Sepal.Length, y = Sepal.Width, colour = Species))+</strong></em><br>
<em><strong>    geom\_point()</strong></em>
</p>
<p>
<em><strong>iris %&gt;% </strong></em><br> <em><strong>   ggplot(aes(x =
Petal.Length, y = Petal.Width, colour = Species))+</strong></em><br>
<em><strong>   geom\_point()</strong></em>
</p>
<p>
<img class="aligncenter wp-image-591 size-full" src="http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/4.png%201632w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/4-300x90.png%20300w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/4-768x230.png%20768w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/4-1024x307.png%201024w" alt="" width="1632" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/4.png 1632w, http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/4-300x90.png 300w, http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/4-768x230.png 768w, http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/4-1024x307.png 1024w">
</p>
<p>
Em um caso real, seria importante realizar uma análise exploratório do
conjunto de dados a fim de observar melhor o comportamento das variáveis
e a relação entre elas. Uma análise de correlação seria muito
interessante aqui, mas vou manter o foco apenas para a implementação do
kNN.
</p>
<p>
Abaixo segue o código para a criação da função para normalização e a sua
aplicação em todas as linhas do conjunto de dados:
</p>
<p>
<em><strong>\# Construindo função normalizar:</strong></em><br>
<em><strong>normalizar &lt;- function(x) {</strong></em><br>
<em><strong>     num &lt;- x – min(x)</strong></em><br> <em><strong>   
 denom &lt;- max(x) – min(x)</strong></em><br> <em><strong>     return
(num/denom)</strong></em><br> <em><strong>}</strong></em>
</p>
<p>
<em><strong>\# aplicando a função normalizar para as variáveis
numéricas</strong></em><br> <em><strong>iris\_norm &lt;-
as.data.frame(lapply(iris\[1:4\], normalizar))</strong></em>
</p>
<p>
<em><strong>\# Obtendo um resumo do novo dataset</strong></em><br>
<em><strong>summary(iris\_norm)</strong></em>
</p>
<p>
<img class="aligncenter wp-image-592 " src="http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/5.png%20680w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/5-300x108.png%20300w" alt="" width="627" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/5.png 680w, http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/5-300x108.png 300w">
</p>
<p>
Para aplicar o kNN, neste caso específico, não utilizarei os dados
normalizados.
</p>
<p>
Abaixo segue o código para dividir o conjunto de dados em conjunto
treinamento e conjunto teste, via amostra aleatória, na proporção 2/3 e
1/3 respectivamente:
</p>
<p>
<em><strong>\# Construindo um indicador para amostra
aleatória:</strong></em><br> <em><strong>set.seed(1234)</strong></em>
</p>
<p>
<em><strong>ind &lt;- sample(2, nrow(iris), replace=TRUE, prob=c(0.67,
0.33))</strong></em>
</p>
<p>
<em><strong>\# Construindo o conjunto de treinamento:</strong></em><br>
<em><strong>iris.treinamento &lt;- iris\[ind==1, 1:4\]</strong></em>
</p>
<p>
<em><strong>\# Construindo o conjunto de treinamento:</strong></em><br>
<em><strong>iris.test &lt;- iris\[ind==2, 1:4\]</strong></em>
</p>
<p>
<em><strong>\# Inspecionando os conjuntos:</strong></em><br>
<em><strong>head(iris.treinamento)</strong></em><br>
<em><strong>head(iris.test)</strong></em>
</p>
<p>
<img class="aligncenter wp-image-593 " src="http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/6.png%20570w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/6-300x203.png%20300w" alt="" width="393" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/6.png 570w, http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/6-300x203.png 300w">
</p>
<p>
Perceba que os conjuntos treinamento e teste possuem apenas os valores
numéricos e não mais a variável <em>Species</em>, que é justamento o que
queremos prever.
</p>
<p>
Logo, vamos criar um vetor que contenha as observações da variável
Species para os conjuntos treinamento e teste:
</p>
<p>
<em><strong>\# Criando o vetor com os nomes(labels) para o conjunto
treinamento</strong></em><br> <em><strong>iris.trainLabels &lt;-
iris\[ind==1,5\]</strong></em>
</p>
<p>
<em><strong>\# Criando o vetor com os nomes(labels) para o conjunto
teste</strong></em><br> <em><strong>iris.testLabels &lt;- iris\[ind==2,
5\]</strong></em>
</p>
<p>
<em><strong>\# Inspecionando o resultado</strong></em><br>
<em><strong>print(iris.trainLabels)</strong></em><br>
<em><strong>print(iris.testLabels)</strong></em>
</p>
<p>
<img class="aligncenter wp-image-595 " src="http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/7.png%20961w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/7-300x149.png%20300w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/7-768x382.png%20768w" alt="" width="703" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/7.png 961w, http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/7-300x149.png 300w, http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/7-768x382.png 768w">
</p>
<p>
Temos agora tudo o que é necessário para construir o modelo, executando
a função <strong><em>knn()</em></strong>, disponível no
pacote <strong><em>class</em></strong><em>.</em>
</p>
<p>
Vamos utilizar aqui um k = 3.
</p>
<p>
<strong><em>\# Instale e carregue o pacote class:</em></strong><br>
<strong><em>\# install.packages(“class”)</em></strong><br>
<strong><em>library(class)</em></strong>
</p>
<p>
<strong><em>\# Veja mais detalhes sobre a função knn:</em></strong><br>
<strong><em>?knn</em></strong>
</p>
<p>
<strong><em>\# Construindo o modelo</em></strong><br>
<strong><em>iris\_pred &lt;- knn(train = iris.treinamento, test =
iris.test, cl = iris.trainLabels, k=3)</em></strong>
</p>
<p>
<strong><em>\# Inspecionando `iris_pred`</em></strong><br>
<strong><em>iris\_pred</em></strong>
</p>
<p>
<img class="aligncenter wp-image-597 " src="http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/8.png%20996w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/8-300x71.png%20300w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/8-768x181.png%20768w" alt="" width="936" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/8.png 996w, http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/8-300x71.png 300w, http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/8-768x181.png 768w">
</p>
<p>
Veja acima que o retorno da função <em>knn() </em>são as espécies
predizidas para o conjunto teste.
</p>
<p>
Nosso último passo é validar a performance do nosso modelo.
</p>
<p>
De maneira rudimentar, você pode fazer esta validação verificando se
cada observação do resultado do modelo (variável <em>iris\_pred</em>)
fez a predição correta, ou seja, se é igual à classe do conjunto teste
(variável <em>iris.testLabels).</em>
</p>
<p>
Mas vamos fazer esta validação de uma forma mais eficiente, utilizando a
função de tabela cruzada, <em><strong>CrossTable()</strong></em>,
disponível no pacote <strong><em>gmodels</em></strong>:
</p>
<p>
<em><strong>\# Instale e carregue o pacote gmodels:</strong></em><br>
<em><strong>\# install.packages(“gmodels”)</strong></em><br>
<em><strong>library(gmodels)</strong></em>
</p>
<p>
<em><strong>\# Construindo a tabela:</strong></em><br>
<em><strong>CrossTable(x = iris.testLabels, y = iris\_pred,
prop.chisq=FALSE)</strong></em>
</p>
<p>
<img class="aligncenter wp-image-599 size-full" src="http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/9.png%20699w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/9-266x300.png%20266w" alt="" width="699" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/9.png 699w, http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/9-266x300.png 266w">
</p>
<p>
Da tabela acima, lemos que nosso modelo fez apenas uma previsão errada:
para uma observação de espécie <em>virginica</em>, o modelo prediziu que
era de espécie <em>versicolor</em>.
</p>
<p>
Para todas as outras 39 observações do conjunto teste, o nosso modelo
fez a previsão correta. Poderíamos concluir que a performance do modelo
é bastante satisfatória.
</p>
<p>
Este foi um exemplo simples, então não tivemos que trabalhar muito no
modelo. Mas na prática, aumentar a performance do modelo implica em
normalizar os dados, verificar o resultado para diferentes valores para
k e testar diferentes formas de manipulação estatística, de modo a
construir o modelo mais eficaz possível.
</p>
<p>
Abaixo segue todo o código utilizado neste artigo:
</p>
<pre class="brush: r; title: ; notranslate"> # Abrindo pelo RStudio: iris&#xA0;&#xA0; # Importando da UCI: iris &lt;-&#xA0;read.csv(url(&quot;http://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data&quot;), header = FALSE) names(iris) &lt;- c(&quot;Sepal.Length&quot;, &quot;Sepal.Width&quot;, &quot;Petal.Length&quot;, &quot;Petal.Width&quot;, &quot;Species&quot;) # Visualizando os dados: library(tidyverse) iris %&gt;% ggplot(aes(x = Sepal.Length, y = Sepal.Width, colour = Species))+ geom_point() iris %&gt;% ggplot(aes(x = Petal.Length, y = Petal.Width, colour = Species))+ geom_point() # Construindo fun&#xE7;&#xE3;o normalizar: normalizar &lt;- function(x) { num &lt;- x - min(x) denom &lt;- max(x) - min(x) return (num/denom) } # aplicando a fun&#xE7;&#xE3;o normalizar para as vari&#xE1;veis num&#xE9;ricas iris_norm &lt;- as.data.frame(lapply(iris[1:4], normalizar)) # Obtendo um resumo do novo dataset summary(iris_norm) # Construindo um indicador para amostra aleat&#xF3;ria: set.seed(1234) ind &lt;- sample(2, nrow(iris), replace=TRUE, prob=c(0.67, 0.33)) # Construindo o conjunto de treinamento: iris.treinamento &lt;- iris[ind==1, 1:4] # Construindo o conjunto de treinamento: iris.test &lt;- iris[ind==2, 1:4] # Inspecionando os conjuntos: head(iris.treinamento) head(iris.test) # Criando o vetor com os nomes(labels) para o conjunto treinamento iris.trainLabels &lt;- iris[ind==1,5] # Criando o vetor com os nomes(labels) para o conjunto teste iris.testLabels &lt;- iris[ind==2, 5] # Inspecionando o resultado print(iris.trainLabels) print(iris.testLabels) # Instale e carregue o pacote class: # install.packages(&quot;class&quot;) library(class) # Veja mais detalhes sobre a fun&#xE7;&#xE3;o knn: ?knn # Construindo o modelo iris_pred &lt;- knn(train = iris.treinamento, test = iris.test, cl = iris.trainLabels, k=3) # Inspecionando `iris_pred` iris_pred # Instale e carregue o pacote gmodels: # install.packages(&quot;gmodels&quot;) library(gmodels) # Construindo a tabela: CrossTable(x = iris.testLabels, y = iris_pred, prop.chisq=FALSE) </pre>
<p>
Espero que este artigo tenha sido útil para você e que possa usufruir do
conhecimento aqui compartilhado.
</p>
<p>
Caso tenha qualquer comentário, sugestão, crítica ou dúvida, utilize o
espaço para comentários abaixo.
</p>
<p>
Até a próxima!
</p>
</div>

