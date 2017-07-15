+++
title = "Top 3 pacotes pra usar com rmarkdown"
date = "2017-07-15 20:26:00"
categories = ["curso-r"]
original_url = "http://curso-r.com/blog/2017/07/15/2017-07-15-top-3-rmarkdown/"
+++

<p class="text-muted text-uppercase mb-small text-right">
Por <a href="http://curso-r.com/author/fernando">Fernando</a> 15/07/2017
</p>
<p>
Os criadores do Markdown, segundo suas próprias palavras, criaram a
linguagem com o objetivo de construir um “formato de texto fácil de ler,
fácil de escrever e opcionalmente conversível para
HTML”<a href="http://curso-r.com/blog/2017/07/15/2017-07-15-top-3-rmarkdown/#fn1" class="footnoteRef" id="fnref1"><sup>1</sup></a>.
Com o passar do tempo, esse objetivo foi expandido pela comunidade, pois
a simplicidade também é útil para outros formatos.
</p>
<p>
As extensões andam em dois sentidos. Um deles é construir tradutores
universais entre todas as linguagens de marcação, como o
<code>pandoc</code>, permitindo que seja fácil construir documentos a
partir de textos em Markdown. A outra classe de extensões incorpora as
vantagens obtidas a outras ferramentas, como o <code>Rmarkdown</code>,
que adiciona o resultado de códigos em R aos textos escritos em
Markdown.
</p>
<p>
Essa segunda classe de extensões é particularmente importante para os
estatísticos, já que a comunicação é uma parte muito importante do seu
trabalho. Usando <code>Rmarkdown</code>, é fácil construir relatórios
reprodutíveis, concisos e, por último mas não menos importante, bonitos.
</p>
<p>
Neste post, vou listar pra vocês os meus 3 pacotes favoritos para
formatar e organizar documentos em Rmarkdown, descrevendo brevemente o
que eu mais gosto neles. Os três pacotes, assim como o próprio pacote
<code>rmarkdown</code>, estão sendo desenvolvidos pela comunidade e pelo
Rstudio, de tal forma que não vou mencionar explicitamente nenhuma das
pessoas envolvidas nos projetos, mas antes de começar a lista quero
deixar registrado que muito do que a gente tem hoje foi culpa do Yihui
Xie. Muito obrigado, Yihui!
</p>
<p>
O pacote <code>rticles</code> contém vários templates para documentos em
<code>rmarkdown</code>. Os modelos são todos baseados nos padrões de
artigos acadêmicos, mas eles são bonitos e flexíveis o suficiente para
garantir sua aplicabilidade em vários outros contextos.
</p>
<p>
Pra aplicações mais gerais, acho o template da <em>Statistic in
Medicine</em> bastante adequado.
</p>

<p>
Na nossa segunda posição, vem o pacote <code>tufte</code>. Ele contém
templates para documentos em <code>rmarkdown</code> e ferramentas
gráficas que se baseiam nas práticas de visualização do Edward Tufte
<a href="http://curso-r.com/blog/2017/07/15/2017-07-15-top-3-rmarkdown/#fn2" class="footnoteRef" id="fnref2"><sup>2</sup></a>,
sujeito que está no banner desse post. A ideia aqui é construir
relatórios fluidos e que incorporem formas de informação quantitativas
(gráficos e tabelas) de maneira mais fluida.
</p>
<p>
Vendo alguns exemplos no
<a href="http://rmarkdown.rstudio.com/tufte_handout_format.html">site do
Rstudio</a> dá pra ver como a coisa é elegante e prática. A grande
sacada é usar a margem com mais liberdade: algumas notas de rodapé, por
exemplo, na verdade são pequenos comentários, então você pode inseri-los
na margem da página pra sugerir essa relação mais íntima com o que você
escreveu.
</p>

<p>
Na terceira posição vem um pacote um pouco mais jovem do que os
anteriores. Dessa vez o objetivo é construir documentos mais longos,
como uma apostila ou um relatório. A estrutura de arquivos é bastante
simples e é possível criar capítulos, seções, sumários etc como se você
estivesse rascunhando alguma coisa em <code>rmarkdown</code>.
</p>
<p>
Além de estruturar a escrita de um documento grande, esse pacote também
se comunica bem com o <code>tufte</code> e já prevê alguma maneiras de
publicar o seu trabalho. É possível compilar os <em>books</em> em um
html, mais ou menos como os livros do
<a href="http://rmarkdown.rstudio.com/tufte_handout_format.html">Hadley</a>,
ou num pdf, sugerindo uma maneira bem legal de escrever uma dissertação
ou uma tese. Se você integrar o <em>bookdown</em> com
<a href="https://travis-ci.org/">Travis</a>, então, o céu é o limite.
</p>

