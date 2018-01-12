+++
title = "Tipos de relações entre variáveis"
date = "2017-12-02"
categories = ["fellipe-gomes"]
original_url = "https://gomesfellipe.github.io/post/tipos-de-relacoes-entre-variaveis/"
+++

<p id="main">
<article class="post">
<header>
</header>
<p>
Vimos no
<a href="https://gomesfellipe.github.io/post/tipos-de-correlacoes/">último
post</a> sobre quais tipos de medidas de correlação e associação podem
ser calculadas para identificar o grau de associação (ou dependência)
entre as variáveis.
</p>
<p>
Já sabemos que esses coeficientes variam entre 0 e 1 ou entre -1 e +1,
de maneira que a proximidade de zero indique a falta de associação entre
elas.
</p>
<p>
Porém o que fazer com tantas métricas? Qual o cálculo mais aconselhado
para as relações dois a dois de cada tipo de variáveis (medidas,
quantidades, nomes, classes com algum tipo de ordem ou hierarquia)?
</p>
<p>
Não basta chegar no R e fazer um <code>pairs(dados)</code> junto com
<code>cor(dados)</code> e olhar aquele monte de números sem saber se
eles apresentam algum resultado realmente relevante embasado na teoria
estatística.
</p>
<p>
Vejamos então os tipos de relações possíveis e quais tipos de medidas
podem ser utilizadas a seguir.
</p>

<p>
Tipos de medidas que podem ser utilizadas:
</p>
<ul>
<li>
Pearson (Intensidade de relacionamento linear)
</li>
<li>
Spearman (Relação monotônica entre dados emparelhados)
</li>
<li>
Kendall (Correlação entre duas variáveis ordinais de amostras pequenas)
</li>
</ul>
<p>
A suposição de normalidade é amplamente utilizada na estatística.
</p>
<p>
Compara os quantis dos dados com os quantis de uma normal padrão
</p>
<pre class="r"><code>par(mfrow=c(2,2)) ### Verificando a Normalidade Atrav&#xE9;s do QQplot qq = function(x){ qqnorm(x,main = &quot;&quot;, xlab = &quot;Quantis te&#xF3;ricos N(0,1)&quot;, pch = 20) qqline(x, lty = 1, col = &quot;red&quot;) } qq(dados$IDADE) qq(dados$GASAUDE) qq(dados$GASLAZER) qq(dados$GASTEDU)</code></pre>
<p>
<img src="https://gomesfellipe.github.io/post/2017-12-02-tipos-de-relacoes-entre-variaveis_files/figure-html/unnamed-chunk-4-1.png" width="672">
</p>

<p>
Incluindo uma região de aceitação, para cada ponto constroi o intervalo
de confiança
</p>
<pre class="r"><code>#Envelope envelope&lt;-function(x){ n &lt;- length(x) nsim &lt;- 100 # N&#xFA;mero de simula&#xE7;&#xF5;es conf &lt;- 0.95 # Coef. de confian&#xE7;a # Dados simulados ~ normal dadossim &lt;- matrix(rnorm(n*nsim, mean = mean(x), sd = sd(x)), nrow = n) dadossim &lt;- apply(dadossim,2,sort) # Limites da banda e m&#xE9;dia infsup&lt;-apply(dadossim,1,quantile, probs = c((1 - conf) / 2,(1 + conf) / 2)) xbsim &lt;- rowMeans(dadossim) faixay &lt;- range(x, dadossim) qq0 &lt;- qqnorm(x, main = &quot;&quot;, xlab = &quot;Quantis te&#xF3;ricos N(0,1)&quot;, pch = 20, ylim = faixay) eixox &lt;- sort(qq0$x) lines(eixox, xbsim) lines(eixox, infsup[1,], col = &quot;red&quot;) lines(eixox, infsup[2,], col = &quot;red&quot;) } par(mfrow=c(2,2)) envelope(dados$GASTEDU) envelope(dados$GASAUDE) envelope(dados$GASLAZER) envelope(dados$IDADE)</code></pre>
<p>
<img src="https://gomesfellipe.github.io/post/2017-12-02-tipos-de-relacoes-entre-variaveis_files/figure-html/unnamed-chunk-5-1.png" width="672">
</p>

<p>
A seguir, diversos testes de hipóteses para avaliar:
</p>
<p>
<span class="math display">
$$ H\_0: \\text{Dados Normais} \\\\ H\_1: \\text{Dados N&\#xE3;o Normais} $$
</span>
</p>
<p>
A seguir uma função que criei colocando logo uma variedade de testes
para fornecer diferentes evidências para nossa hipótese:
</p>
<pre class="r"><code>normalidade&lt;-function(x){ t1 &lt;- ks.test(x, &quot;pnorm&quot;,mean(x), sd(x)) # KS t2 &lt;- lillie.test(x) # Lilliefors t3 &lt;- cvm.test(x) # Cram&#xE9;r-von Mises t4 &lt;- shapiro.test(x) # Shapiro-Wilk t5 &lt;- sf.test(x) # Shapiro-Francia t6 &lt;- ad.test(x) # Anderson-Darling t7&lt;-pearson.test(x) # Pearson Test of Normality testes &lt;- c(t1$method, t2$method, t3$method, t4$method, t5$method,t6$method,t7$method) valorp &lt;- c(t1$p.value, t2$p.value, t3$p.value, t4$p.value, t5$p.value,t6$p.value,t7$p.value) resultados &lt;- cbind(valorp) rownames(resultados) &lt;- testes print(resultados, digits = 4) } normalidade(dados$GASAUDE)</code></pre>
<pre><code>## valorp ## One-sample Kolmogorov-Smirnov test 0.9238 ## Lilliefors (Kolmogorov-Smirnov) normality test 0.6494 ## Cramer-von Mises normality test 0.6605 ## Shapiro-Wilk normality test 0.6297 ## Shapiro-Francia normality test 0.6286 ## Anderson-Darling normality test 0.6346 ## Pearson chi-square normality test 0.3249</code></pre>

<p>
Quando os dados são normais e a relação entre variáveis é linear,
podemos utilizar os mesmos testes já comentados:
</p>
<ul>
<li>
Pearson
</li>
<li>
Spearman (amostras maiores)
</li>
<li>
Kendall (amostras pequenas)
</li>
</ul>
<p>
No R:
</p>
<pre class="r"><code>#Matriz de correla&#xE7;&#xF5;es: cor(dados$GASTEDU,dados$GASAUDE)</code></pre>
<pre><code>## [1] 0.77825</code></pre>
<p>
Como saber se a correlação é significativa?
</p>
<p>
<span class="math display">
$$ H\_0: \\text{N&\#xE3;o existe correla&\#xE7;&\#xE3;o} \\\\ H\_1: \\text{Existe correla&\#xE7;&\#xE3;o} $$
</span>
</p>
<p>
Aplicando o teste:
</p>
<pre class="r"><code>#Teste de correla&#xE7;&#xE3;o: cor.test(dados$GASTEDU,dados$GASAUDE,method = &quot;pearson&quot;)</code></pre>

<p>
Quando os dados não se apresentam conforme a distribuição normal ou não
apresentam relação linear, temos disponíveis o cálculo das seguintes
correlações:
</p>
<ul>
<li>
Spearman (amostras maiores)
</li>
<li>
kendall (amostras pequenas)
</li>
</ul>
<p>
Ideal quando temos variáveis medidas apenas em uma escala ordinal.
</p>
<p>
Executando no R:
</p>
<pre class="r"><code>#Teste de correla&#xE7;&#xE3;o: cor.test(dados$GASTEDU,dados$GASAUDE,method = &quot;spearman&quot;)</code></pre>

<p>
Coeficiente de Kendall é, muitas vezes, interpretado como uma medida de
concordância entre dois conjuntos de classificações relativas a um
conjunto de objetos de estudo.
</p>
<p>
Vamos considerar apenas os 20 primeiros elementos da amostra:
</p>
<p>
Aplicação no R:
</p>
<pre class="r"><code>#Teste de correla&#xE7;&#xE3;o: cor.test(dados2$IDADE,dados2$GASAUDE,method = &quot;kendall&quot;)</code></pre>

<p>
Tipos de correlações possíveis para calcular:
</p>
<ul>
<li>
Spearman (amostras maiores)
</li>
<li>
kendall (amostras pequenas)
</li>
</ul>
<p>
Exemplo de uso de Spearman no R:
</p>
<pre class="r"><code>cor(dados$ESCOLAR, dados$RENDA, method = &quot;spearman&quot;) cor.test(dados$ESCOLAR, dados$RENDA, method = &quot;spearman&quot;)</code></pre>
<p>
Exemplo de uso de Kendall com uma amostra menor:
</p>
<pre class="r"><code>cor(dados2$ESCOLAR, dados2$RENDA, method = &quot;kendall&quot;) cor.test(dados2$ESCOLAR, dados2$RENDA, method = &quot;kendall&quot;)</code></pre>

<p>
Independente de ser normal ou não
</p>
<ul>
<li>
Spearman (amostras maiores)
</li>
<li>
Kendall (amostras pequenas)
</li>
<li>
Comparações de grupos (Testes de Hipóteses)
</li>
</ul>
<p>
Exemplo de uso de Spearman no R:
</p>
<pre class="r"><code>cor(dados$IDADE, dados$RENDA, method = &quot;spearman&quot;) cor.test(dados$IDADE, dados$RENDA, method = &quot;spearman&quot;)</code></pre>
<p>
Exemplo de uso de Kendall com uma amostra menor:
</p>
<pre class="r"><code>cor(dados2$IDADE, dados2$RENDA, method = &quot;kendall&quot;) cor.test(dados2$IDADE, dados2$RENDA, method = &quot;kendall&quot;)</code></pre>

<p>
Os termos nível nominal de medida ou escala nominal são utilizadas para
se referir a àqueles dados que só podem ser categorizados. No sentido
estrito, não existe uma medida ou escala envolvida, o que existe é
apenas uma contagem.
</p>
<p>
Vamos avaliar a profissão e o estado civil primeiramente, precisamos da
tabela de contingência.
</p>
<p>
Tabelas de Contingência (ou tabelas de freqüência de dupla entrada) são
tabelas em que as frequências correspondem a duas classificações, uma
classificação está nas linhas da tabela e a outra está nas colunas.
Veja:
</p>
<pre class="r"><code>tab=ftable(as.factor(dados$PROFI), as.factor(dados$ESTCIVIL), dnn=c(&quot;Profiss&#xE3;o&quot;, &quot;EStado Civil&quot;)) tab</code></pre>
<pre><code>## EStado Civil 1 2 3 4 ## Profiss&#xE3;o ## 1 26 13 29 1 ## 2 24 6 21 0</code></pre>
<p>
<span class="math display">
$$ H\_0: \\text{S&\#xE3;o independentes (N&\#xE3;o associadas)} \\\\ H\_1: \\text{N&\#xE3;o s&\#xE3;o independentes (S&\#xE3;o associadas) } $$
</span>
</p>
<p>
Executando o teste:
</p>
<pre class="r"><code>chisq.test(dados$PROFI, dados$ESTCIVIL)</code></pre>
<pre><code>## ## Pearson&apos;s Chi-squared test ## ## data: dados$PROFI and dados$ESTCIVIL ## X-squared = 2.2905, df = 3, p-value = 0.5143</code></pre>
<p>
<strong>OBS</strong>: Correção de YAKES quando existe alguma frequência
esperada menor do que 5, veja:
</p>

<p>
O teste qui-quadrado quando aplicado a amostras pequenas, como por
exemplo com tamanho inferior a 20, veja:
</p>
<pre class="r"><code>fisher.test(dados2$PROFI, dados2$ESTCIVIL)</code></pre>
<pre><code>## ## Fisher&apos;s Exact Test for Count Data ## ## data: dados2$PROFI and dados2$ESTCIVIL ## p-value = 0.5226 ## alternative hypothesis: two.sided</code></pre>

<p>
os testes fornecem apenas a resposta se as variáveis estão ou não
correlacionadas. Para saber a intensidade desta relação, utilizam-se
medidas de associação.
</p>
<p>
Considere as seguintes medidas:
</p>
<ul>
<li>
<span class="math inline">**ϕ**</span> <strong>(phi)</strong> (é o R de
pearson quando aplicado a tabelas 2x2)
</li>
<li>
<strong>V de Crámer</strong>
</li>
<li>
<strong>Coeficiente de contingência</strong>
</li>
</ul>
<p>
Ambos variam de 0 (ausência de associação) a 1 (associação muito forte).
</p>
<pre class="r"><code>#Comando para tabela cruzada: tab &lt;- xtabs(~ PROFI + ESTCIVIL, data = dados) #Calcular as medidas de associa&#xE7;&#xE3;o da tabela: summary(assocstats(tab))</code></pre>
<pre><code>## ## Call: xtabs(formula = ~PROFI + ESTCIVIL, data = dados) ## Number of cases in table: 120 ## Number of factors: 2 ## Test for independence of all factors: ## Chisq = 2.2905, df = 3, p-value = 0.5143 ## Chi-squared approximation may be incorrect ## X^2 df P(&gt; X^2) ## Likelihood Ratio 2.6823 3 0.44324 ## Pearson 2.2905 3 0.51435 ## ## Phi-Coefficient : NA ## Contingency Coeff.: 0.137 ## Cramer&apos;s V : 0.138</code></pre>
<pre class="r"><code>#phi (r aplicado na Tabela de 2x2 --&gt; Phi) cor(dados$PROFI,dados$ESTCIVIL) </code></pre>
<pre><code>## [1] -0.06972599</code></pre>

<p>
É uma medida de concordância.
</p>
<p>
<strong>Obs</strong>: Também pode ser utilizado o coeficiente de Kappa
ponderado (pesquisar)
</p>
<pre class="r"><code>#Kappa medico1&lt;-sample(0:1,10, replace=T) medico2&lt;-sample(0:1,10, replace=T) #Kappa.test(x, y=NULL, conf.level=0.95) fmsb::Kappa.test(medico1,medico2)</code></pre>
<pre><code>## $Result ## ## Estimate Cohen&apos;s kappa statistics and test the null hypothesis ## that the extent of agreement is same as random (kappa=0) ## ## data: medico1 and medico2 ## Z = 0.63246, p-value = 0.2635 ## 95 percent confidence interval: ## -0.4072726 0.8072726 ## sample estimates: ## [1] 0.2 ## ## ## $Judgement ## [1] &quot;Slight agreement&quot;</code></pre>

<p>
Vamos avaliar a profissão e o estado civil primeiramente, precisamos da
tabela de contingência:
</p>
<pre class="r"><code>tab=ftable(as.factor(dados$PROFI), as.factor(dados$RENDA), dnn=c(&quot;Profiss&#xE3;o&quot;, &quot;Renda&quot;)) tab</code></pre>
<pre><code>## Renda 1 2 3 4 ## Profiss&#xE3;o ## 1 4 52 9 4 ## 2 0 30 17 4</code></pre>
<p>
<span class="math display">
$$ H\_0: \\text{S&\#xE3;o independentes (N&\#xE3;o associadas)} \\\\ H\_1: \\text{N&\#xE3;o s&\#xE3;o independentes (S&\#xE3;o associadas) } $$
</span>
</p>
<p>
Executando o teste:
</p>
<pre class="r"><code>chisq.test(dados$PROFI, dados$RENDA)</code></pre>
<pre><code>## ## Pearson&apos;s Chi-squared test ## ## data: dados$PROFI and dados$RENDA ## X-squared = 9.8864, df = 3, p-value = 0.01956</code></pre>
<p>
<strong>OBS</strong>: Correção de YAKES quando existe alguma frequência
esperada menor do que 5, veja:
</p>

<p>
O teste qui-quadrado quando aplicado a amostras pequenas, como por
exemplo com tamanho inferior a 20, veja:
</p>
<pre class="r"><code>fisher.test(dados2$PROFI, dados2$RENDA)</code></pre>
<pre><code>## ## Fisher&apos;s Exact Test for Count Data ## ## data: dados2$PROFI and dados2$RENDA ## p-value = 1 ## alternative hypothesis: two.sided</code></pre>

<p>
os testes fornecem apenas a resposta se as variáveis estão ou não
correlacionadas. Para saber a intensidade desta relação, utilizam-se
medidas de associação.
</p>
<p>
Considere as seguintes medidas:
</p>
<ul>
<li>
<span class="math inline">**ϕ**</span> <strong>(phi) </strong> (é o R de
pearson quando aplicado a tabelas 2x2)
</li>
<li>
<strong>V de Crámer</strong>
</li>
<li>
<strong>Coeficiente de contingência</strong>
</li>
</ul>
<p>
Ambos variam de 0 (ausência de associação) a 1 (associação muito forte).
</p>
<pre class="r"><code>#Comando para tabela cruzada: tab &lt;- xtabs(~ PROFI + RENDA, data = dados) #Calcular as medidas de associa&#xE7;&#xE3;o da tabela: summary(assocstats(tab))</code></pre>
<pre><code>## ## Call: xtabs(formula = ~PROFI + RENDA, data = dados) ## Number of cases in table: 120 ## Number of factors: 2 ## Test for independence of all factors: ## Chisq = 9.886, df = 3, p-value = 0.01956 ## Chi-squared approximation may be incorrect ## X^2 df P(&gt; X^2) ## Likelihood Ratio 11.3123 3 0.010152 ## Pearson 9.8864 3 0.019557 ## ## Phi-Coefficient : NA ## Contingency Coeff.: 0.276 ## Cramer&apos;s V : 0.287</code></pre>
<pre class="r"><code>#phi (r aplicado na Tabela de 2x2 --&gt; Phi) cor(dados$PROFI,dados$RENDA) </code></pre>
<pre><code>## [1] 0.231198</code></pre>

<p>
Testa a concordância entre duas pessoas (a hipótese nula é de que a
concordância é zero)
</p>
<pre class="r"><code>#Kappa medico1&lt;-sample(0:1,10, replace=T) medico2&lt;-sample(0:1,10, replace=T) #Kappa.test(x, y=NULL, conf.level=0.95) fmsb::Kappa.test(medico1,medico2)</code></pre>
<pre><code>## $Result ## ## Estimate Cohen&apos;s kappa statistics and test the null hypothesis ## that the extent of agreement is same as random (kappa=0) ## ## data: medico1 and medico2 ## Z = 1.2649, p-value = 0.103 ## 95 percent confidence interval: ## -0.1680515 0.9680515 ## sample estimates: ## [1] 0.4 ## ## ## $Judgement ## [1] &quot;Fair agreement&quot;</code></pre>

<p>
Uma variável dicotômica é uma variável qualitativa que só possui duas
categorias.
</p>
<p>
Portanto a mesma abordagem utilizada em:
</p>
<p>
Dicotômica x Ordinal = Nominal x Ordinal = Nominal x Nominal
</p>

<p>
Pode-se ajustar um modelo de regressão linear simples e avaliar seu
coeficiente de determinação, veja:
</p>
<pre class="r"><code>#R2: summary(lm(dados$GASAUDE~dados$ESTCIVIL))$r.squared</code></pre>
<pre><code>## [1] 0.0001015817</code></pre>

<p>
O pearson aplicada em uma relação de variável dicotômica com uma
variável ordinal
</p>

<p>
Quando por exemplo, trabalha-se com “renda por grupo”, existem muitas
abordagens como o teste t ou anova como opções de testes paramétricos e
muito mais
</p>

<p>
Pode ser que queremos estudar a correlação entre x e y, porém existem
uma variável z que também está correlacionada com alguma das duas
variáveis, veja:
</p>
<p>
<img src="https://gomesfellipe.github.io/post/2017-12-02-tipos-de-relacoes-entre-variaveis_files/figure-html/unnamed-chunk-27-1.png" width="672">
</p>
<pre><code>## [1] 0.7821115</code></pre>
<p>
<img src="https://gomesfellipe.github.io/post/2017-12-02-tipos-de-relacoes-entre-variaveis_files/figure-html/unnamed-chunk-27-2.png" width="672">
</p>
<pre><code>## [1] 0.7476177</code></pre>
<p>
<img src="https://gomesfellipe.github.io/post/2017-12-02-tipos-de-relacoes-entre-variaveis_files/figure-html/unnamed-chunk-27-3.png" width="672">
</p>
<pre><code>## [1] 0.7821115</code></pre>
<p>
<img src="https://gomesfellipe.github.io/post/2017-12-02-tipos-de-relacoes-entre-variaveis_files/figure-html/unnamed-chunk-27-4.png" width="672">
</p>
<pre><code>## [1] 0.77825</code></pre>
<p>
Isto implica que a variável educação é uma variável de confusão, veja as
correlações:
</p>
<p>
<img src="https://gomesfellipe.github.io/post/2017-12-02-tipos-de-relacoes-entre-variaveis_files/figure-html/unnamed-chunk-28-1.png" width="672">
</p>
<p>
O que acontece com a associação entre lazer e saúde quando controlamos a
variável de confusão educação?
</p>
<pre class="r"><code># correla&#xE7;&#xE3;o LAZER vc SA&#xDA;DE controlando o EDUCA&#xC7;&#xC3;O (correla&#xE7;&#xE3;o parcial de primeira ordem = um vari&#xE1;vel para controlar) rp&lt;-ggm::pcor(c(&quot;GASLAZER&quot;, &quot;GASAUDE&quot;, &quot;GASTEDU&quot;),var(dados)) #controlando A EDUCA&#xC7;&#xC3;O #Signific&#xE2;ncia da Correla&#xE7;&#xE3;o Parcial #Coeficiente de Determina&#xE7;&#xE3;o com base no Coef. de Pearson r&lt;-cor(dados$GASLAZER,dados$GASAUDE) #sem controlar o lazer #Coeficiente de Determina&#xE7;&#xE3;o com base na correla&#xE7;&#xE3;o parcial pcor.test(rp,1,length(dados$GASAUDE)) #&quot;1&quot; porque s&#xF3; usamos uma vari&#xE1;vel de controle</code></pre>
<pre><code>## $tval ## [1] 5.922106 ## ## $df ## [1] 117 ## ## $pvalue ## [1] 3.259388e-08</code></pre>
<pre class="r"><code>data.frame(&quot;Sem corre&#xE7;&#xE3;o&quot;=r^2, &quot;Com corre&#xE7;&#xE3;o&quot;=rp^2)</code></pre>
<pre><code>## Sem.corre&#xE7;&#xE3;o Com.corre&#xE7;&#xE3;o ## 1 0.6116985 0.2306242</code></pre>

<p>
A variável de controle (ou qualquer uma delas) pode ser dicotômica
(categórica)
</p>
<pre class="r"><code>#Visualmente: ggplot(data = dados, aes(x = GASLAZER, y = GASAUDE,colour = as.factor(PROFI))) + geom_point()</code></pre>
<p>
<img src="https://gomesfellipe.github.io/post/2017-12-02-tipos-de-relacoes-entre-variaveis_files/figure-html/unnamed-chunk-30-1.png" width="672">
</p>
<pre class="r"><code>#Sem controlar: r=cor(dados$GASLAZER, dados$GASAUDE) rp&lt;-pcor(c(&quot;GASLAZER&quot;, &quot;GASAUDE&quot;, &quot;PROFI&quot;),var(dados)) data.frame(&quot;Sem corre&#xE7;&#xE3;o&quot;=r^2, &quot;Com corre&#xE7;&#xE3;o&quot;=rp^2)</code></pre>
<pre><code>## Sem.corre&#xE7;&#xE3;o Com.corre&#xE7;&#xE3;o ## 1 0.6116985 0.6162497</code></pre>

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
</ul>
</footer>
</article>
<article class="post">
<a href="https://disqus.com/" class="dsq-brlink">comments powered by
</a>
</article>
</p>

