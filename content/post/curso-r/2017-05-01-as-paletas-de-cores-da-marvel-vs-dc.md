+++
title = "As cores da Marvel vs DC"
date = "2017-05-01 20:26:00"
categories = ["curso-r"]
+++

<p>
A cor é uma diferença notável entre os filmes da Marvel e da DC.
Enquanto a Disney/Marvel Studios costuma lançar filmes com tons mais
claros e alegres, a Warner tem optado por cenários escuros, com um
aspecto mais sombrios. Essas escolhas são um reflexo do clima das
histórias de cada universo: aventuras engraçaralhas com um drama
superficial vs seja lá o que passa na cabeça do
<a href="http://retalhoclub.com.br/wp-content/uploads/2017/03/03.jpg">Zack
Snyder</a>.
</p>
<p>
Para estudar melhor a paleta de cores utilizadas nos filmes, vamos
aplicar a análise introduzida pelo Dani
<a href="http://curso-r.com/blog/2017/04/22/2017-04-21-paleta-de-cores/">neste
post</a>, com pequenas alterações. Como amostra, selecionei 10 imagens
de Batman vs Superman e 10 do Capitão América: guerra civil. Tentando
deixar a análise o menos subjetiva possível, escolhi imagens de cenas
emblemáticas e dos principais personagens. Abaixo as imagens que peguei
de cada filme.
</p>
<p>
<img src="http://curso-r.com/blog/2017-05-01-as-paletas-de-cores-da-marvel-vs-dc_files/figure-html/unnamed-chunk-1-1.png" width="768">
</p>
<p>
<img src="http://curso-r.com/blog/2017-05-01-as-paletas-de-cores-da-marvel-vs-dc_files/figure-html/unnamed-chunk-2-1.png" width="768">
</p>
<p>
Seguindo a análise do Dani, vamos utilizar as seguintes bibliotecas para
a análise.
</p>
<pre class="r"><code>library(jpeg)
library(tidyverse)
library(glue)</code></pre>
<p>
Eu salvei as imagens em arquivos do tipo “bvs\_n.jpg” e “cw\_n.jpg”, com
n variando de 1 a 10. Isso facilitou a leitura desses arquivos. O código
abaixo mostra como criar um vetor com o caminho das 10 imagens de cada
filme. Se você quiser saber mais sobre a função <code>glue()</code>,
visite
<a href="http://curso-r.com/blog/2017/04/17/2017-04-08-glue/">este
post</a>.
</p>
<pre class="r"><code>arquivos_bvs &lt;- glue(&quot;images/bvs_{n}.jpg&quot;, n = 1:10)
arquivos_cw &lt;- glue(&quot;images/cw_{n}.jpg&quot;, n = 1:10)</code></pre>
<p>
Como vamos trabalhar com mais de uma imagem, eu criei a função
<code>ler\_imagem()</code> para ler os arquivos.
</p>
<pre class="r"><code>ler_imagem &lt;- function(caminho) { img &lt;- readJPEG(caminho) %&gt;% apply(3, as.numeric) }</code></pre>
<p>
Podemos então usar a função <code>map()</code> para aplicá-la a todos os
10 arquivos. A função <code>reduce(rbind)</code> transforma as 10
matrizes de pixels em uma matriz só, como se as imagens estivessem
coladas uma embaixo da outra.
</p>
<pre class="r"><code>img_bvs &lt;- map(arquivos_bvs, ler_imagem) %&gt;% reduce(rbind)
img_cw &lt;- map(arquivos_cw, ler_imagem) %&gt;% reduce(rbind)</code></pre>
<p>
Abaixo estão as funções <code>cria\_paleta()</code> e
<code>exibir()</code> do post do Dani. A única diferença aqui é que a
função <code>cria\_paleta()</code> já recebe a matriz representando a
imagem.
</p>
<pre class="r"><code>criar_paleta &lt;- function(img_matrix, num_cores){ km &lt;- kmeans(img_matrix, centers = num_cores) img_df &lt;- tibble( r = img_matrix[,1], g = img_matrix[,2], b = img_matrix[,3], cluster = km$cluster ) centroides &lt;- img_df %&gt;% group_by(cluster) %&gt;% summarise_all(mean) centroides &lt;- centroides %&gt;% mutate(cor = rgb(r, g, b)) sort(centroides$cor)
} exibir &lt;- function(x) { n &lt;- length(x) old &lt;- par(mar = c(0.5, 0.5, 0.5, 0.5)) on.exit(par(old)) image(1:n, 1, as.matrix(1:n), col = x, ylab = &quot;&quot;, xaxt = &quot;n&quot;, yaxt = &quot;n&quot;, bty = &quot;n&quot;)
}
</code></pre>
<p>
Assim, basta aplicar essas funções aos objetos <code>img\_bvs</code> e
<code>img\_cw</code> para obter as paletas. Primeiro para o Batman vs
Superman:
</p>
<pre class="r"><code>paleta_bvs &lt;- criar_paleta(img_bvs, 10)
exibir(paleta_bvs)</code></pre>
<p>
<img src="http://curso-r.com/blog/2017-05-01-as-paletas-de-cores-da-marvel-vs-dc_files/figure-html/unnamed-chunk-9-1.png" width="768">
</p>
<p>
E agora para o Capitão América:
</p>
<pre class="r"><code>paleta_cw &lt;- criar_paleta(img_cw, 10)
exibir(paleta_cw)</code></pre>
<p>
<img src="http://curso-r.com/blog/2017-05-01-as-paletas-de-cores-da-marvel-vs-dc_files/figure-html/unnamed-chunk-11-1.png" width="768">
</p>
<p>
Observe que o filme da DC tem cores mais escuras e fortes, com vários
tons de azul, indicando as cenas noturnas e de chuva. Já a paleta da
Marvel apresenta cores mais claras, com vários tons representando o céu
pálido das cenas externas.
</p>
<p>
Podemos fazer a análise agora para o pôster de cada filme (o que aparece
no IMDB):
</p>
<p>
<img src="http://curso-r.com/blog/2017-05-01-as-paletas-de-cores-da-marvel-vs-dc_files/figure-html/unnamed-chunk-12-1.png" width="768">
</p>
<pre class="r"><code>img_bvs &lt;- ler_imagem(&quot;images/bvs_poster.jpg&quot;)
paleta_bvs &lt;- criar_paleta(img_bvs, 10)
exibir(paleta_bvs)</code></pre>
<p>
<img src="http://curso-r.com/blog/2017-05-01-as-paletas-de-cores-da-marvel-vs-dc_files/figure-html/unnamed-chunk-14-1.png" width="768">
</p>
<pre class="r"><code>img_cw &lt;- ler_imagem(&quot;images/cw_poster.jpg&quot;)
paleta_cw &lt;- criar_paleta(img_cw, 10)
exibir(paleta_cw)</code></pre>
<p>
<img src="http://curso-r.com/blog/2017-05-01-as-paletas-de-cores-da-marvel-vs-dc_files/figure-html/unnamed-chunk-16-1.png" width="768">
</p>
<p>
Veja que os diferentes tons de azul se repete no pôster do Batman vs
Superman. Já o pôster do Capitão América é bem cinzento, com metade da
paleta representando
<a href="http://media.melty.com.br/article-6991-ratio265_1020/filme-50-tons-de-cinza-jamie-dornan-christian.jpg">tons
de cinza</a>.
</p>
<p>
Fica então o desafio de repetir a análise para outros filmes e
compartilhar o resultado com a gente. Comentários? Sugestões? Críticas?
Mande a sua opinião!
</p>

