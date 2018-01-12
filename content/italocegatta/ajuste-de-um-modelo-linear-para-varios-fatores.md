+++
title = "Ajuste de um modelo linear para vários fatores"
date = "2016-08-27"
categories = ["italocegatta"]
original_url = "https://italocegatta.github.io/ajuste-de-um-modelo-linear-para-varios-fatores/"
+++

<p>
Ajustar um modelo linear ou não linear é algo relativamente simples no
R. Mas em muitos casos precisamos ajustá-lo para vários fatores e
dependendo da quantidade isso se torna uma tarefa chata. Se você, assim
como eu, já precisou fazer isso no Excel, sabe o que é perder mais que
uma tarde copiando e colando informações entres abas e planilhas.<br>
</p>
<p>
Mas felizmente existe uma máxima muito interessante entre programadores
que é:
</p>
<blockquote>
<p>
Don’t Repeat Yourself (DRY)
</p>
</blockquote>
<p>
Depois que eu percebi o quanto a repetição humana gera erros, abracei
totalmente o conceito DRY. Acreditem, vocês serão muito mais felizes e
eficientes deixando o computador fazer as tarefas repetitivas e chatas.
</p>
<p>
Para exemplificar, vamos fazer algo muito comum nas ciências florestais,
que é predizer as alturas das árvores. Medir a altura da árvore é uma
atividade laboriosa, e há muito tempo se sabe que a altura total das
árvores possui alta correlação com o seu diâmetro.
</p>
<p>
Utilizaremos mais uma vez os dados do
<a href="https://italocegatta.github.io/ajuste-de-um-modelo-linear-para-varios-fatores/www.projetotume.com">Projeto
TUME</a>, referente a medição de 24 meses do TUME 55 plantado no Mato
Grosso do Sul.
</p>
<pre class="r"><code>if (!require(&quot;pacman&quot;)) install.packages(&quot;pacman&quot;)
pacman::p_load(readr, dplyr, tidyr, broom, purrr, ggplot2)</code></pre>
<pre class="r"><code>dados &lt;- read_csv2( &quot;https://github.com/italocegatta/italocegatta.github.io_source/raw/master/content/dados/tume_55_24.csv&quot;
) dados</code></pre>
<pre><code>## # A tibble: 1,881 x 9
## N_tume I_meses Esp Parc_m2 N_arv DAP_cm H_m Cod Cod2
## &lt;int&gt; &lt;int&gt; &lt;chr&gt; &lt;dbl&gt; &lt;int&gt; &lt;dbl&gt; &lt;dbl&gt; &lt;int&gt; &lt;int&gt;
## 1 55 24 E_botryoides 600 1 4.1 6.5 NA NA
## 2 55 24 E_botryoides 600 2 9.7 8.0 NA NA
## 3 55 24 E_botryoides 600 3 NA NA 5 NA
## 4 55 24 E_botryoides 600 4 7.6 7.5 2 NA
## 5 55 24 E_botryoides 600 5 3.8 5.0 NA NA
## 6 55 24 E_botryoides 600 6 NA NA 1 NA
## 7 55 24 E_botryoides 600 7 12.6 9.0 6 NA
## 8 55 24 E_botryoides 600 8 NA NA 1 NA
## 9 55 24 E_botryoides 600 9 7.0 8.0 NA NA
## 10 55 24 E_botryoides 600 10 7.5 7.5 NA NA
## # ... with 1,871 more rows</code></pre>
<p>
Nosso objetivo é simples: ajustar um modelo hipsométrico para cada
espécie e em seguida predizer as alturas das árvores. A Figura
<a href="https://italocegatta.github.io/ajuste-de-um-modelo-linear-para-varios-fatores/#fig:9-dap-h">1</a>
mostra a relação que teríamos se fosse ajustado apenas um modelo para
todas as espécies.
</p>
<pre class="r"><code>ggplot(dados, aes(DAP_cm, H_m)) + geom_point(alpha=0.4) + geom_smooth(method=&quot;lm&quot;) + theme_bw()</code></pre>
<span id="fig:9-dap-h"></span>
<img src="https://italocegatta.github.io/post/2016-08-27-ajuste-de-um-modelo-linear-para-varios-fatores_files/figure-html/9-dap-h-1.png" alt="Rela&#xE7;&#xE3;o entre o di&#xE2;metro e a altura sem destin&#xE7;&#xE3;o de esp&#xE9;cie." width="4000">
<p class="caption">
Figura 1: Relação entre o diâmetro e a altura sem destinção de espécie.
</p>

<p>
Mas na prática, a relação diâmetro-altura é diferente entre espécie,
como pode ser notado na Figura
<a href="https://italocegatta.github.io/ajuste-de-um-modelo-linear-para-varios-fatores/#fig:9-dap-h-spp">2</a>.
Talvez fique mais evidente a diferença observando os coeficientes dos
modelos que serão ajustados a seguir.
</p>
<pre class="r"><code>ggplot(dados, aes(DAP_cm, H_m)) + geom_point(alpha=0.4) + geom_smooth(method=&quot;lm&quot;) + facet_wrap(~Esp) + theme_bw()</code></pre>
<span id="fig:9-dap-h-spp"></span>
<img src="https://italocegatta.github.io/post/2016-08-27-ajuste-de-um-modelo-linear-para-varios-fatores_files/figure-html/9-dap-h-spp-1.png" alt="Rela&#xE7;&#xE3;o entre o di&#xE2;metro e a altura por esp&#xE9;cie." width="4000">
<p class="caption">
Figura 2: Relação entre o diâmetro e a altura por espécie.
</p>

<p>
A primeira etapa é entender que um data.frame pode conter vários tipos
de elementos, como números, caracteres, listas e também outros
data.frames. Para isso utilizaremos a função <code>nest()</code> do
pacote <code>tidyr</code> e aninharemos os dados em função das espécies.
</p>
<pre class="r"><code>dados %&gt;% group_by(Esp) %&gt;% nest()</code></pre>
<pre><code>## # A tibble: 24 x 2
## Esp data
## &lt;chr&gt; &lt;list&gt;
## 1 E_botryoides &lt;tibble [80 x 8]&gt;
## 2 E_brassiana &lt;tibble [80 x 8]&gt;
## 3 E_camaldulensis &lt;tibble [80 x 8]&gt;
## 4 E_citriodora &lt;tibble [80 x 8]&gt;
## 5 E_cloeziana &lt;tibble [51 x 8]&gt;
## 6 E_dunnii_urophylla &lt;tibble [80 x 8]&gt;
## 7 E_exserta &lt;tibble [80 x 8]&gt;
## 8 E_grandis_AT &lt;tibble [80 x 8]&gt;
## 9 E_grandis_camaldulensis &lt;tibble [80 x 8]&gt;
## 10 E_grandis_CH &lt;tibble [80 x 8]&gt;
## # ... with 14 more rows</code></pre>
<p>
Agora podemos ajustar um modelo de regressão para cada espécie
utilizando a função <code>map</code>,do pacote <code>purrr</code>.
Podemos ainda extrair as informações desses modelos com as funções
<code>glance</code>, <code>tidy</code> e <code>augment</code>, do pacote
<code>broom</code>.
</p>
<pre class="r"><code>dados_modl &lt;- dados %&gt;% group_by(Esp) %&gt;% nest() %&gt;% mutate( ajuste = data %&gt;% map(~ lm(log(H_m) ~ I(1/DAP_cm), data = .)), resumo = map(ajuste, glance), coef = map(ajuste, tidy), resid = map(ajuste, augment) ) dados_modl</code></pre>
<pre><code>## # A tibble: 24 x 6
## Esp data ajuste
## &lt;chr&gt; &lt;list&gt; &lt;list&gt;
## 1 E_botryoides &lt;tibble [80 x 8]&gt; &lt;S3: lm&gt;
## 2 E_brassiana &lt;tibble [80 x 8]&gt; &lt;S3: lm&gt;
## 3 E_camaldulensis &lt;tibble [80 x 8]&gt; &lt;S3: lm&gt;
## 4 E_citriodora &lt;tibble [80 x 8]&gt; &lt;S3: lm&gt;
## 5 E_cloeziana &lt;tibble [51 x 8]&gt; &lt;S3: lm&gt;
## 6 E_dunnii_urophylla &lt;tibble [80 x 8]&gt; &lt;S3: lm&gt;
## 7 E_exserta &lt;tibble [80 x 8]&gt; &lt;S3: lm&gt;
## 8 E_grandis_AT &lt;tibble [80 x 8]&gt; &lt;S3: lm&gt;
## 9 E_grandis_camaldulensis &lt;tibble [80 x 8]&gt; &lt;S3: lm&gt;
## 10 E_grandis_CH &lt;tibble [80 x 8]&gt; &lt;S3: lm&gt;
## # ... with 14 more rows, and 3 more variables: resumo &lt;list&gt;, coef &lt;list&gt;,
## # resid &lt;list&gt;</code></pre>
<p>
Da mesma forma que aninhamos os dados por espécie, podemos retorná-los
para o formato original, mas agora mostrando apenas as informações que
realmente interessam.
</p>
<pre class="r"><code>dados_modl %&gt;% select(Esp, resumo) %&gt;% unnest(resumo)</code></pre>
<pre><code>## # A tibble: 24 x 12
## Esp r.squared adj.r.squared sigma statistic
## &lt;chr&gt; &lt;dbl&gt; &lt;dbl&gt; &lt;dbl&gt; &lt;dbl&gt;
## 1 E_botryoides 0.7865503 0.7832152 0.13638082 235.83647
## 2 E_brassiana 0.7034805 0.6984547 0.16015749 139.97510
## 3 E_camaldulensis 0.7193692 0.7156767 0.12781229 194.81849
## 4 E_citriodora 0.6017939 0.5958506 0.10226763 101.25459
## 5 E_cloeziana 0.2595328 0.2339995 0.16724765 10.16446
## 6 E_dunnii_urophylla 0.7199293 0.7159283 0.16115569 179.93693
## 7 E_exserta 0.5897407 0.5837949 0.19572456 99.18630
## 8 E_grandis_AT 0.7472094 0.7438832 0.07718312 224.64407
## 9 E_grandis_camaldulensis 0.8290924 0.8265415 0.16085772 325.02460
## 10 E_grandis_CH 0.7764890 0.7731530 0.10465726 232.76148
## # ... with 14 more rows, and 7 more variables: p.value &lt;dbl&gt;, df &lt;int&gt;,
## # logLik &lt;dbl&gt;, AIC &lt;dbl&gt;, BIC &lt;dbl&gt;, deviance &lt;dbl&gt;, df.residual &lt;int&gt;</code></pre>
<pre class="r"><code>dados_modl %&gt;% select(Esp, coef ) %&gt;% unnest(coef)</code></pre>
<pre><code>## # A tibble: 48 x 6
## Esp term estimate std.error statistic
## &lt;chr&gt; &lt;chr&gt; &lt;dbl&gt; &lt;dbl&gt; &lt;dbl&gt;
## 1 E_botryoides (Intercept) 2.633365 0.04223569 62.349272
## 2 E_botryoides I(1/DAP_cm) -4.129688 0.26891300 -15.356968
## 3 E_brassiana (Intercept) 2.014323 0.05110864 39.412563
## 4 E_brassiana I(1/DAP_cm) -2.373711 0.20063302 -11.831107
## 5 E_camaldulensis (Intercept) 2.727702 0.04605191 59.231027
## 6 E_camaldulensis I(1/DAP_cm) -4.792441 0.34335365 -13.957740
## 7 E_citriodora (Intercept) 2.553408 0.05513037 46.315809
## 8 E_citriodora I(1/DAP_cm) -3.802655 0.37790230 -10.062534
## 9 E_cloeziana (Intercept) 2.323552 0.11578912 20.067098
## 10 E_cloeziana I(1/DAP_cm) -2.842311 0.89151651 -3.188176
## # ... with 38 more rows, and 1 more variables: p.value &lt;dbl&gt;</code></pre>
<pre class="r"><code>dados_modl %&gt;% select(Esp, resid) %&gt;% unnest(resid)</code></pre>
<pre><code>## # A tibble: 1,633 x 11
## Esp .rownames log.H_m. I.1.DAP_cm. .fitted .se.fit
## &lt;chr&gt; &lt;chr&gt; &lt;dbl&gt; &lt;dbl&gt; &lt;dbl&gt; &lt;dbl&gt;
## 1 E_botryoides 1 1.871802 0.24390244 1.626124 0.03165108
## 2 E_botryoides 2 2.079442 0.10309278 2.207624 0.02008843
## 3 E_botryoides 4 2.014903 0.13157895 2.089985 0.01712280
## 4 E_botryoides 5 1.609438 0.26315789 1.546605 0.03614528
## 5 E_botryoides 7 2.197225 0.07936508 2.305612 0.02418794
## 6 E_botryoides 9 2.079442 0.14285714 2.043409 0.01679076
## 7 E_botryoides 10 2.014903 0.13333333 2.082740 0.01703615
## 8 E_botryoides 13 1.609438 0.16666667 1.945083 0.01784853
## 9 E_botryoides 14 2.302585 0.09803922 2.228493 0.02086574
## 10 E_botryoides 15 2.140066 0.12048193 2.135812 0.01795064
## # ... with 1,623 more rows, and 5 more variables: .resid &lt;dbl&gt;,
## # .hat &lt;dbl&gt;, .sigma &lt;dbl&gt;, .cooksd &lt;dbl&gt;, .std.resid &lt;dbl&gt;</code></pre>
<p>
Após o ajuste do modelo, temos de predizer as alturas. O único adendo
para esse comando é que precisamos fazer em duas etapas, uma utilizando
a função <code>predict</code> e outra para trazer o valor predito para a
escala natural, pois o modelo foi ajustado na escala logarítmica.
</p>
<pre class="r"><code>dados_pred &lt;- dados_modl %&gt;% mutate( hpred = map2(ajuste, data, predict), hpred = map(hpred, exp) ) %&gt;% select(Esp, data, hpred)</code></pre>
<p>
Por fim, temos de volta um data.frame com as alturas preditas. Por mais
que o ajuste tenha ficado razoável, na prática a construção de modelos
de relação hipsométrica envolvem outras etapas e um maior rigor em
termos estatísticos.
</p>
<pre class="r"><code>dados_compl &lt;- dados_pred %&gt;% unnest(hpred, data) dados_compl</code></pre>
<pre><code>## # A tibble: 1,881 x 10
## Esp hpred N_tume I_meses Parc_m2 N_arv DAP_cm H_m Cod
## &lt;chr&gt; &lt;dbl&gt; &lt;int&gt; &lt;int&gt; &lt;dbl&gt; &lt;int&gt; &lt;dbl&gt; &lt;dbl&gt; &lt;int&gt;
## 1 E_botryoides 5.084129 55 24 600 1 4.1 6.5 NA
## 2 E_botryoides 9.094080 55 24 600 2 9.7 8.0 NA
## 3 E_botryoides NA 55 24 600 3 NA NA 5
## 4 E_botryoides 8.084791 55 24 600 4 7.6 7.5 2
## 5 E_botryoides 4.695500 55 24 600 5 3.8 5.0 NA
## 6 E_botryoides NA 55 24 600 6 NA NA 1
## 7 E_botryoides 10.030312 55 24 600 7 12.6 9.0 6
## 8 E_botryoides NA 55 24 600 8 NA NA 1
## 9 E_botryoides 7.716873 55 24 600 9 7.0 8.0 NA
## 10 E_botryoides 8.026428 55 24 600 10 7.5 7.5 NA
## # ... with 1,871 more rows, and 1 more variables: Cod2 &lt;int&gt;</code></pre>
<p>
Caso tenha alguma dúvida ou sugestão sobre o post, fique à vontade para
fazer um comentário ou me contatar por E-mail.
</p>
<pre class="r"><code>devtools::session_info()</code></pre>
<pre><code>## setting value ## version R version 3.3.3 (2017-03-06)
## system x86_64, mingw32 ## ui RTerm ## language (EN) ## collate Portuguese_Brazil.1252 ## tz America/Sao_Paulo ## date 2017-10-14 ## ## package * version date source ## assertthat 0.2.0 2017-04-11 CRAN (R 3.3.3) ## backports 1.1.1 2017-09-25 CRAN (R 3.3.3) ## base * 3.3.3 2017-03-06 local ## bindr 0.1 2016-11-13 CRAN (R 3.3.3) ## bindrcpp * 0.2 2017-06-17 CRAN (R 3.3.3) ## blogdown 0.1 2017-08-22 CRAN (R 3.3.3) ## bookdown 0.5 2017-08-20 CRAN (R 3.3.3) ## broom * 0.4.2 2017-02-13 CRAN (R 3.3.2) ## colorspace 1.3-2 2016-12-14 CRAN (R 3.3.2) ## curl 2.8.1 2017-07-21 CRAN (R 3.3.3) ## datasets * 3.3.3 2017-03-06 local ## devtools 1.13.3 2017-08-02 CRAN (R 3.3.3) ## digest 0.6.12 2017-01-27 CRAN (R 3.3.2) ## dplyr * 0.7.4 2017-09-28 CRAN (R 3.3.3) ## evaluate 0.10.1 2017-06-24 CRAN (R 3.3.3) ## foreign 0.8-67 2016-09-13 CRAN (R 3.3.3) ## ggplot2 * 2.2.1.9000 2017-07-15 Github (tidyverse/ggplot2@45853c7)
## glue 1.1.1 2017-06-21 CRAN (R 3.3.3) ## graphics * 3.3.3 2017-03-06 local ## grDevices * 3.3.3 2017-03-06 local ## grid 3.3.3 2017-03-06 local ## gtable 0.2.0 2016-02-26 CRAN (R 3.3.2) ## highr 0.6 2016-05-09 CRAN (R 3.3.3) ## hms 0.3 2016-11-22 CRAN (R 3.3.2) ## htmltools 0.3.6 2017-04-28 CRAN (R 3.3.3) ## knitr 1.17 2017-08-10 CRAN (R 3.3.3) ## labeling 0.3 2014-08-23 CRAN (R 3.3.2) ## lattice 0.20-34 2016-09-06 CRAN (R 3.3.3) ## lazyeval 0.2.0 2016-06-12 CRAN (R 3.3.2) ## magrittr 1.5 2014-11-22 CRAN (R 3.3.2) ## memoise 1.1.0 2017-04-21 CRAN (R 3.3.3) ## methods * 3.3.3 2017-03-06 local ## mnormt 1.5-5 2016-10-15 CRAN (R 3.3.2) ## munsell 0.4.3 2016-02-13 CRAN (R 3.3.2) ## nlme 3.1-131 2017-02-06 CRAN (R 3.3.3) ## pacman * 0.4.6 2017-05-14 CRAN (R 3.3.3) ## parallel 3.3.3 2017-03-06 local ## pkgconfig 2.0.1 2017-03-21 CRAN (R 3.3.3) ## plyr 1.8.4 2016-06-08 CRAN (R 3.3.2) ## psych 1.7.8 2017-09-09 CRAN (R 3.3.3) ## purrr * 0.2.3 2017-08-02 CRAN (R 3.3.3) ## R6 2.2.2 2017-06-17 CRAN (R 3.3.3) ## Rcpp 0.12.13 2017-09-28 CRAN (R 3.3.3) ## readr * 1.1.1 2017-05-16 CRAN (R 3.3.3) ## reshape2 1.4.2 2016-10-22 CRAN (R 3.3.2) ## rlang 0.1.2 2017-08-09 CRAN (R 3.3.3) ## rmarkdown 1.6 2017-06-15 CRAN (R 3.3.3) ## rprojroot 1.2 2017-01-16 CRAN (R 3.3.3) ## scales 0.5.0 2017-08-24 CRAN (R 3.3.3) ## stats * 3.3.3 2017-03-06 local ## stringi 1.1.5 2017-04-07 CRAN (R 3.3.3) ## stringr 1.2.0 2017-02-18 CRAN (R 3.3.2) ## tibble 1.3.4 2017-08-22 CRAN (R 3.3.3) ## tidyr * 0.7.1 2017-09-01 CRAN (R 3.3.3) ## tidyselect 0.2.0 2017-08-30 CRAN (R 3.3.3) ## tools 3.3.3 2017-03-06 local ## utils * 3.3.3 2017-03-06 local ## withr 2.0.0 2017-07-28 CRAN (R 3.3.3) ## yaml 2.1.14 2016-11-12 CRAN (R 3.3.3)</code></pre>

