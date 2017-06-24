+++
title = "Componentes Principais - Intuição"
date = "2017-06-24 07:12:00"
categories = ["curso-r"]
original_url = "http://curso-r.com/blog/2017/06/24/2017-06-24-componentes-principais-intuicao/"
+++

<p class="text-muted text-uppercase mb-small text-right">
Por <a href="http://curso-r.com/author/athos">Athos</a> 24/06/2017
</p>
<p>
Componentes principais são bastante utilizados em modelagem estatística,
mas a sua definição matemática rigorosa faz com que a ACP pareça um
conceito mais abstrato do que somos capazes de compreender, em
particular quando falam <strong>“maximizar a variância total”</strong> e
<strong>“diminuir a dimensionalidade”</strong>. A primeira reação é um
grande “HEIN?”.
</p>
<p>
Abaixo tem alguns gráficos em 3 dimensões que dá uma boa ilustração
sobre o que essas duas afirmativas querem dizer e, mesmo sendo um
exemplo simples, irá ajudar a extrapolar a ideia para problemas mais
complexos.
</p>
<ol>
<li>
O primeiro gráfico é a representação com <strong>100% da
informação</strong> em três dimensões.
</li>
<li>
O segundo gráfico é como fica a representação do mesmo conjunto de
dados, mas com uma dimensão a menos (<strong>redução de
dimensionalidade</strong>).
</li>
<li>
Ao diminuir uma dimensão, perdemos informação (não é mais <strong>100%
da variância total</strong>) e essa perda é mensurada pela variância
explicada pelas dimensões que deixamos para trás.
</li>
<li>
As duas primeiras dimensões projetam os dados de tal forma que
apresentem a <strong>maximizar a variância total</strong> possível em
apenas duas dimensões.
</li>
</ol>
<p>
<strong>pacotes para os exemplos</strong>
</p>
<pre class="r"><code>library(plotly)
library(magrittr)
library(tidyr)
library(dplyr)</code></pre>
<pre class="r"><code>a &lt;- 1
tetraedro &lt;- data.frame( x = c(a * sqrt(3)/3, - a * sqrt(3)/6, - a * sqrt(3)/6, 0), y = c(0, - a/2, a/2, 0), z = c(0, 0, 0, a * sqrt(6)/3), cor = c(&quot;a&quot;, &quot;b&quot;, &quot;c&quot;, &quot;d&quot;), id = 1:4) tetraedro_linhas &lt;- combn(x = tetraedro$id, m = 2) %&gt;% t %&gt;% as.data.frame.matrix %&gt;% set_names(c(&quot;id1&quot;, &quot;id2&quot;)) %&gt;% mutate(id_par = 1:n()) %&gt;% gather(id_ordem, id, id1, id2) %&gt;% left_join(tetraedro, by = &quot;id&quot;) %&gt;% arrange(id_ordem)</code></pre>
<pre class="r"><code>tetraedro_pc &lt;- prcomp(tetraedro %&gt;% dplyr::select(x, y, z))
summary(tetraedro_pc)
## Importance of components:
## PC1 PC2 PC3
## Standard deviation 0.4082 0.4082 0.4082
## Proportion of Variance 0.3333 0.3333 0.3333
## Cumulative Proportion 0.3333 0.6667 1.0000 p1 &lt;- plot_ly(x = ~x, y = ~y, z = ~z, width = &quot;50%&quot;, height = &quot;50%&quot;) %&gt;% add_lines(data = tetraedro) %&gt;% add_markers(data = tetraedro) p2 &lt;- plot_ly(x = ~PC2, y = ~PC3, z = ~PC3, width = &quot;50%&quot;, height = &quot;50%&quot;) %&gt;% # add_lines(data = tetraedro_pc %&gt;% predict %&gt;% as.data.frame) %&gt;% add_markers(data = tetraedro_pc %&gt;% predict %&gt;% as.data.frame) htmltools::tagList(list(p1, p2))</code></pre>

<pre class="r"><code>x &lt;- c()
y &lt;- c()
z &lt;- c()
c &lt;- c() for (i in 1:62) { r &lt;- 20 * cos(i / 20) x &lt;- c(x, r * cos(i)) y &lt;- c(y, r * sin(i)) z &lt;- c(z, i) c &lt;- c(c, i)
} data &lt;- data.frame(x, y, z, c)</code></pre>
<pre class="r"><code>p1 &lt;- plot_ly(data, x = ~x, y = ~y, z = ~z, type = &apos;scatter3d&apos;, mode = &apos;lines+markers&apos;, line = list(width = 6, color = ~c, colorscale = &apos;Viridis&apos;), marker = list(size = 3.5, color = ~c, colorscale = &apos;Greens&apos;, cmin = -20, cmax = 50)) data2 &lt;- prcomp(data %&gt;% dplyr::select(x, y, z))
summary(data2)
## Importance of components:
## PC1 PC2 PC3
## Standard deviation 18.0494 10.1375 9.8547
## Proportion of Variance 0.6198 0.1955 0.1847
## Cumulative Proportion 0.6198 0.8153 1.0000 p2 &lt;- plot_ly(predict(data2) %&gt;% as.data.frame, x = ~PC1, y = ~PC2, z = 1, type = &apos;scatter3d&apos;, mode = &apos;lines+markers&apos;, line = list(width = 6, color = ~c, colorscale = &apos;Viridis&apos;), marker = list(size = 3.5, color = ~c, colorscale = &apos;Greens&apos;, cmin = -20, cmax = 50)) htmltools::tagList(list(p1, p2))</code></pre>

