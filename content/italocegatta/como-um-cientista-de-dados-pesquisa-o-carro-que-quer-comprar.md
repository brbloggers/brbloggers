+++
title = "Como um cientista de dados pesquisa o carro que quer comprar?"
date = "2017-07-29"
categories = ["italocegatta"]
original_url = "https://italocegatta.github.io/como-um-cientista-de-dados-pesquisa-o-carro-que-quer-comprar/"
+++

<p>
Estou naquela parte da vida em que se planeja comprar um carro. Como eu
sou, acima de todos os sonhos, pão duro, decidir qual marca, modelo,
versão e ano do veículo não vai ser fácil. Pensando nisso resolvi
escrever um pacote no R para me ajudar a tomar esta decisão. O objetivo
deste post é apresentar o pacote e as funções que auxiliam na coleta das
informações da tabela <a href="http://veiculos.fipe.org.br/">FIPE</a>.
</p>
<p>
Para aqueles que já passaram pela etapa de compra ou venda de um carro,
provavelmente já consultaram a famosa tabela. Nas palavras do próprio
site da FIPE:
</p>
<blockquote>
<p>
A Tabela Fipe expressa preços médios de veículos no mercado nacional,
servindo apenas como um parâmetro para negociações ou avaliações. Os
preços efetivamente praticados variam em função da região, conservação,
cor, acessórios ou qualquer outro fator que possa influenciar as
condições de oferta e procura por um veículo específico.
</p>
</blockquote>
<p>
A motivação para este pacote foi exclusivamente pessoal e por isso a
utilização das funções está bastante restrita. Por isso, se alguém
quiser ajudar no desenvolvimento do pacote é só chegar e mandar um
<a href="https://github.com/italocegatta/fipe">Pull Request</a> no
Github, contribuições serão muito bem vindas.
</p>
<p>
Primeiro vou mostrar as funções e o workflow idealizado para o pacote.
Queremos saber, por enquanto, o preço atual de uma BMW X6 M ano 2015. O
primeiro passo é definir o mês de referência que se deseja consultar o
preço do veículo. A FIPE disponibiliza os valores consolidados desde
janeiro de 2001.
</p>
<pre class="r"><code>if (!require(&quot;pacman&quot;)) install.packages(&quot;pacman&quot;)
pacman::p_load(dplyr, purrr, stringr, tidyr, forcats, ggplot2)
pacman::p_load_gh(&quot;italocegatta/fipe&quot;)</code></pre>
<pre class="r"><code>fipe_referencia()</code></pre>
<pre><code>## # A tibble: 199 x 2
## data_ref cod_ref
## &lt;date&gt; &lt;int&gt;
## 1 2017-07-01 215
## 2 2017-06-01 214
## 3 2017-05-01 212
## 4 2017-04-01 211
## 5 2017-03-01 207
## 6 2017-02-01 205
## 7 2017-01-01 202
## 8 2016-12-01 200
## 9 2016-11-01 198
## 10 2016-10-01 197
## # ... with 189 more rows</code></pre>
<p>
Como o objetivo saber o preço atual do veículo, pegaremos o código
<code>215</code> (mês em que escrevo este post). Agora vamos procurar o
código da marca BMW. Note que precisamos inserir o código do mês de
referência para consultar a marca, essa é uma exigência do site da FIPE.
Lembrando que o pacote não possui nenhum banco de dados armazenado,
todas as informações são consultadas no site da tabela FIPE no ato da
execução da função.
</p>
<pre class="r"><code>fipe_marca(cod_ref = 215)</code></pre>
<pre><code>## # A tibble: 87 x 2
## marca cod_marca
## &lt;chr&gt; &lt;int&gt;
## 1 Acura 1
## 2 Agrale 2
## 3 Alfa Romeo 3
## 4 AM Gen 4
## 5 Asia Motors 5
## 6 ASTON MARTIN 189
## 7 Audi 6
## 8 BMW 7
## 9 BRM 8
## 10 Buggy 9
## # ... with 77 more rows</code></pre>
<p>
Por sorte, o código <code>7</code> da BMW aparece logo nos primeiros
valores por ordem alfabética. Podemos seguir para o próximo passo e
pegar o código do modelo que queremos. A consulta a baixo mostras que a
BMW tem 221 modelos cadastrados na tabela FIPE. Como já definimos o
modelo que queremos, vamos filtrar do dataframe para enxergar o código
do modelo.
</p>
<pre class="r"><code>(bmw &lt;- fipe_modelo(cod_ref = 215, cod_marca = 7))</code></pre>
<pre><code>## # A tibble: 221 x 2
## modelo cod_modelo
## &lt;chr&gt; &lt;int&gt;
## 1 116iA 1.6 TB 16V 136cv 5p 6146
## 2 118iA 2.0 16V 136cv 3p 5576
## 3 118iA 2.0 16V 136cv 5p 4960
## 4 118iA Full 1.6 TB 16V 170cv 5p 6147
## 5 118iA/ Urban/Sport 1.6 TB 16V 170cv 5p 5923
## 6 120i 2.0 16V 150cv/ 156cv 5p 152
## 7 120iA 2.0 16V 150cv/ 156cv 5p 153
## 8 120iA 2.0 16V 156cv 3p 4700
## 9 120iA Cabrio 2.0 16V 156cv 2p 4683
## 10 120iA Sport 2.0 ActiveFlex 16V Aut. 7178
## # ... with 211 more rows</code></pre>
<pre class="r"><code>filter(bmw, str_detect(modelo, &quot;X6 M&quot;))</code></pre>
<pre><code>## # A tibble: 1 x 2
## modelo cod_modelo
## &lt;chr&gt; &lt;int&gt;
## 1 X6 M 4.4 4x4 V8 32V Bi-Turbo Aut. 5189</code></pre>
<p>
Pronto, agora já sabemos que o código que a FIPE dá para o modelo X6 M é
o <code>5189</code>. Teríamos tudo pronto, se não fosse o padrão que a
FIPE adota no campo<code>ano</code>, onde o ano do modelo é acrescido de
um código de combustível. A diferenciação para os “0 km” é feita na
mesma coluna, utilizando a identificação 32000-\*. Enfim, contornando as
falhas estruturais no banco de dados deles, agora sabemos os códigos que
identificam o ano do modelo, bem como o carro 0 km. Como eu optei por
procurar o valor do carro 2015, iremos considerar o código
<code>2015-1</code>.
</p>
<pre class="r"><code>fipe_ano(cod_ref = 215, cod_marca = 7, cod_modelo = 5189)</code></pre>
<pre><code>## # A tibble: 9 x 2
## ano cod_ano
## &lt;chr&gt; &lt;chr&gt;
## 1 0 km 32000-1
## 2 2017 2017-1
## 3 2016 2016-1
## 4 2015 2015-1
## 5 2014 2014-1
## 6 2013 2013-1
## 7 2012 2012-1
## 8 2011 2011-1
## 9 2010 2010-1</code></pre>
<p>
Agora sim vamos ao bendito preço da BMW!
</p>
<pre class="r"><code>fipe(cod_ref = 215, cod_marca = 7, cod_modelo = 5189, cod_ano = &quot;2015-1&quot;) %&gt;% glimpse()</code></pre>
<pre><code>## Observations: 1
## Variables: 7
## $ cod_fipe &lt;chr&gt; &quot;009144-8&quot;
## $ ref &lt;date&gt; 2017-07-01
## $ marca &lt;chr&gt; &quot;BMW&quot;
## $ modelo &lt;chr&gt; &quot;X6 M 4.4 4x4 V8 32V Bi-Turbo Aut.&quot;
## $ ano &lt;chr&gt; &quot;2015&quot;
## $ combustivel &lt;chr&gt; &quot;Gasolina&quot;
## $ valor &lt;dbl&gt; 368603</code></pre>
<p>
Achamos o preço do carro que eu queria. Apenas R$ 368 mil. Uma
pechincha. Obviamente, saber quanto vale uma BMW X6 não faz diferênça
alguma no meu dia. Um abraço pra quem tem condições de comprar um carro
desse sem precisar vender um rim.
</p>
<p>
Agora que já conhecemos as funções e o fluxo para consultar o valor dos
carros, vamos ampliar a consulta e justificar as horas que passamos
aprendendo a programar. Já sabemos o preço do X6 M em julho/2017, mas e
nos meses anteriores? Como será que foi a depreciação média do carro
usado nos últimos meses? E os outros modelos X6, quanto será que estão
valendo?
</p>
<p>
Digamos que, agora, estas questões podem ser respondidas de forma bem
rápida. Eu mostro.
</p>
<p>
Vamos retomar os passos, mas agora no nível hard. Vou analisar o
comportamento dos preços desde 2009. Para deixar a consulta mais rápida,
serão considerados apenas 3 meses de referência por ano.
</p>
<pre class="r"><code>(base_marca &lt;- fipe_referencia() %&gt;% filter(data_ref %in% seq.Date(as.Date(&quot;2009-01-01&quot;), as.Date(&quot;2017-07-01&quot;), by = &quot;4 months&quot;)) %&gt;% mutate(marca = map(cod_ref, fipe_marca)) %&gt;% unnest() %&gt;% filter(marca == &quot;BMW&quot;)
)</code></pre>
<pre><code>## # A tibble: 26 x 4
## data_ref cod_ref marca cod_marca
## &lt;date&gt; &lt;int&gt; &lt;chr&gt; &lt;int&gt;
## 1 2017-05-01 212 BMW 7
## 2 2017-01-01 202 BMW 7
## 3 2016-09-01 196 BMW 7
## 4 2016-05-01 191 BMW 7
## 5 2016-01-01 187 BMW 7
## 6 2015-09-01 183 BMW 7
## 7 2015-05-01 179 BMW 7
## 8 2015-01-01 174 BMW 7
## 9 2014-09-01 170 BMW 7
## 10 2014-05-01 166 BMW 7
## # ... with 16 more rows</code></pre>
<p>
Notem que agora temos um dataframe com códigos de referência entre
janeiro/2008 a maio/2017. Seguindo a análise, precisamos encontrar os
códigos dos modelos X6.
</p>
<pre class="r"><code>(base_modelo &lt;- mutate(base_marca, modelo = map2(cod_ref, cod_marca, fipe_modelo)) %&gt;% unnest() %&gt;% filter(str_detect(modelo, &quot;X6&quot;))
)</code></pre>
<pre><code>## # A tibble: 82 x 6
## data_ref cod_ref marca cod_marca modelo
## &lt;date&gt; &lt;int&gt; &lt;chr&gt; &lt;int&gt; &lt;chr&gt;
## 1 2017-05-01 212 BMW 7 X6 M 4.4 4x4 V8 32V Bi-Turbo Aut.
## 2 2017-05-01 212 BMW 7 X6 XDRIVE 35i 3.0 306cv Bi-Turbo
## 3 2017-05-01 212 BMW 7 X6 XDRIVE 50i 4.4 407cv Bi-Turbo
## 4 2017-05-01 212 BMW 7 X6 XDRIVE 50i M Sport 4.4 Bi-Turbo
## 5 2017-01-01 202 BMW 7 X6 M 4.4 4x4 V8 32V Bi-Turbo Aut.
## 6 2017-01-01 202 BMW 7 X6 XDRIVE 35i 3.0 306cv Bi-Turbo
## 7 2017-01-01 202 BMW 7 X6 XDRIVE 50i 4.4 407cv Bi-Turbo
## 8 2017-01-01 202 BMW 7 X6 XDRIVE 50i M Sport 4.4 Bi-Turbo
## 9 2016-09-01 196 BMW 7 X6 M 4.4 4x4 V8 32V Bi-Turbo Aut.
## 10 2016-09-01 196 BMW 7 X6 XDRIVE 35i 3.0 306cv Bi-Turbo
## # ... with 72 more rows, and 1 more variables: cod_modelo &lt;int&gt;</code></pre>
<p>
O próximo passo é pegar, para cada versão, os diferentes anos de
fabricação do carro. A função vai consultar os anos de fabricação que a
FIPE consolidou para cada uma das 82 linhas (combinação entre modelo e
mês de referência).
</p>
<pre class="r"><code>(base_consulta &lt;- mutate(base_modelo, ano = pmap(list(cod_ref, cod_marca, cod_modelo), fipe_ano)) %&gt;% unnest()
)</code></pre>
<pre><code>## # A tibble: 480 x 8
## data_ref cod_ref marca cod_marca modelo
## &lt;date&gt; &lt;int&gt; &lt;chr&gt; &lt;int&gt; &lt;chr&gt;
## 1 2017-05-01 212 BMW 7 X6 M 4.4 4x4 V8 32V Bi-Turbo Aut.
## 2 2017-05-01 212 BMW 7 X6 M 4.4 4x4 V8 32V Bi-Turbo Aut.
## 3 2017-05-01 212 BMW 7 X6 M 4.4 4x4 V8 32V Bi-Turbo Aut.
## 4 2017-05-01 212 BMW 7 X6 M 4.4 4x4 V8 32V Bi-Turbo Aut.
## 5 2017-05-01 212 BMW 7 X6 M 4.4 4x4 V8 32V Bi-Turbo Aut.
## 6 2017-05-01 212 BMW 7 X6 M 4.4 4x4 V8 32V Bi-Turbo Aut.
## 7 2017-05-01 212 BMW 7 X6 M 4.4 4x4 V8 32V Bi-Turbo Aut.
## 8 2017-05-01 212 BMW 7 X6 M 4.4 4x4 V8 32V Bi-Turbo Aut.
## 9 2017-05-01 212 BMW 7 X6 M 4.4 4x4 V8 32V Bi-Turbo Aut.
## 10 2017-05-01 212 BMW 7 X6 XDRIVE 35i 3.0 306cv Bi-Turbo
## # ... with 470 more rows, and 3 more variables: cod_modelo &lt;int&gt;,
## # ano &lt;chr&gt;, cod_ano &lt;chr&gt;</code></pre>
<p>
Se na sua internet a função anterior demorou, prepara que a próxima vai
demorar um tanto mais. Temos 480 requisições para fazer no site da FIPE
em busca dos preços que queremos.
</p>
<pre class="r"><code>(consulta &lt;- mutate( base_consulta, consulta = pmap(list(cod_ref, cod_marca, cod_modelo, cod_ano), fipe) ) %&gt;% select(consulta) %&gt;% unnest() %&gt;% select(ref, modelo, ano, valor)
)</code></pre>
<pre><code>## # A tibble: 480 x 4
## ref modelo ano valor
## &lt;date&gt; &lt;chr&gt; &lt;chr&gt; &lt;dbl&gt;
## 1 2017-05-01 X6 M 4.4 4x4 V8 32V Bi-Turbo Aut. 0 km 644550
## 2 2017-05-01 X6 M 4.4 4x4 V8 32V Bi-Turbo Aut. 2017 520193
## 3 2017-05-01 X6 M 4.4 4x4 V8 32V Bi-Turbo Aut. 2016 475803
## 4 2017-05-01 X6 M 4.4 4x4 V8 32V Bi-Turbo Aut. 2015 365088
## 5 2017-05-01 X6 M 4.4 4x4 V8 32V Bi-Turbo Aut. 2014 317505
## 6 2017-05-01 X6 M 4.4 4x4 V8 32V Bi-Turbo Aut. 2013 291749
## 7 2017-05-01 X6 M 4.4 4x4 V8 32V Bi-Turbo Aut. 2012 231191
## 8 2017-05-01 X6 M 4.4 4x4 V8 32V Bi-Turbo Aut. 2011 204481
## 9 2017-05-01 X6 M 4.4 4x4 V8 32V Bi-Turbo Aut. 2010 193629
## 10 2017-05-01 X6 XDRIVE 35i 3.0 306cv Bi-Turbo 0 km 415744
## # ... with 470 more rows</code></pre>
<p>
Depois de 4 passos, temos o banco de dados desejado. Imagina coletar
estes dados, na mão, pelo site oficial!
</p>
<p>
Bom agora o pacote está apresentado. Pretendo fazer outros posts com
estudos de casos mais específicos, portanto vou deixar apenas um gráfico
que resume a consulta que acabamos de fazer.
</p>
<pre class="r"><code>consulta %&gt;% mutate(ano = fct_relevel(ano, &quot;0 km&quot;, after = Inf)) %&gt;% ggplot(aes(ref, valor, color = ano, group = ano)) + geom_line(color = &quot;grey30&quot;) + geom_point(size = 3) + facet_wrap(~modelo) + labs( x = &quot;M&#xEA;s de ref&#xEA;rencia&quot;, y = &quot;Valor (R$)&quot;, color = &quot;Ano do \nmodelo&quot; ) + scale_y_continuous(breaks = seq(0, 700000, 50000), labels = scales::dollar_format(prefix = NULL, big.mark = &quot;.&quot;)) + scale_x_date(date_breaks = &quot;1 year&quot;, date_labels = &quot;%b/%y&quot;) + scale_color_viridis_d() + theme_bw() + theme(legend.position = &quot;top&quot;) </code></pre>
<p>
<img src="https://italocegatta.github.io/post/2017-07-29-como-um-cientista-de-dados-pesquisa-o-carro-que-quer-comprar_files/figure-html/plot_fipe-1.png" width="4800">
</p>
<p>
Caso tenha alguma dúvida ou sugestão sobre o post, fique à vontade para
fazer um comentário ou me contactar por Email.
</p>
<pre class="r"><code>devtools::session_info()</code></pre>
<pre><code>## setting value ## version R version 3.3.3 (2017-03-06)
## system x86_64, mingw32 ## ui RTerm ## language (EN) ## collate Portuguese_Brazil.1252 ## tz America/Sao_Paulo ## date 2017-07-29 ## ## package * version date source ## assertthat 0.2.0 2017-04-11 CRAN (R 3.3.3) ## backports 1.1.0 2017-05-22 CRAN (R 3.3.3) ## base * 3.3.3 2017-03-06 local ## bindr 0.1 2016-11-13 CRAN (R 3.3.3) ## bindrcpp * 0.2 2017-06-17 CRAN (R 3.3.3) ## blogdown 0.0.25 2017-03-23 Github (rstudio/blogdown@1c10d16) ## bookdown 0.4 2017-05-20 CRAN (R 3.3.3) ## colorspace 1.3-2 2016-12-14 CRAN (R 3.3.2) ## curl 2.8.1 2017-07-21 CRAN (R 3.3.3) ## datasets * 3.3.3 2017-03-06 local ## devtools 1.13.2 2017-06-02 CRAN (R 3.3.3) ## digest 0.6.12 2017-01-27 CRAN (R 3.3.2) ## dplyr * 0.7.2 2017-07-20 CRAN (R 3.3.3) ## evaluate 0.10.1 2017-06-24 CRAN (R 3.3.3) ## fipe * 0.0.0.9000 2017-07-29 local ## forcats * 0.2.0 2017-01-23 CRAN (R 3.3.2) ## ggplot2 * 2.2.1.9000 2017-07-15 Github (tidyverse/ggplot2@45853c7)
## glue 1.1.1 2017-06-21 CRAN (R 3.3.3) ## graphics * 3.3.3 2017-03-06 local ## grDevices * 3.3.3 2017-03-06 local ## grid 3.3.3 2017-03-06 local ## gtable 0.2.0 2016-02-26 CRAN (R 3.3.2) ## hms 0.3 2016-11-22 CRAN (R 3.3.2) ## htmltools 0.3.6 2017-04-28 CRAN (R 3.3.3) ## httr 1.2.1 2016-07-03 CRAN (R 3.3.2) ## jsonlite 1.5 2017-06-01 CRAN (R 3.3.3) ## knitr 1.16 2017-05-18 CRAN (R 3.3.3) ## lazyeval 0.2.0 2016-06-12 CRAN (R 3.3.2) ## lubridate 1.6.0 2016-09-13 CRAN (R 3.3.2) ## magrittr 1.5 2014-11-22 CRAN (R 3.3.2) ## memoise 1.1.0 2017-04-21 CRAN (R 3.3.3) ## methods 3.3.3 2017-03-06 local ## munsell 0.4.3 2016-02-13 CRAN (R 3.3.2) ## pacman * 0.4.6 2017-05-14 CRAN (R 3.3.3) ## pkgconfig 2.0.1 2017-03-21 CRAN (R 3.3.3) ## plyr 1.8.4 2016-06-08 CRAN (R 3.3.2) ## purrr * 0.2.2.2 2017-05-11 CRAN (R 3.3.3) ## R6 2.2.2 2017-06-17 CRAN (R 3.3.3) ## Rcpp 0.12.12 2017-07-15 CRAN (R 3.3.3) ## readr 1.1.1 2017-05-16 CRAN (R 3.3.3) ## rlang 0.1.1 2017-05-18 CRAN (R 3.3.3) ## rmarkdown 1.6 2017-06-15 CRAN (R 3.3.3) ## rprojroot 1.2 2017-01-16 CRAN (R 3.3.3) ## scales 0.4.1.9002 2017-07-15 Github (hadley/scales@6db7b6f) ## stats * 3.3.3 2017-03-06 local ## stringi 1.1.5 2017-04-07 CRAN (R 3.3.3) ## stringr * 1.2.0 2017-02-18 CRAN (R 3.3.2) ## tibble 1.3.3 2017-05-28 CRAN (R 3.3.3) ## tidyr * 0.6.3 2017-05-15 CRAN (R 3.3.3) ## tools 3.3.3 2017-03-06 local ## utils * 3.3.3 2017-03-06 local ## viridisLite 0.2.0 2017-03-24 CRAN (R 3.3.3) ## withr 1.0.2 2016-06-20 CRAN (R 3.3.3) ## yaml 2.1.14 2016-11-12 CRAN (R 3.3.3)</code></pre>

