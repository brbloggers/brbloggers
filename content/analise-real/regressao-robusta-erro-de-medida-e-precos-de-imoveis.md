+++
title = "Regressão robusta, erro de medida e preços de imóveis"
date = "2017-02-20 20:31:57"
categories = ["analise-real"]
original_url = "https://analisereal.com/2017/02/20/regressao-robusta-erro-de-medida-e-precos-de-imoveis/"
+++

<article id="post-3783" class="post-3783 post type-post status-publish format-standard hentry category-dados category-econometria category-estatistica category-imoveis-2 category-r tag-brasilia tag-erro-de-medida tag-growth-regression tag-imoveis tag-lm tag-lmrob tag-r tag-regressao-robusta">
<br>
<p>
Um amigo estava tendo problemas ao analisar sua base de dados e pediu
ajuda — ao olhar alguns gráficos o problema parecia claro: erro de
medida. Resolvi revisitar um
<a href="https://analisereal.com/2014/12/21/erro-de-medida-precos-de-imoveis-e-growth-regressions/">post
antigo</a> e falar um pouco mais sobre como poucas observações
influentes podem afetar sua análise e como métodos robustos podem te dar
uma dica se isso está acontecendo.
</p>
<p>
Voltemos, então, ao nosso exemplo de uma base de dados de venda de
imóveis <em>online</em>:
</p>
<pre class="brush: r; title: ; notranslate">
arquivo &lt;- url(&quot;https://dl.dropboxusercontent.com/u/44201187/dados/vendas.rds&quot;)
con &lt;- gzcon(arquivo)
vendas &lt;- readRDS(con)
close(con)
</pre>
<p>
Suponha que você esteja interessado na relação entre preço e tamanho do
imóvel. Basta um gráfico para perceber que a base contém alguns dados
<em>muito</em> corrompidos:
</p>
<pre class="brush: r; title: ; notranslate">
with(vendas, plot(preco ~ m2))
</pre>
<p>
<img class="size-full wp-image-3788 aligncenter" src="https://analisereal.files.wordpress.com/2017/02/unnamed-chunk-15-1.png?w=440%20440w,%20https://analisereal.files.wordpress.com/2017/02/unnamed-chunk-15-1.png?w=150%20150w,%20https://analisereal.files.wordpress.com/2017/02/unnamed-chunk-15-1.png?w=300%20300w,%20https://analisereal.files.wordpress.com/2017/02/unnamed-chunk-15-1.png%20504w" alt="unnamed-chunk-15-1" srcset="https://analisereal.files.wordpress.com/2017/02/unnamed-chunk-15-1.png?w=440 440w, https://analisereal.files.wordpress.com/2017/02/unnamed-chunk-15-1.png?w=150 150w, https://analisereal.files.wordpress.com/2017/02/unnamed-chunk-15-1.png?w=300 300w, https://analisereal.files.wordpress.com/2017/02/unnamed-chunk-15-1.png 504w">
</p>
<p>
Mas, não são muitos pontos. Nossa base tem mais de 25 mil observações,
será que apenas essas poucas observações corrompidas podem alterar tanto
assim nossa análise? Sim. Se você rodar uma regressão simples, ficará
desapontado:
</p>
<pre class="brush: r; title: ; notranslate">
summary(m1 &lt;- lm(preco ~ m2, data = vendas))
</pre>
<pre class="brush: plain; title: ; notranslate">
##
## Call:
## lm(formula = preco ~ m2, data = vendas)
##
## Residuals:
## Min 1Q Median 3Q Max
## -6746423 -937172 -527498 99957 993612610
##
## Coefficients:
## Estimate Std. Error t value Pr(&gt;|t|)
## (Intercept) 1386226.833 18826.675 73.631 &lt; 0.0000000000000002 ***
## m2 18.172 3.189 5.699 0.0000000121 ***
## ---
## Signif. codes: 0 &apos;***&apos; 0.001 &apos;**&apos; 0.01 &apos;*&apos; 0.05 &apos;.&apos; 0.1 &apos; &apos; 1
##
## Residual standard error: 9489000 on 254761 degrees of freedom
## Multiple R-squared: 0.0001275, Adjusted R-squared: 0.0001235
## F-statistic: 32.48 on 1 and 254761 DF, p-value: 0.00000001208
</pre>
<p>
A regressão está sugerindo que cada metro quadrado extra no imóvel
corresponde, em média, a um aumento de apenas 18 reais em seu preço!
Como vimos no caso do
<a href="https://analisereal.com/2014/12/21/erro-de-medida-precos-de-imoveis-e-growth-regressions/">post
anterior</a>, limpar um percentual bem pequeno da base é suficiente para
estimar algo que faça sentido.
</p>
<p>
Mas, suponha que você não tenha noção de quais sejam os outliers da base
e também que, por alguma razão, você não saiba que 18 reais o metro
quadrado é um número <em>completamente absurdo a priori</em>. O que
fazer? (Vale fazer um parêntese aqui – se você está analisando um
problema em que você não tem o mínimo de conhecimento substantivo, não
sabe julgar sequer se 18 é um número grande ou pequeno, plausível ou
não, <em>isso por si só é um sinal de alerta</em>, mas prossigamos de
qualquer forma!)
</p>
<p>
Um hábito que vale a pena você incluir no seu dia-a-dia é rodar
<a href="https://projecteuclid.org/download/pdf_1/euclid.aos/1176350366">regressões
resistentes/robustas</a>, que buscam levar em conta a possibilidade de
uma grande parcela dos dados estar corrompida.
</p>
<p>
Vejamos o que ocorre no nosso exemplo de dados online:
</p>
<pre class="brush: r; title: ; notranslate">
library(robust)
summary(m2 &lt;- lmRob(preco ~ m2, data = vendas))
</pre>
<pre class="brush: plain; title: ; notranslate">
##
## Call:
## lmRob(formula = preco ~ m2, data = vendas)
##
## Residuals:
## Min 1Q Median 3Q Max
## -3683781389 -202332 -23119 64600 994411077
##
## Coefficients:
## Estimate Std. Error t value Pr(&gt;|t|)
## (Intercept) -15926.247 589.410 -27.02 &lt;0.0000000000000002 ***
## m2 9450.762 5.611 1684.32 &lt;0.0000000000000002 ***
## ---
## Signif. codes: 0 &apos;***&apos; 0.001 &apos;**&apos; 0.01 &apos;*&apos; 0.05 &apos;.&apos; 0.1 &apos; &apos; 1
##
## Residual standard error: 171800 on 254761 degrees of freedom
## Multiple R-Squared: 0.4806
##
## Test for Bias:
## statistic p-value
## M-estimate 502.61 0
## LS-estimate 86.91 0
</pre>
<p>
Agora cada metro quadrado correponde a um aumento de R$9.450,00 no preço
do imóvel! A mensagem aqui extrapola dados online, que são notórios por
terem observações com erros de várias ordens de magnitude. Praticamente
toda base de dados que você usa está sujeita a isso, mesmo de fontes
oficiais.
<a href="https://analisereal.com/2014/12/21/erro-de-medida-precos-de-imoveis-e-growth-regressions/">No
post anterior</a> vimos um exemplo em que pesquisadores não desconfiaram
de uma queda de 36% (!!!) do PIB na Tanzânia.
</p>
<p>
Por fim, vale fazer a ressalva de sempre: entender o que está
acontencedo nos seus dados — por que os valores são diferentes e a razão
de existir de alguns outliers  — é fundamental. Dependendo do tipo de
problema, os outliers podem <em>não</em> ser erros de medida, e você não
quer simplesmente ignorar sua influência. Na verdade, há casos em que
outliers podem ser a parte mais interessante da história.
</p>

</article>

