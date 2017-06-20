+++
title = "INTRODUÇÃO AO R - Aula 2b"
date = "2016-09-27 03:00:00"
categories = ["r-python-e-redes"]
original_url = "http://neylsoncrepalde.github.io/2016-09-27-introducao-ao-r-aula-2b/"
+++

<article class="blog-post">
<p>
Olá. Os bancos de dados que vamos usar nesta parte da aula estão
disponíveis em
<a href="http://bit.ly/2dnrHmZ">http://bit.ly/2dnrHmZ</a>.
</p>
<h2 id="importando-bancos-de-dados">
Importando bancos de dados
</h2>
<p>
Podemos importar um banco de dados no R usando os comandos
<code class="highlighter-rouge">read.table()</code>.
</p>
<pre class="highlight"><code><span class="n">options</span><span class="p">(</span><span class="n">scipen</span><span class="o">=</span><span class="m">999</span><span class="p">)</span><span class="w">
</span><span class="n">dados</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">read.table</span><span class="p">(</span><span class="s2">&quot;enade_2014_amostra.csv&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">sep</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;;&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">stringsAsFactors</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nb">F</span><span class="p">,</span><span class="w"> </span><span class="n">header</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nb">T</span><span class="p">)</span><span class="w">
</span></code></pre>

<p>
Há outros comandos para importar bancos de dados em estruturas
específicas, como separados por vírgulas (.csv), separados por
ponto-e-vírgula, separados por tab (.tsv), bancos de dados em formato
fixo (como a PNAD). Você pode investigar cada um deles usando o comando
<code class="highlighter-rouge">help()</code> ou sua versão compacta,
<code class="highlighter-rouge">?</code>.
</p>
<pre class="highlight"><code><span class="n">help</span><span class="p">(</span><span class="s2">&quot;read.csv&quot;</span><span class="p">)</span><span class="w">
</span><span class="o">?</span><span class="n">read.fwf</span><span class="w">
</span><span class="o">?</span><span class="n">read.csv2</span><span class="w">
</span></code></pre>

<p>
Um dos maiores desenvolvedores para linguagem R, Hadley Wickham,
desenvolveu um pacote muito eficiente para leitura de bancos de dados
chamado <code class="highlighter-rouge">readr</code>. Como sabemos que
trata-se de um arquivo .csv separado por ponto-e-vírgula, devemos usar o
comando <code class="highlighter-rouge">read\_csv2</code>. Vamos
experimentá-lo comparando seu desempenho com o comando da base do R:
</p>
<pre class="highlight"><code><span class="n">system.time</span><span class="p">(</span><span class="n">dados</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">read.csv2</span><span class="p">(</span><span class="s2">&quot;enade_2014_amostra.csv&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">stringsAsFactors</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nb">F</span><span class="p">,</span><span class="w"> </span><span class="n">header</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nb">T</span><span class="p">))</span><span class="w">
</span></code></pre>

<pre class="highlight"><code>## user system elapsed ## 0.548 0.000 0.544
</code></pre>

<pre class="highlight"><code><span class="n">library</span><span class="p">(</span><span class="n">readr</span><span class="p">)</span><span class="w">
</span><span class="n">system.time</span><span class="p">(</span><span class="n">dados</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">read_csv2</span><span class="p">(</span><span class="s2">&quot;enade_2014_amostra.csv&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">col_names</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nb">T</span><span class="p">))</span><span class="w">
</span></code></pre>

<pre class="highlight"><code>## user system elapsed ## 0.128 0.000 0.128
</code></pre>

<p>
Veja como a função <code class="highlighter-rouge">read\_csv2()</code> é
mais de 3 vezes mais rápida do que a função base!!! O Wickham tem ainda
vários outros pacotes desenvolvidos para manipulação de dados string,
manipulação de bancos de dados, transformação de variáveis, dentre
outros. Esses pacotes podem tornar a nossa vida bem mais fácil! Veja uma
apresentação sobre o <strong>hadleyverse</strong>, universo de Hadley em
<a href="http://barryrowlingson.github.io/hadleyverse">http://barryrowlingson.github.io/hadleyverse</a>.
</p>
<p>
Para importar dados de outros programas como SPSS, Stata ou SAS, você
pode usar o pacote <code class="highlighter-rouge">foreign</code>.
</p>
<pre class="highlight"><code><span class="n">library</span><span class="p">(</span><span class="n">foreign</span><span class="p">)</span><span class="w">
</span><span class="o">?</span><span class="n">read.spss</span><span class="w"> </span><span class="c1"># l&#xEA; SPSS
</span><span class="o">?</span><span class="n">read.dta</span><span class="w"> </span><span class="c1"># l&#xEA; Stata
</span><span class="o">?</span><span class="n">read.ssd</span><span class="w"> </span><span class="c1"># l&#xEA; SAS
</span><span class="o">?</span><span class="n">read.xport</span><span class="w"> </span><span class="c1"># l&#xEA; SAS
</span></code></pre>

<h2 id="bônus-introdução-ao-ggplot2">
Bônus: Introdução ao ggplot2
</h2>
<p>
<strong>ggplot2</strong> é um pacote desenvolvido por (adivinha?) Hadley
Wickham para a construção de gráficos de alta qualidade e alta
customização. Gráficos desse pacote se tornaram um <em>standard</em> no
meio acadêmico podendo ser encontrados nas principais revistas de
análise quantitativa.
</p>
<p>
Sua sintaxe é a seguinte:
</p>
<p>
<code class="highlighter-rouge">ggplot(data = "banco de dados", aes(x =
"vetor x", y = "vetor y")) + tipo de gráfico (podem ser vários
aninhados)</code>
</p>
<p>
Vamos repetir alguns gráficos gerados com o banco de dados
<code class="highlighter-rouge">iris</code> agora com o pacote ggplot2.
</p>
<pre class="highlight"><code><span class="n">library</span><span class="p">(</span><span class="n">ggplot2</span><span class="p">)</span><span class="w">
</span><span class="n">data</span><span class="p">(</span><span class="n">iris</span><span class="p">)</span><span class="w">
</span><span class="c1"># Gerando um histograma
</span><span class="n">ggplot</span><span class="p">(</span><span class="n">data</span><span class="o">=</span><span class="n">iris</span><span class="p">,</span><span class="w"> </span><span class="n">aes</span><span class="p">(</span><span class="n">x</span><span class="o">=</span><span class="n">Petal.Length</span><span class="p">))</span><span class="o">+</span><span class="n">geom_histogram</span><span class="p">()</span><span class="w">
</span></code></pre>

<p>
<img src="http://neylsoncrepalde.github.io/img/intro_r_aula2b_files/figure-markdown_github/unnamed-chunk-5-1.png" alt="">
</p>
<pre class="highlight"><code><span class="c1"># Gerando um scatterplot
</span><span class="n">ggplot</span><span class="p">(</span><span class="n">data</span><span class="o">=</span><span class="n">iris</span><span class="p">,</span><span class="w"> </span><span class="n">aes</span><span class="p">(</span><span class="n">x</span><span class="o">=</span><span class="n">Petal.Length</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="o">=</span><span class="n">Sepal.Length</span><span class="p">))</span><span class="o">+</span><span class="n">geom_point</span><span class="p">()</span><span class="w">
</span></code></pre>

<p>
<img src="http://neylsoncrepalde.github.io/img/intro_r_aula2b_files/figure-markdown_github/unnamed-chunk-5-2.png" alt="">
</p>
<pre class="highlight"><code><span class="c1"># Gerando um boxplot e um violinplot
</span><span class="n">ggplot</span><span class="p">(</span><span class="n">data</span><span class="o">=</span><span class="n">iris</span><span class="p">,</span><span class="w"> </span><span class="n">aes</span><span class="p">(</span><span class="n">x</span><span class="o">=</span><span class="n">Species</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="o">=</span><span class="n">Petal.Length</span><span class="p">))</span><span class="o">+</span><span class="n">geom_boxplot</span><span class="p">()</span><span class="w">
</span></code></pre>

<p>
<img src="http://neylsoncrepalde.github.io/img/intro_r_aula2b_files/figure-markdown_github/unnamed-chunk-5-3.png" alt="">
</p>
<pre class="highlight"><code><span class="n">ggplot</span><span class="p">(</span><span class="n">data</span><span class="o">=</span><span class="n">iris</span><span class="p">,</span><span class="w"> </span><span class="n">aes</span><span class="p">(</span><span class="n">x</span><span class="o">=</span><span class="n">Species</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="o">=</span><span class="n">Petal.Length</span><span class="p">))</span><span class="o">+</span><span class="n">geom_violin</span><span class="p">()</span><span class="w">
</span></code></pre>

<p>
<img src="http://neylsoncrepalde.github.io/img/intro_r_aula2b_files/figure-markdown_github/unnamed-chunk-5-4.png" alt="">
</p>
<pre class="highlight"><code><span class="c1"># Gerando um gr&#xE1;fico de barras
</span><span class="n">ggplot</span><span class="p">(</span><span class="n">data</span><span class="o">=</span><span class="n">iris</span><span class="p">,</span><span class="w"> </span><span class="n">aes</span><span class="p">(</span><span class="n">x</span><span class="o">=</span><span class="n">Species</span><span class="p">))</span><span class="o">+</span><span class="n">geom_bar</span><span class="p">()</span><span class="w">
</span></code></pre>

<p>
<img src="http://neylsoncrepalde.github.io/img/intro_r_aula2b_files/figure-markdown_github/unnamed-chunk-5-5.png" alt="">
</p>
<pre class="highlight"><code><span class="c1"># Podemos inclusive plotar uma reta de regress&#xE3;o
</span><span class="n">ggplot</span><span class="p">(</span><span class="n">data</span><span class="o">=</span><span class="n">iris</span><span class="p">,</span><span class="w"> </span><span class="n">aes</span><span class="p">(</span><span class="n">x</span><span class="o">=</span><span class="n">Petal.Length</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="o">=</span><span class="n">Sepal.Length</span><span class="p">))</span><span class="o">+</span><span class="n">geom_point</span><span class="p">()</span><span class="o">+</span><span class="n">geom_smooth</span><span class="p">(</span><span class="n">method</span><span class="o">=</span><span class="s2">&quot;lm&quot;</span><span class="p">)</span><span class="w">
</span></code></pre>

<p>
<img src="http://neylsoncrepalde.github.io/img/intro_r_aula2b_files/figure-markdown_github/unnamed-chunk-5-6.png" alt="">
</p>
<p>
Vamos realizar algumas análises com os dados da PNAD 2012. Primeiro
importamos o banco de dados.
</p>
<pre class="highlight"><code><span class="n">library</span><span class="p">(</span><span class="n">foreign</span><span class="p">)</span><span class="w">
</span><span class="n">pnad</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">read.spss</span><span class="p">(</span><span class="s2">&quot;pes_2012.sav&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">to.data.frame</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nb">T</span><span class="p">)</span><span class="w">
</span><span class="n">head</span><span class="p">(</span><span class="n">pnad</span><span class="p">)</span><span class="w">
</span></code></pre>

<pre class="highlight"><code>## V0101 UF V0302 V8005 V0404 V4803 V4718 V4720 V4729
## 1 2012 Rond&#xF4;nia Masculino 48 Branca 15 anos ou mais 3000 3000 232
## 2 2012 Rond&#xF4;nia Feminino 48 Branca 15 anos ou mais 3000 3000 232
## 3 2012 Rond&#xF4;nia Feminino 23 Branca 15 anos ou mais 1100 1100 232
## 4 2012 Rond&#xF4;nia Feminino 21 Branca 14 anos 1100 1100 232
## 5 2012 Rond&#xF4;nia Feminino 54 Branca 15 anos ou mais NA 460 232
## 6 2012 Rond&#xF4;nia Masculino 56 Preta 15 anos ou mais 10000 10000 232
</code></pre>

<p>
Vamos ver a variável sexo (V0302):
</p>
<pre class="highlight"><code><span class="n">library</span><span class="p">(</span><span class="n">descr</span><span class="p">)</span><span class="w">
</span><span class="n">freq</span><span class="p">(</span><span class="n">pnad</span><span class="o">$</span><span class="n">V</span><span class="m">0302</span><span class="p">)</span><span class="w">
</span></code></pre>

<p>
<img src="http://neylsoncrepalde.github.io/img/intro_r_aula2b_files/figure-markdown_github/unnamed-chunk-7-1.png" alt="">
</p>
<pre class="highlight"><code>## pnad$V0302 ## Frequ&#xEA;ncia Percentual
## Masculino 176397 48.67
## Feminino 186054 51.33
## Total 362451 100.00
</code></pre>

<p>
Vamos verificar a idade (V8005) média, e depois a idade média de homens
e mulheres. Podemos verificar a idade por grupos de sexo fazendo
<em>subsetting</em> ou realizando um teste de médias.
</p>
<pre class="highlight"><code><span class="c1"># M&#xE9;dia ponderada pelo peso amostral
</span><span class="n">weighted.mean</span><span class="p">(</span><span class="n">pnad</span><span class="o">$</span><span class="n">V</span><span class="m">8005</span><span class="p">,</span><span class="w"> </span><span class="n">pnad</span><span class="o">$</span><span class="n">V</span><span class="m">4729</span><span class="p">)</span><span class="w">
</span></code></pre>

<pre class="highlight"><code><span class="c1"># M&#xE9;dia por grupos de sexo
</span><span class="n">mean</span><span class="p">(</span><span class="n">pnad</span><span class="o">$</span><span class="n">V</span><span class="m">8005</span><span class="p">[</span><span class="n">pnad</span><span class="o">$</span><span class="n">V</span><span class="m">0302</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="s2">&quot;Masculino&quot;</span><span class="p">])</span><span class="w">
</span></code></pre>

<pre class="highlight"><code><span class="n">mean</span><span class="p">(</span><span class="n">pnad</span><span class="o">$</span><span class="n">V</span><span class="m">8005</span><span class="p">[</span><span class="n">pnad</span><span class="o">$</span><span class="n">V</span><span class="m">0302</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="s2">&quot;Feminino&quot;</span><span class="p">])</span><span class="w">
</span></code></pre>

<pre class="highlight"><code><span class="n">t.test</span><span class="p">(</span><span class="n">pnad</span><span class="o">$</span><span class="n">V</span><span class="m">8005</span><span class="o">~</span><span class="n">pnad</span><span class="o">$</span><span class="n">V</span><span class="m">0302</span><span class="p">)</span><span class="w">
</span></code></pre>

<pre class="highlight"><code>## ## Welch Two Sample t-test
## ## data: pnad$V8005 by pnad$V0302
## t = -28.734, df = 362230, p-value &lt; 0.00000000000000022
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
## -2.114581 -1.844524
## sample estimates:
## mean in group Masculino mean in group Feminino ## 31.62186 33.60142
</code></pre>

<p>
Vamos verificar agora a variável cor (V0404). Vamos elaborar uma tabela
de contingência cor X sexo.
</p>
<p>
<img src="http://neylsoncrepalde.github.io/img/intro_r_aula2b_files/figure-markdown_github/unnamed-chunk-9-1.png" alt="">
</p>
<pre class="highlight"><code>## pnad$V0404 ## Frequ&#xEA;ncia Percentual
## Ind&#xED;gena 1435 0.395916
## Branca 155595 42.928561
## Preta 30120 8.310089
## Amarela 1550 0.427644
## Parda 173733 47.932824
## Sem declara&#xE7;&#xE3;o 18 0.004966
## Total 362451 100.000000
</code></pre>

<pre class="highlight"><code><span class="n">table</span><span class="p">(</span><span class="n">pnad</span><span class="o">$</span><span class="n">V</span><span class="m">0404</span><span class="p">,</span><span class="n">pnad</span><span class="o">$</span><span class="n">V</span><span class="m">0302</span><span class="p">)</span><span class="w">
</span></code></pre>

<pre class="highlight"><code>## ## Masculino Feminino
## Ind&#xED;gena 721 714
## Branca 73465 82130
## Preta 15222 14898
## Amarela 682 868
## Parda 86298 87435
## Sem declara&#xE7;&#xE3;o 9 9
</code></pre>

<p>
Agora vamos investigar a variável renda mensal do trabalho principal.
Para isso, é preciso codificar o valor 999999999999 como
<code class="highlighter-rouge">NA</code>.
</p>
<pre class="highlight"><code>## Min. 1st Qu. Median Mean 3rd Qu. ## 0 622 800 26260000000 1500 ## Max. NA&apos;s ## 1000000000000 188912
</code></pre>

<pre class="highlight"><code><span class="c1"># Veja que, ap&#xF3;s a recodifica&#xE7;&#xE3;o dos NA&apos;s, as medidas estat&#xED;sticas mudam
</span><span class="n">pnad</span><span class="o">$</span><span class="n">V</span><span class="m">4718</span><span class="p">[</span><span class="n">pnad</span><span class="o">$</span><span class="n">V</span><span class="m">4718</span><span class="w"> </span><span class="o">&gt;=</span><span class="w"> </span><span class="m">999999999999</span><span class="p">]</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">NA</span><span class="w">
</span><span class="n">summary</span><span class="p">(</span><span class="n">pnad</span><span class="o">$</span><span class="n">V</span><span class="m">4718</span><span class="p">)</span><span class="w">
</span></code></pre>

<pre class="highlight"><code>## Min. 1st Qu. Median Mean 3rd Qu. Max. NA&apos;s ## 0 622 800 1343 1400 350000 193470
</code></pre>

<p>
<img src="http://neylsoncrepalde.github.io/img/intro_r_aula2b_files/figure-markdown_github/unnamed-chunk-10-1.png" alt="">
</p>
<p>
Vamos testar algumas diferenças de salários por sexo e cor. Para testar
por cor, vamos criar uma variável <em>dummy</em>
<code class="highlighter-rouge">branco</code>. Para isso, usaremos o
comando <code class="highlighter-rouge">ifelse()</code>. Ele funciona da
seguinte maneira: se a condição determinada for cumprida, atribui-se o
primeiro valor. Se não, atribui-se o segundo valor.
</p>
<pre class="highlight"><code><span class="c1"># Testando por sexo
</span><span class="n">t.test</span><span class="p">(</span><span class="n">pnad</span><span class="o">$</span><span class="n">V</span><span class="m">4718</span><span class="o">~</span><span class="n">pnad</span><span class="o">$</span><span class="n">V</span><span class="m">0302</span><span class="p">)</span><span class="w">
</span></code></pre>

<pre class="highlight"><code>## ## Welch Two Sample t-test
## ## data: pnad$V4718 by pnad$V0302
## t = 36.656, df = 163240, p-value &lt; 0.00000000000000022
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
## 421.982 469.657
## sample estimates:
## mean in group Masculino mean in group Feminino ## 1532.572 1086.752
</code></pre>

<pre class="highlight"><code><span class="c1"># Criando a dummy branco
# Se pnad$V0404 for igual a &quot;branca&quot;, atribua 1. Se n&#xE3;o, atribua 0.
</span><span class="n">pnad</span><span class="o">$</span><span class="n">branco</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">ifelse</span><span class="p">(</span><span class="n">pnad</span><span class="o">$</span><span class="n">V</span><span class="m">0404</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="s2">&quot;Branca&quot;</span><span class="p">,</span><span class="w"> </span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="m">0</span><span class="p">)</span><span class="w">
</span><span class="n">pnad</span><span class="o">$</span><span class="n">branco</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">as.factor</span><span class="p">(</span><span class="n">pnad</span><span class="o">$</span><span class="n">branco</span><span class="p">)</span><span class="w"> </span><span class="c1"># transforma em factor
</span><span class="n">levels</span><span class="p">(</span><span class="n">pnad</span><span class="o">$</span><span class="n">branco</span><span class="p">)</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="s2">&quot;N&#xE3;o Branco&quot;</span><span class="p">,</span><span class="s2">&quot;Branco&quot;</span><span class="p">)</span><span class="w"> </span><span class="c1"># coloca os labels
</span><span class="n">freq</span><span class="p">(</span><span class="n">pnad</span><span class="o">$</span><span class="n">branco</span><span class="p">,</span><span class="w"> </span><span class="n">plot</span><span class="o">=</span><span class="nb">F</span><span class="p">)</span><span class="w"> </span><span class="c1"># verifica a distribui&#xE7;&#xE3;o
</span></code></pre>

<pre class="highlight"><code>## pnad$branco ## Frequ&#xEA;ncia Percentual
## N&#xE3;o Branco 206856 57.07
## Branco 155595 42.93
## Total 362451 100.00
</code></pre>

<pre class="highlight"><code><span class="c1"># Ser&#xE1; que brancos ganham mais, menos, ou igual a n&#xE3;o brancos no Brasil?
</span><span class="n">t.test</span><span class="p">(</span><span class="n">pnad</span><span class="o">$</span><span class="n">V</span><span class="m">4718</span><span class="o">~</span><span class="n">pnad</span><span class="o">$</span><span class="n">branco</span><span class="p">)</span><span class="w">
</span></code></pre>

<pre class="highlight"><code>## ## Welch Two Sample t-test
## ## data: pnad$V4718 by pnad$branco
## t = -51.066, df = 92293, p-value &lt; 0.00000000000000022
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
## -750.1254 -694.6719
## sample estimates:
## mean in group N&#xE3;o Branco mean in group Branco ## 1027.188 1749.587
</code></pre>

<p>
Vamos testar agora algumas correlações entre renda, escolaridade e
idade. Para isso, é necessário retirar os NA’s.
</p>
<pre class="highlight"><code><span class="n">pnad_semna</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">na.omit</span><span class="p">(</span><span class="n">pnad</span><span class="p">)</span><span class="w"> </span><span class="c1"># tira NA&apos;s e guarda no objeto pnad_semna
</span><span class="w">
</span><span class="c1"># Renda, escolaridade e idade
</span><span class="n">cor</span><span class="p">(</span><span class="n">cbind</span><span class="p">(</span><span class="n">pnad_semna</span><span class="o">$</span><span class="n">V</span><span class="m">4718</span><span class="p">,</span><span class="w"> </span><span class="nf">as.numeric</span><span class="p">(</span><span class="n">pnad_semna</span><span class="o">$</span><span class="n">V</span><span class="m">4803</span><span class="p">),</span><span class="w"> </span><span class="n">pnad_semna</span><span class="o">$</span><span class="n">V</span><span class="m">8005</span><span class="p">))</span><span class="w">
</span></code></pre>

<pre class="highlight"><code>## [,1] [,2] [,3]
## [1,] 1.0000000 0.2605251 0.1046775
## [2,] 0.2605251 1.0000000 -0.2547903
## [3,] 0.1046775 -0.2547903 1.0000000
</code></pre>

<p>
Vamos montar um modelinho de regressão para tentar explicar o desempenho
dos alunos no ENADE como função do sexo, da idade e da cor. Para isso,
primeiro devemos verificar a distribuição da variável resposta.
</p>
<pre class="highlight"><code><span class="n">enade</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">read_csv2</span><span class="p">(</span><span class="s2">&quot;enade_2014_amostra.csv&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">col_names</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nb">T</span><span class="p">)</span><span class="w">
</span><span class="n">hist</span><span class="p">(</span><span class="n">enade</span><span class="o">$</span><span class="n">nt_ger</span><span class="p">,</span><span class="w"> </span><span class="n">col</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;blue&quot;</span><span class="p">)</span><span class="w">
</span></code></pre>

<p>
<img src="http://neylsoncrepalde.github.io/img/intro_r_aula2b_files/figure-markdown_github/unnamed-chunk-13-1.png" alt="">
</p>
<p>
A variável possui distribuição normal e portanto é uma boa variável para
aplicar regressão linear por MQO. Agora, após, ver algumas estatísticas
descritivas, vamos montar o modelo:
</p>
<pre class="highlight"><code>## Min. 1st Qu. Median Mean 3rd Qu. Max. NA&apos;s ## 0.0 292.0 414.0 399.6 528.0 943.0 1724
</code></pre>

<pre class="highlight"><code><span class="c1"># Colocando NA&apos;s nas n&#xE3;o respostas da vari&#xE1;vel sexo
</span><span class="n">enade</span><span class="o">$</span><span class="n">tp_sexo</span><span class="p">[</span><span class="n">enade</span><span class="o">$</span><span class="n">tp_sexo</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="s2">&quot;N&quot;</span><span class="p">]</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">NA</span><span class="w">
</span><span class="n">freq</span><span class="p">(</span><span class="n">enade</span><span class="o">$</span><span class="n">tp_sexo</span><span class="p">,</span><span class="w"> </span><span class="n">plot</span><span class="o">=</span><span class="nb">F</span><span class="p">)</span><span class="w">
</span></code></pre>

<pre class="highlight"><code>## enade$tp_sexo ## Frequ&#xEA;ncia Percentual % V&#xE1;lido
## F 5744 57.44 57.45
## M 4254 42.54 42.55
## NA&apos;s 2 0.02 ## Total 10000 100.00 100.00
</code></pre>

<pre class="highlight"><code><span class="c1"># Idade
</span><span class="n">summary</span><span class="p">(</span><span class="n">enade</span><span class="o">$</span><span class="n">nu_idade</span><span class="p">)</span><span class="w">
</span></code></pre>

<pre class="highlight"><code>## Min. 1st Qu. Median Mean 3rd Qu. Max. ## 18.00 23.00 27.00 29.89 34.00 73.00
</code></pre>

<pre class="highlight"><code><span class="n">enade</span><span class="o">$</span><span class="n">qe_i2</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">as.factor</span><span class="p">(</span><span class="n">enade</span><span class="o">$</span><span class="n">qe_i2</span><span class="p">)</span><span class="w"> </span><span class="c1"># transformando em factor
</span><span class="w">
</span><span class="c1"># colocando os labels
</span><span class="n">levels</span><span class="p">(</span><span class="n">enade</span><span class="o">$</span><span class="n">qe_i2</span><span class="p">)</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="s2">&quot;Branco&quot;</span><span class="p">,</span><span class="s2">&quot;Negro&quot;</span><span class="p">,</span><span class="s2">&quot;Pardo&quot;</span><span class="p">,</span><span class="s2">&quot;Amarelo&quot;</span><span class="p">,</span><span class="s2">&quot;Ind&#xED;gena&quot;</span><span class="p">)</span><span class="w">
</span><span class="n">freq</span><span class="p">(</span><span class="n">enade</span><span class="o">$</span><span class="n">qe_i2</span><span class="p">,</span><span class="w"> </span><span class="n">plot</span><span class="o">=</span><span class="nb">F</span><span class="p">)</span><span class="w">
</span></code></pre>

<pre class="highlight"><code>## enade$qe_i2 ## Frequ&#xEA;ncia Percentual % V&#xE1;lido
## Branco 4606 46.06 52.9791
## Negro 893 8.93 10.2715
## Pardo 2988 29.88 34.3685
## Amarelo 129 1.29 1.4838
## Ind&#xED;gena 78 0.78 0.8972
## NA&apos;s 1306 13.06 ## Total 10000 100.00 100.0000
</code></pre>

<p>
A sintaxe do modelo de regressão funciona da seguinte forma:
</p>
<p>
<code class="highlighter-rouge">lm(dependente ~ preditor1 + preditor2 +
preditor3, data = banco de dados)</code>
</p>
<pre class="highlight"><code><span class="c1"># Montando o modelo
</span><span class="n">modelo</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">lm</span><span class="p">(</span><span class="n">nt_ger</span><span class="w"> </span><span class="o">~</span><span class="w"> </span><span class="n">tp_sexo</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">nu_idade</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">qe_i2</span><span class="p">,</span><span class="w"> </span><span class="n">data</span><span class="o">=</span><span class="n">enade</span><span class="p">)</span><span class="w">
</span><span class="n">summary</span><span class="p">(</span><span class="n">modelo</span><span class="p">)</span><span class="w"> </span><span class="c1"># apresenta os resultados do modelo
</span></code></pre>

<pre class="highlight"><code>## ## Call:
## lm(formula = nt_ger ~ tp_sexo + nu_idade + qe_i2, data = enade)
## ## Residuals:
## Min 1Q Median 3Q Max ## -425.92 -106.49 13.69 127.53 521.92 ## ## Coefficients:
## Estimate Std. Error t value Pr(&gt;|t|) ## (Intercept) 448.8788 7.8895 56.896 &lt; 0.0000000000000002 ***
## tp_sexoM 0.6301 4.1269 0.153 0.878656 ## nu_idade -1.2085 0.2409 -5.017 0.000000535724 ***
## qe_i2Negro -25.9165 6.9206 -3.745 0.000182 ***
## qe_i2Pardo -28.6309 4.4442 -6.442 0.000000000124 ***
## qe_i2Amarelo -19.1198 16.4444 -1.163 0.244987 ## qe_i2Ind&#xED;gena -50.1873 21.4993 -2.334 0.019600 * ## ---
## Signif. codes: 0 &apos;***&apos; 0.001 &apos;**&apos; 0.01 &apos;*&apos; 0.05 &apos;.&apos; 0.1 &apos; &apos; 1
## ## Residual standard error: 183.4 on 8235 degrees of freedom
## (1758 observations deleted due to missingness)
## Multiple R-squared: 0.009782, Adjusted R-squared: 0.009061 ## F-statistic: 13.56 on 6 and 8235 DF, p-value: 0.000000000000002249
</code></pre>

<p>
Podemos interpretar este modelo da seguinte forma:
</p>
<p>
Homens não tem diferença estatisticamente significante das mulheres em
relação à nota geral. Para cada 1 ano a mais de idade, a nota geral
diminui, em média, 1.21 pontos. No caso da variável
<strong>Cor</strong>, por se tratar de uma variável categórica, todos os
coeficientes serão interpretados em relação à categoria de referência, a
que foi retirada. Neste caso, negros tem, em média, uma nota 25.9 pontos
menor que brancos; pardos tem, em média, uma nota 28.6 pontos menor que
brancos, e indígenas tem, em média, uma nota -50 pontos menor que
brancos mantendo-se todas as demais variáveis constantes. O coeficiente
para a categoria amarelo não foi estatisticamente significativo, ou
seja, a diferença entre as notas desse grupo e dos brancos é
estatisticamente igual a 0.
</p>
<p>
Agora vamos avaliar nosso modelo. O R nos dá alguns gráficos
<em>default</em> de avaliação.
</p>
<pre class="highlight"><code><span class="c1"># gr&#xE1;ficos de avalia&#xE7;&#xE3;o
</span><span class="n">plot</span><span class="p">(</span><span class="n">modelo</span><span class="p">)</span><span class="w">
</span></code></pre>

<p>
<img src="http://neylsoncrepalde.github.io/img/intro_r_aula2b_files/figure-markdown_github/unnamed-chunk-16-1.png" alt="">
<img src="http://neylsoncrepalde.github.io/img/intro_r_aula2b_files/figure-markdown_github/unnamed-chunk-16-2.png" alt="">
<img src="http://neylsoncrepalde.github.io/img/intro_r_aula2b_files/figure-markdown_github/unnamed-chunk-16-3.png" alt="">
<img src="http://neylsoncrepalde.github.io/img/intro_r_aula2b_files/figure-markdown_github/unnamed-chunk-16-4.png" alt="">
</p>
<p>
Para realizar uma análise dos resíduos da regressão, podemos tirar um
histograma. O comando <code class="highlighter-rouge">residuals()</code>
extrai os resíduos de um modelo estatístico.
</p>
<pre class="highlight"><code><span class="c1"># Histograma dos res&#xED;duos
</span><span class="n">hist</span><span class="p">(</span><span class="n">residuals</span><span class="p">(</span><span class="n">modelo</span><span class="p">),</span><span class="w"> </span><span class="n">col</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;red&quot;</span><span class="p">)</span><span class="w">
</span></code></pre>

<p>
<img src="http://neylsoncrepalde.github.io/img/intro_r_aula2b_files/figure-markdown_github/unnamed-chunk-17-1.png" alt="">
</p>
<p>
Depois disso, podemos plotar a reta de regressão usando o comando
<code class="highlighter-rouge">plot()</code> e o comando
<code class="highlighter-rouge">abline()</code>. O comando
<code class="highlighter-rouge">abline()</code> toma como argumentos o
intercepto e a inclinação (coeficiente) da variável que desejamos
plotar.
</p>
<pre class="highlight"><code><span class="c1"># Plotando a reta de regress&#xE3;o
</span><span class="n">coef</span><span class="p">(</span><span class="n">modelo</span><span class="p">)</span><span class="w"> </span><span class="c1"># verificando apenas os coeficientes do modelo
</span></code></pre>

<pre class="highlight"><code>## (Intercept) tp_sexoM nu_idade qe_i2Negro qe_i2Pardo ## 448.8788071 0.6300838 -1.2084605 -25.9164527 -28.6308728 ## qe_i2Amarelo qe_i2Ind&#xED;gena ## -19.1197937 -50.1872827
</code></pre>

<pre class="highlight"><code><span class="n">plot</span><span class="p">(</span><span class="n">enade</span><span class="o">$</span><span class="n">nu_idade</span><span class="p">,</span><span class="w"> </span><span class="n">enade</span><span class="o">$</span><span class="n">nt_ger</span><span class="p">,</span><span class="w"> </span><span class="n">pch</span><span class="o">=</span><span class="m">19</span><span class="p">)</span><span class="w"> </span><span class="c1"># plotando as vari&#xE1;veis
</span><span class="n">abline</span><span class="p">(</span><span class="n">a</span><span class="o">=</span><span class="m">448.8764</span><span class="p">,</span><span class="w"> </span><span class="n">b</span><span class="o">=</span><span class="m">-1.2085</span><span class="p">,</span><span class="w"> </span><span class="n">col</span><span class="o">=</span><span class="s2">&quot;red&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">lwd</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">2</span><span class="p">)</span><span class="w"> </span><span class="c1">#plotando uma reta com intercepto e slope
</span></code></pre>

<p>
<img src="http://neylsoncrepalde.github.io/img/intro_r_aula2b_files/figure-markdown_github/unnamed-chunk-18-1.png" alt="">
</p>
<pre class="highlight"><code><span class="c1"># BONUS: o mesmo gr&#xE1;fico com ggplot2
</span><span class="n">library</span><span class="p">(</span><span class="n">ggplot2</span><span class="p">)</span><span class="w">
</span><span class="n">ggplot</span><span class="p">(</span><span class="n">enade</span><span class="p">,</span><span class="w"> </span><span class="n">aes</span><span class="p">(</span><span class="n">nu_idade</span><span class="p">,</span><span class="w"> </span><span class="n">nt_ger</span><span class="p">))</span><span class="o">+</span><span class="n">geom_point</span><span class="p">()</span><span class="o">+</span><span class="w"> </span><span class="n">geom_abline</span><span class="p">(</span><span class="n">intercept</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">448.8764</span><span class="p">,</span><span class="w"> </span><span class="n">slope</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">-1.2085</span><span class="p">,</span><span class="w"> </span><span class="n">col</span><span class="o">=</span><span class="s2">&quot;red&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">lwd</span><span class="o">=</span><span class="m">1</span><span class="p">)</span><span class="o">+</span><span class="w"> </span><span class="n">labs</span><span class="p">(</span><span class="n">title</span><span class="o">=</span><span class="s2">&quot;Reta de regress&#xE3;o&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">x</span><span class="o">=</span><span class="s2">&quot;Idade&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="o">=</span><span class="s2">&quot;Nota Geral&quot;</span><span class="p">)</span><span class="w">
</span></code></pre>

<p>
<img src="http://neylsoncrepalde.github.io/img/intro_r_aula2b_files/figure-markdown_github/unnamed-chunk-18-2.png" alt="">
</p>
</article>
<p class="blog-tags">
Tags: R programming, rstats
</p>

