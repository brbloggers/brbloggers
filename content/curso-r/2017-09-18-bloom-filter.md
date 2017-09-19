+++
title = "Filtros de Bloom em R"
date = "2017-09-18 07:12:00"
categories = ["curso-r"]
original_url = "http://curso-r.com/blog/2017/09/18/2017-09-18-bloom-filter/"
+++

<p>
<a href="https://en.wikipedia.org/wiki/Bloom_filter">Filtro de Bloom</a>
é um algoritmo muito interessante para testar se um elemento pertence a
um conjunto. Ele é considerado uma estrutura de dados probabilística, ou
seja, o resultado pode não estar correto com alguma probabilidade.
Especificamente para o filtro de bloom, existe a possibilidade de falsos
positivos mas não de falsos negativos: o algoritmo pode dizer que o
elemento pertence ao conjunto, mas na verdade não pertencer, mas nunca
dirá que ele não pertence sendo que ele pertence.
</p>
<p>
Bloom Filters são úteis em diversas situações, geralmente relacionadas
ao ganho de velocidade e de espaço que o seu uso pode trazer. Muitos
sistemas de bancos de dados usam bloom filters para reduzir o número de
buscas no disco (ex.
<a href="https://docs.datastax.com/en/cassandra/2.1/cassandra/operations/ops_tuning_bloom_filters_c.html">Cassandra</a>).
O
<a href="https://blog.medium.com/what-are-bloom-filters-1ec2a50c68ff">Medium</a>
usa para evitar recomendar uma paǵina que você já leu. Recentemente,
encontraram até <a href="https://arxiv.org/abs/1706.03993">aplicações
para bloom filters em machine learning</a>.
</p>
<p>
Nesse post vamos implementar uma versão simplificada, nada otimizada dos
filtros de Bloom em R. Mas antes disso, vale a pena ler o
<a href="https://en.wikipedia.org/wiki/Bloom_filter">verbete da
Wikipedia sobre o assunto</a>.
</p>
<p>
Essencialmente, um filtro de bloom é um vetor de <code>TRUE</code>s e
<code>FALSES</code> de tamanho <span class="math inline">*m*</span>.
Inicializamos esse vetor com <code>FALSES</code>. Em seguida para cada
elemento do conjunto que você deseja representar pelo filtro, repetimos
o seguinte processo: Hasheamos o elemento usando <span
class="math inline">*k*</span> funções de hash diferentes. Cada uma
dessas funções indicará um elemento do vetor que deve ser marcado como
<code>TRUE</code>. Armazenamos então esse vetor de bits. São os valores
de <span class="math inline">*m*</span> e de <span
class="math inline">*k*</span> que controlam a probabilidade de falsos
positivos.
</p>
<p>
Veja como podemos criar uma função em R para fazer essas operações. Essa
função inicializa o vetor de bits de tamanho <span
class="math inline">*m*</span> com <code>FALSES</code> e em seguida,
para cada uma das <span class="math inline">*k*</span> funções de hash
(no caso apenas variamos a semente do hash MurMur32) e para cada
elemento de <code>x</code> calculamos o elemento do vetor
<code>vec</code> que deve se tornar <code>TRUE</code>. No final, ela
retorna o vetor <code>vec</code>, onde armazenamos como atributos os
parâmetros usados na sua construção.
</p>
<pre class="r"><code>library(digest)
library(magrittr) criar_vetor_de_bits &lt;- function(x, m = 1000, k = 7){ vec &lt;- rep(FALSE, m) for (i in 1:k) { for (j in 1:length(x)) { hash &lt;- digest(x[j], algo = &quot;murmur32&quot;, serialize = FALSE, seed = i) %&gt;% Rmpfr::mpfr(base = 16) %% m %&gt;% as.integer() vec[hash + 1] &lt;- TRUE } } # armazenamos os par&#xE2;metros usados na constru&#xE7;&#xE3;o attributes(vec) &lt;- list(m = m, k= k) return(vec)
}</code></pre>
<p>
Dado um conjunto de strings, podemos criar o vetor de bits que o
representa.
</p>
<pre class="r"><code>vect &lt;- criar_vetor_de_bits(c(&quot;eu&quot;, &quot;pertenco&quot;, &quot;ao&quot;, &quot;conjunto&quot;, &quot;de&quot;, &quot;strings&quot;), m = 1000, k = 7)</code></pre>
<p>
Agora vamos definir uma função que verifica se uma string pertence ao
conjunto, dada apenas a representação dos bits desse conjunto. Hasheamos
o elemento que desejamos verificar a presença no conjunto com a primeira
função de hash. Se ela indicar um elemento do vetor que já está marcado
com <code>TRUE</code> então continuamos, se não, retorna
<code>FALSE</code> indicando que o elemento não pertence ao conjunto.
Continuamos até acabarem as funções de hash ou até 1 <code>FALSE</code>
ter sido retornado.
</p>
<pre class="r"><code>verificar_presenca &lt;- function(x, vetor_de_bits){ k &lt;- attr(vetor_de_bits, &quot;k&quot;) m &lt;- attr(vetor_de_bits, &quot;m&quot;) for(i in 1:k){ hash &lt;- digest(x, algo = &quot;murmur32&quot;, serialize = FALSE, seed = i) %&gt;% Rmpfr::mpfr(base = 16) %% m %&gt;% as.integer() if(!vetor_de_bits[hash + 1]) { return(FALSE) } } return(TRUE)
} verificar_presenca(&quot;nao&quot;, vect)
verificar_presenca(&quot;eu&quot;, vect)
verificar_presenca(&quot;abc&quot;, vect)</code></pre>
<p>
Com <code>m = 1000</code> e <code>k = 7</code> não consegui encontrar
nenhum falso positivo, mas basta diminuir o tamanho de <code>m</code> e
de <code>k</code> que encontraremos. No verbete da Wikipedia a conta
está bonitinha mas de fato a probabilidade de falsos positivos pode ser
estimada em função dos parâmetros <span class="math inline">*k*</span> e
<span class="math inline">*m*</span> e <span
class="math inline">*n*</span> (tamanho do conjunto representado) é dada
por
</p>
<p>
<span class="math display">
(1 − *e*<sup>−*k**n*/*m*</sup>)<sup>*k*</sup>
</span>
</p>
<p>
No caso apresentado, a probabilidade de colisão é de 1.991256e-10.
</p>

