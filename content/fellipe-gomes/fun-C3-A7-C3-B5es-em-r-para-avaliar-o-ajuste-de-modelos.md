+++
title = "Pacotes do R para avaliar o ajuste de modelos"
date = "2017-12-05"
categories = ["fellipe-gomes"]
original_url = "https://gomesfellipe.github.io/post/2017-12-05-fun%C3%A7%C3%B5es-em-r-para-avaliar-o-ajuste-de-modelos/fun%C3%A7%C3%B5es-em-r-para-avaliar-o-ajuste-de-modelos/"
+++

<div id="wrapper">
<p id="main">
<article class="post">
<header>
</header>
<div id="content">
<img src="https://gomesfellipe.github.io/img/2017-12-05-fun&#xE7;&#xF5;es-em-r-para-avaliar-o-ajuste-de-modelos/imagem1.png">

<p>
Traduzindo:
</p>
<p>
“<em>Essencialmente, todos os modelos estão errados, mas alguns são
úteis</em>” - George E. P. Box
</p>
<p>
Se você estuda estatística provavelmente já deve saber quem é este
simpático senhor. Box teve grande contribuição para a estatística. Foi
aluno do Ronald Aylmer Fisher e ainda se casou com a filha dele!
</p>
<p>
Lendo um
<a href="http://jaguar.fcav.unesp.br/RME/fasciculos/v27/v27_n4/A10_Millor.pdf">artigo
sobre a vida de Fisher</a> um parágrafo me chamou atenção com uma fala
de sua filha, que dizia o seguinte:
</p>
<p>
“Joan Fisher Box, filha de Fisher, em seu livro sobre a vida do pai, se
referindo à péssima classificação dele em francês, escreveu: “… ele
nunca teve muita paciência com irrelevâncias.” (Box, 1978)”
</p>
<p>
Fico imaginando o tamanho da contribuição desdes crânios para a
comunidade se tivessem acesso a tantos mecanismos que temos hoje em dia
e o que eles achariam relevantes..
</p>
<p>
Para o bom ajuste de um modelo, certamente; a inferência, as análises de
desvios, os critérios de seleção de um modelo, conferir comportamento
dos resíduos e avaliação das estatísticas de diagnósticos são muito
relevantes.
</p>
<p>
No <a href="https://cran.r-project.org/">CRAN</a> já contamos com muitos
pacotes disponíveis para nos auxiliar nessas avaliações, portanto vou
mostrar aqui alguns pacotes com funções que já me ajudaram muito em
avaliações de modelos indo além das funções nativas do R e do pacote
<code>ggplot2</code> (Um excelente pacote para apresentações elegantes e
práticas de resultados visuais).
</p>

<div id="ggally" class="section level1">
<p>
Este pacote é sensacional, existem funções muito relevantes nele para
melhorar a nossa experiência com ajuste de modelos, as funções
apresentadas aqui são baseadas na
<a href="http://ggobi.github.io/ggally/#ggally">página de documentação
GGally</a>, lá você pode conferir a documentação completa.
</p>
<p>
Primeiramente vamos carregar o pacote:
</p>
<pre class="r"><code>suppressMessages(library(GGally))</code></pre>
<p>
Carregado o pacote, vejamos as principais funções que podem nos
auxiliar.
</p>
<p>
O objetivo da função <code>GGally::ggcoef</code> é traçar rapidamente os
coeficientes de um modelo.
</p>
<p>
Para um modelo linear:
</p>
<pre class="r"><code>reg &lt;- lm(Sepal.Length ~ Sepal.Width + Petal.Length + Petal.Width, data = iris) ggcoef(reg)</code></pre>
<pre><code>## Carregando pacotes exigidos: broom</code></pre>
<p>
<img src="https://gomesfellipe.github.io/post/2017-12-05-fun%C3%A7%C3%B5es-em-r-para-avaliar-o-ajuste-de-modelos/fun%C3%A7%C3%B5es-em-r-para-avaliar-o-ajuste-de-modelos/2017-12-05-fun&#xE7;&#xF5;es-em-r-para-avaliar-o-ajuste-de-modelos_files/figure-html/unnamed-chunk-2-1.png" width="672">
</p>
<p>
Para um modelo logístico podemos utilizar o argumento <code>exponentiate
= TRUE</code> e além disso, somos capazes de fazer diversas alterações
no gráfico utilizando o <code>ggcoef()</code> veja alguns exemplo de
argumentos que podem ser usados para personalizar como barras de erro e
a linha vertical são plotadas:
</p>
<pre class="r"><code>#Ajustando o modelo: d &lt;- as.data.frame(Titanic) log.reg &lt;- glm(Survived ~ Sex + Age + Class, family = binomial, data = d, weights = d$Freq) #Elaborando o gr&#xE1;fico ggcoef( log.reg, #O modelo a ser conferido exponentiate = TRUE, #Para avaliar o modelo log&#xED;stico vline_color = &quot;red&quot;, #Reta em zero #vline_linetype = &quot;solid&quot;, #Altera a linha de refer&#xEA;ncia errorbar_color = &quot;blue&quot;, #Cor da barra de erros errorbar_height = .25, shape = 18, #Altera o formato dos pontos centrais #size=3, #Altera o tamanho do ponto color=&quot;black&quot;, #Altera a cor do ponto mapping = aes(x = estimate, y = term, size = p.value))+ scale_size_continuous(trans = &quot;reverse&quot;) #Essa linha faz com que inverta o tamanho </code></pre>
<p>
<img src="https://gomesfellipe.github.io/post/2017-12-05-fun%C3%A7%C3%B5es-em-r-para-avaliar-o-ajuste-de-modelos/fun%C3%A7%C3%B5es-em-r-para-avaliar-o-ajuste-de-modelos/2017-12-05-fun&#xE7;&#xF5;es-em-r-para-avaliar-o-ajuste-de-modelos_files/figure-html/unnamed-chunk-3-1.png" width="672">
</p>

<p>
O objetivo desta função é exibir dois dados agrupados em uma matriz de
plotagem. Isso é útil para análise de correlação canônica, análise de
séries temporais múltiplas e análise de regressão.
</p>
<p>
Os dados do exemplo apresentados aqui podem ser encontrados neste
<a href="http://www.stats.idre.ucla.edu/r/dae/canonical-correlation-analysis">link</a>
</p>
<pre class="r"><code>data(psychademic) head(psychademic)</code></pre>
<pre><code>## locus_of_control self_concept motivation read write math science sex ## 1 -0.84 -0.24 4 54.8 64.5 44.5 52.6 female ## 2 -0.38 -0.47 3 62.7 43.7 44.7 52.6 female ## 3 0.89 0.59 3 60.6 56.7 70.5 58.0 male ## 4 0.71 0.28 3 62.7 56.7 54.7 58.0 male ## 5 -0.64 0.03 4 41.6 46.3 38.4 36.3 female ## 6 1.11 0.90 2 62.7 64.5 61.4 58.0 female</code></pre>
<pre class="r"><code>psych_variables &lt;- attr(psychademic, &quot;psychology&quot;) academic_variables &lt;- attr(psychademic, &quot;academic&quot;)</code></pre>
<pre class="r"><code>ggduo( psychademic, psych_variables, academic_variables, types = list(continuous = &quot;smooth_lm&quot;), title = &quot;Correla&#xE7;&#xE3;o entre as vari&#xE1;veis psicol&#xF3;gicas e academicas&quot;, xlab = &quot;Psicol&#xF3;gicos&quot;, ylab = &quot;Academicas&quot; )</code></pre>
<pre><code>## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`. ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.</code></pre>
<p>
<img src="https://gomesfellipe.github.io/post/2017-12-05-fun%C3%A7%C3%B5es-em-r-para-avaliar-o-ajuste-de-modelos/fun%C3%A7%C3%B5es-em-r-para-avaliar-o-ajuste-de-modelos/2017-12-05-fun&#xE7;&#xF5;es-em-r-para-avaliar-o-ajuste-de-modelos_files/figure-html/unnamed-chunk-6-1.png" width="672">
</p>
<p>
Uma vez que o <code>ggduo</code> não tem uma seção superior para exibir
os valores de correlação, podemos usar uma função personalizada para
adicionar a informação nas parcelas contínuas.
</p>
<p>
Criando uma função personalizada para informar a correlação entre as
observações:
</p>
<pre class="r"><code>lm_with_cor &lt;- function(data, mapping, ..., method = &quot;pearson&quot;) { x &lt;- eval(mapping$x, data) y &lt;- eval(mapping$y, data) cor &lt;- cor(x, y, method = method) ggally_smooth_lm(data, mapping, ...) + ggplot2::geom_label( data = data.frame( x = min(x, na.rm = TRUE), y = max(y, na.rm = TRUE), lab = round(cor, digits = 3) ), mapping = ggplot2::aes(x = x, y = y, label = lab), hjust = 0, vjust = 1, size = 5, fontface = &quot;bold&quot;, inherit.aes = FALSE # do not inherit anything from the ... ) }</code></pre>
<p>
Portanto:
</p>
<pre class="r"><code>ggduo( psychademic, rev(psych_variables), academic_variables, mapping = aes(color = sex), types = list(continuous = wrap(lm_with_cor, alpha = 0.25)), showStrips = FALSE, title = &quot;Correla&#xE7;&#xE3;o entre vari&#xE1;veis acad&#xEA;mica e psicol&#xF3;gica&quot;, xlab = &quot;Psicol&#xF3;gica&quot;, ylab = &quot;Academica&quot;, legend = c(5,2) ) + theme(legend.position = &quot;bottom&quot;)</code></pre>
<pre><code>## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`. ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`. ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.</code></pre>
<p>
<img src="https://gomesfellipe.github.io/post/2017-12-05-fun%C3%A7%C3%B5es-em-r-para-avaliar-o-ajuste-de-modelos/fun%C3%A7%C3%B5es-em-r-para-avaliar-o-ajuste-de-modelos/2017-12-05-fun&#xE7;&#xF5;es-em-r-para-avaliar-o-ajuste-de-modelos_files/figure-html/unnamed-chunk-8-1.png" width="672">
</p>
<p>
Para avaliar resíduos da uma regressão ajustada para cada uma das
variáveis explanatórias vs. as variáveis explanatórias:
</p>
<pre class="r"><code>dados &lt;- datasets::swiss # Criando uma coluna &quot;fake&quot;: dados$Residual &lt;- seq_len(nrow(dados)) # Calculando todos os res&#xED;duos que ser&#xE3;o exibidos: colunas=2:6 #Informe as colunas que contem as variaveis explanatorias residuals &lt;- lapply(dados[colunas], function(x) { summary(lm(Fertility ~ x, data = dados))$residuals }) # Calculando um intervalo constante para todos os res&#xED;duos y_range &lt;- range(unlist(residuals)) # Fun&#xE7;&#xE3;o modificada para mostrar os res&#xED;duos: lm_or_resid &lt;- function(data, mapping, ..., line_color = &quot;red&quot;, line_size = 1) { if (as.character(mapping$y) != &quot;Residual&quot;) { return(ggally_smooth_lm(data, mapping, ...)) } # Criando os res&#xED;duos para apresentar: resid_data &lt;- data.frame( x = data[[as.character(mapping$x)]], y = residuals[[as.character(mapping$x)]] ) ggplot(data = data, mapping = mapping) + geom_hline(yintercept = 0, color = line_color, size = line_size) + ylim(y_range) + geom_point(data = resid_data, mapping = aes(x = x, y = y), ...) } # Plote os dados: ggduo( dados, 2:6, c(1,7), types = list(continuous = lm_or_resid) )</code></pre>
<p>
<img src="https://gomesfellipe.github.io/post/2017-12-05-fun%C3%A7%C3%B5es-em-r-para-avaliar-o-ajuste-de-modelos/fun%C3%A7%C3%B5es-em-r-para-avaliar-o-ajuste-de-modelos/2017-12-05-fun&#xE7;&#xF5;es-em-r-para-avaliar-o-ajuste-de-modelos_files/figure-html/unnamed-chunk-9-1.png" width="672">
</p>

<div id="ggallyggnostic" class="section level2">
<p>
O <code>ggnostic</code> é um wrapper de exibição para <code>ggduo</code>
que exibe diagnósticos de modelo completo para cada variável explicativa
dada.
</p>
<p>
Por padrão, o ggduo exibe os valores residuais, o sigma do modelo de
“leave-one-out”, os pontos de alavanca e a distância de Cook em relação
a cada variável explicativa.
</p>
<p>
As linhas da matriz de plotagem podem ser expandidas para incluir
valores ajustados, erro padrão dos valores ajustados, resíduos
padronizados e qualquer uma das variáveis de resposta.
</p>
<p>
Se o modelo for um modelo linear, os asteriscos (\*) são adicionados de
acordo com a significância anova de cada variável explicativa.
</p>
<p>
A maioria das parcelas diagnósticas contêm linhas de referência para
ajudar a determinar se o modelo está adequadamente instalado
</p>
<p>
Olhando para os conjuntos de dados do conjunto de dados
<code>state.x77</code> ajustaremos um modelo de regressão múltipla para
a expectativa de vida.
</p>
<pre class="r"><code>#Dados que ser&#xE3;o utilizados no exemplos: state &lt;- as.data.frame(state.x77) #Arrumando o nome das variaveis: colnames(state)[c(4, 6)] &lt;- c(&quot;Life.Exp&quot;, &quot;HS.Grad&quot;) # Ajustando o modelo completo: model &lt;- lm(Life.Exp ~ ., data = state) # Executando o stepwise para encontrar o melhor ajuste model &lt;- step(model, trace = FALSE)</code></pre>
<p>
Executando o diagnóstico deste modelo com a função
<code>ggnostic()</code>:
</p>
<pre class="r"><code># look at model diagnostics ggnostic(model)</code></pre>
<pre><code>## `geom_smooth()` using method = &apos;loess&apos; ## `geom_smooth()` using method = &apos;loess&apos; ## `geom_smooth()` using method = &apos;loess&apos; ## `geom_smooth()` using method = &apos;loess&apos;</code></pre>
<p>
<img src="https://gomesfellipe.github.io/post/2017-12-05-fun%C3%A7%C3%B5es-em-r-para-avaliar-o-ajuste-de-modelos/fun%C3%A7%C3%B5es-em-r-para-avaliar-o-ajuste-de-modelos/2017-12-05-fun&#xE7;&#xF5;es-em-r-para-avaliar-o-ajuste-de-modelos_files/figure-html/unnamed-chunk-11-1.png" width="672">
</p>
<p>
Para acessar as variáveis influentes do modelo podemos utilizar a função
<code>influence.measures()</code>, veja:
</p>
<pre class="r"><code>summary(influence.measures(model))</code></pre>
<pre><code>## Potentially influential observations of ## lm(formula = Life.Exp ~ Population + Murder + HS.Grad + Frost, data = state) : ## ## dfb.1_ dfb.Pplt dfb.Mrdr dfb.HS.G dfb.Frst dffit cov.r ## Alaska 0.41 0.18 -0.40 -0.35 -0.16 -0.50 1.36_* ## California 0.04 -0.09 0.00 -0.04 0.03 -0.12 1.81_* ## Hawaii -0.03 -0.57 -0.28 0.66 -1.24_* 1.43_* 0.74 ## Nevada 0.40 0.14 -0.42 -0.29 -0.28 -0.52 1.46_* ## New York 0.01 -0.06 0.00 0.00 -0.01 -0.07 1.44_* ## cook.d hat ## Alaska 0.05 0.25 ## California 0.00 0.38_* ## Hawaii 0.36 0.24 ## Nevada 0.05 0.29 ## New York 0.00 0.23</code></pre>
<p>
Esta função retorna as seguintes estatísticas:
</p>
<table>
<colgroup>
<col width="18%">
<col width="19%">
<col width="13%">
<col width="13%">
<col width="13%">
</colgroup>
<thead>
</thead>
<tbody>
<tr class="odd">
<td>
Alteração no vetor estimado <span
class="math inline">$\\hat \\beta$</span> ao se retirar o i-ésimo ponto
da análise
</td>
<td>
Alteração provocada no valor ajustado pela retirada da observação <span
class="math inline">*i*</span>
</td>
<td>
Expressa o relação de covariancia
</td>
<td>
Medida de afastamento das estimativas ao retirar <span
class="math inline">*i*</span> e também considera o resíduo
estudentizado internamente
</td>
<td>
Elementos da diagonal da matriz H
</td>
</tr>
</tbody>
</table>
<p>
Vejamos então um exemplo de matriz de matriz de diagnóstico completo.
</p>
<p>
As seguintes linhas de código exibirão uma matriz de diagnóstico para o
mesmo modelo:
</p>
<pre class="r"><code>#Ajustando um modelo de exemplo: flea_model &lt;- step(lm(head ~ ., data = flea), trace = FALSE)</code></pre>
<p>
Todas as colunas possíveis e usando <code>ggally\_smooth()</code> para
exibir os pontos ajustados e as variáveis de resposta temos:
</p>
<pre class="r"><code># default output ggnostic(flea_model, # mapping = ggplot2::aes(color = species), #Para colorir segundo um fator columnsY = c(&quot;head&quot;, &quot;.fitted&quot;, &quot;.se.fit&quot;, &quot;.resid&quot;, &quot;.std.resid&quot;, &quot;.hat&quot;, &quot;.sigma&quot;, &quot;.cooksd&quot;), continuous = list(default = ggally_smooth, .fitted = ggally_smooth) )</code></pre>
<pre><code>## `geom_smooth()` using method = &apos;loess&apos; ## `geom_smooth()` using method = &apos;loess&apos; ## `geom_smooth()` using method = &apos;loess&apos; ## `geom_smooth()` using method = &apos;loess&apos; ## `geom_smooth()` using method = &apos;loess&apos; ## `geom_smooth()` using method = &apos;loess&apos;</code></pre>
<p>
<img src="https://gomesfellipe.github.io/post/2017-12-05-fun%C3%A7%C3%B5es-em-r-para-avaliar-o-ajuste-de-modelos/fun%C3%A7%C3%B5es-em-r-para-avaliar-o-ajuste-de-modelos/2017-12-05-fun&#xE7;&#xF5;es-em-r-para-avaliar-o-ajuste-de-modelos_files/figure-html/unnamed-chunk-14-1.png" width="672">
</p>
</div>
<p>
O <code>ggpairs</code> é uma forma especial de uma ggmatrix que produz
uma comparação pairwise de dados multivariados. Por padrão, o ggpairs
fornece duas comparações diferentes de cada par de colunas e exibe a
densidade ou a contagem da variável respectiva ao longo da diagonal. Com
diferentes configurações de parâmetros, a diagonal pode ser substituída
pelos valores do eixo e rótulos variáveis.
</p>
<pre class="r"><code>#Funcao de correlacoes my_fn &lt;- function(data, mapping, method=&quot;lm&quot;, ...){ p &lt;- ggplot(data = data, mapping = mapping) + geom_point() + geom_smooth(method=method, ...) p } data(tips, package = &quot;reshape&quot;) #Correla&#xE7;oes cruzadas ggpairs(tips, lower = list(continuous = my_fn))</code></pre>
<pre><code>## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`. ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`. ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`. ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`. ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`. ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`. ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`. ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`. ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`. ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`. ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`. ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.</code></pre>
<p>
<img src="https://gomesfellipe.github.io/post/2017-12-05-fun%C3%A7%C3%B5es-em-r-para-avaliar-o-ajuste-de-modelos/fun%C3%A7%C3%B5es-em-r-para-avaliar-o-ajuste-de-modelos/2017-12-05-fun&#xE7;&#xF5;es-em-r-para-avaliar-o-ajuste-de-modelos_files/figure-html/unnamed-chunk-15-1.png" width="672">
</p>
<p>
Existem muitos recursos ocultos dentro dos <code>ggpairs()</code> e
muitos exemplos podem ser conferidos na internet para obter o máximo do
<code>ggpairs()</code>.
</p>

<p>
A principal função é <code>ggscatmat</code>. É semelhante a
<code>ggpairs()</code>, mas funciona apenas para dados multivariados
puramente numéricos.
</p>
<p>
É mais rápido que ggpairs, porque é necessário fazer menos escolhas.
</p>
<p>
Ele cria uma matriz com diagramas de dispersão na diagonal inferior,
densidades na diagonal e correlações escritas na diagonal superior.
</p>
<p>
A sintaxe é inserir o conjunto de dados, as colunas que deseja traçar,
uma coluna de cores e um nível alfa.
</p>
<pre class="r"><code>data(flea) ggscatmat(flea, columns = 2:4, color=&quot;species&quot;, alpha=0.8)</code></pre>
<p>
<img src="https://gomesfellipe.github.io/post/2017-12-05-fun%C3%A7%C3%B5es-em-r-para-avaliar-o-ajuste-de-modelos/fun%C3%A7%C3%B5es-em-r-para-avaliar-o-ajuste-de-modelos/2017-12-05-fun&#xE7;&#xF5;es-em-r-para-avaliar-o-ajuste-de-modelos_files/figure-html/unnamed-chunk-16-1.png" width="672">
</p>

</div>
<p>
Outra opção interessante para avaliar o ajuste dos modelos é o pacote
<a href="https://cran.r-project.org/web/packages/ggfortify/index.html">ggfottify</a>.
Ele disponibiliza uma interface de traçado (como a função
<code>plot(modelo\_ajustado)</code>) de análise e gráficos em um estilo
unificado, porém usando <code>ggplot2</code>.
</p>
<p>
Vamos então dar início carregando o pacote:
</p>
<pre class="r"><code>suppressMessages(library(ggfortify))</code></pre>
<p>
Veja a seguir alguns dos gráficos disponíveis no R para a análise de
resíduos:
</p>
<pre class="r"><code>autoplot(flea_model, which = 1:6, ncol = 3, label.size = 3)</code></pre>
<p>
<img src="https://gomesfellipe.github.io/post/2017-12-05-fun%C3%A7%C3%B5es-em-r-para-avaliar-o-ajuste-de-modelos/fun%C3%A7%C3%B5es-em-r-para-avaliar-o-ajuste-de-modelos/2017-12-05-fun&#xE7;&#xF5;es-em-r-para-avaliar-o-ajuste-de-modelos_files/figure-html/unnamed-chunk-18-1.png" width="672">
</p>
<p>
Especificando as opções de plot
</p>
<p>
Algumas propriedades desses gráficos podem ser alteradas. Por exemplo, a
opção <code>colour = 'dodgerblue3'</code> é para pontos de dados, o
<code>smooth.colour = 'black'</code> é para linhas de suavização e
<code>ad.colour = 'blue'</code> é para opções adicionais.
</p>
<p>
Veja ainda que ncol e nrow controlam o layout.
</p>
<pre class="r"><code>autoplot(flea_model, which = 1:6, colour = &apos;dodgerblue3&apos;, smooth.colour = &apos;black&apos;, smooth.linetype = &apos;dashed&apos;, ad.colour = &apos;blue&apos;, label.size = 3, label.n = 5, label.colour = &apos;blue&apos;, ncol = 3)</code></pre>
<p>
<img src="https://gomesfellipe.github.io/post/2017-12-05-fun%C3%A7%C3%B5es-em-r-para-avaliar-o-ajuste-de-modelos/fun%C3%A7%C3%B5es-em-r-para-avaliar-o-ajuste-de-modelos/2017-12-05-fun&#xE7;&#xF5;es-em-r-para-avaliar-o-ajuste-de-modelos_files/figure-html/unnamed-chunk-19-1.png" width="672">
</p>
<p>
Além disso, você pode usar nomes de colunas para essas propriedades,
vamos separar os grupos de machos e fêmeas por cores:
</p>
<pre class="r"><code>autoplot(flea_model, which = 1:6, data = flea, colour = &apos;species&apos;, label.size = 3, ncol = 3)</code></pre>
<p>
<img src="https://gomesfellipe.github.io/post/2017-12-05-fun%C3%A7%C3%B5es-em-r-para-avaliar-o-ajuste-de-modelos/fun%C3%A7%C3%B5es-em-r-para-avaliar-o-ajuste-de-modelos/2017-12-05-fun&#xE7;&#xF5;es-em-r-para-avaliar-o-ajuste-de-modelos_files/figure-html/unnamed-chunk-20-1.png" width="672">
</p>
<p>
O que será que os crânios da estatística fariam diante de tantos
recursos?
</p>

</div>
<footer>
</footer>
</article>
<article class="post">
<a href="https://disqus.com/" class="dsq-brlink">comments powered by
</a>
</article>
</p>
</div>

