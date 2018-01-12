+++
title = "Ajustando Modelos Bayesianos com JAGS"
date = "2017-12-18"
categories = ["felippe-gomes"]
original_url = "https://gomesfellipe.github.io/post/2017-12-18-bayesiana-jags-mcmcplot/bayesiana-jags-mcmcplot/"
+++

<p>
Quando estamos falando de Inferência nosso objetivo normalmente é tentar
verificar alguma informação sobre uma quantidade desconhecida.
</p>
<p>
Para isso devemos utilizar <strong>toda</strong> informação disponível,
seja ela <strong>objetiva</strong> ou <strong>subjetiva</strong> (isto
é, vinda de umam amostra ou de algum conhecimento préveo ou intuitivo)
</p>
<p>
Segundo o ponto de vista Bayesiano essa informação subjetiva também será
incorporada na análise graças ao
<a href="https://pt.wikipedia.org/wiki/Teorema_de_Bayes">teorema de
bayes</a>.
</p>
<p>
Como no ponto de vista Bayesiano atribuímos aleatoriedade ao parâmetro,
nossa “crença” será representada por uma distribuição de probabilidade
(ou modelo probabilístico)
</p>
<p>
<em>Teorema de bayes</em>: <span class="math display">
$$ p(\\theta|x)=\\frac{p(x,\\theta)}{p(x)}=\\frac{p(x|\\theta)p(\\theta)}{p(x)} $$
</span>
</p>
<p>
onde:
</p>
<ul>
<li>
<span class="math inline">*p*(*x*|*θ*)</span>: função de verossimilhança
(modelo)
</li>
<li>
<span class="math inline">*p*(*θ*)</span>: distribuição a priori
</li>
<li>
<span class="math inline">*p*(*x*)</span>: distribuição marginal de
<span class="math inline">*x*</span>.
</li>
</ul>
<p>
A estimação muitas vezes envolve o cálculo de integrais nada simples
analiticamente porém, alguns algorítimos como o amostrador de Gibbs pode
relizar aproximações muito relevantes.
</p>

<p>
Para entender como funciona o modelo bayesiano, primeiramente vamos
começar com algo bem simples, suponha:
</p>
<p>
<span class="math display">
*Y*<sub>*i*</sub> ∼ *N*(*μ*<sub>*i*</sub>, *τ*)
</span> onde <span class="math inline">*μ*</span> é definido como <span
class="math inline">*μ*<sub>*i*</sub> = *X***β**</span>.
</p>
<p>
Incialmente vamos considerar que não existe relação nenhuma, então
utilizaremos a priori:
</p>
<p>
<span class="math display">
*β* ∼ *N*(0, *τ*<sub>*β*</sub>)
</span>
</p>
<p>
onde <span class="math inline">*τ*</span> é conhecido.
</p>
<p>
Nem sempre é uma tarefa simples determinar a distribuição posteri de um
modelo bayesiano e é neste ponto que o pacote <code>jags</code>será
bastante útil (existem outras alternativas como o
<a href="https://cran.r-project.org/package=R2WinBUGS">WinBugs</a>,
<a href="https://cran.r-project.org/package=R2OpenBUGS">OpenBugs</a>,
<a href="https://cran.r-project.org/web/packages/rstan/index.html">Stan</a>,
mas aqui resolvi trazer apenas o
<a href="https://cran.r-project.org/package=rjags">jags</a> por possuir
vantagens bem interessantes.)
</p>

<p>
O pacote
<a href="https://cran.r-project.org/package=R2jags"><code>R2jags</code></a>
é exatamente o que seu nome significa: “<em>Just Another Gibbs
Sampler</em>”. Possui as mesmas funcionalidades do nosso querido
<a href="https://cran.r-project.org/package=R2OpenBUGS">OpenBugs</a>
possibilitando também que seja utilizado inteiramente dentro do ambiente
R.
</p>
<p>
Assim como o OpenBugs, ele também trabalha chamando o
<a href="https://gomesfellipe.github.io/post/2017-12-18-bayesiana-jags-mcmcplot/bayesiana-jags-mcmcplot/mcmc-jags.sourceforge.net/">software
oficial que precisa ser baixado no site</a>.
</p>
<p>
Para começar a utilizar basta baixar o pacote e acessá-lo na biblioteca:
</p>
<pre class="r"><code>suppressMessages(library(R2jags))</code></pre>

<p>
A base de dados que será utilizada para ajustar o modelo será a base
nativa do R chamada <code>trees</code>:
</p>
<pre class="r"><code>X&lt;-trees[,1:2] #Matriz de vari&#xE1;veis explanat&#xF3;rias Y&lt;- trees[,3] #Vetor da vari&#xE1;vel resposta p &lt;- ncol(X) #p &#xE9; o n&#xFA;mero de par&#xE2;metros do modelo (nesse caso &#xE9; o n&#xFA;mero de colunas) n &lt;- nrow(X) #n &#xE9; o n&#xFA;mero de observa&#xE7;&#xF5;es do modelo</code></pre>
<p>
O modelo deve estar declarado e salvo em um arquivo <code>.txt</code>
(ou mesmo um outro arquivo <code>.r</code>) da seguinte maneira:
</p>
<pre class="r"><code>### Declarando o modelo Bayesiano sink(&quot;linreg.txt&quot;) cat(&quot; model { # Prioris for(j in 1:p) { beta[j] ~ dnorm(mu.beta, tau.beta) } sigma ~ dunif(0, 100) tau &lt;- 1/ (sigma * sigma) # Verossimilhan&#xE7;a for (i in 1:n) { y[i] ~ dnorm(mu[i], tau) mu[i] &lt;- inprod(X[i,], beta) } } &quot;,fill=TRUE) sink()</code></pre>
<p>
Uma vez que o modelo esta declarado, é a hora de nomear os parametros da
função que fará o ajuste do modelo
</p>
<pre class="r"><code>#Parametros da Priori mu.beta &lt;- 0 tau.beta &lt;- 0.001 #Set Working Directory wd &lt;- getwd() # Junte os dados em uma lista win.data &lt;- list(X=X,y=Y,p=p,n=n,mu.beta=mu.beta,tau.beta=tau.beta) # Fun&#xE7;&#xE3;o de inicializa&#xE7;&#xE3;o inits &lt;- function(){ list(beta=rnorm(p), sigma = rlnorm(1))} # Os parametros que desejamos estimar params &lt;- c(&quot;beta&quot;,&quot;sigma&quot;,&quot;tau&quot;) # Caracteristicas do MCMC n.burnin &lt;- 500 #N&#xFA;mero de itera&#xE7;&#xF5;es que ser&#xE3;o descartadas n.thin &lt;- 10 #para economizar mem&#xF3;ria e tempo de computa&#xE7;&#xE3;o se n.iter for grande n.post &lt;- 5000 n.chains &lt;- 3 #N&#xFA;mero de cadeias n.iter &lt;- n.burnin + n.thin*n.post #N&#xFA;mero de itera&#xE7;&#xF5;es</code></pre>

<p>
Após ter em mãos todos esses resultados, já podemos ajustar o modelo com
o comando <code>jags()</code>, veja:
</p>
<pre class="r"><code>bayes.mod.fit &lt;-jags(data = win.data, inits = inits, parameters = params, model.file = &quot;linreg.txt&quot;, # O arquivo &quot;linreg.txt&quot; deve estar no mesmo diret&#xF3;rio n.iter = n.iter, n.thin=n.thin, n.burnin=n.burnin, n.chains=n.chains, working.directory=wd,DIC = T)</code></pre>
<pre><code>## module glm loaded</code></pre>
<pre><code>## Compiling model graph ## Resolving undeclared variables ## Allocating nodes ## Graph information: ## Observed stochastic nodes: 31 ## Unobserved stochastic nodes: 3 ## Total graph size: 166 ## ## Initializing model</code></pre>
<pre class="r"><code>print(bayes.mod.fit, dig = 3)</code></pre>
<pre><code>## Inference for Bugs model at &quot;linreg.txt&quot;, fit using jags, ## 3 chains, each with 50500 iterations (first 500 discarded), n.thin = 10 ## n.sims = 15000 iterations saved ## mu.vect sd.vect 2.5% 25% 50% 75% 97.5% Rhat ## beta[1] 5.041 0.434 4.174 4.756 5.041 5.330 5.888 1.001 ## beta[2] -0.476 0.077 -0.626 -0.528 -0.476 -0.426 -0.323 1.001 ## sigma 6.441 0.885 4.973 5.816 6.340 6.971 8.448 1.001 ## tau 0.025 0.007 0.014 0.021 0.025 0.030 0.040 1.001 ## deviance 201.895 2.642 198.877 199.934 201.227 203.138 208.746 1.001 ## n.eff ## beta[1] 15000 ## beta[2] 15000 ## sigma 9000 ## tau 9000 ## deviance 15000 ## ## For each parameter, n.eff is a crude measure of effective sample size, ## and Rhat is the potential scale reduction factor (at convergence, Rhat=1). ## ## DIC info (using the rule, pD = var(deviance)/2) ## pD = 3.5 and DIC = 205.4 ## DIC is an estimate of expected predictive error (lower deviance is better).</code></pre>
<p>
Com os resultados em mãos podemos avaliar o ajuste do modelo, o jags nos
fornece os intervalos de credibilidade e o Rhat, que é a convergência da
cadeia, a princípio vamos apenas considerar o fato de que quanto mais
próximo de 1, melhor são as estimativas.
</p>
<p>
Não vou me extender neste post com a interpretação do modelo pois o
objetivo esta sendo mostrar a funcionalidade do jags em conjunto com o
R.
</p>

<p>
Para o diagnóstico do modelo podemos utilizar o pacote
<code>mcmcplots</code> que fornece de maneira bem agradável os
resultados gerados pelo amostrador, primeiramente vamos carregar o
pacote:
</p>
<pre class="r"><code>suppressMessages(library(mcmcplots))</code></pre>
<p>
Em seguida precisar informar para o <code>R</code> que o resultado do
algorítimo se trata de um objeto mcmc, portanto:
</p>
<pre class="r"><code>bayes.mod.fit.mcmc &lt;- as.mcmc(bayes.mod.fit) summary(bayes.mod.fit.mcmc)</code></pre>
<pre><code>## ## Iterations = 1:49991 ## Thinning interval = 10 ## Number of chains = 3 ## Sample size per chain = 5000 ## ## 1. Empirical mean and standard deviation for each variable, ## plus standard error of the mean: ## ## Mean SD Naive SE Time-series SE ## beta[1] 5.04122 0.433931 0.0035430 0.0035433 ## beta[2] -0.47641 0.077249 0.0006307 0.0006308 ## deviance 201.89526 2.641790 0.0215701 0.0215705 ## sigma 6.44108 0.885098 0.0072268 0.0072264 ## tau 0.02544 0.006748 0.0000551 0.0000551 ## ## 2. Quantiles for each variable: ## ## 2.5% 25% 50% 75% 97.5% ## beta[1] 4.17435 4.75638 5.04057 5.32985 5.88790 ## beta[2] -0.62634 -0.52791 -0.47616 -0.42614 -0.32258 ## deviance 198.87657 199.93420 201.22721 203.13842 208.74552 ## sigma 4.97252 5.81561 6.33999 6.97125 8.44793 ## tau 0.01401 0.02058 0.02488 0.02957 0.04044</code></pre>
<p>
O pacote nos fornece alguns tipos de gráficos para diagnóstico
</p>
<pre class="r"><code>caterplot(bayes.mod.fit.mcmc) #Observando todas as estimativas</code></pre>
<p>
<img src="https://gomesfellipe.github.io/post/2017-12-18-bayesiana-jags-mcmcplot/2017-12-18-bayesiana-jags-mcmcplot_files/figure-html/unnamed-chunk-8-1.png" width="672">
</p>
<pre class="r"><code>caterplot(bayes.mod.fit.mcmc,parms = params) #Observando as estimativas de todos os par&#xE2;metros menos o desvio</code></pre>
<p>
<img src="https://gomesfellipe.github.io/post/2017-12-18-bayesiana-jags-mcmcplot/2017-12-18-bayesiana-jags-mcmcplot_files/figure-html/unnamed-chunk-8-2.png" width="672">
</p>
<pre class="r"><code>denplot(bayes.mod.fit.mcmc) #Densidade das estimativas de cada cadeia</code></pre>
<p>
<img src="https://gomesfellipe.github.io/post/2017-12-18-bayesiana-jags-mcmcplot/2017-12-18-bayesiana-jags-mcmcplot_files/figure-html/unnamed-chunk-8-3.png" width="672">
</p>
<pre class="r"><code>traplot(bayes.mod.fit.mcmc,greek = T) #Avaliando a converg&#xEA;ncia</code></pre>
<p>
<img src="https://gomesfellipe.github.io/post/2017-12-18-bayesiana-jags-mcmcplot/2017-12-18-bayesiana-jags-mcmcplot_files/figure-html/unnamed-chunk-8-4.png" width="672">
</p>
<p>
E por fim, para diagnósticos rápidos, pode produzir arquivos html com
traço, densidade e autocorrelação.
</p>
<p>
O comando traça tudo em uma página e os arquivos serão exibidos em seu
navegador de internet padrão.
</p>
<pre class="r"><code>#mcmcplot(bayes.mod.fit.mcmc)</code></pre>
<p>
Vai retornar algo como:
</p>
<img src="https://gomesfellipe.github.io/post/2017-12-18-bayesiana-jags-mcmcplot/bayesiana-jags-mcmcplot/img/2017-12-18-bayesiana-jags-mcmcplot/imagem1.png">

<p>
Como o objetivo do post é trazer a funcionalidade do pacote, vou apenas
deixar ilustrado quais são algumas das funções mais comumente utilizadas
para avaliar estatísticamente o desempenho dos modelos.
</p>
<p>
Diagnosticos estatísticos do modelo:
</p>
<pre class="r"><code>#Mais diagnosticos: gelman.plot(bayes.mod.fit.mcmc)</code></pre>
<p>
<img src="https://gomesfellipe.github.io/post/2017-12-18-bayesiana-jags-mcmcplot/2017-12-18-bayesiana-jags-mcmcplot_files/figure-html/unnamed-chunk-10-1.png" width="672">
</p>
<pre class="r"><code>geweke.diag(bayes.mod.fit.mcmc)</code></pre>
<pre><code>## [[1]] ## ## Fraction in 1st window = 0.1 ## Fraction in 2nd window = 0.5 ## ## beta[1] beta[2] deviance sigma tau ## -0.7525 0.7990 -0.1262 -0.3000 0.2442 ## ## ## [[2]] ## ## Fraction in 1st window = 0.1 ## Fraction in 2nd window = 0.5 ## ## beta[1] beta[2] deviance sigma tau ## -0.6577 0.3495 -1.4621 -0.4054 -0.0026 ## ## ## [[3]] ## ## Fraction in 1st window = 0.1 ## Fraction in 2nd window = 0.5 ## ## beta[1] beta[2] deviance sigma tau ## 0.086228 -0.203488 -2.438796 -0.198904 -0.000538</code></pre>
<pre class="r"><code>geweke.plot(bayes.mod.fit.mcmc)</code></pre>
<p>
<img src="https://gomesfellipe.github.io/post/2017-12-18-bayesiana-jags-mcmcplot/2017-12-18-bayesiana-jags-mcmcplot_files/figure-html/unnamed-chunk-10-2.png" width="672"><img src="https://gomesfellipe.github.io/post/2017-12-18-bayesiana-jags-mcmcplot/2017-12-18-bayesiana-jags-mcmcplot_files/figure-html/unnamed-chunk-10-3.png" width="672"><img src="https://gomesfellipe.github.io/post/2017-12-18-bayesiana-jags-mcmcplot/2017-12-18-bayesiana-jags-mcmcplot_files/figure-html/unnamed-chunk-10-4.png" width="672">
</p>
<pre class="r"><code>raftery.diag(bayes.mod.fit.mcmc)</code></pre>
<pre><code>## [[1]] ## ## Quantile (q) = 0.025 ## Accuracy (r) = +/- 0.005 ## Probability (s) = 0.95 ## ## Burn-in Total Lower bound Dependence ## (M) (N) (Nmin) factor (I) ## beta[1] 20 36200 3746 9.66 ## beta[2] 20 37410 3746 9.99 ## deviance 20 35610 3746 9.51 ## sigma 20 38030 3746 10.20 ## tau 20 36810 3746 9.83 ## ## ## [[2]] ## ## Quantile (q) = 0.025 ## Accuracy (r) = +/- 0.005 ## Probability (s) = 0.95 ## ## Burn-in Total Lower bound Dependence ## (M) (N) (Nmin) factor (I) ## beta[1] 20 38030 3746 10.20 ## beta[2] 20 36200 3746 9.66 ## deviance 20 36800 3746 9.82 ## sigma 20 37410 3746 9.99 ## tau 20 39300 3746 10.50 ## ## ## [[3]] ## ## Quantile (q) = 0.025 ## Accuracy (r) = +/- 0.005 ## Probability (s) = 0.95 ## ## Burn-in Total Lower bound Dependence ## (M) (N) (Nmin) factor (I) ## beta[1] 20 36800 3746 9.82 ## beta[2] 20 37410 3746 9.99 ## deviance 20 38030 3746 10.20 ## sigma 20 38030 3746 10.20 ## tau 20 36800 3746 9.82</code></pre>
<pre class="r"><code>heidel.diag(bayes.mod.fit.mcmc)</code></pre>
<pre><code>## [[1]] ## ## Stationarity start p-value ## test iteration ## beta[1] passed 1 0.501 ## beta[2] passed 1 0.513 ## deviance passed 1 0.910 ## sigma passed 1 0.870 ## tau passed 1 0.835 ## ## Halfwidth Mean Halfwidth ## test ## beta[1] passed 5.0406 0.011840 ## beta[2] passed -0.4763 0.002109 ## deviance passed 201.8610 0.071856 ## sigma passed 6.4278 0.024174 ## tau passed 0.0255 0.000186 ## ## [[2]] ## ## Stationarity start p-value ## test iteration ## beta[1] passed 1 0.665 ## beta[2] passed 1 0.901 ## deviance passed 1 0.102 ## sigma passed 1 0.409 ## tau passed 1 0.572 ## ## Halfwidth Mean Halfwidth ## test ## beta[1] passed 5.0423 0.012170 ## beta[2] passed -0.4767 0.002167 ## deviance passed 201.9226 0.073403 ## sigma passed 6.4598 0.024746 ## tau passed 0.0253 0.000188 ## ## [[3]] ## ## Stationarity start p-value ## test iteration ## beta[1] passed 1 0.535 ## beta[2] passed 1 0.505 ## deviance passed 1 0.566 ## sigma passed 1 0.545 ## tau passed 1 0.571 ## ## Halfwidth Mean Halfwidth ## test ## beta[1] passed 5.0408 0.012074 ## beta[2] passed -0.4763 0.002148 ## deviance passed 201.9022 0.074403 ## sigma passed 6.4357 0.024672 ## tau passed 0.0255 0.000188</code></pre>

<p>
Uma função muito conveniente para analisar representações numéricas de
diagnósticos em um ajuste é o pacote <code>superdiag</code> de Tsai,
Gill e Rapkin, 2012 que trás uma série de estatísticas para avaliar o
desempenho dos ajustes do modelo.
</p>
<pre class="r"><code>library(superdiag)</code></pre>
<pre><code>## Carregando pacotes exigidos: boa</code></pre>
<pre class="r"><code>superdiag(bayes.mod.fit.mcmc, burnin = 100)</code></pre>
<pre><code>## Number of chains = 3 ## Number of iterations = 5000 per chain before discarding the burn-in period ## The burn-in period = 100 per chain ## Sample size in total = 14700 ## ## ********** The Geweke diagnostic: ********** ## Z-scores: ## chain1 chain 2 chain 3 ## beta[1] -0.6847148 -0.53909430 0.5489244 ## beta[2] 0.8767093 0.16014573 -0.5862203 ## deviance -0.1998514 -1.17898874 -0.5647567 ## sigma -0.1948859 0.07534338 -0.3671472 ## tau 0.1266931 -0.19103856 0.2890960 ## Window From Start 0.1000000 0.65517000 0.0405800 ## Window From Stop 0.5000000 0.06690000 0.9341600 ## ## ********** The Gelman-Rubin diagnostic: ********** ## Potential scale reduction factors: ## ## Point est. Upper C.I. ## beta[1] 1 1 ## beta[2] 1 1 ## deviance 1 1 ## sigma 1 1 ## tau 1 1 ## ## Multivariate psrf ## ## 1 ## ## ********** The Heidelberger-Welch diagnostic: ********** ## ## Chain 1, epsilon=0.1, alpha=0.05 ## Stationarity start p-value ## test iteration ## beta[1] passed 1 0.582 ## beta[2] passed 1 0.589 ## deviance passed 1 0.892 ## sigma passed 1 0.828 ## tau passed 1 0.801 ## ## Halfwidth Mean Halfwidth ## test ## beta[1] passed 5.0417 0.011977 ## beta[2] passed -0.4764 0.002132 ## deviance passed 201.8621 0.072646 ## sigma passed 6.4283 0.024416 ## tau passed 0.0255 0.000188 ## ## Chain 2, epsilon=0.023, alpha=0.05 ## Stationarity start p-value ## test iteration ## beta[1] passed 1 0.835 ## beta[2] passed 1 0.968 ## deviance passed 1 0.103 ## sigma passed 1 0.458 ## tau passed 1 0.570 ## ## Halfwidth Mean Halfwidth ## test ## beta[1] passed 5.0437 0.01227 ## beta[2] passed -0.4769 0.00219 ## deviance passed 201.9238 0.07421 ## sigma passed 6.4609 0.02506 ## tau passed 0.0253 0.00019 ## ## Chain 3, epsilon=0.066, alpha=0.05 ## Stationarity start p-value ## test iteration ## beta[1] passed 1 0.531 ## beta[2] passed 1 0.496 ## deviance passed 1 0.641 ## sigma passed 1 0.503 ## tau passed 1 0.535 ## ## Halfwidth Mean Halfwidth ## test ## beta[1] passed 5.0410 0.01223 ## beta[2] passed -0.4763 0.00208 ## deviance passed 201.9062 0.07524 ## sigma passed 6.4349 0.02334 ## tau passed 0.0255 0.00019 ## ## ********** The Raftery-Lewis diagnostic: ********** ## ## Chain 1, converge.eps = 0.001 ## Quantile (q) = 0.025 ## Accuracy (r) = +/- 0.005 ## Probability (s) = 0.95 ## ## Burn-in Total Lower bound Dependence ## (M) (N) (Nmin) factor (I) ## beta[1] 2 3635 3746 0.970 ## beta[2] 1 3757 3746 1.000 ## deviance 2 3575 3746 0.954 ## sigma 2 3821 3746 1.020 ## tau 2 3697 3746 0.987 ## ## ## Chain 2, converge.eps = 0.001 ## Quantile (q) = 0.001 ## Accuracy (r) = +/- 0.001 ## Probability (s) = 0.999 ## ## You need a sample size of at least 10817 with these values of q, r and s ## ## Chain 3, converge.eps = 5e-04 ## Quantile (q) = 0.001 ## Accuracy (r) = +/- 0.0025 ## Probability (s) = 0.95 ## ## Burn-in Total Lower bound Dependence ## (M) (N) (Nmin) factor (I) ## beta[1] 2 628 615 1.02 ## beta[2] 2 628 615 1.02 ## deviance 2 628 615 1.02 ## sigma 2 628 615 1.02 ## tau 2 628 615 1.02</code></pre>
<p>
Para finalizar, outra função que pode ser útil pata atualizando o
modelo, se necessário - por exemplo, se não houver convergência ou pouca
convergencia:
</p>
<pre class="r"><code>bayes.mod.fit.upd &lt;- update(bayes.mod.fit, n.iter=1000) bayes.mod.fit.upd &lt;- autojags(bayes.mod.fit)</code></pre>

<p>
Assim como toda a Estatística, inferência bayesiana não funciona se a
teoria não for aplicada corretamente. É uma ferramenta muito poderosa e
necessita ser usada com cautela pois demanda bastante o uso de
metodologias estatísticas.
</p>
<p>
Como dizia o tio Ben: “grandes poderes trazem grandes responsabilidades”
então vamos tomar cuidado com os resultados que encontramos.
</p>

