+++
title = "Conhecendo os pacotes populares — Introdução a Machine Learning com R — Parte 2"
date = "2016-05-15 23:01:01"
categories = ["d-van"]
original_url = "https://d-van.org/conhecendo-os-pacotes-populares-introdu%C3%A7%C3%A3o-a-machine-learning-com-r-parte-2-8bff273fbb76?source=rss----79c839d6008d---4"
+++

<div>
<div>
<p id="0e4f" class="graf graf--p graf-after--h3">
Na
<a href="https://medium.com/arqui-voz/predizendo-as-mortes-do-game-of-thrones-introdu%C3%A7%C3%A3o-a-machine-learning-com-r-parte-1-19c09a93f8a3#.qo2eqn3ix" class="markup--anchor markup--p-anchor">primeira
parte</a> , usando conceitos simples, adquirimos intuição de como
funciona uma SVM. Se ainda não leu, recomendo fortemente.
</p>

<div class="section-content">
<div class="section-inner sectionLayout--insetColumn">
<p id="de47" class="graf graf--p graf--leading">
Refrescando a memória, temos um conjunto de dados (ex: uma imagem) e um
classificador com pesos para esses dados. O classificador realiza
operações (definidas pela função kernel) entre seus pesos e os dados
para retornar scores. O maior dos scores deve apontar a classe correta
(mecanismo de voto). Vimos que existem diversas formas de encontrar
valores para os pesos que classifiquem corretamente as imagens
(minimizem as perdas).
</p>
<p id="de0e" class="graf graf--p graf-after--p">
Vimos como funcionam as operações com um kernel linear.
</p>
<p id="9049" class="graf graf--p graf-after--p">
Não é de nosso interesse codificar uma SVM do zero a cada aplicação.
Primeiro, se todos usarem ferramentas compatíveis, economizaremos tempo
e aumentaremos a capacidade de comunicação com outros grupos na hora de
reportar trabalhos. Além disso, podemos fazer aprimoramentos no software
a longo prazo (otimização de algoritmos e interface de usuário). Por
esses motivos, temos alguns pacotes disponíveis.
</p>
<figure id="519e" class="graf graf--figure graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/0*oerCiPcLTwTomG9w.jpg">
<figcaption class="imageCaption">
<a href="https://en.wikipedia.org/wiki/Linus_Torvalds" class="markup--anchor markup--figure-anchor">Linus
Torvalds</a> (Linux) e
<a href="https://en.wikipedia.org/wiki/Richard_Stallman" class="markup--anchor markup--figure-anchor">Richard
Stallman</a> (GNU). Dois caras legais.
</figcaption>
</figure>
<p id="2845" class="graf graf--p graf-after--figure">
Graças ao movimento em torno do<em class="markup--em markup--p-em">
software livre </em>e seus ideais, temos acesso a pacotes potentes
desenvolvidos pela comunidade. Como prometido, veremos nesse texto a
implementação de Support Vector Machines com pacotes populares no R.
</p>
<p id="eb45" class="graf graf--p graf-after--p">
Recomendo esse paper
<a href="https://www.jstatsoft.org/article/view/v015i09" class="markup--anchor markup--p-anchor">aqui</a>
para uma abordagem mais profunda e definições formais com
hiperplanos — <strong class="markup--strong markup--p-strong">Support
Vector Machines in R (</strong> Alexandros Karatzoglou, David Meyer,
Kurt Hornik).
</p>
<p id="9bf6" class="graf graf--p graf-after--h4">
O paper acima traz uma comparação de recursos e benchmarks para tempos
das funções dos pacotes
<strong class="markup--strong markup--p-strong">kernlab</strong>,
<strong class="markup--strong markup--p-strong">e1071</strong>,
<strong class="markup--strong markup--p-strong">klaR</strong> e
<strong class="markup--strong markup--p-strong">svmpath </strong>em
diferentes datasets para uma mesma tarefa.
</p>
<figure id="c5f5" class="graf graf--figure graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/1*9g-WmZcpPivwihjciE5DlA.png">
<figcaption class="imageCaption">
Benchmarks (Tempo em segundos). Os dados para os pacotes estão
nas colunas.
</figcaption>
</figure>
<p id="c021" class="graf graf--p graf-after--figure">
Os pacotes
<strong class="markup--strong markup--p-strong">kernlab</strong> e
<strong class="markup--strong markup--p-strong">e1071</strong> parecem
ser os mais rápidos (e1071 ligeramente na frente). A
<strong class="markup--strong markup--p-strong">e1071</strong> é um
interface para o
<a href="https://www.csie.ntu.edu.tw/~cjlin/libsvm/" class="markup--anchor markup--p-anchor"><strong class="markup--strong markup--p-strong">libsvm</strong></a> ,
library premiada (IJCNN 2001 Challenge) e escrita em C++, o que garante
a melhor performance. O problema é que não há flexibilidade para mudar
muito o <em class="markup--em markup--p-em">kernel</em>. Já o
<strong class="markup--strong markup--p-strong">kernlab </strong>traz
maior flexibilidade, mas seleção de modelos é limitada. Recomendo
brincar com as quatro <em class="markup--em markup--p-em">libs</em>. Já
que não vamos mexer no <em class="markup--em markup--p-em">kernel</em>,
vamos com a função
<strong class="markup--strong markup--p-strong">svm()</strong> do pacote
<strong class="markup--strong markup--p-strong">e1071 </strong>em nome
do minimalismo.
</p>
<p id="977c" class="graf graf--p graf-after--h4">
Vamos usar o famoso banco de dados
<a href="https://en.wikipedia.org/wiki/Iris_flower_data_set" class="markup--anchor markup--p-anchor">iris</a>.
Usado por Ronald Fisher para demonstrar análise discriminante linear
<a href="http://onlinelibrary.wiley.com/doi/10.1111/j.1469-1809.1936.tb02137.x/abstract;jsessionid=03C8F50AD5ECCFDFCD4951CFBB66FCC5.f03t01?systemMessage=Wiley+Online+Library+will+be+unavailable+on+Saturday+14th+May+11%3A00-14%3A00+BST+%2F+06%3A00-09%3A00+EDT+%2F+18%3A00-21%3A00+SGT+for+essential+maintenance.Apologies+for+the+inconvenience" class="markup--anchor markup--p-anchor">em
1936</a>, já incluso no R.
</p>
<figure id="dffb" class="graf graf--figure graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/0*4uZKnV8j40GLSgNr.jpg">
<figcaption class="imageCaption">
<em class="markup--em markup--figure-em">Iris virginica</em> — Uma das
espécies estudadas. Imagem retirada
da <a href="https://upload.wikimedia.org/wikipedia/commons/9/9f/Iris_virginica.jpg" class="markup--anchor markup--figure-anchor">wiki</a>
</figcaption>
</figure>
<figure id="0635" class="graf graf--figure graf-after--figure">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/1*HF8ztPROe238WIlkQkH0xQ.png">
<figcaption class="imageCaption">
12 observações (são 150) do banco de dados: espécie (Species) tamanho
(Length) e largura (Width) de pétalas e sétalas
</figcaption>
</figure>
<pre id="40af" class="graf graf--pre graf-after--figure"># pacote e1071 com a funcao svm<br>&gt;library(e1071)</pre>
<pre id="66ec" class="graf graf--pre graf-after--pre"># O pacote caret tem varias utilidades em machine learning. Carreguei para aproveitar o gerador de dados particionados<br>&gt;library(caret)</pre>
<pre id="e861" class="graf graf--pre graf-after--pre"># Carregando nossos dados<br>&gt;data(iris)<br><br></pre>
<pre id="87fa" class="graf graf--pre graf-after--pre">#Como antes, enviesamos gerador de numeros aleatorios para garantir resultados iguals na replicacao<br>&gt;set.seed(50)</pre>
<pre id="9a07" class="graf graf--pre graf-after--pre"># Usa funcao createDataPartition do caret para gerar vetor com vasos sorteados na proporcao 4/5<br># A frequencia relativa de r&#xF3;tulos (Species) fica mantida<br>&gt;iris.tr.vec &lt;- createDataPartition(y=iris$Species,p = 4/5,list=F)</pre>
<pre id="d3a0" class="graf graf--pre graf-after--pre"># Carregando dataset de treino com casos sorteados (4/5 da amostra)<br>&gt;iris.tr &lt;- iris[iris.tr.vec,]</pre>
<pre id="07d3" class="graf graf--pre graf-after--pre"># Corregando dataset de teste com casos complementares (1/4 restantes)<br>&gt;iris.ts &lt;- iris[-iris.tr.vec,]</pre>
<p id="db44" class="graf graf--p graf-after--pre">
Agora, temos um banco com 80% (4/5) dos dados para treinar a SVM e outro
com 20% para testar.
</p>
<p id="20e6" class="graf graf--p graf-after--h4">
Vamos usar a função svm, especificando uma fórmula (“Species ~ .”
significa Species como variável de classificação e as outras como
input), o banco de dados e um custo (Constate C; falaremos mais sobre
ela depois).
</p>
<pre id="9395" class="graf graf--pre graf-after--p"># Ajusta support vector machine em banco de treino (isis.tr)<br>&gt;svm.iris &lt;- svm(Species ~&#xA0;., data=iris.tr, cost=100,  kernel=&quot;linear&quot;)<br>#Se eu quisesse menos variaveis: svm(Species ~ Sepal.Length + Petal.Length,data=iris.ts,cost=100, kernel=&quot;linear&quot;)</pre>
<p id="3a36" class="graf graf--p graf-after--pre">
Agora, fazemos as predições:
</p>
<pre id="6396" class="graf graf--pre graf-after--p"># Usa metodo predict para fazer predicoes em dataset de teste (iris.ts) usando nossa svm (svm.iris)<br>&gt;svm.pred &lt;- predict(svm.iris,iris.ts)</pre>
<pre id="7d1e" class="graf graf--pre graf-after--pre"># Dispoe predicoes e valores no dataset de teste em uma tabela<br>&gt;agree.tab &lt;- table(pred=svm.pred,true=iris.ts$Species)<br>&gt;agree.tab<br>agree.tab<br>            true<br>pred         setosa versicolor virginica<br>  setosa         10          0         0<br>  versicolor      0          9         1<br>  virginica       0          1         9</pre>
<pre id="4068" class="graf graf--pre graf-after--pre"># Notem que as predicoes foram bastante parecidas, com apenas dois erros<br># Usando classAgreement do proprio pacote e1071<br># Calculamos:<br># Percentual de acertos e Kappa (leva em conta acertos aleatorios)</pre>
<pre id="868b" class="graf graf--pre graf-after--pre"># Index de Rand e seu valor corrigido para acertos aleat&#xF3;rios.<br>&gt;classAgreement(agree.tab)<br>$diag<br>[1] 0.9333333<br>$kappa<br>[1] 0.9<br>$rand<br>[1] 0.9172414<br>$crand<br>[1] 0.8066667</pre>
<p id="b887" class="graf graf--p graf-after--pre">
Notem que os valores foram bons. Classificamos corretamente ~93% das
espécies com base em medidas das pétalas e sépalas em nossa amostra de
teste.
</p>
<p id="4868" class="graf graf--p graf-after--p">
Fica uma dúvida. Na hora de ajustar o SVM, escolhemos o parâmetro
<em class="markup--em markup--p-em">cost. O
</em>parâmetro<em class="markup--em markup--p-em"> cost </em>é um valor
associado a Regularização dos pesos durante o treinamento (Constante C
na formulação de Lagrange).
<a href="http://stats.stackexchange.com/questions/31066/what-is-the-influence-of-c-in-svms-with-linear-kernel" class="markup--anchor markup--p-anchor">Ele
reflete o quanto queremos evitar classificar exemplos de forma
errada</a>. Um valor pequeno vai priorizar margens maiores, mesmo que
isso implique mais classificações erradas. Um C maior vai resultar num
ajuste classificação correta para outliers, ainda que com margens
menores.
</p>
<figure id="a550" class="graf graf--figure graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/0*0Wl_lkR62aen55y3.jpg">
<figcaption class="imageCaption">
C maior (margens menores) vs. C Menor (margens maiores)
</figcaption>
</figure>
<p id="938c" class="graf graf--p graf-after--figure">
Os melhores valores para o hiperparâmetro C dependem da estrutura do
seus dados.
</p>
<p id="33a4" class="graf graf--p graf-after--p">
Os autores do libsvm sugerem testar valores de C através de
<em class="markup--em markup--p-em">cross-validation. </em>Em nosso
dataset, mudar os valores de cost de 100 para 1, 10 ou 1000 gera algumas
mudanças. Custos 100 e 1000 erraram menos.
</p>
<pre id="9a4e" class="graf graf--pre graf-after--p">&gt;svm.iris1 &lt;- svm(Species ~ .,data=iris.tr,cost=1,kernel=&quot;linear&quot;)</pre>
<pre id="a747" class="graf graf--pre graf-after--pre">&gt;svm.iris10 &lt;- svm(Species ~ .,data=iris.tr,cost=10,kernel=&quot;linear&quot;)</pre>
<pre id="68e5" class="graf graf--pre graf-after--pre">&gt;svm.iris1000 &lt;- svm(Species ~ .,data=iris.tr,cost=1000,kernel=&quot;linear&quot;)</pre>
<pre id="0b76" class="graf graf--pre graf-after--pre">#Repetir processo de predicao e avaliacao com predict,table e classAgreement como antes para cada modelo. Fica a cargo de voces ;)</pre>
<p id="4dc7" class="graf graf--p graf-after--pre">
Outra maneira é usar uma função embutida no e1071(tune.svm), que já faz
uso do dataset inteiro com 10-<em class="markup--em markup--p-em">fold
cross validation</em>. O mesmo usado pela equipe do
<a href="https://got.show/" class="markup--anchor markup--p-anchor">A
Song of Ice and Data</a>. Essa alternativa (tune.svm) costuma trazer
melhores resultados segundo os autores do e1071.
</p>
<pre id="f230" class="graf graf--pre graf-after--p">#Ajustando valores testaveis de entre 1 e 1024<br>&gt;tune.info &lt;- tune.svm(Species~., data = iris, cost = 2^(0:10),kernel=&quot;linear&quot;)<br><br></pre>
<pre id="2eb8" class="graf graf--pre graf-after--pre">#Sumario do tuning atraves de 10-fold-cross-validation<br>&gt;summary(tune.info)</pre>
<pre id="5e26" class="graf graf--pre graf-after--pre">Parameter tuning of &#x2018;svm&#x2019;:</pre>
<pre id="07e7" class="graf graf--pre graf-after--pre">- sampling method: 10-fold cross validation </pre>
<pre id="2e66" class="graf graf--pre graf-after--pre">- best parameters:<br> cost<br>  128</pre>
<pre id="a27b" class="graf graf--pre graf-after--pre">- best performance: 0.02 </pre>
<pre id="8302" class="graf graf--pre graf-after--pre">- Detailed performance results:<br>   cost      error dispersion<br>1     1 0.04666667 0.04499657<br>2     2 0.04000000 0.04661373<br>3     4 0.04000000 0.04661373<br>4     8 0.04000000 0.04661373<br>5    16 0.04000000 0.04661373<br>6    32 0.04000000 0.04661373<br>7    64 0.04000000 0.04661373<br>8   128 0.02000000 0.03220306<br>9   256 0.03333333 0.05665577<br>10  512 0.02666667 0.04661373<br>11 1024 0.03333333 0.06478835</pre>
<pre id="c739" class="graf graf--pre graf-after--pre">&gt;plot(tune.info)</pre>
<figure id="76ab" class="graf graf--figure graf-after--pre">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/1*tqAsRPceIFBc-XQXGrICcg.png">
</figure>
<p id="7131" class="graf graf--p graf-after--figure">
O tune.svm retornou, entre os valores, que os melhores parâmetros são
cost = 128. Pelo gráfico, ainda é possível detectar zonas mais propícias
e testar valores no intervalo. Podemos estabelecer esses parâmetros
manualmente.
</p>
<pre id="0e84" class="graf graf--pre graf-after--p">&gt;svm.opt &lt;- svm(Species ~ .,data=iris.tr,cost=128,kernel=&quot;linear&quot;)</pre>
<p id="92bd" class="graf graf--p graf-after--pre">
Ou invocar o objeto com
$best.model (&lt;em class="markup--em markup--p-em"&gt;names(tune.info)&lt;/em&gt; para outros valores e objetos):&lt;/p&gt;&lt;pre id="8205" class="graf graf--pre graf-after--p"&gt;\#Invocando melhor modelo. &lt;br&gt;&gt;tune.info$best.model
</pre>
<pre id="9fda" class="graf graf--pre graf-after--pre">Call:<br>best.svm(x = Species ~ ., data = iris, cost = (2^(0:10)), kernel = &quot;linear&quot;)<br><br><br>Parameters:<br>   SVM-Type:  C-classification <br> SVM-Kernel:  linear <br>       cost:  128 <br>      gamma:  0.25 <br><br>Number of Support Vectors:  15</pre>
<pre id="275c" class="graf graf--pre graf-after--pre">#Fazendo predicoes<br>&gt;tune.pred &lt;- predict(tune.info$best.model,iris)<br>&gt;tune.pred &lt;- predict(tune.info$best.model,iris)</pre>
<pre id="ef4a" class="graf graf--pre graf-after--pre">#Tabela de classificacoes predicoes vs. observacoes<br>&gt;agree.tune &lt;- table(pred = tune.pred,true=iris$Species)<br>&gt;agree.tune<br>            true<br>pred         setosa versicolor virginica<br>  setosa         50          0         0<br>  versicolor      0         48         1<br>  virginica       0          2        49</pre>
<pre id="c96f" class="graf graf--pre graf-after--pre">#Observando concordancia das predicoes e observacoes<br>&gt;classAgreement(agree.tune)<br>$diag<br>[1] 0.98<br>$kappa<br>[1] 0.97<br>$rand<br>[1] 0.9739597<br>$crand<br>[1] 0.9410123</pre>
<p id="72c0" class="graf graf--p graf-after--pre">
Está implementado nosso classificador de espécies com base no
comprimento e largura de sépalas e pétalas. Agora, um biólogo em dúvida
sobre a espécie de uma nova amostra pode usar nosso programa para
classificar a planta usando suas medidas.
</p>
<p id="0097" class="graf graf--p graf-after--p">
A mesma lógica serve para uso de SVM em outras áreas, como classificação
de imagens e classificação de risco de créditos em instituições
finaneiras.
</p>
<p id="7b30" class="graf graf--p graf-after--h4">
Algumas observações:
</p>
<ul class="postList">
<li id="6f2b" class="graf graf--li graf-after--p">
Alguns devem ter notado que o modelo ajustado pelo
<em class="markup--em markup--li-em">tune </em>tem um parâmetro
<em class="markup--em markup--li-em">gamma </em>além do parâmetro C.
Normalmente, o parâmetro <em class="markup--em markup--li-em">gamma
</em>pertence a outros kernels
(<a href="https://cran.r-project.org/web/packages/e1071/e1071.pdf" class="markup--anchor markup--li-anchor">e1071</a>,
pag.50). Mudar o parâmetro <em class="markup--em markup--li-em">gamma
</em>não altera o desempenho de uma SVM com kernel linear. Imagino que
seja um artefato da função <em class="markup--em markup--li-em">tune
</em>por lidar com diversos kernels.
</li>
<li id="6a2d" class="graf graf--li graf-after--li">
O paper a seguir sugere um caminho para implementação de SVMs para
iniciantes (fazer Scaling dos dados sempre e dar preferência ao Kernel
RBF).
<a href="https://www.csie.ntu.edu.tw/~cjlin/papers/guide/guide.pdf" class="markup--anchor markup--li-anchor">A
Practical Guide to Support Vector Classification</a>. Chih-Wei Hsu,
Chih-Chung Chang, and Chih-Jen Lin. XXX XXX
</li>
</ul>
<p id="58b0" class="graf graf--p graf-after--h4">
Finalizamos nossa Parte 2.
</p>
<p id="11a4" class="graf graf--p graf-after--p">
Durante o processo, aprendemos sobre o funcionamento de
<em class="markup--em markup--p-em">Support Vector Machines com R </em>e
passamos por alguns conceitos importantes para
<em class="markup--em markup--p-em">Machine Learning.</em>
</p>
<p id="bd7e" class="graf graf--p graf-after--p">
Dúvidas? Opiniões? Comente. A resposta costuma ser rápida.
</p>
<p id="c19d" class="graf graf--p graf-after--p">
<strong class="markup--strong markup--p-strong">Você pode</strong>
distribuir, alterar ou complementar esse texto, desde que o referencie e
que o faça de forma não comercial.
</p>
<p id="0540" class="graf graf--p graf-after--h4">
<a href="https://www.csie.ntu.edu.tw/~cjlin/papers/guide/guide.pdf" class="markup--anchor markup--p-anchor">Chih-Wei
Hsu, Chih-Chung Chang, and Chih-Jen Lin. A Practical Guide to Support
Vector Classification</a>.
</p>
<p id="13fe" class="graf graf--p graf-after--p">
Karatzoglou et al. Support Vector Machines in R.
<em class="markup--em markup--p-em">Journal of Statistical Software.
</em>April 2006, Volume 15, Issue 9.
</p>
<p id="b099" class="graf graf--p graf-after--p">
<a href="http://cs231n.github.io/" class="markup--anchor markup--p-anchor">CS231n — Stanford
University: Convolutional Neural Networks for Visual Recognition</a>
</p>
<p id="1d82" class="graf graf--p graf-after--p graf--trailing">
Documentação dos pacotes
<a href="https://cran.r-project.org/web/packages/e1071/index.html" class="markup--anchor markup--p-anchor">e1071</a>
e
<a href="https://cran.r-project.org/web/packages/caret/index.html" class="markup--anchor markup--p-anchor">caret</a>
do R.
</p>
</div>
</div>
</div>
</div>

