+++
title = "Criando nossos próprios verbos no dplyr"
date = "2017-09-30 00:50:00"
categories = ["lurodrigo"]
original_url = "https://lurodrigo.github.io/2017/09/criando-verbos-dplyr"
+++

<section class="page__content">
<p>
Uma das decisões que tomei como programador R esse ano foi usar as
soluções do tidyverse sempre que possível, ainda que pacotes fora dele
oferecessem soluções computacionalmente mais eficientes. Isso implica,
naturalmente, optar pelo dplyr em vez do data.table. O motivo é que,
basicamente, percebi que os recursos computacionais maiores que o dplyr
consome são mais baratos que o tempo que eu levava para tentar lembrar o
que os hieroglifos do data.table significavam um mês depois que haviam
sido escritos.
</p>
<p>
Entretanto, senti falta de algumas conveniências do data.table, em
particular, a possibilidade de alteração de colunas condicional às
linhas. Considere o seguinte exemplo: descobri que, devido a alguma
falha no sistema, todos os voos registrados no dia primeiro de janeiro
aconteceram, na verdade, no dia 7 de setembro. Seria bem simples
corrigir isso usando data.table:
</p>
<pre class="highlight"><code><span class="n">library</span><span class="p">(</span><span class="n">nycflights13</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">data.table</span><span class="p">)</span><span class="w"> </span><span class="n">dt</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">data.table</span><span class="p">(</span><span class="n">flights</span><span class="p">)</span><span class="w">
</span><span class="n">head</span><span class="p">(</span><span class="n">dt</span><span class="p">)</span><span class="w">
</span><span class="c1">#&gt; year month day dep_time sched_dep_time dep_delay arr_time
#&gt; 1: 2013 1 1 517 515 2 830
#&gt; 2: 2013 1 1 533 529 4 850
#&gt; 3: 2013 1 1 542 540 2 923
#&gt; 4: 2013 1 1 544 545 -1 1004
#&gt; 5: 2013 1 1 554 600 -6 812
#&gt; 6: 2013 1 1 554 558 -4 740
#&gt; sched_arr_time arr_delay carrier flight tailnum origin dest air_time
#&gt; 1: 819 11 UA 1545 N14228 EWR IAH 227
#&gt; 2: 830 20 UA 1714 N24211 LGA IAH 227
#&gt; 3: 850 33 AA 1141 N619AA JFK MIA 160
#&gt; 4: 1022 -18 B6 725 N804JB JFK BQN 183
#&gt; 5: 837 -25 DL 461 N668DN LGA ATL 116
#&gt; 6: 728 12 UA 1696 N39463 EWR ORD 150
#&gt; distance hour minute time_hour
#&gt; 1: 1400 5 15 2013-01-01 05:00:00
#&gt; 2: 1416 5 29 2013-01-01 05:00:00
#&gt; 3: 1089 5 40 2013-01-01 05:00:00
#&gt; 4: 1576 5 45 2013-01-01 05:00:00
#&gt; 5: 762 6 0 2013-01-01 06:00:00
#&gt; 6: 719 5 58 2013-01-01 05:00:00
</span><span class="w">
</span><span class="n">dt</span><span class="p">[</span><span class="n">month</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="m">1</span><span class="w"> </span><span class="o">&amp;</span><span class="w"> </span><span class="n">day</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="n">`:=`</span><span class="p">(</span><span class="w"> </span><span class="n">month</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">7</span><span class="p">,</span><span class="w"> </span><span class="n">day</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">7</span><span class="w">
</span><span class="p">)]</span><span class="w"> </span><span class="n">head</span><span class="p">(</span><span class="n">dt</span><span class="p">[,</span><span class="w"> </span><span class="n">.</span><span class="p">(</span><span class="n">month</span><span class="p">,</span><span class="w"> </span><span class="n">day</span><span class="p">)])</span><span class="w">
</span><span class="c1">#&gt; month day
#&gt; 1: 7 7
#&gt; 2: 7 7
#&gt; 3: 7 7
#&gt; 4: 7 7
#&gt; 5: 7 7
#&gt; 6: 7 7
</span></code></pre>

<p>
Infelizmente, o dplyr não possui uma forma tão conveniente de tratar
esses casos. A
<a href="https://github.com/tidyverse/dplyr/issues/631">recomendação
semioficial</a> é usar vários
<code class="highlighter-rouge">ifelse</code>s:
</p>
<pre class="highlight"><code><span class="n">library</span><span class="p">(</span><span class="n">dplyr</span><span class="p">)</span><span class="w"> </span><span class="n">flights</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">mutate</span><span class="p">(</span><span class="w"> </span><span class="n">month</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">ifelse</span><span class="p">(</span><span class="n">month</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="m">1</span><span class="w"> </span><span class="o">&amp;</span><span class="w"> </span><span class="n">day</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="m">7</span><span class="p">,</span><span class="w"> </span><span class="n">month</span><span class="p">),</span><span class="w"> </span><span class="n">day</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">ifelse</span><span class="p">(</span><span class="n">month</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="m">1</span><span class="w"> </span><span class="o">&amp;</span><span class="w"> </span><span class="n">day</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="m">7</span><span class="p">,</span><span class="w"> </span><span class="n">day</span><span class="p">)</span><span class="w"> </span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">select</span><span class="p">(</span><span class="n">month</span><span class="p">,</span><span class="w"> </span><span class="n">day</span><span class="p">)</span><span class="w">
</span><span class="c1">#&gt; # A tibble: 336,776 x 2
#&gt; month day
#&gt; &lt;dbl&gt; &lt;int&gt;
#&gt; 1 7 1
#&gt; 2 7 1
#&gt; 3 7 1
#&gt; 4 7 1
#&gt; 5 7 1
#&gt; 6 7 1
#&gt; 7 7 1
#&gt; 8 7 1
#&gt; 9 7 1
#&gt; 10 7 1
#&gt; # ... with 336,766 more rows
</span></code></pre>

<p>
Opa! Ainda não está correto. Há diferenças semânticas fortes entre o
<code class="highlighter-rouge">:=</code> do data.table e o
<code class="highlighter-rouge">mutate</code>. O data.table primeiro
descobre em quais linhas as operações devem ser realizadas e só depois
as executa. O código dplyr acima não: a condição no
<code class="highlighter-rouge">ifelse</code> é reavaliada a cada coluna
alterada. Além disso, essas operações são feitas no escopo da tabela no
estado em que estava antes da execução de qualquer modificação, enquanto
o <code class="highlighter-rouge">mutate</code> sempre usa seu estado
mais recente. É por isso que o resultado final não é o esperado: no
momento em que a linha
</p>
<pre class="highlight"><code><span class="n">day</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">ifelse</span><span class="p">(</span><span class="n">month</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="m">1</span><span class="w"> </span><span class="o">&amp;</span><span class="w"> </span><span class="n">day</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="m">7</span><span class="p">,</span><span class="w"> </span><span class="n">day</span><span class="p">)</span><span class="w">
</span></code></pre>

<p>
é executada, os valores em <code class="highlighter-rouge">month</code>
já foram modificados para 7 (onde foi o caso), a condição falha e os
valores armazenados em <code class="highlighter-rouge">day</code> não
são alterados. No entanto, um workaround é possível: podemos criar uma
coluna temporária para armazenar o resultado da condição do ifelse e
apagá-la depois das modificações:
</p>
<pre class="highlight"><code><span class="n">flights</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">mutate</span><span class="p">(</span><span class="w"> </span><span class="n">condicao</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">month</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="m">1</span><span class="w"> </span><span class="o">&amp;</span><span class="w"> </span><span class="n">day</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="n">month</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">ifelse</span><span class="p">(</span><span class="n">condicao</span><span class="p">,</span><span class="w"> </span><span class="m">7</span><span class="p">,</span><span class="w"> </span><span class="n">month</span><span class="p">),</span><span class="w"> </span><span class="n">day</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">ifelse</span><span class="p">(</span><span class="n">condicao</span><span class="p">,</span><span class="w"> </span><span class="m">7</span><span class="p">,</span><span class="w"> </span><span class="n">day</span><span class="p">),</span><span class="w"> </span><span class="n">condicao</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">NULL</span><span class="w"> </span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">select</span><span class="p">(</span><span class="n">month</span><span class="p">,</span><span class="w"> </span><span class="n">day</span><span class="p">)</span><span class="w">
</span><span class="c1">#&gt; # A tibble: 336,776 x 2
#&gt; month day
#&gt; &lt;dbl&gt; &lt;dbl&gt;
#&gt; 1 7 7
#&gt; 2 7 7
#&gt; 3 7 7
#&gt; 4 7 7
#&gt; 5 7 7
#&gt; 6 7 7
#&gt; 7 7 7
#&gt; 8 7 7
#&gt; 9 7 7
#&gt; 10 7 7
#&gt; # ... with 336,766 more rows
</span></code></pre>

<p>
Ok, funciona, mas ainda há duas inconveniências em relação à versão
data.table: primeiro, precisamos manipular diretamente uma coluna lógica
temporária, e depois, ainda temos que repetir explicitamente o nome da
coluna dentro dos <code class="highlighter-rouge">ifelse</code>s para
que o valor atual seja mantido quando a condição falhar.
</p>
<p>
Percebi, então, que o <code class="highlighter-rouge">mutate</code> é um
verbo inconveniente nesse tipo de situação. Felizmente, o Tidyverse
lançou, há algum tempo, o framework de <em>tidy evaluation</em> que
permite, entre outras coisas, criar novos verbos para o dplyr com alguma
facilidade. O objetivo desse post é criar verbos que funcionem de forma
similar à sentença <code class="highlighter-rouge">dt\[cond, col :=
val\]</code> do data.table dentro do dplyr.
</p>
<h2 id="criando-o-verbo-transform_where">
Criando o verbo <code class="highlighter-rouge">transform\_where</code>
</h2>
<p>
A solução que desenvolvi para essa situação foi o verbo
<code class="highlighter-rouge">transform\_where</code>. Aqui está um
exemplo do seu funcionamento:
</p>
<pre class="highlight"><code><span class="n">flights</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">transform_where</span><span class="p">(</span><span class="w"> </span><span class="n">month</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="m">1</span><span class="w"> </span><span class="o">&amp;</span><span class="w"> </span><span class="n">day</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="n">month</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">7</span><span class="p">,</span><span class="w"> </span><span class="n">day</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">7</span><span class="w"> </span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">select</span><span class="p">(</span><span class="n">month</span><span class="p">,</span><span class="w"> </span><span class="n">day</span><span class="p">)</span><span class="w">
</span><span class="c1">#&gt; # A tibble: 336,776 x 2
#&gt; month day
#&gt; &lt;dbl&gt; &lt;dbl&gt;
#&gt; 1 7 7
#&gt; 2 7 7
#&gt; 3 7 7
#&gt; 4 7 7
#&gt; 5 7 7
#&gt; 6 7 7
#&gt; 7 7 7
#&gt; 8 7 7
#&gt; 9 7 7
#&gt; 10 7 7
#&gt; # ... with 336,766 more rows
</span></code></pre>

<p>
Tão compacto quanto a versão data.table e ainda tem a vantagem de
produzir código fácil de ler! E quanto código isso levou? Bem, umas dez
linhas:
</p>
<pre class="highlight"><code><span class="n">library</span><span class="p">(</span><span class="n">rlang</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">purrr</span><span class="p">)</span><span class="w"> </span><span class="n">transform_where</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">.data</span><span class="p">,</span><span class="w"> </span><span class="n">condition</span><span class="p">,</span><span class="w"> </span><span class="n">...</span><span class="p">)</span><span class="w"> </span><span class="p">{</span><span class="w"> </span><span class="n">condition</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">enquo</span><span class="p">(</span><span class="n">condition</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">eval_tidy</span><span class="p">(</span><span class="n">.data</span><span class="p">)</span><span class="w"> </span><span class="n">mods</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">quos</span><span class="p">(</span><span class="n">...</span><span class="p">)</span><span class="w"> </span><span class="n">mods</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">map2</span><span class="p">(</span><span class="n">mods</span><span class="p">,</span><span class="w"> </span><span class="nf">names</span><span class="p">(</span><span class="n">mods</span><span class="p">),</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">quoted_expr</span><span class="p">,</span><span class="w"> </span><span class="n">column_name</span><span class="p">)</span><span class="w"> </span><span class="p">{</span><span class="w"> </span><span class="n">quo</span><span class="p">(</span><span class="n">ifelse</span><span class="p">(</span><span class="n">condition</span><span class="p">,</span><span class="w"> </span><span class="o">!!</span><span class="n">quoted_expr</span><span class="p">,</span><span class="w"> </span><span class="o">!!</span><span class="n">sym</span><span class="p">(</span><span class="n">column_name</span><span class="p">)))</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">eval_tidy</span><span class="p">(</span><span class="n">.data</span><span class="p">)</span><span class="w"> </span><span class="p">})</span><span class="w"> </span><span class="n">mutate</span><span class="p">(</span><span class="n">.data</span><span class="p">,</span><span class="w"> </span><span class="o">!!!</span><span class="n">mods</span><span class="p">)</span><span class="w">
</span><span class="p">}</span><span class="w">
</span></code></pre>

<p>
Ok, o código é curto, mas é críptico para quem nunca teve contato com
<em>non-standard evaluation</em> em geral, e com o framework de tidy
evaluation em particular. Vou tentar explicar com algum detalhe como
isso tudo está funcionando. Primeiro, os argumentos:
<code class="highlighter-rouge">.data</code> representa a tabela,
<code class="highlighter-rouge">condition</code> a condição, e
<code class="highlighter-rouge">...</code>, os outros argumentos, isto
é, as modificações que devem ser realizadas.
</p>
<p>
Vamos para a primeira linha.
</p>
<pre class="highlight"><code><span class="n">condition</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">enquo</span><span class="p">(</span><span class="n">condition</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">eval_tidy</span><span class="p">(</span><span class="n">.data</span><span class="p">)</span><span class="w">
</span></code></pre>

<p>
<code class="highlighter-rouge">rlang::enquo</code> é uma função que faz
alguma magia negra para guardar, numa estrutura chamada denominada
<em>quosure</em>, a <em>expressão</em> que foi passada para
<code class="highlighter-rouge">condition</code>, e não seu valor.
Afinal, esse valor sequer é válido ainda, pois
<code class="highlighter-rouge">month == 1 & day == 1</code> não indica
explicitamente em que tabela
<code class="highlighter-rouge">month</code> e
<code class="highlighter-rouge">day</code> estão. É aqui que entra a
função <code class="highlighter-rouge">rlang::eval\_tidy</code>, que
executa a expressão passada a ela dentro do ambiente indicado
(<code class="highlighter-rouge">.data</code>). Agora o interpretador
sabe onde procurar os <code class="highlighter-rouge">month</code> e
<code class="highlighter-rouge">day</code>: são colunas da tabela
<code class="highlighter-rouge">.data</code>, oras! Ao final dessa
linha, condition guardará um vetor lógico, com
<code class="highlighter-rouge">TRUE</code> nas linhas onde a condição
passou e <code class="highlighter-rouge">FALSE</code> onde falhou.
Próxima linha:
</p>
<p>
<code class="highlighter-rouge">rlang::quos</code> faz a mesma coisa que
<code class="highlighter-rouge">enquo</code>, mas para uma lista de
expressões toda de uma vez. No caso em que essa lista tem nomes, eles
também são guardados. Faça o teste:
</p>
<pre class="highlight"><code><span class="n">func</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">...</span><span class="p">)</span><span class="w"> </span><span class="p">{</span><span class="w"> </span><span class="n">print</span><span class="p">(</span><span class="n">quos</span><span class="p">(</span><span class="n">...</span><span class="p">))</span><span class="w">
</span><span class="p">}</span><span class="w"> </span><span class="n">func</span><span class="p">(</span><span class="n">a</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="n">b</span><span class="p">,</span><span class="w"> </span><span class="n">c</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="m">1</span><span class="p">)</span><span class="w">
</span><span class="c1">#&gt; [[1]]
#&gt; &lt;quosure: global&gt;
#&gt; ~a == b
#&gt;
#&gt; [[2]]
#&gt; &lt;quosure: global&gt;
#&gt; ~c + 1
#&gt;
#&gt; attr(,&quot;class&quot;)
#&gt; [1] &quot;quosures&quot;
</span><span class="n">func</span><span class="p">(</span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">x</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="m">2</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">y</span><span class="o">*</span><span class="m">3</span><span class="p">)</span><span class="w">
</span><span class="c1">#&gt; $x
#&gt; &lt;quosure: global&gt;
#&gt; ~x + 2
#&gt;
#&gt; $y
#&gt; &lt;quosure: global&gt;
#&gt; ~y * 3
#&gt;
#&gt; attr(,&quot;class&quot;)
#&gt; [1] &quot;quosures&quot;
</span></code></pre>

<p>
A função a seguir é o coração de todo o processo. Ela transforma uma
expressão <code class="highlighter-rouge">x = expr</code> em
<code class="highlighter-rouge">x = ifelse(condition, expr, x)</code>.
Ou seja, ela transforma assignments simples em expressões complexas
envolvendo condições e <code class="highlighter-rouge">ifelse</code>s,
nos poupando o trabalho de digitá-los.
</p>
<pre class="highlight"><code><span class="k">function</span><span class="p">(</span><span class="n">quoted_expr</span><span class="p">,</span><span class="w"> </span><span class="n">column_name</span><span class="p">)</span><span class="w"> </span><span class="p">{</span><span class="w"> </span><span class="n">quo</span><span class="p">(</span><span class="n">ifelse</span><span class="p">(</span><span class="n">condition</span><span class="p">,</span><span class="w"> </span><span class="o">!!</span><span class="n">quoted_expr</span><span class="p">,</span><span class="w"> </span><span class="o">!!</span><span class="n">sym</span><span class="p">(</span><span class="n">column_name</span><span class="p">)))</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">eval_tidy</span><span class="p">(</span><span class="n">.data</span><span class="p">)</span><span class="w">
</span><span class="p">}</span><span class="w">
</span><span class="c1">#&gt; function(quoted_expr, column_name) {
#&gt; quo(ifelse(condition, !!quoted_expr, !!sym(column_name))) %&gt;%
#&gt; eval_tidy(.data)
#&gt; }
</span></code></pre>

<p>
Essa função tem dois parâmetros:
<code class="highlighter-rouge">quoted\_expr</code>, uma quosure com uma
expressão capturada anteriormente, e
<code class="highlighter-rouge">column\_name</code>, o nome da coluna em
uma string. A função <code class="highlighter-rouge">rlang::quo</code>
salva a expressão passada como parâmetro em uma quosure, e o operador
<code class="highlighter-rouge">!!</code> faz o inverso: transforma uma
quosure numa expressão. A função
<code class="highlighter-rouge">rlang::sym</code>, por sua vez,
transforma uma string em uma expressão (um símbolo, mais
especificamente). Agora já dá pra entender a ação da seguinte linha:
</p>
<pre class="highlight"><code><span class="n">quo</span><span class="p">(</span><span class="n">ifelse</span><span class="p">(</span><span class="n">condition</span><span class="p">,</span><span class="w"> </span><span class="o">!!</span><span class="n">quoted_expr</span><span class="p">,</span><span class="w"> </span><span class="o">!!</span><span class="n">sym</span><span class="p">(</span><span class="n">column_name</span><span class="p">)))</span><span class="w">
</span></code></pre>

<p>
Imaginemos que <code class="highlighter-rouge">quoted\_expr</code> é uma
quosure que guarda a expressão <code class="highlighter-rouge">7</code>
e <code class="highlighter-rouge">column\_name</code> é string
<code class="highlighter-rouge">"month"</code>: após a ação do
<code class="highlighter-rouge">!!</code>, a linha acima equivale a:
</p>
<pre class="highlight"><code><span class="n">quo</span><span class="p">(</span><span class="n">ifelse</span><span class="p">(</span><span class="n">condition</span><span class="p">,</span><span class="w"> </span><span class="m">7</span><span class="p">,</span><span class="w"> </span><span class="n">month</span><span class="p">))</span><span class="w">
</span></code></pre>

<p>
Essa quosure resultante é passada para
<code class="highlighter-rouge">eval\_tidy</code>, que calcula o valor
dessa expressão dentro da tabela
<code class="highlighter-rouge">.data</code>. No fim, a função retorna
um vetor contendo o novo valor da coluna.
</p>
<p>
Para quem não conhece,
<code class="highlighter-rouge">purrr::map2</code> é essencialmente uma
generalização de <code class="highlighter-rouge">lapply</code> que toma
duas listas ou vetores como argumento, além de uma função de dois
parâmetros. Dados <code class="highlighter-rouge">x = c(x1, x2,
x3)</code>, <code class="highlighter-rouge">y = c(y1, y2, y2)</code> e
<code class="highlighter-rouge">f</code>, retorna uma lista
<code class="highlighter-rouge">list(f(x1, y1), f(x2, y2), f(x3,
y3))</code>. Além disso, se o primeiro vetor ou lista tem
<code class="highlighter-rouge">names</code>, esses
<code class="highlighter-rouge">names</code> são mantidos na lista
resultante. Agora já dá pra entender o trecho completo.
</p>
<pre class="highlight"><code><span class="n">mods</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">map2</span><span class="p">(</span><span class="n">mods</span><span class="p">,</span><span class="w"> </span><span class="nf">names</span><span class="p">(</span><span class="n">mods</span><span class="p">),</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">quoted_expr</span><span class="p">,</span><span class="w"> </span><span class="n">column_name</span><span class="p">)</span><span class="w"> </span><span class="p">{</span><span class="w"> </span><span class="n">quo</span><span class="p">(</span><span class="n">ifelse</span><span class="p">(</span><span class="n">condition</span><span class="p">,</span><span class="w"> </span><span class="o">!!</span><span class="n">quoted_expr</span><span class="p">,</span><span class="w"> </span><span class="o">!!</span><span class="n">sym</span><span class="p">(</span><span class="n">column_name</span><span class="p">)))</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">eval_tidy</span><span class="p">(</span><span class="n">.data</span><span class="p">)</span><span class="w">
</span><span class="p">})</span><span class="w">
</span></code></pre>

<p>
Pegamos <code class="highlighter-rouge">mods</code>, uma lista cujos
<code class="highlighter-rouge">names</code> são os nomes das colunas e
cujos valores são expressões, e retornamos uma nova lista com os mesmos
<code class="highlighter-rouge">names</code>, nomes das colunas, mas com
as colunas já calculadas a partir de um
<code class="highlighter-rouge">ifelse</code> adequado.
</p>
<p>
Por último, o operador <code class="highlighter-rouge">!!!</code> é para
<code class="highlighter-rouge">quos</code> o que
<code class="highlighter-rouge">!!</code> é para
<code class="highlighter-rouge">quo</code>: transforma uma lista de
quosures em uma sequência de expressões. Então a última linha,
</p>
<p>
após a ação do <code class="highlighter-rouge">!!!</code>, equivale a
</p>
<pre class="highlight"><code><span class="n">mutate</span><span class="p">(</span><span class="n">.data</span><span class="p">,</span><span class="w"> </span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">vetorx</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">vetory</span><span class="p">)</span><span class="w">
</span></code></pre>

<p>
onde <code class="highlighter-rouge">vetorx</code> e
<code class="highlighter-rouge">vetory</code> são os resultados que
foram obtidos anteriormente após a execução dos
<code class="highlighter-rouge">ifelse</code>s. E pronto! Após todas
essas manipulações de quosures, chegamos ao resultado que queríamos!
</p>
<h2 id="criando-um-mutate_where">
Criando um <code class="highlighter-rouge">mutate\_where</code>:
</h2>
<p>
Eu chamei a função de
<code class="highlighter-rouge">transform\_where</code> ao invés de
<code class="highlighter-rouge">mutate\_where</code> em analogia à
diferença entre as funções
<code class="highlighter-rouge">transform</code> e
<code class="highlighter-rouge">mutate</code>: a primeira executa no
contexto inicial da tabela, e a última, sempre no contexto mais recente.
O exemplo abaixo esclarece a diferença.
</p>
<pre class="highlight"><code><span class="n">df</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">data.frame</span><span class="p">(</span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">1</span><span class="o">:</span><span class="m">5</span><span class="p">)</span><span class="w">
</span><span class="n">df</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">transform</span><span class="p">(</span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">x</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">x</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="m">1</span><span class="p">)</span><span class="w">
</span><span class="c1">#&gt; x y
#&gt; 1 2 2
#&gt; 2 3 3
#&gt; 3 4 4
#&gt; 4 5 5
#&gt; 5 6 6
</span><span class="n">df</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">mutate</span><span class="p">(</span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">x</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">x</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="m">1</span><span class="p">)</span><span class="w">
</span><span class="c1">#&gt; x y
#&gt; 1 2 3
#&gt; 2 3 4
#&gt; 3 4 5
#&gt; 4 5 6
#&gt; 5 6 7
</span></code></pre>

<p>
Eu criei um <code class="highlighter-rouge">transform\_where</code>
porque parecia atender melhor minhas necessidades, mas é possível
conceber situações onde um
<code class="highlighter-rouge">mutate\_where</code> fosse mais
conveniente. É muito mais difícil fazer isso? Não. Eis o código:
</p>
<pre class="highlight"><code><span class="n">mutate_where</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">.data</span><span class="p">,</span><span class="w"> </span><span class="n">condition</span><span class="p">,</span><span class="w"> </span><span class="n">...</span><span class="p">)</span><span class="w"> </span><span class="p">{</span><span class="w"> </span><span class="n">condition</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">enquo</span><span class="p">(</span><span class="n">condition</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">eval_tidy</span><span class="p">(</span><span class="n">.data</span><span class="p">)</span><span class="w"> </span><span class="n">mods</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">quos</span><span class="p">(</span><span class="n">...</span><span class="p">)</span><span class="w"> </span><span class="n">mods</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">map2</span><span class="p">(</span><span class="n">mods</span><span class="p">,</span><span class="w"> </span><span class="nf">names</span><span class="p">(</span><span class="n">mods</span><span class="p">),</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">quoted_expr</span><span class="p">,</span><span class="w"> </span><span class="n">column_name</span><span class="p">)</span><span class="w"> </span><span class="p">{</span><span class="w"> </span><span class="n">quo</span><span class="p">(</span><span class="n">ifelse</span><span class="p">(</span><span class="n">condition</span><span class="p">,</span><span class="w"> </span><span class="o">!!</span><span class="n">quoted_expr</span><span class="p">,</span><span class="w"> </span><span class="o">!!</span><span class="n">sym</span><span class="p">(</span><span class="n">column_name</span><span class="p">)))</span><span class="w"> </span><span class="p">})</span><span class="w"> </span><span class="n">mutate</span><span class="p">(</span><span class="n">.data</span><span class="p">,</span><span class="w"> </span><span class="o">!!!</span><span class="n">mods</span><span class="p">)</span><span class="w">
</span><span class="p">}</span><span class="w">
</span></code></pre>

<p>
Ele é <em>quase</em> igual ao código do
<code class="highlighter-rouge">transform\_where</code>, com uma pequena
diferença: não há um <code class="highlighter-rouge">eval\_tidy</code>
dentro da função auxiliar. Isso faz com que, ao invés de se calcular
logo o valor das colunas modificadas, apenas se substitua as expressões
passadas por expressões envoltas por um
<code class="highlighter-rouge">ifelse</code>. Ao contrário de antes, a
linha
</p>
<p>
não vira
</p>
<pre class="highlight"><code><span class="n">mutate</span><span class="p">(</span><span class="n">.data</span><span class="p">,</span><span class="w"> </span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">vetorx</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">vetory</span><span class="p">)</span><span class="w">
</span></code></pre>

<p>
e sim
</p>
<pre class="highlight"><code><span class="n">mutate</span><span class="p">(</span><span class="n">.data</span><span class="p">,</span><span class="w"> </span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">ifelse</span><span class="p">(</span><span class="n">condition</span><span class="p">,</span><span class="w"> </span><span class="m">7</span><span class="p">,</span><span class="w"> </span><span class="n">x</span><span class="p">),</span><span class="w"> </span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">ifelse</span><span class="p">(</span><span class="n">condition</span><span class="p">,</span><span class="w"> </span><span class="m">7</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="p">))</span><span class="w">
</span></code></pre>

<p>
então essas modificações são executadas com a semântica tradicional do
dplyr, isto é, usando eventualmente os valores modificados que acabaram
de ser computados, em vez dos valores guardados antes da execução da
função.
</p>
<p>
Qual a melhor das duas funções? Depende do contexto. No caso que abriu o
post, certamente um
<code class="highlighter-rouge">transform\_where</code> funciona melhor.
Agora imagine uma situação onde os dados de partida e chegada estivessem
incorretos em algumas linhas. A variável
<code class="highlighter-rouge">air\_time</code>, tempo de voo, também
precisará ser atualizada. Nesse caso, um
<code class="highlighter-rouge">mutate\_where</code> corrigindo os
valores de <code class="highlighter-rouge">dep\_time</code> e
<code class="highlighter-rouge">arr\_time</code> e recalculando
<code class="highlighter-rouge">air\_time</code> como essa diferença
resolverá a situação, enquanto um
<code class="highlighter-rouge">transform\_where</code>, iria, de fato,
manter a coluna <code class="highlighter-rouge">air\_time</code> como
estava antes. Na prática, sempre tenho as duas em mãos.
</p>
<p>
<strong>Exercício para o leitor:</strong> Uma diferença entre o meu
<code class="highlighter-rouge">transform\_where</code> e o
funcionamento do <code class="highlighter-rouge">data.table</code> é que
esse último consegue criar colunas novas, preenchendo-as com
<code class="highlighter-rouge">NA</code> nas linhas onde a condição é
falsa. Sinceramente, esse comportamento me desagrada, por implicar que a
tabela poderá sair com formatos diferentes dependendo de uma condição de
forma nada explícita. De todo modo, como poderíamos modificar
<code class="highlighter-rouge">transform\_where</code> para que ela
tenha esse comportamento?
</p>
</section>

