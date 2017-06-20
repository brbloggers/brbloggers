+++
title = "Os gráficos que explicam nossos dados (barras)"
date = "2016-05-14"
categories = ["italocegatta"]
original_url = "https://italocegatta.github.io/os-graficos-que-explicam-nossos-dados-barras/"
+++

<p id="main" class="hasCover">
<article class="post">
<p>
Este é o segundo post de uma série que estou fazendo sobre tipos de
gráficos. Falamos um pouco sobre o
<a href="https://italocegatta.github.io/os-graficos-que-explicam-nossos-dados-boxplot">boxplot</a>
e agora vamos ao gráfico de barras.
</p>
<p>
Gráficos de barras são muito úteis para podermos comparar fatores.
Quando estão um ao lado do outro a comparação é feita rapidamente, já
que as barras dão a noção de escala. Normalmente as barras informam um
resumo (i. e. média, soma ou contagem), mas podemos ainda adicionar uma
barra de erro ou desvio e deixar o gráfico mais detalhado.
</p>
<p>
Continuaremos com o banco de dados apresentado no post sobre
<a href="https://italocegatta.github.io/o-conceito-tidy-data.html">tidy
data</a>.
</p>
<pre class="r"><code>if (!require(&quot;pacman&quot;)) install.packages(&quot;pacman&quot;) pacman::p_load(readr, dplyr, ggplot2, ggthemes)</code></pre>
<pre class="r"><code>dados &lt;- read_csv2( &quot;https://github.com/italocegatta/italocegatta.github.io_source/raw/master/content/dados/base_vespa.csv&quot; ) dados</code></pre>
<pre><code>## # A tibble: 2,100 &#xD7; 5 ## Tratamento Individuo Coleta Local Galhas ## &lt;chr&gt; &lt;int&gt; &lt;int&gt; &lt;chr&gt; &lt;int&gt; ## 1 Actara d1 1 1 Peciolo 1 ## 2 Actara d1 2 1 Peciolo NA ## 3 Actara d1 3 1 Peciolo NA ## 4 Actara d1 4 1 Peciolo NA ## 5 Actara d1 5 1 Peciolo NA ## 6 Actara d1 6 1 Peciolo NA ## 7 Actara d1 7 1 Peciolo NA ## 8 Actara d1 8 1 Peciolo NA ## 9 Actara d1 9 1 Peciolo NA ## 10 Actara d1 10 1 Peciolo NA ## # ... with 2,090 more rows</code></pre>
<p>
A primeira sequência de gráficos está relacionada ao total de galhas
encontradas nas mudas de cada tratamento. Nessa comparação, temos de
considerar tratamentos como fatores e os locais onde a galha foi
encontrada como níveis do fator local. Essa distinção vai nos ajuda a
escolher a melhor forma de construir um gráfico de acordo com o que
queremos mostrar.
</p>
<pre class="r"><code># seleciona apenas as Coletas de numero 5, em seguida monta um fator de # agrupamento em fun&#xE7;&#xE3;o de Tratamento. Aplica a soma de todas as # observa&#xE7;&#xF5;es (Galhas) de acordo com o fator de agrupamento. total_trat &lt;- dados %&gt;% filter(Coleta == 5) %&gt;% group_by(Tratamento) %&gt;% summarise(Galhas = sum(Galhas, na.rm=T)) total_trat</code></pre>
<pre><code>## # A tibble: 7 &#xD7; 2 ## Tratamento Galhas ## &lt;chr&gt; &lt;int&gt; ## 1 Actara d1 73 ## 2 Actara d2 57 ## 3 Actara d3 30 ## 4 Evidence d1 27 ## 5 Evidence d2 21 ## 6 Evidence d3 12 ## 7 Testemunha 77</code></pre>
<p>
Agora já podemos fazer o primeiro gráfico simples e básico (Figura
<a href="https://italocegatta.github.io/os-graficos-que-explicam-nossos-dados-barras/#fig:5-bar-basico">1</a>).
</p>
<pre class="r"><code>ggplot(total_trat, aes(Tratamento, Galhas)) + geom_bar(stat = &quot;identity&quot;) + theme_few()</code></pre>
<span id="fig:5-bar-basico"></span>
<img src="https://italocegatta.github.io/post/2016-05-14-os-graficos-que-explicam-nossos-dados-barras_files/figure-html/5-bar-basico-1.png" alt="N&#xFA;mero total de galhas de cada tratamento." width="4000">
<p class="caption">
Figura 1: Número total de galhas de cada tratamento.
</p>

<p>
Mas ainda temos a variável <code>Local</code>, certo? Podemos
apresentá-la sem muito esforço.
</p>
<pre class="r"><code>total_trat_local &lt;- dados %&gt;% filter(Coleta == 5) %&gt;% group_by(Tratamento, Local) %&gt;% summarise(Galhas = sum(Galhas, na.rm=T)) total_trat_local</code></pre>
<pre><code>## Source: local data frame [21 x 3] ## Groups: Tratamento [?] ## ## Tratamento Local Galhas ## &lt;chr&gt; &lt;chr&gt; &lt;int&gt; ## 1 Actara d1 Caule 13 ## 2 Actara d1 Nervura 19 ## 3 Actara d1 Peciolo 41 ## 4 Actara d2 Caule 10 ## 5 Actara d2 Nervura 9 ## 6 Actara d2 Peciolo 38 ## 7 Actara d3 Caule 7 ## 8 Actara d3 Nervura 6 ## 9 Actara d3 Peciolo 17 ## 10 Evidence d1 Caule 6 ## # ... with 11 more rows</code></pre>
<pre class="r"><code>ggplot(total_trat_local, aes(Tratamento, Galhas, fill = Local)) + geom_bar(stat = &quot;identity&quot;) + theme_few() + scale_fill_brewer(palette = &quot;Spectral&quot;)</code></pre>
<span id="fig:5-bar-local"></span>
<img src="https://italocegatta.github.io/post/2016-05-14-os-graficos-que-explicam-nossos-dados-barras_files/figure-html/5-bar-local-1.png" alt="N&#xFA;mero total de galhas de cada tratamento em diferentes locais - n&#xED;veis agrupados." width="4000">
<p class="caption">
Figura 2: Número total de galhas de cada tratamento em diferentes locais
- níveis agrupados.
</p>

<p>
No caso da Figura
<a href="https://italocegatta.github.io/os-graficos-que-explicam-nossos-dados-barras/#fig:5-bar-local">2</a>,
à primeira vista comparamos as barras (fatores) e depois as cores
(níveis). Podemos dar mais evidência aos níveis, transformando-os em
barras como na Figura
<a href="https://italocegatta.github.io/os-graficos-que-explicam-nossos-dados-barras/#fig:5-bar-local-dodge">3</a>.
</p>
<pre class="r"><code>ggplot(total_trat_local, aes(Tratamento, Galhas, fill = Local)) + geom_bar(stat = &quot;identity&quot;, position = &quot;dodge&quot;) + theme_few() + scale_fill_brewer(palette = &quot;Spectral&quot;)</code></pre>
<span id="fig:5-bar-local-dodge"></span>
<img src="https://italocegatta.github.io/post/2016-05-14-os-graficos-que-explicam-nossos-dados-barras_files/figure-html/5-bar-local-dodge-1.png" alt="N&#xFA;mero total de galhas de cada tratamento em diferentes locais - n&#xED;veis lado a lados." width="4000">
<p class="caption">
Figura 3: Número total de galhas de cada tratamento em diferentes locais
- níveis lado a lados.
</p>

<p>
Como alternativa, podemos subdividir os níveis em painéis e deixar o
gráfico mais balanceado, ou seja, sem concentrar a informação em fatores
ou níveis (Figura
<a href="https://italocegatta.github.io/os-graficos-que-explicam-nossos-dados-barras/#fig:5-bar-local-facet">4</a>).
</p>
<pre class="r"><code>ggplot(total_trat_local, aes(Tratamento, Galhas )) + geom_bar(stat = &quot;identity&quot;, position = &quot;dodge&quot;) + facet_wrap(~Local) + theme_few() + theme(axis.text.x = element_text(angle = 30, hjust = 0.5, vjust = 0.5))</code></pre>
<span id="fig:5-bar-local-facet"></span>
<img src="https://italocegatta.github.io/post/2016-05-14-os-graficos-que-explicam-nossos-dados-barras_files/figure-html/5-bar-local-facet-1.png" alt="N&#xFA;mero total de galhas de cada tratamento em diferentes locais - n&#xED;veis em painel." width="4000">
<p class="caption">
Figura 4: Número total de galhas de cada tratamento em diferentes locais
- níveis em painel.
</p>

<p>
Note que nos 3 gráficos anteriores o banco de dados para formação do
gráfico é o mesmo, mas cada um dá ênfase em um aspecto diferente. A
parte boa é que podemos modificá-los de acordo com o nosso interesse de
uma forma rápida e bem simples.
</p>

<p>
Se quisermos adicionar o valor de cada nível ou fator na barra, temos de
alterar o banco de dados para que ele coincida com o que queremos
mostrar.
</p>
<p>
Para a Figura
<a href="https://italocegatta.github.io/os-graficos-que-explicam-nossos-dados-barras/#fig:5-bar-basico-annot">5</a>,
modificamos apenas o código do gráfico.
</p>
<pre class="r"><code>ggplot(total_trat, aes(Tratamento, Galhas)) + geom_bar(stat = &quot;identity&quot;) + geom_text(aes(label = Galhas), size = 6, vjust = -0.2) + theme_few()</code></pre>
<span id="fig:5-bar-basico-annot"></span>
<img src="https://italocegatta.github.io/post/2016-05-14-os-graficos-que-explicam-nossos-dados-barras_files/figure-html/5-bar-basico-annot-1.png" alt="N&#xFA;mero total de galhas de cada tratamento com o valor na respectiva barra." width="4000">
<p class="caption">
Figura 5: Número total de galhas de cada tratamento com o valor na
respectiva barra.
</p>

<p>
Para a próxima figura temos de criar uma coluna que informa a posição em
que o valor deve ficar no eixo y, uma vez que ele deve estar exatamente
no centro do respectivo compartimento da barra. Como resultado temos a
Figura
<a href="https://italocegatta.github.io/os-graficos-que-explicam-nossos-dados-barras/#fig:5-bar-local-annot">6</a>.
</p>
<pre class="r"><code># Cria uma nova coluna que contem a posi&#xE7;&#xE3;o no eixo y que corresponde ao centro # da barra. Esta posi&#xE7;&#xE3;o correnponde ao local onde o label de cada barra # ser&#xE1; mostrado total_trat_local_y &lt;- total_trat_local %&gt;% mutate(Galhas_y = replace(cumsum(Galhas) - (0.5*Galhas), Galhas == 0, NA)) ggplot(total_trat_local_y, aes(Tratamento, Galhas, fill = Local)) + geom_bar(stat = &quot;identity&quot;) + geom_text(aes(label = Galhas, y = Galhas_y)) + theme_few() + scale_fill_brewer(palette = &quot;Spectral&quot;)</code></pre>
<span id="fig:5-bar-local-annot"></span>
<img src="https://italocegatta.github.io/post/2016-05-14-os-graficos-que-explicam-nossos-dados-barras_files/figure-html/5-bar-local-annot-1.png" alt="N&#xFA;mero total de galhas de cada tratamento em diferentes locais com o valor da respectiva barra - n&#xED;veis agrupados." width="4000">
<p class="caption">
Figura 6: Número total de galhas de cada tratamento em diferentes locais
com o valor da respectiva barra - níveis agrupados.
</p>

<p>
As Figuras
<a href="https://italocegatta.github.io/os-graficos-que-explicam-nossos-dados-barras/#fig:5-bar-local-dodge-annot">7</a>
e
<a href="https://italocegatta.github.io/os-graficos-que-explicam-nossos-dados-barras/#fig:5-bar-local-facet-annot">8</a>
foram criadas apenas alterando o código do gráfico.
</p>
<pre class="r"><code>ggplot(total_trat_local, aes(Tratamento, Galhas, fill = Local)) + geom_bar(stat = &quot;identity&quot;, position = &quot;dodge&quot;) + geom_text(aes(label = Galhas), position = position_dodge(width=0.9), vjust = -0.2) + theme_few() + scale_fill_brewer(palette = &quot;Spectral&quot;)</code></pre>
<span id="fig:5-bar-local-dodge-annot"></span>
<img src="https://italocegatta.github.io/post/2016-05-14-os-graficos-que-explicam-nossos-dados-barras_files/figure-html/5-bar-local-dodge-annot-1.png" alt="N&#xFA;mero total de galhas de cada tratamento em diferentes locais com o valor da respectiva barra - n&#xED;veis lado a lados." width="4000">
<p class="caption">
Figura 7: Número total de galhas de cada tratamento em diferentes locais
com o valor da respectiva barra - níveis lado a lados.
</p>

<pre class="r"><code>ggplot(total_trat_local, aes(Tratamento, Galhas )) + geom_bar(stat = &quot;identity&quot;, position = &quot;dodge&quot;) + geom_text(aes(label = Galhas), vjust = -0.2) + facet_wrap(~Local) + theme_few() + theme(axis.text.x = element_text(angle = 30, hjust = 0.5, vjust = 0.5))</code></pre>
<span id="fig:5-bar-local-facet-annot"></span>
<img src="https://italocegatta.github.io/post/2016-05-14-os-graficos-que-explicam-nossos-dados-barras_files/figure-html/5-bar-local-facet-annot-1.png" alt="N&#xFA;mero total de galhas de cada tratamento em diferentes locais com o valor da respectiva barra - n&#xED;veis em painel." width="4000">
<p class="caption">
Figura 8: Número total de galhas de cada tratamento em diferentes locais
com o valor da respectiva barra - níveis em painel.
</p>

<p>
Uma outra informação interessante para o gráfico de barras é a barra de
erro ou desvio. Com ela, além de informarmos o valor que queremos,
também informamos uma medida de dispersão associada a esse valor. Nos
gráficos anteriores apresentei o total de galhas por tratamento e local.
Não faz sentido, nesse caso, colocar uma barra de desvio, pois a soma
não é uma medida de posição. Portanto, vamos resumir novamente os dados
em função da média e acrescentar o erro padrão da média.
</p>
<pre class="r"><code># Seleciona apenas as Coletas de numero 5, em seguida calcula a m&#xE9;dia e o # desvio padr&#xE3;o de cada Tratamento. media_trat_desv &lt;- dados %&gt;% filter(Coleta == 5) %&gt;% group_by(Tratamento) %&gt;% summarise(desv = sd(Galhas, na.rm=T)/sqrt(n()), Galhas = mean(Galhas, na.rm=T)) media_trat_desv</code></pre>
<pre><code>## # A tibble: 7 &#xD7; 3 ## Tratamento desv Galhas ## &lt;chr&gt; &lt;dbl&gt; &lt;dbl&gt; ## 1 Actara d1 0.4799351 4.055556 ## 2 Actara d2 0.4893473 3.352941 ## 3 Actara d3 0.1331730 2.307692 ## 4 Evidence d1 0.5889188 3.857143 ## 5 Evidence d2 0.2667039 2.625000 ## 6 Evidence d3 0.1632993 2.000000 ## 7 Testemunha 0.3601529 3.347826</code></pre>
<p>
Após criar o <em>data frame</em> com o desvio, a Figura
<a href="https://italocegatta.github.io/os-graficos-que-explicam-nossos-dados-barras/#fig:5-bar-basico-desv">9</a>
é facilmente criada com o código abaixo.
</p>
<pre class="r"><code>ggplot(media_trat_desv, aes(Tratamento, Galhas)) + geom_bar(stat = &quot;identity&quot;) + geom_errorbar(aes(ymin = Galhas - desv, ymax = Galhas + desv), width = 0.4) + theme_few()</code></pre>
<span id="fig:5-bar-basico-desv"></span>
<img src="https://italocegatta.github.io/post/2016-05-14-os-graficos-que-explicam-nossos-dados-barras_files/figure-html/5-bar-basico-desv-1.png" alt="N&#xFA;mero total de galhas de cada tratamento com barra de desvio." width="4000">
<p class="caption">
Figura 9: Número total de galhas de cada tratamento com barra de desvio.
</p>

<p>
No caso das Figuras
<a href="https://italocegatta.github.io/os-graficos-que-explicam-nossos-dados-barras/#fig:5-bar-local-dodge-desv">10</a>
e
<a href="https://italocegatta.github.io/os-graficos-que-explicam-nossos-dados-barras/#fig:5-bar-local-facet-desv">11</a>,
precisamos dados dados agrupados por <code>Tratamento</code> e
<code>Local</code>. O código para o gráfico é muito semelhante aos
anteriores. Em alguns tratamentos há somente um indivíduo indivídio com
contagem de galhas. Nesta situação não há barra de desvio.
</p>
<pre class="r"><code># Seleciona apenas as Coletas de numero 5, em seguida calcula a mediana e o # desvio padr&#xE3;o em fun&#xE7;&#xE3;o de cada Trtatamento e Local. mediana_trat_local_desv &lt;- dados %&gt;% filter(Coleta == 5) %&gt;% group_by(Tratamento, Local) %&gt;% summarise(desv = sd(Galhas, na.rm=T)/sqrt(n()), Galhas = median(Galhas, na.rm=T)) mediana_trat_local_desv</code></pre>
<pre><code>## Source: local data frame [21 x 4] ## Groups: Tratamento [?] ## ## Tratamento Local desv Galhas ## &lt;chr&gt; &lt;chr&gt; &lt;dbl&gt; &lt;dbl&gt; ## 1 Actara d1 Caule 0.3291403 2 ## 2 Actara d1 Nervura 0.8276473 3 ## 3 Actara d1 Peciolo 1.0200373 4 ## 4 Actara d2 Caule 0.2708013 1 ## 5 Actara d2 Nervura 0.2813657 2 ## 6 Actara d2 Peciolo 1.1751393 4 ## 7 Actara d3 Caule 0.1118034 2 ## 8 Actara d3 Nervura 0.0000000 2 ## 9 Actara d3 Peciolo 0.2972092 3 ## 10 Evidence d1 Caule 0.2236068 2 ## # ... with 11 more rows</code></pre>
<pre class="r"><code>ggplot(mediana_trat_local_desv, aes(Tratamento, Galhas, fill = Local)) + geom_bar(stat = &quot;identity&quot;, position = &quot;dodge&quot;) + geom_errorbar(aes(ymin = Galhas - desv, ymax = Galhas + desv), position = position_dodge(width=0.9), width = 0.4) + theme_few() + scale_fill_brewer(palette = &quot;Spectral&quot;)</code></pre>
<span id="fig:5-bar-local-dodge-desv"></span>
<img src="https://italocegatta.github.io/post/2016-05-14-os-graficos-que-explicam-nossos-dados-barras_files/figure-html/5-bar-local-dodge-desv-1.png" alt="N&#xFA;mero total de galhas de cada tratamento em diferentes locais com barra de desvio - n&#xED;veis lado a lados." width="4000">
<p class="caption">
Figura 10: Número total de galhas de cada tratamento em diferentes
locais com barra de desvio - níveis lado a lados.
</p>

<pre class="r"><code>ggplot(mediana_trat_local_desv, aes(Tratamento, Galhas )) + geom_bar(stat = &quot;identity&quot;, position = &quot;dodge&quot;) + geom_errorbar(aes(ymin = Galhas - desv, ymax = Galhas + desv), width = 0.4) + facet_wrap(~Local) + theme_few() + theme(axis.text.x = element_text(angle = 30, hjust = 0.5, vjust = 0.5))</code></pre>
<span id="fig:5-bar-local-facet-desv"></span>
<img src="https://italocegatta.github.io/post/2016-05-14-os-graficos-que-explicam-nossos-dados-barras_files/figure-html/5-bar-local-facet-desv-1.png" alt="N&#xFA;mero total de galhas de cada tratamento em diferentes locais com barra de desvio - n&#xED;veis em painel." width="4000">
<p class="caption">
Figura 11: Número total de galhas de cada tratamento em diferentes
locais com barra de desvio - níveis em painel.
</p>

<p>
Caso tenha alguma dúvida ou sugestão sobre o post, fique à vontade para
fazer um comentário ou me contactar por Email.
</p>
<pre class="r"><code>devtools::session_info()</code></pre>
<pre><code>## setting value ## version R version 3.3.3 (2017-03-06) ## system x86_64, mingw32 ## ui RTerm ## language (EN) ## collate Portuguese_Brazil.1252 ## tz America/Sao_Paulo ## date 2017-04-08 ## ## package * version date source ## assertthat 0.1 2013-12-06 CRAN (R 3.3.2) ## backports 1.0.5 2017-01-18 CRAN (R 3.3.2) ## blogdown 0.0.25 2017-03-23 Github (rstudio/blogdown@1c10d16) ## bookdown 0.3.14 2017-03-23 Github (rstudio/bookdown@f427fdf) ## colorspace 1.3-2 2016-12-14 CRAN (R 3.3.2) ## curl 2.3 2016-11-24 CRAN (R 3.3.2) ## DBI 0.5-1 2016-09-10 CRAN (R 3.3.2) ## devtools 1.12.0 2016-06-24 CRAN (R 3.3.3) ## digest 0.6.12 2017-01-27 CRAN (R 3.3.2) ## dplyr * 0.5.0 2016-06-24 CRAN (R 3.3.2) ## evaluate 0.10 2016-10-11 CRAN (R 3.3.3) ## ggplot2 * 2.2.1 2016-12-30 CRAN (R 3.3.2) ## ggthemes * 3.4.0 2017-02-19 CRAN (R 3.3.3) ## gtable 0.2.0 2016-02-26 CRAN (R 3.3.2) ## highr 0.6 2016-05-09 CRAN (R 3.3.3) ## htmltools 0.3.5 2016-03-21 CRAN (R 3.3.3) ## knitr 1.15.1 2016-11-22 CRAN (R 3.3.3) ## labeling 0.3 2014-08-23 CRAN (R 3.3.2) ## lazyeval 0.2.0 2016-06-12 CRAN (R 3.3.2) ## magrittr 1.5 2014-11-22 CRAN (R 3.3.2) ## memoise 1.0.0 2016-01-29 CRAN (R 3.3.3) ## munsell 0.4.3 2016-02-13 CRAN (R 3.3.2) ## pacman * 0.4.1 2016-03-30 CRAN (R 3.3.3) ## plyr 1.8.4 2016-06-08 CRAN (R 3.3.2) ## R6 2.2.0 2016-10-05 CRAN (R 3.3.2) ## RColorBrewer 1.1-2 2014-12-07 CRAN (R 3.3.2) ## Rcpp 0.12.9 2017-01-14 CRAN (R 3.3.2) ## readr * 1.0.0 2016-08-03 CRAN (R 3.3.2) ## rmarkdown 1.3 2016-12-21 CRAN (R 3.3.3) ## rprojroot 1.2 2017-01-16 CRAN (R 3.3.3) ## scales 0.4.1 2016-11-09 CRAN (R 3.3.2) ## stringi 1.1.2 2016-10-01 CRAN (R 3.3.2) ## stringr 1.2.0 2017-02-18 CRAN (R 3.3.2) ## tibble 1.2 2016-08-26 CRAN (R 3.3.2) ## withr 1.0.2 2016-06-20 CRAN (R 3.3.3) ## yaml 2.1.14 2016-11-12 CRAN (R 3.3.3)</code></pre>

</article>
<footer id="footer" class="main-content-wrap">
<span class="copyrights"> © 2017 Ítalo Cegatta. All Rights Reserved
</span>
</footer>
</p>

<img id="about-card-picture" src="http://i.imgur.com/9MOS3vs.png" alt="Foto do autor">
<p id="about-card-bio">
R, Floresta e Data Science
</p>
<p id="about-card-job">
<i class="fa fa-briefcase"></i> <br> Suzano Papel e celulose
</p>
<p id="about-card-location">
<i class="fa fa-map-marker"></i> <br> Itapetininga-SP
</p>

