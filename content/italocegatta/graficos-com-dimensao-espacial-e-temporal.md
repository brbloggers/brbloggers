+++
title = "Gráficos com dimensão espacial e temporal"
date = "2017-06-16"
categories = ["italocegatta"]
original_url = "https://italocegatta.github.io/graficos-com-dimensao-espacial-e-temporal/"
+++

<p>
O post de hoje é sobre visualização de dados com dimensão espacial e
temporal. Eventualmente me deparo com esse desafio nas análises do dia a
dia e por isso resolvi deixar algumas alternativas para isto
resgistradas aqui. O contexto que iremos abordar está relacionado ao
banco de dados de focos de incêndios registrados pelo INPE no
<a href="http://www.inpe.br/queimadas/situacao-atual">Programa Queimadas
Monitoramento por Satélites</a>. O site é interessante e apresenta
algumas estatísticas úteis sobre as queimadas na América do Sul e
Brasil. Iremos trabalhar com a tabela que resume os focos de incêndios
por ano e Estado brasileiro.
</p>
<pre class="r"><code>if (!require(&quot;pacman&quot;)) install.packages(&quot;pacman&quot;)
pacman::p_load(readr, dplyr, ggplot2, viridis, scales, sf, geofacet, gganimate)
pacman::p_load_gh(&quot;italocegatta/brmap&quot;)</code></pre>
<p>
O primeiro passo foi copiar os dados da página e organizá-los no formato
<a href="https://italocegatta.github.io/o-conceito-tidy-data/">tidy</a>.
Poderíamos fazer uma análise exploratória dos dados, mas quero manter o
foco em algo bem pontual: como mostrar os dados brutos de uma só vez? Ou
seja, considerando a dimensão de tempo (ano), geografia (localização do
estado) e variável resposta (focos) na mesma janela gráfica. .
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
<pre class="r"><code>ggplot(estados_focos) + geom_sf(aes(fill = focos), color = NA) + facet_wrap(~ano) + scale_fill_viridis() + theme_bw()</code></pre>
<p>
<img src="https://italocegatta.github.io/post/2017-07-08-graficos-com-dimensao-espacial-e-temporal_files/figure-html/unnamed-chunk-4-1.png" width="4000">
</p>
<pre class="r"><code>ggplot(estados_focos, aes(ano, focos)) + geom_col() + facet_geo(~estado, grid = br_grid1) + labs( x = &quot;Ano&quot;, y = &quot;N&#xBA; de focos de inc&#xEA;ndios&quot; ) + scale_x_continuous(breaks = 2011:2017, labels = 11:17) + # scale_y_continuous(breaks = seq(100, 600, 200)) + theme_bw() + theme( axis.title = element_text(size = 18), panel.grid.minor.x = element_blank() )</code></pre>
<p>
<img src="https://italocegatta.github.io/post/2017-07-08-graficos-com-dimensao-espacial-e-temporal_files/figure-html/unnamed-chunk-5-1.png" width="4000">
</p>
<pre class="r"><code>(ggplot(estados_focos) + geom_sf(aes(fill = focos, frame = ano), color = NA) + ggtitle(&quot;Ano:&quot;) + scale_fill_viridis() + theme_bw() ) %&gt;% gganimate() </code></pre>

