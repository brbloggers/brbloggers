+++
title = "Predizendo as mortes do Game of Thrones — Introdução a Machine Learning com R — Parte 1"
date = "2016-05-08 20:56:59"
categories = ["d-van"]
original_url = "https://d-van.org/predizendo-as-mortes-do-game-of-thrones-introdu%C3%A7%C3%A3o-a-machine-learning-com-r-parte-1-19c09a93f8a3?source=rss----79c839d6008d---4"
+++

<p id="f809" class="graf graf--p graf-after--h3">
Na semana passada, 28 de Abril, o atual CEO da Google
(<a href="https://en.wikipedia.org/wiki/Sundar_Pichai" class="markup--anchor markup--p-anchor">Sundar
Pichai</a>) publicou
<a href="https://googleblog.blogspot.com.br/2016/04/this-years-founders-letter.html" class="markup--anchor markup--p-anchor">uma
carta</a> no Google Blog mostrando sua visão de futuro e compartilhando
com acionistas e com o público sua visão da companhia. O termo
‘<em class="markup--em markup--p-em">machine learning</em>’ foi usado 8
vezes, inclusive como responsável pelas principais inovações recentes,
como Google Maps e Google Photos.
</p>
<blockquote id="50a3" class="graf graf--blockquote graf--startsWithDoubleQuote graf-after--p">
“(…) our long-term investment in machine learning and AI. (…) It’s what
has allowed us to build products that get better over time, making them
increasingly useful and helpful.” Sundar Pichai, CEO,Google, 2016
</blockquote>
<figure id="ce62" class="graf graf--figure graf--iframe graf-after--blockquote">
<iframe width="700" height="393" src="https://d-van.org/media/616d97de0fcf33cbad50ba64c1e80d89?postId=19c09a93f8a3" class>
</iframe>

<figcaption class="imageCaption">
AlphaGo: Monte-Carlo tree search, deep neural networks e reinforcement
learning jogando contra si
</figcaption>
</figure>
<p id="dfa9" class="graf graf--p graf-after--figure">
Em março, o Google DeepMind AlphaGo tornou-se o primeiro programa de
computador a vencer um mestre de Go. O feito é difícil por tratar-se de
um jogo quase impossível de ser totalmente computado. Existem
2,08\*10¹⁷⁰ maneiras válidas de dispor as peças no tabuleiro. Vale
lembrar que o número de átomos no universo observável é de módicos 10⁸⁰.
</p>
<p id="0c00" class="graf graf--p graf-after--p">
Inteligência artificial possui aplicações crescentes nas áreas de
finanças, saúde, indústria, aviação e segurança. Está tomando tanto
espaço que o longa-metragem
<a href="http://www.imdb.com/title/tt0470752/" class="markup--anchor markup--p-anchor">Ex
Machina</a>, cuja história gira em torno
do<a href="https://en.wikipedia.org/wiki/Turing_test" class="markup--anchor markup--p-anchor">
Teste de Turing</a> (e romance), ganhou um Oscar e
<a href="https://en.wikipedia.org/wiki/Ghost_in_the_Shell" class="markup--anchor markup--p-anchor"><em class="markup--em markup--p-em">Ghost
in the shell</em></a><em class="markup--em markup--p-em"> </em>vai ter
adaptação com Scarlett Johansson!
</p>
<figure id="0ad3" class="graf graf--figure graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/0*fN6MssfmhjZQeFm5.gif">
<figcaption class="imageCaption">
Major Motoko Kusanagi — Ghost in the Shell.
</figcaption>
</figure>
<p id="235b" class="graf graf--p graf-after--figure">
Seguindo a filosofia “construa para aprender”, vamos conhecer machine
learning implementando os princípios de um classificador linear
conhecido como Support Vector Machine (SVM) na famigerada
<a href="https://en.wikipedia.org/wiki/R_%28programming_language%29" class="markup--anchor markup--p-anchor">linguagem
R</a>. Apesar de simples, SVMs possuem aplicações reais. Por exemplo,
são o motor por trás do site
<a href="http://www.theguardian.com/tv-and-radio/video/2016/apr/21/a-song-of-ice-and-data-students-create-death-prediction-software-for-game-of-thrones-video" class="markup--anchor markup--p-anchor">“A
Song of Ice and Data”</a>, que recebeu atenção na mídia por fazer
predições sobre mortes na série Game of Thrones.
</p>
<p id="0054" class="graf graf--p graf-after--p graf--trailing">
Mostrarei a implementação dos componentes básicos e, na parte 2, a
aplicação prática com um pacote já desenvolvido .
<em class="markup--em markup--p-em">Machine learning </em>é um campo
intimamente ligado à estatística. É inevitável usarmos abstrações como
matrizes e funções. Tentei fazer um balanço entre rigor matemático e
simplificações para facilitar uma intuição dos objetos.
</p>

<p id="895a" class="graf graf--p graf-after--h4">
Se chamamos de inteligência artificial, ela precisa aprender a resolver
um problema. Comecemos com um problema de nosso cotidiano: classificar
imagens. Nossas redes neurais fazem isso o tempo inteiro quando a luz
atinge nossas retinas e sabemos que este é um navio:
</p>
<figure id="9eff" class="graf graf--figure graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/0*OebvofuoC-mz6Pra.jpg">
</figure>
<p id="f988" class="graf graf--p graf-after--figure">
Note que podemos mudar o ângulo da foto, as cores, o tamanho e outras
características e ainda assim saberemos que é um navio.
</p>
<figure id="bc29" class="graf graf--figure graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/0*F6S83lisVtOCLnmW.jpg">
</figure>
<p id="35c6" class="graf graf--p graf-after--figure">
As informações visuais são processadas e, olhando o conjunto,
classificamos o objeto em nossa frente.
<em class="markup--em markup--p-em">Machine learning</em> é necessário
para tarefas assim exatamente porque não é possível codificar todas as
características que a foto deve ter para retratar um navio. Elas são
abstratas.
</p>
<p id="39dc" class="graf graf--p graf-after--h4">
O campo de Machine Learning estuda entidades que aprendem sobre dados
sem uma programação explícita. Normalmente, o programa aprende com a
exposição a diversos exemplos e suas respectivas classificações
(<strong class="markup--strong markup--p-strong">aprendizado
supervisionado</strong>). Nesse caso, a aprendizado se dá usando a
resposta correta como guia para ajustar os parâmetros internos. Após a
exposição a muitos exemplos (muitas vezes, milhões) e respectivas
respostas corretas, o programa adquire capacidade de acertar a resposta
de exemplos inéditos. Encaixa-se nesse campo boa parte dos métodos mais
populares de regressão (linear, logística binomial, regressão de
Poisson…) e redes neurais.
</p>
<p id="58ef" class="graf graf--p graf-after--p">
Outra maneira
(<strong class="markup--strong markup--p-strong">aprendizado
não-supervisionado</strong>) é estimar a estrutura interna dos dados
mesmo sem informações sobre a classificações corretas, através da
análise de características em comum entre subgrupos de exemplos. Aqui
estão técnicas de <em class="markup--em markup--p-em">clustering (ex:
k-means) </em>e análise de componentes principais
(<em class="markup--em markup--p-em">PCA</em>).
</p>
<p id="858a" class="graf graf--p graf-after--h4">
Com o exemplo do navio, vimos que uma utilidade para algoritmos de
<em class="markup--em markup--p-em">machine learning</em> está na
classificação de fotos. Outros objetivos também podem ser atacados:
predição do preço médio de ações no mercado financeiro, probabilidade de
um paciente recém-admitido com dor torácica estar infartando,
temperatura esperada para os próximos dias.
</p>
<p id="d947" class="graf graf--p graf-after--p">
O preço médio de uma ação é um número positivo (Ex: 6,93 reais). A
probabilidade de infarto é um número entre 0 e 1 (Ex: 0,60 ou 60%). Como
a estrutura dos dados pode variar, assim como as dimensões de interesse,
usamos diferentes métodos mais ou menos complexos. Em nosso caso,
tratando-se de Support Vector Machines, vamos falar de classificadores:
cada exemplo <strong class="markup--strong markup--p-strong">x
</strong>(foto) tem uma classificação correta
<strong class="markup--strong markup--p-strong">K </strong>(navio).
Nosso classificador deve retornar o rótulo compatível com a resposta
correta a partir dos pixels contidos na foto.
</p>
<p id="1243" class="graf graf--p graf-after--h4">
Um tipos mais simples de classificador é o linear.
</p>
<figure id="afc3" class="graf graf--figure graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/0*frujx5GLAaYfh4_v.png">
<figcaption class="imageCaption">
Imaginemos que a imagem tenha 10 pixels de altura e 10 de largura.
</figcaption>
</figure>
<p id="19cf" class="graf graf--p graf-after--figure">
Para simplificação, supomos que a foto acima possua 10 x 10 pixels em
preto e branco (100 pixels com valores entre 0,preto, e 255, branco).
Esses pixels podem ser esticados e vistos como uma matriz
<strong class="markup--strong markup--p-strong">x</strong> de dimensão
\[100 x 1\] com valores entre 0 e 255 em cada elemento.
</p>
<p id="19aa" class="graf graf--p graf-after--p">
Podemos simular uma imagem deste tamanho gerando uma matriz de dimensão
10x10 com 100 valores naturais aleatórios (entre 0 e 255) no R :
</p>
<pre id="41b6" class="graf graf--pre graf-after--p">#Garante que os valores no exemplo serao iguais aos seus, enviesando o gerador de dados aleatorios<br>set.seed(2000)</pre>
<pre id="9e6e" class="graf graf--pre graf-after--pre">#Cria dados com 100 valores inteiros no intervalo [0,255] com reposicao<br>my.image.data &lt;- sample(0:255,100,replace=T)</pre>
<pre id="b287" class="graf graf--pre graf-after--pre">#Le como uma matrix [10x10]<br>x &lt;- matrix(my.image.data,10,10)</pre>
<figure id="eaf7" class="graf graf--figure graf-after--pre">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/1*R3G4i3Rte-ae2bIED4dP6Q.png">
<figcaption class="imageCaption">
Eis a nossa imagem \[10x10\]. O computador lê os valores entre 0 (preto)
e 255 (branco), dispondo para nós o sinal visual correspondente.
</figcaption>
</figure>
<p id="4cb6" class="graf graf--p graf-after--figure">
Vamos supor que nosso classificador recebe imagens de uma câmera noturna
no porto da cidade e que as imagens podem ser classificadas em 4(K)
tipos: navio, morcego, golfinho ou submarino.
</p>
<p id="be3e" class="graf graf--p graf-after--p">
O classificador linear atribui scores para cada uma das 4 classes
aplicando seus pesos em cada pixel da imagem.
</p>
<p id="eec5" class="graf graf--p graf-after--p">
Matematicamente, é uma multiplicação dessa matriz de valores de imagem
<strong class="markup--strong markup--p-strong">x </strong>\[100x1\]por
uma matriz <strong class="markup--strong markup--p-strong">W
</strong>\[100 X 4\]<strong class="markup--strong markup--p-strong">
</strong>que traz pesos (weights) estimados para cada pixel para os 4
scores. O resultado dessa multiplicação de matrizes são scores para cada
classe <strong class="markup--strong markup--p-strong">K</strong>.
</p>
<p id="d796" class="graf graf--p graf-after--p">
Vamos considerar que nossa ordem de rótulos é:<br>\[navio, morcego,
golfinho, submarino\]
</p>
<p id="9748" class="graf graf--p graf-after--p">
Em R:
</p>
<pre id="ad13" class="graf graf--pre graf-after--p">#Iniciando pesos com base em distribui&#xE7;&#xE3;o normal<br>#Dividi os valores por 100 para reduzir a magnitude dos numeros<br>my.weights &lt;- rnorm(400)/100</pre>
<pre id="9e9f" class="graf graf--pre graf-after--pre">#Le pesos como matriz [100x4]<br>w &lt;- matrix(my.weights,100,4)</pre>
<pre id="d38b" class="graf graf--pre graf-after--pre">#Multiplicacao usando o operador %*%<br>as.vector(x)%*%w</pre>
<pre id="2d9d" class="graf graf--pre graf-after--pre">#Resultado<br>          [,1]      [,2]      [,3]     [,4]<br>[1,] -0.4198168 -3.163685 -3.889999 19.54444</pre>
<p id="0c5c" class="graf graf--p graf-after--pre">
O classificador linear traz um valor de score para cada classe. A
interpretação desses valores pode variar, mas vamos pensar, por
enquanto, que nosso objetivo é que o maior score seja o da classe
correta.
</p>
<p id="180d" class="graf graf--p graf-after--p">
Em nosso exemplo:<br>\[-0.4198168, -3.163685, -3.889999, 19.54444\]
</p>
<p id="05cd" class="graf graf--p graf-after--p">
e lembrando que nossa ordem de classes é:<br>\[navio, morcego, golfinho,
submarino\]
</p>
<p id="bc77" class="graf graf--p graf-after--p">
Entre os valores, o maior entre os quatro foi o quarto (19.54444),
sugerindo o rótulo de submarino, que é errado.
</p>
<p id="8e79" class="graf graf--p graf-after--p">
O processo de aprendizado, consiste em expor o classificador a diversos
exemplos <strong class="markup--strong markup--p-strong">X</strong> até
que ele ajuste esses parâmetros
<strong class="markup--strong markup--p-strong">W</strong>, apontando a
classe <strong class="markup--strong markup--p-strong">K</strong>
correta(navio, 1º elemento da matriz) com o score maior .
</p>
<p id="a3e7" class="graf graf--p graf-after--p">
A imagem abaixo traz um diagrama dessa multiplicação.
</p>
<figure id="8bd7" class="graf graf--figure graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/0*DvcTwEW9rzJXL8PP.jpg">
<figcaption class="imageCaption">
Visitem o
<a href="http://cs231n.github.io/linear-classify/" class="markup--anchor markup--figure-anchor">http://cs231n.github.io/linear-classify/</a>
para mais detalhes. Essa imagem traz um diagrama do processamento dos
dados que resultam nos scores finais paras classes K: cat,dog,ship.
Nesse caso, a classificação seria cachorro (437.9)
</figcaption>
</figure>
<figure id="2b9d" class="graf graf--figure graf-after--figure">
<img class="graf-image" src="https://cdn-images-1.medium.com/max/1600/0*nT80vNdK15AjEYh_.png">
<figcaption class="imageCaption">
Nese caso, y indica os pesos (antes chamados de W nesse texto) e x^T a
matriz com dados do exemplo. O uso de transposição ou não depende da
forma escolhida para a matriz y (\[nx1\] ou \[1 x n\]).
</figcaption>
</figure>
<p id="fb1d" class="graf graf--p graf-after--figure">
Essa função é chamada <em class="markup--em markup--p-em">kernel
function </em>e, no em nosso caso, é linear.
</p>
<p id="be31" class="graf graf--p graf-after--p">
Para levar em conta uma constante
<strong class="markup--strong markup--p-strong">b, </strong>usaremos um
truque: ao adicionar o valor 1 ao final da imagem, a multiplicação dos
pesos associados será constante. Assim podemos incluir estimativas do
valor de <strong class="markup--strong markup--p-strong">b</strong> como
pesos em <strong class="markup--strong markup--p-strong">W</strong>,
que, quando multiplicados por 1, serão sempre as mesmas constantes.
</p>
<pre id="b1af" class="graf graf--pre graf-after--p">#Adiciona valor 1 ao vetor e armazena em x.vec. Agora temos 101 elementos<br>x.vec &lt;- c(as.vector(x),1)</pre>
<pre id="e683" class="graf graf--pre graf-after--pre">#Inicia pesos incluindo 4 valores extras para (uma constante para cada score)<br>my.weights&lt;- rnorm(404)/100</pre>
<pre id="3c32" class="graf graf--pre graf-after--pre">#Leitura como matriz w de dimensao 101x4<br>w &lt;- matrix(my.weights,101,4)</pre>
<pre id="fc0e" class="graf graf--pre graf-after--pre">#Multiplicacao: (pixels da imagem + 1)* (Pesos do classificador)<br>x.vec%*%w</pre>
<pre id="1f1b" class="graf graf--pre graf-after--pre">#Resultado<br>          [,1]      [,2]     [,3]     [,4]<br>[1,] -18.47206 -4.578708 15.71626 28.55935</pre>
<p id="6a08" class="graf graf--p graf-after--pre">
Agora, nossos scores aleatórios são:
</p>
<p id="760e" class="graf graf--p graf-after--p">
\[-18.47206, -4.578708, 15.71626, 28.55935\]
</p>
<p id="a47e" class="graf graf--p graf-after--p">
Ainda indicando submarino (4ª posição) com maior score. Como transformar
esses pesos em valores úteis?
</p>
<p id="2474" class="graf graf--p graf-after--p">
Inicialmente, estabelecemos pesos aleatórios a partir de uma
distribuição normal. Foi o que fizemos no R com a função
<em class="markup--em markup--p-em">rnorm</em>.
</p>
<p id="8403" class="graf graf--p graf-after--p">
Nosso objetivo agora é observar as respostas corretas em várias imagens
e alterar os valores de
<strong class="markup--strong markup--p-strong">W </strong>para que os
scores maiores sejam os das classes corretas.
</p>
<p id="bf72" class="graf graf--p graf-after--p">
Esse aprendizado se dá através de uma função de perda
<strong class="markup--strong markup--p-strong">L.</strong>
</p>
<p id="c2cc" class="graf graf--p graf-after--h4">
A função de perda quantifica o quão distante estamos dos pesos
desejados. A <em class="markup--em markup--p-em">SVM loss function</em>
que vamos usar é ajustada de forma que o score desejado deve ser maior
que os outros por uma margem determinada delta (Δ).
</p>
<figure id="c519" class="graf graf--figure graf-after--p">
<img class="graf-image" src="https://cdn-images-1.medium.com/max/1600/1*sA5MXEl9FFQjjoI3uQ59kQ.png">
<figcaption class="imageCaption">
Função de perda
</figcaption>
</figure>
<p id="192a" class="graf graf--p graf-after--figure">
A função max retorna 0 ou o valor à direita da vírgula, caso ele seja
positivo. A soma L (<em class="markup--em markup--p-em">loss</em>) vai
acumular perda se o score correto não estiver distante o suficiente (Δ)
dos deltas incorretos.
</p>
<p id="99bb" class="graf graf--p graf-after--p">
Implementando em R:
</p>
<pre id="7dee" class="graf graf--pre graf-after--p">loss &lt;- function(x,w,cor.class){<br>  #Determina delta = 2, a distancia minima entre o maior score e os outros<br>  delta &lt;- 2<br>  #Calcula scores multiplicando valores da imagem por pesos W<br>  scores &lt;- x.vec%*%w<br>  #Score da classe correta fornecida pelo argumento da funcao<br>  correct.class.sc &lt;- scores[cor.class]<br>  #Obtem numero de classes<br>  dimensions.class &lt;- length(scores)<br>  #Perda inicial = 0  <br>  cur.loss &lt;- 0</pre>
<pre id="3003" class="graf graf--pre graf-after--pre">  #Loop para calcular a soma dos valores de max(0,~formula SVM)<br>  #A funcao max esta nas funcoes basicas (Base Package) do R<br>  for (i in 1:dimensions.class){<br>    if (i == cor.class){<br>      next<br>    }<br>    cur.loss &lt;- cur.loss + max(0,scores[i] - correct.class.sc + delta)<br>  }<br>  #Retorna valor da perda<br>  return(cur.loss)<br>  }</pre>
<p id="8a1a" class="graf graf--p graf-after--pre">
E podemos testar os scores para cada classe invocando a função na forma
loss(imagem,pesos,classe\_correta):
</p>
<pre id="fcff" class="graf graf--pre graf-after--p">&gt; loss(x,w,1)<br>[1] 101.1131<br>&gt; loss(x,w,2)<br>[1] 57.43302<br>&gt; loss(x,w,3)<br>[1] 14.84309<br>&gt; loss(x,w,4)<br>[1] 0</pre>
<p id="9092" class="graf graf--p graf-after--pre">
Notem que se informamos que a classe correta é a 4, que tinha o maior
score, a função retorna 0. Isto é , não há acréscimo de perda.
</p>
<p id="3e5b" class="graf graf--p graf-after--p">
Agora, o objetivo é encontrar valores de
<strong class="markup--strong markup--p-strong">W </strong>que
minimizem<strong class="markup--strong markup--p-strong"> L
</strong>para todos os
exemplos<strong class="markup--strong markup--p-strong">.</strong> Isso
pode ser feito de maneira analítica, calculando o gradiente
de<strong class="markup--strong markup--p-strong"> L </strong>com
cálculo diferencial, ou de maneira numérica, através de algoritmos.
</p>
<p id="620f" class="graf graf--p graf-after--p">
Aos que têm alguma familiaridade com cálculo básico, o gradiente parte
do mesmo conceito de derivativa, só que para funções
<em class="markup--em markup--p-em">n</em>-dimensionais.
</p>
<p id="a598" class="graf graf--p graf-after--p">
Para evitar erros de convergência, costuma-se comparar ambos valores. Na
prática, estamos mexendo nos parâmetros
<strong class="markup--strong markup--p-strong">W </strong>de forma a
direcionar nossa função de perda
<strong class="markup--strong markup--p-strong">L</strong> aos menores
valores, descendo a montanha.
</p>
<figure id="756f" class="graf graf--figure graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/0*O1r13dAIaVCC2MO9.">
<figcaption class="imageCaption">
Visitem:
<a href="http://blog.dato.com/parallel-ml-with-hogwild" class="markup--anchor markup--figure-anchor">http://blog.dato.com/parallel-ml-with-hogwild</a>
</figcaption>
</figure>
<p id="db8d" class="graf graf--p graf-after--figure">
Com os novos parâmetros
<strong class="markup--strong markup--p-strong">W, </strong>podemos
aplicar o classificador na imagem inédita x’’\[10x10\], obter os scores
para predizer a classe dela, assim como uma nova função de perda.
</p>
<p id="e49e" class="graf graf--p graf-after--p">
Como dá para notar, mesmo num exemplo simplificado, treinar o
classificador implica muitas computações de matrizes n-dimensionais .
Por isso, precisamos de bastante poder computacional e
<em class="markup--em markup--p-em">machine learning</em> só ganhou
atenção recentemente, com o avanço do hardware apropriado.
</p>
<p id="67a6" class="graf graf--p graf-after--h4">
E no caso do Game of Thrones?
</p>
<p id="d4b4" class="graf graf--p graf-after--p">
Aos invés de matrizes com uma dimensão para cada pixel\[10x10\], podemos
usar matrizes com dimensões para dados do personagem:
</p>
<p id="58e6" class="graf graf--p graf-after--p">
No caso do
<a href="https://got.show/machine-learning-algorithm-predicts-death-game-of-thrones" class="markup--anchor markup--p-anchor">modelo
do A Song of Ice And Data</a>, eles usaram dimensões como:
“Idade”,”Casado ou não”;”Número de aparições no livro A Feast for
Crows”.
</p>
<p id="aad1" class="graf graf--p graf-after--p">
<em class="markup--em markup--p-em">-No caso de variáveis categóricas
como o estado civil “Casado ou não”, codificamos 1 para presença e 0
para ausência (dummy coding).Assim, as estimativas de efeito podem ser
feitas por categoria-</em>
</p>
<p id="956c" class="graf graf--p graf-after--p">
Um personagem de 34 anos, casado, que apareceu 3 vezes seria o vetor
\[34,1,3\].
</p>
<p id="4424" class="graf graf--p graf-after--p">
A função do núcleo (kernel) descrita anteriormente é linear e esses
valores seriam multiplicados pela matriz de valores W, somados a b e
resultariam em scores. Eles usaram um kernel polinomial:
</p>
<figure id="465f" class="graf graf--figure graf-after--p">
<img class="graf-image" src="https://cdn-images-1.medium.com/max/1600/0*f9l36UPMzy1ffzJZ.png">
</figure>
<p id="7f1c" class="graf graf--p graf-after--figure">
As funções kernel retornam sempre um produto interno entre dois pontos
no espaço adequado. Além do linear do polinomial, temos outros: Gaussian
Radial Basis Function (RBF) é um exemplo envolvendo exponenciação.
</p>
<figure id="0b3a" class="graf graf--figure graf-after--p">
<img class="graf-image" src="https://cdn-images-1.medium.com/max/1600/1*HJ87LPVR_ZCtkBguX3Uplw.png">
</figure>
<p id="7175" class="graf graf--p graf-after--figure">
Agora, sabemos examinar um conjunto de imagens rotuladas, criar um
classificador linear e treiná-lo (ajustar pesos
<strong class="markup--strong markup--p-strong">W</strong> minimizando a
função de perda
<strong class="markup--strong markup--p-strong">L</strong>) para
retornar um maior score nas as classificações corretas.
</p>
<p id="6e5e" class="graf graf--p graf-after--h4">
O próximo passo é testar a utilidade de nosso modelo. De nada adianta
treinar uma inteligência artificial com métodos sofisticados se ela não
é capaz de classificar as fotos da maneira correta. Um caminho comum de
fazer isso é separando os dados de maneira complementar. Podemos pegar
um subconjunto com 4/5 dos dados para treinar o modelo e testar suas
predições no 1/5 restante.
</p>
<p id="fba8" class="graf graf--p graf-after--p">
Existem outros algoritmos mais complexos para esta tarefa. O modelo do
<a href="https://got.show/machine-learning-algorithm-predicts-death-game-of-thrones" class="markup--anchor markup--p-anchor">A
Song of Ice And Data</a> usou <em class="markup--em markup--p-em">k fold
cross-validation (k=10)</em>. Isso significa que os dados foram
separados em 10 partes iguais. O modelo é treinado em 9 partes e testado
na parte restante. Em seguida, é feito um rodízio para que cada
subconjunto seja usado como amostra de teste uma vez.
</p>
<p id="e623" class="graf graf--p graf-after--p">
Os resultados são:
</p>
<figure id="6008" class="graf graf--figure graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/1*1BYLoqUQmxGzgTdC8rj2dw.png">
</figure>
<p id="31ed" class="graf graf--p graf-after--figure">
Ele define <em class="markup--em markup--p-em">Precision </em>(Precisão)
como a proproção de acertos entre os palpites feitos.
</p>
<p id="befe" class="graf graf--p graf-after--p">
<em class="markup--em markup--p-em">Recall (Mesmo que Sensibilidade)
</em>é definido como proporção de acertos entre os personagens que
realmente morreram. F-Measure é uma média ponderada de Precisão e
Sensibilidade.
</p>
<p id="26ef" class="graf graf--p graf-after--p">
Podemos notar que o modelo não foi tão bom em prever mortes. Dos
palpites de morte feitos, cerca de metade (49%) estavam corretos. Por
outro lado, 60% dos personagens mortos estavam na lista de palpites.
</p>
<p id="9eca" class="graf graf--p graf-after--p">
Visite o
<a href="https://github.com/got-show/general" class="markup--anchor markup--p-anchor">GitHub
da equipe</a> para interagir com os desenvolvedores. Eu postei uma
<em class="markup--em markup--p-em">issue</em> e
<a href="https://github.com/got-show/general/issues/5" class="markup--anchor markup--p-anchor">fui
respondido rapidament</a>e.
</p>
<p id="9d62" class="graf graf--p graf-after--h4">
Vimos como funciona uma SVM. No próximo texto, vamos implementar e
treinar <em class="markup--em markup--p-em">support vector machines
</em>usando pacotes populares no R
(<a href="https://medium.com/arqui-voz/conhecendo-os-pacotes-populares-introdu%C3%A7%C3%A3o-a-machine-learning-com-r-parte-2-8bff273fbb76#.4t4vo5k8b" class="markup--anchor markup--p-anchor">clique
para ler a Parte 2</a>).
</p>
<p id="bd7e" class="graf graf--p graf-after--p">
Dúvidas? Opiniões? Comente. A resposta costuma ser rápida.
</p>
<p id="c19d" class="graf graf--p graf-after--p">
<strong class="markup--strong markup--p-strong">Você pode</strong>
distribuir, alterar ou complementar esse texto, desde que o referencie e
que o faça de forma não comercial.
</p>
<p id="37fd" class="graf graf--p graf-after--h4">
<a href="http://cs231n.github.io/" class="markup--anchor markup--p-anchor">CS231n
- Stanford University: Convolutional Neural Networks for Visual
Recognition</a>
</p>
<p id="da96" class="graf graf--p graf-after--p graf--trailing">
Karatzoglou et al. Support Vector Machines in R.
<em class="markup--em markup--p-em">Journal of Statistical Software.
</em>April 2006, Volume 15, Issue 9.
</p>

