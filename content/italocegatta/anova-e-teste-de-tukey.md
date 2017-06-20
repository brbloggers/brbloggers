+++
title = "ANOVA e teste de Tukey"
date = "2016-09-08"
categories = ["italocegatta"]
original_url = "https://italocegatta.github.io/anova-e-teste-de-tukey/"
+++

<p>
Análise de variância (ANOVA) e testes de médias são métodos comuns em
artigos científicos. Você com certeza já viu aquelas letrinhas indicando
a diferença entre tratamentos em algum estudo publicado. Por mais que
este método esteja entrando em desuso - há uma tendência em abandonar
esse tipo de abordagem estatística - penso que ainda o veremos por
muitos anos no meio científico.
</p>
<p>
Como contexto, temos um teste de 5 progênies de eucalipto e queremos
avaliar se volume por hectare (nossa variável resposta), difere entre os
tratamentos.
</p>
<p>
Pois bem, para percebermos a dimensão dos dados e qual a variabilidade
de cada tratamento, vamos criar um boxplot (Figura
<a href="https://italocegatta.github.io/anova-e-teste-de-tukey/#fig:10-boxplot">1</a>).
Caso você queira saber um pouco mais sobre este tipo de gráfico, veja o
<a href="https://italocegatta.github.io/os-graficos-que-explicam-nossos-dados-boxplot">post
sobre ele</a>.
</p>
<pre class="r"><code>if (!require(&quot;pacman&quot;)) install.packages(&quot;pacman&quot;) pacman::p_load(readr, dplyr, ggplot2, ggthemes, car, agricolae)</code></pre>
<pre class="r"><code>dados &lt;- read_csv2( &quot;https://github.com/italocegatta/italocegatta.github.io_source/raw/master/content/dados/base_progenie.csv&quot; ) dados</code></pre>
<pre><code>## # A tibble: 30 &#xD7; 3 ## repeticao progenie volume ## &lt;int&gt; &lt;chr&gt; &lt;int&gt; ## 1 1 A 212 ## 2 2 A 206 ## 3 3 A 224 ## 4 4 A 289 ## 5 5 A 324 ## 6 6 A 219 ## 7 1 B 108 ## 8 2 B 194 ## 9 3 B 163 ## 10 4 B 111 ## # ... with 20 more rows</code></pre>
<pre class="r"><code>ggplot(dados, aes(progenie, volume)) + geom_boxplot() + theme_bw() + theme_few()</code></pre>
<span id="fig:10-boxplot"></span>
<img src="https://italocegatta.github.io/post/2016-09-08-anova-e-teste-de-tukey_files/figure-html/10-boxplot-1.png" alt="Variabilidade do volume por hectare de cada tratamento." width="4000">
<p class="caption">
Figura 1: Variabilidade do volume por hectare de cada tratamento.
</p>

<p>
A ANOVA é um método bastante consolidado no meio acadêmico. Basicamente,
este método informa se existe um tratamento discrepante dentre os
demais. Entretanto, ele exige que algumas premissas sejam atendidas,
como: distribuição normal dos resíduos e homogeneidade de variância.
</p>
<p>
Primeiro, vamos utilizar o teste de Levene para verificar se há
homogeneidade de variância, ou homocedasticidade. Como o p-valor é maior
que 5% não temos evidência significativa para rejeitar a hipótese nula
de homogeneidade, ou seja, nossos dados tem homogeneidade de variância.
</p>
<pre class="r"><code>leveneTest(volume ~ factor(progenie), data=dados)</code></pre>
<pre><code>## Levene&apos;s Test for Homogeneity of Variance (center = median) ## Df F value Pr(&gt;F) ## group 4 2.4677 0.07086 . ## 25 ## --- ## Signif. codes: 0 &apos;***&apos; 0.001 &apos;**&apos; 0.01 &apos;*&apos; 0.05 &apos;.&apos; 0.1 &apos; &apos; 1</code></pre>
<p>
O segundo pressuposto é a normalidade dos resíduos. Utilizaremos o teste
de Shapiro-Wilk cuja hipótese nula é a de que os dados seguem uma
distribuição normal. Como o p-valor é superior ao limite de 5%, podemos
aceitar a hipótese nula e considerar nossos dados normais.
</p>
<pre class="r"><code>anova &lt;- aov(volume ~ progenie, data=dados) shapiro.test(resid(anova))</code></pre>
<pre><code>## ## Shapiro-Wilk normality test ## ## data: resid(anova) ## W = 0.96097, p-value = 0.3279</code></pre>
<p>
Uma vez que os pressupostos foram atendidos, seguiremos para a ANOVA.
Note que, caso os testes de Levene e Shapiro-Wilk resultassem em um
p-valor significante, ou seja, menor que 5%, teríamos que utilizar outro
método estatístico para analisar nossos dados. Nesse caso, uma
alternativa é utilizar testes não-paramétricos, uma vez que eles não
exigem os pressupostos que acabamos de testar.
</p>
<p>
Nossa ANOVA resultou em um p-valor menor que 5%, portanto, temos
evidências de que ao menos um tratamento se diferencia dos demais. Isso
já é uma resposta, mas pouco acrescenta à nossa pesquisa pois queremos
saber quem é este tratamento discrepante. Ou melhor, queremos poder
comparar os tratamentos entre si e verificar quais são estatisticamente
iguais ou diferentes.
</p>
<pre class="r"><code>summary(anova)</code></pre>
<pre><code>## Df Sum Sq Mean Sq F value Pr(&gt;F) ## progenie 4 86726 21681 8.89 0.000131 *** ## Residuals 25 60974 2439 ## --- ## Signif. codes: 0 &apos;***&apos; 0.001 &apos;**&apos; 0.01 &apos;*&apos; 0.05 &apos;.&apos; 0.1 &apos; &apos; 1</code></pre>
<p>
Para esta abordagem existem alguns testes de médias e cada um tem uma
particularidade, mas de longe o mais utilizado é o de Tukey.
</p>
<p>
A interpretação do teste de Tukey é simples. Após determinarmos a
diferença mínima significativa (ou Honest Significant Difference - HSD),
podemos julgar se as médias são iguais ou não. Em termos práticos, esse
valor nos dá uma margem de igualdade, pois se a diferença entre dois
tratamentos for maior do que isso, os médias são diferentes.
</p>
<p>
A análise começa sempre pela maior média, no nosso caso a progênie A
(245, 66). Com uma continha rápida, a média do tratamento A menos a
diferença mínima significativa <code>245,66 - 83,73 = 161,93</code>,
aceitaremos que um tratamento é igual ao A se a média dele for maior que
161,93. O tratamento subsequente (o segundo do ranking) é a progênie D e
como sua média é maior que 161,93 podemos dizer que ela é
estatisticamente igual a progênie A.
</p>
<p>
As próximas comparações seguem a mesma lógica. Quando registramos que
duas médias são iguais, nós as rotulamos com a mesma letra para
facilitar a identificação. Veja no fim do output as letras evidenciando
a igualdade entre os tratamentos.
</p>
<pre class="r"><code>tukey &lt;- HSD.test(anova, &quot;progenie&quot;) tukey</code></pre>
<pre><code>## $statistics ## Mean CV MSerror HSD ## 165.7667 29.79233 2438.953 83.73866 ## ## $parameters ## Df ntr StudentizedRange alpha test name.t ## 25 5 4.153363 0.05 Tukey progenie ## ## $means ## volume std r Min Max ## A 245.6667 48.78798 6 206 324 ## B 159.6667 49.47996 6 108 236 ## C 80.5000 15.60449 6 63 100 ## D 190.1667 75.37484 6 100 267 ## E 152.8333 37.96534 6 106 210 ## ## $comparison ## NULL ## ## $groups ## trt means M ## 1 A 245.6667 a ## 2 D 190.1667 ab ## 3 B 159.6667 bc ## 4 E 152.8333 bc ## 5 C 80.5000 c</code></pre>
<p>
Para deixar mais visual ainda, podemos construir um gráfico de barras
com a média de cada tratamento e adicionar a sua letra correspondente ao
teste de Tukey (Figura
<a href="https://italocegatta.github.io/anova-e-teste-de-tukey/#fig:10-barras-tukey">2</a>).
</p>
<pre class="r"><code>tukey$groups %&gt;% ggplot(aes(reorder(trt, means, function(x) -mean(x)), means)) + geom_bar(stat = &quot;identity&quot;) + geom_text(aes(label = M), vjust = 1.8, size = 9, color = &quot;white&quot;) + labs(x = &quot;Prog&#xEA;nies&quot;, y = &quot;M&#xE9;dias&quot;) + theme_few()</code></pre>
<span id="fig:10-barras-tukey"></span>
<img src="https://italocegatta.github.io/post/2016-09-08-anova-e-teste-de-tukey_files/figure-html/10-barras-tukey-1.png" alt="M&#xE9;dias dos tratamentos. As letras indicam m&#xE9;dias estatisticamente iguais pelo teste de Tukey a 5% de signific&#xE2;ncia." width="4000">
<p class="caption">
Figura 2: Médias dos tratamentos. As letras indicam médias
estatisticamente iguais pelo teste de Tukey a 5% de significância.
</p>

<p>
Caso tenha alguma dúvida ou sugestão sobre o post, fique à vontade para
fazer um comentário ou me contactar por Email.
</p>
<pre class="r"><code>devtools::session_info()</code></pre>
<pre><code>## setting value ## version R version 3.3.3 (2017-03-06) ## system x86_64, mingw32 ## ui RTerm ## language (EN) ## collate Portuguese_Brazil.1252 ## tz America/Sao_Paulo ## date 2017-04-08 ## ## package * version date source ## agricolae * 1.2-4 2016-06-12 CRAN (R 3.3.3) ## AlgDesign 1.1-7.3 2014-10-15 CRAN (R 3.3.2) ## assertthat 0.1 2013-12-06 CRAN (R 3.3.2) ## backports 1.0.5 2017-01-18 CRAN (R 3.3.2) ## blogdown 0.0.25 2017-03-23 Github (rstudio/blogdown@1c10d16) ## bookdown 0.3.14 2017-03-23 Github (rstudio/bookdown@f427fdf) ## boot 1.3-18 2016-02-23 CRAN (R 3.3.3) ## car * 2.1-4 2016-12-02 CRAN (R 3.3.3) ## cluster 2.0.5 2016-10-08 CRAN (R 3.3.3) ## coda 0.19-1 2016-12-08 CRAN (R 3.3.3) ## colorspace 1.3-2 2016-12-14 CRAN (R 3.3.2) ## combinat 0.0-8 2012-10-29 CRAN (R 3.3.2) ## curl 2.3 2016-11-24 CRAN (R 3.3.2) ## DBI 0.5-1 2016-09-10 CRAN (R 3.3.2) ## deldir 0.1-12 2016-03-06 CRAN (R 3.3.2) ## devtools 1.12.0 2016-06-24 CRAN (R 3.3.3) ## digest 0.6.12 2017-01-27 CRAN (R 3.3.2) ## dplyr * 0.5.0 2016-06-24 CRAN (R 3.3.2) ## evaluate 0.10 2016-10-11 CRAN (R 3.3.3) ## expm 0.999-1 2017-02-02 CRAN (R 3.3.3) ## gdata 2.17.0 2015-07-04 CRAN (R 3.3.2) ## ggplot2 * 2.2.1 2016-12-30 CRAN (R 3.3.2) ## ggthemes * 3.4.0 2017-02-19 CRAN (R 3.3.3) ## gmodels 2.16.2 2015-07-22 CRAN (R 3.3.3) ## gtable 0.2.0 2016-02-26 CRAN (R 3.3.2) ## gtools 3.5.0 2015-05-29 CRAN (R 3.3.2) ## highr 0.6 2016-05-09 CRAN (R 3.3.3) ## htmltools 0.3.5 2016-03-21 CRAN (R 3.3.3) ## klaR 0.6-12 2014-08-06 CRAN (R 3.3.3) ## knitr 1.15.1 2016-11-22 CRAN (R 3.3.3) ## labeling 0.3 2014-08-23 CRAN (R 3.3.2) ## lattice 0.20-34 2016-09-06 CRAN (R 3.3.3) ## lazyeval 0.2.0 2016-06-12 CRAN (R 3.3.2) ## LearnBayes 2.15 2014-05-29 CRAN (R 3.3.2) ## lme4 1.1-12 2016-04-16 CRAN (R 3.3.3) ## magrittr 1.5 2014-11-22 CRAN (R 3.3.2) ## MASS 7.3-45 2016-04-21 CRAN (R 3.3.3) ## Matrix 1.2-8 2017-01-20 CRAN (R 3.3.3) ## MatrixModels 0.4-1 2015-08-22 CRAN (R 3.3.3) ## memoise 1.0.0 2016-01-29 CRAN (R 3.3.3) ## mgcv 1.8-17 2017-02-08 CRAN (R 3.3.3) ## minqa 1.2.4 2014-10-09 CRAN (R 3.3.3) ## munsell 0.4.3 2016-02-13 CRAN (R 3.3.2) ## nlme 3.1-131 2017-02-06 CRAN (R 3.3.3) ## nloptr 1.0.4 2014-08-04 CRAN (R 3.3.3) ## nnet 7.3-12 2016-02-02 CRAN (R 3.3.3) ## pacman * 0.4.1 2016-03-30 CRAN (R 3.3.3) ## pbkrtest 0.4-7 2017-03-15 CRAN (R 3.3.3) ## plyr 1.8.4 2016-06-08 CRAN (R 3.3.2) ## quantreg 5.29 2016-09-04 CRAN (R 3.3.3) ## R6 2.2.0 2016-10-05 CRAN (R 3.3.2) ## Rcpp 0.12.9 2017-01-14 CRAN (R 3.3.2) ## readr * 1.0.0 2016-08-03 CRAN (R 3.3.2) ## rmarkdown 1.3 2016-12-21 CRAN (R 3.3.3) ## rprojroot 1.2 2017-01-16 CRAN (R 3.3.3) ## scales 0.4.1 2016-11-09 CRAN (R 3.3.2) ## sp 1.2-4 2016-12-22 CRAN (R 3.3.3) ## SparseM 1.76 2017-03-09 CRAN (R 3.3.3) ## spdep 0.6-11 2017-02-23 CRAN (R 3.3.3) ## stringi 1.1.2 2016-10-01 CRAN (R 3.3.2) ## stringr 1.2.0 2017-02-18 CRAN (R 3.3.2) ## tibble 1.2 2016-08-26 CRAN (R 3.3.2) ## withr 1.0.2 2016-06-20 CRAN (R 3.3.3) ## yaml 2.1.14 2016-11-12 CRAN (R 3.3.3)</code></pre>

