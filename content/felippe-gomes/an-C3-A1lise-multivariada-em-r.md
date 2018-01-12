+++
title = "Análise Multivariada com R"
date = "2018-01-04"
categories = ["felippe-gomes"]
original_url = "https://gomesfellipe.github.io/post/2018-01-01-analise-multivariada-em-r/an%C3%A1lise-multivariada-em-r/"
+++

<p id="main">
<article class="post">
<header>
</header>
<a href="https://gomesfellipe.github.io/post/2018-01-01-analise-multivariada-em-r/an%C3%A1lise-multivariada-em-r/" class="image featured">
<img src="https://gomesfellipe.github.io/img/2018/01/multivariada-fatorial-cluster-R.png" alt="">
</a>
<p>
Esse é o primeiro post do ano e como no ano de 2017 falou-se tanto das
maravilhas computacionais desta onda do Big Data e em contra partida,
<a href="https://gomesfellipe.github.io/post/2017-12-12-google-trends-e-r/google-trends-e-r/">identificamos
que deste 2004 a popularidade pelo termo “estatística” vem diminuindo
como mostrei em uma breve pesquisa neste post sobre a API do
googletrends</a> sinto que existe uma necessidade de se ampliar também a
divulgação dos métodos estatísticos pois o aprofundamento na teoria é
fundamental (é muito fácil achar resultados sem fundamento apenas
“apertando botão”), como as ferramentas da estatística multivariada que
muitas vezes servem como soluções para essas grandes quantidades de
dados
</p>
<p>
Diversas vezes nos deparamos com bases de dados que envolvem além de
muitas observações, muitas variáveis, especialmente nas análises de
fenômenos ou processos sociais, psicológicos, educacionais e econômicos
bem como na área da química, biologia, geologia, marketing, medicina,
medicina veterinária, dentre muitas outras.
</p>
<p>
Com as ferramentas estatísticas da análise multivariada somos capazes de
identificar muitos elementos que podem ter relevância na análise dos
dados, dois exemplos de ferramentas importantes são as que permitem
encontrar fatores que não são diretamente observáveis com base em um
conjunto de variáveis observáveis e as que permitem agrupar conjuntos de
dados que possuem características semelhantes com algorítimos
computacionais (chamados de aprendizados não-supervisionados ou
semi-supervisionados em machine learning) e a partir dai estudar as
novas classificações.
</p>
<p>
Neste post será apresentado algumas soluções para o caso em que existe a
necessidade de avaliar um grande conjunto de dados com muitas variáveis
e não temos muitas informações a respeito.
</p>

<p>
Na análise fatorial buscamos fatores que explicam parte da variância
total dos dados, os fatores são as somas das variâncias originais.
</p>
<ul>
<li>
<p>
Procura identificar fatores que não são diretamente observáveis, com
base em um conjunto de variáveis observáveis.
</p>
</li>
<li>
<p>
Explicar a correlação ou covariância, entre um conjunto de variáveis, em
termos de um número limitado de variáveis não-observáveis, chamadas de
fatores ou variáveis latentes.
</p>
</li>
<li>
<p>
Em casos nos quais se tem um número grande de variáveis medidas e
correlacionadas entre si, seria possível identificar-se um número menor
de variáveis alternativas, não correlacionadas e que de algum modo
sumarizassem as informações principais das variáveis originais.
</p>
</li>
<li>
<p>
A partir do momento em que os fatores são identificados, seus valores
numéricos, chamados de escores, podem ser obtidos para cada elemento
amostral. Conseqüentemente, estes escores podem ser utilizados em outras
análises que envolvam outras técnicas estatísticas, como análise de
regressão ou análise de variância, por exemplo.
</p>
</li>
</ul>

<ul>
<li>
<p>
Computação da matriz de correlações para as variáveis originais;
</p>
</li>
<li>
<p>
Extração de fatores
</p>
</li>
<li>
<p>
Rotação dos fatores para tonar a interpretação mais fácil;
</p>
</li>
<li>
<p>
Cálculo dos escores dos fatores
</p>
</li>
</ul>
<ul>
<li>
Teste de Bartlett - a hipótese nula da matriz de correlação ser uma
matriz identidade ( <span class="math inline">|*R*|=1</span> ), isto é,
avalia se os componentes fora da diagonal principal são zero. O
resultado significativo indica que existem algumas relações entre as
variáveis.
</li>
</ul>
<p>
No R:
</p>
<pre class="r"><code>Bartlett.sphericity.test &lt;- function(x) { method &lt;- &quot;Teste de esfericidade de Bartlett&quot; data.name &lt;- deparse(substitute(x)) x &lt;- subset(x, complete.cases(x)) # Omitindo valores faltantes n &lt;- nrow(x) p &lt;- ncol(x) chisq &lt;- (1-n+(2*p+5)/6)*log(det(cor(x))) df &lt;- p*(p-1)/2 p.value &lt;- pchisq(chisq, df, lower.tail=FALSE) names(chisq) &lt;- &quot;X-squared&quot; names(df) &lt;- &quot;df&quot; return(structure(list(statistic=chisq, parameter=df, p.value=p.value, method=method, data.name=data.name), class=&quot;htest&quot;)) } Bartlett.sphericity.test(dados)</code></pre>
<pre><code>## ## Teste de esfericidade de Bartlett ## ## data: dados ## X-squared = 2590.3, df = 55, p-value &lt; 2.2e-16</code></pre>
<ul>
<li>
Teste KMO (Kaiser-Meyer-Olkin) - avalia a adequação do tamanho amostra.
Varia entre 0 e 1, onde: zero indica inadequado para análise fatorial,
aceitável se for maior que 0.5, recomendado acima de 0.8.
</li>
</ul>
<p>
No R:
</p>
<pre class="r"><code>kmo = function(x) { x = subset(x, complete.cases(x)) r = cor(x) r2 = r^2 i = solve(r) d = diag(i) p2 = (-i/sqrt(outer(d, d)))^2 diag(r2) &lt;- diag(p2) &lt;- 0 KMO = sum(r2)/(sum(r2)+sum(p2)) MSA = colSums(r2)/(colSums(r2)+colSums(p2)) return(list(KMO=KMO, MSA=MSA)) } kmo(dados)</code></pre>
<pre><code>## $KMO ## [1] 0.5942236 ## ## $MSA ## A B C D E F G ## 0.6789278 0.9151657 0.6897541 0.3385536 0.8699746 0.3632508 0.5172135 ## H I J K ## 0.4878681 0.4901580 0.4895023 0.4686937</code></pre>
<p>
Nem sempre é possível utilizar a correlação de pearson, porém, existem
diversas outras maneiras de se saber qual a correlação dos dados.
Podemos utilizar correlações como de Spearman, Policórica, etc.. Já fiz
um post onde explico os
<a href="https://gomesfellipe.github.io/post/tipos-de-relacoes-entre-variaveis/">diferentes
tipos de relações entre os tipos de variáveis</a> e os
<a href="https://gomesfellipe.github.io/post/tipos-de-correlacoes/">tipos
de correlações</a> possíveis para avaliar a relação dessas variáveis.
</p>
<p>
Aqui um outro exemplo de como utilizar a correlação parcial
</p>
<pre class="r"><code>partial.cor &lt;- function (x) { R &lt;- cor(x) RI &lt;- solve(R) D &lt;- 1/sqrt(diag(RI)) Rp &lt;- -RI * (D %o% D) diag(Rp) &lt;- 0 rownames(Rp) &lt;- colnames(Rp) &lt;- colnames(x) Rp } mat_anti_imagem &lt;- -partial.cor(dados[,1:10]) mat_anti_imagem</code></pre>
<pre><code>## A B C D E ## A 0.000000000 -0.25871349 -0.872167400 0.01668860 -0.04245837 ## B -0.258713494 0.00000000 -0.204228090 0.05621580 0.09801359 ## C -0.872167400 -0.20422809 0.000000000 -0.02459342 -0.00482831 ## D 0.016688604 0.05621580 -0.024593418 0.00000000 -0.18602037 ## E -0.042458373 0.09801359 -0.004828310 -0.18602037 0.00000000 ## F -0.011036934 0.06018969 -0.008201211 0.80625893 -0.14078426 ## G 0.006994874 -0.12746560 0.045529480 -0.75073120 -0.32160010 ## H -0.071792191 0.03375700 0.059785980 -0.03196914 0.08903510 ## I 0.055698412 -0.03720345 -0.040061304 0.08243832 -0.03925037 ## J -0.042609593 0.06775755 0.004145341 -0.06024239 0.05806892 ## F G H I J ## A -0.011036934 0.006994874 -0.071792191 0.05569841 -0.042609593 ## B 0.060189694 -0.127465596 0.033756995 -0.03720345 0.067757550 ## C -0.008201211 0.045529480 0.059785980 -0.04006130 0.004145341 ## D 0.806258927 -0.750731196 -0.031969142 0.08243832 -0.060242391 ## E -0.140784264 -0.321600101 0.089035097 -0.03925037 0.058068923 ## F 0.000000000 -0.792991683 0.001496987 0.08467393 -0.001404078 ## G -0.792991683 0.000000000 -0.025016441 -0.05943429 0.009961615 ## H 0.001496987 -0.025016441 0.000000000 -0.55229599 0.044929237 ## I 0.084673934 -0.059434295 -0.552295987 0.00000000 0.056248550 ## J -0.001404078 0.009961615 0.044929237 0.05624855 0.000000000</code></pre>

<ul>
<li>
<p>
Fatores são obtidos através da decomposição espectral da matriz de
correlações, resultado em cargas fatoriais que indicam o quanto cada
variável está associada a cada fator e os autovalores associados a cada
um dos fatores envolvidos
</p>
</li>
<li>
<p>
São formadas combinações lineares das variáveis observadas.
</p>
</li>
<li>
<p>
O primeiro componente principal consiste na combinação que responde pela
maior quantidade de variância na amostra.
</p>
</li>
<li>
<p>
O segundo componente responde pela segunda maior variância na amostra e
não é correlacionado com o primeiro componente.
</p>
</li>
<li>
<p>
Sucessivos componentes explicam progressivamente menores porções de
variância total da amostra e todos são não correlacionados uns aos
outros.
</p>
</li>
</ul>
<p>
No R a análise de componentes principais pode ser realizada com as
funções nativas <code>prcomp()</code> e a visualização pode ser
realizada com a função <code>biplot</code> nativa do R ou com a função
<code>autoplot()</code> do pacote <code>ggfortify</code> apresentado em
um posto que eu
<a href="https://gomesfellipe.github.io/post/2017-12-26-diagnostico-de-modelos/diagnostico-de-modelos/">comento
sobre ajustes de modelos lineares</a>.
</p>
<p>
Neste exemplo utilizaremos
<a href="https://github.com/vqv/ggbiplot/blob/master/R/ggscreeplot.r">as
funções de código aberto encontrei nesse github</a> que permite elaborar
o gráfico baseado em funções do <code>ggplot</code>, além disso também
carregaremos o pacote deste Github. Veja:
</p>
<pre class="r"><code>suppressMessages(library(ggplot2)) suppressMessages(library(ggfortify)) suppressMessages(library(ggbiplot)) #Componentes principais: acpcor=prcomp(dados, scale = TRUE) summary(acpcor)</code></pre>
<pre><code>## Importance of components: ## PC1 PC2 PC3 PC4 PC5 PC6 PC7 ## Standard deviation 1.7205 1.5835 1.2745 1.2107 1.02156 0.72100 0.6634 ## Proportion of Variance 0.2691 0.2280 0.1477 0.1333 0.09487 0.04726 0.0400 ## Cumulative Proportion 0.2691 0.4971 0.6447 0.7780 0.87285 0.92011 0.9601 ## PC8 PC9 PC10 PC11 ## Standard deviation 0.4953 0.33061 0.25079 0.14588 ## Proportion of Variance 0.0223 0.00994 0.00572 0.00193 ## Cumulative Proportion 0.9824 0.99235 0.99807 1.00000</code></pre>
<pre class="r"><code>ggbiplot(acpcor, obs.scale = 1, var.scale = 1, ellipse = TRUE, circle = TRUE) + scale_color_discrete(name = &apos;&apos;) + theme(legend.direction = &apos;horizontal&apos;, legend.position = &apos;top&apos;)</code></pre>
<p>
<img src="https://gomesfellipe.github.io/post/2018-01-01-analise-multivariada-em-r/2018-01-01-analise-multivariada-em-r_files/figure-html/unnamed-chunk-6-1.png" width="672">
</p>
<pre class="r"><code># autoplot(acpcor, label = TRUE, label.size = 1, # loadings = TRUE, loadings.label = TRUE, loadings.label.size = 3)</code></pre>
<p>
Para a observação do gráfico scree-plot podemos utilizar os comandos a
seguir (com funções nativas do R ou mesmo com funções personalizadas
como a que eu acabei de comentar
<a href="https://github.com/vqv/ggbiplot/blob/master/R/ggscreeplot.r">disponivel
nesse github</a>
</p>
<pre class="r"><code>#Com Funcao nativa do R: # plot(1:ncol(dados), acpcor$sdev^2, type = &quot;b&quot;, xlab = &quot;Componente&quot;, # ylab = &quot;Vari&#xE2;ncia&quot;, pch = 20, cex.axis = 1.3, cex.lab = 1.3) #Ou funcao personalizada com ggplot2: ggscreeplot(acpcor)</code></pre>
<p>
<img src="https://gomesfellipe.github.io/post/2018-01-01-analise-multivariada-em-r/2018-01-01-analise-multivariada-em-r_files/figure-html/unnamed-chunk-7-1.png" width="672">
</p>
<ul>
<li>
<p>
Algumas variáveis são mais correlacionadas com alguns fatores do que
outras.
</p>
</li>
<li>
<p>
Em alguns casos, a interpretação dos fatores originais pode não ser
tarefa muito fácil devido à aparição de coeficientes de grandeza
numérica similar, e não desprezível, em vários fatores diferentes.
</p>
</li>
<li>
<p>
O propósito da rotação é obter uma estrutura simples.
</p>
</li>
<li>
<p>
Em uma estrutura simples, cada fator tem carga alta somente para algumas
variáveis, tornando mais fácil a sua identificação.
</p>
</li>
<li>
<p>
Tipos: Varimax, Quartimax, Equamax
</p>
</li>
</ul>
<p>
Aplicando a Varimax:
</p>
<pre class="r"><code>k &lt;- 6 #6 fatores selecionados carfat = acpcor$rotation[, 1:k] %*% diag(acpcor$sdev[1:k]) carfatr = varimax(carfat)</code></pre>

<ul>
<li>
<p>
Índices atribuídos a variável original que expressam em % o quanto da
variabilidade de cada variável é explicada pelo modelo
</p>
</li>
<li>
<p>
Designa-se por comunalidade (<span
class="math inline">*h*<sub>*i*</sub><sup>2</sup></span>)a proporção da
variância de cada variável explicada pelos fatores comuns.
</p>
</li>
<li>
<p>
As comunalidades variam entre 0 e 1, sendo 0 quando os fatores comuns
não explicam nenhuma variância da variável e 1 quando explicam toda a
sua variância.
</p>
</li>
<li>
<p>
Quando o valor das comunalidades é menor que 0,6 deve-se pensar em:
aumentar a amostra, eliminar as variáveis.
</p>
</li>
</ul>

<ul>
<li>
<p>
Feito pelas cargas fatoriais que são os parâmetros do modelo
</p>
</li>
<li>
<p>
Fatores expressam as covariâncias entre cada fator e as variáveis
originais
</p>
</li>
<li>
<p>
Varimax ajuda a interpretar o modelo
</p>
</li>
<li>
<p>
Rotações ortogonais (para dependente) ; Rotações oblíquas (para
independentes)
</p>
</li>
</ul>

<p>
Técnica estatística multivariada que tem como objetivo organizar um
conjunto de objetos em um determinado nº de subconjuntos mutuamente
exclusivos (clusters), de tal forma que os objetos em um mesmo cluster
sejam semelhantes entre si,porém diferentes dos objetos nos outros
clusters
</p>
<p>
Etapas para análise de clusters, que são comuns em qualquer análise
(KDD):
</p>
<ul>
<li>
Seleção dos objetos a serem agrupados
</li>
<li>
Definir conjunto de atributos que caracterizam os objetos
</li>
<li>
Medida de dissimilaridade
</li>
<li>
Seleção de um algoritmo de agregação
</li>
<li>
Definição do número de clusters
</li>
<li>
Interpretação e validação dos clusters
</li>
</ul>
<p>
Critérios para a seleção:
</p>
<ul>
<li>
Selecionar variáveis diferentes entre si
</li>
<li>
Variáveis padronizadas (padronização mais comum é a Z-score)
</li>
</ul>
<p>
Existem algumas abordagens para a utilização das técnicas de análises de
clusters, as diferenças entre os métodos hierárquicos e os não
hierárquicos são as seguintes:
</p>
<p>
Métodos Hierárquicos são preferidos quando:
</p>
<ul>
<li>
Serão analisadas varias alternativas de agrupamento.
</li>
<li>
O tamanho da amostra é moderado ( de 300 a 1000 objetos )
</li>
</ul>
<p>
Métodos não-hierárquicos são preferidos quando:
</p>
<ul>
<li>
O número de grupos é conhecido.
</li>
<li>
Presença dos outliers, desde que os métodos não-hierárquicos são menos
influenciados por outliers.
</li>
<li>
Há um grande nº de objetos a serem agrupados.
</li>
</ul>
<p>
É realizado em dois passos, o primeiro deles calcula-se a matriz de
similaridade com o uso da função <em>dist()</em> (existem diversos tipos
de distâncias que podem ser utilizadas aqui), o método utilizado será o
de <strong>Ward</strong> (também poderíamos escolher o método da menor
distância, maior distância ou a distância média).
</p>
<p>
Vantagens:
</p>
<ul>
<li>
Rápidos e exigem menos tempo de processamento.
</li>
<li>
Apresentam resultados para diferentes níveis de agregação.
</li>
</ul>
<p>
Desvantagens:
</p>
<ul>
<li>
Alocação de um objeto em um cluster é irrevogável
</li>
<li>
Impacto substancial dos outliers ( apesar do Ward ser o menos
susceptível)
</li>
<li>
Não apropriados para analisar uma amostra muito extensa, pois a medida
que o tamanho da amostra aumenta, a necessidade de armazenamento das
distâncias cresce drasticamente
</li>
</ul>
<p>
Para bases grandes é melhor não usar este método pois precisa da matriz
de distâncias.
</p>
<p>
Dentre os métodos, a menor distância pode ser ruim em muitas situações,
pois coloca muitos objetos no mesmo cluster.
</p>
<p>
Geralmente utiliza-se o dendograma para a visualização dos clusters.
</p>
<pre class="r"><code>#Construindo a matriz de similaridade: matriz_similaridade = dist(iris[,-5], #Conjunto de dados utilizados &quot;euclidean&quot; #medida de dist&#xE2;ncia utilizada ) #Construindo o agrupamento hier&#xE1;rquico aglomerativo: agrupamento = hclust(matriz_similaridade, #Matriz de similaridade calculada &quot;ward.D&quot; #M&#xE9;todo de agrupamento ) #Converte hclust em dendrograma e plot: hcd &lt;- as.dendrogram(agrupamento) suppressMessages( library(ggdendro)) # Tipo pode ser &quot;rectangle&quot; ou &quot;triangle&quot; dend_data &lt;- dendro_data(hcd, type = &quot;rectangle&quot;) # o que esta contido em dend_data: names(dend_data)</code></pre>
<pre><code>## [1] &quot;segments&quot; &quot;labels&quot; &quot;leaf_labels&quot; &quot;class&quot;</code></pre>
<pre class="r"><code>plot(agrupamento,xlab=&quot;Matriz de similaridade&quot;,main = &quot;Dendograma&quot;, cex = 0.3) #Construindo representacao de grupos - gera&#xE7;&#xE3;o de vetores: grupos = cutree(agrupamento, #Vari&#xE1;vel calculada em hclust 3 #Quantidade de grupos desejados ) #Construindo o dendograma: rect.hclust(agrupamento, k=3, border=&quot;red&quot;)</code></pre>
<p>
<img src="https://gomesfellipe.github.io/post/2018-01-01-analise-multivariada-em-r/2018-01-01-analise-multivariada-em-r_files/figure-html/unnamed-chunk-10-1.png" width="672">
</p>
<p>
Existem diversas outras maneiras de se visualizar dendogramas, veja a
seguir um outro exemplo utilizando o pacote <code>ape</code>:
</p>
<pre class="r"><code>suppressMessages(library(ape)) plot(as.phylo(agrupamento), type = &quot;unrooted&quot;, cex = 0.6, no.margin = TRUE)</code></pre>
<p>
<img src="https://gomesfellipe.github.io/post/2018-01-01-analise-multivariada-em-r/2018-01-01-analise-multivariada-em-r_files/figure-html/unnamed-chunk-11-1.png" width="672">
</p>
<p>
Para mais informações de métodos de plot de dendogramas,talvez
<a href="http://www.sthda.com/english/wiki/beautiful-dendrogram-visualizations-in-r-5-must-known-methods-unsupervised-machine-learning">essa
página</a> possa ser útil.
</p>

<p>
Esta é uma das mais populares abordagens de agrupamento de dados por
partição. A partir de uma escolha inicial para os centroides, o
algoritmo procede verificando quais exemplares são mais similares a
quais centroides.
</p>
<p>
Vantagens:
</p>
<ul>
<li>
Tendem a maximizar a dispersão entre os centros de gravidade dos
clusters (mantem os clusters bem separados)
</li>
<li>
Simplicidade de cálculo, calcula somente as distâncias entre os objetos
e os centros de gravidade dos clusters
</li>
</ul>
<p>
Desvantagens:
</p>
<ul>
<li>
Depende dos conjuntos de sementes iniciais, principalmente se a seleção
das sementes é aleatória
</li>
<li>
Não há garantias de um agrupamento ótimo dos objetos
</li>
</ul>
<pre class="r"><code>#Construindo o agrupamento por particionamento: c = kmeans(iris[,-5], #Conjunto de dados utilizados 2, #N&#xFA;mero de grupos a ser descoberto iter.max=5 #N&#xFA;mero m&#xE1;ximo de itera&#xE7;&#xF5;es permitido no algor&#xED;tmo )</code></pre>
<p>
Para efeito de visualização, podemos utilizar a seguinte função que
encontra dois fatores principais a partir da análise fatorial e às
utiliza como eixos
</p>
<pre class="r"><code>plot_kmeans = function(df, clusters, runs) { suppressMessages(library(psych)) suppressMessages(library(ggplot2)) #cluster tmp_k = kmeans(df, centers = clusters, nstart = 100) #factor tmp_f = fa(df, 2, rotate = &quot;none&quot;) #collect data tmp_d = data.frame(matrix(ncol=0, nrow=nrow(df))) tmp_d$cluster = as.factor(tmp_k$cluster) tmp_d$fact_1 = as.numeric(tmp_f$scores[, 1]) tmp_d$fact_2 = as.numeric(tmp_f$scores[, 2]) tmp_d$label = rownames(df) #plot g = ggplot(tmp_d, aes(fact_1, fact_2, color = cluster)) + geom_point() + geom_text(aes(label = label), size = 3, vjust = 1, color = &quot;black&quot;) return(g) } plot_kmeans(iris[,-5], 3)</code></pre>
<pre><code>## The estimated weights for the factor scores are probably incorrect. Try a different factor extraction method.</code></pre>
<p>
<img src="https://gomesfellipe.github.io/post/2018-01-01-analise-multivariada-em-r/2018-01-01-analise-multivariada-em-r_files/figure-html/unnamed-chunk-13-1.png" width="672">
</p>
<p>
Não vou me estender nessa parte, mas é bom esclarecer que após encontrar
os clusters e de extrema importância realizar a análise exploratória
deles para entender os comportamentos dos grupos identificados.
</p>
<pre class="r"><code>#Conferindo os grupos formados: c$cluster%&gt;% table()</code></pre>
<pre><code>## . ## 1 2 ## 53 97</code></pre>
<pre class="r"><code>c$cluster%&gt;% table()%&gt;% barplot(main=&quot;Frequ&#xEA;ncias dos clusters&quot;, names.arg=c(&quot;Cluster 1&quot;, &quot;Cluster 2&quot;))</code></pre>
<p>
<img src="https://gomesfellipe.github.io/post/2018-01-01-analise-multivariada-em-r/2018-01-01-analise-multivariada-em-r_files/figure-html/unnamed-chunk-14-1.png" width="672">
</p>

<p>
O número adequado de clusters (k) deve ser maximizar o pseudo-F:
</p>
<p>
<span class="math display">
$$ pseudo-F = \\dfrac{ \\dfrac{BSS}{k-1} } { \\dfrac{WSS}{N-k}} =\\dfrac{\\textrm{Quadrado m&\#xE9;dio entre clusters}}{\\textrm{Quadrado m&\#xE9;dio dentro dos clusters}} $$
</span>
</p>

<p>
Este pacote faz os cálculos das medidas que avaliam se os clusters são
compactos, bem separados e estáveis.
</p>
<p>
Vejamos os tipos de medidas:
</p>
<p>
<strong>Medidas de validação</strong>:
</p>
<ol>
<li>
conectividade: relativa ao grau de vizinhança entre objetos em um mesmo
cluster, varia entre 0 e infinito e quanto menor melhor.
</li>
<li>
silhueta: homogeneidade interna, assume valores entre -1 e 1 e quanto
mais próximo de 1 melhor.
</li>
<li>
índice de Dunn: quantifica a separação entre os agrupamentos, assume
valores entre 0 e 1 e quanto maior melhor.
</li>
</ol>
<p>
<strong>Medidas de estabilidade</strong>:
</p>
<ol>
<li>
APN - average proportion of non-overlap: proporção média de observações
não classificadas no mesmo cluster nos casos com dados completos e
incompletos. Assume valor no intervalo \[0,1\], próximos de 0 indicam
agrupamentos consistentes.
</li>
<li>
AD - average distance: distância média entre observações classificadas
no mesmo cluster nos casos com dados completos e incompletos. Assume
valores não negativos, sendo preferíveis valores próximos de zero.
</li>
<li>
ADM - average distance between means: distância média entre os
centroides quando as observações estão em um mesmo cluster. Assume
valores não negativos, sendo preferíveis valores próximos de zero.
</li>
<li>
FOM - figure of merit: medida do erro cometido ao usar os centroides
como estimativas das observações na coluna removida. Assume valores não
negativos, sendo preferíveis valores próximos de zero.
</li>
</ol>
<pre class="r"><code>suppressMessages(library(clValid)) #Medidas de valida&#xE7;&#xE3;o: valida=clValid(iris[1:4],3,clMethods=c(&quot;hierarchical&quot;,&quot;kmeans&quot;),validation=&quot;internal&quot;) summary(valida)</code></pre>
<pre><code>## ## Clustering Methods: ## hierarchical kmeans ## ## Cluster sizes: ## 3 ## ## Validation Measures: ## 3 ## ## hierarchical Connectivity 4.4770 ## Dunn 0.1378 ## Silhouette 0.5542 ## kmeans Connectivity 10.0917 ## Dunn 0.0988 ## Silhouette 0.5528 ## ## Optimal Scores: ## ## Score Method Clusters ## Connectivity 4.4770 hierarchical 3 ## Dunn 0.1378 hierarchical 3 ## Silhouette 0.5542 hierarchical 3</code></pre>
<pre class="r"><code>#Medidas de estabilidade; valida=clValid(iris[1:4],3,clMethods=c(&quot;hierarchical&quot;,&quot;kmeans&quot;),validation=&quot;stability&quot;) summary(valida)</code></pre>
<pre><code>## ## Clustering Methods: ## hierarchical kmeans ## ## Cluster sizes: ## 3 ## ## Validation Measures: ## 3 ## ## hierarchical APN 0.0912 ## AD 1.0596 ## ADM 0.3680 ## FOM 0.4209 ## kmeans APN 0.0630 ## AD 0.9390 ## ADM 0.1131 ## FOM 0.3935 ## ## Optimal Scores: ## ## Score Method Clusters ## APN 0.0630 kmeans 3 ## AD 0.9390 kmeans 3 ## ADM 0.1131 kmeans 3 ## FOM 0.3935 kmeans 3</code></pre>

<pre class="r"><code>library(cluster) #Construindo a matriz de similaridade: matriz_similaridade = dist(iris[,-5], #Conjunto de dados utilizados &quot;euclidean&quot; #medida de dist&#xE2;ncia utilizada ) #Construindo o agrupamento hier&#xE1;rquico aglomerativo: agrupamento = hclust(matriz_similaridade, #Matriz de similaridade calculada &quot;ward.D&quot; #M&#xE9;todo de agrupamento ) silhueta =silhouette(cutree(agrupamento,k=3),dist(iris[,-5])) plot(silhueta,main=&quot;&quot;)</code></pre>
<p>
<img src="https://gomesfellipe.github.io/post/2018-01-01-analise-multivariada-em-r/2018-01-01-analise-multivariada-em-r_files/figure-html/unnamed-chunk-16-1.png" width="672">
</p>
<pre class="r"><code>summary(silhueta)</code></pre>
<pre><code>## Silhouette of 150 units in 3 clusters from silhouette.default(x = cutree(agrupamento, k = 3), dist = dist(iris[, from -5])) : ## Cluster sizes and average silhouette widths: ## 50 64 36 ## 0.7994998 0.4115006 0.4670305 ## Individual silhouette widths: ## Min. 1st Qu. Median Mean 3rd Qu. Max. ## -0.09013 0.39933 0.56701 0.55416 0.77690 0.85493</code></pre>

<p>
Como podemos observar, a análise de agrupamentos é um método
exploratório. É útil para organizar conjuntos de dados que contam com
características semelhantes.
</p>
<p>
É uma das principais técnicas da mineração de dados e já conta com
grande variedade de algoritmos.
</p>

<footer>
<ul class="stats">
<li>
Categories
</li>
<li>
<a href="https://gomesfellipe.github.io/categories/estatistica">Estatistica</a>
</li>
<li>
<a href="https://gomesfellipe.github.io/categories/r">R</a>
</li>
<li>
<a href="https://gomesfellipe.github.io/categories/teoria">Teoria</a>
</li>
<li>
<a href="https://gomesfellipe.github.io/categories/multivariada">multivariada</a>
</li>
<li>
<a href="https://gomesfellipe.github.io/categories/pca">pca</a>
</li>
<li>
<a href="https://gomesfellipe.github.io/categories/componentes-principais">componentes
principais</a>
</li>
</ul>
</footer>
</article>
<article class="post">
<a href="https://disqus.com/" class="dsq-brlink">comments powered by
</a>
</article>
</p>

