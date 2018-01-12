+++
title = "R para Usuários de Excel"
date = "2017-02-22 18:14:10"
categories = ["IBPAD"]
original_url = "https://www.ibpad.com.br/blog/r-para-usuarios-de-excel/"
+++

<div class="post-inner-content">
<div class="vc_row wpb_row vc_row-fluid">
<div class="wpb_column vc_column_container vc_col-sm-12">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<div class="wpb_text_column wpb_content_element ">
<div class="wpb_wrapper">
<p style="text-align: right;">
<em>\* Publicação de Gordon Shotwell, traduzida pelo IBPAD – post
original pode ser
acessado <a href="http://shotwell.ca/blog/post/r_for_excel_users/">aqui</a></em>
</p>
<p>
<img class="size-medium wp-image-4573 alignleft" src="https://www.ibpad.com.br/wp-content/uploads/2017/02/RparaExcel-260x121.jpg" alt="" width="260" height="121" srcset="https://www.ibpad.com.br/wp-content/uploads/2017/02/RparaExcel-260x121.jpg 260w, https://www.ibpad.com.br/wp-content/uploads/2017/02/RparaExcel-100x47.jpg 100w, https://www.ibpad.com.br/wp-content/uploads/2017/02/RparaExcel.jpg 741w" sizes="(max-width: 260px) 100vw, 260px">A
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
<img class="alignnone size-large wp-image-4576" src="https://www.ibpad.com.br/wp-content/uploads/2017/02/R-Vs-Excel-1024x870.jpg" alt="" width="900" height="765" srcset="https://www.ibpad.com.br/wp-content/uploads/2017/02/R-Vs-Excel-1024x870.jpg 1024w, https://www.ibpad.com.br/wp-content/uploads/2017/02/R-Vs-Excel-260x221.jpg 260w, https://www.ibpad.com.br/wp-content/uploads/2017/02/R-Vs-Excel-768x652.jpg 768w, https://www.ibpad.com.br/wp-content/uploads/2017/02/R-Vs-Excel-100x85.jpg 100w, https://www.ibpad.com.br/wp-content/uploads/2017/02/R-Vs-Excel.jpg 1436w" sizes="(max-width: 900px) 100vw, 900px">No
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
    um conjunto de dados que mora no intervalo de $A1:C$36, você nomeia
    o conjunto de dados quando quiser lê-lo, e referir-se-á a ele por
    esse nome sempre que você quiser fazer algo com ele. Você pode fazer
    isso com o Excel nomeando intervalos de células, mas não é comum de
    ser feito.
    </li>
    </ul>
    <h4>
    1.  Estruturas de dados
        </h4>
        <p>
        Excel tem apenas uma estrutura de dados básicos: a célula. As
        células são extremamente flexíveis, pois podem armazenar
        informações numéricas, de caracteres, lógicas ou de fórmulas. O
        custo dessa flexibilidade é a imprevisibilidade. Por exemplo,
        você pode armazenar o caractere “6” em uma célula quando você
        quer armazenar o número 6.
        </p>
        <p>
        A estrutura de dados R básica é um vetor. Você pode pensar em um
        vetor como uma coluna em uma planilha do Excel com a limitação
        de que todos os dados nesse vetor devem ser do mesmo tipo. Se
        for um vetor de caracteres, cada elemento deve ser um caractere,
        se for um vetor lógico, cada elemento deve ser VERDADEIRO ou
        FALSO; Se é numérico você pode confiar que cada elemento é um
        número. Não há tal restrição no Excel: você pode ter uma coluna
        de números juntamente com um texto explicativo. Isso não é
        permitido em R.
        </p>
        <h4>
        1.  Iteração
            </h4>
            <p>
            Iteração é um dos recursos mais poderosos das linguagens de
            programação e é uma grande novidade para os usuários do
            Excel. Iteração é apenas pedir para o computador fazer a
            mesma coisa várias vezes seguidas por um determinado
            período. Talvez você queira desenhar o mesmo gráfico com
            base em cinquenta conjuntos de dados diferentes, ou ler e
            filtrar várias bases de dados. Em uma linguagem de
            programação como R você escreve um script que funciona para
            todos os casos em que você deseja aplicá-lo e então diz ao
            computador para aplicá-lo.
            </p>
            <p>
            Os analistas do Excel costumam fazer muito dessa iteração.
            Por exemplo, se um analista do Excel quiser combinar dez
            arquivos .xls diferentes em um arquivo grande, eles
            provavelmente abrirá cada um individualmente, copiará os
            dados e colará-los em uma planilha principal. O analista
            está efetivamente tomando o lugar de um<em> for loop</em>
            fazendo uma coisa repetidamente até que uma condição seja
            atendida.
            </p>
            <h4>
            1.  Simplificação através da abstração
                </h4>
                <p>
                Outra grande diferença é que a programação incentiva
                você a simplificar sua análise, abstraindo funções
                comuns a partir dessa análise. No exemplo abaixo você
                pode achar que tem que ler o mesmo tipo de arquivos
                repetidamente e verificar se eles têm o número certo de
                linhas. R permite que você escreva uma função que faz
                isso:
                </p>
                <span class="crayon-title"></span>

                <span class="crayon-language">R</span>

                <textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
                read\_and\_check &lt;- function(file){  out &lt;-
                read.csv(file)  if(nrow(out) == 0) {    stop("Essa
                planilha está vazia!")  } else {     out  } }
                </textarea>

                <table class="crayon-table">
                <tr class="crayon-row">
                <td class="crayon-nums " data-settings="show">
                1

                2

                3

                4

                5

                6

                7

                8

                </td>
                <td class="crayon-code">
                <span class="crayon-v">read\_and\_check</span><span
                class="crayon-h"> </span><span
                class="crayon-o">&lt;</span><span
                class="crayon-o">-</span><span class="crayon-h">
                </span><span class="crayon-t">function</span><span
                class="crayon-sy">(</span><span
                class="crayon-v">file</span><span
                class="crayon-sy">)</span><span
                class="crayon-sy">{</span> 

                <span class="crayon-h"> </span><span
                class="crayon-v">out</span><span class="crayon-h">
                </span><span class="crayon-o">&lt;</span><span
                class="crayon-o">-</span><span class="crayon-h">
                </span><span class="crayon-v">read</span><span
                class="crayon-sy">.</span><span
                class="crayon-e">csv</span><span
                class="crayon-sy">(</span><span
                class="crayon-v">file</span><span
                class="crayon-sy">)</span> 

                <span class="crayon-h"> </span><span
                class="crayon-st">if</span><span
                class="crayon-sy">(</span><span
                class="crayon-e">nrow</span><span
                class="crayon-sy">(</span><span
                class="crayon-v">out</span><span
                class="crayon-sy">)</span><span class="crayon-h">
                </span><span class="crayon-o">==</span><span
                class="crayon-h"> </span><span
                class="crayon-cn">0</span><span
                class="crayon-sy">)</span><span class="crayon-h">
                </span><span class="crayon-sy">{</span>   

                <span class="crayon-h"> </span><span
                class="crayon-r">stop</span><span
                class="crayon-sy">(</span><span class="crayon-s">"Essa
                planilha está vazia!"</span><span
                class="crayon-sy">)</span> 

                <span class="crayon-h"> </span><span
                class="crayon-sy">}</span><span class="crayon-h">
                </span><span class="crayon-st">else</span><span
                class="crayon-h"> </span><span
                class="crayon-sy">{</span>  

                 <span class="crayon-h"> </span><span
                class="crayon-i">out</span> 

                <span class="crayon-h">  </span><span
                class="crayon-sy">}</span>

                <span class="crayon-sy">}</span>

                </td>
                </tr>
                </table>

<p>
Tudo que essa função faz é ler um arquivo .csv e verificar se ele tem
mais de zero linhas. Se não, ele retorna um erro. Caso contrário,
retorna o arquivo (que é chamado de “out”). Esta é uma abordagem
poderosa porque ajuda a poupar tempo e a reduzir erros. Por exemplo, se
você quiser verificar se o arquivo tem mais de 23 linhas, você só
precisa alterar a condição em um lugar e não em várias planilhas.
</p>
<p>
Não há realmente nenhum análogo para esses tipos de funções em um fluxo
de trabalho baseado em Excel, e quando a maioria dos analistas chegar a
este ponto começarão a escrever código VBA para fazer parte desse
trabalho.
</p>
<h5>
Exemplo: Juntar duas tabelas
</h5>
<p>
Para exemplificar, vamos juntar duas tabelas no Excel e no R. Vamos
dizer que temos duas tabelas de dados, uma com algumas informações sobre
carros e outra com a cor desses carros, e queremos juntar os dois
juntos. Para o propósito deste exercício, vamos supor que o número de
cilindros em um carro determina a sua cor.
</p>
<div id="crayon-5a5818c87fd00644788737" class="crayon-syntax crayon-theme-classic crayon-font-monaco crayon-os-pc print-yes notranslate" data-settings=" minimize scroll-mouseover" style=" margin-top: 12px; margin-bottom: 12px; font-size: 12px !important; line-height: 15px !important;">
<span class="crayon-title"></span>

<span class="crayon-language">R</span>

<div class="crayon-plain-wrap">
<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
library(dplyr) library(knitr) cars &lt;- mtcars colours &lt;-
data\_frame(   cyl =
unique(cars$cyl),   colour = c("Blue", "Green", "Eggplant") )  kable(cars\[1:10, \]) \#kable is just for displaying the table&lt;/textarea&gt;&lt;/div&gt; &lt;div class="crayon-main" style=""&gt; &lt;table class="crayon-table"&gt;&lt;tr class="crayon-row"&gt; &lt;td class="crayon-nums " data-settings="show"&gt; &lt;div class="crayon-nums-content" style="font-size: 12px !important; line-height: 15px !important;"&gt; &lt;div class="crayon-num" data-line="crayon-5a5818c87fd00644788737-1"&gt;1&lt;/div&gt; &lt;div class="crayon-num crayon-striped-num" data-line="crayon-5a5818c87fd00644788737-2"&gt;2&lt;/div&gt; &lt;div class="crayon-num" data-line="crayon-5a5818c87fd00644788737-3"&gt;3&lt;/div&gt; &lt;div class="crayon-num crayon-striped-num" data-line="crayon-5a5818c87fd00644788737-4"&gt;4&lt;/div&gt; &lt;div class="crayon-num" data-line="crayon-5a5818c87fd00644788737-5"&gt;5&lt;/div&gt; &lt;div class="crayon-num crayon-striped-num" data-line="crayon-5a5818c87fd00644788737-6"&gt;6&lt;/div&gt; &lt;div class="crayon-num" data-line="crayon-5a5818c87fd00644788737-7"&gt;7&lt;/div&gt; &lt;div class="crayon-num crayon-striped-num" data-line="crayon-5a5818c87fd00644788737-8"&gt;8&lt;/div&gt; &lt;/div&gt; &lt;/td&gt; &lt;td class="crayon-code"&gt;&lt;div class="crayon-pre" style="font-size: 12px !important; line-height: 15px !important; -moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4;"&gt; &lt;div class="crayon-line" id="crayon-5a5818c87fd00644788737-1"&gt; &lt;span class="crayon-r"&gt;library&lt;/span&gt;&lt;span class="crayon-sy"&gt;(&lt;/span&gt;&lt;span class="crayon-v"&gt;dplyr&lt;/span&gt;&lt;span class="crayon-sy"&gt;)&lt;/span&gt; &lt;/div&gt; &lt;div class="crayon-line crayon-striped-line" id="crayon-5a5818c87fd00644788737-2"&gt; &lt;span class="crayon-r"&gt;library&lt;/span&gt;&lt;span class="crayon-sy"&gt;(&lt;/span&gt;&lt;span class="crayon-v"&gt;knitr&lt;/span&gt;&lt;span class="crayon-sy"&gt;)&lt;/span&gt; &lt;/div&gt; &lt;div class="crayon-line" id="crayon-5a5818c87fd00644788737-3"&gt; &lt;span class="crayon-v"&gt;cars&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;&lt;&lt;/span&gt;&lt;span class="crayon-o"&gt;-&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-e"&gt;mtcars&lt;/span&gt; &lt;/div&gt; &lt;div class="crayon-line crayon-striped-line" id="crayon-5a5818c87fd00644788737-4"&gt; &lt;span class="crayon-v"&gt;colours&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;&lt;&lt;/span&gt;&lt;span class="crayon-o"&gt;-&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-e"&gt;data\_frame&lt;/span&gt;&lt;span class="crayon-sy"&gt;(&lt;/span&gt; &lt;/div&gt; &lt;div class="crayon-line" id="crayon-5a5818c87fd00644788737-5"&gt; &lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-v"&gt;cyl&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;=&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-e"&gt;unique&lt;/span&gt;&lt;span class="crayon-sy"&gt;(&lt;/span&gt;&lt;span class="crayon-v"&gt;cars&lt;/span&gt;&lt;span class="crayon-sy"&gt;$</span><span
class="crayon-v">cyl</span><span class="crayon-sy">)</span><span
class="crayon-sy">,</span>
</div>
 <span class="crayon-h"> </span><span
class="crayon-v">colour</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-e">c</span><span class="crayon-sy">(</span><span
class="crayon-s">"Blue"</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-s">"Green"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-s">"Eggplant"</span><span class="crayon-sy">)</span>

<span class="crayon-sy">)</span> 

<span class="crayon-e">kable</span><span class="crayon-sy">(</span><span
class="crayon-v">cars</span><span class="crayon-sy">\[</span><span
class="crayon-cn">1</span><span class="crayon-o">:</span><span
class="crayon-cn">10</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-sy">\]</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-c">\#kable is just for displaying the table</span>

</div>
</td>
</tr>
</table>
</div>
</div>
<p>
<img class="alignnone size-full wp-image-4503" src="https://www.ibpad.com.br/wp-content/uploads/2017/02/tabela-1.png" alt="" width="962" height="475" srcset="https://www.ibpad.com.br/wp-content/uploads/2017/02/tabela-1.png 962w, https://www.ibpad.com.br/wp-content/uploads/2017/02/tabela-1-260x128.png 260w, https://www.ibpad.com.br/wp-content/uploads/2017/02/tabela-1-768x379.png 768w, https://www.ibpad.com.br/wp-content/uploads/2017/02/tabela-1-100x49.png 100w" sizes="(max-width: 962px) 100vw, 962px">
</p>
<span class="crayon-title"></span>

<span class="crayon-language">R</span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
kable(colours)
</textarea>

<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
1

</td>
<td class="crayon-code">
<span class="crayon-e">kable</span><span class="crayon-sy">(</span><span
class="crayon-v">colours</span><span class="crayon-sy">)</span>

</td>
</tr>
</table>

<p>
<img class="alignnone size-full wp-image-4502" src="https://www.ibpad.com.br/wp-content/uploads/2017/02/tabela-2.png" alt="" width="963" height="184" srcset="https://www.ibpad.com.br/wp-content/uploads/2017/02/tabela-2.png 963w, https://www.ibpad.com.br/wp-content/uploads/2017/02/tabela-2-260x50.png 260w, https://www.ibpad.com.br/wp-content/uploads/2017/02/tabela-2-768x147.png 768w, https://www.ibpad.com.br/wp-content/uploads/2017/02/tabela-2-100x19.png 100w" sizes="(max-width: 963px) 100vw, 963px">
</p>
<p>
No Excel você provavelmente faria isso usando a função VLOOKUP(), que
leva uma chave e um intervalo e, em seguida, procuraria o valor dessa
chave dentro desse intervalo. Um exemplo de planilha dessa abordagem
pode ser
visto <a href="https://docs.google.com/spreadsheets/d/1K2IqdXX2MoUB4BorRcBcruS7spCvRtDwqXV-4gYAob4/edit">aqui</a>.
Observe que em cada célula de pesquisa existe alguma versão de
=vlookup(C4,$H2:I$5, 2, FALSE).
</p>
<p>
Isso ilustra algumas coisas. Primeiro, o cálculo tem a mesma forma que
os dados, e acontece no mesmo arquivo que os dados. Temos tantas
fórmulas quanto temos coisas que queremos pesquisar, e elas são
colocadas ao lado do conjunto de dados. Se você usou esta aproximação
você pode provavelmente recordar de erros no processo de escrever e de
encher esta fórmula. Em segundo lugar, os dados são referidos pela sua
localização na folha. Se movimentarmos a tabela de consulta para outra
folha, ou para outro lugar nessa folha, isso vai estragar a análise. Em
terceiro lugar, observe que a primeira entrada da coluna cyl no
armazenamento de planilha em C2 é armazenada como texto, o que causa
erro na função de pesquisa. Em R, você teria que armazenar todos os
valores de calendário como um vetor numérico ou de caracteres. Para
fazer a mesma coisa em R, nós usaríamos este código:
</p>
<span class="crayon-title"></span>

<span class="crayon-language">R</span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
left\_join(cars, colours, by = "cyl") %&gt;%  filter(row\_number() %in%
1:10) %&gt;% \# to display only a subset of the data   kable()
</textarea>

<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
1

2

3

</td>
<td class="crayon-code">
<span class="crayon-e">left\_join</span><span
class="crayon-sy">(</span><span class="crayon-v">cars</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">colours</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">by</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-s">"cyl"</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&gt;</span><span
class="crayon-o">%</span> <span class="crayon-h"> </span>

<span class="crayon-e">filter</span><span
class="crayon-sy">(</span><span class="crayon-e">row\_number</span><span
class="crayon-sy">(</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">%</span><span
class="crayon-st">in</span><span class="crayon-o">%</span><span
class="crayon-h"> </span><span class="crayon-cn">1</span><span
class="crayon-o">:</span><span class="crayon-cn">10</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&gt;</span><span
class="crayon-o">%</span><span class="crayon-h"> </span><span
class="crayon-c">\# to display only a subset of the data</span>

 <span class="crayon-h"> </span><span class="crayon-e">kable</span><span
class="crayon-sy">(</span><span class="crayon-sy">)</span>

</td>
</tr>
</table>

<p>
<img class="alignnone size-large wp-image-4578" src="https://www.ibpad.com.br/wp-content/uploads/2017/02/Tabela2-1024x455.jpg" alt="" width="900" height="400" srcset="https://www.ibpad.com.br/wp-content/uploads/2017/02/Tabela2-1024x455.jpg 1024w, https://www.ibpad.com.br/wp-content/uploads/2017/02/Tabela2-260x116.jpg 260w, https://www.ibpad.com.br/wp-content/uploads/2017/02/Tabela2-768x341.jpg 768w, https://www.ibpad.com.br/wp-content/uploads/2017/02/Tabela2-100x44.jpg 100w" sizes="(max-width: 900px) 100vw, 900px">Aqui
nós nos referimos aos dados pelo seu nome, usamos uma função para operar
em toda a tabela ao invés de linha a linha. Como a consistência é
imposta para cada vetor, não podemos armazenar acidentalmente uma
entrada de caractere em um vetor numérico.
</p>
<p>
<strong>Iteração</strong>
</p>
<p>
Se quiséssemos obter o deslocamento médio para cada cor de carro, a
maioria dos usuários de Excel provavelmente faria essa iteração
manualmente, primeiro selecionando a tabela, classificando-a por cor e,
em seguida, escolhendo os intervalos que eles queriam média analisar. Um
analista mais sofisticado provavelmente usaria a função averageif()para
escolher os critérios que eles queriam média, e assim evitaria alguns
erros. Ambas as abordagens são implementadas na guia iteração da
planilha.
</p>
<p>
Em R você faria algo como isto:
</p>
<span class="crayon-title"></span>

<span class="crayon-language">R</span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
left\_join(cars, colours, by = "cyl") %&gt;%   group\_by(colour) %&gt;%
  summarize(mean\_displacement = mean(disp)) %&gt;%   kable()
</textarea>

<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
1

2

3

4

</td>
<td class="crayon-code">
<span class="crayon-e">left\_join</span><span
class="crayon-sy">(</span><span class="crayon-v">cars</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">colours</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">by</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-s">"cyl"</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&gt;</span><span
class="crayon-o">%</span>

 <span class="crayon-h"> </span><span
class="crayon-e">group\_by</span><span class="crayon-sy">(</span><span
class="crayon-v">colour</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">%</span><span
class="crayon-o">&gt;</span><span class="crayon-o">%</span>

 <span class="crayon-h"> </span><span
class="crayon-e">summarize</span><span class="crayon-sy">(</span><span
class="crayon-v">mean\_displacement</span><span class="crayon-h">
</span><span class="crayon-o">=</span><span class="crayon-h">
</span><span class="crayon-e">mean</span><span
class="crayon-sy">(</span><span class="crayon-v">disp</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">%</span><span
class="crayon-o">&gt;</span><span class="crayon-o">%</span>

 <span class="crayon-h"> </span><span class="crayon-e">kable</span><span
class="crayon-sy">(</span><span class="crayon-sy">)</span>

</td>
</tr>
</table>

<p>
<img class="alignnone size-large wp-image-4579" src="https://www.ibpad.com.br/wp-content/uploads/2017/02/Tabela3-1024x179.jpg" alt="" width="900" height="157" srcset="https://www.ibpad.com.br/wp-content/uploads/2017/02/Tabela3-1024x179.jpg 1024w, https://www.ibpad.com.br/wp-content/uploads/2017/02/Tabela3-260x46.jpg 260w, https://www.ibpad.com.br/wp-content/uploads/2017/02/Tabela3-768x134.jpg 768w, https://www.ibpad.com.br/wp-content/uploads/2017/02/Tabela3-100x18.jpg 100w" sizes="(max-width: 900px) 100vw, 900px">O
que isto faz é pegar o conjunto de dados, dividi-lo pela variável de
agrupamento, neste caso, a cor, e, em seguida, aplicar a função na
função summarize de cada grupo. A diferença é que nós estamos nos
referindo às coisas pelo nome em vez da posição – há uma linha de código
que aplica a função ao conjunto de dados inteiro, e todas as ações
iterativas são armazenadas no script.
</p>
<p>
Generalização através de funções são um dos aspectos mais difíceis no
aprendizado de uma linguagem de programação. É importante falar sobre
elas pois são comuns e podem ser bastante desanimadoras para os usuários
do Excel, porque eles são totalmente estranhos ao seu fluxo de trabalho.
Uma função é uma maneira de usar código existente em novos objetos.  Uma
função que se encaixa no caso descrito acima pode parecer assim:
</p>
<span class="crayon-title"></span>

<span class="crayon-language">R</span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
join\_and\_summarize &lt;- function(df, colour\_df){   left\_join(df,
colour\_df, by = "cyl") %&gt;%     group\_by(colour) %&gt;%    
summarize(mean\_displacement = mean(disp)) }
</textarea>

<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
1

2

3

4

5

</td>
<td class="crayon-code">
<span class="crayon-v">join\_and\_summarize</span><span
class="crayon-h"> </span><span class="crayon-o">&lt;</span><span
class="crayon-o">-</span><span class="crayon-h"> </span><span
class="crayon-t">function</span><span class="crayon-sy">(</span><span
class="crayon-v">df</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">colour\_df</span><span
class="crayon-sy">)</span><span class="crayon-sy">{</span>

 <span class="crayon-h"> </span><span
class="crayon-e">left\_join</span><span class="crayon-sy">(</span><span
class="crayon-v">df</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">colour\_df</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">by</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"cyl"</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">%</span><span
class="crayon-o">&gt;</span><span class="crayon-o">%</span>

   <span class="crayon-h"> </span><span
class="crayon-e">group\_by</span><span class="crayon-sy">(</span><span
class="crayon-v">colour</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">%</span><span
class="crayon-o">&gt;</span><span class="crayon-o">%</span>

   <span class="crayon-h"> </span><span
class="crayon-e">summarize</span><span class="crayon-sy">(</span><span
class="crayon-v">mean\_displacement</span><span class="crayon-h">
</span><span class="crayon-o">=</span><span class="crayon-h">
</span><span class="crayon-e">mean</span><span
class="crayon-sy">(</span><span class="crayon-v">disp</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span>

<span class="crayon-sy">}</span>

</td>
</tr>
</table>

<p>
O que está entre as chaves <span id="crayon-5a5818c87fd0c602411667"
class="crayon-syntax crayon-syntax-inline crayon-theme-classic crayon-theme-classic-inline crayon-font-monaco"
style="font-size: 12px !important; line-height: 15px !important;font-size: 12px !important;"><span
class="crayon-pre crayon-code"
style="font-size: 12px !important; line-height: 15px !important;font-size: 12px !important; -moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4;"><span
class="crayon-t">function</span><span class="crayon-sy">(</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-sy">(</span><span class="crayon-e">dfe </span><span
class="crayon-v">colour\_df</span><span
class="crayon-sy">)</span></span></span>  são chamados de “argumentos”,
e quando você utiliza a função tudo o que faz é pegar os objetos reais
que você fornece à função e os conecta para onde quer que esse argumento
apareça dentro das chaves. Neste caso, nós ligaríamos cars para o
argumento dfe, e colours para o argumento colour\_df. A função, em
seguida, basicamente substitui todos os df com carros e colour\_df com
cores e, em seguida, avalia o código.
</p>
<span class="crayon-title"></span>

<span class="crayon-language">R</span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
join\_and\_summarize(cars, colours) %&gt;%   kable()
</textarea>

<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
1

2

</td>
<td class="crayon-code">
<span class="crayon-e">join\_and\_summarize</span><span
class="crayon-sy">(</span><span class="crayon-v">cars</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">colours</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">%</span><span
class="crayon-o">&gt;</span><span class="crayon-o">%</span>

 <span class="crayon-h"> </span><span class="crayon-e">kable</span><span
class="crayon-sy">(</span><span class="crayon-sy">)</span>

</td>
</tr>
</table>

<p>
<img class="alignnone size-large wp-image-4580" src="https://www.ibpad.com.br/wp-content/uploads/2017/02/tabela4-1024x183.jpg" alt="" width="900" height="161" srcset="https://www.ibpad.com.br/wp-content/uploads/2017/02/tabela4-1024x183.jpg 1024w, https://www.ibpad.com.br/wp-content/uploads/2017/02/tabela4-260x47.jpg 260w, https://www.ibpad.com.br/wp-content/uploads/2017/02/tabela4-768x138.jpg 768w, https://www.ibpad.com.br/wp-content/uploads/2017/02/tabela4-100x18.jpg 100w" sizes="(max-width: 900px) 100vw, 900px"><strong>Conclusão</strong>
</p>
<p>
Usuários de Excel têm uma maneira de pensar a análise de dados muito
rígida, e isso torna o aprendizado do de R mais difícil. No entanto,
aprender a programar permitirá que você faça coisas que você não pode
fazer no Excel, e realmente vale a pena a dor de aprender uma nova
linguagem.
</p>
</div>
</div>
</div>
</div>
</div>
</div>
<figure class="wpb_wrapper vc_figure">
<a href="https://www.ibpad.com.br/produto/ciencia-de-dados-com-r-df/" target="_blank" class="vc_single_image-wrapper   vc_box_border_grey"><img width="260" height="253" src="https://www.ibpad.com.br/wp-content/uploads/2017/09/Curso-de-programa%C3%A7%C3%A3o-em-R-260x253.png" class="vc_single_image-img attachment-medium" alt="" srcset="https://www.ibpad.com.br/wp-content/uploads/2017/09/Curso-de-programação-em-R-260x253.png 260w, https://www.ibpad.com.br/wp-content/uploads/2017/09/Curso-de-programação-em-R-100x97.png 100w, https://www.ibpad.com.br/wp-content/uploads/2017/09/Curso-de-programação-em-R.png 363w" sizes="(max-width: 260px) 100vw, 260px"></a>
</figure>

<p>
Se interessa em aprender mais sobre a programação e linguagem R na
prática? Conheça o curso presencial <strong>Ciência de Dados com
R</strong> que acontecerá no mês de novembro em
<a href="https://www.ibpad.com.br/produto/ciencia-de-dados-com-r-df/" target="_blank">Brasília</a>
e em
<a href="https://www.ibpad.com.br/produto/ciencia-de-dados-com-r-sp/" target="_blank">São
Paulo</a>. Este curso foi desenvolvido para que você aprenda a programar
e ter uma base sólida.
</p>

</div>

