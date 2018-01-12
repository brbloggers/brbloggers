+++
title = "Prophet vs forecast vs mafs: Qual o melhor pacote para séries temporais?"
date = "2017-10-03 11:33:02"
categories = ["IBPAD"]
original_url = "https://www.ibpad.com.br/blog/analise-de-dados/prophet-vs-forecast-vs-mafs-qual-o-melhor-pacote-para-series-temporais/"
+++

<div class="post-inner-content">
<p>
Spoiler: Depende!
</p>
<p>
Neste post, falaremos sobre: Os pacotes <code>prophet</code>,
<code>forecast</code> e <code>mafs</code>, três pacotes para previsão de
Séries temporais e o pacote cranlogs é para baixar os dados de downloads
do CRAN.
</p>
<span class="crayon-title"></span>

<span class="crayon-language">R</span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
library(mafs) library(prophet) library(cranlogs) library(tidyverse)
library(lubridate)
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
<span class="crayon-r">library</span><span
class="crayon-sy">(</span><span class="crayon-v">mafs</span><span
class="crayon-sy">)</span>

<span class="crayon-r">library</span><span
class="crayon-sy">(</span><span class="crayon-v">prophet</span><span
class="crayon-sy">)</span>

<span class="crayon-r">library</span><span
class="crayon-sy">(</span><span class="crayon-v">cranlogs</span><span
class="crayon-sy">)</span>

<span class="crayon-r">library</span><span
class="crayon-sy">(</span><span class="crayon-v">tidyverse</span><span
class="crayon-sy">)</span>

<span class="crayon-r">library</span><span
class="crayon-sy">(</span><span class="crayon-v">lubridate</span><span
class="crayon-sy">)</span>

</td>
</tr>
</table>

<p>
 
</p>

<p>
 
</p>
<blockquote>
<p style="text-align: right;">
<a href="https://www.ibpad.com.br/produto/series-temporais-sp/" target="_blank">Prof.
Sillas Gonzaga é professor do curso de Séries Temporais do IBPAD.
Inscrições abertas em São Paulo.</a>
</p>
</blockquote>
<p>
 
</p>
<h2>
Pacotes de previsão de séries temporais no R
</h2>
<p>
<code>Prophet</code> é um pacote para R e Python que implementa o
algoritmo de previsão de séries temporais usado em produção no Facebook.
Ele foi programado para detectar automaticamente os padrões sazonais de
uma série de input, sem precisar de ajustes manuais. Contudo, é possível
customizar alguns inputs de parâmetros, como indicar a presença de
períodos sazonais (semanal ou anual), feriados e changepoints. O método
é descrito por inteiro <a href="https://peerj.com/preprints/3190/">neste
paper</a>. Os pacotes para R e Python são apenas uma simples interface
para cálculos realizados em <a href="http://mc-stan.org/">Stan</a>.
Segundo a própria equipe de desenvolvimento, o Prophet funciona melhor
com séries temporais de frequência diária, com pelo menos um ano de
dado, sendo robusto a dados ausentes (NA), mudanças na tendência e
outliers.
</p>
<p>
<code>forecast</code> é um pacote para R criado
por <a href="https://robjhyndman.com/">Rob Hyndmann</a>, um dos maiores
especialistas em Séries Temporais do mundo e autor do livro online
gratuito <a href="https://www.otexts.org/fpp/">Forecasting: principles
and practice</a>, uma excelente referência no tema. O pacote, além de
funções muito úteis de visualização e tratamento de séries temporais,
possui funções para ajustar dezenas de diferentes tipos de modelos de
séries temporais, como ARIMA, suavização exponencial, Croston e Redes
Neurais. Fácil de usar, possui também funções de previsão e avaliação de
acurácia.
</p>
<p>
<code>mafs</code> é um pacote criado por mim, durante a elaboração do
meu TCC na graduação de Engenharia de Produção. Eu queria fazer algo
relacionado a previsão de demanda em larga escala, mas não sabia direito
qual modelo escolher para cada série (uma tarefa das mais difícieis em
séries temporais). A partir desse problema, desenvolvi um método
automatizado de seleção do melhor modelo de previsão, que acabou virando
o <code>mafs</code>. Resumidamente, sua principal
função, <code>select\_forecast()</code>, recebe uma série temporal de
input, divide-a em séries de treino e de teste, ajusta 17 (ou menos, de
acordo com a opção do usuário) modelos de previsão contidos no
pacote <code>forecast</code> na série de treino, obtem previsões para
cada modelo e as compara com a série de teste por meio de uma métrica de
erro (como o MAPE) escolhida pelo usuário. O modelo de melhor erro é
então selecionado para prever valores futuros para a série.
</p>
<p>
Faremos então um exercício de comparar a acurácia dos
pacotes <code>prophet</code> e <code>mafs</code> (e por tabela
o <code>forecast</code>) usando a série temporal de downloads diários do
pacote <code>forecast</code> (o mais popular dos três).
</p>

<h2>
Coleta dos dados
</h2>
<p>
Vamos definir os parâmetros de data de nossa query:
</p>
<span class="crayon-title"></span>

<span class="crayon-language">R</span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
data\_inicio &lt;- as.Date("2015-09-30") data\_fim &lt;-
as.Date("2017-09-30") df\_dls &lt;- cran\_downloads(packages =
"forecast", from = data\_inicio, to = data\_fim)

knitr::kable(head(df\_dls))
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
<span class="crayon-v">data\_inicio</span><span class="crayon-h">
</span><span class="crayon-o">&lt;</span><span
class="crayon-o">-</span><span class="crayon-h"> </span><span
class="crayon-st">as</span><span class="crayon-sy">.</span><span
class="crayon-e">Date</span><span class="crayon-sy">(</span><span
class="crayon-s">"2015-09-30"</span><span class="crayon-sy">)</span>

<span class="crayon-v">data\_fim</span><span class="crayon-h">
</span><span class="crayon-o">&lt;</span><span
class="crayon-o">-</span><span class="crayon-h"> </span><span
class="crayon-st">as</span><span class="crayon-sy">.</span><span
class="crayon-e">Date</span><span class="crayon-sy">(</span><span
class="crayon-s">"2017-09-30"</span><span class="crayon-sy">)</span>

<span class="crayon-v">df\_dls</span><span class="crayon-h">
</span><span class="crayon-o">&lt;</span><span
class="crayon-o">-</span><span class="crayon-h"> </span><span
class="crayon-e">cran\_downloads</span><span
class="crayon-sy">(</span><span class="crayon-v">packages</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-s">"forecast"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">from</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">data\_inicio</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-st">to</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">data\_fim</span><span class="crayon-sy">)</span>

 

<span class="crayon-v">knitr</span><span class="crayon-o">::</span><span
class="crayon-e">kable</span><span class="crayon-sy">(</span><span
class="crayon-e">head</span><span class="crayon-sy">(</span><span
class="crayon-v">df\_dls</span><span class="crayon-sy">)</span><span
class="crayon-sy">)</span>

</td>
</tr>
</table>

<p>
 
</p>
<table class="table table-condensed">
<thead>
<tr class="header">
<th align="left">
date
</th>
<th align="right">
count
</th>
<th align="left">
package
</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">
2015-09-30
</td>
<td align="right">
639
</td>
<td align="left">
forecast
</td>
</tr>
<tr class="even">
<td align="left">
2015-10-01
</td>
<td align="right">
770
</td>
<td align="left">
forecast
</td>
</tr>
<tr class="odd">
<td align="left">
2015-10-02
</td>
<td align="right">
644
</td>
<td align="left">
forecast
</td>
</tr>
<tr class="even">
<td align="left">
2015-10-03
</td>
<td align="right">
486
</td>
<td align="left">
forecast
</td>
</tr>
<tr class="odd">
<td align="left">
2015-10-04
</td>
<td align="right">
501
</td>
<td align="left">
forecast
</td>
</tr>
<tr class="even">
<td align="left">
2015-10-05
</td>
<td align="right">
670
</td>
<td align="left">
forecast
</td>
</tr>
</tbody>
</table>
<p>
Vemos que o dataframe <code>df\_dls</code> possui três colunas: a
primeira indica a data, a segunda a quantidade de downloads do pacote
naquele dia e a terceira a qual pacote os dados se referem.
</p>
<p>
Primeiramente, será que tem algum buraco nos dados? Vamos fazer uma
verificação:
</p>
<span class="crayon-title"></span>

<span class="crayon-language">R</span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
vetor\_datas &lt;- seq.Date(from =
min(df\_dls*d**a**t**e*),*t**o* = *m**a**x*(*d**f*<sub>*d*</sub>*l**s*date),
by = "1 day") length(vetor\_datas) == nrow(df\_dls) \#\# \[1\] TRUE
</textarea>

<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
1

2

3

</td>
<td class="crayon-code">
<span class="crayon-v">vetor\_datas</span><span class="crayon-h">
</span><span class="crayon-o">&lt;</span><span
class="crayon-o">-</span><span class="crayon-h"> </span><span
class="crayon-v">seq</span><span class="crayon-sy">.</span><span
class="crayon-e">Date</span><span class="crayon-sy">(</span><span
class="crayon-v">from</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-e">min</span><span class="crayon-sy">(</span><span
class="crayon-v">df\_dls</span><span
class="crayon-sy">$&lt;/span&gt;&lt;span class="crayon-v"&gt;date&lt;/span&gt;&lt;span class="crayon-sy"&gt;)&lt;/span&gt;&lt;span class="crayon-sy"&gt;,&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-st"&gt;to&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;=&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-e"&gt;max&lt;/span&gt;&lt;span class="crayon-sy"&gt;(&lt;/span&gt;&lt;span class="crayon-v"&gt;df\_dls&lt;/span&gt;&lt;span class="crayon-sy"&gt;$</span><span
class="crayon-v">date</span><span class="crayon-sy">)</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">by</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"1 day"</span><span class="crayon-sy">)</span>

<span class="crayon-e">length</span><span
class="crayon-sy">(</span><span
class="crayon-v">vetor\_datas</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">==</span><span class="crayon-h"> </span><span
class="crayon-e">nrow</span><span class="crayon-sy">(</span><span
class="crayon-v">df\_dls</span><span class="crayon-sy">)</span>

<span class="crayon-c">\#\# \[1\] TRUE</span>

</td>
</tr>
</table>

<p>
O TRUE acima indica que não temos nenhum buraco nos dados. Isto é, caso
haja algum dia onde ninguém baixou o <code>forecast</code>, o dado
informado será 0 ao invés de NA.
</p>
<p>
A melhor maneira de visualizar os dados que temos é por meio de um
gráfico de linha do <code>ggplot2</code>:
</p>
<span class="crayon-title"></span>

<span class="crayon-language">R</span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
ggplot(df\_dls, aes(x = date, y = count)) + geom\_line() +
theme\_minimal() + labs(x = NULL, y = NULL, title = "Quantidade de
downloads diários do pacote forecast") + scale\_x\_date(date\_labels =
"%m/%Y", date\_breaks = "3 months")
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
<span class="crayon-e">ggplot</span><span
class="crayon-sy">(</span><span class="crayon-v">df\_dls</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-e">aes</span><span class="crayon-sy">(</span><span
class="crayon-v">x</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">date</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">y</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-v">count</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">+</span>

<span class="crayon-h">  </span><span
class="crayon-e">geom\_line</span><span class="crayon-sy">(</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">+</span>

<span class="crayon-h">  </span><span
class="crayon-e">theme\_minimal</span><span
class="crayon-sy">(</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">+</span><span
class="crayon-h"> </span>

<span class="crayon-h">  </span><span class="crayon-e">labs</span><span
class="crayon-sy">(</span><span class="crayon-v">x</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-t">NULL</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">y</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-t">NULL</span><span class="crayon-sy">,</span>

<span class="crayon-h">       </span><span
class="crayon-v">title</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"Quantidade de downloads diários do pacote
forecast"</span><span class="crayon-sy">)</span><span class="crayon-h">
</span><span class="crayon-o">+</span>

<span class="crayon-h">  </span><span
class="crayon-e">scale\_x\_date</span><span
class="crayon-sy">(</span><span
class="crayon-v">date\_labels</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"%m/%Y"</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">date\_breaks</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-s">"3 months"</span><span
class="crayon-sy">)</span>

</td>
</tr>
</table>

<p>
 
</p>

<p>
<img class="size-full wp-image-11946" src="https://www.ibpad.com.br/wp-content/uploads/2017/10/unnamed-chunk-4-1.png" alt="" width="672" height="480" srcset="https://www.ibpad.com.br/wp-content/uploads/2017/10/unnamed-chunk-4-1.png 672w, https://www.ibpad.com.br/wp-content/uploads/2017/10/unnamed-chunk-4-1-260x186.png 260w, https://www.ibpad.com.br/wp-content/uploads/2017/10/unnamed-chunk-4-1-100x71.png 100w" sizes="(max-width: 672px) 100vw, 672px">
</p>
<p>
Existem alguns outliers na série. Como além de ser difícil prever esses
picos é improvável que eles aconteçam novamente, vamos os retirar da
série:
</p>
<span class="crayon-title"></span>

<span class="crayon-language">R</span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
df\_dls &lt;- df\_dls %&gt;% filter(date &gt;= as.Date("2017-02-01"))
</textarea>

<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
1

</td>
<td class="crayon-code">
<span class="crayon-v">df\_dls</span><span class="crayon-h">
</span><span class="crayon-o">&lt;</span><span
class="crayon-o">-</span><span class="crayon-h"> </span><span
class="crayon-v">df\_dls</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&gt;</span><span
class="crayon-o">%</span><span class="crayon-h"> </span><span
class="crayon-e">filter</span><span class="crayon-sy">(</span><span
class="crayon-v">date</span><span class="crayon-h"> </span><span
class="crayon-o">&gt;=</span><span class="crayon-h"> </span><span
class="crayon-st">as</span><span class="crayon-sy">.</span><span
class="crayon-e">Date</span><span class="crayon-sy">(</span><span
class="crayon-s">"2017-02-01"</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span>

</td>
</tr>
</table>

<p>
 
</p>

<h2>
Obtendo previsões para a série
</h2>
<p>
Para este post, vamos simular que o objetivo é prever o mês de Setembro
da série, usando o restante como conjunto de treino.
</p>
<span class="crayon-title"></span>

<span class="crayon-language">R</span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
definir conjuntos de treino e teste
===================================

data\_treino &lt;- as.Date("2017-09-01")
</textarea>

<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
1

2

</td>
<td class="crayon-code">
<span class="crayon-c">\# definir conjuntos de treino e teste</span>

<span class="crayon-v">data\_treino</span><span class="crayon-h">
</span><span class="crayon-o">&lt;</span><span
class="crayon-o">-</span><span class="crayon-h"> </span><span
class="crayon-st">as</span><span class="crayon-sy">.</span><span
class="crayon-e">Date</span><span class="crayon-sy">(</span><span
class="crayon-s">"2017-09-01"</span><span class="crayon-sy">)</span>

</td>
</tr>
</table>

<p>
 
</p>
<h3>
Prophet
</h3>
<p>
A função de ajuste de modelo <code>prophet::prophet()</code> exige que o
data frame de input possua duas colunas: uma chamada <code>ds</code>,
com o vetor de datas, e uma chamada <code>y</code>, com o vetor numérico
da variável que se deseja prever. Aliás, uma crítica pessoal minha
ao <code>prophet</code> é a de eles usarem dataframes como objetos de
input, e não objetos do tipo <code>ts</code>, que é o normal no R para
séries temporais.
</p>
<span class="crayon-title"></span>

<span class="crayon-language">R</span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
df\_dls &lt;- df\_dls %&gt;% select(ds = date, y = count) df\_treino
&lt;- df\_dls %&gt;% filter(ds &lt; data\_treino) df\_teste &lt;-
df\_dls %&gt;% filter(ds &gt;= data\_treino) nn &lt;- nrow(df\_teste)
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
<span class="crayon-v">df\_dls</span><span class="crayon-h">
</span><span class="crayon-o">&lt;</span><span
class="crayon-o">-</span><span class="crayon-h"> </span><span
class="crayon-v">df\_dls</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&gt;</span><span
class="crayon-o">%</span><span class="crayon-h"> </span><span
class="crayon-e">select</span><span class="crayon-sy">(</span><span
class="crayon-v">ds</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">date</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">y</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-v">count</span><span
class="crayon-sy">)</span>

<span class="crayon-v">df\_treino</span><span class="crayon-h">
</span><span class="crayon-o">&lt;</span><span
class="crayon-o">-</span><span class="crayon-h"> </span><span
class="crayon-v">df\_dls</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&gt;</span><span
class="crayon-o">%</span><span class="crayon-h"> </span><span
class="crayon-e">filter</span><span class="crayon-sy">(</span><span
class="crayon-v">ds</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-h"> </span><span
class="crayon-v">data\_treino</span><span class="crayon-sy">)</span>

<span class="crayon-v">df\_teste</span><span class="crayon-h">
</span><span class="crayon-o">&lt;</span><span
class="crayon-o">-</span><span class="crayon-h"> </span><span
class="crayon-v">df\_dls</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&gt;</span><span
class="crayon-o">%</span><span class="crayon-h"> </span><span
class="crayon-e">filter</span><span class="crayon-sy">(</span><span
class="crayon-v">ds</span><span class="crayon-h"> </span><span
class="crayon-o">&gt;=</span><span class="crayon-h"> </span><span
class="crayon-v">data\_treino</span><span class="crayon-sy">)</span>

<span class="crayon-v">nn</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-e">nrow</span><span
class="crayon-sy">(</span><span class="crayon-v">df\_teste</span><span
class="crayon-sy">)</span>

</td>
</tr>
</table>

<p>
 
</p>
<p>
As principais funções do <code>prophet</code> são mostradas abaixo:
</p>
<span class="crayon-title"></span>

<span class="crayon-language">R</span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
fitar modelo prophet
====================

mod\_prophet &lt;- prophet(df\_treino) \#\# Initial log joint
probability = -2.90115 \#\# Optimization terminated normally: \#\#
Convergence detected: absolute parameter change was below tolerance
fcast\_prophet &lt;- predict(mod\_prophet,
make\_future\_dataframe(mod\_prophet, periods = nn))
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

</td>
<td class="crayon-code">
<span class="crayon-c">\# fitar modelo prophet</span>

<span class="crayon-v">mod\_prophet</span><span class="crayon-h">
</span><span class="crayon-o">&lt;</span><span
class="crayon-o">-</span><span class="crayon-h"> </span><span
class="crayon-e">prophet</span><span class="crayon-sy">(</span><span
class="crayon-v">df\_treino</span><span class="crayon-sy">)</span>

<span class="crayon-c">\#\# Initial log joint probability =
-2.90115</span>

<span class="crayon-c">\#\# Optimization terminated normally: </span>

<span class="crayon-c">\#\#   Convergence detected: absolute parameter
change was below tolerance</span>

<span class="crayon-v">fcast\_prophet</span><span class="crayon-h">
</span><span class="crayon-o">&lt;</span><span
class="crayon-o">-</span><span class="crayon-h"> </span><span
class="crayon-e">predict</span><span class="crayon-sy">(</span><span
class="crayon-v">mod\_prophet</span><span class="crayon-sy">,</span>

<span class="crayon-h">                         </span><span
class="crayon-e">make\_future\_dataframe</span><span
class="crayon-sy">(</span><span
class="crayon-v">mod\_prophet</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">periods</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">nn</span><span class="crayon-sy">)</span><span
class="crayon-sy">)</span>

</td>
</tr>
</table>

<p>
 
</p>
<p>
É possível visualizar as previsões fornecidas pelo <code>prophet</code>:
</p>
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
plot(mod\_prophet, fcast\_prophet)
</textarea>

<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
1

</td>
<td class="crayon-code">
<span class="crayon-e">plot</span><span class="crayon-sy">(</span><span
class="crayon-v">mod\_prophet</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">fcast\_prophet</span><span class="crayon-sy">)</span>

</td>
</tr>
</table>

<p>
 
</p>

<p>
<img class="aligncenter size-full wp-image-11948" src="https://www.ibpad.com.br/wp-content/uploads/2017/10/unnamed-chunk-9-1.png" alt="" width="672" height="480" srcset="https://www.ibpad.com.br/wp-content/uploads/2017/10/unnamed-chunk-9-1.png 672w, https://www.ibpad.com.br/wp-content/uploads/2017/10/unnamed-chunk-9-1-260x186.png 260w, https://www.ibpad.com.br/wp-content/uploads/2017/10/unnamed-chunk-9-1-100x71.png 100w" sizes="(max-width: 672px) 100vw, 672px">
</p>
<p>
A tabela abaixo mostra uma pequena parte do dataframe de output:
</p>
<span class="crayon-title"></span>

<span class="crayon-language">R</span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
knitr::kable(head(fcast\_prophet))
</textarea>

<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
1

</td>
<td class="crayon-code">
<span class="crayon-v">knitr</span><span class="crayon-o">::</span><span
class="crayon-e">kable</span><span class="crayon-sy">(</span><span
class="crayon-e">head</span><span class="crayon-sy">(</span><span
class="crayon-v">fcast\_prophet</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span>

</td>
</tr>
</table>

<p>
 
</p>
<table class="table table-condensed">
<thead>
<tr class="header">
<th align="left">
ds
</th>
<th align="right">
trend
</th>
<th align="right">
seasonal
</th>
<th align="right">
seasonalities
</th>
<th align="right">
seasonalities\_lower
</th>
<th align="right">
seasonalities\_upper
</th>
<th align="right">
seasonal\_lower
</th>
<th align="right">
seasonal\_upper
</th>
<th align="right">
weekly
</th>
<th align="right">
weekly\_lower
</th>
<th align="right">
weekly\_upper
</th>
<th align="right">
yhat\_lower
</th>
<th align="right">
yhat\_upper
</th>
<th align="right">
trend\_lower
</th>
<th align="right">
trend\_upper
</th>
<th align="right">
yhat
</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">
2017-02-01
</td>
<td align="right">
2630.864
</td>
<td align="right">
264.016251
</td>
<td align="right">
264.016251
</td>
<td align="right">
264.016251
</td>
<td align="right">
264.016251
</td>
<td align="right">
264.016251
</td>
<td align="right">
264.016251
</td>
<td align="right">
264.016251
</td>
<td align="right">
264.016251
</td>
<td align="right">
264.016251
</td>
<td align="right">
2084.346
</td>
<td align="right">
3657.371
</td>
<td align="right">
2630.864
</td>
<td align="right">
2630.864
</td>
<td align="right">
2894.880
</td>
</tr>
<tr class="even">
<td align="left">
2017-02-02
</td>
<td align="right">
2634.808
</td>
<td align="right">
393.889195
</td>
<td align="right">
393.889195
</td>
<td align="right">
393.889195
</td>
<td align="right">
393.889195
</td>
<td align="right">
393.889195
</td>
<td align="right">
393.889195
</td>
<td align="right">
393.889195
</td>
<td align="right">
393.889195
</td>
<td align="right">
393.889195
</td>
<td align="right">
2226.090
</td>
<td align="right">
3791.494
</td>
<td align="right">
2634.808
</td>
<td align="right">
2634.808
</td>
<td align="right">
3028.697
</td>
</tr>
<tr class="odd">
<td align="left">
2017-02-03
</td>
<td align="right">
2638.751
</td>
<td align="right">
8.692494
</td>
<td align="right">
8.692494
</td>
<td align="right">
8.692494
</td>
<td align="right">
8.692494
</td>
<td align="right">
8.692494
</td>
<td align="right">
8.692494
</td>
<td align="right">
8.692494
</td>
<td align="right">
8.692494
</td>
<td align="right">
8.692494
</td>
<td align="right">
1860.844
</td>
<td align="right">
3467.157
</td>
<td align="right">
2638.751
</td>
<td align="right">
2638.751
</td>
<td align="right">
2647.444
</td>
</tr>
<tr class="even">
<td align="left">
2017-02-04
</td>
<td align="right">
2642.695
</td>
<td align="right">
-645.710391
</td>
<td align="right">
-645.710391
</td>
<td align="right">
-645.710391
</td>
<td align="right">
-645.710391
</td>
<td align="right">
-645.710391
</td>
<td align="right">
-645.710391
</td>
<td align="right">
-645.710391
</td>
<td align="right">
-645.710391
</td>
<td align="right">
-645.710391
</td>
<td align="right">
1149.036
</td>
<td align="right">
2773.226
</td>
<td align="right">
2642.695
</td>
<td align="right">
2642.695
</td>
<td align="right">
1996.984
</td>
</tr>
<tr class="odd">
<td align="left">
2017-02-05
</td>
<td align="right">
2646.638
</td>
<td align="right">
-524.249067
</td>
<td align="right">
-524.249067
</td>
<td align="right">
-524.249067
</td>
<td align="right">
-524.249067
</td>
<td align="right">
-524.249067
</td>
<td align="right">
-524.249067
</td>
<td align="right">
-524.249067
</td>
<td align="right">
-524.249067
</td>
<td align="right">
-524.249067
</td>
<td align="right">
1339.384
</td>
<td align="right">
2951.047
</td>
<td align="right">
2646.638
</td>
<td align="right">
2646.638
</td>
<td align="right">
2122.389
</td>
</tr>
<tr class="even">
<td align="left">
2017-02-06
</td>
<td align="right">
2650.582
</td>
<td align="right">
201.997594
</td>
<td align="right">
201.997594
</td>
<td align="right">
201.997594
</td>
<td align="right">
201.997594
</td>
<td align="right">
201.997594
</td>
<td align="right">
201.997594
</td>
<td align="right">
201.997594
</td>
<td align="right">
201.997594
</td>
<td align="right">
201.997594
</td>
<td align="right">
2056.022
</td>
<td align="right">
3700.804
</td>
<td align="right">
2650.582
</td>
<td align="right">
2650.582
</td>
<td align="right">
2852.579
</td>
</tr>
</tbody>
</table>
<p>
Vemos que o dataframe resultante é bem verboso, possuindo 16 colunas.
Para este post, precisamos apenas da coluna <code>yhat</code>, que se
refere à previsão obtida pelo <code>prophet</code>, além da coluna de
data.
</p>
<span class="crayon-title"></span>

<span class="crayon-language">R</span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
retornar previsoes
==================

fcast\_prophet &lt;- fcast\_prophet %&gt;% filter(ds &gt;= data\_treino)
%&gt;% select(ds, yhat) %&gt;% mutate(ds = as.Date(ds), yhat =
round(yhat))
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
<span class="crayon-c">\# retornar previsoes</span>

<span class="crayon-v">fcast\_prophet</span><span class="crayon-h">
</span><span class="crayon-o">&lt;</span><span
class="crayon-o">-</span><span class="crayon-h"> </span><span
class="crayon-v">fcast\_prophet</span><span class="crayon-h">
</span><span class="crayon-o">%</span><span
class="crayon-o">&gt;</span><span class="crayon-o">%</span><span
class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">filter</span><span class="crayon-sy">(</span><span
class="crayon-v">ds</span><span class="crayon-h"> </span><span
class="crayon-o">&gt;=</span><span class="crayon-h"> </span><span
class="crayon-v">data\_treino</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&gt;</span><span
class="crayon-o">%</span><span class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">select</span><span class="crayon-sy">(</span><span
class="crayon-v">ds</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">yhat</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&gt;</span><span
class="crayon-o">%</span><span class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">mutate</span><span class="crayon-sy">(</span><span
class="crayon-v">ds</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-st">as</span><span class="crayon-sy">.</span><span
class="crayon-e">Date</span><span class="crayon-sy">(</span><span
class="crayon-v">ds</span><span class="crayon-sy">)</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">yhat</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-e">round</span><span class="crayon-sy">(</span><span
class="crayon-v">yhat</span><span class="crayon-sy">)</span><span
class="crayon-sy">)</span>

</td>
</tr>
</table>

<p>
 
</p>

<div id="mafs" class="section level3">
<h3>
mafs
</h3>
<p>
A sintaxe do <code>mafs</code> é diferente. Como ele foi feito em cima
do pacote <code>forecast</code>, o objeto de input deve ser um objeto da
classe <code>ts</code>. Por isso, precisamos transformar os dados nesse
formato:
</p>
<div id="crayon-5a5818bd26a56202093788" class="crayon-syntax crayon-theme-classic crayon-font-monaco crayon-os-pc print-yes notranslate" data-settings=" minimize scroll-mouseover" style=" margin-top: 12px; margin-bottom: 12px; font-size: 12px !important; line-height: 15px !important;">
<span class="crayon-title"></span>

<span class="crayon-language">R</span>

<div class="crayon-plain-wrap">
<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
transformar em objeto ts
========================

ts\_dls &lt;-
ts(df\_treino$y, start = lubridate::decimal\_date(data\_inicio),  frequency = 365)&lt;/textarea&gt;&lt;/div&gt; &lt;div class="crayon-main" style=""&gt; &lt;table class="crayon-table"&gt;&lt;tr class="crayon-row"&gt; &lt;td class="crayon-nums " data-settings="show"&gt; &lt;div class="crayon-nums-content" style="font-size: 12px !important; line-height: 15px !important;"&gt; &lt;div class="crayon-num" data-line="crayon-5a5818bd26a56202093788-1"&gt;1&lt;/div&gt; &lt;div class="crayon-num crayon-striped-num" data-line="crayon-5a5818bd26a56202093788-2"&gt;2&lt;/div&gt; &lt;div class="crayon-num" data-line="crayon-5a5818bd26a56202093788-3"&gt;3&lt;/div&gt; &lt;/div&gt; &lt;/td&gt; &lt;td class="crayon-code"&gt;&lt;div class="crayon-pre" style="font-size: 12px !important; line-height: 15px !important; -moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4;"&gt; &lt;div class="crayon-line" id="crayon-5a5818bd26a56202093788-1"&gt;&lt;span class="crayon-c"&gt;\# transformar em objeto ts&lt;/span&gt;&lt;/div&gt; &lt;div class="crayon-line crayon-striped-line" id="crayon-5a5818bd26a56202093788-2"&gt; &lt;span class="crayon-v"&gt;ts\_dls&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;&lt;&lt;/span&gt;&lt;span class="crayon-o"&gt;-&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-e"&gt;ts&lt;/span&gt;&lt;span class="crayon-sy"&gt;(&lt;/span&gt;&lt;span class="crayon-v"&gt;df\_treino&lt;/span&gt;&lt;span class="crayon-sy"&gt;$</span><span
class="crayon-v">y</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">start</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-v">lubridate</span><span
class="crayon-o">::</span><span
class="crayon-e">decimal\_date</span><span
class="crayon-sy">(</span><span
class="crayon-v">data\_inicio</span><span
class="crayon-sy">)</span><span class="crayon-sy">,</span>
</div>
<span class="crayon-h">             </span><span
class="crayon-v">frequency</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-cn">365</span><span class="crayon-sy">)</span>

</div>
</td>
</tr>
</table>
</div>
</div>
<p>
 
</p>
<p>
Assim, já podemos obter os modelos com o <code>mafs</code>. Nos testes
que eu fiz, os modelos <code>StructTS</code> (modelo estrutural)
e <code>tslm</code> (modelo de regressão que usa a tendência e a
sazonalidade como regressores) não funcionam nuito bem para séries
diárias (o <code>StructTS</code> demora uma eternidade para rodar para
séries diárias).
</p>
<span class="crayon-title"></span>

<span class="crayon-language">R</span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
modelo\_mafs &lt;- select\_forecast(ts\_dls, test\_size = nn, horizon =
nn, error = "MAPE", verbose = TRUE, dont\_apply = c("StructTS", "tslm"))
\#\# Warning in nnetar(x, p = 12, size = 12, repeats = 24): Series too
short for \#\# seasonal lags \#\# Warning in
forecastHybrid::hybridModel(x, verbose = FALSE): frequency(y) &gt;= \#\#
24. The ets model will not be used. \#\# Warning in
forecastHybrid::hybridModel(x, verbose = FALSE): frequency(y) &gt;= \#\#
24. The Theta model will not be used. \#\# Warning in
forecastHybrid::hybridModel(x, verbose = FALSE): The stlm model \#\#
requres a series more than twice as long as the seasonal period. The
stlm \#\# model will not be used. \#\# Warning in
forecastHybrid::hybridModel(x, verbose = FALSE): The nnetar \#\# model
requres a series more than twice as long as the seasonal period. The
\#\# nnetar model will not be used. \#\# Warning in mean.default(x,
na.rm = TRUE): argument is not numeric or \#\# logical: returning NA

Warning in mean.default(x, na.rm = TRUE): argument is not numeric or
--------------------------------------------------------------------

logical: returning NA
---------------------

Warning in mean.default(x, na.rm = TRUE): argument is not numeric or
--------------------------------------------------------------------

logical: returning NA
---------------------

Warning in trainingaccuracy(f, test, d, D): test elements must be within
------------------------------------------------------------------------

sample
------

Warning in trainingaccuracy(f, test, d, D): test elements must be within
------------------------------------------------------------------------

sample
------

Warning in trainingaccuracy(f, test, d, D): test elements must be within
------------------------------------------------------------------------

sample
------

prev\_mafs &lt;-
round(modelo\_mafs*b**e**s**t*<sub>*f*</sub>*o**r**e**c**a**s**t*mean)
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

22

23

24

25

26

27

28

29

30

31

32

</td>
<td class="crayon-code">
<span class="crayon-v">modelo\_mafs</span><span class="crayon-h">
</span><span class="crayon-o">&lt;</span><span
class="crayon-o">-</span><span class="crayon-h"> </span><span
class="crayon-e">select\_forecast</span><span
class="crayon-sy">(</span><span class="crayon-v">ts\_dls</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">test\_size</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">nn</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">horizon</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-v">nn</span><span
class="crayon-sy">,</span>

<span class="crayon-h">                               </span><span
class="crayon-v">error</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"MAPE"</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">verbose</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-t">TRUE</span><span
class="crayon-sy">,</span>

<span class="crayon-h">                               </span><span
class="crayon-v">dont\_apply</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-e">c</span><span class="crayon-sy">(</span><span
class="crayon-s">"StructTS"</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-s">"tslm"</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span>

<span class="crayon-c">\#\# Warning in nnetar(x, p = 12, size = 12,
repeats = 24): Series too short for</span>

<span class="crayon-c">\#\# seasonal lags</span>

<span class="crayon-c">\#\# Warning in forecastHybrid::hybridModel(x,
verbose = FALSE): frequency(y) &gt;=</span>

<span class="crayon-c">\#\# 24. The ets model will not be used.</span>

<span class="crayon-c">\#\# Warning in forecastHybrid::hybridModel(x,
verbose = FALSE): frequency(y) &gt;=</span>

<span class="crayon-c">\#\# 24. The Theta model will not be used.</span>

<span class="crayon-c">\#\# Warning in forecastHybrid::hybridModel(x,
verbose = FALSE): The stlm model</span>

<span class="crayon-c">\#\# requres a series more than twice as long as
the seasonal period. The stlm</span>

<span class="crayon-c">\#\# model will not be used.</span>

<span class="crayon-c">\#\# Warning in forecastHybrid::hybridModel(x,
verbose = FALSE): The nnetar</span>

<span class="crayon-c">\#\# model requres a series more than twice as
long as the seasonal period. The</span>

<span class="crayon-c">\#\# nnetar model will not be used.</span>

<span class="crayon-c">\#\# Warning in mean.default(x, na.rm = TRUE):
argument is not numeric or</span>

<span class="crayon-c">\#\# logical: returning NA</span>

 

<span class="crayon-c">\#\# Warning in mean.default(x, na.rm = TRUE):
argument is not numeric or</span>

<span class="crayon-c">\#\# logical: returning NA</span>

 

<span class="crayon-c">\#\# Warning in mean.default(x, na.rm = TRUE):
argument is not numeric or</span>

<span class="crayon-c">\#\# logical: returning NA</span>

<span class="crayon-c">\#\# Warning in trainingaccuracy(f, test, d, D):
test elements must be within</span>

<span class="crayon-c">\#\# sample</span>

 

<span class="crayon-c">\#\# Warning in trainingaccuracy(f, test, d, D):
test elements must be within</span>

<span class="crayon-c">\#\# sample</span>

 

<span class="crayon-c">\#\# Warning in trainingaccuracy(f, test, d, D):
test elements must be within</span>

<span class="crayon-c">\#\# sample</span>

<span class="crayon-v">prev\_mafs</span><span class="crayon-h">
</span><span class="crayon-o">&lt;</span><span
class="crayon-o">-</span><span class="crayon-h"> </span><span
class="crayon-e">round</span><span class="crayon-sy">(</span><span
class="crayon-v">modelo\_mafs</span><span
class="crayon-sy">$&lt;/span&gt;&lt;span class="crayon-v"&gt;best\_forecast&lt;/span&gt;&lt;span class="crayon-sy"&gt;$</span><span
class="crayon-v">mean</span><span class="crayon-sy">)</span>

</td>
</tr>
</table>

<p>
 
</p>
<p>
Vemos que alguns dos modelos aplicados pelo <code>mafs</code> produziram
alguma mensagem de aviso ou não puderam ser obtidos. De fato, o
dataframe <code>modelo\_mafs$df\_models&lt;/code&gt; retorna apenas 13 modelos:&lt;/p&gt; &lt;div id="crayon-5a5818bd26a5a467382376" class="crayon-syntax crayon-theme-classic crayon-font-monaco crayon-os-pc print-yes notranslate" data-settings=" minimize scroll-mouseover" style=" margin-top: 12px; margin-bottom: 12px; font-size: 12px !important; line-height: 15px !important;"&gt; &lt;div class="crayon-toolbar" data-settings=" mouseover overlay hide delay" style="font-size: 12px !important;height: 18px !important; line-height: 18px !important;"&gt; &lt;span class="crayon-title"&gt;&lt;/span&gt; &lt;div class="crayon-tools" style="font-size: 12px !important;height: 18px !important; line-height: 18px !important;"&gt; &lt;div class="crayon-button crayon-nums-button" title="Alternar números de linha"&gt;&lt;div class="crayon-button-icon"&gt;&lt;/div&gt;&lt;/div&gt; &lt;div class="crayon-button crayon-plain-button" title="Exibir código simples"&gt;&lt;div class="crayon-button-icon"&gt;&lt;/div&gt;&lt;/div&gt; &lt;div class="crayon-button crayon-wrap-button" title="Alternar quebras de linha"&gt;&lt;div class="crayon-button-icon"&gt;&lt;/div&gt;&lt;/div&gt; &lt;div class="crayon-button crayon-expand-button" title="Expand Code"&gt;&lt;div class="crayon-button-icon"&gt;&lt;/div&gt;&lt;/div&gt; &lt;div class="crayon-button crayon-copy-button" title="Copy"&gt;&lt;div class="crayon-button-icon"&gt;&lt;/div&gt;&lt;/div&gt; &lt;div class="crayon-button crayon-popup-button" title="Abrir código em nova janela"&gt;&lt;div class="crayon-button-icon"&gt;&lt;/div&gt;&lt;/div&gt; &lt;span class="crayon-language"&gt;R&lt;/span&gt; &lt;/div&gt; &lt;/div&gt; &lt;div class="crayon-info" style="min-height: 16.8px !important; line-height: 16.8px !important;"&gt;&lt;/div&gt; &lt;div class="crayon-plain-wrap"&gt;&lt;textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;"&gt; knitr::kable(modelo\_mafs$df\_models)
</textarea>
</div>
<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
1

</td>
<td class="crayon-code">
<span class="crayon-v">knitr</span><span class="crayon-o">::</span><span
class="crayon-e">kable</span><span class="crayon-sy">(</span><span
class="crayon-v">modelo\_mafs</span><span
class="crayon-sy">$</span><span class="crayon-v">df\_models</span><span
class="crayon-sy">)</span>

</td>
</tr>
</table>

</div>
<p>
 
</p>
<table class="table table-condensed">
<thead>
<tr class="header">
<th align="left">
model
</th>
<th align="right">
ME
</th>
<th align="right">
RMSE
</th>
<th align="right">
MAE
</th>
<th align="right">
MPE
</th>
<th align="right">
MAPE
</th>
<th align="right">
MASE
</th>
<th align="right">
ACF1
</th>
<th align="left">
best\_model
</th>
<th align="right">
runtime\_model
</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">
auto.arima
</td>
<td align="right">
430.0275
</td>
<td align="right">
543.5366
</td>
<td align="right">
471.5111
</td>
<td align="right">
11.938668
</td>
<td align="right">
13.422700
</td>
<td align="right">
NaN
</td>
<td align="right">
0.3145553
</td>
<td align="left">
ets
</td>
<td align="right">
0.377
</td>
</tr>
<tr class="even">
<td align="left">
bats
</td>
<td align="right">
339.0677
</td>
<td align="right">
473.3145
</td>
<td align="right">
428.6866
</td>
<td align="right">
9.189533
</td>
<td align="right">
12.378723
</td>
<td align="right">
NaN
</td>
<td align="right">
0.3059720
</td>
<td align="left">
ets
</td>
<td align="right">
1.882
</td>
</tr>
<tr class="odd">
<td align="left">
croston
</td>
<td align="right">
216.5770
</td>
<td align="right">
396.5251
</td>
<td align="right">
375.9404
</td>
<td align="right">
5.472501
</td>
<td align="right">
11.130077
</td>
<td align="right">
NaN
</td>
<td align="right">
0.3041755
</td>
<td align="left">
ets
</td>
<td align="right">
1.886
</td>
</tr>
<tr class="even">
<td align="left">
ets
</td>
<td align="right">
-145.3627
</td>
<td align="right">
362.5698
</td>
<td align="right">
260.4997
</td>
<td align="right">
-5.475541
</td>
<td align="right">
8.614132
</td>
<td align="right">
NaN
</td>
<td align="right">
0.3041755
</td>
<td align="left">
ets
</td>
<td align="right">
0.075
</td>
</tr>
<tr class="odd">
<td align="left">
hybrid
</td>
<td align="right">
26257.8410
</td>
<td align="right">
37720.2071
</td>
<td align="right">
26257.8410
</td>
<td align="right">
786.376373
</td>
<td align="right">
786.376373
</td>
<td align="right">
NaN
</td>
<td align="right">
0.8728045
</td>
<td align="left">
ets
</td>
<td align="right">
9.695
</td>
</tr>
<tr class="even">
<td align="left">
meanf
</td>
<td align="right">
441.9520
</td>
<td align="right">
552.8545
</td>
<td align="right">
482.2700
</td>
<td align="right">
12.289703
</td>
<td align="right">
13.732511
</td>
<td align="right">
NaN
</td>
<td align="right">
0.3041755
</td>
<td align="left">
ets
</td>
<td align="right">
0.001
</td>
</tr>
<tr class="odd">
<td align="left">
naive
</td>
<td align="right">
-145.3667
</td>
<td align="right">
362.5714
</td>
<td align="right">
260.5000
</td>
<td align="right">
-5.475662
</td>
<td align="right">
8.614149
</td>
<td align="right">
NaN
</td>
<td align="right">
0.3041755
</td>
<td align="left">
ets
</td>
<td align="right">
0.004
</td>
</tr>
<tr class="even">
<td align="left">
nnetar
</td>
<td align="right">
136.5865
</td>
<td align="right">
557.6698
</td>
<td align="right">
472.8066
</td>
<td align="right">
3.481630
</td>
<td align="right">
14.652416
</td>
<td align="right">
NaN
</td>
<td align="right">
0.4416121
</td>
<td align="left">
ets
</td>
<td align="right">
1.285
</td>
</tr>
<tr class="odd">
<td align="left">
rwf
</td>
<td align="right">
-145.3667
</td>
<td align="right">
362.5714
</td>
<td align="right">
260.5000
</td>
<td align="right">
-5.475662
</td>
<td align="right">
8.614149
</td>
<td align="right">
NaN
</td>
<td align="right">
0.3041755
</td>
<td align="left">
ets
</td>
<td align="right">
0.003
</td>
</tr>
<tr class="even">
<td align="left">
rwf\_drift
</td>
<td align="right">
-239.1374
</td>
<td align="right">
409.9504
</td>
<td align="right">
283.8696
</td>
<td align="right">
-8.303362
</td>
<td align="right">
9.516029
</td>
<td align="right">
NaN
</td>
<td align="right">
0.3038044
</td>
<td align="left">
ets
</td>
<td align="right">
0.005
</td>
</tr>
<tr class="odd">
<td align="left">
snaive
</td>
<td align="right">
595.5000
</td>
<td align="right">
1254.7320
</td>
<td align="right">
984.1000
</td>
<td align="right">
18.379700
</td>
<td align="right">
29.369605
</td>
<td align="right">
NaN
</td>
<td align="right">
0.2117650
</td>
<td align="left">
ets
</td>
<td align="right">
0.002
</td>
</tr>
<tr class="even">
<td align="left">
splinef
</td>
<td align="right">
-3506.0761
</td>
<td align="right">
3982.5196
</td>
<td align="right">
3506.0761
</td>
<td align="right">
-106.818788
</td>
<td align="right">
106.818788
</td>
<td align="right">
NaN
</td>
<td align="right">
0.8778869
</td>
<td align="left">
ets
</td>
<td align="right">
0.440
</td>
</tr>
<tr class="odd">
<td align="left">
tbats
</td>
<td align="right">
339.0677
</td>
<td align="right">
473.3145
</td>
<td align="right">
428.6866
</td>
<td align="right">
9.189533
</td>
<td align="right">
12.378723
</td>
<td align="right">
NaN
</td>
<td align="right">
0.3059720
</td>
<td align="left">
ets
</td>
<td align="right">
4.372
</td>
</tr>
</tbody>
</table>
<p>
Vamos então obter a previsão futura produzida pelo <code>mafs</code> e a
juntar com a previsão do <code>prophet</code> no dataframe de teste:
</p>
<span class="crayon-title"></span>

<span class="crayon-language">R</span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
prev\_mafs &lt;-
round(modelo\_mafs*b**e**s**t*<sub>*f*</sub>*o**r**e**c**a**s**t*mean)
fcast\_prophet$yhat\_mafs &lt;- as.numeric(prev\_mafs) \# mudar nome das
colunas names(fcast\_prophet) &lt;- c("ds", "previsao\_prophet",
"previsao\_mafs") \# juntar dataframe de resultado com o de previsao
df\_teste &lt;- df\_teste %&gt;% left\_join(fcast\_prophet, by = "ds")

plotar previsoes vs resultados reais
====================================

df\_teste %&gt;% gather(metodo, previsao, -(1:2)) %&gt;% ggplot(aes(x =
ds, y = y)) + geom\_line() + geom\_line(aes(y = previsao, color =
metodo))
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

</td>
<td class="crayon-code">
<span class="crayon-v">prev\_mafs</span><span class="crayon-h">
</span><span class="crayon-o">&lt;</span><span
class="crayon-o">-</span><span class="crayon-h"> </span><span
class="crayon-e">round</span><span class="crayon-sy">(</span><span
class="crayon-v">modelo\_mafs</span><span
class="crayon-sy">$&lt;/span&gt;&lt;span class="crayon-v"&gt;best\_forecast&lt;/span&gt;&lt;span class="crayon-sy"&gt;$</span><span
class="crayon-v">mean</span><span class="crayon-sy">)</span>

<span class="crayon-v">fcast\_prophet</span><span
class="crayon-sy">$</span><span class="crayon-v">yhat\_mafs</span><span
class="crayon-h"> </span><span class="crayon-o">&lt;</span><span
class="crayon-o">-</span><span class="crayon-h"> </span><span
class="crayon-st">as</span><span class="crayon-sy">.</span><span
class="crayon-e">numeric</span><span class="crayon-sy">(</span><span
class="crayon-v">prev\_mafs</span><span class="crayon-sy">)</span>

<span class="crayon-c">\# mudar nome das colunas</span>

<span class="crayon-e">names</span><span class="crayon-sy">(</span><span
class="crayon-v">fcast\_prophet</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-e">c</span><span
class="crayon-sy">(</span><span class="crayon-s">"ds"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-s">"previsao\_prophet"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-s">"previsao\_mafs"</span><span class="crayon-sy">)</span>

<span class="crayon-c">\# juntar dataframe de resultado com o de
previsao</span>

<span class="crayon-v">df\_teste</span><span class="crayon-h">
</span><span class="crayon-o">&lt;</span><span
class="crayon-o">-</span><span class="crayon-h"> </span><span
class="crayon-v">df\_teste</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&gt;</span><span
class="crayon-o">%</span><span class="crayon-h">  </span><span
class="crayon-e">left\_join</span><span class="crayon-sy">(</span><span
class="crayon-v">fcast\_prophet</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">by</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"ds"</span><span class="crayon-sy">)</span>

 

<span class="crayon-c">\# plotar previsoes vs resultados reais</span>

<span class="crayon-v">df\_teste</span><span class="crayon-h">
</span><span class="crayon-o">%</span><span
class="crayon-o">&gt;</span><span class="crayon-o">%</span><span
class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">gather</span><span class="crayon-sy">(</span><span
class="crayon-v">metodo</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">previsao</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-o">-</span><span class="crayon-sy">(</span><span
class="crayon-cn">1</span><span class="crayon-o">:</span><span
class="crayon-cn">2</span><span class="crayon-sy">)</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&gt;</span><span
class="crayon-o">%</span><span class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">ggplot</span><span class="crayon-sy">(</span><span
class="crayon-e">aes</span><span class="crayon-sy">(</span><span
class="crayon-v">x</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">ds</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">y</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-v">y</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">+</span><span
class="crayon-h"> </span>

<span class="crayon-h">    </span><span
class="crayon-e">geom\_line</span><span class="crayon-sy">(</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">+</span><span class="crayon-h"> </span>

<span class="crayon-h">    </span><span
class="crayon-e">geom\_line</span><span class="crayon-sy">(</span><span
class="crayon-e">aes</span><span class="crayon-sy">(</span><span
class="crayon-v">y</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">previsao</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">color</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-v">metodo</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span>

</td>
</tr>
</table>

<p>
 
</p>
</div>
<p>
<img class="aligncenter size-full wp-image-11949" src="https://www.ibpad.com.br/wp-content/uploads/2017/10/unnamed-chunk-15-1.png" alt="" width="672" height="480" srcset="https://www.ibpad.com.br/wp-content/uploads/2017/10/unnamed-chunk-15-1.png 672w, https://www.ibpad.com.br/wp-content/uploads/2017/10/unnamed-chunk-15-1-260x186.png 260w, https://www.ibpad.com.br/wp-content/uploads/2017/10/unnamed-chunk-15-1-100x71.png 100w" sizes="(max-width: 672px) 100vw, 672px">
</p>
<p>
O <code>mafs</code> produziu uma previsão de linha reta. Apenas como
forma de demonstrar o uso do meu pacote, vamos remover o
modelo <code>ets</code> da lista de modelos usados e rever os
resultados:
</p>
<div id="crayon-5a5818bd26a63784314118" class="crayon-syntax crayon-theme-classic crayon-font-monaco crayon-os-pc print-yes notranslate" data-settings=" minimize scroll-mouseover" style=" margin-top: 12px; margin-bottom: 12px; font-size: 12px !important; line-height: 15px !important;">
<span class="crayon-title"></span>

<span class="crayon-language">R</span>

<div class="crayon-plain-wrap">
<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
modelo\_mafs &lt;- select\_forecast(ts\_dls, test\_size = nn, horizon =
nn, error = "MAPE", verbose = FALSE, dont\_apply = c("StructTS", "ets",
"tslm")) \#\# Warning in nnetar(x, p = 12, size = 12, repeats = 24):
Series too short for \#\# seasonal lags \#\# Warning in
forecastHybrid::hybridModel(x, verbose = FALSE): frequency(y) &gt;= \#\#
24. The ets model will not be used. \#\# Warning in
forecastHybrid::hybridModel(x, verbose = FALSE): frequency(y) &gt;= \#\#
24. The Theta model will not be used. \#\# Warning in
forecastHybrid::hybridModel(x, verbose = FALSE): The stlm model \#\#
requres a series more than twice as long as the seasonal period. The
stlm \#\# model will not be used. \#\# Warning in
forecastHybrid::hybridModel(x, verbose = FALSE): The nnetar \#\# model
requres a series more than twice as long as the seasonal period. The
\#\# nnetar model will not be used. \#\# Warning in mean.default(x,
na.rm = TRUE): argument is not numeric or \#\# logical: returning NA

Warning in mean.default(x, na.rm = TRUE): argument is not numeric or
--------------------------------------------------------------------

logical: returning NA
---------------------

Warning in mean.default(x, na.rm = TRUE): argument is not numeric or
--------------------------------------------------------------------

logical: returning NA
---------------------

Warning in trainingaccuracy(f, test, d, D): test elements must be within
------------------------------------------------------------------------

sample
------

Warning in trainingaccuracy(f, test, d, D): test elements must be within
------------------------------------------------------------------------

sample
------

Warning in trainingaccuracy(f, test, d, D): test elements must be within
------------------------------------------------------------------------

sample
------

prev\_mafs &lt;-
round(modelo\_mafs*b**e**s**t*<sub>*f*</sub>*o**r**e**c**a**s**t*mean)
fcast\_prophet$previsao\_mafs &lt;- as.numeric(prev\_mafs) \# mudar nome das colunas names(fcast\_prophet) &lt;- c("ds", "previsao\_prophet", "previsao\_mafs") \# juntar dataframe de resultado com o de previsao df\_teste &lt;- df\_dls %&gt;% filter(ds &gt;= data\_treino) df\_teste &lt;- df\_teste %&gt;% left\_join(fcast\_prophet, by = "ds") df\_teste %&gt;%  gather(metodo, previsao, -(1:2)) %&gt;%  ggplot(aes(x = ds, y = y)) +  geom\_line() +  geom\_line(aes(y = previsao, color = metodo))&lt;/textarea&gt;&lt;/div&gt; &lt;div class="crayon-main" style=""&gt; &lt;table class="crayon-table"&gt;&lt;tr class="crayon-row"&gt; &lt;td class="crayon-nums " data-settings="show"&gt; &lt;div class="crayon-nums-content" style="font-size: 12px !important; line-height: 15px !important;"&gt; &lt;div class="crayon-num" data-line="crayon-5a5818bd26a63784314118-1"&gt;1&lt;/div&gt; &lt;div class="crayon-num crayon-striped-num" data-line="crayon-5a5818bd26a63784314118-2"&gt;2&lt;/div&gt; &lt;div class="crayon-num" data-line="crayon-5a5818bd26a63784314118-3"&gt;3&lt;/div&gt; &lt;div class="crayon-num crayon-striped-num" data-line="crayon-5a5818bd26a63784314118-4"&gt;4&lt;/div&gt; &lt;div class="crayon-num" data-line="crayon-5a5818bd26a63784314118-5"&gt;5&lt;/div&gt; &lt;div class="crayon-num crayon-striped-num" data-line="crayon-5a5818bd26a63784314118-6"&gt;6&lt;/div&gt; &lt;div class="crayon-num" data-line="crayon-5a5818bd26a63784314118-7"&gt;7&lt;/div&gt; &lt;div class="crayon-num crayon-striped-num" data-line="crayon-5a5818bd26a63784314118-8"&gt;8&lt;/div&gt; &lt;div class="crayon-num" data-line="crayon-5a5818bd26a63784314118-9"&gt;9&lt;/div&gt; &lt;div class="crayon-num crayon-striped-num" data-line="crayon-5a5818bd26a63784314118-10"&gt;10&lt;/div&gt; &lt;div class="crayon-num" data-line="crayon-5a5818bd26a63784314118-11"&gt;11&lt;/div&gt; &lt;div class="crayon-num crayon-striped-num" data-line="crayon-5a5818bd26a63784314118-12"&gt;12&lt;/div&gt; &lt;div class="crayon-num" data-line="crayon-5a5818bd26a63784314118-13"&gt;13&lt;/div&gt; &lt;div class="crayon-num crayon-striped-num" data-line="crayon-5a5818bd26a63784314118-14"&gt;14&lt;/div&gt; &lt;div class="crayon-num" data-line="crayon-5a5818bd26a63784314118-15"&gt;15&lt;/div&gt; &lt;div class="crayon-num crayon-striped-num" data-line="crayon-5a5818bd26a63784314118-16"&gt;16&lt;/div&gt; &lt;div class="crayon-num" data-line="crayon-5a5818bd26a63784314118-17"&gt;17&lt;/div&gt; &lt;div class="crayon-num crayon-striped-num" data-line="crayon-5a5818bd26a63784314118-18"&gt;18&lt;/div&gt; &lt;div class="crayon-num" data-line="crayon-5a5818bd26a63784314118-19"&gt;19&lt;/div&gt; &lt;div class="crayon-num crayon-striped-num" data-line="crayon-5a5818bd26a63784314118-20"&gt;20&lt;/div&gt; &lt;div class="crayon-num" data-line="crayon-5a5818bd26a63784314118-21"&gt;21&lt;/div&gt; &lt;div class="crayon-num crayon-striped-num" data-line="crayon-5a5818bd26a63784314118-22"&gt;22&lt;/div&gt; &lt;div class="crayon-num" data-line="crayon-5a5818bd26a63784314118-23"&gt;23&lt;/div&gt; &lt;div class="crayon-num crayon-striped-num" data-line="crayon-5a5818bd26a63784314118-24"&gt;24&lt;/div&gt; &lt;div class="crayon-num" data-line="crayon-5a5818bd26a63784314118-25"&gt;25&lt;/div&gt; &lt;div class="crayon-num crayon-striped-num" data-line="crayon-5a5818bd26a63784314118-26"&gt;26&lt;/div&gt; &lt;div class="crayon-num" data-line="crayon-5a5818bd26a63784314118-27"&gt;27&lt;/div&gt; &lt;div class="crayon-num crayon-striped-num" data-line="crayon-5a5818bd26a63784314118-28"&gt;28&lt;/div&gt; &lt;div class="crayon-num" data-line="crayon-5a5818bd26a63784314118-29"&gt;29&lt;/div&gt; &lt;div class="crayon-num crayon-striped-num" data-line="crayon-5a5818bd26a63784314118-30"&gt;30&lt;/div&gt; &lt;div class="crayon-num" data-line="crayon-5a5818bd26a63784314118-31"&gt;31&lt;/div&gt; &lt;div class="crayon-num crayon-striped-num" data-line="crayon-5a5818bd26a63784314118-32"&gt;32&lt;/div&gt; &lt;div class="crayon-num" data-line="crayon-5a5818bd26a63784314118-33"&gt;33&lt;/div&gt; &lt;div class="crayon-num crayon-striped-num" data-line="crayon-5a5818bd26a63784314118-34"&gt;34&lt;/div&gt; &lt;div class="crayon-num" data-line="crayon-5a5818bd26a63784314118-35"&gt;35&lt;/div&gt; &lt;div class="crayon-num crayon-striped-num" data-line="crayon-5a5818bd26a63784314118-36"&gt;36&lt;/div&gt; &lt;div class="crayon-num" data-line="crayon-5a5818bd26a63784314118-37"&gt;37&lt;/div&gt; &lt;div class="crayon-num crayon-striped-num" data-line="crayon-5a5818bd26a63784314118-38"&gt;38&lt;/div&gt; &lt;div class="crayon-num" data-line="crayon-5a5818bd26a63784314118-39"&gt;39&lt;/div&gt; &lt;div class="crayon-num crayon-striped-num" data-line="crayon-5a5818bd26a63784314118-40"&gt;40&lt;/div&gt; &lt;div class="crayon-num" data-line="crayon-5a5818bd26a63784314118-41"&gt;41&lt;/div&gt; &lt;div class="crayon-num crayon-striped-num" data-line="crayon-5a5818bd26a63784314118-42"&gt;42&lt;/div&gt; &lt;div class="crayon-num" data-line="crayon-5a5818bd26a63784314118-43"&gt;43&lt;/div&gt; &lt;/div&gt; &lt;/td&gt; &lt;td class="crayon-code"&gt;&lt;div class="crayon-pre" style="font-size: 12px !important; line-height: 15px !important; -moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4;"&gt; &lt;div class="crayon-line" id="crayon-5a5818bd26a63784314118-1"&gt; &lt;span class="crayon-v"&gt;modelo\_mafs&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;&lt;&lt;/span&gt;&lt;span class="crayon-o"&gt;-&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-e"&gt;select\_forecast&lt;/span&gt;&lt;span class="crayon-sy"&gt;(&lt;/span&gt;&lt;span class="crayon-v"&gt;ts\_dls&lt;/span&gt;&lt;span class="crayon-sy"&gt;,&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-v"&gt;test\_size&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;=&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-v"&gt;nn&lt;/span&gt;&lt;span class="crayon-sy"&gt;,&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-v"&gt;horizon&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;=&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-v"&gt;nn&lt;/span&gt;&lt;span class="crayon-sy"&gt;,&lt;/span&gt; &lt;/div&gt; &lt;div class="crayon-line crayon-striped-line" id="crayon-5a5818bd26a63784314118-2"&gt; &lt;span class="crayon-h"&gt;                               &lt;/span&gt;&lt;span class="crayon-v"&gt;error&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;=&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-s"&gt;"MAPE"&lt;/span&gt;&lt;span class="crayon-sy"&gt;,&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-v"&gt;verbose&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;=&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-t"&gt;FALSE&lt;/span&gt;&lt;span class="crayon-sy"&gt;,&lt;/span&gt; &lt;/div&gt; &lt;div class="crayon-line" id="crayon-5a5818bd26a63784314118-3"&gt; &lt;span class="crayon-h"&gt;                               &lt;/span&gt;&lt;span class="crayon-v"&gt;dont\_apply&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;=&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-e"&gt;c&lt;/span&gt;&lt;span class="crayon-sy"&gt;(&lt;/span&gt;&lt;span class="crayon-s"&gt;"StructTS"&lt;/span&gt;&lt;span class="crayon-sy"&gt;,&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-s"&gt;"ets"&lt;/span&gt;&lt;span class="crayon-sy"&gt;,&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-s"&gt;"tslm"&lt;/span&gt;&lt;span class="crayon-sy"&gt;)&lt;/span&gt;&lt;span class="crayon-sy"&gt;)&lt;/span&gt; &lt;/div&gt; &lt;div class="crayon-line crayon-striped-line" id="crayon-5a5818bd26a63784314118-4"&gt;&lt;span class="crayon-c"&gt;\#\# Warning in nnetar(x, p = 12, size = 12, repeats = 24): Series too short for&lt;/span&gt;&lt;/div&gt; &lt;div class="crayon-line" id="crayon-5a5818bd26a63784314118-5"&gt;&lt;span class="crayon-c"&gt;\#\# seasonal lags&lt;/span&gt;&lt;/div&gt; &lt;div class="crayon-line crayon-striped-line" id="crayon-5a5818bd26a63784314118-6"&gt;&lt;span class="crayon-c"&gt;\#\# Warning in forecastHybrid::hybridModel(x, verbose = FALSE): frequency(y) &gt;=&lt;/span&gt;&lt;/div&gt; &lt;div class="crayon-line" id="crayon-5a5818bd26a63784314118-7"&gt;&lt;span class="crayon-c"&gt;\#\# 24. The ets model will not be used.&lt;/span&gt;&lt;/div&gt; &lt;div class="crayon-line crayon-striped-line" id="crayon-5a5818bd26a63784314118-8"&gt;&lt;span class="crayon-c"&gt;\#\# Warning in forecastHybrid::hybridModel(x, verbose = FALSE): frequency(y) &gt;=&lt;/span&gt;&lt;/div&gt; &lt;div class="crayon-line" id="crayon-5a5818bd26a63784314118-9"&gt;&lt;span class="crayon-c"&gt;\#\# 24. The Theta model will not be used.&lt;/span&gt;&lt;/div&gt; &lt;div class="crayon-line crayon-striped-line" id="crayon-5a5818bd26a63784314118-10"&gt;&lt;span class="crayon-c"&gt;\#\# Warning in forecastHybrid::hybridModel(x, verbose = FALSE): The stlm model&lt;/span&gt;&lt;/div&gt; &lt;div class="crayon-line" id="crayon-5a5818bd26a63784314118-11"&gt;&lt;span class="crayon-c"&gt;\#\# requres a series more than twice as long as the seasonal period. The stlm&lt;/span&gt;&lt;/div&gt; &lt;div class="crayon-line crayon-striped-line" id="crayon-5a5818bd26a63784314118-12"&gt;&lt;span class="crayon-c"&gt;\#\# model will not be used.&lt;/span&gt;&lt;/div&gt; &lt;div class="crayon-line" id="crayon-5a5818bd26a63784314118-13"&gt;&lt;span class="crayon-c"&gt;\#\# Warning in forecastHybrid::hybridModel(x, verbose = FALSE): The nnetar&lt;/span&gt;&lt;/div&gt; &lt;div class="crayon-line crayon-striped-line" id="crayon-5a5818bd26a63784314118-14"&gt;&lt;span class="crayon-c"&gt;\#\# model requres a series more than twice as long as the seasonal period. The&lt;/span&gt;&lt;/div&gt; &lt;div class="crayon-line" id="crayon-5a5818bd26a63784314118-15"&gt;&lt;span class="crayon-c"&gt;\#\# nnetar model will not be used.&lt;/span&gt;&lt;/div&gt; &lt;div class="crayon-line crayon-striped-line" id="crayon-5a5818bd26a63784314118-16"&gt;&lt;span class="crayon-c"&gt;\#\# Warning in mean.default(x, na.rm = TRUE): argument is not numeric or&lt;/span&gt;&lt;/div&gt; &lt;div class="crayon-line" id="crayon-5a5818bd26a63784314118-17"&gt;&lt;span class="crayon-c"&gt;\#\# logical: returning NA&lt;/span&gt;&lt;/div&gt; &lt;div class="crayon-line crayon-striped-line" id="crayon-5a5818bd26a63784314118-18"&gt; &lt;/div&gt; &lt;div class="crayon-line" id="crayon-5a5818bd26a63784314118-19"&gt;&lt;span class="crayon-c"&gt;\#\# Warning in mean.default(x, na.rm = TRUE): argument is not numeric or&lt;/span&gt;&lt;/div&gt; &lt;div class="crayon-line crayon-striped-line" id="crayon-5a5818bd26a63784314118-20"&gt;&lt;span class="crayon-c"&gt;\#\# logical: returning NA&lt;/span&gt;&lt;/div&gt; &lt;div class="crayon-line" id="crayon-5a5818bd26a63784314118-21"&gt; &lt;/div&gt; &lt;div class="crayon-line crayon-striped-line" id="crayon-5a5818bd26a63784314118-22"&gt;&lt;span class="crayon-c"&gt;\#\# Warning in mean.default(x, na.rm = TRUE): argument is not numeric or&lt;/span&gt;&lt;/div&gt; &lt;div class="crayon-line" id="crayon-5a5818bd26a63784314118-23"&gt;&lt;span class="crayon-c"&gt;\#\# logical: returning NA&lt;/span&gt;&lt;/div&gt; &lt;div class="crayon-line crayon-striped-line" id="crayon-5a5818bd26a63784314118-24"&gt;&lt;span class="crayon-c"&gt;\#\# Warning in trainingaccuracy(f, test, d, D): test elements must be within&lt;/span&gt;&lt;/div&gt; &lt;div class="crayon-line" id="crayon-5a5818bd26a63784314118-25"&gt;&lt;span class="crayon-c"&gt;\#\# sample&lt;/span&gt;&lt;/div&gt; &lt;div class="crayon-line crayon-striped-line" id="crayon-5a5818bd26a63784314118-26"&gt; &lt;/div&gt; &lt;div class="crayon-line" id="crayon-5a5818bd26a63784314118-27"&gt;&lt;span class="crayon-c"&gt;\#\# Warning in trainingaccuracy(f, test, d, D): test elements must be within&lt;/span&gt;&lt;/div&gt; &lt;div class="crayon-line crayon-striped-line" id="crayon-5a5818bd26a63784314118-28"&gt;&lt;span class="crayon-c"&gt;\#\# sample&lt;/span&gt;&lt;/div&gt; &lt;div class="crayon-line" id="crayon-5a5818bd26a63784314118-29"&gt; &lt;/div&gt; &lt;div class="crayon-line crayon-striped-line" id="crayon-5a5818bd26a63784314118-30"&gt;&lt;span class="crayon-c"&gt;\#\# Warning in trainingaccuracy(f, test, d, D): test elements must be within&lt;/span&gt;&lt;/div&gt; &lt;div class="crayon-line" id="crayon-5a5818bd26a63784314118-31"&gt;&lt;span class="crayon-c"&gt;\#\# sample&lt;/span&gt;&lt;/div&gt; &lt;div class="crayon-line crayon-striped-line" id="crayon-5a5818bd26a63784314118-32"&gt; &lt;span class="crayon-v"&gt;prev\_mafs&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;&lt;&lt;/span&gt;&lt;span class="crayon-o"&gt;-&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-e"&gt;round&lt;/span&gt;&lt;span class="crayon-sy"&gt;(&lt;/span&gt;&lt;span class="crayon-v"&gt;modelo\_mafs&lt;/span&gt;&lt;span class="crayon-sy"&gt;$</span><span
class="crayon-v">best\_forecast</span><span
class="crayon-sy">$&lt;/span&gt;&lt;span class="crayon-v"&gt;mean&lt;/span&gt;&lt;span class="crayon-sy"&gt;)&lt;/span&gt; &lt;/div&gt; &lt;div class="crayon-line" id="crayon-5a5818bd26a63784314118-33"&gt; &lt;span class="crayon-v"&gt;fcast\_prophet&lt;/span&gt;&lt;span class="crayon-sy"&gt;$</span><span
class="crayon-v">previsao\_mafs</span><span class="crayon-h">
</span><span class="crayon-o">&lt;</span><span
class="crayon-o">-</span><span class="crayon-h"> </span><span
class="crayon-st">as</span><span class="crayon-sy">.</span><span
class="crayon-e">numeric</span><span class="crayon-sy">(</span><span
class="crayon-v">prev\_mafs</span><span class="crayon-sy">)</span>
</div>
<span class="crayon-c">\# mudar nome das colunas</span>

<span class="crayon-e">names</span><span class="crayon-sy">(</span><span
class="crayon-v">fcast\_prophet</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-e">c</span><span
class="crayon-sy">(</span><span class="crayon-s">"ds"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-s">"previsao\_prophet"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-s">"previsao\_mafs"</span><span class="crayon-sy">)</span>

<span class="crayon-c">\# juntar dataframe de resultado com o de
previsao</span>

<span class="crayon-v">df\_teste</span><span class="crayon-h">
</span><span class="crayon-o">&lt;</span><span
class="crayon-o">-</span><span class="crayon-h"> </span><span
class="crayon-v">df\_dls</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&gt;</span><span
class="crayon-o">%</span><span class="crayon-h"> </span><span
class="crayon-e">filter</span><span class="crayon-sy">(</span><span
class="crayon-v">ds</span><span class="crayon-h"> </span><span
class="crayon-o">&gt;=</span><span class="crayon-h"> </span><span
class="crayon-v">data\_treino</span><span class="crayon-sy">)</span>

<span class="crayon-v">df\_teste</span><span class="crayon-h">
</span><span class="crayon-o">&lt;</span><span
class="crayon-o">-</span><span class="crayon-h"> </span><span
class="crayon-v">df\_teste</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&gt;</span><span
class="crayon-o">%</span><span class="crayon-h">  </span><span
class="crayon-e">left\_join</span><span class="crayon-sy">(</span><span
class="crayon-v">fcast\_prophet</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">by</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"ds"</span><span class="crayon-sy">)</span>

<span class="crayon-v">df\_teste</span><span class="crayon-h">
</span><span class="crayon-o">%</span><span
class="crayon-o">&gt;</span><span class="crayon-o">%</span><span
class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">gather</span><span class="crayon-sy">(</span><span
class="crayon-v">metodo</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">previsao</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-o">-</span><span class="crayon-sy">(</span><span
class="crayon-cn">1</span><span class="crayon-o">:</span><span
class="crayon-cn">2</span><span class="crayon-sy">)</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&gt;</span><span
class="crayon-o">%</span><span class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">ggplot</span><span class="crayon-sy">(</span><span
class="crayon-e">aes</span><span class="crayon-sy">(</span><span
class="crayon-v">x</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">ds</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">y</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-v">y</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">+</span><span
class="crayon-h"> </span>

<span class="crayon-h">    </span><span
class="crayon-e">geom\_line</span><span class="crayon-sy">(</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">+</span><span class="crayon-h"> </span>

<span class="crayon-h">    </span><span
class="crayon-e">geom\_line</span><span class="crayon-sy">(</span><span
class="crayon-e">aes</span><span class="crayon-sy">(</span><span
class="crayon-v">y</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">previsao</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">color</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-v">metodo</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span>

</div>
</td>
</tr>
</table>
</div>
</div>
<p>
 
</p>
<p>
<img class="aligncenter size-full wp-image-11950" src="https://www.ibpad.com.br/wp-content/uploads/2017/10/unnamed-chunk-17-1.png" alt="" width="672" height="480" srcset="https://www.ibpad.com.br/wp-content/uploads/2017/10/unnamed-chunk-17-1.png 672w, https://www.ibpad.com.br/wp-content/uploads/2017/10/unnamed-chunk-17-1-260x186.png 260w, https://www.ibpad.com.br/wp-content/uploads/2017/10/unnamed-chunk-17-1-100x71.png 100w" sizes="(max-width: 672px) 100vw, 672px">
</p>
<div id="obtendo-previsoes-para-a-serie" class="section level2">
<p>
Por mais incrível que pareça, mais uma vez uma linha reta foi fornecida
como previsão pelo <code>mafs</code>, enquanto
o <code>prophet</code> conseguiu prever com muita eficácia a
sazonalidade da série.
</p>
<p>
Numericamente, o erro médio absoluto de downloads é de:
</p>

<p>
</p>
<div id="crayon-5a5818bd26a66571016520" class="crayon-syntax crayon-theme-classic crayon-font-monaco crayon-os-pc print-yes notranslate" data-settings=" minimize scroll-mouseover" style=" margin-top: 12px; margin-bottom: 12px; font-size: 12px !important; line-height: 15px !important;">
<span class="crayon-title"></span>

<span class="crayon-language">R</span>

<div class="crayon-plain-wrap">
<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
real &lt;- df\_teste$y prev\_prophet &lt;- df\_teste$previsao\_prophet
prev\_mafs &lt;-
df\_teste$previsao\_mafs mean(abs(real - prev\_mafs)) \#\# \[1\] 1010.867 mean(abs(real - prev\_prophet)) \#\# \[1\] 837.0333&lt;/textarea&gt;&lt;/div&gt; &lt;div class="crayon-main" style=""&gt; &lt;table class="crayon-table"&gt;&lt;tr class="crayon-row"&gt; &lt;td class="crayon-nums " data-settings="show"&gt; &lt;div class="crayon-nums-content" style="font-size: 12px !important; line-height: 15px !important;"&gt; &lt;div class="crayon-num" data-line="crayon-5a5818bd26a66571016520-1"&gt;1&lt;/div&gt; &lt;div class="crayon-num crayon-striped-num" data-line="crayon-5a5818bd26a66571016520-2"&gt;2&lt;/div&gt; &lt;div class="crayon-num" data-line="crayon-5a5818bd26a66571016520-3"&gt;3&lt;/div&gt; &lt;div class="crayon-num crayon-striped-num" data-line="crayon-5a5818bd26a66571016520-4"&gt;4&lt;/div&gt; &lt;div class="crayon-num" data-line="crayon-5a5818bd26a66571016520-5"&gt;5&lt;/div&gt; &lt;div class="crayon-num crayon-striped-num" data-line="crayon-5a5818bd26a66571016520-6"&gt;6&lt;/div&gt; &lt;div class="crayon-num" data-line="crayon-5a5818bd26a66571016520-7"&gt;7&lt;/div&gt; &lt;/div&gt; &lt;/td&gt; &lt;td class="crayon-code"&gt;&lt;div class="crayon-pre" style="font-size: 12px !important; line-height: 15px !important; -moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4;"&gt; &lt;div class="crayon-line" id="crayon-5a5818bd26a66571016520-1"&gt; &lt;span class="crayon-v"&gt;real&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;&lt;&lt;/span&gt;&lt;span class="crayon-o"&gt;-&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-v"&gt;df\_teste&lt;/span&gt;&lt;span class="crayon-sy"&gt;$</span><span
class="crayon-i">y</span>
</div>
<span class="crayon-v">prev\_prophet</span><span class="crayon-h">
</span><span class="crayon-o">&lt;</span><span
class="crayon-o">-</span><span class="crayon-h"> </span><span
class="crayon-v">df\_teste</span><span
class="crayon-sy">$&lt;/span&gt;&lt;span class="crayon-e"&gt;previsao\_prophet&lt;/span&gt; &lt;/div&gt; &lt;div class="crayon-line" id="crayon-5a5818bd26a66571016520-3"&gt; &lt;span class="crayon-v"&gt;prev\_mafs&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;&lt;&lt;/span&gt;&lt;span class="crayon-o"&gt;-&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-v"&gt;df\_teste&lt;/span&gt;&lt;span class="crayon-sy"&gt;$</span><span
class="crayon-e">previsao\_mafs</span>

<span class="crayon-e">mean</span><span class="crayon-sy">(</span><span
class="crayon-e">abs</span><span class="crayon-sy">(</span><span
class="crayon-v">real</span><span class="crayon-h"> </span><span
class="crayon-o">-</span><span class="crayon-h"> </span><span
class="crayon-v">prev\_mafs</span><span class="crayon-sy">)</span><span
class="crayon-sy">)</span>

<span class="crayon-c">\#\# \[1\] 1010.867</span>

<span class="crayon-e">mean</span><span class="crayon-sy">(</span><span
class="crayon-e">abs</span><span class="crayon-sy">(</span><span
class="crayon-v">real</span><span class="crayon-h"> </span><span
class="crayon-o">-</span><span class="crayon-h"> </span><span
class="crayon-v">prev\_prophet</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span>

<span class="crayon-c">\#\# \[1\] 837.0333</span>

</div>
</td>
</tr>
</table>
</div>
</div>
<p>
 
</p>
</div>
<h2>
Considerações finais
</h2>
<p>
Sobre o título (meio sensacionalista) do post: Em meus estudos sobre
séries temporais, é comum encontrar livros e papers afirmando que é
impossível determinar que o modelo X sempre será melhor que Y. Cada
série temporal possui suas próprias características: sazonalidade,
outliers, ciclos de negócios, tendência, frequência, etc. O recomendável
é estudar a teoria de cada modelo que se deseja usar, variar seus
parâmetros e pesquisar em artigos benchmarks para séries temporais de um
determinado contexto (por exemplo, para vendas de produtos de demanda
intermitente costuma-se usar Croston).
</p>

<p>
 
</p>
</div>

