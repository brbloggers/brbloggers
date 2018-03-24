+++
title = "Descobrindo quais são os pacotes de séries temporais mais populares do R"
date = "2018-03-19 21:20:14"
categories = ["IBPAD"]
original_url = "https://www.ibpad.com.br/blog/analise-de-dados/descobrindo-quais-sao-os-pacotes-de-series-temporais-mais-populares-r/"
+++

<div class="post-inner-content">
<div class="vc_row wpb_row vc_row-fluid">
<div class="wpb_column vc_column_container vc_col-sm-12">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<div class="wpb_text_column wpb_content_element ">
<div class="wpb_wrapper">
<p>
Sillas Gonzaga, Cientista de Dados e professor do curso
<a href="https://www.ibpad.com.br/produto/ciencia-de-dados-com-r-sp/" target="_blank">Ciência
de Dados com R</a>, elaborou este post com o objetivo de explicar como
utilizar códigos para descobrir quais pacotes de séries temporais são
mais utilizados na programação R.
</p>
<p>
Dentre os tópicos abordados, você verá:
</p>
<ul>
<li>
O que são as “Task views” do CRAN, o repositório oficial de pacotes do
R;
</li>
<li>
Um tutorial simples porém útil de Web Scraping, de manuseio de texto e
de expressões regulares (regex);
</li>
<li>
Um exemplo de manuseio de dados usando o
<a href="http://tidyverse.org/" target="_blank">tidyverse</a>;
</li>
<li>
Os 20 pacotes de séries temporais mais populares (em número de
downloads) do R.
</li>
</ul>
<h4>
Views do CRAN
</h4>
<p>
O R já ultrapassou a marca de
<a href="http://blog.revolutionanalytics.com/2017/01/cran-10000.html" target="_blank">10
mil pacotes</a> disponibilizados no CRAN, o repositório oficial de
pacotes do R. Não se tem notícia de nenhum outro programa estatístico
que possua tanta diversidade de aplicações, ainda mais de forma
gratuita. Mas isso também pode ter um lado ruim: como achar um pacote
que você precisa?
</p>
<p>
Para organizar e categorizar essa infinidade de pacotes, o pessoal do
CRAN tem uma página chamada
<a href="https://cran.r-project.org/web/views/" target="_blank">Task
Views</a>, onde os pacotes são divididos em 35 páginas: existem grupos
para
<a href="https://cran.r-project.org/web/views/Finance.html" target="_blank">Finanças</a>,
<a href="https://cran.r-project.org/web/views/Econometrics.html" target="_blank">Econometria</a>,
<a href="https://cran.r-project.org/web/views/MachineLearning.html" target="_blank">Machine
Learning</a>,
<a href="https://cran.r-project.org/web/views/Psychometrics.html" target="_blank">Psicometria</a>
e, claro,
<a href="https://cran.r-project.org/web/views/TimeSeries.html" target="_blank">Séries
Temporais</a>, além de outros.
</p>
<p>
O responsável pela Task View de Séries Temporais não é ninguém menos que
Rob Hyndman, um dos maiores especialistas do assunto no mundo.
</p>
<p>
Vamos então nos propor um desafio: contar, automaticamente, a quantidade
de pacotes listados na Task View de Séries Temporais por meio de Web
Scraping na página. Para isso, precisamos ler o código fonte da página,
extrair os links de pacotes e remover as duplicatas.
</p>
<h4>
Web scraping
</h4>
<p>
Para este tutorial, usamos os seguintes pacotes:
</p>
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
library(rvest) \# web scraping library(stringr) \# manipulação de text
(strings) library(tidyverse) \# suite de pacotes do tidyverse, como
dplyr e ggplot2 library(cranlogs) \# baixar logs de downloads de pacotes
do CRAN library(magrittr) \# ja que eu nao vivo sem em um bom %&lt;&gt;%
library(glue) \# para colar textos
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

</td>
<td class="crayon-code">
<span class="crayon-e">library</span><span
class="crayon-sy">(</span><span class="crayon-v">rvest</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-p">\# web scraping</span>

<span class="crayon-e">library</span><span
class="crayon-sy">(</span><span class="crayon-v">stringr</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-p">\# manipulação de text (strings)</span>

<span class="crayon-e">library</span><span
class="crayon-sy">(</span><span class="crayon-v">tidyverse</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-p">\# suite de pacotes do tidyverse, como dplyr e
ggplot2</span>

<span class="crayon-e">library</span><span
class="crayon-sy">(</span><span class="crayon-v">cranlogs</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-p">\# baixar logs de downloads de pacotes do CRAN</span>

<span class="crayon-e">library</span><span
class="crayon-sy">(</span><span class="crayon-v">magrittr</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-p">\# ja que eu nao vivo sem em um bom %&lt;&gt;%</span>

<span class="crayon-e">library</span><span
class="crayon-sy">(</span><span class="crayon-v">glue</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-p">\# para colar textos</span>

</td>
</tr>
</table>

<p>
Como o web scraping em si não é o objetivo principal do post, não vou
entrar em detalhes sobre o código escrito para extrair os links, mas os
comentários no código explicam parcialmente o que cada linha faz.
</p>
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
r view &lt;- "<https://cran.r-project.org/web/views/TimeSeries.html>"
urls &lt;- view %&gt;%
</textarea>

<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
1

2

</td>
<td class="crayon-code">
<span class="crayon-i">r</span><span class="crayon-h"> </span><span
class="crayon-v">view</span><span class="crayon-h"> </span><span
class="crayon-o">&</span><span class="crayon-v">lt</span><span
class="crayon-sy">;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span
class="crayon-s">"<https://cran.r-project.org/web/views/TimeSeries.html>"</span>

<span class="crayon-v">urls</span><span class="crayon-h"> </span><span
class="crayon-o">&</span><span class="crayon-v">lt</span><span
class="crayon-sy">;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-v">view</span><span
class="crayon-h"> </span><span class="crayon-o">%</span><span
class="crayon-o">&</span><span class="crayon-v">gt</span><span
class="crayon-sy">;</span><span class="crayon-o">%</span>

</td>
</tr>
</table>

<p>
</p>
<ul>
<li>
read<em>html %&gt;% \# lê o codigo fonte da pagina</em>
</li>
<li>
htmlnodes(“a”) %&gt;% \# filtra todo o texto dentro da tag html &lt; a
&gt;
</li>
<li>
html\_attr(“href”) \# filtra todo o texto cujo atributo é href (usado
para se referir a links)
</li>
</ul>
<h4>
Dando uma olhada no output
</h4>
<p>
</p>
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
urls %&gt;% head(20) \#\# \[1\]
"<https://CRAN.R-project.org/view=TimeSeries>"  
\#\# \[2\] "Econometrics.html"  
\#\# \[3\] "Finance.html"  
\#\# \[4\] "../packages/forecast/index.html"  
\#\# \[5\] "../packages/zoo/index.html"  
\#\# \[6\] "../packages/roll/index.html"  
\#\# \[7\] "../packages/forecast/index.html"  
\#\# \[8\] "../packages/SDD/index.html"  
\#\# \[9\] "../packages/dCovTS/index.html"  
\#\# \[10\] "../packages/forecast/index.html"  
\#\# \[11\] "../packages/Wats/index.html"  
\#\# \[12\] "../packages/ggseas/index.html"  
\#\# \[13\] "../packages/dygraphs/index.html"  
\#\# \[14\] "../packages/ZRA/index.html"  
\#\# \[15\] "../packages/forecast/index.html"  
\#\# \[16\] "../packages/forecast/index.html"  
\#\# \[17\] "../packages/vars/index.html"  
\#\# \[18\] "../packages/fanplot/index.html"  
\#\# \[19\] "<http://CRAN.R-project.org/doc/Rnews/Rnews_2004-1.pdf>"
\#\# \[20\] "../packages/zoo/index.html"
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

9

10

11

12

13

14

15

16

17

18

19

20

21

</td>
<td class="crayon-code">
<span class="crayon-v">urls</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&</span><span
class="crayon-v">gt</span><span class="crayon-sy">;</span><span
class="crayon-o">%</span><span class="crayon-h"> </span><span
class="crayon-e">head</span><span class="crayon-sy">(</span><span
class="crayon-cn">20</span><span class="crayon-sy">)</span>

<span class="crayon-h">   </span><span class="crayon-p">\#\#  \[1\]
"<https://CRAN.R-project.org/view=TimeSeries>"          </span>

<span class="crayon-h">    </span><span class="crayon-p">\#\#  \[2\]
"Econometrics.html"                                   </span>

<span class="crayon-h">    </span><span class="crayon-p">\#\#  \[3\]
"Finance.html"                                        </span>

<span class="crayon-h">    </span><span class="crayon-p">\#\#  \[4\]
"../packages/forecast/index.html"                     </span>

<span class="crayon-h">    </span><span class="crayon-p">\#\#  \[5\]
"../packages/zoo/index.html"                          </span>

<span class="crayon-h">    </span><span class="crayon-p">\#\#  \[6\]
"../packages/roll/index.html"                         </span>

<span class="crayon-h">    </span><span class="crayon-p">\#\#  \[7\]
"../packages/forecast/index.html"                     </span>

<span class="crayon-h">    </span><span class="crayon-p">\#\#  \[8\]
"../packages/SDD/index.html"                          </span>

<span class="crayon-h">    </span><span class="crayon-p">\#\#  \[9\]
"../packages/dCovTS/index.html"                       </span>

<span class="crayon-h">    </span><span class="crayon-p">\#\# \[10\]
"../packages/forecast/index.html"                     </span>

<span class="crayon-h">    </span><span class="crayon-p">\#\# \[11\]
"../packages/Wats/index.html"                         </span>

<span class="crayon-h">    </span><span class="crayon-p">\#\# \[12\]
"../packages/ggseas/index.html"                       </span>

<span class="crayon-h">    </span><span class="crayon-p">\#\# \[13\]
"../packages/dygraphs/index.html"                     </span>

<span class="crayon-h">    </span><span class="crayon-p">\#\# \[14\]
"../packages/ZRA/index.html"                          </span>

<span class="crayon-h">    </span><span class="crayon-p">\#\# \[15\]
"../packages/forecast/index.html"                     </span>

<span class="crayon-h">    </span><span class="crayon-p">\#\# \[16\]
"../packages/forecast/index.html"                     </span>

<span class="crayon-h">    </span><span class="crayon-p">\#\# \[17\]
"../packages/vars/index.html"                         </span>

<span class="crayon-h">    </span><span class="crayon-p">\#\# \[18\]
"../packages/fanplot/index.html"                      </span>

<span class="crayon-h">    </span><span class="crayon-p">\#\# \[19\]
"<http://CRAN.R-project.org/doc/Rnews/Rnews_2004-1.pdf>"</span>

<span class="crayon-h">    </span><span class="crayon-p">\#\# \[20\]
"../packages/zoo/index.html"</span>

</td>
</tr>
</table>

<p>
Notamos quatro problemas que precisamos consertar:
</p>
<ol>
<li>
É necessário extrair o nome dos pacotes de uma string do tipo
<code>../packages/zoo/index.html</code>, onde <code>zoo</code> é o nome
do pacote;
</li>
<li>
Links de pacotes vêm incompletos:
<code>../packages/zoo/index.html</code> ao invés de
<code><https://cran.r-project.org/web/packages/forecast/index.html></code>;
</li>
<li>
Muitos links além das urls de pacotes são extraídas;
</li>
<li>
Existem duplicatas.
</li>
</ol>
<p>
Vamos resolver um problema por vez (não necessariamente na ordem acima).
Primeiro, extraímos os strings que possuem o padrão
<code>/packages/</code> e removemos as duplicatas:
</p>
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
extrair apenas links com "../packages/"
=======================================

urls % head(20)
</textarea>

<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
1

2

</td>
<td class="crayon-code">
<span class="crayon-p">\# extrair apenas links com "../packages/"</span>

<span class="crayon-v">urls</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-h"> </span><span
class="crayon-e">head</span><span class="crayon-sy">(</span><span
class="crayon-cn">20</span><span class="crayon-sy">)</span>

</td>
</tr>
</table>

<p>
</p>
<div id="crayon-5ab6190b3a176860750013" class="crayon-syntax crayon-theme-classic crayon-font-monaco crayon-os-pc print-yes notranslate" data-settings=" minimize scroll-mouseover" style=" margin-top: 12px; margin-bottom: 12px; font-size: 12px !important; line-height: 15px !important;">
<span class="crayon-title"></span>

<div class="crayon-plain-wrap">
<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
    ##  [1] "../packages/forecast/index.html"  
    ##  [2] "../packages/zoo/index.html"       
    ##  [3] "../packages/roll/index.html"      
    ##  [4] "../packages/SDD/index.html"       
    ##  [5] "../packages/dCovTS/index.html"    
    ##  [6] "../packages/Wats/index.html"      
    ##  [7] "../packages/ggseas/index.html"    
    ##  [8] "../packages/dygraphs/index.html"  
    ##  [9] "../packages/ZRA/index.html"       
    ## [10] "../packages/vars/index.html"      
    ## [11] "../packages/fanplot/index.html"   
    ## [12] "../packages/chron/index.html"     
    ## [13] "../packages/lubridate/index.html" 
    ## [14] "../packages/timetk/index.html"    
    ## [15] "../packages/wktmo/index.html"     
    ## [16] "../packages/timeDate/index.html"  
    ## [17] "../packages/tis/index.html"       
    ## [18] "../packages/mondate/index.html"   
    ## [19] "../packages/tempdisagg/index.html"
    ## [20] "../packages/tsdisagg2/index.html"</textarea></div>

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

9

10

11

12

13

14

15

16

17

18

19

20

</td>
<td class="crayon-code">
<span class="crayon-h">    </span><span class="crayon-p">\#\#  \[1\]
"../packages/forecast/index.html"  </span>

<span class="crayon-h">    </span><span class="crayon-p">\#\#  \[2\]
"../packages/zoo/index.html"       </span>

<span class="crayon-h">    </span><span class="crayon-p">\#\#  \[3\]
"../packages/roll/index.html"      </span>

<span class="crayon-h">    </span><span class="crayon-p">\#\#  \[4\]
"../packages/SDD/index.html"       </span>

<span class="crayon-h">    </span><span class="crayon-p">\#\#  \[5\]
"../packages/dCovTS/index.html"    </span>

<span class="crayon-h">    </span><span class="crayon-p">\#\#  \[6\]
"../packages/Wats/index.html"      </span>

<span class="crayon-h">    </span><span class="crayon-p">\#\#  \[7\]
"../packages/ggseas/index.html"    </span>

<span class="crayon-h">    </span><span class="crayon-p">\#\#  \[8\]
"../packages/dygraphs/index.html"  </span>

<span class="crayon-h">    </span><span class="crayon-p">\#\#  \[9\]
"../packages/ZRA/index.html"       </span>

<span class="crayon-h">    </span><span class="crayon-p">\#\# \[10\]
"../packages/vars/index.html"      </span>

<span class="crayon-h">    </span><span class="crayon-p">\#\# \[11\]
"../packages/fanplot/index.html"   </span>

<span class="crayon-h">    </span><span class="crayon-p">\#\# \[12\]
"../packages/chron/index.html"     </span>

<span class="crayon-h">    </span><span class="crayon-p">\#\# \[13\]
"../packages/lubridate/index.html" </span>

<span class="crayon-h">    </span><span class="crayon-p">\#\# \[14\]
"../packages/timetk/index.html"    </span>

<span class="crayon-h">    </span><span class="crayon-p">\#\# \[15\]
"../packages/wktmo/index.html"     </span>

<span class="crayon-h">    </span><span class="crayon-p">\#\# \[16\]
"../packages/timeDate/index.html"  </span>

<span class="crayon-h">    </span><span class="crayon-p">\#\# \[17\]
"../packages/tis/index.html"       </span>

<span class="crayon-h">    </span><span class="crayon-p">\#\# \[18\]
"../packages/mondate/index.html"   </span>

<span class="crayon-h">    </span><span class="crayon-p">\#\# \[19\]
"../packages/tempdisagg/index.html"</span>

<span class="crayon-h">    </span><span class="crayon-p">\#\# \[20\]
"../packages/tsdisagg2/index.html"</span>

</td>
</tr>
</table>

</div>
<p>
Para extrair o nome dos pacotes, usamos uma aplicação simples de
expressões regulares para remover os caracteres
<code>../packages/</code> e <code>/index.html</code>.
</p>
<h4>
Extrair nome do pacote apenas do string
</h4>
<p>
</p>
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
pacotes % str\_replace\_all("\[..\]+/packages/|index.html|/", "")
</textarea>

<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
1

</td>
<td class="crayon-code">
<span class="crayon-v">pacotes</span><span class="crayon-h">
</span><span class="crayon-o">%</span><span class="crayon-h">
</span><span class="crayon-e">str\_replace\_all</span><span
class="crayon-sy">(</span><span
class="crayon-s">"\[..\]+/packages/|index.html|/"</span><span
class="crayon-sy">,</span><span class="crayon-h">  </span><span
class="crayon-s">""</span><span class="crayon-sy">)</span>

</td>
</tr>
</table>

<p>
</p>
<h4>
Classificar em ordem alfabética
</h4>
<p>
</p>
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
pacotes %&lt;&gt;% sort
</textarea>

<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
1

</td>
<td class="crayon-code">
<span class="crayon-v">pacotes</span><span class="crayon-h">
</span><span class="crayon-o">%</span><span
class="crayon-o">&</span><span class="crayon-v">lt</span><span
class="crayon-sy">;</span><span class="crayon-o">&</span><span
class="crayon-v">gt</span><span class="crayon-sy">;</span><span
class="crayon-o">%</span><span class="crayon-h"> </span><span
class="crayon-v">sort</span>

</td>
</tr>
</table>

<p>
</p>
<h4>
Ver como ficou
</h4>
<p>
pacotes %&gt;% head(20)
</p>
<div id="crayon-5ab6190b3a17e437967533" class="crayon-syntax crayon-theme-classic crayon-font-monaco crayon-os-pc print-yes notranslate" data-settings=" minimize scroll-mouseover" style=" margin-top: 12px; margin-bottom: 12px; font-size: 12px !important; line-height: 15px !important;">
<span class="crayon-title"></span>

<div class="crayon-plain-wrap">
<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
    ##  [1] "acp"         "AER"         "ArDec"       "arfima"      "astsa"      
    ##  [6] "autovarCore" "BAYSTAR"     "bentcableAR" "BETS"        "bfast"      
    ## [11] "BigVAR"      "biwavelet"   "BNPTSclust"  "boot"        "BootPR"     
    ## [16] "brainwaver"  "bspec"       "bsts"        "CADFtest"    "carx"</textarea></div>

<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
1

2

3

4

</td>
<td class="crayon-code">
<span class="crayon-h">    </span><span class="crayon-p">\#\#  \[1\]
"acp"         "AER"         "ArDec"      
"arfima"      "astsa"      </span>

<span class="crayon-h">    </span><span class="crayon-p">\#\#  \[6\]
"autovarCore" "BAYSTAR"     "bentcableAR"
"BETS"        "bfast"      </span>

<span class="crayon-h">    </span><span class="crayon-p">\#\# \[11\]
"BigVAR"      "biwavelet"   "BNPTSclust"  "boot"        "BootPR"    
</span>

<span class="crayon-h">    </span><span class="crayon-p">\#\# \[16\]
"brainwaver"  "bspec"       "bsts"        "CADFtest"    "carx"</span>

</td>
</tr>
</table>

</div>
<p>
Funcionou perfeitamente. Quantos pacotes temos no total?
</p>
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
pacotes %&gt;% length
</textarea>

<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
1

</td>
<td class="crayon-code">
<span class="crayon-v">pacotes</span><span class="crayon-h">
</span><span class="crayon-o">%</span><span
class="crayon-o">&</span><span class="crayon-v">gt</span><span
class="crayon-sy">;</span><span class="crayon-o">%</span><span
class="crayon-h"> </span><span class="crayon-v">length</span>

</td>
</tr>
</table>

<p>
</p>
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
\#\# \[1\] 234
</textarea>

<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
1

</td>
<td class="crayon-code">
<span class="crayon-h">  </span><span class="crayon-p">\#\# \[1\]
234</span>

</td>
</tr>
</table>

<p>
São impressionantes 234 pacotes relacionados a séries temporais! Vale a
pena ler a página da Task View de Séries Temporais para uma breve
descrição de cada um desses pacotes.
</p>
<h4>
Medindo a popularidade dos pacotes
</h4>
<p>
234 não são 10 mil, mas ainda assim é um número grande de pacotes para
quem usa ou quer começar a usar o R para análise de Séries Temporais.
Uma boa maneira de saber os pacotes mais importantes é medindo sua
popularidade em número de downloads nos últimos 30 dias.
</p>
<h4>
Baixar quantidade de downloads desses pacotes no ultimo mes
</h4>
<p>
</p>
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
dls &lt;- cran\_downloads(packages = pacotes, when = "last-month")
</textarea>

<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
1

</td>
<td class="crayon-code">
<span class="crayon-v">dls</span><span class="crayon-h"> </span><span
class="crayon-o">&</span><span class="crayon-v">lt</span><span
class="crayon-sy">;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span
class="crayon-e">cran\_downloads</span><span
class="crayon-sy">(</span><span class="crayon-v">packages</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-v">pacotes</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">when</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"last-month"</span><span class="crayon-sy">)</span>

</td>
</tr>
</table>

<p>
</p>
<h4>
Dando uma olhada no output
</h4>
<p>
head(dls)
</p>
<div id="crayon-5ab6190b3a186502230608" class="crayon-syntax crayon-theme-classic crayon-font-monaco crayon-os-pc print-yes notranslate" data-settings=" minimize scroll-mouseover" style=" margin-top: 12px; margin-bottom: 12px; font-size: 12px !important; line-height: 15px !important;">
<span class="crayon-title"></span>

<div class="crayon-plain-wrap">
<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
    ##         date count package
    ## 1 2017-06-30     7     acp
    ## 2 2017-07-01    11     acp
    ## 3 2017-07-02    13     acp
    ## 4 2017-07-03    13     acp
    ## 5 2017-07-04    16     acp
    ## 6 2017-07-05    14     acp</textarea></div>

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

</td>
<td class="crayon-code">
<span class="crayon-h">    </span><span class="crayon-p">\#\#        
date count package</span>

<span class="crayon-h">    </span><span class="crayon-p">\#\# 1
2017-06-30     7     acp</span>

<span class="crayon-h">    </span><span class="crayon-p">\#\# 2
2017-07-01    11     acp</span>

<span class="crayon-h">    </span><span class="crayon-p">\#\# 3
2017-07-02    13     acp</span>

<span class="crayon-h">    </span><span class="crayon-p">\#\# 4
2017-07-03    13     acp</span>

<span class="crayon-h">    </span><span class="crayon-p">\#\# 5
2017-07-04    16     acp</span>

<span class="crayon-h">    </span><span class="crayon-p">\#\# 6
2017-07-05    14     acp</span>

</td>
</tr>
</table>

</div>
<p>
A função resulta em um data frame simples de três colunas: data,
quantidade de downloads e nome do pacote. Vamos então fazer um gráfico
dos 20 pacotes mais baixados:
</p>
<h4>
Agrupar os dados usando o dplyr
</h4>
<p>
</p>
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
df % group\_by(package) %&gt;% summarise(total\_dls = sum(count, na.rm =
TRUE)) %&gt;% top\_n(20, total\_dls)
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
<span class="crayon-v">df</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">group\_by</span><span class="crayon-sy">(</span><span
class="crayon-t">package</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">%</span><span
class="crayon-o">&</span><span class="crayon-v">gt</span><span
class="crayon-sy">;</span><span class="crayon-o">%</span><span
class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">summarise</span><span class="crayon-sy">(</span><span
class="crayon-v">total\_dls</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-e">sum</span><span class="crayon-sy">(</span><span
class="crayon-v">count</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">na</span><span
class="crayon-sy">.</span><span class="crayon-v">rm</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-t">TRUE</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">%</span><span
class="crayon-o">&</span><span class="crayon-v">gt</span><span
class="crayon-sy">;</span><span class="crayon-o">%</span><span
class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">top\_n</span><span class="crayon-sy">(</span><span
class="crayon-cn">20</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">total\_dls</span><span
class="crayon-sy">)</span>

</td>
</tr>
</table>

<p>
</p>
<h4>
Eu costumo usar um tema pessoal meu para deixar os graficos do ggplot2
mais atraentes
</h4>
<p>
</p>
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
devtools::source\_gist("<https://gist.github.com/sillasgonzaga/ae62d57836c37ebff4a5f7a8dc32eeb7>",
filename = "meu\_tema.R") azul &lt;- "\#01a2d9" \# cor da barra

ggplot(df, aes(x = reorder(package, total\_dls), y = total\_dls)) +
geom\_col(fill = azul) + coord\_flip() + meu\_tema() +
geom\_text(aes(label = total\_dls), hjust = 1, color = "black", size =
3) + labs(x = "Pacote", y = "Downloads nos últimos 30 dias", title = "Os
20 pacotes sobre séries temporais do R mais baixados", subtitle =
"Fonte: Logs de download do CRAN (pacote cranlogs)")
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

9

10

11

</td>
<td class="crayon-code">
<span class="crayon-v">devtools</span><span
class="crayon-o">::</span><span
class="crayon-e">source\_gist</span><span
class="crayon-sy">(</span><span
class="crayon-s">"<https://gist.github.com/sillasgonzaga/ae62d57836c37ebff4a5f7a8dc32eeb7>"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">filename</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"meu\_tema.R"</span><span class="crayon-sy">)</span>

<span class="crayon-v">azul</span><span class="crayon-h"> </span><span
class="crayon-o">&</span><span class="crayon-v">lt</span><span
class="crayon-sy">;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-s">"\#01a2d9"</span><span
class="crayon-h"> </span><span class="crayon-p">\# cor da barra</span>

 

<span class="crayon-e">ggplot</span><span
class="crayon-sy">(</span><span class="crayon-v">df</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-e">aes</span><span class="crayon-sy">(</span><span
class="crayon-v">x</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-e">reorder</span><span class="crayon-sy">(</span><span
class="crayon-t">package</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">total\_dls</span><span
class="crayon-sy">)</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">y</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-v">total\_dls</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">+</span>

<span class="crayon-h">    </span><span
class="crayon-e">geom\_col</span><span class="crayon-sy">(</span><span
class="crayon-v">fill</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">azul</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">+</span>

<span class="crayon-h">    </span><span
class="crayon-e">coord\_flip</span><span class="crayon-sy">(</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">+</span><span class="crayon-h"> </span>

<span class="crayon-h">    </span><span
class="crayon-e">meu\_tema</span><span class="crayon-sy">(</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">+</span>

<span class="crayon-h">    </span><span
class="crayon-e">geom\_text</span><span class="crayon-sy">(</span><span
class="crayon-e">aes</span><span class="crayon-sy">(</span><span
class="crayon-v">label</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">total\_dls</span><span class="crayon-sy">)</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">hjust</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-cn">1</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">color</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-s">"black"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">size</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-cn">3</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">+</span>

<span class="crayon-h">    </span><span
class="crayon-e">labs</span><span class="crayon-sy">(</span><span
class="crayon-v">x</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"Pacote"</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">y</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-s">"Downloads nos últimos
30 dias"</span><span class="crayon-sy">,</span>

<span class="crayon-h">         </span><span
class="crayon-v">title</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"Os 20 pacotes sobre séries temporais do R mais
baixados"</span><span class="crayon-sy">,</span>

<span class="crayon-h">         </span><span
class="crayon-v">subtitle</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"Fonte: Logs de download do CRAN (pacote
cranlogs)"</span><span class="crayon-sy">)</span>

</td>
</tr>
</table>

<p>
</p>
</div>
</div>
<figure class="wpb_wrapper vc_figure">
<a data-rel="prettyPhoto[rel-19286-2137512401]" href="https://www.ibpad.com.br/wp-content/uploads/2018/03/grafico-1.png" target="_self" class="vc_single_image-wrapper   vc_box_border_grey prettyphoto"><img width="672" height="480" src="https://www.ibpad.com.br/wp-content/uploads/2018/03/grafico-1.png" class="vc_single_image-img attachment-full" alt="" srcset="https://www.ibpad.com.br/wp-content/uploads/2018/03/grafico-1.png 672w, https://www.ibpad.com.br/wp-content/uploads/2018/03/grafico-1-260x186.png 260w, https://www.ibpad.com.br/wp-content/uploads/2018/03/grafico-1-100x71.png 100w" sizes="(max-width: 672px) 100vw, 672px"></a>
</figure>

<p>
Confesso que, desses 20 pacotes, conheço apenas o zoo, lubridate,
forecast, xts, fpp, dygraphs e vars. Vale o exercício de entrar nas
páginas desses pacotes para entender o porquê de suas popularidades.
</p>

<span class="vc_sep_holder vc_sep_holder_l"><span
class="vc_sep_line"></span></span><span
class="vc_sep_holder vc_sep_holder_r"><span
class="vc_sep_line"></span></span>

</div>
</div>
</div>
</div>
<figure class="wpb_wrapper vc_figure">
<a href="https://www.ibpad.com.br/produto/ciencia-de-dados-com-r-sp/" target="_self" class="vc_single_image-wrapper   vc_box_border_grey"><img width="1112" height="1180" src="https://www.ibpad.com.br/wp-content/uploads/2016/11/CDR.jpg" class="vc_single_image-img attachment-full" alt="" srcset="https://www.ibpad.com.br/wp-content/uploads/2016/11/CDR.jpg 1112w, https://www.ibpad.com.br/wp-content/uploads/2016/11/CDR-260x276.jpg 260w, https://www.ibpad.com.br/wp-content/uploads/2016/11/CDR-768x815.jpg 768w, https://www.ibpad.com.br/wp-content/uploads/2016/11/CDR-965x1024.jpg 965w, https://www.ibpad.com.br/wp-content/uploads/2016/11/CDR-94x100.jpg 94w" sizes="(max-width: 1112px) 100vw, 1112px"></a>
</figure>

<p>
Tem o interesse de aprender como aproveitar melhor o R e suas aplicações
em diversos tipos de projetos? Aproveite e venha participar das novas
turmas do
curso <strong><a href="https://www.ibpad.com.br/produto/ciencia-de-dados-com-r-sp/" target="_blank">Ciência
de Dados com R</a></strong>. O curso presencial acontecerá
em <a href="https://www.ibpad.com.br/produto/ciencia-de-dados-com-r-df" target="_blank">Brasilia</a> e
em <a href="https://www.ibpad.com.br/produto/ciencia-de-dados-com-r-sp/" target="_blank">São
Paulo</a> e você já pode se inscrever! Te aguardamos para trocar
experiências e praticar os aprendizados.
</p>

</div>

