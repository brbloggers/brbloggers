+++
title = "Construindo mapas eleitorais com R e electionsBR"
date = "2016-11-07 17:34:35"
categories = ["IBPAD"]
original_url = "https://www.ibpad.com.br/blog/analise-de-dados/construindo-mapas-eleitorais-com-r-e-electionsbr/"
+++

<p>
<em>\[Texto do prof.
<a href="https://www.ibpad.com.br/nosso-time/robert-mcdonnell/">Robert
McDonnell</a>, professor do curso de Programação em R – Texto
originalmente publicado
<a href="https://robertmyles.github.io/ElectionsBR.html" target="_blank">aqui</a>\]</em>
</p>
<p>
Para os interessados na política brasileira, foi divulgado um novo
pacote chamado <span id="crayon-5a5818d330010025323278"
class="crayon-syntax crayon-syntax-inline crayon-theme-classic crayon-theme-classic-inline crayon-font-monaco"
style="font-size: 12px !important; line-height: 15px !important;font-size: 12px !important;"><span
class="crayon-pre crayon-code"
style="font-size: 12px !important; line-height: 15px !important;font-size: 12px !important; -moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4;"><span
class="crayon-v">electionsBR</span><span
class="crayon-sy">.</span></span></span> que pega dados do
<a href="http://www.tse.jus.br/eleicoes/estatisticas/repositorio-de-dados-eleitorais" target="_blank">TSE
–  Tribunal Superior Eleitoral</a> e os torna disponíveis em um formato
organizado para usuários de R. Dada a minha obsessão recente com
a <a href="https://robertmyles.github.io//re-creating-plots-from-the-economist-in-r.html">elaboraçao
de mapas</a>, vi aqui a oportunidade de fazer mapas do Brasil com este
pacote.
</p>
<p>
Então, o que podemos fazer com ele? Bem, que tal um mapa de como os
brasileiros votaram nas eleições de 2014? Para fazer isso,
usaremos <code class="highlighter-rouge">electionsBR</code> para obter
os dados das eleições e uma mistura
de <code class="highlighter-rouge">tidyverse</code> e alguns pacotes de
mapeamento e plotagem:
</p>
<figure class="highlight">
<span class="crayon-title"></span>

<span class="crayon-language">R</span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
library(tidyverse) library(electionsBR) library(ggmap) library(rgdal)
library(stringi) library(scales) library(maptools) library(RColorBrewer)
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
<span class="crayon-r">library</span><span
class="crayon-sy">(</span><span class="crayon-v">tidyverse</span><span
class="crayon-sy">)</span>

<span class="crayon-r">library</span><span
class="crayon-sy">(</span><span class="crayon-v">electionsBR</span><span
class="crayon-sy">)</span>

<span class="crayon-r">library</span><span
class="crayon-sy">(</span><span class="crayon-v">ggmap</span><span
class="crayon-sy">)</span>

<span class="crayon-r">library</span><span
class="crayon-sy">(</span><span class="crayon-v">rgdal</span><span
class="crayon-sy">)</span>

<span class="crayon-r">library</span><span
class="crayon-sy">(</span><span class="crayon-v">stringi</span><span
class="crayon-sy">)</span>

<span class="crayon-r">library</span><span
class="crayon-sy">(</span><span class="crayon-v">scales</span><span
class="crayon-sy">)</span>

<span class="crayon-r">library</span><span
class="crayon-sy">(</span><span class="crayon-v">maptools</span><span
class="crayon-sy">)</span>

<span class="crayon-r">library</span><span
class="crayon-sy">(</span><span
class="crayon-v">RColorBrewer</span><span class="crayon-sy">)</span>

</td>
</tr>
</table>

<br>
</figure>
<p>
A
função <code class="highlighter-rouge">vote\_mun\_zone\_fed()</code> toma
um único argumento, <code class="highlighter-rouge">year</code>, como um
inteiro.  Isso demora um bom tempo para fazer o download, visto que é
uma grande base de dados.
</p>
<figure class="highlight">
<span class="crayon-title"></span>

<span class="crayon-language">R</span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
Mun &lt;- vote\_mun\_zone\_fed(2014)
</textarea>

<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
1

</td>
<td class="crayon-code">
<span class="crayon-v">Mun</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span
class="crayon-e">vote\_mun\_zone\_fed</span><span
class="crayon-sy">(</span><span class="crayon-cn">2014</span><span
class="crayon-sy">)</span>

</td>
</tr>
</table>

<br>
</figure>
<p>
Uma vez que temos os dados, podemos usar o
<code class="highlighter-rouge">tidyverse</code> para limpá-los e
organizá-los como quisermos. Eu vou mudar a codificação de caracteres
para ASCII, usando o pacote
<code class="highlighter-rouge">stringi</code> e selecionar apenas as
colunas que eu preciso.
</p>
<figure class="highlight">
<span class="crayon-title"></span>

<span class="crayon-language">R</span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
Mun &lt;- Mun %&gt;% select(SIGLA\_UF, DESCRICAO\_CARGO,
CODIGO\_MUNICIPIO, TOTAL\_VOTOS, NUMERO\_CAND, NOME\_MUNICIPIO,
NUM\_TURNO, SIGLA\_PARTIDO) %&gt;% mutate(NOME\_MUNICIPIO =
stri\_trans\_general(NOME\_MUNICIPIO, "Latin-ASCII"))
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
<span class="crayon-v">Mun</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-v">Mun</span><span
class="crayon-h"> </span><span class="crayon-o">%</span><span
class="crayon-o">&gt;</span><span class="crayon-o">%</span><span
class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">select</span><span class="crayon-sy">(</span><span
class="crayon-v">SIGLA\_UF</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span
class="crayon-v">DESCRICAO\_CARGO</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">CODIGO\_MUNICIPIO</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">TOTAL\_VOTOS</span><span class="crayon-sy">,</span>

<span class="crayon-h">         </span><span
class="crayon-v">NUMERO\_CAND</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">NOME\_MUNICIPIO</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">NUM\_TURNO</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span
class="crayon-v">SIGLA\_PARTIDO</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&gt;</span><span
class="crayon-o">%</span><span class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">mutate</span><span class="crayon-sy">(</span><span
class="crayon-v">NOME\_MUNICIPIO</span><span class="crayon-h">
</span><span class="crayon-o">=</span><span class="crayon-h">
</span><span class="crayon-e">stri\_trans\_general</span><span
class="crayon-sy">(</span><span
class="crayon-v">NOME\_MUNICIPIO</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-s">"Latin-ASCII"</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span>

</td>
</tr>
</table>

<br>
</figure>
<p>
Uma coisa interessante que podemos fazer com este conjunto de dados é
mapear a percentagem do eleitorado que votou em Dilma. Para isso
precisamos de shapefiles para o Brasil, que você pode obter do
site <a href="http://www.gadm.org/country">gadm.org</a>.
</p>
<p>
Precisamos também isolar a votação de Dilma e depois calcular a
proporção em cada município que votou nela. Como houveram dois turnos,
podemos visualizar cada um. O código abaixo representa o primeiro turno;
para fazer a mesma coisa com o segundo turno, apenas alteramos a
primeira linha de código para filtrar
para <code class="highlighter-rouge">filter</code> para <code class="highlighter-rouge">NUM\_TURNO
== 2</code>.
</p>
<figure class="highlight">
<span class="crayon-title"></span>

<span class="crayon-language">R</span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
Pres1 &lt;- Mun %&gt;% filter(DESCRICAO\_CARGO == "PRESIDENTE",
NUM\_TURNO == 1, SIGLA\_UF != "ZZ") %&gt;% group\_by(NUMERO\_CAND,
CODIGO\_MUNICIPIO) %&gt;% mutate(SUM = sum(TOTAL\_VOTOS)) %&gt;%
distinct(CODIGO\_MUNICIPIO, .keep\_all=T) %&gt;% ungroup() %&gt;%
group\_by(CODIGO\_MUNICIPIO) %&gt;% mutate(PERC =
TOTAL\_VOTOS/sum(TOTAL\_VOTOS)\*100) %&gt;% arrange(SIGLA\_UF,
NOME\_MUNICIPIO) %&gt;% ungroup() %&gt;% filter(NUMERO\_CAND == 13)
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

</td>
<td class="crayon-code">
<span class="crayon-v">Pres1</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-v">Mun</span><span
class="crayon-h"> </span><span class="crayon-o">%</span><span
class="crayon-o">&gt;</span><span class="crayon-o">%</span><span
class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">filter</span><span class="crayon-sy">(</span><span
class="crayon-v">DESCRICAO\_CARGO</span><span class="crayon-h">
</span><span class="crayon-o">==</span><span class="crayon-h">
</span><span class="crayon-s">"PRESIDENTE"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">NUM\_TURNO</span><span class="crayon-h"> </span><span
class="crayon-o">==</span><span class="crayon-h"> </span><span
class="crayon-cn">1</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span>

<span class="crayon-h">         </span><span
class="crayon-v">SIGLA\_UF</span><span class="crayon-h"> </span><span
class="crayon-o">!=</span><span class="crayon-h"> </span><span
class="crayon-s">"ZZ"</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">%</span><span
class="crayon-o">&gt;</span><span class="crayon-o">%</span><span
class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">group\_by</span><span class="crayon-sy">(</span><span
class="crayon-v">NUMERO\_CAND</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">CODIGO\_MUNICIPIO</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&gt;</span><span
class="crayon-o">%</span><span class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">mutate</span><span class="crayon-sy">(</span><span
class="crayon-v">SUM</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-e">sum</span><span class="crayon-sy">(</span><span
class="crayon-v">TOTAL\_VOTOS</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">%</span><span
class="crayon-o">&gt;</span><span class="crayon-o">%</span><span
class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">distinct</span><span class="crayon-sy">(</span><span
class="crayon-v">CODIGO\_MUNICIPIO</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-sy">.</span><span class="crayon-v">keep\_all</span><span
class="crayon-o">=</span><span class="crayon-t">T</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&gt;</span><span
class="crayon-o">%</span><span class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">ungroup</span><span class="crayon-sy">(</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&gt;</span><span
class="crayon-o">%</span><span class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">group\_by</span><span class="crayon-sy">(</span><span
class="crayon-v">CODIGO\_MUNICIPIO</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&gt;</span><span
class="crayon-o">%</span><span class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">mutate</span><span class="crayon-sy">(</span><span
class="crayon-v">PERC</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">TOTAL\_VOTOS</span><span class="crayon-o">/</span><span
class="crayon-e">sum</span><span class="crayon-sy">(</span><span
class="crayon-v">TOTAL\_VOTOS</span><span
class="crayon-sy">)</span><span class="crayon-o">\*</span><span
class="crayon-cn">100</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">%</span><span
class="crayon-o">&gt;</span><span class="crayon-o">%</span><span
class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">arrange</span><span class="crayon-sy">(</span><span
class="crayon-v">SIGLA\_UF</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span
class="crayon-v">NOME\_MUNICIPIO</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&gt;</span><span
class="crayon-o">%</span><span class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">ungroup</span><span class="crayon-sy">(</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&gt;</span><span
class="crayon-o">%</span><span class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">filter</span><span class="crayon-sy">(</span><span
class="crayon-v">NUMERO\_CAND</span><span class="crayon-h"> </span><span
class="crayon-o">==</span><span class="crayon-h"> </span><span
class="crayon-cn">13</span><span class="crayon-sy">)</span>

</td>
</tr>
</table>

<br>
</figure>
<figure class="highlight">
Em seguida, leremos nossos arquivos de formato. Teremos que arrumar
nomes de municípios e corrigir erros de codificação.<br>
<span class="crayon-title"></span>

<span class="crayon-language">R</span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
BRmap &lt;- readOGR(dsn = "BRA\_adm\_shp", layer = "BRA\_adm3", verbose
= FALSE) <BRmap@data$NAME_2> &lt;- <BRmap@data$NAME_2> %&gt;%
as.character() %&gt;% stri\_trans\_general("Latin-ASCII") %&gt;%
toupper()
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
<span class="crayon-v">BRmap</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-e">readOGR</span><span
class="crayon-sy">(</span><span class="crayon-v">dsn</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span
class="crayon-s">"BRA\_adm\_shp"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">layer</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"BRA\_adm3"</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">verbose</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-t">FALSE</span><span
class="crayon-sy">)</span>

<span class="crayon-v">BRmap</span><span class="crayon-sy">@</span><span
class="crayon-v">data</span><span
class="crayon-sy">$&lt;/span&gt;&lt;span class="crayon-v"&gt;NAME\_2&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;&lt;&lt;/span&gt;&lt;span class="crayon-o"&gt;-&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-v"&gt;BRmap&lt;/span&gt;&lt;span class="crayon-sy"&gt;@&lt;/span&gt;&lt;span class="crayon-v"&gt;data&lt;/span&gt;&lt;span class="crayon-sy"&gt;$</span><span
class="crayon-v">NAME\_2</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&gt;</span><span
class="crayon-o">%</span><span class="crayon-h"> </span>

<span class="crayon-h">  </span><span class="crayon-st">as</span><span
class="crayon-sy">.</span><span class="crayon-e">character</span><span
class="crayon-sy">(</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">%</span><span
class="crayon-o">&gt;</span><span class="crayon-o">%</span><span
class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">stri\_trans\_general</span><span
class="crayon-sy">(</span><span
class="crayon-s">"Latin-ASCII"</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&gt;</span><span
class="crayon-o">%</span><span class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">toupper</span><span class="crayon-sy">(</span><span
class="crayon-sy">)</span>

</td>
</tr>
</table>

<br>
</figure>
<p>
Vamos ver quais municípios estão faltando da base de
dados <code class="highlighter-rouge">electionsBR</code>.
</p>
<p>
 
</p>
<blockquote>
<p>
<em>Conheça mais do curso de
<a href="https://www.ibpad.com.br/produto/programacao-em-r/">Programação
em R</a> oferecido pelo IBPAD</em>
</p>
<p>
<em> Inscrições abertas em São Paulo e no Rio de Janeiro!</em>
</p>
</blockquote>
<p>
 
</p>
<figure class="highlight">
<span class="crayon-title"></span>

<span class="crayon-language">R</span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
'%ni%' &lt;- Negate('%in%')

unique(<BRmap@data$NAME_2>\[which(<BRmap@data$NAME_2> %ni%
Mun$NOME\_MUNICIPIO)\])

\[1\] "BARRA DA CHOCA" "DIAS D'VILA"  
\[3\] "LIVRAMENTO DO BRUMADO" "MUQUEM DE SAO FRANCISCO"  
\[5\] "OLIVERIA DOS BREJINHOS" "PAU BRAZIL"  
\[7\] "QUIJINGUE" "ITAPAJE"  
\[9\] "MISSO VELHA" "SAO JOAO DO BELM"  
\[11\] "SAO LUIZ DO CURU" "GUIA BRANCA"  
\[13\] "ILHA TRINDADE" "ILHAS DE MARTIM VAZ"  
\[15\] "AMERICANO DO BRAZIL" "BRASABRANTES"  
\[17\] "MATEIRA" "PORTEIRO"  
\[19\] "SANTA RITA DE ARAGUAIA" "ALTO ALEGRE DO MARANHO"  
\[21\] "AMAPA DO MARANHO" "ANAPUROS"  
\[23\] "BOM JARDIN" "HUMBERTO CAMPOS"  
\[25\] "MATES DO NORTE" "VICTORINO FREIRE"  
\[27\] "BATAIPORA" "BARRA DOS BUGRE"  
\[29\] "POXOREO" "SAO FELIX XINGU"  
\[31\] "BANDIERA DO SUL" "BRASOPOLIS"  
\[33\] "CACHOEIRA DE PAJES" "CAMPOS VERDES DE GOIAS"  
\[35\] "CARAVALHOPOLIS" "CASSITERITA"  
\[37\] "CHAVESLANDIA" "FELISBERTO CALDEIRA"  
\[39\] "FRANCISCO DUMON" "GOUVEA"  
\[41\] "ITABIRINHA DE MANTENA" "ITACARAMBIRA"  
\[43\] "PIEDADE DO PONTE NOVA" "PIUI"  
\[45\] "QUELUZITA" "SAO FRANCISCO DE OLIVEIRA"  
\[47\] "SAO SEBASTIO DA VARGEM ALEGRE" "SAN ANTONIO DO ITAMBE"  
\[49\] "SAN ANTONIO DO RIO ABAI" "SANTA RITA DO IBITIPOCA"  
\[51\] "SANTA RITA ITUETO" "ALMERIM"  
\[53\] "BRAGANGA" "ME DO RIO"  
\[55\] "BOQUEIRAO DOS COCHOS" "DESTERRO DE MALTA"  
\[57\] "MONGEIRO" "PEDRA LAVADRA"  
\[59\] "RIACHO" "SAO MIGUEL TAIPU"  
\[61\] "SERIDO" "ALTAMIRA DO PARAN"  
\[63\] "ARAPU" "ASSIS CHATEAUBRI"  
\[65\] "CAMPO" "CONSELHEIRO MAYRINCK"  
\[67\] "IVATUVA" "JABUTI"  
\[69\] "SAO ANTONIO DE SUDOESTE" "SALTO DO LONDRA"  
\[71\] "SANTA CRUZ DE MONTE CASTE" "SANTA ISABEL DO OESTE"  
\[73\] "TEXEIRA SOARES" "TIBAJI"  
\[75\] "VENCESLAU BRAS" "VILA ALTA"  
\[77\] "BARRA DE GUABIRA" "CABO"  
\[79\] "CACHOERINHA" "IGARACU"  
\[81\] "LAGOA DO ITAENGA" "SAO JOAO DO BELMONTE"  
\[83\] "SAO JOAQUIN DO MONTE" "SITIO DOS MOREIRAS"  
\[85\] "TAMBE" "PEDRO LI"  
\[87\] "SAO JOAO PIAUI" "SAO MIGUEL TAPUIO"  
\[89\] "CAMPOS" "CAREPEBUS"  
\[91\] "CONCEICAO MACABU" "ENGENHEIRO PAULO DE FRONT"  
\[93\] "PARATI" "VALENCIA"  
\[95\] "ACU" "AUGUSTO SEVERO"  
\[97\] "GOVERNADOR DIX-SEPT ROSAD" "JANUARIO CICCO"  
\[99\] "JARDIM-PIRANHAS" "JUNCO"  
\[101\] "LAGOA DE ANTA" "LAGOAS DE VELHOS"  
\[103\] "SAO MIGUEL DE TOUROS" "BAJE"  
\[105\] "BARO" "BOA VISTA DAS MISSES"  
\[107\] "CAMAGUA" "CAMPO REAL"  
\[109\] "CHIAPETA" "DILERMANO DE AGUIAR"  
\[111\] "ERVAL" "INHACOR"  
\[113\] "LAGOA MIRIM" "MARCIONILIO DIAS"  
\[115\] "MAXIMILIANO DE ALMAEIDA" "PALMITINHOS"  
\[117\] "SAO MIGUEL DAS MISSES" "UREA"  
\[119\] "VITORIA DAS MISSES" "ALTA FLORESTA D'OESTE"  
\[121\] "ALVORADA D'OESTE" "ESPIGAO D'OESTE"  
\[123\] "NOVA BRASILANDIA D'OESTE" "SAO FELIPE D'OESTE"  
\[125\] "SANTA LUZIA D'OESTE" "ALFREDO MARCONDE"  
\[127\] "APARECIDA DOESTE" "BRODOSQUI"  
\[129\] "DULCINOPOLIS" "EMBU"  
\[131\] "ESTRELA DO OESTE" "FERNO"  
\[133\] "FERRAZ DE VASCON" "FLORINIA"  
\[135\] "GUARANI DO OESTE" "IPAUCU"  
\[137\] "JABUTICABAL" "LUISIANIA"  
\[139\] "PALMEIRA DO OESTE" "PARANAPAREMA"  
\[141\] "PIRACUNUNGA" "PONTES GESTRAL"  
\[143\] "QUITANA" "SAO LUIZ DO PARAITINGA"  
\[145\] "SALTO DO PIRAPORA" "SANTA CLARA DO OESTE"  
\[147\] "SANTA RITA DO OESTE" "GRAO PARA"  
\[149\] "LUIZ ALVES" "PAULO LOPEZ"  
\[151\] "PICARRAS" "PONTA ALTA"  
\[153\] "BUQUIM" "GRACHO CARDOSO"  
\[155\] "ITAPORANGA DAJUDA" "NOSSA SENHORA APRECIDO"  
\[157\] "COUTO MAGALHAES" "MOSQUITO"
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

33

34

35

36

37

38

39

40

41

42

43

44

45

46

47

48

49

50

51

52

53

54

55

56

57

58

59

60

61

62

63

64

65

66

67

68

69

70

71

72

73

74

75

76

77

78

79

80

81

82

83

</td>
<td class="crayon-code">
<span class="crayon-s">'%ni%'</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-e">Negate</span><span
class="crayon-sy">(</span><span class="crayon-s">'%in%'</span><span
class="crayon-sy">)</span>

 

<span class="crayon-e">unique</span><span
class="crayon-sy">(</span><span class="crayon-v">BRmap</span><span
class="crayon-sy">@</span><span class="crayon-v">data</span><span
class="crayon-sy">$&lt;/span&gt;&lt;span class="crayon-v"&gt;NAME\_2&lt;/span&gt;&lt;span class="crayon-sy"&gt;\[&lt;/span&gt;&lt;span class="crayon-e"&gt;which&lt;/span&gt;&lt;span class="crayon-sy"&gt;(&lt;/span&gt;&lt;span class="crayon-v"&gt;BRmap&lt;/span&gt;&lt;span class="crayon-sy"&gt;@&lt;/span&gt;&lt;span class="crayon-v"&gt;data&lt;/span&gt;&lt;span class="crayon-sy"&gt;$</span><span
class="crayon-v">NAME\_2</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-v">ni</span><span
class="crayon-o">%</span><span class="crayon-h"> </span><span
class="crayon-v">Mun</span><span class="crayon-sy">$</span><span
class="crayon-v">NOME\_MUNICIPIO</span><span
class="crayon-sy">)</span><span class="crayon-sy">\]</span><span
class="crayon-sy">)</span>

 

<span class="crayon-h">  </span><span class="crayon-sy">\[</span><span
class="crayon-cn">1</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"BARRA DA
CHOCA"</span><span class="crayon-h">                </span><span
class="crayon-s">"DIAS D'VILA"</span><span
class="crayon-h">                  </span>

<span class="crayon-h">  </span><span class="crayon-sy">\[</span><span
class="crayon-cn">3</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"LIVRAMENTO DO
BRUMADO"</span><span class="crayon-h">         </span><span
class="crayon-s">"MUQUEM DE SAO FRANCISCO"</span><span
class="crayon-h">      </span>

<span class="crayon-h">  </span><span class="crayon-sy">\[</span><span
class="crayon-cn">5</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"OLIVERIA DOS
BREJINHOS"</span><span class="crayon-h">        </span><span
class="crayon-s">"PAU BRAZIL"</span><span
class="crayon-h">                   </span>

<span class="crayon-h">  </span><span class="crayon-sy">\[</span><span
class="crayon-cn">7</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"QUIJINGUE"</span><span
class="crayon-h">                     </span><span
class="crayon-s">"ITAPAJE"</span><span
class="crayon-h">                      </span>

<span class="crayon-h">  </span><span class="crayon-sy">\[</span><span
class="crayon-cn">9</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"MISSO
VELHA"</span><span class="crayon-h">                   </span><span
class="crayon-s">"SAO JOAO DO BELM"</span><span
class="crayon-h">             </span>

<span class="crayon-h"> </span><span class="crayon-sy">\[</span><span
class="crayon-cn">11</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"SAO LUIZ DO
CURU"</span><span class="crayon-h">              </span><span
class="crayon-s">"GUIA BRANCA"</span><span
class="crayon-h">                  </span>

<span class="crayon-h"> </span><span class="crayon-sy">\[</span><span
class="crayon-cn">13</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"ILHA
TRINDADE"</span><span class="crayon-h">                 </span><span
class="crayon-s">"ILHAS DE MARTIM VAZ"</span><span
class="crayon-h">          </span>

<span class="crayon-h"> </span><span class="crayon-sy">\[</span><span
class="crayon-cn">15</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"AMERICANO DO
BRAZIL"</span><span class="crayon-h">           </span><span
class="crayon-s">"BRASABRANTES"</span><span
class="crayon-h">                 </span>

<span class="crayon-h"> </span><span class="crayon-sy">\[</span><span
class="crayon-cn">17</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"MATEIRA"</span><span
class="crayon-h">                       </span><span
class="crayon-s">"PORTEIRO"</span><span
class="crayon-h">                     </span>

<span class="crayon-h"> </span><span class="crayon-sy">\[</span><span
class="crayon-cn">19</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"SANTA RITA DE
ARAGUAIA"</span><span class="crayon-h">        </span><span
class="crayon-s">"ALTO ALEGRE DO MARANHO"</span><span
class="crayon-h">       </span>

<span class="crayon-h"> </span><span class="crayon-sy">\[</span><span
class="crayon-cn">21</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"AMAPA DO
MARANHO"</span><span class="crayon-h">              </span><span
class="crayon-s">"ANAPUROS"</span><span
class="crayon-h">                     </span>

<span class="crayon-h"> </span><span class="crayon-sy">\[</span><span
class="crayon-cn">23</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"BOM JARDIN"</span><span
class="crayon-h">                    </span><span
class="crayon-s">"HUMBERTO CAMPOS"</span><span
class="crayon-h">              </span>

<span class="crayon-h"> </span><span class="crayon-sy">\[</span><span
class="crayon-cn">25</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"MATES DO
NORTE"</span><span class="crayon-h">                </span><span
class="crayon-s">"VICTORINO FREIRE"</span><span
class="crayon-h">             </span>

<span class="crayon-h"> </span><span class="crayon-sy">\[</span><span
class="crayon-cn">27</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"BATAIPORA"</span><span
class="crayon-h">                     </span><span
class="crayon-s">"BARRA DOS BUGRE"</span><span
class="crayon-h">              </span>

<span class="crayon-h"> </span><span class="crayon-sy">\[</span><span
class="crayon-cn">29</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"POXOREO"</span><span
class="crayon-h">                       </span><span
class="crayon-s">"SAO FELIX XINGU"</span><span
class="crayon-h">              </span>

<span class="crayon-h"> </span><span class="crayon-sy">\[</span><span
class="crayon-cn">31</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"BANDIERA DO
SUL"</span><span class="crayon-h">               </span><span
class="crayon-s">"BRASOPOLIS"</span><span
class="crayon-h">                   </span>

<span class="crayon-h"> </span><span class="crayon-sy">\[</span><span
class="crayon-cn">33</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"CACHOEIRA DE
PAJES"</span><span class="crayon-h">            </span><span
class="crayon-s">"CAMPOS VERDES DE GOIAS"</span><span
class="crayon-h">       </span>

<span class="crayon-h"> </span><span class="crayon-sy">\[</span><span
class="crayon-cn">35</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span
class="crayon-s">"CARAVALHOPOLIS"</span><span
class="crayon-h">                </span><span
class="crayon-s">"CASSITERITA"</span><span
class="crayon-h">                  </span>

<span class="crayon-h"> </span><span class="crayon-sy">\[</span><span
class="crayon-cn">37</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span
class="crayon-s">"CHAVESLANDIA"</span><span
class="crayon-h">                  </span><span
class="crayon-s">"FELISBERTO CALDEIRA"</span><span
class="crayon-h">          </span>

<span class="crayon-h"> </span><span class="crayon-sy">\[</span><span
class="crayon-cn">39</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"FRANCISCO
DUMON"</span><span class="crayon-h">               </span><span
class="crayon-s">"GOUVEA"</span><span
class="crayon-h">                       </span>

<span class="crayon-h"> </span><span class="crayon-sy">\[</span><span
class="crayon-cn">41</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"ITABIRINHA DE
MANTENA"</span><span class="crayon-h">         </span><span
class="crayon-s">"ITACARAMBIRA"</span><span
class="crayon-h">                 </span>

<span class="crayon-h"> </span><span class="crayon-sy">\[</span><span
class="crayon-cn">43</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"PIEDADE DO PONTE
NOVA"</span><span class="crayon-h">         </span><span
class="crayon-s">"PIUI"</span><span
class="crayon-h">                         </span>

<span class="crayon-h"> </span><span class="crayon-sy">\[</span><span
class="crayon-cn">45</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"QUELUZITA"</span><span
class="crayon-h">                     </span><span class="crayon-s">"SAO
FRANCISCO DE OLIVEIRA"</span><span class="crayon-h">    </span>

<span class="crayon-h"> </span><span class="crayon-sy">\[</span><span
class="crayon-cn">47</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"SAO SEBASTIO DA VARGEM
ALEGRE"</span><span class="crayon-h"> </span><span class="crayon-s">"SAN
ANTONIO DO ITAMBE"</span><span class="crayon-h">        </span>

<span class="crayon-h"> </span><span class="crayon-sy">\[</span><span
class="crayon-cn">49</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"SAN ANTONIO DO RIO
ABAI"</span><span class="crayon-h">       </span><span
class="crayon-s">"SANTA RITA DO IBITIPOCA"</span><span
class="crayon-h">      </span>

<span class="crayon-h"> </span><span class="crayon-sy">\[</span><span
class="crayon-cn">51</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"SANTA RITA
ITUETO"</span><span class="crayon-h">             </span><span
class="crayon-s">"ALMERIM"</span><span
class="crayon-h">                      </span>

<span class="crayon-h"> </span><span class="crayon-sy">\[</span><span
class="crayon-cn">53</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"BRAGANGA"</span><span
class="crayon-h">                      </span><span class="crayon-s">"ME
DO RIO"</span><span class="crayon-h">                    </span>

<span class="crayon-h"> </span><span class="crayon-sy">\[</span><span
class="crayon-cn">55</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"BOQUEIRAO DOS
COCHOS"</span><span class="crayon-h">          </span><span
class="crayon-s">"DESTERRO DE MALTA"</span><span
class="crayon-h">            </span>

<span class="crayon-h"> </span><span class="crayon-sy">\[</span><span
class="crayon-cn">57</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"MONGEIRO"</span><span
class="crayon-h">                      </span><span
class="crayon-s">"PEDRA LAVADRA"</span><span
class="crayon-h">                </span>

<span class="crayon-h"> </span><span class="crayon-sy">\[</span><span
class="crayon-cn">59</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"RIACHO"</span><span
class="crayon-h">                        </span><span
class="crayon-s">"SAO MIGUEL TAIPU"</span><span
class="crayon-h">             </span>

<span class="crayon-h"> </span><span class="crayon-sy">\[</span><span
class="crayon-cn">61</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"SERIDO"</span><span
class="crayon-h">                        </span><span
class="crayon-s">"ALTAMIRA DO PARAN"</span><span
class="crayon-h">            </span>

<span class="crayon-h"> </span><span class="crayon-sy">\[</span><span
class="crayon-cn">63</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"ARAPU"</span><span
class="crayon-h">                         </span><span
class="crayon-s">"ASSIS CHATEAUBRI"</span><span
class="crayon-h">             </span>

<span class="crayon-h"> </span><span class="crayon-sy">\[</span><span
class="crayon-cn">65</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"CAMPO"</span><span
class="crayon-h">                         </span><span
class="crayon-s">"CONSELHEIRO MAYRINCK"</span><span
class="crayon-h">         </span>

<span class="crayon-h"> </span><span class="crayon-sy">\[</span><span
class="crayon-cn">67</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"IVATUVA"</span><span
class="crayon-h">                       </span><span
class="crayon-s">"JABUTI"</span><span
class="crayon-h">                       </span>

<span class="crayon-h"> </span><span class="crayon-sy">\[</span><span
class="crayon-cn">69</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"SAO ANTONIO DE
SUDOESTE"</span><span class="crayon-h">       </span><span
class="crayon-s">"SALTO DO LONDRA"</span><span
class="crayon-h">              </span>

<span class="crayon-h"> </span><span class="crayon-sy">\[</span><span
class="crayon-cn">71</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"SANTA CRUZ DE MONTE
CASTE"</span><span class="crayon-h">     </span><span
class="crayon-s">"SANTA ISABEL DO OESTE"</span><span
class="crayon-h">        </span>

<span class="crayon-h"> </span><span class="crayon-sy">\[</span><span
class="crayon-cn">73</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"TEXEIRA
SOARES"</span><span class="crayon-h">                </span><span
class="crayon-s">"TIBAJI"</span><span
class="crayon-h">                       </span>

<span class="crayon-h"> </span><span class="crayon-sy">\[</span><span
class="crayon-cn">75</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"VENCESLAU
BRAS"</span><span class="crayon-h">                </span><span
class="crayon-s">"VILA ALTA"</span><span
class="crayon-h">                    </span>

<span class="crayon-h"> </span><span class="crayon-sy">\[</span><span
class="crayon-cn">77</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"BARRA DE
GUABIRA"</span><span class="crayon-h">              </span><span
class="crayon-s">"CABO"</span><span
class="crayon-h">                         </span>

<span class="crayon-h"> </span><span class="crayon-sy">\[</span><span
class="crayon-cn">79</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span
class="crayon-s">"CACHOERINHA"</span><span
class="crayon-h">                   </span><span
class="crayon-s">"IGARACU"</span><span
class="crayon-h">                      </span>

<span class="crayon-h"> </span><span class="crayon-sy">\[</span><span
class="crayon-cn">81</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"LAGOA DO
ITAENGA"</span><span class="crayon-h">              </span><span
class="crayon-s">"SAO JOAO DO BELMONTE"</span><span
class="crayon-h">         </span>

<span class="crayon-h"> </span><span class="crayon-sy">\[</span><span
class="crayon-cn">83</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"SAO JOAQUIN DO
MONTE"</span><span class="crayon-h">          </span><span
class="crayon-s">"SITIO DOS MOREIRAS"</span><span
class="crayon-h">           </span>

<span class="crayon-h"> </span><span class="crayon-sy">\[</span><span
class="crayon-cn">85</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"TAMBE"</span><span
class="crayon-h">                         </span><span
class="crayon-s">"PEDRO LI"</span><span
class="crayon-h">                     </span>

<span class="crayon-h"> </span><span class="crayon-sy">\[</span><span
class="crayon-cn">87</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"SAO JOAO
PIAUI"</span><span class="crayon-h">                </span><span
class="crayon-s">"SAO MIGUEL TAPUIO"</span><span
class="crayon-h">            </span>

<span class="crayon-h"> </span><span class="crayon-sy">\[</span><span
class="crayon-cn">89</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"CAMPOS"</span><span
class="crayon-h">                        </span><span
class="crayon-s">"CAREPEBUS"</span><span
class="crayon-h">                    </span>

<span class="crayon-h"> </span><span class="crayon-sy">\[</span><span
class="crayon-cn">91</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"CONCEICAO
MACABU"</span><span class="crayon-h">              </span><span
class="crayon-s">"ENGENHEIRO PAULO DE FRONT"</span><span
class="crayon-h">    </span>

<span class="crayon-h"> </span><span class="crayon-sy">\[</span><span
class="crayon-cn">93</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"PARATI"</span><span
class="crayon-h">                        </span><span
class="crayon-s">"VALENCIA"</span><span
class="crayon-h">                     </span>

<span class="crayon-h"> </span><span class="crayon-sy">\[</span><span
class="crayon-cn">95</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"ACU"</span><span
class="crayon-h">                           </span><span
class="crayon-s">"AUGUSTO SEVERO"</span><span
class="crayon-h">               </span>

<span class="crayon-h"> </span><span class="crayon-sy">\[</span><span
class="crayon-cn">97</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"GOVERNADOR DIX-SEPT
ROSAD"</span><span class="crayon-h">     </span><span
class="crayon-s">"JANUARIO CICCO"</span><span
class="crayon-h">               </span>

<span class="crayon-h"> </span><span class="crayon-sy">\[</span><span
class="crayon-cn">99</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span
class="crayon-s">"JARDIM-PIRANHAS"</span><span
class="crayon-h">               </span><span
class="crayon-s">"JUNCO"</span><span
class="crayon-h">                        </span>

<span class="crayon-sy">\[</span><span
class="crayon-cn">101</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"LAGOA DE
ANTA"</span><span class="crayon-h">                 </span><span
class="crayon-s">"LAGOAS DE VELHOS"</span><span
class="crayon-h">             </span>

<span class="crayon-sy">\[</span><span
class="crayon-cn">103</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"SAO MIGUEL DE
TOUROS"</span><span class="crayon-h">          </span><span
class="crayon-s">"BAJE"</span><span
class="crayon-h">                         </span>

<span class="crayon-sy">\[</span><span
class="crayon-cn">105</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"BARO"</span><span
class="crayon-h">                          </span><span
class="crayon-s">"BOA VISTA DAS MISSES"</span><span
class="crayon-h">         </span>

<span class="crayon-sy">\[</span><span
class="crayon-cn">107</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"CAMAGUA"</span><span
class="crayon-h">                       </span><span
class="crayon-s">"CAMPO REAL"</span><span
class="crayon-h">                   </span>

<span class="crayon-sy">\[</span><span
class="crayon-cn">109</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"CHIAPETA"</span><span
class="crayon-h">                      </span><span
class="crayon-s">"DILERMANO DE AGUIAR"</span><span
class="crayon-h">          </span>

<span class="crayon-sy">\[</span><span
class="crayon-cn">111</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"ERVAL"</span><span
class="crayon-h">                         </span><span
class="crayon-s">"INHACOR"</span><span
class="crayon-h">                      </span>

<span class="crayon-sy">\[</span><span
class="crayon-cn">113</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"LAGOA
MIRIM"</span><span class="crayon-h">                   </span><span
class="crayon-s">"MARCIONILIO DIAS"</span><span
class="crayon-h">             </span>

<span class="crayon-sy">\[</span><span
class="crayon-cn">115</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"MAXIMILIANO DE
ALMAEIDA"</span><span class="crayon-h">       </span><span
class="crayon-s">"PALMITINHOS"</span><span
class="crayon-h">                  </span>

<span class="crayon-sy">\[</span><span
class="crayon-cn">117</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"SAO MIGUEL DAS
MISSES"</span><span class="crayon-h">         </span><span
class="crayon-s">"UREA"</span><span
class="crayon-h">                         </span>

<span class="crayon-sy">\[</span><span
class="crayon-cn">119</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"VITORIA DAS
MISSES"</span><span class="crayon-h">            </span><span
class="crayon-s">"ALTA FLORESTA D'OESTE"</span><span
class="crayon-h">        </span>

<span class="crayon-sy">\[</span><span
class="crayon-cn">121</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"ALVORADA
D'OESTE"</span><span class="crayon-h">              </span><span
class="crayon-s">"ESPIGAO D'OESTE"</span><span
class="crayon-h">              </span>

<span class="crayon-sy">\[</span><span
class="crayon-cn">123</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"NOVA BRASILANDIA
D'OESTE"</span><span class="crayon-h">      </span><span
class="crayon-s">"SAO FELIPE D'OESTE"</span><span
class="crayon-h">           </span>

<span class="crayon-sy">\[</span><span
class="crayon-cn">125</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"SANTA LUZIA
D'OESTE"</span><span class="crayon-h">           </span><span
class="crayon-s">"ALFREDO MARCONDE"</span><span
class="crayon-h">             </span>

<span class="crayon-sy">\[</span><span
class="crayon-cn">127</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"APARECIDA
DOESTE"</span><span class="crayon-h">              </span><span
class="crayon-s">"BRODOSQUI"</span><span
class="crayon-h">                    </span>

<span class="crayon-sy">\[</span><span
class="crayon-cn">129</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span
class="crayon-s">"DULCINOPOLIS"</span><span
class="crayon-h">                  </span><span
class="crayon-s">"EMBU"</span><span
class="crayon-h">                         </span>

<span class="crayon-sy">\[</span><span
class="crayon-cn">131</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"ESTRELA DO
OESTE"</span><span class="crayon-h">              </span><span
class="crayon-s">"FERNO"</span><span
class="crayon-h">                        </span>

<span class="crayon-sy">\[</span><span
class="crayon-cn">133</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"FERRAZ DE
VASCON"</span><span class="crayon-h">              </span><span
class="crayon-s">"FLORINIA"</span><span
class="crayon-h">                     </span>

<span class="crayon-sy">\[</span><span
class="crayon-cn">135</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"GUARANI DO
OESTE"</span><span class="crayon-h">              </span><span
class="crayon-s">"IPAUCU"</span><span
class="crayon-h">                       </span>

<span class="crayon-sy">\[</span><span
class="crayon-cn">137</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span
class="crayon-s">"JABUTICABAL"</span><span
class="crayon-h">                   </span><span
class="crayon-s">"LUISIANIA"</span><span
class="crayon-h">                    </span>

<span class="crayon-sy">\[</span><span
class="crayon-cn">139</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"PALMEIRA DO
OESTE"</span><span class="crayon-h">             </span><span
class="crayon-s">"PARANAPAREMA"</span><span
class="crayon-h">                 </span>

<span class="crayon-sy">\[</span><span
class="crayon-cn">141</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span
class="crayon-s">"PIRACUNUNGA"</span><span
class="crayon-h">                   </span><span
class="crayon-s">"PONTES GESTRAL"</span><span
class="crayon-h">               </span>

<span class="crayon-sy">\[</span><span
class="crayon-cn">143</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"QUITANA"</span><span
class="crayon-h">                       </span><span
class="crayon-s">"SAO LUIZ DO PARAITINGA"</span><span
class="crayon-h">       </span>

<span class="crayon-sy">\[</span><span
class="crayon-cn">145</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"SALTO DO
PIRAPORA"</span><span class="crayon-h">             </span><span
class="crayon-s">"SANTA CLARA DO OESTE"</span><span
class="crayon-h">         </span>

<span class="crayon-sy">\[</span><span
class="crayon-cn">147</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"SANTA RITA DO
OESTE"</span><span class="crayon-h">           </span><span
class="crayon-s">"GRAO PARA"</span><span
class="crayon-h">                    </span>

<span class="crayon-sy">\[</span><span
class="crayon-cn">149</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"LUIZ ALVES"</span><span
class="crayon-h">                    </span><span
class="crayon-s">"PAULO LOPEZ"</span><span
class="crayon-h">                  </span>

<span class="crayon-sy">\[</span><span
class="crayon-cn">151</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"PICARRAS"</span><span
class="crayon-h">                      </span><span
class="crayon-s">"PONTA ALTA"</span><span
class="crayon-h">                   </span>

<span class="crayon-sy">\[</span><span
class="crayon-cn">153</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"BUQUIM"</span><span
class="crayon-h">                        </span><span
class="crayon-s">"GRACHO CARDOSO"</span><span
class="crayon-h">               </span>

<span class="crayon-sy">\[</span><span
class="crayon-cn">155</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"ITAPORANGA
DAJUDA"</span><span class="crayon-h">             </span><span
class="crayon-s">"NOSSA SENHORA APRECIDO"</span><span
class="crayon-h">       </span>

<span class="crayon-sy">\[</span><span
class="crayon-cn">157</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-s">"COUTO
MAGALHAES"</span><span class="crayon-h">               </span><span
class="crayon-s">"MOSQUITO"</span>

</td>
</tr>
</table>

<br>
</figure>
<p>
Isso é um pouco irritante, mas alguns são fáceis de corrigir – no final
vão faltar apenas alguns municípios por causa dessas diferenças de
codificação. Alguns outros são mais difíceis de descobrir: eu não sei se
os erros estão nos dados do TSE, ou neste geo-dados. De qualquer forma,
não vale a pena gastar muito tempo recodificando, por isso vamos
deixá-lo de lado por enquanto.
</p>
<figure class="highlight">
<span class="crayon-title"></span>

<span class="crayon-language">R</span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
<BRmap@data$NAME_2>\[<BRmap@data$NAME_2=>="ASSIS BRAZIL"\] &lt;- "ASSIS
BRASIL" <BRmap@data$NAME_2>\[<BRmap@data$NAME_2=>="JOINVILE"\] &lt;-
"JOINVILLE" <BRmap@data$NAME_2>\[<BRmap@data$NAME_2=>="MACEIO
(CAPITAL)"\] &lt;- "MACEIO"
<BRmap@data$NAME_2>\[<BRmap@data$NAME_2=>="SAO GABRIEL DE CAHOEIRA"\]
&lt;- "SAO GABRIEL DA CACHOEIRA"
<BRmap@data$NAME_2>\[<BRmap@data$NAME_2=>="NOVO BRAZIL"\] &lt;- "NOVO
BRASIL" <BRmap@data$NAME_2>\[<BRmap@data$NAME_2=>="PERI-MIRIM"\] &lt;-
"PERI MIRIM" <BRmap@data$NAME_2>\[<BRmap@data$NAME_2=>="SEM-PEIXE"\]
&lt;- "SEM PEIXE" <BRmap@data$NAME_2>\[<BRmap@data$NAME_2=>="BRAZIL
NOVO"\] &lt;- "BRASIL NOVO"
<BRmap@data$NAME_2>\[<BRmap@data$NAME_2=>="OLHOS-D'AGUA"\] &lt;- "OLHOS
D'AGUA" <BRmap@data$NAME_2>\[<BRmap@data$NAME_2=>="OLHO-D'AGUA DO
BORGES"\] &lt;- "OLHO D'AGUA DO BORGES"
<BRmap@data$NAME_2>\[<BRmap@data$NAME_2=>="SERRA DA SAUDAD"\] &lt;-
"SERRA DA SAUDADE" <BRmap@data$NAME_2>\[<BRmap@data$NAME_2=>="PEIXE
BOI"\] &lt;- "PEIXE-BOI"
<BRmap@data$NAME_2>\[<BRmap@data$NAME_2=>="RICAHO DOS CAVALOS"\] &lt;-
"RIACHO DOS CAVALOS"
<BRmap@data$NAME_2>\[<BRmap@data$NAME_2=>="BRAZILEIRA"\] &lt;-
"BRASILEIRA" <BRmap@data$NAME_2>\[<BRmap@data$NAME_2=>="SUL BRAZIL"\]
&lt;- "SUL BRASIL"
<BRmap@data$NAME_2>\[<BRmap@data$NAME_2=>="FLORINIAPOLIS"\] &lt;-
"FLORIANOPOLIS" <BRmap@data$NAME_2>\[<BRmap@data$NAME_2=>="BON JESUS DOS
PERDOES"\] &lt;- "BOM JESUS DOS PERDOES"
<BRmap@data$NAME_2>\[<BRmap@data$NAME_2=>="OLHO-D'AGUA DO BORGES"\]
&lt;- "OLHO D'AGUA DO BORGES"
<BRmap@data$NAME_2>\[<BRmap@data$NAME_2=>="MISSO"\] &lt;- "MISSAO"
<BRmap@data$NAME_2>\[<BRmap@data$NAME_2=>="SALIDAO"\] &lt;- "SOLIDAO"
<BRmap@data$NAME_2>\[<BRmap@data$NAME_2=>="SAO JOAO DAS DUAS PONTE"\]
&lt;- "SAO JOAO DAS DUAS PONTES"
<BRmap@data$NAME_2>\[<BRmap@data$NAME_2=>="ORLEAES"\] &lt;- "ORLEANS"
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

</td>
<td class="crayon-code">
<span class="crayon-v">BRmap</span><span class="crayon-sy">@</span><span
class="crayon-v">data</span><span
class="crayon-sy">$&lt;/span&gt;&lt;span class="crayon-v"&gt;NAME\_2&lt;/span&gt;&lt;span class="crayon-sy"&gt;\[&lt;/span&gt;&lt;span class="crayon-v"&gt;BRmap&lt;/span&gt;&lt;span class="crayon-sy"&gt;@&lt;/span&gt;&lt;span class="crayon-v"&gt;data&lt;/span&gt;&lt;span class="crayon-sy"&gt;$</span><span
class="crayon-v">NAME\_2</span><span class="crayon-o">==</span><span
class="crayon-s">"ASSIS BRAZIL"</span><span
class="crayon-sy">\]</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-s">"ASSIS BRASIL"</span>

<span class="crayon-v">BRmap</span><span class="crayon-sy">@</span><span
class="crayon-v">data</span><span
class="crayon-sy">$&lt;/span&gt;&lt;span class="crayon-v"&gt;NAME\_2&lt;/span&gt;&lt;span class="crayon-sy"&gt;\[&lt;/span&gt;&lt;span class="crayon-v"&gt;BRmap&lt;/span&gt;&lt;span class="crayon-sy"&gt;@&lt;/span&gt;&lt;span class="crayon-v"&gt;data&lt;/span&gt;&lt;span class="crayon-sy"&gt;$</span><span
class="crayon-v">NAME\_2</span><span class="crayon-o">==</span><span
class="crayon-s">"JOINVILE"</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-o">&lt;</span><span
class="crayon-o">-</span><span class="crayon-h"> </span><span
class="crayon-s">"JOINVILLE"</span>

<span class="crayon-v">BRmap</span><span class="crayon-sy">@</span><span
class="crayon-v">data</span><span
class="crayon-sy">$&lt;/span&gt;&lt;span class="crayon-v"&gt;NAME\_2&lt;/span&gt;&lt;span class="crayon-sy"&gt;\[&lt;/span&gt;&lt;span class="crayon-v"&gt;BRmap&lt;/span&gt;&lt;span class="crayon-sy"&gt;@&lt;/span&gt;&lt;span class="crayon-v"&gt;data&lt;/span&gt;&lt;span class="crayon-sy"&gt;$</span><span
class="crayon-v">NAME\_2</span><span class="crayon-o">==</span><span
class="crayon-s">"MACEIO (CAPITAL)"</span><span
class="crayon-sy">\]</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-s">"MACEIO"</span>

<span class="crayon-v">BRmap</span><span class="crayon-sy">@</span><span
class="crayon-v">data</span><span
class="crayon-sy">$&lt;/span&gt;&lt;span class="crayon-v"&gt;NAME\_2&lt;/span&gt;&lt;span class="crayon-sy"&gt;\[&lt;/span&gt;&lt;span class="crayon-v"&gt;BRmap&lt;/span&gt;&lt;span class="crayon-sy"&gt;@&lt;/span&gt;&lt;span class="crayon-v"&gt;data&lt;/span&gt;&lt;span class="crayon-sy"&gt;$</span><span
class="crayon-v">NAME\_2</span><span class="crayon-o">==</span><span
class="crayon-s">"SAO GABRIEL DE CAHOEIRA"</span><span
class="crayon-sy">\]</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-s">"SAO GABRIEL DA
CACHOEIRA"</span>

<span class="crayon-v">BRmap</span><span class="crayon-sy">@</span><span
class="crayon-v">data</span><span
class="crayon-sy">$&lt;/span&gt;&lt;span class="crayon-v"&gt;NAME\_2&lt;/span&gt;&lt;span class="crayon-sy"&gt;\[&lt;/span&gt;&lt;span class="crayon-v"&gt;BRmap&lt;/span&gt;&lt;span class="crayon-sy"&gt;@&lt;/span&gt;&lt;span class="crayon-v"&gt;data&lt;/span&gt;&lt;span class="crayon-sy"&gt;$</span><span
class="crayon-v">NAME\_2</span><span class="crayon-o">==</span><span
class="crayon-s">"NOVO BRAZIL"</span><span
class="crayon-sy">\]</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-s">"NOVO BRASIL"</span>

<span class="crayon-v">BRmap</span><span class="crayon-sy">@</span><span
class="crayon-v">data</span><span
class="crayon-sy">$&lt;/span&gt;&lt;span class="crayon-v"&gt;NAME\_2&lt;/span&gt;&lt;span class="crayon-sy"&gt;\[&lt;/span&gt;&lt;span class="crayon-v"&gt;BRmap&lt;/span&gt;&lt;span class="crayon-sy"&gt;@&lt;/span&gt;&lt;span class="crayon-v"&gt;data&lt;/span&gt;&lt;span class="crayon-sy"&gt;$</span><span
class="crayon-v">NAME\_2</span><span class="crayon-o">==</span><span
class="crayon-s">"PERI-MIRIM"</span><span
class="crayon-sy">\]</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-s">"PERI MIRIM"</span>

<span class="crayon-v">BRmap</span><span class="crayon-sy">@</span><span
class="crayon-v">data</span><span
class="crayon-sy">$&lt;/span&gt;&lt;span class="crayon-v"&gt;NAME\_2&lt;/span&gt;&lt;span class="crayon-sy"&gt;\[&lt;/span&gt;&lt;span class="crayon-v"&gt;BRmap&lt;/span&gt;&lt;span class="crayon-sy"&gt;@&lt;/span&gt;&lt;span class="crayon-v"&gt;data&lt;/span&gt;&lt;span class="crayon-sy"&gt;$</span><span
class="crayon-v">NAME\_2</span><span class="crayon-o">==</span><span
class="crayon-s">"SEM-PEIXE"</span><span
class="crayon-sy">\]</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-s">"SEM PEIXE"</span>

<span class="crayon-v">BRmap</span><span class="crayon-sy">@</span><span
class="crayon-v">data</span><span
class="crayon-sy">$&lt;/span&gt;&lt;span class="crayon-v"&gt;NAME\_2&lt;/span&gt;&lt;span class="crayon-sy"&gt;\[&lt;/span&gt;&lt;span class="crayon-v"&gt;BRmap&lt;/span&gt;&lt;span class="crayon-sy"&gt;@&lt;/span&gt;&lt;span class="crayon-v"&gt;data&lt;/span&gt;&lt;span class="crayon-sy"&gt;$</span><span
class="crayon-v">NAME\_2</span><span class="crayon-o">==</span><span
class="crayon-s">"BRAZIL NOVO"</span><span
class="crayon-sy">\]</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-s">"BRASIL NOVO"</span>

<span class="crayon-v">BRmap</span><span class="crayon-sy">@</span><span
class="crayon-v">data</span><span
class="crayon-sy">$&lt;/span&gt;&lt;span class="crayon-v"&gt;NAME\_2&lt;/span&gt;&lt;span class="crayon-sy"&gt;\[&lt;/span&gt;&lt;span class="crayon-v"&gt;BRmap&lt;/span&gt;&lt;span class="crayon-sy"&gt;@&lt;/span&gt;&lt;span class="crayon-v"&gt;data&lt;/span&gt;&lt;span class="crayon-sy"&gt;$</span><span
class="crayon-v">NAME\_2</span><span class="crayon-o">==</span><span
class="crayon-s">"OLHOS-D'AGUA"</span><span
class="crayon-sy">\]</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-s">"OLHOS D'AGUA"</span>

<span class="crayon-v">BRmap</span><span class="crayon-sy">@</span><span
class="crayon-v">data</span><span
class="crayon-sy">$&lt;/span&gt;&lt;span class="crayon-v"&gt;NAME\_2&lt;/span&gt;&lt;span class="crayon-sy"&gt;\[&lt;/span&gt;&lt;span class="crayon-v"&gt;BRmap&lt;/span&gt;&lt;span class="crayon-sy"&gt;@&lt;/span&gt;&lt;span class="crayon-v"&gt;data&lt;/span&gt;&lt;span class="crayon-sy"&gt;$</span><span
class="crayon-v">NAME\_2</span><span class="crayon-o">==</span><span
class="crayon-s">"OLHO-D'AGUA DO BORGES"</span><span
class="crayon-sy">\]</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-s">"OLHO D'AGUA DO
BORGES"</span>

<span class="crayon-v">BRmap</span><span class="crayon-sy">@</span><span
class="crayon-v">data</span><span
class="crayon-sy">$&lt;/span&gt;&lt;span class="crayon-v"&gt;NAME\_2&lt;/span&gt;&lt;span class="crayon-sy"&gt;\[&lt;/span&gt;&lt;span class="crayon-v"&gt;BRmap&lt;/span&gt;&lt;span class="crayon-sy"&gt;@&lt;/span&gt;&lt;span class="crayon-v"&gt;data&lt;/span&gt;&lt;span class="crayon-sy"&gt;$</span><span
class="crayon-v">NAME\_2</span><span class="crayon-o">==</span><span
class="crayon-s">"SERRA DA SAUDAD"</span><span
class="crayon-sy">\]</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-s">"SERRA DA
SAUDADE"</span>

<span class="crayon-v">BRmap</span><span class="crayon-sy">@</span><span
class="crayon-v">data</span><span
class="crayon-sy">$&lt;/span&gt;&lt;span class="crayon-v"&gt;NAME\_2&lt;/span&gt;&lt;span class="crayon-sy"&gt;\[&lt;/span&gt;&lt;span class="crayon-v"&gt;BRmap&lt;/span&gt;&lt;span class="crayon-sy"&gt;@&lt;/span&gt;&lt;span class="crayon-v"&gt;data&lt;/span&gt;&lt;span class="crayon-sy"&gt;$</span><span
class="crayon-v">NAME\_2</span><span class="crayon-o">==</span><span
class="crayon-s">"PEIXE BOI"</span><span
class="crayon-sy">\]</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-s">"PEIXE-BOI"</span>

<span class="crayon-v">BRmap</span><span class="crayon-sy">@</span><span
class="crayon-v">data</span><span
class="crayon-sy">$&lt;/span&gt;&lt;span class="crayon-v"&gt;NAME\_2&lt;/span&gt;&lt;span class="crayon-sy"&gt;\[&lt;/span&gt;&lt;span class="crayon-v"&gt;BRmap&lt;/span&gt;&lt;span class="crayon-sy"&gt;@&lt;/span&gt;&lt;span class="crayon-v"&gt;data&lt;/span&gt;&lt;span class="crayon-sy"&gt;$</span><span
class="crayon-v">NAME\_2</span><span class="crayon-o">==</span><span
class="crayon-s">"RICAHO DOS CAVALOS"</span><span
class="crayon-sy">\]</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-s">"RIACHO DOS
CAVALOS"</span>

<span class="crayon-v">BRmap</span><span class="crayon-sy">@</span><span
class="crayon-v">data</span><span
class="crayon-sy">$&lt;/span&gt;&lt;span class="crayon-v"&gt;NAME\_2&lt;/span&gt;&lt;span class="crayon-sy"&gt;\[&lt;/span&gt;&lt;span class="crayon-v"&gt;BRmap&lt;/span&gt;&lt;span class="crayon-sy"&gt;@&lt;/span&gt;&lt;span class="crayon-v"&gt;data&lt;/span&gt;&lt;span class="crayon-sy"&gt;$</span><span
class="crayon-v">NAME\_2</span><span class="crayon-o">==</span><span
class="crayon-s">"BRAZILEIRA"</span><span
class="crayon-sy">\]</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-s">"BRASILEIRA"</span>

<span class="crayon-v">BRmap</span><span class="crayon-sy">@</span><span
class="crayon-v">data</span><span
class="crayon-sy">$&lt;/span&gt;&lt;span class="crayon-v"&gt;NAME\_2&lt;/span&gt;&lt;span class="crayon-sy"&gt;\[&lt;/span&gt;&lt;span class="crayon-v"&gt;BRmap&lt;/span&gt;&lt;span class="crayon-sy"&gt;@&lt;/span&gt;&lt;span class="crayon-v"&gt;data&lt;/span&gt;&lt;span class="crayon-sy"&gt;$</span><span
class="crayon-v">NAME\_2</span><span class="crayon-o">==</span><span
class="crayon-s">"SUL BRAZIL"</span><span
class="crayon-sy">\]</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-s">"SUL BRASIL"</span>

<span class="crayon-v">BRmap</span><span class="crayon-sy">@</span><span
class="crayon-v">data</span><span
class="crayon-sy">$&lt;/span&gt;&lt;span class="crayon-v"&gt;NAME\_2&lt;/span&gt;&lt;span class="crayon-sy"&gt;\[&lt;/span&gt;&lt;span class="crayon-v"&gt;BRmap&lt;/span&gt;&lt;span class="crayon-sy"&gt;@&lt;/span&gt;&lt;span class="crayon-v"&gt;data&lt;/span&gt;&lt;span class="crayon-sy"&gt;$</span><span
class="crayon-v">NAME\_2</span><span class="crayon-o">==</span><span
class="crayon-s">"FLORINIAPOLIS"</span><span
class="crayon-sy">\]</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-s">"FLORIANOPOLIS"</span>

<span class="crayon-v">BRmap</span><span class="crayon-sy">@</span><span
class="crayon-v">data</span><span
class="crayon-sy">$&lt;/span&gt;&lt;span class="crayon-v"&gt;NAME\_2&lt;/span&gt;&lt;span class="crayon-sy"&gt;\[&lt;/span&gt;&lt;span class="crayon-v"&gt;BRmap&lt;/span&gt;&lt;span class="crayon-sy"&gt;@&lt;/span&gt;&lt;span class="crayon-v"&gt;data&lt;/span&gt;&lt;span class="crayon-sy"&gt;$</span><span
class="crayon-v">NAME\_2</span><span class="crayon-o">==</span><span
class="crayon-s">"BON JESUS DOS PERDOES"</span><span
class="crayon-sy">\]</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-s">"BOM JESUS DOS
PERDOES"</span>

<span class="crayon-v">BRmap</span><span class="crayon-sy">@</span><span
class="crayon-v">data</span><span
class="crayon-sy">$&lt;/span&gt;&lt;span class="crayon-v"&gt;NAME\_2&lt;/span&gt;&lt;span class="crayon-sy"&gt;\[&lt;/span&gt;&lt;span class="crayon-v"&gt;BRmap&lt;/span&gt;&lt;span class="crayon-sy"&gt;@&lt;/span&gt;&lt;span class="crayon-v"&gt;data&lt;/span&gt;&lt;span class="crayon-sy"&gt;$</span><span
class="crayon-v">NAME\_2</span><span class="crayon-o">==</span><span
class="crayon-s">"OLHO-D'AGUA DO BORGES"</span><span
class="crayon-sy">\]</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-s">"OLHO D'AGUA DO
BORGES"</span>

<span class="crayon-v">BRmap</span><span class="crayon-sy">@</span><span
class="crayon-v">data</span><span
class="crayon-sy">$&lt;/span&gt;&lt;span class="crayon-v"&gt;NAME\_2&lt;/span&gt;&lt;span class="crayon-sy"&gt;\[&lt;/span&gt;&lt;span class="crayon-v"&gt;BRmap&lt;/span&gt;&lt;span class="crayon-sy"&gt;@&lt;/span&gt;&lt;span class="crayon-v"&gt;data&lt;/span&gt;&lt;span class="crayon-sy"&gt;$</span><span
class="crayon-v">NAME\_2</span><span class="crayon-o">==</span><span
class="crayon-s">"MISSO"</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-o">&lt;</span><span
class="crayon-o">-</span><span class="crayon-h"> </span><span
class="crayon-s">"MISSAO"</span>

<span class="crayon-v">BRmap</span><span class="crayon-sy">@</span><span
class="crayon-v">data</span><span
class="crayon-sy">$&lt;/span&gt;&lt;span class="crayon-v"&gt;NAME\_2&lt;/span&gt;&lt;span class="crayon-sy"&gt;\[&lt;/span&gt;&lt;span class="crayon-v"&gt;BRmap&lt;/span&gt;&lt;span class="crayon-sy"&gt;@&lt;/span&gt;&lt;span class="crayon-v"&gt;data&lt;/span&gt;&lt;span class="crayon-sy"&gt;$</span><span
class="crayon-v">NAME\_2</span><span class="crayon-o">==</span><span
class="crayon-s">"SALIDAO"</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-o">&lt;</span><span
class="crayon-o">-</span><span class="crayon-h"> </span><span
class="crayon-s">"SOLIDAO"</span>

<span class="crayon-v">BRmap</span><span class="crayon-sy">@</span><span
class="crayon-v">data</span><span
class="crayon-sy">$&lt;/span&gt;&lt;span class="crayon-v"&gt;NAME\_2&lt;/span&gt;&lt;span class="crayon-sy"&gt;\[&lt;/span&gt;&lt;span class="crayon-v"&gt;BRmap&lt;/span&gt;&lt;span class="crayon-sy"&gt;@&lt;/span&gt;&lt;span class="crayon-v"&gt;data&lt;/span&gt;&lt;span class="crayon-sy"&gt;$</span><span
class="crayon-v">NAME\_2</span><span class="crayon-o">==</span><span
class="crayon-s">"SAO JOAO DAS DUAS PONTE"</span><span
class="crayon-sy">\]</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-s">"SAO JOAO DAS DUAS
PONTES"</span>

<span class="crayon-v">BRmap</span><span class="crayon-sy">@</span><span
class="crayon-v">data</span><span
class="crayon-sy">$&lt;/span&gt;&lt;span class="crayon-v"&gt;NAME\_2&lt;/span&gt;&lt;span class="crayon-sy"&gt;\[&lt;/span&gt;&lt;span class="crayon-v"&gt;BRmap&lt;/span&gt;&lt;span class="crayon-sy"&gt;@&lt;/span&gt;&lt;span class="crayon-v"&gt;data&lt;/span&gt;&lt;span class="crayon-sy"&gt;$</span><span
class="crayon-v">NAME\_2</span><span class="crayon-o">==</span><span
class="crayon-s">"ORLEAES"</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span class="crayon-o">&lt;</span><span
class="crayon-o">-</span><span class="crayon-h"> </span><span
class="crayon-s">"ORLEANS"</span>

</td>
</tr>
</table>

<br>
</figure>
<p>
Podemos usar <code class="highlighter-rouge">fortify</code> para
transformar isso tudo em algo mais manipulável para
o <code class="highlighter-rouge">ggplot().</code> Então podemos
acrescentar os dados que temos do total de votos para a Dilma e estamos
prontos para plotar algo.
</p>
<figure class="highlight">
<span class="crayon-title"></span>

<span class="crayon-language">R</span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
Brasil &lt;- fortify(BRmap, region = "ID\_2") %&gt;%  
mutate(id = as.integer(id)) %&gt;% full\_join(<BRmap@data>, by =c("id" =
"ID\_2")) %&gt;% select(c(id, long, lat, order, hole, piece, group,
NAME\_2)) %&gt;% rename(NOME\_MUNICIPIO = NAME\_2)

head(Brasil) id long lat order hole piece group NOME\_MUNICIPIO 1 1
-67.10586 -9.688110 1 FALSE 1 1.1 ACRELANDIA 2 1 -67.05984 -9.706651 2
FALSE 1 1.1 ACRELANDIA 3 1 -66.80647 -9.814520 3 FALSE 1 1.1 ACRELANDIA
4 1 -66.62003 -9.894039 4 FALSE 1 1.1 ACRELANDIA 5 1 -66.58875 -9.903196
5 FALSE 1 1.1 ACRELANDIA 6 1 -66.62333 -9.923209 6 FALSE 1 1.1
ACRELANDIA

Dilma\_1 &lt;- left\_join(Brasil, Pres1) %&gt;% mutate(PERC =
ifelse(is.na(PERC), mean(PERC, na.rm=T), PERC)) ggplot() +
geom\_polygon(data = Dilma\_1, aes(x = long, y = lat, group = group,
fill = PERC), color = "white", size = 0.1) +
scale\_fill\_distiller(palette = "RdBu", breaks = pretty\_breaks(n = 8))
+ guides(fill = guide\_legend(reverse = TRUE)) + labs(fill = "Dilma
(%)") + theme\_nothing(legend = TRUE) +
xlim(range(Dilma\_1*l**o**n**g*)) + *y**l**i**m*(*r**a**n**g**e*(*D**i**l**m**a*<sub>1</sub>lat))
+ coord\_map()
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

</td>
<td class="crayon-code">
<span class="crayon-v">Brasil</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-e">fortify</span><span
class="crayon-sy">(</span><span class="crayon-v">BRmap</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">region</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"ID\_2"</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">%</span><span
class="crayon-o">&gt;</span><span class="crayon-o">%</span><span
class="crayon-h">  </span>

<span class="crayon-h">  </span><span
class="crayon-e">mutate</span><span class="crayon-sy">(</span><span
class="crayon-v">id</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-st">as</span><span class="crayon-sy">.</span><span
class="crayon-t">integer</span><span class="crayon-sy">(</span><span
class="crayon-v">id</span><span class="crayon-sy">)</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&gt;</span><span
class="crayon-o">%</span><span class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">full\_join</span><span class="crayon-sy">(</span><span
class="crayon-v">BRmap</span><span class="crayon-sy">@</span><span
class="crayon-v">data</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">by</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-e">c</span><span class="crayon-sy">(</span><span
class="crayon-s">"id"</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"ID\_2"</span><span class="crayon-sy">)</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&gt;</span><span
class="crayon-o">%</span><span class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">select</span><span class="crayon-sy">(</span><span
class="crayon-e">c</span><span class="crayon-sy">(</span><span
class="crayon-v">id</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-t">long</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">lat</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">order</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">hole</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">piece</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">group</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">NAME\_2</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">%</span><span
class="crayon-o">&gt;</span><span class="crayon-o">%</span><span
class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">rename</span><span class="crayon-sy">(</span><span
class="crayon-v">NOME\_MUNICIPIO</span><span class="crayon-h">
</span><span class="crayon-o">=</span><span class="crayon-h">
</span><span class="crayon-v">NAME\_2</span><span
class="crayon-sy">)</span>

<span class="crayon-h">  </span>

<span class="crayon-e">head</span><span class="crayon-sy">(</span><span
class="crayon-v">Brasil</span><span class="crayon-sy">)</span>

<span class="crayon-h">  </span><span
class="crayon-e">id      </span><span class="crayon-t">long</span><span
class="crayon-h">       </span><span class="crayon-e">lat </span><span
class="crayon-e">order  </span><span class="crayon-e">hole </span><span
class="crayon-e">piece </span><span class="crayon-e">group </span><span
class="crayon-v">NOME</span><span class="crayon-sy">\_</span>MUNICIPIO

<span class="crayon-cn">1</span><span class="crayon-h">  </span><span
class="crayon-cn">1</span><span class="crayon-h"> </span><span
class="crayon-o">-</span><span class="crayon-cn">67.10586</span><span
class="crayon-h"> </span><span class="crayon-o">-</span><span
class="crayon-cn">9.688110</span><span class="crayon-h">    
</span><span class="crayon-cn">1</span><span class="crayon-h">
</span><span class="crayon-t">FALSE</span><span class="crayon-h">    
</span><span class="crayon-cn">1</span><span class="crayon-h">  
</span><span class="crayon-cn">1.1</span><span class="crayon-h">    
</span><span class="crayon-i">ACRELANDIA</span>

<span class="crayon-cn">2</span><span class="crayon-h">  </span><span
class="crayon-cn">1</span><span class="crayon-h"> </span><span
class="crayon-o">-</span><span class="crayon-cn">67.05984</span><span
class="crayon-h"> </span><span class="crayon-o">-</span><span
class="crayon-cn">9.706651</span><span class="crayon-h">    
</span><span class="crayon-cn">2</span><span class="crayon-h">
</span><span class="crayon-t">FALSE</span><span class="crayon-h">    
</span><span class="crayon-cn">1</span><span class="crayon-h">  
</span><span class="crayon-cn">1.1</span><span class="crayon-h">    
</span><span class="crayon-i">ACRELANDIA</span>

<span class="crayon-cn">3</span><span class="crayon-h">  </span><span
class="crayon-cn">1</span><span class="crayon-h"> </span><span
class="crayon-o">-</span><span class="crayon-cn">66.80647</span><span
class="crayon-h"> </span><span class="crayon-o">-</span><span
class="crayon-cn">9.814520</span><span class="crayon-h">    
</span><span class="crayon-cn">3</span><span class="crayon-h">
</span><span class="crayon-t">FALSE</span><span class="crayon-h">    
</span><span class="crayon-cn">1</span><span class="crayon-h">  
</span><span class="crayon-cn">1.1</span><span class="crayon-h">    
</span><span class="crayon-i">ACRELANDIA</span>

<span class="crayon-cn">4</span><span class="crayon-h">  </span><span
class="crayon-cn">1</span><span class="crayon-h"> </span><span
class="crayon-o">-</span><span class="crayon-cn">66.62003</span><span
class="crayon-h"> </span><span class="crayon-o">-</span><span
class="crayon-cn">9.894039</span><span class="crayon-h">    
</span><span class="crayon-cn">4</span><span class="crayon-h">
</span><span class="crayon-t">FALSE</span><span class="crayon-h">    
</span><span class="crayon-cn">1</span><span class="crayon-h">  
</span><span class="crayon-cn">1.1</span><span class="crayon-h">    
</span><span class="crayon-i">ACRELANDIA</span>

<span class="crayon-cn">5</span><span class="crayon-h">  </span><span
class="crayon-cn">1</span><span class="crayon-h"> </span><span
class="crayon-o">-</span><span class="crayon-cn">66.58875</span><span
class="crayon-h"> </span><span class="crayon-o">-</span><span
class="crayon-cn">9.903196</span><span class="crayon-h">    
</span><span class="crayon-cn">5</span><span class="crayon-h">
</span><span class="crayon-t">FALSE</span><span class="crayon-h">    
</span><span class="crayon-cn">1</span><span class="crayon-h">  
</span><span class="crayon-cn">1.1</span><span class="crayon-h">    
</span><span class="crayon-i">ACRELANDIA</span>

<span class="crayon-cn">6</span><span class="crayon-h">  </span><span
class="crayon-cn">1</span><span class="crayon-h"> </span><span
class="crayon-o">-</span><span class="crayon-cn">66.62333</span><span
class="crayon-h"> </span><span class="crayon-o">-</span><span
class="crayon-cn">9.923209</span><span class="crayon-h">    
</span><span class="crayon-cn">6</span><span class="crayon-h">
</span><span class="crayon-t">FALSE</span><span class="crayon-h">    
</span><span class="crayon-cn">1</span><span class="crayon-h">  
</span><span class="crayon-cn">1.1</span><span class="crayon-h">    
</span><span class="crayon-e">ACRELANDIA</span>

 

 

<span class="crayon-v">Dilma\_1</span><span class="crayon-h">
</span><span class="crayon-o">&lt;</span><span
class="crayon-o">-</span><span class="crayon-h"> </span><span
class="crayon-e">left\_join</span><span class="crayon-sy">(</span><span
class="crayon-v">Brasil</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">Pres1</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&gt;</span><span
class="crayon-o">%</span><span class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">mutate</span><span class="crayon-sy">(</span><span
class="crayon-v">PERC</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-e">ifelse</span><span class="crayon-sy">(</span><span
class="crayon-st">is</span><span class="crayon-sy">.</span><span
class="crayon-t">na</span><span class="crayon-sy">(</span><span
class="crayon-v">PERC</span><span class="crayon-sy">)</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-e">mean</span><span class="crayon-sy">(</span><span
class="crayon-v">PERC</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-t">na</span><span
class="crayon-sy">.</span><span class="crayon-v">rm</span><span
class="crayon-o">=</span><span class="crayon-t">T</span><span
class="crayon-sy">)</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">PERC</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span>

<span class="crayon-e">ggplot</span><span
class="crayon-sy">(</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">+</span><span
class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">geom\_polygon</span><span
class="crayon-sy">(</span><span class="crayon-v">data</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-v">Dilma\_1</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-e">aes</span><span class="crayon-sy">(</span><span
class="crayon-v">x</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-t">long</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">y</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-v">lat</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span>

<span class="crayon-h">                                   </span><span
class="crayon-v">group</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">group</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">fill</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-v">PERC</span><span
class="crayon-sy">)</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span>

<span class="crayon-h">               </span><span
class="crayon-v">color</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"white"</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">size</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-cn">0.1</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">+</span>

<span class="crayon-h">  </span><span
class="crayon-e">scale\_fill\_distiller</span><span
class="crayon-sy">(</span><span class="crayon-v">palette</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-s">"RdBu"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span>

<span class="crayon-h">                       </span><span
class="crayon-v">breaks</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-e">pretty\_breaks</span><span
class="crayon-sy">(</span><span class="crayon-v">n</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-cn">8</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">+</span>

<span class="crayon-h">  </span><span
class="crayon-e">guides</span><span class="crayon-sy">(</span><span
class="crayon-v">fill</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-e">guide\_legend</span><span
class="crayon-sy">(</span><span class="crayon-v">reverse</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-t">TRUE</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">+</span>

<span class="crayon-h">  </span><span class="crayon-e">labs</span><span
class="crayon-sy">(</span><span class="crayon-v">fill</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-s">"Dilma (%)"</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">+</span>

<span class="crayon-h">  </span><span
class="crayon-e">theme\_nothing</span><span
class="crayon-sy">(</span><span class="crayon-v">legend</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-t">TRUE</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">+</span><span class="crayon-h"> </span>

<span class="crayon-h">  </span><span class="crayon-e">xlim</span><span
class="crayon-sy">(</span><span class="crayon-e">range</span><span
class="crayon-sy">(</span><span class="crayon-v">Dilma\_1</span><span
class="crayon-sy">$&lt;/span&gt;&lt;span class="crayon-t"&gt;long&lt;/span&gt;&lt;span class="crayon-sy"&gt;)&lt;/span&gt;&lt;span class="crayon-sy"&gt;)&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;+&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-e"&gt;ylim&lt;/span&gt;&lt;span class="crayon-sy"&gt;(&lt;/span&gt;&lt;span class="crayon-e"&gt;range&lt;/span&gt;&lt;span class="crayon-sy"&gt;(&lt;/span&gt;&lt;span class="crayon-v"&gt;Dilma\_1&lt;/span&gt;&lt;span class="crayon-sy"&gt;$</span><span
class="crayon-v">lat</span><span class="crayon-sy">)</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">+</span>

<span class="crayon-h">  </span><span
class="crayon-e">coord\_map</span><span class="crayon-sy">(</span><span
class="crayon-sy">)</span>

</td>
</tr>
</table>

<br>
</figure>
<p>
<img src="https://i.imgur.com/xYMEQrk.jpg">
</p>
<p>
Podemos ver que mesmo em 2014, o apoio de Dilma no Sudeste do país não
foi esmagador.
</p>
<p>
Nós podemos usar <code class="highlighter-rouge">electionsBR</code> para
investigar outros itens de interesse, como a parcela de votos por
partido. Por exemplo, talvez você esteja interessado em saber se o
Partido Comunista do Brasil tem nichos no país. Tudo que precisamos
fazer é um subconjunto do banco de dados
<code class="highlighter-rouge">Mun</code> que baixamos anteriormente
por <code class="highlighter-rouge">DESCRICAO\_CARGO == "DEPUTADO
FEDERAL"</code> and<code class="highlighter-rouge">SIGLA\_PARTIDO == "PC
do B"</code>.e SIGLA\_PARTIDO == “PC do B”. Além dessas mudanças, todo o
resto pode ser feito da mesma maneira. Uma vez que temos este dataframe
(que eu vou chamar de
<code class="highlighter-rouge">pc</code>), podemos plotar tudo da mesma
maneira:
</p>
<figure class="highlight">
<span class="crayon-title"></span>

<span class="crayon-language">R</span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
ggplot() + geom\_polygon(data = pc, aes(x = long, y = lat, group =
group, fill = PERC), color = "white", size = 0.1) +
scale\_fill\_distiller(palette = "RdBu", breaks = pretty\_breaks(n = 8))
+ guides(fill = guide\_legend(reverse = TRUE)) + labs(fill = "PC do B
(%)") + theme\_nothing(legend = TRUE) +
xlim(range(pc*l**o**n**g*)) + *y**l**i**m*(*r**a**n**g**e*(*p**c*lat)) +
coord\_map()
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
<span class="crayon-e">ggplot</span><span
class="crayon-sy">(</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">+</span><span
class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">geom\_polygon</span><span
class="crayon-sy">(</span><span class="crayon-v">data</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-v">pc</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-e">aes</span><span class="crayon-sy">(</span><span
class="crayon-v">x</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-t">long</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">y</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-v">lat</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">group</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">group</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span>

<span class="crayon-h">                              </span><span
class="crayon-v">fill</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">PERC</span><span class="crayon-sy">)</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span>

<span class="crayon-h">               </span><span
class="crayon-v">color</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"white"</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">size</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-cn">0.1</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">+</span>

<span class="crayon-h">  </span><span
class="crayon-e">scale\_fill\_distiller</span><span
class="crayon-sy">(</span><span class="crayon-v">palette</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-s">"RdBu"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span>

<span class="crayon-h">                       </span><span
class="crayon-v">breaks</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-e">pretty\_breaks</span><span
class="crayon-sy">(</span><span class="crayon-v">n</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-cn">8</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">+</span>

<span class="crayon-h">  </span><span
class="crayon-e">guides</span><span class="crayon-sy">(</span><span
class="crayon-v">fill</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-e">guide\_legend</span><span
class="crayon-sy">(</span><span class="crayon-v">reverse</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-t">TRUE</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">+</span>

<span class="crayon-h">  </span><span class="crayon-e">labs</span><span
class="crayon-sy">(</span><span class="crayon-v">fill</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-s">"PC do B
(%)"</span><span class="crayon-sy">)</span><span class="crayon-h">
</span><span class="crayon-o">+</span>

<span class="crayon-h">  </span><span
class="crayon-e">theme\_nothing</span><span
class="crayon-sy">(</span><span class="crayon-v">legend</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-t">TRUE</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">+</span><span class="crayon-h"> </span>

<span class="crayon-h">  </span><span class="crayon-e">xlim</span><span
class="crayon-sy">(</span><span class="crayon-e">range</span><span
class="crayon-sy">(</span><span class="crayon-v">pc</span><span
class="crayon-sy">$&lt;/span&gt;&lt;span class="crayon-t"&gt;long&lt;/span&gt;&lt;span class="crayon-sy"&gt;)&lt;/span&gt;&lt;span class="crayon-sy"&gt;)&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;+&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-e"&gt;ylim&lt;/span&gt;&lt;span class="crayon-sy"&gt;(&lt;/span&gt;&lt;span class="crayon-e"&gt;range&lt;/span&gt;&lt;span class="crayon-sy"&gt;(&lt;/span&gt;&lt;span class="crayon-v"&gt;pc&lt;/span&gt;&lt;span class="crayon-sy"&gt;$</span><span
class="crayon-v">lat</span><span class="crayon-sy">)</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">+</span>

<span class="crayon-h">  </span><span
class="crayon-e">coord\_map</span><span class="crayon-sy">(</span><span
class="crayon-sy">)</span>

</td>
</tr>
</table>

<br>
</figure>
<p>
<img src="https://i.imgur.com/jXKjZgG.jpg">
</p>
<p>
Pelo visto não é um país muito comunista.
</p>
<p>
Isso foi uma breve apresentação do pacote
<code class="highlighter-rouge">electionsBR</code>. Estão disponíveis
dados de outros anos e eleições também, assim como dados de outros
níveis administrativos, não apenas o Presidente e Deputados Federais. O
TSE também tem dados sobre os antecedentes dos candidatos e seus gastos
de campanha, todos os quais podem ser utilizados
com <code class="highlighter-rouge">electionsBR</code>. E se você quiser
combinar toda essa informação com o comportamento legislativo da Câmara
dos Deputados, basta carregar o
pacote <code class="highlighter-rouge">bRasilLegis</code> e você tem uma
abundância de dados sobre deputados federais brasileiros na palma da
mão. Estou muito orgulhoso de estar envolvido em ambos os pacotes. É
ótimo ajudar a facilitar o acesso a esses dados para os interessados na
política Brasileira.
</p>
<p>
Ps. Esta postagem no blog foi escrita usando
<a href="http://rmarkdown.rstudio.com/r_notebooks.html"><code class="highlighter-rouge">R
Notebooks</code></a> e transformada em .md na minha pasta
jekyll<code class="highlighter-rouge">\_posts,</code> usando uma função
de <a href="https://github.com/dgrtwo/dgrtwo.github.com/blob/master/_scripts/knitpages.R">David
Robinson</a>. Admito que gostei muito do
<code class="highlighter-rouge">R Notebooks</code> até agora,
especialmente a pré-visualização. Experimente você também.
</p>
<p>
Update: parece que algumas pessoas estão tendo problemas executando os
scripts acima, com o <strong>R</strong> retornando:
<code class="highlighter-rouge">Error: isTRUE(gpclibPermitStatus()) is
not TRUE</code>. A solução para isso é ter certeza de que tem rgdal ou
rgeos ou pacote de mapeamento semelhante instalado.
</p>
<p>
Vale mencionar que eu estou envolvido no desenvolvimento deste pacote,
entretanto não sou um dos desenvolvedores originais – os que merecem
esse crédito são
<a href="https://github.com/silvadenisson/electionsBR">Denisson
Silva</a>, Fernando Meireles, e Beatriz Costa. No entanto, estou
promovendo aqui porque eu acho que é ótimo, e não porque estou
envolvido. (Embora eu esteja envolvido porque eu acho que é ótimo
<img class="emoji" title=":smile:" src="https://assets-cdn.github.com/images/icons/emoji/unicode/1f604.png" alt=":smile:" width="20" height="20" align="absmiddle">
)
</p>
<p>
 
</p>

