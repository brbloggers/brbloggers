+++
title = "O conceito tidy data"
date = "2016-04-30"
categories = ["italocegatta"]
original_url = "https://italocegatta.github.io/o-conceito-tidy-data/"
+++

<p>
A ideia central desse post é bem simples: dados bem organizados valem a
pena e economizam seu tempo!
</p>
<p>
Em minha primeira iniciação científica (quando comecei a trabalhar com o
R), propus um experimento para avaliar a eficiência de 2 inseticidas
para o controle de uma praga que ataca mudas de eucalipto <span
class="citation">(Cegatta and Villegas
<a href="https://italocegatta.github.io/o-conceito-tidy-data/#ref-cegatta_eficiencia_2013">2013</a>)</span>.
Eu estava no primeiro ano da faculdade, sabia muito pouco de Excel e
nada de R.
</p>
<p>
Neste post vou retomar os dados brutos desse experimento e organizá-los
de uma forma eficiente, pois na época não o fiz.
</p>
<p>
No experimento tivemos 5 coletas sucessivas de dados para acompanhar a
evolução do número de galhas em mudas de eucalipto com diferentes
tratamentos de inseticidas. Galha é uma reação da planta que tem
diversas causas, nesse caso específico, é devido à postura de uma vespa
em busca de abrigo para seus ovos.
</p>
<br>
<span id="fig:fig-base"></span>
<img src="http://i.imgur.com/JsYqVH7.png" alt="Dados brutos. Como n&#xE3;o organizar seu banco de dados.">
<p class="caption">
Figura 1: Dados brutos. Como não organizar seu banco de dados.
</p>

<p>
A estrutura do banco de dados que obtive no fim do experimento está
apresentada na Figura
<a href="https://italocegatta.github.io/o-conceito-tidy-data/#fig:fig-base">1</a>.
Para a época, foi o melhor que consegui fazer e pela inexperiência
cometi os seguintes erros:
</p>
<ol>
<li>
Uso de caracteres especiais.
</li>
<li>
Uso de espaço entre as palavras.
</li>
<li>
Células mescladas.
</li>
<li>
Observações (Nº de galhas no pecíolo, nervura e caule) organizadas em
colunas.
</li>
</ol>
<p>
O uso de caracteres especiais não é recomentado em muitas ocasiões, essa
dica vale para quase tudo que envolve computação. O mesmo se aplica para
os espaços entre as palavras, mas podemos ser mais flexíveis neste caso.
Mesclar uma célula será o seu maior problema em uma planilha eletrônica,
cuidado com isso! Recomendo mesclar células em raríssimas exceções, como
formatação de tabelas em Word ou PowerPoint. O meu último erro foi o
maior deles, confundi observações com variáveis. Em minha defesa, o
inexperiente Ítalo tentou organizar os dados em um layout de fácil
visualização. Veja que é fácil acompanhar a evolução das galhas ao longo
do tempo. Para a percepção humana, organização de dados no formato
longitudinal é muito prática e rápida. Mas temos que pensar em como o
computador trabalha e como ele faz todos os cálculos que precisamos. No
fim, eu consegui fazer tudo que eu queria com os dados nesse formato,
mas acredite, foi sofrível e muito ineficiente.
</p>
<p>
O conceito tidy data está muito bem descrito por <span
class="citation">Wickham
(<a href="https://italocegatta.github.io/o-conceito-tidy-data/#ref-wickham_tidy_2014">2014</a>)</span>,
onde ele apresenta o pacote
<a href="https://cran.r-project.org/web/packages/tidyr/index.html">tidyr</a>
que contém uma gama de funções muito úteis para esse fim. Wickham também
dedicou um capítulo específico sobre esse conceito em seu
<a href="http://r4ds.had.co.nz/">livro</a> <span
class="citation">(Grolemund and Wickham
<a href="https://italocegatta.github.io/o-conceito-tidy-data/#ref-grolemund_r_2016">2016</a>)</span>.
Por tidy data, entendemos que:
</p>
<ul>
<li>
Variáveis estão dispostas em colunas.
</li>
<li>
Observações estão dispostas em linhas.
</li>
<li>
Os valores atribuídos às variáveis em cada observação formam a tabela.
</li>
</ul>
<p>
Agora vamos aplicar esse conceito ao meu banco de dados. Podemos fazer
isso de várias formas, vai depender de como iremos entrar com os dados
no R. Vou mostrar 2 métodos que penso ser os mais práticos e genéricos.
</p>
<pre class="r"><code># Pacotes utilizados neste post
if (!require(&quot;pacman&quot;)) install.packages(&quot;pacman&quot;)
pacman::p_load(readxl, dplyr, tidyr, httr)</code></pre>
<p>
Partindo da base de dados original, fiz uma pequena alteração separando
em cada aba as coletas que foram realizadas (Figura
<a href="https://italocegatta.github.io/o-conceito-tidy-data/#fig:fig-entrada1">2</a>).
</p>
<br>
<span id="fig:fig-entrada1"></span>
<img src="http://i.imgur.com/3AsFpmQ.png" alt="Modifica&#xE7;&#xE3;o do banco de dados original para ser importado no R. Divis&#xE3;o das coletas em abas.">
<p class="caption">
Figura 2: Modificação do banco de dados original para ser importado no
R. Divisão das coletas em abas.
</p>

<p>
Como são apenas 4 abas, podemos importá-las usando um comando por linha.
</p>
<p>
Mas e se tivéssemos 50 coletas? Deu preguiça. Vamos melhorar a
importação e deixar o computador trabalhar por nós.
</p>
<pre class="r"><code># Faz o mesmo que os comandos anteriores, mas utiliza um &#xB4;for&#xB4; para repetir # o precesso em todas as abas. dados1 &lt;- list() for(i in 1:5) { dados1[[paste0(&quot;c&quot;,i)]] &lt;- read_excel(base_vespa1, paste0(&quot;Coleta&quot;, i))
}</code></pre>
<p>
Agora precisamos de um fator (nº da coleta) para diferenciarmos cada
medição e colocar tudo em um único data frame.
</p>
<pre class="r"><code># Cria um fator para diferenciar as medi&#xE7;&#xF5;es medi&#xE7;&#xF5;es for(i in names(dados1)) { dados1[[i]][ , &quot;Coleta&quot;] = i } dados1 &lt;- bind_rows(dados1)</code></pre>
<p>
Como minhas análises vão considerar o local da galha como o variável,
devo organizar <em>Peciolo</em>, <em>Nervura</em> e <em>Caule</em> em
uma só coluna denominada <em>Local</em>.
</p>
<pre class="r"><code># Transforma as columas &#xB4;Peciolo&#xB4;, &#xB4;Nervura&#xB4; e &#xB4;Caule&#xB4; em uma s&#xF3; coluna
# denominada &#xB4;Local&#xB4;.
dados1 &lt;- gather( dados1, &quot;Local&quot;, &quot;Galhas&quot;, c(Peciolo, Nervura, Caule)
) dados1</code></pre>
<pre><code>## # A tibble: 2,100 x 5
## Tratamento Individuo Coleta Local Galhas
## &lt;chr&gt; &lt;dbl&gt; &lt;chr&gt; &lt;chr&gt; &lt;dbl&gt;
## 1 Actara d1 1. c1 Peciolo 1.
## 2 Actara d1 2. c1 Peciolo NA ## 3 Actara d1 3. c1 Peciolo NA ## 4 Actara d1 4. c1 Peciolo NA ## 5 Actara d1 5. c1 Peciolo NA ## 6 Actara d1 6. c1 Peciolo NA ## 7 Actara d1 7. c1 Peciolo NA ## 8 Actara d1 8. c1 Peciolo NA ## 9 Actara d1 9. c1 Peciolo NA ## 10 Actara d1 10. c1 Peciolo NA ## # ... with 2,090 more rows</code></pre>

<p>
Nesse método, não fiz nenhuma grande alteração na base de dados. Apenas
corrigi o nome das colunas com um fator que indica o número da coleta e
em seguida o local (Figura
<a href="https://italocegatta.github.io/o-conceito-tidy-data/#fig:fig-entrada2">3</a>).
</p>
<br>
<span id="fig:fig-entrada2"></span>
<img src="http://i.imgur.com/YGY8pvV.png" alt="Modifica&#xE7;&#xE3;o do banco de dados original para ser importado no R. Altera&#xE7;&#xE3;o dos nomes das colunas.">
<p class="caption">
Figura 3: Modificação do banco de dados original para ser importado no
R. Alteração dos nomes das colunas.
</p>

<p>
Vamos agora importar e organizar os dados no mesmo formato que no método
1, mas com um código bem mais simples.
</p>
<pre class="r"><code># L&#xEA; os dados, transforma as vari&#xE1;veis que est&#xE3;o em v&#xE1;rias colunas em uma s&#xF3; e
# Separa as informa&#xE7;&#xF5;es que est&#xE3;o na coluna &#xB4;Local&#xB4; em duas colunas (vari&#xE1;veis)
# &#xB4;Coleta&#xB4; e &#xB4;Local&#xB4;.
dados2 &lt;- read_excel(base_vespa2) %&gt;% gather(&quot;Local&quot;, &quot;Galhas&quot;, 3:dim(.)[2]) %&gt;% separate(Local, c(&quot;Coleta&quot;, &quot;Local&quot;)) dados2</code></pre>
<pre><code>## # A tibble: 2,100 x 5
## Tratamento Individuo Coleta Local Galhas
## &lt;chr&gt; &lt;dbl&gt; &lt;chr&gt; &lt;chr&gt; &lt;dbl&gt;
## 1 Actara d1 1. 1 Peciolo 1.
## 2 Actara d1 2. 1 Peciolo NA ## 3 Actara d1 3. 1 Peciolo NA ## 4 Actara d1 4. 1 Peciolo NA ## 5 Actara d1 5. 1 Peciolo NA ## 6 Actara d1 6. 1 Peciolo NA ## 7 Actara d1 7. 1 Peciolo NA ## 8 Actara d1 8. 1 Peciolo NA ## 9 Actara d1 9. 1 Peciolo NA ## 10 Actara d1 10. 1 Peciolo NA ## # ... with 2,090 more rows</code></pre>
<p>
Com os dados nesse formato fica incrivelmente fácil fazer gráficos,
resumos e testes. Vou abordar esses pontos no futuro em outros posts.
</p>
<p>
Caso tenha alguma dúvida ou sugestão sobre o post, fique à vontade para
fazer um comentário ou me contatar por E-mail.
</p>
<pre class="r"><code>devtools::session_info()</code></pre>
<pre><code>## setting value ## version R version 3.4.3 (2017-11-30)
## system x86_64, mingw32 ## ui RTerm ## language (EN) ## collate Portuguese_Brazil.1252 ## tz America/Sao_Paulo ## date 2018-03-24 ## ## package * version date source ## assertthat 0.2.0 2017-04-11 CRAN (R 3.4.3) ## backports 1.1.2 2017-12-13 CRAN (R 3.4.3) ## base * 3.4.3 2017-12-06 local ## bindr 0.1.1 2018-03-13 CRAN (R 3.4.4) ## bindrcpp 0.2 2017-06-17 CRAN (R 3.4.3) ## blogdown 0.5 2018-01-24 CRAN (R 3.4.4) ## bookdown 0.7 2018-02-18 CRAN (R 3.4.4) ## cellranger 1.1.0 2016-07-27 CRAN (R 3.4.3) ## cli 1.0.0 2017-11-05 CRAN (R 3.4.3) ## compiler 3.4.3 2017-12-06 local ## crayon 1.3.4 2017-09-16 CRAN (R 3.4.3) ## curl 3.1 2017-12-12 CRAN (R 3.4.3) ## datasets * 3.4.3 2017-12-06 local ## devtools 1.13.5 2018-02-18 CRAN (R 3.4.3) ## digest 0.6.15 2018-01-28 CRAN (R 3.4.3) ## dplyr * 0.7.4 2017-09-28 CRAN (R 3.4.3) ## evaluate 0.10.1 2017-06-24 CRAN (R 3.4.3) ## glue 1.2.0 2017-10-29 CRAN (R 3.4.3) ## graphics * 3.4.3 2017-12-06 local ## grDevices * 3.4.3 2017-12-06 local ## highr 0.6 2016-05-09 CRAN (R 3.4.3) ## htmltools 0.3.6 2017-04-28 CRAN (R 3.4.3) ## httr * 1.3.1 2017-08-20 CRAN (R 3.4.3) ## knitr 1.20 2018-02-20 CRAN (R 3.4.4) ## magrittr 1.5 2014-11-22 CRAN (R 3.4.3) ## memoise 1.1.0 2017-04-21 CRAN (R 3.4.3) ## methods * 3.4.3 2017-12-06 local ## pacman * 0.4.6 2017-05-14 CRAN (R 3.4.3) ## pillar 1.2.1 2018-02-27 CRAN (R 3.4.4) ## pkgconfig 2.0.1 2017-03-21 CRAN (R 3.4.3) ## purrr 0.2.4 2017-10-18 CRAN (R 3.4.3) ## R6 2.2.2 2017-06-17 CRAN (R 3.4.3) ## Rcpp 0.12.16 2018-03-13 CRAN (R 3.4.4) ## readxl * 1.0.0 2017-04-18 CRAN (R 3.4.3) ## rlang 0.2.0.9001 2018-03-25 Github (r-lib/rlang@870a6bf) ## rmarkdown 1.9 2018-03-01 CRAN (R 3.4.4) ## rprojroot 1.3-2 2018-01-03 CRAN (R 3.4.3) ## stats * 3.4.3 2017-12-06 local ## stringi 1.1.7 2018-03-12 CRAN (R 3.4.4) ## stringr 1.3.0 2018-02-19 CRAN (R 3.4.4) ## tibble 1.4.2 2018-01-22 CRAN (R 3.4.3) ## tidyr * 0.8.0 2018-01-29 CRAN (R 3.4.3) ## tidyselect 0.2.4 2018-02-26 CRAN (R 3.4.4) ## tools 3.4.3 2017-12-06 local ## utf8 1.1.3 2018-01-03 CRAN (R 3.4.3) ## utils * 3.4.3 2017-12-06 local ## withr 2.1.2 2018-03-25 Github (jimhester/withr@79d7b0d)
## xfun 0.1 2018-01-22 CRAN (R 3.4.4) ## yaml 2.1.18 2018-03-08 CRAN (R 3.4.4)</code></pre>

