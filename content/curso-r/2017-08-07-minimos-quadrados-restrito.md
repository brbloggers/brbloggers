+++
title = "Mínimos quadrados com restrições lineares"
date = "2017-08-07 07:12:00"
categories = ["curso-r"]
original_url = "http://curso-r.com/blog/2017/08/07/2017-08-07-minimos-quadrados-restrito/"
+++

<p>
A característica mais importante de um modelo estatístico é a sua
flexibilidade. Esse termo pode ser entendido de várias formas, mas neste
texto vou considerar que um modelo é flexível se ele <em>explica
coerentemente</em> uma ampla gama de fenômenos reais.
</p>
<p>
Pensando assim, a regressão linear pode ser considerada um modelo
flexível, já que muitas relações funcionais cotidianas são do tipo <span
class="math inline">*y* = *β**x*</span>. É justamente por causa dessa
flexibilidade que a boa e velha regressão de mínimos quadrados é tão
usada, até mesmo aonde não deveria. O seu uso é tão indiscriminado que
uma vez, em aula, um professor extraordinariamente admirável me disse
que “90% dos problemas do mundo podem ser resolvidos com uma regressão
linear”.
</p>
<p>
Sendo bastante honesto, é provável que o meu professor esteja certo, mas
este post não é sobre isso. Este é um post sobre o que fazer quando a
regressão linear simples não basta. No que segue, vamos discutir uma
pequena (e poderosa) extensão do modelo de regressão linear simples, mas
antes de prosseguir para o problema propriamente dito (e sua
implementação em R), vamos discutir da teoria que existe por trás dele.
</p>
<p>
Embora seja pouco enfatizado nos bacharelados de estatística, uma
regressão linear pode ser formulada como um problema de programação
quadrática. Entrando nos detalhes, essa afirmação deve-se a dois fatos:
</p>
<ol>
<li>
Existe uma teoria, que chama-se programação quadrática, que soluciona
problemas da forma
</li>
</ol>
<p>
<span class="math display">
$$\\min\_x \\frac{1}{2}x&apos; Q x + c&apos; x,$$
</span>
</p>
<p>
onde <span class="math inline">*x* ∈ ℝ<sup>*p*</sup></span> e <span
class="math inline">*Q*</span> e <span class="math inline">*c*</span>
tem dimensões que fazem a conta acima ter sentido. A teoria ocupa-se
desenvolvendo algoritmos exatos e aproximados para obter soluções desses
problemas, inclusive com generalizações:
</p>
<p>
<span class="math display">
$$\\min\_x \\frac{1}{2}x&apos; Q x + c&apos; x, \\text{ sujeito a }Ax \\geq 0.$$
</span>
</p>
<ol>
<li>
Uma regressão linear consiste em resolver
</li>
</ol>
<p>
<span class="math display">
$$\\min\_\\beta (Y - \\beta X)&apos;(Y-\\beta X),$$
</span>
</p>
<p>
que, com um pouco de álgebra, é equivalente à
</p>
<p>
<span class="math display">
$$ \\min\_\\beta -2Y&apos;X\\beta + \\beta&apos;X&apos;X\\beta.$$
</span>
</p>
<p>
Logo, tomando <span class="math inline">$Q = 2X&apos;X$</span> e <span
class="math inline">$c = \\frac{1}{2}X&apos;Y$</span> tem-se que esse é
um problema de programação quadrática, que por sua vez é um problema
convexo, que, segundo a teoria, tem uma única solução no ponto <span
class="math inline">$\\beta = (X&apos;X)^{-1}X&apos;Y$</span>.
</p>

<p>
Talvez o jeito mais simples de flexibilizar uma regressão linear no
sentido mencionado no começo desse texto é restringir os seus
parâmetros. Em muitos contextos, esse é o único jeito de colocar
conhecimentos prévios na
modelagem<a href="http://curso-r.com/blog/2017/08/07/2017-08-07-minimos-quadrados-restrito/#fn1" class="footnoteRef" id="fnref1"><sup>1</sup></a>.
</p>
<p>
Um caso bastante emblemático aparece nas curvas de crédito divulgadas
pela
ANBIMA<a href="http://curso-r.com/blog/2017/08/07/2017-08-07-minimos-quadrados-restrito/#fn2" class="footnoteRef" id="fnref2"><sup>2</sup></a>.
Lá, ajusta-se um conjunto de curvas que depende de 6 parâmetros e cada
curva representa uma classificação de risco (que nem aquela em que o
Brasil pode tomar
<em>downgrade</em><a href="http://curso-r.com/blog/2017/08/07/2017-08-07-minimos-quadrados-restrito/#fn3" class="footnoteRef" id="fnref3"><sup>3</sup></a>).
Como os níveis de risco estão ordenados, é natural exigir que também
exista uma ordenação entre as curvas. Sem entrar em detalhes, a ideia
pode ser expressa assim:
</p>
<p>
<span class="math display">
$$\\beta\_{AAA} &lt; \\beta\_{AA} &lt; \\beta\_{A} &lt; \\beta\_{BBB} &lt; ...$$
</span>
</p>
<p>
O que é que isso tem a ver com programação quadrática? A resposta é que
a inequação acima pode ser escrita como <span
class="math inline">*A**β* ≥ 0</span>, de tal forma já existe uma teoria
para resolver uma regressão linear simples com restrições desse tipo!
Basta que ela seja vista como um problema de programação quadrática.
</p>

<p>
Existe um pacote de R para quase tudo, então, como não poderia deixar de
ser, existe um pacote em R para resolver problemas do tipo:
</p>
<p>
<span class="math display">
$$\\min\_x \\frac{1}{2}x&apos; Q x + c&apos; x, \\text{ sujeito a }Ax \\geq 0.$$
</span>
</p>
<p>
Para ilustrar o seu uso, vamos considerar um exemplo. Vamos simular um
conjunto de dados em que <span
class="math inline">*β*<sub>5</sub> = 0.31, *β*<sub>4</sub> = 0.43, *β*<sub>3</sub> = 1.31, *β*<sub>2</sub> = 2.19, *β*<sub>1</sub> = 2.29</span>
são os valores reais que precisamos estimar, considere que vale
</p>
<p>
<span class="math display">
*Y* ≈ *β*<sub>1</sub>*X*<sub>1</sub> + *β*<sub>2</sub>*X*<sub>2</sub> + *β*<sub>3</sub>*X*<sub>3</sub> + *β*<sub>4</sub>*X*<sub>4</sub> + *β*<sub>5</sub>*X*<sub>5</sub>
</span>
</p>
<p>
e que o erro de regressão tem distribuição normal.
</p>
<pre class="r"><code>set.seed(11071995)
N &lt;- 30 betas &lt;- c(2.29, 2.19, 1.31, 0.43, 0.31)
X &lt;- matrix(rnorm(5*N), byrow = T, ncol = length(betas), nrow = N)
Y &lt;- X %*% betas + rnorm(N, sd = 3)</code></pre>
<p>
Se soubermos <em>a priori</em> que valem as seguintes afirmações
</p>
<p>
<span class="math display">
$$ \\beta\_1,\\beta\_2,\\beta\_3,\\beta\_4,\\beta\_5 &gt; 0 \\text{ e } \\beta\_1 &gt; \\beta\_2 &gt; \\beta\_3 &gt; \\beta\_4 &gt; \\beta\_5,$$
</span>
</p>
<p>
a minimização de <span
class="math inline">$(Y-\\beta X)&apos;(Y-\\beta X)$</span> pode ser
resolvida usando a função <code>solve.QP</code>. Tudo que precisamos
fazer é escrever o conjunto de inequações na forma <span
class="math inline">*A**β* ≥ 0</span>. Mas isso é bem fácil! Basta notar
que as restrições são equivalentes à
</p>
<p>
<span class="math display">
$$ \\left(\\begin{array}{cccc}
1 &amp; 0 &amp; 0 &amp; 0 &amp; 0 \\\\
0 &amp; 1 &amp; 0 &amp; 0 &amp; 0 \\\\
0 &amp; 0 &amp; 1 &amp; 0 &amp; 0 \\\\
0 &amp; 0 &amp; 0 &amp; 1 &amp; 0 \\\\
0 &amp; 0 &amp; 0 &amp; 0 &amp; 1 \\\\
1 &amp; -1 &amp; 0 &amp; 0 &amp; 0 \\\\
0 &amp; 1 &amp; -1 &amp; 0 &amp; 0 \\\\
0 &amp; 0 &amp; 1 &amp; -1 &amp; 0 \\\\
0 &amp; 0 &amp; 0 &amp; 1 &amp; -1 \\\\
\\end{array}\\right) \\times \\left(\\begin{array}{c}\\beta\_1 \\\\ \\beta\_2 \\\\ \\beta\_3 \\\\ \\beta\_4 \\\\ \\beta\_5 \\end{array}\\right) \\geq 0.$$
</span>
</p>
<p>
Dessa forma, o problema está prontinho pra passar no moedor de carne,
com uma última ressalva. O problema resolvido no <code>solve.QP</code> é
</p>
<p>
<span class="math display">
$$\\min\_x \\frac{1}{2}x&apos; Q x + c&apos; x, \\text{ sujeito a }A&apos;x \\geq 0,$$
</span>
</p>
<p>
então vamos ter que tomar o cuidado de passar as nossas restrições
através do transposto da matriz que obtivemos acima. Isso resultará na
matriz <span class="math inline">*A*</span>.
</p>
<pre class="r"><code>library(tidyverse)
library(quadprog) Q &lt;- t(X) %*% X
c &lt;- t(Y) %*% X
A &lt;- cbind(c(1,0,0,0,0),c(0,1,0,0,0),c(0,0,1,0,0), c(0,0,0,1,0),c(0,0,0,0,1),c(1,-1,0,0,0), c(0,1,-1,0,0),c(0,0,1,-1,0),c(0,0,0,1,-1)) solucao &lt;- solve.QP(Q, # X&apos;X c, # Y&apos;X A, # A transposta c(0,0,0,0,0,0,0,0,0)) # vetor de compara&#xE7;&#xE3;o</code></pre>
<p>
Para checar como valeu a pena todo esse esforço, dá uma olhada na
diferença entre as estimativas! Os pontinhos vermelhos são as
estimativas do modelo irrestrito, enquanto as barras são as estimativas
do modelo com restrições.
</p>
<p>
<img src="http://curso-r.com/blog/2017-08-07-minimos-quadrados-restrito_files/figure-html/unnamed-chunk-3-1.png" width="672">
</p>

