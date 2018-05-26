+++
title = "AED de forma rápida e um pouco de Machine Learning"
date = "2018-05-26"
categories = ["fellipe-gomes"]
original_url = "https://gomesfellipe.github.io/post/2018-05-26-smarteademachinelearning/smarteademachinelearning/"
+++

<p id="main">
<article class="post">
<header>
<p>
Veja como é possível realizar a AED de forma muito rápida com o pacote
SmartEAD, além de uma breve aplicação de técnicas de machine learning e
estatística para ilustrar alguns possíveis cenários da analise da dados
</p>

</header>
<a href="https://gomesfellipe.github.io/post/2018-05-26-smarteademachinelearning/smarteademachinelearning/" class="image featured">
<img src="https://gomesfellipe.github.io/img/2018/05/img1.png" alt="">
</a>
<p>
A análise exploratória dos dados (AED) foi um termo que ganhou bastante
popularidade quando Tukey publicou o livro Exploratory Data Analysis em
1977 que tratava uma “busca por conhecimento antes da análise de dados
de fato”. Ocorre quando busca-se obter informações ocultas sobre os
dados, tais como: variação, anomalias, distribuição, tendências, padrões
e relações
</p>
<p>
Ao iniciar uma análise de dados, começamos pela AED para a partir dai
decidir como buscar qual solução para o problema. É importante frisar
que a AED e a construção de gráficos <strong>não</strong> são a mesma
coisa, mesmo a AED sendo altamente baseada em produção de gráficos como
de dispersão, histogramas, boxplots etc.
</p>
<p>
Por vezes a AED no R pode envolver a produção de longos scripts
utilizando funções como as do pacote <code>ggplot2</code> e mesmo
sabendo que desejamos sempre criar o gráfico de maneira mais informativa
e atraente possível, as vezes precisamos ter uma noção geral dos dados
de forma rápida, não necessariamente tão detalhada e customizada de
cara.
</p>
<p>
A vezes queremos apenas ter uma primeira impressão dos dados e em
seguida pensar em quais os gráficos mais se adequariam para a entrega
dos resultados que mesmo as funções base do R dependendo do caso também
envolvem a confecção de longos scripts.
</p>
<p>
Existem pacotes que auxiliam na hora de se fazer uma rápida análise
exploratória, como o
<a href="https://github.com/ropenscilabs/skimr">skimr</a> e o
<a href="https://github.com/boxuancui/DataExplorer">DataExplorer</a>.
Porém estava pesquisando de existiam mais opções para uma rápida
abordagem de AED e me deparei com esta
<a href="https://cran.r-project.org/web/packages/SmartEDA/vignettes/Report_r1.html">vinheta</a>,
por Dayanand, Kiran, Ravi.
</p>
<p>
Essa vinheta apresenta o pacote
<a href="https://cran.r-project.org/web/packages/SmartEDA"><code>SmartEAD</code></a>
que trás uma série de funções que auxiliam na AED de forma bem prática.
O pacote está disponível no CRAN.
</p>
<p>
Para testar o pacote foi utilizada uma base de dados do artigo
<a href="http://people.stern.nyu.edu/wgreene/Lugano2013/Fair-ExtramaritalAffairs.pdf">A
Theory of Extramarital Affairs</a>, publicado pela
<a href="http://www.jstor.org/publisher/ucpress">The University of
Chicago Press</a>.
</p>
<p>
Gostei tanto da proposta do pacote que resolvi preparar este post que
conta com a explanação de alguns tópicos apresentados pelo autor,
algumas explicações da teoria estatística apresentada na análise
descritiva e exploratória dos dados e além da aplicação de algumas
técnicas estatísticas e de machine learning para o entendimento da base
de dados.
</p>

<p>
Como ele pode ajudá-lo a criar uma análise de dados exploratória? O
<code>SmartEDA</code> inclui várias funções personalizadas para executar
uma análise exploratória inicial em qualquer dado de entrada. A saída
gerada pode ser obtida em formato resumido e gráfico e os resultados
também podem ser exportados como relatórios.
</p>
<p>
O pacote SmartEDA ajuda a construir uma boa base de compreensão de
dados, algumas de suas funcionalidades são:
</p>
<ul>
<li>
O pacote SmartEDA fará com que você seja capaz de aplicar diferentes
tipos de EDA sem ter que lembre-se dos diferentes nomes dos pacotes R e
escrever longos scripts R com esforço manual para preparar o relatório
da EDA, permitindo o entendimento dos dados de maneira mais rápida
</li>
<li>
Não há necessidade de categorizar as variáveis em caractere, numérico,
fator etc. As funções do SmartEDA categorizam automaticamente todos os
recursos no tipo de dados correto (caractere, numérico, fator etc.) com
base nos dados de entrada.
</li>
</ul>
<p>
O pacote SmartEDA ajuda a obter a análise completa dos dados
exploratórios apenas executando a função em vez de escrever um longo
código r.
</p>
<pre class="r"><code># install.packages(&quot;SmartEDA&quot;)
suppressMessages(library(&quot;SmartEDA&quot;))</code></pre>
<p>
outros pactes que serão utilizados no post (incluindo um script com
algumas funções, que estará disponível no meu github
<a href="https://github.com/gomesfellipe/gomesfellipe.github.io/blob/master/post/2018-05-26-smarteademachinelearning/functions.R">neste
link</a>).
</p>
<pre class="r"><code>library(knitr) # Para tabelas interativas
library(DT) # Para tabelas interativas
library(dplyr) # Para manipulacao de dados
library(plotly) # Para gerar uma tabela
library(psych) # para an&#xE1;lise fatorial
source(&quot;functions.R&quot;) # script com funcoes customizadas</code></pre>
<p>
Estava à procura de uma base de dados para testar as funcionalidades do
pacote <code>SmartEAD</code> quando um colega de trabalho me mostrou um
artigo chamado
<a href="http://people.stern.nyu.edu/wgreene/Lugano2013/Fair-ExtramaritalAffairs.pdf">A
Theory of Extramarital Affairs</a>, publicado pela
<a href="http://www.jstor.org/publisher/ucpress">The University of
Chicago Press</a>. Neste artigo é desenvolvido um
<a href="https://en.wikipedia.org/wiki/Tobit_model">modelo pelo
estimador de Tobit</a> que explica a alocação de um tempo do indivíduo
entre o trabalho e dois tipos de atividades de lazer: tempo passou com o
cônjuge e tempo gasto com o amante.
</p>
<p>
Não conhecia o modelo proposto e em uma rápida pesquisa no Google notei
que alguns dos dados utilizados nesse artigo estão disponíveis no pacote
<a href="ftp://cran.r-project.org/pub/R/web/packages/AER">AER</a> de
Econometria Aplicada com R, que contém funções, conjuntos de dados,
exemplos, demonstrações e vinhetas para o livro
<a href="http://jrsyzx.njau.edu.cn/__local/C/94/F1/35C7CC5EDA214D4AAE7FE2BA0FD_0D3DFF32_3CDD40.pdf?e=.pdf">Applied
Econometrics with R</a> e como esses dados já foram tratados e estão
“prontos para análise”, resolvi usar essa amostra pela conveniência.
</p>
<p>
Portanto farei aqui uma análise exploratória e ao final de cada caso
(<em>sem variável reposta</em>, <em>com variável resposta numérica</em>
e <em>com variável resposta binária</em>), para ter uma breve intuição
de como se comportam os dados irei primeiro utilizar um <em>algorítimo
de machine learning não supervisionado</em> para o agrupamento das
observações (sem considerar q já conhecemos a variável resposta), depois
ajustar um\* modelo de regressão linear simples\* considerando a
variável resposta como numérica e por fim o ajuste de um <em>algorítimo
de machine learning supervisonado de classificação</em> após discretizar
a variável resposta.
</p>
<p>
A base de dados pode ser conferida a seguir:
</p>

<pre class="r"><code>suppressMessages(library(AER))
data(Affairs)
Affairs%&gt;% datatable()</code></pre>
<p>
Neste post, a análise de dados será feita considerando a variável
<code>affairs</code> (Quantas vezes envolvido em caso extraconjugal no
último ano (aparentemente em 1977)) e a base de dados conta com as
variáveis gênero, idade, anos de casado, se tem crianças, religiosidade,
educação, ocupação e como avalia o casamento.
</p>
<p>
Informações detalhadas podem ser conferidas na tabela a seguir, retirada
do artigo apresentado:
</p>
<img src="https://gomesfellipe.github.io/img/2018-05-26-smarteademachinelearning/tab.png">

<p>
Obs.: Essa tabela foi feita com o pacote
<a href="https://plot.ly/r/"><code>plotly</code></a>, o código pode ser
conferido
<a href="https://gist.github.com/gomesfellipe/4d1d17ca97ac6dadfabad6baef3c5539">aqui</a>.
</p>

<p>
Entendendo as dimensões do conjunto de dados, nomes de variáveis, resumo
geral, variáveis ausentes e tipos de dados de cada variável com a função
<code>ExpData()</code>, se o argumento Type = 1, visualização dos dados
(os nomes das colunas são “Descrições”, “Obs.”), já se Type = 2,
estrutura dos dados (os nomes das colunas são “S.no”, “VarName”,
“VarClass”, “VarType”) :
</p>
<pre class="r"><code># Visao geral dos dados - Type = 1
ExpData(data=Affairs, type=1, # O tipo 1 &#xE9; uma vis&#xE3;o geral dos dados DV=NULL) # especifique o nome da vari&#xE1;vel de destino, se houver. isso n&#xE3;o &#xE9; obrigat&#xF3;rio</code></pre>
<pre><code>## Descriptions Obs
## 1 Total Sample 601
## 2 No. of Variables 9
## 3 No. of Numeric Variables 7
## 4 No. of Factor Variables 2
## 5 No. of Text Variables 0
## 6 No. of Date Variables 0
## 7 No. of Zero variance Variables (Uniform) 0
## 8 %. of Variables having complete cases 100%
## 9 %. of Variables having &lt;50% missing cases 0%
## 10 %. of Variables having &gt;50% missing cases 0%
## 11 %. of Variables having &gt;90% missing cases 0%</code></pre>
<p>
Conferindo o nome das variáveis e os tipos de cada uma:
</p>
<pre class="r"><code># Estrutura dos dados - Type = 2
ExpData(data=Affairs, type=2, # O tipo 2 &#xE9; a estrutura dos dados DV=NULL) # especifique o nome da vari&#xE1;vel de destino, se houver. isso n&#xE3;o &#xE9; obrigat&#xF3;rio</code></pre>
<pre><code>## S.no VarName VarClass VarType
## 1 1 affairs numeric Independet variable
## 2 2 gender* factor Independet variable
## 3 3 age numeric Independet variable
## 4 4 yearsmarried numeric Independet variable
## 5 5 children* factor Independet variable
## 6 6 religiousness* integer Independet variable
## 7 7 education numeric Independet variable
## 8 8 occupation* integer Independet variable
## 9 9 rating* integer Independet variable</code></pre>
<p>
Esta função fornece visão geral e estrutura dos quadros de dados.
</p>

<p>
As funções a seguir apresentam a saída EDA para 3 casos diferentes de
análise exploratória dos dados, são elas:
</p>
<ul>
<li>
<p>
A variável de destino não está definida
</p>
</li>
<li>
<p>
A variável alvo é contínua
</p>
</li>
<li>
<p>
A variável de destino é categórica
</p>
</li>
</ul>
<p>
Para fins ilustrativos, será feita inicialmente uma análise considerando
que não existe variável resposta, em seguida será considerada a variável
<code>affairs</code> como variável resposta e por fim, será feita uma
transformação nesta variável resposta numérica de forma que ela seja
discretizada da seguinte maneira:
</p>
<p>
<span class="math display">
$$
1 \\text{ se j&\#xE1; houve caso extraconjugal} \\\\
0 \\text{ se n&\#xE3;o houve caso extraconjugal}
$$
</span>
</p>

<p>
Caso o interesse seja apenas ter uma noção geral dos dados de forma
extremamente rápida, basta rodar a linha de código abaixo:
</p>
<pre class="r"><code>ExpReport(Affairs,op_file = &quot;teste.html&quot;)</code></pre>
<p>
Antes de começar a explanar cada um dos casos, achei que seria legal
frisar que além de tudo que será apresentado, existe a opção de se obter
um relatório extenso sobre a análise exploratória dos dados em apenas
uma linha!
</p>
<p>
Para ilustrar o primeiro caso, onde a variável destino não é definida,
vamos supor que não existe uma variável alvo na nossa base de dados e
estamos interessados em simplesmente obter uma visão geral enquanto
pensamos em quais técnicas estatísticas serão utilizadas para avaliar
nosso dataset.
</p>
<p>
Resumo de de todas as variáveis numéricas:
</p>
<pre class="r"><code>ExpNumStat (Affairs, by = &quot;A&quot;, # Agrupar por A (estat&#xED;sticas resumidas por Todos), G (estat&#xED;sticas resumidas por grupo), GA (estat&#xED;sticas resumidas por grupo e Geral) gp = NULL, # vari&#xE1;vel de destino, se houver, padr&#xE3;o NULL MesofShape = 2, # Medidas de formas (assimetria e curtose). Outlier = TRUE, # Calcular o limite inferior, o limite superior e o n&#xFA;mero de outliers round = 2) # Arredondar</code></pre>
<pre><code>## Vname Group TN nNeg nZero nPos NegInf PosInf NA_Value
## 1 affairs All 601 0 451 150 0 0 0
## 2 age All 601 0 0 601 0 0 0
## 5 education All 601 0 0 601 0 0 0
## 6 occupation All 601 0 0 601 0 0 0
## 7 rating All 601 0 0 601 0 0 0
## 4 religiousness All 601 0 0 601 0 0 0
## 3 yearsmarried All 601 0 0 601 0 0 0
## Per_of_Missing min max mean median SD CV IQR Skweness Kurtosis
## 1 0 0.00 12 1.46 0 3.30 2.27 0 2.34 4.21
## 2 0 17.50 57 32.49 32 9.29 0.29 10 0.89 0.22
## 5 0 9.00 20 16.17 16 2.40 0.15 4 -0.25 -0.31
## 6 0 1.00 7 4.19 5 1.82 0.43 3 -0.74 -0.78
## 7 0 1.00 5 3.93 4 1.10 0.28 2 -0.83 -0.21
## 4 0 1.00 5 3.12 3 1.17 0.37 2 -0.09 -1.01
## 3 0 0.12 15 8.18 7 5.57 0.68 11 0.08 -1.57
## LB.25% UB.75% nOutliers
## 1 0.0 0.0 150
## 2 12.0 52.0 22
## 5 8.0 24.0 0
## 6 -1.5 10.5 0
## 7 0.0 8.0 0
## 4 -1.0 7.0 0
## 3 -12.5 31.5 0</code></pre>
<p>
Podemos ver que não existem variáveis negativas e a única variável que
apresentou “zero” foi a variável resposta. Nenhum registro como
<code>Inf</code> ou como <code>NA</code> e além das medidas descritivas
também podemos notar as medidas de <code>skweness</code> e
<code>kurtosis</code>. Alguns comentários sobre essas medidas:
</p>
<p>
Medidas de forma para dar uma avaliação detalhada dos dados. Explica a
quantidade e a direção do desvio.
</p>
<ul>
<li>
<strong>Kurotsis</strong> explica o quão alto e afiado é o pico central
(Achatamento).
</li>
<li>
<strong>Skewness</strong> não tem unidades: mas um número, como um
escore z (medida da assimetria)
</li>
</ul>
<p>
Onde:
</p>
<p>
<a href="https://pt.wikipedia.org/wiki/Curtose"><strong>Kurtose</strong></a>:
</p>
<p>
A curtose é uma medida de forma que caracteriza o achatamento da curva
da função de distribuição de probabilidade, Assim:
</p>
<ul>
<li>
Se o valor da curtose for = 0 (ou 3, pela segunda definição), então tem
o mesmo achatamento que a distribuição normal. Chama-se a estas funções
de mesocúrticas
</li>
<li>
Se o valor é &gt; 0 (ou &gt; 3), então a distribuição em questão é mais
alta (afunilada) e concentrada que a distribuição normal. Diz-se que
esta função probabilidade é leptocúrtica, ou que a distribuição tem
caudas pesadas (o significado é que é relativamente fácil obter valores
que não se aproximam da média a vários múltiplos do desvio padrão)
</li>
<li>
Se o valor é &lt; 0 (ou &lt; 3), então a função de distribuição é mais
“achatada” que a distribuição normal. Chama-se-lhe platicúrtica
</li>
</ul>
<p>
<a href="https://pt.wikipedia.org/wiki/Obliquidade"><strong>Skewness</strong></a>:
</p>
<p>
O Skewness mede a assimetria das caudas da distribuição. Distribuições
assimétricas que tem uma cauda mais “pesada” que a outra apresentam
obliquidade. Distribuições simétricas tem obliquidade zero. Assim:
</p>
<ul>
<li>
Se v&gt;0, então a distribuição tem uma cauda direita (valores acima da
média) mais pesada
</li>
<li>
Se v&lt;0, então a distribuição tem uma cauda esquerda (valores abaixo
da média) mais pesada
</li>
<li>
Se v=0, então a distribuição é aproximadamente simétrica (na terceira
potência do desvio em relação à média).
</li>
</ul>
<p>
Representação gráfica de todos os recursos numéricos com <strong>gráfico
de densidade</strong> (uni variada):
</p>
<pre class="r"><code># Nota: Vari&#xE1;vel exclu&#xED;da (se o valor &#xFA;nico da vari&#xE1;vel for menor ou igual a 10 [im = 10]) ExpNumViz(Affairs, gp=NULL, # Variaveel alvo Page=c(2,2), # padr&#xE3;o de sa&#xED;da. sample=8) # sele&#xE7;&#xE3;o aleat&#xF3;ria de plots</code></pre>
<pre><code>## $`0`</code></pre>
<p>
<img src="https://gomesfellipe.github.io/post/2018-05-26-smarteademachinelearning/2018-05-26-smarteademachinelearning_files/figure-html/unnamed-chunk-10-1.png" width="672"><img src="https://gomesfellipe.github.io/post/2018-05-26-smarteademachinelearning/2018-05-26-smarteademachinelearning_files/figure-html/unnamed-chunk-10-2.png" width="672">
</p>
<p>
Exibidos os gráficos com as densidades das variáveis numéricas. Como
podemos ver a maioria da amostra não registrou caso extraconjugal, a
maioria tem de 12 ou mais anos de casado. A média amostral da idade dos
indivíduos é de aproximadamente 32 anos apresentando leve assimetria com
cauda a direita. As demais variáveis podem ser conferidas visualmente.
</p>

<p>
Essa função selecionará automaticamente variáveis categóricas e gerará
frequência ou tabelas cruzadas com base nas entradas do usuário. A saída
inclui contagens, porcentagens, total de linhas e total de colunas.
</p>
<p>
Frequência para todas as variáveis independentes categóricas:
</p>
<pre class="r"><code>ExpCTable(Affairs, Target=NULL, # Variavel alvo margin=1, # margem de &#xED;ndice, 1 para propor&#xE7;&#xF5;es baseadas em linha e 2 para propor&#xE7;&#xF5;es baseadas em coluna clim=10,# quantidade de categorias m&#xE1;ximas a serem consideradas para frequ&#xEA;ncia / tabela personalizada, default 10. nlim=NULL, # limites exclusivos de vari&#xE1;vel num&#xE9;rica. Os valores padr&#xE3;o &quot;nlim&quot; s&#xE3;o 3, a tabela exclui as vari&#xE1;veis num&#xE9;ricas que t&#xEA;m valores &#xFA;nicos maiores que &quot;nlim&quot; round=2, # Arredondar bin=NULL, # n&#xFA;mero de cortes para vari&#xE1;vel alvo cont&#xED;nua per=T) # valores percentuais. Tabela padr&#xE3;o dar&#xE1; contagens.</code></pre>
<pre><code>## Variable Valid Frequency Percent CumPercent
## 1 gender female 315 52.41 52.41
## 2 gender male 286 47.59 100.00
## 3 gender TOTAL 601 NA NA
## 4 children no 171 28.45 28.45
## 5 children yes 430 71.55 100.00
## 6 children TOTAL 601 NA NA</code></pre>
<p>
Obs.: <code>NA</code> significa <code>Not Applicable</code>
</p>

<p>
Essa função varre automaticamente cada variável e cria um gráfico de
barras para variáveis categóricas.
</p>
<p>
Gráficos de barra para todas as variáveis categóricas
</p>
<pre class="r"><code>ExpCatViz(Affairs, gp=NULL, # Variavel target fname=NULL, # Nome do arquivo de saida, default &#xE9; pdf clim=10,# categorias m&#xE1;ximas a incluir nos gr&#xE1;ficos de barras. margin=2,# &#xED;ndice, 1 para propor&#xE7;&#xF5;es baseadas em linha e 2 para propor&#xE7;&#xF5;es baseadas em colunas Page = c(2,1), # padrao de saida sample=4) # sele&#xE7;&#xE3;o aleat&#xF3;ria de plot</code></pre>
<pre><code>## $`0`</code></pre>
<p>
<img src="https://gomesfellipe.github.io/post/2018-05-26-smarteademachinelearning/2018-05-26-smarteademachinelearning_files/figure-html/unnamed-chunk-12-1.png" width="672"><img src="https://gomesfellipe.github.io/post/2018-05-26-smarteademachinelearning/2018-05-26-smarteademachinelearning_files/figure-html/unnamed-chunk-12-2.png" width="672">
</p>

<p>
Apenas para efeitos ilustrativos, como estamos supondo que não temos a
variável resposta vou remover a coluna <code>affairs</code> do data set
e considerarei apenas as variáveis numéricas para fazer uma análise
multivariada com o algorítimo de machine learning
<a href="https://stat.ethz.ch/R-manual/R-devel/library/stats/html/kmeans.html"><code>kmeans</code></a>.
</p>
<p>
A função
<a href="https://github.com/gomesfellipe/functions/blob/master/plot_kmeans.R"><code>plot\_kmeans()</code></a>
pode ser encontrada em
<a href="https://gomesfellipe.github.io/post/2018-05-26-smarteademachinelearning/smarteademachinelearning/github.com/gomesfellipe">meu
github</a> no
<a href="https://github.com/gomesfellipe/functions">repositório aberto
de funções</a>.
</p>
<p>
Vejamos os resultados:
</p>
<pre class="r"><code>plot_kmeans(Affairs[,-c(1)]%&gt;% select_if(is.numeric) , 2)</code></pre>
<p>
<img src="https://gomesfellipe.github.io/post/2018-05-26-smarteademachinelearning/2018-05-26-smarteademachinelearning_files/figure-html/unnamed-chunk-13-1.png" width="672">
</p>
<p>
Como podemos observar, foram detectados dois grupos no conjunto de
dados. O ideal agora seria fazer uma AED desses clusters identificados e
avaliar qual o comportamento dos grupos formados mas como essa variável
foi omitida e a seguir discutiremos a avaliação da base diante de da
variável resposta, deixo essas análises aos curiosos de plantão.
</p>
<p>
Mais informações sobre análise multivariava podem ser encontrada no meu
post sobre
<a href="https://gomesfellipe.github.io/post/2018-01-01-analise-multivariada-em-r/an%C3%A1lise-multivariada-em-r/">Análise
Multivariada com r</a> e também em um
<a href="https://www.kaggle.com/gomes555/an-lise-multivariada-pca-e-kmeans">kernel
que escrevi para a plataforma kaggle</a>.
</p>
<p>
Além disso disponibilizo uma aplicação Shiny que criei a algum tempo
para PCA (Análise de componentes Principais) e tarefa de machine
learning com agrupamento
<a href="https://gomesfellipe.shinyapps.io/appPCAkmeans/">nenste
link</a>.
</p>

<p>
Agora vamos considerar que estamos diante de um desfecho onde a variável
alvo é contínua, para isso será considerada a variável
<code>affairs</code> como variável alvo.
</p>
<p>
Descrição da variável affairs:
</p>
<pre class="r"><code>summary(Affairs[,&quot;affairs&quot;])</code></pre>
<pre><code>## Min. 1st Qu. Median Mean 3rd Qu. Max. ## 0.000 0.000 0.000 1.456 0.000 12.000</code></pre>

<p>
Estatísticas de resumo quando a variável dependente é contínua Preço.
</p>
<pre class="r"><code>ExpNumStat(Affairs, by=&quot;A&quot;, # Agrupar por A (estat&#xED;sticas resumidas por Todos), G (estat&#xED;sticas resumidas por grupo), GA (estat&#xED;sticas resumidas por grupo e Geral) gp=&quot;affairs&quot;, # Variavel alvo Qnt=seq(0,1,0.1), # padr&#xE3;o NULL. Quantis especificados [c (0,25,0,75) encontrar&#xE3;o os percentis 25 e 75] MesofShape=1, # Medidas de formas (assimetria e curtose) Outlier=TRUE, # Calcular limite superior , inferior e numero de outliers round=2) # Arredondamento</code></pre>
<pre><code>## Note: Target variable is continuous
## Summary statistics excluded group by statement
## Results generated with correlation value against target variable</code></pre>
<pre><code>## Vname Note TN nNeg nZero nPos NegInf PosInf NA_Value
## 1 affairs Cor b/w affairs 601 0 451 150 0 0 0
## 2 age Cor b/w affairs 601 0 0 601 0 0 0
## 5 education Cor b/w affairs 601 0 0 601 0 0 0
## 6 occupation Cor b/w affairs 601 0 0 601 0 0 0
## 7 rating Cor b/w affairs 601 0 0 601 0 0 0
## 4 religiousness Cor b/w affairs 601 0 0 601 0 0 0
## 3 yearsmarried Cor b/w affairs 601 0 0 601 0 0 0
## Per_of_Missing min max mean median SD CV IQR 0% 10% 20% 30%
## 1 0 0.00 12 1.46 0 3.30 2.27 0 0.00 0.0 0.0 0
## 2 0 17.50 57 32.49 32 9.29 0.29 10 17.50 22.0 22.0 27
## 5 0 9.00 20 16.17 16 2.40 0.15 4 9.00 14.0 14.0 14
## 6 0 1.00 7 4.19 5 1.82 0.43 3 1.00 1.0 2.0 4
## 7 0 1.00 5 3.93 4 1.10 0.28 2 1.00 2.0 3.0 4
## 4 0 1.00 5 3.12 3 1.17 0.37 2 1.00 2.0 2.0 2
## 3 0 0.12 15 8.18 7 5.57 0.68 11 0.12 1.5 1.5 4
## 40% 50% 60% 70% 80% 90% 100% LB.25% UB.75% nOutliers cor
## 1 0 0 0 0 1 7 12 0.0 0.0 150 1.00
## 2 27 32 32 37 42 47 57 12.0 52.0 22 0.10
## 5 16 16 17 18 18 20 20 8.0 24.0 0 0.00
## 6 4 5 5 5 6 6 7 -1.5 10.5 0 0.05
## 7 4 4 4 5 5 5 5 0.0 8.0 0 -0.28
## 4 3 3 4 4 4 5 5 -1.0 7.0 0 -0.14
## 3 4 7 10 15 15 15 15 -12.5 31.5 0 0.19</code></pre>
<pre class="r"><code>#Se a vari&#xE1;vel de destino for cont&#xED;nua, as estat&#xED;sticas de resumo adicionar&#xE3;o a coluna de correla&#xE7;&#xE3;o (Correla&#xE7;&#xE3;o entre a vari&#xE1;vel de destino e todas as vari&#xE1;veis independentes)</code></pre>
<p>
Representação gráfica de todas as variáveis numéricas com gráficos de
dispersão (bivariada)
</p>
<p>
Gráfico de dispersão entre todas as variáveis numéricas e a variável de
destino affairs. Esta trama ajuda a examinar quão bem uma variável alvo
está correlacionada com variáveis dependentes.
</p>
<p>
Variável dependente é affairs (contínuo).
</p>
<pre class="r"><code>ExpNumViz(Affairs, gp=&quot;affairs&quot;, # Variavel alvo nlim=4, # a vari&#xE1;vel num&#xE9;rica com valor exclusivo &#xE9; maior que 4 Page=c(2,2), # formato de saida sample=8) # selecionado aleatoriamente 8 gr&#xE1;ficos de dispers&#xE3;o</code></pre>
<pre><code>## $`0`</code></pre>
<p>
<img src="https://gomesfellipe.github.io/post/2018-05-26-smarteademachinelearning/2018-05-26-smarteademachinelearning_files/figure-html/unnamed-chunk-16-1.png" width="672"><img src="https://gomesfellipe.github.io/post/2018-05-26-smarteademachinelearning/2018-05-26-smarteademachinelearning_files/figure-html/unnamed-chunk-16-2.png" width="672">
</p>

<p>
Resumo de variáveis categóricas de acordo com a frequência para todas as
variáveis independentes categóricas por Affairs
</p>
<pre class="r"><code>##bin=4, descretized 4 categories based on quantiles ExpCTable(Affairs, Target=&quot;affairs&quot;, margin=1, # margem de &#xED;ndice, 1 para propor&#xE7;&#xF5;es baseadas em linha e 2 para propor&#xE7;&#xF5;es baseadas em coluna clim=10,# quantidade de categorias m&#xE1;ximas a serem consideradas para frequ&#xEA;ncia / tabela personalizada, default 10. nlim=NULL, # limites exclusivos de vari&#xE1;vel num&#xE9;rica. Os valores padr&#xE3;o &quot;nlim&quot; s&#xE3;o 3, a tabela exclui as vari&#xE1;veis num&#xE9;ricas que t&#xEA;m valores &#xFA;nicos maiores que &quot;nlim&quot; round=0, # Arredondar bin=NULL, # n&#xFA;mero de cortes para vari&#xE1;vel alvo cont&#xED;nua per=T) # valores percentuais. Tabela padr&#xE3;o dar&#xE1; contagens.</code></pre>
<pre><code>## VARIABLE CATEGORY Number affairs:(-0.012,3] affairs:(3,6] affairs:(6,9]
## 1 gender female nn 273 0 22
## 2 gender male nn 248 0 20
## 3 gender TOTAL nn 521 0 42
## 4 gender female % 52 NaN 52
## 5 gender male % 48 NaN 48
## 6 gender TOTAL % 100 NaN 100
## 7 children no nn 157 0 7
## 8 children yes nn 364 0 35
## 9 children TOTAL nn 521 0 42
## 10 children no % 30 NaN 17
## 11 children yes % 70 NaN 83
## 12 children TOTAL % 100 NaN 100
## affairs:(9,12] TOTAL
## 1 20 315
## 2 18 286
## 3 38 601
## 4 53 52
## 5 47 48
## 6 100 100
## 7 7 171
## 8 31 430
## 9 38 601
## 10 18 28
## 11 82 72
## 12 100 100</code></pre>
<p>
Essa função varre automaticamente cada variável e cria um gráfico de
barras para variáveis categóricas.
</p>
<p>
Gráficos de barra para todas as variáveis categóricas
</p>
<pre class="r"><code>ExpCatViz(Affairs, gp=&quot;affairs&quot;, # Variavel target fname=NULL, # Nome do arquivo de saida, default &#xE9; pdf clim=10,# categorias m&#xE1;ximas a incluir nos gr&#xE1;ficos de barras. margin=2,# &#xED;ndice, 1 para propor&#xE7;&#xF5;es baseadas em linha e 2 para propor&#xE7;&#xF5;es baseadas em colunas Page = c(2,1), # padrao de saida sample=4) # sele&#xE7;&#xE3;o aleat&#xF3;ria de plot</code></pre>
<pre><code>## $`0`</code></pre>
<p>
<img src="https://gomesfellipe.github.io/post/2018-05-26-smarteademachinelearning/2018-05-26-smarteademachinelearning_files/figure-html/unnamed-chunk-18-1.png" width="672"><img src="https://gomesfellipe.github.io/post/2018-05-26-smarteademachinelearning/2018-05-26-smarteademachinelearning_files/figure-html/unnamed-chunk-18-2.png" width="672">
</p>

<pre class="r"><code>suppressMessages(library(ggplot2))
suppressMessages(library(dplyr))
suppressMessages(library(GGally))
data(&quot;Affairs&quot;)
#Correla&#xE7;oes cruzadas
Affairs%&gt;% select(age:rating,affairs)%&gt;%
ggpairs(lower = list(continuous = my_fn,combo=wrap(&quot;facethist&quot;, binwidth=1), continuous=wrap(my_bin, binwidth=0.25)),aes(fill=affairs))+theme_bw()</code></pre>
<p>
<img src="https://gomesfellipe.github.io/post/2018-05-26-smarteademachinelearning/2018-05-26-smarteademachinelearning_files/figure-html/unnamed-chunk-19-1.png" width="672">
</p>
<pre class="r"><code>ggcorr(Affairs,label = T,nbreaks = 5,label_round = 4)</code></pre>
<p>
<img src="https://gomesfellipe.github.io/post/2018-05-26-smarteademachinelearning/2018-05-26-smarteademachinelearning_files/figure-html/unnamed-chunk-20-1.png" width="672">
</p>

<p>
Por fim, vamos ajustar um modelo de regressão linear para entender quais
são as variáveis significativas para explicar a variação da variável
resposta e qual o efeito de cada uma dessas variáveis explicativas no
nosso desfecho.
</p>
<p>
Com o R base é possível ajustar um modelo de regressão linear simples
utilizando a função <code>lm()</code> e em seguida usar a função
<code>step()</code> para utilizar técnicas como
<a href="https://en.wikipedia.org/wiki/Stepwise_regression">stepwise</a>,
porém como quero utilizar também a técnica de
<a href="https://pt.wikipedia.org/wiki/Valida%C3%A7%C3%A3o_cruzada">validação
cruzada</a>. Para isso vou utilizar o pacote
<a href="https://cran.r-project.org/web/packages/caret/caret.pdf"><code>caret</code></a>,
muito famoso por facilitar o ajuste de modelos de machine learning (ou
mesmo modelos estatísticos tradicionais).
</p>
<p>
Além disso estou usando as transformações
<a href="https://www.rdocumentation.org/packages/caret/versions/6.0-79/topics/preProcess"><code>center()</code></a>,
que subtrai a média dos dados e
<a href="https://www.rdocumentation.org/packages/caret/versions/6.0-79/topics/preProcess"><code>scale()</code></a>
divide pelo desvio padrão.
</p>
<pre class="r"><code>data(&quot;Affairs&quot;)
suppressMessages(library(caret))
set.seed(123)
index &lt;- sample(1:2,nrow(Affairs),replace=T,prob=c(0.8,0.2))
train = Affairs[index==1,] %&gt;%as.data.frame()
test = Affairs[index==2,] %&gt;%as.data.frame() # Setando os par&#xE2;metros para o controle do ajuste do modelo:
fitControl &lt;- trainControl(method = &quot;repeatedcv&quot;, # 10fold cross validation number = 10, repeats=5 # do 5 repititi&#xE7;&#xF5;es of cv ) # Regress&#xE3;o Linear com Stepwise
set.seed(825)
lmFit &lt;- train(affairs ~ ., data = train, method = &quot;lmStepAIC&quot;, trControl = fitControl, preProc = c(&quot;center&quot;, &quot;scale&quot;),trace=F)
summary(lmFit)</code></pre>
<pre><code>## ## Call:
## lm(formula = .outcome ~ age + yearsmarried + religiousness + ## occupation + rating, data = dat)
## ## Residuals:
## Min 1Q Median 3Q Max ## -5.1452 -1.7819 -0.7601 0.2719 11.3518 ## ## Coefficients:
## Estimate Std. Error t value Pr(&gt;|t|) ## (Intercept) 1.4146 0.1401 10.096 &lt; 0.0000000000000002 ***
## age -0.6890 0.2291 -3.007 0.002779 ** ## yearsmarried 1.1058 0.2302 4.804 0.000002087 ***
## religiousness -0.5121 0.1455 -3.519 0.000475 ***
## occupation 0.3858 0.1445 2.669 0.007858 ** ## rating -0.7830 0.1470 -5.326 0.000000155 ***
## ---
## Signif. codes: 0 &apos;***&apos; 0.001 &apos;**&apos; 0.01 &apos;*&apos; 0.05 &apos;.&apos; 0.1 &apos; &apos; 1
## ## Residual standard error: 3.07 on 474 degrees of freedom
## Multiple R-squared: 0.144, Adjusted R-squared: 0.135 ## F-statistic: 15.95 on 5 and 474 DF, p-value: 0.00000000000001542</code></pre>
<p>
Como podemos ver as variáveis Idade, Anos de casado, religiosidade,
ocupação e como avaliam o próprio relacionamento se apresentaram
significantes
</p>
<p>
Como o <span class="math inline">*R*<sup>2</sup> = 0, 144</span>,
conclui-se que <span class="math inline">14, 4</span> da variação da
quantidade de vezes que foi envolvida em caso extraconjugal no último
ano é explicada pelo modelo ajustado.
</p>
<p>
Observando a coluna das estimativas, podemos notar o quanto varia a
quantidade de vezes que foi envolvido em caso extraconjugal ao aumentar
em 1 unidade cada uma das variáveis explicativas.
</p>
<p>
Além disso o valor p obtido através da estatística F foi menor do que
<span class="math inline">*α* = 0.05</span>, o que implica que pelo
menos uma das variáveis explicativas tem relação significativa com a
variável resposta.
</p>
<p>
Selecionando apenas as variáveis selecionadas com o ajuste do modelo:
</p>
<pre class="r"><code>train=as.data.frame(train[,c(1,3,4,6,8,9)])
test=as.data.frame(test[,c(1,3,4,6,8,9)])</code></pre>
<p>
Existem varias formas e técnicas de se avaliar o ajuste de um modelo e
como o foco deste post é apresentar as utilidades do pacote
<code>SmartEAD</code> irei fazer uma avaliação muito breve sobre os
resíduos, apresento mais algumas maneiras no post sobre
<a href="https://gomesfellipe.github.io/post/2017-12-24-diagnostico-de-modelo/diagnostico-de-modelos/">pacotes
do R para avaliar o ajuste de modelos</a>.
</p>
<pre class="r"><code>library(GGally)
# calculate all residuals prior to display
residuals &lt;- lapply(train[2:ncol(train)], function(x) { summary(lm(affairs ~ x, data = train))$residuals
}) # add a &apos;fake&apos; column
train$Residual &lt;- seq_len(nrow(train)) # calculate a consistent y range for all residuals
y_range &lt;- range(unlist(residuals)) # plot the data
ggduo( train, 2:6, c(1,7), types = list(continuous = lm_or_resid)
)+ theme_bw()</code></pre>
<p>
<img src="https://gomesfellipe.github.io/post/2018-05-26-smarteademachinelearning/2018-05-26-smarteademachinelearning_files/figure-html/unnamed-chunk-23-1.png" width="672">
</p>
<pre class="r"><code>train=train%&gt;% select(-Residual)</code></pre>
<p>
Neste gráfico é possível observar como se comportam os ajustes de
modelos lineares de cada variável explicativa em relação à variável
resposta e além disso na segunda linha é possível notar o comportamento
dos resíduos no modelo.
</p>
<p>
Uma das suposições do ajuste de um modelo linear normal é de que <span
class="math inline">*ϵ* ∼ *N*(0, *σ*<sup>2</sup>)</span> e visualmente
parece que essa condição não deve ser atendida, pois esperaríamos algo
como uma “nuvem” aleatória de pontos em torno de zero.
</p>

<p>
Além da suposição da normalidade dos resíduos, existem ainda mais
detalhes do comportamento desses erros, uma breve apresentação no
gráfico a seguir:
</p>
<pre class="r"><code>suppressMessages(library(ggfortify)) autoplot(lmFit$finalModel, which = 1:6, data = train, colour = &apos;affairs&apos;, label.size = 3, ncol = 3)+theme_classic()</code></pre>
<p>
<img src="https://gomesfellipe.github.io/post/2018-05-26-smarteademachinelearning/2018-05-26-smarteademachinelearning_files/figure-html/unnamed-chunk-24-1.png" width="672">
</p>
<p>
Pelo que parece no gráfico com título “Normal Q-Q”, as variáveis
associadas à variável resposta com valores acima de 6 se comportam de
forma inesperadas quando comparadas com os quantis teóricos.
</p>

<p>
Para finalizar a avaliação da base de dados, a Variável alvo será
discretizado de tal forma:
</p>
<p>
<span class="math display">
$$
1 = \\text{se affairs} &gt; 0\\\\
0 = c.c.
$$
</span>
</p>
<p>
Essa transformação será utilizada apenas com fins ilustrativos do
algorítimo de árvore de decisões, que está ficando muito comum na
ciência de dados como uma tarefa supervisionada de machine learning.
</p>
<pre class="r"><code>Affairs = Affairs %&gt;% mutate(daffairs = ifelse(Affairs$affairs!=0,1,0)) %&gt;% mutate(daffairs = as.factor(daffairs))%&gt;% select(-affairs)
levels(Affairs$daffairs) = c(&quot;N&#xE3;o&quot;, &quot;Sim&quot;)</code></pre>
<p>
Resumo de todas as variáveis numéricas
</p>
<pre class="r"><code>ExpNumStat(Affairs, by=&quot;A&quot;, # Agrupar por A (estat&#xED;sticas resumidas por Todos), G (estat&#xED;sticas resumidas por grupo), GA (estat&#xED;sticas resumidas por grupo e Geral) gp=&quot;daffairs&quot;, # Variavel alvo Qnt=seq(0,1,0.1), # padr&#xE3;o NULL. Quantis especificados [c (0,25,0,75) encontrar&#xE3;o os percentis 25 e 75] MesofShape=1, # Medidas de formas (assimetria e curtose) Outlier=TRUE, # Calcular limite superior , inferior e numero de outliers round=2) # Arredondamento</code></pre>
<pre><code>## Vname Group TN nNeg nZero nPos NegInf PosInf NA_Value
## 1 age All 601 0 0 601 0 0 0
## 4 education All 601 0 0 601 0 0 0
## 5 occupation All 601 0 0 601 0 0 0
## 6 rating All 601 0 0 601 0 0 0
## 3 religiousness All 601 0 0 601 0 0 0
## 2 yearsmarried All 601 0 0 601 0 0 0
## Per_of_Missing min max mean median SD CV IQR 0% 10% 20% 30%
## 1 0 17.50 57 32.49 32 9.29 0.29 10 17.50 22.0 22.0 27
## 4 0 9.00 20 16.17 16 2.40 0.15 4 9.00 14.0 14.0 14
## 5 0 1.00 7 4.19 5 1.82 0.43 3 1.00 1.0 2.0 4
## 6 0 1.00 5 3.93 4 1.10 0.28 2 1.00 2.0 3.0 4
## 3 0 1.00 5 3.12 3 1.17 0.37 2 1.00 2.0 2.0 2
## 2 0 0.12 15 8.18 7 5.57 0.68 11 0.12 1.5 1.5 4
## 40% 50% 60% 70% 80% 90% 100% LB.25% UB.75% nOutliers
## 1 27 32 32 37 42 47 57 12.0 52.0 22
## 4 16 16 17 18 18 20 20 8.0 24.0 0
## 5 4 5 5 5 6 6 7 -1.5 10.5 0
## 6 4 4 4 5 5 5 5 0.0 8.0 0
## 3 3 3 4 4 4 5 5 -1.0 7.0 0
## 2 4 7 10 15 15 15 15 -12.5 31.5 0</code></pre>
<p>
Box plots para todas as variáveis numéricas vs variável dependente
categórica - Comparação bivariada apenas com categorias
</p>
<p>
Boxplot para todos os atributos numéricos por cada categoria de affair
</p>
<pre class="r"><code>ExpNumViz(Affairs, gp=&quot;daffairs&quot;, # Variaevl alvo type=1, # 1 (boxplot por categoria e global), 2 (boxplot por categoria apenas), 3 (boxplot for overall) nlim=NULL, # limite &#xFA;nico da vari&#xE1;vel num&#xE9;rica. O padr&#xE3;o nlim &#xE9; 3, o gr&#xE1;fico excluir&#xE1; a vari&#xE1;vel num&#xE9;rica que est&#xE1; tendo um valor &#xFA;nico menor que &apos;nlim&apos; col=c(&quot;pink&quot;,&quot;yellow&quot;,&quot;orange&quot;), # Cor dos boxplots Page=c(2,2),# formato de saida sample=8) # amostra de variaveis para o resumo</code></pre>
<pre><code>## $`0`</code></pre>
<p>
<img src="https://gomesfellipe.github.io/post/2018-05-26-smarteademachinelearning/2018-05-26-smarteademachinelearning_files/figure-html/unnamed-chunk-27-1.png" width="672"><img src="https://gomesfellipe.github.io/post/2018-05-26-smarteademachinelearning/2018-05-26-smarteademachinelearning_files/figure-html/unnamed-chunk-27-2.png" width="672">
</p>

<p>
Tabulação cruzada com variável de destino com tabelas customizadas entre
todas as variáveis independentes categóricas e a variável de destino
<code>daffairs</code>:
</p>
<pre class="r"><code>ExpCTable(Affairs, Target=&quot;daffairs&quot;, # variavel alvo margin=1, # 1 para proporcoes por linha, 2 para colunas clim=10, # maximo de categorias consideradas por frequencia/ custom table round=2, # arredondar per=F) # valores percentuais. Tabela padr&#xE3;o dar&#xE1; contagens.</code></pre>
<pre><code>## VARIABLE CATEGORY daffairs:N&#xE3;o daffairs:Sim TOTAL
## 1 gender female 243 72 315
## 2 gender male 208 78 286
## 3 gender TOTAL 451 150 601
## 4 children no 144 27 171
## 5 children yes 307 123 430
## 6 children TOTAL 451 150 601</code></pre>
<p>
Gráfico de barras empilhadas com barras verticais ou horizontais para
todas as variáveis categóricas
</p>
<pre class="r"><code>ExpCatViz(Affairs, gp=&quot;daffairs&quot;, fname=NULL, # Nome do arquivo de saida, default &#xE9; pdf clim=10,# categorias m&#xE1;ximas a incluir nos gr&#xE1;ficos de barras. margin=2,# &#xED;ndice, 1 para propor&#xE7;&#xF5;es baseadas em linha e 2 para propor&#xE7;&#xF5;es baseadas em colunas Page = c(2,1), # padrao de saida sample=4) # sele&#xE7;&#xE3;o aleat&#xF3;ria de plot</code></pre>
<pre><code>## $`0`</code></pre>
<p>
<img src="https://gomesfellipe.github.io/post/2018-05-26-smarteademachinelearning/2018-05-26-smarteademachinelearning_files/figure-html/unnamed-chunk-29-1.png" width="672"><img src="https://gomesfellipe.github.io/post/2018-05-26-smarteademachinelearning/2018-05-26-smarteademachinelearning_files/figure-html/unnamed-chunk-29-2.png" width="672">
</p>

<p>
<code>IV</code> é o peso da evidência e valores da informação, <span
class="math inline">*l**n*(*o**d**s**s*)×(*p**c**t*0 − *p**c**t*1)</span>
onde <span
class="math inline">$pct1 =\\frac{\\text{&quot;boas observa&\#xE7;&\#xF5;es&quot;}}{\\text{&quot;total boas observa&\#xE7;&\#xF5;es&quot;}}$</span>;
<span
class="math inline">$pct0 = \\frac{&quot;\\text{observa&\#xE7;&\#xF5;es ruins&quot;} }{ \\text{&quot;total de observa&\#xE7;&\#xF5;es ruins&quot;}}$</span>
e $odds = $
</p>
<pre class="r"><code>ExpCatStat(Affairs %&gt;% mutate(daffairs = if_else(daffairs==&quot;N&#xE3;o&quot;, 0, 1)) , Target=&quot;daffairs&quot;, result = &quot;IV&quot;) %&gt;% select(-c(Target,Ref_1,Ref_0))</code></pre>
<pre><code>## Variable Class Out_1 Out_0 TOTAL Per_1 Per_0 Odds WOE IV
## 1 gender female 72 243 315 0.480 0.539 0.891 -0.115 0.007
## 2 gender male 78 208 286 0.520 0.461 1.128 0.120 0.007
## 3 children no 27 144 171 0.180 0.319 0.564 -0.573 0.080
## 4 children yes 123 307 430 0.820 0.681 1.204 0.186 0.026
## 5 age 17.5 3 3 6 0.020 0.007 2.857 1.050 0.014
## 6 age 22 16 101 117 0.107 0.224 0.478 -0.738 0.086
## 7 age 27 36 117 153 0.240 0.259 0.927 -0.076 0.001
## 8 age 32 38 77 115 0.253 0.171 1.480 0.392 0.032
## 9 age 37 23 65 88 0.153 0.144 1.062 0.060 0.001
## 10 age 42 18 38 56 0.120 0.084 1.429 0.357 0.013
## 11 age 47 7 16 23 0.047 0.035 1.343 0.295 0.004
## 12 age 52 6 15 21 0.040 0.033 1.212 0.192 0.001
## 13 age 57 3 19 22 0.020 0.042 0.476 -0.742 0.016
## 14 yearsmarried 0.125 1 10 11 0.007 0.022 0.318 -1.146 0.017
## 15 yearsmarried 0.417 1 9 10 0.007 0.020 0.350 -1.050 0.014
## 16 yearsmarried 0.75 3 28 31 0.020 0.062 0.323 -1.130 0.047
## 17 yearsmarried 1.5 12 76 88 0.080 0.169 0.473 -0.749 0.067
## 18 yearsmarried 10 21 49 70 0.140 0.109 1.284 0.250 0.008
## 19 yearsmarried 15 62 142 204 0.413 0.315 1.311 0.271 0.027
## 20 yearsmarried 4 27 78 105 0.180 0.173 1.040 0.039 0.000
## 21 yearsmarried 7 23 59 82 0.153 0.131 1.168 0.155 0.003
## 22 religiousness 1 20 28 48 0.133 0.062 2.145 0.763 0.054
## 23 religiousness 2 41 123 164 0.273 0.273 1.000 0.000 0.000
## 24 religiousness 3 43 86 129 0.287 0.191 1.503 0.407 0.039
## 25 religiousness 4 33 157 190 0.220 0.348 0.632 -0.459 0.059
## 26 religiousness 5 13 57 70 0.087 0.126 0.690 -0.371 0.014
## 27 education 12 13 31 44 0.087 0.069 1.261 0.232 0.004
## 28 education 14 35 119 154 0.233 0.264 0.883 -0.124 0.004
## 29 education 16 20 95 115 0.133 0.211 0.630 -0.462 0.036
## 30 education 17 27 62 89 0.180 0.137 1.314 0.273 0.012
## 31 education 18 33 79 112 0.220 0.175 1.257 0.229 0.010
## 32 education 20 20 60 80 0.133 0.133 1.000 0.000 0.000
## 33 education 9 2 5 7 0.013 0.011 1.182 0.167 0.000
## 34 occupation 1 23 90 113 0.153 0.200 0.765 -0.268 0.013
## 35 occupation 2 3 10 13 0.020 0.022 0.909 -0.095 0.000
## 36 occupation 3 15 32 47 0.100 0.071 1.408 0.342 0.010
## 37 occupation 4 21 47 68 0.140 0.104 1.346 0.297 0.011
## 38 occupation 5 44 160 204 0.293 0.355 0.825 -0.192 0.012
## 39 occupation 6 39 104 143 0.260 0.231 1.126 0.119 0.003
## 40 occupation 7 5 8 13 0.033 0.018 1.833 0.606 0.009
## 41 rating 1 8 8 16 0.053 0.018 2.944 1.080 0.038
## 42 rating 2 33 33 66 0.220 0.073 3.014 1.103 0.162
## 43 rating 3 27 66 93 0.180 0.146 1.233 0.209 0.007
## 44 rating 4 48 146 194 0.320 0.324 0.988 -0.012 0.000
## 45 rating 5 34 198 232 0.227 0.439 0.517 -0.660 0.140</code></pre>

<p>
Além de toda a informação visual e das estatísticas descritivas, ainda
contamos com alguma função que fornece estatísticas resumidas para todas
as colunas de caracteres ou categóricas no data frame
</p>
<pre class="r"><code>ExpCatStat(Affairs %&gt;% mutate(daffairs = if_else(daffairs==&quot;N&#xE3;o&quot;, 0, 1)), Target=&quot;daffairs&quot;, # variavel alvo result = &quot;Stat&quot;) # resumo de estatisticas</code></pre>
<pre><code>## Variable Target Unique Chi-squared p-value df IV Value
## 1 gender daffairs 2 1.334 0.248 1 0.014
## 2 children daffairs 2 10.055 0.002 1 0.106
## 3 age daffairs 9 17.771 0.023 8 0.168
## 4 yearsmarried daffairs 8 17.177 0.016 7 0.183
## 5 religiousness daffairs 5 19.354 0.001 4 0.166
## 6 education daffairs 7 7.057 0.316 6 0.066
## 7 occupation daffairs 7 6.718 0.348 6 0.058
## 8 rating daffairs 5 41.433 0 4 0.347
## Pred Power
## 1 Not Predictive
## 2 Medium Predictive
## 3 Medium Predictive
## 4 Medium Predictive
## 5 Medium Predictive
## 6 Somewhat Predictive
## 7 Somewhat Predictive
## 8 Highly Predictive</code></pre>
<p>
Os critérios usados para classificação de poder preditivo variável
categórico são
</p>
<ul>
<li>
<p>
Se o valor da informação for &lt;0,03, então, poder de previsão = “Não
Preditivo”
</p>
</li>
<li>
<p>
Se o valor da informação é de 0,3 a 0,1, então o poder preditivo = “um
pouco preditivo”
</p>
</li>
<li>
<p>
Se o valor da informação for de 0,1 a 0,3, então, poder preditivo =
“Medium Predictive”
</p>
</li>
<li>
<p>
Se o valor da informação for&gt; 0.3, então, poder preditivo =
“Altamente Preditivo”
</p>
</li>
</ul>
<p>
Nota para a variável <code>rating</code> que segundo essas regras,
demonstrou alto poder preditivo.
</p>

<p>
O algorítimo supervisionado de machine learning conhecido como
<a href="https://www.stat.berkeley.edu/~breiman/RandomForests/">Random
Forest</a> é uma grande caixa preta. Apresenta resultados muito robustos
pois combina o resultado de várias árvores de decisões e pode ser
facilmente aplicada com o pacote <code>caret</code>.
</p>
<p>
<a href="https://topepo.github.io/caret/variable-importance.html">No
livro do pacote caret</a> o algorítimo é apresentado da seguinte
maneira: “segundo o pacote do R: Para cada árvore, a precisão da
previsão na parte fora do saco dos dados é registrada. Então, o mesmo é
feito após a permutação de cada variável preditora. A diferença entre as
duas precisões é calculada pela média de todas as árvores e normalizada
pelo erro padrão. Para a regressão, o MSE é calculado nos dados fora da
bolsa para cada árvore e, em seguida, o mesmo é computado após a
permutação de uma variável. As diferenças são calculadas e normalizadas
pelo erro padrão. Se o erro padrão é igual a 0 para uma variável, a
divisão não é feita.”
</p>
<p>
Não entrarei em muitos detalhes sobre o algorítimo pois esta parte é
apenas um demonstrativo dos diferentes cenários de análise exploratória
dos dados. Seram comentadas apenas algumas métricas utilizadas.
</p>
<p>
Ajuste com o algorítimo Random Forest:
</p>
<pre class="r"><code>suppressMessages(library(caret))
set.seed(1)
index &lt;- sample(1:2,nrow(Affairs),replace=T,prob=c(0.8,0.2))
train = Affairs[index==1,] %&gt;%as.data.frame()
test = Affairs[index==2,] %&gt;%as.data.frame() # Setando os par&#xE2;metros para o controle do ajuste do modelo:
fitControl &lt;- trainControl(method = &quot;repeatedcv&quot;, # 10fold cross validation number = 10 ) # Random Forest
set.seed(825)
antes = Sys.time()
rfFit &lt;- train(daffairs ~ ., data = train, method = &quot;rf&quot;, trControl = fitControl, trace=F, preProc = c(&quot;center&quot;, &quot;scale&quot;)) antes - Sys.time() # Para saber quanto tempo durou o ajuste</code></pre>
<pre><code>## Time difference of -9.350121 secs</code></pre>
<p>
Resultados do ajuste:
</p>
<pre class="r"><code>rfFit</code></pre>
<pre><code>## Random Forest ## ## 484 samples
## 8 predictor
## 2 classes: &apos;N&#xE3;o&apos;, &apos;Sim&apos; ## ## Pre-processing: centered (8), scaled (8) ## Resampling: Cross-Validated (10 fold, repeated 1 times) ## Summary of sample sizes: 435, 436, 436, 436, 435, 435, ... ## Resampling results across tuning parameters:
## ## mtry Accuracy Kappa ## 2 0.7500000 0.1167424
## 5 0.7232568 0.1432592
## 8 0.7192177 0.1543523
## ## Accuracy was used to select the optimal model using the largest value.
## The final value used for the model was mtry = 2.</code></pre>
<p>
<strong>Accurary e Kappa</strong>
</p>
<p>
Essas são as métricas padrão usadas para avaliar algoritmos em conjuntos
de dados de classificação binária.
</p>
<ul>
<li>
<a href="https://en.wikipedia.org/wiki/Accuracy_and_precision"><strong>Accuray</strong></a>:
é a porcentagem de classificar corretamente as instâncias fora de todas
as instâncias. É mais útil em uma classificação binária do que problemas
de classificação de várias classes, porque pode ser menos claro
exatamente como a precisão é dividida entre essas classes (por exemplo,
você precisa ir mais fundo com uma matriz de confusão).
</li>
<li>
<a href="https://en.wikipedia.org/wiki/Cohen%27s_kappa"><strong>Kappa ou
Kappa de Cohen</strong></a> é como a precisão da classificação, exceto
que é normalizado na linha de base da chance aleatória em seu conjunto
de dados. É uma medida mais útil para usar em problemas que têm um
desequilíbrio nas classes (por exemplo, divisão de 70 a 30 para as
classes 0 e 1 e você pode atingir 70% de precisão prevendo que todas as
instâncias são para a classe 0).
</li>
</ul>
<p>
A seguir a “Variable Importance” de cada variável:
</p>
<pre class="r"><code>rfImp = varImp(rfFit);rfImp</code></pre>
<pre><code>## rf variable importance
## ## Overall
## age 100.000
## rating 98.882
## religiousness 85.536
## education 81.668
## occupation 65.776
## yearsmarried 65.106
## gendermale 5.799
## childrenyes 0.000</code></pre>
<pre class="r"><code>plot(rfImp)</code></pre>
<p>
<img src="https://gomesfellipe.github.io/post/2018-05-26-smarteademachinelearning/2018-05-26-smarteademachinelearning_files/figure-html/unnamed-chunk-35-1.png" width="672">
</p>
<p>
A função dimensiona automaticamente as pontuações de importância entre 0
e 100, os escores de importância da variável em Random Forest são
medidas agregadas. Eles apenas quantificam o impacto do preditor, não o
efeito específico, para isso utilizamos o ajuste um modelo paramétrico
onde conseguimos estimar termos estruturais.
</p>
<p>
É claro que existem muitos adentos a serem feitos tanto na forma como os
dados foram apresentados no ajuste do modelo linear e no Random Forest,
mas como a finalidade do post continua sendo apresentar o pacote
SmartEAD, encerrarei a avaliação por aqui.
</p>
<p>
Caso alguém queira entender com mais detalhes a avaliação de modelos de
machine learning, talvez
<a href="https://topepo.github.io/caret/measuring-performance.html">o
livro do pacote caret</a> seja uma alternativa interessante para ter uma
noção geral.
</p>

<p>
Não conseguimos nenhum modelo útil que quantificasse as incertezas nas
modelagens deste post mas conseguimos executar praticamente todas as
funções do pacote <code>SmartEAD</code> e foi muito útil para conhecer a
base em poucas linhas, obrigado Dayanand Ubrangala, Kiran R. e Ravi
Prasad Kondapalli!
</p>

<footer>
</footer>
</article>
<article class="post">
<a href="https://disqus.com/" class="dsq-brlink">comments powered by
</a>
</article>
</p>

