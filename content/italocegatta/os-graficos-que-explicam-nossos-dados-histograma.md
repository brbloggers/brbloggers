+++
title = "Os gráficos que explicam nossos dados (histograma)"
date = "2016-07-15"
categories = ["italocegatta"]
original_url = "https://italocegatta.github.io/os-graficos-que-explicam-nossos-dados-histograma/"
+++

<p>
Histogramas são usados para mostrar a frequência com que uma variável
ocorre. Isto é muito interessante para mostrar qual a distribuição dos
seus dados e podemos apresentar em forma de frequência absoluta,
relativa, percentual e acumulada. Para exemplificar este tipo gráfico,
vamos utilizar os dados de inventário de uma propriedade fictícia na
Amazônia. Estes dados são meramente ilustrativos e não tem valor real. O
objetivo aqui é apresentar algumas particularidades da construção de
gráficos de barras no R e facilitar a vida de quem quer abandonar os
gráficos do Excel.
</p>
<pre class="r"><code>if (!require(&quot;pacman&quot;)) install.packages(&quot;pacman&quot;) pacman::p_load(readr, dplyr, ggplot2, ggthemes)</code></pre>
<pre class="r"><code>dados &lt;- read_csv2( &quot;https://raw.githubusercontent.com/italocegatta/italocegatta.github.io_source/master/content/dados/base_amazonia.csv&quot; ) dados</code></pre>
<pre><code>## # A tibble: 276 &#xD7; 7 ## Especie Nome_cientifico Comercial DAP HCom ## &lt;chr&gt; &lt;chr&gt; &lt;chr&gt; &lt;int&gt; &lt;int&gt; ## 1 NAO IDENTIFICADA Nao Identificada Nao 20 10 ## 2 EMBIRA Lecythidaceae Nao 34 13 ## 3 NAO IDENTIFICADA Nao Identificada Nao 18 6 ## 4 SUCUPIRA Leguminosae-Papilionoideae Nao 18 7 ## 5 CANELA Lauraceae Nao 24 10 ## 6 TACHI Lecythidaceae Sim 21 10 ## 7 ENVIRA CAJU Annonaceae Nao 20 11 ## 8 JUTAI Leguminosae-Caesalpinioideae Nao 38 13 ## 9 CATUABA Vochysiaceae Sim 57 13 ## 10 NAO IDENTIFICADA Nao Identificada Nao 22 7 ## # ... with 266 more rows, and 2 more variables: Volume &lt;dbl&gt;, QF &lt;int&gt;</code></pre>
<p>
Primeiro vamos ver qual a distribuição dos indivíduos em classes de
diâmetro. A Figura
<a href="https://italocegatta.github.io/os-graficos-que-explicam-nossos-dados-histograma/#fig:7-hist-dap">1</a>
mostra a frequência de indivíduos em classes de diâmetro de 10 cm.
Visivelmente, podemos ver que a faixa de diâmetro mais frequente está
entre 15 e 35 cm (centro de classe 20 e 30 cm, respectivamente).
</p>
<pre class="r"><code>ggplot(dados, aes(DAP)) + geom_histogram(binwidth = 10, color = &quot;white&quot;) + labs(x = &quot;Di&#xE2;metro (cm)&quot;, y = &quot;Frequ&#xEA;ncia (arv/ha)&quot;) + scale_x_continuous(breaks = seq(0, 100,10)) + theme_few()</code></pre>
<span id="fig:7-hist-dap"></span>
<img src="https://italocegatta.github.io/post/2016-07-15-os-graficos-que-explicam-nossos-dados-histograma_files/figure-html/7-hist-dap-1.png" alt="Histograma com a frequ&#xEA;ncia absoluta por classes de di&#xE2;metro." width="4000">
<p class="caption">
Figura 1: Histograma com a frequência absoluta por classes de diâmetro.
</p>

<p>
Mas, e quanto às espécies comerciais? Como elas estão distribuídas? A
Figura
<a href="https://italocegatta.github.io/os-graficos-que-explicam-nossos-dados-histograma/#fig:7-hist-dap-comerc">2</a>
faz esta diferenciação. E lembre-se, no manejo florestal da Amazônia só
é permitido a exploração de árvores com diâmetro maior que 50 cm.
</p>
<pre class="r"><code>ggplot(dados, aes(DAP, fill = Comercial)) + geom_histogram(binwidth = 10, color = &quot;white&quot;, alpha = 0.5) + labs(x = &quot;Di&#xE2;metro (cm)&quot;, y = &quot;Frequ&#xEA;ncia (arv/ha)&quot;) + scale_x_continuous(breaks = seq(0, 100,10)) + theme_few() + theme(legend.position = c(.9, .9)) + scale_fill_hue(&quot;Comercial?&quot;, labels = c(&quot;N&#xE3;o&quot;, &quot;Sim&quot;))</code></pre>
<span id="fig:7-hist-dap-comerc"></span>
<img src="https://italocegatta.github.io/post/2016-07-15-os-graficos-que-explicam-nossos-dados-histograma_files/figure-html/7-hist-dap-comerc-1.png" alt="Histograma com a frequ&#xEA;ncia absoluta por classes de di&#xE2;metro e separa&#xE7;&#xE3;o pelo fator de &#xE1;rvores de interesse comercial." width="4000">
<p class="caption">
Figura 2: Histograma com a frequência absoluta por classes de diâmetro e
separação pelo fator de árvores de interesse comercial.
</p>

<p>
Vamos melhorar um pouco mais a informação sob o ponto de vista da
exploração: qual a frequência de indivíduos que são de interesse
comercial e tem diâmetro mais que 50 cm? (Figura
<a href="https://italocegatta.github.io/os-graficos-que-explicam-nossos-dados-histograma/#fig:7-hist-vol-exp">3</a>).
</p>
<pre class="r"><code>ggplot(dados, aes(Volume, fill = DAP &gt; 50 &amp; Comercial == &quot;Sim&quot;)) + geom_histogram(binwidth = 0.5, color = &quot;white&quot;, alpha = 0.5) + labs(x = Volume~individual ~ (m^3 / arv), y = &quot;Frequ&#xEA;ncia (arv/ha)&quot;) + scale_y_continuous(breaks = seq(0, 150, 20)) + scale_x_continuous(breaks = seq(0, 10, 0.5)) + theme_few() + theme(legend.position = c(.9, .9)) + scale_fill_hue(&quot;Pode explorar?&quot;, labels = c(&quot;N&#xE3;o&quot;, &quot;Sim&quot;))</code></pre>
<span id="fig:7-hist-vol-exp"></span>
<img src="https://italocegatta.github.io/post/2016-07-15-os-graficos-que-explicam-nossos-dados-histograma_files/figure-html/7-hist-vol-exp-1.png" alt="Histograma com a frequ&#xEA;ncia absoluta por classes de volume individual e separa&#xE7;&#xE3;o pelo fator de &#xE1;rvores de interesse comercial e di&#xE2;metro maior que 50 cm." width="4000">
<p class="caption">
Figura 3: Histograma com a frequência absoluta por classes de volume
individual e separação pelo fator de árvores de interesse comercial e
diâmetro maior que 50 cm.
</p>

<p>
Se quisermos ainda apresentar o gráfico em termos das frequências
relativas, podemos fazer a seguinte modificação, conforme a Figura
<a href="https://italocegatta.github.io/os-graficos-que-explicam-nossos-dados-histograma/#fig:7-hist-vol-exp-rel">4</a>.
</p>
<pre class="r"><code>ggplot(dados, aes(Volume, fill = DAP &gt; 50 &amp; Comercial == &quot;Sim&quot;)) + geom_histogram( aes(y = ..count../sum(..count..)), binwidth = 0.5, color = &quot;white&quot;, alpha = 0.5 ) + labs(x = Volume~individual ~ (m^3 / arv), y = &quot;Frequ&#xEA;ncia (arv/ha)&quot;) + scale_y_continuous(breaks = seq(0, .5, 0.05), labels = scales::percent) + scale_x_continuous(breaks = seq(0, 10, 0.5)) + theme_few() + theme(legend.position = c(.9, .9)) + scale_fill_hue(&quot;Pode explorar?&quot;, labels = c(&quot;N&#xE3;o&quot;, &quot;Sim&quot;))</code></pre>
<span id="fig:7-hist-vol-exp-rel"></span>
<img src="https://italocegatta.github.io/post/2016-07-15-os-graficos-que-explicam-nossos-dados-histograma_files/figure-html/7-hist-vol-exp-rel-1.png" alt="Histograma com a frequ&#xEA;ncia relativa por classes de volume individual e separa&#xE7;&#xE3;o pelo fator de &#xE1;rvores de interesse comercial e di&#xE2;metro maior que 50 cm." width="4000">
<p class="caption">
Figura 4: Histograma com a frequência relativa por classes de volume
individual e separação pelo fator de árvores de interesse comercial e
diâmetro maior que 50 cm.
</p>

<p>
Caso tenha alguma dúvida ou sugestão sobre o post, fique à vontade para
fazer um comentário ou me contactar por Email.
</p>
<pre class="r"><code>devtools::session_info()</code></pre>
<pre><code>## setting value ## version R version 3.3.3 (2017-03-06) ## system x86_64, mingw32 ## ui RTerm ## language (EN) ## collate Portuguese_Brazil.1252 ## tz America/Sao_Paulo ## date 2017-04-08 ## ## package * version date source ## assertthat 0.1 2013-12-06 CRAN (R 3.3.2) ## backports 1.0.5 2017-01-18 CRAN (R 3.3.2) ## blogdown 0.0.25 2017-03-23 Github (rstudio/blogdown@1c10d16) ## bookdown 0.3.14 2017-03-23 Github (rstudio/bookdown@f427fdf) ## colorspace 1.3-2 2016-12-14 CRAN (R 3.3.2) ## curl 2.3 2016-11-24 CRAN (R 3.3.2) ## DBI 0.5-1 2016-09-10 CRAN (R 3.3.2) ## devtools 1.12.0 2016-06-24 CRAN (R 3.3.3) ## digest 0.6.12 2017-01-27 CRAN (R 3.3.2) ## dplyr * 0.5.0 2016-06-24 CRAN (R 3.3.2) ## evaluate 0.10 2016-10-11 CRAN (R 3.3.3) ## ggplot2 * 2.2.1 2016-12-30 CRAN (R 3.3.2) ## ggthemes * 3.4.0 2017-02-19 CRAN (R 3.3.3) ## gtable 0.2.0 2016-02-26 CRAN (R 3.3.2) ## highr 0.6 2016-05-09 CRAN (R 3.3.3) ## htmltools 0.3.5 2016-03-21 CRAN (R 3.3.3) ## knitr 1.15.1 2016-11-22 CRAN (R 3.3.3) ## labeling 0.3 2014-08-23 CRAN (R 3.3.2) ## lazyeval 0.2.0 2016-06-12 CRAN (R 3.3.2) ## magrittr 1.5 2014-11-22 CRAN (R 3.3.2) ## memoise 1.0.0 2016-01-29 CRAN (R 3.3.3) ## munsell 0.4.3 2016-02-13 CRAN (R 3.3.2) ## pacman * 0.4.1 2016-03-30 CRAN (R 3.3.3) ## plyr 1.8.4 2016-06-08 CRAN (R 3.3.2) ## R6 2.2.0 2016-10-05 CRAN (R 3.3.2) ## Rcpp 0.12.9 2017-01-14 CRAN (R 3.3.2) ## readr * 1.0.0 2016-08-03 CRAN (R 3.3.2) ## rmarkdown 1.3 2016-12-21 CRAN (R 3.3.3) ## rprojroot 1.2 2017-01-16 CRAN (R 3.3.3) ## scales 0.4.1 2016-11-09 CRAN (R 3.3.2) ## stringi 1.1.2 2016-10-01 CRAN (R 3.3.2) ## stringr 1.2.0 2017-02-18 CRAN (R 3.3.2) ## tibble 1.2 2016-08-26 CRAN (R 3.3.2) ## withr 1.0.2 2016-06-20 CRAN (R 3.3.3) ## yaml 2.1.14 2016-11-12 CRAN (R 3.3.3)</code></pre>

