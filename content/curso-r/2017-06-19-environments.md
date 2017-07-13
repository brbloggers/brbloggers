+++
title = "Environments"
date = "2017-06-19 20:26:00"
categories = ["curso-r"]
original_url = "http://curso-r.com/blog/2017/06/19/2017-06-19-environments/"
+++

<p>
Se você utiliza o R regularmente, com certeza já se deparou com o termo
<em>environment</em>. Ele aparece como um painel do RStudio, quando
acessamos o código de uma função e (implicitamente) quando carregamos
pacotes. Neste post, vamos tentar responder as três perguntas básicas
sobre qualquer coisa no R: 1. o que é? 2. para que serve? e 3. como NÃO
usar?
</p>
<p>
Definindo de uma maneira bem simples, <em>environments</em> são locais
onde objetos são armazenados, isto é, conjuntos de ligações entre
símbolos e valores. Por exemplo, quando fazemos a atribuição abaixo,
</p>
<pre class="r"><code>a &lt;- 4</code></pre>
<p>
estamos criando uma associação do símbolo <code>a</code> ao valor
<code>4</code>, que, por padrão, é guardada dentro do <em>global
environment</em>.
</p>
<pre class="r"><code>ls(globalenv())
## [1] &quot;a&quot;</code></pre>
<p>
Assim, quando rodarmos o símbolo <code>a</code>, o R, por padrão, vai
procurar dentro desse <em>environment</em> um valor para devolver. No
caso, o valor <code>4</code>.
</p>
<pre class="r"><code>a
## [1] 4</code></pre>
<p>
Mais formalmente, <em>environments</em> podem ser definidos como a
junção de duas coisas: um conjunto de pares (símbolo, valor); e um
ponteiro para um outro <em>environment</em>. Quando o R não encontra um
valor para um símbolo no <em>environment</em> em que está procurando,
ele passa a procurar no próximo, o <em>environment</em> para qual o
primeiro está apontando, chamado de <em>environment pai</em>. Assim, os
<em>environments</em> se estruturam como uma árvore, cuja raiz é um
<em>environment</em> vazio.
</p>
<pre class="r"><code>emptyenv()
## &lt;environment: R_EmptyEnv&gt;</code></pre>

<p>
É possível criar novos <em>environments</em> com a função
<code>new.env()</code>
</p>
<pre class="r"><code>magrathea &lt;- new.env()</code></pre>
<p>
e criar objetos dentro desse <em>environments</em> com a função
<code>assign()</code>
</p>
<pre class="r"><code>assign(&quot;a&quot;, 8, envir = magrathea)</code></pre>
<pre class="r"><code>ls(magrathea)
## [1] &quot;a&quot;</code></pre>
<p>
Agora temos um objeto chamado <code>a</code> no <em>global
environment</em> e no <em>magrathea</em>, que nós criamos. Note que o R
inicia a busca no <em>global environment</em>.
</p>
<pre class="r"><code>a
## [1] 4</code></pre>
<p>
Vamos agora criar outro objeto dentro de <em>magrathea</em>.
</p>
<pre class="r"><code>assign(&quot;b&quot;, 15, envir = magrathea)</code></pre>
<p>
Observe que se procurarmos simplesmente por <code>b</code>, o R não vai
encontrar um valor para associar.
</p>
<pre class="r"><code>b</code></pre>
<p>
Acontece que <code>magrathea</code> é um <em>environment</em> “abaixo”
do <em>global</em> na hierarquia, e o R só estende a sua busca para
<em>environments</em> acima (sim, estou pensando numa árvore de
ponta-cabeça).
</p>
<pre class="r"><code>parent.env(magrathea)
## &lt;environment: R_GlobalEnv&gt;</code></pre>
<p>
Se criarmos agora um objeto no <em>global</em>
</p>
<pre class="r"><code>c &lt;- 16</code></pre>
<p>
e usarmos a função <code>get()</code> para procurá-lo no
<em>environment</em> que criamos, o R irá encontrá-lo porque o
<em>global</em> é o <em>environment</em> pai de <em>magrathea</em>.
</p>
<pre class="r"><code>get(&quot;c&quot;, envir = magrathea)
## [1] 16</code></pre>
<p>
Essa estrutura é muito útil na hora de utilizar funções. Sempre que uma
função é chamada, um novo <em>environment</em> é criado, o
<em>environment</em> de avaliação, que contém os objetos usados como
argumento da função, os objetos criados dentro da função e aponta para o
<em>environment</em> onde a função foi criada (geralmente o
<em>global</em>).
</p>
<pre class="r"><code>f &lt;- function(a, b) { c &lt;- a + b return(c) } environment(f)
## &lt;environment: R_GlobalEnv&gt;</code></pre>
<p>
Esse comportamento nos permite fazer duas coisas. Primeiro, os cálculos
realizados dentro das funções não modificam os objetos do
<em>global</em>.
</p>
<pre class="r"><code>f(23, 42)
## [1] 65 c
## [1] 16</code></pre>
<p>
Segundo, podemos utilizar objetos dentro da função sem defini-los lá
dentro.
</p>
<pre class="r"><code>f &lt;- function(b) { return(a + b) } f(108)
## [1] 112</code></pre>
<p>
Neste caso, como o R não encontrou o símbolo <code>a</code> dentro do
<em>environment</em> de avaliação, ele foi buscar no pai, o
<em>global</em>.
</p>

<p>
Agora que temos uma visão ao menos superficial da estrutura de
<em>environments</em>, podemos entender melhor porque usar a função
<code>attach()</code> é uma prática não recomendada ao programar em R.
</p>
<p>
Se utilizarmos a função <code>search()</code>, ela nos devolverá o
“caminho” de <em>environments</em>, começando do <em>global</em>
(<em>magrathea</em> não será exibido).
</p>
<pre class="r"><code>search()
## [1] &quot;.GlobalEnv&quot; &quot;package:methods&quot; &quot;package:stats&quot; ## [4] &quot;package:graphics&quot; &quot;package:grDevices&quot; &quot;package:utils&quot; ## [7] &quot;package:datasets&quot; &quot;Autoloads&quot; &quot;package:base&quot;</code></pre>
<p>
Repare que os pacotes carregados geram um novo <em>environment</em> na
árvore.
</p>
<pre class="r"><code>library(ggplot2)
search()
## [1] &quot;.GlobalEnv&quot; &quot;package:ggplot2&quot; &quot;package:methods&quot; ## [4] &quot;package:stats&quot; &quot;package:graphics&quot; &quot;package:grDevices&quot;
## [7] &quot;package:utils&quot; &quot;package:datasets&quot; &quot;Autoloads&quot; ## [10] &quot;package:base&quot;</code></pre>
<p>
É por isso que, ao carregar um pacote, podemos utilizar as suas funções
sem a necessidade de escrever coisas do tipo
<code>ggplot2::geom\_point()</code>. Agora, veja o que acontece quando
usamos a função <code>attach()</code>
</p>
<pre class="r"><code>mighty &lt;- list(&quot;Jason&quot; = &quot;vermelho&quot;, &quot;Zach&quot; = &quot;Preto&quot;, &quot;Billy&quot; = &quot;Azul&quot;, &quot;Trini&quot; = &quot;Amarela&quot;, &quot;Kimberly&quot; = &quot;Rosa&quot;, &quot;Thomas&quot; = &quot;Verde&quot;) attach(mighty)
search()
## [1] &quot;.GlobalEnv&quot; &quot;mighty&quot; &quot;package:ggplot2&quot; ## [4] &quot;package:methods&quot; &quot;package:stats&quot; &quot;package:graphics&quot; ## [7] &quot;package:grDevices&quot; &quot;package:utils&quot; &quot;package:datasets&quot; ## [10] &quot;Autoloads&quot; &quot;package:base&quot;</code></pre>
<p>
Um novo <em>environment mighty</em> é criado acima do <em>global</em>!
Isso quer dizer que se você não tiver total conhecimento dos objetos que
estão sendo anexados, você estará criando uma lista de objetos
“invisíveis” que podem ser avaliados mesmo dentro de funções. E veja o
que acontece quando carregamos mais pacotes
</p>
<pre class="r"><code>library(dplyr)
## Warning: Installed Rcpp (0.12.11.4) different from Rcpp used to build dplyr (0.12.11.3).
## Please reinstall dplyr to avoid random crashes or undefined behavior.
## ## Attaching package: &apos;dplyr&apos;
## The following objects are masked from &apos;package:stats&apos;:
## ## filter, lag
## The following objects are masked from &apos;package:base&apos;:
## ## intersect, setdiff, setequal, union
search()
## [1] &quot;.GlobalEnv&quot; &quot;package:dplyr&quot; &quot;mighty&quot; ## [4] &quot;package:ggplot2&quot; &quot;package:methods&quot; &quot;package:stats&quot; ## [7] &quot;package:graphics&quot; &quot;package:grDevices&quot; &quot;package:utils&quot; ## [10] &quot;package:datasets&quot; &quot;Autoloads&quot; &quot;package:base&quot;</code></pre>
<p>
O <em>environment</em> do pacote <code>dplyr</code> aparece antes do
<code>mighty</code>. Isso quer dizer que os objetos do <em>mighty</em>
podem ser mascarados por todos os pacotes que você carregar a seguir.
Veja um simples exemplo de como as coisas podem dar errado.
</p>
<pre class="r"><code>dados &lt;- tibble::tibble(paciente = 1:30, cancer = rbinom(30, size = 1, prob = 0.5)) attach(dados)
cancer
## [1] 0 0 0 0 1 1 1 1 0 0 0 0 0 0 1 1 0 1 1 0 0 1 0 0 1 0 1 0 1 1</code></pre>
<p>
Com o código acima, criamos um banco de dados representando 30 pacientes
com (1) ou sem (0) um certo tipo de câncer. As variáveis
<code>paciente</code> e <code>cancer</code> foram anexadas ao rodarmos
<code>attach(dados)</code>.
</p>
<p>
Agora, imagine se esse banco de dados tiver informações de tempo até a
remissão do câncer e quisermos rodar modelos de sobrevivência. Um passo
natural seria carregar a biblioteca <code>survival</code>.
</p>
<pre class="r"><code>library(survival)
## ## Attaching package: &apos;survival&apos;
## The following object is masked from &apos;dados&apos;:
## ## cancer
search()
## [1] &quot;.GlobalEnv&quot; &quot;package:survival&quot; &quot;dados&quot; ## [4] &quot;package:dplyr&quot; &quot;mighty&quot; &quot;package:ggplot2&quot; ## [7] &quot;package:methods&quot; &quot;package:stats&quot; &quot;package:graphics&quot; ## [10] &quot;package:grDevices&quot; &quot;package:utils&quot; &quot;package:datasets&quot; ## [13] &quot;Autoloads&quot; &quot;package:base&quot;</code></pre>
<p>
O pacote <code>survival</code> também tem um objeto chamado
<em>cancer</em>. Assim, ao carregá-lo, o <em>environment survival</em>
ficará na frente do <em>environment dados</em> na árvore e, se não
prestarmos atenção com o <em>warning</em>, esse será o nosso novo objeto
<code>cancer</code>.
</p>
<pre class="r"><code>head(cancer)
## inst time status age sex ph.ecog ph.karno pat.karno meal.cal wt.loss
## 1 3 306 2 74 1 1 90 100 1175 NA
## 2 3 455 2 68 1 0 90 90 1225 15
## 3 3 1010 1 56 1 0 90 90 NA 15
## 4 5 210 2 57 1 1 90 60 1150 11
## 5 1 883 2 60 1 0 100 90 NA 0
## 6 12 1022 1 74 1 1 50 80 513 0</code></pre>
<p>
Assim, se for utilizar a função <code>attach()</code> é preciso ter
muito cuidado com o que se está fazendo. E a melhor dica é <strong>não
use</strong>.
</p>
<p>
Esse post foi apenas uma introdução sobre como os <em>environments</em>
funcionam. Ainda existe muito mais coisa por trás, como o conceito de
<em>namespaces</em>. Se você quiser saber mais, recomendo como primeira
parada <a href="https://www.r-bloggers.com/environments-in-r/">esse
post</a>, do qual tirei boa parte das informações passadas aqui. Também
vale a pena dar uma olhada nas definições
<a href="https://cran.r-project.org/doc/manuals/R-lang.html#Environment-objects">nesse
link</a>.
</p>
<p>
Sugestões, dúvidas e críticas, deixe um comentário!
</p>

