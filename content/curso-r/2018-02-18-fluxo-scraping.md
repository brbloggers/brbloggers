+++
title = "O Fluxo do Web Scraping"
date = "2018-02-18"
categories = ["curso-r"]
original_url = "http://curso-r.com/blog/2018/02/18/2018-02-18-fluxo-scraping/"
+++

<p class="text-muted text-uppercase mb-small text-right">
Por <a href="http://curso-r.com/author/caio">Caio</a> 18/02/2018
</p>
<p>
<em>Web scraping</em> (ou raspagem web) não é nada mais que o ato de
coletar dados da internet. Hoje em dia é muito comum termos acesso
rápido e fácil a qualquer conjunto de informações pela web, mas
raramente esses dados estão estruturados e em uma forma de fácil
obtenção pelo usuário.
</p>
<p>
Isso faz com que precisemos aprender a coletar esses dados por conta
própria. Neste post vou descrever o <strong>fluxo do web
scraping</strong>, um passo a passo para explicar aos iniciantes como
funciona a criação de um raspador.
</p>
<p>
Caso você já tenha visto o
<a href="http://r4ds.had.co.nz/introduction.html">fluxo da ciência de
dados</a> descrito por Hadley Wickham, o fluxo do web scraping vai ser
bastante simples de entender. Todos os itens a seguir vão se basear
neste diagrama:
</p>
<img src="http://curso-r.com/blog/2018-02-18-fluxo-scraping/cycle.png">

<p>
Cada verbo indica um fase do processo de raspar dados da internet. A
caixa azulada no meio do diagrama denominada <strong>reprodução</strong>
indica um procedimento iterativo que devemos repetir até que a coleta
funcione, mas, de resto, o fluxo é um processo linear.
</p>
<p>
Nas próximas seções, vamos explorar um exemplo bem simples para entender
como esses passos se dariam no mundo real: extrair os títulos de artigos
da Wikipédia.
</p>
<p>
O primeiro passo do fluxo se chama <strong>identificar</strong> porque
nele identificamos a informação que vamos coletar. Aqui precisamos
entender bem qual é a estrutura das páginas que queremos raspar e traçar
um plano para extrair tudo que precisamos.
</p>
<p>
No nosso exemplo, precisaríamos entrar em algumas páginas da Wikipédia
para entender se os títulos se comportam da mesma forma em todas. Como a
Wikipédia é um site organizado, todos os títulos são criados da mesma
forma em absolutamente todos os artigos.
</p>
<img src="http://curso-r.com/blog/2018-02-18-fluxo-scraping/title.gif">

<p>
Se tivéssemos que fazer várias requests HTTP para chegar até a
informação que queremos, seria aqui em que tentaríamos
<strong>replicar</strong> essas chamadas. Neste passo é importante
compreender absolutamente tudo que a página está fazendo para trazer o
conteúdo até você, então é necessário analisar o seu <em>networking</em>
a fim de entender tais requests e seus respectivos queries.
</p>
<p>
No nosso caso, basta fazer uma chamada GET para obter a página do artigo
desejado. Também se faz necessário salvar a página localmente para que
possamos dar continuidade ao fluxo.
</p>
<pre class="r"><code>url &lt;- &quot;https://en.wikipedia.org/wiki/R_(programming_language)&quot;
httr::GET(url, httr::write_disk(&quot;~/Desktop/wiki.html&quot;))</code></pre>

<p>
O anglicismo <strong>parsear</strong> vem do verbo <em>to parse</em>,
que quer dizer algo como analisar ou estudar, mas que, no contexto do
web scraping, significa extrair os dados desejados de um arquivo HTML.
</p>
<p>
Aqui vamos usar a informação obtida no passo 2 para retirar do arquivo
que chamei de <code>wiki.html</code> o título do artigo.
</p>
<pre class="r"><code>&quot;~/Desktop/wiki.html&quot; %&gt;% xml2::read_html() %&gt;% rvest::html_node(xpath = &quot;//*[@id=&apos;firstHeading&apos;]&quot;) %&gt;% rvest::html_text()
#&gt; [1] &quot;R (programming language)&quot;</code></pre>

<p>
Se tivermos feito tudo certo até agora, <strong>validar</strong> os
resultados será uma tarefa simples. Precisamos apenas reproduzir o
procedimento descrito até agora para algumas outras páginas de modo
verificar se estamos de fato extraindo corretamente tudo o que queremos.
</p>
<p>
Caso encontremos algo de errado precisamos voltar ao passo 3, tentar
replicar corretamente o comportamento do site e parsear os dados certos
nas páginas.
</p>

<p>
O último passo consiste em colocar o nosso scraper em produção. Aqui,
ele já deve estar funcionando corretamente para todos os casos desejados
e estar pronto para raspar todos os dados dos quais precisamos.
</p>
<p>
Na maior parte dos casos isso consiste em encapsular o scraper em uma
função que recebe uma série de links e aplica o mesmo procedimento em
cada um. Se quisermos aumentar a eficiência desse processo, podemos
<a href="http://curso-r.com/blog/2018/02/17/2018-02-17-scraper-distribuido/">paralelizar
ou distribuir</a> o nosso raspador.
</p>
<pre class="r"><code>scraper &lt;- function(url, path) { httr::GET(url, httr::write_disk(path)) path %&gt;% xml2::read_html() %&gt;% rvest::html_node(xpath = &quot;//*[@id=&apos;firstHeading&apos;]&quot;) %&gt;% rvest::html_text()
} purrr::map2_chr(links, paths, scraper)</code></pre>

<p>
Fazer um scraper não é uma tarefa fácil, mas, se toda vez seguirmos um
método consistente e robusto, podemos melhorar um pouco o nosso
trabalho. O fluxo do web scraping tenta ser este método, englobando em
passos simples e razoavelmente bem definidos essa arte que é fazer
raspadores web.
</p>
<p>
Caso você tenha se interessado pelo conteúdo abordado nesse post, eu e o
pessoal da Curso-R vamos dar no dia 10/03/2018 um workshop em São Paulos
sobre web scraping com R. Lá você vai ter a oportunidade de aprender em
muitos mais detalhes como são, no mundo real, os 6 passos do web
scraping além de várias dicas de como tornar seus scrapers ainda
melhores.
</p>

