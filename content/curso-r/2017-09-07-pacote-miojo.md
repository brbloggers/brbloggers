+++
title = "Pacotes miojo - como fazer um pacote no R em 3 minutos"
date = "2017-09-07 20:26:00"
categories = ["curso-r"]
original_url = "http://curso-r.com/blog/2017/09/07/2017-09-07-pacote-miojo/"
+++

<p class="text-muted text-uppercase mb-small text-right">
Por <a href="http://curso-r.com/author/julio">Julio</a> 07/09/2017
</p>
<p>
Nesse post vou mostrar como fazer um pacote em R muito, muito rápido.
Tirei várias coisas que costumo fazer nos pacotes, com dor no coração,
tudo pela velocidade, mantendo só o essencial.
</p>
<p>
Duas restrições que usei são
</p>
<ol>
<li>
O pacote precisa ficar disponível no GitHub.
</li>
<li>
O pacote precisa ter pelo menos uma função.
</li>
</ol>
<p>
Essa é a solução que eu acho mais segura e rápida. Você também pode
<a href="http://curso-r.com/blog/2017/07/17/2017-07-17-rstudio-e-github/">usar
o próprio RStudio para criar pacotes ou clonar coisas do github</a>, mas
isso pode dar alguns bugs.
</p>
<p>
Clique no link: &lt;a
href=‘<a href="https://github.com/new" class="uri">https://github.com/new</a>’,
target=‘blank’&gt;<https://github.com/new>
</p>
<ul>
<li>
Escreva o nome do seu pacote. O nome do pacote não pode ter espaços,
underline (<code>\_</code>) nem hífen (<code>-</code>) nem começar com
números.
</li>
<li>
Tique a opção <strong>Initialize this repository with a README</strong>.
</li>
<li>
Clique em <strong>Create repository</strong>.
</li>
</ul>

<p>
Recomendo clonar repositórios abrindo um terminal e digitando
</p>
<pre><code>$ git clone https://github.com/usuario/nomeDoPacote</code></pre>
<p>
Você pode clonar de outras formas, inclusive dentro do RStudio. Se você
usar o RStudio, <strong>saia do projeto</strong> e delete o arquivo
<code>.RProj</code> criado automaticamente, pois ele terá metadados
inapropriados para criar pacotes.
</p>

<p>
Exemplo:
</p>
<pre class="r"><code>#&apos; Soma 2
#&apos; #&apos; Recebe um vetor de n&#xFA;meros e retorna um vetor de n&#xFA;meros somando dois
#&apos; #&apos; @param x vetor de n&#xFA;meros.
#&apos;
#&apos; @export
soma_2 &lt;- function(x) { x + 2
}</code></pre>
<ol>
<li>
Crie a função dentro de um arquivo com extensão <code>.R</code> na pasta
<code>R</code>
</li>
<li>
As informações que começam com <code>\#'</code> acima da função servem
para documentar. Nesse caso,
<ul>
<li>
a primeira linha é o título
</li>
<li>
a segunda linha é a descrição
</li>
<li>
a parte que começa com <code>@param</code> descreve o que é o parâmetro
de entrada
</li>
<li>
a parte que começa com <code>@export</code> diz para o pacote que essa
função deve estar disponível para o usuário quando ele rodar
<code>library(nomeDoPacote)</code>.
</li>
</ul>
</li>
</ol>

<ol>
<li>
Rode <code>devtools::document()</code>.
</li>
<li>
Commite suas alterações.
</li>
<li>
Dê um push!
</li>
</ol>
<p>
Se não saba o que é commitar e pushar, veja o artigo do
<a href="http://curso-r.com/author/athos/">Athos</a> sobre
<a href="http://curso-r.com/blog/2017/07/17/2017-07-17-rstudio-e-github/">o
uso do git e do GitHub</a>.
</p>

<ol>
<li>
Mande o nome do seu usuário do GitHub e o nome do seu pacote para sua
migue.
</li>
<li>
Peça para ela rodar:
</li>
</ol>
<pre class="r"><code>devtools::install_github(&apos;usuario/nomeDoPacote&apos;)</code></pre>
<ol>
<li>
Agora ela poderá usar sua função!
</li>
</ol>
<pre class="r"><code>library(nomeDoPacote)
soma_2(1:10)
# [1] 3 4 5 6 7 8 9 10 11 12</code></pre>
<p>
Você também pode ver o help da função com <code>?soma\_2</code>:
</p>
<p>
<img src="http://curso-r.com/blog/2017-09-07-pacote-miojo_files/figure-html/unnamed-chunk-4-1.png" width="672">
</p>
<p>
FIM!
</p>

<ul>
<li>
Agora você não tem desculpa para não empacotar suas soluções em R.
</li>
<li>
Esse tutorial é incompleto! Para acessar mais detalhes, veja
<a href="http://r-pkgs.had.co.nz/" class="uri">http://r-pkgs.had.co.nz</a>,
elaborado por você sabe quem.
</li>
</ul>
<p>
<img src="http://curso-r.com/blog/2017-09-07-pacote-miojo_files/figure-html/unnamed-chunk-6-1.png" width="480">
</p>

<ul>
<li>
Use sempre <code>devtools::check()</code> para checar se seu pacote está
100% bem construído.
</li>
<li>
Use <code>devtools::use\_package()</code> para usar funções de outros
pacotes.
</li>
<li>
Sempre use os <code>::</code> para chamar as funções e nunca rode
<code>library()</code> ou <code>require()</code> dentro de um pacote.
</li>
<li>
Use <code>devtools::use\_mit\_license()</code> para adicionar um arquivo
<code>LICENSE</code> ao seu pacote.
</li>
<li>
Use <code>abjutils::use\_pipe()</code> para poder usar o
<code>%&gt;%</code> nos seus pacotes.
</li>
<li>
Use <code>devtools::use\_data()</code> para adicionar dados ao seu
pacote.
</li>
<li>
Use <code>devtools::use\_vignettes()</code> para escrever um tutorial
sobre seu pacote,
<a href="https://cran.r-project.org/web/packages/dplyr/vignettes/dplyr.html">igual
a esse do dplyr, por exemplo</a>.
</li>
</ul>
<p>
<img src="http://curso-r.com/blog/2017-09-07-pacote-miojo_files/figure-html/unnamed-chunk-7-1.png" width="480">
</p>
<p>
É isso. Happy coding ;)
</p>

