+++
title = "Fazendo o R Voar com Rcpp"
date = "2017-11-22"
categories = ["mind-and-iron"]
original_url = "http://ctlente.com/pt/rcpp-intro/"
+++

<p>
O que fazer quando precisamos que o nosso script rode mais rápido?
Geralmente a primeira ideia que temos é otimizar o código: reduzir a
quantidade de laços, diminuir o tamanho das estruturas, utilizar
programação paralela, etc… Mas quando se trata de R, temos a
possibilidade de aumentar a velocidade do código sem alterar
praticamente nada da sua estrutura.
</p>
<p>
Neste post darei uma introdução básica ao pacote <code>Rcpp</code>, uma
ferramenta que nos permite rodar código em C++ de dentro do R.
</p>
<p>
C++ é uma linguagem de programação muito famosa e versátil. Ela têm
elementos de programação genérica, imperativa e orientada a objeto e
também fornece uma interface para manipulação de memória de baixo nível.
</p>
<p>
Uma característica interessante do C++ é que ele é <em>extremamente</em>
veloz. Diferentemente do R, ela é uma linguagem compilada, com tipagem
estática e que não fornece tantas abstrações de operações, permitindo
que seu código execute com eficiência incrível.
</p>
<p>
Para explorar os benefícios que o C++ pode trazer para o seu código R,
instale e carregue o pacote <code>Rcpp</code> com os comandos abaixo:
</p>
<pre class="r"><code>install.packages(&quot;Rcpp&quot;)
library(Rcpp)</code></pre>
<p>
Vejamos agora um exemplo simples de como chamar código C++ do R. O jeito
mais fácil de fazer isso é através da função <code>cppFunction()</code>:
ela recebe uma string que será interpretada como uma função em C++.
</p>
<pre class="r"><code>adicao_r &lt;- function(x, y, z) { sum = x + y + z return(sum)
} cppFunction( &quot;int adicao_c(int x, int y, int z) { int sum = x + y + z; return sum; }&quot;) adicao_r(1, 2, 3)
#&gt; [1] 6 adicao_c(1, 2, 3)
#&gt; [1] 6</code></pre>
<p>
Como podemos observar no exemplo acima, ambas as funções têm o mesmo
comportamento apesar de algumas diferenças superficiais. Note como temos
sempre que declarar os tipos das variáveis em C++! Usando a
palavra-chave <code>int</code> deixamos claro para o compilador que uma
variável terá o tipo inteiro e até mesmo que uma função deve retornar um
valor de tipo inteiro. Outra coisa que é importante lembrar é que
precisamos colocar um ponto-e-vírgula após cada comando C++.
</p>

<p>
Normalmente o C++ teria diferenças enormes em relação ao R no seu
tratamento de vetores, mas para a nossa sorte o <code>Rcpp</code> nos
disponibiliza uma biblioteca de estruturas que abstraem o comportamento
do R. No exemplo a seguir temos uma função que recebe um número e vetor
numérico, computa a distância euclidiana entre o valor e o vetor e
retorna um vetor numérico como saída.
</p>
<pre class="r"><code>dist_r &lt;- function(x, ys) { sqrt((x - ys) ^ 2)
} cppFunction( &quot;NumericVector dist_c(double x, NumericVector ys) { int n = ys.size(); NumericVector out(n); for(int i = 0; i &lt; n; i++) { out[i] = sqrt(pow(ys[i] - x, 2.0)); } return out; }&quot;) dist_r(10, 20:25)
#&gt; [1] 10 11 12 13 14 15 dist_c(10, 20:25)
#&gt; [1] 10 11 12 13 14 15</code></pre>
<p>
A estrutura <code>NumericVector</code> abstrai um vetor numérico do R,
nos permitindo trabalhar com ele de uma maneira mais familiar. Com o
método <code>.size()</code> obtemos o seu comprimento (equivalente a
<code>length()</code>) e podemos declarar um novo com o construtor
<code>NumericVector nome(comprimento);</code>. O único ponto de
diferença fundamental entre o C++ e o R é que o primeiro não possui
operações vetorizadas propriamente ditas, fazendo com que precisemos
usar laços para toda e qualquer iteração.
</p>

<p>
Certos aspectos da filosofia do R o tornam uma linguagem extremamente
versátil, mas isso vem com certas desvantagens. Alguns pontos em que a
performance do R deixa a desejar são laço não vetorizáveis (por uma
iteração depender da anterior), funções recursivas e estruturas de dados
complexas.
</p>
<p>
Nestas e em muitas outras situações, usar C++ pode ser extremamente
vantajoso. No exemplo a seguir veremos a diferença entre a performance
de um laço em C++ e um em R; note que esta nem é uma das 3 situações
listadas no parágrafo anterior e que mesmo assim o código em C++ é <em>6
vezes mais rápido</em>.
</p>
<pre class="r"><code>soma_r &lt;- function(v) { total &lt;- 0 for (e in v) { if (e &lt; 0) { total = total - e } else if (e &gt; 0.75) { total = total + e/2 } else { total = total + e } } return(total)
} cppFunction( &quot;double soma_c(NumericVector v) { double total = 0; for (int i = 0; i &lt; v.size(); i++) { if (v[i] &lt; 0) { total -= v[i]; } else if (v[i] &gt; 0.75) { total += v[i]/2; } else { total += v[i]; } } return(total); }&quot;) v &lt;- runif(100000, -1, 1)
microbenchmark::microbenchmark(soma_r(v), soma_c(v))
#&gt; Unit: milliseconds
#&gt; expr min lq mean median uq max neval
#&gt; soma_r(v) 6.105048 6.436608 6.911819 6.718456 7.183266 11.610624 100
#&gt; soma_c(v) 1.045805 1.063956 1.161585 1.097920 1.210052 1.955702 100</code></pre>
<p>
<strong>Obs.</strong>: Os símbolos <code>+=</code> e <code>-=</code> são
equivalentes a <code>a = a +/- b</code>, já o símbolo <code>++</code> é
equivalente a <code>a = a + 1</code>.
</p>

<p>
Com o pacote <code>Rcpp</code>, podemos rodar código em C++ de dentro do
próprio R. Através dessa técnica conseguimos otimizar nosso código ou
mesmo ter acesso a estruturas de dados complexas disponibilizadas pelo
C++.
</p>
<p>
Para saber mais sobre o assunto, dê uma olhada no
<a href="http://adv-r.had.co.nz/Rcpp.html">tutorial</a> escrito por
Hadley Wickham no livro <em>Advanced R</em>. Também recomendo a própria
<a href="http://www.rcpp.org/">página</a> do <code>Rcpp</code> e sua
extensa <a href="http://gallery.rcpp.org/">galeria de exemplos</a>.
</p>
<p>
P.S.: Se você quiser o código completo deste tutorial, disponibilizei
ele em um
<a href="https://gist.github.com/ctlente/8d6c025a8e60319fdba63f247cef164a">Gist</a>.
</p>

