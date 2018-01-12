+++
title = "Meta-análise R (1): Quais são os pacotes mais baixados?"
date = "2016-05-25 03:00:00"
categories = ["paixao-por-dados"]
original_url = "http://sillasgonzaga.github.io/2016-05-25-metaanalise_1/"
+++

<article class="blog-post">
<p>
Este é o primeiro post de uma nova série sobre meta-análises de pacotes
R. Com o pacote <code class="highlighter-rouge">miniCRAN</code> é
possível baixar logs de downloads de pacotes de R por meio do
<a href="https://cran.rstudio.com/">espelho (mirror) do RStudio do
CRAN</a>. Cada linha nesses logs representa um download de um pacote por
um usuário.
</p>
<p>
O objetivo desta série é analisar os dados gerados por esses logs.
</p>
<p>
Para este primeiro post, é mostrado:
</p>
<ul>
<li>
Como baixar os logs de downloads de pacotes do CRAN do RStudio de forma
automatizada com o pacote
<code class="highlighter-rouge">miniCRAN</code>;
</li>
<li>
Como selecionar os pacotes R mais populares pelo
<a href="https://pt.wikipedia.org/wiki/Princ%C3%ADpio_de_Pareto">Princípio
de Pareto</a>;
</li>
<li>
Os 20 pacotes mais populares;
</li>
<li>
Um grafo de redes criado a partir dos pacotes mais populares filtrados e
suas dependências.
</li>
</ul>
<p>
Os pacotes usados neste post são:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="c1">#library(installr)</span><span class="w">
</span><span class="n">suppressMessages</span><span class="p">(</span><span class="n">library</span><span class="p">(</span><span class="n">dplyr</span><span class="p">))</span><span class="w"> </span><span class="c1"># Usado para agregar os dados em pacotes</span><span class="w">
</span><span class="n">suppressMessages</span><span class="p">(</span><span class="n">library</span><span class="p">(</span><span class="n">igraph</span><span class="p">))</span><span class="w"> </span><span class="c1"># Usado para plotar o grafo criado pelo miniCRAN</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">miniCRAN</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">ggplot2</span><span class="p">)</span><span class="w"> </span><span class="n">library</span><span class="p">(</span><span class="n">ggthemes</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">scales</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">feather</span><span class="p">)</span><span class="w"> </span><span class="c1"># Usado para carregar arquivos</span></code></pre>
</figure>
<p>
As linhas abaixo mostram como eu baixei os logs da mirror do RStudio do
CRAN para o período entre 24 de Abril de 2016 a 24 de Maio a 2016. Os
logs de cada dia desse período são salvos na pasta indicada no argumento
<code class="highlighter-rouge">log\_folder</code>, totalizando cerca de
250 MB. O dataframe gerado com o código gerado é enorme, por isso é
recomendável removê-lo da memória após realizar os filtros desejados a
partir dele.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">temp_dir</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">download_RStudio_CRAN_data</span><span class="p">(</span><span class="n">START</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s1">&apos;2016-04-24&apos;</span><span class="p">,</span><span class="n">END</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s1">&apos;2016-05-24&apos;</span><span class="p">,</span><span class="w"> </span><span class="n">log_folder</span><span class="o">=</span><span class="s2">&quot;/home/sillas/R/data&quot;</span><span class="p">)</span><span class="w">
</span><span class="n">df_cran</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">read_RStudio_CRAN_data</span><span class="p">(</span><span class="s2">&quot;/home/sillas/R/data&quot;</span><span class="p">)</span><span class="w">
</span><span class="c1">#save(df_cran, file = &quot;/home/sillas/R/data/df_cran.Rdata&quot;)</span><span class="w">
</span><span class="c1">#load(&quot;/home/sillas/R/data/df_cran.Rdata&quot;)</span><span class="w"> </span><span class="c1"># Agregar logs por pacote:</span><span class="w"> </span><span class="c1"># df_pkgs &lt;- df_cran %&gt;%</span><span class="w">
</span><span class="c1"># group_by(package) %&gt;%</span><span class="w">
</span><span class="c1"># summarise(downloads = n()) %&gt;%</span><span class="w">
</span><span class="c1"># arrange(desc(downloads)) %&gt;%</span><span class="w">
</span><span class="c1"># mutate(downloads_acum = cumsum(downloads))</span><span class="w"> </span><span class="c1">#rm(df_cran)</span></code></pre>
</figure>
<p>
Para não ter de carregar o objeto
<code class="highlighter-rouge">df\_cran</code> toda vez que eu
renderizo o arquivo markdown deste post, salvei uma cópia em disco do
dataframe <code class="highlighter-rouge">df\_pkgs</code>. Para isso,
usei o pacote <code class="highlighter-rouge">feather</code>, que torna
os processos de escrita e leitura de arquivos no R
<a href="https://blog.rstudio.org/2016/03/29/feather/">muito
rápidas</a>.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="c1">#write_feather(df_pkgs, &quot;df_pkgs.feather&quot;)</span><span class="w">
</span><span class="n">df_pkgs</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">read_feather</span><span class="p">(</span><span class="s2">&quot;/home/sillas/R/Projetos/PaixaoPorDados/sillasgonzaga.github.io/data/df_pkgs.feather&quot;</span><span class="p">)</span><span class="w">
</span><span class="n">print</span><span class="p">(</span><span class="n">df_pkgs</span><span class="p">,</span><span class="w"> </span><span class="m">10</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## Source: local data frame [9,236 x 3]
## ## package downloads downloads_acum
## &lt;chr&gt; &lt;int&gt; &lt;int&gt;
## 1 RcppArmadillo 425443 425443
## 2 Rcpp 285869 711312
## 3 ggplot2 246536 957848
## 4 digest 210749 1168597
## 5 stringr 207837 1376434
## 6 plyr 203498 1579932
## 7 stringi 202125 1782057
## 8 magrittr 195198 1977255
## 9 scales 194719 2171974
## 10 reshape2 182363 2354337
## .. ... ... ...</code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-r"><span class="nf">dim</span><span class="p">(</span><span class="n">df_pkgs</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## [1] 9236 3</code></pre>
</figure>
<p>
Temos que 9236 diferentes pacotes foram baixados no período analisado.
</p>
<p>
Para determinar a quantidade de pacotes a serem analisados como membros
de uma rede, usei o Princípio de Pareto:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="p">(</span><span class="n">total_downloads</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="nf">sum</span><span class="p">(</span><span class="n">df_pkgs</span><span class="o">$</span><span class="n">downloads</span><span class="p">))</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## [1] 17491320</code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-r"><span class="p">(</span><span class="n">limite80</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">total_downloads</span><span class="w"> </span><span class="o">*</span><span class="w"> </span><span class="m">0.80</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## [1] 13993056</code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-r"><span class="n">df_pkgs_pareto</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">filter</span><span class="p">(</span><span class="n">df_pkgs</span><span class="p">,</span><span class="w"> </span><span class="n">downloads_acum</span><span class="w"> </span><span class="o">&lt;=</span><span class="w"> </span><span class="n">limite80</span><span class="p">)</span><span class="w"> </span><span class="n">nrow</span><span class="p">(</span><span class="n">df_pkgs_pareto</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## [1] 335</code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-r"><span class="m">100</span><span class="o">*</span><span class="n">nrow</span><span class="p">(</span><span class="n">df_pkgs_pareto</span><span class="p">)</span><span class="o">/</span><span class="n">nrow</span><span class="p">(</span><span class="n">df_pkgs</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## [1] 3.627111</code></pre>
</figure>
<p>
Temos que 335 pacotes, cerca de 3,6% do total, equivalem a 80% de todos
os downloads de pacotes nos últimos 30 dias, o que mostra que a regra de
Pareto é aplicável aqui e que, apesar de haver milhares de pacotes
disponíveis no CRAN, a grande maioria deles não são baixados muitas
vezes, como mostram as seguintes estatísticas:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">summary</span><span class="p">(</span><span class="n">df_pkgs</span><span class="o">$</span><span class="n">downloads</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## Min. 1st Qu. Median Mean 3rd Qu. Max. ## 1 137 182 1894 315 425400</code></pre>
</figure>
<p>
O número mediano de downloads por usuário é de 182, muito distante dos
10 mais populares mostrados acima.
</p>
<p>
Os vinte pacotes mais baixados são:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">df_pkgs_pareto</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">top_n</span><span class="p">(</span><span class="m">20</span><span class="p">,</span><span class="w"> </span><span class="n">wt</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">downloads</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">ggplot</span><span class="p">(</span><span class="n">aes</span><span class="p">(</span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">reorder</span><span class="p">(</span><span class="n">package</span><span class="p">,</span><span class="w"> </span><span class="n">downloads</span><span class="p">),</span><span class="w"> </span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">downloads</span><span class="p">))</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">geom_bar</span><span class="p">(</span><span class="n">stat</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;identity&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">fill</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;#014d64&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">labs</span><span class="p">(</span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Quantidade de downloads\n entre Abril e Maio/2016&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">scale_y_continuous</span><span class="p">(</span><span class="n">labels</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">comma</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">coord_flip</span><span class="p">()</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">theme_economist</span><span class="p">()</span><span class="w"> </span></code></pre>
</figure>
<p>
<img src="http://sillasgonzaga.github.io/figs/metaanalise_1/unnamed-chunk-6-1.png" alt="center">
</p>
<p>
Pessoalmente, não fiquei surpreso ao ver que, dos 6 pacotes mais
baixados, 3 (ggplot2, stringr e plyr) fazem parte do Hadleyverse, ou
seja, foram criados pelo gênio Hadley Wickham, que revolucionou o modo
como o R é usado e é ídolo para muitos usuários da linguagem, como eu
:).
</p>
<p>
Após filtrar os pacotes que entrarão na análise, o pacote miniCRAN é
usado para extrair as dependências de cada um e formar uma rede deles. A
função <code class="highlighter-rouge">makeDepGraph</code> extrai as
dependências dos pacotes indicados na função e cria um grafo. Por
exemplo:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">pkgDep</span><span class="p">(</span><span class="s2">&quot;ggplot2&quot;</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## [1] &quot;ggplot2&quot; &quot;digest&quot; &quot;gtable&quot; &quot;MASS&quot; ## [5] &quot;plyr&quot; &quot;reshape2&quot; &quot;scales&quot; &quot;Rcpp&quot; ## [9] &quot;stringr&quot; &quot;RColorBrewer&quot; &quot;dichromat&quot; &quot;munsell&quot; ## [13] &quot;labeling&quot; &quot;colorspace&quot; &quot;stringi&quot; &quot;magrittr&quot; ## [17] &quot;jsonlite&quot; &quot;rex&quot; &quot;httr&quot; &quot;crayon&quot; ## [21] &quot;withr&quot; &quot;memoise&quot; &quot;mime&quot; &quot;curl&quot; ## [25] &quot;openssl&quot; &quot;R6&quot; &quot;lazyeval&quot; &quot;lattice&quot; ## [29] &quot;survival&quot; &quot;Formula&quot; &quot;latticeExtra&quot; &quot;cluster&quot; ## [33] &quot;rpart&quot; &quot;nnet&quot; &quot;acepack&quot; &quot;foreign&quot; ## [37] &quot;gridExtra&quot; &quot;data.table&quot; &quot;chron&quot; &quot;Matrix&quot; ## [41] &quot;maps&quot; &quot;sp&quot; &quot;nlme&quot; &quot;mvtnorm&quot; ## [45] &quot;TH.data&quot; &quot;sandwich&quot; &quot;codetools&quot; &quot;zoo&quot; ## [49] &quot;praise&quot; &quot;SparseM&quot; &quot;MatrixModels&quot; &quot;evaluate&quot; ## [53] &quot;formatR&quot; &quot;highr&quot; &quot;markdown&quot; &quot;yaml&quot; ## [57] &quot;knitr&quot; &quot;htmltools&quot; &quot;caTools&quot; &quot;bitops&quot; ## [61] &quot;gdtools&quot; &quot;BH&quot; &quot;covr&quot; &quot;ggplot2movies&quot;
## [65] &quot;hexbin&quot; &quot;Hmisc&quot; &quot;mapproj&quot; &quot;maptools&quot; ## [69] &quot;mgcv&quot; &quot;multcomp&quot; &quot;testthat&quot; &quot;quantreg&quot; ## [73] &quot;rmarkdown&quot; &quot;svglite&quot;</code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-r"><span class="n">makeDepGraph</span><span class="p">(</span><span class="s2">&quot;ggplot2&quot;</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## IGRAPH DN-- 74 123 -- ## + attr: name (v/c), type (e/c)
## + edges (vertex names):
## [1] magrittr -&gt;rex lazyeval -&gt;rex ## [3] jsonlite -&gt;httr mime -&gt;httr ## [5] curl -&gt;httr openssl -&gt;httr ## [7] R6 -&gt;httr memoise -&gt;crayon ## [9] digest -&gt;memoise lattice -&gt;latticeExtra
## [11] RColorBrewer-&gt;latticeExtra gtable -&gt;gridExtra ## [13] chron -&gt;data.table Matrix -&gt;survival ## [15] digest -&gt;ggplot2 gtable -&gt;ggplot2 ## + ... omitted several edges</code></pre>
</figure>
<p>
Assim, dos 335 pacotes mais populares, são gerados dois grafos: o da
esquerda, com o método <code class="highlighter-rouge">plot</code> com
as modificações nativas realizadas pelo
<code class="highlighter-rouge">miniCRAN</code> e o da direita, feita
pelo pacote <code class="highlighter-rouge">igraph</code>.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">set.seed</span><span class="p">(</span><span class="m">123</span><span class="p">)</span><span class="w">
</span><span class="n">list_pkgs</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">df_pkgs_pareto</span><span class="o">$</span><span class="n">package</span><span class="w">
</span><span class="n">g</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">makeDepGraph</span><span class="p">(</span><span class="n">list_pkgs</span><span class="p">)</span><span class="w"> </span><span class="n">par</span><span class="p">(</span><span class="n">mfrow</span><span class="o">=</span><span class="p">(</span><span class="nf">c</span><span class="p">(</span><span class="m">1</span><span class="p">,</span><span class="m">2</span><span class="p">)))</span><span class="w">
</span><span class="n">plot</span><span class="p">(</span><span class="n">g</span><span class="p">,</span><span class="w"> </span><span class="n">vertex.size</span><span class="o">=</span><span class="m">10</span><span class="p">,</span><span class="w"> </span><span class="n">cex</span><span class="o">=</span><span class="m">0.7</span><span class="p">,</span><span class="w"> </span><span class="n">main</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;&quot;</span><span class="p">)</span><span class="w"> </span><span class="c1"># m&#xE9;todo plot.pkgDepGraph</span><span class="w"> </span><span class="n">plot.igraph</span><span class="p">(</span><span class="n">g</span><span class="p">)</span></code></pre>
</figure>
<p>
<img src="http://sillasgonzaga.github.io/figs/metaanalise_1/unnamed-chunk-8-1.png" alt="center">
</p>
<p>
Como pode-se ver, ambos os gráficos acima são visualmente poluídos e não
dá para aprender muita coisa a partir deles. Além disso, a fim de
analisar a centralidade de um pacote em um grafo, é importante saber o
que o argumento <code class="highlighter-rouge">suggests</code> da
função <code class="highlighter-rouge">makeDepGraph</code> significa.
Segundo <a href="http://r-pkgs.had.co.nz/description.html">Hadley
Wickham</a>, quando o pacote A sugere um outro pacote B, significa que o
A <em>pode</em> usar o pacote B, mas ele não é requerido. Este pode ser
usado para rodar testes, montar vignettes (tutoriais de pacotes), etc.
</p>
<p>
Vamos, então, como fica o grafo dos 20 pacotes mais populares, com e sem
<code class="highlighter-rouge">suggests</code>, com o pacote
<code class="highlighter-rouge">ggplot2</code> destacado:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">list_pkgs</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">df_pkgs</span><span class="o">$</span><span class="n">package</span><span class="p">[</span><span class="m">1</span><span class="o">:</span><span class="m">20</span><span class="p">]</span><span class="w"> </span><span class="n">par</span><span class="p">(</span><span class="n">mfrow</span><span class="o">=</span><span class="p">(</span><span class="nf">c</span><span class="p">(</span><span class="m">1</span><span class="p">,</span><span class="m">2</span><span class="p">)))</span><span class="w">
</span><span class="n">g</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">makeDepGraph</span><span class="p">(</span><span class="n">list_pkgs</span><span class="p">,</span><span class="w"> </span><span class="n">enhances</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">FALSE</span><span class="p">,</span><span class="w"> </span><span class="n">suggests</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">FALSE</span><span class="p">)</span><span class="w">
</span><span class="n">set.seed</span><span class="p">(</span><span class="m">123</span><span class="p">)</span><span class="w">
</span><span class="n">plot</span><span class="p">(</span><span class="n">g</span><span class="p">,</span><span class="w"> </span><span class="n">pkgsToHighlight</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;ggplot2&quot;</span><span class="p">,</span><span class="n">vertex.size</span><span class="o">=</span><span class="m">20</span><span class="p">,</span><span class="w"> </span><span class="n">cex</span><span class="o">=</span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="n">main</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Argumento suggests = FALSE&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">legendPosition</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">NULL</span><span class="p">)</span><span class="w"> </span><span class="n">g</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">makeDepGraph</span><span class="p">(</span><span class="n">list_pkgs</span><span class="p">,</span><span class="w"> </span><span class="n">enhances</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">FALSE</span><span class="p">,</span><span class="w"> </span><span class="n">suggests</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">TRUE</span><span class="p">)</span><span class="w">
</span><span class="n">set.seed</span><span class="p">(</span><span class="m">123</span><span class="p">)</span><span class="w">
</span><span class="n">plot</span><span class="p">(</span><span class="n">g</span><span class="p">,</span><span class="w"> </span><span class="n">pkgsToHighlight</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;ggplot2&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">vertex.size</span><span class="o">=</span><span class="m">20</span><span class="p">,</span><span class="w"> </span><span class="n">cex</span><span class="o">=</span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="n">main</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Argumento suggests = TRUE&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">legendPosition</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="m">-1</span><span class="p">,</span><span class="w"> </span><span class="m">-1</span><span class="p">))</span></code></pre>
</figure>
<p>
<img src="http://sillasgonzaga.github.io/figs/metaanalise_1/unnamed-chunk-9-1.png" alt="center">
</p>
<p>
Agora sim já é possível aprender algumas coisas a partir do grafo. O
sentido da linha vermelha indica que, por exemplo, o
<code class="highlighter-rouge">ggplot2</code> importa vários
pacotes(<code class="highlighter-rouge">digest</code>,
<code class="highlighter-rouge">gtable</code>,
<code class="highlighter-rouge">MASS</code>,
<code class="highlighter-rouge">reshape2</code>,
<code class="highlighter-rouge">plyr</code> e
<code class="highlighter-rouge">scales</code>), mas não é importado por
nenhum outro. Já o grafo da direita mostra que o
<code class="highlighter-rouge">ggplot2</code> sugere muitos outros, o
que aumenta sua centralidade na rede.
</p>
<p>
Conclusão: para realizar análises de centralidade de pacotes R, é
necessário deixar o argumento
<code class="highlighter-rouge">suggests</code> como
<code class="highlighter-rouge">FALSE</code>.
</p>
</article>

