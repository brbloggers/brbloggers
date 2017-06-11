+++
title = "Diagramas de Venn em R"
date = "2017-04-29 20:26:00"
categories = ["curso-r"]
+++

<p class="text-muted text-uppercase mb-small text-right">
Por <a href="http://curso-r.com/author/fernando">Fernando</a> 29/04/2017
</p>
<p>
Diagramas de Venn são como slides de PowerPoint. Se eles tem poucos
elementos concisos em uma ordem inteligente, um leitor consegue conectar
as ideias expostas e aprender alguma coisa. Em caso contrário, o excesso
de informação se transforma em um obstáculo para a comunicação.
</p>
<p>
Bons diagramas de Venn são capazes de te fazer perceber cruzamentos que
não estão no seu radar.
<a href="http://andrewgelman.com/2006/03/29/the_serenity_pr/">No blog do
Andrew Gelman</a> tem um exemplo interessante. Ele considera uma oração,
em inglês, que pede:
</p>
<blockquote>
<p>
God give me the serenity to accept things which cannot be changed; Give
me courage to change things which must be changed; And the wisdom to
distinguish one from the other.
</p>
</blockquote>
<p>
Pelo jeito em que ela foi escrita, parece que só existem dois tipos de
coisas: aquelas que não podem ser modificadas e aquelas que nós devemos
mudar. Entretanto, esse não é o caso:
</p>
<ul>
<li>
Se uma coisa pode ser modificada e eu não devo mudá-la, ela não é
importante.
</li>
<li>
Se uma coisa coisa não pode ser modificada e eu devo mudá-la, eu preciso
aceitá-la.
</li>
</ul>
<p>
<img src="http://curso-r.com/blog/2017-04-29-diagramas-de-venn_files/figure-html/unnamed-chunk-1-1.png" width="672">
</p>
<p>
Considerando esse diagrama, O Gelman até sugere uma prece mais
cuidadosa:
</p>
<blockquote>
<p>
Lord, grant me the serenity to accept things that cannot be changed,
courage to change things that must be changed; discernment to ignore
things that don’t need changing; acceptance that some things I need to
change, i can’t; And the wisdom to understand Venn Diagrams.
</p>
</blockquote>
<p>
A despeito da utilidade de Diagramas de Venn bem feitos, o R oferece
poucas maneiras de construí-los. No CRAN, existem apenas três pacotes
especializados em construir esses gráficos, mas duas delas são um pouco
insatisfatórias. Neste post, vamos descobrir como fazer diagramas de
Venn usando o pacote <code>VennDiagram</code>.
</p>
<p>
Para não nos distrairmos com bases de dados complicadas, vamos usar uma
tabela artifical inspirada
<a href="https://rstudio-pubs-static.s3.amazonaws.com/13301_6641d73cfac741a59c0a851feb99e98b.html">nesse
link</a>. Cada linha dessa base representa as preferências por animais
de estimação de uma pessoa hipotética. No total temos 34 pessoas na base
e as opções possíveis são “Cães”,“Gatos”,“Lagartos” e “Serpentes”.
</p>
<p>
O data.frame está disponível no código fonte desse post.
</p>

<p>
Codificar os gráficos no pacote <code>VennDiagram</code> é um pouco
chato, por isso vamos precisar de outros pacotes pra ajudar. No geral,
apenas as coisas do <code>tidyverse</code> já vão servir.
</p>
<p>
O comando abaixo chama os pacotes que vamos usar neste post.
</p>
<pre class="r"><code>library(VennDiagram)
library(tidyverse)</code></pre>

<p>
Como eu já disse antes, esse pacote é bem chato, pois em todos os
gráficos você precisa escrever diretamente o número de elementos em cada
pedaço dos conjuntos e os parâmetros gráficos detalhados demais. Pra
funcionar bem, você tem que dizer exatamente o que quer fazer.
</p>
<p>
Vamos começar fazendo um diagrama simples. Ele vai representar o
conjunto de pessoas que gostam de cachorros.
</p>
<pre class="r"><code>numero_de_pessoas_que_gostam_de_cachorros &lt;- dataset %&gt;% dplyr::filter(Dog == 1) %&gt;% nrow() grid.newpage()
invisible(draw.single.venn(numero_de_pessoas_que_gostam_de_cachorros, #N&#xFA;mero de elementos do conjunto category = &quot;Pessoas que gostam de cachorros&quot;, #Nome do conjunto lty = &quot;blank&quot;, #Grossura da borda dos conjuntos.&quot;blank&quot; quer dizer que n&#xE3;o vai ter borda fill = &quot;light blue&quot;, #Cor do conjunto alpha = 0.5 #Transpar&#xEA;ncia do conjunto. Varia de 0 a 1 ))</code></pre>
<p>
<img src="http://curso-r.com/blog/2017-04-29-diagramas-de-venn_files/figure-html/unnamed-chunk-4-1.png" width="480">
</p>
<p>
Complicando um pouco mais, dessa vez vamos fazer um diagrama que
represente as pessoas que gostam de gatos ou de cachorros.
</p>
<pre class="r"><code>numero_de_pessoas_que_gostam_de_cachorros &lt;- dataset %&gt;% dplyr::filter(Dog == 1) %&gt;% nrow() numero_de_pessoas_que_gostam_de_gatos &lt;- dataset %&gt;% dplyr::filter(Cat == 1) %&gt;% nrow() numero_de_pessoas_que_gostam_de_gatos_e_de_cachorros &lt;- dataset %&gt;% dplyr::filter(Dog == 1 &amp; Cat == 1) %&gt;% nrow() grid.newpage()
invisible(draw.pairwise.venn(area1 = numero_de_pessoas_que_gostam_de_cachorros, #N&#xFA;mero de elementos da primeira categoria area2 = numero_de_pessoas_que_gostam_de_gatos, #N&#xFA;mero de elementos da segunda categoria cross.area = numero_de_pessoas_que_gostam_de_gatos_e_de_cachorros, #N&#xFA;mero de elementos na intersec&#xE7;&#xE3;o category = c(&quot;Pessoas que gostam\nde cachorros&quot;, &quot;Pessoas que gostam\nde gatos&quot;), #Nome das categorias lty = c(&quot;blank&quot;, &quot;blank&quot;), #Grossura das bordas fill = c(&quot;light blue&quot;, &quot;pink&quot;), #Cores das bordas alpha = c(0.5, 0.5), #Transpar&#xEA;ncia das bordas cat.pos = c(0, 0), #Posi&#xE7;&#xE3;o dos t&#xED;tulos com rela&#xE7;&#xE3;o aos c&#xED;rculos. 0 quer dizer &quot;em cima&quot; scaled = F #Constr&#xF3;i as &#xE1;reas sem escala ))</code></pre>
<p>
<img src="http://curso-r.com/blog/2017-04-29-diagramas-de-venn_files/figure-html/unnamed-chunk-5-1.png" width="480">
</p>
<p>
A falta de escalas deixou esse gráfico simétrico e esteticamente
agradável. Entretanto, em algumas situações é mais legal representar os
conjuntos em escala.
</p>
<pre class="r"><code>numero_de_pessoas_que_gostam_de_cachorros &lt;- dataset %&gt;% dplyr::filter(Dog == 1) %&gt;% nrow() numero_de_pessoas_que_gostam_de_serpentes &lt;- dataset %&gt;% dplyr::filter(Snake == 1) %&gt;% nrow() numero_de_pessoas_que_gostam_de_cachorros_e_de_serpentes &lt;- dataset %&gt;% dplyr::filter(Dog == 1 &amp; Snake == 1) %&gt;% nrow() grid.newpage()
invisible(draw.pairwise.venn(area1 = numero_de_pessoas_que_gostam_de_cachorros, #N&#xFA;mero de elementos da primeira categoria area2 = numero_de_pessoas_que_gostam_de_serpentes, #N&#xFA;mero de elementos da segunda categoria cross.area = numero_de_pessoas_que_gostam_de_cachorros_e_de_serpentes, #N&#xFA;mero de elementos na intersec&#xE7;&#xE3;o category = c(&quot;Pessoas que gostam\nde cachorros&quot;, &quot;Pessoas que gostam\nde serpentes&quot;), #Nome das categorias lty = c(&quot;blank&quot;, &quot;blank&quot;), #Grossura das bordas fill = c(&quot;light blue&quot;, &quot;light green&quot;), #Cores das bordas alpha = c(0.5, 0.5), #Transpar&#xEA;ncia das bordas cat.pos = c(0, 0), #Posi&#xE7;&#xE3;o dos t&#xED;tulos com rela&#xE7;&#xE3;o aos c&#xED;rculos. 0 quer dizer &quot;em cima&quot; scaled = T #Constr&#xF3;i as &#xE1;reas sem escala ))</code></pre>
<p>
<img src="http://curso-r.com/blog/2017-04-29-diagramas-de-venn_files/figure-html/unnamed-chunk-6-1.png" width="480">
</p>
<p>
Até aqui tudo vai mais ou menos bem, mas a coisa fica bem mais chata
quando você precisa representar um diagrama com três conjuntos. Você vai
precisar passar pra função o tamanho de todos os pedacinhos.
</p>
<pre class="r"><code>numero_de_pessoas_que_gostam_de_gatos &lt;- dataset %&gt;% dplyr::filter(Cat == 1) %&gt;% nrow() numero_de_pessoas_que_gostam_de_serpentes &lt;- dataset %&gt;% dplyr::filter(Snake == 1) %&gt;% nrow() numero_de_pessoas_que_gostam_de_lagartos &lt;- dataset %&gt;% dplyr::filter(Lizard == 1) %&gt;% nrow() numero_de_pessoas_que_gostam_de_gatos_e_de_serpentes &lt;- dataset %&gt;% dplyr::filter(Cat == 1 &amp; Snake == 1) %&gt;% nrow() numero_de_pessoas_que_gostam_de_gatos_e_de_lagartos &lt;- dataset %&gt;% dplyr::filter(Cat == 1 &amp; Lizard == 1) %&gt;% nrow() numero_de_pessoas_que_gostam_de_serpentes_e_de_lagartos &lt;- dataset %&gt;% dplyr::filter(Lizard == 1 &amp; Snake == 1) %&gt;% nrow() numero_de_pessoas_que_gostam_de_serpentes_e_lagartos_e_gatos &lt;- dataset %&gt;% dplyr::filter(Lizard == 1 &amp; Snake == 1 &amp; Cat == 1) %&gt;% nrow() grid.newpage()
invisible(draw.triple.venn(area1 = numero_de_pessoas_que_gostam_de_gatos, area2 = numero_de_pessoas_que_gostam_de_serpentes, area3 = numero_de_pessoas_que_gostam_de_lagartos, n12 = numero_de_pessoas_que_gostam_de_gatos_e_de_serpentes, n23 = numero_de_pessoas_que_gostam_de_serpentes_e_de_lagartos, n13 = numero_de_pessoas_que_gostam_de_gatos_e_de_lagartos, n123 = numero_de_pessoas_que_gostam_de_serpentes_e_lagartos_e_gatos, category = c(&quot;Gatos&quot;, &quot;Serpentes&quot;, &quot;Lagartos&quot;), lty = &quot;blank&quot;, fill = c(&quot;light blue&quot;, &quot;green&quot;, &quot;light green&quot;), cat.pos = c(45,45,45), scaled = T))</code></pre>
<p>
<img src="http://curso-r.com/blog/2017-04-29-diagramas-de-venn_files/figure-html/unnamed-chunk-7-1.png" width="480">
</p>

