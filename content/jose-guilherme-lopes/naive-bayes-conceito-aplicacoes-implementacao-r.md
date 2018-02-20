+++
title = "Naive Bayes: conceito, aplicações e implementação em R"
date = "2018-02-19 15:17:17"
categories = ["jose-guilherme-lopes"]
original_url = "http://joseguilhermelopes.com.br/naive-bayes-conceito-aplicacoes-implementacao-r/"
+++

<p>
O Naive Bayes é um algoritmo para classificação probabilística, baseado
no teorema de Bayes.
</p>
<p>
Enquanto o
<a href="http://joseguilhermelopes.com.br/uma-visao-sobre-o-algoritmo-knn-com-aplicacao-em-r/">kNN</a>,
que também é um algoritmo para classificação, utiliza a ideia de
proximidade (em geral modelada pela distância Euclidiana) para
classificar novas entidades, o Naive Bayes usa o conceito de
probabilidade para realizar a classificação.
</p>
<p>
Neste artigo apresento o conceito de probabilidade condicional, o
teorema de Bayes, o método do Naive Bayes e como implementá-lo em
linguagem R.
</p>
<h3>
<strong>Probabilidade Condicional</strong>
</h3>
<p>
Em poucas palavras,
<a href="https://pt.wikipedia.org/wiki/Probabilidade_condicionada">probabilidade
condicional</a> é a probabilidade de que algo aconteça dado que alguma
outra coisa já aconteceu.
</p>
<p>
O raciocínio para calcular a probabilidade condicional é que: se temos
dois eventos A e B, podemos calcular a probabilidade de A acontecer dado
que B aconteceu , <strong>P(A | B)</strong>, fazendo a divisão entre a
probabilidade de A e B ocorrerem juntos, <strong>P(A ∩ B)</strong>, pela
probabilidade de B ocorrer, <strong>P(B)</strong>.
</p>
<p>
O diagrama a seguir exemplifica este conceito:
</p>
<p>
<img class="aligncenter wp-image-626 " src="http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/conditional_b.png%20737w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/conditional_b-150x150.png%20150w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/conditional_b-300x300.png%20300w" alt="" width="428" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/conditional_b.png 737w, http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/conditional_b-150x150.png 150w, http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/conditional_b-300x300.png 300w">
</p>
<h3>
</h3>
<h3>
<strong>Teorema de Bayes</strong>
</h3>
<p>
O <a href="https://pt.wikipedia.org/wiki/Teorema_de_Bayes">teorema de
Bayes</a> é um corolário da lei de probabilidade condicional.
</p>
<p>
Perceba pela fórmula de probabilidade condicional, que podemos
representar a probabilidade de intersecção, <strong>P(A ∩ B)</strong>,
no formato <strong>P(A | B) P(B) </strong>ou no formato <strong>P(B | A)
P(A)</strong>, visto que <strong>P(A ∩ B) = P(B ∩ A)</strong>:
</p>
<p>
<img class="alignnone wp-image-627 size-full" src="http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/454654.png%20692w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/454654-300x19.png%20300w" alt="" width="692" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/454654.png 692w, http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/454654-300x19.png 300w">
</p>
<p>
E é através dessa conclusão que nasce o Teorema de Bayes, representado
pela fórmula:
</p>
<p>
<img class="aligncenter wp-image-624 " src="http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/1_9YuCNcICo5PW5qqQug6Yqw.png%20734w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/1_9YuCNcICo5PW5qqQug6Yqw-300x121.png%20300w" alt="" width="530" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/1_9YuCNcICo5PW5qqQug6Yqw.png 734w, http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/1_9YuCNcICo5PW5qqQug6Yqw-300x121.png 300w">
</p>
<p>
No qual:
</p>
<p>
<strong>P(A)</strong> e <strong>P(B)</strong> são chamadas de
probabilidades a priori; e
</p>
<p>
<strong>P(A | B) </strong>e <strong>P(B | A)</strong> são chamadas de
probabilidades a posteriori.
</p>
<p>
Um exemplo para entender a regra de Bayes poderia ser:
</p>
<p>
A: ter uma doença
</p>
<p>
B: um teste para esta doença dar positivo.
</p>
<p>
Teríamos então:
</p>
<p>
<em>Probabilidade de ter a doença dado que o teste deu positivo = </em>
</p>
<p>
<em>\[(Probabilidade do teste dar positivo dado que se tem a
doença)\*(Probabilidade de ter a doença)\] / </em>
</p>
<p>
<em>/ (Probabilidade do teste dar positivo, com ou sem doença)</em>
</p>
<p>
Havendo os conceitos de probabilidade condicional e do teorema de Bayes
claros, vamos agora ao algoritmo de Naive Bayes e à sua implementação
computacional:
</p>
<h3>
<strong>O algoritmo Naive Bayes</strong>
</h3>
<p>
Naive, em inglês, significa ingênuo, tolo. Isso é devido ao fato de que
o algoritmo assume que existe independência entre as variáveis do
conjunto de dados. Em outras palavras, o Naive Bayes considera que o
valor de uma variavél não está relacionado ou não é consequência do
valor de outra variável.
</p>
<p>
Em um processo de classificação no qual um exemplar com classe
desconhecida seja apresentado, o Naive Bayes tomará a decisão sobre qual
é a classe daquele exemplar, por meio do cálculo de probabilidades
condicionais. Ele faz isso calculando as probabilidades de ele pertencer
à cada uma das diferentes classes existentes no conjunto de treinamento
e então classifica o exemplar pela classe com maior probabilidade.
</p>
<p>
Para tornar mais claro, vamos tomar um exemplo utilizando dados do
Titanic, o qual também será usado na implementação computacional em R no
final do artigo.
</p>
<p>
Na tabela a seguir temos as seguintes informações de passageiros que
estavam no Titanic: a classe à qual pertenciam, o sexo, a idade e se
sobreviveram ou não. Para este exemplo eu usei dados fictícios, mas
utilizaremos a tabela real na implementação computacional em R ao final
do artigo.
</p>
<p>
Este é o nosso conjunto de treinamento, que possui 12 observações:
</p>
<p>
<img class="aligncenter wp-image-633 " src="http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/tabela-1.png%20771w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/tabela-1-300x205.png%20300w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/tabela-1-768x526.png%20768w" alt="" width="600" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/tabela-1.png 771w, http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/tabela-1-300x205.png 300w, http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/tabela-1-768x526.png 768w">
</p>
<p>
<strong>Tomando a variável <em>Sobreviveu</em> como aquela a ser
prevista, a implementação do Naive Bayes seria a de criar um modelo
probabilístico que faria a previsão se uma pessoa sobreviveria ou não
com base na sua classe, sexo e idade.</strong>
</p>
<p>
O primeiro passo a se fazer seria o de calcular as nossas
probabilidades <em>a priori</em>:
</p>
<p>
P(Sim) = 5/12 ; P(Não) = 7/12
</p>
<p>
Em seguida avaliamos cada uma das outras variáveis para o cálculo de
probabilidades condicionais. Por exemplo, para a
variável <em>Sexo</em> temos que:
</p>
<p>
P(Masculino | Sobreviveu Sim) = 3/5
</p>
<p>
P(Masculino | Não Sobreviveu) = 3/7
</p>
<p>
P(Feminino | Sobreviveu Sim) = 2/5
</p>
<p>
P(Feminino | Não Sobreviveu) = 4/7
</p>
<p>
E assim repetimos o processo para todas as variáveis, e então, para
realizar uma previsão, basta multiplicar todas as probabilidades.
</p>
<p>
Vamos supor que o nosso conjunto de teste seja um único exemplar e que
seja o personagem interpretado por Leonardo DiCaprio no filme Titanic.
Teríamos então:
</p>
<p>
<img class="aligncenter wp-image-634 " src="http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/tabela2.png%20778w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/tabela2-300x39.png%20300w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/tabela2-768x100.png%20768w" alt="" width="609" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/tabela2.png 778w, http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/tabela2-300x39.png 300w, http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/tabela2-768x100.png 768w">
</p>
<p>
Calculando as probabilidades para este exemplar, teríamos:
</p>
<p>
P(Sobreviver sim | terceira classe, sexo masculino e idade adulta)
= 5/12 \* 2/5 \* 3/5 \* 4/5 = <strong>0,08</strong>
</p>
<p>
P(Não sobreviver | terceira classe, sexo masculino e idade adulta)
= 7/12 \* 2/7 \* 3/7 \* 3/7 = <strong>0,03</strong>
</p>
<p>
Assim, o nosso exemplar é classificado pela probabilidade maior, que no
caso é a de <strong>Sobreviver = sim</strong>. <em>O</em><em> que prova
que
<a href="https://www.cineclick.com.br/noticias/titanic-kate-winslet-admite-que-jack-cabia-na-tabua">Jack
cabia sim naquela tábua</a>.</em>
</p>
<p>
O modelo Naive Bayes é fácil de construir e particularmente útil para
conjuntos de dados muito grandes. Juntamente com a simplicidade, Naive
Bayes é conhecido por superar outros métodos de classificação altamente
sofisticados.
</p>
<p>
Naive Bayes é comumente usado quando você possui variáveis discretas, ou
quando contínuas, seguem uma distribuição conhecida (ainda que
abordagens não-paramétricas também possam ser usadas).
</p>
<p>
Dentre as diferentes aplicações do Naive Bayes, as mais usadas são:
</p>
<ul>
<li>
<strong>Previsão em tempo real:</strong> Naive Bayes é um classificador
eficiente e bastante rápido. Quando o modelo é implementado para receber
dados que são gerados muito rapidamente, como aqueles oriundos de
<a href="http://joseguilhermelopes.com.br/big-data-nao-se-trata-apenas-de-volume-de-dados/">Big
Data</a>, o algoritmo pode realizar previsões em tempo real.
</li>
<li>
<strong>Previsão multivariada</strong>: Este algoritmo também é bem
conhecido para o recurso de predição multi-classe. No caso para prever a
probabilidade de múltiplas classes de uma variável alvo.
</li>
<li>
<strong>Classificação de texto</strong>: o classificador Naive Bayes é
um dos algoritmos mais bem sucedidos quando se trata da classificação de
documentos de texto, ou seja, se um documento de texto pertence a uma ou
mais categorias (classes). Devido ao melhor resultado em problemas de
várias classes e regras de independência, o Naive Bayes possui maior
taxa de sucesso em comparação com outros algoritmos. Dentre as
aplicações da classificação de texto, estão:
<ul>
<li>
<strong>Filtragem de spam</strong>: Isso se tornou um mecanismo popular
para distinguir o email de spam do e-mail legítimo. Vários serviços de
e-mail modernos implementam filtragem de spam bayesiana.
</li>
<li>
<strong>Análise do Sentimento</strong>: pode ser usado para analisar o
caráter de tweets ou postagens de Facebook, comentários e avaliações,
sejam eles negativos, positivos ou neutros.
</li>
</ul>
</li>
<li>
<strong>Sistema de recomendação</strong>: O algoritmo Naive Bayes em
combinação com
<a href="https://en.wikipedia.org/wiki/Collaborative_filtering">filtragem
colaborativa</a> é usado para criar sistemas de recomendação híbridos
que ajudam a prever se um usuário gostaria de um determinado recurso ou
não.
</li>
</ul>
<ul>
<li>
<ul>
<li>
Quando a suposição de independência é válida, um classificador Naive
Bayes se apresenta melhor comparado a outros modelos, como a regressão
logística e você precisa de menos dados de treinamento.
</li>
<li>
É fácil e rápido prever a classe de conjuntos de dados de teste. Ele
também funciona bem na previsão de várias classes.
</li>
<li>
Ele funciona bem tanto para variáveis categóricas como para variáveis
numéricas (<strong>para variáveis numéricas, é assumida a distribuição
normal)</strong>.
</li>
</ul>
</li>
<li>
<ul>
<li>
Se a variável categórica tiver uma categoria (no conjunto de dados de
teste), que não foi observada no conjunto de dados de treinamento, então
o modelo atribuirá uma probabilidade de 0 (zero) e será incapaz de fazer
uma previsão. Isso geralmente é conhecido como “Frequência zero”. Para
resolver isso, podemos usar a técnica de suavização. Uma das técnicas de
suavização mais simples é chamada de estimativa de Laplace.
</li>
<li>
Naive Bayes muitas vezes é um estimador ruim, então as saídas de
probabilidade de probabilidade não devem ser consideradas seriamente
demais.
</li>
</ul>
</li>
</ul>
<h3>
<strong>Implementação do Naive Bayes em R</strong>
</h3>
<h3>
</h3>
<p>
O pacote que vamos utilizar aqui para implementar o Naive Bayes é o
pacote <em><a href="https://cran.r-project.org/web/packages/e1071/e1071.pdf">e1071</a>,
</em>e para a criação do modelo utilizamos a
função <em>naiveBayes(). </em>Caso você não tenha o pacote instalado,
basta executar o comando <em>install.packages(“e1071”)</em>. Nosso
primeiro passo então é o de carregar o pacote:
</p>
<p>
<em><strong>library(e1071)</strong></em>
</p>
<p>
O conjunto de dados que vamos utilizar como exemplo é
o <em>Titanic</em>. Este dataset já está presente no <em>base</em> do R
(certifique-se que você está com a versão do R atualizada) e possui as
mesmas variáveis do exemplo utilizado neste artigo: Classe, Sexo, Idade
e Sobrevivência.
</p>
<p>
<em><strong>data(Titanic)</strong></em><br>
<em><strong>str(Titanic)</strong></em>
</p>
<p>
<img class="aligncenter wp-image-638 " src="http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/1-1.png%20589w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/1-1-300x133.png%20300w" alt="" width="451" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/1-1.png 589w, http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/1-1-300x133.png 300w">
</p>
<p>
Decidi por manter o conjunto de dados no formato <em>table</em> mesmo.
Caso você transforme para <em>data frame</em>, use a variável de
frequência de cada classe para fazer a divisão do conjunto de dados. Eu
coloquei a função para isto no final do código disponível ao final do
artigo.
</p>
<p>
Para construção do modelo, utilizamos a função <em>naiveBayes(). </em>Os
parâmetros principais são: 1) a variável cuja classes são o objeto de
previsão e que serão as probabilidades <em>a priori; </em>2) O conjunto
de dados de treinamento.
</p>
<p>
No nosso caso, a nossa variável para o primeiro parâmetro
é <em>Survived</em> e o conjunto de dados é o <em>Titanic</em>:
</p>
<p>
<em><strong>modelo\_NB &lt;- naiveBayes(Survived ~., data =
Titanic)</strong></em>
</p>
<p>
Se executarmos o objeto <em><strong>modelo\_NB</strong></em>, teremos
como output os valores das probabilidades <em>a priori </em> e as
probabilidades condicionais das outras variáveis:
</p>
<p>
<img class="aligncenter wp-image-639 size-full" src="http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/2.png%20589w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/2-300x281.png%20300w" alt="" width="589" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/2.png 589w, http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/2-300x281.png 300w">
</p>
<p>
O nosso conjunto de teste será novamente um exemplar fictício:
</p>
<p>
<em><strong>exemplar\_teste &lt;- data.frame(Class=”1st”, Sex=”Female”,
Age=”Adult”)</strong></em>
</p>
<p>
E assim, utilizamos a função <em>predict()</em> para obter o resultado
da estimativa.
</p>
<p>
Dentro da função <em>predict</em>, você pode especificar o
parâmetro <em>type = “class” </em>para obter somente a classe prevista,
ou <em>type = “raw”</em> para obter a probabilidade para cada uma das
classes:
</p>
<p>
<img class="aligncenter wp-image-640 size-full" src="http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/3.png%20497w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/3-300x120.png%20300w" alt="" width="497" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/3.png 497w, http://joseguilhermelopes.com.br/wp-content/uploads/2018/02/3-300x120.png 300w">
</p>
<p>
A seguir está todo o código em R:
</p>
<pre class="brush: r; title: ; notranslate"> library(e1071) data(Titanic) str(Titanic) modelo_NB &lt;- naiveBayes(Survived ~., data = Titanic) modelo_NB exemplar_teste &lt;- data.frame(Class=&quot;1st&quot;, Sex=&quot;Female&quot;, Age=&quot;Adult&quot;) predict(modelo_NB, exemplar_teste, type = &quot;class&quot;) predict(modelo_NB, exemplar_teste, type = &quot;raw&quot;) # Caso voc&#xEA; queira transformar o conjunto para data.frame e dividir as observa&#xE7;&#xF5;es pelas respectivas frequ&#xEA;ncias: Titanic &lt;- as.data.frame(Titanic) head(Titanic) countsToCases &lt;- function(x, countcol = &quot;Freq&quot;){ idx &lt;- rep.int(seq_len(nrow(x)), x[[countcol]]) x[[countcol]] &lt;- NULL x[idx,] } novo_Titanic &lt;- countsToCases(as.data.frame(Titanic)) </pre>
<p>
Espero que você tenha gostado deste artigo e que ele possa ter sido
bastante útil para você.
</p>
<p>
Até a próxima!
</p>

