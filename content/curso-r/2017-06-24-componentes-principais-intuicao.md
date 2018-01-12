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
Abaixo tem alguns gráficos em 3 dimensões que dão uma boa ilustração
sobre o que essas duas afirmativas querem dizer e, mesmo sendo um
exemplo simples, irão ajudar a extrapolar a ideia para problemas mais
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
As duas primeiras dimensões projetam os dados de forma que apresentam a
<strong>máxima a variância total</strong> possível em apenas duas
dimensões.
</li>
</ol>
<p>
<strong>pacotes para os exemplos</strong>
</p>
<pre class="r"><code>library(magrittr)
library(tidyr)
library(dplyr)</code></pre>
<p>
OBS: não esqueça de girar os gráficos! =)
</p>
<pre class="r"><code>a &lt;- 1
tetraedro &lt;- data.frame( x = c(a * sqrt(3)/3, - a * sqrt(3)/6, - a * sqrt(3)/6, 0), y = c(0, - a/2, a/2, 0), z = c(0, 0, 0, a * sqrt(6)/3), cor = c(&quot;a&quot;, &quot;b&quot;, &quot;c&quot;, &quot;d&quot;), id = 1:4) tetraedro_linhas &lt;- combn(x = tetraedro$id, m = 2) %&gt;% t %&gt;% as.data.frame.matrix %&gt;% set_names(c(&quot;id1&quot;, &quot;id2&quot;)) %&gt;% mutate(id_par = 1:n()) %&gt;% gather(id_ordem, id, id1, id2) %&gt;% left_join(tetraedro, by = &quot;id&quot;) %&gt;% arrange(id_ordem)</code></pre>
<p>
<strong>Contribuição dos componentes na variância total</strong>
</p>
<pre class="r"><code>tetraedro_pc &lt;- prcomp(tetraedro %&gt;% dplyr::select(x, y, z)) # PCA acontece aqui
knitr::kable(summary(tetraedro_pc)$importance)</code></pre>
<table>
<thead>
</thead>
<tbody>
<tr class="odd">
<td>
Standard deviation
</td>
<td>
0.4082483
</td>
<td>
0.4082483
</td>
<td>
0.4082483
</td>
</tr>
<tr class="even">
<td>
Proportion of Variance
</td>
<td>
0.3333300
</td>
<td>
0.3333300
</td>
<td>
0.3333300
</td>
</tr>
<tr class="odd">
<td>
Cumulative Proportion
</td>
<td>
0.3333300
</td>
<td>
0.6666700
</td>
<td>
1.0000000
</td>
</tr>
</tbody>
</table>
<p>
<strong>3 dimensões (100% da variância)</strong>
</p>
<pre class="r"><code>library(plotly) plot_ly(tetraedro_linhas, x = ~x, y = ~y, z = ~z) %&gt;% add_lines() %&gt;% add_markers()</code></pre>
<p>
<strong>2 dimensões (67% da variância)</strong>
</p>
<pre class="r"><code>tetraedro_pc_pred &lt;- tetraedro_pc %&gt;% predict %&gt;% as.data.frame
plot_ly(tetraedro_pc_pred, x = ~PC2, y = ~PC3, z = ~PC3) %&gt;% add_lines() %&gt;% add_markers()</code></pre>

<pre class="r"><code>x &lt;- c()
y &lt;- c()
z &lt;- c()
c &lt;- c() for (i in 1:62) { r &lt;- 20 * cos(i / 20) x &lt;- c(x, r * cos(i)) y &lt;- c(y, r * sin(i)) z &lt;- c(z, i) c &lt;- c(c, i)
} forma_legal &lt;- data.frame(x, y, z, c)</code></pre>
<p>
<strong>Contribuição dos componentes na variância total</strong>
</p>
<pre class="r"><code>forma_legal_pc &lt;- prcomp(forma_legal %&gt;% dplyr::select(x, y, z)) # PCA acontece aqui
knitr::kable(summary(forma_legal_pc)$importance)</code></pre>
<table>
<thead>
</thead>
<tbody>
<tr class="odd">
<td>
Standard deviation
</td>
<td>
18.04936
</td>
<td>
10.13750
</td>
<td>
9.854732
</td>
</tr>
<tr class="even">
<td>
Proportion of Variance
</td>
<td>
0.61975
</td>
<td>
0.19550
</td>
<td>
0.184750
</td>
</tr>
<tr class="odd">
<td>
Cumulative Proportion
</td>
<td>
0.61975
</td>
<td>
0.81525
</td>
<td>
1.000000
</td>
</tr>
</tbody>
</table>
<p>
<strong>3 dimensões (100% da variância)</strong>
</p>
<pre class="r"><code>plot_ly(forma_legal, x = ~x, y = ~y, z = ~z, type = &quot;scatter3d&quot;, mode = &quot;markers+lines&quot;, line = list(width = 6, color = ~c, colorscale = &apos;Viridis&apos;), marker = list(size = 3.5, color = ~c, colorscale = &apos;Greens&apos;, cmin = -20, cmax = 50))</code></pre>
<p>
<strong>2 dimensões (82% da variância)</strong>
</p>
<pre class="r"><code>forma_legal_pc_pred &lt;- forma_legal_pc %&gt;% predict %&gt;% as.data.frame
plot_ly(forma_legal_pc_pred, x = ~PC1, y = ~PC2, z = 1, type = &apos;scatter3d&apos;, mode = &apos;lines+markers&apos;, line = list(width = 6, color = ~c, colorscale = &apos;Viridis&apos;), marker = list(size = 3.5, color = ~c, colorscale = &apos;Greens&apos;, cmin = -20, cmax = 50))</code></pre>

