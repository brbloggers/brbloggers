+++
title = "Knitr: mudando o diretório de trabalho"
date = "2017-03-25 20:26:00"
categories = ["curso-r"]
original_url = "http://curso-r.com/blog/2017/03/25/2017-03-25-knitr-mudando-diretorio-de-trabalho/"
+++

<div>
<p class="text-muted text-uppercase mb-small text-right">
Por <a href="http://curso-r.com/author/william">William</a> 25/03/2017
</p>
<div id="post-content">
<p>
O pacote <code>knitr</code> é um mecanismo rápido, elegante e flexível
para gerar relatórios dinâmicos no R. Ele trabalha lado a lado com o
<code>rmarkdown</code> para transformar arquivos <code>.Rmd</code> em
diversos formatos, como html, pdf e até mesmo word. Misturando
<em>chunks</em> de código em R com texto puro, LaTeX e html, a tarefa de
criar outputs para análises estatísticas no R ficou muito mais simples.
</p>
<p>
Quando estamos trabalhando com arquivos Rmarkdown no Rstudio, o
diretório de trabalho é a própria pasta onde o <code>Rmd</code> está
salvo. Assim, se o nosso relatório tem algum input (banco de dados,
arquivos com código em R ou imagens, por exemplo), esses arquivos
precisam estar nessa pasta. Isso pode ser uma chateação se você está
dentro de um projeto e organizou os arquivos de forma diferente: banco
de dados em uma pasta, <code>.R</code> em outra, imagens em outra,
outputs em outra…
</p>
<p>
A primeira ideia que vem à cabeça é usar a função <code>setwd()</code>
dentro de algum chunk para mudar o diretório de trabalho dentro do
arquivo <code>Rmd</code>. No entanto, se fizermos isso, o diretório de
trabalho será mudado para aquele chunk, mas voltará a ser a pasta do
arquivo <code>.Rmd</code> após a sua execução. Veja o
<code>warning</code> abaixo.
</p>
<pre class="r"><code>setwd(&apos;../&apos;) # Warning message: you changed the working directory # to C:/novo_diretorio (probably via setwd()). # It will be restored to C:/diretorio_do_Rdm. # See the Note section in ?knitr::knit.</code></pre>
<p>
Lendo a seção “Note” do <code>?knitr:knit</code>, verificamos que mudar
o diretório de trabalho via <code>setwd()</code> pode levar a
<strong>terríveis consequências</strong>. Basicamente, figuras e
arquivos de cache podem ser salvos no lugar errado, e o seu relatório
não será gerado corretamente. Ainda lendo a seção “Note”, encontramos a
maneira correta de mudar o diretório de trabalho: setar a opção
<code>opts\_knit$set(root.dir = ...)&lt;/code&gt;.&lt;/p&gt; &lt;pre class="r"&gt;&lt;code&gt;opts\_knit$set(root.dir
= '../')</code>
</pre>
<p>
Vale ainda ressaltar que a mudança do diretório só vai ser definida para
os chunks seguintes, isto é, se você fizer a mudança
<code>opts\_knit$set(root.dir = '../')</code> e, no mesmo chunk, tentar
ler um arquivo no diretório pai (<code>source(input.R)</code>, por
exemplo), o arquivo não vai ser encontrado.
</p>
</div>
</div>

