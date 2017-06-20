+++
title = "Os gráficos que explicam nossos dados (boxplot)"
date = "2016-05-06"
categories = ["italocegatta"]
original_url = "https://italocegatta.github.io/os-graficos-que-explicam-nossos-dados-boxplot/"
+++

<p>
Nossos dados merecem ser apresentados de forma clara, atraente e
inspiradora. Não há nada mais frustrante que dar duro no campo para
coletar os dados e depois apresentá-los numa simples tabela de resumos.
Podemos e devemos fazer mais, certo?
</p>
<p>
Vou começar agora uma série de posts sobre tipos de gráficos. Como disse
no primeiro post desse
<a href="https://italocegatta.github.io/sobre-esse-blog.html">blog</a>,
minha intenção é documentar os scripts que escrevi durante a graduação,
portanto os gráficos que vou apresentar se resumem aos que tive de fazer
por conta de alguma demanda específica.
</p>
<p>
Para iniciar, escolhi o gráfico boxplot. É um gráfico muito útil para
entender a variabilidade das nossas observações. No boxplot temos 5
informações básicas: valor mínimo, primeiro quartil, mediana, terceiro
quartil e valor máximo. Há ainda a notificação de <em>outliers</em>,
quando a observação é maior ou menor que 1,5 vezes a distância
interquartílica.
</p>
<p>
Vamos trabalhar com os dados que apresentei no post anterior sobre
<a href="https://italocegatta.github.io/o-conceito-tidy-data.html">tidy
data</a>.
</p>
<pre class="r"><code>library(pacman) p_load(readr, dplyr, tidyr, ggplot2, ggthemes)</code></pre>
<pre class="r"><code>dados &lt;- read_csv2( &quot;https://raw.githubusercontent.com/italocegatta/italocegatta.github.io_source/master/content/dados/base_vespa.csv&quot; ) dados</code></pre>
<pre><code>## # A tibble: 2,100 &#xD7; 5 ## Tratamento Individuo Coleta Local Galhas ## &lt;chr&gt; &lt;int&gt; &lt;int&gt; &lt;chr&gt; &lt;int&gt; ## 1 Actara d1 1 1 Peciolo 1 ## 2 Actara d1 2 1 Peciolo NA ## 3 Actara d1 3 1 Peciolo NA ## 4 Actara d1 4 1 Peciolo NA ## 5 Actara d1 5 1 Peciolo NA ## 6 Actara d1 6 1 Peciolo NA ## 7 Actara d1 7 1 Peciolo NA ## 8 Actara d1 8 1 Peciolo NA ## 9 Actara d1 9 1 Peciolo NA ## 10 Actara d1 10 1 Peciolo NA ## # ... with 2,090 more rows</code></pre>
<p>
Primeiro vamos processar os dados da última medição (Coleta 5) para
verificar o nº total de galhas de cada tratamento, desconsiderando o
local da galha. Nesse caso estou considerando apenas as mudas que foram
atacadas e tiveram o desenvolvimento de galhas.
</p>
<pre class="r"><code># seleciona apenas as Coletas de numero 5, em seguida monta um fator de # agrupamento em fun&#xE7;&#xE3;o de Tratamento e Individuo. Aplica a soma de todas as # observa&#xE7;&#xF5;es (Galhas) de acordo com o fator de agrupamento. Troca os valores # 0 (quando n&#xE3;o h&#xE1; galhas) por NA. total &lt;- dados %&gt;% filter(Coleta == 5) %&gt;% group_by(Tratamento, Individuo) %&gt;% summarise(Galhas = sum(Galhas, na.rm=T)) %&gt;% mutate(Galhas = replace(Galhas, Galhas == 0, NA)) total</code></pre>
<pre><code>## Source: local data frame [140 x 3] ## Groups: Tratamento [7] ## ## Tratamento Individuo Galhas ## &lt;chr&gt; &lt;int&gt; &lt;int&gt; ## 1 Actara d1 1 11 ## 2 Actara d1 2 NA ## 3 Actara d1 3 4 ## 4 Actara d1 4 NA ## 5 Actara d1 5 NA ## 6 Actara d1 6 NA ## 7 Actara d1 7 30 ## 8 Actara d1 8 NA ## 9 Actara d1 9 NA ## 10 Actara d1 10 NA ## # ... with 130 more rows</code></pre>
<p>
O boxplot é um gráfico unidimensional, ou seja, precisamos de apenas uma
variável para construí-lo. Entretanto, podemos usar variáveis
categóricas para servir de agrupamento e replicar o gráfico para todos
os níveis da variável. Por exemplo, no nosso banco de dados temos
<code>Galhas</code> como variável quantitativa e
<code>Tratamento</code>, <code>Coleta</code> e <code>Local</code> como
variável qualitativa.
</p>
<pre class="r"><code>ggplot(total, aes(&quot;Total&quot;, Galhas)) + geom_boxplot() + theme_few()</code></pre>
<span id="fig:4-boxplot-total"></span>
<img src="https://italocegatta.github.io/post/2016-05-06-os-graficos-que-explicam-nossos-dados-boxplot_files/figure-html/4-boxplot-total-1.png" alt="Boxplot que mostra o n&#xBA; de galhas de todos os tratamentos." width="4000">
<p class="caption">
Figura 1: Boxplot que mostra o nº de galhas de todos os tratamentos.
</p>

<p>
A Figura
<a href="https://italocegatta.github.io/os-graficos-que-explicam-nossos-dados-boxplot/#fig:4-boxplot-total">1</a>
dá uma visão geral de todas as observações em um único boxplot, mas não
nos explica muita coisa. No caso da Figura
<a href="https://italocegatta.github.io/os-graficos-que-explicam-nossos-dados-boxplot/#fig:4-boxplot-trat">2</a>,
<code>Tratamento</code> tratamento é uma variável categórica e nos
permite subdividir os boxplots para todos os níveis e assim podemos
compará-los.
</p>
<pre class="r"><code>ggplot(total, aes(Tratamento, Galhas)) + geom_boxplot() + theme_few()</code></pre>
<span id="fig:4-boxplot-trat"></span>
<img src="https://italocegatta.github.io/post/2016-05-06-os-graficos-que-explicam-nossos-dados-boxplot_files/figure-html/4-boxplot-trat-1.png" alt="Boxplot que mostra o n&#xBA; de galhas em fun&#xE7;&#xE3;o de cada tratamento." width="4000">
<p class="caption">
Figura 2: Boxplot que mostra o nº de galhas em função de cada
tratamento.
</p>

<p>
Note que no tratamento <em>Actara d1</em>, há um indivíduo discrepante
(<em>outlier</em>) que se destaca com 30 galhas. Note também a grande
variabilidade entre os tratamentos, muito comum em experimentos
envolvendo insetos. Normalmente o coeficiente de variação é extremamente
alto e dificilmente há homogeneidade de variância. Um comentário
interessante sobre o boxplot é que a caixa, valores entre o 1º e 3º
quartil, corresponde a 50% das observações.
</p>
<p>
Podemos também avaliar a variabilidade do nº de galhas por local. Para
isso vamos incluir a variável <code>Local</code> no agrupamento (Figura
<a href="https://italocegatta.github.io/os-graficos-que-explicam-nossos-dados-boxplot/#fig:4-boxplot-local">3</a>).
</p>
<pre class="r"><code># Adiciona mais um fator de agrupamento para o resumo. Nesse caso cada # indiv&#xED;duo ter&#xE1; o n&#xBA; de galhas explicito em cada local. local &lt;- dados %&gt;% filter(Coleta == 5) %&gt;% group_by(Tratamento, Individuo, Local) %&gt;% summarise(Galhas = sum(Galhas, na.rm=T)) %&gt;% mutate(Galhas = replace(Galhas, Galhas == 0, NA)) local</code></pre>
<pre><code>## Source: local data frame [420 x 4] ## Groups: Tratamento, Individuo [140] ## ## Tratamento Individuo Local Galhas ## &lt;chr&gt; &lt;int&gt; &lt;chr&gt; &lt;int&gt; ## 1 Actara d1 1 Caule 2 ## 2 Actara d1 1 Nervura 3 ## 3 Actara d1 1 Peciolo 6 ## 4 Actara d1 2 Caule NA ## 5 Actara d1 2 Nervura NA ## 6 Actara d1 2 Peciolo NA ## 7 Actara d1 3 Caule 1 ## 8 Actara d1 3 Nervura 1 ## 9 Actara d1 3 Peciolo 2 ## 10 Actara d1 4 Caule NA ## # ... with 410 more rows</code></pre>
<pre class="r"><code>ggplot(local, aes(Tratamento, Galhas, fill = Local)) + geom_boxplot() + theme_few() + scale_fill_brewer(palette = &quot;Spectral&quot;)</code></pre>
<span id="fig:4-boxplot-local"></span>
<img src="https://italocegatta.github.io/post/2016-05-06-os-graficos-que-explicam-nossos-dados-boxplot_files/figure-html/4-boxplot-local-1.png" alt="Boxplot que mostra o n&#xBA; de galhas por local e tratamento." width="4000">
<p class="caption">
Figura 3: Boxplot que mostra o nº de galhas por local e tratamento.
</p>

<p>
Uma outra perspectiva é avaliar a evolução do total de galhas por
coleta. Para isto basta incluir a variável <code>Coleta</code> no
agrupamento (Figura
<a href="https://italocegatta.github.io/os-graficos-que-explicam-nossos-dados-boxplot/#fig:4-boxplot-coleta">4</a>).
Para facilitar a visualização, vou excluir a primeira coleta. Podemos
ainda adicionar os pontos que representam as observações para poder
identificar quantas observações tem cada tratamento.
</p>
<pre class="r"><code>total_coleta &lt;- dados %&gt;% filter(Coleta != 1 ) %&gt;% group_by(Tratamento, Coleta, Individuo) %&gt;% summarise(Galhas = sum(Galhas, na.rm=T)) %&gt;% mutate(Galhas = replace(Galhas, Galhas == 0, NA)) total_coleta</code></pre>
<pre><code>## Source: local data frame [560 x 4] ## Groups: Tratamento, Coleta [28] ## ## Tratamento Coleta Individuo Galhas ## &lt;chr&gt; &lt;int&gt; &lt;int&gt; &lt;int&gt; ## 1 Actara d1 2 1 3 ## 2 Actara d1 2 2 NA ## 3 Actara d1 2 3 NA ## 4 Actara d1 2 4 NA ## 5 Actara d1 2 5 NA ## 6 Actara d1 2 6 NA ## 7 Actara d1 2 7 2 ## 8 Actara d1 2 8 NA ## 9 Actara d1 2 9 NA ## 10 Actara d1 2 10 NA ## # ... with 550 more rows</code></pre>
<pre class="r"><code>ggplot(total_coleta, aes(Tratamento, Galhas)) + geom_boxplot() + geom_jitter(alpha = 0.4) + facet_wrap(~ Coleta, labeller = label_both) + theme_few() + theme(axis.text.x = element_text(angle = 30, hjust = 0.5, vjust = 0.5))</code></pre>
<span id="fig:4-boxplot-coleta"></span>
<img src="https://italocegatta.github.io/post/2016-05-06-os-graficos-que-explicam-nossos-dados-boxplot_files/figure-html/4-boxplot-coleta-1.png" alt="Boxplot que mostra a dispers&#xE3;o do total de galhas por tratamento e coletas." width="4000">
<p class="caption">
Figura 4: Boxplot que mostra a dispersão do total de galhas por
tratamento e coletas.
</p>

<p>
É importante destacar que o gráfico da Figura
<a href="https://italocegatta.github.io/os-graficos-que-explicam-nossos-dados-boxplot/#fig:4-boxplot-coleta">4</a>
não é adequado para esse tipo de informação. Nesse caso seria mais
interessante um gráfico de linhas em que cada linha representa um
tratamento (veremos esse gráfico em um futuro post).
</p>
<p>
Caso tenha alguma dúvida ou sugestão sobre o post, fique à vontade para
fazer um comentário ou me contactar por Email.
</p>
<pre class="r"><code>devtools::session_info()</code></pre>
<pre><code>## setting value ## version R version 3.3.3 (2017-03-06) ## system x86_64, mingw32 ## ui RTerm ## language (EN) ## collate Portuguese_Brazil.1252 ## tz America/Sao_Paulo ## date 2017-04-30 ## ## package * version date source ## assertthat 0.2.0 2017-04-11 CRAN (R 3.3.3) ## backports 1.0.5 2017-01-18 CRAN (R 3.3.2) ## blogdown 0.0.25 2017-03-23 Github (rstudio/blogdown@1c10d16) ## bookdown 0.3.14 2017-03-23 Github (rstudio/bookdown@f427fdf) ## colorspace 1.3-2 2016-12-14 CRAN (R 3.3.2) ## curl 2.6 2017-04-27 CRAN (R 3.3.3) ## DBI 0.6-1 2017-04-01 CRAN (R 3.3.3) ## devtools 1.12.0 2016-06-24 CRAN (R 3.3.3) ## digest 0.6.12 2017-01-27 CRAN (R 3.3.2) ## dplyr * 0.5.0 2016-06-24 CRAN (R 3.3.2) ## evaluate 0.10 2016-10-11 CRAN (R 3.3.3) ## ggplot2 * 2.2.1 2016-12-30 CRAN (R 3.3.2) ## ggthemes * 3.4.0 2017-02-19 CRAN (R 3.3.3) ## gtable 0.2.0 2016-02-26 CRAN (R 3.3.2) ## highr 0.6 2016-05-09 CRAN (R 3.3.3) ## hms 0.3 2016-11-22 CRAN (R 3.3.2) ## htmltools 0.3.6 2017-04-28 CRAN (R 3.3.3) ## knitr 1.15.1 2016-11-22 CRAN (R 3.3.3) ## labeling 0.3 2014-08-23 CRAN (R 3.3.2) ## lazyeval 0.2.0 2016-06-12 CRAN (R 3.3.2) ## magrittr 1.5 2014-11-22 CRAN (R 3.3.2) ## memoise 1.1.0 2017-04-21 CRAN (R 3.3.3) ## munsell 0.4.3 2016-02-13 CRAN (R 3.3.2) ## pacman * 0.4.1 2016-03-30 CRAN (R 3.3.3) ## plyr 1.8.4 2016-06-08 CRAN (R 3.3.2) ## R6 2.2.0 2016-10-05 CRAN (R 3.3.2) ## RColorBrewer 1.1-2 2014-12-07 CRAN (R 3.3.2) ## Rcpp 0.12.10 2017-03-19 CRAN (R 3.3.3) ## readr * 1.1.0 2017-03-22 CRAN (R 3.3.3) ## rmarkdown 1.5 2017-04-26 CRAN (R 3.3.3) ## rprojroot 1.2 2017-01-16 CRAN (R 3.3.3) ## scales 0.4.1 2016-11-09 CRAN (R 3.3.2) ## stringi 1.1.5 2017-04-07 CRAN (R 3.3.3) ## stringr 1.2.0 2017-02-18 CRAN (R 3.3.2) ## tibble 1.3.0 2017-04-01 CRAN (R 3.3.3) ## tidyr * 0.6.1 2017-01-10 CRAN (R 3.3.2) ## withr 1.0.2 2016-06-20 CRAN (R 3.3.3) ## yaml 2.1.14 2016-11-12 CRAN (R 3.3.3)</code></pre>

