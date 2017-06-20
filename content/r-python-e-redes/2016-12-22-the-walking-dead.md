+++
title = "The Walking DEAD - um modelo de difusão social para o apocalipse zumbi!"
date = "2016-12-22 02:00:00"
categories = ["r-python-e-redes"]
original_url = "http://neylsoncrepalde.github.io/2016-12-22-the-walking-dead/"
+++

<article class="blog-post">
<p>
Por uma série de motivos (inclua-se aqui meu problema de pesquisa de
tese, curiosidade sobre ABM’s, o vício da minha cunhada em Netflix)
cheguei até o excelente artigo de Riebling e Schmitz (2016) intitulado
<strong>ZombieApocalypse: Modeling the social dynamics of infection and
rejection.</strong> O artigo é aberto e pode ser visualizado
<a href="http://journals.sagepub.com/doi/full/10.1177/2059799115622767">aqui</a>.
Sua ideia é bastante engenhosa: eles usam um modelo de difusão em redes
(<em>network diffusion model</em>) para modelizar o alastrar de uma
infecção zumbi generalizada. Neste post, vamos replicar uma versão
simples do modelo tentando entender a implementação de um modelo de
simulação computacional de agentes em redes. O post foi amplamente
inspirado num Jupyter Notebook publicado pelos autores e que pode ser
conferido
<a href="https://github.com/jrriebling/ZombieApocalypseSim">aqui</a>.
</p>
<p>
<img src="http://weknowyourdreams.com/images/zombies/zombies-04.jpg" alt="">
</p>
<p>
Os modelos de difusão são amplamente utilizados para estudar padrões de
infecção e contágio na área da saúde utilizando técnicas da Análise de
Redes Sociais (ARS). São um tipo de <em>Agent Based Modeling</em> ou
Modelagem Baseada em Agentes, modelos onde agentes e suas ações são
simulados computacionalmente. O
<a href="https://www.facebook.com/rogerio.barbosa.7528">Rogério
Barbosa</a> tem uma série de posts muito bons sobre o método que podem
ser vistos
<a href="https://sociaisemetodos.wordpress.com/2016/04/20/cachorros-artificiais-agentes-de-agent-based-modeling-usando-r-parte-1/">aqui</a>.
Na implementação desse tipo de modelos, o pesquisador programa as
características dos agentes e do mundo social mais fundamentais de que
precisa para tentar entender como os fenômenos no nível macro emergem
das interações.
</p>
<p>
Para simular o <em>The Walking Dead</em>, vamos usar a distribuição
Anaconda do Python 3.5. A distribuição pode ser baixada
<a href="https://www.continuum.io/downloads">aqui</a>. Se é a primeira
vez que você instala o Python, é importante instalar também alguns
pacotes que não vem como <em>default</em> na distro Anaconda.
</p>
<p>
Se você é usuário de Windows, abra o prompt de comando clicando no botão
do Windows e pesquisando por <code class="highlighter-rouge">cmd</code>.
Se você é usuário de Ubuntu, abra o terminal com
<code class="highlighter-rouge">Ctrl + Alt + t</code>. Para instalar os
pacotes, use os comandos:
</p>
<pre><code class="language-linux">pip install simpy
pip install networkx
pip install nxsim
</code></pre>
<p>
Vamos aos códigos.
</p>
<h2 id="carregando-as-bibliotecas">
Carregando as bibliotecas
</h2>
<pre class="highlight"><code><span class="kn">import</span> <span class="nn">matplotlib.pyplot</span> <span class="kn">as</span> <span class="nn">plt</span>
<span class="kn">import</span> <span class="nn">networkx</span> <span class="kn">as</span> <span class="nn">nx</span>
<span class="kn">import</span> <span class="nn">pandas</span> <span class="kn">as</span> <span class="nn">pd</span>
<span class="kn">import</span> <span class="nn">numpy</span> <span class="kn">as</span> <span class="nn">np</span>
<span class="kn">import</span> <span class="nn">seaborn</span> <span class="kn">as</span> <span class="nn">sns</span>
<span class="kn">import</span> <span class="nn">random</span>
<span class="kn">import</span> <span class="nn">os</span>
<span class="kn">from</span> <span class="nn">nxsim</span> <span class="kn">import</span> <span class="n">NetworkSimulation</span><span class="p">,</span> <span class="n">BaseNetworkAgent</span><span class="p">,</span> <span class="n">BaseLoggingAgent</span> <span class="n">sns</span><span class="o">.</span><span class="n">set_context</span><span class="p">(</span><span class="s">&apos;notebook&apos;</span><span class="p">)</span> <span class="c">#colocando um aspecto mais atrativo nos plots com seaborn</span>
</code></pre>

<h2 id="algumas-funções-úteis">
Algumas funções úteis
</h2>
<pre class="highlight"><code><span class="k">def</span> <span class="nf">census_to_df</span><span class="p">(</span><span class="n">log</span><span class="p">,</span> <span class="n">num_trials</span><span class="o">=</span><span class="mi">1</span><span class="p">,</span> <span class="n">state_id</span><span class="o">=</span><span class="mi">1</span><span class="p">,</span> <span class="n">dir_path</span><span class="o">=</span><span class="s">&apos;sim_01&apos;</span><span class="p">):</span> <span class="s">&quot;&quot;&quot;Reads nxsim log files and returns the sum of agents with a given state_id at every time interval of the simulation for every run of the simulation as a pandas DataFrame object.&quot;&quot;&quot;</span> <span class="n">D</span> <span class="o">=</span> <span class="p">{}</span> <span class="k">for</span> <span class="n">i</span> <span class="ow">in</span> <span class="nb">range</span><span class="p">(</span><span class="n">num_trials</span><span class="p">):</span> <span class="n">name</span> <span class="o">=</span> <span class="s">&apos;Trial &apos;</span> <span class="o">+</span> <span class="nb">str</span><span class="p">(</span><span class="n">i</span><span class="p">)</span> <span class="n">trial</span> <span class="o">=</span> <span class="n">log</span><span class="o">.</span><span class="n">open_trial_state_history</span><span class="p">(</span><span class="n">dir_path</span><span class="o">=</span><span class="n">dir_path</span><span class="p">,</span> <span class="n">trial_id</span><span class="o">=</span><span class="n">i</span><span class="p">)</span> <span class="n">census</span> <span class="o">=</span> <span class="p">[</span><span class="nb">sum</span><span class="p">([</span><span class="mi">1</span> <span class="k">for</span> <span class="n">node_id</span><span class="p">,</span> <span class="n">state</span> <span class="ow">in</span> <span class="n">g</span><span class="o">.</span><span class="n">items</span><span class="p">()</span> <span class="k">if</span> <span class="n">node_id</span> <span class="o">!=</span> <span class="s">&apos;topology&apos;</span> <span class="ow">and</span> <span class="n">state</span><span class="p">[</span><span class="s">&apos;id&apos;</span><span class="p">]</span> <span class="o">==</span> <span class="n">state_id</span><span class="p">])</span> <span class="k">for</span> <span class="n">t</span><span class="p">,</span> <span class="n">g</span> <span class="ow">in</span> <span class="n">trial</span><span class="o">.</span><span class="n">items</span><span class="p">()]</span> <span class="n">D</span><span class="p">[</span><span class="n">name</span><span class="p">]</span> <span class="o">=</span> <span class="n">census</span> <span class="k">return</span> <span class="n">pd</span><span class="o">.</span><span class="n">DataFrame</span><span class="p">(</span><span class="n">D</span><span class="p">)</span> <span class="k">def</span> <span class="nf">friends_to_the_end</span><span class="p">(</span><span class="n">log</span><span class="p">,</span> <span class="n">num_trials</span><span class="o">=</span><span class="mi">1</span><span class="p">,</span> <span class="n">dir_path</span><span class="o">=</span><span class="s">&apos;sim_01&apos;</span><span class="p">):</span> <span class="s">&quot;&quot;&quot;Reads nxsim log files and returns the number of human friends connected to every human at every time interval of the simulation for every run of the simulation as a pandas DataFrame object.&quot;&quot;&quot;</span> <span class="n">D</span> <span class="o">=</span> <span class="p">{}</span> <span class="k">for</span> <span class="n">i</span> <span class="ow">in</span> <span class="nb">range</span><span class="p">(</span><span class="n">num_trials</span><span class="p">):</span> <span class="n">name</span> <span class="o">=</span> <span class="s">&apos;Trial &apos;</span> <span class="o">+</span> <span class="nb">str</span><span class="p">(</span><span class="n">i</span><span class="p">)</span> <span class="n">trial</span> <span class="o">=</span> <span class="n">log</span><span class="o">.</span><span class="n">open_trial_state_history</span><span class="p">(</span><span class="n">dir_path</span><span class="o">=</span><span class="n">dir_path</span><span class="p">,</span> <span class="n">trial_id</span><span class="o">=</span><span class="n">i</span><span class="p">)</span> <span class="n">friends</span> <span class="o">=</span> <span class="p">[</span><span class="n">np</span><span class="o">.</span><span class="n">mean</span><span class="p">([</span><span class="n">state</span><span class="p">[</span><span class="s">&apos;friends&apos;</span><span class="p">]</span> <span class="k">for</span> <span class="n">node_id</span><span class="p">,</span> <span class="n">state</span> <span class="ow">in</span> <span class="n">g</span><span class="o">.</span><span class="n">items</span><span class="p">()</span> <span class="k">if</span> <span class="n">node_id</span> <span class="o">!=</span> <span class="s">&apos;topology&apos;</span> <span class="ow">and</span> <span class="n">state</span><span class="p">[</span><span class="s">&apos;id&apos;</span><span class="p">]</span> <span class="o">==</span> <span class="mi">0</span><span class="p">])</span> <span class="k">for</span> <span class="n">t</span><span class="p">,</span> <span class="n">g</span> <span class="ow">in</span> <span class="n">trial</span><span class="o">.</span><span class="n">items</span><span class="p">()]</span> <span class="n">D</span><span class="p">[</span><span class="n">name</span><span class="p">]</span> <span class="o">=</span> <span class="n">friends</span> <span class="k">return</span> <span class="n">pd</span><span class="o">.</span><span class="n">DataFrame</span><span class="p">(</span><span class="n">D</span><span class="p">)</span> <span class="k">def</span> <span class="nf">edge_count_to_df</span><span class="p">(</span><span class="n">log</span><span class="p">,</span> <span class="n">num_trials</span><span class="o">=</span><span class="mi">1</span><span class="p">,</span> <span class="n">state_id</span><span class="o">=</span><span class="mi">1</span><span class="p">,</span> <span class="n">dir_path</span><span class="o">=</span><span class="s">&apos;sim_01&apos;</span><span class="p">):</span> <span class="s">&quot;&quot;&quot;Reads nxsim log files and returns the edge count for the topology at every time interval of the simulation for every run of the simulation as a pandas DataFrame object.&quot;&quot;&quot;</span> <span class="n">D</span> <span class="o">=</span> <span class="p">{}</span> <span class="k">for</span> <span class="n">i</span> <span class="ow">in</span> <span class="nb">range</span><span class="p">(</span><span class="n">num_trials</span><span class="p">):</span> <span class="n">name</span> <span class="o">=</span> <span class="s">&apos;Trial &apos;</span> <span class="o">+</span> <span class="nb">str</span><span class="p">(</span><span class="n">i</span><span class="p">)</span> <span class="n">trial</span> <span class="o">=</span> <span class="n">log</span><span class="o">.</span><span class="n">open_trial_state_history</span><span class="p">(</span><span class="n">dir_path</span><span class="o">=</span><span class="n">dir_path</span><span class="p">,</span> <span class="n">trial_id</span><span class="o">=</span><span class="n">i</span><span class="p">)</span> <span class="n">edge_count</span> <span class="o">=</span> <span class="p">[</span><span class="nb">len</span><span class="p">(</span><span class="n">trial</span><span class="p">[</span><span class="n">key</span><span class="p">][</span><span class="s">&apos;topology&apos;</span><span class="p">])</span> <span class="k">for</span> <span class="n">key</span> <span class="ow">in</span> <span class="n">trial</span><span class="p">]</span> <span class="n">D</span><span class="p">[</span><span class="n">name</span><span class="p">]</span> <span class="o">=</span> <span class="n">edge_count</span> <span class="k">return</span> <span class="n">pd</span><span class="o">.</span><span class="n">DataFrame</span><span class="p">(</span><span class="n">D</span><span class="p">)</span>
</code></pre>

<h2 id="topologia">
Topologia
</h2>
<p>
Vamos declarar a topologia da rede sobre a qual as simulações irão
acontecer. A principal diferença entre os modelos de difusão social e os
ABM’s comuns reside no pressuposto da independência das observações.
Esse pressuposto não se sustenta em estruturas relacionais já que a
mudança de apenas um laço muda toda a configuração da rede. O pacote
<em>nxsim</em> nos permite rodar um modelo de simulações apenas dentro
da topologia de uma rede dada. Vamos simular uma rede livre de escala
com 100 nós, ou 100 pessoas.
</p>
<pre class="highlight"><code><span class="n">number_of_nodes</span> <span class="o">=</span> <span class="mi">100</span>
<span class="n">G</span> <span class="o">=</span> <span class="n">nx</span><span class="o">.</span><span class="n">scale_free_graph</span><span class="p">(</span><span class="n">number_of_nodes</span><span class="p">)</span><span class="o">.</span><span class="n">to_undirected</span><span class="p">()</span>
</code></pre>

<h2 id="classe-de-agentes">
Classe de agentes
</h2>
<h3 id="cenário-1---infestação-zumbi">
Cenário 1 - Infestação Zumbi
</h3>
<p>
Vamos agora definir a classe de agentes que nos interessa num cenário
básico e as ações dos agentes. Nesse modelo preliminar, o que acontece
nas rodadas é o seguinte: O estado de <em>humano</em> é definido como
<code class="highlighter-rouge">self.state\['id'\]==0</code> e o estado
<em>Zumbi</em> como
<code class="highlighter-rouge">self.state\['id'\]==1</code>. A cada
rodada, se o agente é humano ele verifica se tem pessoas próximas,
“vizinhos”, que estão infectados. Joga-se dados e se o valor obtido for
menor do que o limite da infecção, ele se infecta. Depois, conta-se os
amigos que ainda são humanos.
</p>
<pre class="highlight"><code><span class="k">class</span> <span class="nc">ZombieMassiveOutbreak</span><span class="p">(</span><span class="n">BaseNetworkAgent</span><span class="p">):</span> <span class="k">def</span> <span class="nf">__init__</span><span class="p">(</span><span class="bp">self</span><span class="p">,</span> <span class="n">environment</span><span class="o">=</span><span class="bp">None</span><span class="p">,</span> <span class="n">agent_id</span><span class="o">=</span><span class="mi">0</span><span class="p">,</span> <span class="n">state</span><span class="o">=</span><span class="p">()):</span> <span class="nb">super</span><span class="p">()</span><span class="o">.</span><span class="n">__init__</span><span class="p">(</span><span class="n">environment</span><span class="o">=</span><span class="n">environment</span><span class="p">,</span> <span class="n">agent_id</span><span class="o">=</span><span class="n">agent_id</span><span class="p">,</span> <span class="n">state</span><span class="o">=</span><span class="n">state</span><span class="p">)</span> <span class="bp">self</span><span class="o">.</span><span class="n">inf_prob</span> <span class="o">=</span> <span class="mf">0.2</span> <span class="k">def</span> <span class="nf">run</span><span class="p">(</span><span class="bp">self</span><span class="p">):</span> <span class="k">while</span> <span class="bp">True</span><span class="p">:</span> <span class="k">if</span> <span class="bp">self</span><span class="o">.</span><span class="n">state</span><span class="p">[</span><span class="s">&apos;id&apos;</span><span class="p">]</span> <span class="o">==</span> <span class="mi">0</span><span class="p">:</span> <span class="bp">self</span><span class="o">.</span><span class="n">check_for_infection</span><span class="p">()</span> <span class="bp">self</span><span class="o">.</span><span class="n">count_friends</span><span class="p">()</span> <span class="k">yield</span> <span class="bp">self</span><span class="o">.</span><span class="n">env</span><span class="o">.</span><span class="n">timeout</span><span class="p">(</span><span class="mi">1</span><span class="p">)</span> <span class="k">else</span><span class="p">:</span> <span class="k">yield</span> <span class="bp">self</span><span class="o">.</span><span class="n">env</span><span class="o">.</span><span class="n">event</span><span class="p">()</span> <span class="k">def</span> <span class="nf">check_for_infection</span><span class="p">(</span><span class="bp">self</span><span class="p">):</span> <span class="n">zombie_neighbors</span> <span class="o">=</span> <span class="bp">self</span><span class="o">.</span><span class="n">get_neighboring_agents</span><span class="p">(</span><span class="n">state_id</span><span class="o">=</span><span class="mi">1</span><span class="p">)</span> <span class="k">for</span> <span class="n">neighbor</span> <span class="ow">in</span> <span class="n">zombie_neighbors</span><span class="p">:</span> <span class="k">if</span> <span class="n">random</span><span class="o">.</span><span class="n">random</span><span class="p">()</span> <span class="o">&lt;</span> <span class="bp">self</span><span class="o">.</span><span class="n">inf_prob</span><span class="p">:</span> <span class="bp">self</span><span class="o">.</span><span class="n">state</span><span class="p">[</span><span class="s">&apos;id&apos;</span><span class="p">]</span> <span class="o">=</span> <span class="mi">1</span> <span class="k">print</span><span class="p">(</span><span class="bp">self</span><span class="o">.</span><span class="n">env</span><span class="o">.</span><span class="n">now</span><span class="p">,</span> <span class="bp">self</span><span class="o">.</span><span class="nb">id</span><span class="p">,</span> <span class="s">&apos;&lt;--&apos;</span><span class="p">,</span> <span class="n">neighbor</span><span class="o">.</span><span class="nb">id</span><span class="p">,</span> <span class="n">sep</span><span class="o">=</span><span class="s">&apos;</span><span class="se">\t</span><span class="s">&apos;</span><span class="p">)</span> <span class="k">break</span> <span class="k">def</span> <span class="nf">count_friends</span><span class="p">(</span><span class="bp">self</span><span class="p">):</span> <span class="n">human_neighbors</span> <span class="o">=</span> <span class="bp">self</span><span class="o">.</span><span class="n">get_neighboring_agents</span><span class="p">(</span><span class="n">state_id</span><span class="o">=</span><span class="mi">0</span><span class="p">)</span> <span class="bp">self</span><span class="o">.</span><span class="n">state</span><span class="p">[</span><span class="s">&apos;friends&apos;</span><span class="p">]</span> <span class="o">=</span> <span class="nb">len</span><span class="p">(</span><span class="n">human_neighbors</span><span class="p">)</span>
</code></pre>

<p>
Para iniciar a simulação, primeiro estabelecemos todos como humanos e
escolhemos um “paciente zero”, o primeiro zumbi! Nessa simulação, serão
feitas até 28 rodadas. O processo todo será repetido 100 vezes.
</p>
<pre class="highlight"><code><span class="c"># Starting out with a human population</span>
<span class="n">init_states</span> <span class="o">=</span> <span class="p">[{</span><span class="s">&apos;id&apos;</span><span class="p">:</span> <span class="mi">0</span><span class="p">,</span> <span class="p">}</span> <span class="k">for</span> <span class="n">_</span> <span class="ow">in</span> <span class="nb">range</span><span class="p">(</span><span class="n">number_of_nodes</span><span class="p">)]</span> <span class="c"># Randomly seeding patient zero</span>
<span class="n">patient_zero</span> <span class="o">=</span> <span class="n">random</span><span class="o">.</span><span class="n">randint</span><span class="p">(</span><span class="mi">0</span><span class="p">,</span> <span class="n">number_of_nodes</span><span class="p">)</span>
<span class="n">init_states</span><span class="p">[</span><span class="n">patient_zero</span><span class="p">]</span> <span class="o">=</span> <span class="p">{</span><span class="s">&apos;id&apos;</span><span class="p">:</span> <span class="mi">1</span><span class="p">}</span> <span class="c"># Setting up the simulation</span>
<span class="n">sim</span> <span class="o">=</span> <span class="n">NetworkSimulation</span><span class="p">(</span><span class="n">topology</span><span class="o">=</span><span class="n">G</span><span class="p">,</span> <span class="n">states</span><span class="o">=</span><span class="n">init_states</span><span class="p">,</span> <span class="n">agent_type</span><span class="o">=</span><span class="n">ZombieMassiveOutbreak</span><span class="p">,</span> <span class="n">max_time</span><span class="o">=</span><span class="mi">28</span><span class="p">,</span> <span class="n">num_trials</span><span class="o">=</span><span class="mi">100</span><span class="p">,</span> <span class="n">logging_interval</span><span class="o">=</span><span class="mf">1.0</span><span class="p">,</span> <span class="n">dir_path</span><span class="o">=</span><span class="s">&apos;sim_01&apos;</span><span class="p">)</span> <span class="c"># Running the simulation</span>
<span class="n">sim</span><span class="o">.</span><span class="n">run_simulation</span><span class="p">()</span>
</code></pre>

<pre class="highlight"><code>Starting simulations...
---Trial 0---
Setting up agents...
1   0   &lt;--  49
1   17  &lt;--  0
1   19  &lt;--  0
1   25  &lt;--  0
1   37  &lt;--  0
1   38  &lt;--  0
............. 11    9   &lt;--  1
11  74  &lt;--  1
12  87  &lt;--  6
13  29  &lt;--  55
18  98  &lt;--  64
Written 28 items to pickled binary file: sim_01/log.99.state.pickled
Simulation completed.
</code></pre>

<p>
Do mesmo modo como a modelagem baseada em agentes, o modelo de difusão
social está preocupado com a análise dos resultados macro das
interações. Vamos olhar para como as infecções acontecem no tempo.
</p>
<pre class="highlight"><code><span class="n">zombies</span> <span class="o">=</span> <span class="n">census_to_df</span><span class="p">(</span><span class="n">BaseLoggingAgent</span><span class="p">,</span> <span class="mi">100</span><span class="p">,</span> <span class="mi">1</span><span class="p">,</span> <span class="n">dir_path</span><span class="o">=</span><span class="s">&apos;sim_01&apos;</span><span class="p">)</span><span class="o">.</span><span class="n">T</span>
<span class="n">humans</span> <span class="o">=</span> <span class="n">census_to_df</span><span class="p">(</span><span class="n">BaseLoggingAgent</span><span class="p">,</span> <span class="mi">100</span><span class="p">,</span> <span class="mi">0</span><span class="p">,</span> <span class="n">dir_path</span><span class="o">=</span><span class="s">&apos;sim_01&apos;</span><span class="p">)</span><span class="o">.</span><span class="n">T</span> <span class="n">plt</span><span class="o">.</span><span class="n">plot</span><span class="p">(</span><span class="n">zombies</span><span class="o">.</span><span class="n">mean</span><span class="p">(),</span> <span class="n">color</span><span class="o">=</span><span class="s">&apos;r&apos;</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">fill_between</span><span class="p">(</span><span class="n">zombies</span><span class="o">.</span><span class="n">columns</span><span class="p">,</span> <span class="n">zombies</span><span class="o">.</span><span class="nb">max</span><span class="p">(),</span> <span class="n">zombies</span><span class="o">.</span><span class="nb">min</span><span class="p">(),</span> <span class="n">color</span><span class="o">=</span><span class="s">&apos;r&apos;</span><span class="p">,</span> <span class="n">alpha</span><span class="o">=.</span><span class="mi">33</span><span class="p">)</span> <span class="n">plt</span><span class="o">.</span><span class="n">plot</span><span class="p">(</span><span class="n">humans</span><span class="o">.</span><span class="n">mean</span><span class="p">(),</span> <span class="n">color</span><span class="o">=</span><span class="s">&apos;g&apos;</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">fill_between</span><span class="p">(</span><span class="n">humans</span><span class="o">.</span><span class="n">columns</span><span class="p">,</span> <span class="n">humans</span><span class="o">.</span><span class="nb">max</span><span class="p">(),</span> <span class="n">humans</span><span class="o">.</span><span class="nb">min</span><span class="p">(),</span> <span class="n">color</span><span class="o">=</span><span class="s">&apos;g&apos;</span><span class="p">,</span> <span class="n">alpha</span><span class="o">=.</span><span class="mi">33</span><span class="p">)</span> <span class="n">plt</span><span class="o">.</span><span class="n">title</span><span class="p">(</span><span class="s">&apos;Simple ZombieApokalypse, $P_{inf}=0.2$&apos;</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">legend</span><span class="p">([</span><span class="s">&apos;Zombies&apos;</span><span class="p">,</span> <span class="s">&apos;Humans&apos;</span><span class="p">],</span> <span class="n">loc</span><span class="o">=</span><span class="mi">7</span><span class="p">,</span> <span class="n">frameon</span><span class="o">=</span><span class="bp">True</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">xlim</span><span class="p">(</span><span class="n">xmax</span><span class="o">=</span><span class="mi">27</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">xticks</span><span class="p">(</span><span class="n">np</span><span class="o">.</span><span class="n">arange</span><span class="p">(</span><span class="mi">0</span><span class="p">,</span> <span class="mf">28.</span><span class="p">,</span> <span class="mi">3</span><span class="p">),</span> <span class="nb">tuple</span><span class="p">(</span><span class="nb">range</span><span class="p">(</span><span class="mi">1</span><span class="p">,</span> <span class="mi">29</span><span class="p">,</span> <span class="mi">3</span><span class="p">)))</span>
<span class="n">plt</span><span class="o">.</span><span class="n">ylabel</span><span class="p">(</span><span class="s">&apos;Population&apos;</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">xlabel</span><span class="p">(</span><span class="s">&apos;Simulation time&apos;</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">show</span><span class="p">()</span>
</code></pre>

<p>
<img src="http://neylsoncrepalde.github.io/img/2016-12-22-the-walking-dead/output_13_0.svg" alt="svg">
</p>
<h3 id="cenário-2---escapar">
Cenário 2 - Escapar!!
</h3>
<p>
Vamos programar um segundo cenário para nossa infestação zumbi. Se eu
algum dia encontrasse com um zumbi, sem pestenejar, sairia correndo
desenfreadamente sem olhar pra trás e gritando como uma garotinha(!!!).
Nossos agentes virtuais também devem ter esse direito. Agora eles podem
tentar escapar.
</p>
<p>
Na nova simulação, além de tudo o que já acontecia, antes de qualquer
coisa, nosso agente pode perceber aqueles próximos que se tornaram
zumbis e tentar escapar. Se os dados forem menores do que a “marca” de
correr (<code class="highlighter-rouge">self.run\_prob = 0.05</code>), o
laço entre esses agentes é desfeito e o nosso agente pode sair gritando
como uma garotinha livre do seu amigo zumbi (pelo menos desse).
</p>
<pre class="highlight"><code><span class="k">class</span> <span class="nc">ZombieEscape</span><span class="p">(</span><span class="n">BaseNetworkAgent</span><span class="p">):</span> <span class="k">def</span> <span class="nf">__init__</span><span class="p">(</span><span class="bp">self</span><span class="p">,</span> <span class="n">environment</span><span class="o">=</span><span class="bp">None</span><span class="p">,</span> <span class="n">agent_id</span><span class="o">=</span><span class="mi">0</span><span class="p">,</span> <span class="n">state</span><span class="o">=</span><span class="p">()):</span> <span class="nb">super</span><span class="p">()</span><span class="o">.</span><span class="n">__init__</span><span class="p">(</span><span class="n">environment</span><span class="o">=</span><span class="n">environment</span><span class="p">,</span> <span class="n">agent_id</span><span class="o">=</span><span class="n">agent_id</span><span class="p">,</span> <span class="n">state</span><span class="o">=</span><span class="n">state</span><span class="p">)</span> <span class="bp">self</span><span class="o">.</span><span class="n">inf_prob</span> <span class="o">=</span> <span class="mf">0.3</span> <span class="bp">self</span><span class="o">.</span><span class="n">run_prob</span> <span class="o">=</span> <span class="mf">0.05</span> <span class="k">def</span> <span class="nf">run</span><span class="p">(</span><span class="bp">self</span><span class="p">):</span> <span class="k">while</span> <span class="bp">True</span><span class="p">:</span> <span class="k">if</span> <span class="bp">self</span><span class="o">.</span><span class="n">state</span><span class="p">[</span><span class="s">&apos;id&apos;</span><span class="p">]</span> <span class="o">==</span> <span class="mi">0</span><span class="p">:</span> <span class="bp">self</span><span class="o">.</span><span class="n">run_you_fools</span><span class="p">()</span> <span class="bp">self</span><span class="o">.</span><span class="n">check_for_infection</span><span class="p">()</span> <span class="bp">self</span><span class="o">.</span><span class="n">count_friends</span><span class="p">()</span> <span class="k">yield</span> <span class="bp">self</span><span class="o">.</span><span class="n">env</span><span class="o">.</span><span class="n">timeout</span><span class="p">(</span><span class="mi">1</span><span class="p">)</span> <span class="k">else</span><span class="p">:</span> <span class="k">yield</span> <span class="bp">self</span><span class="o">.</span><span class="n">env</span><span class="o">.</span><span class="n">event</span><span class="p">()</span> <span class="k">def</span> <span class="nf">check_for_infection</span><span class="p">(</span><span class="bp">self</span><span class="p">):</span> <span class="n">zombie_neighbors</span> <span class="o">=</span> <span class="bp">self</span><span class="o">.</span><span class="n">get_neighboring_agents</span><span class="p">(</span><span class="n">state_id</span><span class="o">=</span><span class="mi">1</span><span class="p">)</span> <span class="k">for</span> <span class="n">neighbor</span> <span class="ow">in</span> <span class="n">zombie_neighbors</span><span class="p">:</span> <span class="k">if</span> <span class="n">random</span><span class="o">.</span><span class="n">random</span><span class="p">()</span> <span class="o">&lt;</span> <span class="bp">self</span><span class="o">.</span><span class="n">inf_prob</span><span class="p">:</span> <span class="bp">self</span><span class="o">.</span><span class="n">state</span><span class="p">[</span><span class="s">&apos;id&apos;</span><span class="p">]</span> <span class="o">=</span> <span class="mi">1</span> <span class="c"># zombie</span> <span class="k">print</span><span class="p">(</span><span class="s">&apos;Infection:&apos;</span><span class="p">,</span> <span class="bp">self</span><span class="o">.</span><span class="n">env</span><span class="o">.</span><span class="n">now</span><span class="p">,</span> <span class="bp">self</span><span class="o">.</span><span class="nb">id</span><span class="p">,</span> <span class="s">&apos;&lt;--&apos;</span><span class="p">,</span> <span class="n">neighbor</span><span class="o">.</span><span class="nb">id</span><span class="p">,</span> <span class="n">sep</span><span class="o">=</span><span class="s">&apos;</span><span class="se">\t</span><span class="s">&apos;</span><span class="p">)</span> <span class="k">break</span> <span class="k">def</span> <span class="nf">run_you_fools</span><span class="p">(</span><span class="bp">self</span><span class="p">):</span> <span class="n">zombie_neighbors</span> <span class="o">=</span> <span class="bp">self</span><span class="o">.</span><span class="n">get_neighboring_agents</span><span class="p">(</span><span class="n">state_id</span><span class="o">=</span><span class="mi">1</span><span class="p">)</span> <span class="k">for</span> <span class="n">neighbor</span> <span class="ow">in</span> <span class="n">zombie_neighbors</span><span class="p">:</span> <span class="k">if</span> <span class="n">random</span><span class="o">.</span><span class="n">random</span><span class="p">()</span> <span class="o">&lt;</span> <span class="bp">self</span><span class="o">.</span><span class="n">run_prob</span><span class="p">:</span> <span class="bp">self</span><span class="o">.</span><span class="n">global_topology</span><span class="o">.</span><span class="n">remove_edge</span><span class="p">(</span><span class="bp">self</span><span class="o">.</span><span class="nb">id</span><span class="p">,</span> <span class="n">neighbor</span><span class="o">.</span><span class="nb">id</span><span class="p">)</span> <span class="k">print</span><span class="p">(</span><span class="s">&apos;Rejection:&apos;</span><span class="p">,</span> <span class="bp">self</span><span class="o">.</span><span class="n">env</span><span class="o">.</span><span class="n">now</span><span class="p">,</span> <span class="s">&apos;Edge:&apos;</span><span class="p">,</span> <span class="bp">self</span><span class="o">.</span><span class="nb">id</span><span class="p">,</span> <span class="n">neighbor</span><span class="o">.</span><span class="nb">id</span><span class="p">,</span> <span class="n">sep</span><span class="o">=</span><span class="s">&apos;</span><span class="se">\t</span><span class="s">&apos;</span><span class="p">)</span> <span class="k">def</span> <span class="nf">count_friends</span><span class="p">(</span><span class="bp">self</span><span class="p">):</span> <span class="n">human_neighbors</span> <span class="o">=</span> <span class="bp">self</span><span class="o">.</span><span class="n">get_neighboring_agents</span><span class="p">(</span><span class="n">state_id</span><span class="o">=</span><span class="mi">0</span><span class="p">)</span> <span class="bp">self</span><span class="o">.</span><span class="n">state</span><span class="p">[</span><span class="s">&apos;friends&apos;</span><span class="p">]</span> <span class="o">=</span> <span class="nb">len</span><span class="p">(</span><span class="n">human_neighbors</span><span class="p">)</span>
</code></pre>

<p>
Rodando a simulação:
</p>
<pre class="highlight"><code><span class="c"># Starting out with a human population</span>
<span class="n">init_states</span> <span class="o">=</span> <span class="p">[{</span><span class="s">&apos;id&apos;</span><span class="p">:</span> <span class="mi">0</span><span class="p">,</span> <span class="p">}</span> <span class="k">for</span> <span class="n">_</span> <span class="ow">in</span> <span class="nb">range</span><span class="p">(</span><span class="n">number_of_nodes</span><span class="p">)]</span> <span class="c"># Randomly seeding patient zero</span>
<span class="n">patient_zero</span> <span class="o">=</span> <span class="n">random</span><span class="o">.</span><span class="n">randint</span><span class="p">(</span><span class="mi">0</span><span class="p">,</span> <span class="n">number_of_nodes</span><span class="p">)</span>
<span class="n">init_states</span><span class="p">[</span><span class="n">patient_zero</span><span class="p">]</span> <span class="o">=</span> <span class="p">{</span><span class="s">&apos;id&apos;</span><span class="p">:</span> <span class="mi">1</span><span class="p">}</span> <span class="c"># Setting up the simulation</span>
<span class="n">sim</span> <span class="o">=</span> <span class="n">NetworkSimulation</span><span class="p">(</span><span class="n">topology</span><span class="o">=</span><span class="n">G</span><span class="p">,</span> <span class="n">states</span><span class="o">=</span><span class="n">init_states</span><span class="p">,</span> <span class="n">agent_type</span><span class="o">=</span><span class="n">ZombieEscape</span><span class="p">,</span> <span class="n">max_time</span><span class="o">=</span><span class="mi">28</span><span class="p">,</span> <span class="n">num_trials</span><span class="o">=</span><span class="mi">100</span><span class="p">,</span> <span class="n">logging_interval</span><span class="o">=</span><span class="mf">1.0</span><span class="p">,</span> <span class="n">dir_path</span><span class="o">=</span><span class="s">&apos;sim_02&apos;</span><span class="p">)</span> <span class="c"># Running the simulation</span>
<span class="n">sim</span><span class="o">.</span><span class="n">run_simulation</span><span class="p">()</span>
</code></pre>

<pre class="highlight"><code>Starting simulations...
---Trial 0---
Setting up agents...
Infection:  0   23  &lt;--  77
Infection:  2   2   &lt;--  23
Infection:  2   3   &lt;--  2
Infection:  2   8   &lt;--  2
Infection:  2   10  &lt;--  2
Infection:  2   13  &lt;--  8
Infection:  2   14  &lt;--  2
Infection:  2   17  &lt;--  2
Infection:  2   19  &lt;--  17
Infection:  2   35  &lt;--  3
Infection:  2   45  &lt;--  2
Rejection:  2   Edge:   48  2
Rejection:  3   Edge:   0   19
Infection:  3   0   &lt;--  3 ............................. Infection:  8   64  &lt;--  20
Infection:  8   96  &lt;--  1
Infection:  9   98  &lt;--  64
Infection:  11  39  &lt;--  12
Infection:  15  69  &lt;--  1
Infection:  18  46  &lt;--  11
Written 28 items to pickled binary file: sim_02/log.99.state.pickled
Simulation completed.
</code></pre>

<p>
E agora, vamos ver como o número de zumbis e humanos se comporta no
tempo:
</p>
<pre class="highlight"><code><span class="n">zombies</span> <span class="o">=</span> <span class="n">census_to_df</span><span class="p">(</span><span class="n">BaseLoggingAgent</span><span class="p">,</span> <span class="mi">100</span><span class="p">,</span> <span class="mi">1</span><span class="p">,</span> <span class="n">dir_path</span><span class="o">=</span><span class="s">&apos;sim_02&apos;</span><span class="p">)</span><span class="o">.</span><span class="n">T</span>
<span class="n">humans</span> <span class="o">=</span> <span class="n">census_to_df</span><span class="p">(</span><span class="n">BaseLoggingAgent</span><span class="p">,</span> <span class="mi">100</span><span class="p">,</span> <span class="mi">0</span><span class="p">,</span> <span class="n">dir_path</span><span class="o">=</span><span class="s">&apos;sim_02&apos;</span><span class="p">)</span><span class="o">.</span><span class="n">T</span> <span class="c">## For later comparisons:</span>
<span class="n">mean_escape_zombies</span> <span class="o">=</span> <span class="n">zombies</span><span class="o">.</span><span class="n">mean</span><span class="p">()</span>
<span class="n">mean_escape_humans</span> <span class="o">=</span> <span class="n">humans</span><span class="o">.</span><span class="n">mean</span><span class="p">()</span> <span class="n">plt</span><span class="o">.</span><span class="n">plot</span><span class="p">(</span><span class="n">zombies</span><span class="o">.</span><span class="n">mean</span><span class="p">(),</span> <span class="n">color</span><span class="o">=</span><span class="s">&apos;r&apos;</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">fill_between</span><span class="p">(</span><span class="n">zombies</span><span class="o">.</span><span class="n">columns</span><span class="p">,</span> <span class="n">zombies</span><span class="o">.</span><span class="nb">max</span><span class="p">(),</span> <span class="n">zombies</span><span class="o">.</span><span class="nb">min</span><span class="p">(),</span> <span class="n">color</span><span class="o">=</span><span class="s">&apos;r&apos;</span><span class="p">,</span> <span class="n">alpha</span><span class="o">=.</span><span class="mi">2</span><span class="p">)</span> <span class="n">plt</span><span class="o">.</span><span class="n">plot</span><span class="p">(</span><span class="n">humans</span><span class="o">.</span><span class="n">mean</span><span class="p">(),</span> <span class="n">color</span><span class="o">=</span><span class="s">&apos;g&apos;</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">fill_between</span><span class="p">(</span><span class="n">humans</span><span class="o">.</span><span class="n">columns</span><span class="p">,</span> <span class="n">humans</span><span class="o">.</span><span class="nb">max</span><span class="p">(),</span> <span class="n">humans</span><span class="o">.</span><span class="nb">min</span><span class="p">(),</span> <span class="n">color</span><span class="o">=</span><span class="s">&apos;g&apos;</span><span class="p">,</span> <span class="n">alpha</span><span class="o">=.</span><span class="mi">2</span><span class="p">)</span> <span class="n">plt</span><span class="o">.</span><span class="n">title</span><span class="p">(</span><span class="s">&apos;Escape ZombieApokalypse, $P_{inf} = 0.3$, $P_{run} = 0.05$&apos;</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">legend</span><span class="p">([</span><span class="s">&apos;Zombies&apos;</span><span class="p">,</span> <span class="s">&apos;Humans&apos;</span><span class="p">],</span> <span class="n">loc</span><span class="o">=</span><span class="mi">7</span><span class="p">,</span> <span class="n">frameon</span><span class="o">=</span><span class="bp">True</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">xlim</span><span class="p">(</span><span class="n">xmax</span><span class="o">=</span><span class="mi">27</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">xticks</span><span class="p">(</span><span class="n">np</span><span class="o">.</span><span class="n">arange</span><span class="p">(</span><span class="mi">0</span><span class="p">,</span> <span class="mf">28.</span><span class="p">,</span> <span class="mi">3</span><span class="p">),</span> <span class="nb">tuple</span><span class="p">(</span><span class="nb">range</span><span class="p">(</span><span class="mi">1</span><span class="p">,</span> <span class="mi">29</span><span class="p">,</span> <span class="mi">3</span><span class="p">)))</span>
<span class="n">plt</span><span class="o">.</span><span class="n">ylabel</span><span class="p">(</span><span class="s">&apos;Population&apos;</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">xlabel</span><span class="p">(</span><span class="s">&apos;Simulation time&apos;</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">show</span><span class="p">()</span>
</code></pre>

<p>
<img src="http://neylsoncrepalde.github.io/img/2016-12-22-the-walking-dead/output_19_0.svg" alt="svg">
</p>
<p>
Apenas programando a possibilidade de escapar de um zumbi, podemos
observar a esperança de sobrevivência da raça humana com cerca de 20
humanos remanescentes. Se essa possibilidade não existisse, o domínio
zumbi total seria inevitável, como vimos na primeira simulação. Agora,
vamos comparar os dois cenários para verificar o remanescente humano em
cada um.
</p>
<pre class="highlight"><code><span class="n">first_friends</span> <span class="o">=</span> <span class="n">friends_to_the_end</span><span class="p">(</span><span class="n">BaseLoggingAgent</span><span class="p">,</span> <span class="mi">100</span><span class="p">,</span> <span class="n">dir_path</span><span class="o">=</span><span class="s">&apos;sim_01&apos;</span><span class="p">)</span><span class="o">.</span><span class="n">T</span>
<span class="n">escape_friends</span> <span class="o">=</span> <span class="n">friends_to_the_end</span><span class="p">(</span><span class="n">BaseLoggingAgent</span><span class="p">,</span> <span class="mi">100</span><span class="p">,</span> <span class="n">dir_path</span><span class="o">=</span><span class="s">&apos;sim_02&apos;</span><span class="p">)</span><span class="o">.</span><span class="n">T</span> <span class="n">plt</span><span class="o">.</span><span class="n">plot</span><span class="p">(</span><span class="n">first_friends</span><span class="o">.</span><span class="n">mean</span><span class="p">(),</span> <span class="n">color</span><span class="o">=</span><span class="s">&apos;y&apos;</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">plot</span><span class="p">(</span><span class="n">escape_friends</span><span class="o">.</span><span class="n">mean</span><span class="p">(),</span> <span class="n">color</span><span class="o">=</span><span class="s">&apos;b&apos;</span><span class="p">)</span> <span class="n">plt</span><span class="o">.</span><span class="n">title</span><span class="p">(</span><span class="s">&apos;Remaining Friends (Humans)&apos;</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">legend</span><span class="p">([</span><span class="s">&apos;Zombie Outbreak&apos;</span><span class="p">,</span><span class="s">&apos;Escape&apos;</span><span class="p">],</span> <span class="n">loc</span><span class="o">=</span><span class="s">&apos;best&apos;</span><span class="p">,</span> <span class="n">frameon</span><span class="o">=</span><span class="bp">True</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">xlim</span><span class="p">(</span><span class="n">xmax</span><span class="o">=</span><span class="mi">27</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">xticks</span><span class="p">(</span><span class="n">np</span><span class="o">.</span><span class="n">arange</span><span class="p">(</span><span class="mi">0</span><span class="p">,</span> <span class="mf">28.</span><span class="p">,</span> <span class="mi">3</span><span class="p">),</span> <span class="nb">tuple</span><span class="p">(</span><span class="nb">range</span><span class="p">(</span><span class="mi">1</span><span class="p">,</span> <span class="mi">29</span><span class="p">,</span> <span class="mi">3</span><span class="p">)))</span>
<span class="n">plt</span><span class="o">.</span><span class="n">ylabel</span><span class="p">(</span><span class="s">&apos;Average number of friends&apos;</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">xlabel</span><span class="p">(</span><span class="s">&apos;Simulation time&apos;</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">show</span><span class="p">()</span>
</code></pre>

<pre class="highlight"><code>/home/neylson/anaconda3/lib/python3.5/site-packages/numpy/core/_methods.py:59: RuntimeWarning: Mean of empty slice. warnings.warn(&quot;Mean of empty slice.&quot;, RuntimeWarning)
</code></pre>

<p>
<img src="http://neylsoncrepalde.github.io/img/2016-12-22-the-walking-dead/output_21_1.svg" alt="svg">
</p>
<p>
Podemos visualizar o fenômeno do contágio na rede. Para isso, vamos
escolher uma das simulações
(<code class="highlighter-rouge">trial\_id</code>) e plotar num grafo os
nós humanos e os nós infectados.
</p>
<pre class="highlight"><code><span class="n">pos</span><span class="o">=</span><span class="n">nx</span><span class="o">.</span><span class="n">fruchterman_reingold_layout</span><span class="p">(</span><span class="n">G</span><span class="p">)</span>
<span class="k">for</span> <span class="n">i</span> <span class="ow">in</span> <span class="nb">range</span><span class="p">(</span><span class="mi">28</span><span class="p">):</span> <span class="n">cor</span> <span class="o">=</span> <span class="p">[]</span> <span class="k">for</span> <span class="n">j</span> <span class="ow">in</span> <span class="nb">range</span><span class="p">(</span><span class="n">number_of_nodes</span><span class="p">):</span> <span class="n">cor</span><span class="o">.</span><span class="n">append</span><span class="p">(</span><span class="n">BaseLoggingAgent</span><span class="o">.</span><span class="n">open_trial_state_history</span><span class="p">(</span><span class="n">dir_path</span><span class="o">=</span><span class="s">&quot;sim_01&quot;</span><span class="p">,</span> <span class="n">trial_id</span><span class="o">=</span><span class="mi">0</span><span class="p">)[</span><span class="n">i</span><span class="p">][</span><span class="n">j</span><span class="p">][</span><span class="s">&apos;id&apos;</span><span class="p">])</span> <span class="n">cores</span> <span class="o">=</span> <span class="p">[]</span> <span class="k">for</span> <span class="n">j</span> <span class="ow">in</span> <span class="n">cor</span><span class="p">:</span> <span class="k">if</span> <span class="n">j</span> <span class="o">==</span> <span class="mi">1</span><span class="p">:</span> <span class="n">cores</span><span class="o">.</span><span class="n">append</span><span class="p">(</span><span class="s">&apos;red&apos;</span><span class="p">)</span>
<span class="n">r</span> <span class="k">else</span><span class="p">:</span> <span class="n">cores</span><span class="o">.</span><span class="n">append</span><span class="p">(</span><span class="s">&apos;lightgreen&apos;</span><span class="p">)</span> <span class="c">#plotando a rede</span> <span class="n">plt</span><span class="o">.</span><span class="n">figure</span><span class="p">(</span><span class="n">i</span><span class="p">,</span> <span class="n">figsize</span><span class="o">=</span><span class="p">(</span><span class="mi">12</span><span class="p">,</span> <span class="mi">8</span><span class="p">))</span> <span class="n">plt</span><span class="o">.</span><span class="n">axis</span><span class="p">(</span><span class="s">&apos;off&apos;</span><span class="p">)</span> <span class="n">nx</span><span class="o">.</span><span class="n">draw_networkx_nodes</span><span class="p">(</span><span class="n">G</span><span class="p">,</span><span class="n">pos</span><span class="p">,</span><span class="n">node_size</span><span class="o">=</span><span class="mi">60</span><span class="p">,</span><span class="n">node_color</span><span class="o">=</span><span class="n">cores</span><span class="p">)</span> <span class="n">nx</span><span class="o">.</span><span class="n">draw_networkx_edges</span><span class="p">(</span><span class="n">G</span><span class="p">,</span><span class="n">pos</span><span class="p">,</span><span class="n">alpha</span><span class="o">=.</span><span class="mi">4</span><span class="p">)</span> <span class="n">plt</span><span class="o">.</span><span class="n">title</span><span class="p">(</span><span class="s">&apos;Infection - Time &apos;</span><span class="o">+</span><span class="nb">str</span><span class="p">(</span><span class="n">i</span><span class="p">),</span> <span class="n">size</span><span class="o">=</span><span class="mi">16</span><span class="p">)</span> <span class="k">if</span> <span class="n">i</span> <span class="o">&lt;</span> <span class="mi">9</span><span class="p">:</span> <span class="n">plt</span><span class="o">.</span><span class="n">savefig</span><span class="p">(</span><span class="s">&apos;image00&apos;</span><span class="o">+</span><span class="nb">str</span><span class="p">(</span><span class="n">i</span><span class="o">+</span><span class="mi">1</span><span class="p">)</span><span class="o">+</span><span class="s">&apos;.png&apos;</span><span class="p">)</span> <span class="k">elif</span> <span class="n">i</span> <span class="o">&gt;=</span> <span class="mi">9</span><span class="p">:</span> <span class="n">plt</span><span class="o">.</span><span class="n">savefig</span><span class="p">(</span><span class="s">&apos;image0&apos;</span><span class="o">+</span><span class="nb">str</span><span class="p">(</span><span class="n">i</span><span class="o">+</span><span class="mi">1</span><span class="p">)</span><span class="o">+</span><span class="s">&apos;.png&apos;</span><span class="p">)</span> </code></pre>

<p>
Podemos transformar todos os plots em um vídeo para facilitar a
visualização com <strong>ffmpeg</strong>. Aqui está o código para fazer
um slide show.
</p>
<pre><code class="language-linux">ffmpeg -framerate 1 -i image%03d.png output.mp4
</code></pre>
<p>
Clique no grafo abaixo e veja o vídeo!
</p>
<p>
<a href="https://raw.githubusercontent.com/neylsoncrepalde/diffusion_models/master/output.mp4"><img src="http://neylsoncrepalde.github.io/img/2016-12-22-the-walking-dead/output_23_0.svg" alt="svg"></a>
</p>
<p>
Por hoje é só! Ano que vem tem mais! Abraços
</p>
</article>
<p class="blog-tags">
Tags: Python, rstats, Social Network Analysis, Network Diffusion Models,
Infection Dynamics
</p>

