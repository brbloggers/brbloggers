+++
title = "Criando paletas de cores a partir imagens no R"
date = "2015-09-28"
categories = ["dfalbel"]
original_url = "http://dfalbel.github.io/2015/09/paleta-de-cores-img.html"
+++

<article class="post-content">
<p>
Recentemente eu quis obter as cores predominantes de uma foto para
usá-las em um gráfico que estava fazendo. Acabei achando o problema
interessante: não é óbvio determinar uma maneira de encontrar as cores
distintas, porém predominantes, em uma imagem.
</p>
<p>
Então, fiz um pacote do R que lê uma imagem em
<code class="highlighter-rouge">jpeg</code> e cria uma paleta de cores
baseada nesta imagem. Abaixo mostro um exemplo, em seguida explico
rapidamente como o algoritmo funciona.
</p>
<p>
O pacote é instalado utilizando
<code class="highlighter-rouge">devtools::install\_github('dfalbel/paletaCores')</code>.
Em seguida, você pode obter a paleta da seguinte maneira.
</p>
<p>
<img src="https://vice-images.vice.com/images/content-images/2015/09/09/mick-rock-tk-body-image-1441819666.jpg?resize=*:*&amp;output-quality=" alt="david-bowie">
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">suppressPackageStartupMessages</span><span class="p">(</span><span class="n">library</span><span class="p">(</span><span class="n">paletaCores</span><span class="p">))</span><span class="w">
</span><span class="n">cores</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">criar_paleta</span><span class="p">(</span><span class="s2">&quot;../images/david bowie.jpeg&quot;</span><span class="p">)</span><span class="w">
</span><span class="n">cores</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## [1] &quot;#4B69A9&quot; &quot;#B52F25&quot; &quot;#240C4C&quot; &quot;#D58E5D&quot; &quot;#EBDCC6&quot;</code></pre>
</figure>
<p>
Esse código retorna um vetor de cores, que pode ser exibido usando a
função exibir que acompanha o pacote
<code class="highlighter-rouge">paletaCores</code>.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">exibir</span><span class="p">(</span><span class="n">cores</span><span class="p">)</span></code></pre>
</figure>
<p>
<img src="http://dfalbel.github.io/images/2015-09-28-paleta-de-cores-img/unnamed-chunk-2-1.png" alt="plot of chunk unnamed-chunk-2">
</p>
<p>
A primeiro passo que é necessário entender é como uma imagem é
interpretada pelo <code class="highlighter-rouge">R</code>. O pacote
<code class="highlighter-rouge">paletaCores</code> possui uma função,
que não é exportada, que serve para ler uma imagem.
</p>
<p>
A imagem no <code class="highlighter-rouge">R</code> é representada por
um <code class="highlighter-rouge">data.frame</code> com o seguinte
formato:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">img</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">paletaCores</span><span class="o">:::</span><span class="n">ler</span><span class="p">(</span><span class="s2">&quot;../images/david bowie.jpeg&quot;</span><span class="p">)</span><span class="w">
</span><span class="n">head</span><span class="p">(</span><span class="n">img</span><span class="p">,</span><span class="w"> </span><span class="n">n</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">5</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## x y r g b cor id
## 1 1 750 0.2352941 0.5333333 0.5843137 #3C8895 1
## 2 1 749 0.2627451 0.5568627 0.5372549 #438E89 2
## 3 1 748 0.2941176 0.5843137 0.5960784 #4B9598 3
## 4 1 747 0.2509804 0.5372549 0.5607843 #40898F 4
## 5 1 746 0.2470588 0.5411765 0.5647059 #3F8A90 5</code></pre>
</figure>
<p>
Ou seja, é um <code class="highlighter-rouge">data.frame</code> que
mapeia cada pixel, identificado por sua coordenada
<code class="highlighter-rouge">x,y</code> a uma cor que é identificada
pela trípla de valores <code class="highlighter-rouge">rgb</code>.
</p>
<p>
Então como separar as cores mais importantes e diferentes entre si da
imagem? Aqui usamos a técnica de clusterização conhecida como kmeans. As
variáveis utilizadas foram cada atributo da cor dos píxels:
<code class="highlighter-rouge">r</code>,
<code class="highlighter-rouge">g</code> e
<code class="highlighter-rouge">b</code>.
</p>
<p>
Veja o código da função
<code class="highlighter-rouge">criar\_paleta</code>.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">paletaCores</span><span class="o">::</span><span class="n">criar_paleta</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## function (img, n = 5) ## {
## foto &lt;- ler(img)
## cluster &lt;- kmeans(x = foto %&gt;% dplyr::select(r, g, b), centers = n)
## foto$grupo &lt;- cluster$cluster
## grupos &lt;- foto %&gt;% dplyr::group_by(grupo) %&gt;% dplyr::summarise(r = mean(r), ## g = mean(g), b = mean(b)) %&gt;% dplyr::mutate(cor = rgb(r, ## g, b))
## return(grupos$cor)
## }
## &lt;environment: namespace:paletaCores&gt;</code></pre>
</figure>
<p>
Utilizamos, em seguida, a cor representada pelo centróide de cada
cluster criado como cor da paleta.
</p>
<p>
<img src="http://dfalbel.github.io/images/2015-09-28-paleta-de-cores-img/praia.jpg" alt="praia">
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">criar_paleta</span><span class="p">(</span><span class="s2">&quot;../images/2015-09-28-paleta-de-cores-img/praia.jpg&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">exibir</span></code></pre>
</figure>
<p>
<img src="http://dfalbel.github.io/images/2015-09-28-paleta-de-cores-img/unnamed-chunk-5-1.png" alt="plot of chunk unnamed-chunk-5">
</p>
<p>
<img src="http://dfalbel.github.io/images/2015-09-28-paleta-de-cores-img/vulcao.jpeg" alt="vulcao">
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">criar_paleta</span><span class="p">(</span><span class="s2">&quot;../images/2015-09-28-paleta-de-cores-img/vulcao.jpeg&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">exibir</span></code></pre>
</figure>
<p>
<img src="http://dfalbel.github.io/images/2015-09-28-paleta-de-cores-img/unnamed-chunk-6-1.png" alt="plot of chunk unnamed-chunk-6">
</p>
</article>

