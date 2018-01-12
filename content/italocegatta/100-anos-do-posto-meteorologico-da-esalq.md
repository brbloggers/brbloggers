+++
title = "100 anos do posto meteorológico da ESALQ"
date = "2017-10-14"
categories = ["italocegatta"]
original_url = "https://italocegatta.github.io/100-anos-do-posto-meteorologico-da-esalq/"
+++

<p>
No dia 31 de dezembro de 2016 o Posto Meteorológico da
<a href="http://www.esalq.usp.br/departamentos/leb/posto/">ESALQ/USP</a>
completou 100 anos de funcionamento. Em ‘comemoração’ a este belo banco
de dados, pretendo fazer alguns gráficos para analisar, sem muita
pretensão, como o clima variou de lá pra cá.
</p>
<p>
No site do Posto podemos encontrar os dados nas escalas diária e mensal.
Separei apenas os
<a href="http://www.esalq.usp.br/departamentos/leb/postocon.html">dados
mensais</a> para vermos aqui. Fiz algumas poucas adaptações no banco
para poder pelo menos iniciar a análise. Não considerei nenhuma
consistência e preenchimento de falhas (tem bastante, o que é
completamente compreensível!).
</p>
<p>
Minha primeira movimentação é criar colunas para identificar o ano e as
décadas, precisaremos delas mais para frente.
</p>
<pre class="r"><code>if (!require(&quot;pacman&quot;)) install.packages(&quot;pacman&quot;)
pacman::p_load(readr, dplyr, RcppRoll, lubridate, stringr, ggplot2, ggridges, ggthemes)</code></pre>
<pre class="r"><code>clima &lt;- read_csv2(&quot;https://raw.githubusercontent.com/italocegatta/italocegatta.github.io_source/master/content/dados/posto_esalq.csv&quot;) %&gt;% mutate( data = dmy(data), ano = year(data), decada_label = cut(ano, breaks = seq(1910, 2020, by = 10), dig.lab = 100, right = FALSE), decada = as.numeric(str_extract(decada_label, &quot;[0-9]+&quot;)) ) clima</code></pre>
<pre><code>## # A tibble: 1,200 x 9
## data prec ur t_max t_min t_med ano decada_label decada
## &lt;date&gt; &lt;dbl&gt; &lt;dbl&gt; &lt;dbl&gt; &lt;dbl&gt; &lt;dbl&gt; &lt;dbl&gt; &lt;fctr&gt; &lt;dbl&gt;
## 1 1917-01-01 295.70 NA 28.1 18.3 23.2 1917 [1910,1920) 1910
## 2 1917-02-01 135.76 NA 28.3 18.4 23.3 1917 [1910,1920) 1910
## 3 1917-03-01 58.90 NA 28.6 16.9 22.7 1917 [1910,1920) 1910
## 4 1917-04-01 116.20 NA 26.7 13.9 20.3 1917 [1910,1920) 1910
## 5 1917-05-01 58.50 NA 22.2 8.6 15.4 1917 [1910,1920) 1910
## 6 1917-06-01 13.00 NA 23.3 6.3 14.8 1917 [1910,1920) 1910
## 7 1917-07-01 13.30 NA 24.0 7.7 15.9 1917 [1910,1920) 1910
## 8 1917-08-01 5.40 NA 26.4 7.5 16.9 1917 [1910,1920) 1910
## 9 1917-09-01 62.20 NA 27.8 12.2 20.0 1917 [1910,1920) 1910
## 10 1917-10-01 58.40 NA 27.6 13.8 20.7 1917 [1910,1920) 1910
## # ... with 1,190 more rows</code></pre>
<p>
Vou começar pela precipitação mensal. Para visualizar a distribuição dos
dados a melhor abordagem é fazer um histograma. Vamos criar um
histograma com intervalo de classe de 15 mm de chuva para cada mês do
ano considerando os 100 anos de dados.
</p>
<pre class="r"><code>clima %&gt;% mutate(mes = month(data)) %&gt;% ggplot(aes(prec, rev(factor(mes)), height = ..density..)) + geom_density_ridges(stat = &quot;binline&quot;, binwidth = 15, fill = &quot;grey20&quot;, color = &quot;grey90&quot;) + labs( x = &quot;Chuva mensal (mm)&quot;, y = &quot;M&#xEA;s&quot; ) + scale_fill_viridis_c() + scale_x_continuous(breaks = seq(0,700, 30)) + scale_y_discrete(labels = format(ISOdate(2000, 12:1, 1), &quot;%b&quot;)) + theme_few()</code></pre>
<p>
<img src="https://italocegatta.github.io/post/2017-10-14-100-anos-do-posto-meteorologico-da-esalq_files/figure-html/unnamed-chunk-3-1.png" width="4800">
</p>
<p>
E qual a década que mais choveu? Como variou a chuva anual ao longo
desses 100 anos? Primeiro precisamos calcular quanto choveu em cada
década. Em seguida vamos calcular quanto choveu em cada ano e juntar as
duas informações. No gráfico abaixo, representei a média da década numa
linha de tendência suavizada. Notem que a seca de 2014 Não foi a maior
do século, houveram outros 4 anos mais secos desde de 1917.
</p>
<pre class="r"><code>prec_decada &lt;- clima %&gt;% group_by(decada, ano) %&gt;% summarise(prec = sum(prec)) %&gt;% group_by(decada) %&gt;% summarise(prec = mean(prec)) clima %&gt;% group_by(decada, ano) %&gt;% summarise(prec = sum(prec)) %&gt;% ggplot(aes(ano, prec)) + geom_line() + geom_point() + geom_smooth( data = prec_decada, aes(decada + 5, prec) ) + labs( x = &quot;Ano&quot;, y = &quot;Precipita&#xE7;&#xE3;o anual (mm)&quot; ) + scale_x_continuous(breaks = seq(1917, 2017, 10)) + theme_bw()</code></pre>
<p>
<img src="https://italocegatta.github.io/post/2017-10-14-100-anos-do-posto-meteorologico-da-esalq_files/figure-html/unnamed-chunk-4-1.png" width="4800">
</p>
<p>
Passando para a temperatura média, podemos construir um painel com a
densidade de probabilidade para valores que variam entre 12,5 a 27,7
(amplitude dos dados).
</p>
<pre class="r"><code>ggplot(clima, aes(t_med)) + geom_density() + facet_wrap(~ano) + labs( x = &quot;Temperatura m&#xE9;dia mensal (&#xBA;C)&quot;, y = &quot;Densidade&quot; ) + theme_few(base_size = 9)</code></pre>
<p>
<img src="https://italocegatta.github.io/post/2017-10-14-100-anos-do-posto-meteorologico-da-esalq_files/figure-html/unnamed-chunk-5-1.png" width="4800">
</p>
<p>
Considerando as décadas, podemos fazer um gráfico um pouco mais simples
para facilitar a visualização. Agora, cada década tem sua distribuição
de probabilidade. Aparentemente, a calda da direita está se deslocando
para maiores temperaturas.
</p>
<pre class="r"><code>ggplot(clima, aes(t_med, factor(decada), fill = ..x..)) + geom_density_ridges_gradient(show.legend = FALSE, color = &quot;white&quot;) + labs( x = &quot;Temperatura m&#xE9;dia mensal (&#xBA;C)&quot;, y = &quot;D&#xE9;cada&quot; ) + scale_fill_viridis_c() + theme_few(base_size = 9)</code></pre>
<p>
<img src="https://italocegatta.github.io/post/2017-10-14-100-anos-do-posto-meteorologico-da-esalq_files/figure-html/unnamed-chunk-6-1.png" width="4800">
</p>
<p>
E quanto a variação da temperatura nos meses do ano? Quanto podemos
esperar de frio ou calor em cada mês?
</p>
<pre class="r"><code>clima %&gt;% mutate(mes = month(data)) %&gt;% ggplot(aes(t_med, rev(factor(mes)), fill = ..x..)) + geom_density_ridges_gradient(color = &quot;white&quot;, show.legend = FALSE) + labs( x = &quot;Temperatura m&#xE9;dia mensal (&#xBA;C)&quot;, y = &quot;M&#xEA;s&quot; ) + scale_fill_viridis_c() + scale_x_continuous(breaks = seq(0,40, 4)) + scale_y_discrete(labels = format(ISOdate(2000, 12:1, 1), &quot;%b&quot;)) + theme_few()</code></pre>
<p>
<img src="https://italocegatta.github.io/post/2017-10-14-100-anos-do-posto-meteorologico-da-esalq_files/figure-html/unnamed-chunk-7-1.png" width="4800">
</p>
<p>
Podemos também visualizar a amplitude da temperatura máxima e mínima ao
longo dos anos.
</p>
<pre class="r"><code>ggplot(clima, aes(month(data))) + geom_ribbon(aes(ymax = t_max, ymin = t_min)) + facet_wrap(~ano) + labs( x = &quot;M&#xEA;s&quot;, y = &quot;Amplitude da temperatura m&#xED;nima e m&#xE1;xima mensal (&#xBA;C)&quot; ) + scale_x_continuous( breaks = seq(1, 12, 2), labels = format(ISOdate(2000, seq(1, 12, 2), 1), &quot;%b&quot;) ) + theme_few(10)</code></pre>
<p>
<img src="https://italocegatta.github.io/post/2017-10-14-100-anos-do-posto-meteorologico-da-esalq_files/figure-html/unnamed-chunk-8-1.png" width="5200">
</p>
<p>
Para finalizar, vamos calcular a média móvel de 30 anos para a
temperatura média. Sem dúvida, dos anos 90 pra cá a temperatura média só
vem subindo. A minha grande dúvida é: como será que a produção de
alimentos e biomassa vai se comportar com essa mudança de clima? Será um
grande desafio para a nossa geração, sem dúvida.
</p>
<pre class="r"><code>clima_normal &lt;- clima %&gt;% filter(!is.na(t_med)) %&gt;% group_by(ano = year(data)) %&gt;% summarise(t_med = mean(t_med, na.rm = TRUE)) %&gt;% ungroup() %&gt;% mutate(t_med_movel = roll_mean(t_med, 30, align = &quot;right&quot;, fill = NA)) %&gt;% filter(!is.na(t_med_movel)) ggplot(clima_normal, aes(t_med_movel, ano)) + geom_path() + geom_point() + labs( x = &quot;M&#xE9;dia m&#xF3;vel da temperatura m&#xE9;dia (&#xBA;C)&quot;, y = &quot;Ano&quot; ) + scale_y_reverse(breaks = seq(1940, 2017, by = 5)) + theme_bw()</code></pre>
<p>
<img src="https://italocegatta.github.io/post/2017-10-14-100-anos-do-posto-meteorologico-da-esalq_files/figure-html/unnamed-chunk-9-1.png" width="4800">
</p>
<p>
Caso tenha alguma dúvida ou sugestão sobre o post, fique à vontade para
fazer um comentário ou me contatar por E-mail.
</p>
<pre class="r"><code>devtools::session_info()</code></pre>
<pre><code>## setting value ## version R version 3.3.3 (2017-03-06)
## system x86_64, mingw32 ## ui RTerm ## language (EN) ## collate Portuguese_Brazil.1252 ## tz America/Sao_Paulo ## date 2017-10-14 ## ## package * version date source ## assertthat 0.2.0 2017-04-11 CRAN (R 3.3.3) ## backports 1.1.1 2017-09-25 CRAN (R 3.3.3) ## base * 3.3.3 2017-03-06 local ## bindr 0.1 2016-11-13 CRAN (R 3.3.3) ## bindrcpp * 0.2 2017-06-17 CRAN (R 3.3.3) ## blogdown 0.1 2017-08-22 CRAN (R 3.3.3) ## bookdown 0.5 2017-08-20 CRAN (R 3.3.3) ## colorspace 1.3-2 2016-12-14 CRAN (R 3.3.2) ## curl 2.8.1 2017-07-21 CRAN (R 3.3.3) ## datasets * 3.3.3 2017-03-06 local ## devtools 1.13.3 2017-08-02 CRAN (R 3.3.3) ## digest 0.6.12 2017-01-27 CRAN (R 3.3.2) ## dplyr * 0.7.4 2017-09-28 CRAN (R 3.3.3) ## evaluate 0.10.1 2017-06-24 CRAN (R 3.3.3) ## ggplot2 * 2.2.1.9000 2017-07-15 Github (tidyverse/ggplot2@45853c7)
## ggridges * 0.4.1 2017-09-15 CRAN (R 3.3.3) ## ggthemes * 3.4.0 2017-02-19 CRAN (R 3.3.3) ## glue 1.1.1 2017-06-21 CRAN (R 3.3.3) ## graphics * 3.3.3 2017-03-06 local ## grDevices * 3.3.3 2017-03-06 local ## grid 3.3.3 2017-03-06 local ## gtable 0.2.0 2016-02-26 CRAN (R 3.3.2) ## hms 0.3 2016-11-22 CRAN (R 3.3.2) ## htmltools 0.3.6 2017-04-28 CRAN (R 3.3.3) ## knitr 1.17 2017-08-10 CRAN (R 3.3.3) ## labeling 0.3 2014-08-23 CRAN (R 3.3.2) ## lazyeval 0.2.0 2016-06-12 CRAN (R 3.3.2) ## lubridate * 1.6.0 2016-09-13 CRAN (R 3.3.2) ## magrittr 1.5 2014-11-22 CRAN (R 3.3.2) ## memoise 1.1.0 2017-04-21 CRAN (R 3.3.3) ## methods * 3.3.3 2017-03-06 local ## munsell 0.4.3 2016-02-13 CRAN (R 3.3.2) ## pacman * 0.4.6 2017-05-14 CRAN (R 3.3.3) ## pkgconfig 2.0.1 2017-03-21 CRAN (R 3.3.3) ## plyr 1.8.4 2016-06-08 CRAN (R 3.3.2) ## R6 2.2.2 2017-06-17 CRAN (R 3.3.3) ## Rcpp 0.12.13 2017-09-28 CRAN (R 3.3.3) ## RcppRoll * 0.2.2 2015-04-05 CRAN (R 3.3.3) ## readr * 1.1.1 2017-05-16 CRAN (R 3.3.3) ## rlang 0.1.2 2017-08-09 CRAN (R 3.3.3) ## rmarkdown 1.6 2017-06-15 CRAN (R 3.3.3) ## rprojroot 1.2 2017-01-16 CRAN (R 3.3.3) ## scales 0.5.0 2017-08-24 CRAN (R 3.3.3) ## stats * 3.3.3 2017-03-06 local ## stringi 1.1.5 2017-04-07 CRAN (R 3.3.3) ## stringr * 1.2.0 2017-02-18 CRAN (R 3.3.2) ## tibble 1.3.4 2017-08-22 CRAN (R 3.3.3) ## tools 3.3.3 2017-03-06 local ## utils * 3.3.3 2017-03-06 local ## viridisLite 0.2.0 2017-03-24 CRAN (R 3.3.3) ## withr 2.0.0 2017-07-28 CRAN (R 3.3.3) ## yaml 2.1.14 2016-11-12 CRAN (R 3.3.3)</code></pre>

