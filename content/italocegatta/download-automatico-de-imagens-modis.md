+++
title = "Download automático de imagens MODIS"
date = "2017-01-15"
categories = ["italocegatta"]
original_url = "https://italocegatta.github.io/download-automatico-de-imagens-modis/"
+++

<p>
O MODIS (MODerate resolution Imaging Spectroradiometer) faz parte de um
programa da NASA para monitoramento da superfície terrestre. Os
satélites Terra e Aqua fornecem informações muito interessantes para o
setor agroflorestal e nos permite entender de maneira bastante eficaz a
dinâmica do uso do solo e de crescimento das nossas culturas.
</p>
<p>
O MODOIS tem diversos
<a href="https://modis.gsfc.nasa.gov/data/">produtos</a>, mas neste post
vamos tratar especificamente do produto
<a href="https://lpdaac.usgs.gov/dataset_discovery/modis/modis_products_table/mod13q1_v006">MOD13Q1</a>,
que disponibiliza a cada 16 dias um raster de EVI e NDVI com resolução
de 250 m. Bom, se você está acostumado com imagens de
satélite/drone/vant com resolução submétrica, pode ser que no primeiro
momento esta escala te assuste. Mas vale lembrar que é um serviço
gratuito e e de ótima qualidade.
</p>
<p>
As cenas do MODIS ficam disponíveis em um
<a href="https://e4ftl01.cr.usgs.gov/">ftp</a> e navegando por lá
podemos chegar na pasta do produto que nos
<a href="http://e4ftl01.cr.usgs.gov/MOLT/MOD13Q1.006">interessa</a>.
Temos então imagens de satélite processadas, com correção atmosférica,
sem deslocamento espacial e com regularidade. O satélite varre a terra a
cada dois dias e as melhores visadas são utilizadas para compor o
produto que é disponibilizado a cada 16 dias. Há casos (de baixa
frequência) em que a nebulosidade é tanta que não é possível compor a
informação do pixel dentro desta janela
</p>
<p>
Nosso objetivo para este poste é fazer o download das cenas de forma
automática, um web scraping. No R há diversos pacotes que nos auxiliam
neste processo. A primeira etapa é acessar o ftp que contém as cenas e
extrair as datas das cenas disponíveis.
</p>
<pre class="r"><code>if (!require(&quot;pacman&quot;)) install.packages(&quot;pacman&quot;) pacman::p_load(dplyr, xml2, rvest, httr, stringr, methods)</code></pre>
<pre class="r"><code># url do ftp que cont&#xE9;m as cenas path_root &lt;- &quot;http://e4ftl01.cr.usgs.gov/MOLT/MOD13Q1.006&quot; # carrega a raiz do ftp page_root &lt;- read_html(path_root) # extrai os dias das cenas scene_days &lt;- page_root %&gt;% html_nodes(&quot;a&quot;) %&gt;% html_text(trim = T) %&gt;% &apos;[&apos;(-c(1:7)) %&gt;% str_replace_all(&quot;\\/&quot;, &quot;&quot;) glimpse(scene_days)</code></pre>
<pre><code>## chr [1:395] &quot;2000.02.18&quot; &quot;2000.03.05&quot; &quot;2000.03.21&quot; ...</code></pre>
<p>
Muito bem, temos até a data da ultima atualização deste post 395 cenas
disponíveis. O script abaixo cria a pasta com a data da cena e coloca lá
os
<a href="https://modis-land.gsfc.nasa.gov/MODLAND_grid.html">tiles</a>
de seu interesse. Como exemplo vamos pegar os tiles que cobrem os
estados de São Paulo e Bahia. Note que é preciso ter um cadastro para
autorizar o download dos arquivos. É simples e rápido de fazer acessando
este <a href="https://urs.earthdata.nasa.gov/users/new/">link</a>.
</p>
<pre class="r"><code># inicio do 1&#xBA; loop - dias for (i in seq_along(scene_days)) { # cria a pasta para receber os tiles if(!dir.exists(scene_days[i])) dir.create(scene_days[i]) # ideintificador de itera&#xE7;&#xE3;o day &lt;- scene_days[i] # carrega a pagina do dia da cena page_tiles &lt;- read_html(paste(path_root, day, sep = &quot;/&quot;)) # extrai os tiles de interesse path_tiles &lt;- page_tiles %&gt;% html_nodes(&quot;a&quot;) %&gt;% html_text(trim = T) %&gt;% &apos;[&apos;(str_detect(., &quot;[hdf]$&quot;)) %&gt;% &apos;[&apos;(str_detect(., &quot;h13v11|h14v10&quot;)) # inicio do 2&#xBA; loop - tiles for (j in seq_along(path_tiles)) { # url do tile path_tile &lt;- paste(path_root, day, path_tiles[j], sep = &quot;/&quot;) # id do tile tile &lt;- paste(day, path_tiles[j], sep = &quot;/&quot;) # download do arquivo if (!file.exists(tile)) { temp &lt;- GET(path_tile, authenticate(&quot;LOGIN&quot;, &quot;SENHA&quot;)) writeBin(content(temp, &quot;raw&quot;), tile) rm(temp) } } }</code></pre>
<p>
Como tudo que está neste blog, este script foi escrito para resolver um
problema específico e com certeza tem muito espaço para melhoria. Os
próximos passos da análise, extração dos rasters e processamento da
imagem serão abordados em posts separados. No futuro, caso exista uma
demanda, pode ser que as funções sejam reunidas em um pacote específico
sobre isso.
</p>
<p>
Caso tenha alguma dúvida ou sugestão sobre o post, fique à vontade para
fazer um comentário ou me contactar por Email.
</p>
<pre class="r"><code>devtools::session_info()</code></pre>
<pre><code>## setting value ## version R version 3.3.3 (2017-03-06) ## system x86_64, mingw32 ## ui RTerm ## language (EN) ## collate Portuguese_Brazil.1252 ## tz America/Sao_Paulo ## date 2017-04-30 ## ## package * version date source ## assertthat 0.2.0 2017-04-11 CRAN (R 3.3.3) ## backports 1.0.5 2017-01-18 CRAN (R 3.3.2) ## blogdown 0.0.25 2017-03-23 Github (rstudio/blogdown@1c10d16) ## bookdown 0.3.14 2017-03-23 Github (rstudio/bookdown@f427fdf) ## curl 2.6 2017-04-27 CRAN (R 3.3.3) ## DBI 0.6-1 2017-04-01 CRAN (R 3.3.3) ## devtools 1.12.0 2016-06-24 CRAN (R 3.3.3) ## digest 0.6.12 2017-01-27 CRAN (R 3.3.2) ## dplyr * 0.5.0 2016-06-24 CRAN (R 3.3.2) ## evaluate 0.10 2016-10-11 CRAN (R 3.3.3) ## htmltools 0.3.6 2017-04-28 CRAN (R 3.3.3) ## httr * 1.2.1 2016-07-03 CRAN (R 3.3.2) ## knitr 1.15.1 2016-11-22 CRAN (R 3.3.3) ## magrittr 1.5 2014-11-22 CRAN (R 3.3.2) ## memoise 1.1.0 2017-04-21 CRAN (R 3.3.3) ## pacman * 0.4.1 2016-03-30 CRAN (R 3.3.3) ## R6 2.2.0 2016-10-05 CRAN (R 3.3.2) ## Rcpp 0.12.10 2017-03-19 CRAN (R 3.3.3) ## rmarkdown 1.5 2017-04-26 CRAN (R 3.3.3) ## rprojroot 1.2 2017-01-16 CRAN (R 3.3.3) ## rvest * 0.3.2 2016-06-17 CRAN (R 3.3.2) ## selectr 0.3-1 2016-12-19 CRAN (R 3.3.2) ## stringi 1.1.5 2017-04-07 CRAN (R 3.3.3) ## stringr * 1.2.0 2017-02-18 CRAN (R 3.3.2) ## tibble 1.3.0 2017-04-01 CRAN (R 3.3.3) ## withr 1.0.2 2016-06-20 CRAN (R 3.3.3) ## XML 3.98-1.6 2017-03-30 CRAN (R 3.3.3) ## xml2 * 1.1.1 2017-01-24 CRAN (R 3.3.2) ## yaml 2.1.14 2016-11-12 CRAN (R 3.3.3)</code></pre>

