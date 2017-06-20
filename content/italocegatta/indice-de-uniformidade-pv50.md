+++
title = "Índice de uniformidade (PV50)"
date = "2016-10-09"
categories = ["italocegatta"]
original_url = "https://italocegatta.github.io/indice-de-uniformidade-pv50/"
+++

<p>
O PV50 é hoje o índice mais utilizado quando queremos expressar a
uniformidade de um plantio florestal. <span class="citation">Hakamada
(<a href="https://italocegatta.github.io/indice-de-uniformidade-pv50/#ref-Hakamada2012">2012</a>)</span>
apresentou um estudo detalhado sobre diversos índices e concluiu que o
PV50 é o índice mais indicado para explicar a relação entre
uniformidade, qualidade silvicultural e produtividade em plantios
homogêneos de <em>Eucalyptus</em>.
</p>
<p>
O objetivo deste post é mostrar, passo a passo, como calcular este
índice no R e fazer uma breve análise de seus resultados.
</p>
<p>
O PV50 é a porcentagem de volume acumulado das 50% menores árvores do
seu conjunto de dados, considerando as falhas de plantio e árvores
mortas <span class="citation">(Hakamada et al.
<a href="https://italocegatta.github.io/indice-de-uniformidade-pv50/#ref-Hakamada2015">2015</a>)</span>.
A expressão do índice é dada da seguinte forma:
</p>
<p>
<img src="http://www.sciweavers.org/tex2img.php?eq=PV50%20%3D%20%5Cfrac%7B%5Csum_%7Bk%3D1%7D%5E%7B%5Cfrac%7Bn%7D%7B2%7D%7DV_%7Bij%7D%7D%7B%5Csum_%7Bk%3D1%7D%5E%7Bn%7DV_%7Bij%7D%7D&amp;bc=White&amp;fc=Black&amp;im=jpg&amp;fs=12&amp;ff=arev&amp;edit=0" alt="PV50 = \frac{\sum_{k=1}^{\frac{n}{2}}V_{ij}}{\sum_{k=1}^{n}V_{ij}}" width="139">
</p>
<p>
Onde: PV50 = porcentagem acumulada do volume das 50% menores árvores
plantadas; V = volume da árvore i; n = número de árvores plantadas
ordenadas (da menor para a maior).
</p>
<p>
Primeiro vamos entender os cálculos do índice, considerando apenas 10
árvores hipotéticas com 0,1 metros cúbicos de volume.
</p>
<pre class="r"><code># carrega os pacotes necess&#xE1;rios if (!require(&quot;pacman&quot;)) install.packages(&quot;pacman&quot;) pacman::p_load(readr, dplyr, ggplot2, forcats)</code></pre>
<pre class="r"><code># exemplo com n&#xFA;mero par arv10 &lt;- rep(0.1, 10) str(arv10)</code></pre>
<pre><code>## num [1:10] 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1</code></pre>
<p>
Este é o referencial teórico de uniformidade, todas as árvores do mesmo
tamanho. Sem precisar fazer conta, sabemos que o volume das 50% menores
árvores é igual a 50% do volume total, o que equivale a um PV50 = 50.
</p>
<pre class="r"><code># identifica a metade do numero de &#xE1;rvores metade &lt;- length(arv10)/2 metade</code></pre>
<pre><code>## [1] 5</code></pre>
<pre class="r"><code># soma todas as &#xE1;rvores soma_todas &lt;- sum(arv10, na.rm = TRUE) soma_todas</code></pre>
<pre><code>## [1] 1</code></pre>
<pre class="r"><code># soma o valor de metade das &#xE1;rvores em ordem crescente soma_metade &lt;- sum(sort(arv10)[1:metade], na.rm = TRUE) soma_metade</code></pre>
<pre><code>## [1] 0.5</code></pre>
<pre class="r"><code># calcula o PV50 PV50 &lt;- soma_metade / soma_todas * 100 PV50</code></pre>
<pre><code>## [1] 50</code></pre>
<p>
Agora vamos simular 11 árvores com o mesmo volume, veja o que acontece.
</p>
<pre class="r"><code># exemplo com n&#xFA;mero impar arv11 &lt;- rep(0.1, 11) str(arv11)</code></pre>
<pre><code>## num [1:11] 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 ...</code></pre>
<pre class="r"><code># metade do numero de &#xE1;rvores metade &lt;- length(arv11)/2 metade</code></pre>
<pre><code>## [1] 5.5</code></pre>
<pre class="r"><code># soma todas as &#xE1;rvores soma_todas &lt;- sum(arv11, na.rm = TRUE) soma_todas</code></pre>
<pre><code>## [1] 1.1</code></pre>
<pre class="r"><code># soma o valor de metade das &#xE1;rvores em ordem crescente soma_metade &lt;- sum(sort(arv11)[1:metade], na.rm = TRUE) soma_metade</code></pre>
<pre><code>## [1] 0.5</code></pre>
<pre class="r"><code># calcula o PV50 PV50 &lt;- soma_metade / soma_todas * 100 PV50</code></pre>
<pre><code>## [1] 45.45455</code></pre>
<p>
O resultado deveria ser 50, mas como o número de árvores é impar, o R
arredonda a posição 5,5 para 5 e pega até a quinta árvore no momento em
que queremos somar as 50% menores. Para contornar isso, vamos calcular a
soma das 50% menores árvores de uma forma diferente. Primeiro calculamos
a soma acumulada e depois extraímos a média (semelhante ao modo de se
calcular uma mediana).
</p>
<pre class="r"><code># vetor de soma acumulada soma_acumulada &lt;- cumsum(sort(arv11)) soma_acumulada</code></pre>
<pre><code>## [1] 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1</code></pre>
<pre class="r"><code># soma a metade do vetor de soma acumulada soma_metade &lt;- mean(soma_acumulada[metade + 0L:1L], na.rm = TRUE) soma_metade</code></pre>
<pre><code>## [1] 0.55</code></pre>
<pre class="r"><code># calcula o PV50 PV50 &lt;- soma_metade / soma_todas * 100 PV50</code></pre>
<pre><code>## [1] 50</code></pre>
<p>
Agora que a questão do número de árvores foi superada, podemos incluir
árvores mortas, o que equivale a elementos do tipo <code>NA</code> no R.
Veja que o resultado não está consistente pois a
<code>soma\_acumulada</code> ignorou as árvores mortas.
</p>
<pre class="r"><code># exemplo com valores perdidos arv11_na &lt;- rep(0.1, 11) arv11_na[c(3,4)] &lt;- NA str(arv11_na)</code></pre>
<pre><code>## num [1:11] 0.1 0.1 NA NA 0.1 0.1 0.1 0.1 0.1 0.1 ...</code></pre>
<pre class="r"><code># metade do numero de &#xE1;rvores metade &lt;- length(arv11_na)/2 metade</code></pre>
<pre><code>## [1] 5.5</code></pre>
<pre class="r"><code># soma todas as &#xE1;rvores soma_todas &lt;- sum(arv11_na, na.rm = TRUE) soma_todas</code></pre>
<pre><code>## [1] 0.9</code></pre>
<pre class="r"><code># vetor de soma acumulada soma_acumulada &lt;- cumsum(sort(arv11_na)) soma_acumulada</code></pre>
<pre><code>## [1] 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9</code></pre>
<pre class="r"><code># soma a metade do vetor de soma acumulada soma_metade &lt;- mean(soma_acumulada[metade + 0L:1L], na.rm = TRUE) soma_metade</code></pre>
<pre><code>## [1] 0.55</code></pre>
<pre class="r"><code># calcula o PV50 PV50 &lt;- soma_metade / soma_todas * 100 PV50</code></pre>
<pre><code>## [1] 61.11111</code></pre>
<p>
Para corrigir este o erro, temos de incluir manualmente as árvores
mortas na sequência. Veja que agora o resultado está de acordo com o
esperado.
</p>
<pre class="r"><code># vetor de valores perdidos mortas &lt;- arv11_na[is.na(arv11_na)] mortas</code></pre>
<pre><code>## [1] NA NA</code></pre>
<pre class="r"><code># metade do numero de &#xE1;rvores metade &lt;- length(arv11_na)/2 metade</code></pre>
<pre><code>## [1] 5.5</code></pre>
<pre class="r"><code># soma todas as &#xE1;rvores soma_todas &lt;- sum(arv11_na, na.rm = TRUE) soma_todas</code></pre>
<pre><code>## [1] 0.9</code></pre>
<pre class="r"><code># vetor de soma acumulada com valores perdidos soma_acumulada &lt;- c(mortas, cumsum(sort(arv11_na))) soma_acumulada</code></pre>
<pre><code>## [1] NA NA 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9</code></pre>
<pre class="r"><code># soma a metade do vetor de soma acumulada soma_metade &lt;- mean(soma_acumulada[metade + 0L:1L], na.rm = TRUE) soma_metade</code></pre>
<pre><code>## [1] 0.35</code></pre>
<pre class="r"><code># calcula o PV50 PV50 &lt;- soma_metade / soma_todas * 100 PV50</code></pre>
<pre><code>## [1] 38.88889</code></pre>
<p>
Agora eu vou dar aquele passo mágico dos livros de matemática e física,
em que o autor diz “é fácil notar que o resultado leva a …” e apresentar
uma função que lida com as questões que mostramos acima e retorna o PV50
do nosso conjunto de dados de forma correta.
</p>
<pre class="r"><code>pv50 &lt;- function(x) { mortas &lt;- x[is.na(x)] metade &lt;- length(x)/2 soma_todas &lt;- sum(x, na.rm = TRUE) soma_acumulada &lt;- c(mortas, cumsum(sort(x))) if (metade%%2L == 1L) soma_metade &lt;- mean(soma_acumulada[metade], na.rm = TRUE) else soma_metade &lt;- mean(soma_acumulada[metade + 0L:1L], na.rm = TRUE) z &lt;- soma_metade / soma_todas * 100 return(z) }</code></pre>
<p>
Podemos rapidamente verificar se os resultados estão consistentes
fazendo alguns testes.
</p>
<pre class="r"><code>a &lt;- rep(10, 10) str(a)</code></pre>
<pre><code>## num [1:10] 10 10 10 10 10 10 10 10 10 10</code></pre>
<pre class="r"><code>pv50(a) # Ok!</code></pre>
<pre><code>## [1] 50</code></pre>
<pre class="r"><code>a1 &lt;- rep(10 ,11) str(a1)</code></pre>
<pre><code>## num [1:11] 10 10 10 10 10 10 10 10 10 10 ...</code></pre>
<pre class="r"><code>pv50(a1) # Ok!</code></pre>
<pre><code>## [1] 50</code></pre>
<pre class="r"><code>b &lt;- a b[c(3, 7)] &lt;- NA str(b)</code></pre>
<pre><code>## num [1:10] 10 10 NA 10 10 10 NA 10 10 10</code></pre>
<pre class="r"><code>pv50(b) # Ok!</code></pre>
<pre><code>## [1] 37.5</code></pre>
<pre class="r"><code>b1 &lt;- a1 b1[c(3, 7)] &lt;- NA str(b1)</code></pre>
<pre><code>## num [1:11] 10 10 NA 10 10 10 NA 10 10 10 ...</code></pre>
<pre class="r"><code>pv50(b1) # Ok!</code></pre>
<pre><code>## [1] 38.88889</code></pre>
<p>
Boa, já temos uma função para calcular o PV50 e podemos aplicá-la em um
conjunto de dados para podermos interpretar. Utilizaremos mais uma vez
os dados do
<a href="https://italocegatta.github.io/indice-de-uniformidade-pv50/www.projetotume.com">Projeto
TUME</a>, referente ao <a href="http://www.projetotume.com/tume134">TUME
134</a> plantado em Piracicaba-SP. O volume individual foi calculado
arbitrariamente utilizando o fator de forma 0,5.
</p>
<pre class="r"><code># importa o arquivo tume_55.csv dados &lt;- read_csv2( &quot;https://github.com/italocegatta/italocegatta.github.io_source/raw/master/content/dados/tume_55.csv&quot; ) glimpse(dados)</code></pre>
<pre><code>## Observations: 1,222 ## Variables: 7 ## $ Esp &lt;chr&gt; &quot;E_camaldulensis&quot;, &quot;E_camaldulensis&quot;, &quot;E_camaldulensis... ## $ I_meses &lt;int&gt; 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34... ## $ Parc_m2 &lt;int&gt; 288, 288, 288, 288, 288, 288, 288, 288, 288, 288, 288,... ## $ N_arv &lt;int&gt; 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16,... ## $ DAP_cm &lt;dbl&gt; 5.411268, 12.254931, 3.978874, 6.429860, 9.676621, 5.6... ## $ H_m &lt;dbl&gt; 7.651490, 11.424046, 5.909205, 8.572873, 10.498957, 7.... ## $ Vol &lt;dbl&gt; 0.008798406, 0.067375427, 0.003673747, 0.013918399, 0....</code></pre>
<p>
Iremos calcular o PV50 e o volume por hectare para cada fator
<code>Esp</code> e <code>I\_meses</code> e em seguida ordenar as
espécies pelo PV50.
</p>
<pre class="r"><code># agrupa os dados em fun&#xE7;&#xE3;o de esp&#xE9;cie e idade para # calcular o pv50 e o volume dados_pv50 &lt;- dados %&gt;% group_by(Esp, I_meses) %&gt;% summarise( Parc_m2 = mean( Parc_m2), PV50 = pv50(Vol), Vol_ha = sum(Vol, na.rm = TRUE) * (10000/Parc_m2) ) %&gt;% ungroup() %&gt;% # ordena o fator de esp&#xE9;cies de forma decrescente em fun&#xE7;&#xE3;o do pv50 mutate(Esp = fct_reorder(Esp, -PV50)) dados_pv50</code></pre>
<pre><code>## # A tibble: 20 &#xD7; 5 ## Esp I_meses Parc_m2 PV50 Vol_ha ## &lt;fctr&gt; &lt;int&gt; &lt;dbl&gt; &lt;dbl&gt; &lt;dbl&gt; ## 1 E_camaldulensis 34 288 21.36325 47.50044 ## 2 E_camaldulensis 46 288 14.26669 79.09417 ## 3 E_camaldulensis 60 600 13.18344 110.06612 ## 4 E_camaldulensis 85 288 12.70684 203.98374 ## 5 E_citriodora 34 288 17.84086 46.56646 ## 6 E_citriodora 46 288 16.43760 84.96252 ## 7 E_citriodora 60 600 12.53474 97.00958 ## 8 E_citriodora 85 288 12.73166 205.04360 ## 9 E_dunnii 34 288 28.58694 103.36725 ## 10 E_dunnii 46 288 29.21288 160.54057 ## 11 E_dunnii 60 600 27.46026 198.47239 ## 12 E_dunnii 85 288 26.39616 349.63571 ## 13 E_paniculata 34 288 27.36895 46.43145 ## 14 E_paniculata 46 288 24.13274 84.42312 ## 15 E_paniculata 60 600 19.63065 114.81369 ## 16 E_paniculata 85 288 18.21965 194.87958 ## 17 E_urophylla_grandis 34 288 26.25100 85.67855 ## 18 E_urophylla_grandis 46 288 24.20636 157.30295 ## 19 E_urophylla_grandis 60 600 20.33734 217.30209 ## 20 E_urophylla_grandis 85 288 17.89856 277.37748</code></pre>
<p>
Para entendermos os dados, vamos primeiro ver o crescimento em volume de
cada espécies em função do tempo (Figura
<a href="https://italocegatta.github.io/indice-de-uniformidade-pv50/#fig:12-vol-idade">1</a>).
Note que <em>E. dunnii</em> e <em>E. urophylla</em> x <em>E.
grandis</em> tinham crescimento muito parecido até os 60 meses de idade.
</p>
<pre class="r"><code>ggplot(dados_pv50, aes(I_meses, Vol_ha, color = Esp)) + geom_point() + geom_line() + labs( color = &quot;Esp&#xE9;cies&quot;, x = &quot;Idade (meses)&quot;, y = Volume~m^3~ha^-1 ) + scale_color_brewer(palette = &quot;Set1&quot;) + theme_bw(base_size = 16) + theme(legend.justification = &quot;top&quot;)</code></pre>
<span id="fig:12-vol-idade"></span>
<img src="https://italocegatta.github.io/post/2016-10-09-indice-de-uniformidade-pv50_files/figure-html/12-vol-idade-1.png" alt="Crescimento em volume por hectare em fun&#xE7;&#xE3;o da idade." width="4000">
<p class="caption">
Figura 1: Crescimento em volume por hectare em função da idade.
</p>

<p>
Agora podemos construir um gráfico que relaciona o PV50 e a idade
(Figura
<a href="https://italocegatta.github.io/indice-de-uniformidade-pv50/#fig:12-pv50-idade">2</a>).
A interpretação do índice é simples, o PV50 representa a porcentagem em
volume que as 50% menores árvores contribuem para o volume total. Em
nossos dados, <em>E. dunnii</em>, ao 85 meses de idade, tem um PV50 de
aproximadamente 26. Isso quer dizer que aos 7 anos, as 50% menores
árvores da parcela de <em>E. dunnii</em> representam apenas 26% do
volume total. Ou seja, 50% das árvores contribuem muito pouco para o
volume total da parcela e isso tem um impacto direto na produtividade.
</p>
<pre class="r"><code>ggplot(dados_pv50, aes(I_meses, PV50, color = Esp)) + geom_point() + geom_line() + labs(color = &quot;Esp&#xE9;cies&quot;, x = &quot;Idade (meses)&quot;, y = &quot;PV50&quot;) + scale_color_brewer(palette = &quot;Set1&quot;) + scale_y_continuous(breaks = seq(10, 30, 2)) + theme_bw(base_size = 16) + theme(legend.justification = &quot;top&quot;)</code></pre>
<span id="fig:12-pv50-idade"></span>
<img src="https://italocegatta.github.io/post/2016-10-09-indice-de-uniformidade-pv50_files/figure-html/12-pv50-idade-1.png" alt="Varia&#xE7;&#xE3;o do PV50 por esp&#xE9;cies em fun&#xE7;&#xE3;o da idade." width="4000">
<p class="caption">
Figura 2: Variação do PV50 por espécies em função da idade.
</p>

<p>
A Figura
<a href="https://italocegatta.github.io/indice-de-uniformidade-pv50/#fig:12-pv50-vol">3</a>
mostra claramente a relação direta que há entre produção de madeira e a
uniformidade ao longo do crescimento da floresta. Note também que na
medida em que a idade avança, a uniformidade diminui, pois a dominância
das árvores maiores sobre as menores fica cada vez mais forte.
</p>
<pre class="r"><code>ggplot(dados_pv50, aes(Vol_ha, PV50)) + geom_point(aes(color = factor(I_meses))) + geom_smooth(method = &quot;lm&quot;, formula = y ~x, se = FALSE) + facet_wrap(~Esp, dir = &quot;v&quot;) + labs(color = &quot;Idade (meses)&quot;, x = Volume~m^3~ha^-1, y = &quot;PV50&quot;) + scale_color_brewer(palette = &quot;Dark2&quot;) + theme_bw(base_size = 16) + theme(legend.justification = &quot;top&quot;)</code></pre>
<span id="fig:12-pv50-vol"></span>
<img src="https://italocegatta.github.io/post/2016-10-09-indice-de-uniformidade-pv50_files/figure-html/12-pv50-vol-1.png" alt="Rela&#xE7;&#xE3;o entre o PV50 e volume por hectare em fun&#xE7;&#xE3;o da idade." width="4000">
<p class="caption">
Figura 3: Relação entre o PV50 e volume por hectare em função da idade.
</p>

<p>
Por fim, para colocar tudo em um só gráfico, podemos adicionar ao
gráfico de crescimento em volume a informação do PV50 para evidenciar
que as espécies mais produtivas tem PV50 elevado e que este índice
consegue explicar muito bem essa relação (Figura
<a href="https://italocegatta.github.io/indice-de-uniformidade-pv50/#fig:12-vol-pv50-idade">4</a>).
</p>
<p>
Um comentário interessante é que dentre as espécies que estamos
estudando, todas são de origem seminal, com exceção do <em>E.
dunnii</em>, que é um clone. Este fator explica sua produtividade e alta
homogeneidade, principalmente frente ao hibrido de <em>E. urophylla</em>
x <em>E. grandis</em>, que é seu concorrente direto. Quando estivermos
analisando dados de plantios clonais, o PV50 vai expressar a qualidade
silvicultural do plantio, uma vez que a base genética é a mesma em todas
as plantas.
</p>
<pre class="r"><code>ggplot(dados_pv50, aes(I_meses, Vol_ha, color = Esp)) + geom_point(aes(size = PV50), alpha = 0.4) + geom_line() + labs( color = &quot;Esp&#xE9;cies&quot;, x = &quot;Idade (meses)&quot;, y = Volume~m^3~ha^-1 ) + scale_color_brewer(palette = &quot;Set1&quot;) + theme_bw(base_size = 16) + theme(legend.justification = &quot;top&quot;)</code></pre>
<span id="fig:12-vol-pv50-idade"></span>
<img src="https://italocegatta.github.io/post/2016-10-09-indice-de-uniformidade-pv50_files/figure-html/12-vol-pv50-idade-1.png" alt="Crescimento do volume em fun&#xE7;&#xE3;o da idade, com informa&#xE7;&#xE3;o do PV50 no tamanho do ponto." width="4000">
<p class="caption">
Figura 4: Crescimento do volume em função da idade, com informação do
PV50 no tamanho do ponto.
</p>

<p>
Caso tenha alguma dúvida ou sugestão sobre o post, fique à vontade para
fazer um comentário ou me contactar por Email.
</p>
<pre class="r"><code>devtools::session_info()</code></pre>
<pre><code>## setting value ## version R version 3.3.3 (2017-03-06) ## system x86_64, mingw32 ## ui RTerm ## language (EN) ## collate Portuguese_Brazil.1252 ## tz America/Sao_Paulo ## date 2017-04-30 ## ## package * version date source ## assertthat 0.2.0 2017-04-11 CRAN (R 3.3.3) ## backports 1.0.5 2017-01-18 CRAN (R 3.3.2) ## blogdown 0.0.25 2017-03-23 Github (rstudio/blogdown@1c10d16) ## bookdown 0.3.14 2017-03-23 Github (rstudio/bookdown@f427fdf) ## colorspace 1.3-2 2016-12-14 CRAN (R 3.3.2) ## curl 2.6 2017-04-27 CRAN (R 3.3.3) ## DBI 0.6-1 2017-04-01 CRAN (R 3.3.3) ## devtools 1.12.0 2016-06-24 CRAN (R 3.3.3) ## digest 0.6.12 2017-01-27 CRAN (R 3.3.2) ## dplyr * 0.5.0 2016-06-24 CRAN (R 3.3.2) ## evaluate 0.10 2016-10-11 CRAN (R 3.3.3) ## forcats * 0.2.0 2017-01-23 CRAN (R 3.3.2) ## ggplot2 * 2.2.1 2016-12-30 CRAN (R 3.3.2) ## gtable 0.2.0 2016-02-26 CRAN (R 3.3.2) ## highr 0.6 2016-05-09 CRAN (R 3.3.3) ## hms 0.3 2016-11-22 CRAN (R 3.3.2) ## htmltools 0.3.6 2017-04-28 CRAN (R 3.3.3) ## knitr 1.15.1 2016-11-22 CRAN (R 3.3.3) ## labeling 0.3 2014-08-23 CRAN (R 3.3.2) ## lazyeval 0.2.0 2016-06-12 CRAN (R 3.3.2) ## magrittr 1.5 2014-11-22 CRAN (R 3.3.2) ## memoise 1.1.0 2017-04-21 CRAN (R 3.3.3) ## munsell 0.4.3 2016-02-13 CRAN (R 3.3.2) ## pacman * 0.4.1 2016-03-30 CRAN (R 3.3.3) ## plyr 1.8.4 2016-06-08 CRAN (R 3.3.2) ## R6 2.2.0 2016-10-05 CRAN (R 3.3.2) ## RColorBrewer 1.1-2 2014-12-07 CRAN (R 3.3.2) ## Rcpp 0.12.10 2017-03-19 CRAN (R 3.3.3) ## readr * 1.1.0 2017-03-22 CRAN (R 3.3.3) ## rmarkdown 1.5 2017-04-26 CRAN (R 3.3.3) ## rprojroot 1.2 2017-01-16 CRAN (R 3.3.3) ## scales 0.4.1 2016-11-09 CRAN (R 3.3.2) ## stringi 1.1.5 2017-04-07 CRAN (R 3.3.3) ## stringr 1.2.0 2017-02-18 CRAN (R 3.3.2) ## tibble 1.3.0 2017-04-01 CRAN (R 3.3.3) ## withr 1.0.2 2016-06-20 CRAN (R 3.3.3) ## yaml 2.1.14 2016-11-12 CRAN (R 3.3.3)</code></pre>
<p>
Hakamada, Rodrigo Eiji. 2012. “Uso do inventário florestal como
ferramenta de monitoramento da qualidade silvicultura em povoamentos
clonais de Eucalyptus.” PhD thesis, Piracicaba: Universidade de São
Paulo; Biblioteca Digital de Teses e Dissertações da Universidade de São
Paulo.
doi:<a href="https://doi.org/10.11606/D.11.2012.tde-05072012-100431">10.11606/D.11.2012.tde-05072012-100431</a>.
</p>

<p>
Hakamada, Rodrigo Eiji, José Luiz Stape, Cristiane Camargo Zani de
Lemos, Adriano Emanuel Amaral Almeida, and Luis Fernando Silva. 2015.
“Uniformidade entre árvores durante uma rotação e sua relação com a
produtividade em Eucalyptus clonais.” <em>CERNE</em> 21 (3).
Universidade Federal de Lavras: 465–72.
doi:<a href="https://doi.org/10.1590/01047760201521031716">10.1590/01047760201521031716</a>.
</p>

