+++
title = "Pacotes brasileiros para R: micro-pacotes"
date = "2017-07-31 23:02:54"
categories = ["IBPAD"]
original_url = "https://www.ibpad.com.br/blog/pacotes-brasileiros-para-r-micro-pacotes/"
+++

<div class="post-inner-content">
<div class="vc_row wpb_row vc_row-fluid">
<div class="wpb_column vc_column_container vc_col-sm-12">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<div class="wpb_text_column wpb_content_element ">
<div class="wpb_wrapper">
<p>
Tem pacotes para R que têm muitas funções, e têm outros que possuem só
uma função principal. Neste post, olhamos os pacotes brasileiros para R
que caem nesta segunda categoria — ‘micro-pacotes’.
</p>
<h5>
<strong>RSLP</strong>
</h5>
<p>
O pacote <a href="https://github.com/dfalbe">rlsp</a>, por Daniel
Falbel, vai fazer a vida de quem trabalha com mineração de textos em
português bem mais fácil. O pacote usa ‘stemming’ para a língua
portuguesa. Em outras palavras, ele reduz palavras às suas raízes,
facilitando a análise de textos. Um exemplo:
</p>

<p>
 
</p>
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
install.packages("rslp")

palavras
</textarea>

<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
1

2

3

</td>
<td class="crayon-code">
<span class="crayon-v">install</span><span
class="crayon-sy">.</span><span class="crayon-e">packages</span><span
class="crayon-sy">(</span><span class="crayon-s">"rslp"</span><span
class="crayon-sy">)</span>

 

<span class="crayon-v">palavras</span>

</td>
</tr>
</table>

<p>
 
</p>
<p>
Um outro pacote do Daniel,
<a href="https://github.com/dfalbel/ptstem">ptstem</a> traz mais
ferramentas para a análise de texto, para quem tem interesse em nesta
área.
</p>
<h5>
<strong>cepR</strong>
</h5>
<p>
O pacote cepR acessa dados postais do Brasil tais como nomes de
bairros, cidades, estados, logradouros, CEPs e outras informações de
interesse como altitude, longitude e latitude. O usuário precisa de um
<em>token</em> do website
<a href="http://cepaberto.com/users/register">CEPaberto</a>, e daí
pode procurar ou por CEPs ou por detalhes de bairros com o CEP. Por
exemplo, a rua João Moura onde moro em São Paulo:
</p>

<p>
</p>
<div id="crayon-5a5818c2e8ded165693890" class="crayon-syntax crayon-theme-classic crayon-font-monaco crayon-os-pc print-yes notranslate" data-settings=" minimize scroll-mouseover" style=" margin-top: 12px; margin-bottom: 12px; font-size: 12px !important; line-height: 15px !important;">
<span class="crayon-title"></span>

<div class="crayon-plain-wrap">
<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
install.packages("cepR")

cepR::busca\_cep(cep = "005412002", token = XXXXXXXXX)

    ## # A tibble: 1 x 10
    ##   estado    cidade    bairro      cep
    ##                  
    ## 1     SP São Paulo Pinheiros 05412002
    ##
    ## # ... with 6 more variables: logradouro , latitude ,
    ## #   longitude , altitude , ddd , cod_IBGE</textarea></div>

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

</td>
<td class="crayon-code">
 

 

<span class="crayon-v">install</span><span
class="crayon-sy">.</span><span class="crayon-e">packages</span><span
class="crayon-sy">(</span><span class="crayon-s">"cepR"</span><span
class="crayon-sy">)</span>

 

<span class="crayon-v">cepR</span><span class="crayon-o">::</span><span
class="crayon-e">busca\_cep</span><span class="crayon-sy">(</span><span
class="crayon-v">cep</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"005412002"</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">token</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-v">XXXXXXXXX</span><span
class="crayon-sy">)</span>

 

 

<span class="crayon-h">    </span><span class="crayon-p">\#\# \# A
tibble: 1 x 10</span>

<span class="crayon-h">    </span><span class="crayon-p">\#\#  
estado    cidade    bairro      cep</span>

<span class="crayon-h">    </span><span
class="crayon-p">\#\#                  </span>

<span class="crayon-h">    </span><span class="crayon-p">\#\# 1     SP
São Paulo Pinheiros 05412002</span>

<span class="crayon-h">    </span><span class="crayon-p">\#\#</span>

<span class="crayon-h">    </span><span class="crayon-p">\#\# \# ...
with 6 more variables: logradouro , latitude ,</span>

<span class="crayon-h">    </span><span class="crayon-p">\#\# \#  
longitude , altitude , ddd , cod\_IBGE</span>

</td>
</tr>
</table>

</div>
<p>
 
</p>
<h5>
<strong>GetTDData</strong>
</h5>
<p>
O pacote <a href="https://github.com/cran/GetTDData">GetTDData</a> baixa
dados do Tesouro do governo brasileiro, do website
<a href="http://www.tesouro.gov.br/tesouro-direto-balanco-e-estatisticas">Tesouro
Direto</a>. O pacote arruma estes arquivos para você usar no R. Para
quem está interessado em dados financeiras, é bem mais fácil do que
baixar tudo e tentar importar um por um para R! O autor, Marcelo Perlin,
<a href="https://www.ibpad.com.br/blog/pacotes-brasileiros-do-r-parte-3-analisando-financas-no-r/">tem
outros pacotes</a> para R que tratam com dados financeiros também.
</p>
<h5>
<strong>riscoBrasil</strong>
</h5>
<p>
Falando de dados financeiros, o pacote
<a href="https://github.com/RobertMyles/riscoBrasil">riscoBrasil</a> baixa
dados do índice do J.P. Morgan sobre o ‘risco Brasil’. O J.P. Morgan
mantenha um <em>Emerging Markets Bond Index</em> com índices de risco
para vários países, e o IBGE disponibiliza estes dados no caso do
Brasil. O pacote tem uma função, <code>riscoBrasil()</code>, fazendo ele
um ‘micro-pacote’ mesmo! Mais detalhes podem ser vistos na página do
pacote, e pode ser instalado com
<code>install.packages("riscoBrasil")</code>.
</p>
<h5>
<strong>sabesp</strong>
</h5>
<p>
O pacote <a href="https://github.com/jtrecenti/sabesp">sabesp</a> do
Júlio Trecenti, baixa e arruma dados da SABESP (a Companhia de
Saneamento Básico do Estado de São Paulo). Júlio mostra como, com poucas
linhas de código, pode produzir um gráfico bem informativo sobre o
estado dos reservatórios de água em São Paulo:
</p>
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
install.packages("devtools") \#\# se não tem
============================================

install.packages("lubridate") \#\# idem
=======================================

devtools::install\_github("jtrecenti/sabesp") library(dplyr)
library(sabesp) library(ggplot2)

datas % filter(titulo == 'volume armazenado') %&gt;% ggplot(aes(x =
data, y = info, colour = lugar)) + geom\_line() + theme\_bw() +
geom\_hline(yintercept = 0, colour = 'gray') +
scale\_x\_date(date\_labels = '%b %Y', date\_breaks = '3 months', limits
= as.Date(c('2012-12-01', '2015-12-01'))) + theme(axis.text.x =
element\_text(angle = 45, hjust = 1))
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

</td>
<td class="crayon-code">
 

 

<span class="crayon-p">\# install.packages("devtools")  \#\# se não
tem</span>

<span class="crayon-p">\# install.packages("lubridate") \#\# idem</span>

 

 

<span class="crayon-v">devtools</span><span
class="crayon-o">::</span><span
class="crayon-e">install\_github</span><span
class="crayon-sy">(</span><span
class="crayon-s">"jtrecenti/sabesp"</span><span
class="crayon-sy">)</span>

<span class="crayon-e">library</span><span
class="crayon-sy">(</span><span class="crayon-v">dplyr</span><span
class="crayon-sy">)</span>

<span class="crayon-e">library</span><span
class="crayon-sy">(</span><span class="crayon-v">sabesp</span><span
class="crayon-sy">)</span>

<span class="crayon-e">library</span><span
class="crayon-sy">(</span><span class="crayon-v">ggplot2</span><span
class="crayon-sy">)</span>

 

<span class="crayon-v">datas</span><span class="crayon-h"> </span><span
class="crayon-o">%</span>

<span class="crayon-h">  </span><span
class="crayon-e">filter</span><span class="crayon-sy">(</span><span
class="crayon-v">titulo</span><span class="crayon-h"> </span><span
class="crayon-o">==</span><span class="crayon-h"> </span><span
class="crayon-s">'volume armazenado'</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&</span><span
class="crayon-v">gt</span><span class="crayon-sy">;</span><span
class="crayon-o">%</span>

<span class="crayon-h">  </span><span
class="crayon-e">ggplot</span><span class="crayon-sy">(</span><span
class="crayon-e">aes</span><span class="crayon-sy">(</span><span
class="crayon-v">x</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">data</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">y</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-v">info</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">colour</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">lugar</span><span class="crayon-sy">)</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">+</span>

<span class="crayon-h">  </span><span
class="crayon-e">geom\_line</span><span class="crayon-sy">(</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">+</span>

<span class="crayon-h">  </span><span
class="crayon-e">theme\_bw</span><span class="crayon-sy">(</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">+</span>

<span class="crayon-h">  </span><span
class="crayon-e">geom\_hline</span><span class="crayon-sy">(</span><span
class="crayon-v">yintercept</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-cn">0</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">colour</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-s">'gray'</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">+</span>

<span class="crayon-h">  </span><span
class="crayon-e">scale\_x\_date</span><span
class="crayon-sy">(</span><span
class="crayon-v">date\_labels</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">'%b %Y'</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">date\_breaks</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-s">'3 months'</span><span
class="crayon-sy">,</span>

<span class="crayon-h">               </span><span
class="crayon-v">limits</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-st">as</span><span class="crayon-sy">.</span><span
class="crayon-e">Date</span><span class="crayon-sy">(</span><span
class="crayon-e">c</span><span class="crayon-sy">(</span><span
class="crayon-s">'2012-12-01'</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-s">'2015-12-01'</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">+</span>

<span class="crayon-h">  </span><span class="crayon-e">theme</span><span
class="crayon-sy">(</span><span class="crayon-v">axis</span><span
class="crayon-sy">.</span><span class="crayon-v">text</span><span
class="crayon-sy">.</span><span class="crayon-v">x</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span
class="crayon-e">element\_text</span><span
class="crayon-sy">(</span><span class="crayon-v">angle</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-cn">45</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">hjust</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-cn">1</span><span class="crayon-sy">)</span><span
class="crayon-sy">)</span>

</td>
</tr>
</table>

<p>
</p>
</div>
</div>
<figure class="wpb_wrapper vc_figure">
<img width="1039" height="561" src="https://www.ibpad.com.br/wp-content/uploads/2017/07/sabesp-1.png" class="vc_single_image-img attachment-full" alt="" srcset="https://www.ibpad.com.br/wp-content/uploads/2017/07/sabesp-1.png 1039w, https://www.ibpad.com.br/wp-content/uploads/2017/07/sabesp-1-260x140.png 260w, https://www.ibpad.com.br/wp-content/uploads/2017/07/sabesp-1-768x415.png 768w, https://www.ibpad.com.br/wp-content/uploads/2017/07/sabesp-1-1024x553.png 1024w, https://www.ibpad.com.br/wp-content/uploads/2017/07/sabesp-1-100x54.png 100w" sizes="(max-width: 1039px) 100vw, 1039px">

</figure>

</div>
</div>
</div>
</div>
</div>

