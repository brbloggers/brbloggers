+++
title = "Salvando data.frames: uma comparação"
date = "2017-07-19 21:26:00"
categories = ["curso-r"]
original_url = "http://curso-r.com/blog/2017/07/20/2017-07-20-escrevendo-data-frames/"
+++

<p class="text-muted text-uppercase mb-small text-right">
Por <a href="http://curso-r.com/author/daniel">Daniel</a> 20/07/2017
</p>
<p>
Salvar data.frames para ler depois é uma tarefa muito comum para quem
trabalha com R, principalmente quando o seu processo possui algumas
etapas mais demoradas e você não quer ter que rodar tudo de novo.
</p>
<p>
Veja aqui 3 formas fáceis, e rápidas para salvar o seu banco de dados e
não perder tempo lendo novamente.
</p>
<p>
Talvez a função mais conhecida para salvar objetos do R. Ela salva em um
formato binário que só pode ser lido pelo R. Por padrão comprime o
arquivo após salvar, o que economiza espaço no disco, mas pode fazê-la
levar mais tempo para rodar.
</p>
<p>
Considere um <code>data.frame</code> gerado pelo código abaixo:
</p>
<pre class="r"><code>nrOfRows &lt;- 1e7
x &lt;- data.frame( Integers = 1:nrOfRows, # integer Logicals = sample(c(TRUE, FALSE, NA), nrOfRows, replace = TRUE), # logical Text = factor(sample(state.name, nrOfRows, replace = TRUE)), # text Numericals = runif(nrOfRows, 0.0, 100), # numericals stringsAsFactors = FALSE)</code></pre>
<p>
Agora veja o tempo que demoramos para salvá-lo com o
<code>saveRDS</code>.
</p>
<pre class="r"><code>system.time({ saveRDS(x, &quot;~/Desktop/saveRDS.rds&quot;) }) # user system elapsed # 19.300 0.112 19.386 </code></pre>
<p>
O espaço ocupado pelo arquivo é de 95MB. Indicando para a função que
você não deseja comprimir:
</p>
<pre class="r"><code>system.time({ saveRDS(x, &quot;~/Desktop/saveRDS2.rds&quot;, compress = FALSE) })
# user system elapsed # 0.260 0.116 0.377 </code></pre>
<p>
O tempo vai para menos de 1s. Mas agora o arquivo ficou com 200MB. O
pacote <code>readr</code> tem uma função chamada <code>write\_rds</code>
que é um wrapper de <code>saveRDS</code> que por padrão não comprime os
arquivos, já que o Hadley diz que armazenamento é, em geral, muito mais
barato do que tempo de processamento.
</p>
<p>
É importante também verificar o tempo que demoramos para ler o arquivo
novamente para o R. No caso ler o arquivo comprimido demora 2x mais do
que o arquivo não comprimido.
</p>
<pre class="r"><code>system.time({ a &lt;- readRDS(&quot;~/Desktop/saveRDS.rds&quot;) })
# user system elapsed # 1.068 0.040 1.105 system.time({ a &lt;- readRDS(&quot;~/Desktop/saveRDS2.rds&quot;) })
# user system elapsed # 0.380 0.068 0.447 </code></pre>
<p>
Para salvar <code>data.frames</code> do R no disco, <code>saveRDS</code>
é sempre a minha primeira opção: é relativamente rápido para ler e
escrever e não exige instalação de nenhum pacote.
</p>
<p>
Além disso, o <code>saveRDS</code> serve para praticamente qualquer tipo
de objeto do R, ou seja, você pode usá-lo para salvar os modelos que
você ajustou ou qualquer outra coisa.
</p>
<p>
As principais desvantagens dessa função para as outras que mostrarei a
seguir são:
</p>
<ul>
<li>
só pode ser lido pelo R
</li>
<li>
não permite que você leia apenas um subset das linhas/ colunas.
</li>
</ul>

<p>
<a href="https://github.com/wesm/feather"><code>feather</code> é um
formato de arquivo</a> desenvolvido por duas pessoas muito fodas. Wes
McKinney, autor do Pandas (principal biblioteca de manipulação de dados
do python) e Hadley Wickham, principal desenvolvedor do
<code>tidyverse</code>.
</p>
<p>
O <code>feather</code> é bem rápido para salvar <code>data.frames</code>
no disco, tempo comparável a salvar o arquivo sem comprimir usando o
<code>saveRDS</code>. Mas só isso não é o suficiente para ser necessário
usá-lo, já que neste caso o <code>saveRDS</code> rápido o suficiente.
</p>
<p>
A principal vantagem do <code>feather</code> é que ele foi criado para
ser um formato de compartilhamento de <code>data.frames</code> entre
diversas linguagens de programação. Existem pacotes para ler arquivos
<code>.feather</code> escritos em R, python, Julia: as três principais
linguagens para análise de dados.
</p>
<p>
O <code>feather</code> também permite que você leia apenas algumas
linhas ou colunas do dataset, o que muitas vezes é útil para fazer
consultas mais rápidas na base sem ter que ler tudo para a RAM de uma
vez só.
</p>
<pre class="r"><code>library(feather)
system.time({ write_feather(x, &quot;~/Desktop/feather.feather&quot;)
})
# user system elapsed # 0.172 0.084 0.253 </code></pre>
<p>
O arquivo produzido pesa 162MB. Para ler o arquivo salvo:
</p>
<pre class="r"><code>system.time({ a &lt;- read_feather(&quot;~/Desktop/feather.feather&quot;)
})
# user system elapsed # 0.112 0.020 0.131 </code></pre>
<p>
Usando o <code>feather</code> para ler apenas algumas linhas e colunas.
</p>
<pre class="r"><code>a &lt;- feather(&quot;~/Desktop/feather.feather&quot;)
b &lt;- a[5000:6000, 1:3]</code></pre>

<p>
<a href="https://github.com/fstpackage/fst"><code>fst</code> é um
pacote</a> para ler e escrever <code>data.frames</code> de forma muito
rápida.
</p>
<img src="http://curso-r.com/img/escrevendodfs/README-speedCode-1.png" alt="">

<p>
A imagem (retirada
<a href="https://github.com/fstpackage/fst">daqui</a>) acima mostra a
sua velocidade. O <code>fst</code> é mais ou menos 3 vezes mais rápido
para ler os arquivos salvos e cerca de 2x mais rápido para escrevê-los.
O arquivo salvo pelo <code>fst</code> é também um pouco menor: 130MB.
</p>
<p>
Ler e escrever é, assim como as outras opções, tão simples como usar uma
função:
</p>
<pre class="r"><code>library(fst)
# salvar
write.fst(x, &quot;/home/daniel/Desktop/dataset.fst&quot;) # ler
a &lt;- read.fst(&quot;~/Desktop/dataset.fst&quot;) # ler apenas algumas linhas e colunas
b &lt;- read.fst(&quot;~/Desktop/dataset.fst&quot;, c(&quot;Logicals&quot;, &quot;Text&quot;), 2000, 4990) </code></pre>
<p>
<strong>Note</strong> Como o Sillas mencionou nos comentários, a versão
do CRAN do <code>fst</code> salva datas como numericos no arquivo. Os
números podedm sser convertidos para data novamente usando a função
<code>as.Date</code> do pacote <code>zoo</code>, mas tem que tomar
cuidado!
</p>

<h2>
Conclusão
</h2>
<ul>
<li>
<p>
Use sempre <code>saveRDS</code> e <code>readRDS</code>, se precisar de
velocidade, salve com o argumento <code>compress = FALSE</code> para não
comprimir o arquivo.
</p>
</li>
<li>
<p>
Se você for ler a base em python ou Julia e quiser um formato
padronizado, use o
<a href="https://github.com/wesm/feather"><code>feather</code></a>.
</p>
</li>
<li>
<p>
Se você for realmente ler e escrever os seus dados muitas vezes e você
precisar de velocidade, use o
<a href="https://github.com/fstpackage/fst"><code>fst</code></a>.
</p>
</li>
</ul>

