+++
title = "Quebrando CAPTCHAs - Parte IV: Trabalhando com a imagem completa"
date = "2017-07-31 11:07:31"
categories = ["curso-r"]
original_url = "http://curso-r.com/blog/2017/07/31/2017-06-29-captcha-dados/"
+++

<p class="text-muted text-uppercase mb-small text-right">
Por <a href="http://curso-r.com/author/julio">Julio</a> 31/07/2017
</p>
<p>
No último post sobre
<a href="http://curso-r.com/tags/captcha/">CAPTCHAs</a> nós vimos que a
segmentação das imagens (separar uma imagem em várias imagens, uma para
cada caractere) é um problema complicado. Definir uma largura fixa ou
utilizar outros métodos ad-hoc para segmentar as imagens pode dar bons
frutos, mas não é o suficiente para quebrar CAPTCHAs mais complexos,
como o da Receita Federal.
</p>
<p>
Alguns meses atrás, tentamos resolver esse problema de várias formas.
Uma delas foi utilizar algoritmos de agrupamento (<span
class="math inline">*k*</span>-médias) ou de identificação de conjuntos
conectados. Esses algoritmos se mostraram instáveis e não aumentaram
muito o poder preditivo. Outra ideia que tentamos foi criar vários
critérios de corte fixos e incluir todas as colunas geradas na base de
dados. Mas isso deixou nos deixou com uma dimensão muito grande pra
tratar, e parecia que os modelos precisavam de muito mais dados pra
começarem a funcionar.
</p>
<p>
Foi aí que o Daniel nos disse que estava trabalhando no pacote do Keras
e que existia uma forma de trabalhar com a imagem completa, sem
segmentar. A tarefa de segmentação seria “parametrizada” num modelão
complexo de deep learning e conseguiríamos resolver o problema
<strong>sem pré-processamento</strong>.
</p>
<p>
Inicialmente, eu e o Athos ficamos perplexos com a ideia. Foi só quando
o Daniel mostrou um modelo que <strong>acertava 100% dos CAPTCHAs do
TJMG</strong> que fomos convencidos, e passamos a chamar esse modelo de
“magia negra”.
</p>
<p>
Nesse post, vamos discutir como montar a base para fazer a magia negra.
</p>
<p>
Nossa resposta não é mais uma categoria, e sim uma matriz. A matriz tem
<span class="math inline">*k*</span> linhas (número de letras em um
CAPTCHA) <span class="math inline">*p*</span> colunas (número de valores
possíveis de um caractere). O elemento <span
class="math inline">(*i*, *j*)</span> vale <code>1</code> se na posição
<span class="math inline">*i*</span> aparece a letra relativa à posição
<span class="math inline">*j*</span>.
</p>
<p>
Assim,
</p>
<pre><code>a49f36</code></pre>
<p>
vira isso: (substituí <code>0</code> por <code>'.'</code> para ficar
mais fácil de ver)
</p>
<table>
<thead>
</thead>
<tbody>
<tr class="odd">
<td>
1
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
1
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
</tr>
<tr class="even">
<td>
2
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
1
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
</tr>
<tr class="odd">
<td>
3
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
1
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
</tr>
<tr class="even">
<td>
4
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
1
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
</tr>
<tr class="odd">
<td>
5
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
1
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
</tr>
<tr class="even">
<td>
6
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
1
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
<td>
.
</td>
</tr>
</tbody>
</table>
<p>
Isso para uma imagem. Vamos precisar de uma terceira dimensão, que são
as “linhas” de nossa resposta (uma para cada CAPTCHA).
</p>
<p>
Nosso <code>y</code> final é um array de dimensões <span
class="math inline">*n* × *k* × *p*</span>. Achou estranho? Estamos só
começando!
</p>

<p>
Uma imagem nada mais é do que uma matriz de pixels. Cada elemento da
matriz é um número entre zero e um indicando o quanto de cor há nesse
pixel. Assim, zero significa preto (ausência de cor), e um significa
branco (todas as cores). Valores intermediários dão escala de cinza.
Para representar imagens com cores, é necessária uma terceira dimensão
de tamanho 3, indicando os pesos de <code>R</code> (<em>red</em>)
<code>G</code> (<em>green</em>) e <code>B</code> (<em>blue</em>).
</p>
<p>
Assim, nossa base de dados de explicativas é um array de dimensões <span
class="math inline">*n* × *h* × *w* × 3</span>, em que <span
class="math inline">*h*</span> e <span class="math inline">*w*</span>
são a altura e a largura da imagem, respectivamente.
</p>

<p>
Para facilitar a vida, criamos uma função <code>prepare</code> que
prepara os arquivos de imagem num formato adequado para ajuste dos
modelos usando o Keras.
</p>
<p>
Veja um exemplo com 30 CAPTCHAs do TJMG. Aqui temos apenas cinco números
por imagem, então <span class="math inline">*k* = 5</span> e <span
class="math inline">*p* = 10</span>.
</p>
<pre class="r"><code>library(decryptr)
arqs &lt;- dir(&apos;img/tjmg&apos;, full.names = TRUE) d_captcha &lt;- arqs %&gt;% read_captcha() %&gt;% prepare() str(d_captcha)
## List of 3
## $ y: num [1:30, 1:5, 1:10] 0 0 0 0 0 0 0 0 0 0 ...
## ..- attr(*, &quot;dimnames&quot;)=List of 3
## .. ..$ : NULL
## .. ..$ : chr [1:5] &quot;1&quot; &quot;2&quot; &quot;3&quot; &quot;4&quot; ...
## .. ..$ : chr [1:10] &quot;0&quot; &quot;1&quot; &quot;2&quot; &quot;3&quot; ...
## $ x: num [1:30, 1:40, 1:110, 1] 0.749 0.749 0.753 0.749 0.749 ...
## $ n: int 30
## - attr(*, &quot;class&quot;)= chr &quot;prepared&quot;</code></pre>

<h3>
Wrap-up
</h3>
<ul>
<li>
Segmentar as imagens é complicado
</li>
<li>
Vamos trabalhar com a imagem completa, mas precisamos de uma estrutura
de dados adequada.
</li>
<li>
Nossa resposta será um array de dimensão <code>\#captchas</code> x
<code>\#caracteres</code> x <code>\#categorias</code>, preenchidas
sempre com zeros e uns.
</li>
<li>
Nossa explicativa será um array de dimensão <code>\#captchas</code> x
<code>altura</code> x <code>largura</code> x <code>3</code>, preenchidas
com números entre zero e um, com os pesos de vermelho, verde e azul.
</li>
<li>
Use a função <code>decryptr::prepare()</code> num vetor de caminhos de
arquivos classificados para montar a base de forma adequada.
</li>
</ul>
<p>
No próximo post sobre esse tema, vamos falar um pouco das redes neurais
profundas que vamos ajustar.
</p>
<p>
É isso. Happy coding ;)
</p>

