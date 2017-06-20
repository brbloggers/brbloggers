+++
title = "Testes com Python e Igraph"
date = "2016-11-05 02:00:00"
categories = ["r-python-e-redes"]
original_url = "http://neylsoncrepalde.github.io/2016-11-05-testes-com-python-igraph/"
+++

<article class="blog-post">
<p>
Hoje vamos realizar algumas análises com Python e o famoso pacote
<em>Igraph</em>, uma das biliotecas mais usadas para análise de redes
sociais (SNA) em diversas linguagens. Eu mesmo comecei a trabalhar com
análise de redes usando <em>Igraph</em> no <strong>R</strong>. Hoje,
vamos testar algumas funções do <em>Igraph</em> no Python.
</p>
<p>
Lembrando que estamos usando a distribuição Anaconda do Python 3.5.
Vamos aos códigos.
</p>
<p>
Primeiro, após importar as funções da biblioteca <em>Igraph</em>, vamos
carregar a famosa rede <em>Zachary’s Karate Club</em>.
</p>
<pre class="highlight"><code><span class="kn">from</span> <span class="nn">igraph</span> <span class="kn">import</span> <span class="o">*</span> <span class="n">karate</span> <span class="o">=</span> <span class="n">Nexus</span><span class="o">.</span><span class="n">get</span><span class="p">(</span><span class="s">&quot;karate&quot;</span><span class="p">)</span>
<span class="n">karate</span><span class="o">.</span><span class="n">summary</span><span class="p">()</span>
</code></pre>

<pre class="highlight"><code>&quot;IGRAPH UNW- 34 78 -- Zachary&apos;s karate club network\n+ attr: Author (g), Citation (g), name (g), Faction (v), id (v), name (v), weight (e)&quot;
</code></pre>

<p>
Com o método <code class="highlighter-rouge">summary()</code> podemos
observar que a rede possui 34 vértices e 78 laços. Ele possui alguns
atributos da rede (Autor, Citação e nome), atributos dos vértices
(Facção, id e nome) e um atributo de peso dos laços.
</p>
<p>
Vamos printar a citação correta deste banco de dados.
</p>
<pre class="highlight"><code>&apos;Wayne W. Zachary. An Information Flow Model for Conflict and Fission in Small Groups. Journal of Anthropological Research Vol. 33, No. 4 452-473&apos;
</code></pre>

<p>
Agora, vamos investigar os nomes dos indivíduos.
</p>
<pre class="highlight"><code>[&apos;Mr Hi&apos;, &apos;Actor 2&apos;, &apos;Actor 3&apos;, &apos;Actor 4&apos;, &apos;Actor 5&apos;, &apos;Actor 6&apos;, &apos;Actor 7&apos;, &apos;Actor 8&apos;, &apos;Actor 9&apos;, &apos;Actor 10&apos;, &apos;Actor 11&apos;, &apos;Actor 12&apos;, &apos;Actor 13&apos;, &apos;Actor 14&apos;, &apos;Actor 15&apos;, &apos;Actor 16&apos;, &apos;Actor 17&apos;, &apos;Actor 18&apos;, &apos;Actor 19&apos;, &apos;Actor 20&apos;, &apos;Actor 21&apos;, &apos;Actor 22&apos;, &apos;Actor 23&apos;, &apos;Actor 24&apos;, &apos;Actor 25&apos;, &apos;Actor 26&apos;, &apos;Actor 27&apos;, &apos;Actor 28&apos;, &apos;Actor 29&apos;, &apos;Actor 30&apos;, &apos;Actor 31&apos;, &apos;Actor 32&apos;, &apos;Actor 33&apos;, &apos;John A&apos;]
</code></pre>

<p>
Vamos olhar agora para a “facção” de cada um:
</p>
<pre class="highlight"><code>[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 2.0, 2.0, 1.0, 1.0, 1.0, 1.0, 2.0, 2.0, 1.0, 1.0, 2.0, 1.0, 2.0, 1.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0]
</code></pre>

<p>
Agora, vamos plotar a rede usando os nomes dos indivíduos como
<em>labels</em>, atribuindo cores para cada facção, atribuindo o peso de
cada laço à sua espessura na imagem e fazendo com que o tamanho varie
pela centralidade de grau.
</p>
<pre class="highlight"><code><span class="n">lay</span> <span class="o">=</span> <span class="n">karate</span><span class="o">.</span><span class="n">layout</span><span class="p">(</span><span class="s">&quot;kk&quot;</span><span class="p">)</span>
<span class="n">karate</span><span class="o">.</span><span class="n">vs</span><span class="p">[</span><span class="s">&quot;label&quot;</span><span class="p">]</span> <span class="o">=</span> <span class="n">karate</span><span class="o">.</span><span class="n">vs</span><span class="p">[</span><span class="s">&quot;name&quot;</span><span class="p">]</span> <span class="n">color</span> <span class="o">=</span> <span class="p">[]</span>
<span class="k">for</span> <span class="n">faction</span> <span class="ow">in</span> <span class="n">karate</span><span class="o">.</span><span class="n">vs</span><span class="p">[</span><span class="s">&apos;Faction&apos;</span><span class="p">]:</span> <span class="k">if</span> <span class="n">faction</span> <span class="o">==</span> <span class="mi">1</span><span class="p">:</span> <span class="n">x</span><span class="o">=</span><span class="s">&apos;red&apos;</span> <span class="n">color</span><span class="o">.</span><span class="n">append</span><span class="p">(</span><span class="n">x</span><span class="p">)</span> <span class="k">elif</span> <span class="n">faction</span> <span class="o">==</span> <span class="mi">2</span><span class="p">:</span> <span class="n">x</span><span class="o">=</span><span class="s">&apos;lightgreen&apos;</span> <span class="n">color</span><span class="o">.</span><span class="n">append</span><span class="p">(</span><span class="n">x</span><span class="p">)</span> <span class="n">karate</span><span class="o">.</span><span class="n">vs</span><span class="p">[</span><span class="s">&quot;color&quot;</span><span class="p">]</span> <span class="o">=</span> <span class="n">color</span> <span class="n">plot</span><span class="p">(</span><span class="n">karate</span><span class="p">,</span> <span class="n">bbox</span><span class="o">=</span><span class="p">(</span><span class="mi">600</span><span class="p">,</span><span class="mi">400</span><span class="p">),</span> <span class="n">layout</span><span class="o">=</span><span class="n">lay</span><span class="p">,</span> <span class="n">vertex_size</span><span class="o">=</span><span class="n">karate</span><span class="o">.</span><span class="n">degree</span><span class="p">(),</span> <span class="n">edge_color</span><span class="o">=</span><span class="s">&apos;grey&apos;</span><span class="p">,</span> <span class="n">edge_width</span><span class="o">=</span><span class="n">karate</span><span class="o">.</span><span class="n">es</span><span class="p">[</span><span class="s">&apos;weight&apos;</span><span class="p">])</span><span class="o">.</span><span class="n">show</span><span class="p">()</span>
</code></pre>

<p>
<img src="http://neylsoncrepalde.github.io/img/karate_python.png" alt="">
</p>
<p>
Após alguns testes, verifiquei que o pacote <em>Igraph</em> no R é um
pouco mais eficiente pela liberdade que o R tem em plotagens e por já
ter várias ferramentas implementadas. Eu, por exemplo, tenho trabalhado
muito com os modelos P\* ou <em>ERGM</em>’s. Esses modelos já estão
bastante bem implementados no R no pacote <em>statnet</em>. No Python
precisaríamos programá-lo <em>from scratch</em> o que me dá um certo
pânico só de pensar… Esse esforço já foi feito e o código pode ser
acessado <a href="http://davidmasad.com/blog/ergms-from-scratch/">neste
post</a>.
</p>
<p>
Coisas simples, como adicionar um título a um grafo gerado no Python,
podem ser um pouco trabalhosas (veja
<a href="http://stackoverflow.com/questions/18250684/add-title-and-legend-to-igraph-plots">esta
discussão</a> no StackOverflow).
</p>
<p>
Como já disse em outro post, algumas análises funcionam melhor no R,
outras melhor no Python. Com esses testes, seguirei realizando análises
de redes no R. Já raspagem de dados em rede online…
</p>
</article>
<p class="blog-tags">
Tags: Python 3.5, Social Network Analysis, Igraph
</p>

