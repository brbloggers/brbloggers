+++
title = "O guia do ggplot2: como fazer qualquer tipo de gráfico no R"
date = "2017-12-22 09:17:30"
categories = ["jose-guilherme-lopes"]
original_url = "http://joseguilhermelopes.com.br/o-guia-do-ggplot2-como-fazer-qualquer-tipo-de-grafico-no-r/"
+++

<p>
Na linguagem R, existem diversas funções para a criação de gráficos.
Porém, o pacote <strong>ggplot2</strong> traz uma extensão mais ampla,
moderna e acessível para visualização de dados, o que o torna um dos
pacotes mais usados dentro do
<a href="http://joseguilhermelopes.com.br/o-pacote-tidyverse-para-r/">Tidyverse</a>.
</p>
<p>
Neste artigo, vou apresentar todas as funções necessárias para criação
de gráficos com o ggplot2.
</p>
<p>
Para exemplificar as funções, vou usar os datasets que vêm junto ao
pacote tidyverse como o <strong>diamonds</strong> e
o <strong>mpg</strong>. Assim, fica mais fácil para você replicar os
códigos no seu computador.
</p>
<p>
Mas se você quiser outros datasets para praticar ou pesquisar, recomendo
buscar no
<a href="http://joseguilhermelopes.com.br/kaggle-o-portal-para-ciencia-de-dados/">Kaggle</a> ou
em alguns dos sites
linkados <a href="http://joseguilhermelopes.com.br/15-excelentes-sites-de-fontes-de-dados-abertos/">aqui</a>.
</p>
<p>
Para utilizar o ggplot2, instale o pacote executando a
função <em><strong>install.packages(“ggplot2”)</strong> </em>e em
seguida o carregue
executando <em><strong>library(“ggplot2”)</strong>. </em>Mas recomendo
instalar e carregar todo o conjunto de pacotes do Tidyverse, assim você
carrega de uma só vez todas as ferramentas básicas necessárias para
trabalhar com dados no R. Para isso, instale e carregue o tidyverse
executando as seguintes funções:
</p>
<p>
<em>install.packages(“tidyverse”)</em>
</p>
<p>
<em>library(“tidyverse”)<br> </em>
</p>
<h3>
<strong><br> Os parâmetros para criação de gráficos</strong>
</h3>
<p>
A seguir está descrito o template para a criação de qualquer gráfico com
o ggplot2, com todos os sete parâmetros que podem ser utilizados. Os
parâmetros estão em negrito e entre &lt; &gt;, e são a parte do código
em que você deve especificar o argumento desejado.
</p>
<blockquote>
<p>
<em>ggplot(data = &lt;<strong>DATASET</strong>&gt;) +</em>
</p>
<p>
<em>&lt;<strong>GEOM\_FUNCTION</strong>&gt;(mapping =
aes(&lt;<strong>MAPPING</strong>&gt;), stat =
&lt;<strong>STAT</strong>&gt;, position =
&lt;<strong>POSITION</strong>&gt;) +</em>
</p>
<p>
<em>&lt;<strong>COORDINATE\_FUNCTION</strong>&gt; + </em>
</p>
<p>
<em>&lt;<strong>FACET\_FUNCTION</strong>&gt;</em>
</p>
</blockquote>
<p>
Vou entrar em detalhes sobre os parâmetros ao longo deste artigo, mas a
seguir descrevo um resumo sobre cada um deles:
</p>
<ul>
<li>
<strong>&lt;DATASET&gt; </strong>: o dataset onde estão os dados que
você deseja criar o gráfico <strong>(Obrigatório).</strong>
</li>
<li>
<strong>&lt;GEOM\_FUNCTION&gt;</strong> : a função geom é o objeto
geométrico que um gráfico utiliza para representar os dados, como
barras, pontos, linhas, boxplots,  etc. <strong>(Obrigatório).</strong>
</li>
<li>
<strong>&lt;MAPPING&gt; : </strong>aqui você especifica quais são as
variáveis do seu dataset a serem utilizadas. Por exemplo, para um
gráfico de dispersão, especificamos <em>mapping = aes(x = variavel1, y =
variavel2)</em>. (<strong>Obrigatório)</strong>
</li>
<li>
<strong>&lt;STAT&gt;</strong> : é a transformação estatística a ser
feita nos dados para a criação do gráfico. Cada geom possui um stat
padrão, mas caso você queira um stat diferente para aquele geom, ele
deve ser especificado.
</li>
<li>
<strong>&lt;POSITION&gt; :</strong> é a posição em que os objetos do
geom se localizam. Cada geom possui uma posição padrão, mas caso você
queira uma posição diferente para aquele geom, ela deve ser
especificada.
</li>
<li>
<strong>&lt;COORDINATE\_FUNCTION&gt; : </strong>é a função que define o
sistema de coordenadas a ser utilizado no gráfico, que por padrão é o
sistema cartesiano. Você pode alterar e inverter as coordenadas do
gráfico com esta função, por exemplo para alterar um gráfico de colunas
para um gráfico de barras.
</li>
<li>
<strong>&lt;FACET\_FUNCTION&gt; : </strong>esta função permite dividir o
seu gráfico em subgráficos, geralmente a divisão é realizada por uma
variável categorizada, permitindo assim a comparação entre diferentes
grupos.
</li>
</ul>
<p>
Além destes parâmetros, existem as funções para inserção de títulos e
alteração de cores do gráfico, que citarei no final.
</p>
<p>
É possível criar centenas de milhares de gráficos ao realizar
combinações entre estes parâmetros. É muito útil enxergar as funções do
ggplot2, em especial os geoms, como camadas.
</p>
<p>
Não é necessário memorizar todas as funções do ggplot2, apenas entender
os conceitos e a lógica dos parâmetros que criam os gráficos. Para ver
em detalhes as funções do ggplot2 utilize a ajuda do R, executando ? +
função, ou ?? + função. Você também pode ver uma lista das funções
apenas digitando ? + o início da função.
</p>
<p>
Por exemplo, se na criação do seu gráfico você não sabe ou não se lembra
qual geom usar, execute <em>? + geom\_. </em>Isto abrirá uma caixa com
todas as funções que começam com <em>geom\_</em>, e assim você pode ler
sobre os detalhes de cada uma:
</p>
<p>
<img class="aligncenter wp-image-507" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/1-1.png%20676w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/1-1-300x95.png%20300w" alt="" width="500" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/1-1.png 676w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/1-1-300x95.png 300w">
</p>
<h3>
<strong>Especificando o dataset e mapeando as variáveis</strong>
</h3>
<p>
Para criação de gráficos com o ggplot2, inicie com a
função <em>ggplot(). </em>Por padrão, o primeiro argumento da função
<em>ggplot() </em>é o nome do dataset onde estão os dados que você
deseja criar o gráfico. Assim, se você especificar o dataset no primeiro
argumento da função ggplot, não é necessário inserir “<em>data = “</em>,
você pode inserir apenas o nome do dataset.
</p>
<p>
Por exemplo, o dataset <em>diamonds</em>, que vem imbutido no tidyverse,
pode ser declarado no ggplot no formato:
</p>
<p>
<em><strong>ggplot(data = dataset)</strong> , </em>ou
simplesmente, <strong><em>ggplot(dataset)</em></strong><em> .</em>
</p>
<p>
A especificação, ou mapeamento, das variáveis, é feita utilizando a
função <em>mapping = </em><em>aes() </em>ou
simplesmente <em>aes(). </em>Esta função pode ser declarada dentro da
função <em>ggplot()</em> ou dentro da função geom, a diferença é que na
função <em>ggplot() </em>o mapeamento das variáveis é global para todo o
resto do código (muito útil se você estiver trabalhando com múltiplos
geoms), enquanto que na função geom o mapeamento é específico para
aquele geom.
</p>
<p>
<em><strong>ggplot(data = dataset, aes(x = variavel1, y = variavel2))
+ </strong><strong>geom\_x()</strong></em>
</p>
<p>
é equivalente à
</p>
<p>
<strong><em>ggplot(data = dataset) + geom\_x(aes(x = variavel1, y =
variavel2))</em></strong>
</p>
<p>
Leve em consideração que é possível realizar o mapeamento de funções de
variáveis, por exemplo <em>aes(x = variavel1 ^ 2).</em>
</p>
<p>
Além disso, na função <em>aes()</em>, é possível mapear variáveis com o
objetivo de agregar mais informação visual ao gráfico.
</p>
<p>
Por exemplo, num gráfico de dispersão (onde o geom é o <em>geom\_point()
)</em>, temos que declarar duas variáveis quantitativas dentro
do <em>aes() </em>para criar o gráfico. Mas poderíamos agregar mais
informação ao gráfico de dispersão ao utilizar cores para exibir as
diferentes categorias presentes numa terceira variável. Para isso,
especificamos esta terceira variável como argumento de “color” ou
“colour”:
</p>
<p>
<em><strong>ggplot(data=mpg) + </strong></em><br> <em><strong>
geom\_point(mapping = aes(x=displ, y = hwy))</strong></em>
</p>
<p>
<em><strong>ggplot(data=mpg) + </strong></em><br> <em><strong>
geom\_point(mapping = aes(x=displ, y = hwy, color =
class))</strong></em>
</p>
<p>
<img class="aligncenter wp-image-515 size-full" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/3-1.png%201629w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/3-1-300x90.png%20300w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/3-1-768x231.png%20768w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/3-1-1024x307.png%201024w" alt="" width="1629" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/3-1.png 1629w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/3-1-300x90.png 300w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/3-1-768x231.png 768w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/3-1-1024x307.png 1024w">
</p>
<p>
Se caso você não possa ou não queira fazer essa divisão por cores, pode
fazer pela transparência dos pontos com <em>alpha</em> (ex: <em>alpha =
class)</em> ou pelo formato dos pontos com <em>shape</em> (ex: <em>shape
= class). </em>Mas atenção que em <em>shape</em> são aceitos no máximo 6
diferentes categorias.
</p>
<h3>
</h3>
<h3>
<strong><br> Objetos geométricos – geoms</strong>
</h3>
<p>
Irei apresentar aqui um resumo da maioria dos geoms do ggplot2. Para
facilitar a apresentação, irei dividir os geoms por quantidade e tipo de
variáveis a serem especificadas.
</p>
<p>
É sempre válido explorar a ajuda da função (<em>?geom\_x</em>) para ver
os parâmetros que podem ser inseridos na função, assim você usa todo o
potencial do geom e deixa o gráfico na formato exato que desejar.
</p>
<ul>
<li>
<strong>Gráficos para uma variável – contínua</strong>
</li>
</ul>
<p>
c &lt;- ggplot(data=mpg, mapping=aes(x = hwy))
</p>
<p>
<em>c + geom\_area()</em>
</p>
<p>
c + geom\_density()
</p>
<p>
<em>c + geom\_dotplot()</em>
</p>
<p>
<em>c + geom\_freqpoly()</em>
</p>
<p>
<em>c + geom\_histogram()</em>
</p>
<p>
<img class="size-medium wp-image-519 alignleft" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/1-2-300x187.png%20300w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/1-2-768x478.png%20768w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/1-2.png%20785w" alt="" width="300" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/1-2-300x187.png 300w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/1-2-768x478.png 768w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/1-2.png 785w">
<img class="size-medium wp-image-520 alignleft" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/2-1-300x187.png%20300w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/2-1-768x478.png%20768w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/2-1.png%20785w" alt="" width="300" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/2-1-300x187.png 300w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/2-1-768x478.png 768w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/2-1.png 785w">
<img class="size-medium wp-image-521 alignleft" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/3-2-300x187.png%20300w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/3-2-768x478.png%20768w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/3-2.png%20785w" alt="" width="300" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/3-2-300x187.png 300w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/3-2-768x478.png 768w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/3-2.png 785w">
<img class="size-medium wp-image-522 alignleft" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/4-300x187.png%20300w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/4-768x478.png%20768w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/4.png%20785w" alt="" width="300" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/4-300x187.png 300w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/4-768x478.png 768w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/4.png 785w">
<img class="size-medium wp-image-523 alignleft" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/5-300x187.png%20300w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/5-768x478.png%20768w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/5.png%20785w" alt="" width="300" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/5-300x187.png 300w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/5-768x478.png 768w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/5.png 785w">
</p>
<ul>
<li>
<strong>Gráficos para uma variável – discreta</strong>
</li>
</ul>
<p>
<em>ggplot(data=mpg, mapping=aes(x=fl))+</em><br> <em> geom\_bar()</em>
</p>
<p>
<img class="alignnone size-medium wp-image-525" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/6-300x187.png%20300w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/6-768x478.png%20768w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/6.png%20785w" alt="" width="300" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/6-300x187.png 300w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/6-768x478.png 768w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/6.png 785w">
</p>
<ul>
<li>
<strong>Gráficos para duas variáveis – ambas contínuas</strong>
</li>
</ul>
<p>
<em>e &lt;- ggplot(data=mpg, mapping=aes(x=cty, y=hwy))</em>
</p>
<p>
<em>e + geom\_point()</em>
</p>
<p>
<em>e + geom\_jitter()</em>
</p>
<p>
<em>e + geom\_smooth()</em>
</p>
<p>
<img class="alignnone size-medium wp-image-526" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/1-3-300x187.png%20300w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/1-3-768x478.png%20768w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/1-3.png%20785w" alt="" width="300" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/1-3-300x187.png 300w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/1-3-768x478.png 768w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/1-3.png 785w">
<img class="alignnone size-medium wp-image-527" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/2-2-300x187.png%20300w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/2-2-768x478.png%20768w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/2-2.png%20785w" alt="" width="300" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/2-2-300x187.png 300w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/2-2-768x478.png 768w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/2-2.png 785w">
<img class="alignnone size-medium wp-image-528" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/3-3-300x187.png%20300w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/3-3-768x478.png%20768w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/3-3.png%20785w" alt="" width="300" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/3-3-300x187.png 300w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/3-3-768x478.png 768w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/3-3.png 785w">
</p>
<ul>
<li>
<strong>Gráficos para duas variáveis – uma discreta e uma
contínua</strong>
</li>
</ul>
<p>
<em>f &lt;- ggplot(mpg, aes(class, hwy))</em>
</p>
<p>
<em>f + geom\_bar(stat=”identity”)</em>
</p>
<p>
<em>f + geom\_boxplot()</em>
</p>
<p>
<em>f + geom\_violin()</em>
</p>
<p>
<img class="alignnone size-medium wp-image-531" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/1-4-300x187.png%20300w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/1-4-768x478.png%20768w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/1-4.png%20785w" alt="" width="300" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/1-4-300x187.png 300w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/1-4-768x478.png 768w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/1-4.png 785w">
<img class="alignnone size-medium wp-image-532" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/2-3-300x187.png%20300w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/2-3-768x478.png%20768w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/2-3.png%20785w" alt="" width="300" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/2-3-300x187.png 300w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/2-3-768x478.png 768w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/2-3.png 785w">
<img class="alignnone size-medium wp-image-533" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/3-4-300x187.png%20300w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/3-4-768x478.png%20768w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/3-4.png%20785w" alt="" width="300" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/3-4-300x187.png 300w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/3-4-768x478.png 768w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/3-4.png 785w">
</p>
<ul>
<li>
<b>Distribuições contínuas bivariadas</b>
</li>
</ul>
<p>
<em>h &lt;- ggplot(diamonds, aes(carat, price))</em>
</p>
<p>
<em>h + geom\_bin2d(binwidth = c(0.25, 500))</em>
</p>
<p>
<em>h +  geom\_density\_2d()</em>
</p>
<p>
<em>h +  geom\_hex()</em>
</p>
<p>
<img class="alignnone size-medium wp-image-534" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/1-5-300x187.png%20300w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/1-5-768x478.png%20768w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/1-5.png%20785w" alt="" width="300" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/1-5-300x187.png 300w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/1-5-768x478.png 768w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/1-5.png 785w">
<img class="alignnone size-medium wp-image-535" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/2-4-300x187.png%20300w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/2-4-768x478.png%20768w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/2-4.png%20785w" alt="" width="300" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/2-4-300x187.png 300w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/2-4-768x478.png 768w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/2-4.png 785w">
<img class="alignnone size-medium wp-image-536" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/3-5-300x187.png%20300w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/3-5-768x478.png%20768w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/3-5.png%20785w" alt="" width="300" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/3-5-300x187.png 300w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/3-5-768x478.png 768w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/3-5.png 785w">
</p>
<p>
<em>i &lt;- ggplot(economics, aes(date, unemploy))</em>
</p>
<p>
<em>i + </em><em>geom\_area()</em>
</p>
<p>
<em>i +  </em><em>geom\_line()</em>
</p>
<p>
<img class="alignnone size-medium wp-image-537" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/1-6-300x187.png%20300w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/1-6-768x478.png%20768w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/1-6.png%20785w" alt="" width="300" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/1-6-300x187.png 300w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/1-6-768x478.png 768w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/1-6.png 785w">
<img class="alignnone size-medium wp-image-538" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/2-5-300x187.png%20300w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/2-5-768x478.png%20768w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/2-5.png%20785w" alt="" width="300" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/2-5-300x187.png 300w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/2-5-768x478.png 768w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/2-5.png 785w">
</p>
<ul>
<li>
<strong>Gráficos para três variáveis</strong>
</li>
</ul>
<p>
<em>seals$z &lt;- with(seals, sqrt(delta\_long^2 +
delta\_lat^2))</em><br> <em> l &lt;- ggplot(seals, aes(long, lat))</em>
</p>
<p>
<em>l +  geom\_contour(aes(z=z))</em>
</p>
<p>
<em>l +  geom\_tile(aes(fill=z))</em>
</p>
<p>
<img class="alignnone size-medium wp-image-539" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/1-7-300x187.png%20300w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/1-7-768x478.png%20768w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/1-7.png%20785w" alt="" width="300" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/1-7-300x187.png 300w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/1-7-768x478.png 768w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/1-7.png 785w">
 <img class="alignnone size-medium wp-image-541" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/3-6-300x187.png%20300w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/3-6-768x478.png%20768w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/3-6.png%20785w" alt="" width="300" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/3-6-300x187.png 300w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/3-6-768x478.png 768w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/3-6.png 785w">
</p>
<p>
Veja também: <em>?geom\_map</em>
</p>
<h3>
<strong><br> Transformações estatísticas – stats</strong>
</h3>
<p>
Alguns geoms realizam uma transformação nos dados para a criação do
gráfico. Por exemplo, o gráfico de colunas/barras faz uma contagem de
cada observação de uma variável e exibe no gráfico, colunas
proporcionais à esta contagem.
</p>
<p>
“Stats” é uma forma alternativa para criar uma camada.
</p>
<p>
Ambas as funções stat e geom combinam um stat com um geom para criar uma
camada. Por exemplo, <strong>stat\_count(geom = “bar”) </strong>faz o
mesmo que <strong>geom\_bar(stat = “count”).</strong>
</p>
<p>
Use um stat para escolher uma transformação a ser visualizada.
</p>
<p>
Veja por exemplo este gráfico de colunas para a variável “cut”, que
possui 5 diferentes observações:
</p>
<p>
<em>ggplot(data=diamonds)+</em><br> <em>
geom\_bar(mapping=aes(x=cut))</em>
</p>
<p>
<img class="aligncenter wp-image-476 size-full" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/11/1.png%20500w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/11/1-300x187.png%20300w" alt="" width="500" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/11/1.png 500w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/11/1-300x187.png 300w">
</p>
<p>
Perceba no gráfico acima, que no eixo y está descrito “count”. Não
tivemos que especificar no nosso código a realização desta contagem,
pois a transformação do tipo contagem (<strong>count</strong>) é a
transformação estatística (<strong>stat</strong>) padrão da função
geom\_bar.
</p>
<p>
Veja a lista detalhada de todas as transformações do ggplot2,
digitando <em>?stat\_</em> e navegando pelo menu exibido.
</p>
<h3>
<strong>Ajustes de Posição – positions</strong>
</h3>
<p>
Ajustes de posição definem como os geoms se localizam, evitando que
ocupem o mesmo espaço.
</p>
<p>
Por exemplo, você deseja criar um gráfico de barras para duas variáveis.
A posição das barras podem ser uma ao lado da outra, empilhadas no
tamanho de cada uma, empilhadas mas com a altura normalizada, etc.
</p>
<p>
Para definir a posição dos seus objetos/elementos, utilize o
argumento <strong>position =  “x”</strong> dentro da função geom. O “x”
pode ser declarado nas seguintes formas:
</p>
<ul>
<li>
<strong>position = “identity”</strong> irá colocar cada objeto na
posição exata em que ele cairia no contexto do gráfico. É um ajuste útil
para geoms do tipo 2D, como no gráfico de dispersão (geom\_point), no
qual “identity” é o ajuste de posição padrão. Para gráficos de barras,
não é um ajuste muito útil, mas segue como exemplo:
</li>
</ul>
<p>
<em> ggplot(diamonds, aes(x=cut, fill = clarity))+</em><br> <em>
geom\_bar(position=”identity”)</em>
</p>
<p>
<img class=" wp-image-485 aligncenter" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/identity-300x187.png%20300w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/identity-768x478.png%20768w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/identity.png%20785w" alt="" width="476" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/identity-300x187.png 300w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/identity-768x478.png 768w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/identity.png 785w">
</p>
<ul>
<li>
<strong>position = “dodge” </strong>coloca objetos sobrepostos um ao
lado do outro. Isto torna mais fácil a comparação de valores
individuais:
</li>
</ul>
<p>
<em>ggplot(diamonds, aes(x=cut, fill=clarity))+</em><br> <em>
geom\_bar(position=”dodge”)</em>
</p>
<p>
<img class=" wp-image-486 aligncenter" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/dodge-300x187.png%20300w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/dodge-768x478.png%20768w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/dodge.png%20785w" alt="" width="467" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/dodge-300x187.png 300w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/dodge-768x478.png 768w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/dodge.png 785w">
</p>
<ul>
<li>
<strong>position = “fill”</strong> irá empilhar os elementos um sobre o
outro, mas normalizando a altura. Isso é muito útil para comparar
proporções entre os grupos:
</li>
</ul>
<p>
<em>ggplot(diamonds, aes(x=cut, fill=clarity))+</em><br> <em>
geom\_bar(position=”fill”)</em>
</p>
<p>
<img class=" wp-image-488 aligncenter" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/fill-300x187.png%20300w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/fill-768x478.png%20768w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/fill.png%20785w" alt="" width="475" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/fill-300x187.png 300w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/fill-768x478.png 768w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/fill.png 785w">
</p>
<ul>
<li>
<strong>position = “jitter” </strong>é muito útil para gráficos de
dispersão. Um dos problemas do gráfico de dispersão é o
chamado <em>overplotting</em>, que ocorre quando dois ou mais pontos
estão posicionados no mesmo local do gráfico (como x = 40 e y = 2) e
assim a visualização fica comprometida pois só enxergaremos um único
ponto naquele local. Ao definir position=”jitter”, o ggplot irá
adicionar um ruído aleatório nas posições de X e Y.
</li>
</ul>
<p>
Adicionar aleatoriedade pode parecer uma forma estranha de melhorar o
seu gráfico, mas enquanto o <em>jitter</em> torna seu gráfico menos
preciso em pequena escala, ele torna o seu gráfico mais revelador e
significativo em larga escala.
</p>
<p>
<em>ggplot(mpg, aes(x=displ, y=hwy))+</em><br> <em>
geom\_point(position=”jitter”)</em>
</p>
<p>
<img class=" wp-image-489 aligncenter" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/jitter-300x187.png%20300w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/jitter-768x478.png%20768w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/jitter.png%20785w" alt="" width="451" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/jitter-300x187.png 300w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/jitter-768x478.png 768w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/jitter.png 785w">
</p>
<p>
Outros ajustes de posição que não irei exemplificar aqui, mas que são
bastante intuitivos e fáceis de aplicar são:
</p>
<ul>
<li>
<strong>position = “nudge”</strong>, que afasta os rótulos dos pontos.
</li>
<li>
<strong>position = “stack”</strong>, que empilha os elementos um sobre o
outro.
</li>
</ul>
<p>
Para obter mais informação sobre qualquer ajuste de posição, veja a
página de ajuda associada a cada ajuste:
</p>
<p>
<em>?position\_dodge, ?position\_fill, ?position\_identity,
?position\_jitter, ?position\_stack</em>, etc.
</p>
<h3>
<strong>Sistemas de Coordenadas – coordinates</strong>
</h3>
O sistema de coordenadas padrão é o Cartesiano, onde as posições de X e
Y agem independentemente para encontrar a localização de cada
ponto/objeto no gráfico.

Entretanto existem outros sistemas de coordenadas que podem ser bastante
úteis para visualização de dados, de acordo com o seu objetivo:

<ul>
<li>
<strong>coord\_flip()</strong> faz a inversão entre os eixos X e Y. Isso
é muito útil quando o número de variáveis que você possui no eixo X é
muito extenso e a leitura fica comprometida.
</li>
</ul>
Por exemplo, neste gráfico são exibidos os boxplots de 15 variáveis:

<em>ggplot(mpg, aes(x = manufacturer, y = hwy))+</em>

<p>
<img class="aligncenter wp-image-495 size-full" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/1.png%20785w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/1-300x187.png%20300w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/1-768x478.png%20768w" alt="" width="785" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/1.png 785w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/1-300x187.png 300w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/1-768x478.png 768w">
</p>
Se inserirmos a função coord\_flip(), os eixos se invertem e o gráfico
pode ser melhor visualizado:

<em>ggplot(mpg, aes(x = manufacturer, y = hwy))+</em>

<img class="aligncenter wp-image-496 size-full" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/2.png%20785w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/2-300x187.png%20300w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/2-768x478.png%20768w" alt="" width="785" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/2.png 785w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/2-300x187.png 300w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/2-768x478.png 768w">

Dica: o gráfico de barras nada mais é do que um gráfico de colunas
geom\_bar() com a função coord\_flip().

<ul>
<li>
<strong>coord\_quickmap() </strong>é muito útil quando se está
trabalhando com dados espaciais. Esta função ajusta corretamente a
extensão do seu mapa, em especial quando se usa geom\_polygon().
</li>
</ul>

<ul>
<li>
<strong>coord\_polar()</strong> transforma o gráfico para o sistema de
coordenadas polares. Utilize esta função para criar gráficos de Coxcomb
e
<a href="http://www.sthda.com/english/wiki/ggplot2-pie-chart-quick-start-guide-r-software-and-data-visualization">gráficos
de setores</a>.
</li>
</ul>
<p>
Exemplo de gráfico de Coxcomb:
</p>
<p>
<em>ggplot(diamonds, aes(x = cut, fill=cut))+</em><br> <em>
geom\_bar()+</em><br> <em> coord\_polar()</em>
</p>
<p>
<img class="aligncenter wp-image-497 size-full" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/3.png%20785w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/3-300x187.png%20300w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/3-768x478.png%20768w" alt="" width="785" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/3.png 785w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/3-300x187.png 300w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/12/3-768x478.png 768w">
</p>
<h3>
<strong><br> Dividindo o gráfico em subgráficos – facets</strong>
</h3>
<p>
Facetas, ou facets, têm o propósito de dividir um gráfico em subgráficos
baseando-se em uma ou mais variáveis discretas (em especial variáveis
categorizadas).
</p>
<p>
Facetas podem ser muito úteis quando você deseja visualizar o
comportamento de diferentes categorias num mesmo gráfico.
</p>
<p>
Por exemplo, estamos visualizando um gráfico de dispersão entre o
tamanho do motor de um carro (displ) e o consumo de gasolina por milha
percorrida(hwy):
</p>
<p>
<em>ggplot(data=mpg)+</em><br> <em> geom\_point(mapping=aes(x=displ,
y=hwy))</em>
</p>
<p>
<img class="aligncenter wp-image-478 size-full" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/11/2.png%20785w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/11/2-300x187.png%20300w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/11/2-768x478.png%20768w" alt="" width="785" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/11/2.png 785w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/11/2-300x187.png 300w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/11/2-768x478.png 768w">
</p>
<p>
e então decidimos dividir este gráfico pelo tipo do automóvel(class),
assim podemos visualizar o mesmo comparativo mas dividido entre
categorias. Para isso usamos a função FACET:
</p>
<p>
ggplot(data=mpg)+ geom\_point(mapping=aes(x=displ, y=hwy))+
</p>
<p>
facet\_wrap(~ class, nrow=2)
</p>

