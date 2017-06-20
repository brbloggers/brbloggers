+++
title = "R para Usuários de Excel"
date = "2017-02-22 18:14:10"
categories = ["IBPAD"]
original_url = "http://www.ibpad.com.br/blog/r-para-usuarios-de-excel/"
+++

<p style="text-align: right;">
<em>\* Publicação de Gordon Shotwell, traduzida pelo IBPAD – post
original pode ser
acessado <a href="http://shotwell.ca/blog/post/r_for_excel_users/">aqui</a></em>
</p>
<p>
<img data-attachment-id="4573" data-permalink="http://www.ibpad.com.br/blog/r-para-usuarios-de-excel/attachment/rparaexcel/" data-orig-file="https://i0.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/RparaExcel.jpg?fit=741%2C345" data-orig-size="741,345" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;}" data-image-title="R para Excel" data-image-description="" data-medium-file="https://i0.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/RparaExcel.jpg?fit=260%2C121" data-large-file="https://i0.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/RparaExcel.jpg?fit=741%2C345" class="size-medium wp-image-4573 alignleft" src="https://i0.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/RparaExcel.jpg?resize=260%2C121" alt="" srcset="https://i0.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/RparaExcel.jpg?resize=260%2C121 260w, https://i0.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/RparaExcel.jpg?resize=100%2C47 100w, https://i0.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/RparaExcel.jpg?w=741 741w" sizes="(max-width: 260px) 100vw, 260px" data-recalc-dims="1" />A
primeira ferramenta onde aprendemos a trabalhar com números costuma ser
o Excel.
</p>
<p>
Um dos recursos mais incríveis do Excel é, de fato, sua simplicidade e
sua forma intuitiva de apresentar a ferramenta. Todos os dias, em todo o
mundo, pessoas abrem uma planilha para fazer alguma entrada de dados e,
pouco a pouco, aprendem a fazer tarefas analíticas cada vez mais
complexas. Excel é um mestre no ensino do próprio Excel.
</p>
<p>
R não é assim. A curva de aprendizado para R costuma ser mais íngrime no
começo. Isso pode ser especialmente frustante quando você não consegue
fazer tarefas simples no R como importar arquivos ou plotar um gráfico,
e no Excel são coisas tão intuitivas.
</p>
<hr />
<p style="text-align: right;">
<a href="http://www.ibpad.com.br/blog/formacao-em-r/" target="_blank"><br />
</a><a href="http://www.ibpad.com.br/blog/formacao-em-r/" target="_blank"><img data-attachment-id="4138" data-permalink="http://www.ibpad.com.br/nossos-cursos/formacao-em-r/attachment/vitrine-r/" data-orig-file="https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Vitrine-R.png?fit=1225%2C1134" data-orig-size="1225,1134" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;}" data-image-title="Vitrine Formação em R" data-image-description="" data-medium-file="https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Vitrine-R.png?fit=260%2C241" data-large-file="https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Vitrine-R.png?fit=900%2C833" class="aligncenter wp-image-4138 size-medium" src="https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Vitrine-R.png?resize=260%2C241" srcset="https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Vitrine-R.png?resize=260%2C241 260w, https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Vitrine-R.png?resize=768%2C711 768w, https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Vitrine-R.png?resize=1024%2C948 1024w, https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Vitrine-R.png?resize=100%2C93 100w, https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Vitrine-R.png?w=1225 1225w" sizes="(max-width: 260px) 100vw, 260px" data-recalc-dims="1" /></a>
</p>
<p style="text-align: center;">
<a href="http://www.ibpad.com.br/blog/formacao-em-r/" target="_blank">Quer
dar um passo adiante? Conheça a nossa formação em R do IBPAD</a>
</p>
<hr />
<p>
Essa é a dificuldade de aprender a programar. Linguagens de programação
são projetados para serem gerais em sua aplicação e para permitir que
você realize uma enorme variedade de tarefas complexas com o mesmo
conjunto básico de ferramentas. O custo desta generalidade é uma curva
de aprendizagem íngreme. Quando você começa a aprender a fazer tarefas
básicas em R, você também está aprendendo a fazer coisas complexas no
caminho. À medida que você aprende cada vez mais, o custo marginal de
análises complexas diminui. Excel é o oposto, e é muito fácil no início,
mas o custo marginal aumenta com a complexidade do problema. Uma
representação gráfica disso se aproximaria a isso:
</p>
<p>
<img data-attachment-id="4576" data-permalink="http://www.ibpad.com.br/blog/r-para-usuarios-de-excel/attachment/r-vs-excel/" data-orig-file="https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/R-Vs-Excel.jpg?fit=1436%2C1220" data-orig-size="1436,1220" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;}" data-image-title="R-Vs-Excel" data-image-description="" data-medium-file="https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/R-Vs-Excel.jpg?fit=260%2C221" data-large-file="https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/R-Vs-Excel.jpg?fit=900%2C765" class="alignnone size-large wp-image-4576" src="https://i0.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/R-Vs-Excel-1024x870.jpg?resize=900%2C765" alt="" srcset="https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/R-Vs-Excel.jpg?resize=1024%2C870 1024w, https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/R-Vs-Excel.jpg?resize=260%2C221 260w, https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/R-Vs-Excel.jpg?resize=768%2C652 768w, https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/R-Vs-Excel.jpg?resize=100%2C85 100w, https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/R-Vs-Excel.jpg?w=1436 1436w" sizes="(max-width: 900px) 100vw, 900px" data-recalc-dims="1" />No
início, quando você está tentando realizar coisas simples como
equilibrar um orçamento ou inserir alguns dados à mão, R é
definitivamente mais difícil de aprender do que o Excel. No entanto,
quando tarefas ficam mais complexas, tornam-se mais fáceis de realizar
em R do que no Excel, porque as estruturas de núcleo do Excel são
projetados para casos de uso relativamente simples e não são as melhores
para problemas mais complexos. Isto não quer dizer que você não pode
resolver uma variedade de problemas complexos com o Excel, mas a
ferramenta não vai facilitar sua vida.
</p>
<p>
Para muitos de nós, a dor de aprender a programar é dor do fracasso.
Quando o programa lhe dá uma mensagem de erro incompreensível, parece
que está dizendo que você é estúpido e lhe falta aptidão para
programação. Mas depois de programar por um tempo, você aprende que
ninguém realmente entende esses erros, e todo mundo se sente como um
impostor quando seu programa falha. A dor que você sente não é a dor do
fracasso, é apenas a dor da aprendizagem.
</p>
<h3>
Por que aprender coisas novas é tão difícil?
</h3>
<p>
A dificuldade de aprender uma nova ferramenta é causada por dois
obstáculos:
</p>
<h4>
Obstáculo \# 1:
</h4>
<p>
A ferramenta é diferente do que você conhece. Quando você conhece
intimamente uma ferramenta, você desenvolve um vocabulário nessa
ferramenta, você lembra dos atalhos, fórmulas e de onde tudo está
visualmente. Mesmo depois de muito tempo sem usar Excel, é muito fácil
voltar a usá-lo, quase como andar de bicicleta. Quando você está
aprendendo uma nova ferramenta, você não conhece nenhuma dessas coisas,
e isso torna o aprendizado mais difícil. Além disso, você sabe onde
procurar ajuda em ferramentas conhecidas ou como fazer perguntas do
Google de tal forma que você encontre respostas úteis. Nessa nova
ferramenta, você não conhece nenhuma dessas coisas.
</p>
<h4>
Obstáculo \# 2:
</h4>
<p>
A maneira como a nova ferramenta quer que você pense sobre o problema é
diferente da maneira como você está acostumado a pensar sobre o
problema. Por exemplo, se você está acostumado a colocar sua análise em
uma grade retangular, passar para uma ferramenta que é projetada em
torno de comandos vai ser difícil.
</p>
<p>
Esse obstáculo costuma ser de longe a maior barreira para os usuários de
Excel. A maioria das pessoas que aprendem R tem alguma base em
programação. Os modelos mentais subjacentes às linguagens como Matlab ou
Python, bem como pacotes estatísticos como SPSS e SAS, têm muito em
comum com R. Excel, por outro lado, faz você pensar sobre problemas
analíticos de uma maneira muito diferente, e não há muitos recursos para
traduzir um para o outro.
</p>
<p>
 
</p>
<h3>
Quatro diferenças fundamentais entre R e Excel
</h3>
<h4>
1.  Análise baseada em texto
    </h4>
    <p>
    O Excel é baseado na planilha física ou planilha de contador. Este é
    um grande pedaço de papel com linhas e colunas. Os registros são
    armazenados na primeira coluna à esquerda, os cálculos sobre esses
    registros foram armazenados nas caixas à direita, e a soma desses
    cálculos foi totalizada na parte inferior. Isso seria um modelo
    referencial de computação, que tem algumas qualidades:
    </p>
    <ul>
    <li>
     Os dados e computação são geralmente armazenados no mesmo local;
    </li>
    <li>
     Os dados são identificados pela sua localização na planilha.
    Geralmente, você não nomeia um intervalo de dados no Excel, mas em
    vez disso se refere a ele por sua localização, por exemplo:$A1:C$36;
    </li>
    <li>
    Os cálculos geralmente têm a mesma forma que os dados. Em outras
    palavras, se você quiser multiplicar 20 números armazenados nas
    células A1:An por 2, você precisará de 20 cálculos: =A1 \* 2, =A2 \*
    2, …., =An \* 2.
    </li>
    </ul>
    <h5>
    A análise de dados baseada em texto é diferente:
    </h5>
    <ul>
    <li>
    Dados e computação são separados. Você tem um arquivo que armazena
    os dados e outro arquivo que armazena os comandos que dizem ao
    programa como manipular esses dados. Isso leva a um tipo de modelo
    processual no qual os dados brutos são alimentados através de um
    conjunto de instruções e aparecem do outro lado, manipulados;
    </li>
    <li>
    Bases de dados são geralmente referenciadas pelo nome. Em vez de ter
    um conjunto de dados que mora no intervalo de
    $A1:C$36, você nomeia o conjunto de dados quando quiser lê-lo, e referir-se-á a ele por esse nome sempre que você quiser fazer algo com ele. Você pode fazer isso com o Excel nomeando intervalos de células, mas não é comum de ser feito.&lt;/li&gt; &lt;/ul&gt; &lt;h4&gt;2) Estruturas de dados&lt;/h4&gt; &lt;p&gt;Excel tem apenas uma estrutura de dados básicos: a célula. As células são extremamente flexíveis, pois podem armazenar informações numéricas, de caracteres, lógicas ou de fórmulas. O custo dessa flexibilidade é a imprevisibilidade. Por exemplo, você pode armazenar o caractere &\#8220;6&\#8221; em uma célula quando você quer armazenar o número 6.&lt;/p&gt; &lt;p&gt;A estrutura de dados R básica é um vetor. Você pode pensar em um vetor como uma coluna em uma planilha do Excel com a limitação de que todos os dados nesse vetor devem ser do mesmo tipo. Se for um vetor de caracteres, cada elemento deve ser um caractere, se for um vetor lógico, cada elemento deve ser VERDADEIRO ou FALSO; Se é numérico você pode confiar que cada elemento é um número. Não há tal restrição no Excel: você pode ter uma coluna de números juntamente com um texto explicativo. Isso não é permitido em R.&lt;/p&gt; &lt;h4&gt;3) Iteração&lt;/h4&gt; &lt;p&gt;Iteração é um dos recursos mais poderosos das linguagens de programação e é uma grande novidade para os usuários do Excel. Iteração é apenas pedir para o computador fazer a mesma coisa várias vezes seguidas por um determinado período. Talvez você queira desenhar o mesmo gráfico com base em cinquenta conjuntos de dados diferentes, ou ler e filtrar várias bases de dados. Em uma linguagem de programação como R você escreve um script que funciona para todos os casos em que você deseja aplicá-lo e então diz ao computador para aplicá-lo.&lt;/p&gt; &lt;p&gt;Os analistas do Excel costumam fazer muito dessa iteração. Por exemplo, se um analista do Excel quiser combinar dez arquivos .xls diferentes em um arquivo grande, eles provavelmente abrirá cada um individualmente, copiará os dados e colará-los em uma planilha principal. O analista está efetivamente tomando o lugar de um&lt;em&gt; for loop&lt;/em&gt; fazendo uma coisa repetidamente até que uma condição seja atendida.&lt;/p&gt; &lt;h4&gt;4) Simplificação através da abstração&lt;/h4&gt; &lt;p&gt;Outra grande diferença é que a programação incentiva você a simplificar sua análise, abstraindo funções comuns a partir dessa análise. No exemplo abaixo você pode achar que tem que ler o mesmo tipo de arquivos repetidamente e verificar se eles têm o número certo de linhas. R permite que você escreva uma função que faz isso:&lt;/p&gt;&lt;pre class="crayon-plain-tag"&gt;read\_and\_check &lt;- function(file){   out &lt;- read.csv(file)   if(nrow(out) == 0) {     stop("Essa planilha está vazia!")   } else {     out   } }&lt;/pre&gt;&lt;p&gt;Tudo que essa função faz é ler um arquivo .csv e verificar se ele tem mais de zero linhas. Se não, ele retorna um erro. Caso contrário, retorna o arquivo (que é chamado de &\#8220;out&\#8221;). Esta é uma abordagem poderosa porque ajuda a poupar tempo e a reduzir erros. Por exemplo, se você quiser verificar se o arquivo tem mais de 23 linhas, você só precisa alterar a condição em um lugar e não em várias planilhas.&lt;/p&gt; &lt;p&gt;Não há realmente nenhum análogo para esses tipos de funções em um fluxo de trabalho baseado em Excel, e quando a maioria dos analistas chegar a este ponto começarão a escrever código VBA para fazer parte desse trabalho.&lt;/p&gt; &lt;h5&gt;Exemplo: Juntar duas tabelas&lt;/h5&gt; &lt;p&gt;Para exemplificar, vamos juntar duas tabelas no Excel e no R. Vamos dizer que temos duas tabelas de dados, uma com algumas informações sobre carros e outra com a cor desses carros, e queremos juntar os dois juntos. Para o propósito deste exercício, vamos supor que o número de cilindros em um carro determina a sua cor.&lt;/p&gt;&lt;pre class="crayon-plain-tag"&gt;library(dplyr) library(knitr) cars &lt;- mtcars colours &lt;- data\_frame(   cyl = unique(cars$cyl),
      colour = c("Blue", "Green", "Eggplant") )  kable(cars\[1:10, \])
    \#kable is just for displaying the table
    </pre>
    <p>
    <img data-attachment-id="4503" data-permalink="http://www.ibpad.com.br/blog/r-para-usuarios-de-excel/attachment/tabela-1/" data-orig-file="https://i0.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/tabela-1.png?fit=962%2C475" data-orig-size="962,475" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;}" data-image-title="tabela 1" data-image-description="" data-medium-file="https://i0.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/tabela-1.png?fit=260%2C128" data-large-file="https://i0.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/tabela-1.png?fit=900%2C444" class="alignnone size-full wp-image-4503" src="https://i0.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/tabela-1.png?resize=900%2C444" alt="" srcset="https://i0.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/tabela-1.png?w=962 962w, https://i0.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/tabela-1.png?resize=260%2C128 260w, https://i0.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/tabela-1.png?resize=768%2C379 768w, https://i0.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/tabela-1.png?resize=100%2C49 100w" sizes="(max-width: 900px) 100vw, 900px" data-recalc-dims="1" />
    </p>
    <pre class="crayon-plain-tag">kable(colours)</pre>
    <p>
    <img data-attachment-id="4502" data-permalink="http://www.ibpad.com.br/blog/r-para-usuarios-de-excel/attachment/tabela-2/" data-orig-file="https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/tabela-2.png?fit=963%2C184" data-orig-size="963,184" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;}" data-image-title="tabela 2" data-image-description="" data-medium-file="https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/tabela-2.png?fit=260%2C50" data-large-file="https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/tabela-2.png?fit=900%2C172" class="alignnone size-full wp-image-4502" src="https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/tabela-2.png?resize=900%2C172" alt="" srcset="https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/tabela-2.png?w=963 963w, https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/tabela-2.png?resize=260%2C50 260w, https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/tabela-2.png?resize=768%2C147 768w, https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/tabela-2.png?resize=100%2C19 100w" sizes="(max-width: 900px) 100vw, 900px" data-recalc-dims="1" />
    </p>
    <p>
    No Excel você provavelmente faria isso usando a função VLOOKUP(),
    que leva uma chave e um intervalo e, em seguida, procuraria o valor
    dessa chave dentro desse intervalo. Um exemplo de planilha dessa
    abordagem pode ser
    visto <a href="https://docs.google.com/spreadsheets/d/1K2IqdXX2MoUB4BorRcBcruS7spCvRtDwqXV-4gYAob4/edit">aqui</a>.
    Observe que em cada célula de pesquisa existe alguma versão de
    =vlookup(C4,$H2:I$5, 2, FALSE).
    </p>
    <p>
    Isso ilustra algumas coisas. Primeiro, o cálculo tem a mesma forma
    que os dados, e acontece no mesmo arquivo que os dados. Temos tantas
    fórmulas quanto temos coisas que queremos pesquisar, e elas são
    colocadas ao lado do conjunto de dados. Se você usou esta
    aproximação você pode provavelmente recordar de erros no processo de
    escrever e de encher esta fórmula. Em segundo lugar, os dados são
    referidos pela sua localização na folha. Se movimentarmos a tabela
    de consulta para outra folha, ou para outro lugar nessa folha, isso
    vai estragar a análise. Em terceiro lugar, observe que a primeira
    entrada da coluna cyl no armazenamento de planilha em C2 é
    armazenada como texto, o que causa erro na função de pesquisa. Em R,
    você teria que armazenar todos os valores de calendário como um
    vetor numérico ou de caracteres. Para fazer a mesma coisa em R, nós
    usaríamos este código:
    </p>
    <pre class="crayon-plain-tag">left_join(cars, colours, by = "cyl") %&gt;%  
    filter(row_number() %in% 1:10) %&gt;% # to display only a subset of the data
      kable()</pre>
    <p>
    <img data-attachment-id="4578" data-permalink="http://www.ibpad.com.br/blog/r-para-usuarios-de-excel/attachment/tabela2/" data-orig-file="https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Tabela2.jpg?fit=1770%2C787" data-orig-size="1770,787" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;}" data-image-title="Tabela2" data-image-description="" data-medium-file="https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Tabela2.jpg?fit=260%2C116" data-large-file="https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Tabela2.jpg?fit=900%2C400" class="alignnone size-large wp-image-4578" src="https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Tabela2.jpg?resize=900%2C400" alt="" srcset="https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Tabela2.jpg?resize=1024%2C455 1024w, https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Tabela2.jpg?resize=260%2C116 260w, https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Tabela2.jpg?resize=768%2C341 768w, https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Tabela2.jpg?resize=100%2C44 100w" sizes="(max-width: 900px) 100vw, 900px" data-recalc-dims="1" />Aqui
    nós nos referimos aos dados pelo seu nome, usamos uma função para
    operar em toda a tabela ao invés de linha a linha. Como a
    consistência é imposta para cada vetor, não podemos armazenar
    acidentalmente uma entrada de caractere em um vetor numérico.
    </p>
    <p>
    <strong>Iteração</strong>
    </p>
    <p>
    Se quiséssemos obter o deslocamento médio para cada cor de carro, a
    maioria dos usuários de Excel provavelmente faria essa iteração
    manualmente, primeiro selecionando a tabela, classificando-a por cor
    e, em seguida, escolhendo os intervalos que eles queriam
    média analisar. Um analista mais sofisticado provavelmente usaria a
    função averageif()para escolher os critérios que eles queriam média,
    e assim evitaria alguns erros. Ambas as abordagens são implementadas
    na guia iteração da planilha.
    </p>
    <p>
    Em R você faria algo como isto:
    </p>
    <pre class="crayon-plain-tag">left_join(cars, colours, by = "cyl") %&gt;%
      group_by(colour) %&gt;%
      summarize(mean_displacement = mean(disp)) %&gt;%
      kable()</pre>
    <p>
    <img data-attachment-id="4579" data-permalink="http://www.ibpad.com.br/blog/r-para-usuarios-de-excel/attachment/tabela3/" data-orig-file="https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Tabela3.jpg?fit=1765%2C309" data-orig-size="1765,309" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;}" data-image-title="Tabela3" data-image-description="" data-medium-file="https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Tabela3.jpg?fit=260%2C46" data-large-file="https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Tabela3.jpg?fit=900%2C157" class="alignnone size-large wp-image-4579" src="https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Tabela3.jpg?resize=900%2C157" alt="" srcset="https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Tabela3.jpg?resize=1024%2C179 1024w, https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Tabela3.jpg?resize=260%2C46 260w, https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Tabela3.jpg?resize=768%2C134 768w, https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Tabela3.jpg?resize=100%2C18 100w" sizes="(max-width: 900px) 100vw, 900px" data-recalc-dims="1" />O
    que isto faz é pegar o conjunto de dados, dividi-lo pela variável de
    agrupamento, neste caso, a cor, e, em seguida, aplicar a função na
    função summarize de cada grupo. A diferença é que nós estamos nos
    referindo às coisas pelo nome em vez da posição – há uma linha de
    código que aplica a função ao conjunto de dados inteiro, e todas as
    ações iterativas são armazenadas no script.
    </p>
    <p>
    Generalização através de funções são um dos aspectos mais difíceis
    no aprendizado de uma linguagem de programação. É importante falar
    sobre elas pois são comuns e podem ser bastante desanimadoras para
    os usuários do Excel, porque eles são totalmente estranhos ao seu
    fluxo de trabalho. Uma função é uma maneira de usar código existente
    em novos objetos.  Uma função que se encaixa no caso descrito acima
    pode parecer assim:
    </p>
    <pre class="crayon-plain-tag">join_and_summarize &lt;- function(df, colour_df){
      left_join(df, colour_df, by = "cyl") %&gt;%
        group_by(colour) %&gt;%
        summarize(mean_displacement = mean(disp))
    }</pre>
    <p>
    O que está entre as chaves
    <pre class="crayon-plain-tag">function() (dfe colour_df)</pre>
      são chamados de “argumentos”, e quando você utiliza a função tudo
    o que faz é pegar os objetos reais que você fornece à função e os
    conecta para onde quer que esse argumento apareça dentro das chaves.
    Neste caso, nós ligaríamos cars para o argumento dfe, e colours para
    o argumento colour\_df. A função, em seguida, basicamente substitui
    todos os df com carros e colour\_df com cores e, em seguida, avalia
    o código.
    </p>
    <pre class="crayon-plain-tag">join_and_summarize(cars, colours) %&gt;%
      kable()</pre>
    <p>
    <img data-attachment-id="4580" data-permalink="http://www.ibpad.com.br/blog/r-para-usuarios-de-excel/attachment/tabela4/" data-orig-file="https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/tabela4.jpg?fit=1770%2C317" data-orig-size="1770,317" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;}" data-image-title="tabela4" data-image-description="" data-medium-file="https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/tabela4.jpg?fit=260%2C47" data-large-file="https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/tabela4.jpg?fit=900%2C161" class="alignnone size-large wp-image-4580" src="https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/tabela4.jpg?resize=900%2C161" alt="" srcset="https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/tabela4.jpg?resize=1024%2C183 1024w, https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/tabela4.jpg?resize=260%2C47 260w, https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/tabela4.jpg?resize=768%2C138 768w, https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/tabela4.jpg?resize=100%2C18 100w" sizes="(max-width: 900px) 100vw, 900px" data-recalc-dims="1" /><strong>Conclusão</strong>
    </p>
    <p>
    Usuários de Excel têm uma maneira de pensar a análise de dados muito
    rígida, e isso torna o aprendizado do de R mais difícil. No entanto,
    aprender a programar permitirá que você faça coisas que você não
    pode fazer no Excel, e realmente vale a pena a dor de aprender uma
    nova linguagem.
    </p>
    <hr />
    <p style="text-align: right;">
    <a href="http://www.ibpad.com.br/blog/formacao-em-r/" target="_blank"><br />
    </a><a href="http://www.ibpad.com.br/blog/formacao-em-r/" target="_blank"><img data-attachment-id="4138" data-permalink="http://www.ibpad.com.br/nossos-cursos/formacao-em-r/attachment/vitrine-r/" data-orig-file="https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Vitrine-R.png?fit=1225%2C1134" data-orig-size="1225,1134" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;}" data-image-title="Vitrine Formação em R" data-image-description="" data-medium-file="https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Vitrine-R.png?fit=260%2C241" data-large-file="https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Vitrine-R.png?fit=900%2C833" class="aligncenter wp-image-4138 size-medium" src="https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Vitrine-R.png?resize=260%2C241" srcset="https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Vitrine-R.png?resize=260%2C241 260w, https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Vitrine-R.png?resize=768%2C711 768w, https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Vitrine-R.png?resize=1024%2C948 1024w, https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Vitrine-R.png?resize=100%2C93 100w, https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Vitrine-R.png?w=1225 1225w" sizes="(max-width: 260px) 100vw, 260px" data-recalc-dims="1" /></a>
    </p>
    <p style="text-align: center;">
    <a href="http://www.ibpad.com.br/blog/formacao-em-r/" target="_blank">Quer
    dar um passo adiante? Conheça a nossa formação em R do IBPAD</a>
    </p>
    <p>
    O post
    <a rel="nofollow" href="http://www.ibpad.com.br/blog/r-para-usuarios-de-excel/">R
    para Usuários de Excel</a> apareceu primeiro em
    <a rel="nofollow" href="http://www.ibpad.com.br">IBPAD</a>.
    </p>

