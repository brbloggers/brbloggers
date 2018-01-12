+++
title = "Criando relatórios com template tufle "
date = "2017-12-14"
categories = ["felippe-gomes"]
original_url = "https://gomesfellipe.github.io/post/2017-12-14-criando-relat%C3%B3rios-com-template-tufle/criando-relat%C3%B3rios-com-template-tufle/"
+++

<p>
Além da limpeza da base de dados, análises e aplicação de metodologias
estatísticas para a solução de problemas, escrever relatórios também é
uma tarefa indispensável e que ocupa bastante tempo do trabalho de um
estatístico.
</p>
<p>
como disse Gibran em algum momento; precisamos <em>transformar em
palavras aquilo que já conhecemos em pensamentos</em>. Ninguém quer
perder tempo precioso de análises em formatações de documentos.
</p>
<p>
Elaborar templates de relatórios é uma tarefa comum entre programadores
estatísticos. Busquei alguma solução que de alguma forma fosse útil na
página do <a href="https://www.rstudio.com/">RStudio</a> e me deparei
com o pacote <code>tufle</code> disponível no
<a href="https://cran.r-project.org/">CRAN</a>.
</p>
<p>
Este pacote fornece um template interessante para a elaboração de
arquivos rmarkdown para converter para PDF, a apresentação é apresentada
no manual mais ou menos dessa maneira:
</p>
<img src="http://rmarkdown.rstudio.com/images/tufte-handout.png" alt="Imagem do manual">
<p class="caption">
Imagem do manual
</p>

<p>
Para instalar o pacote, basta rodar a linha de comando:
</p>
<pre class="r"><code>install.packages(&quot;tufte&quot;)</code></pre>

<p>
Para criar um documento com o novo template, basta acessar
<code>File&gt;New File&gt;R Markdown...</code> e selecionar o templante:
</p>
<img src="http://rmarkdown.rstudio.com/images/new-tufte-handout.png" alt="Imagem do manual do pacote">
<p class="caption">
Imagem do
<a href="http://rmarkdown.rstudio.com/tufte_handout_format.html#overview">manual
do pacote</a>
</p>

<p>
Um novo documento será aberto, caso deseje fazer alguma alteração no
preâmbulo, existem essas opções apresentadas no
<a href="https://cran.r-project.org/web/packages/tufte/tufte.pdf">manual
do pacote no CRAN</a>:
</p>

<pre class="r"><code>---
title: &quot;T&#xED;tulo&quot;
subtitle: &quot;Subtitulo&quot;
author: &quot;Autor&quot;
date: &quot;`r Sys.Date()`&quot;
output: tufte::tufte_html: default tufte::tufte_handout: keep_tex: false #true highlight: tango #&#x201C;default&#x201D;, &#x201C;pygments&#x201D;, &#x201C;kate&#x201D;, &#x201C;monochrome&#x201D;, &#x201C;espresso&#x201D;, &#x201C;zenburn&#x201D;, and &#x201C;haddock&#x201D; fig_width: 4 fig_height: 4 citation_package: natbib latex_engine: xelatex tufte::tufte_book: citation_package: natbib latex_engine: xelatex
bibliography: skeleton.bib
link-citations: yes
---</code></pre>
<p>
Agora basta formatar e organizar os resultados de acordo com seu
interesse nas análises sem grandes preocupações com a formatação,
deixando da maneira que seja mais conveiente.
</p>
<p>
O que sempre foi possível em latex agora já pode ser adapato para quem
gosta de trabalhar diretamente no RStudio!
</p>

