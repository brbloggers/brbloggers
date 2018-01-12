+++
title = "K-means e paleta de cores"
date = "2017-04-22 11:07:31"
categories = ["curso-r"]
original_url = "http://curso-r.com/blog/2017/04/22/2017-04-21-paleta-de-cores/"
+++

<p>
Uma aplicação interessante de algoritmos de clusterização é a obtenção
de paletas de cores a partir de imagens. Veja como isso pode ser feito
usando o R.
</p>
<p>
Em primeiro lugar, vamos ler a imagem como uma matriz para o R. Existem
diversas bibliotecas para carregar as imagens, vamos usar aqui a
<a href="https://cran.r-project.org/package=jpeg"><code>jpeg</code></a>.
Para esse caso ela é melhor porque já lê a imagem no formato que
precisamos.
</p>
<pre class="r"><code>library(jpeg)
library(magrittr)
img &lt;- readJPEG(&quot;img/david-bowie.jpg&quot;)</code></pre>
<p>
A imagem lida pelo pacote <code>jpeg</code> é representada por um
<code>array</code> com dimensões: <code>c(altura, largura,
n\_bandas)</code> que no nosso caso é <code>c(1100, 727, 3)</code>. O
número de bandas é 3: R, G e B.
</p>
<p>
Podemos exibir a imagem no R, convertendo o array, primeiro em um obheto
do tipo <code>raster</code> e depois simplesmente usando a função
<code>plot</code>.
</p>
<pre class="r"><code>plot(as.raster(img))</code></pre>
<img src="http://curso-r.com/blog/img/david-bowie.jpg" alt="">

<p>
O problema de obter a paleta de cores de uma imagem pode ser formulado
como um problema de clusterização: “obter grupos de individuos que
possuem a menor diferença dentro de cada um e a maior diferença possível
entre os grupos de acordo com algumas características das unidades
amostrais”.
</p>
<p>
Nesse caso, os indivíduos são os pixels da imagem e as características
que estamos interessados são os valores de R, de G e de B (valores que
representam a cor do pixel). Para o algortimos de clusterização,
precisamos de uma matriz com as 3 colunas R, G e B e largura\*altura
(numero de pixels) linhas representado os indivíduos. É exatamente essa
conversão que o trecho de código a seguir realiza.
</p>
<pre class="r"><code>img_matrix &lt;- apply(img, 3, as.numeric)</code></pre>
<p>
Agora temos uma matriz com 3 colunas e 799.700 linhas. Vamos aplicar
agora o algoritmo k-means, para organizar cada um desses pixels em um
grupo. O K-means pede o número de grupos como input, vamos começar com
6.
</p>
<pre class="r"><code>km &lt;- kmeans(img_matrix, centers = 6)</code></pre>
<p>
O objeto gerado pela função <code>kmeans</code> armazena um vetor
chamado <code>cluster</code> (do tamanho do número de linhas da matriz)
com um identificador do grupo de cada observação da matriz.
</p>
<p>
A cor que representa cada um dos grupos é representada pelo vetor c(r,
g, b) com a média de todas as observações de cada um dos grupos. Podemos
obter isso com algumas manipulações usando o <code>dplyr</code>.
</p>
<pre class="r"><code>library(tibble)
library(dplyr)
img_df &lt;- tibble( r = img_matrix[,1], g = img_matrix[,2], b = img_matrix[,3], cluster = km$cluster )
centroides &lt;- img_df %&gt;% group_by(cluster) %&gt;% summarise_all(mean)</code></pre>
<pre class="r"><code>centroides
## cluster r g b
## 1 1 0.2212872 0.27343576 0.4408807
## 2 2 0.5005334 0.18317885 0.1587987
## 3 3 0.8768478 0.76214788 0.6453526
## 4 4 0.7016480 0.46726975 0.3238780
## 5 5 0.3541833 0.46237840 0.5494459
## 6 6 0.1242676 0.04329523 0.2157608</code></pre>
<p>
Também transformamos uma cor r, g e b em uma representação hexadecimal.
Assim conseguimos um vetor de caracteres que representa a a paleta de
cores.
</p>
<pre class="r"><code>centroides &lt;- centroides %&gt;% mutate(cor = rgb(r, g, b))
centroides$cor
## [1] &quot;#384670&quot; &quot;#802F28&quot; &quot;#E0C2A5&quot; &quot;#B37753&quot; &quot;#5A768C&quot; &quot;#200B37&quot;</code></pre>
<p>
Para exibir a paleta vamos usar a seguinte função que foi copiada e
levemente modificada
<a href="https://github.com/karthik/wesanderson">daqui</a>
</p>
<pre class="r"><code>exibir &lt;- function(x) { n &lt;- length(x) old &lt;- par(mar = c(0.5, 0.5, 0.5, 0.5)) on.exit(par(old)) image(1:n, 1, as.matrix(1:n), col = x, ylab = &quot;&quot;, xaxt = &quot;n&quot;, yaxt = &quot;n&quot;, bty = &quot;n&quot;)
}
exibir(sort(centroides$cor))</code></pre>
<p>
<img src="http://curso-r.com/blog/2017-04-21-paleta-de-cores_files/figure-html/exibir-1.png" width="672">
</p>
<p>
Assim obtivemos uma paleta de cores da imagem que mostramos
anteriormente. Vamos colocar todo o código que fizemos passo a passo
aqui em uma única função para podermos facilmente criar a paleta de
cores para outras imagens.
</p>
<pre class="r"><code>criar_paleta &lt;- function(img, num_cores){ # transforma a imagem em uma matriz img_matrix &lt;- apply(img, 3, as.numeric) # treina o algoritmo de k m&#xE9;dias km &lt;- kmeans(img_matrix, centers = num_cores) img_df &lt;- tibble( r = img_matrix[,1], g = img_matrix[,2], b = img_matrix[,3], cluster = km$cluster ) # calcula os centroides dos grupos centroides &lt;- img_df %&gt;% group_by(cluster) %&gt;% summarise_all(mean) # transforma a cor em hexadecimal centroides &lt;- centroides %&gt;% mutate(cor = rgb(r, g, b)) # vetor de cores sort(centroides$cor)
}</code></pre>
<p>
Vejamos agora o que acontece com essa bela imagem do filme Moonrise
Kingdom do Wes Anderson, que é famoso por fazer filmes com belas paletas
de cores.
</p>
<pre class="r"><code>moonrise &lt;- readJPEG(&quot;img/moonrise-kingdom.jpg&quot;)
plot(as.raster(moonrise))</code></pre>
<img src="http://curso-r.com/blog/img/moonrise-kingdom.jpg" alt="">

<pre class="r"><code>paleta &lt;- criar_paleta(moonrise, 6)</code></pre>
<pre class="r"><code>exibir(paleta)</code></pre>
<p>
<img src="http://curso-r.com/blog/2017-04-21-paleta-de-cores_files/figure-html/paleta2-1.png" width="672">
</p>
<p>
É isso. Se você gostou, tente fazer com outras imagens e compartilhe com
a gente os resultados.
</p>

