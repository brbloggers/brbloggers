+++
title = "O paradoxo dos aniversários com simulação e probabilidade"
date = "2018-01-20"
categories = ["fellipe-gomes"]
original_url = "https://gomesfellipe.github.io/post/2018-01-20-simulacao-e-probabilidade/simulacao-e-probabilidade/"
+++

<p id="main">
<article class="post">
<header>
<p>
Quanto você acha que é a probabiliddade num grupo de 23 pessoas
escolhidas aleatoriamente que duas delas farão aniversário no mesmo dia?
Acreditaria se eu te dissesse que essa chance é maior do que 50%? A
probabilidade é contra intuitiva e neste post vamos demonstrar de forma
analitica e atraves de simulação esse e outros resultados além de
dissertar um pouco sobre a história e conceitos importantes de
probabilidade
</p>

</header>
<a href="https://gomesfellipe.github.io/post/2018-01-20-simulacao-e-probabilidade/simulacao-e-probabilidade/" class="image featured">
<img src="https://gomesfellipe.github.io/img/2018/01/modelagem-probabilidade2.png" alt="">
</a>
<p>
O uso de cálculo de probabilidades para avaliar incertezas já é
utilizado a centenas de anos. Foram tantas áreas que se encontraram
aplicações (como na medicina, jogos de azar, previsão do tempo…) que
hoje não restam dúvidas de que os dados são onipresentes, ainda mais em
plena era da informação.
</p>
<p>
Os conceitos de chances e de incertezas são tão antigos quando a própria
civilização. Pessoas sempre tiveram que lidar com incertezas sobre o
clima, suprimento de alimentos, suprimentos de água, risco de vida e
tantas outras ameaças ao ser humano que o esforço para reduzir essas
incertezas e seus efeitos passou a ser muito importante.
</p>
<p>
A ideia do jogo tem uma longa história,já no egito antigo em 2000 a.c
foram encontrados em tumbas
(<a href="https://pt.wikipedia.org/wiki/Jogo_de_azar#Hist%C3%B3ria">dados
cúbicos com marcações praticamente idênticas às de dados modernos
(wikipedia)</a>).
</p>
<p>
Segundo <span class="citation">DeGroot (n.d.)</span>, a teoria da
probabilidade foi desenvolvida de forma constante desde o século XVII e
tem sido amplamente aplicada em diversos campos de estudo. Hoje, a
teoria da probabilidade é uma ferramenta importante na maioria das áreas
de engenharia, ciência e gestão.
</p>
<p>
Muitos pesquisadores estão ativamente envolvidos na descoberta e no
estabelecimento de novas aplicações de probabilidade em campos de
química, meteorologia, fotografia de satélites, marketing, previsão de
terremoto, comportamento humano, design de sistemas informáticos,
finanças, genética e lei.
</p>
<p>
Além das muitas aplicações formais da teoria da probabilidade, o
conceito de probabilidade entra em nossa vida cotidiana e conversa.
</p>
<p>
Muitas vezes ouvimos e usamos expressões como “<em>Provavelmente vai
chover a amanhã à noite</em>”, “<em>É muito provável que o onibus
atrase</em>”, ou “<em>As chances são altas de não poder se juntar a nós
para almoçar esta tarde</em>”. Cada uma dessas expressões é baseada no
conceito da probabilidade de que algum evento específico ocorrerá.
</p>
<p>
Existem três abordagens atualmente, as duas primeiras são:
</p>
<ul>
<li>
<p>
Se refere à subconjuntos unitários equiprováveis
</p>
</li>
<li>
<p>
<span
class="math inline">$P(A)=\\dfrac{\\text{N&\#xFA;mero de elementos de }A}{\\text{N&\#xFA;mero de elementos de }\\Omega}$</span>
</p>
</li>
</ul>

<ul>
<li>
<p>
Considera o limite de frequências relativas como o valor de
probabilidade
</p>
</li>
<li>
<p>
<span
class="math inline">$P(A)=lim\_{n \\rightarrow \\infty} \\frac{n\_A}{n}$</span>
</p>
</li>
</ul>
<p>
onde <span class="math inline">*n*<sub>*A*</sub></span> é o nº de
ocorrências de <span class="math inline">*A*</span> em <span
class="math inline">*n*</span> repetições independentes do experimento
</p>

<p>
Segundo <span class="citation">Magalhães (n.d.)</span>, as definições
acima possuem o apelo da intuição e permanecem sendo usadas para
resolver inúmeros problemas, entretanto elas não são suficientes para
uma formulação matemática rigorosa da probabilidade.
</p>
<p>
Aproximadamente em 1930 A. N. Kolmogorov apresentou um conjunto de
axiomas matemáticos para definir probabilidade, permitindo incluir as
definições anteriores como casos particulares.
</p>
<p>
Porém, como o verdadeiro significado da probabilidade ainda é um assunto
altamente polêmico e está envolvido em muitas discussões filosóficas
atuais sobre as bases da estatística e quando se trata de
probabilidades, não adianta utilizar apenas a intuição pois nosso
cérebro vai da bug!
</p>
<p>
A probabilidade é extremamente contra intuitiva e seu estudo deve sempre
envolver uma vasta gama de exercícios para treinar nosso raciocínio
analítico. Existem diversos problemas práticos que já ilustraram isso e
um ótimo exemplo que todo mundo que já fez um curso básico de
probabilidade já conhece, o
<a href="https://pt.wikipedia.org/wiki/Paradoxo_do_anivers%C3%A1rio">Paradóxo
do aniversário</a>
</p>

<p>
Exemplo retirado do livro do <span class="citation">Feller
(n.d.)</span>, questiona:
</p>
<p>
“Num grupo de <span class="math inline">*n*</span> pessoas, qual é a
probabilidade de pelo menos duas delas fazerem aniversário no mesmo
dia?”
</p>
<p>
Esse problema surpreende todo mundo porque dependendo do valor de <span
class="math inline">*n*</span> pessoas, a probabilidade é bastante alta!
Segundo veremos a probabilidade de isso ocorrer em uma turma de 23
pessoas ou mais escolhidas <strong>aleatoriamente</strong> é maior que
<strong>50%</strong>!
</p>
<p>
Qual aluno de qualquer turma de probabilidade que nunca foi desafiado
numa aposta pelo professor que tinha dois alunos com mesma data de
aniversário na sala de aula e se deu conta que perderia em poucos
minutos?
</p>
<p>
Vamos resolver esse problema tanto pela abordagem clássica quanto pela
abordagem frequentista, para utilizar a segunda abordagem dados de
muitas turmas de variados tamanhos serão simulados utilizando o
<strong>R</strong> e podemos comparar os resultados e buscar alguma
evidência de que os dados se distribuem de forma semelhante!
</p>
<p>
<strong>Obs</strong>: Simular dados permitem imitar o funcionamento de,
praticamente, qualquer tipo de operação ou processo (sistemas) do mundo
real!
</p>

<p>
Considerando o ano com 365 dias, podemos assumir que <span
class="math inline">$n&lt;365$</span> primeiramente devemos definir o
espaço amostral <span class="math inline">*Ω*</span> que será o conjunto
de todas as sequências formadas com as datas dos aniversários
(associamos cada data a um dos 365 dias do ano), defini-se:
</p>
<p>
<em>experimento</em>: observar o aniversário de n pessoas
</p>
<p>
<span class="math display">
*Ω* = {(1, 1, ..., 1),(1, 2, 53, ..., 201),(24, 27, 109, ..., 200),...}
</span>
</p>
<p>
portanto, sua cardinalidade será:
</p>
<p>
<span class="math display">
\#*Ω* = 365<sup>*n*</sup>
</span>
</p>
<p>
Definindo o evento:
</p>
<p>
<span class="math display">
*A* = pelo meno 2 alunos fazendo anivers&\#xE1;rio no mesmo dia em uma turma de tamanho *n*
</span> Observa-se que é um evento complicado de se calcular. Uma
prática muito comum na teoria das probabilidades nestes casos é estudar
o complementar do evento de interesse, veja:
</p>
<p>
<span class="math display">
*A*<sup>*c*</sup> = nenhum dos alunos fazenndo anivers&\#xE1;rio no mesmo dia em uma turma de tamanho *n*
</span>
</p>
<p>
Agora basta fazer a conta:
</p>
<p>
<span class="math display">
$$
P(A^c)=\\frac{\\\#A^c}{\\\#\\Omega}=\\frac{365 \\times 364 \\times ... \\times (365-n+1)}{365^n}=\\frac{365!}{365^n (365-n)!}
$$
</span>
</p>
<p>
segundo propriedades , se o evento é o complementar de todos n serem
diferentes consequentemente o seguinte resultado é verdadeiro:
</p>
<p>
<span class="math display">
$$
p(A)=1- \\frac{365!}{365^n (365-n)!}
$$
</span>
</p>
<p>
Agora que já sabemos a probabilidade de pelo menos duas pessoas fazerem
aniversário no mesmo dia em uma turma de <span
class="math inline">*n*</span> alunos, vejamos o comportamento deste
ajuste e uma tabela com possíveis valores de <span
class="math inline">*n*</span>:
</p>
<p>
Em R:
</p>
<p>
Utilizando expansão em série de Taylor
(<a href="https://pt.wikipedia.org/wiki/Paradoxo_do_anivers%C3%A1rio#Aproxima%C3%A7%C3%B5es">mais
informações</a>):
</p>
<pre class="r"><code>birthday=function(x){ a=1-exp(-(x^2)/(2*365)) return(a)
}
birthday(23)</code></pre>
<pre><code>## [1] 0.5155095</code></pre>
<table class="table table-condensed">
<thead>
<tr>
<th>
n
</th>
<th>
P
</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<span>5</span>
</td>
<td>
<span>0.0336668</span>
</td>
</tr>
<tr>
<td>
<span>15</span>
</td>
<td>
<span>0.2652457</span>
</td>
</tr>
<tr>
<td>
<span>25</span>
</td>
<td>
<span>0.5752117</span>
</td>
</tr>
<tr>
<td>
<span>35</span>
</td>
<td>
<span>0.8132683</span>
</td>
</tr>
<tr>
<td>
<span>45</span>
</td>
<td>
<span>0.9375864</span>
</td>
</tr>
<tr>
<td>
<span>55</span>
</td>
<td>
<span>0.9841381</span>
</td>
</tr>
<tr>
<td>
<span>65</span>
</td>
<td>
<span>0.9969349</span>
</td>
</tr>
<tr>
<td>
<span>75</span>
</td>
<td>
<span>0.9995496</span>
</td>
</tr>
<tr>
<td>
<span>85</span>
</td>
<td>
<span>0.9999497</span>
</td>
</tr>
</tbody>
</table>
<p>
Em Python (função retirada do
<a href="https://pt.wikipedia.org/wiki/Paradoxo_do_anivers%C3%A1rio#Implementa%C3%A7%C3%A3o_em_Python">wikpédia</a>
para comparar os resultados):
</p>
<pre class="python"><code>def birthday(x): p = (1.0/365)**x for i in range((366-x),366): p *= i return 1-p print(&quot;%1.7f&quot; %(birthday(23))) #Arredondando para o mesmo numero de casas decimais default do R</code></pre>
<pre><code>## 0.5072972</code></pre>
<p>
Tanto a aproximação do R quanto a do Python obtiveram resultados
semelhantes
</p>
<p>
Vejamos como é o comportamento da curva teórica e as estimações:
</p>
<p>
<img src="https://gomesfellipe.github.io/post/2018-01-20-simulacao-e-probabilidade/2018-01-20-simulacao-e-probabilidade_files/figure-html/unnamed-chunk-4-1.png" width="672">
</p>
<p>
Note que segundo a distribuição teórica, confirmamos que a probabilidade
do evento ocorrer em uma turma de 23 pessoas ou mais escolhidas
<strong>aleatoriamente</strong> é maior que <strong>50%</strong>!
</p>

<p>
Segundo o
<a href="https://pt.wikipedia.org/wiki/Simula%C3%A7%C3%A3o">wikipédia</a>,
a simulação “consiste em empregar formalizações em computadores, como
expressões matemáticas ou especificações mais ou menos formalizadas, com
o propósito de imitar um processo ou operação do mundo real”
</p>
<p>
Nossa simulação irá consistir em imitar o comportamento de um processo
do mundo real utilizando o seguinte código para simular o experimento de
<em>observar o aniversário de <span class="math inline">*n*</span>
pessoas</em> milhares de vezes:
</p>
<pre class="r"><code>N&lt;- 5000 #Numero de simulacoes do experimento prob=0
for(n in 2:100){ #Para n variand de 2 at&#xE9; 50 cont_a=0 #Inicia o contador M=matrix(NA, N, n) #Delara uma matriz varia com as dimensoes desejadas for(i in 1:N){ #indice i que percorre todas as N linhas simuladas M[i,] = sample(1:365, n, replace = T) #Sorteio de uma amosra de tamanho n de numeros de 1 a 365 linha=M[i,] #objeto linha recebe a linha simulada tab=table(linha) #objeto tab guarda a tabela de frequencias dessa amostra if(length(tab)&lt;n){ #se o tamanho da tabela de frequencias for menor que o tamanho da turma cont_a=cont_a+1 #contador recebe 1 pois duas pessoas fizeram aniversario no mesmo dia } } prob[n]=cont_a/N #a probabilidade ser&#xE1; a proporcao de pessoas que fazem aniversario no mesmo dia observadas em N amostra simuladas
} prob[23]</code></pre>
<pre><code>## [1] 0.498</code></pre>
<p>
Notamos que o resultado observado é muito próximo d resultado calculado
de acordo com a probabilidade teoria para a chance de se se encontrar
pelo menos 2 pessoas que fazem aniversário em uma turma de 23 anos
(<em>novamente ultrapassou os 50%!!!</em>)
</p>
<p>
Para efeito de comparação visual com a resolução anterior:
</p>
<table class="table table-condensed">
<thead>
<tr>
<th>
</th>
<th>
n
</th>
<th>
P
</th>
</tr>
</thead>
<tbody>
<tr>
<td>
5
</td>
<td>
<span>5</span>
</td>
<td>
<span>0.0316</span>
</td>
</tr>
<tr>
<td>
15
</td>
<td>
<span>15</span>
</td>
<td>
<span>0.2542</span>
</td>
</tr>
<tr>
<td>
25
</td>
<td>
<span>25</span>
</td>
<td>
<span>0.5696</span>
</td>
</tr>
<tr>
<td>
35
</td>
<td>
<span>35</span>
</td>
<td>
<span>0.8018</span>
</td>
</tr>
<tr>
<td>
45
</td>
<td>
<span>45</span>
</td>
<td>
<span>0.9432</span>
</td>
</tr>
<tr>
<td>
55
</td>
<td>
<span>55</span>
</td>
<td>
<span>0.9866</span>
</td>
</tr>
<tr>
<td>
65
</td>
<td>
<span>65</span>
</td>
<td>
<span>0.9978</span>
</td>
</tr>
<tr>
<td>
75
</td>
<td>
<span>75</span>
</td>
<td>
<span>0.9996</span>
</td>
</tr>
<tr>
<td>
85
</td>
<td>
<span>85</span>
</td>
<td>
<span>1.0000</span>
</td>
</tr>
</tbody>
</table>
<p>
<img src="https://gomesfellipe.github.io/post/2018-01-20-simulacao-e-probabilidade/2018-01-20-simulacao-e-probabilidade_files/figure-html/unnamed-chunk-7-1.png" width="672">
</p>

<p>
Por fim, vejamos de forma visual se o comportamento dos resultados
simulados estão de acordo com o resultado teórico calculado:
</p>
<p>
<img src="https://gomesfellipe.github.io/post/2018-01-20-simulacao-e-probabilidade/2018-01-20-simulacao-e-probabilidade_files/figure-html/unnamed-chunk-8-1.png" width="672">
</p>
<p>
Como podemos ver o comportamento dos dados simulados foi muito similar
ao da curva teórica calculada.
</p>

<p>
Existe uma vasta gama de aplicações de simulações como em projetos de
análises de sistemas de manufatura, avaliação de requisitos não
funcionais de hardware e software, avaliação de novas armas e táticas
militares, reposição de estoque, projeto de sistemas de transporte,
avaliações de serviços, aplicações estatísticas de cadeias MCMC…
</p>
<p>
Um simulador permite testar várias alternativas a um custo
<strong>geralmente</strong> mais baixo do que no mundo real,
possibilitando o melhor entendimento sobre o problema!
</p>

<p>
DeGroot, Morris H. n.d. <em>Probability and Statistics</em>. Vol. 4.
</p>

<p>
Feller, William. n.d. <em>An Introduction to Probability Theory and Its
Applications</em>. Vol. 3.
</p>

<p>
Magalhães, Mascos N. n.d. <em>Probabilidade E Variáveis
Aleatóriasa</em>. Vol. 1.
</p>

<footer>
<ul class="stats">
<li>
Categories
</li>
<li>
<a href="https://gomesfellipe.github.io/categories/estatistica">Estatistica</a>
</li>
<li>
<a href="https://gomesfellipe.github.io/categories/modelos">Modelos</a>
</li>
<li>
<a href="https://gomesfellipe.github.io/categories/r">R</a>
</li>
<li>
<a href="https://gomesfellipe.github.io/categories/teoria">Teoria</a>
</li>
<li>
<a href="https://gomesfellipe.github.io/categories/utilidades">utilidades</a>
</li>
<li>
<a href="https://gomesfellipe.github.io/categories/simulacao">simulacao</a>
</li>
<li>
<a href="https://gomesfellipe.github.io/categories/probabilidade">probabilidade</a>
</li>
</ul>
</footer>
</article>
<article class="post">
<a href="https://disqus.com/" class="dsq-brlink">comments powered by
</a>
</article>
</p>

