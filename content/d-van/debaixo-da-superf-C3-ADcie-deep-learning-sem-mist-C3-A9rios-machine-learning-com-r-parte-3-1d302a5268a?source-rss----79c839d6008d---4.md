+++
title = "Debaixo da superfície: deep learning sem mistérios. Machine Learning com R — Parte 3"
date = "2017-10-11 23:25:32"
categories = ["d-van"]
original_url = "https://d-van.org/debaixo-da-superf%C3%ADcie-deep-learning-sem-mist%C3%A9rios-machine-learning-com-r-parte-3-1d302a5268a?source=rss----79c839d6008d---4"
+++

<p id="0f1c" class="graf graf--p graf-after--h3">
Nos textos anteriores (1ª
parte — <a href="https://d-van.org/predizendo-as-mortes-do-game-of-thrones-introdu%C3%A7%C3%A3o-a-machine-learning-com-r-parte-1-19c09a93f8a3" class="markup--anchor markup--p-anchor">link</a>),
mostramos o funcionamento de um classificador simples e usamos
(<a href="https://d-van.org/conhecendo-os-pacotes-populares-introdu%C3%A7%C3%A3o-a-machine-learning-com-r-parte-2-8bff273fbb76" class="markup--anchor markup--p-anchor">link</a>)
um pacote popular para ilustrar a configuração, treinamento e avaliação
do modelo (Support Vector Machine).
</p>
<p id="8499" class="graf graf--p graf-after--p">
Um mal entendido envolvendo<em class="markup--em markup--p-em"> deep
learning</em> é de que produzimos uma caixa preta, útil porém
inacessível. Vamos entender como funcionam redes profundas e de onde
surge essa confusão.
</p>
<figure id="b1cb" class="graf graf--figure graf-after--h4">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/1*uz0Y8_dNGXxh1En_QqwZHA.png">
<figcaption class="imageCaption">
Exemplo de “1” em letra cursiva e sua representação numa matriz 2x2.
<a href="http://colah.github.io/posts/2014-10-Visualizing-MNIST/" class="markup--anchor markup--figure-anchor">http://colah.github.io/posts/2014-10-Visualizing-MNIST/</a>
</figcaption>
</figure>
<p id="e48e" class="graf graf--p graf-after--figure">
Podemos representar imagens usando matrizes, como na figura acima. O
monitor lê cada número e ativa o ponto brilhante correspondente na tela,
criando a ilusão de imagens e filmes.
</p>
<p id="0fdb" class="graf graf--p graf-after--p">
Implementamos um classificador simples
(<em class="markup--em markup--p-em">Support Vector Machine</em>, SVM),
que lê uma imagem, como o 1 acima, na forma de matriz. Usando uma função
(<em class="markup--em markup--p-em">kernel function</em>), que aceita
esse input e considera pesos internos (w), gerando scores empregados nas
predições.
</p>
<figure id="12cf" class="graf graf--figure graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/1*GFQr27jiqY0jtxpGKdsZTQ.png">
</figure>
<p id="4234" class="graf graf--p graf-after--figure">
Esse kernel pode ser simples, com apenas combinações lineares, ou mais
complexo, com outras funções
<a href="https://en.wikipedia.org/wiki/Radial_basis_function_kernel" class="markup--anchor markup--p-anchor">(e.g.
RBF)</a>.
</p>
<p id="6fe8" class="graf graf--p graf-after--h3">
Com o aprendizado através de exemplos, otimizamos otimizamos nosso
classificador (mudando pesos W) para minimizar a perda, erro, usando
aproximações(e.g:
<a href="https://xcorr.net/2014/01/23/adagrad-eliminating-learning-rates-in-stochastic-gradient-descent/" class="markup--anchor markup--p-anchor">Adagrad</a>).
A função de perda é menor quando temos pontuações (votos) maiores para
as classes certas.
</p>
<p id="da71" class="graf graf--p graf-after--p">
SVMs têm bom desempenho em diversas estruturas de dados, especialmente
quando a arquitetura é otimizada por um usuário experiente. Onde entram
as redes neurais?
</p>
<figure id="01a9" class="graf graf--figure graf-after--p">
<img class="graf-image" alt="Image result for signal vs noise beautiful" src="https://cdn-images-1.medium.com/max/1600/1*bpxmMpSKLs86DZWiP-_mnw@2x.png">
</figure>
<p id="479f" class="graf graf--p graf-after--h3">
As versões reais da maioria dos conceitos criados por seres humanos não
são idênticas umas às outras. Em outras palavras, não existe um conjunto
rígido de regras para classificarmos a maior parte das entidades ao
nosso redor.
</p>
<p id="bce5" class="graf graf--p graf-after--p">
Muitas entidades são diferentes, porém similares o suficiente para
pertencer a uma mesma categoria.
</p>
<figure id="e2ad" class="graf graf--figure graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/0*OBb0FiADapopd5HG.jpg">
<figcaption class="imageCaption">
Todos são naturalmente reconhecidos como felinos, mas apresentam
variações de tamanho, cor e proporção em todo o corpo.
<a href="http://voices.nationalgeographic.org/files/2015/12/Wild-Cat-Species.jpg" class="markup--anchor markup--figure-anchor">http://voices.nationalgeographic.org/files/2015/12/Wild-Cat-Species.jpg</a>
</figcaption>
</figure>
<p id="43ee" class="graf graf--p graf-after--figure">
Esse é um problema interessante e antigo. Alguns filósofos acreditam que
abstrações humanas são instâncias de um conceito mais genérico: mapas
biológicos contidos em redes neuronais (Paul
Churchland<a href="https://mitpress.mit.edu/books/platos-camera" class="markup--anchor markup--p-anchor">,
Plato’s Camera</a>).
</p>
<p id="f56d" class="graf graf--p graf-after--p">
Esses mapas estão associados de forma hierarquizada. Numerosos padrões
em níveis inferiores e um número menor em camadas superiores.
</p>
<p id="02f4" class="graf graf--p graf-after--p">
No caso da visão, neurônios superficiais captam pontos luminosos. O
padrão de ativação sensorial enviado ao córtex visual primário é o
primeiro mapa, que é torcido e filtrado caminho cima.
</p>
<figure id="9894" class="graf graf--figure graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/0*VIuKhQ0U03EfnpUo.">
<figcaption class="imageCaption">
<em class="markup--em markup--figure-em">Resposta a estímulos visuais em
V1 de Macaca fascicularis
</em><a href="http://www.jneurosci.org/content/32/40/13971" class="markup--anchor markup--figure-anchor">http://www.jneurosci.org/content/32/40/13971</a>
</figcaption>
</figure>
<p id="4633" class="graf graf--p graf-after--figure">
Neurônios intermediários possuem configurações que identificam
características simples: olhos e subcomponentes da face. Por fim, temos
camadas mais
<strong class="markup--strong markup--p-strong"><em class="markup--em markup--p-em">profundas,
</em></strong>ligadas a abstrações.
</p>
<figure id="f379" class="graf graf--figure graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/1*C17gQkpeUaym_NbiAKsheA.png">
<figcaption class="imageCaption">
Retirado de:
<a href="https://www.youtube.com/watch?v=SeyIg6ArS4Y" class="markup--anchor markup--figure-anchor">https://www.youtube.com/watch?v=SeyIg6ArS4Y</a>
</figcaption>
</figure>
<p id="5bc3" class="graf graf--p graf-after--h3">
Um classificador deve capturar essa estrutura abstrata a partir de
modelos matemáticos tratáveis. Para examinarmos esse aspecto, usemos um
exemplo. O gráfico abaixo representa milhares de amostras com: (1) a
curva diária natural de um hormônio (em vermelho) e a curva sob uso de
esteroides anabolizantes (azul).
</p>
<figure id="2f23" class="graf graf--figure graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/1*hEzMB4MaAviB5MHkAr0-vw.png">
<figcaption class="imageCaption">
Exemplo inspirado no texto de Chris Olah
(<a href="http://colah.github.io/posts/2014-03-NN-Manifolds-Topology/" class="markup--anchor markup--figure-anchor">http://colah.github.io/posts/2014-03-NN-Manifolds-Topology/</a>)
</figcaption>
</figure>
<p id="8622" class="graf graf--p graf-after--figure">
Como hipotéticos membros de uma comitê atlético, nosso objetivo aqui é,
dada uma amostra, saber se o atleta está sob efeito de esteroides.
</p>
<p id="f051" class="graf graf--p graf-after--p">
Quando experimentamos, normalmente haverá ruídos (erros) na medida e
receberemos medições imprecisas da curva. Variações na dieta daquele
dia, micções, sudorese, stress e outros fatores.
</p>
<p id="1f88" class="graf graf--p graf-after--p">
Usamos <strong class="markup--strong markup--p-strong">o tempo (t,
</strong>eixo horizontal) e nível hormonal
(<strong class="markup--strong markup--p-strong">β, </strong>eixo
vertical). <br>Numa regressão logística simples, fazemos essa
classificação com base nas probabilidades de uma função sigmoide. Temos
uma probabilidade (valor entre 0 e 1).
</p>
<p id="2826" class="graf graf--p graf-after--p">
P(h,β) = 1/(1+exp-(i+t*h+β*y+ε)).<br>ε representa o erro e i é uma
constante. Em uma linha do R:
</p>
<pre id="0dc1" class="graf graf--pre graf-after--p">logist.fit &lt;- glm(type_dic ~ beta + tempo,               family=binomial,data=inv.ds)<br># Criei 1000 time-points ao longo do dia.</pre>
<p id="f794" class="graf graf--p graf-after--pre">
A vantagem de usar essa modelagem é que temos uma relação direta entre o
inverso dessa função (P^(-1), “logito”) e a combinação linear dos nossos
parâmetros:<br><strong class="markup--strong markup--p-strong">logit
(P(x))=i+t*x+β*y+ε</strong>
</p>
<p id="c378" class="graf graf--p graf-after--p">
Em outras palavras, o processo de estimação é parecido com o da
regressão linear, que é facilmente tratável. Outra consequência é que
assumimos que a distinção entre classes
(<em class="markup--em markup--p-em">com base no logito, log odds</em>)
pode ser dada por um limite. Este tem uma relação linear com nossas
variáveis. Estimamos a magnitude e o sentido dessas relações pelos
parâmetros da regressão.
</p>
<figure id="35c3" class="graf graf--figure graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/1*-yWax6CWeQBKpVVFshk89g.png">
<figcaption class="imageCaption">
Podemos imaginar que o log odds (z, eixo vertical) cresce linearmente
com uma combinação de duas variaveis (x e y). Notem que a superfície
definida pelo nossa equação/modelo é um plano. z = 3 + 3x + 2y. Plotado
no Wolfram Alpha
</figcaption>
</figure>
<p id="5ab3" class="graf graf--p graf-after--figure">
Estimamos qual seria a posição na reta dada por aquela medida e usamos
um limite de decisão (<em class="markup--em markup--p-em">decision
boundary) </em>linear. Voltando ao nosso exemplo, seria difícil capturar
as diferenças usando apenas esta estratégia.
</p>
<figure id="d9ed" class="graf graf--figure graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/0*pqQRrIXlsUTY6upr.png">
<figcaption class="imageCaption">
Acima, um neurônio sigmoide, que equivale à regressão logística. É como
o plano anterior, mas visto de cima, dividimos ele em duas regiões para
classficação.
<a href="http://colah.github.io/posts/2015-01-Visualizing-Representations/" class="markup--anchor markup--figure-anchor">http://colah.github.io/posts/2015-01-Visualizing-Representations/</a>
</figcaption>
</figure>
<p id="18ba" class="graf graf--p graf-after--figure">
Por que? O classificador linear otimiza suas respostas levando em conta
apenas o valor absoluto da medida hormonal. Isto é, valores acima de um
limite serão considerados dopping, não considerando horário.
Matematicamente, o coeficiente para o tempo foi ajustado em 0. Mudar
isso tornaria a reta divisória inclinada em relação ao eixo x, piorando
a classificação.
</p>
<p id="dc41" class="graf graf--p graf-after--p">
Podemos verificar isso diretamente através dos parâmetros estimados em
nosso modelo de regressão.
</p>
<pre id="ce5f" class="graf graf--pre graf-after--p">&gt; summary(logist.fit)</pre>
<pre id="f9c9" class="graf graf--pre graf-after--pre">Call:  glm(formula = type_dic ~ beta + tempo, family = binomial, data = inv.ds)</pre>
<pre id="6210" class="graf graf--pre graf-after--pre">Coefficients:<br>  (Intercept)     beta        <strong class="markup--strong markup--pre-strong">tempo </strong> <br>-0.8752803   -3.6195723   <strong class="markup--strong markup--pre-strong">-0.0001221 # Pr&#xF3;ximo a zero</strong></pre>
<pre id="f7df" class="graf graf--pre graf-after--pre">Degrees of Freedom: 999 Total (i.e. Null);  997 Residual<br>Null Deviance:     1386 <br>Residual Deviance: 774.4  AIC: 780.4<br>&gt; prob=predict(logist.fit,type=c(&quot;response&quot;))<br>&gt; inv.ds$prob=prob<br>&gt; curve &lt;- roc(type_dic ~ prob, data = inv.ds)<br>&gt; curve<br><br>Call:<br>  roc.formula(formula = type_dic ~ prob, data = inv.ds)</pre>
<pre id="c17b" class="graf graf--pre graf-after--pre">Data: prob in 500 controls (type_dic 0) &lt; 500 cases (type_dic 1).<br>Area under the curve: 0.8767</pre>
<p id="2240" class="graf graf--p graf-after--h3">
A solução é introduzir termos polinomiais de grau mais alto (x²,x³…),
interações ou usar funções mais complexas. Aí corremos o risco de
realizar <strong class="markup--strong markup--p-strong">sobre
ajuste</strong>. Deixar o sinal dos confundir e fazer um modelo complexo
que não funciona em novos exemplos.
</p>
<p id="d0c5" class="graf graf--p graf-after--p">
<strong class="markup--strong markup--p-strong">E o que acontece se
conectarmos classificadores simples hierarquicamente?</strong>
</p>
<p id="4e0b" class="graf graf--p graf-after--p">
A resposta de uma unidade é usada como a entrada de outras. Quando
processamos o sinal em etapas, cada camada modifica os dados para as
camadas posteriores, transformando e filtrando/dando forma.
</p>
<p id="31e7" class="graf graf--p graf-after--p">
As camadas intermediárias permitem a transformação gradual do sinal, e o
sistema acerta usando apenas dois classificadores simples
(<a href="https://en.wikipedia.org/wiki/Sigmoid_function" class="markup--anchor markup--p-anchor">sigmoides</a>).
No exemplo acima, temos uma camada de 2 neurônios entre o input e o
output.
</p>
<figure id="338d" class="graf graf--figure graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/0*bmzRtQU8C4BmBTLC.png">
<figcaption class="imageCaption">
<a href="http://colah.github.io/posts/2015-01-Visualizing-Representations/" class="markup--anchor markup--figure-anchor">http://colah.github.io/posts/2015-01-Visualizing-Representations/</a>
</figcaption>
</figure>
<p id="2d32" class="graf graf--p graf-after--figure">
Agora, a primeira camada (hidden) modifica a entrada com duas unidades
sigmoides e a segunda camada pode classificar corretamente usando apenas
uma reta, algo que era impossível antes.
</p>
<p id="c120" class="graf graf--p graf-after--p">
Em tese, esse modelo pode capturar melhor as características que geraram
os dados (flutuação hormonal ao longo do dia).
</p>
<p id="0c8f" class="graf graf--p graf-after--h3">
Notem que o diagrama acima lembra uma rede neural. Esse tipo de
classificador foi inspirado na organização microscópica de neurônios
reais e acredita-se que seu funcionamento seja de alguma forma análogo.
A arquitetura de redes convolucionais
(<em class="markup--em markup--p-em">convolutional neural
networks</em>), estado da arte em reconhecimento de imagens, foi
inspirada no
<a href="https://www.ncbi.nlm.nih.gov/pmc/articles/PMC1557912/" class="markup--anchor markup--p-anchor">córtex
visual de mamíferos</a>.
</p>
<p id="63d2" class="graf graf--p graf-after--p">
Outros modelos bio inspirados (Spiking neural networks, LTSMs…)
apresentam desempenhos inéditos para tarefas complexas e pouco
estruturadas, como reconhecimento de voz e tradução de textos.
</p>
<p id="d422" class="graf graf--p graf-after--p">
A teoria mais aceita é de que o maquinário neural dos animais foi
desenhado por processos evolutivos, como a seleção natural. Assim,
apresenta coloridas formas de complexidade a depender da tarefa
desempenhada.
</p>
<figure id="c9a1" class="graf graf--figure graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/1*hWYpsxWOj9IdpLQeaUOE8w.png">
<figcaption class="imageCaption">
Como podemos ver, as redes biológicas são complexas, com até dezenas de
bilhões de unidades de processamento paralelas conectadas. Zona
destacada possui grafo isomorfo ao descrito no texto. Modificado de
<a href="http://www.rzagabe.com/2014/11/03/an-introduction-to-artificial-neural-networks.html" class="markup--anchor markup--figure-anchor">http://www.rzagabe.com/2014/11/03/an-introduction-to-artificial-neural-networks.html</a>
</figcaption>
</figure>
<p id="cf58" class="graf graf--p graf-after--figure">
Nos modelos profundos
(<strong class="markup--strong markup--p-strong">deep</strong>) de
reconhecimento de rosto, neurônios de camadas superficiais capturam
bordas, ângulos e vértices, camadas intermediárias detectam presença de
olhos, boca, nariz. Por fim, camadas ao final da arquitetura decidem se
é um rosto ou não e a quem ele pertence.
</p>
<p id="114b" class="graf graf--p graf-after--h3">
Podemos demonstrar formalmente que uma rede neural com apenas uma camada
interna é capaz de aproximar
<strong class="markup--strong markup--p-strong">qualquer
</strong>função. A
<a href="http://neuralnetworksanddeeplearning.com/chap4.html" class="markup--anchor markup--p-anchor">prova
</a>não é lá essas coisas, já que, no fundo o que fazemos é criar uma
tabela de consulta (lookup table) para os valores de entrada e saída
usando os neurônios.
</p>
<p id="abf5" class="graf graf--p graf-after--p">
Na prática, é difícil obter boas performances. Tão difícil que redes
neurais passaram décadas esquecidas. Se você rodar o modelo abaixo,
baseado no nosso exemplo, verá que a acurácia é próxima da regressão
logística. É necessário algum conhecimento e tempo para afinar os
detalhes.
</p>
<p id="bf06" class="graf graf--p graf-after--p">
Normalmente, depende da qualidade e da quantidade dos dados.
</p>
<pre id="0146" class="graf graf--pre graf-after--p"># Neural Net para o exemplo<br>library(deepnet)<br>inv.ds$tempo.norm &lt;- normalize(inv.ds$tempo)</pre>
<pre id="9cfe" class="graf graf--pre graf-after--pre">deep.log.dbn &lt;- dbn.dnn.train(<br>  x=as.matrix(inv.ds[,c(&quot;beta&quot;,&quot;tempo.norm&quot;)]),<br>  y=as.numeric(as.character(inv.ds$type_dic)),<br>  hidden = c(2), activationfun = &quot;sigm&quot;,<br>  learningrate=2.65, momentum=0.85, learningrate_scale=1,<br>  output = &quot;sigm&quot;, numepochs=3, batchsize= 11)</pre>
<p id="02bc" class="graf graf--p graf-after--pre">
As redes neurais passaram algum tempo esquecidas, até que
<a href="http://people.idsia.ch/~juergen/who-invented-backpropagation.html" class="markup--anchor markup--p-anchor">algumas
reviravoltas</a> ¹ permitiram o treinamento eficaz delas redes.
Algoritmos para melhorar o treinamento, assim como arquiteturas
econômicas ou especialmente boas em determinadas tarefas.
</p>
<p id="7c69" class="graf graf--p graf-after--p">
Além disso, o uso de processadores gráficos (GPU), desenhados para as
operações de álgebra linear que discutimos (com matrizes) permitiu
treinar em um volume maior de dados.
</p>
<p id="0591" class="graf graf--p graf-after--h3">
Uma vez que o texto é sobre
<strong class="markup--strong markup--p-strong"><em class="markup--em markup--p-em">deep
leaning,
</em></strong>precisamos<strong class="markup--strong markup--p-strong">
</strong>falar de
<em class="markup--em markup--p-em">backpropagation </em>.
</p>
<p id="6b91" class="graf graf--p graf-after--p">
Como vimos nas partes 1 e 2, o treinamento consiste em ajustar os pesos
W do classificador (SVM) para minimizar a função que calcula nosso erro
E.
</p>
<p id="cbe8" class="graf graf--p graf-after--p">
Como alguém de olhos vendados em uma ladeira, podemos dar um passo e
saber medir qual o efeito sobre a nossa altura
<em class="markup--em markup--p-em">(subimos ou descemos, + ou -</em>),
assim como a intensidade
<em class="markup--em markup--p-em">(</em>magnitude numérica: 50cm ou 70
cm<em class="markup--em markup--p-em">)</em>. A partir daí, definimos
uma regra para movimentação.
</p>
<figure id="b8fa" class="graf graf--figure graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/0*pjKOpe1SAyZeG_wf.">
</figure>
<p id="d4bf" class="graf graf--p graf-after--figure">
Quando treinamos um único nodo (SVM), o nosso trabalho é como o de um
cego tateando até descer ao lugar mais baixo. É possível seguir o
caminho aos poucos. Com redes profundas, a entrada de um nodo depende da
saída dos que se conectam a ele. O sistema é um pouco mais complexo.
</p>
<p id="db2b" class="graf graf--p graf-after--p">
Vamos usar <strong class="markup--strong markup--p-strong">derivadas.
</strong>Ou seu equivalente para funções de múltiplas variáveis,
<strong class="markup--strong markup--p-strong">gradiente</strong>. O
gradiente é um vetor/lista com as derivadas parciais daquela função.
</p>
<p id="9e68" class="graf graf--p graf-after--p">
Matematicamente, queremos a derivada parcial da função de custo (f) com
respeito às entradas. Como vimos, podemos encarar a rede neural como uma
sequência de funções plugadas. Se o primeiro nó tem q(x,y), o segundo,
f, tem valor f(q(x,y) ou <em class="markup--em markup--p-em">f</em> o
<em class="markup--em markup--p-em">q.</em>
</p>
<p id="0315" class="graf graf--p graf-after--p">
q(x,y) = 3x+2y \#camada inferior<br>f(z) = z² \#camada superior
</p>
<p id="67b9" class="graf graf--p graf-after--p">
f(q(x,y)) = q² = (3x+2y)² \# input inferior para superior
</p>
<p id="5743" class="graf graf--p graf-after--p">
Podemos calcular o efeito de mudanças inter nodos com
<strong class="markup--strong markup--p-strong">a regra de cadeia
</strong>funções compostas. Isto é, podemos obter o gradiente de erro no
nodo de hierarquia mais alta (f), com respeito a uma das variáveis de
entrada (x) na hierarquia mais baixa. A operação é computacionalmente
barata, bastando multiplicar as derivadas parciais dos erros em cada
parte.
</p>
<figure id="49a6" class="graf graf--figure graf-after--p">
<img class="graf-image" src="https://cdn-images-1.medium.com/max/1600/1*Coy5kJUZlg7JY3G5Gzs4eA.png">
</figure>
<p id="4685" class="graf graf--p graf-after--figure">
É possível calcular de forma recursiva, portanto local e paralela, ao
longo das camadas. Fazendo o mesmo acima para df/dy, teremos os valores
de \[df/dx ; df/dy\] que é precisamente nosso gradiente.
</p>
<pre id="f648" class="graf graf--pre graf-after--p"># Valor duplo (x,y) para inputs<br>x=1 <br>y=3</pre>
<pre id="643d" class="graf graf--pre graf-after--pre">q = 3*x + 2*y # primeira camada<br>f = q^2 # segunda camada</pre>
<pre id="766e" class="graf graf--pre graf-after--pre"># Backprop - Mudan&#xE7;as em hierarquia superior<br># dadas por entradas de camadas inferires<br>dfdq = 2*q # derivada de x&#xB2; ; varia&#xE7;&#xE3;o de f em fun&#xE7;&#xE3;o de q<br>dqdx = 3 # Derivada de 3x ; varia&#xE7;&#xE3;o de q em fun&#xE7;&#xE3;o de x<br>dqdy = 2 # Derivada de 2x ; varia&#xE7;&#xE3;o de q em fun&#xE7;&#xE3;o de y</pre>
<pre id="aa24" class="graf graf--pre graf-after--pre"># Obter gradiente de f(x,y) multiplicando as parciais <br>dfdx = dfdq*dqdx <br>dfdy = dfdq*dqdy<br>grad = c(dfdx,dfdy)<br>&gt; grad<br>[1] 24 16</pre>
<p id="798d" class="graf graf--p graf-after--pre">
Usando essa lógica, calculamos os gradientes para a função de erro e
treinamos o modelo.
</p>
<p id="4846" class="graf graf--p graf-after--h3">
Nos próximos episódios, vamos colocar a mão na massa em aplicações mais
realistas onde apenas algoritmos sofisticados de
<em class="markup--em markup--p-em">machine learning </em>conseguem bom
desempenho.
</p>
<p id="34c8" class="graf graf--p graf-after--p graf--trailing">
¹ Para uma história completa:
<a href="http://www.idsia.ch/~juergen/deep-learning-overview.html" class="markup--anchor markup--p-anchor">J.
Schmidhuber. Deep Learning in Neural Networks: An Overview.</a> Neural
Networks, 61, p 85–117, 2015. (Based on 2014 TR with 88 pages and 888
references, with PDF & LATEX source & complete public BIBTEX file).
</p>

