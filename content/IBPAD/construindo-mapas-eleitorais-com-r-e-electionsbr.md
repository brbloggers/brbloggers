+++
title = "Construindo mapas eleitorais com R e electionsBR"
date = "2016-11-07 17:34:35"
categories = ["IBPAD"]
original_url = "http://www.ibpad.com.br/blog/analise-de-dados/construindo-mapas-eleitorais-com-r-e-electionsbr/"
+++

<p>
<em>\[Texto do prof.
<a href="http://www.ibpad.com.br/nosso-time/robert-mcdonnell/">Robert
McDonnell</a>, professor do curso de Programação em R – Texto
originalmente publicado
<a href="http://robertmyles.github.io/ElectionsBR.html" target="_blank">aqui</a>\]</em>
</p>
<p>
Para os interessados na política brasileira, foi divulgado um novo
pacote chamado
<pre class="crayon-plain-tag">electionsBR.</pre>
 que pega dados do
<a href="http://www.tse.jus.br/eleicoes/estatisticas/repositorio-de-dados-eleitorais" target="_blank">TSE
–  Tribunal Superior Eleitoral</a> e os torna disponíveis em um formato
organizado para usuários de R. Dada a minha obsessão recente com
a <a href="http://robertmyles.github.io//re-creating-plots-from-the-economist-in-r.html" class="broken_link">elaboraçao
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
<pre class="crayon-plain-tag">library(tidyverse)
library(electionsBR)
library(ggmap)
library(rgdal)
library(stringi)
library(scales)
library(maptools)
library(RColorBrewer)</pre>
<br />
</figure>
<p>
A
função <code class="highlighter-rouge">vote\_mun\_zone\_fed()</code> toma
um único argumento, <code class="highlighter-rouge">year</code>, como um
inteiro.  Isso demora um bom tempo para fazer o download, visto que é
uma grande base de dados.
</p>
<figure class="highlight">
<pre class="crayon-plain-tag">Mun &lt;- vote_mun_zone_fed(2014)</pre>
<br />
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
<pre class="crayon-plain-tag">Mun &lt;- Mun %&gt;% 
  select(SIGLA_UF, DESCRICAO_CARGO, CODIGO_MUNICIPIO, TOTAL_VOTOS,
         NUMERO_CAND, NOME_MUNICIPIO, NUM_TURNO, SIGLA_PARTIDO) %&gt;% 
  mutate(NOME_MUNICIPIO = stri_trans_general(NOME_MUNICIPIO, "Latin-ASCII"))</pre>
<br />
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
<pre class="crayon-plain-tag">Pres1 &lt;- Mun %&gt;% 
  filter(DESCRICAO_CARGO == "PRESIDENTE", NUM_TURNO == 1, 
         SIGLA_UF != "ZZ") %&gt;% 
  group_by(NUMERO_CAND, CODIGO_MUNICIPIO) %&gt;% 
  mutate(SUM = sum(TOTAL_VOTOS)) %&gt;% 
  distinct(CODIGO_MUNICIPIO, .keep_all=T) %&gt;% 
  ungroup() %&gt;% 
  group_by(CODIGO_MUNICIPIO) %&gt;% 
  mutate(PERC = TOTAL_VOTOS/sum(TOTAL_VOTOS)*100) %&gt;% 
  arrange(SIGLA_UF, NOME_MUNICIPIO) %&gt;% 
  ungroup() %&gt;% 
  filter(NUMERO_CAND == 13)</pre>
<br />
</figure>
<figure class="highlight">
Em seguida, leremos nossos arquivos de formato. Teremos que arrumar
nomes de municípios e corrigir erros de codificação.<br />
<pre class="crayon-plain-tag">BRmap &lt;- readOGR(dsn = "BRA_adm_shp", layer = "BRA_adm3", verbose = FALSE)
BRmap@data$NAME_2 &lt;- BRmap@data$NAME_2 %&gt;% 
  as.character() %&gt;% 
  stri_trans_general("Latin-ASCII") %&gt;% 
  toupper()</pre>
<br />
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
<a href="http://www.ibpad.com.br/produto/programacao-em-r/">Programação
em R</a> oferecido pelo IBPAD</em>
</p>
<p>
<em> Inscrições abertas em São Paulo e no Rio de Janeiro!</em>
</p>
</blockquote>
<p>
 
</p>
<figure class="highlight">
<pre class="crayon-plain-tag">'%ni%' &lt;- Negate('%in%')

unique(BRmap@data$NAME_2[which(BRmap@data$NAME_2 %ni% Mun$NOME_MUNICIPIO)])

  [1] "BARRA DA CHOCA"                "DIAS D'VILA"                  
  [3] "LIVRAMENTO DO BRUMADO"         "MUQUEM DE SAO FRANCISCO"      
  [5] "OLIVERIA DOS BREJINHOS"        "PAU BRAZIL"                   
  [7] "QUIJINGUE"                     "ITAPAJE"                      
  [9] "MISSO VELHA"                   "SAO JOAO DO BELM"             
 [11] "SAO LUIZ DO CURU"              "GUIA BRANCA"                  
 [13] "ILHA TRINDADE"                 "ILHAS DE MARTIM VAZ"          
 [15] "AMERICANO DO BRAZIL"           "BRASABRANTES"                 
 [17] "MATEIRA"                       "PORTEIRO"                     
 [19] "SANTA RITA DE ARAGUAIA"        "ALTO ALEGRE DO MARANHO"       
 [21] "AMAPA DO MARANHO"              "ANAPUROS"                     
 [23] "BOM JARDIN"                    "HUMBERTO CAMPOS"              
 [25] "MATES DO NORTE"                "VICTORINO FREIRE"             
 [27] "BATAIPORA"                     "BARRA DOS BUGRE"              
 [29] "POXOREO"                       "SAO FELIX XINGU"              
 [31] "BANDIERA DO SUL"               "BRASOPOLIS"                   
 [33] "CACHOEIRA DE PAJES"            "CAMPOS VERDES DE GOIAS"       
 [35] "CARAVALHOPOLIS"                "CASSITERITA"                  
 [37] "CHAVESLANDIA"                  "FELISBERTO CALDEIRA"          
 [39] "FRANCISCO DUMON"               "GOUVEA"                       
 [41] "ITABIRINHA DE MANTENA"         "ITACARAMBIRA"                 
 [43] "PIEDADE DO PONTE NOVA"         "PIUI"                         
 [45] "QUELUZITA"                     "SAO FRANCISCO DE OLIVEIRA"    
 [47] "SAO SEBASTIO DA VARGEM ALEGRE" "SAN ANTONIO DO ITAMBE"        
 [49] "SAN ANTONIO DO RIO ABAI"       "SANTA RITA DO IBITIPOCA"      
 [51] "SANTA RITA ITUETO"             "ALMERIM"                      
 [53] "BRAGANGA"                      "ME DO RIO"                    
 [55] "BOQUEIRAO DOS COCHOS"          "DESTERRO DE MALTA"            
 [57] "MONGEIRO"                      "PEDRA LAVADRA"                
 [59] "RIACHO"                        "SAO MIGUEL TAIPU"             
 [61] "SERIDO"                        "ALTAMIRA DO PARAN"            
 [63] "ARAPU"                         "ASSIS CHATEAUBRI"             
 [65] "CAMPO"                         "CONSELHEIRO MAYRINCK"         
 [67] "IVATUVA"                       "JABUTI"                       
 [69] "SAO ANTONIO DE SUDOESTE"       "SALTO DO LONDRA"              
 [71] "SANTA CRUZ DE MONTE CASTE"     "SANTA ISABEL DO OESTE"        
 [73] "TEXEIRA SOARES"                "TIBAJI"                       
 [75] "VENCESLAU BRAS"                "VILA ALTA"                    
 [77] "BARRA DE GUABIRA"              "CABO"                         
 [79] "CACHOERINHA"                   "IGARACU"                      
 [81] "LAGOA DO ITAENGA"              "SAO JOAO DO BELMONTE"         
 [83] "SAO JOAQUIN DO MONTE"          "SITIO DOS MOREIRAS"           
 [85] "TAMBE"                         "PEDRO LI"                     
 [87] "SAO JOAO PIAUI"                "SAO MIGUEL TAPUIO"            
 [89] "CAMPOS"                        "CAREPEBUS"                    
 [91] "CONCEICAO MACABU"              "ENGENHEIRO PAULO DE FRONT"    
 [93] "PARATI"                        "VALENCIA"                     
 [95] "ACU"                           "AUGUSTO SEVERO"               
 [97] "GOVERNADOR DIX-SEPT ROSAD"     "JANUARIO CICCO"               
 [99] "JARDIM-PIRANHAS"               "JUNCO"                        
[101] "LAGOA DE ANTA"                 "LAGOAS DE VELHOS"             
[103] "SAO MIGUEL DE TOUROS"          "BAJE"                         
[105] "BARO"                          "BOA VISTA DAS MISSES"         
[107] "CAMAGUA"                       "CAMPO REAL"                   
[109] "CHIAPETA"                      "DILERMANO DE AGUIAR"          
[111] "ERVAL"                         "INHACOR"                      
[113] "LAGOA MIRIM"                   "MARCIONILIO DIAS"             
[115] "MAXIMILIANO DE ALMAEIDA"       "PALMITINHOS"                  
[117] "SAO MIGUEL DAS MISSES"         "UREA"                         
[119] "VITORIA DAS MISSES"            "ALTA FLORESTA D'OESTE"        
[121] "ALVORADA D'OESTE"              "ESPIGAO D'OESTE"              
[123] "NOVA BRASILANDIA D'OESTE"      "SAO FELIPE D'OESTE"           
[125] "SANTA LUZIA D'OESTE"           "ALFREDO MARCONDE"             
[127] "APARECIDA DOESTE"              "BRODOSQUI"                    
[129] "DULCINOPOLIS"                  "EMBU"                         
[131] "ESTRELA DO OESTE"              "FERNO"                        
[133] "FERRAZ DE VASCON"              "FLORINIA"                     
[135] "GUARANI DO OESTE"              "IPAUCU"                       
[137] "JABUTICABAL"                   "LUISIANIA"                    
[139] "PALMEIRA DO OESTE"             "PARANAPAREMA"                 
[141] "PIRACUNUNGA"                   "PONTES GESTRAL"               
[143] "QUITANA"                       "SAO LUIZ DO PARAITINGA"       
[145] "SALTO DO PIRAPORA"             "SANTA CLARA DO OESTE"         
[147] "SANTA RITA DO OESTE"           "GRAO PARA"                    
[149] "LUIZ ALVES"                    "PAULO LOPEZ"                  
[151] "PICARRAS"                      "PONTA ALTA"                   
[153] "BUQUIM"                        "GRACHO CARDOSO"               
[155] "ITAPORANGA DAJUDA"             "NOSSA SENHORA APRECIDO"       
[157] "COUTO MAGALHAES"               "MOSQUITO"</pre>
<br />
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
<pre class="crayon-plain-tag">BRmap@data$NAME_2[BRmap@data$NAME_2=="ASSIS BRAZIL"] &lt;- "ASSIS BRASIL"
BRmap@data$NAME_2[BRmap@data$NAME_2=="JOINVILE"] &lt;- "JOINVILLE"
BRmap@data$NAME_2[BRmap@data$NAME_2=="MACEIO (CAPITAL)"] &lt;- "MACEIO"
BRmap@data$NAME_2[BRmap@data$NAME_2=="SAO GABRIEL DE CAHOEIRA"] &lt;- "SAO GABRIEL DA CACHOEIRA"
BRmap@data$NAME_2[BRmap@data$NAME_2=="NOVO BRAZIL"] &lt;- "NOVO BRASIL"
BRmap@data$NAME_2[BRmap@data$NAME_2=="PERI-MIRIM"] &lt;- "PERI MIRIM"
BRmap@data$NAME_2[BRmap@data$NAME_2=="SEM-PEIXE"] &lt;- "SEM PEIXE"
BRmap@data$NAME_2[BRmap@data$NAME_2=="BRAZIL NOVO"] &lt;- "BRASIL NOVO"
BRmap@data$NAME_2[BRmap@data$NAME_2=="OLHOS-D'AGUA"] &lt;- "OLHOS D'AGUA"
BRmap@data$NAME_2[BRmap@data$NAME_2=="OLHO-D'AGUA DO BORGES"] &lt;- "OLHO D'AGUA DO BORGES"
BRmap@data$NAME_2[BRmap@data$NAME_2=="SERRA DA SAUDAD"] &lt;- "SERRA DA SAUDADE"
BRmap@data$NAME_2[BRmap@data$NAME_2=="PEIXE BOI"] &lt;- "PEIXE-BOI"
BRmap@data$NAME_2[BRmap@data$NAME_2=="RICAHO DOS CAVALOS"] &lt;- "RIACHO DOS CAVALOS"
BRmap@data$NAME_2[BRmap@data$NAME_2=="BRAZILEIRA"] &lt;- "BRASILEIRA"
BRmap@data$NAME_2[BRmap@data$NAME_2=="SUL BRAZIL"] &lt;- "SUL BRASIL"
BRmap@data$NAME_2[BRmap@data$NAME_2=="FLORINIAPOLIS"] &lt;- "FLORIANOPOLIS"
BRmap@data$NAME_2[BRmap@data$NAME_2=="BON JESUS DOS PERDOES"] &lt;- "BOM JESUS DOS PERDOES"
BRmap@data$NAME_2[BRmap@data$NAME_2=="OLHO-D'AGUA DO BORGES"] &lt;- "OLHO D'AGUA DO BORGES"
BRmap@data$NAME_2[BRmap@data$NAME_2=="MISSO"] &lt;- "MISSAO"
BRmap@data$NAME_2[BRmap@data$NAME_2=="SALIDAO"] &lt;- "SOLIDAO"
BRmap@data$NAME_2[BRmap@data$NAME_2=="SAO JOAO DAS DUAS PONTE"] &lt;- "SAO JOAO DAS DUAS PONTES"
BRmap@data$NAME_2[BRmap@data$NAME_2=="ORLEAES"] &lt;- "ORLEANS"</pre>
<br />
</figure>
<p>
Podemos usar <code class="highlighter-rouge">fortify</code> para
transformar isso tudo em algo mais manipulável para
o <code class="highlighter-rouge">ggplot().</code> Então podemos
acrescentar os dados que temos do total de votos para a Dilma e estamos
prontos para plotar algo.
</p>
<figure class="highlight">
<pre class="crayon-plain-tag">Brasil &lt;- fortify(BRmap, region = "ID_2") %&gt;%  
  mutate(id = as.integer(id)) %&gt;% 
  full_join(BRmap@data, by =c("id" = "ID_2")) %&gt;% 
  select(c(id, long, lat, order, hole, piece, group, NAME_2)) %&gt;% 
  rename(NOME_MUNICIPIO = NAME_2)
  
head(Brasil)
  id      long       lat order  hole piece group NOME_MUNICIPIO
1  1 -67.10586 -9.688110     1 FALSE     1   1.1     ACRELANDIA
2  1 -67.05984 -9.706651     2 FALSE     1   1.1     ACRELANDIA
3  1 -66.80647 -9.814520     3 FALSE     1   1.1     ACRELANDIA
4  1 -66.62003 -9.894039     4 FALSE     1   1.1     ACRELANDIA
5  1 -66.58875 -9.903196     5 FALSE     1   1.1     ACRELANDIA
6  1 -66.62333 -9.923209     6 FALSE     1   1.1     ACRELANDIA


Dilma_1 &lt;- left_join(Brasil, Pres1) %&gt;% 
  mutate(PERC = ifelse(is.na(PERC), mean(PERC, na.rm=T), PERC))
ggplot() + 
  geom_polygon(data = Dilma_1, aes(x = long, y = lat, 
                                   group = group, fill = PERC), 
               color = "white", size = 0.1) +
  scale_fill_distiller(palette = "RdBu", 
                       breaks = pretty_breaks(n = 8)) +
  guides(fill = guide_legend(reverse = TRUE)) +
  labs(fill = "Dilma (%)") +
  theme_nothing(legend = TRUE) + 
  xlim(range(Dilma_1$long)) + ylim(range(Dilma_1$lat)) +
  coord_map()</pre>
<br />
</figure>
<p>
<img src="https://i2.wp.com/i.imgur.com/xYMEQrk.jpg?w=900" data-recalc-dims="1" />
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
<pre class="crayon-plain-tag">ggplot() + 
  geom_polygon(data = pc, aes(x = long, y = lat, group = group, 
                              fill = PERC), 
               color = "white", size = 0.1) +
  scale_fill_distiller(palette = "RdBu", 
                       breaks = pretty_breaks(n = 8)) +
  guides(fill = guide_legend(reverse = TRUE)) +
  labs(fill = "PC do B (%)") +
  theme_nothing(legend = TRUE) + 
  xlim(range(pc$long)) + ylim(range(pc$lat)) +
  coord_map()</pre>
<br />
</figure>
<p>
<img src="https://i0.wp.com/i.imgur.com/jXKjZgG.jpg?w=900" data-recalc-dims="1" />
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
<img class="emoji" title=":smile:" src="https://i0.wp.com/assets-cdn.github.com/images/icons/emoji/unicode/1f604.png?resize=20%2C20&#038;ssl=1" alt=":smile:" align="absmiddle" data-recalc-dims="1" />
)
</p>
<p>
 
</p>
<p>
O post
<a rel="nofollow" href="http://www.ibpad.com.br/blog/analise-de-dados/construindo-mapas-eleitorais-com-r-e-electionsbr/">Construindo
mapas eleitorais com R e electionsBR</a> apareceu primeiro em
<a rel="nofollow" href="http://www.ibpad.com.br">IBPAD</a>.
</p>

