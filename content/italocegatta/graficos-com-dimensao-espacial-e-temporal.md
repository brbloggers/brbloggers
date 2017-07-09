+++
title = "Gráficos com dimensão espacial e temporal"
date = "2017-07-08"
categories = ["italocegatta"]
original_url = "https://italocegatta.github.io/graficos-com-dimensao-espacial-e-temporal/"
+++

<p>
O post de hoje é sobre visualização de dados com dimensão espacial e
temporal. Basicamente são gráficos que tem uma informação geográfica
associada com informações que variam no tempo. Esse tipo de análise é
comum no meu dia a dia e por isso resolvi deixar 3 alternativas
resgistradas aqui. O contexto que iremos abordar está relacionado ao
banco de dados de focos de incêndios registrados pelo INPE no
<a href="http://www.inpe.br/queimadas/situacao-atual">Programa Queimadas
Monitoramento por Satélites</a>. O site é bem interessante e apresenta
algumas estatísticas úteis sobre as queimadas na América do Sul e
Brasil. Iremos trabalhar com a tabela que resume os focos de incêndios
por ano e Estado brasileiro.
</p>
<pre class="r"><code>if (!require(&quot;pacman&quot;)) install.packages(&quot;pacman&quot;)
pacman::p_load(readr, dplyr, sf, ggplot2, ggthemes, geofacet, gganimate, viridis, scales)
pacman::p_load_gh(&quot;italocegatta/brmap&quot;)</code></pre>
<p>
O primeiro passo foi copiar os dados da página e organizá-los no formato
<a href="https://italocegatta.github.io/o-conceito-tidy-data/">tidy</a>.
Poderíamos fazer uma análise exploratória dos dados, mas quero manter o
foco em algo bem pontual: como mostrar os dados brutos de uma só vez? Ou
seja, considerando a dimensão de tempo (ano), geografia (localização do
estado) e variável resposta (focos) na mesma janela gráfica, de que
forma poderíamos apresentar os dados? .
</p>
<pre class="r"><code>focos &lt;- read_csv2(&quot;https://raw.githubusercontent.com/italocegatta/italocegatta.github.io_source/master/content/dados/base_incendios.csv&quot;) focos</code></pre>
<pre><code>## # A tibble: 162 x 3
## sigla ano focos
## &lt;chr&gt; &lt;int&gt; &lt;int&gt;
## 1 AC 2011 13
## 2 AL 2011 127
## 3 AM 2011 159
## 4 AP 2011 5
## 5 BA 2011 883
## 6 CE 2011 44
## 7 DF 2011 8
## 8 ES 2011 55
## 9 GO 2011 492
## 10 MA 2011 656
## # ... with 152 more rows</code></pre>
<p>
Vamos agora adicionar a referência espacial aos dados utilizando os
polígonos do pacote
<a href="https://github.com/italocegatta/brmap">brmap</a>.
</p>
<pre class="r"><code>estados_focos &lt;- focos %&gt;% left_join(brmap_estado, by = &quot;sigla&quot;) estados_focos</code></pre>
<pre><code>## # A tibble: 162 x 6
## sigla ano focos cod_estado estado geometry
## &lt;chr&gt; &lt;int&gt; &lt;int&gt; &lt;dbl&gt; &lt;chr&gt; &lt;simple_feature&gt;
## 1 AC 2011 13 12 Acre &lt;MULTIPOLYGON...&gt;
## 2 AL 2011 127 27 Alagoas &lt;MULTIPOLYGON...&gt;
## 3 AM 2011 159 13 Amazonas &lt;MULTIPOLYGON...&gt;
## 4 AP 2011 5 16 Amap&#xE1; &lt;MULTIPOLYGON...&gt;
## 5 BA 2011 883 29 Bahia &lt;MULTIPOLYGON...&gt;
## 6 CE 2011 44 23 Cear&#xE1; &lt;MULTIPOLYGON...&gt;
## 7 DF 2011 8 53 Distrito Federal &lt;MULTIPOLYGON...&gt;
## 8 ES 2011 55 32 Esp&#xED;rito Santo &lt;MULTIPOLYGON...&gt;
## 9 GO 2011 492 52 Goi&#xE1;s &lt;MULTIPOLYGON...&gt;
## 10 MA 2011 656 21 Maranh&#xE3;o &lt;MULTIPOLYGON...&gt;
## # ... with 152 more rows</code></pre>
<p>
A primeira abordagem vai utilizar o pacote
<a href="https://github.com/hafen/geofacet">geofacet</a>. Ele permite
criarmos um grid de referência para orientar a função
<code>facet\_wrap</code> de <code>ggplot2</code>. O pacote já vem
carregado com um grid do Brasil, o <code>br\_grid1</code>, mas você pode
construir e utilizar seu próprio grid. Eu, particularmente, gosto desta
representação pois é extramamente flexível e conporta uma infinidade de
gráficos (linhas, pontos, barras…) e dimenções (color, shape, size…). O
gráfico
<a href="https://italocegatta.github.io/graficos-com-dimensao-espacial-e-temporal/#fig:focos-geofacet">1</a>
está bem simples mas cumpre seu papel em facilitar a parcepção da
variação anual e dar uma noção da região espacial do estado no Brasil.
</p>
<pre class="r"><code>ggplot(estados_focos, aes(ano, focos)) + geom_line() + facet_geo(~estado, grid = br_grid1) + labs( x = &quot;Ano&quot;, y = &quot;N&#xBA; de focos de inc&#xEA;ndios&quot; ) + scale_x_continuous(breaks = 2011:2017, labels = 11:17) + scale_y_continuous(label = unit_format(unit = &quot;k&quot;, scale = 1e-3)) + theme_few()</code></pre>
<span id="fig:focos-geofacet"></span>
<img src="https://italocegatta.github.io/post/2017-07-08-graficos-com-dimensao-espacial-e-temporal_files/figure-html/focos-geofacet-1.png" alt="Representa&#xE7;&#xE3;o em painel orientado utilizando linhas." width="4000">
<p class="caption">
Figura 1: Representação em painel orientado utilizando linhas.
</p>

<p>
A segunda abordagem é relativamente simples e intuitiva. Construiremos
um mapa temático utilizando o Nº de focos como escala de cor, mas
organizado em um painel que tem como base o ano de regsitro. O gráfico
<a href="https://italocegatta.github.io/graficos-com-dimensao-espacial-e-temporal/#fig:focos-facet">2</a>
apela para a dimensão de cor e instantaneamente nos informa o estado
mais crítico. Especificamente para esta análise ele este tipo de gráfico
é muito apropriado.
</p>
<pre class="r"><code>ggplot(estados_focos) + geom_sf(aes(fill = focos), color = NA) + facet_wrap(~ano) + labs(fill = &quot;N&#xBA; de focos de inc&#xEA;ndios&quot;) + scale_fill_viridis(label = unit_format(unit = &quot;k&quot;, scale = 1e-3)) + theme_bw() + theme(legend.position = &quot;bottom&quot;, legend.justification = &quot;right&quot;) + guides(fill = guide_colorbar(barwidth = 15, title.position = &quot;top&quot;))</code></pre>
<span id="fig:focos-facet"></span>
<img src="https://italocegatta.github.io/post/2017-07-08-graficos-com-dimensao-espacial-e-temporal_files/figure-html/focos-facet-1.png" alt="Representa&#xE7;&#xE3;o em painel utilizando cores." width="4000">
<p class="caption">
Figura 2: Representação em painel utilizando cores.
</p>

<p>
E por fim, nossa terceira tentativa vai unificar os paineis do gráfico
<a href="https://italocegatta.github.io/graficos-com-dimensao-espacial-e-temporal/#fig:focos-facet">2</a>
em um gif animado. A limitação do gráfico é que muitas vezes nossos
gráficos vão para documentos estáticos como PDF e Word, inviabilizando o
gif.
</p>
<pre class="r"><code>(ggplot(estados_focos) + geom_sf(aes(fill = focos, frame = ano), color = NA) + ggtitle(&quot;Ano:&quot;) + labs(fill = &quot;N&#xBA; de focos de inc&#xEA;ndios&quot;) + scale_fill_viridis(label = unit_format(unit = &quot;k&quot;, scale = 1e-3)) + theme_bw() + theme(legend.position = &quot;bottom&quot;, legend.justification = &quot;right&quot;) + guides(fill = guide_colorbar(barwidth = 15, title.position = &quot;top&quot;)) ) %&gt;% gganimate()</code></pre>
<p>
<a href="http://imgur.com/Vfkq7hW"><img src="http://i.imgur.com/Vfkq7hW.gif"></a>
</p>
<p>
Caso tenha alguma dúvida ou sugestão sobre o post, fique à vontade para
fazer um comentário ou me contactar por Email.
</p>
<pre class="r"><code>devtools::session_info()</code></pre>
<pre><code>## setting value ## version R version 3.3.3 (2017-03-06)
## system x86_64, mingw32 ## ui RTerm ## language (EN) ## collate Portuguese_Brazil.1252 ## tz America/Sao_Paulo ## date 2017-07-08 ## ## package * version date source ## animation 2.5 2017-03-30 CRAN (R 3.3.3) ## assertthat 0.2.0 2017-04-11 CRAN (R 3.3.3) ## backports 1.1.0 2017-05-22 CRAN (R 3.3.3) ## base * 3.3.3 2017-03-06 local ## base64enc 0.1-3 2015-07-28 CRAN (R 3.3.2) ## bindr 0.1 2016-11-13 CRAN (R 3.3.3) ## bindrcpp 0.2 2017-06-17 CRAN (R 3.3.3) ## blogdown 0.0.25 2017-03-23 Github (rstudio/blogdown@1c10d16) ## bookdown 0.4 2017-05-20 CRAN (R 3.3.3) ## brmap * 0.0.2 2017-07-07 local ## colorspace 1.3-2 2016-12-14 CRAN (R 3.3.2) ## curl 2.7 2017-06-26 CRAN (R 3.3.3) ## datasets * 3.3.3 2017-03-06 local ## DBI 0.7 2017-06-18 CRAN (R 3.3.3) ## devtools 1.13.2 2017-06-02 CRAN (R 3.3.3) ## digest 0.6.12 2017-01-27 CRAN (R 3.3.2) ## dplyr * 0.7.1 2017-06-22 CRAN (R 3.3.3) ## evaluate 0.10 2016-10-11 CRAN (R 3.3.3) ## geofacet * 0.1.4 2017-06-20 CRAN (R 3.3.3) ## gganimate * 0.1.0.9000 2017-05-24 Github (dgrtwo/gganimate@bf82002) ## ggplot2 * 2.2.1.9000 2017-06-16 Github (tidyverse/ggplot2@398fc07)
## ggthemes * 3.4.0 2017-02-19 CRAN (R 3.3.3) ## glue 1.1.1 2017-06-21 CRAN (R 3.3.3) ## graphics * 3.3.3 2017-03-06 local ## grDevices * 3.3.3 2017-03-06 local ## grid 3.3.3 2017-03-06 local ## gridExtra 2.2.1 2016-02-29 CRAN (R 3.3.3) ## gtable 0.2.0 2016-02-26 CRAN (R 3.3.2) ## highr 0.6 2016-05-09 CRAN (R 3.3.3) ## hms 0.3 2016-11-22 CRAN (R 3.3.2) ## htmltools 0.3.6 2017-04-28 CRAN (R 3.3.3) ## knitr 1.16 2017-05-18 CRAN (R 3.3.3) ## labeling 0.3 2014-08-23 CRAN (R 3.3.2) ## lazyeval 0.2.0 2016-06-12 CRAN (R 3.3.2) ## magrittr 1.5 2014-11-22 CRAN (R 3.3.2) ## memoise 1.1.0 2017-04-21 CRAN (R 3.3.3) ## methods 3.3.3 2017-03-06 local ## munsell 0.4.3 2016-02-13 CRAN (R 3.3.2) ## pacman * 0.4.6 2017-05-14 CRAN (R 3.3.3) ## pkgconfig 2.0.1 2017-03-21 CRAN (R 3.3.3) ## plyr 1.8.4 2016-06-08 CRAN (R 3.3.2) ## R6 2.2.2 2017-06-17 CRAN (R 3.3.3) ## Rcpp 0.12.11 2017-05-22 CRAN (R 3.3.3) ## readr * 1.1.1 2017-05-16 CRAN (R 3.3.3) ## rlang 0.1.1 2017-05-18 CRAN (R 3.3.3) ## rmarkdown 1.6 2017-06-15 CRAN (R 3.3.3) ## rprojroot 1.2 2017-01-16 CRAN (R 3.3.3) ## scales * 0.4.1 2016-11-09 CRAN (R 3.3.2) ## sf * 0.5-1 2017-06-23 CRAN (R 3.3.3) ## stats * 3.3.3 2017-03-06 local ## stringi 1.1.5 2017-04-07 CRAN (R 3.3.3) ## stringr 1.2.0 2017-02-18 CRAN (R 3.3.2) ## tibble 1.3.3 2017-05-28 CRAN (R 3.3.3) ## tools 3.3.3 2017-03-06 local ## udunits2 0.13 2016-11-17 CRAN (R 3.3.2) ## units 0.4-5 2017-06-15 CRAN (R 3.3.3) ## utils * 3.3.3 2017-03-06 local ## viridis * 0.4.0 2017-03-27 CRAN (R 3.3.3) ## viridisLite * 0.2.0 2017-03-24 CRAN (R 3.3.3) ## withr 1.0.2 2016-06-20 CRAN (R 3.3.3) ## yaml 2.1.14 2016-11-12 CRAN (R 3.3.3)</code></pre>

