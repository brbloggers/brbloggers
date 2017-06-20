+++
title = "Erro de medida e ‘atenuação’ dos efeitos estimados"
date = "2017-02-11 22:16:18"
categories = ["analise-real"]
original_url = "https://analisereal.com/2017/02/11/__trashed/"
+++

<article id="post-3751" class="post-3751 post type-post status-publish format-standard hentry category-econometria category-estatistica category-metodologia tag-andrew-gelman tag-significancia-estatistica">
<br>
<p>
<a href="http://www.stat.columbia.edu/%7Egelman/research/published/measurement.pdf">Andrew
Gelman publicou um pequeno comentário na Science</a> sobre erro de
medida e “atenuação dos efeitos estimados”. O argumento é o seguinte: no
modelo clássico de erro de medida, na média suas estimativas são puxadas
para baixo. Suponha, então, que você tenha feito um experimento com
amostra pequena, com erro de medida, mas ainda assim você tenha
encontrado um efeito estimado “significante”. Ora, é tentador argumentar
o seguinte: tanto a amostra pequena quanto o erro de medida estão
“jogando contra” meu efeito estimado, então é provável que o efeito real
seja ainda maior do que o que eu estimei. Parece lógico, não?
</p>
<p>
Parece, mas não é. E, infelizmente, esse raciocínio ainda engana muitos
pesquisadores. Na verdade, em um contexto de efeitos reais pequenos
junto com amostras pequenas, é mais provável que aquelas estimativas
estatisticamente significantes estejam <em>superestimando</em> o efeito
real. O problema aqui é que o ruído das amostras pequenas em conjunto
com o viés de seleção de estimativas estatisticamente significantes
predomina. Vejamos isso na prática com uma simples simulação.
</p>
<p>
No código abaixo eu simulo mil estudos com um tamanho amostral fixo (n =
10, n = 20, n = 50, n = 500 e n = 1000). Desses mil estudos, eu
seleciono apenas aqueles que são estatisticamente “significantes” e
coloco no gráfico o valor estimado do estudo. O valor real do efeito é
0.1, que está representado pela linha vermelha. Vejam que, para amostras
até de tamanho 100, <em>todas</em> as estimativas “significantes” da
simulação estão superestimando o efeito real. Apenas quando a amostra é
grande o suficiente que o efeito atenuante do erro de medida se faz
prevalecer, revertendo o resultado.
</p>
<p>
<img src="https://dl.dropboxusercontent.com/u/44201187/wp/figure/cars-1.png" alt="plot of chunk cars">
</p>
<p>
E se você comparar as estimativas com e sem erro de medida, como faz
Gelman, também vai verificar que com amostras pequenas dificilmente uma
é sempre maior do que a outra.
</p>
<p>
Código para simulação:
</p>
<pre class="brush: r; title: ; notranslate">rm(list = ls())
set.seed(10)
ns = c(10, 20, 50, 100, 500, 1000)
oldpar &lt;- par(mfrow = c(2,3))
for (n in ns) { b = 0.1 x &lt;- rnorm(n) y &lt;- b*x coefs &lt;- replicate(1000, { xs &lt;- x + rnorm(n) ys &lt;- y + rnorm(n) coef(summary(lm(ys ~ xs)))[2,] }) coefs &lt;- t(coefs) plot(coefs[coefs[,3] &gt; 2, 1], ylim = c(min(c(b, coefs[,1])), max(coefs[,1])), xlab = &quot;Significant Experiments&quot;, ylab = &quot;&apos;Significant&apos; Estimates&quot;, main = paste(&quot;Sample size =&quot;, n), pch = 20) abline(h = b, col = &quot;red&quot;, lty = 2)
}
par(oldpar)
</pre>

</article>

