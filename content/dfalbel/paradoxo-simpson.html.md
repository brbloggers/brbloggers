+++
title = "O paradoxo de Simpson"
date = "2016-02-22"
categories = ["dfalbel"]
original_url = "http://dfalbel.github.io/2016/02/paradoxo-simpson.html"
+++

<p class="post">
<article class="post-content">
<p>
Está em fase de pré-venda um
<a href="http://www.amazon.com/Causal-Inference-Statistics-Judea-Pearl/dp/1119186846/ref=sr_1_1?ie=UTF8&amp;qid=1452539578&amp;sr=8-1&amp;keywords=judea+pearl+primer">novo
livro do Judea Pearl</a> sobre inferência causal em estatística. Achei
interessante que no primeiro capítulo do livro,
<a href="http://bayes.cs.ucla.edu/PRIMER/">disponibilizado aqui</a> logo
após a motivação de se estudar causalidade, Pearl fala sobre o
<a href="https://en.wikipedia.org/wiki/Simpson%27s_paradox">paradoxo de
Simpson</a>.
</p>
<p>
Nomeado em memória de Edward Simpson (1922), o primeiro estatístico a
popularizá-lo, o paradoxo refere-se a existência de dados nos quais a
associação estatística que é valida para a população inteira é revertida
em todas as subpopulações, quando consideramos algum agrupamento.
</p>
<p>
O exemplo clássico do Simpson é de um grupo de pacientes doentes que
tiveram a opção de tentar um remédio novo. Os resultados obtidos foram
os seguintes.
</p>
<table>
<thead>
<tr>
<th>
 
</th>
<th>
Drug
</th>
<th>
No drug
</th>
</tr>
</thead>
<tbody>
<tr>
<td>
Men
</td>
<td>
81 out of 87 recovered (93%)
</td>
<td>
234 out of 270 recovered (87%)
</td>
</tr>
<tr>
<td>
Women
</td>
<td>
192 out of 263 recovered (73%)
</td>
<td>
55 out of 80 recovered (69%)
</td>
</tr>
<tr>
<td>
Combined data
</td>
<td>
273 out of 350 recovered (78%)
</td>
<td>
289 out of 350 recovered (83%)
</td>
</tr>
</tbody>
</table>
<p>
Entre todos os que testaram a nova droga, uma porcentagem menor dos que
usaram o remédio se recuperaram do que entre os que não o utilizaram. No
entanto, Os homens que usaram o remédio se recuperaram mais do que os
que não usaram. O Mesmo acontece para as mulheres: a proporção de
recuperação dentre as mulheres que usaram a droga é maior do que dentre
as que não. Isso parece contraditório, se soubermos o sexo do indivíduo,
não importanto qual ele seja, é melhor tratá-lo com o novo remédio, mas
se não soubermos é melhor não tratá-lo com o novo medicamento.
</p>
<p>
<strong>Surge então a dúvida</strong>: se o governo fosse decidir sobre
a adoção de uma política de uso desse novo medicamento, que decisão ele
deveria tomar?
</p>
<p>
A resposta de Pearl, em seu livro, é muito completa. Ele diz:
</p>
<blockquote>
<p>
A resposta não pode ser encontrada em estatística simples. Para poder
decidir se a droga irá ajudar ou prejudicar o paciente, primeiramente é
necessário entender a história por trás dos dados - a história que
geraram os resultados observados. Suponha que sabemos de um fato
adicional: Estrógeno tem um efeito negativo na recuperação, então
mulheres tem menos chance de se recuperar do que os homens, não
importando o novo medicamento. Adicionalmente, como podemos ver pelos
dados, mulheres têm significativamente mais chance de tomar o novo
medicamento do que os homens. Então, a razão pela qual o medicamento
parece ser prejudicial para a população em geral, se selecionarmos um
usuário do medicamente aleatóriamente, essa pessoa tem mais chance de
ser uma mulher, que tem menor chance de recuperação do que uma pessoa
que não tomou o medicamento. (…) Por isso, para analisar corretamente,
precisamos comparar individuos do mesmo gênero, assim assegurando que
qualquer diferença nas taxas de recuperação entre aqueles que tomam ou
não o medicamento <strong>não</strong> é devida à presença do estrógeno.
Isso significa que devemos consultar os dados segregados, que nos mostra
inequivocadamente que o medicamento é útil.
</p>
</blockquote>
<p>
Supondo que o banco de dados que gerou a tabela acima seja da seguinte
forma:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">dados</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">data.frame</span><span class="p">(</span><span class="w"> </span><span class="n">id</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">1</span><span class="o">:</span><span class="m">700</span><span class="p">,</span><span class="w"> </span><span class="n">sexo</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="nf">rep</span><span class="p">(</span><span class="s2">&quot;Homem&quot;</span><span class="p">,</span><span class="w"> </span><span class="m">357</span><span class="p">),</span><span class="w"> </span><span class="nf">rep</span><span class="p">(</span><span class="s2">&quot;Mulher&quot;</span><span class="p">,</span><span class="w"> </span><span class="m">343</span><span class="p">)),</span><span class="w"> </span><span class="n">remedio</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="nf">rep</span><span class="p">(</span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="m">87</span><span class="p">),</span><span class="w"> </span><span class="nf">rep</span><span class="p">(</span><span class="m">0</span><span class="p">,</span><span class="w"> </span><span class="m">270</span><span class="p">),</span><span class="w"> </span><span class="nf">rep</span><span class="p">(</span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="m">263</span><span class="p">),</span><span class="w"> </span><span class="nf">rep</span><span class="p">(</span><span class="m">0</span><span class="p">,</span><span class="w"> </span><span class="m">80</span><span class="p">)),</span><span class="w"> </span><span class="n">recuperou</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="nf">rep</span><span class="p">(</span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="m">81</span><span class="p">),</span><span class="w"> </span><span class="nf">rep</span><span class="p">(</span><span class="m">0</span><span class="p">,</span><span class="w"> </span><span class="m">6</span><span class="p">),</span><span class="w"> </span><span class="nf">rep</span><span class="p">(</span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="m">234</span><span class="p">),</span><span class="w"> </span><span class="nf">rep</span><span class="p">(</span><span class="m">0</span><span class="p">,</span><span class="w"> </span><span class="m">36</span><span class="p">),</span><span class="w"> </span><span class="nf">rep</span><span class="p">(</span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="m">192</span><span class="p">),</span><span class="w"> </span><span class="nf">rep</span><span class="p">(</span><span class="m">0</span><span class="p">,</span><span class="w"> </span><span class="m">71</span><span class="p">),</span><span class="w"> </span><span class="nf">rep</span><span class="p">(</span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="m">55</span><span class="p">),</span><span class="w"> </span><span class="nf">rep</span><span class="p">(</span><span class="m">0</span><span class="p">,</span><span class="w"> </span><span class="m">25</span><span class="p">))</span><span class="w">
</span><span class="p">)</span></code></pre>
</figure>
<p>
Veja que na tabela resumo eles estão iguais:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">library</span><span class="p">(</span><span class="n">dplyr</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## ## Attaching package: &apos;dplyr&apos;</code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## The following objects are masked from &apos;package:stats&apos;:
## ## filter, lag</code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## The following objects are masked from &apos;package:base&apos;:
## ## intersect, setdiff, setequal, union</code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-r"><span class="n">dados</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">group_by</span><span class="p">(</span><span class="n">sexo</span><span class="p">,</span><span class="w"> </span><span class="n">remedio</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">summarise</span><span class="p">(</span><span class="n">n_rec</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">sum</span><span class="p">(</span><span class="n">recuperou</span><span class="p">),</span><span class="w"> </span><span class="n">n</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">n</span><span class="p">())</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## Source: local data frame [4 x 4]
## Groups: sexo [?]
## ## sexo remedio n_rec n
## (fctr) (dbl) (dbl) (int)
## 1 Homem 0 234 270
## 2 Homem 1 81 87
## 3 Mulher 0 55 80
## 4 Mulher 1 192 263</code></pre>
</figure>
<p>
Para estimar o efeito do uso do medicamento na recuperação poderíamos
ajustar um modelo de regressão logística com o seguinte código:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">modelo</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">glm</span><span class="p">(</span><span class="n">recuperou</span><span class="w"> </span><span class="o">~</span><span class="w"> </span><span class="n">sexo</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">remedio</span><span class="p">,</span><span class="w"> </span><span class="n">data</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">dados</span><span class="p">,</span><span class="w"> </span><span class="n">family</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;binomial&quot;</span><span class="p">)</span></code></pre>
</figure>
<p>
Calculamos a probabilidade de recuperação para cada um dos casos
possíveis.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">casos</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">expand.grid</span><span class="p">(</span><span class="n">sexo</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="s2">&quot;Homem&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;Mulher&quot;</span><span class="p">),</span><span class="w"> </span><span class="n">remedio</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="m">1</span><span class="p">,</span><span class="m">0</span><span class="p">))</span><span class="w">
</span><span class="n">casos</span><span class="o">$</span><span class="n">prob</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">predict</span><span class="p">(</span><span class="n">modelo</span><span class="p">,</span><span class="w"> </span><span class="n">newdata</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">casos</span><span class="p">,</span><span class="w"> </span><span class="n">type</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;response&quot;</span><span class="p">)</span></code></pre>
</figure>
<p>
Agora podemos ver que para quem recee o medicamento a probabilidade de
recuperação, não importando o gênero do indivíduo.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">tab</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">casos</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">group_by</span><span class="p">(</span><span class="n">remedio</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">summarise</span><span class="p">(</span><span class="n">p</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">mean</span><span class="p">(</span><span class="n">prob</span><span class="p">))</span><span class="w">
</span><span class="n">tab</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## Source: local data frame [2 x 2]
## ## remedio p
## (dbl) (dbl)
## 1 0 0.7684074
## 2 1 0.8229495</code></pre>
</figure>
<p>
Vemos então que ao tomar o remédio a probabilidade de cura aumenta em
7.1%.
</p>
<p>
A análise incorreta, sem considerar o sexo, mostraria outra conclusão
(vide a tabela abaixo).
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">modelo</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">glm</span><span class="p">(</span><span class="n">recuperou</span><span class="w"> </span><span class="o">~</span><span class="w"> </span><span class="n">remedio</span><span class="p">,</span><span class="w"> </span><span class="n">data</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">dados</span><span class="p">,</span><span class="w"> </span><span class="n">family</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;binomial&quot;</span><span class="p">)</span><span class="w">
</span><span class="n">casos</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">expand.grid</span><span class="p">(</span><span class="n">sexo</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="s2">&quot;Homem&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;Mulher&quot;</span><span class="p">),</span><span class="w"> </span><span class="n">remedio</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="m">1</span><span class="p">,</span><span class="m">0</span><span class="p">))</span><span class="w">
</span><span class="n">casos</span><span class="o">$</span><span class="n">prob</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">predict</span><span class="p">(</span><span class="n">modelo</span><span class="p">,</span><span class="w"> </span><span class="n">newdata</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">casos</span><span class="p">,</span><span class="w"> </span><span class="n">type</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;response&quot;</span><span class="p">)</span><span class="w">
</span><span class="n">tab</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">casos</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">group_by</span><span class="p">(</span><span class="n">remedio</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">summarise</span><span class="p">(</span><span class="n">p</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">mean</span><span class="p">(</span><span class="n">prob</span><span class="p">))</span><span class="w">
</span><span class="n">tab</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## Source: local data frame [2 x 2]
## ## remedio p
## (dbl) (dbl)
## 1 0 0.8257143
## 2 1 0.7800000</code></pre>
</figure>
<p>
Assim seria observada uma queda de -5.54% na probabilidade de
recuperação com o uso do medicamento.
</p>
</article>
<br> <ins class="adsbygoogle"></ins> <br>
</p>

