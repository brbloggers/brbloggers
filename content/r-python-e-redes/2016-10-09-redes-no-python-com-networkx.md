+++
title = "Redes no Python com networkx"
date = "2016-10-09 03:00:00"
categories = ["r-python-e-redes"]
original_url = "http://neylsoncrepalde.github.io/2016-10-09-redes-no-python-com-networkx/"
+++

<article class="blog-post">
<p>
Após um encontro marcante com o prof.
<a href="https://www.facebook.com/taghawinejad">Davoud Taghawi-Nejad</a>
numa disciplina do MQ 2016 de <em>Agent Based Modeling</em> onde fui
iniciado à programação em Python, fiquei com “a pulga atrás da orelha”
sobre o poder dessa linguagem. Após alguma investigação preliminar, além
de descobrir vários comentários de pessoas da área da computação
exaltando a praticidade, facilidade e eficiência da linguagem, descobri
também uma alta integração com <code class="highlighter-rouge">R</code>.
Por que isso acontece?
</p>
<p>
As principais justificativas mobilizadas foram na linha de que há
algumas coisas mais fáceis de serem feitas no R e outras mais fáceis de
serem feitas no Python. O melhor dos dois mundos estaria na utilização
conjunta das duas ferramentas. <em>Agent Based Modeling</em>, por
exemplo, seria mais fácil no Python. A elaboração de modelos
estatísticos mais complexos, como Modelos Hierárquicos ou os Modelos P\*
(ERGM’s) para dados relacionais seriam mais fáceis no R.
</p>
<p>
A partir disso, dedici realizar alguns testes com Python e tentar
descobrir este melhor entre os dois mundos. Hoje vamos trabalhar algumas
análises básicas de Análises de Redes Sociais (ARS) com o módulo
<code class="highlighter-rouge">networkx</code> do Python. Tudo foi
feito com Python 3.5 usando
<a href="https://pythonhosted.org/spyder/">Spyder</a>. Vamos lá!
</p>
<pre class="highlight"><code><span class="kn">import</span> <span class="nn">networkx</span> <span class="kn">as</span> <span class="nn">nx</span>
<span class="kn">import</span> <span class="nn">pandas</span> <span class="kn">as</span> <span class="nn">pd</span>
<span class="kn">import</span> <span class="nn">scipy</span> <span class="kn">as</span> <span class="nn">sp</span>
<span class="kn">from</span> <span class="nn">scipy</span> <span class="kn">import</span> <span class="n">stats</span>
<span class="kn">import</span> <span class="nn">matplotlib.pyplot</span> <span class="kn">as</span> <span class="nn">plt</span> <span class="s">&apos;&apos;&apos;
Importando um arquivo com minha rede pessoal. Voc&#xEA; pode tentar com outro arquivo do Pajek (.net) que possuir.
Caso n&#xE3;o possua, voc&#xEA; pode trabalhar com os dados embutidos no m&#xF3;dulo da rede de casamentos das fam&#xED;lias florentinas.
Para isso, use o comando:
G = nx.florentine_families_graph()
&apos;&apos;&apos;</span>
<span class="n">G</span> <span class="o">=</span> <span class="n">nx</span><span class="o">.</span><span class="n">read_pajek</span><span class="p">(</span><span class="s">&apos;/home/neylson/Documentos/rede_neylson.net&apos;</span><span class="p">)</span>
<span class="n">G</span> <span class="o">=</span> <span class="n">nx</span><span class="o">.</span><span class="n">Graph</span><span class="p">(</span><span class="n">G</span><span class="p">)</span> <span class="c"># Transformando num grafo ao inv&#xE9;s de um Multi-grafo</span> <span class="c"># Plotando a rede</span>
<span class="n">plt</span><span class="o">.</span><span class="n">figure</span><span class="p">(</span><span class="mi">1</span><span class="p">,</span> <span class="n">figsize</span><span class="o">=</span><span class="p">(</span><span class="mi">12</span><span class="p">,</span> <span class="mi">8</span><span class="p">))</span> <span class="c">#definindo o tamanho da figura</span>
<span class="n">pos</span><span class="o">=</span><span class="n">nx</span><span class="o">.</span><span class="n">fruchterman_reingold_layout</span><span class="p">(</span><span class="n">G</span><span class="p">)</span> <span class="c">#definindo o algoritmo do layout</span>
<span class="n">plt</span><span class="o">.</span><span class="n">axis</span><span class="p">(</span><span class="s">&apos;off&apos;</span><span class="p">)</span> <span class="c">#retira as bordas</span>
<span class="n">nx</span><span class="o">.</span><span class="n">draw_networkx_nodes</span><span class="p">(</span><span class="n">G</span><span class="p">,</span><span class="n">pos</span><span class="p">,</span><span class="n">node_size</span><span class="o">=</span><span class="mi">50</span><span class="p">)</span> <span class="c">#plota os nodes</span>
<span class="n">nx</span><span class="o">.</span><span class="n">draw_networkx_edges</span><span class="p">(</span><span class="n">G</span><span class="p">,</span><span class="n">pos</span><span class="p">,</span><span class="n">alpha</span><span class="o">=</span><span class="mf">0.4</span><span class="p">)</span> <span class="c">#plota os ties</span>
<span class="n">plt</span><span class="o">.</span><span class="n">title</span><span class="p">(</span><span class="s">&apos;Egonet - Neylson&apos;</span><span class="p">,</span> <span class="n">size</span><span class="o">=</span><span class="mi">16</span><span class="p">)</span> <span class="c">#T&#xED;tulo</span>
<span class="n">plt</span><span class="o">.</span><span class="n">show</span><span class="p">()</span> <span class="c">#plota</span>
</code></pre>

<p>
<img src="http://neylsoncrepalde.github.io/img/redes_no_python/output_1_0.png" alt="">
</p>
<p>
Agora vamos tirar algumas métricas conhecidas da ARS.
</p>
<pre class="highlight"><code><span class="c"># Calculando o grau para cada n&#xF3;</span>
<span class="n">deg</span> <span class="o">=</span> <span class="n">nx</span><span class="o">.</span><span class="n">degree</span><span class="p">(</span><span class="n">G</span><span class="p">)</span>
<span class="c"># Transforma num DataFrame (pandas)</span>
<span class="n">degree</span> <span class="o">=</span> <span class="n">pd</span><span class="o">.</span><span class="n">DataFrame</span><span class="o">.</span><span class="n">from_dict</span><span class="p">(</span><span class="n">data</span><span class="o">=</span><span class="n">deg</span><span class="p">,</span> <span class="n">orient</span><span class="o">=</span><span class="s">&apos;index&apos;</span><span class="p">)</span>
<span class="c"># Apresenta apenas os valores do dicion&#xE1;rio com os graus</span>
<span class="n">deg</span><span class="o">.</span><span class="n">values</span><span class="p">()</span>
</code></pre>

<pre class="highlight"><code>dict_values([8, 24, 19, 19, 24, 19, 30, 4, 24, 5, 24, 4, 24, 19, 1, 24, 2, 19, 19, 1, 3, 23, 5, 24, 1, 35, 30, 24, 8, 5, 19, 8, 7, 1, 3, 5, 1, 3, 24, 19, 24, 1, 3, 8, 23, 19, 24, 8, 2, 24, 23, 19, 19, 1, 19, 24, 19, 19, 4, 24, 19, 24, 6, 24, 3, 19, 24, 19, 24, 2, 5, 1, 3, 4, 25, 1, 26, 19, 8, 24, 8, 2])
</code></pre>

<pre class="highlight"><code><span class="c"># Calcula as centralidades de intermedia&#xE7;&#xE3;o</span>
<span class="n">bet</span> <span class="o">=</span> <span class="n">nx</span><span class="o">.</span><span class="n">betweenness_centrality</span><span class="p">(</span><span class="n">G</span><span class="p">,</span> <span class="n">normalized</span><span class="o">=</span><span class="bp">False</span><span class="p">)</span>
<span class="c"># Transforma em DataFrame (pandas)</span>
<span class="n">between</span> <span class="o">=</span> <span class="n">pd</span><span class="o">.</span><span class="n">DataFrame</span><span class="o">.</span><span class="n">from_dict</span><span class="p">(</span><span class="n">data</span><span class="o">=</span><span class="n">bet</span><span class="p">,</span> <span class="n">orient</span><span class="o">=</span><span class="s">&apos;index&apos;</span><span class="p">)</span>
<span class="c"># Apresenta apenas os valores do dicion&#xE1;rio com as centralidades de intermedia&#xE7;&#xE3;o</span>
<span class="n">bet</span><span class="o">.</span><span class="n">values</span><span class="p">()</span>
</code></pre>

<pre class="highlight"><code>dict_values([0.0, 1.913043478260871, 0.0, 0.0, 1.913043478260871, 0.0, 633.5, 0.0, 1.913043478260871, 0.0, 1.913043478260871, 0.0, 1.913043478260871, 0.0, 0.0, 1.913043478260871, 0.0, 0.0, 0.0, 0.0, 0.0, 1.8695652173913055, 192.0, 1.913043478260871, 0.0, 1461.0434782608695, 633.5, 1.913043478260871, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 0.0, 2.0, 1.913043478260871, 0.0, 1.913043478260871, 0.0, 0.0, 0.0, 1.8695652173913055, 0.0, 1.913043478260871, 0.0, 0.0, 1.913043478260871, 0.043478260869565216, 0.0, 0.0, 0.0, 0.0, 1.913043478260871, 0.0, 0.0, 0.0, 1.913043478260871, 0.0, 1.913043478260871, 2.0, 1.913043478260871, 0.0, 0.0, 1.913043478260871, 0.0, 1.913043478260871, 0.0, 0.0, 0.0, 0.0, 0.0, 13.913043478260885, 0.0, 1.913043478260871, 0.0, 0.0, 1.913043478260871, 0.0, 0.0])
</code></pre>

<p>
Agora vamos investigar um pouco as distribuições do grau e da
centralidade betweeness. Vamos pedir estatísticas descritivas dessas
variáveis com o comando
<code class="highlighter-rouge">stats.describe()</code>.
</p>
<pre class="highlight"><code>DescribeResult(nobs=82, minmax=(array([ 0.]), array([ 1461.04347826])), mean=array([ 36.3902439]), variance=array([ 35381.05947516]), skewness=array([ 6.192137]), kurtosis=array([ 40.67356702]))
</code></pre>

<pre class="highlight"><code>DescribeResult(nobs=82, minmax=(array([1]), array([35])), mean=array([ 14.12195122]), variance=array([ 96.33062331]), skewness=array([-0.04715037]), kurtosis=array([-1.51965044]))
</code></pre>

<p>
Vamos agora plotar as distribuições de grau e de centralidade de
intermediação em histogramas.
</p>
<pre class="highlight"><code><span class="n">plt</span><span class="o">.</span><span class="n">hist</span><span class="p">(</span><span class="n">degree</span><span class="p">,</span> <span class="n">color</span><span class="o">=</span><span class="s">&quot;green&quot;</span><span class="p">,</span> <span class="n">alpha</span><span class="o">=.</span><span class="mi">5</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">title</span><span class="p">(</span><span class="s">&apos;Histograma do Grau&apos;</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">show</span><span class="p">()</span>
</code></pre>

<p>
<img src="http://neylsoncrepalde.github.io/img/redes_no_python/output_9_0.png" alt="">
</p>
<pre class="highlight"><code><span class="n">plt</span><span class="o">.</span><span class="n">hist</span><span class="p">(</span><span class="n">between</span><span class="p">,</span> <span class="n">color</span><span class="o">=</span><span class="s">&quot;yellow&quot;</span><span class="p">,</span> <span class="n">alpha</span><span class="o">=.</span><span class="mi">5</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">title</span><span class="p">(</span><span class="s">&apos;Histograma da centralidade Betweenness&apos;</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">show</span><span class="p">()</span>
</code></pre>

<p>
<img src="http://neylsoncrepalde.github.io/img/redes_no_python/output_10_0.png" alt="">
</p>
<p>
Vamos investigar a densidade desse grafo. A densidade é uma medida que
mostra o quão conectada é uma rede. A densidade delta pode ser definida
por
</p>
<p>
<img src="http://neylsoncrepalde.github.io/img/redes_no_python/formula_densidade.png" alt="">
</p>
<p>
onde g é o número de vértices e L é o número de laços observados. Em
suma, esta medida é calculada com o <em>número de laços observados sobre
o número de laços possíveis na rede</em>.
</p>
<pre class="highlight"><code><span class="c"># Investigando a densidade</span>
<span class="n">densidade</span> <span class="o">=</span> <span class="n">nx</span><span class="o">.</span><span class="n">density</span><span class="p">(</span><span class="n">G</span><span class="p">)</span>
<span class="n">densidade</span>
</code></pre>

<p>
Agora, vamos plotar a rede novamente fazendo com que o tamanho dos
vértices varie por grau e por centralidade de intermediação.
</p>
<pre class="highlight"><code><span class="n">plt</span><span class="o">.</span><span class="n">figure</span><span class="p">(</span><span class="mi">1</span><span class="p">,</span> <span class="n">figsize</span><span class="o">=</span><span class="p">(</span><span class="mi">12</span><span class="p">,</span> <span class="mi">8</span><span class="p">))</span>
<span class="n">pos</span><span class="o">=</span><span class="n">nx</span><span class="o">.</span><span class="n">fruchterman_reingold_layout</span><span class="p">(</span><span class="n">G</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">axis</span><span class="p">(</span><span class="s">&apos;off&apos;</span><span class="p">)</span>
<span class="n">nx</span><span class="o">.</span><span class="n">draw_networkx_nodes</span><span class="p">(</span><span class="n">G</span><span class="p">,</span><span class="n">pos</span><span class="p">,</span><span class="n">node_size</span><span class="o">=</span><span class="n">degree</span><span class="o">*</span><span class="mi">5</span><span class="p">)</span>
<span class="n">nx</span><span class="o">.</span><span class="n">draw_networkx_edges</span><span class="p">(</span><span class="n">G</span><span class="p">,</span><span class="n">pos</span><span class="p">,</span><span class="n">alpha</span><span class="o">=</span><span class="mf">0.4</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">title</span><span class="p">(</span><span class="s">&apos;Egonet - Neylson</span><span class="se">\n</span><span class="s">Tamanho = Degree&apos;</span><span class="p">,</span> <span class="n">size</span><span class="o">=</span><span class="mi">16</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">show</span><span class="p">()</span>
</code></pre>

<p>
<img src="http://neylsoncrepalde.github.io/img/redes_no_python/output_14_0.png" alt="">
</p>
<p>
Agora o tamanho variando por centralidade “betweenness”.
</p>
<pre class="highlight"><code><span class="n">plt</span><span class="o">.</span><span class="n">figure</span><span class="p">(</span><span class="mi">1</span><span class="p">,</span> <span class="n">figsize</span><span class="o">=</span><span class="p">(</span><span class="mi">12</span><span class="p">,</span> <span class="mi">8</span><span class="p">))</span>
<span class="n">pos</span><span class="o">=</span><span class="n">nx</span><span class="o">.</span><span class="n">fruchterman_reingold_layout</span><span class="p">(</span><span class="n">G</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">axis</span><span class="p">(</span><span class="s">&apos;off&apos;</span><span class="p">)</span>
<span class="n">nx</span><span class="o">.</span><span class="n">draw_networkx_nodes</span><span class="p">(</span><span class="n">G</span><span class="p">,</span><span class="n">pos</span><span class="p">,</span><span class="n">node_size</span><span class="o">=</span><span class="n">between</span><span class="p">)</span>
<span class="n">nx</span><span class="o">.</span><span class="n">draw_networkx_edges</span><span class="p">(</span><span class="n">G</span><span class="p">,</span><span class="n">pos</span><span class="p">,</span><span class="n">alpha</span><span class="o">=</span><span class="mf">0.4</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">title</span><span class="p">(</span><span class="s">&apos;Egonet - Neylson</span><span class="se">\n</span><span class="s">Tamanho = Centralidade Betweenness&apos;</span><span class="p">,</span> <span class="n">size</span><span class="o">=</span><span class="mi">16</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">show</span><span class="p">()</span>
</code></pre>

<p>
<img src="http://neylsoncrepalde.github.io/img/redes_no_python/output_16_0.png" alt="">
</p>
<p>
É muito comum em redes extraírmos apenas o <em>componente gigante</em>
ou <em>componente principal</em>, isto é, a maior estrutura conectada da
rede. Algumas medidas só são possíveis numa estrutura conectada. Um
exemplo é a medida de <em>diâmetro</em>, ou seja, a maior distância
geodésica encontrada na rede. É necessário extrair o componente
principal porque se tentarmos calcular o diâmetro de uma estrutura
disconexa nos depararemos com uma distância infinita. Veja como a
densidade muda dentro do componente principal.
</p>
<pre class="highlight"><code><span class="c"># Extraindo o componente gigante</span>
<span class="n">giant</span> <span class="o">=</span> <span class="nb">max</span><span class="p">(</span><span class="n">nx</span><span class="o">.</span><span class="n">connected_component_subgraphs</span><span class="p">(</span><span class="n">G</span><span class="p">),</span> <span class="n">key</span><span class="o">=</span><span class="nb">len</span><span class="p">)</span> <span class="c">#Calculando a densidade</span>
<span class="n">dens</span> <span class="o">=</span> <span class="n">nx</span><span class="o">.</span><span class="n">density</span><span class="p">(</span><span class="n">giant</span><span class="p">)</span>
<span class="n">dens</span>
</code></pre>

<p>
Vamos agora plotar o componente principal.
</p>
<pre class="highlight"><code><span class="n">plt</span><span class="o">.</span><span class="n">figure</span><span class="p">(</span><span class="mi">1</span><span class="p">,</span> <span class="n">figsize</span><span class="o">=</span><span class="p">(</span><span class="mi">12</span><span class="p">,</span><span class="mi">8</span><span class="p">))</span>
<span class="n">pos</span><span class="o">=</span><span class="n">nx</span><span class="o">.</span><span class="n">fruchterman_reingold_layout</span><span class="p">(</span><span class="n">giant</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">axis</span><span class="p">(</span><span class="s">&apos;off&apos;</span><span class="p">)</span>
<span class="n">nx</span><span class="o">.</span><span class="n">draw_networkx_nodes</span><span class="p">(</span><span class="n">giant</span><span class="p">,</span><span class="n">pos</span><span class="p">,</span><span class="n">node_size</span><span class="o">=</span><span class="mi">60</span><span class="p">,</span><span class="n">node_color</span><span class="o">=</span><span class="s">&apos;lightgreen&apos;</span><span class="p">)</span>
<span class="n">nx</span><span class="o">.</span><span class="n">draw_networkx_edges</span><span class="p">(</span><span class="n">giant</span><span class="p">,</span><span class="n">pos</span><span class="p">,</span><span class="n">alpha</span><span class="o">=.</span><span class="mi">4</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">title</span><span class="p">(</span><span class="s">&apos;Egonet - Neylson</span><span class="se">\n</span><span class="s">Giant Component&apos;</span><span class="p">,</span> <span class="n">size</span><span class="o">=</span><span class="mi">16</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">show</span><span class="p">()</span>
</code></pre>

<p>
<img src="http://neylsoncrepalde.github.io/img/redes_no_python/output_21_0.png" alt="">
</p>
<p>
Vamos agora investigar o grau médio do componente principal.
</p>
<pre class="highlight"><code><span class="n">grau</span> <span class="o">=</span> <span class="n">pd</span><span class="o">.</span><span class="n">DataFrame</span><span class="o">.</span><span class="n">from_dict</span><span class="p">(</span><span class="n">nx</span><span class="o">.</span><span class="n">degree</span><span class="p">(</span><span class="n">giant</span><span class="p">),</span> <span class="n">orient</span><span class="o">=</span><span class="s">&apos;index&apos;</span><span class="p">)</span>
<span class="k">print</span><span class="p">(</span><span class="s">&apos;Grau m&#xE9;dio do componente principal: &apos;</span> <span class="o">+</span> <span class="nb">str</span><span class="p">(</span><span class="n">sp</span><span class="o">.</span><span class="n">mean</span><span class="p">(</span><span class="n">grau</span><span class="p">)[</span><span class="mi">0</span><span class="p">]))</span>
</code></pre>

<pre class="highlight"><code>Grau m&#xE9;dio do componente principal: 16.5882352941
</code></pre>

<p>
Vamos investigar as estatísticas descritivas da variável
<strong>grau</strong> para o componente principal.
</p>
<pre class="highlight"><code>DescribeResult(nobs=68, minmax=(array([2]), array([35])), mean=array([ 16.58823529]), variance=array([ 79.79806848]), skewness=array([-0.39919466]), kurtosis=array([-1.16243315]))
</code></pre>

<p>
Agora, vamos investigar a assortatividade do componente principal. A
assortatividade é uma medida de correlação que mostra se nós com grau
alto se conectam a nós de mesmo grau ou parecidos (assortativa) ou se
nós de grau alto se conectam com nós de graus diferentes
(disassortativo). A medida é calculada por
</p>
<p>
<img src="http://neylsoncrepalde.github.io/img/redes_no_python/formula_rho.png" alt="">
</p>
<p>
onde ejk é o excesso conjunto da probabilidade dos graus de j e de k, q
é a distribuição normalizada do grau excedente de um nó aleatório e o
denominador sigma q ao quadrado é a variância de q. Vamos ao escore:
</p>
<pre class="highlight"><code><span class="n">r</span> <span class="o">=</span> <span class="n">nx</span><span class="o">.</span><span class="n">degree_assortativity_coefficient</span><span class="p">(</span><span class="n">giant</span><span class="p">)</span>
<span class="n">r</span>
</code></pre>

<p>
O rho de 0.35 mostra que a rede é assortativa, ou seja, nós com alto
grau relacionam-se entre si.
</p>
<p>
Por hoje é isso! Dúvidas, comentários, elogios e críticas, deixe aqui no
final do post. Grande abraço!
</p>
</article>
<p class="blog-tags">
Tags: Python 3.5, Redes, Social Network Analysis
</p>

