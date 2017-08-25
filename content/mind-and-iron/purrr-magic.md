+++
title = "A Magia de Purrr"
date = "2017-08-18"
categories = ["mind-and-iron"]
original_url = "http://ctlente.com/pt/purrr-magic/"
+++

<p>
Você já ouviu falar sobre um pacote de R chamado <code>purrr</code>? Ele
é descrito como um <em>toolkit</em> de programação funcional para a
linguagem R e permite que façamos coisas honestamente incríveis. Se você
nunca ouviu falar sobre o <code>purrr</code> ou mesmo se já ouviu falar
mas não sabe de todo o seu pontencial, esse post é feito para você.
</p>
<p>
Se você quisesse tornar o R mais conciso, o que você mudaria nele? Uma
boa primeira tentativa talvez envolvesse simplificar a “composição de
funções” (o ato de aplicar uma função ao resultado de outra). Dê uma
olhada nesse exemplo horrível:
</p>
<pre class="r"><code>car_data &lt;- transform(aggregate(. ~ cyl, data = subset(mtcars, hp &gt; 100), FUN = function(x) round(mean(x, 2))), kpl = mpg*0.4251)</code></pre>
<p>
Se não quisermos salvar resultados intermediários, compor diversas
funções passa a ser super importante. Mas a estratégia mostrada acima
faz com que seja muito difícil entender o que está acontecendo e em que
ordem (para os nerds lendo isso, é o equivalente de escrever <span
class="math inline">*g*(*f*(*x*))</span> ao invés de <span
class="math inline">*f* ∘ *g*(*x*)</span>). Em R, a solução para esse
problema vem na forma do “<em>pipe</em>”, um operador que nos permite
colocar a primeira função antes da segunda e não dentro dela:
</p>
<pre class="r"><code>car_data &lt;- mtcars %&gt;% subset(hp &gt; 100) %&gt;% aggregate(. ~ cyl, data = ., FUN = . %&gt;% mean %&gt;% round(2)) %&gt;% transform(kpl = mpg %&gt;% multiply_by(0.4251))</code></pre>
<p>
Mas o que mais você mudaria no R? Bem, o próximo lugar que evidentemente
precisa de uma melhoria são so laços…
</p>

<p>
Antes de começarmos a demonstração, você vai precisar de alguns pacotes.
Instale-os rodando o código abaixo:
</p>
<pre class="r"><code>install.packages(c(&quot;devtools&quot;, &quot;purrrr&quot;))
devtools::install_github(&quot;jennybc/repurrrsive&quot;)
library(purrr)</code></pre>
<p>
Agora que temos tudo pronto, vamos conhecer melhor a estrela desse
tutorial! <code>gh\_repos</code> é uma lista multi-nível gigantesca que
pode assustar até os programadores de R mais experientes. Eu vou
renomear <code>gh\_repos</code> para <code>ghr</code> por simplicidade:
</p>
<pre class="r"><code>ghr &lt;- repurrrsive::gh_repos</code></pre>
<p>
Felizmente a sua estrutura é simples o suficiente para que possamos
usá-la para propósitos educacionais. O primeiro nível de
<code>ghr</code> é composto por 6 listas, cada uma representando um
<strong>usuário</strong> do GitHub. Cada uma destas listas é feita de
mais ou menos 30 listas menores representando os
<strong>repositórios</strong> daquele usuário. Cada repositório tem mais
de 60 campos com <strong>informações</strong> sobre o repo; um destes
campos também é uma lista e contém <strong>dados de login</strong>
pertencentes ao dono do repo.
</p>
<img src="http://ctlente.com/purrr-magic/ghr_pt.png" alt="">

<p>
Eu sei que isso não parece muito fácil de entender, mas vamos revisar a
estrutura algumas vezes ainda. Antes de tudo vamos só refrescar as
nossas habilidades com listas e descobrir quantos repositórios o
primeiro usuário em <code>ghr</code> tem:
</p>
<pre class="r"><code>length(ghr[[1]])
# [1] 30</code></pre>
<p>
Nesse pequeno comando estamos selecionando o primeiro elemento do
primeiro nível da lista (<code>ghr\[\[1\]\]</code>) ou, em outras
palavras, estamos escolhendo o primeiro usuário. Ao aplicar
<code>length()</code> neste usuário, podemos ver quantos elementos
ele(a) tem, resultando no número de repositórios pertencentes a ele(a).
De forma geral, se quiséssemos ver quantos campos de informação tem o
terceiro repo deste usuário (ou o comprimento do terceiro elemento do
segundo nível associado ao primeiro elemento do primeiro nível),
poderíamos rodar <code>length(ghr\[\[1\]\]\[\[3\]\])</code>.
</p>

<p>
Agora que você se lembra de como listas funcionam em R, um óbvio
incremento de dificuldade é descobrir quantos repositórios cada usuário
tem. Isso pode ser resolvido com o bom e velho laço <code>for</code>,
aplicando <code>length()</code> a cada elemento do primeiro nível de
<code>ghr</code>:
</p>
<pre class="r"><code>lengths &lt;- c()
for (i in seq_along(ghr)) { lengths &lt;- c(lengths, length(ghr[[i]]))
}
lengths
# [1] 30 30 30 26 30 30</code></pre>
<p>
Mas vamos com calma, tem que existir um jeito mais fácil! Só estamos
iterando em uma lista, por que precisamos de <code>i</code>,
<code>c()</code>, <code>seq\_along()</code>, ou mesmo
<code>lengths</code>? É aqui que o <code>map()</code> entra em jogo, o
carro chefe do pacote <code>purrr</code>. <code>map()</code> é uma
abstração de laços, permitindo que iteremos nos elementos de uma lista e
não em alguma variável auxiliar. Em outras palavras ele aplica uma
funçao em todo elemento de uma lista.
</p>
<pre class="r"><code>map(ghr, length)
# [[1]]
# [1] 30
# # [[2]]
# [1] 30
# # [[3]]
# [1] 30
# # [[4]]
# [1] 26
# # [[5]]
# [1] 30
# # [[6]]
# [1] 30</code></pre>
<p>
Bem, usamos menos linhas de código, mas o que está acontecendo com essa
saída? <code>map()</code> é uma funçao muito genérica, então ela sempre
retorna listas (assim ela não precisa se preocupar com o tipo da saída).
Mas <code>map()</code> tem várias funções irmãs, <code>map\_xxx()</code>
(<code>map\_dbl()</code>, <code>map\_chr()</code>,
<code>map\_lgl()</code>, …), que são capazes de “nivelar” a saída se
você já souber que tipo ela terá. No nosso caso queremos um vetor de
<em>doubles</em>, então usamos <code>map\_dbl()</code>:
</p>
<pre class="r"><code>map_dbl(ghr, length)
# [1] 30 30 30 26 30 30</code></pre>
<p>
Você viu isso?! São apenas 21 caracteres e eles fizeram a mesma coisa
que aquele laço horrível lá em cima!
</p>

<p>
Agora que você já conheceu os princípios fundamentais do
<code>purrr</code>, eu vou lhe apresentar às funções anônimas, outra
funcionalidade interessantíssima do pacote. Elas são funções que podemos
definir dentro de um <code>map()</code> sem ter que nomeá-las,
aparecendo em duas formas: fórmulas e funções.
</p>
<p>
Fórmulas são antecedidas por um til e você não pode controlar o nome de
seus argumentos. Funções por outro lado são, bem, funções normais do R.
Primeiramente vamos ver como fórmulas funcionam:
</p>
<pre class="r"><code>map_dbl(ghr, ~length(.x))
# [1] 30 30 30 26 30 30</code></pre>
<p>
Fórmulas nos permitem passar argumentos para a função sendo mapeada.
Lembre-se de como estamos tirando o comprimento de cada sub-lista de
<code>ghr</code>? Se usarmos a notação-til podemos explicitamente
acessar aquele elemento e colocá-lo onde quisermos dentro da chamada da
função, mas o seu nome será <code>.x</code> independentemente de
qualquer outra coisa.
</p>
<pre class="r"><code>map(1:3, ~runif(2, max = .x))
# [[1]]
# [1] 0.2512402 0.4499058
# # [[2]]
# [1] 1.767479 1.600513
# # [[3]]
# [1] 2.367293 1.263795</code></pre>
<p>
No exemplo acima temos que usar a notação-til porque, se não tivéssemos,
o vetor <code>1:3</code> acabaria sendo usado como o primeiro argumento
de <code>runif()</code>. E falando em argumentos, <code>map()</code>
convenientemente permite que você envie qualquer outro argumento fixo no
final da chamada (note como desta vez <code>1:3</code> é usado
automaticamente como o primeiro argumento).
</p>
<pre class="r"><code>map(1:3, runif, min = 3, max = 6)
# [[1]]
# [1] 3.902211
# # [[2]]
# [1] 4.511896 4.405196
# # [[3]]
# [1] 5.498137 3.940454 5.413348</code></pre>
<p>
E por último mas não menos importante, funções. Elas são muito parecidas
com fórmulas, entretanto aqui você pode nomear os argumentos como quiser
(a desvantagem é que você tem que definir a função de forma bastante
prolixa):
</p>
<pre class="r"><code>map(1:3, function(n) { runif(n, min = 3, max = 6) })
# [[1]]
# [1] 4.54061
# # [[2]]
# [1] 3.557612 4.022569
# # [[3]]
# [1] 3.369300 4.109919 4.095583</code></pre>

<p>
Como você já deve ter percebido, também é possível chamar uma
<code>map()</code> dentro da outra! Isso é muito últil quando queremos
acessar níveis mais profundos de uma lista (como quando falamos sobre
<code>length(ghr\[\[1\]\]\[\[3\]\])</code>). Vamos ver quantos campos de
informação tem cada repo de cada usuário:
</p>
<pre class="r"><code>map(ghr, ~map(.x, length))
# [[1]]
# [[1]][[1]]
# [1] 68
# # [[1]][[2]]
# [1] 68
# # [[1]][[3]]
# [1] 68
# # [[1]][[4]]
# [1] 68
#
# ... map(ghr, ~map_dbl(.x, length))
# [[1]]
# [1] 68 68 68 68 68 68 68 68 68 68 68 68 68 68 68 68 68 68 68
# [20] 68 68 68 68 68 68 68 68 68 68 68
# # [[2]]
# [1] 68 68 68 68 68 68 68 68 68 68 68 68 68 68 68 68 68 68 68
# [20] 68 68 68 68 68 68 68 68 68 68 68
# # ...</code></pre>
<p>
O primeiro comando acima devolve uma lista de listas muito longas, mas
isso se deve somente ao fato de que o <code>map()</code> mais interior
retorna uma lista para cada repo e depois o <code>map()</code> mais de
fora embrulha tudo aquilo em outra lista. Para uma saída mais
inteligente, usar <code>map\_dbl()</code> na chamada mais interna nos
permite devolver um único vetor para cada usuário.
</p>
<p>
No entanto, esse campos contém outras informações preciosas. Até agora
nossa lista permaneceu completamente sem nomes, o que significa que cada
lista de usuário e cada lista de repo não estão marcadas com os nomes
dos usuários e repos. Vamos ver se podemos encontrar os nomes dos
usuários no campo <code>login</code> da lista
<code>$owner&lt;/code&gt; de cada repo (note o uso de &lt;code&gt;map\_chr()&lt;/code&gt;; esse &\#xE9; o equivalente de &lt;code&gt;map\_dbl()&lt;/code&gt; para caracteres):&lt;/p&gt; &lt;pre class="r"&gt;&lt;code&gt;map(ghr, function(user) { map\_chr(user, ~.x$owner$login) }) \# \[\[1\]\] \# \[1\] &quot;gaborcsardi&quot; &quot;gaborcsardi&quot; &quot;gaborcsardi&quot; &quot;gaborcsardi&quot; \# \[5\] &quot;gaborcsardi&quot; &quot;gaborcsardi&quot; &quot;gaborcsardi&quot; &quot;gaborcsardi&quot; \# ... \# \# \[\[2\]\] \# \[1\] &quot;jennybc&quot; &quot;jennybc&quot; &quot;jennybc&quot; &quot;jennybc&quot; &quot;jennybc&quot; \# \[6\] &quot;jennybc&quot; &quot;jennybc&quot; &quot;jennybc&quot; &quot;jennybc&quot; &quot;jennybc&quot; \# ... \# \# ... map(ghr, function(user) { user %&gt;% map\_chr(~.x$owner$login) }) \# ... map(ghr, ~map\_chr(.x, ~.x$owner$login)) \# ...&lt;/code&gt;&lt;/pre&gt; &lt;p&gt;Todos os 3 comandos devolvem exatamente a mesma coisa, mas o primeiro &\#xE9; o mais f&\#xE1;cil de entender. Para cada autor, iteramos em seus repos e acessamos o elemento &lt;code&gt;$owner$login&lt;/code&gt;. O segundo nos mostra que &\#xE9; poss&\#xED;vel mapear um &lt;em&gt;pipe&lt;/em&gt;. O terceiro por sua vez condensa tudo ao m&\#xE1;ximo (note como usamos &lt;code&gt;.x&lt;/code&gt; duas vezes; a primeira vez vem do &lt;code&gt;map()&lt;/code&gt; e representa cada usu&\#xE1;rio, enquanto a segunda vem do &lt;code&gt;map\_chr()&lt;/code&gt; e representa cada repo).&lt;/p&gt; &lt;p&gt;No entanto, todos todos os comandos sofrem de repeti&\#xE7;&\#xE3;o na sa&\#xED;da dado que estamos fazendo a mesma coisa para cada repo dispon&\#xED;vel. J&\#xE1; que s&\#xF3; precisamos dessa informa&\#xE7;&\#xE3;o uma vez para cada usu&\#xE1;rio, podemos usar o bom e velho &lt;code&gt;\[1\]&lt;/code&gt; para pegar apenas o primeiro elemento do vetor retornado por &lt;code&gt;map\_chr()&lt;/code&gt; e depois usar outro &lt;code&gt;map\_chr()&lt;/code&gt; para que n&\#xE3;o precisemos lidar com listas estranhas:&lt;/p&gt; &lt;pre class="r"&gt;&lt;code&gt;map\_chr(ghr, ~map\_chr(.x, ~.x$owner$login)\[1\]) \# \[1\] &quot;gaborcsardi&quot; &quot;jennybc&quot; &quot;jtleek&quot; &quot;juliasilge&quot; \# \[5\] &quot;leeper&quot; &quot;masalmon&quot; &lt;/code&gt;&lt;/pre&gt; &lt;/div&gt; &lt;div id="pipes-e-maps" class="section level2"&gt; &lt;p&gt;Na se&\#xE7;&\#xE3;o acima usamos &lt;code&gt;map()&lt;/code&gt;s com &lt;em&gt;pipes&lt;/em&gt;, e agora vamos usar &lt;em&gt;pipes&lt;/em&gt; com &lt;code&gt;map()&lt;/code&gt;s. Isso deveria ser bastante l&\#xF3;gico dado o &\#xFA;ltimo trecho de c&\#xF3;digo, mas vamos usar o &lt;code&gt;map()&lt;/code&gt; para pegar o login dos usu&\#xE1;rios, usar &lt;code&gt;set\_names()&lt;/code&gt; para dar nomes aos usu&\#xE1;rios de acordo com seus logins e por fim usar &lt;code&gt;pluck()&lt;/code&gt; para selecionar a lista de reposit&\#xF3;rios de &\#x201C;jennybc&\#x201D; (note o ponto em &lt;code&gt;set\_names()&lt;/code&gt;; ele representa o resultado vindo da linha cima, estamos usando ele como o segundo argumento da fun&\#xE7;&\#xE3;o):&lt;/p&gt; &lt;pre class="r"&gt;&lt;code&gt;ghr %&gt;% map\_chr(~map\_chr(.x, ~.x$owner*l**o**g**i**n*)\[1\])name))
}) %&gt;% pluck("jennybc", "eigencoder") \# ... ghr %&gt;%
map(~set\_names(.x, map(.x, ~.x*n**a**m**e*)))name</code> de cada um e
por fim selecionando o repositório <code>eigencoder</code> de Jenny (que
seria equivalente a <code>\[\[2\]\]\[\[30\]\]</code>).
</p>

<p>
O legal de programar é tentar escrever a mesma coisa no mínimo de
caracteres possível (tarefa apelidada de <em>code golf</em>). Antes de
nomearmos tanto usuários e repos, vamos deixar o processo de nomear
usuários seja um pouco mais enxuto:
</p>
<pre class="r"><code>set_names(ghr, map_chr(ghr, ~map_chr(.x, ~.x$owner$login)[1]))
set_names(ghr, map(ghr, ~map(.x, ~.x$owner$login)[[1]]))
set_names(ghr, map(ghr, ~.x[[1]]$owner$login))</code></pre>
<p>
Todos os 3 comandos fazem a mesma coisa, sendo que já vimos o primeiro
antes. O segundo comando aproveita-se do fato de que
<code>set\_names()</code> não precisa receber um vetor como argumento,
uma lista também funciona. O terceiro inverte a ideia de pegar o login
de todos os repos e depois selecionar o primeiro pegando o login apenas
do primeiro repo.
</p>
<p>
Agora que temos a forma mais curta possível de nomear os elementos
principais de <code>ghr</code>, aqui está o que eu chamo de dois coelhos
em uma cajadada:
</p>
<pre class="r"><code>ghr &lt;- ghr %&gt;% set_names(map(., ~.x[[1]]$owner$login)) %&gt;% map(~set_names(.x, map(.x, ~.x$name))) &gt; names(ghr)
# [1] &quot;gaborcsardi&quot; &quot;jennybc&quot; &quot;jtleek&quot; &quot;juliasilge&quot; # [5] &quot;leeper&quot; &quot;masalmon&quot; &gt; names(ghr$jennybc)
# [1] &quot;2013-11_sfu&quot; # [2] &quot;2014-01-27-miami&quot; # [3] &quot;2014-05-12-ubc&quot;
# ...</code></pre>

<p>
Para finalizar esse tutorial, vou criar uma função simples que retorna o
número de estrelas que cada usuário tem. Nessa tarefa temos que iterar
em dois objetos: <code>ghr</code> e os nomes de seus usuários.
</p>
<pre class="r"><code>about &lt;- function(user, name) { stars &lt;- map_dbl(user, ~.x$stargazers_count) %&gt;% sum() message(name, &quot; has &quot;, stars, &quot; stars!&quot;)
} map2(ghr, names(ghr), about)
# gaborcsardi has 289 stars!
# jennybc has 190 stars!
# jtleek has 4910 stars!
# juliasilge has 308 stars!
# leeper has 66 stars!
# masalmon has 47 stars!</code></pre>
<p>
Em <code>about()</code> pegamos a soma da contagem de <em>star
gazers</em> de cara repo de um usuário (usando <code>map\_dbl()</code>,
claro) e depois soltamos a mensagem com o nome. Para fazer isso para
cada usuário de <code>ghr</code>, usuamos a prima mais próxima de
<code>map()</code>: <code>map2()</code>.
</p>
<p>
Essa funçao é anaáloga a <code>map()</code>, mas itera em duas listas ao
invés de somente usa (note que para fórmulas usamos <code>.x</code> no
lugar dos elementos da primeira lsita e <code>.y</code> no lugar dos
elementos da segunda). E agora que você já entende os membros mais
importantes da família <code>map()</code>, aqui está uma lista de todos
os outros que você já pode começar a usar:
</p>
<ul>
<li>
<code>map2\_xxx()</code> (análoga a <code>map\_xxx()</code>)
</li>
<li>
<code>pmap()</code> (com a qual você pode interar em quantos elementos
forem necessários)
</li>
<li>
<code>lmap()</code> (para mapear com funções que recebem e retornam
listas)
</li>
<li>
<code>imap()</code> (para iterar em uma lista e seus nomes, assim como
acabamos de fazer)
</li>
<li>
<code>map\_at()/map\_if()</code> (funções que permitem com que você
filtre quais elementos serão mapeados)
</li>
</ul>

<p>
Esse não foi um post pequeno, mas eu sinto que não poderia ter feito ele
em menos palavras. Mapeamento é um conceito complicado e demorou muito
tempo para que eu entendesse o pouco que eu sei.
</p>
<p>
O pacote <code>purrr</code> é realmente uma ferramenta incrível (na
minha opinião, a mais conveniente e bonita da linguagem R) e é justo
dizer que a <code>map()</code> é grande parte do motivo… Mas ela não é a
única família de funções no pacote!
</p>
<p>
No próximo post falaremos sobre algumas outras funções do
<code>purrr</code>: <code>reduce()</code>, <code>flatten()</code>,
<code>invoke()</code>, <code>modify()</code>, <code>possibly()</code> e
<code>keep()</code>. Enquanto isso, dê uma olhada no
<a href="https://github.com/ctlente">meu github</a>, no de
<a href="https://github.com/jennybc">Jennifer Bryan</a> (autora do
<code>repurrrsive</code>) e no de
<a href="https://github.com/hadley">Hadley Wickham</a> (autor do
<code>purrr</code> e outros pacotes incríveis de R).
</p>

