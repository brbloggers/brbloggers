+++
title = "Os gráficos que explicam nossos dados (heatmap)"
date = "2016-07-09"
categories = ["italocegatta"]
original_url = "https://italocegatta.github.io/os-graficos-que-explicam-nossos-dados-heatmap/"
+++

<p>
O heatmap é um gráfico muito útil para identificar padrões,
principalmente quando temos muitas variáveis no gráfico. Essencialmente
o heatmap necessita de 3 variáveis: uma variável resposta e duas outras
variáveis para compor os eixos x e y. Não há restrição quanto ao tipo de
variável, qualquer uma delas podem ser quantitativa ou qualitativa.
Talvez esse seja o trunfo do heatmap, essa flexbilidade quanto a
natureza das variáveis nos permite utilizá-lo em diversos momentos e
substituir gráficos mais tradicionais quando eles não dão conta do
recado.
</p>
<p>
Vamos trabalhar com os dados do
<a href="http://www.projetotume.com/">Projeto TUME</a>, especificamente
com o TUME 0, plantado na Estação Experimental de Itatinga. O TUME é um
projeto muito interessante e possui informações importantes sobre
plantios de <em>Eucalyptus</em> no Brasil, vale a pena visitar o site e
aproveitar o conteúdo disponível.
</p>
<p>
Vamos primeiro carregar os dados e fazer algumas alterações. Para
auxiliar na ordem dos fatores no gráfico vamos adicionar um atributo na
coluna <code>Esp</code> informando a ordem crescente das espécies em
função da altura dominante. Em seguida, apenas por conveniência,
converti a idade dos inventários de meses para anos.
</p>
<pre class="r"><code>if (!require(&quot;pacman&quot;)) install.packages(&quot;pacman&quot;) pacman::p_load(readr, dplyr, ggplot2, ggthemes, viridis)</code></pre>
<pre class="r"><code>dados &lt;- read_csv2( &quot;https://github.com/italocegatta/italocegatta.github.io_source/raw/master/content/dados/tume0.csv&quot; ) # Cria um fator com o atributo para a vari&#xE1;vel Esp que informa a ordem crescente # das esp&#xE9;cies em fun&#xE7;&#xE3;o da altura dominante. dados &lt;- dados %&gt;% mutate( Esp = reorder(Esp, Hdom, function(x) max(x)), Idade = round(I_meses/12,1) ) dados</code></pre>
<pre><code>## # A tibble: 138 &#xD7; 16 ## N_tume Esp I_meses Parc_m2 DAPmed DAPsd Hmed Hsd Hdom ## &lt;int&gt; &lt;fctr&gt; &lt;int&gt; &lt;dbl&gt; &lt;dbl&gt; &lt;dbl&gt; &lt;dbl&gt; &lt;dbl&gt; &lt;dbl&gt; ## 1 0 Clone_1 52 1425.6 11.4 1.4 16.5 1.3 17.8 ## 2 0 Clone_2 52 1425.6 10.2 1.4 15.9 1.4 16.6 ## 3 0 Clone_3 52 1425.6 10.7 1.6 15.0 1.3 16.1 ## 4 0 E_benthamii 52 1425.6 9.0 2.7 9.8 2.3 13.0 ## 5 0 E_botryoides 52 1425.6 9.1 4.3 10.8 3.4 15.3 ## 6 0 E_camaldulensis 52 1425.6 8.3 2.9 8.3 2.3 11.8 ## 7 0 E_citriodora 52 1425.6 8.0 3.5 8.3 2.8 12.0 ## 8 0 E_cloeziana 52 928.8 7.5 2.5 7.0 2.0 9.6 ## 9 0 E_deanei 52 1425.6 10.6 2.9 11.3 1.8 13.4 ## 10 0 E_dunnii 52 1425.6 6.7 3.7 6.1 2.4 10.3 ## # ... with 128 more rows, and 7 more variables: N_fuste &lt;int&gt;, Sobr &lt;dbl&gt;, ## # G &lt;dbl&gt;, V &lt;int&gt;, IMA &lt;dbl&gt;, B &lt;int&gt;, Idade &lt;dbl&gt;</code></pre>
<p>
Se fizermos a seguinte pergunta: qual gráfico podemos utilizar para
mostrar o crescimento da altura dominantes dos materiais? Penso que a
resposta rápida seria, um gráfico de linhas! Ok, vamos tentar, veja a
Figura
<a href="https://italocegatta.github.io/os-graficos-que-explicam-nossos-dados-heatmap/#fig:6-linhas">1</a>.
</p>
<pre class="r"><code>ggplot(dados, aes(Idade, Hdom, color = Esp)) + geom_line(size=1.5) + labs(x = &quot;Idade (anos)&quot;, y = &quot;Altura dominante (m)&quot;) + theme_few() + scale_color_viridis( name = &quot;Materiais gen&#xE9;ticos&quot;, direction = -1, discrete = T ) + guides(col = guide_legend(ncol = 1, reverse = TRUE))</code></pre>
<span id="fig:6-linhas"></span>
<img src="https://italocegatta.github.io/post/2016-07-09-os-graficos-que-explicam-nossos-dados-heatmap_files/figure-html/6-linhas-1.png" alt="Aumento da altura dominante utilizando gr&#xE1;ficos de linhas." width="4000">
<p class="caption">
Figura 1: Aumento da altura dominante utilizando gráficos de linhas.
</p>

<p>
Muito bem, o gráfico consegue mostar a tendência e o padrão de
crescimento. Mas se alguém perguntar sobre o <em>Eucaluptus dunnii</em>,
capaz de demorarmos um tempo para encontrar a linha correspondente.
Capaz ainda de não conseguirmos distinguir entre uma cor e outra. Essa é
uma limitação do gráfico de linhas, quanto temos muitos fatores na
legenda fica difícil a distinção entre eles. E quando se tem uma
restrição de cor e o gráfico precisa estar em escala de cinza? Esquece!
Há quem tente utilizar símbolos ou tipos de traços para distinguir os
fatores, mas mesmo assim, não é uma tarefa fácil.
</p>
<p>
É neste momento que podemos nos aproveitar do heatmap. Agora a
intencidade de cor indica a variável resposta (Figura
<a href="https://italocegatta.github.io/os-graficos-que-explicam-nossos-dados-heatmap/#fig:6-heatmap-cont">2</a>).
Veja que fica mais fácil acompanhar o crescimento de uma espécies em
especial.
</p>
<pre class="r"><code>ggplot(dados, aes(factor(Idade), Esp, fill = Hdom)) + geom_tile() + labs(x = &quot;Idade (anos)&quot;, y = &quot;Materiais gen&#xE9;ticos&quot;) + theme_few() + scale_fill_viridis(name = &quot;Altura dominante (m)&quot;, direction = -1) + guides(col = guide_legend(reverse = TRUE))</code></pre>
<span id="fig:6-heatmap-cont"></span>
<img src="https://italocegatta.github.io/post/2016-07-09-os-graficos-que-explicam-nossos-dados-heatmap_files/figure-html/6-heatmap-cont-1.png" alt="Aumento da altura dominante utilizando heatmap com escala de cor cont&#xED;nua." width="4000">
<p class="caption">
Figura 2: Aumento da altura dominante utilizando heatmap com escala de
cor contínua.
</p>

<p>
Se for do interesse controlar a escala de cor em intervalos e classes, a
alteração é simples (Figura
<a href="https://italocegatta.github.io/os-graficos-que-explicam-nossos-dados-heatmap/#fig:6-heatmap-discr">3</a>).
Se reduzirmos as classes de cor, perdemos resolução na escala da
variável resposta. Dependendo do objetivo do gráfico isso pode ser bom
ou ruim. Neste caso, escolhi intervalos de 2 metros, pois achei mais
adequado.
</p>
<pre class="r"><code>ggplot(dados, aes(factor(Idade), Esp, fill = cut(Hdom, breaks = seq(0, 40, 2)))) + geom_tile() + labs(x = &quot;Idade (anos)&quot;, y = &quot;Materiais gen&#xE9;ticos&quot;) + theme_few() + scale_fill_viridis( name = &quot;Altura dominante (m)&quot;, discrete = T, direction = -1 ) + guides(col = guide_legend(reverse = TRUE))</code></pre>
<span id="fig:6-heatmap-discr"></span>
<img src="https://italocegatta.github.io/post/2016-07-09-os-graficos-que-explicam-nossos-dados-heatmap_files/figure-html/6-heatmap-discr-1.png" alt="Aumento da altura dominante utilizando heatmap com escala de cor discreta." width="4000">
<p class="caption">
Figura 3: Aumento da altura dominante utilizando heatmap com escala de
cor discreta.
</p>

<p>
Se quisermos deixar explícito o valor da variável resposta podemos
indicá-la no gráfico, como na Figura
<a href="https://italocegatta.github.io/os-graficos-que-explicam-nossos-dados-heatmap/#fig:6-heatmap-discr-label">4</a>.
Eu particularmente acho que fica muito poluído, mas em alguns casos pode
ser interessante.
</p>
<pre class="r"><code>ggplot(dados, aes(factor(Idade), Esp, fill = cut(Hdom, breaks = seq(0, 40, 2)))) + geom_tile() + geom_text(aes(label = Hdom), color = &quot;white&quot;) + labs(x = &quot;Idade (anos)&quot;, y = &quot;Materiais gen&#xE9;ticos&quot;) + theme_few() + scale_fill_viridis( name = &quot;Altura dominante (m)&quot;, discrete = T, direction = -1 ) + guides(col = guide_legend(reverse = TRUE))</code></pre>
<span id="fig:6-heatmap-discr-label"></span>
<img src="https://italocegatta.github.io/post/2016-07-09-os-graficos-que-explicam-nossos-dados-heatmap_files/figure-html/6-heatmap-discr-label-1.png" alt="Aumento da altura dominante utilizando heatmap com escala de cor discreta e informa&#xE7;&#xE3;o do valor no grid." width="4000">
<p class="caption">
Figura 4: Aumento da altura dominante utilizando heatmap com escala de
cor discreta e informação do valor no grid.
</p>

<p>
Note que o eixo x é uma variável temporal, entretanto o gráfico não dá a
escala entre os anos. Um observador desatento pode achar que as medições
ocorreram em intervalos regulares, mas isso não é verdade. Essa é uma
desvantagem do heatmap. Quando as variáveis dos eixos são numéricas e
representam uma escala comparativa, este atributo fica comprometido.
</p>
<p>
Caso tenha alguma dúvida ou sugestão sobre o post, fique à vontade para
fazer um comentário ou me contactar por Email.
</p>
<pre class="r"><code>devtools::session_info()</code></pre>
<pre><code>## setting value ## version R version 3.3.3 (2017-03-06) ## system x86_64, mingw32 ## ui RTerm ## language (EN) ## collate Portuguese_Brazil.1252 ## tz America/Sao_Paulo ## date 2017-04-08 ## ## package * version date source ## assertthat 0.1 2013-12-06 CRAN (R 3.3.2) ## backports 1.0.5 2017-01-18 CRAN (R 3.3.2) ## blogdown 0.0.25 2017-03-23 Github (rstudio/blogdown@1c10d16) ## bookdown 0.3.14 2017-03-23 Github (rstudio/bookdown@f427fdf) ## colorspace 1.3-2 2016-12-14 CRAN (R 3.3.2) ## curl 2.3 2016-11-24 CRAN (R 3.3.2) ## DBI 0.5-1 2016-09-10 CRAN (R 3.3.2) ## devtools 1.12.0 2016-06-24 CRAN (R 3.3.3) ## digest 0.6.12 2017-01-27 CRAN (R 3.3.2) ## dplyr * 0.5.0 2016-06-24 CRAN (R 3.3.2) ## evaluate 0.10 2016-10-11 CRAN (R 3.3.3) ## ggplot2 * 2.2.1 2016-12-30 CRAN (R 3.3.2) ## ggthemes * 3.4.0 2017-02-19 CRAN (R 3.3.3) ## gridExtra 2.2.1 2016-02-29 CRAN (R 3.3.3) ## gtable 0.2.0 2016-02-26 CRAN (R 3.3.2) ## highr 0.6 2016-05-09 CRAN (R 3.3.3) ## htmltools 0.3.5 2016-03-21 CRAN (R 3.3.3) ## knitr 1.15.1 2016-11-22 CRAN (R 3.3.3) ## labeling 0.3 2014-08-23 CRAN (R 3.3.2) ## lazyeval 0.2.0 2016-06-12 CRAN (R 3.3.2) ## magrittr 1.5 2014-11-22 CRAN (R 3.3.2) ## memoise 1.0.0 2016-01-29 CRAN (R 3.3.3) ## munsell 0.4.3 2016-02-13 CRAN (R 3.3.2) ## pacman * 0.4.1 2016-03-30 CRAN (R 3.3.3) ## plyr 1.8.4 2016-06-08 CRAN (R 3.3.2) ## R6 2.2.0 2016-10-05 CRAN (R 3.3.2) ## Rcpp 0.12.9 2017-01-14 CRAN (R 3.3.2) ## readr * 1.0.0 2016-08-03 CRAN (R 3.3.2) ## rmarkdown 1.3 2016-12-21 CRAN (R 3.3.3) ## rprojroot 1.2 2017-01-16 CRAN (R 3.3.3) ## scales 0.4.1 2016-11-09 CRAN (R 3.3.2) ## stringi 1.1.2 2016-10-01 CRAN (R 3.3.2) ## stringr 1.2.0 2017-02-18 CRAN (R 3.3.2) ## tibble 1.2 2016-08-26 CRAN (R 3.3.2) ## viridis * 0.3.4 2016-03-12 CRAN (R 3.3.3) ## withr 1.0.2 2016-06-20 CRAN (R 3.3.3) ## yaml 2.1.14 2016-11-12 CRAN (R 3.3.3)</code></pre>

