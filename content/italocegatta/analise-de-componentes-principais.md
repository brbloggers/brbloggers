+++
title = "Análise de componentes principais"
date = "2016-08-01"
categories = ["italocegatta"]
original_url = "https://italocegatta.github.io/analise-de-componentes-principais/"
+++

<p>
Quando temos dados multivariados, a análise de componentes principais
(PCA) é um recurso muito interessante e relativamente simples, em termos
de conceito teórico e interpretação prática. Para exemplificar, vamos
trabalhar com os dados climáticos de algumas cidades brasileiras. Os
dados climáticos foram compilados a partir de estações automáticas do
<a href="http://www.inmet.gov.br/portal/index.php?r=estacoes/estacoesautomaticas">INMET</a>.
</p>
<p>
No R, temos a facilidade de poder fazer o cálculo dos componentes
principais e logo em seguida poder apresentá-los em gráficos elegantes e
de fácil entendimento. O Objetivo deste post é apresentar uma rápida
demonstração de como rodar um PCA e gerar os gráficos derivados.
</p>
<pre class="r"><code>if (!require(&quot;pacman&quot;)) install.packages(&quot;pacman&quot;) pacman::p_load(readr, dplyr, ggplot2, ggrepel) pacman::p_load_gh(&quot;vqv/ggbiplot&quot;)</code></pre>
<pre class="r"><code>dados &lt;- read_csv2( &quot;https://github.com/italocegatta/italocegatta.github.io_source/raw/master/content/dados/base_clima.csv&quot; ) print(dados, n=31)</code></pre>
<pre><code>## # A tibble: 31 &#xD7; 6 ## Cidade Koppen Tmed PPT ETP DEF ## &lt;chr&gt; &lt;chr&gt; &lt;dbl&gt; &lt;dbl&gt; &lt;dbl&gt; &lt;dbl&gt; ## 1 Bom Despacho Cwa 22.64 801.8 1112.1 238.4 ## 2 Niquelandia Aw 24.63 562.2 1372.5 655.7 ## 3 Arapoti Cfb 18.48 1367.0 669.7 25.4 ## 4 Rio Verde Aw 23.34 1244.8 1196.2 425.4 ## 5 Belo Oriente Aw 22.56 1053.5 1104.8 125.4 ## 6 Guanhaes Cwa 20.62 817.6 866.0 187.9 ## 7 Eldorado do Sul Cfa 20.58 1787.4 858.7 10.7 ## 8 Sao Gabriel Cfa 20.23 1782.6 927.4 2.8 ## 9 Inhambupe As 24.23 715.2 1318.4 607.4 ## 10 Botucatu Cfb 21.94 1012.8 1030.0 184.1 ## 11 Estrela do Sul Cwa 23.41 1133.6 1208.4 206.2 ## 12 Buri Cfa 19.98 1404.4 805.0 3.6 ## 13 Inocencia Am 24.48 1019.6 1374.8 389.2 ## 14 Chapadao do Sul Am 22.62 1026.6 1097.7 325.8 ## 15 Aracruz Aw 23.89 849.4 1276.9 335.5 ## 16 Tres Lagoas Aw 25.23 943.8 1501.6 538.4 ## 17 Tres Marias Aw 22.25 811.4 1052.1 404.8 ## 18 Peixe Aw 26.29 1207.6 1630.3 674.5 ## 19 Mogi Guacu Cwa 22.40 923.6 1100.4 209.9 ## 20 Brejinho de Nazare Aw 25.88 1507.2 1563.4 495.7 ## 21 Monte Dourado Am 27.38 2528.7 1820.6 529.7 ## 22 Otacilio Costa Cfb 16.91 2092.2 547.8 0.0 ## 23 Telemaco Borba Cfa 18.48 1367.0 669.7 28.0 ## 24 Borebi Cfa 22.12 947.6 1057.8 200.9 ## 25 Coracao de Jesus As 23.91 413.4 1275.1 743.7 ## 26 Antonio Olinto Cfb 17.67 1740.2 615.8 0.0 ## 27 Tres Barras Cfb 17.30 1122.8 581.0 16.5 ## 28 Urbano Santos Aw 27.05 1437.8 1750.3 935.0 ## 29 Eunapolis Am 22.88 1419.2 1127.6 31.2 ## 30 Itagimirim Aw 25.18 490.6 1460.3 869.5 ## 31 Bocaiuva Aw 23.91 413.4 1275.5 641.8</code></pre>
<p>
A análise de componentes principais nos mostra o quanto cada grupo de
variáveis explicam a variabilidade total dados. No nosso caso, o
primeiro componente responde por 72% da variabilidade e tem efeito quase
que igual da temperatura (Tmed), evapotranspiração (ETP) e déficit
hídrico (DEF). O segundo componente é majoritariamente o efeito da chuva
(PPT). Juntos, os dois componente explicam 95% dos dados.
</p>
<pre class="r"><code>pca &lt;- select(dados, Tmed:DEF) %&gt;% princomp(cor = T) summary(pca); loadings(pca)</code></pre>
<pre><code>## Importance of components: ## Comp.1 Comp.2 Comp.3 Comp.4 ## Standard deviation 1.7007490 0.9709348 0.40137904 0.0602784852 ## Proportion of Variance 0.7231368 0.2356786 0.04027628 0.0009083739 ## Cumulative Proportion 0.7231368 0.9588153 0.99909163 1.0000000000</code></pre>
<pre><code>## ## Loadings: ## Comp.1 Comp.2 Comp.3 Comp.4 ## Tmed 0.567 -0.201 -0.437 0.668 ## PPT -0.241 -0.933 0.251 ## ETP 0.561 -0.284 -0.261 -0.732 ## DEF 0.553 0.823 ## ## Comp.1 Comp.2 Comp.3 Comp.4 ## SS loadings 1.00 1.00 1.00 1.00 ## Proportion Var 0.25 0.25 0.25 0.25 ## Cumulative Var 0.25 0.50 0.75 1.00</code></pre>
<p>
A Figura
<a href="https://italocegatta.github.io/analise-de-componentes-principais/#fig:8-pca">1</a>
ajuda-nos a visualizar a disposição das cidades em função dos dois
principais componentes. Se analisarmos por quadrantes, podemos agrupar
as cidades de clima semelhante e ainda verificar a relação com as
variáveis de clima. As setas indicam o efeito positivo ou negativo da
variável. Por exemplo, o quadrante Q4 é caracterizado por valores altos
de chuva e praticamente nenhum deficit hídrico. No oposto, temos o Q2
com baixa precipitação e alto déficit hídrico.
</p>
<pre class="r"><code>ggbiplot(pca) + geom_point() + geom_vline(xintercept = 0, size = 1.2, linetype = 6) + geom_hline(yintercept = 0, size = 1.2, linetype = 6) + geom_label_repel(aes(label = dados$Cidade), size = 3, nudge_x = .2) + annotate( &quot;text&quot;, x = c(-2, 2, 2, -2), y = c(2, 2, -2, -2), label = paste0(&quot;Q&quot;, 1:4), size = 6 ) + lims(x = c(-2,2), y = c(-2,2)) + theme_bw()</code></pre>
<span id="fig:8-pca"></span>
<img src="https://italocegatta.github.io/post/2016-08-01-analise-de-componentes-principais_files/figure-html/8-pca-1.png" alt="Representa&#xE7;&#xE3;o gr&#xE1;fica dos componentes principais." width="3200">
<p class="caption">
Figura 1: Representação gráfica dos componentes principais.
</p>

<p>
Como também temos a informação do clima Koppen, podemos colorir o
gráfico em função deste atributo (Figura
<a href="https://italocegatta.github.io/analise-de-componentes-principais/#fig:8-pca-koppen">2</a>).
</p>
<pre class="r"><code>ggbiplot(pca) + geom_point(aes(color = dados$Koppen)) + geom_vline(xintercept = 0, size = 1.2, linetype = 6) + geom_hline(yintercept = 0, size = 1.2, linetype = 6) + geom_label_repel( aes(color = dados$Koppen, label = dados$Cidade), size = 3, nudge_x = .2, show.legend = F ) + lims(x = c(-2,2), y = c(-2,2)) + scale_color_brewer(&quot;Clima Koppen&quot;, palette = &quot;Dark2&quot;) + theme_bw()+ theme(legend.position = &quot;top&quot;)</code></pre>
<span id="fig:8-pca-koppen"></span>
<img src="https://italocegatta.github.io/post/2016-08-01-analise-de-componentes-principais_files/figure-html/8-pca-koppen-1.png" alt="Representa&#xE7;&#xE3;o gr&#xE1;fica dos componentes principais com classifica&#xE7;&#xE3;o Koppen." width="3200">
<p class="caption">
Figura 2: Representação gráfica dos componentes principais com
classificação Koppen.
</p>

<p>
Caso tenha alguma dúvida ou sugestão sobre o post, fique à vontade para
fazer um comentário ou me contactar por Email.
</p>
<pre class="r"><code>devtools::session_info()</code></pre>
<pre><code>## setting value ## version R version 3.3.3 (2017-03-06) ## system x86_64, mingw32 ## ui RTerm ## language (EN) ## collate Portuguese_Brazil.1252 ## tz America/Sao_Paulo ## date 2017-04-08 ## ## package * version date source ## assertthat 0.1 2013-12-06 CRAN (R 3.3.2) ## backports 1.0.5 2017-01-18 CRAN (R 3.3.2) ## blogdown 0.0.25 2017-03-23 Github (rstudio/blogdown@1c10d16) ## bookdown 0.3.14 2017-03-23 Github (rstudio/bookdown@f427fdf) ## colorspace 1.3-2 2016-12-14 CRAN (R 3.3.2) ## curl 2.3 2016-11-24 CRAN (R 3.3.2) ## DBI 0.5-1 2016-09-10 CRAN (R 3.3.2) ## devtools 1.12.0 2016-06-24 CRAN (R 3.3.3) ## digest 0.6.12 2017-01-27 CRAN (R 3.3.2) ## dplyr * 0.5.0 2016-06-24 CRAN (R 3.3.2) ## evaluate 0.10 2016-10-11 CRAN (R 3.3.3) ## ggbiplot * 0.55 2017-03-24 Github (vqv/ggbiplot@7325e88) ## ggplot2 * 2.2.1 2016-12-30 CRAN (R 3.3.2) ## ggrepel * 0.6.5 2016-11-24 CRAN (R 3.3.3) ## gtable 0.2.0 2016-02-26 CRAN (R 3.3.2) ## highr 0.6 2016-05-09 CRAN (R 3.3.3) ## htmltools 0.3.5 2016-03-21 CRAN (R 3.3.3) ## knitr 1.15.1 2016-11-22 CRAN (R 3.3.3) ## labeling 0.3 2014-08-23 CRAN (R 3.3.2) ## lazyeval 0.2.0 2016-06-12 CRAN (R 3.3.2) ## magrittr 1.5 2014-11-22 CRAN (R 3.3.2) ## memoise 1.0.0 2016-01-29 CRAN (R 3.3.3) ## munsell 0.4.3 2016-02-13 CRAN (R 3.3.2) ## pacman * 0.4.1 2016-03-30 CRAN (R 3.3.3) ## plyr * 1.8.4 2016-06-08 CRAN (R 3.3.2) ## R6 2.2.0 2016-10-05 CRAN (R 3.3.2) ## RColorBrewer 1.1-2 2014-12-07 CRAN (R 3.3.2) ## Rcpp 0.12.9 2017-01-14 CRAN (R 3.3.2) ## readr * 1.0.0 2016-08-03 CRAN (R 3.3.2) ## rmarkdown 1.3 2016-12-21 CRAN (R 3.3.3) ## rprojroot 1.2 2017-01-16 CRAN (R 3.3.3) ## scales * 0.4.1 2016-11-09 CRAN (R 3.3.2) ## stringi 1.1.2 2016-10-01 CRAN (R 3.3.2) ## stringr 1.2.0 2017-02-18 CRAN (R 3.3.2) ## tibble 1.2 2016-08-26 CRAN (R 3.3.2) ## withr 1.0.2 2016-06-20 CRAN (R 3.3.3) ## yaml 2.1.14 2016-11-12 CRAN (R 3.3.3)</code></pre>

