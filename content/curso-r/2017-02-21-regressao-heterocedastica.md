+++
title = "Modelando a variância da normal"
date = "2017-03-09 11:07:31"
categories = ["curso-r"]
original_url = "http://curso-r.com/blog/2017/03/09/2017-02-21-regressao-heterocedastica/"
+++

<p>
Verificar as suposições dos modelos é muito importante quando fazemos
inferência estatística. Em particular, a suposição de
homocedasticidade<a href="http://curso-r.com/blog/2017/03/09/2017-02-21-regressao-heterocedastica/#fn1" class="footnoteRef" id="fnref1"><sup>1</sup></a>
dos modelos de regressão linear é especialmente importante, pois
modifica o cálculo de erros padrão, intervalos de confiança e valores-p.
</p>
<p>
Neste post, vou mostrar três pacotes do R que ajustam modelos da forma
</p>
<p>
<span class="math display">
$$ Y\_i = \\beta\_0 + \\sum\_{k=1}^p\\beta\_kx\_{ik} + \\epsilon\_i, \\ i = 1,\\ldots,n$$
</span>
</p>
<p>
<span class="math display">
*ϵ*<sub>*i*</sub> ∼ N(0, *σ*<sub>*i*</sub>), *i* = 1, …, *n* independentes, com *σ*<sub>*i*</sub><sup>2</sup> = *α**x*<sub>*i*</sub><sup>2</sup>.
</span>
</p>
<p>
Além de mostrar como se faz, também vou ilustrar o desempenho dos
pacotes em um exemplo simulado. O modelo que gerará os dados do exemplo
terá a seguinte forma funcional
</p>
<p>
<span class="math display">
*Y*<sub>*i*</sub> = *β**x*<sub>*i*</sub> + *ϵ*<sub>*i*</sub>,  *i* = 1, ...*n*
</span> <span class="math display">
$$ \\epsilon\_i \\sim N(0, \\sigma\_i)\\text{ independentes, com }\\sigma\_i = \\alpha\\sqrt{|x\_i|},$$
</span>
</p>
<p>
e os parâmetros do modelo serão os valores <span
class="math inline">*β* = 1</span> e <span
class="math inline">*α* = 4</span>. A heterocedasticidade faz com que os
pontos desenhem um cone ao redor da reta de regressão.
</p>
<pre class="r"><code>library(ggplot2) N &lt;- 1000 set.seed(11071995)
X &lt;- sample((N/100):(N*3), N)
Y &lt;- rnorm(N,X,4*sqrt(X)) qplot(X,Y) + theme_bw(15) + geom_point(color = &apos;darkorange&apos;)</code></pre>
<p>
<img src="http://curso-r.com/blog/2017-02-21-regressao-heterocedastica_files/figure-html/unnamed-chunk-1-1.png" width="672">
</p>
<pre class="r"><code>X2 &lt;- sqrt(X)
dataset &lt;- data.frame(Y,X,X2)</code></pre>
<p>
Quando se ajusta um GAMLSS, você pode modelar os parâmetros de locação,
escala e curtose ao mesmo tempo em que escolhe a distribuição dos dados
dentre uma grande gama de opções. Escolhendo a distribuição normal e
modelando apenas os parâmetros de locação e escala, o GAMLSS ajusta
modelos lineares normais com heterocedasticidade.
</p>
<p>
No código abaixo, o parâmetro <code>formula = Y ~ X-1</code> indica que
a função de regressão será constituída por um preditor linear em
<code>X</code> sem intercepto. Já o parâmetro <code>sigma.formula =
~X2-1</code> indica que o desvio padrão será modelado por um preditor
linear em <code>X2</code> (ou raiz de <code>X</code>), também sem
intercepto.
</p>
<pre class="r"><code>library(gamlss) fit_gamlss &lt;- gamlss::gamlss(formula = Y ~ X-1, sigma.formula = ~X2-1, data = dataset, family = NO())</code></pre>
<pre><code>GAMLSS-RS iteration 1: Global Deviance = 17872.29 GAMLSS-RS iteration 2: Global Deviance = 17870.67 GAMLSS-RS iteration 3: Global Deviance = 17870.67 </code></pre>
<p>
Conforme descrito no sumário abaixo, a estimativa de alfa está muito
abaixo do valor simulado.
</p>
<pre class="r"><code>summary(fit_gamlss)</code></pre>
<pre><code>******************************************************************
Family: c(&quot;NO&quot;, &quot;Normal&quot;) Call: gamlss::gamlss(formula = Y ~ X - 1, sigma.formula = ~X2 - 1, family = NO(), data = dataset) Fitting method: RS() ------------------------------------------------------------------
Mu link function: identity
Mu Coefficients: Estimate Std. Error t value Pr(&gt;|t|) X 0.996942 0.005131 194.3 &lt;2e-16 ***
---
Signif. codes: 0 &apos;***&apos; 0.001 &apos;**&apos; 0.01 &apos;*&apos; 0.05 &apos;.&apos; 0.1 &apos; &apos; 1 ------------------------------------------------------------------
Sigma link function: log
Sigma Coefficients: Estimate Std. Error t value Pr(&gt;|t|) X2 0.1791449 0.0009606 186.5 &lt;2e-16 ***
---
Signif. codes: 0 &apos;***&apos; 0.001 &apos;**&apos; 0.01 &apos;*&apos; 0.05 &apos;.&apos; 0.1 &apos; &apos; 1 ------------------------------------------------------------------
No. of observations in the fit: 1000 Degrees of Freedom for the fit: 2 Residual Deg. of Freedom: 998 at cycle: 3 Global Deviance: 17870.67 AIC: 17874.67 SBC: 17884.49 ******************************************************************</code></pre>

<p>
Quando se ajusta um Modelo Linear Generalizado Duplo (MLGD em português
e DGLM em inglês), você tem uma flexibilidade parecida com a de um
GAMLSS. Entretanto, você não pode definir um modelo para a curtose e a
classe de distribuições disponível é bem menor.
</p>
<p>
O código abaixo, similar ao utilizado para ajustar o GAMLSS, ajusta um
DGLM aos dados simulados.
</p>
<pre class="r"><code>library(dglm) fit &lt;- dglm(Y~X-1, dformula = ~X2-1,data = dataset, family = gaussian, method = &apos;reml&apos;)</code></pre>
<pre><code>Warning: glm.fit: algorithm did not converge</code></pre>
<p>
Novamente, verifica-se que o alfa estimado está muito distante do
verdadeiro alfa.
</p>
<pre class="r"><code>summary(fit)</code></pre>
<pre><code>
Call: dglm(formula = Y ~ X - 1, dformula = ~X2 - 1, family = gaussian, data = dataset, method = &quot;reml&quot;) Mean Coefficients: Estimate Std. Error t value Pr(&gt;|t|)
X 0.9969432 0.008981392 111.001 0
(Dispersion Parameters for gaussian family estimated as below ) Scaled Null Deviance: 27197.48 on 1000 degrees of freedom
Scaled Residual Deviance: 3090.08 on 999 degrees of freedom Dispersion Coefficients: Estimate Std. Error z value Pr(&gt;|z|)
X2 0.3577322 0.001166004 306.8019 0
(Dispersion parameter for Gamma family taken to be 2 ) Scaled Null Deviance: 1628.301 on 1000 degrees of freedom
Scaled Residual Deviance: 6526.59 on 999 degrees of freedom Minus Twice the Log-Likelihood: 17870.76 Number of Alternating Iterations: 18 </code></pre>

<p>
<a href="http://mc-stan.org/">Stan</a> é uma linguagem de programação
voltada para descrever e manipular objetos probabilísticos, como por
exemplo variáveis aleatórias, processos estocásticos, distribuições de
probabilidades etc. Essa linguagem foi projetada para tornar intuitivo e
simples o ajuste de modelos estatísticos. Em particular, a forma de
descrever modelos bayesianos é bem cômoda.
</p>
<p>
O <code>stan</code> possui várias interfaces para <code>R</code>. A mais
básica é o <code>rstan</code>, que será utilizada aqui. A principal
função desse pacote é a função <code>rstan</code>, que possui dois
parâmetros básicos:
</p>
<ul>
<li>
um parâmetro <code>model\_code =</code>, que recebe um código que
descreve o modelo na linguagem <code>stan</code>.
</li>
<li>
um parâmetro <code>data =</code>, que recebe uma lista contendo os
inputs do modelo, tais como dados coletados, parâmetros de distribuições
a priori, etc.
</li>
</ul>
<p>
Embora esse seja o mínimo que a função precisa, também podemos passar
outras componentes. O parâmetro <code>verbose = FALSE</code> faz com que
a função não imprima nada enquanto roda e o parâmetro <code>control =
list(...)</code> passa uma lista de opções de controle para o algoritmo
de ajuste.
</p>
<p>
O retorno da função <code>stan()</code> é um objeto do tipo
<code>stanfit</code>, que pode ser sumarizado da mesma forma que outros
modelos em R, utilizando a função <code>summary()</code> e a função
<code>plot()</code>.
</p>
<p>
O código abaixo ilustra a aplicação da função <code>stan()</code> ao
nosso exemplo.
</p>
<pre class="r"><code>library(rstan) scode &lt;- &quot;data { int&lt;lower=0&gt; N; vector[N] y; vector[N] x;
}
parameters { real beta; real&lt;lower=0&gt; alpha;
}
model { beta ~ normal(0,10); alpha ~ gamma(1,1); y ~ normal(beta * x, alpha * sqrt(x));
}&quot; dados &lt;- list(N = nrow(dataset), y = dataset$Y, x = dataset$X) fit_stan &lt;- rstan::stan(model_code = scode, verbose = FALSE, data = dados, control = list(adapt_delta = 0.99))</code></pre>
<p>
A figura abaixo descreve os intervalos de credibilidade obtidos para
cada parâmetro do modelo. O ponto central de cada intervalo representa
as estimativas pontuais dos parâmetros. Como se nota, as estimativas do
modelo utilizando <code>stan</code> estão bem próximas dos valores
verdadeiros.
</p>
<pre class="r"><code>plot(fit_stan)</code></pre>
<p>
<img src="http://curso-r.com/blog/2017-02-21-regressao-heterocedastica_files/figure-html/unnamed-chunk-8-1.png" width="672">
</p>

