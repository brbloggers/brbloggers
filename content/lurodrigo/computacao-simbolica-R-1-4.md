+++
title = "Escrevendo um pequeno sistema de computação simbólica em R (Parte 1/4)"
date = "2017-05-02 00:38:00"
categories = ["lurodrigo"]
original_url = "https://lurodrigo.github.io/2017/05/computacao-simbolica-R-1-4"
+++

<p class="page__inner-wrap">
<header>
<p class="page__meta">
<i class="fa fa-clock-o"></i> 11 minutos de leitura
</p>
</header>
<section class="page__content">
<p>
<em>An english version of this post is available
<a href="https://lurodrigo.github.io/2017/05/symbolic-computation-R-1-4/">here</a>.</em>
</p>
<p>
Essa semana me peguei pensando em como pacotes como o
<code class="highlighter-rouge">dplyr</code> utilizam muito recursos de
metaprogramação (isto é, computação sobre a própria linguagem) para
criar funções com grande poder expressivo. Me perguntei: será que é
possível usar isso para manipulação algébrica? Em particular, seria
possível criar uma função que, dada a descrição simbólica de uma função,
computasse sua derivada?
</p>
<p>
Pensei no problema da derivada, em particular, porque é evidente que
encontrar as derivadas de funções elementares é uma mera manipulação
formal (embora tediosa), ao contrário da busca por antiderivadas, que
está muito mais para <em>arte</em> que para algoritmo.
</p>
<p>
Descobri, depois de alguns dias brincando com a ideia, que isso não só é
possível como é possível com relativa facilidade. É um exercício que
ilustra bem como as ferramentas funcionais e de metaprogramação do R se
traduzem em mais concisão e expressividade.
</p>
<p>
Quero que esta linguagem satisfaça quatro requisitos:
</p>
<ol>
<li>
Possa descrever concisamente todas as funções elementares do cálculo,
isto é, aquelas obtidas a partir de polinômios, trigonométricas,
exponenciais e logaritmos.
</li>
<li>
Que as funções expressas possam ser manipuladas simbólica e
numericamente.
</li>
<li>
Possa computar simbolicamente as derivadas destas funções.
</li>
<li>
Que as expressões simbólicas geradas sejam simples, na medida do
possível.
</li>
</ol>
<p>
Quero deixar claro que não sou nenhum especialista em computação
simbólica e que, muito provavelmente, um sistema para uso real-world
precisaria implementar várias otimizações dos algoritmos aqui usados.
</p>
<p>
Mãos à obra, então! Estou usando três pacotes:
<code class="highlighter-rouge">purrr</code>,
<code class="highlighter-rouge">lazyeval</code>, e
<code class="highlighter-rouge">glue</code>. O uso deles será explicado
ao longo do texto.
</p>
<p>
O primeiro detalhe é que quero ter uma função <em>chamável</em>, isto é,
que eu possa avaliar f(x) diretamente para algum número, mas ao mesmo
tempo preciso que ela possa armazenar mais informações, por exemplo, uma
representação em string ou qual é a sua derivada. Para isso, posso usar
os atributos em R.
</p>
<p>
Em R, todo objeto pode guardar dados através da função
<code class="highlighter-rouge">attr()</code>. Pode-se depois acessá-los
via <code class="highlighter-rouge">attr()</code> ou
<code class="highlighter-rouge">%@%</code>. Então basta pegar uma função
matemática ordinária em R e adicionar os dados que forem necessários a
ela via atributos. Também modificarei o método
<code class="highlighter-rouge">print()</code> e o
<code class="highlighter-rouge">as.character</code> delas para que o
trabalho com essas funções no console seja mais agradável. Por último,
criarei uma função para computar simbolicamente a n-ésima derivada.
</p>
<pre class="highlight"><code><span class="n">library</span><span class="p">(</span><span class="n">purrr</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">glue</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">lazyeval</span><span class="p">)</span><span class="w"> </span><span class="n">symbolic</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">f</span><span class="p">,</span><span class="w"> </span><span class="n">repr</span><span class="p">,</span><span class="w"> </span><span class="n">df</span><span class="p">,</span><span class="w"> </span><span class="n">type</span><span class="p">,</span><span class="w"> </span><span class="n">params</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">list</span><span class="p">(),</span><span class="w"> </span><span class="n">inverse</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">NULL</span><span class="p">)</span><span class="w"> </span><span class="p">{</span><span class="w"> </span><span class="nf">class</span><span class="p">(</span><span class="n">f</span><span class="p">)</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="s2">&quot;symbolic&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;function&quot;</span><span class="p">)</span><span class="w"> </span><span class="nf">attr</span><span class="p">(</span><span class="n">f</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;repr&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">repr</span><span class="w"> </span><span class="c1"># uma representa&#xE7;&#xE3;o da fun&#xE7;&#xE3;o, como string
</span><span class="w"> </span><span class="nf">attr</span><span class="p">(</span><span class="n">f</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;df&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">lazy</span><span class="p">(</span><span class="n">df</span><span class="p">)</span><span class="w"> </span><span class="c1"># a derivada da fun&#xE7;&#xE3;o
</span><span class="w"> </span><span class="nf">attr</span><span class="p">(</span><span class="n">f</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;inverse&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">lazy</span><span class="p">(</span><span class="n">inverse</span><span class="p">)</span><span class="w"> </span><span class="c1"># a inversa da fun&#xE7;&#xE3;o. n&#xE3;o ser&#xE1; usada ainda.
</span><span class="w"> </span><span class="nf">attr</span><span class="p">(</span><span class="n">f</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;type&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">type</span><span class="w"> </span><span class="c1"># que tipo de fun&#xE7;&#xE3;o isso &#xE9;
</span><span class="w"> </span><span class="nf">attr</span><span class="p">(</span><span class="n">f</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;params&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">params</span><span class="w"> </span><span class="c1"># os par&#xE2;metros que definem uma fun&#xE7;&#xE3;o daquele tipo
</span><span class="w"> </span><span class="n">f</span><span class="w">
</span><span class="p">}</span><span class="w"> </span><span class="c1"># fun&#xE7;&#xF5;es auxiliares
</span><span class="n">is_symbolic</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">x</span><span class="p">)</span><span class="w"> </span><span class="n">inherits</span><span class="p">(</span><span class="n">x</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;symbolic&quot;</span><span class="p">)</span><span class="w"> </span><span class="n">as.character.symbolic</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">f</span><span class="p">)</span><span class="w"> </span><span class="n">f</span><span class="o">%@%</span><span class="s2">&quot;repr&quot;</span><span class="w"> </span><span class="n">print.symbolic</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">f</span><span class="p">)</span><span class="w"> </span><span class="n">cat</span><span class="p">(</span><span class="n">glue</span><span class="p">(</span><span class="s2">&quot;x -&gt; {f}&quot;</span><span class="p">))</span><span class="w"> </span><span class="c1"># fun&#xE7;&#xE3;o para calcular a n-&#xE9;sima derivada recursivamente
</span><span class="n">D</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">f</span><span class="p">,</span><span class="w"> </span><span class="n">n</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">1</span><span class="p">)</span><span class="w"> </span><span class="p">{</span><span class="w"> </span><span class="k">if</span><span class="w"> </span><span class="p">(</span><span class="n">n</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="m">0</span><span class="p">)</span><span class="w"> </span><span class="c1"># n&#xE3;o faz nada
</span><span class="w"> </span><span class="n">f</span><span class="w"> </span><span class="k">else</span><span class="w"> </span><span class="k">if</span><span class="w"> </span><span class="p">(</span><span class="n">n</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="m">1</span><span class="p">)</span><span class="w"> </span><span class="c1"># se quer a primeira derivada, apenas retorna o atributo df de f
</span><span class="w"> </span><span class="n">lazy_eval</span><span class="p">(</span><span class="n">f</span><span class="o">%@%</span><span class="s2">&quot;df&quot;</span><span class="p">)</span><span class="w"> </span><span class="k">else</span><span class="w"> </span><span class="c1"># se n&#xE3;o, calcula a n-1 &#xE9;sima derivada da sua derivada
</span><span class="w"> </span><span class="n">D</span><span class="p">(</span><span class="n">lazy_eval</span><span class="p">(</span><span class="n">f</span><span class="o">%@%</span><span class="s2">&quot;df&quot;</span><span class="p">),</span><span class="w"> </span><span class="n">n</span><span class="w"> </span><span class="o">-</span><span class="w"> </span><span class="m">1</span><span class="p">)</span><span class="w">
</span><span class="p">}</span><span class="w">
</span></code></pre>

<p>
Uma ferramenta muito importante e usada extensivamente neste projeto é a
<em>lazy evaluation</em>. Isto ficará claro quando eu definir a primeira
função dentro deste sistema: a função nula. Sabe-se que a derivada da
função nula é a própria função nula. Defino-a por uma via aparentemente
circular, que intuitivamente deveria resultar em alguma espécie de erro,
mas não é isso que ocorre. Veja:
</p>
<pre class="highlight"><code><span class="n">Null</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">symbolic</span><span class="p">(</span><span class="w"> </span><span class="n">f</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">x</span><span class="p">)</span><span class="w"> </span><span class="m">0</span><span class="p">,</span><span class="w"> </span><span class="n">repr</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;0&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">df</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">Null</span><span class="p">,</span><span class="w"> </span><span class="n">type</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;null&quot;</span><span class="w">
</span><span class="p">)</span><span class="w"> </span><span class="n">is_nullf</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">x</span><span class="p">)</span><span class="w"> </span><span class="n">x</span><span class="o">%@%</span><span class="s2">&quot;type&quot;</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="s2">&quot;null&quot;</span><span class="w">
</span></code></pre>

<pre class="highlight"><code><span class="n">Null</span><span class="w">
</span><span class="c1">#&gt; x -&gt; 0
</span><span class="n">Null</span><span class="p">(</span><span class="m">5</span><span class="p">)</span><span class="w">
</span><span class="c1">#&gt; [1] 0
</span><span class="n">D</span><span class="p">(</span><span class="n">Null</span><span class="p">)</span><span class="w"> </span><span class="c1"># a pr&#xF3;pria fun&#xE7;&#xE3;o nula
#&gt; x -&gt; 0
</span></code></pre>

<p>
Defino <code class="highlighter-rouge">Null</code> como o resultado de
<code class="highlighter-rouge">symbolic()</code> aplicado a uma lista
de parâmetros e um deles é o próprio
<code class="highlighter-rouge">Null</code>, e mesmo assim tudo funciona
corretamente? O segredo para isso é a função
<code class="highlighter-rouge">lazy()</code>, que é usada no interior
de <code class="highlighter-rouge">symbolic()</code>. Ela captura a
<em>expressão</em> que define a derivada, mas não a executa. De fato,
não preciso computar a derivada de uma função logo que a defino, só
precisamos saber <em>como</em> computá-la, e é precisamente isso que
<code class="highlighter-rouge">lazy(df)</code> faz. Somente em
<code class="highlighter-rouge">D()</code> que preciso ter a derivada
computada de fato, e lá que uso
<code class="highlighter-rouge">lazy\_eval()</code> para obtê-la.
</p>
<p>
Experimente rodar o código anterior retirando as chamadas a
<code class="highlighter-rouge">lazy()</code>. Você irá obter a seguinte
mensagem de erro:
</p>
<pre class="highlight"><code>Error in symbolic(f = function(x) 0, repr = &quot;0&quot;, df = Null, type = &quot;null&quot;) : object &apos;Null&apos; not found
</code></pre>

<p>
Isto ocorre porque <code class="highlighter-rouge">Null</code> ainda não
está definido no momento em que
<code class="highlighter-rouge">symbolic()</code> é chamada. A lazy
evaluation cortorna isto. Ela diz que, quando eu quiser calcular a
derivada de <code class="highlighter-rouge">Null</code>, basta retornar
a própria <code class="highlighter-rouge">Null</code>. Só que quando
isso acontecer, <code class="highlighter-rouge">Null</code> já terá sido
definida. Problema resolvido :)
</p>
<p>
Podemos, então, definir mais alguns tipos de funções:
</p>
<pre class="highlight"><code><span class="n">Const</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">c</span><span class="p">)</span><span class="w"> </span><span class="p">{</span><span class="w"> </span><span class="k">if</span><span class="w"> </span><span class="p">(</span><span class="n">c</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="m">0</span><span class="p">)</span><span class="w"> </span><span class="nf">return</span><span class="p">(</span><span class="n">Null</span><span class="p">)</span><span class="w"> </span><span class="n">symbolic</span><span class="p">(</span><span class="w"> </span><span class="n">f</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">x</span><span class="p">)</span><span class="w"> </span><span class="n">c</span><span class="p">,</span><span class="w"> </span><span class="n">repr</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">as.character</span><span class="p">(</span><span class="n">c</span><span class="p">),</span><span class="w"> </span><span class="n">df</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">Null</span><span class="p">,</span><span class="w"> </span><span class="n">type</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;const&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">params</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">list</span><span class="p">(</span><span class="n">c</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">c</span><span class="p">)</span><span class="w"> </span><span class="p">)</span><span class="w"> </span><span class="p">}</span><span class="w"> </span><span class="n">is_const</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">x</span><span class="p">)</span><span class="w"> </span><span class="n">x</span><span class="o">%@%</span><span class="s2">&quot;type&quot;</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="s2">&quot;const&quot;</span><span class="w"> </span><span class="c1"># Mon&#xF4;mios
</span><span class="n">Mono</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">a</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="n">n</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">1</span><span class="p">)</span><span class="w"> </span><span class="p">{</span><span class="w"> </span><span class="k">if</span><span class="w"> </span><span class="p">(</span><span class="n">a</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="m">0</span><span class="p">)</span><span class="w"> </span><span class="nf">return</span><span class="p">(</span><span class="n">Null</span><span class="p">)</span><span class="w"> </span><span class="k">if</span><span class="w"> </span><span class="p">(</span><span class="n">n</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="m">0</span><span class="p">)</span><span class="w"> </span><span class="nf">return</span><span class="p">(</span><span class="n">Const</span><span class="p">(</span><span class="n">a</span><span class="p">))</span><span class="w"> </span><span class="n">symbolic</span><span class="p">(</span><span class="w"> </span><span class="n">f</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">x</span><span class="p">)</span><span class="w"> </span><span class="n">a</span><span class="o">*</span><span class="n">x</span><span class="o">^</span><span class="n">n</span><span class="p">,</span><span class="w"> </span><span class="n">repr</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">glue</span><span class="p">(</span><span class="s2">&quot;{a}*x^{n}&quot;</span><span class="p">),</span><span class="w"> </span><span class="n">df</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">Mono</span><span class="p">(</span><span class="n">n</span><span class="o">*</span><span class="n">a</span><span class="p">,</span><span class="w"> </span><span class="n">n</span><span class="m">-1</span><span class="p">),</span><span class="w"> </span><span class="n">type</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;mono&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">params</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">list</span><span class="p">(</span><span class="n">a</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">a</span><span class="p">,</span><span class="w"> </span><span class="n">n</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">n</span><span class="p">),</span><span class="w"> </span><span class="n">inverse</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">Mono</span><span class="p">(</span><span class="m">1</span><span class="o">/</span><span class="n">a</span><span class="o">^</span><span class="p">(</span><span class="m">1</span><span class="o">/</span><span class="n">n</span><span class="p">),</span><span class="w"> </span><span class="m">1</span><span class="o">/</span><span class="n">n</span><span class="p">)</span><span class="w"> </span><span class="p">)</span><span class="w">
</span><span class="p">}</span><span class="w"> </span><span class="n">is_mono</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">x</span><span class="p">)</span><span class="w"> </span><span class="n">x</span><span class="o">%@%</span><span class="s2">&quot;type&quot;</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="s2">&quot;mono&quot;</span><span class="w"> </span><span class="n">Log</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">symbolic</span><span class="p">(</span><span class="w"> </span><span class="n">f</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">log</span><span class="p">,</span><span class="w"> </span><span class="n">repr</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;log(x)&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">df</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">Mono</span><span class="p">(</span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="m">-1</span><span class="p">),</span><span class="w"> </span><span class="n">type</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;log&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">inverse</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">Exp</span><span class="w">
</span><span class="p">)</span><span class="w"> </span><span class="n">is_log</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">x</span><span class="p">)</span><span class="w"> </span><span class="n">x</span><span class="o">%@%</span><span class="s2">&quot;type&quot;</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="s2">&quot;log&quot;</span><span class="w"> </span><span class="n">Exp</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">symbolic</span><span class="p">(</span><span class="w"> </span><span class="n">f</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">exp</span><span class="p">,</span><span class="w"> </span><span class="n">repr</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;exp(x)&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">df</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">Exp</span><span class="p">,</span><span class="w"> </span><span class="n">type</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;exp&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">inverse</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">Log</span><span class="w">
</span><span class="p">)</span><span class="w"> </span><span class="n">is_exp</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">x</span><span class="p">)</span><span class="w"> </span><span class="n">x</span><span class="o">%@%</span><span class="s2">&quot;type&quot;</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="s2">&quot;exp&quot;</span><span class="w">
</span></code></pre>

<p>
Sendo estrito, a definição de inversa de monômios que dei só vale para
domínio nos positivos, mas este é o tipo de sofisticação que ainda não
resolverei nesta série de posts. Testando pra ver se está tudo
funcionando corretamente:
</p>
<pre class="highlight"><code><span class="n">f</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">Const</span><span class="p">(</span><span class="m">3</span><span class="p">)</span><span class="w">
</span><span class="n">f</span><span class="p">(</span><span class="m">5</span><span class="p">)</span><span class="w">
</span><span class="c1">#&gt; [1] 3
</span><span class="n">D</span><span class="p">(</span><span class="n">f</span><span class="p">)</span><span class="w">
</span><span class="c1">#&gt; x -&gt; 0
</span><span class="n">D</span><span class="p">(</span><span class="n">f</span><span class="p">,</span><span class="w"> </span><span class="m">2</span><span class="p">)</span><span class="w">
</span><span class="c1">#&gt; x -&gt; 0
</span><span class="w">
</span><span class="n">f</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">Mono</span><span class="p">(</span><span class="m">0.5</span><span class="p">,</span><span class="w"> </span><span class="m">2</span><span class="p">)</span><span class="w">
</span><span class="n">f</span><span class="p">(</span><span class="m">3</span><span class="p">)</span><span class="w">
</span><span class="c1">#&gt; [1] 4.5
</span><span class="n">D</span><span class="p">(</span><span class="n">f</span><span class="p">)</span><span class="w">
</span><span class="c1">#&gt; x -&gt; 1*x^1
</span><span class="n">D</span><span class="p">(</span><span class="n">f</span><span class="p">,</span><span class="w"> </span><span class="m">2</span><span class="p">)</span><span class="w">
</span><span class="c1">#&gt; x -&gt; 1
</span><span class="w">
</span><span class="n">f</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">Log</span><span class="w">
</span><span class="n">f</span><span class="p">(</span><span class="nf">exp</span><span class="p">(</span><span class="m">1</span><span class="p">))</span><span class="w">
</span><span class="c1">#&gt; [1] 1
</span><span class="n">D</span><span class="p">(</span><span class="n">f</span><span class="p">)</span><span class="w">
</span><span class="c1">#&gt; x -&gt; 1*x^-1
</span><span class="n">D</span><span class="p">(</span><span class="n">f</span><span class="p">,</span><span class="w"> </span><span class="m">2</span><span class="p">)</span><span class="w">
</span><span class="c1">#&gt; x -&gt; -1*x^-2
</span><span class="w">
</span><span class="n">f</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">Exp</span><span class="w">
</span><span class="n">f</span><span class="p">(</span><span class="m">1</span><span class="p">)</span><span class="w">
</span><span class="c1">#&gt; [1] 2.718282
</span><span class="n">D</span><span class="p">(</span><span class="n">f</span><span class="p">)</span><span class="w">
</span><span class="c1">#&gt; x -&gt; exp(x)
</span><span class="n">D</span><span class="p">(</span><span class="n">f</span><span class="p">,</span><span class="w"> </span><span class="m">2</span><span class="p">)</span><span class="w">
</span><span class="c1">#&gt; x -&gt; exp(x)
</span></code></pre>

<p>
Até agora conseguimos definir algumas funções elementares, mas ainda não
podemos fazer nada muito divertido com elas. O cálculo começa a ficar
interessante quando podemos definir novas funções através de somas,
produtos e, com destaque especial, composições. No próximo post da série
explicarei como adicionar isto ao sistema. Até lá!
</p>
<p>
O código como encontrado ao final deste post pode ser visto
<a href="https://github.com/lurodrigo/symbolic/blob/master/R/symbolic_01.R">aqui</a>.
</p>
</section>
<footer class="page__meta">
<p class="page__taxonomy">
<strong><i class="fa fa-fw fa-tags"></i> Tags: </strong> <span>
<a href="https://lurodrigo.github.io/tags/#computa&#xE7;&#xE3;o-simb&#xF3;lica" class="page__taxonomy-item">Computação
simbólica</a><span class="sep">, </span>
<a href="https://lurodrigo.github.io/tags/#lazyeval" class="page__taxonomy-item">lazyeval</a><span
class="sep">, </span>
<a href="https://lurodrigo.github.io/tags/#metaprograma&#xE7;&#xE3;o" class="page__taxonomy-item">Metaprogramação</a><span
class="sep">, </span>
<a href="https://lurodrigo.github.io/tags/#programa&#xE7;&#xE3;o-funcional" class="page__taxonomy-item">Programação
funcional</a><span class="sep">, </span>
<a href="https://lurodrigo.github.io/tags/#purrr" class="page__taxonomy-item">purrr</a><span
class="sep">, </span>
<a href="https://lurodrigo.github.io/tags/#r" class="page__taxonomy-item">R</a>
</span>
</p>
<p class="page__taxonomy">
<strong><i class="fa fa-fw fa-folder-open"></i> Categorias: </strong>
<span>
<a href="https://lurodrigo.github.io/categories/#portugu&#xEA;s" class="page__taxonomy-item">Português</a><span
class="sep">, </span>
<a href="https://lurodrigo.github.io/categories/#r" class="page__taxonomy-item">R</a><span
class="sep">, </span>
<a href="https://lurodrigo.github.io/categories/#r-pt" class="page__taxonomy-item">R\_pt</a>
</span>
</p>
<p class="page__date">
<strong><i class="fa fa-fw fa-calendar"></i> Atualizado em:</strong>
<time>May 01, 2017</time>
</p>
</footer>
<section class="page__share">
<a href="https://twitter.com/intent/tweet?via=lu_rodrigo&amp;text=Escrevendo%20um%20pequeno%20sistema%20de%20computa&#xE7;&#xE3;o%20simb&#xF3;lica%20em%20R%20(Parte%201/4)%20https://lurodrigo.github.io/2017/05/computacao-simbolica-R-1-4/" class="btn btn--twitter"><i class="fa fa-fw fa-twitter"></i><span>
Twitter</span></a>
<a href="https://www.facebook.com/sharer/sharer.php?u=https://lurodrigo.github.io/2017/05/computacao-simbolica-R-1-4/" class="btn btn--facebook"><i class="fa fa-fw fa-facebook"></i><span>
Facebook</span></a>
<a href="https://plus.google.com/share?url=https://lurodrigo.github.io/2017/05/computacao-simbolica-R-1-4/" class="btn btn--google-plus"><i class="fa fa-fw fa-google-plus"></i><span>
Google+</span></a>
<a href="https://www.linkedin.com/shareArticle?mini=true&amp;url=https://lurodrigo.github.io/2017/05/computacao-simbolica-R-1-4/" class="btn btn--linkedin"><i class="fa fa-fw fa-linkedin"></i><span>
LinkedIn</span></a>
</section>
</p>

