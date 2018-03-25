+++
title = "Qual estado tem mais pau-rodado?"
date = "1-01-01"
categories = ["italocegatta"]
original_url = "https://italocegatta.github.io/qual-estado-tem-mais-pau-rodado/"
+++

<p>
Em Cuiabá, cidade que em que nasci e cresci, <em>pau-rodado</em> é
subistantivo que define passoas que nasceram em outro estado mas moram
em Cuiabá e ali construíram suas vidas. Aliás, Cuiabá sempre foi
conhecida por ser uma Cidade super acolhedora e talvez por isso todos
encaram o dito <em>pau-rodado</em> de uma forma engraçada sem qualquer
sentido pejorativo.
</p>
<p>
Mutio bem, meu interesse com este post é analisar o comportamento dos
fluxos migratórios entre estados. Serei breve e não vamos abordar todos
os estados, mas se você tiver curiosidade poderá aproveitar o código
para uma análise mais ampla.
</p>
<p>
A motivação partiu de uma matéria do
<a href="https://www.nexojornal.com.br/grafico/2017/12/01/Fluxos-migrat%C3%B3rios-a-distribui%C3%A7%C3%A3o-da-popula%C3%A7%C3%A3o-de-cada-estado-pelo-pa%C3%ADs">Nexo
Jornal</a> sobre este tema, porém ao nível estadual. Depois de algumas
horas tentando decifrar o site do IBGE, cheguei na
<a href="https://sidra.ibge.gov.br/tabela/1852">página</a> que informa a
população residente, por lugar de nascimento e unidade da federação.
</p>
<p>
Então vamos começar a análise carregando os pacotes do R necessários
para este post.
</p>
<pre class="r"><code>if (!require(&quot;pacman&quot;)) install.packages(&quot;pacman&quot;)
pacman::p_load(readr, dplyr, tidyr, forcats, sf, geosphere, brmap, ggplot2, ggrepel, geofacet, ggthemes)
pacman::p_load_gh(&quot;italocegatta/brmap&quot;)</code></pre>
<p>
Os dados oroginais estão disponíveis neste
<a href="https://sidra.ibge.gov.br/tabela/1852">link</a>, fiz apenas
adequações porque o IBGE insiste em mesclar células nas tabelas
disponibilizadas.
</p>
<pre class="r"><code>base &lt;- read_csv2(&quot;https://raw.githubusercontent.com/italocegatta/italocegatta.github.io_source/master/content/dados/pnad_2015_migracao.csv&quot;) base</code></pre>
<pre><code>## # A tibble: 27 x 28
## Estado Rond&#xF4;nia Acre Amazonas Roraima Par&#xE1; Amap&#xE1; Tocantins
## &lt;chr&gt; &lt;dbl&gt; &lt;dbl&gt; &lt;dbl&gt; &lt;dbl&gt; &lt;dbl&gt; &lt;dbl&gt; &lt;dbl&gt;
## 1 Rond&#xF4;nia 57.4 1.84 1.90 0.0800 0.700 NA 0.0200
## 2 Acre 1.54 87.9 3.89 0.0200 0.170 NA 0.0200
## 3 Amazonas 0.460 1.60 87.6 0.230 5.36 0.130 0.0600
## 4 Roraima 0.650 0.240 5.16 55.6 6.54 0.0400 0.570 ## 5 Par&#xE1; 0.0300 0.0200 0.490 0.0200 84.6 0.190 1.07 ## 6 Amap&#xE1; 0.100 0.0300 0.200 0.170 20.8 72.7 0.100 ## 7 Tocantins 0.0700 0.0700 0.0200 NA 2.83 0.0200 69.5 ## 8 Maranh&#xE3;o 0.0300 0.0100 0.0500 NA 1.11 0.0100 0.320 ## 9 Piau&#xED; 0.0400 0.0200 0.0400 0.0500 0.280 NA 0.110 ## 10 Cear&#xE1; 0.0300 0.0400 0.110 NA 0.220 0.0100 0.0300
## # ... with 17 more rows, and 20 more variables: Maranh&#xE3;o &lt;dbl&gt;,
## # Piau&#xED; &lt;dbl&gt;, Cear&#xE1; &lt;dbl&gt;, `Rio Grande do Norte` &lt;dbl&gt;, Para&#xED;ba &lt;dbl&gt;,
## # Pernambuco &lt;dbl&gt;, Alagoas &lt;dbl&gt;, Sergipe &lt;dbl&gt;, Bahia &lt;dbl&gt;, `Minas
## # Gerais` &lt;dbl&gt;, `Esp&#xED;rito Santo` &lt;dbl&gt;, `Rio de Janeiro` &lt;dbl&gt;, `S&#xE3;o
## # Paulo` &lt;dbl&gt;, Paran&#xE1; &lt;dbl&gt;, `Santa Catarina` &lt;dbl&gt;, `Rio Grande do
## # Sul` &lt;dbl&gt;, `Mato Grosso do Sul` &lt;dbl&gt;, `Mato Grosso` &lt;dbl&gt;,
## # Goi&#xE1;s &lt;dbl&gt;, `Distrito Federal` &lt;dbl&gt;</code></pre>
<p>
Dados longitudinais como estes ajudam humanos a enxergar os valores de
forma mais fácil, mas do ponto de vista de processamento de dados, não
dá pra fazer muita coisa com os dados assim. Vamos organizá-los seguindo
a filosofia do
<a href="https://italocegatta.github.io/o-conceito-tidy-data">Tidy
data</a>.
</p>
<p>
A nova tabela nos informa a porcentagem da população residente (coluna
‘valor’) para cada estado subidividindo os valores por local de
nascimento. E agora vai a primeira simplificação: foram selecionados
apenas os 6 Estados de nacimento mais representativos para cada Estado
de residência.
</p>
<pre class="r"><code>df &lt;- base %&gt;% gather(reside, valor, -Estado) %&gt;% select(nasce = Estado, reside, valor) %&gt;% replace_na(list(valor = 0)) %&gt;% group_by(nasce) %&gt;% filter(row_number(-valor) &lt;= 6) %&gt;% ungroup() df</code></pre>
<pre><code>## # A tibble: 162 x 3
## nasce reside valor
## &lt;chr&gt; &lt;chr&gt; &lt;dbl&gt;
## 1 Rond&#xF4;nia Rond&#xF4;nia 57.4 ## 2 Acre Rond&#xF4;nia 1.54 ## 3 Amazonas Rond&#xF4;nia 0.460
## 4 Acre Acre 87.9 ## 5 Amazonas Acre 1.60 ## 6 Acre Amazonas 3.89 ## 7 Amazonas Amazonas 87.6 ## 8 Roraima Amazonas 5.16 ## 9 Roraima Roraima 55.6 ## 10 Amazonas Par&#xE1; 5.36 ## # ... with 152 more rows</code></pre>
<p>
Vamos nos preparar para a segunda simplificação: selecionar os extremos
em termos de população que nasceu e reside no mesmo estado. Então, RS,
CE e PE são os estados que mais tem moradores nascidos dentro do próprio
estado, enquanto RO, RR e DF tem uma parcela maior de residentes
nascidos em outros estados.
</p>
<pre class="r"><code>estados_interesse &lt;- df %&gt;% filter(reside == nasce) %&gt;% filter(row_number(-valor) &lt;= 3 | row_number(valor) &lt;= 3) %&gt;% arrange(-valor) %&gt;% pull(nasce) estados_interesse</code></pre>
<pre><code>## [1] &quot;Rio Grande do Sul&quot; &quot;Cear&#xE1;&quot; &quot;Pernambuco&quot; ## [4] &quot;Rond&#xF4;nia&quot; &quot;Roraima&quot; &quot;Distrito Federal&quot;</code></pre>
<p>
Preparando para o mapa, vamos pegar as coodenadas dos centróides de cada
Estado.
</p>
<pre class="r"><code>estado_cent &lt;- brmap_estado %&gt;% st_centroid() %&gt;% cbind(., st_coordinates(.)) %&gt;% st_set_geometry(NULL) %&gt;% select(estado, lon = X, lat = Y) estado_cent</code></pre>
<pre><code>## estado lon lat
## 1 Rond&#xF4;nia -62.84197 -10.913218
## 2 Acre -70.47328 -9.212886
## 3 Amazonas -64.65314 -4.154177
## 4 Roraima -61.39928 2.084226
## 5 Par&#xE1; -53.06424 -3.974791
## 6 Amap&#xE1; -51.95592 1.443319
## 7 Tocantins -48.32923 -10.150316
## 8 Maranh&#xE3;o -45.27922 -5.061285
## 9 Piau&#xED; -42.96862 -7.387530
## 10 Cear&#xE1; -39.61569 -5.093345
## 11 Rio Grande do Norte -36.67348 -5.839677
## 12 Para&#xED;ba -36.83262 -7.121055
## 13 Pernambuco -37.99843 -8.326066
## 14 Alagoas -36.62494 -9.513863
## 15 Sergipe -37.44390 -10.584475
## 16 Bahia -41.72094 -12.475023
## 17 Minas Gerais -44.67343 -18.456187
## 18 Esp&#xED;rito Santo -40.67106 -19.575176
## 19 Rio de Janeiro -42.65238 -22.188741
## 20 S&#xE3;o Paulo -48.73391 -22.263472
## 21 Paran&#xE1; -51.61668 -24.635899
## 22 Santa Catarina -50.47480 -27.247356
## 23 Rio Grande do Sul -53.32029 -29.705681
## 24 Mato Grosso do Sul -54.84563 -20.327310
## 25 Mato Grosso -55.91215 -12.948967
## 26 Goi&#xE1;s -49.62361 -16.042227
## 27 Distrito Federal -47.79736 -15.780692</code></pre>
<p>
E agora, o pulo do gato. Vamos criar as linhas que ligam os estados
entre si e em seguida adicionar à tabela que informa as relações de
fluxo. Portanto, para cada relação entre Estado de nascimento/residencia
temos uma feição de linha e o valor que representa a porcentagem de
residentes.
</p>
<pre class="r"><code>coord &lt;- df %&gt;% left_join(estado_cent, by = c(&quot;nasce&quot; = &quot;estado&quot;)) %&gt;% left_join(estado_cent, by = c(&quot;reside&quot; = &quot;estado&quot;)) %&gt;% filter(nasce %in% estados_interesse) linhas &lt;- gcIntermediate( select(coord, lon.x, lat.x), select(coord, lon.y, lat.y), sp = TRUE, addStartEnd = TRUE ) %&gt;% st_as_sf() fluxo_linha &lt;- coord %&gt;% select(nasce, reside, valor) %&gt;% bind_cols(linhas) %&gt;% left_join(estado_cent, by = c(&quot;reside&quot; = &quot;estado&quot;)) %&gt;% mutate(nasce = fct_relevel(nasce, estados_interesse)) %&gt;% st_as_sf() fluxo_linha</code></pre>
<pre><code>## Simple feature collection with 36 features and 5 fields
## geometry type: LINESTRING
## dimension: XY
## bbox: xmin: -64.65314 ymin: -29.70568 xmax: -36.62494 ymax: 2.084226
## epsg (SRID): 4326
## proj4string: +proj=longlat +ellps=WGS84 +no_defs
## # A tibble: 36 x 6
## nasce reside valor lon lat geometry
## &lt;fct&gt; &lt;chr&gt; &lt;dbl&gt; &lt;dbl&gt; &lt;dbl&gt; &lt;LINESTRING [&#xC2;&#xB0;]&gt;
## 1 Rond&#xF4;nia Rond&#xF4;nia 57.4 -62.8 -10.9 (-62.84197 -10.91322, -6~
## 2 Roraima Amazonas 5.16 -64.7 -4.15 (-61.39928 2.084226, -61~
## 3 Roraima Roraima 55.6 -61.4 2.08 (-61.39928 2.084226, -61~
## 4 Roraima Par&#xE1; 6.54 -53.1 -3.97 (-61.39928 2.084226, -61~
## 5 Roraima Maranh&#xE3;o 19.0 -45.3 -5.06 (-61.39928 2.084226, -61~
## 6 Distrito Federal Maranh&#xE3;o 4.42 -45.3 -5.06 (-47.79736 -15.78069, -4~
## 7 Cear&#xE1; Piau&#xED; 0.390 -43.0 -7.39 (-39.61569 -5.093345, -3~
## 8 Distrito Federal Piau&#xED; 5.08 -43.0 -7.39 (-47.79736 -15.78069, -4~
## 9 Roraima Cear&#xE1; 2.76 -39.6 -5.09 (-61.39928 2.084226, -60~
## 10 Cear&#xE1; Cear&#xE1; 95.8 -39.6 -5.09 (-39.61569 -5.093345, -3~
## # ... with 26 more rows</code></pre>
<p>
Para deixar o gráfico um pouco mais bonito, vamos dar cor ao valor que
estamos estudando. Mas agora a feição será o polígono que representa o
estado de residentes.
</p>
<pre class="r"><code>fluxo_poligono &lt;- brmap_estado %&gt;% left_join(df, by = c(&quot;estado&quot; = &quot;reside&quot;)) %&gt;% rename(reside = estado) %&gt;% filter(nasce %in% estados_interesse) %&gt;% mutate(nasce = fct_relevel(nasce, estados_interesse)) %&gt;% select(nasce, reside, valor) fluxo_poligono</code></pre>
<pre><code>## Simple feature collection with 36 features and 3 fields
## geometry type: POLYGON
## dimension: XY
## bbox: xmin: -73.80156 ymin: -33.75118 xmax: -34.79288 ymax: 5.271841
## epsg (SRID): 4674
## proj4string: +proj=longlat +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +no_defs
## # A tibble: 36 x 4
## nasce reside valor geometry
## &lt;fct&gt; &lt;chr&gt; &lt;dbl&gt; &lt;POLYGON [&#xC2;&#xB0;]&gt;
## 1 Rond&#xF4;nia Rond&#xF4;nia 57.4 ((-62.86662 -7.975868, -62.86017 -7.9~
## 2 Roraima Amazonas 5.16 ((-67.32609 2.029714, -67.31682 2.001~
## 3 Roraima Roraima 55.6 ((-60.20051 5.264343, -60.19828 5.260~
## 4 Roraima Par&#xE1; 6.54 ((-54.95431 2.583692, -54.93542 2.518~
## 5 Roraima Maranh&#xE3;o 19.0 ((-45.84073 -1.045485, -45.84099 -1.0~
## 6 Distrito Federal Maranh&#xE3;o 4.42 ((-45.84073 -1.045485, -45.84099 -1.0~
## 7 Cear&#xE1; Piau&#xED; 0.390 ((-41.74605 -2.803497, -41.74241 -2.8~
## 8 Distrito Federal Piau&#xED; 5.08 ((-41.74605 -2.803497, -41.74241 -2.8~
## 9 Roraima Cear&#xE1; 2.76 ((-40.49717 -2.784509, -40.49173 -2.7~
## 10 Cear&#xE1; Cear&#xE1; 95.8 ((-40.49717 -2.784509, -40.49173 -2.7~
## # ... with 26 more rows</code></pre>
<p>
Pronto, já temos todos os dados que fazer o gráfico de interesse.
Lembrando que optamos por dar destaque a 6 Estados e para cada um deles,
os 6 estados que mais representam a população de residentes. É um tanto
complexo. Eu fiquei algumas horas para poder criar o código e entender o
que estava processando.
</p>
<p>
Como exemplo vamos interpretar as informações de Roraima: de todos os
residentes, 55.6% nasceram no próprio Estado de Roraima; 5.2%, 6.5% e
19% nasceram no Amazonas, Pará e Maranhão, respectivamente. x = NULL, y
</p>
<pre class="r"><code>ggplot() + geom_sf(data = brmap_estado, color = &quot;grey80&quot;, fill = &quot;grey95&quot;, size = 0.005) + geom_sf(data = fluxo_poligono, aes(fill = valor), color = &quot;grey80&quot;, size = 0.01) + geom_sf(data = fluxo_linha, color = &quot;cyan&quot;, size = 0.3) + geom_label_repel( data = fluxo_linha, aes(lon, lat, label = round(valor, 1)), size = 3, segment.colour = NA ) + facet_wrap(~nasce) + labs( title = &quot;Popula&#xE7;&#xE3;o residente (% do total geral)&quot;, subtitle = &quot;PNAD/IBGE, 2015&quot;, x = NULL, y = NULL ) + scale_fill_viridis_c(guide = FALSE) + coord_sf(datum = NA) + theme_fivethirtyeight()</code></pre>
<p>
<img src="https://italocegatta.github.io/post/2019-03-24-qual-estado-tem-mais-pau-rodado_files/figure-html/unnamed-chunk-9-1.png" width="4800">
</p>
<p>
Pontos interessantes:
</p>
<ul>
<li>
Rondônia e Roraima retém uma proporção parecida da população dentro do
próprio estado, entretanto o pessoal que mora em Rondônia veio do Sul e
Sudeste; ao passo que os moradores de Roraima vem do AM, PA e MA.
</li>
<li>
O Distrito Federal não me surpreendeu, grande parte de pessoas nasceram
em GO, MG e BA.
</li>
<li>
Um número expressivo de pessoas que nasceram em São Paulo e hoje moram
no CE e PE… parece que o jogo virou, não é mesmo?
</li>
</ul>
<p>
Caso tenha alguma dúvida ou sugestão sobre o post, fique à vontade para
fazer um comentário ou me contatar por E-mail.
</p>
<pre class="r"><code>devtools::session_info()</code></pre>
<pre><code>## setting value ## version R version 3.4.3 (2017-11-30)
## system x86_64, mingw32 ## ui RTerm ## language (EN) ## collate Portuguese_Brazil.1252 ## tz America/Sao_Paulo ## date 2018-03-24 ## ## package * version date source ## assertthat 0.2.0 2017-04-11 CRAN (R 3.4.3) ## backports 1.1.2 2017-12-13 CRAN (R 3.4.3) ## base * 3.4.3 2017-12-06 local ## bindr 0.1.1 2018-03-13 CRAN (R 3.4.4) ## bindrcpp * 0.2 2017-06-17 CRAN (R 3.4.3) ## blogdown 0.5 2018-01-24 CRAN (R 3.4.4) ## bookdown 0.7 2018-02-18 CRAN (R 3.4.4) ## brmap * 0.0.4 2018-02-11 Github (italocegatta/brmap@af57fd2)
## class 7.3-14 2015-08-30 CRAN (R 3.4.3) ## classInt 0.1-24 2017-04-16 CRAN (R 3.4.3) ## cli 1.0.0 2017-11-05 CRAN (R 3.4.3) ## colorspace 1.3-2 2016-12-14 CRAN (R 3.4.3) ## compiler 3.4.3 2017-12-06 local ## crayon 1.3.4 2017-09-16 CRAN (R 3.4.3) ## curl 3.1 2017-12-12 CRAN (R 3.4.3) ## datasets * 3.4.3 2017-12-06 local ## DBI 0.8 2018-03-02 CRAN (R 3.4.4) ## devtools 1.13.5 2018-02-18 CRAN (R 3.4.3) ## digest 0.6.15 2018-01-28 CRAN (R 3.4.3) ## dplyr * 0.7.4 2017-09-28 CRAN (R 3.4.3) ## e1071 1.6-8 2017-02-02 CRAN (R 3.4.3) ## evaluate 0.10.1 2017-06-24 CRAN (R 3.4.3) ## forcats * 0.3.0 2018-02-19 CRAN (R 3.4.4) ## geofacet * 0.1.5 2017-07-19 CRAN (R 3.4.4) ## geosphere * 1.5-7 2017-11-05 CRAN (R 3.4.4) ## ggplot2 * 2.2.1.9000 2018-03-25 Github (tidyverse/ggplot2@3c9c504) ## ggrepel * 0.7.0 2017-09-29 CRAN (R 3.4.3) ## ggthemes * 3.4.0 2017-02-19 CRAN (R 3.4.3) ## glue 1.2.0 2017-10-29 CRAN (R 3.4.3) ## graphics * 3.4.3 2017-12-06 local ## grDevices * 3.4.3 2017-12-06 local ## grid 3.4.3 2017-12-06 local ## gtable 0.2.0 2016-02-26 CRAN (R 3.4.3) ## hms 0.4.2 2018-03-10 CRAN (R 3.4.4) ## htmltools 0.3.6 2017-04-28 CRAN (R 3.4.3) ## knitr 1.20 2018-02-20 CRAN (R 3.4.4) ## lattice 0.20-35 2017-03-25 CRAN (R 3.4.3) ## lazyeval 0.2.1 2017-10-29 CRAN (R 3.4.3) ## magrittr 1.5 2014-11-22 CRAN (R 3.4.3) ## memoise 1.1.0 2017-04-21 CRAN (R 3.4.3) ## methods * 3.4.3 2017-12-06 local ## munsell 0.4.3 2016-02-13 CRAN (R 3.4.3) ## pacman * 0.4.6 2017-05-14 CRAN (R 3.4.3) ## pillar 1.2.1 2018-02-27 CRAN (R 3.4.4) ## pkgconfig 2.0.1 2017-03-21 CRAN (R 3.4.3) ## plyr 1.8.4 2016-06-08 CRAN (R 3.4.3) ## purrr 0.2.4 2017-10-18 CRAN (R 3.4.3) ## R6 2.2.2 2017-06-17 CRAN (R 3.4.3) ## Rcpp 0.12.16 2018-03-13 CRAN (R 3.4.4) ## readr * 1.1.1 2017-05-16 CRAN (R 3.4.3) ## rlang 0.2.0.9001 2018-03-25 Github (r-lib/rlang@870a6bf) ## rmarkdown 1.9 2018-03-01 CRAN (R 3.4.4) ## rprojroot 1.3-2 2018-01-03 CRAN (R 3.4.3) ## scales 0.5.0.9000 2018-02-11 Github (hadley/scales@d767915) ## sf * 0.6-1 2018-03-22 CRAN (R 3.4.3) ## sp 1.2-7 2018-01-19 CRAN (R 3.4.3) ## stats * 3.4.3 2017-12-06 local ## stringi 1.1.7 2018-03-12 CRAN (R 3.4.4) ## stringr 1.3.0 2018-02-19 CRAN (R 3.4.4) ## tibble 1.4.2 2018-01-22 CRAN (R 3.4.3) ## tidyr * 0.8.0 2018-01-29 CRAN (R 3.4.3) ## tidyselect 0.2.4 2018-02-26 CRAN (R 3.4.4) ## tools 3.4.3 2017-12-06 local ## udunits2 0.13 2016-11-17 CRAN (R 3.4.1) ## units 0.5-1 2018-01-08 CRAN (R 3.4.3) ## utf8 1.1.3 2018-01-03 CRAN (R 3.4.3) ## utils * 3.4.3 2017-12-06 local ## viridisLite 0.3.0 2018-02-01 CRAN (R 3.4.3) ## withr 2.1.2 2018-03-25 Github (jimhester/withr@79d7b0d) ## xfun 0.1 2018-01-22 CRAN (R 3.4.4) ## yaml 2.1.18 2018-03-08 CRAN (R 3.4.4)</code></pre>

