+++
title = "Clusterização no R: Como segmentar países de acordo com indicadores econômicos"
date = "2016-06-28 03:00:00"
categories = ["paixao-por-dados"]
original_url = "http://sillasgonzaga.github.io/2016-06-28-clusterizacaoPaises/"
+++

<article class="blog-post">
<p>
Neste post, eu mostro como:
</p>
<ul>
<li>
Baixar dados de indicadores macroecômicos de todos os países usando a
API do World Bank;
</li>
<li>
Clusterizar países de acordo com esses indicadores usando o algoritmo
<em>k-means</em>;
</li>
<li>
O Brasil está mais próximo de Serra Leoa e Zimbábue que dos Estados
Unidos e Noruega
</li>
</ul>
<figure class="highlight">
<pre><code class="language-r"><span class="n">library</span><span class="p">(</span><span class="n">WDI</span><span class="p">)</span><span class="w"> </span><span class="c1"># baixar os dados do World Bank
</span><span class="n">library</span><span class="p">(</span><span class="n">magrittr</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">formattable</span><span class="p">)</span></code></pre>
</figure>
<h2 id="importação-dos-dados">
Importação dos dados
</h2>
<p>
Felizmente, o processo de importação dos dados do World Bank é feito de
maneira automatizada pelo pacote
<a href="https://github.com/vincentarelbundock/WDI"><code class="highlighter-rouge">WDI</code></a>
usando a função <code class="highlighter-rouge">WDI()</code>. Como é
necessário inserir o código do indicador, usei a função
<code class="highlighter-rouge">WDIsearch()</code> para buscar o código
do indicador relacionado a, por exemplo, inflação:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">WDIsearch</span><span class="p">(</span><span class="s2">&quot;Inflation&quot;</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## indicator name ## [1,] &quot;FP.CPI.TOTL.ZG&quot; &quot;Inflation, consumer prices (annual %)&quot;
## [2,] &quot;NY.GDP.DEFL.KD.ZG&quot; &quot;Inflation, GDP deflator (annual %)&quot;</code></pre>
</figure>
<p>
Portanto, o código do indicador de inflação é “FP.CPI.TOTL.ZG”. Repeti o
mesmo para outros indicadores que escolhi para esta análise:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="c1"># lista de indicadores para baixar:
</span><span class="n">lista_indicadores</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="s2">&quot;FP.CPI.TOTL.ZG&quot;</span><span class="p">,</span><span class="w"> </span><span class="c1"># infla&#xE7;&#xE3;o (%)
</span><span class="w"> </span><span class="s2">&quot;NY.GDP.PCAP.CD&quot;</span><span class="p">,</span><span class="w"> </span><span class="c1"># Pib per capita (USD)
</span><span class="w"> </span><span class="s2">&quot;NY.GDP.MKTP.KD.ZG&quot;</span><span class="p">,</span><span class="w"> </span><span class="c1"># crescimento do PIB anual (%),
</span><span class="w"> </span><span class="s2">&quot;SL.UEM.TOTL.ZS&quot;</span><span class="w"> </span><span class="c1"># Desemprego (%)
</span><span class="p">)</span><span class="w"> </span><span class="c1"># Usei 2014 como ano de refer&#xEA;ncia pois os resultados de alguns indicadores de 2015 ainda n&#xE3;o foram disponibilizados
</span><span class="n">df</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">WDI</span><span class="p">(</span><span class="n">indicator</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">lista_indicadores</span><span class="p">,</span><span class="w"> </span><span class="n">country</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;all&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">start</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">2014</span><span class="p">,</span><span class="w"> </span><span class="n">end</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">2014</span><span class="p">,</span><span class="w"> </span><span class="n">extra</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">TRUE</span><span class="p">)</span><span class="w">
</span><span class="n">str</span><span class="p">(</span><span class="n">df</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## &apos;data.frame&apos;:  248 obs. of 14 variables:
## $ iso2c : chr &quot;1A&quot; &quot;1W&quot; &quot;4E&quot; &quot;7E&quot; ...
## $ country : chr &quot;Arab World&quot; &quot;World&quot; &quot;East Asia &amp; Pacific (developing only)&quot; &quot;Europe &amp; Central Asia (developing only)&quot; ...
## $ year : num 2014 2014 2014 2014 2014 ...
## $ FP.CPI.TOTL.ZG : num 2.78 2.6 3.86 2.53 6.67 ...
## $ NY.GDP.PCAP.CD : num 7447 10739 6240 6896 1504 ...
## $ NY.GDP.MKTP.KD.ZG: num 2.28 2.49 6.75 2.26 6.89 ...
## $ SL.UEM.TOTL.ZS : num 11.52 5.93 4.58 9.26 3.9 ...
## $ iso3c : Factor w/ 248 levels &quot;ABW&quot;,&quot;AFG&quot;,&quot;AGO&quot;,..: 6 243 59 61 195 5 7 2 11 4 ...
## $ region : Factor w/ 8 levels &quot;Aggregates&quot;,&quot;East Asia &amp; Pacific (all income levels)&quot;,..: 1 1 1 1 1 3 5 7 4 3 ...
## $ capital : Factor w/ 211 levels &quot;&quot;,&quot;Abu Dhabi&quot;,..: 1 1 1 1 1 10 2 80 167 191 ...
## $ longitude : Factor w/ 211 levels &quot;&quot;,&quot;-0.126236&quot;,..: 1 1 1 1 1 45 141 169 158 72 ...
## $ latitude : Factor w/ 211 levels &quot;&quot;,&quot;0.20618&quot;,&quot;-0.229498&quot;,..: 1 1 1 1 1 137 77 105 46 131 ...
## $ income : Factor w/ 7 levels &quot;Aggregates&quot;,&quot;High income: nonOECD&quot;,..: 1 1 1 1 1 2 2 5 7 7 ...
## $ lending : Factor w/ 5 levels &quot;Aggregates&quot;,&quot;Blend&quot;,..: 1 1 1 1 1 5 5 4 3 3 ...</code></pre>
</figure>
<p>
O output acima mostra que o data frame não contém dados apenas de países
mas também de unidades agregadas, como o mundo, mundo árabe, América
Latina, etc. Por isso, removi as unidades agregadas:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">df</span><span class="o">$</span><span class="n">region</span><span class="w"> </span><span class="o">%&lt;&gt;%</span><span class="w"> </span><span class="n">as.character</span><span class="w">
</span><span class="c1"># remover agregados
</span><span class="n">df</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">subset</span><span class="p">(</span><span class="n">df</span><span class="p">,</span><span class="w"> </span><span class="n">region</span><span class="w"> </span><span class="o">!=</span><span class="w"> </span><span class="s2">&quot;Aggregates&quot;</span><span class="p">)</span></code></pre>
</figure>
<p>
Abaixo eu crio um novo dataframe apenas com as variáveis de interesse:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">df2</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">df</span><span class="p">[,</span><span class="w"> </span><span class="n">lista_indicadores</span><span class="p">]</span><span class="w">
</span><span class="n">row.names</span><span class="p">(</span><span class="n">df2</span><span class="p">)</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">df</span><span class="o">$</span><span class="n">country</span><span class="w">
</span><span class="n">colnames</span><span class="p">(</span><span class="n">df2</span><span class="p">)</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="s2">&quot;inflacao&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;pib_per_capita&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;crescimento_pib&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;desemprego&quot;</span><span class="p">)</span><span class="w">
</span><span class="n">summary</span><span class="p">(</span><span class="n">df2</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## inflacao pib_per_capita crescimento_pib desemprego ## Min. :-1.5092 Min. : 255 Min. :-24.000 Min. : 0.300 ## 1st Qu.: 0.5936 1st Qu.: 1802 1st Qu.: 1.588 1st Qu.: 4.300 ## Median : 2.6705 Median : 5484 Median : 3.310 Median : 6.900 ## Mean : 3.9496 Mean : 14625 Mean : 3.205 Mean : 8.606 ## 3rd Qu.: 5.4123 3rd Qu.: 16091 3rd Qu.: 5.199 3rd Qu.:10.950 ## Max. :62.1686 Max. :116613 Max. : 10.300 Max. :31.000 ## NA&apos;s :39 NA&apos;s :27 NA&apos;s :29 NA&apos;s :38</code></pre>
</figure>
<p>
Duas observações importantes sobre o output acima:
</p>
<ul>
<li>
Para facilitar a interpretação dos resultados da análise, transformei a
taxa de desemprego em taxa de emprego, pois assim temos três indicadores
que. quanto maior seus valores, mais pujante é a Economia de seus
países;
</li>
<li>
Alguns países não contém dados para alguns dos indicadores. Não há
informação, por exemplo, sobre desemprego em 38 países.
</li>
</ul>
<p>
Para resolver o problema dos valores ausentes (os
<code class="highlighter-rouge">NA</code>), poderia ser aplicada uma
técnica robusta, mas como esta é uma análise simples ou optei por
remover os países que tinham algum dado faltando.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">df2</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">na.omit</span><span class="p">(</span><span class="n">df2</span><span class="p">)</span><span class="w">
</span><span class="n">df2</span><span class="o">$</span><span class="n">desemprego</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="m">100</span><span class="w"> </span><span class="o">-</span><span class="w"> </span><span class="n">df2</span><span class="o">$</span><span class="n">desemprego</span><span class="w">
</span><span class="nf">names</span><span class="p">(</span><span class="n">df2</span><span class="p">)[</span><span class="m">4</span><span class="p">]</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="s2">&quot;emprego&quot;</span></code></pre>
</figure>
<h2 id="clusterização">
Clusterização
</h2>
<p>
Para usar o algoritmo <em>k-means</em> para clusterizar os países, é
necessário:
</p>
<ul>
<li>
Calcular a distância (dissimilaridade) entre os países;
</li>
<li>
Escolher o número de clusteres.
</li>
</ul>
<p>
Para o cálculo da distância, temos um problema: as escalas das colunas
são diferentes. Enquanto o PIB per capita é dado em dólares por pessoa e
vão de 255 a 116,613, os outros são dados em porcentagem. Se não for
feita nenhuma transformação dos dados, o PIB per capita terá um peso
muito maior na clusterização dos dados que os outros indicadores.
</p>
<p>
Por isso, é necessário convertes todos os indicadores a uma escala única
de média 0:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">df2_escala</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">scale</span><span class="p">(</span><span class="n">df2</span><span class="p">)</span><span class="w">
</span><span class="c1"># Conferindo o output para o Brasil
</span><span class="n">df2_escala</span><span class="p">[</span><span class="s2">&quot;Brazil&quot;</span><span class="p">,</span><span class="w"> </span><span class="p">]</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## inflacao pib_per_capita crescimento_pib emprego ## 0.5314139 -0.1864309 -1.2654843 0.2454973</code></pre>
</figure>
<p>
Na nova escala, temos que o Brasil apresenta inflação acima da média,
PIB per capita abaixo da média, Crescimento do PIB abaixo da média (e
olha que isso foi em 2014…) e taxa de emprego acima da média.
</p>
<p>
A determinação da quantidade de clusteres não segue uma regra
pré-definida e deve ser pensada pelo responsável pela análise. Cada
projeto de clusterização tem suas próprias particularidades. Contudo,
alguns métodos analíticos podem ajudar nessa escolha, seja pela
minização da soma dos quadrados dos clusteres ou pelo auxílio visual de
um dendograma.
</p>
<p>
Para determinar o número de clusteres pelo primeiro método, observe o
gráfico abaixo:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="c1"># referencia: http://www.statmethods.net/advstats/cluster.html
</span><span class="n">wss</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="p">(</span><span class="n">nrow</span><span class="p">(</span><span class="n">df2_escala</span><span class="p">)</span><span class="m">-1</span><span class="p">)</span><span class="o">*</span><span class="nf">sum</span><span class="p">(</span><span class="n">apply</span><span class="p">(</span><span class="n">df2_escala</span><span class="p">,</span><span class="m">2</span><span class="p">,</span><span class="n">var</span><span class="p">))</span><span class="w">
</span><span class="k">for</span><span class="w"> </span><span class="p">(</span><span class="n">i</span><span class="w"> </span><span class="k">in</span><span class="w"> </span><span class="m">2</span><span class="o">:</span><span class="m">15</span><span class="p">)</span><span class="w"> </span><span class="n">wss</span><span class="p">[</span><span class="n">i</span><span class="p">]</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="nf">sum</span><span class="p">(</span><span class="n">kmeans</span><span class="p">(</span><span class="n">df2_escala</span><span class="p">,</span><span class="w"> </span><span class="n">centers</span><span class="o">=</span><span class="n">i</span><span class="p">)</span><span class="o">$</span><span class="n">withinss</span><span class="p">)</span><span class="w">
</span><span class="n">plot</span><span class="p">(</span><span class="m">1</span><span class="o">:</span><span class="m">15</span><span class="p">,</span><span class="w"> </span><span class="n">wss</span><span class="p">,</span><span class="w"> </span><span class="n">type</span><span class="o">=</span><span class="s2">&quot;b&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">xlab</span><span class="o">=</span><span class="s2">&quot;N&#xFA;mero of Clusters&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">ylab</span><span class="o">=</span><span class="s2">&quot;Soma dos quadrados dentro dos clusteres&quot;</span><span class="p">)</span><span class="w"> </span></code></pre>
</figure>
<p>
<img src="http://sillasgonzaga.github.io/figs/12clusterizacaoPaises/unnamed-chunk-8-1.png" alt="center">
</p>
<p>
A soma dos quadrados dos clusteres se mantem estável a partir de 8
segmentos. Contudo, é preciso pensar qual a interpretação que teríamos
disso. Quer dizer, posso dizer que dividi os dados em 8 clusteres, mas…
e daí? O que seria aprendido por meio desses 8 clusteres?
</p>
<p>
Pelo segundo método, um dendograma é criado:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">dendo</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">df2_escala</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">dist</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">hclust</span><span class="w">
</span><span class="n">plot</span><span class="p">(</span><span class="n">dendo</span><span class="p">)</span><span class="w">
</span><span class="n">rect.hclust</span><span class="p">(</span><span class="n">dendo</span><span class="p">,</span><span class="w"> </span><span class="n">k</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">3</span><span class="p">,</span><span class="w"> </span><span class="n">border</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;blue&quot;</span><span class="p">)</span><span class="w">
</span><span class="n">rect.hclust</span><span class="p">(</span><span class="n">dendo</span><span class="p">,</span><span class="w"> </span><span class="n">k</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">4</span><span class="p">,</span><span class="w"> </span><span class="n">border</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;red&quot;</span><span class="p">)</span></code></pre>
</figure>
<p>
<img src="http://sillasgonzaga.github.io/figs/12clusterizacaoPaises/unnamed-chunk-9-1.png" alt="center">
</p>
<p>
A posição de cada país no dendograma é determinada pela dissimilaridade
entre cada um dos outros países. Veja que a opção de 4 segmentos divide
um dos segmentos da opção de 3 ao meio. Portanto, 4 parece ser uma boa
escolha para a quantidade de clusteres do modelo desta análise.
</p>
<p>
Por exemplo, esta é a distância entre o Brasil e alguns outros países:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">df2_escala</span><span class="p">[</span><span class="nf">c</span><span class="p">(</span><span class="s2">&quot;Brazil&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;Sierra Leone&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;Zimbabwe&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;Norway&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;United States&quot;</span><span class="p">),]</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">dist</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## Brazil Sierra Leone Zimbabwe Norway
## Sierra Leone 1.900431 ## Zimbabwe 2.060580 1.650196 ## Norway 4.060091 4.559608 4.400310 ## United States 2.334771 2.866905 2.503331 1.970294</code></pre>
</figure>
<p>
Dá para ver que o Brasil tem uma distância euclidiana de 1,90 em relação
a Serra Leoa, 2,06 ao Zimbábue, 2,33 aos Estados Unidos e 4,06 a
Noruega. Ou seja, levando em conta os indicadores macroeconômicos
considerados nesta análise, é possível dizer que o Brasil é mais similar
com países miseráveis do que com países ricos (Veja como os EUA são
menos distantes em relação a Noruega do que ao Zimbábue).
</p>
<p>
Podemos também ver qual a distribuição do grau de dissimularidade do
Brasil com o resto do mundo:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">mat_brasil</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">df2_escala</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">dist</span><span class="p">(</span><span class="n">diag</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">TRUE</span><span class="p">,</span><span class="w"> </span><span class="n">upper</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">TRUE</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">as.matrix</span><span class="w">
</span><span class="c1"># 5 pa&#xED;ses com menor dissimilaridade
</span><span class="n">mat_brasil</span><span class="p">[,</span><span class="w"> </span><span class="s2">&quot;Brazil&quot;</span><span class="p">]</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">sort</span><span class="p">()</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">head</span><span class="p">(</span><span class="m">6</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## Brazil Russian Federation Equatorial Guinea ## 0.0000000 0.4703667 0.5118298 ## Gambia, The Trinidad and Tobago Chile ## 0.5927519 0.7035814 0.8109536</code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-r"><span class="c1"># 5 pa&#xED;ses com MAIOR dissimilaridade
</span><span class="n">mat_brasil</span><span class="p">[,</span><span class="w"> </span><span class="s2">&quot;Brazil&quot;</span><span class="p">]</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">sort</span><span class="p">()</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">tail</span><span class="p">(</span><span class="m">5</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## Qatar Malawi Mauritania Luxembourg Sudan ## 4.282810 4.399952 4.756417 5.083102 6.676918</code></pre>
</figure>
<p>
O resultado dos 5 países mais distantes do Brasil é curioso: dentre
eles, há 2 países ricos (Qatar e Luxemburgo) e três pobres (Malawi,
Mauritânia e Sudão). Ou seja, não é necessariamente verdade que o Brasil
é mais similar a países pobres da África que países ricos. <del>Esse é o
tipo de coisa que, se eu fosse um jornalista sensacionalista,
omitiria</del>.
</p>
<p>
Brincadeiras a parte, já podemos pular para a parte de criar os
segmentos:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="c1"># fixar uma seed para garantir a reproducibilidade da an&#xE1;lise:
</span><span class="n">set.seed</span><span class="p">(</span><span class="m">123</span><span class="p">)</span><span class="w"> </span><span class="c1"># criar os clusteres
</span><span class="n">lista_clusteres</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">kmeans</span><span class="p">(</span><span class="n">df2_escala</span><span class="p">,</span><span class="w"> </span><span class="n">centers</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">4</span><span class="p">)</span><span class="o">$</span><span class="n">cluster</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-r"><span class="c1"># fun&#xE7;&#xE3;o customizada para calcular a m&#xE9;dia dos indicadores para cada cluster
</span><span class="n">cluster.summary</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">data</span><span class="p">,</span><span class="w"> </span><span class="n">groups</span><span class="p">)</span><span class="w"> </span><span class="p">{</span><span class="w"> </span><span class="n">x</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="nf">round</span><span class="p">(</span><span class="n">aggregate</span><span class="p">(</span><span class="n">data</span><span class="p">,</span><span class="w"> </span><span class="nf">list</span><span class="p">(</span><span class="n">groups</span><span class="p">),</span><span class="w"> </span><span class="n">mean</span><span class="p">),</span><span class="w"> </span><span class="m">2</span><span class="p">)</span><span class="w"> </span><span class="n">x</span><span class="o">$</span><span class="n">qtd</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="nf">as.numeric</span><span class="p">(</span><span class="n">table</span><span class="p">(</span><span class="n">groups</span><span class="p">))</span><span class="w"> </span><span class="c1"># colocar coluna de quantidade na segunda posi&#xE7;&#xE3;o
</span><span class="w"> </span><span class="n">x</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">x</span><span class="p">[,</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="m">6</span><span class="p">,</span><span class="w"> </span><span class="m">2</span><span class="p">,</span><span class="w"> </span><span class="m">3</span><span class="p">,</span><span class="w"> </span><span class="m">4</span><span class="p">,</span><span class="w"> </span><span class="m">5</span><span class="p">)]</span><span class="w"> </span><span class="nf">return</span><span class="p">(</span><span class="n">x</span><span class="p">)</span><span class="w">
</span><span class="p">}</span><span class="w"> </span><span class="p">(</span><span class="n">tabela</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">cluster.summary</span><span class="p">(</span><span class="n">df2</span><span class="p">,</span><span class="w"> </span><span class="n">lista_clusteres</span><span class="p">))</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## Group.1 qtd inflacao pib_per_capita crescimento_pib emprego
## 1 1 53 6.24 3131.17 5.89 94.47
## 2 2 27 1.47 57642.74 1.59 94.18
## 3 3 53 3.16 9476.58 2.28 92.44
## 4 4 20 2.20 10320.51 2.25 79.23</code></pre>
</figure>
<p>
Para melhorar a apresentação visual do output acima, usei o pacote
<code class="highlighter-rouge">formattable</code> junto com uma função
que criei para colorir de verde o valor caso seja superior ou igual à
média do indicador e vermelho caso contrário.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">colorir.valor</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">x</span><span class="p">)</span><span class="w"> </span><span class="n">ifelse</span><span class="p">(</span><span class="n">x</span><span class="w"> </span><span class="o">&gt;=</span><span class="w"> </span><span class="n">mean</span><span class="p">(</span><span class="n">x</span><span class="p">),</span><span class="w"> </span><span class="n">style</span><span class="p">(</span><span class="n">color</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;green&quot;</span><span class="p">),</span><span class="w"> </span><span class="n">style</span><span class="p">(</span><span class="n">color</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;red&quot;</span><span class="p">))</span><span class="w"> </span><span class="n">nome_colunas</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="s2">&quot;Cluster&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;Quantidade de pa&#xED;ses do cluster&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;Taxa de Infla&#xE7;&#xE3;o (%)&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;PIB Per Capita (US$)&quot;</span><span class="p">,</span><span class="s2">&quot;Crescimento anual do PIB (%)&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;Taxa de Emprego (%)&quot;</span><span class="p">)</span><span class="w"> </span><span class="n">formattable</span><span class="p">(</span><span class="w"> </span><span class="n">tabela</span><span class="p">,</span><span class="w"> </span><span class="nf">list</span><span class="p">(</span><span class="w"> </span><span class="n">pib_per_capita</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">formatter</span><span class="p">(</span><span class="s2">&quot;span&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">style</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">x</span><span class="w"> </span><span class="o">~</span><span class="w"> </span><span class="n">colorir.valor</span><span class="p">(</span><span class="n">x</span><span class="p">)),</span><span class="w"> </span><span class="n">crescimento_pib</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">formatter</span><span class="p">(</span><span class="s2">&quot;span&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">style</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">x</span><span class="w"> </span><span class="o">~</span><span class="w"> </span><span class="n">colorir.valor</span><span class="p">(</span><span class="n">x</span><span class="p">)),</span><span class="w"> </span><span class="n">emprego</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">formatter</span><span class="p">(</span><span class="s2">&quot;span&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">style</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">x</span><span class="w"> </span><span class="o">~</span><span class="w"> </span><span class="n">colorir.valor</span><span class="p">(</span><span class="n">x</span><span class="p">))</span><span class="w"> </span><span class="p">),</span><span class="w"> </span><span class="n">col.names</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">nome_colunas</span><span class="p">,</span><span class="w"> </span><span class="n">format</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;markdown&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">pad</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">0</span><span class="w"> </span><span class="p">)</span></code></pre>
</figure>
<table>
<thead>
<tr>
<th>
Cluster
</th>
<th>
Quantidade de países do cluster
</th>
<th>
Taxa de Inflação (%)
</th>
<th>
PIB Per Capita
(US) &lt; /*t**h* &gt; &lt;*t**h* &gt; *C**r**e**s**c**i**m**e**n**t**o**a**n**u**a**l**d**o**P**I**B*(</span><span
class="n">cluster</span><span class="w"> </span><span
class="o">&lt;-</span><span class="w"> </span><span
class="n">lista\_clusteres</span><span class="w"> </span><span
class="n">df2</span><span class="p">\[</span><span
class="s2">"Brazil"</span><span class="p">,\]</span></code>
</pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## inflacao pib_per_capita crescimento_pib emprego cluster
## Brazil 6.332092 11726.81 0.1033714 93.2 3</code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-r"><span class="n">cl_brasil</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">df2</span><span class="p">[</span><span class="s2">&quot;Brazil&quot;</span><span class="p">,</span><span class="w"> </span><span class="p">]</span><span class="o">$</span><span class="n">cluster</span><span class="w"> </span><span class="n">x</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">df2</span><span class="p">[</span><span class="n">df2</span><span class="o">$</span><span class="n">cluster</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="n">cl_brasil</span><span class="p">,</span><span class="w"> </span><span class="p">]</span><span class="w"> </span><span class="n">x</span><span class="p">[</span><span class="n">order</span><span class="p">(</span><span class="o">-</span><span class="n">x</span><span class="o">$</span><span class="n">pib_per_capita</span><span class="p">),]</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">knitr</span><span class="o">::</span><span class="n">kable</span><span class="p">()</span></code></pre>
</figure>
<table>
<thead>
<tr>
<th>
 
</th>
<th>
inflacao
</th>
<th>
pib\_per\_capita
</th>
<th>
crescimento\_pib
</th>
<th>
emprego
</th>
<th>
cluster
</th>
</tr>
</thead>
<tbody>
<tr>
<td>
Korea, Rep.
</td>
<td>
1.2724064
</td>
<td>
27970.4951
</td>
<td>
3.3101476
</td>
<td>
96.5
</td>
<td>
3
</td>
</tr>
<tr>
<td>
Bahrain
</td>
<td>
2.6511955
</td>
<td>
24855.2156
</td>
<td>
4.4809352
</td>
<td>
96.1
</td>
<td>
3
</td>
</tr>
<tr>
<td>
Saudi Arabia
</td>
<td>
2.6705256
</td>
<td>
24406.4765
</td>
<td>
3.6386990
</td>
<td>
94.4
</td>
<td>
3
</td>
</tr>
<tr>
<td>
Slovenia
</td>
<td>
0.2000749
</td>
<td>
24001.9014
</td>
<td>
3.0483310
</td>
<td>
90.5
</td>
<td>
3
</td>
</tr>
<tr>
<td>
Trinidad and Tobago
</td>
<td>
5.6844181
</td>
<td>
21323.7547
</td>
<td>
0.8171023
</td>
<td>
96.0
</td>
<td>
3
</td>
</tr>
<tr>
<td>
Estonia
</td>
<td>
-0.1448155
</td>
<td>
20147.7782
</td>
<td>
2.9065372
</td>
<td>
92.3
</td>
<td>
3
</td>
</tr>
<tr>
<td>
Czech Republic
</td>
<td>
0.3371869
</td>
<td>
19502.4173
</td>
<td>
1.9781540
</td>
<td>
93.8
</td>
<td>
3
</td>
</tr>
<tr>
<td>
Oman
</td>
<td>
1.0140148
</td>
<td>
19309.6124
</td>
<td>
2.8942055
</td>
<td>
92.8
</td>
<td>
3
</td>
</tr>
<tr>
<td>
Equatorial Guinea
</td>
<td>
4.8250896
</td>
<td>
18918.2768
</td>
<td>
-0.3040945
</td>
<td>
92.1
</td>
<td>
3
</td>
</tr>
<tr>
<td>
Slovak Republic
</td>
<td>
-0.0761653
</td>
<td>
18500.6646
</td>
<td>
2.5219336
</td>
<td>
86.7
</td>
<td>
3
</td>
</tr>
<tr>
<td>
Lithuania
</td>
<td>
0.1064941
</td>
<td>
16489.7290
</td>
<td>
3.0324700
</td>
<td>
88.7
</td>
<td>
3
</td>
</tr>
<tr>
<td>
Latvia
</td>
<td>
0.6085193
</td>
<td>
15692.1916
</td>
<td>
2.3592052
</td>
<td>
90.0
</td>
<td>
3
</td>
</tr>
<tr>
<td>
Barbados
</td>
<td>
1.8871702
</td>
<td>
15366.2926
</td>
<td>
0.1803427
</td>
<td>
88.0
</td>
<td>
3
</td>
</tr>
<tr>
<td>
Chile
</td>
<td>
4.3950000
</td>
<td>
14528.3258
</td>
<td>
1.8940490
</td>
<td>
93.6
</td>
<td>
3
</td>
</tr>
<tr>
<td>
Poland
</td>
<td>
0.1069519
</td>
<td>
14336.7977
</td>
<td>
3.3340489
</td>
<td>
90.8
</td>
<td>
3
</td>
</tr>
<tr>
<td>
Hungary
</td>
<td>
-0.2223151
</td>
<td>
14026.5744
</td>
<td>
3.6722200
</td>
<td>
92.2
</td>
<td>
3
</td>
</tr>
<tr>
<td>
Russian Federation
</td>
<td>
7.8128951
</td>
<td>
12735.9184
</td>
<td>
0.6404858
</td>
<td>
94.9
</td>
<td>
3
</td>
</tr>
<tr>
<td>
Brazil
</td>
<td>
6.3320923
</td>
<td>
11726.8059
</td>
<td>
0.1033714
</td>
<td>
93.2
</td>
<td>
3
</td>
</tr>
<tr>
<td>
Turkey
</td>
<td>
8.8545727
</td>
<td>
10515.0078
</td>
<td>
2.9141429
</td>
<td>
90.8
</td>
<td>
3
</td>
</tr>
<tr>
<td>
Costa Rica
</td>
<td>
4.5153127
</td>
<td>
10415.4444
</td>
<td>
3.5023522
</td>
<td>
91.7
</td>
<td>
3
</td>
</tr>
<tr>
<td>
Mexico
</td>
<td>
4.0186172
</td>
<td>
10325.6461
</td>
<td>
2.2307947
</td>
<td>
95.1
</td>
<td>
3
</td>
</tr>
<tr>
<td>
Lebanon
</td>
<td>
0.7497186
</td>
<td>
10057.8884
</td>
<td>
2.0000000
</td>
<td>
93.6
</td>
<td>
3
</td>
</tr>
<tr>
<td>
Mauritius
</td>
<td>
3.2176919
</td>
<td>
10016.6486
</td>
<td>
3.6000000
</td>
<td>
92.3
</td>
<td>
3
</td>
</tr>
<tr>
<td>
Romania
</td>
<td>
1.0689610
</td>
<td>
10000.0026
</td>
<td>
2.7773444
</td>
<td>
93.0
</td>
<td>
3
</td>
</tr>
<tr>
<td>
Suriname
</td>
<td>
3.3897457
</td>
<td>
9680.1159
</td>
<td>
1.8429092
</td>
<td>
94.4
</td>
<td>
3
</td>
</tr>
<tr>
<td>
Colombia
</td>
<td>
2.8778103
</td>
<td>
7903.9258
</td>
<td>
4.5525010
</td>
<td>
89.9
</td>
<td>
3
</td>
</tr>
<tr>
<td>
Azerbaijan
</td>
<td>
1.3850289
</td>
<td>
7886.4591
</td>
<td>
2.0000000
</td>
<td>
94.8
</td>
<td>
3
</td>
</tr>
<tr>
<td>
Bulgaria
</td>
<td>
-1.4181227
</td>
<td>
7851.2654
</td>
<td>
1.5502287
</td>
<td>
88.4
</td>
<td>
3
</td>
</tr>
<tr>
<td>
Peru
</td>
<td>
3.2260468
</td>
<td>
6541.0306
</td>
<td>
2.3502537
</td>
<td>
95.8
</td>
<td>
3
</td>
</tr>
<tr>
<td>
Ecuador
</td>
<td>
3.5731279
</td>
<td>
6345.8407
</td>
<td>
3.6749821
</td>
<td>
95.4
</td>
<td>
3
</td>
</tr>
<tr>
<td>
Thailand
</td>
<td>
1.8903771
</td>
<td>
5977.3806
</td>
<td>
0.8656637
</td>
<td>
99.1
</td>
<td>
3
</td>
</tr>
<tr>
<td>
Algeria
</td>
<td>
2.9164064
</td>
<td>
5484.0668
</td>
<td>
3.8000000
</td>
<td>
90.5
</td>
<td>
3
</td>
</tr>
<tr>
<td>
Jordan
</td>
<td>
2.8915663
</td>
<td>
5422.5709
</td>
<td>
3.0963303
</td>
<td>
88.9
</td>
<td>
3
</td>
</tr>
<tr>
<td>
Jamaica
</td>
<td>
8.2900058
</td>
<td>
5106.0775
</td>
<td>
0.6877507
</td>
<td>
86.8
</td>
<td>
3
</td>
</tr>
<tr>
<td>
Belize
</td>
<td>
1.2013996
</td>
<td>
4831.1776
</td>
<td>
3.5833148
</td>
<td>
88.5
</td>
<td>
3
</td>
</tr>
<tr>
<td>
Georgia
</td>
<td>
3.0688121
</td>
<td>
4435.1927
</td>
<td>
4.7664424
</td>
<td>
86.6
</td>
<td>
3
</td>
</tr>
<tr>
<td>
Tunisia
</td>
<td>
4.9377353
</td>
<td>
4420.6984
</td>
<td>
2.6958334
</td>
<td>
86.7
</td>
<td>
3
</td>
</tr>
<tr>
<td>
El Salvador
</td>
<td>
1.1057751
</td>
<td>
4119.9920
</td>
<td>
1.9519442
</td>
<td>
93.8
</td>
<td>
3
</td>
</tr>
<tr>
<td>
Egypt, Arab Rep.
</td>
<td>
10.1458006
</td>
<td>
3365.7074
</td>
<td>
2.2287910
</td>
<td>
86.8
</td>
<td>
3
</td>
</tr>
<tr>
<td>
Morocco
</td>
<td>
0.4354565
</td>
<td>
3190.3104
</td>
<td>
2.4170812
</td>
<td>
89.8
</td>
<td>
3
</td>
</tr>
<tr>
<td>
Ukraine
</td>
<td>
12.1883657
</td>
<td>
3082.4614
</td>
<td>
-6.8000082
</td>
<td>
92.3
</td>
<td>
3
</td>
</tr>
<tr>
<td>
Honduras
</td>
<td>
6.1292493
</td>
<td>
2434.8272
</td>
<td>
3.0852150
</td>
<td>
96.1
</td>
<td>
3
</td>
</tr>
<tr>
<td>
Solomon Islands
</td>
<td>
5.1659024
</td>
<td>
2024.1904
</td>
<td>
1.5074263
</td>
<td>
96.1
</td>
<td>
3
</td>
</tr>
<tr>
<td>
Senegal
</td>
<td>
-1.0797448
</td>
<td>
1067.1318
</td>
<td>
4.7205396
</td>
<td>
90.0
</td>
<td>
3
</td>
</tr>
<tr>
<td>
Zimbabwe
</td>
<td>
-0.2172862
</td>
<td>
931.1982
</td>
<td>
3.8482899
</td>
<td>
94.6
</td>
<td>
3
</td>
</tr>
<tr>
<td>
Haiti
</td>
<td>
4.5661735
</td>
<td>
824.1598
</td>
<td>
2.7498502
</td>
<td>
93.2
</td>
<td>
3
</td>
</tr>
<tr>
<td>
Comoros
</td>
<td>
0.5787475
</td>
<td>
810.0758
</td>
<td>
2.0616395
</td>
<td>
93.5
</td>
<td>
3
</td>
</tr>
<tr>
<td>
Burkina Faso
</td>
<td>
-0.2580895
</td>
<td>
713.0639
</td>
<td>
3.9960447
</td>
<td>
96.9
</td>
<td>
3
</td>
</tr>
<tr>
<td>
Afghanistan
</td>
<td>
4.6043340
</td>
<td>
633.5692
</td>
<td>
1.3125309
</td>
<td>
90.9
</td>
<td>
3
</td>
</tr>
<tr>
<td>
Guinea-Bissau
</td>
<td>
-1.5092446
</td>
<td>
567.8226
</td>
<td>
2.5402863
</td>
<td>
93.1
</td>
<td>
3
</td>
</tr>
<tr>
<td>
Guinea
</td>
<td>
9.7139773
</td>
<td>
539.6158
</td>
<td>
0.3999986
</td>
<td>
98.2
</td>
<td>
3
</td>
</tr>
<tr>
<td>
Liberia
</td>
<td>
9.8263580
</td>
<td>
457.8586
</td>
<td>
0.7011416
</td>
<td>
96.2
</td>
<td>
3
</td>
</tr>
<tr>
<td>
Gambia, The
</td>
<td>
5.9473749
</td>
<td>
441.2934
</td>
<td>
0.8774606
</td>
<td>
93.0
</td>
<td>
3
</td>
</tr>
</tbody>
</table>
<p>
Dá para perceber que existe um problema com nosso resultado: No mesmo
segmento, estão presentes a Coreia do Sul e países como Haiti e
Zimbábue. Isso pode ser explicado por uma série de razões, como:
</p>
<ul>
<li>
O número e perfil dos indicadores macroeconômicos escolhidos não é bom o
suficiente para determinar uma segmentação eficiente dos países;
</li>
<li>
O número de clusteres deveria ser maior;
</li>
<li>
Deveriam ser feitas apenas interações (escolhendo valores diferentes
como argumento de <code class="highlighter-rouge">set.seed()</code>)
</li>
<li>
O erro se deve a um erro aleatório, também chamado de ruído, do
algoritmo k-means. Afinal de contas, como sabemos, nenhum modelo é
perfeito.
</li>
</ul>
</article>

