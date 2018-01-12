+++
title = "Tidy Data, Teste T Pareado e Modelos Mistos"
date = "2017-10-27 07:12:00"
categories = ["curso-r"]
original_url = "http://curso-r.com/blog/2017/10/27/2017-10-27-tidy-data-mixed-models/"
+++

<p>
Esse paper é, para mim, o melhor artigo do Hadley. A primeira frase da
definição cita Tolstói e diz:
</p>
<blockquote>
<p>
Like families, tidy datasets are all alike but every messy dataset is
messy in its own way.
</p>
</blockquote>
<p>
Essa frase resume a vida de qualquer um que trabalha ou já trabalhou com
análise de dados. O ponto mais importante do que significa <em>tidy
data</em> também está neste primeiro parágrafo: são datasets em que a
estrutura dos dados está ligada padronizadamente com o seu significado.
A forma padronizada é:
</p>
<p>
O exemplo cássico é o seguinte. Primeiro vamos ver um banco de dados
<em>desarrumado</em>.
</p>
<p>
Esse dataset está <em>desarrumado</em> pois existem duas colunas
<strong>Idh2015</strong> e <strong>Idh2014</strong> que representam a
mesma variável: <strong>IDH</strong> e uma variável implícita
<strong>ANO</strong>, que também aparece nesta duas colunas. A forma
<em>tidy</em> de representar este dataset seria:
</p>
<p>
… teste t-pareado ou com modelos mistos?
</p>
<p>
Suponha que queremos inferir se houve alguma mudança na média do IDH de
um ano para o outro. Ou seja testar se a média do IDH de 2015 é
diferente da média do IDH de 2014. Vamos considerar um banco de dados
simulado:
</p>
<pre class="r"><code>set.seed(10201)
library(tidyverse)
df &lt;- data_frame( Pais = paste0(&quot;pais&quot;, 1:50), Idh2014 = runif(50), Idh2015 = Idh2014 + rnorm(50, mean = 0.1, sd = 0.025)
)</code></pre>
<p>
Uma forma de fazer isso é usar o teste t pareado que é ensinado nos
cursos introdutórios de estatística. Basicamente o que ele faz é testar
se a média da diferença entre o IDH2015 e o IDH 2014 é diferente de
zero. Isso é diferente de um teste T usual, pois o teste t pareado
ajusta o seu cálculo da variância para considerar que existem duas
fontes de incerteza.
</p>
<p>
No R a forma mais natural de fazer isso é:
</p>
<pre class="r"><code>teste &lt;- t.test(df$Idh2015, df$Idh2014, paired=TRUE)</code></pre>
<p>
Note que o nosso banco de dados está <em>desarrumado</em> e mesmo assim
foi muito simples fazer esse teste no R. Agora vamos arrumar o banco de
dados.
</p>
<pre class="r"><code>df &lt;- df %&gt;% gather(ano, idh, -Pais) %&gt;% mutate(ano = parse_number(ano))</code></pre>
<p>
Agora para fazer o mesmo teste, poderíamos filtrar o banco de dados duas
vezes, por exemplo:
</p>
<pre class="r"><code>t.test(df$idh[df$ano == 2015], df$idh[df$ano == 2014], paired = TRUE) Paired t-test data: df$idh[df$ano == 2015] and df$idh[df$ano == 2014]
t = 27.355, df = 49, p-value &lt; 2.2e-16
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval: 0.09000554 0.10427822
sample estimates:
mean of the differences 0.09714188 </code></pre>
<p>
Mas aí estamos voltando para a forma desarrumada para fazer o teste.
Outra forma de fazer é considerar essa comparação de médias como um
problema de regressão em que a suposição independência das observações
não é válida, uma vez que dado um pais, com certeza existe relação entre
o idh de 2014 e de 2015.
</p>
<p>
Vamos ajustar um modelo com efeitos aleatórios para esse problema e
comparar os resultados.
</p>
<pre class="r"><code>library(nlme)
model &lt;- lme(idh ~ as.factor(ano), random = ~1|Pais, data = df)
summary(model)
Linear mixed-effects model fit by REML Data: df AIC BIC logLik -184.7518 -174.4119 96.37588 Random effects: Formula: ~1 | Pais (Intercept) Residual
StdDev: 0.3009017 0.01775584 Fixed effects: idh ~ as.factor(ano) Value Std.Error DF t-value p-value
(Intercept) 0.4840132 0.04262795 49 11.35436 0
as.factor(ano)2015 0.0971419 0.00355117 49 27.35491 0 Correlation: (Intr)
as.factor(ano)2015 -0.042 Standardized Within-Group Residuals: Min Q1 Med Q3 Max -1.88877770 -0.44544521 -0.01239249 0.39934207 1.84475543 Number of Observations: 100
Number of Groups: 50 </code></pre>
<p>
Estamos interessados em comparar a significância do efeito fixo da
variável ano nesse modelo com a do teste t-pareado. Veja que no caso a
estatística T do testes é idêntica: 27.35.
</p>
<p>
Vimos que a forma como os dados estão estruturados no seu banco de dados
pode influenciar a técnica utilizada para a sua análise. Se ele
estivesse na forma <em>desarrumada</em> o mais natural seria aplicar um
teste t pareado, se ele estivesse em formado <em>tidy</em> o natural
seria usar um modelo misto. No seu paper, Hadley argumenta que a maioria
dos softwares esperam que o seu banco de dados esteja <em>arrumado</em>
no sentido de que cada variável é uma coluna e cada observação é uma
linha.
</p>

