+++
title = "INTRODUÇÃO AO R - Aula 2a"
date = "2016-09-27 03:00:00"
categories = ["r-python-e-redes"]
original_url = "http://neylsoncrepalde.github.io/2016-09-27-introducao-ao-r-aula-2a/"
+++

<article class="blog-post">
<p>
Vamos analisar um banco de dados imbutido no
<code class="highlighter-rouge">R</code> com dados de medidas de tamanho
e espessura de pétalas e sépalas de 3 diferentes espécies de flores.
</p>
<pre class="highlight"><code><span class="n">options</span><span class="p">(</span><span class="n">scipen</span><span class="o">=</span><span class="m">999</span><span class="p">)</span><span class="w"> </span><span class="c1"># Tira a nota&#xE7;&#xE3;o cient&#xED;fica do tipo 2e-16
</span><span class="n">data</span><span class="p">(</span><span class="n">iris</span><span class="p">)</span><span class="w">
</span><span class="nf">names</span><span class="p">(</span><span class="n">iris</span><span class="p">)</span><span class="w"> </span><span class="c1"># Retorna o nome das vari&#xE1;veis
</span></code></pre>

<pre class="highlight"><code>## [1] &quot;Sepal.Length&quot; &quot;Sepal.Width&quot; &quot;Petal.Length&quot; &quot;Petal.Width&quot; ## [5] &quot;Species&quot;
</code></pre>

<pre class="highlight"><code><span class="nf">dim</span><span class="p">(</span><span class="n">iris</span><span class="p">)</span><span class="w"> </span><span class="c1"># Dimens&#xF5;es do banco de dados
</span></code></pre>

<pre class="highlight"><code><span class="n">head</span><span class="p">(</span><span class="n">iris</span><span class="p">)</span><span class="w"> </span><span class="c1"># Mostra as primeiras colunas
</span></code></pre>

<pre class="highlight"><code>## Sepal.Length Sepal.Width Petal.Length Petal.Width Species
## 1 5.1 3.5 1.4 0.2 setosa
## 2 4.9 3.0 1.4 0.2 setosa
## 3 4.7 3.2 1.3 0.2 setosa
## 4 4.6 3.1 1.5 0.2 setosa
## 5 5.0 3.6 1.4 0.2 setosa
## 6 5.4 3.9 1.7 0.4 setosa
</code></pre>

<pre class="highlight"><code><span class="n">tail</span><span class="p">(</span><span class="n">iris</span><span class="p">)</span><span class="w"> </span><span class="c1"># Mostra as &#xFA;ltimas colunas
</span></code></pre>

<pre class="highlight"><code>## Sepal.Length Sepal.Width Petal.Length Petal.Width Species
## 145 6.7 3.3 5.7 2.5 virginica
## 146 6.7 3.0 5.2 2.3 virginica
## 147 6.3 2.5 5.0 1.9 virginica
## 148 6.5 3.0 5.2 2.0 virginica
## 149 6.2 3.4 5.4 2.3 virginica
## 150 5.9 3.0 5.1 1.8 virginica
</code></pre>

<pre class="highlight"><code><span class="n">View</span><span class="p">(</span><span class="n">iris</span><span class="p">)</span><span class="w"> </span><span class="c1"># Visualizar o banco de dados completo
</span></code></pre>

<p>
Vamos olhar primeiro para a classe de cada variável:
</p>
<p>
As quatro primeiras variáveis são numéricas. A última é do tipo
<code class="highlighter-rouge">factor</code>, uma classe que ainda não
abordamos. Faremos isso mais adiante. Vamos nos concentrar agora em
possibilidades de análises para dados do tipo numeric.
</p>
<p>
Podemos pedir um conjunto de estatísticas descritivas dos dados com o
comando <code class="highlighter-rouge">summary()</code>
</p>
<pre class="highlight"><code>## Sepal.Length Sepal.Width Petal.Length Petal.Width ## Min. :4.300 Min. :2.000 Min. :1.000 Min. :0.100 ## 1st Qu.:5.100 1st Qu.:2.800 1st Qu.:1.600 1st Qu.:0.300 ## Median :5.800 Median :3.000 Median :4.350 Median :1.300 ## Mean :5.843 Mean :3.057 Mean :3.758 Mean :1.199 ## 3rd Qu.:6.400 3rd Qu.:3.300 3rd Qu.:5.100 3rd Qu.:1.800 ## Max. :7.900 Max. :4.400 Max. :6.900 Max. :2.500 ## Species ## setosa :50 ## versicolor:50 ## virginica :50 ## ## ## </code></pre>

<p>
Podemos usar o mesmo comando para tirar estatísticas descritivas de cada
variável
</p>
<pre class="highlight"><code><span class="n">summary</span><span class="p">(</span><span class="n">iris</span><span class="o">$</span><span class="n">Sepal.Length</span><span class="p">)</span><span class="w">
</span></code></pre>

<pre class="highlight"><code>## Min. 1st Qu. Median Mean 3rd Qu. Max. ## 4.300 5.100 5.800 5.843 6.400 7.900
</code></pre>

<p>
ou pedir as estatísticas que nos interessam. Por exemplo:
</p>
<pre class="highlight"><code><span class="n">mean</span><span class="p">(</span><span class="n">iris</span><span class="o">$</span><span class="n">Sepal.Length</span><span class="p">)</span><span class="w"> </span><span class="c1"># M&#xE9;dia
</span></code></pre>

<pre class="highlight"><code><span class="n">median</span><span class="p">(</span><span class="n">iris</span><span class="o">$</span><span class="n">Sepal.Length</span><span class="p">)</span><span class="w"> </span><span class="c1"># Mediana
</span></code></pre>

<pre class="highlight"><code><span class="n">var</span><span class="p">(</span><span class="n">iris</span><span class="o">$</span><span class="n">Sepal.Length</span><span class="p">)</span><span class="w"> </span><span class="c1"># Vari&#xE2;ncia
</span></code></pre>

<pre class="highlight"><code><span class="n">sd</span><span class="p">(</span><span class="n">iris</span><span class="o">$</span><span class="n">Sepal.Length</span><span class="p">)</span><span class="w"> </span><span class="c1"># Desvio Padr&#xE3;o
</span></code></pre>

<pre class="highlight"><code><span class="nf">max</span><span class="p">(</span><span class="n">iris</span><span class="o">$</span><span class="n">Sepal.Length</span><span class="p">)</span><span class="w"> </span><span class="c1"># M&#xE1;ximo
</span></code></pre>

<pre class="highlight"><code><span class="nf">min</span><span class="p">(</span><span class="n">iris</span><span class="o">$</span><span class="n">Sepal.Length</span><span class="p">)</span><span class="w"> </span><span class="c1"># M&#xED;nimo
</span></code></pre>

<pre class="highlight"><code><span class="n">quantile</span><span class="p">(</span><span class="n">iris</span><span class="o">$</span><span class="n">Sepal.Length</span><span class="p">)</span><span class="w"> </span><span class="c1"># Quartis
</span></code></pre>

<pre class="highlight"><code>## 0% 25% 50% 75% 100% ## 4.3 5.1 5.8 6.4 7.9
</code></pre>

<pre class="highlight"><code><span class="n">quantile</span><span class="p">(</span><span class="n">iris</span><span class="o">$</span><span class="n">Sepal.Length</span><span class="p">,</span><span class="w"> </span><span class="n">probs</span><span class="w"> </span><span class="o">=</span><span class="nf">c</span><span class="p">(</span><span class="m">0</span><span class="p">,</span><span class="m">.1</span><span class="p">,</span><span class="m">.2</span><span class="p">,</span><span class="m">.3</span><span class="p">,</span><span class="m">.4</span><span class="p">,</span><span class="m">.5</span><span class="p">,</span><span class="m">.6</span><span class="p">,</span><span class="m">.7</span><span class="p">,</span><span class="m">.8</span><span class="p">,</span><span class="m">.9</span><span class="p">,</span><span class="m">1</span><span class="p">))</span><span class="w"> </span><span class="c1"># Decis
</span></code></pre>

<pre class="highlight"><code>## 0% 10% 20% 30% 40% 50% 60% 70% 80% 90% 100% ## 4.30 4.80 5.00 5.27 5.60 5.80 6.10 6.30 6.52 6.90 7.90
</code></pre>

<h2 id="algumas-estatísticas-comuns">
Algumas estatísticas comuns
</h2>
<p>
Vamos investigar algumas relações entre essas variáveis. Primeiro, vamos
tirar uma matriz de correlações.
</p>
<pre class="highlight"><code><span class="n">cor</span><span class="p">(</span><span class="n">iris</span><span class="p">[,</span><span class="m">1</span><span class="o">:</span><span class="m">4</span><span class="p">])</span><span class="w"> </span><span class="c1"># Correlaciona as vari&#xE1;veis de 1 a 4
</span></code></pre>

<pre class="highlight"><code>## Sepal.Length Sepal.Width Petal.Length Petal.Width
## Sepal.Length 1.0000000 -0.1175698 0.8717538 0.8179411
## Sepal.Width -0.1175698 1.0000000 -0.4284401 -0.3661259
## Petal.Length 0.8717538 -0.4284401 1.0000000 0.9628654
## Petal.Width 0.8179411 -0.3661259 0.9628654 1.0000000
</code></pre>

<pre class="highlight"><code><span class="n">cor</span><span class="p">(</span><span class="n">iris</span><span class="o">$</span><span class="n">Sepal.Length</span><span class="p">,</span><span class="w"> </span><span class="n">iris</span><span class="o">$</span><span class="n">Petal.Length</span><span class="p">)</span><span class="w"> </span><span class="c1"># Correla&#xE7;&#xE3;o entre duas vari&#xE1;veis
</span></code></pre>

<pre class="highlight"><code><span class="n">cor.test</span><span class="p">(</span><span class="n">iris</span><span class="o">$</span><span class="n">Sepal.Length</span><span class="p">,</span><span class="w"> </span><span class="n">iris</span><span class="o">$</span><span class="n">Petal.Length</span><span class="p">)</span><span class="w"> </span><span class="c1"># Correla&#xE7;&#xE3;o com teste estat&#xED;stico
</span></code></pre>

<pre class="highlight"><code>## ## Pearson&apos;s product-moment correlation
## ## data: iris$Sepal.Length and iris$Petal.Length
## t = 21.646, df = 148, p-value &lt; 0.00000000000000022
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
## 0.8270363 0.9055080
## sample estimates:
## cor ## 0.8717538
</code></pre>

<pre class="highlight"><code><span class="n">plot</span><span class="p">(</span><span class="n">iris</span><span class="o">$</span><span class="n">Sepal.Length</span><span class="p">,</span><span class="w"> </span><span class="n">iris</span><span class="o">$</span><span class="n">Petal.Length</span><span class="p">)</span><span class="w"> </span><span class="c1"># produz um scatterplot
</span></code></pre>

<p>
<img src="http://neylsoncrepalde.github.io/img/intro_r_aula2a_files/figure-markdown_github/unnamed-chunk-6-1.png" alt="">
</p>
<p>
Podemos fazer algumas seleções (<em>subsettings</em>) em nossos dados
caso queiramos investigar um grupo específico. Neste caso, vamos olhar
para algumas estatísticas das flores pertencentes apenas ao grupo
<code class="highlighter-rouge">virginica</code>.
</p>
<pre class="highlight"><code><span class="c1"># Seleciono as linhas em que a vari&#xE1;vel Species &#xE9; igual ao character &quot;virginica&quot;
</span><span class="n">summary</span><span class="p">(</span><span class="n">iris</span><span class="p">[</span><span class="n">iris</span><span class="o">$</span><span class="n">Species</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="s2">&quot;virginica&quot;</span><span class="p">,</span><span class="w"> </span><span class="p">])</span><span class="w">
</span></code></pre>

<pre class="highlight"><code>## Sepal.Length Sepal.Width Petal.Length Petal.Width ## Min. :4.900 Min. :2.200 Min. :4.500 Min. :1.400 ## 1st Qu.:6.225 1st Qu.:2.800 1st Qu.:5.100 1st Qu.:1.800 ## Median :6.500 Median :3.000 Median :5.550 Median :2.000 ## Mean :6.588 Mean :2.974 Mean :5.552 Mean :2.026 ## 3rd Qu.:6.900 3rd Qu.:3.175 3rd Qu.:5.875 3rd Qu.:2.300 ## Max. :7.900 Max. :3.800 Max. :6.900 Max. :2.500 ## Species ## setosa : 0 ## versicolor: 0 ## virginica :50 ## ## ## </code></pre>

<pre class="highlight"><code><span class="c1"># Seleciono apenas os casos da vari&#xE1;vel Petal.Length que perten&#xE7;am ao grupo &quot;virginica&quot;
</span><span class="n">mean</span><span class="p">(</span><span class="n">iris</span><span class="o">$</span><span class="n">Petal.Length</span><span class="p">[</span><span class="n">iris</span><span class="o">$</span><span class="n">Species</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="s2">&quot;virginica&quot;</span><span class="p">])</span><span class="w"> </span></code></pre>

<pre class="highlight"><code><span class="n">var</span><span class="p">(</span><span class="n">iris</span><span class="o">$</span><span class="n">Petal.Length</span><span class="p">[</span><span class="n">iris</span><span class="o">$</span><span class="n">Species</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="s2">&quot;virginica&quot;</span><span class="p">])</span><span class="w">
</span></code></pre>

<pre class="highlight"><code><span class="n">sd</span><span class="p">(</span><span class="n">iris</span><span class="o">$</span><span class="n">Petal.Length</span><span class="p">[</span><span class="n">iris</span><span class="o">$</span><span class="n">Species</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="s2">&quot;virginica&quot;</span><span class="p">])</span><span class="w">
</span></code></pre>

<h3 id="atenção">
Atenção!
</h3>
<ol>
<li>
<p>
Veja que no caso de summary, usamos vírgula porque especificamos no
<em>subsetting</em> linhas e colunas. Quando usamos os comandos
<code class="highlighter-rouge">mean()</code>,
<code class="highlighter-rouge">var()</code> e
<code class="highlighter-rouge">sd()</code>, não usamos vírgula pois
trata-se de vetores numéricos, ou seja, especificamos apenas posições.
</p>
</li>
<li>
<p>
Para estabelecer uma relação de igualdade no R usamos
<code class="highlighter-rouge">==</code> (igual, igual) pois
<code class="highlighter-rouge">=</code> (igual) é um símbolo de
atribuição (lembram?). Outros comparativos são
<code class="highlighter-rouge">&gt;</code> (maior que),
<code class="highlighter-rouge">&lt;</code> (menor que),
<code class="highlighter-rouge">&lt;=</code>, (menor ou igual),
<code class="highlighter-rouge">&gt;=</code> (maior ou igual),
<code class="highlighter-rouge">!=</code> (diferente).
</p>
</li>
</ol>
<p>
Podemos fazer um teste de duas médias, ou teste <strong>T de
Student</strong>. Testaremos se dois grupos tem médias estatisticamente
diferentes ou não. Para isso, primeiro, vamos criar um novo objeto
apenas com os dados de duas espécies. Veja bem que esse tipo de teste é
feito quando se tem uma variável numérica e uma variável categórica
<strong>com duas categorias</strong>.
</p>
<pre class="highlight"><code><span class="c1"># Selecionando as linhas em que Species seja DIFERENTE de &quot;setosa&quot;. </span><span class="n">dados</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">iris</span><span class="p">[</span><span class="n">iris</span><span class="o">$</span><span class="n">Species</span><span class="w"> </span><span class="o">!=</span><span class="w"> </span><span class="s2">&quot;setosa&quot;</span><span class="p">,]</span><span class="w">
</span><span class="n">t.test</span><span class="p">(</span><span class="n">dados</span><span class="o">$</span><span class="n">Petal.Length</span><span class="o">~</span><span class="n">dados</span><span class="o">$</span><span class="n">Species</span><span class="p">)</span><span class="w">
</span></code></pre>

<pre class="highlight"><code>## ## Welch Two Sample t-test
## ## data: dados$Petal.Length by dados$Species
## t = -12.604, df = 95.57, p-value &lt; 0.00000000000000022
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
## -1.49549 -1.08851
## sample estimates:
## mean in group versicolor mean in group virginica ## 4.260 5.552
</code></pre>

<pre class="highlight"><code><span class="n">boxplot</span><span class="p">(</span><span class="n">dados</span><span class="o">$</span><span class="n">Petal.Length</span><span class="o">~</span><span class="n">dados</span><span class="o">$</span><span class="n">Species</span><span class="p">)</span><span class="w">
</span></code></pre>

<p>
<img src="http://neylsoncrepalde.github.io/img/intro_r_aula2a_files/figure-markdown_github/unnamed-chunk-8-1.png" alt="">
</p>
<p>
Neste caso, os grupos tem médias estatisticamente diferentes.
</p>
<p>
Para testar se médias de mais de dois grupos são estatisticamente
diferentes, use a <strong>análise de variância</strong>, ou ANOVA. Vamos
testar se existe diferença estatística entre uma das médias da variável
Petal.Length para os três grupos de espécies.
</p>
<pre class="highlight"><code><span class="n">summary</span><span class="p">(</span><span class="n">aov</span><span class="p">(</span><span class="n">iris</span><span class="o">$</span><span class="n">Petal.Length</span><span class="o">~</span><span class="n">iris</span><span class="o">$</span><span class="n">Species</span><span class="p">))</span><span class="w">
</span></code></pre>

<pre class="highlight"><code>## Df Sum Sq Mean Sq F value Pr(&gt;F) ## iris$Species 2 437.1 218.55 1180 &lt;0.0000000000000002 ***
## Residuals 147 27.2 0.19 ## ---
## Signif. codes: 0 &apos;***&apos; 0.001 &apos;**&apos; 0.01 &apos;*&apos; 0.05 &apos;.&apos; 0.1 &apos; &apos; 1
</code></pre>

<p>
Neste caso, pelo menos 1 dos grupos tem média estatisticamente diferente
dos demais.
</p>
<h3 id="variáveis-factor">
Variáveis FACTOR
</h3>
<p>
As variáveis de classe <code class="highlighter-rouge">factor</code> são
variáveis categóricas. Nessa classe, cada categoria tem um
<em>label</em>. Podemos criar uma variável categórica entrando com os
dados e definindo os labels, por exemplo:
</p>
<pre class="highlight"><code><span class="n">sexo</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">factor</span><span class="p">(</span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="s2">&quot;Feminino&quot;</span><span class="p">,</span><span class="s2">&quot;Masculino&quot;</span><span class="p">,</span><span class="s2">&quot;Feminino&quot;</span><span class="p">,</span><span class="s2">&quot;Masculino&quot;</span><span class="p">,</span><span class="s2">&quot;Feminino&quot;</span><span class="p">,</span><span class="s2">&quot;Feminino&quot;</span><span class="p">),</span><span class="w"> </span><span class="n">levels</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="s2">&quot;Feminino&quot;</span><span class="p">,</span><span class="s2">&quot;Masculino&quot;</span><span class="p">))</span><span class="w">
</span><span class="n">sexo</span><span class="w">
</span></code></pre>

<pre class="highlight"><code>## [1] Feminino Masculino Feminino Masculino Feminino Feminino ## Levels: Feminino Masculino
</code></pre>

<p>
Há uma função excelente implementada no pacote
<code class="highlighter-rouge">descr</code> para tabela de frequências
de uma variável categórica. Trata-se da função
<code class="highlighter-rouge">freq()</code>. Para usá-la, primeiro, se
ele não estiver instalado, podemos instalá-lo com o comando
<code class="highlighter-rouge">install.packages()</code>. Segundo,
precisamos carregar o pacote no ambiente.
</p>
<pre class="highlight"><code><span class="n">install.packages</span><span class="p">(</span><span class="s2">&quot;descr&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">dependencies</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nb">T</span><span class="p">)</span><span class="w"> </span><span class="c1"># Instala tamb&#xE9;m as depend&#xEA;ncias do pacote.
</span></code></pre>

<pre class="highlight"><code><span class="n">library</span><span class="p">(</span><span class="n">descr</span><span class="p">)</span><span class="w">
</span><span class="n">freq</span><span class="p">(</span><span class="n">sexo</span><span class="p">)</span><span class="w">
</span></code></pre>

<p>
<img src="http://neylsoncrepalde.github.io/img/intro_r_aula2a_files/figure-markdown_github/unnamed-chunk-12-1.png" alt="">
</p>
<pre class="highlight"><code>## sexo ## Frequ&#xEA;ncia Percentual
## Feminino 4 66.67
## Masculino 2 33.33
## Total 6 100.00
</code></pre>

<p>
Vamos usar essa mesma função para analisar a variável Species do banco
<code class="highlighter-rouge">iris</code>.
</p>
<p>
<img src="http://neylsoncrepalde.github.io/img/intro_r_aula2a_files/figure-markdown_github/unnamed-chunk-13-1.png" alt="">
</p>
<pre class="highlight"><code>## iris$Species ## Frequ&#xEA;ncia Percentual
## setosa 50 33.33
## versicolor 50 33.33
## virginica 50 33.33
## Total 150 100.00
</code></pre>

<p>
Guarde esse comando. Ele é bastante útil.
</p>
<h2 id="gráficos">
Gráficos
</h2>
<p>
Visualização de dados não é algo trivial e há vários estudos
interessantes sobre o assunto. Apresentarei aqui apenas algumas dicas
básicas.
</p>
<p>
Para visualizar a distribuição de uma variável, usamos um histograma.
</p>
<p>
<img src="http://neylsoncrepalde.github.io/img/intro_r_aula2a_files/figure-markdown_github/unnamed-chunk-14-1.png" alt="">
</p>
<p>
Podemos adicionar um <em>label</em> para o eixo x, para o eixo y, um
título mais bonito e uma cor no gráfico para que ele fique um pouco mais
simpático:
</p>
<pre class="highlight"><code><span class="n">hist</span><span class="p">(</span><span class="n">iris</span><span class="o">$</span><span class="n">Petal.Length</span><span class="p">,</span><span class="w"> </span><span class="n">xlab</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Comprimento da P&#xE9;tala&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">ylab</span><span class="o">=</span><span class="s2">&quot;Frequ&#xEA;ncia&quot;</span><span class="w"> </span><span class="p">,</span><span class="n">main</span><span class="o">=</span><span class="s2">&quot;Histograma do Comprimento da P&#xE9;tala&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">col</span><span class="o">=</span><span class="s2">&quot;green&quot;</span><span class="p">)</span><span class="w">
</span></code></pre>

<p>
<img src="http://neylsoncrepalde.github.io/img/intro_r_aula2a_files/figure-markdown_github/unnamed-chunk-15-1.png" alt="">
</p>
<p>
Para visualizar duas variáveis numéricas, podemos usar um
<em>scatterplot</em> como fizemos acima.
</p>
<pre class="highlight"><code><span class="n">plot</span><span class="p">(</span><span class="n">iris</span><span class="o">$</span><span class="n">Petal.Length</span><span class="p">,</span><span class="w"> </span><span class="n">iris</span><span class="o">$</span><span class="n">Sepal.Length</span><span class="p">)</span><span class="w">
</span></code></pre>

<p>
<img src="http://neylsoncrepalde.github.io/img/intro_r_aula2a_files/figure-markdown_github/unnamed-chunk-16-1.png" alt="">
</p>
<p>
Para visualizar diferenças de variáveis numéricas entre grupos, podemos
usar <em>boxplots</em>.
</p>
<pre class="highlight"><code><span class="n">boxplot</span><span class="p">(</span><span class="n">iris</span><span class="o">$</span><span class="n">Petal.Length</span><span class="o">~</span><span class="n">iris</span><span class="o">$</span><span class="n">Species</span><span class="p">)</span><span class="w">
</span></code></pre>

<p>
<img src="http://neylsoncrepalde.github.io/img/intro_r_aula2a_files/figure-markdown_github/unnamed-chunk-17-1.png" alt="">
</p>
<p>
Podemos ainda plotar as frequências de uma variável categórica:
</p>
<pre class="highlight"><code><span class="n">barplot</span><span class="p">(</span><span class="n">table</span><span class="p">(</span><span class="n">iris</span><span class="o">$</span><span class="n">Species</span><span class="p">))</span><span class="w">
</span></code></pre>

<p>
<img src="http://neylsoncrepalde.github.io/img/intro_r_aula2a_files/figure-markdown_github/unnamed-chunk-18-1.png" alt="">
</p>
<p>
Veja que o comando <code class="highlighter-rouge">freq()</code> que
utilizamos mais cedo já produz esse gráfico por <em>default</em>.
</p>
</article>
<p class="blog-tags">
Tags: R programming, rstats
</p>

