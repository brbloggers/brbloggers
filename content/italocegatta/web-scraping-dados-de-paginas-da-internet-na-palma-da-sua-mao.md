+++
title = "Web scraping: dados de páginas da internet na palma da sua mão"
date = "2017-06-16"
categories = ["italocegatta"]
original_url = "https://italocegatta.github.io/web-scraping-dados-de-paginas-da-internet-na-palma-da-sua-mao/"
+++

<p>
Você já precisou copiar na mão uma informação de texto, valor ou tabela
de uma pagina web? Pelo menos no meu trabalho isto é muito comum. Por
mais que os dados estejam lá site, eles nunca estão disponíveis todos
juntos e no formato que queremos, parece que sacanagem. Diante disto, o
objetivo deste post é mostrar como podemos utilizar o R para coletar
dados de uma página web e esquecer o famooooso <em>ctrl+c/ctrl+v</em>.
</p>
<p>
Vamos exemplificar o post utilizando o site do IBGE para saber quantos
metros cúbicos de lenha de eucalipto foram produzidos em 2015 em cada
estado brasileiro. De cara, se os dados não estiverem numa tabela
pronta, você já espera ter que entrar em 27 páginas diferentes para
pegar esta informação.
</p>
<p>
Nosso ponto de partida é a página
<a href="http://www.ibge.gov.br/estadosat/">States@</a> do IBGE, que
reúne diversas informações na escala estadual. Acessando a página
podemos ver o código html por trás (utilize a tecla F12) e assim
entender como a página está estruturada. Como queremos entrar nos
Estados, podemos ver na Figura
<a href="https://italocegatta.github.io/web-scraping-dados-de-paginas-da-internet-na-palma-da-sua-mao/#fig:pg1">1</a>
que essa informação está abaixo do <code>id="menu"</code>. Note que ao
passarmos o mouse sobre a linha <code>&lt;div id="menu"&gt;</code> o
navegador identifica na página a localização do elemento e ainda nos
informa o id CSS de rastreio, no caso <code>div\#menu</code>.
</p>
<span id="fig:pg1"></span>
<img src="http://i.imgur.com/VjiEvCM.png" alt="P&#xE1;gina inicial do site.">
<p class="caption">
Figura 1: Página inicial do site.
</p>

<p>
Então já podemos começar a programar e desenhar o acesso aos dados. No
R, cada página web é um objeto que precisa ser salvo na memória. Então,
cada página é importante para ter os dados ou por ser uma etapa para
conseguir os dados. A página inicial (<code>pg\_raiz</code>) contém os
links para as páginas dos Estados, por isso precisamos acessá-la.
</p>
<pre class="r"><code>if (!require(&quot;pacman&quot;)) install.packages(&quot;pacman&quot;)
pacman::p_load(purrr, dplyr, tidyr, stringr, rvest, ggplot2, viridis, scales, sf)
pacman::p_load_gh(&quot;italocegatta/brmap&quot;)</code></pre>
<pre class="r"><code>url_raiz &lt;- &quot;http://www.ibge.gov.br/estadosat/&quot; pg_raiz &lt;- read_html(url_raiz)</code></pre>
<p>
No objeto <code>posfixo\_estados</code> temos a parte do link que leva
até a página de cada estado. Para ter o link completo, é só juntar com o
link da página raiz.
</p>
<pre class="r"><code>posfixo_estados &lt;- html_node(pg_raiz, &quot;div#menu&quot;) %&gt;% html_children() %&gt;% html_node(&quot;a&quot;) %&gt;% html_attr(&quot;href&quot;) posfixo_estados</code></pre>
<pre><code>## [1] &quot;perfil.php?sigla=ro&quot; &quot;perfil.php?sigla=ac&quot; &quot;perfil.php?sigla=am&quot;
## [4] &quot;perfil.php?sigla=rr&quot; &quot;perfil.php?sigla=pa&quot; &quot;perfil.php?sigla=ap&quot;
## [7] &quot;perfil.php?sigla=to&quot; &quot;perfil.php?sigla=ma&quot; &quot;perfil.php?sigla=pi&quot;
## [10] &quot;perfil.php?sigla=ce&quot; &quot;perfil.php?sigla=rn&quot; &quot;perfil.php?sigla=pb&quot;
## [13] &quot;perfil.php?sigla=pe&quot; &quot;perfil.php?sigla=al&quot; &quot;perfil.php?sigla=se&quot;
## [16] &quot;perfil.php?sigla=ba&quot; &quot;perfil.php?sigla=mg&quot; &quot;perfil.php?sigla=es&quot;
## [19] &quot;perfil.php?sigla=rj&quot; &quot;perfil.php?sigla=sp&quot; &quot;perfil.php?sigla=pr&quot;
## [22] &quot;perfil.php?sigla=sc&quot; &quot;perfil.php?sigla=rs&quot; &quot;perfil.php?sigla=ms&quot;
## [25] &quot;perfil.php?sigla=mt&quot; &quot;perfil.php?sigla=go&quot; &quot;perfil.php?sigla=df&quot;</code></pre>
<pre class="r"><code>url_estados &lt;- paste0(url_raiz, posfixo_estados)</code></pre>
<p>
Vamos agora acessar às páginas de todos os Estados e armazenar no objeto
<code>pg\_estados</code>.
</p>
<pre class="r"><code>pg_estados &lt;- map(url_estados, read_html)</code></pre>
<p>
Navegando pela página de um estado qualquer, identificamos que queremos
a informação contida no link <em>Extração Vegetal e Silvicultura
2015</em>. Nesse caso, precisamos mais uma vez dos links que leva a esta
página (para cada estado). Também é possível, tanto pelo R quanto pelo
navegador, ver que esse link está na posição 68 da lista/tablela nomeada
como <code>table.temas</code>.
</p>
<pre class="r"><code>posfixo_lenha &lt;- map( pg_estados, ~html_node(.x, &quot;table.temas&quot;) %&gt;% html_children() %&gt;% &apos;[&apos;(68) %&gt;% html_node(&quot;a&quot;) %&gt;% html_attr(&quot;href&quot;) ) %&gt;% flatten_chr() posfixo_lenha</code></pre>
<pre><code>## [1] &quot;temas.php?sigla=ro&amp;tema=extracaovegetal2015&quot;
## [2] &quot;temas.php?sigla=ac&amp;tema=extracaovegetal2015&quot;
## [3] &quot;temas.php?sigla=am&amp;tema=extracaovegetal2015&quot;
## [4] &quot;temas.php?sigla=rr&amp;tema=extracaovegetal2015&quot;
## [5] &quot;temas.php?sigla=pa&amp;tema=extracaovegetal2015&quot;
## [6] &quot;temas.php?sigla=ap&amp;tema=extracaovegetal2015&quot;
## [7] &quot;temas.php?sigla=to&amp;tema=extracaovegetal2015&quot;
## [8] &quot;temas.php?sigla=ma&amp;tema=extracaovegetal2015&quot;
## [9] &quot;temas.php?sigla=pi&amp;tema=extracaovegetal2015&quot;
## [10] &quot;temas.php?sigla=ce&amp;tema=extracaovegetal2015&quot;
## [11] &quot;temas.php?sigla=rn&amp;tema=extracaovegetal2015&quot;
## [12] &quot;temas.php?sigla=pb&amp;tema=extracaovegetal2015&quot;
## [13] &quot;temas.php?sigla=pe&amp;tema=extracaovegetal2015&quot;
## [14] &quot;temas.php?sigla=al&amp;tema=extracaovegetal2015&quot;
## [15] &quot;temas.php?sigla=se&amp;tema=extracaovegetal2015&quot;
## [16] &quot;temas.php?sigla=ba&amp;tema=extracaovegetal2015&quot;
## [17] &quot;temas.php?sigla=mg&amp;tema=extracaovegetal2015&quot;
## [18] &quot;temas.php?sigla=es&amp;tema=extracaovegetal2015&quot;
## [19] &quot;temas.php?sigla=rj&amp;tema=extracaovegetal2015&quot;
## [20] &quot;temas.php?sigla=sp&amp;tema=extracaovegetal2015&quot;
## [21] &quot;temas.php?sigla=pr&amp;tema=extracaovegetal2015&quot;
## [22] &quot;temas.php?sigla=sc&amp;tema=extracaovegetal2015&quot;
## [23] &quot;temas.php?sigla=rs&amp;tema=extracaovegetal2015&quot;
## [24] &quot;temas.php?sigla=ms&amp;tema=extracaovegetal2015&quot;
## [25] &quot;temas.php?sigla=mt&amp;tema=extracaovegetal2015&quot;
## [26] &quot;temas.php?sigla=go&amp;tema=extracaovegetal2015&quot;
## [27] &quot;temas.php?sigla=df&amp;tema=extracaovegetal2015&quot;</code></pre>
<p>
Aqui, mais uma vez, será preciso juntar o <em>link</em> específico de
cada estado com a url da página raiz.
</p>
<pre class="r"><code>url_lenha &lt;- paste0(url_raiz, posfixo_lenha) pg_lenha &lt;- map(url_lenha, read_html)</code></pre>
<p>
Agora, vamos dar um passo para trás e listar o nome dos Estados na ordem
que as páginas são acessadas para podemos utilizar mais à frente.
</p>
<pre class="r"><code>lista_estados &lt;- html_node(pg_raiz, &quot;div#menu&quot;) %&gt;% html_children() %&gt;% html_node(&quot;img&quot;) %&gt;% html_attr(&quot;alt&quot;) lista_estados</code></pre>
<pre><code>## [1] &quot;Rond&#xF4;nia&quot; &quot;Acre&quot; &quot;Amazonas&quot; ## [4] &quot;Roraima&quot; &quot;Par&#xE1;&quot; &quot;Amap&#xE1;&quot; ## [7] &quot;Tocantins&quot; &quot;Maranh&#xE3;o&quot; &quot;Piau&#xED;&quot; ## [10] &quot;Cear&#xE1;&quot; &quot;Rio Grande do Norte&quot; &quot;Para&#xED;ba&quot; ## [13] &quot;Pernambuco&quot; &quot;Alagoas&quot; &quot;Sergipe&quot; ## [16] &quot;Bahia&quot; &quot;Minas Gerais&quot; &quot;Esp&#xED;rito Santo&quot; ## [19] &quot;Rio de Janeiro&quot; &quot;S&#xE3;o Paulo&quot; &quot;Paran&#xE1;&quot; ## [22] &quot;Santa Catarina&quot; &quot;Rio Grande do Sul&quot; &quot;Mato Grosso do Sul&quot; ## [25] &quot;Mato Grosso&quot; &quot;Goi&#xE1;s&quot; &quot;Distrito federal&quot;</code></pre>
<p>
O próximo passo é extrair a tabela de informação de cada estado e
posteriormente filtrar a informação que é de nosso interesse. Note que é
neste momento que a programação se diferencia das atividades manuais:
caso seu interesse seja por lenha de pinus, por exemplo, basta alterar
uma palavra no código abaixo e ser feliz com o resultado em poucos
segundos. Claro que é um exemplo hipotético, dificilmente alguém vai
precisar desse código específico, mas o ponto está na capacidade de
escrever seu próprio código e não precisar fazer o trabalho manual.
</p>
<pre class="r"><code>tabelas &lt;- map( set_names(pg_lenha, lista_estados), ~html_node(.x, &quot;table#tabela_temas&quot;) %&gt;% html_table() %&gt;% as_tibble() %&gt;% rename(produto = X1, valor = X2, unidade = X3) ) qnt &lt;- map_df( tabelas, ~filter(.x, str_detect(produto, c(&quot;Lenha de eucalipto&quot;, &quot;quantidade&quot;))) %&gt;% &apos;[[&apos;(&quot;valor&quot;) ) %&gt;% gather(estado, volume) %&gt;% mutate(volume = as.numeric(str_replace_all(volume, &quot;\\.&quot;, &quot;&quot;))) qnt </code></pre>
<pre><code>## # A tibble: 27 x 2
## estado volume
## &lt;chr&gt; &lt;dbl&gt;
## 1 Rond&#xF4;nia 690
## 2 Acre NA
## 3 Amazonas NA
## 4 Roraima NA
## 5 Par&#xE1; NA
## 6 Amap&#xE1; NA
## 7 Tocantins 2300
## 8 Maranh&#xE3;o 195428
## 9 Piau&#xED; 188724
## 10 Cear&#xE1; NA
## # ... with 17 more rows</code></pre>
<p>
De certa forma já resolvemos o problema, a quantidade de lenha de
eucalipto produzida em cada estado no ano de 2015 já está em nossas
mãos. Mas vamos dar um passo além e visualizar isso num mapa. O pacote
<a href="https://github.com/italocegatta/brmap">brmap</a> possui os
polígonos dos Estados brasileiros no formato <code>sf</code>, o novo
pacote para manupulação de objetos espaciais no R.
</p>
<pre class="r"><code>qnt_mapa &lt;- left_join(brmap_estado, qnt) ggplot(qnt_mapa) + geom_sf(aes(fill = volume)) + labs( title = &quot;Lenha de eucalipto - quantidade produzida em 2015&quot;, subtitle = &quot;IBGE Estados - Extra&#xE7;&#xE3;o Vegetal e Silvicultura 2015&quot; ) + scale_fill_viridis( Lenha~de~eucalipto~(m^3), na.value = &quot;grey90&quot;, labels = function(x) format(x, big.mark = &quot;.&quot;, decimal.mark = &quot;,&quot;, scientific = FALSE) ) + theme_bw() + theme(legend.position = &quot;bottom&quot;) + guides(fill = guide_colorbar(barwidth = 30, title.position = &quot;top&quot;))</code></pre>
<p>
<img src="https://italocegatta.github.io/post/2017-06-16-web-scraping-dados-de-paginas-da-internet-na-palma-da-sua-mao_files/figure-html/unnamed-chunk-9-1.png" width="4000">
</p>
<p>
Caso tenha alguma dúvida ou sugestão sobre o post, fique à vontade para
fazer um comentário ou me contactar por Email.
</p>
<pre class="r"><code>devtools::session_info()</code></pre>
<pre><code>## setting value ## version R version 3.3.3 (2017-03-06)
## system x86_64, mingw32 ## ui RTerm ## language (EN) ## collate Portuguese_Brazil.1252 ## tz America/Sao_Paulo ## date 2017-07-08 ## ## package * version date source ## assertthat 0.2.0 2017-04-11 CRAN (R 3.3.3) ## backports 1.1.0 2017-05-22 CRAN (R 3.3.3) ## base * 3.3.3 2017-03-06 local ## bindr 0.1 2016-11-13 CRAN (R 3.3.3) ## bindrcpp * 0.2 2017-06-17 CRAN (R 3.3.3) ## blogdown 0.0.25 2017-03-23 Github (rstudio/blogdown@1c10d16) ## bookdown 0.4 2017-05-20 CRAN (R 3.3.3) ## brmap * 0.0.2 2017-07-07 local ## colorspace 1.3-2 2016-12-14 CRAN (R 3.3.2) ## curl 2.7 2017-06-26 CRAN (R 3.3.3) ## datasets * 3.3.3 2017-03-06 local ## DBI 0.7 2017-06-18 CRAN (R 3.3.3) ## devtools 1.13.2 2017-06-02 CRAN (R 3.3.3) ## digest 0.6.12 2017-01-27 CRAN (R 3.3.2) ## dplyr * 0.7.1 2017-06-22 CRAN (R 3.3.3) ## evaluate 0.10 2016-10-11 CRAN (R 3.3.3) ## ggplot2 * 2.2.1.9000 2017-06-16 Github (tidyverse/ggplot2@398fc07)
## glue 1.1.1 2017-06-21 CRAN (R 3.3.3) ## graphics * 3.3.3 2017-03-06 local ## grDevices * 3.3.3 2017-03-06 local ## grid 3.3.3 2017-03-06 local ## gridExtra 2.2.1 2016-02-29 CRAN (R 3.3.3) ## gtable 0.2.0 2016-02-26 CRAN (R 3.3.2) ## highr 0.6 2016-05-09 CRAN (R 3.3.3) ## htmltools 0.3.6 2017-04-28 CRAN (R 3.3.3) ## httr 1.2.1 2016-07-03 CRAN (R 3.3.2) ## knitr 1.16 2017-05-18 CRAN (R 3.3.3) ## labeling 0.3 2014-08-23 CRAN (R 3.3.2) ## lazyeval 0.2.0 2016-06-12 CRAN (R 3.3.2) ## magrittr 1.5 2014-11-22 CRAN (R 3.3.2) ## memoise 1.1.0 2017-04-21 CRAN (R 3.3.3) ## methods 3.3.3 2017-03-06 local ## munsell 0.4.3 2016-02-13 CRAN (R 3.3.2) ## pacman * 0.4.6 2017-05-14 CRAN (R 3.3.3) ## pkgconfig 2.0.1 2017-03-21 CRAN (R 3.3.3) ## plyr 1.8.4 2016-06-08 CRAN (R 3.3.2) ## purrr * 0.2.2.2 2017-05-11 CRAN (R 3.3.3) ## R6 2.2.2 2017-06-17 CRAN (R 3.3.3) ## Rcpp 0.12.11 2017-05-22 CRAN (R 3.3.3) ## rlang 0.1.1 2017-05-18 CRAN (R 3.3.3) ## rmarkdown 1.6 2017-06-15 CRAN (R 3.3.3) ## rprojroot 1.2 2017-01-16 CRAN (R 3.3.3) ## rvest * 0.3.2 2016-06-17 CRAN (R 3.3.2) ## scales * 0.4.1 2016-11-09 CRAN (R 3.3.2) ## selectr 0.3-1 2016-12-19 CRAN (R 3.3.2) ## sf * 0.5-1 2017-06-23 CRAN (R 3.3.3) ## stats * 3.3.3 2017-03-06 local ## stringi 1.1.5 2017-04-07 CRAN (R 3.3.3) ## stringr * 1.2.0 2017-02-18 CRAN (R 3.3.2) ## tibble 1.3.3 2017-05-28 CRAN (R 3.3.3) ## tidyr * 0.6.3 2017-05-15 CRAN (R 3.3.3) ## tools 3.3.3 2017-03-06 local ## udunits2 0.13 2016-11-17 CRAN (R 3.3.2) ## units 0.4-5 2017-06-15 CRAN (R 3.3.3) ## utils * 3.3.3 2017-03-06 local ## viridis * 0.4.0 2017-03-27 CRAN (R 3.3.3) ## viridisLite * 0.2.0 2017-03-24 CRAN (R 3.3.3) ## withr 1.0.2 2016-06-20 CRAN (R 3.3.3) ## XML 3.98-1.9 2017-06-19 CRAN (R 3.3.3) ## xml2 * 1.1.1 2017-01-24 CRAN (R 3.3.2) ## yaml 2.1.14 2016-11-12 CRAN (R 3.3.3)</code></pre>

