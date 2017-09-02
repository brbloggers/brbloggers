+++
title = "Comportamentos imprevisíveis do lubridate"
date = "2017-09-02 07:12:00"
categories = ["curso-r"]
original_url = "http://curso-r.com/blog/2017/09/02/2017-07-29-comportamentos-estranhos-lubridate/"
+++

<p>
Manter-se atualizado na parte mais computacional é muito importante para
um estatístico. Essa convicção é bastante razoável, mas costuma gerar
polêmica em alguns ciclos acadêmicos. Quem nunca se questionou se “(eu)
deveria implementar esse Newton-Raphson ou usar um pacote de procedência
duvidosa?” ou “escrever a matriz de delineamento é mesmo importante? O R
já solta pra mim!” que atire a primeira pedra.
</p>
<p>
Na minha opinião, esse tipo de discussão nasce morta. Ao mesmo tempo em
que é importante conhecer bem a teoria que se aplica, o mundo é vasto e
grandioso demais pra gastar tempo estudando detalhes técnicos de
implementação de todas as coisas. Isso é óbvio, mas por outro lado “um
pouco” de conhecimento sobre a parte suja do trabalho também é essencial
em algumas situações. Se a sua base ficou grande demais para o R, todo o
seu conhecimento de estatística pode ser inútil, porque o que te separa
do sucesso é um bom gerenciamento dos recursos computacionais.
</p>
<p>
Precisa existir um equilíbrio entre “apertar botões” e “reinventar a
roda”. Isso é óbvio, mas a parte triste da discussão é que esse
equilíbrio pode ser difícil de alcançar.
</p>
<p>
Existem muitas versões da discussão entre estatísticos-computeiros e
estatísticos-papel-e-caneta. Uma delas, que será tema deste post, parte
da questão “Eu deveria implementar todas as minhas funções ou usar as
guloseimas tecnológicas disponíveis no CRAN?”. De um lado, os apóstolos
do <code>tidyverse</code>, como a própria <code>Curso-R</code>, defendem
e divulgam os avanços proporcionados por ferramentas que computam em
altíssimo nível. Os estatísticos mais caxias gostam de implementar todas
as contas e funções que foram utilizar, o que provoca alguns hábitos
estranhos. Os tipos mais radicais invertem matrizes em Fortran, não
acreditam na função <code>quantile</code> e não raramente são afeitos à
teorias da conspiração.
</p>
<p>
Como sempre, nenhum dos dois lados está 100% correto, mas na última
semana me deparei com um problema que me fez sentir mais próximo do mais
radical dos xiitas.
</p>
<p>
Considere que você precisa carregar um vetor de datas que vieram do
Excel. Pulando a parte de leitura e as soluções que poderiam vir do bom
uso de pacotes como <code>readxl</code> e <code>openxlsx</code>,
considere que o problema prático consiste em converter, já no R, o
seguinte vetor de textos num vetor de datas.
</p>
<pre class="r"><code>exemplo_1 &lt;- c(&quot;22/08/2016&quot;,&quot;29/08/2016&quot;, &quot;05/09/2016&quot;,&quot;12/09/2016&quot;)</code></pre>
<p>
Quem usa o <code>tidyverse</code> faria isso usando a função
<code>dmy</code> do pacote <code>lubridate</code>:
</p>
<pre class="r"><code>lubridate::dmy(exemplo_1)</code></pre>
<pre><code>## [1] &quot;2016-08-22&quot; &quot;2016-08-29&quot; &quot;2016-09-05&quot; &quot;2016-09-12&quot;</code></pre>
<p>
e o resultado seria exatamente o que a gente quer. O que aconteceu
comigo, entretanto, foi um comportamento inesperado num exemplo muito
parecido com esse.
</p>
<p>
Por conta da formatação irregular de um arquivo de Excel, me deparei com
um vetor parecido com esse <code>o\_que\_observei</code>:
</p>
<pre class="r"><code>repeticoes &lt;- 800
o_que_observei &lt;- c(rep(&quot;39419&quot;, repeticoes), &quot;22/08/2016&quot;,&quot;29/08/2016&quot;, &quot;05/09/2016&quot;,&quot;12/09/2016&quot;)</code></pre>
<p>
Eu imaginava que, quando <code>repeticoes</code> valesse 800, o
resultado fosse o mesmo que acontece quando <code>repeticoes</code> vale
1, mas esse não é o caso.
</p>
<p>
Primeiro, vamos o que acontece quando <code>repeticoes</code> vale 1:
</p>
<pre class="r"><code>exemplo_2 &lt;- c(&quot;39419&quot;, &quot;22/08/2016&quot;,&quot;29/08/2016&quot;, &quot;05/09/2016&quot;,&quot;12/09/2016&quot;)</code></pre>
<p>
O <code>lubridate</code> não é esperto o suficiente para perceber que a
primeira entrada representa uma data com origem no dia “30/12/1899” (a
data padrão em Excel’s de Windows), mas tudo aquilo que ele não sabe
como converter vira um <code>NA</code>.
</p>
<pre class="r"><code>lubridate::dmy(exemplo_2)</code></pre>
<pre><code>## Warning: 1 failed to parse.</code></pre>
<pre><code>## [1] NA &quot;2016-08-22&quot; &quot;2016-08-29&quot; &quot;2016-09-05&quot; &quot;2016-09-12&quot;</code></pre>
<p>
Agora, veja só o que acontece quando fazemos a mesma coisa no meu
exemplo:
</p>
<pre class="r"><code>lubridate::dmy(o_que_observei)</code></pre>
<pre><code>## Warning: All formats failed to parse. No formats found.</code></pre>
<pre><code>## [1] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
## [24] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
## [47] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
## [70] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
## [93] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
## [116] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
## [139] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
## [162] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
## [185] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
## [208] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
## [231] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
## [254] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
## [277] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
## [300] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
## [323] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
## [346] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
## [369] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
## [392] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
## [415] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
## [438] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
## [461] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
## [484] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
## [507] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
## [530] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
## [553] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
## [576] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
## [599] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
## [622] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
## [645] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
## [668] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
## [691] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
## [714] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
## [737] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
## [760] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
## [783] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA</code></pre>
<p>
O resultado é bastante estranho. Embora as últimas entradas do vetor
sejam datas num formato conhecido, não é isso que a função retorna.
</p>

<p>
Me perguntando sobre o que aconteceu, eu resolvi criar uma
<a href="http://127.0.0.1:4321/blog/2017/07/29/2017-07-29-comportamentos-estranhos-lubridate/">issue</a>
no pacote <code>lubridate</code>.
</p>
<blockquote>
<p>
Consider the following vectors:
</p>
<pre><code>dates_vector_1 &lt;- c(&quot;22/08/2016&quot;,&quot;29/08/2016&quot;,&quot;05/09/2016&quot;,&quot;12/09/2016&quot;)
dates_vector_2 &lt;- c(rep(&quot;1&quot;, 500), dates_vector_1)
dates_vector_3 &lt;- c(rep(&quot;1&quot;, 800), dates_vector_1)</code></pre>
<p>
<code>dmy</code> fails to detect formats on the third, even though it’s
capable of finding it on the second.
</p>
<pre><code>library(lubridate) dmy(dates_vector_1)
dmy(dates_vector_2)
dmy(dates_vector_3)</code></pre>
<p>
Is this supposed to happen? If it is, why?
</p>
</blockquote>
<p>
A resposta do <code>vspinu</code>, pricipal contribuidor do
<code>lubridate</code> hoje, me respondeu muito rapidamente!
</p>
<blockquote>
<p>
This is a consequence of guessing formats based on a deterministic
sub-sample of the original vector. This issue was aleviated somewhat
recently, but it’s impossible to solve efficiently without dropping
format guesser to C level. Not something which I would consider in the
future.
</p>
<p>
See \#307 \#308. You can disable guesser with parse\_date\_time and
train=FALSE.
</p>
</blockquote>
<p>
Case solved! O problema é a <code>parse\_date\_time</code>, que é usada
por trás do <code>dmy</code>. Antes de converter, o
<code>lubridate</code> adivinha quais são os formatos, que usa apenas
<a href="https://github.com/tidyverse/lubridate/issues/307">um pedaço do
vetor</a>.
</p>

<p>
A solução proposta pelo <code>vspinu</code> não funcionou no meu caso.
</p>
<pre class="r"><code>parse_date_time(o_que_observei, train = T, orders = &apos;dmy&apos;)</code></pre>
<p>
O <code>parse\_date\_time</code> continua não reconhecendo as últimas
entradas do meu vetor como datas, mesmo com o <code>train =
FALSE</code>.
</p>
<p>
Para não gastar muito tempo, terminei fazendo um gato pra resolver o meu
problema.
</p>
<pre class="r"><code>novo &lt;- c(&quot;01/01/2001&quot;, o_que_observei) solucao &lt;- dmy(novo)[-1]</code></pre>
<pre><code>## Warning: 800 failed to parse.</code></pre>
<pre class="r"><code>solucao</code></pre>
<pre><code>## [1] NA NA NA NA NA ## [6] NA NA NA NA NA ## [11] NA NA NA NA NA ## [16] NA NA NA NA NA ## [21] NA NA NA NA NA ## [26] NA NA NA NA NA ## [31] NA NA NA NA NA ## [36] NA NA NA NA NA ## [41] NA NA NA NA NA ## [46] NA NA NA NA NA ## [51] NA NA NA NA NA ## [56] NA NA NA NA NA ## [61] NA NA NA NA NA ## [66] NA NA NA NA NA ## [71] NA NA NA NA NA ## [76] NA NA NA NA NA ## [81] NA NA NA NA NA ## [86] NA NA NA NA NA ## [91] NA NA NA NA NA ## [96] NA NA NA NA NA ## [101] NA NA NA NA NA ## [106] NA NA NA NA NA ## [111] NA NA NA NA NA ## [116] NA NA NA NA NA ## [121] NA NA NA NA NA ## [126] NA NA NA NA NA ## [131] NA NA NA NA NA ## [136] NA NA NA NA NA ## [141] NA NA NA NA NA ## [146] NA NA NA NA NA ## [151] NA NA NA NA NA ## [156] NA NA NA NA NA ## [161] NA NA NA NA NA ## [166] NA NA NA NA NA ## [171] NA NA NA NA NA ## [176] NA NA NA NA NA ## [181] NA NA NA NA NA ## [186] NA NA NA NA NA ## [191] NA NA NA NA NA ## [196] NA NA NA NA NA ## [201] NA NA NA NA NA ## [206] NA NA NA NA NA ## [211] NA NA NA NA NA ## [216] NA NA NA NA NA ## [221] NA NA NA NA NA ## [226] NA NA NA NA NA ## [231] NA NA NA NA NA ## [236] NA NA NA NA NA ## [241] NA NA NA NA NA ## [246] NA NA NA NA NA ## [251] NA NA NA NA NA ## [256] NA NA NA NA NA ## [261] NA NA NA NA NA ## [266] NA NA NA NA NA ## [271] NA NA NA NA NA ## [276] NA NA NA NA NA ## [281] NA NA NA NA NA ## [286] NA NA NA NA NA ## [291] NA NA NA NA NA ## [296] NA NA NA NA NA ## [301] NA NA NA NA NA ## [306] NA NA NA NA NA ## [311] NA NA NA NA NA ## [316] NA NA NA NA NA ## [321] NA NA NA NA NA ## [326] NA NA NA NA NA ## [331] NA NA NA NA NA ## [336] NA NA NA NA NA ## [341] NA NA NA NA NA ## [346] NA NA NA NA NA ## [351] NA NA NA NA NA ## [356] NA NA NA NA NA ## [361] NA NA NA NA NA ## [366] NA NA NA NA NA ## [371] NA NA NA NA NA ## [376] NA NA NA NA NA ## [381] NA NA NA NA NA ## [386] NA NA NA NA NA ## [391] NA NA NA NA NA ## [396] NA NA NA NA NA ## [401] NA NA NA NA NA ## [406] NA NA NA NA NA ## [411] NA NA NA NA NA ## [416] NA NA NA NA NA ## [421] NA NA NA NA NA ## [426] NA NA NA NA NA ## [431] NA NA NA NA NA ## [436] NA NA NA NA NA ## [441] NA NA NA NA NA ## [446] NA NA NA NA NA ## [451] NA NA NA NA NA ## [456] NA NA NA NA NA ## [461] NA NA NA NA NA ## [466] NA NA NA NA NA ## [471] NA NA NA NA NA ## [476] NA NA NA NA NA ## [481] NA NA NA NA NA ## [486] NA NA NA NA NA ## [491] NA NA NA NA NA ## [496] NA NA NA NA NA ## [501] NA NA NA NA NA ## [506] NA NA NA NA NA ## [511] NA NA NA NA NA ## [516] NA NA NA NA NA ## [521] NA NA NA NA NA ## [526] NA NA NA NA NA ## [531] NA NA NA NA NA ## [536] NA NA NA NA NA ## [541] NA NA NA NA NA ## [546] NA NA NA NA NA ## [551] NA NA NA NA NA ## [556] NA NA NA NA NA ## [561] NA NA NA NA NA ## [566] NA NA NA NA NA ## [571] NA NA NA NA NA ## [576] NA NA NA NA NA ## [581] NA NA NA NA NA ## [586] NA NA NA NA NA ## [591] NA NA NA NA NA ## [596] NA NA NA NA NA ## [601] NA NA NA NA NA ## [606] NA NA NA NA NA ## [611] NA NA NA NA NA ## [616] NA NA NA NA NA ## [621] NA NA NA NA NA ## [626] NA NA NA NA NA ## [631] NA NA NA NA NA ## [636] NA NA NA NA NA ## [641] NA NA NA NA NA ## [646] NA NA NA NA NA ## [651] NA NA NA NA NA ## [656] NA NA NA NA NA ## [661] NA NA NA NA NA ## [666] NA NA NA NA NA ## [671] NA NA NA NA NA ## [676] NA NA NA NA NA ## [681] NA NA NA NA NA ## [686] NA NA NA NA NA ## [691] NA NA NA NA NA ## [696] NA NA NA NA NA ## [701] NA NA NA NA NA ## [706] NA NA NA NA NA ## [711] NA NA NA NA NA ## [716] NA NA NA NA NA ## [721] NA NA NA NA NA ## [726] NA NA NA NA NA ## [731] NA NA NA NA NA ## [736] NA NA NA NA NA ## [741] NA NA NA NA NA ## [746] NA NA NA NA NA ## [751] NA NA NA NA NA ## [756] NA NA NA NA NA ## [761] NA NA NA NA NA ## [766] NA NA NA NA NA ## [771] NA NA NA NA NA ## [776] NA NA NA NA NA ## [781] NA NA NA NA NA ## [786] NA NA NA NA NA ## [791] NA NA NA NA NA ## [796] NA NA NA NA NA ## [801] &quot;2016-08-22&quot; &quot;2016-08-29&quot; &quot;2016-09-05&quot; &quot;2016-09-12&quot;</code></pre>

<p>
A eterna disputa entre os que sabem exatamente o que acontece por trás
dos programas e aqueles que não sabem vai continuar eternamente. Como
disseram numa das issues que mencionei neste texto
</p>
<blockquote>
<p>
Obviously there is no mathematical solution without inspecting the full
vector that won’t run into edge cases.
</p>
</blockquote>
<p>
Mas isso não deve ser motivo para se isolar numa caverna. Sempre podemos
olhar com cuidado para as soluções que implementamos e entrar em contato
com os desenvolvedores das nossas ferramentas.
</p>
<p>
Por hoje, espero que esse problema específico sobre o
<code>lubridate</code> esteja esclarecido e que ninguém fique com medo
de usar a infinitude de pacotes de R. Como vimos aqui, mesmo que a
princípios as coisas sejam obscuras, sempre podemos buscar mais
informações sobre a implementação de uma função.
</p>

