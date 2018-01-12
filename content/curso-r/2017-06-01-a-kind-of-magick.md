+++
title = "A kind of magick"
date = "2017-06-01 20:26:00"
categories = ["curso-r"]
original_url = "http://curso-r.com/blog/2017/06/01/2017-06-01-a-kind-of-magick/"
+++

<p class="text-muted text-uppercase mb-small text-right">
Por <a href="http://curso-r.com/author/william">William</a> 01/06/2017
</p>
<p>
Já vimos como o Rstudio se torna uma ferramenta poderosa quando
combinado com certos pacotes, como o <code>knitr</code> e
<code>shiny</code>, ou outros recursos, como o <em>markdown</em> e o
<em>git</em>. Hoje, veremos como transformar o Rstudio num elegante e
interativo editor de imagens utilizando o pacote <code>magick</code>.
</p>
<p>
Este <em>post</em> é um breve resumo das funcionalidades do
<code>magick</code>. Para uma apresentação completa, visite o
<a href="https://cran.r-project.org/web/packages/magick/vignettes/intro.html">vignette
do pacote</a>.
</p>
<p>
Já usamos o magick em outros posts do blog (às vezes por trás das
cortinas) para tratar imagens. Esse pacote é um <em>wrapper</em> da
biblioteca
<a href="https://www.imagemagick.org/Magick++/STL.html">ImageMagick</a>,
provavelmente a biblioteca <em>open-source</em> para processamento de
imagens mais amigável disponível hoje em dia.
</p>
<p>
No Windows ou OS-X, instale via CRAN:
</p>
<pre class="r"><code>install.packages(&quot;magick&quot;)</code></pre>
<p>
No Linux, consulte o
<a href="https://cran.r-project.org/web/packages/magick/vignettes/intro.html#build_from_source">vignette
do Magick</a> para mais informações.
</p>

<p>
Para começar a usar as funções do <code>magick</code>, carregue o
pacote.
</p>
<pre class="r"><code>library(magick)
## Linking to ImageMagick 6.8.9.9
## Enabled features: cairo, fontconfig, freetype, fftw, lcms, pango, rsvg, x11
## Disabled features: ghostscript, webp
library(magrittr)</code></pre>
<p>
Vamos utilizar a seguinte imagem como exemplo neste post:
</p>
<p>
<img src="http://curso-r.com/blog/2017-06-01-a-kind-of-magick_files/figure-html/unnamed-chunk-3-1.png" width="768">
</p>
<p>
A função <code>image\_read()</code> lê imagens de arquivos, como
<code>.jpg</code> ou <code>png</code>. Diversas outras extensões são
suportadas. Utilize <code>str(magick::magick\_config())</code> para
verificar quais formatos estão disponíveis na sua versão do ImageMagick.
</p>
<pre><code>## format width height colorspace filesize
## 1 JPEG 2745 1780 sRGB 662239</code></pre>
<p>
A função <code>image\_write()</code> exporta imagens em qualquer um dos
formatos suportados.
</p>
<pre class="r"><code>image_write(freddie, path = &quot;freddie_png.png&quot;, format = &quot;png&quot;)</code></pre>
<p>
<strong>Dica</strong>: no Rstudio, pasta rodar o objeto
<code>freddie</code> para visualizar a imagem no painel <em>Viewer</em>.
</p>

<p>
Ao ler uma imagem com o magick, ela é guardada em memória em seu formato
original. Para converter essa imagem, utilizamos a função
<code>image\_convert()</code>.
</p>
<pre class="r"><code>freddie_png &lt;- image_convert(freddie, &quot;png&quot;)
image_info(freddie_png)
## format width height colorspace filesize
## 1 PNG 2745 1780 sRGB 0</code></pre>
<p>
Neste ponto você já deve ter reparado que as (principais) funções do
pacote <code>magick</code> utilizam o prefixo <code>image\_</code>.
</p>

<p>
A maioria das transformações que você pode fazer com as imagens
utilizará um parâmetro <code>geometry</code>. Esse parâmetro requer uma
sintaxe especial, da forma AXB+C+D, sendo que cada elemento (A, B, C e
D) é opcional. Veja alguns exemplos:
</p>
<ul>
<li>
<code>image\_crop(image, "100x150+50+20")</code>: recorta uma região de
tamanho 100px x 150px, começando +50px da esquerda para a direita e
+20px de cima para baixo;
</li>
<li>
<code>image\_scale(image, "200")</code>: redimensiona proporcionalmente
ao comprimento: 200px;
</li>
<li>
<code>image\_scale(image, "x200")</code>: redimensiona proporcionalmente
à altura: 200px;
</li>
<li>
<code>image\_border(frink, "red", "20x10")</code>: adiciona uma borda de
20px (esquerda/direita) e 10px (cima/baixo)
</li>
</ul>
<p>
Para mais detalhes sobre essa sintaxe, consulte
<a href="http://www.imagemagick.org/Magick++/Geometry.html">este
link</a>.
</p>
<p>
Vamos testar essas funções na nossa imagem!
</p>
<p>
Começaremos a redimensionando para facilitar o uso e a visualização de
algumas funções.
</p>
<pre class="r"><code>freddie_resized &lt;- image_scale(freddie, &quot;500&quot;)
image_info(freddie_resized)
## format width height colorspace filesize
## 1 JPEG 500 324 sRGB 0</code></pre>
<p>
Agora, vamos recortar um pedaço.
</p>
<pre class="r"><code>image_crop(freddie_resized, &quot;100x150+280+30&quot;)</code></pre>
<p>
<img src="http://curso-r.com/blog/2017-06-01-a-kind-of-magick_files/figure-html/unnamed-chunk-9-1.png" width="384">
</p>
<p>
Colocar uma borda.
</p>
<pre class="r"><code>image_border(freddie_resized, &quot;purple&quot;, &quot;20x10&quot;)</code></pre>
<p>
<img src="http://curso-r.com/blog/2017-06-01-a-kind-of-magick_files/figure-html/unnamed-chunk-11-1.png" width="768">
</p>
<p>
Girá-la de ponta-cabeça.
</p>
<pre class="r"><code>image_flip(freddie_resized)</code></pre>
<p>
<img src="http://curso-r.com/blog/2017-06-01-a-kind-of-magick_files/figure-html/unnamed-chunk-13-1.png" width="768">
</p>
<p>
E inverter a direção.
</p>
<pre class="r"><code>image_flop(freddie_resized)</code></pre>
<p>
<img src="http://curso-r.com/blog/2017-06-01-a-kind-of-magick_files/figure-html/unnamed-chunk-15-1.png" width="768">
</p>
<p>
Com o pipe, fica fácil aplicar todas as funções ao mesmo tempo.
</p>
<pre class="r"><code>freddie_resized %&gt;% image_crop(&quot;100x150+280+30&quot;) %&gt;% image_border(&quot;purple&quot;, &quot;20x10&quot;) %&gt;% image_flip %&gt;% image_flop</code></pre>
<p>
<img src="http://curso-r.com/blog/2017-06-01-a-kind-of-magick_files/figure-html/unnamed-chunk-17-1.png" width="384">
</p>

<p>
Agora vamos aplicar alguns filtros e efeitos.
</p>
<pre class="r"><code>image_blur(freddie_resized, 10, 5)</code></pre>
<p>
<img src="http://curso-r.com/blog/2017-06-01-a-kind-of-magick_files/figure-html/unnamed-chunk-19-1.png" width="672">
</p>
<pre class="r"><code>image_noise(freddie_resized)</code></pre>
<p>
<img src="http://curso-r.com/blog/2017-06-01-a-kind-of-magick_files/figure-html/unnamed-chunk-21-1.png" width="672">
</p>
<pre class="r"><code>image_annotate(freddie_resized, &quot;Farrokh Bulsara&quot;, size = 30, color = &quot;red&quot;, boxcolor = &quot;white&quot;, degrees = 9, location = &quot;+60+30&quot;)</code></pre>
<p>
<img src="http://curso-r.com/blog/2017-06-01-a-kind-of-magick_files/figure-html/unnamed-chunk-23-1.png" width="672">
</p>

<p>
Realmente recomendamos uma leitura do Vignette do magick para ter uma
boa ideia de tudo o que ele permite fazer. Além de várias outras
ferramentas de edição para imagens estáticas, ainda é possível mexer com
GIFs e animações! Ou fazer coisas como:
</p>
<pre class="r"><code>library(ggplot2)
library(grid) qplot(speed, dist, data = cars, geom = c(&quot;point&quot;, &quot;smooth&quot;))
grid.raster(freddie_cropped, width = 0.15, height = 0.3, hjust = -2, vjust = 1)</code></pre>
<pre><code>## `geom_smooth()` using method = &apos;loess&apos; and formula &apos;y ~ x&apos;</code></pre>
<p>
<img src="http://curso-r.com/blog/2017-06-01-a-kind-of-magick_files/figure-html/unnamed-chunk-25-1.png" width="672">
</p>

