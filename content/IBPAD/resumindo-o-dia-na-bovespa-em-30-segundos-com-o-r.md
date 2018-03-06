+++
title = "Resumindo o dia na Bovespa em 30 segundos com o R"
date = "2018-02-26 20:11:45"
categories = ["IBPAD"]
original_url = "https://www.ibpad.com.br/blog/resumindo-o-dia-na-bovespa-em-30-segundos-com-o-r/"
+++

<<<<<<< HEAD
    <div class="wpb_text_column wpb_content_element ">
        <div class="wpb_wrapper">
            <p>Uma boa maneira de melhorar suas habilidades em R é desenvolvendo projetos práticos, mesmo que não seja algo que envolva aplicar técnicas avançadas estatísticas. Suponha por exemplo que você gostaria que existisse um site que mostrasse no final do dia as principais movimentações na Bovespa, destacando às ações que tiveram uma maior variação em seu preço, em comparação com o preço de fechamento anterior.</p>

=======
<div class="post-inner-content">
<div class="vc_row wpb_row vc_row-fluid vc_custom_1506116488244 vc_row-has-fill">
<div class="wpb_column vc_column_container vc_col-sm-12">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
<div class="wpb_text_column wpb_content_element ">
<div class="wpb_wrapper">
<p>
Uma boa maneira de melhorar suas habilidades em R é desenvolvendo
projetos práticos, mesmo que não seja algo que envolva aplicar técnicas
avançadas estatísticas. Suponha por exemplo que você gostaria
que existisse um site que mostrasse no final do dia as principais
movimentações na Bovespa, destacando às ações que tiveram uma maior
variação em seu preço, em comparação com o preço de fechamento anterior.
</p>
>>>>>>> 8ddb1ca530324468c273af37e5324e507c1ed797
<p>
Uma boa maneira de trabalhar com dados de ações seria com o pacote
<code>quantmod</code>. Contudo, para cumprir o desafio proposto neste
post, seria necessário baixar manualmente as ações de cada uma das
empresas listadas na Bovespa (lista essa que você teria de criar
manualmente), agrupar os dados em uma estrutura única (como um data
frame) e aplicar as funções de data wrangling necessárias.
</p>
<p>
Outra, que será a abordada aqui, é pelo web scraping, que consiste em
extrair dados de páginas na Internet de forma automatizada. Para
isso, <a href="http://exame.abril.com.br/mercados/cotacoes-bovespa/acoes?page=1%22">esta
página no site da Exame</a> nos ajuda. Ela (e as páginas subsequentes)
traz uma tabela com o nome da empresa, o preço da ação em R$ e a
variação em relação ao fechamento anterior, entre outras. Nós
precisamos, então, extrair a tabela da página, fazer a limpeza
necessária e trabalhar com os dados. Isso é muito mais fácil do que
parece.
</p>
<p>
Para este tutorial, usaremos estes pacotes:
</p>
<<<<<<< HEAD
<!-- Crayon Syntax Highlighter v_2.7.2_beta -->
        <div id="crayon-5a9ec59b7e35e689269853" class="crayon-syntax crayon-theme-classic crayon-font-monaco crayon-os-pc print-yes notranslate" data-settings=" minimize scroll-mouseover" style=" margin-top: 12px; margin-bottom: 12px; font-size: 12px !important; line-height: 15px !important;">
        
            <div class="crayon-toolbar" data-settings=" mouseover overlay hide delay" style="font-size: 12px !important;height: 18px !important; line-height: 18px !important;">

<span class="crayon-title"></span>

            <div class="crayon-info" style="min-height: 16.8px !important; line-height: 16.8px !important;"></div>
            <div class="crayon-plain-wrap"><textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">

=======
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
>>>>>>> 8ddb1ca530324468c273af37e5324e507c1ed797
library(rvest) \# web scraping library(tidyverse) \# suite de pacotes
library(magrittr) \# pipe = S2 library(stringr) \# manipulacao de texto
library(ggthemes) \# usaremos para fazer graficos parecidos com o da The
Economist library(ggrepel) \# para plotar o nome das principais acoes
</textarea>

<<<<<<< HEAD
            <div class="crayon-main" style="">
                <table class="crayon-table"><tr class="crayon-row">

<td class="crayon-nums " data-settings="show">
                    <div class="crayon-nums-content" style="font-size: 12px !important; line-height: 15px !important;">

=======
<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
>>>>>>> 8ddb1ca530324468c273af37e5324e507c1ed797
1

2

3

4

5

6

<<<<<<< HEAD
</div>
                </td>
                        <td class="crayon-code"><div class="crayon-pre" style="font-size: 12px !important; line-height: 15px !important; -moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4;">

=======
</td>
<td class="crayon-code">
>>>>>>> 8ddb1ca530324468c273af37e5324e507c1ed797
<span class="crayon-e">library</span><span
class="crayon-sy">(</span><span class="crayon-v">rvest</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-p">\# web scraping</span>

<span class="crayon-e">library</span><span
class="crayon-sy">(</span><span class="crayon-v">tidyverse</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-p">\# suite de pacotes</span>

<span class="crayon-e">library</span><span
class="crayon-sy">(</span><span class="crayon-v">magrittr</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-p">\# pipe = S2</span>

<span class="crayon-e">library</span><span
class="crayon-sy">(</span><span class="crayon-v">stringr</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-p">\# manipulacao de texto</span>

<span class="crayon-e">library</span><span
class="crayon-sy">(</span><span class="crayon-v">ggthemes</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-p">\# usaremos para fazer graficos parecidos com o da The
Economist</span>

<span class="crayon-e">library</span><span
class="crayon-sy">(</span><span class="crayon-v">ggrepel</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-p">\# para plotar o nome das principais acoes</span>

<<<<<<< HEAD
</div>
</td>
                    </tr></table>

        </div>

<!-- [Format Time: 0.0005 seconds] -->
=======
</td>
</tr>
</table>

>>>>>>> 8ddb1ca530324468c273af37e5324e507c1ed797
<p>
</p>
<h3>
Obtenção dos dados
</h3>
<p>
Primeiramente, vamos construir um vetor com todas as páginas das
ações.No momento deste post, eram 17:
</p>
<<<<<<< HEAD
<!-- Crayon Syntax Highlighter v_2.7.2_beta -->
        <div id="crayon-5a9ec59b7e367932956873" class="crayon-syntax crayon-theme-classic crayon-font-monaco crayon-os-pc print-yes notranslate" data-settings=" minimize scroll-mouseover" style=" margin-top: 12px; margin-bottom: 12px; font-size: 12px !important; line-height: 15px !important;">
        
            <div class="crayon-toolbar" data-settings=" mouseover overlay hide delay" style="font-size: 12px !important;height: 18px !important; line-height: 18px !important;">

<span class="crayon-title"></span>

            <div class="crayon-info" style="min-height: 16.8px !important; line-height: 16.8px !important;"></div>
            <div class="crayon-plain-wrap"><textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">

url.exame 1:17)
</textarea>

            <div class="crayon-main" style="">
                <table class="crayon-table"><tr class="crayon-row">

<td class="crayon-nums " data-settings="show">
                    <div class="crayon-nums-content" style="font-size: 12px !important; line-height: 15px !important;"><div class="crayon-num" data-line="crayon-5a9ec59b7e367932956873-1">1</div></div>
                </td>
                        <td class="crayon-code"><div class="crayon-pre" style="font-size: 12px !important; line-height: 15px !important; -moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4;"><div class="crayon-line" id="crayon-5a9ec59b7e367932956873-1">

=======
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
url.exame 1:17)
</textarea>

<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
1

</td>
<td class="crayon-code">
>>>>>>> 8ddb1ca530324468c273af37e5324e507c1ed797
<span class="crayon-v">url</span><span class="crayon-sy">.</span><span
class="crayon-i">exame</span><span class="crayon-h"> </span><span
class="crayon-cn">1</span><span class="crayon-o">:</span><span
class="crayon-cn">17</span><span class="crayon-sy">)</span>
<<<<<<< HEAD
</div>
</div>
</td>
                    </tr></table>

</div>
        </div>

<!-- [Format Time: 0.0001 seconds] -->
=======

</td>
</tr>
</table>

>>>>>>> 8ddb1ca530324468c273af37e5324e507c1ed797
<p>
Sobre cada página criada no comando acima, será executada a função
criada abaixo para extrair a tabela que precisamos:
</p>
<<<<<<< HEAD
<!-- Crayon Syntax Highlighter v_2.7.2_beta -->
        <div id="crayon-5a9ec59b7e369764894005" class="crayon-syntax crayon-theme-classic crayon-font-monaco crayon-os-pc print-yes notranslate" data-settings=" minimize scroll-mouseover" style=" margin-top: 12px; margin-bottom: 12px; font-size: 12px !important; line-height: 15px !important;">
        
            <div class="crayon-toolbar" data-settings=" mouseover overlay hide delay" style="font-size: 12px !important;height: 18px !important; line-height: 18px !important;">

<span class="crayon-title"></span>

</div>
            <div class="crayon-info" style="min-height: 16.8px !important; line-height: 16.8px !important;"></div>
            <div class="crayon-plain-wrap"><textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">

=======
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
>>>>>>> 8ddb1ca530324468c273af37e5324e507c1ed797
extrair.tabela % read\_html() %&gt;% \# le codigo fonte da pagina
html\_table() %&gt;% \# extrai tabelas da pagina .\[\[2\]\] %&gt;% \#
por tentativa e erro, das tabelas retornadas, a que queremos é a segunda
select(1:3) %&gt;% \# apenas as tres primeiras colunas sao usadas
set\_names(c("acao", "preco\_reais", "variacao")) %&gt;% \# renomeia
colunas as.data.frame() }
</textarea>
<<<<<<< HEAD
</div>
            <div class="crayon-main" style="">
                <table class="crayon-table"><tr class="crayon-row">

<td class="crayon-nums " data-settings="show">
                    <div class="crayon-nums-content" style="font-size: 12px !important; line-height: 15px !important;">

=======

<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
>>>>>>> 8ddb1ca530324468c273af37e5324e507c1ed797
1

2

3

4

5

6

7

8

<<<<<<< HEAD
</div>
                </td>
                        <td class="crayon-code"><div class="crayon-pre" style="font-size: 12px !important; line-height: 15px !important; -moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4;">

=======
</td>
<td class="crayon-code">
>>>>>>> 8ddb1ca530324468c273af37e5324e507c1ed797
<span class="crayon-v">extrair</span><span
class="crayon-sy">.</span><span class="crayon-v">tabela</span><span
class="crayon-h"> </span><span class="crayon-o">%</span>

<span class="crayon-e">read\_html</span><span
class="crayon-sy">(</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">%</span><span
class="crayon-o">&</span><span class="crayon-v">gt</span><span
class="crayon-sy">;</span><span class="crayon-o">%</span><span
class="crayon-h"> </span><span class="crayon-p">\# le codigo fonte da
pagina</span>

<span class="crayon-e">html\_table</span><span
class="crayon-sy">(</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">%</span><span
class="crayon-o">&</span><span class="crayon-v">gt</span><span
class="crayon-sy">;</span><span class="crayon-o">%</span><span
class="crayon-h"> </span><span class="crayon-p">\# extrai tabelas da
pagina</span>

<span class="crayon-sy">.</span><span class="crayon-sy">\[</span><span
class="crayon-sy">\[</span><span
class="crayon-cn">2</span><span class="crayon-sy">\]</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-o">%</span><span
class="crayon-o">&</span><span class="crayon-v">gt</span><span
class="crayon-sy">;</span><span class="crayon-o">%</span><span
class="crayon-h"> </span><span class="crayon-p">\# por tentativa e erro,
das tabelas retornadas, a que queremos é a segunda</span>

<span class="crayon-e">select</span><span
class="crayon-sy">(</span><span class="crayon-cn">1</span><span
class="crayon-o">:</span><span class="crayon-cn">3</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&</span><span
class="crayon-v">gt</span><span class="crayon-sy">;</span><span
class="crayon-o">%</span><span class="crayon-h"> </span><span
class="crayon-p">\# apenas as tres primeiras colunas sao usadas</span>

<span class="crayon-e">set\_names</span><span
class="crayon-sy">(</span><span class="crayon-e">c</span><span
class="crayon-sy">(</span><span class="crayon-s">"acao"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-s">"preco\_reais"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-s">"variacao"</span><span class="crayon-sy">)</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&</span><span
class="crayon-v">gt</span><span class="crayon-sy">;</span><span
class="crayon-o">%</span><span class="crayon-h"> </span><span
class="crayon-p">\# renomeia colunas</span>

<span class="crayon-st">as</span><span class="crayon-sy">.</span><span
class="crayon-v">data</span><span class="crayon-sy">.</span><span
class="crayon-e">frame</span><span class="crayon-sy">(</span><span
class="crayon-sy">)</span>

<span class="crayon-sy">}</span>

<<<<<<< HEAD
</div>
</td>
                    </tr></table>

</div>
        </div>

<!-- [Format Time: 0.0007 seconds] -->
<p>
</p>
<!-- Crayon Syntax Highlighter v_2.7.2_beta -->
        <div id="crayon-5a9ec59b7e36b869892835" class="crayon-syntax crayon-theme-classic crayon-font-monaco crayon-os-pc print-yes notranslate" data-settings=" minimize scroll-mouseover" style=" margin-top: 12px; margin-bottom: 12px; font-size: 12px !important; line-height: 15px !important;">
        
            <div class="crayon-toolbar" data-settings=" mouseover overlay hide delay" style="font-size: 12px !important;height: 18px !important; line-height: 18px !important;">

<span class="crayon-title"></span>

</div>
            <div class="crayon-info" style="min-height: 16.8px !important; line-height: 16.8px !important;"></div>
            <div class="crayon-plain-wrap"><textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">

=======
</td>
</tr>
</table>

<p>
</p>
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
>>>>>>> 8ddb1ca530324468c273af37e5324e507c1ed797
lista.acoes % map(extrair.tabela) \# checando se deu certo lista.acoes
%&gt;% map\_lgl(is.data.frame)

\[1\] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
---------------------------------------------------------------------------

\[15\] TRUE TRUE TRUE
---------------------

transformar os 17 dataframes em um so
=====================================

df.acoes % bind\_rows() \# checando o arquivo str(df.acoes)

'data.frame': 489 obs. of 3 variables:
--------------------------------------

$ acao : chr "ABCB4ABC Brasil PN" "ABEV3Ambev S.A" "AEFI11FII AESAPAR CI" "AELP3AES Elpa ON" ...
------------------------------------------------------------------------------------------------

$ preco\_reais: chr "16,31" "19,39" "146,25" "6,07" ...
-------------------------------------------------------

\#\# $ variacao : chr "-0,49" "0,21" "-1,18" "-0,16" ...
</textarea>
<<<<<<< HEAD
</div>
            <div class="crayon-main" style="">
                <table class="crayon-table"><tr class="crayon-row">

<td class="crayon-nums " data-settings="show">
                    <div class="crayon-nums-content" style="font-size: 12px !important; line-height: 15px !important;">

=======

<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
>>>>>>> 8ddb1ca530324468c273af37e5324e507c1ed797
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

<<<<<<< HEAD
</div>
                </td>
                        <td class="crayon-code"><div class="crayon-pre" style="font-size: 12px !important; line-height: 15px !important; -moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4;">

=======
</td>
<td class="crayon-code">
>>>>>>> 8ddb1ca530324468c273af37e5324e507c1ed797
<span class="crayon-v">lista</span><span class="crayon-sy">.</span><span
class="crayon-v">acoes</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-h"> </span><span
class="crayon-e">map</span><span class="crayon-sy">(</span><span
class="crayon-v">extrair</span><span class="crayon-sy">.</span><span
class="crayon-v">tabela</span><span class="crayon-sy">)</span>

<span class="crayon-p">\# checando se deu certo</span>

<span class="crayon-v">lista</span><span class="crayon-sy">.</span><span
class="crayon-v">acoes</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&</span><span
class="crayon-v">gt</span><span class="crayon-sy">;</span><span
class="crayon-o">%</span><span class="crayon-h"> </span><span
class="crayon-e">map\_lgl</span><span class="crayon-sy">(</span><span
class="crayon-st">is</span><span class="crayon-sy">.</span><span
class="crayon-v">data</span><span class="crayon-sy">.</span><span
class="crayon-v">frame</span><span class="crayon-sy">)</span>

 

<span class="crayon-p">\#\# \[1\] TRUE TRUE TRUE TRUE TRUE TRUE TRUE
TRUE TRUE TRUE TRUE TRUE TRUE TRUE</span>

<span class="crayon-p">\#\# \[15\] TRUE TRUE TRUE</span>

<span class="crayon-p">\# transformar os 17 dataframes em um so</span>

<span class="crayon-v">df</span><span class="crayon-sy">.</span><span
class="crayon-v">acoes</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-h"> </span><span
class="crayon-e">bind\_rows</span><span class="crayon-sy">(</span><span
class="crayon-sy">)</span>

<span class="crayon-p">\# checando o arquivo</span>

<span class="crayon-e">str</span><span class="crayon-sy">(</span><span
class="crayon-v">df</span><span class="crayon-sy">.</span><span
class="crayon-v">acoes</span><span class="crayon-sy">)</span>

 

<span class="crayon-p">\#\# 'data.frame': 489 obs. of 3
variables:</span>

<span class="crayon-p">\#\# $ acao : chr "ABCB4ABC Brasil PN"
"ABEV3Ambev S.A" "AEFI11FII AESAPAR CI" "AELP3AES Elpa ON" ...</span>

<span class="crayon-p">\#\# $ preco\_reais: chr "16,31" "19,39" "146,25"
"6,07" ...</span>

<span class="crayon-p">\#\# $ variacao : chr "-0,49" "0,21" "-1,18"
"-0,16" ...</span>

<<<<<<< HEAD
</div>
</td>
                    </tr></table>

</div>
        </div>

<!-- [Format Time: 0.0006 seconds] -->
=======
</td>
</tr>
</table>

>>>>>>> 8ddb1ca530324468c273af37e5324e507c1ed797
<p>
 
</p>
<h3>
Limpeza dos dados
</h3>
<p>
Como visto, os dados precisam passar por uma certa limpeza:<br> A coluna
<code>acao</code> precisa ser quebrada em duas: uma com o código da ação
(Ex.: ABEV3) e outra com o nome da empresa. Ambas são separadas pelo
<<<<<<< HEAD
string <code>;<br> As duas outras colunas precisam ser convertidas para
numéricas.
=======
string <code></code>;<br> As duas outras colunas precisam ser
convertidas para numéricas.
>>>>>>> 8ddb1ca530324468c273af37e5324e507c1ed797
</p>
<p>
Essas tarefas também não são difíceis graças aos pacotes
<code>tidyr</code> e <code>stringr</code>:
</p>
<h4>
1.  Separar a primeira coluna em duas diferentes pelo separador “”
    </h4>
    <p>
    </p>
<<<<<<< HEAD
    <!-- Crayon Syntax Highlighter v_2.7.2_beta -->
        <div id="crayon-5a9ec59b7e36e364937809" class="crayon-syntax crayon-theme-classic crayon-font-monaco crayon-os-pc print-yes notranslate" data-settings=" minimize scroll-mouseover" style=" margin-top: 12px; margin-bottom: 12px; font-size: 12px !important; line-height: 15px !important;">

            <div class="crayon-toolbar" data-settings=" mouseover overlay hide delay" style="font-size: 12px !important;height: 18px !important; line-height: 18px !important;">

    <span class="crayon-title"></span>

    </div>
            <div class="crayon-info" style="min-height: 16.8px !important; line-height: 16.8px !important;"></div>
            <div class="crayon-plain-wrap"><textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">

=======
    <div id="crayon-5a9eed9c1354a793750538" class="crayon-syntax crayon-theme-classic crayon-font-monaco crayon-os-pc print-yes notranslate" data-settings=" minimize scroll-mouseover" style=" margin-top: 12px; margin-bottom: 12px; font-size: 12px !important; line-height: 15px !important;">
    <span class="crayon-title"></span>

    <div class="crayon-plain-wrap">
    <textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
>>>>>>> 8ddb1ca530324468c273af37e5324e507c1ed797
    df.acoes %&lt;&gt;% separate(acao, c("codigo\_acao",
    "nome\_empresa"), "\[\]")
    df.acoes*n**o**m**e*<sub>*e*</sub>*m**p**r**e**s**a*</span><span
    class="crayon-v">nome\_empresa</span><span class="crayon-h">
    </span><span class="crayon-o">%</span><span
    class="crayon-o">&</span><span class="crayon-v">lt</span><span
    class="crayon-sy">;</span><span class="crayon-o">&</span><span
    class="crayon-v">gt</span><span class="crayon-sy">;</span><span
    class="crayon-o">%</span><span class="crayon-h"> </span><span
    class="crayon-e">str\_trim</span><span
    class="crayon-sy">(</span><span class="crayon-sy">)</span>
    </div>
    </div>
    </td>
<<<<<<< HEAD
                    </tr></table>

    </div>
        </div>

    <!-- [Format Time: 0.0004 seconds] -->
    <p>
    </p>
    <h4>
    1.  Converter colunas de preco e de variacao para numerico
        </h4>
        <p>
        </p>
        <!-- Crayon Syntax Highlighter v_2.7.2_beta -->
            <div class="crayon-toolbar" data-settings=" mouseover overlay hide delay" style="font-size: 12px !important;height: 18px !important; line-height: 18px !important;">

        <span class="crayon-title"></span>

            <div class="crayon-info" style="min-height: 16.8px !important; line-height: 16.8px !important;"></div>
            <div class="crayon-plain-wrap"><textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">

        df.acoes*p**r**e**c**o*<sub>*r*</sub>*e**a**i**s*preco\_reais
        %&lt;&gt;% str\_replace(",", ".") \# remover pontos
        (ex.:1.004,15)
        df.acoes*p**r**e**c**o*<sub>*r*</sub>*e**a**i**s*variacao
        %&lt;&gt;% str\_replace("\\.", "") \# remover pontos
        (ex.:1.004,15) df.acoes*v**a**r**i**a**c**a**o*variacao
        %&lt;&gt;% as.numeric()
=======
    </tr>
    </table>
    </div>
    </div>

<p>
</p>
<h4>
1.  Converter colunas de preco e de variacao para numerico
    </h4>
    <p>
    </p>
    <div id="crayon-5a9eed9c1354d321660598" class="crayon-syntax crayon-theme-classic crayon-font-monaco crayon-os-pc print-yes notranslate" data-settings=" minimize scroll-mouseover" style=" margin-top: 12px; margin-bottom: 12px; font-size: 12px !important; line-height: 15px !important;">
    <span class="crayon-title"></span>

    <div class="crayon-plain-wrap">
    <textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
    df.acoes*p**r**e**c**o*<sub>*r*</sub>*e**a**i**s*preco\_reais
    %&lt;&gt;% str\_replace(",", ".") \# remover pontos (ex.:1.004,15)
    df.acoes*p**r**e**c**o*<sub>*r*</sub>*e**a**i**s*variacao %&lt;&gt;%
    str\_replace("\\.", "") \# remover pontos (ex.:1.004,15)
    df.acoes*v**a**r**i**a**c**a**o*variacao %&lt;&gt;% as.numeric()
>>>>>>> 8ddb1ca530324468c273af37e5324e507c1ed797

str(df.acoes)

'data.frame': 489 obs. of 4 variables:
--------------------------------------

$ codigo\_acao : chr "ABCB4" "ABEV3" "AEFI11" "AELP3" ...
---------------------------------------------------------

$ nome\_empresa: chr "ABC Brasil PN" "Ambev S.A" "FII AESAPAR CI" "AES Elpa ON" ...
-----------------------------------------------------------------------------------

$ preco\_reais : num 16.31 19.39 146.25 6.07 4.9 ...
----------------------------------------------------

$ variacao : num -0.49 0.21 -1.18 -0.16 0 -6.57 0.08 0 0 0 ...
--------------------------------------------------------------

</textarea>
</div>
<<<<<<< HEAD
            <div class="crayon-main" style="">
                <table class="crayon-table"><tr class="crayon-row">

<td class="crayon-nums " data-settings="show">
                    <div class="crayon-nums-content" style="font-size: 12px !important; line-height: 15px !important;">

=======
<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
>>>>>>> 8ddb1ca530324468c273af37e5324e507c1ed797
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

<<<<<<< HEAD
</div>
                </td>
                        <td class="crayon-code"><div class="crayon-pre" style="font-size: 12px !important; line-height: 15px !important; -moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4;">

<span class="crayon-v">df</span><span class="crayon-sy">.</span><span
class="crayon-v">acoes</span><span
class="crayon-sy">$&lt;/span&gt;&lt;span class="crayon-v"&gt;preco\_reais&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;%&lt;/span&gt;&lt;span class="crayon-o"&gt;&amp;&lt;/span&gt;&lt;span class="crayon-v"&gt;lt&lt;/span&gt;&lt;span class="crayon-sy"&gt;;&lt;/span&gt;&lt;span class="crayon-o"&gt;&amp;&lt;/span&gt;&lt;span class="crayon-v"&gt;gt&lt;/span&gt;&lt;span class="crayon-sy"&gt;;&lt;/span&gt;&lt;span class="crayon-o"&gt;%&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-e"&gt;str\_replace&lt;/span&gt;&lt;span class="crayon-sy"&gt;(&lt;/span&gt;&lt;span class="crayon-s"&gt;"\\\\."&lt;/span&gt;&lt;span class="crayon-sy"&gt;,&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-s"&gt;""&lt;/span&gt;&lt;span class="crayon-sy"&gt;)&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-p"&gt;\# remover pontos (ex.:1.004,15)&lt;/span&gt; &lt;/div&gt; &lt;div class="crayon-line crayon-striped-line" id="crayon-5a9ec59b7e370098630247-2"&gt; &lt;span class="crayon-v"&gt;df&lt;/span&gt;&lt;span class="crayon-sy"&gt;.&lt;/span&gt;&lt;span class="crayon-v"&gt;acoes&lt;/span&gt;&lt;span class="crayon-sy"&gt;$</span><span
=======
</td>
<td class="crayon-code">
<span class="crayon-v">df</span><span class="crayon-sy">.</span><span
class="crayon-v">acoes</span><span
class="crayon-sy">$&lt;/span&gt;&lt;span class="crayon-v"&gt;preco\_reais&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;%&lt;/span&gt;&lt;span class="crayon-o"&gt;&amp;&lt;/span&gt;&lt;span class="crayon-v"&gt;lt&lt;/span&gt;&lt;span class="crayon-sy"&gt;;&lt;/span&gt;&lt;span class="crayon-o"&gt;&amp;&lt;/span&gt;&lt;span class="crayon-v"&gt;gt&lt;/span&gt;&lt;span class="crayon-sy"&gt;;&lt;/span&gt;&lt;span class="crayon-o"&gt;%&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-e"&gt;str\_replace&lt;/span&gt;&lt;span class="crayon-sy"&gt;(&lt;/span&gt;&lt;span class="crayon-s"&gt;"\\\\."&lt;/span&gt;&lt;span class="crayon-sy"&gt;,&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-s"&gt;""&lt;/span&gt;&lt;span class="crayon-sy"&gt;)&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-p"&gt;\# remover pontos (ex.:1.004,15)&lt;/span&gt; &lt;/div&gt; &lt;div class="crayon-line crayon-striped-line" id="crayon-5a9eed9c1354d321660598-2"&gt; &lt;span class="crayon-v"&gt;df&lt;/span&gt;&lt;span class="crayon-sy"&gt;.&lt;/span&gt;&lt;span class="crayon-v"&gt;acoes&lt;/span&gt;&lt;span class="crayon-sy"&gt;$</span><span
>>>>>>> 8ddb1ca530324468c273af37e5324e507c1ed797
class="crayon-v">preco\_reais</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&</span><span
class="crayon-v">lt</span><span class="crayon-sy">;</span><span
class="crayon-o">&</span><span class="crayon-v">gt</span><span
class="crayon-sy">;</span><span class="crayon-o">%</span><span
class="crayon-h"> </span><span class="crayon-e">str\_replace</span><span
class="crayon-sy">(</span><span class="crayon-s">","</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-s">"."</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-p">\# remover pontos
(ex.:1.004,15)</span>

<span class="crayon-v">df</span><span class="crayon-sy">.</span><span
class="crayon-v">acoes</span><span
<<<<<<< HEAD
class="crayon-sy">$&lt;/span&gt;&lt;span class="crayon-v"&gt;preco\_reais&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;%&lt;/span&gt;&lt;span class="crayon-o"&gt;&amp;&lt;/span&gt;&lt;span class="crayon-v"&gt;lt&lt;/span&gt;&lt;span class="crayon-sy"&gt;;&lt;/span&gt;&lt;span class="crayon-o"&gt;&amp;&lt;/span&gt;&lt;span class="crayon-v"&gt;gt&lt;/span&gt;&lt;span class="crayon-sy"&gt;;&lt;/span&gt;&lt;span class="crayon-o"&gt;%&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-st"&gt;as&lt;/span&gt;&lt;span class="crayon-sy"&gt;.&lt;/span&gt;&lt;span class="crayon-e"&gt;numeric&lt;/span&gt;&lt;span class="crayon-sy"&gt;(&lt;/span&gt;&lt;span class="crayon-sy"&gt;)&lt;/span&gt; &lt;/div&gt; &lt;div class="crayon-line crayon-striped-line" id="crayon-5a9ec59b7e370098630247-4"&gt; &lt;span class="crayon-v"&gt;df&lt;/span&gt;&lt;span class="crayon-sy"&gt;.&lt;/span&gt;&lt;span class="crayon-v"&gt;acoes&lt;/span&gt;&lt;span class="crayon-sy"&gt;$</span><span
=======
class="crayon-sy">$&lt;/span&gt;&lt;span class="crayon-v"&gt;preco\_reais&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;%&lt;/span&gt;&lt;span class="crayon-o"&gt;&amp;&lt;/span&gt;&lt;span class="crayon-v"&gt;lt&lt;/span&gt;&lt;span class="crayon-sy"&gt;;&lt;/span&gt;&lt;span class="crayon-o"&gt;&amp;&lt;/span&gt;&lt;span class="crayon-v"&gt;gt&lt;/span&gt;&lt;span class="crayon-sy"&gt;;&lt;/span&gt;&lt;span class="crayon-o"&gt;%&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-st"&gt;as&lt;/span&gt;&lt;span class="crayon-sy"&gt;.&lt;/span&gt;&lt;span class="crayon-e"&gt;numeric&lt;/span&gt;&lt;span class="crayon-sy"&gt;(&lt;/span&gt;&lt;span class="crayon-sy"&gt;)&lt;/span&gt; &lt;/div&gt; &lt;div class="crayon-line crayon-striped-line" id="crayon-5a9eed9c1354d321660598-4"&gt; &lt;span class="crayon-v"&gt;df&lt;/span&gt;&lt;span class="crayon-sy"&gt;.&lt;/span&gt;&lt;span class="crayon-v"&gt;acoes&lt;/span&gt;&lt;span class="crayon-sy"&gt;$</span><span
>>>>>>> 8ddb1ca530324468c273af37e5324e507c1ed797
class="crayon-v">variacao</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&</span><span
class="crayon-v">lt</span><span class="crayon-sy">;</span><span
class="crayon-o">&</span><span class="crayon-v">gt</span><span
class="crayon-sy">;</span><span class="crayon-o">%</span><span
class="crayon-h"> </span><span class="crayon-e">str\_replace</span><span
class="crayon-sy">(</span><span class="crayon-s">"\\."</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-s">""</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-p">\# remover pontos
(ex.:1.004,15)</span>

<span class="crayon-v">df</span><span class="crayon-sy">.</span><span
class="crayon-v">acoes</span><span
<<<<<<< HEAD
class="crayon-sy">$&lt;/span&gt;&lt;span class="crayon-v"&gt;variacao&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;%&lt;/span&gt;&lt;span class="crayon-o"&gt;&amp;&lt;/span&gt;&lt;span class="crayon-v"&gt;lt&lt;/span&gt;&lt;span class="crayon-sy"&gt;;&lt;/span&gt;&lt;span class="crayon-o"&gt;&amp;&lt;/span&gt;&lt;span class="crayon-v"&gt;gt&lt;/span&gt;&lt;span class="crayon-sy"&gt;;&lt;/span&gt;&lt;span class="crayon-o"&gt;%&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-e"&gt;str\_replace&lt;/span&gt;&lt;span class="crayon-sy"&gt;(&lt;/span&gt;&lt;span class="crayon-s"&gt;","&lt;/span&gt;&lt;span class="crayon-sy"&gt;,&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-s"&gt;"."&lt;/span&gt;&lt;span class="crayon-sy"&gt;)&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-p"&gt;\# remover pontos (ex.:1.004,15)&lt;/span&gt; &lt;/div&gt; &lt;div class="crayon-line crayon-striped-line" id="crayon-5a9ec59b7e370098630247-6"&gt; &lt;span class="crayon-v"&gt;df&lt;/span&gt;&lt;span class="crayon-sy"&gt;.&lt;/span&gt;&lt;span class="crayon-v"&gt;acoes&lt;/span&gt;&lt;span class="crayon-sy"&gt;$</span><span
=======
class="crayon-sy">$&lt;/span&gt;&lt;span class="crayon-v"&gt;variacao&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;%&lt;/span&gt;&lt;span class="crayon-o"&gt;&amp;&lt;/span&gt;&lt;span class="crayon-v"&gt;lt&lt;/span&gt;&lt;span class="crayon-sy"&gt;;&lt;/span&gt;&lt;span class="crayon-o"&gt;&amp;&lt;/span&gt;&lt;span class="crayon-v"&gt;gt&lt;/span&gt;&lt;span class="crayon-sy"&gt;;&lt;/span&gt;&lt;span class="crayon-o"&gt;%&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-e"&gt;str\_replace&lt;/span&gt;&lt;span class="crayon-sy"&gt;(&lt;/span&gt;&lt;span class="crayon-s"&gt;","&lt;/span&gt;&lt;span class="crayon-sy"&gt;,&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-s"&gt;"."&lt;/span&gt;&lt;span class="crayon-sy"&gt;)&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-p"&gt;\# remover pontos (ex.:1.004,15)&lt;/span&gt; &lt;/div&gt; &lt;div class="crayon-line crayon-striped-line" id="crayon-5a9eed9c1354d321660598-6"&gt; &lt;span class="crayon-v"&gt;df&lt;/span&gt;&lt;span class="crayon-sy"&gt;.&lt;/span&gt;&lt;span class="crayon-v"&gt;acoes&lt;/span&gt;&lt;span class="crayon-sy"&gt;$</span><span
>>>>>>> 8ddb1ca530324468c273af37e5324e507c1ed797
class="crayon-v">variacao</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&</span><span
class="crayon-v">lt</span><span class="crayon-sy">;</span><span
class="crayon-o">&</span><span class="crayon-v">gt</span><span
class="crayon-sy">;</span><span class="crayon-o">%</span><span
class="crayon-h"> </span><span class="crayon-st">as</span><span
class="crayon-sy">.</span><span class="crayon-e">numeric</span><span
class="crayon-sy">(</span><span class="crayon-sy">)</span>

 

<span class="crayon-e">str</span><span class="crayon-sy">(</span><span
class="crayon-v">df</span><span class="crayon-sy">.</span><span
class="crayon-v">acoes</span><span class="crayon-sy">)</span>

 

<span class="crayon-p">\#\# 'data.frame': 489 obs. of 4
variables:</span>

<span class="crayon-p">\#\# $ codigo\_acao : chr "ABCB4" "ABEV3"
"AEFI11" "AELP3" ...</span>

<span class="crayon-p">\#\# $ nome\_empresa: chr "ABC Brasil PN" "Ambev
S.A" "FII AESAPAR CI" "AES Elpa ON" ...</span>

<span class="crayon-p">\#\# $ preco\_reais : num 16.31 19.39 146.25 6.07
4.9 ...</span>

<span class="crayon-p">\#\# $ variacao : num -0.49 0.21 -1.18 -0.16 0
-6.57 0.08 0 0 0 ...</span>

 

<<<<<<< HEAD
</div>
</td>
                    </tr></table>

</div>
        </div>

<!-- [Format Time: 0.0012 seconds] -->
=======
</td>
</tr>
</table>

</div>
>>>>>>> 8ddb1ca530324468c273af37e5324e507c1ed797
<p>
 
</p>
<h3>
Análise e apresentação dos dados
</h3>
<p>
Agora já estamos prontos para partir para a análise.
</p>
<p>
Primeiramente, qual a distribuição da variação dos preços das ações?
</p>
<<<<<<< HEAD
<!-- Crayon Syntax Highlighter v_2.7.2_beta -->
        <div id="crayon-5a9ec59b7e373271899726" class="crayon-syntax crayon-theme-classic crayon-font-monaco crayon-os-pc print-yes notranslate" data-settings=" minimize scroll-mouseover" style=" margin-top: 12px; margin-bottom: 12px; font-size: 12px !important; line-height: 15px !important;">
        
            <div class="crayon-toolbar" data-settings=" mouseover overlay hide delay" style="font-size: 12px !important;height: 18px !important; line-height: 18px !important;">

<span class="crayon-title"></span>

</div>
            <div class="crayon-info" style="min-height: 16.8px !important; line-height: 16.8px !important;"></div>
            <div class="crayon-plain-wrap"><textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">

df.acoes %&gt;% ggplot(aes(x = variacao)) + geom\_histogram() +
theme\_economist()
</textarea>
</div>
            <div class="crayon-main" style="">
                <table class="crayon-table"><tr class="crayon-row">

<td class="crayon-nums " data-settings="show">
                    <div class="crayon-nums-content" style="font-size: 12px !important; line-height: 15px !important;">

=======
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
df.acoes %&gt;% ggplot(aes(x = variacao)) + geom\_histogram() +
theme\_economist()
</textarea>

<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
>>>>>>> 8ddb1ca530324468c273af37e5324e507c1ed797
1

2

3

4

<<<<<<< HEAD
</div>
                </td>
                        <td class="crayon-code"><div class="crayon-pre" style="font-size: 12px !important; line-height: 15px !important; -moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4;">

=======
</td>
<td class="crayon-code">
>>>>>>> 8ddb1ca530324468c273af37e5324e507c1ed797
<span class="crayon-v">df</span><span class="crayon-sy">.</span><span
class="crayon-v">acoes</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&</span><span
class="crayon-v">gt</span><span class="crayon-sy">;</span><span
class="crayon-o">%</span>

<span class="crayon-e">ggplot</span><span
class="crayon-sy">(</span><span class="crayon-e">aes</span><span
class="crayon-sy">(</span><span class="crayon-v">x</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-v">variacao</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">+</span>

<span class="crayon-e">geom\_histogram</span><span
class="crayon-sy">(</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">+</span>

<span class="crayon-e">theme\_economist</span><span
class="crayon-sy">(</span><span class="crayon-sy">)</span>

<<<<<<< HEAD
</div>
</td>
                    </tr></table>

</div>
        </div>

<!-- [Format Time: 0.0003 seconds] -->
<p>
</p>
        </div>
    </div>

    <div class="wpb_single_image wpb_content_element vc_align_left">
        
        <figure class="wpb_wrapper vc_figure"><div class="vc_single_image-wrapper   vc_box_border_grey"><img width="864" height="480" src="https://www.ibpad.com.br/wp-content/uploads/2017/08/unnamed-chunk-6-1.png" class="vc_single_image-img attachment-full" alt="" srcset="https://www.ibpad.com.br/wp-content/uploads/2017/08/unnamed-chunk-6-1.png 864w, https://www.ibpad.com.br/wp-content/uploads/2017/08/unnamed-chunk-6-1-260x144.png 260w, https://www.ibpad.com.br/wp-content/uploads/2017/08/unnamed-chunk-6-1-768x427.png 768w, https://www.ibpad.com.br/wp-content/uploads/2017/08/unnamed-chunk-6-1-100x56.png 100w" sizes="(max-width: 864px) 100vw, 864px"></div>
        </figure>

</div>
    <div class="wpb_text_column wpb_content_element ">
        <div class="wpb_wrapper">
            <p>No geral, as ações variaram em torno de 0%, com a mediana estando ligeiramente para a esquerda do zero. O histograma mostra que existem alguns outliers, tanto para cima como para baixo.</p>

<p>
Vamos analisar quais foram as ações que mais variaram no dia de hoje:
</p>
<!-- Crayon Syntax Highlighter v_2.7.2_beta -->
        <div id="crayon-5a9ec59b7e375925851039" class="crayon-syntax crayon-theme-classic crayon-font-monaco crayon-os-pc print-yes notranslate" data-settings=" minimize scroll-mouseover" style=" margin-top: 12px; margin-bottom: 12px; font-size: 12px !important; line-height: 15px !important;">
        
            <div class="crayon-toolbar" data-settings=" mouseover overlay hide delay" style="font-size: 12px !important;height: 18px !important; line-height: 18px !important;">

<span class="crayon-title"></span>

</div>
            <div class="crayon-info" style="min-height: 16.8px !important; line-height: 16.8px !important;"></div>
            <div class="crayon-plain-wrap"><textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">

=======
</td>
</tr>
</table>

<p>
</p>
</div>
</div>
<figure class="wpb_wrapper vc_figure">
<img width="864" height="480" src="https://www.ibpad.com.br/wp-content/uploads/2017/08/unnamed-chunk-6-1.png" class="vc_single_image-img attachment-full" alt="" srcset="https://www.ibpad.com.br/wp-content/uploads/2017/08/unnamed-chunk-6-1.png 864w, https://www.ibpad.com.br/wp-content/uploads/2017/08/unnamed-chunk-6-1-260x144.png 260w, https://www.ibpad.com.br/wp-content/uploads/2017/08/unnamed-chunk-6-1-768x427.png 768w, https://www.ibpad.com.br/wp-content/uploads/2017/08/unnamed-chunk-6-1-100x56.png 100w" sizes="(max-width: 864px) 100vw, 864px">

</figure>

<div class="wpb_text_column wpb_content_element ">
<div class="wpb_wrapper">
<p>
No geral, as ações variaram em torno de 0%, com a mediana estando
ligeiramente para a esquerda do zero. O histograma mostra que existem
alguns outliers, tanto para cima como para baixo.
</p>
<p>
Vamos analisar quais foram as ações que mais variaram no dia de hoje:
</p>
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
>>>>>>> 8ddb1ca530324468c273af37e5324e507c1ed797
maiores subidas e quedas:
=========================

limite\_inferior % sort %&gt;% head(5) %&gt;% .\[5\] limite\_superior %
sort %&gt;% tail(5) %&gt;% .\[1\]

df.destaque % filter(variacao &lt;= limite\_inferior | variacao &gt;=
limite\_superior) %&gt;% arrange(desc(variacao))

df.destaque %&gt;% knitr::kable()

<table>
<thead>
<tr class="header">
<th align="left">codigo_acao</th>
<th align="left">nome_empresa</th>
<th align="right">preco_reais</th>
<th align="right">variacao</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">ELPL3</td>
<td align="left">AES Eletropaulo ON</td>
<td align="right">17.58</td>
<td align="right">19.59</td>
</tr>
<tr class="even">
<td align="left">CTSA4</td>
<td align="left">Santanense PN</td>
<td align="right">2.93</td>
<td align="right">13.13</td>
</tr>
<tr class="odd">
<td align="left">USIM6</td>
<td align="left">Usiminas PNB</td>
<td align="right">5.80</td>
<td align="right">10.06</td>
</tr>
<tr class="even">
<td align="left">DTCY3</td>
<td align="left">Dtcom ON</td>
<td align="right">3.74</td>
<td align="right">9.68</td>
</tr>
<tr class="odd">
<td align="left">LLIS3</td>
<td align="left">Restoque ON</td>
<td align="right">40.00</td>
<td align="right">8.11</td>
</tr>
<tr class="even">
<td align="left">PLAS3</td>
<td align="left">Plascar ON</td>
<td align="right">4.10</td>
<td align="right">-7.87</td>
</tr>
<tr class="odd">
<td align="left">SPRI3</td>
<td align="left">Springer ON</td>
<td align="right">9.39</td>
<td align="right">-8.83</td>
</tr>
<tr class="even">
<td align="left">CEPE6</td>
<td align="left">Celpe PNB</td>
<td align="right">15.91</td>
<td align="right">-9.09</td>
</tr>
<tr class="odd">
<td align="left">TXRX4</td>
<td align="left">Têxteis Renaux PN</td>
<td align="right">2.40</td>
<td align="right">-9.77</td>
</tr>
<tr class="even">
<td align="left">OGSA3</td>
<td align="left">NOVA ON</td>
<td align="right">1.80</td>
<td align="right">-15.89</td>
</tr>
</tbody>
</table>

</textarea>
<<<<<<< HEAD
</div>
            <div class="crayon-main" style="">
                <table class="crayon-table"><tr class="crayon-row">

<td class="crayon-nums " data-settings="show">
                    <div class="crayon-nums-content" style="font-size: 12px !important; line-height: 15px !important;">

=======

<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
>>>>>>> 8ddb1ca530324468c273af37e5324e507c1ed797
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

<<<<<<< HEAD
</div>
                </td>
                        <td class="crayon-code"><div class="crayon-pre" style="font-size: 12px !important; line-height: 15px !important; -moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4;">

=======
</td>
<td class="crayon-code">
>>>>>>> 8ddb1ca530324468c273af37e5324e507c1ed797
<span class="crayon-p">\# maiores subidas e quedas:</span>

<span class="crayon-v">limite\_inferior</span><span class="crayon-h">
</span><span class="crayon-o">%</span><span class="crayon-h">
</span><span class="crayon-v">sort</span><span class="crayon-h">
</span><span class="crayon-o">%</span><span
class="crayon-o">&</span><span class="crayon-v">gt</span><span
class="crayon-sy">;</span><span class="crayon-o">%</span><span
class="crayon-h"> </span><span class="crayon-e">head</span><span
class="crayon-sy">(</span><span class="crayon-cn">5</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&</span><span
class="crayon-v">gt</span><span class="crayon-sy">;</span><span
class="crayon-o">%</span><span class="crayon-h"> </span><span
class="crayon-sy">.</span><span class="crayon-sy">\[</span><span
class="crayon-cn">5</span><span class="crayon-sy">\]</span>

<span class="crayon-v">limite\_superior</span><span class="crayon-h">
</span><span class="crayon-o">%</span><span class="crayon-h">
</span><span class="crayon-v">sort</span><span class="crayon-h">
</span><span class="crayon-o">%</span><span
class="crayon-o">&</span><span class="crayon-v">gt</span><span
class="crayon-sy">;</span><span class="crayon-o">%</span><span
class="crayon-h"> </span><span class="crayon-e">tail</span><span
class="crayon-sy">(</span><span class="crayon-cn">5</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&</span><span
class="crayon-v">gt</span><span class="crayon-sy">;</span><span
class="crayon-o">%</span><span class="crayon-h"> </span><span
class="crayon-sy">.</span><span class="crayon-sy">\[</span><span
class="crayon-cn">1</span><span class="crayon-sy">\]</span>

 

<span class="crayon-v">df</span><span class="crayon-sy">.</span><span
class="crayon-v">destaque</span><span class="crayon-h"> </span><span
class="crayon-o">%</span>

<span class="crayon-e">filter</span><span
class="crayon-sy">(</span><span class="crayon-v">variacao</span><span
class="crayon-h"> </span><span class="crayon-o">&</span><span
class="crayon-v">lt</span><span class="crayon-sy">;</span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">limite\_inferior</span><span class="crayon-h">
</span><span class="crayon-o">|</span><span class="crayon-h">
</span><span class="crayon-v">variacao</span><span class="crayon-h">
</span><span class="crayon-o">&</span><span
class="crayon-v">gt</span><span class="crayon-sy">;</span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">limite\_superior</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&</span><span
class="crayon-v">gt</span><span class="crayon-sy">;</span><span
class="crayon-o">%</span>

<span class="crayon-e">arrange</span><span
class="crayon-sy">(</span><span class="crayon-e">desc</span><span
class="crayon-sy">(</span><span class="crayon-v">variacao</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span>

 

<span class="crayon-v">df</span><span class="crayon-sy">.</span><span
class="crayon-v">destaque</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&</span><span
class="crayon-v">gt</span><span class="crayon-sy">;</span><span
class="crayon-o">%</span><span class="crayon-h"> </span><span
class="crayon-v">knitr</span><span class="crayon-o">::</span><span
class="crayon-e">kable</span><span class="crayon-sy">(</span><span
class="crayon-sy">)</span>

 

 

<span class="crayon-o">|</span><span class="crayon-h"> </span><span
class="crayon-v">codigo</span><span class="crayon-sy">&lt;/span&gt;<span class="crayon-v">\_acao</span><span
class="crayon-h"> </span><span class="crayon-o">|</span><span
class="crayon-h"> </span><span
class="crayon-v">nome</span><span class="crayon-sy">&lt;/span&gt;<span class="crayon-v">\_empresa</span><span
class="crayon-h"> </span><span class="crayon-o">|</span><span
class="crayon-h"> </span><span
class="crayon-v">preco</span><span class="crayon-sy">&lt;/span&gt;<span class="crayon-v">\_reais</span><span
class="crayon-o">|</span><span class="crayon-h"> </span><span
class="crayon-v">variacao</span><span class="crayon-o">|</span>

<span class="crayon-o">|</span><span class="crayon-o">:</span><span
class="crayon-o">--</span><span class="crayon-o">--</span><span
class="crayon-o">--</span><span class="crayon-o">--</span><span
class="crayon-o">--</span><span class="crayon-o">--</span><span
class="crayon-o">-</span><span class="crayon-o">|</span><span
class="crayon-o">:</span><span class="crayon-o">--</span><span
class="crayon-o">--</span><span class="crayon-o">--</span><span
class="crayon-o">--</span><span class="crayon-o">--</span><span
class="crayon-o">--</span><span class="crayon-o">--</span><span
class="crayon-o">--</span><span class="crayon-o">--</span><span
class="crayon-o">-</span><span class="crayon-o">|</span><span
class="crayon-o">--</span><span class="crayon-o">--</span><span
class="crayon-o">--</span><span class="crayon-o">--</span><span
class="crayon-o">--</span><span class="crayon-o">--</span><span
class="crayon-o">-</span><span class="crayon-o">:</span><span
class="crayon-o">|</span><span class="crayon-o">--</span><span
class="crayon-o">--</span><span class="crayon-o">--</span><span
class="crayon-o">--</span><span class="crayon-o">-</span><span
class="crayon-o">:</span><span class="crayon-o">|</span>

<span class="crayon-o">|</span><span class="crayon-h"> </span><span
class="crayon-v">ELPL3</span><span class="crayon-h"> </span><span
class="crayon-o">|</span><span class="crayon-h"> </span><span
class="crayon-e">AES </span><span class="crayon-e">Eletropaulo
</span><span class="crayon-v">ON</span><span class="crayon-h">
</span><span class="crayon-o">|</span><span class="crayon-h">
</span><span class="crayon-cn">17.58</span><span
class="crayon-o">|</span><span class="crayon-h"> </span><span
class="crayon-cn">19.59</span><span class="crayon-o">|</span>

<span class="crayon-o">|</span><span class="crayon-h"> </span><span
class="crayon-v">CTSA4</span><span class="crayon-h"> </span><span
class="crayon-o">|</span><span class="crayon-h"> </span><span
class="crayon-e">Santanense </span><span class="crayon-v">PN</span><span
class="crayon-h"> </span><span class="crayon-o">|</span><span
class="crayon-h"> </span><span class="crayon-cn">2.93</span><span
class="crayon-o">|</span><span class="crayon-h"> </span><span
class="crayon-cn">13.13</span><span class="crayon-o">|</span>

<span class="crayon-o">|</span><span class="crayon-h"> </span><span
class="crayon-v">USIM6</span><span class="crayon-h"> </span><span
class="crayon-o">|</span><span class="crayon-h"> </span><span
class="crayon-e">Usiminas </span><span class="crayon-v">PNB</span><span
class="crayon-h"> </span><span class="crayon-o">|</span><span
class="crayon-h"> </span><span class="crayon-cn">5.80</span><span
class="crayon-o">|</span><span class="crayon-h"> </span><span
class="crayon-cn">10.06</span><span class="crayon-o">|</span>

<span class="crayon-o">|</span><span class="crayon-h"> </span><span
class="crayon-v">DTCY3</span><span class="crayon-h"> </span><span
class="crayon-o">|</span><span class="crayon-h"> </span><span
class="crayon-e">Dtcom </span><span class="crayon-v">ON</span><span
class="crayon-h"> </span><span class="crayon-o">|</span><span
class="crayon-h"> </span><span class="crayon-cn">3.74</span><span
class="crayon-o">|</span><span class="crayon-h"> </span><span
class="crayon-cn">9.68</span><span class="crayon-o">|</span>

<span class="crayon-o">|</span><span class="crayon-h"> </span><span
class="crayon-v">LLIS3</span><span class="crayon-h"> </span><span
class="crayon-o">|</span><span class="crayon-h"> </span><span
class="crayon-e">Restoque </span><span class="crayon-v">ON</span><span
class="crayon-h"> </span><span class="crayon-o">|</span><span
class="crayon-h"> </span><span class="crayon-cn">40.00</span><span
class="crayon-o">|</span><span class="crayon-h"> </span><span
class="crayon-cn">8.11</span><span class="crayon-o">|</span>

<span class="crayon-o">|</span><span class="crayon-h"> </span><span
class="crayon-v">PLAS3</span><span class="crayon-h"> </span><span
class="crayon-o">|</span><span class="crayon-h"> </span><span
class="crayon-e">Plascar </span><span class="crayon-v">ON</span><span
class="crayon-h"> </span><span class="crayon-o">|</span><span
class="crayon-h"> </span><span class="crayon-cn">4.10</span><span
class="crayon-o">|</span><span class="crayon-h"> </span><span
class="crayon-o">-</span><span class="crayon-cn">7.87</span><span
class="crayon-o">|</span>

<span class="crayon-o">|</span><span class="crayon-h"> </span><span
class="crayon-v">SPRI3</span><span class="crayon-h"> </span><span
class="crayon-o">|</span><span class="crayon-h"> </span><span
class="crayon-e">Springer </span><span class="crayon-v">ON</span><span
class="crayon-h"> </span><span class="crayon-o">|</span><span
class="crayon-h"> </span><span class="crayon-cn">9.39</span><span
class="crayon-o">|</span><span class="crayon-h"> </span><span
class="crayon-o">-</span><span class="crayon-cn">8.83</span><span
class="crayon-o">|</span>

<span class="crayon-o">|</span><span class="crayon-h"> </span><span
class="crayon-v">CEPE6</span><span class="crayon-h"> </span><span
class="crayon-o">|</span><span class="crayon-h"> </span><span
class="crayon-e">Celpe </span><span class="crayon-v">PNB</span><span
class="crayon-h"> </span><span class="crayon-o">|</span><span
class="crayon-h"> </span><span class="crayon-cn">15.91</span><span
class="crayon-o">|</span><span class="crayon-h"> </span><span
class="crayon-o">-</span><span class="crayon-cn">9.09</span><span
class="crayon-o">|</span>

<span class="crayon-o">|</span><span class="crayon-h"> </span><span
class="crayon-v">TXRX4</span><span class="crayon-h"> </span><span
class="crayon-o">|</span><span class="crayon-h"> </span><span
class="crayon-i">T</span>ê<span class="crayon-e">xteis </span><span
class="crayon-e">Renaux </span><span class="crayon-v">PN</span><span
class="crayon-h"> </span><span class="crayon-o">|</span><span
class="crayon-h"> </span><span class="crayon-cn">2.40</span><span
class="crayon-o">|</span><span class="crayon-h"> </span><span
class="crayon-o">-</span><span class="crayon-cn">9.77</span><span
class="crayon-o">|</span>

<span class="crayon-o">|</span><span class="crayon-h"> </span><span
class="crayon-v">OGSA3</span><span class="crayon-h"> </span><span
class="crayon-o">|</span><span class="crayon-h"> </span><span
class="crayon-e">NOVA </span><span class="crayon-v">ON</span><span
class="crayon-h"> </span><span class="crayon-o">|</span><span
class="crayon-h"> </span><span class="crayon-cn">1.80</span><span
class="crayon-o">|</span><span class="crayon-h"> </span><span
class="crayon-o">-</span><span class="crayon-cn">15.89</span><span
class="crayon-o">|</span>

 

<<<<<<< HEAD
</div>
</td>
                    </tr></table>

</div>
        </div>

<!-- [Format Time: 0.0025 seconds] -->
=======
</td>
</tr>
</table>

>>>>>>> 8ddb1ca530324468c273af37e5324e507c1ed797
<p>
 
</p>
<p>
Uma boa maneira de resumir o dia de hoje seria em um gráfico que
correlaciona o preço da ação com sua variação, destacando o TOP 10
acima:
</p>
<<<<<<< HEAD
<!-- Crayon Syntax Highlighter v_2.7.2_beta -->
        <div id="crayon-5a9ec59b7e377955586579" class="crayon-syntax crayon-theme-classic crayon-font-monaco crayon-os-pc print-yes notranslate" data-settings=" minimize scroll-mouseover" style=" margin-top: 12px; margin-bottom: 12px; font-size: 12px !important; line-height: 15px !important;">
        
            <div class="crayon-toolbar" data-settings=" mouseover overlay hide delay" style="font-size: 12px !important;height: 18px !important; line-height: 18px !important;">

<span class="crayon-title"></span>

</div>
            <div class="crayon-info" style="min-height: 16.8px !important; line-height: 16.8px !important;"></div>
            <div class="crayon-plain-wrap"><textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">

=======
<div id="crayon-5a9eed9c13554569173092" class="crayon-syntax crayon-theme-classic crayon-font-monaco crayon-os-pc print-yes notranslate" data-settings=" minimize scroll-mouseover" style=" margin-top: 12px; margin-bottom: 12px; font-size: 12px !important; line-height: 15px !important;">
<span class="crayon-title"></span>

<div class="crayon-plain-wrap">
<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
>>>>>>> 8ddb1ca530324468c273af37e5324e507c1ed797
df.acoes %&gt;% ggplot(aes(x = variacao, y = preco\_reais)) +
geom\_point() + geom\_text\_repel(data = df.destaque, aes(label =
codigo\_acao)) + theme\_economist() + labs(x = "Variação (%)", y =
"Preço
<<<<<<< HEAD
(R$)", title = "Painel de resumo diário da Bovespa", caption = "Blog do IBPAD - Sillas Gonzaga")&lt;/textarea&gt;&lt;/div&gt;  &lt;div class="crayon-main" style=""&gt;  &lt;table class="crayon-table"&gt;&lt;tr class="crayon-row"&gt; &lt;td class="crayon-nums " data-settings="show"&gt;  &lt;div class="crayon-nums-content" style="font-size: 12px !important; line-height: 15px !important;"&gt; &lt;div class="crayon-num" data-line="crayon-5a9ec59b7e377955586579-1"&gt;1&lt;/div&gt; &lt;div class="crayon-num crayon-striped-num" data-line="crayon-5a9ec59b7e377955586579-2"&gt;2&lt;/div&gt; &lt;div class="crayon-num" data-line="crayon-5a9ec59b7e377955586579-3"&gt;3&lt;/div&gt; &lt;div class="crayon-num crayon-striped-num" data-line="crayon-5a9ec59b7e377955586579-4"&gt;4&lt;/div&gt; &lt;div class="crayon-num" data-line="crayon-5a9ec59b7e377955586579-5"&gt;5&lt;/div&gt; &lt;div class="crayon-num crayon-striped-num" data-line="crayon-5a9ec59b7e377955586579-6"&gt;6&lt;/div&gt; &lt;div class="crayon-num" data-line="crayon-5a9ec59b7e377955586579-7"&gt;7&lt;/div&gt; &lt;div class="crayon-num crayon-striped-num" data-line="crayon-5a9ec59b7e377955586579-8"&gt;8&lt;/div&gt; &lt;/div&gt;  &lt;/td&gt;  &lt;td class="crayon-code"&gt;&lt;div class="crayon-pre" style="font-size: 12px !important; line-height: 15px !important; -moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4;"&gt; &lt;div class="crayon-line" id="crayon-5a9ec59b7e377955586579-1"&gt; &lt;span class="crayon-v"&gt;df&lt;/span&gt;&lt;span class="crayon-sy"&gt;.&lt;/span&gt;&lt;span class="crayon-v"&gt;acoes&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;%&lt;/span&gt;&lt;span class="crayon-o"&gt;&amp;&lt;/span&gt;&lt;span class="crayon-v"&gt;gt&lt;/span&gt;&lt;span class="crayon-sy"&gt;;&lt;/span&gt;&lt;span class="crayon-o"&gt;%&lt;/span&gt; &lt;/div&gt; &lt;div class="crayon-line crayon-striped-line" id="crayon-5a9ec59b7e377955586579-2"&gt; &lt;span class="crayon-e"&gt;ggplot&lt;/span&gt;&lt;span class="crayon-sy"&gt;(&lt;/span&gt;&lt;span class="crayon-e"&gt;aes&lt;/span&gt;&lt;span class="crayon-sy"&gt;(&lt;/span&gt;&lt;span class="crayon-v"&gt;x&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;=&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-v"&gt;variacao&lt;/span&gt;&lt;span class="crayon-sy"&gt;,&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-v"&gt;y&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;=&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-v"&gt;preco\_reais&lt;/span&gt;&lt;span class="crayon-sy"&gt;)&lt;/span&gt;&lt;span class="crayon-sy"&gt;)&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;+&lt;/span&gt; &lt;/div&gt; &lt;div class="crayon-line" id="crayon-5a9ec59b7e377955586579-3"&gt; &lt;span class="crayon-e"&gt;geom\_point&lt;/span&gt;&lt;span class="crayon-sy"&gt;(&lt;/span&gt;&lt;span class="crayon-sy"&gt;)&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;+&lt;/span&gt; &lt;/div&gt; &lt;div class="crayon-line crayon-striped-line" id="crayon-5a9ec59b7e377955586579-4"&gt; &lt;span class="crayon-e"&gt;geom\_text\_repel&lt;/span&gt;&lt;span class="crayon-sy"&gt;(&lt;/span&gt;&lt;span class="crayon-v"&gt;data&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;=&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-v"&gt;df&lt;/span&gt;&lt;span class="crayon-sy"&gt;.&lt;/span&gt;&lt;span class="crayon-v"&gt;destaque&lt;/span&gt;&lt;span class="crayon-sy"&gt;,&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-e"&gt;aes&lt;/span&gt;&lt;span class="crayon-sy"&gt;(&lt;/span&gt;&lt;span class="crayon-v"&gt;label&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;=&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-v"&gt;codigo\_acao&lt;/span&gt;&lt;span class="crayon-sy"&gt;)&lt;/span&gt;&lt;span class="crayon-sy"&gt;)&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;+&lt;/span&gt; &lt;/div&gt; &lt;div class="crayon-line" id="crayon-5a9ec59b7e377955586579-5"&gt; &lt;span class="crayon-e"&gt;theme\_economist&lt;/span&gt;&lt;span class="crayon-sy"&gt;(&lt;/span&gt;&lt;span class="crayon-sy"&gt;)&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;+&lt;/span&gt; &lt;/div&gt; &lt;div class="crayon-line crayon-striped-line" id="crayon-5a9ec59b7e377955586579-6"&gt; &lt;span class="crayon-e"&gt;labs&lt;/span&gt;&lt;span class="crayon-sy"&gt;(&lt;/span&gt;&lt;span class="crayon-v"&gt;x&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;=&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-s"&gt;"Variação (%)"&lt;/span&gt;&lt;span class="crayon-sy"&gt;,&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-v"&gt;y&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;=&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-s"&gt;"Preço (R$)"</span><span
=======
(R$)", title = "Painel de resumo diário da Bovespa", caption = "Blog do IBPAD - Sillas Gonzaga")&lt;/textarea&gt;&lt;/div&gt; &lt;div class="crayon-main" style=""&gt; &lt;table class="crayon-table"&gt;&lt;tr class="crayon-row"&gt; &lt;td class="crayon-nums " data-settings="show"&gt; &lt;div class="crayon-nums-content" style="font-size: 12px !important; line-height: 15px !important;"&gt; &lt;div class="crayon-num" data-line="crayon-5a9eed9c13554569173092-1"&gt;1&lt;/div&gt; &lt;div class="crayon-num crayon-striped-num" data-line="crayon-5a9eed9c13554569173092-2"&gt;2&lt;/div&gt; &lt;div class="crayon-num" data-line="crayon-5a9eed9c13554569173092-3"&gt;3&lt;/div&gt; &lt;div class="crayon-num crayon-striped-num" data-line="crayon-5a9eed9c13554569173092-4"&gt;4&lt;/div&gt; &lt;div class="crayon-num" data-line="crayon-5a9eed9c13554569173092-5"&gt;5&lt;/div&gt; &lt;div class="crayon-num crayon-striped-num" data-line="crayon-5a9eed9c13554569173092-6"&gt;6&lt;/div&gt; &lt;div class="crayon-num" data-line="crayon-5a9eed9c13554569173092-7"&gt;7&lt;/div&gt; &lt;div class="crayon-num crayon-striped-num" data-line="crayon-5a9eed9c13554569173092-8"&gt;8&lt;/div&gt; &lt;/div&gt; &lt;/td&gt; &lt;td class="crayon-code"&gt;&lt;div class="crayon-pre" style="font-size: 12px !important; line-height: 15px !important; -moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4;"&gt; &lt;div class="crayon-line" id="crayon-5a9eed9c13554569173092-1"&gt; &lt;span class="crayon-v"&gt;df&lt;/span&gt;&lt;span class="crayon-sy"&gt;.&lt;/span&gt;&lt;span class="crayon-v"&gt;acoes&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;%&lt;/span&gt;&lt;span class="crayon-o"&gt;&amp;&lt;/span&gt;&lt;span class="crayon-v"&gt;gt&lt;/span&gt;&lt;span class="crayon-sy"&gt;;&lt;/span&gt;&lt;span class="crayon-o"&gt;%&lt;/span&gt; &lt;/div&gt; &lt;div class="crayon-line crayon-striped-line" id="crayon-5a9eed9c13554569173092-2"&gt; &lt;span class="crayon-e"&gt;ggplot&lt;/span&gt;&lt;span class="crayon-sy"&gt;(&lt;/span&gt;&lt;span class="crayon-e"&gt;aes&lt;/span&gt;&lt;span class="crayon-sy"&gt;(&lt;/span&gt;&lt;span class="crayon-v"&gt;x&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;=&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-v"&gt;variacao&lt;/span&gt;&lt;span class="crayon-sy"&gt;,&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-v"&gt;y&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;=&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-v"&gt;preco\_reais&lt;/span&gt;&lt;span class="crayon-sy"&gt;)&lt;/span&gt;&lt;span class="crayon-sy"&gt;)&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;+&lt;/span&gt; &lt;/div&gt; &lt;div class="crayon-line" id="crayon-5a9eed9c13554569173092-3"&gt; &lt;span class="crayon-e"&gt;geom\_point&lt;/span&gt;&lt;span class="crayon-sy"&gt;(&lt;/span&gt;&lt;span class="crayon-sy"&gt;)&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;+&lt;/span&gt; &lt;/div&gt; &lt;div class="crayon-line crayon-striped-line" id="crayon-5a9eed9c13554569173092-4"&gt; &lt;span class="crayon-e"&gt;geom\_text\_repel&lt;/span&gt;&lt;span class="crayon-sy"&gt;(&lt;/span&gt;&lt;span class="crayon-v"&gt;data&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;=&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-v"&gt;df&lt;/span&gt;&lt;span class="crayon-sy"&gt;.&lt;/span&gt;&lt;span class="crayon-v"&gt;destaque&lt;/span&gt;&lt;span class="crayon-sy"&gt;,&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-e"&gt;aes&lt;/span&gt;&lt;span class="crayon-sy"&gt;(&lt;/span&gt;&lt;span class="crayon-v"&gt;label&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;=&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-v"&gt;codigo\_acao&lt;/span&gt;&lt;span class="crayon-sy"&gt;)&lt;/span&gt;&lt;span class="crayon-sy"&gt;)&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;+&lt;/span&gt; &lt;/div&gt; &lt;div class="crayon-line" id="crayon-5a9eed9c13554569173092-5"&gt; &lt;span class="crayon-e"&gt;theme\_economist&lt;/span&gt;&lt;span class="crayon-sy"&gt;(&lt;/span&gt;&lt;span class="crayon-sy"&gt;)&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;+&lt;/span&gt; &lt;/div&gt; &lt;div class="crayon-line crayon-striped-line" id="crayon-5a9eed9c13554569173092-6"&gt; &lt;span class="crayon-e"&gt;labs&lt;/span&gt;&lt;span class="crayon-sy"&gt;(&lt;/span&gt;&lt;span class="crayon-v"&gt;x&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;=&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-s"&gt;"Variação (%)"&lt;/span&gt;&lt;span class="crayon-sy"&gt;,&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-v"&gt;y&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;=&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-s"&gt;"Preço (R$)"</span><span
>>>>>>> 8ddb1ca530324468c273af37e5324e507c1ed797
class="crayon-sy">,</span>
</div>
<span class="crayon-v">title</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"Painel de resumo diário da Bovespa"</span><span
class="crayon-sy">,</span>

<span class="crayon-v">caption</span><span class="crayon-h">
</span><span class="crayon-o">=</span><span class="crayon-h">
</span><span class="crayon-s">"Blog do IBPAD - Sillas
Gonzaga"</span><span class="crayon-sy">)</span>

</div>
</td>
<<<<<<< HEAD
                    </tr></table>

</div>
        </div>

<!-- [Format Time: 0.0007 seconds] -->
<p>
</p>
        </div>
    </div>

    <div class="wpb_single_image wpb_content_element vc_align_left">
        
        <figure class="wpb_wrapper vc_figure"><div class="vc_single_image-wrapper   vc_box_border_grey"><img width="864" height="480" src="https://www.ibpad.com.br/wp-content/uploads/2017/08/unnamed-chunk-8-1.png" class="vc_single_image-img attachment-full" alt="" srcset="https://www.ibpad.com.br/wp-content/uploads/2017/08/unnamed-chunk-8-1.png 864w, https://www.ibpad.com.br/wp-content/uploads/2017/08/unnamed-chunk-8-1-260x144.png 260w, https://www.ibpad.com.br/wp-content/uploads/2017/08/unnamed-chunk-8-1-768x427.png 768w, https://www.ibpad.com.br/wp-content/uploads/2017/08/unnamed-chunk-8-1-100x56.png 100w" sizes="(max-width: 864px) 100vw, 864px"></div>
        </figure>

</div>
    <div class="wpb_text_column wpb_content_element ">
        <div class="wpb_wrapper">
            <p>No código acima, o pacote <code>ggrepel</code> foi usado para plotar os nomes das ações de destaque, garantindo que eles não se cruzassem. Um outlier prejudicou a visualização:</p>

<!-- Crayon Syntax Highlighter v_2.7.2_beta -->
        <div id="crayon-5a9ec59b7e37a915489932" class="crayon-syntax crayon-theme-classic crayon-font-monaco crayon-os-pc print-yes notranslate" data-settings=" minimize scroll-mouseover" style=" margin-top: 12px; margin-bottom: 12px; font-size: 12px !important; line-height: 15px !important;">
        
            <div class="crayon-toolbar" data-settings=" mouseover overlay hide delay" style="font-size: 12px !important;height: 18px !important; line-height: 18px !important;">

<span class="crayon-title"></span>

</div>
            <div class="crayon-info" style="min-height: 16.8px !important; line-height: 16.8px !important;"></div>
            <div class="crayon-plain-wrap"><textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">

=======
</tr>
</table>
</div>
</div>
<p>
</p>
</div>
</div>
<figure class="wpb_wrapper vc_figure">
<img width="864" height="480" src="https://www.ibpad.com.br/wp-content/uploads/2017/08/unnamed-chunk-8-1.png" class="vc_single_image-img attachment-full" alt="" srcset="https://www.ibpad.com.br/wp-content/uploads/2017/08/unnamed-chunk-8-1.png 864w, https://www.ibpad.com.br/wp-content/uploads/2017/08/unnamed-chunk-8-1-260x144.png 260w, https://www.ibpad.com.br/wp-content/uploads/2017/08/unnamed-chunk-8-1-768x427.png 768w, https://www.ibpad.com.br/wp-content/uploads/2017/08/unnamed-chunk-8-1-100x56.png 100w" sizes="(max-width: 864px) 100vw, 864px">

</figure>

<p>
No código acima, o pacote <code>ggrepel</code> foi usado para plotar os
nomes das ações de destaque, garantindo que eles não se cruzassem. Um
outlier prejudicou a visualização:
</p>
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
>>>>>>> 8ddb1ca530324468c273af37e5324e507c1ed797
df.acoes %&gt;% filter(preco\_reais &gt; 40000) %&gt;% knitr::kable()

<table>
<thead>
<tr class="header">
<th align="left">codigo_acao</th>
<th align="left">nome_empresa</th>
<th align="right">preco_reais</th>
<th align="right">variacao</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">PPAR3</td>
<td align="left">Polpar ON</td>
<td align="right">50000</td>
<td align="right">0</td>
</tr>
</tbody>
</table>

</textarea>
<<<<<<< HEAD
</div>
            <div class="crayon-main" style="">
                <table class="crayon-table"><tr class="crayon-row">

<td class="crayon-nums " data-settings="show">
                    <div class="crayon-nums-content" style="font-size: 12px !important; line-height: 15px !important;">

=======

<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
>>>>>>> 8ddb1ca530324468c273af37e5324e507c1ed797
1

2

3

4

5

6

7

8

9

<<<<<<< HEAD
</div>
                </td>
                        <td class="crayon-code"><div class="crayon-pre" style="font-size: 12px !important; line-height: 15px !important; -moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4;">

=======
</td>
<td class="crayon-code">
>>>>>>> 8ddb1ca530324468c273af37e5324e507c1ed797
<span class="crayon-v">df</span><span class="crayon-sy">.</span><span
class="crayon-v">acoes</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&</span><span
class="crayon-v">gt</span><span class="crayon-sy">;</span><span
class="crayon-o">%</span>

<span class="crayon-e">filter</span><span
class="crayon-sy">(</span><span
class="crayon-v">preco\_reais</span><span class="crayon-h"> </span><span
class="crayon-o">&</span><span class="crayon-v">gt</span><span
class="crayon-sy">;</span><span class="crayon-h"> </span><span
class="crayon-cn">40000</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">%</span><span
class="crayon-o">&</span><span class="crayon-v">gt</span><span
class="crayon-sy">;</span><span class="crayon-o">%</span>

<span class="crayon-v">knitr</span><span class="crayon-o">::</span><span
class="crayon-e">kable</span><span class="crayon-sy">(</span><span
class="crayon-sy">)</span>

 

 

<span class="crayon-o">|</span><span class="crayon-h"> </span><span
class="crayon-v">codigo</span><span class="crayon-sy">&lt;/span&gt;<span class="crayon-v">\_acao</span><span
class="crayon-h"> </span><span class="crayon-o">|</span><span
class="crayon-h"> </span><span
class="crayon-v">nome</span><span class="crayon-sy">&lt;/span&gt;<span class="crayon-v">\_empresa</span><span
class="crayon-h"> </span><span class="crayon-o">|</span><span
class="crayon-h"> </span><span
class="crayon-v">preco</span><span class="crayon-sy">&lt;/span&gt;<span class="crayon-v">\_reais</span><span
class="crayon-o">|</span><span class="crayon-h"> </span><span
class="crayon-v">variacao</span><span class="crayon-o">|</span>

<span class="crayon-o">|</span><span class="crayon-o">:</span><span
class="crayon-o">--</span><span class="crayon-o">--</span><span
class="crayon-o">--</span><span class="crayon-o">--</span><span
class="crayon-o">--</span><span class="crayon-o">--</span><span
class="crayon-o">-</span><span class="crayon-o">|</span><span
class="crayon-o">:</span><span class="crayon-o">--</span><span
class="crayon-o">--</span><span class="crayon-o">--</span><span
class="crayon-o">--</span><span class="crayon-o">--</span><span
class="crayon-o">--</span><span class="crayon-o">--</span><span
class="crayon-o">|</span><span class="crayon-o">--</span><span
class="crayon-o">--</span><span class="crayon-o">--</span><span
class="crayon-o">--</span><span class="crayon-o">--</span><span
class="crayon-o">--</span><span class="crayon-o">-</span><span
class="crayon-o">:</span><span class="crayon-o">|</span><span
class="crayon-o">--</span><span class="crayon-o">--</span><span
class="crayon-o">--</span><span class="crayon-o">--</span><span
class="crayon-o">-</span><span class="crayon-o">:</span><span
class="crayon-o">|</span>

<span class="crayon-o">|</span><span class="crayon-h"> </span><span
class="crayon-v">PPAR3</span><span class="crayon-h"> </span><span
class="crayon-o">|</span><span class="crayon-h"> </span><span
class="crayon-e">Polpar </span><span class="crayon-v">ON</span><span
class="crayon-h"> </span><span class="crayon-o">|</span><span
class="crayon-h"> </span><span class="crayon-cn">50000</span><span
class="crayon-o">|</span><span class="crayon-h"> </span><span
class="crayon-cn">0</span><span class="crayon-o">|</span>

 

<<<<<<< HEAD
</div>
</td>
                    </tr></table>

</div>
        </div>

<!-- [Format Time: 0.0008 seconds] -->
=======
</td>
</tr>
</table>

>>>>>>> 8ddb1ca530324468c273af37e5324e507c1ed797
<p>
 
</p>
<p>
O código completo deste post está presente
<a href="https://gist.github.com/sillasgonzaga/ad7ecc08aad76c48ead83b5806c6234b">neste
gist</a>.
</p>
<<<<<<< HEAD
        </div>
    </div>
=======
>>>>>>> 8ddb1ca530324468c273af37e5324e507c1ed797

</div>
</div>
</div>
</div>
<<<<<<< HEAD
    <div class="wpb_single_image wpb_content_element vc_align_left">
        
        <figure class="wpb_wrapper vc_figure"><a href="https://www.ibpad.com.br/produto/ciencia-de-dados-com-r-df/" target="_self" class="vc_single_image-wrapper   vc_box_border_grey"><img width="363" height="353" src="https://www.ibpad.com.br/wp-content/uploads/2017/09/Curso-de-programa%C3%A7%C3%A3o-em-R.png" class="vc_single_image-img attachment-full" alt="" srcset="https://www.ibpad.com.br/wp-content/uploads/2017/09/Curso-de-programação-em-R.png 363w, https://www.ibpad.com.br/wp-content/uploads/2017/09/Curso-de-programação-em-R-260x253.png 260w, https://www.ibpad.com.br/wp-content/uploads/2017/09/Curso-de-programação-em-R-100x97.png 100w" sizes="(max-width: 363px) 100vw, 363px"></a>
        </figure>

    <div class="wpb_text_column wpb_content_element ">
        <div class="wpb_wrapper">
            <p>Este modelo de aplicação do R é uma das possibilidades que a programação te oferece, aproveite e venha aprender muito mais sobre essa programação e linguagem nas novas turmas do curso de <a href="https://www.ibpad.com.br/produto/ciencia-de-dados-com-r-df/" target="_blank">Ciência de Dados com R</a>. O curso presencial acontecerá em <a href="https://www.ibpad.com.br/produto/ciencia-de-dados-com-r-df" target="_blank">Brasilia</a> e em <a href="https://www.ibpad.com.br/produto/ciencia-de-dados-com-r-sp/" target="_blank">São Paulo</a> e você já pode se inscrever! Te aguardamos para trocar experiências e praticar os aprendizados.</p>

        </div>
    </div>

</div>
</div>
=======
<figure class="wpb_wrapper vc_figure">
<a href="https://www.ibpad.com.br/produto/ciencia-de-dados-com-r-df/" target="_self" class="vc_single_image-wrapper   vc_box_border_grey"><img width="363" height="353" src="https://www.ibpad.com.br/wp-content/uploads/2017/09/Curso-de-programa%C3%A7%C3%A3o-em-R.png" class="vc_single_image-img attachment-full" alt="" srcset="https://www.ibpad.com.br/wp-content/uploads/2017/09/Curso-de-programação-em-R.png 363w, https://www.ibpad.com.br/wp-content/uploads/2017/09/Curso-de-programação-em-R-260x253.png 260w, https://www.ibpad.com.br/wp-content/uploads/2017/09/Curso-de-programação-em-R-100x97.png 100w" sizes="(max-width: 363px) 100vw, 363px"></a>
</figure>

<p>
Este modelo de aplicação do R é uma das possibilidades que a programação
te oferece, aproveite e venha aprender muito mais sobre essa programação
e linguagem nas novas turmas do curso de
<a href="https://www.ibpad.com.br/produto/ciencia-de-dados-com-r-df/" target="_blank">Ciência
de Dados com R</a>. O curso presencial acontecerá em
<a href="https://www.ibpad.com.br/produto/ciencia-de-dados-com-r-df" target="_blank">Brasilia</a>
e em
<a href="https://www.ibpad.com.br/produto/ciencia-de-dados-com-r-sp/" target="_blank">São
Paulo</a> e você já pode se inscrever! Te aguardamos para trocar
experiências e praticar os aprendizados.
</p>

</div>
>>>>>>> 8ddb1ca530324468c273af37e5324e507c1ed797

