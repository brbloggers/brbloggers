+++
title = "Pacote reticulate"
date = "2017-11-20 11:25:00"
categories = ["curso-r"]
original_url = "http://curso-r.com/blog/2017/11/20/2017-11-20-reticulate/"
+++

<div id="post-content">
<blockquote>
<p>
Se você também quiser escrever um post como convidada, entre em contato
a gente em <a href="mailto:contato@curso-r.com">contato@curso-r.com</a>!
</p>
</blockquote>
<p>
Imagine se você pudesse aproveitar da quantidade e da variedade enorme
de módulos e bibliotecas do Python no ambiente amigável do RStudio?
Graças ao pacote
<a href="https://rstudio.github.io/reticulate/"><code>reticulate</code></a>
isso é possível de uma maneira familiar para quem quem já é usuário do
R.
</p>
<p>
O <code>reticulate</code> é um pacote que proporciona a integração
Python & R via R e pode ser bastante útil se você quiser fazer todas as
análises no ambiente do Rstudio. Os módulos, classes e funções do Python
importados podem ser utilizados como se fossem funções nativas do R.
</p>
<p>
Para utilizar o pacote são necessárias a instalação do Python com versão
superior a 2.7, a instalação dos módulos do Python que serão utilizados
durante a análise e a instalação do pacote via
<code>install.packages()</code>.
</p>
<pre class="r"><code># install.packages(&quot;reticulate&quot;)
library(reticulate)</code></pre>
<p>
Quando for utilizada uma função do Python em um objeto do R, ele será
convertido para seu formato equivalente do Python e vice-versa. Os tipos
de conversões de objetos são explicitadas
<a href="https://rstudio.github.io/reticulate/articles/introduction.html">neste
link</a>.
</p>
<pre class="r"><code>## Data frame do R &#xE9; convertido em Dict do Python
a &lt;- r_to_py(mtcars)
class(a)
## [1] &quot;python.builtin.dict&quot; &quot;python.builtin.object&quot; ## Dict do Python &#xE9; convertido em List do R
class(py_to_r(a))
## [1] &quot;list&quot;</code></pre>

<div id="importando-modulos" class="section level2">
<p>
A importação de módulos do Python para o R é bem simples. Basta usar a
função <code>import()</code> do pacote <code>reticulate</code> e o nome
do módulo que você quer importar, em seguida guardar isso em um objeto
no R.
</p>
<pre class="r"><code>np &lt;- import(&quot;numpy&quot;)
pandas &lt;- import(&quot;pandas&quot;)
os &lt;- import(&quot;os&quot;)</code></pre>
<p>
Use a função <code>py\_module\_available()</code> pra checar se um
módulo do Python está disponível no seu computador.
</p>
<pre class="r"><code>py_module_available(&quot;matplotlib&quot;)
## [1] TRUE</code></pre>
<p>
As funções que estão dentro de módulos ou classes do Python podem ser
acessadas utilizando o operador
<code>$&lt;/code&gt;:&lt;/p&gt; &lt;pre class="r"&gt;&lt;code&gt;os$getcwd()
\#\# \[1\] "/home/jtrecenti/curso-r/site/content/blog"
np$abs(-1) \#\# \[1\] 1&lt;/code&gt;&lt;/pre&gt; &lt;p&gt;E podemos misturar fun&\#xE7;&\#xF5;es do R e do python:&lt;/p&gt; &lt;pre class="r"&gt;&lt;code&gt;library(magrittr) rnorm(10) %&gt;% np$abs()
%&gt;% np*c**u**m**p**r**o**d**u**c**t*()download\_file(url, cache=TRUE)
fits$info(im.file)&lt;/code&gt;&lt;/pre&gt; &lt;pre&gt;&lt;code&gt;Filename: ~/.astropy/cache/download/py2/2c9202ae878ecfcb60878ceb63837f5f No. Name Ver Type Cards Dimensions Format 0 PRIMARY 1 PrimaryHDU 161 (891, 893) int16 1 er.mask 1 TableHDU 25 1600R x 4C \[F6.2, F6.2, F6.2, F6.2\]&lt;/code&gt;&lt;/pre&gt; &lt;p&gt;Agora vamos transformar nossa imagem em uma matriz de pixels e plotar com a fun&\#xE7;&\#xE3;o image do R.&lt;/p&gt; &lt;pre class="r"&gt;&lt;code&gt;im.data &lt;- fits$getdata(im.file)
im.data %&gt;% t() %&gt;% image(col = gray(seq(0, 1, length =
256)))</code>
</pre>
<p>
<img src="http://curso-r.com/blog/2017-11-20-reticulate_files/figure-html/unnamed-chunk-9-1.png" width="672">
</p>
</div>
</div>

