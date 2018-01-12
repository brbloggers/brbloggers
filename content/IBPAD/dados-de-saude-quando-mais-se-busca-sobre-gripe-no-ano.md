+++
title = "Dados de Saúde – Quando mais se busca sobre gripe no ano?"
date = "2017-10-06 03:44:16"
categories = ["IBPAD"]
original_url = "https://www.ibpad.com.br/blog/analise-de-dados/dados-de-saude-quando-mais-se-busca-sobre-gripe-no-ano/"
+++

<div class="post-inner-content">
<div class="vc_row wpb_row vc_row-fluid">
<div class="wpb_column vc_column_container vc_col-sm-12">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<p>
Neste post, você aprenderá a:
</p>
<ul>
<li>
Baixar dados do Google Trends com o R;
</li>
<li>
Usar gráficos de séries temporais do pacote <span
id="crayon-5a5818bb56875074697615"
class="crayon-syntax crayon-syntax-inline crayon-theme-classic crayon-theme-classic-inline crayon-font-monaco"
style="font-size: 12px !important; line-height: 15px !important;font-size: 12px !important;"><span
class="crayon-pre crayon-code"
style="font-size: 12px !important; line-height: 15px !important;font-size: 12px !important; -moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4;"><span
class="crayon-v">forecast</span></span></span> para analisar a
sazonalidade de uma série temporal;
</li>
<li>
Converter uma série semanal em mensal;
</li>
</ul>

<h3>
O que é Sazonalidade?
</h3>

<p>
No contexto de Séries Temporais, Sazonalidade se refere a um padrão fixo
que se repete no mesmo período do tempo. Podemos citar alguns exemplos
de cabeça, como vendas de trajes de banho no verão e de casacos no
inverno. Modelar a sazonalidade de uma série temporal é fundamental na
aplicação de diversos modelos de previsão.
</p>
<p>
Imagine que você é dono de uma farmácia ou um gestor de comunicação de
alguma secretaria de Saúde e deseja saber em qual época do ano as
pessoas costumam ficar mais doentes e/ou buscar por mais informações
sobre a gripe, por exemplo. Uma fonte de informação útil, rápida e
barata para o seu problema pode ser o
<a href="https://trends.google.com" target="_blank">Google Trends</a>,
que mostra o interesse das pessoas sobre um determinado tema ao longo do
tempo.
</p>
<p>
O pacote <code>gtrendsR</code> fornece uma interface simples de conexão
do R com o Google Trends, sem a necessidade de autenticação por login ou
algo do tipo.
</p>
<p>
Para este post, usamos os seguintes pacotes:
</p>
<span class="crayon-title"></span>

<span class="crayon-language">R</span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
library(gtrendsR) \# interface com o Google Trends library(tidyverse) \#
Pq nao vivo sem ele library(magrittr) \# Nem ele library(forecast) \#
Serve não só para previsões mas também para alguns gráficos legais
library(lubridate) \# manipulação de datas
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
<span class="crayon-h"> </span><span
class="crayon-r">library</span><span class="crayon-sy">(</span><span
class="crayon-v">gtrendsR</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-c">\# interface com o
Google Trends</span>

<span class="crayon-r">library</span><span
class="crayon-sy">(</span><span class="crayon-v">tidyverse</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-c">\# Pq nao vivo sem ele</span>

<span class="crayon-r">library</span><span
class="crayon-sy">(</span><span class="crayon-v">magrittr</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-c">\# Nem ele</span>

<span class="crayon-r">library</span><span
class="crayon-sy">(</span><span class="crayon-v">forecast</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-c">\# Serve não só para previsões mas também para alguns
gráficos legais</span>

<span class="crayon-r">library</span><span
class="crayon-sy">(</span><span class="crayon-v">lubridate</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-c">\# manipulação de datas</span>

</td>
</tr>
</table>

<p>
 
</p>
<p>
Vamos então baixar dados referentes a buscas pelo termo gripe. Usamos a
função gtrends para baixar os dados, no qual atribuímos “BR” ao
argumento geo para especificar que apenas buscas no Brasil sejam
retornadas.
</p>
<p>
 
</p>
<span class="crayon-title"></span>

<span class="crayon-language">R</span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
busca &lt;- "gripe" res &lt;- gtrends(keyword = busca, geo = "BR") res
plot(res)
</textarea>

<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
1

2

3

</td>
<td class="crayon-code">
<span class="crayon-v">busca</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-s">"gripe"</span>

<span class="crayon-v">res</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-e">gtrends</span><span
class="crayon-sy">(</span><span class="crayon-v">keyword</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-v">busca</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">geo</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"BR"</span><span class="crayon-sy">)</span>

<span class="crayon-e">res </span><span
class="crayon-e">plot</span><span class="crayon-sy">(</span><span
class="crayon-v">res</span><span class="crayon-sy">)</span>

</td>
</tr>
</table>

<p>
</p>

<figure class="wpb_wrapper vc_figure">
<a data-rel="prettyPhoto[rel-12050-1039395086]" href="https://www.ibpad.com.br/wp-content/uploads/2017/10/unnamed-chunk-2-1.png" target="_self" class="vc_single_image-wrapper   vc_box_border_grey prettyphoto"><img width="864" height="480" src="https://www.ibpad.com.br/wp-content/uploads/2017/10/unnamed-chunk-2-1.png" class="vc_single_image-img attachment-full" alt="" srcset="https://www.ibpad.com.br/wp-content/uploads/2017/10/unnamed-chunk-2-1.png 864w, https://www.ibpad.com.br/wp-content/uploads/2017/10/unnamed-chunk-2-1-260x144.png 260w, https://www.ibpad.com.br/wp-content/uploads/2017/10/unnamed-chunk-2-1-768x427.png 768w, https://www.ibpad.com.br/wp-content/uploads/2017/10/unnamed-chunk-2-1-100x56.png 100w" sizes="(max-width: 864px) 100vw, 864px"></a>
</figure>

<p>
É perceptível que essa série temporal possui um forte componente
sazonal, pois o número de pesquisas é maior no primeiro semestre que no
segundo.
</p>
<p>
O pacote <code>forecast</code> fornece algumas funções de gráficos
úteis, mas para usá-las será necessário transformar os dados acima em
objetos da classe <code>ts</code>. A variável <code>res</code>, na qual
foi salva o output da função <code>gtrends</code>, é na verdade uma
lista de dataframes. Um deles, o <code>interest\_over\_time</code>, é o
que possui os dados plotados acima.
</p>
<span class="crayon-title"></span>

<span class="crayon-language">R</span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
df str(df) \#\# 'data.frame': 261 obs. of 6 variables: \#\# $ date :
POSIXct, format: "2012-10-07 00:00:00" "2012-10-14 00:00:00" ... \#\# $
hits : int 8 10 9 8 8 7 8 8 7 6 ... \#\# $ keyword : chr "gripe" "gripe"
"gripe" "gripe" ... \#\# $ geo : chr "BR" "BR" "BR" "BR" ... \#\# $
gprop : chr "web" "web" "web" "web" ... \#\# $ category: int 0 0 0 0 0 0
0 0 0 0 ... \# transformar em ts interesse\_ts frequency = 52)
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

</td>
<td class="crayon-code">
<span class="crayon-e">df </span><span class="crayon-e">str</span><span
class="crayon-sy">(</span><span class="crayon-v">df</span><span
class="crayon-sy">)</span>

<span class="crayon-c">\#\# 'data.frame': 261 obs. of 6
variables:</span>

<span class="crayon-c">\#\# $ date : POSIXct, format: "2012-10-07
00:00:00" "2012-10-14 00:00:00" ...</span>

<span class="crayon-c">\#\# $ hits : int 8 10 9 8 8 7 8 8 7 6 ...</span>

<span class="crayon-c">\#\# $ keyword : chr "gripe" "gripe" "gripe"
"gripe" ...</span>

<span class="crayon-c">\#\# $ geo : chr "BR" "BR" "BR" "BR" ...</span>

<span class="crayon-c">\#\# $ gprop : chr "web" "web" "web" "web"
...</span>

<span class="crayon-c">\#\# $ category: int 0 0 0 0 0 0 0 0 0 0
...</span>

<span class="crayon-c">\# transformar em ts</span>

<span class="crayon-e">interesse\_ts </span><span
class="crayon-v">frequency</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-cn">52</span><span class="crayon-sy">)</span>

</td>
</tr>
</table>

<p>
Note que usamos a função<code> lubridate::decimal\_date()</code> para
converter a data de início da série em decimal (formato aceito pela
função <code>ts</code>) e definimos a frequência como 52 pois a série é
semanal (e um ano possui 52 semanas).
</p>
<p>
Com isso, já podemos usar diversos gráficos do pacote <code>forecast
</code>para auxiliar a interpretação do componente sazonal da série:
</p>
<span class="crayon-title"></span>

<span class="crayon-language">R</span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
ggseasonplot(interesse\_ts) + theme\_minimal()
</textarea>

<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
1

</td>
<td class="crayon-code">
<span class="crayon-e">ggseasonplot</span><span
class="crayon-sy">(</span><span
class="crayon-v">interesse\_ts</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">+</span><span class="crayon-h"> </span><span
class="crayon-e">theme\_minimal</span><span
class="crayon-sy">(</span><span class="crayon-sy">)</span>

</td>
</tr>
</table>

<p>
</p>

<figure class="wpb_wrapper vc_figure">
<a data-rel="prettyPhoto[rel-12050-249884834]" href="https://www.ibpad.com.br/wp-content/uploads/2017/10/unnamed-chunk-4-1-1.png" target="_self" class="vc_single_image-wrapper   vc_box_border_grey prettyphoto"><img width="864" height="480" src="https://www.ibpad.com.br/wp-content/uploads/2017/10/unnamed-chunk-4-1-1.png" class="vc_single_image-img attachment-full" alt="" srcset="https://www.ibpad.com.br/wp-content/uploads/2017/10/unnamed-chunk-4-1-1.png 864w, https://www.ibpad.com.br/wp-content/uploads/2017/10/unnamed-chunk-4-1-1-260x144.png 260w, https://www.ibpad.com.br/wp-content/uploads/2017/10/unnamed-chunk-4-1-1-768x427.png 768w, https://www.ibpad.com.br/wp-content/uploads/2017/10/unnamed-chunk-4-1-1-100x56.png 100w" sizes="(max-width: 864px) 100vw, 864px"></a>
</figure>

<p>
<code>ggmonthplot(interesse\_ts) + theme\_minimal()</code>
</p>

<figure class="wpb_wrapper vc_figure">
<a data-rel="prettyPhoto[rel-12050-876550594]" href="https://www.ibpad.com.br/wp-content/uploads/2017/10/unnamed-chunk-4-2.png" target="_self" class="vc_single_image-wrapper   vc_box_border_grey prettyphoto"><img width="864" height="480" src="https://www.ibpad.com.br/wp-content/uploads/2017/10/unnamed-chunk-4-2.png" class="vc_single_image-img attachment-full" alt="" srcset="https://www.ibpad.com.br/wp-content/uploads/2017/10/unnamed-chunk-4-2.png 864w, https://www.ibpad.com.br/wp-content/uploads/2017/10/unnamed-chunk-4-2-260x144.png 260w, https://www.ibpad.com.br/wp-content/uploads/2017/10/unnamed-chunk-4-2-768x427.png 768w, https://www.ibpad.com.br/wp-content/uploads/2017/10/unnamed-chunk-4-2-100x56.png 100w" sizes="(max-width: 864px) 100vw, 864px"></a>
</figure>

<div class="wpb_text_column wpb_content_element ">
<div class="wpb_wrapper">
<p>
Os dois gráficos mostram claramente que existe um pico de interesse da
pessoas pela gripe no segundo trimestre do ano, mais especificamente
entre as semanas 15 a 21.
</p>
<p>
Talvez o fato de a série ser semanal dificulte a análise da sazonalidade
neste caso. Afinal de contas, é muito mais fácil saber em que mês
estamos do que em qual semana.<br> Por isso, vamos transformar a série
de semanal para mensal. Isso é feito usando a função
lubridate::floor\_date(), que recebe uma data de input e retorna o
primeiro dia da referência escolhida. Por exemplo:
</p>
<span class="crayon-title"></span>

<span class="crayon-language">R</span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
data
</textarea>

<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
1

</td>
<td class="crayon-code">
<span class="crayon-v">data</span>

</td>
</tr>
</table>

<p>
Aplicando o que aprendemos:
</p>
<span class="crayon-title"></span>

<span class="crayon-language">R</span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
transformar série semanal em mensal
===================================

interesse\_mensal % mutate(date = as.Date(floor\_date(date, "month")))
%&gt;% \# agrupar por mes group\_by(date) %&gt;% \# calcular a qtd de
pesquisas por mes summarise(hits = sum(hits))
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
<span class="crayon-c">\# transformar série semanal em mensal</span>

<span class="crayon-v">interesse\_mensal</span><span class="crayon-h">
</span><span class="crayon-o">%</span>

<span class="crayon-e">mutate</span><span
class="crayon-sy">(</span><span class="crayon-v">date</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-st">as</span><span
class="crayon-sy">.</span><span class="crayon-e">Date</span><span
class="crayon-sy">(</span><span class="crayon-e">floor\_date</span><span
class="crayon-sy">(</span><span class="crayon-v">date</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-s">"month"</span><span class="crayon-sy">)</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">%</span><span
class="crayon-o">&gt;</span><span class="crayon-o">%</span>

<span class="crayon-c">\# agrupar por mes</span>

<span class="crayon-e">group\_by</span><span
class="crayon-sy">(</span><span class="crayon-v">date</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&gt;</span><span
class="crayon-o">%</span>

<span class="crayon-c">\# calcular a qtd de pesquisas por mes</span>

<span class="crayon-e">summarise</span><span
class="crayon-sy">(</span><span class="crayon-v">hits</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-e">sum</span><span
class="crayon-sy">(</span><span class="crayon-v">hits</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span>

</td>
</tr>
</table>

<p>
</p>
<div id="crayon-5a5818bb56897085757386" class="crayon-syntax crayon-theme-classic crayon-font-monaco crayon-os-pc print-yes notranslate" data-settings=" minimize scroll-mouseover" style=" margin-top: 12px; margin-bottom: 12px; font-size: 12px !important; line-height: 15px !important;">
<span class="crayon-title"></span>

<span class="crayon-language">R</span>

<div class="crayon-plain-wrap">
<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
refazer os gráficos de sazonalidade:
====================================

interesse\_ts\_mensal start =
lubridate::decimal\_date(min(interesse\_mensal$date)), frequency = 12) ggsubseriesplot(interesse\_ts\_mensal) + theme\_minimal()&lt;/textarea&gt;&lt;/div&gt; &lt;div class="crayon-main" style=""&gt; &lt;table class="crayon-table"&gt;&lt;tr class="crayon-row"&gt; &lt;td class="crayon-nums " data-settings="show"&gt; &lt;div class="crayon-nums-content" style="font-size: 12px !important; line-height: 15px !important;"&gt; &lt;div class="crayon-num" data-line="crayon-5a5818bb56897085757386-1"&gt;1&lt;/div&gt; &lt;div class="crayon-num crayon-striped-num" data-line="crayon-5a5818bb56897085757386-2"&gt;2&lt;/div&gt; &lt;div class="crayon-num" data-line="crayon-5a5818bb56897085757386-3"&gt;3&lt;/div&gt; &lt;div class="crayon-num crayon-striped-num" data-line="crayon-5a5818bb56897085757386-4"&gt;4&lt;/div&gt; &lt;/div&gt; &lt;/td&gt; &lt;td class="crayon-code"&gt;&lt;div class="crayon-pre" style="font-size: 12px !important; line-height: 15px !important; -moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4;"&gt; &lt;div class="crayon-line" id="crayon-5a5818bb56897085757386-1"&gt;&lt;span class="crayon-c"&gt;\# refazer os gráficos de sazonalidade:&lt;/span&gt;&lt;/div&gt; &lt;div class="crayon-line crayon-striped-line" id="crayon-5a5818bb56897085757386-2"&gt; &lt;span class="crayon-e"&gt;interesse\_ts\_mensal &lt;/span&gt;&lt;span class="crayon-v"&gt;start&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;=&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-v"&gt;lubridate&lt;/span&gt;&lt;span class="crayon-o"&gt;::&lt;/span&gt;&lt;span class="crayon-e"&gt;decimal\_date&lt;/span&gt;&lt;span class="crayon-sy"&gt;(&lt;/span&gt;&lt;span class="crayon-e"&gt;min&lt;/span&gt;&lt;span class="crayon-sy"&gt;(&lt;/span&gt;&lt;span class="crayon-v"&gt;interesse\_mensal&lt;/span&gt;&lt;span class="crayon-sy"&gt;$</span><span
class="crayon-v">date</span><span class="crayon-sy">)</span><span
class="crayon-sy">)</span><span class="crayon-sy">,</span>
</div>
<span class="crayon-v">frequency</span><span class="crayon-h">
</span><span class="crayon-o">=</span><span class="crayon-h">
</span><span class="crayon-cn">12</span><span class="crayon-sy">)</span>

<span class="crayon-e">ggsubseriesplot</span><span
class="crayon-sy">(</span><span
class="crayon-v">interesse\_ts\_mensal</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">+</span><span class="crayon-h"> </span><span
class="crayon-e">theme\_minimal</span><span
class="crayon-sy">(</span><span class="crayon-sy">)</span>

</div>
</td>
</tr>
</table>
</div>
</div>
<p>
</p>
</div>
</div>
<figure class="wpb_wrapper vc_figure">
<a data-rel="prettyPhoto[rel-12050-1975386262]" href="https://www.ibpad.com.br/wp-content/uploads/2017/10/unnamed-chunk-6-1.png" target="_self" class="vc_single_image-wrapper   vc_box_border_grey prettyphoto"><img width="864" height="480" src="https://www.ibpad.com.br/wp-content/uploads/2017/10/unnamed-chunk-6-1.png" class="vc_single_image-img attachment-full" alt="" srcset="https://www.ibpad.com.br/wp-content/uploads/2017/10/unnamed-chunk-6-1.png 864w, https://www.ibpad.com.br/wp-content/uploads/2017/10/unnamed-chunk-6-1-260x144.png 260w, https://www.ibpad.com.br/wp-content/uploads/2017/10/unnamed-chunk-6-1-768x427.png 768w, https://www.ibpad.com.br/wp-content/uploads/2017/10/unnamed-chunk-6-1-100x56.png 100w" sizes="(max-width: 864px) 100vw, 864px"></a>
</figure>

<p>
</p>
<span class="crayon-title"></span>

<span class="crayon-language">R</span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
ggseasonplot(interesse\_ts\_mensal) + theme\_minimal()
</textarea>

<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
1

</td>
<td class="crayon-code">
<span class="crayon-e">ggseasonplot</span><span
class="crayon-sy">(</span><span
class="crayon-v">interesse\_ts\_mensal</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">+</span><span class="crayon-h"> </span><span
class="crayon-e">theme\_minimal</span><span
class="crayon-sy">(</span><span class="crayon-sy">)</span>

</td>
</tr>
</table>

<p>
</p>

<figure class="wpb_wrapper vc_figure">
<a data-rel="prettyPhoto[rel-12050-1687468213]" href="https://www.ibpad.com.br/wp-content/uploads/2017/10/unnamed-chunk-6-2.png" target="_self" class="vc_single_image-wrapper   vc_box_border_grey prettyphoto"><img width="864" height="480" src="https://www.ibpad.com.br/wp-content/uploads/2017/10/unnamed-chunk-6-2.png" class="vc_single_image-img attachment-full" alt="" srcset="https://www.ibpad.com.br/wp-content/uploads/2017/10/unnamed-chunk-6-2.png 864w, https://www.ibpad.com.br/wp-content/uploads/2017/10/unnamed-chunk-6-2-260x144.png 260w, https://www.ibpad.com.br/wp-content/uploads/2017/10/unnamed-chunk-6-2-768x427.png 768w, https://www.ibpad.com.br/wp-content/uploads/2017/10/unnamed-chunk-6-2-100x56.png 100w" sizes="(max-width: 864px) 100vw, 864px"></a>
</figure>

<p>
Agora é mais fácil ver que os meses onde há maior busca pelo termo gripe
são Abril e Maio.
</p>

</div>
</div>
</div>
</div>
<figure class="wpb_wrapper vc_figure">
<img width="1060" height="1136" src="https://www.ibpad.com.br/wp-content/uploads/2016/10/ST.jpg" class="vc_single_image-img attachment-full" alt="" srcset="https://www.ibpad.com.br/wp-content/uploads/2016/10/ST.jpg 1060w, https://www.ibpad.com.br/wp-content/uploads/2016/10/ST-260x279.jpg 260w, https://www.ibpad.com.br/wp-content/uploads/2016/10/ST-768x823.jpg 768w, https://www.ibpad.com.br/wp-content/uploads/2016/10/ST-955x1024.jpg 955w, https://www.ibpad.com.br/wp-content/uploads/2016/10/ST-93x100.jpg 93w" sizes="(max-width: 1060px) 100vw, 1060px">

</figure>

<p>
Gostaram do post? No próximo vou falar um pouco sobre sazonalidade de
algumas cidades turísticas!
</p>
<p>
Quer aprender um pouco mais sobre séries temporais o curso em São Paulo
começa esse mês.
<a href="https://www.ibpad.com.br/produto/series-temporais-sp/">Mais
informações aqui</a>
</p>

</div>

