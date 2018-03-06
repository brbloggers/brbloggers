+++
title = "Uma introdução ao Shiny e reatividade"
date = "2018-03-05 13:00:00"
categories = ["lurodrigo"]
original_url = "https://lurodrigo.github.io/2018/03/shiny-dashboard-reatividade"
+++

<p class="page__inner-wrap">
<header>
<p class="page__meta">
<i class="fa fa-clock-o"></i> 26 minutos de leitura
</p>
</header>
<section class="page__content">
<p>
O Shiny é um framework web para criação de aplicativos interativos.
Diferente dos frameworks para desenvolvimento web usuais, não há,
<em>necessariamente</em>, necessidade de conhecer HTML, CSS ou
Javascript, as linguagens básicas usadas para construir páginas da web.
</p>
<h2 id="a-estrutura-de-um-aplicativo-shiny">
A estrutura de um aplicativo Shiny
</h2>
<p>
Um aplicativo Shiny consiste de pelo menos dois arquivos:
<code class="highlighter-rouge">ui.R</code> e
<code class="highlighter-rouge">server.R</code>. O arquivo
<code class="highlighter-rouge">ui.R</code> descreve a interface do
aplicativo e o <code class="highlighter-rouge">server.R</code>, a
lógica. Na verdade, é possível construir aplicativos em um único arquivo
<code class="highlighter-rouge">app.R</code>, mas é um approach
inadequado para qualquer aplicativo com alguma complexidade, então não
comentarei sobre. Opcionalmente, é possível definir um arquivo
<code class="highlighter-rouge">global.R</code>. Tudo que for definido
no arquivo <code class="highlighter-rouge">global.R</code> estará
acessível tanto em ambos <code class="highlighter-rouge">ui.R</code> e
<code class="highlighter-rouge">server.R</code>. Portanto, recomendo
usar o arquivo global para carregar os pacotes e definir funções,
variáveis e constantes úteis para o aplicativo.
</p>
<pre class="highlight"><code><span class="c1"># global.R</span><span class="w"> </span><span class="n">library</span><span class="p">(</span><span class="n">shiny</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">shinydashboard</span><span class="p">)</span><span class="w">
</span></code></pre>

<p>
O arquivo <code class="highlighter-rouge">ui.R</code> especifica a
estrutura da página através de uma <em>domain- specific language</em>.
Essencialmente, o Shiny provê um conjunto de funções R que, nestadase
combinadas de maneira adequada, geram o código HTML correspondente. Eu
gosto de usar o pacote
<code class="highlighter-rouge">shinydashboard</code>, que permite a
criação de dashboards com estrutura um pouco mais complexa e melhor
aparência em comparação aos aplicativos Shiny padrão sem ter que se
preocupar muito com as configurações. A página mais simples possível a
ser gerada com o Shiny Dashboard é a seguinte:
</p>
<pre class="highlight"><code><span class="c1"># ui.R</span><span class="w"> </span><span class="n">dashboardPage</span><span class="p">(</span><span class="w"> </span><span class="n">dashboardHeader</span><span class="p">(),</span><span class="w"> </span><span class="n">dashboardSidebar</span><span class="p">(),</span><span class="w"> </span><span class="n">dashboardBody</span><span class="p">()</span><span class="w">
</span><span class="p">)</span><span class="w">
</span></code></pre>

<p>
Note que isso só gera HTML:
</p>
<pre class="highlight"><code><span class="n">print</span><span class="p">(</span><span class="n">dashboardPage</span><span class="p">(</span><span class="w"> </span><span class="n">dashboardHeader</span><span class="p">(),</span><span class="w"> </span><span class="n">dashboardSidebar</span><span class="p">(),</span><span class="w"> </span><span class="n">dashboardBody</span><span class="p">()</span><span class="w">
</span><span class="p">))</span><span class="w">
</span><span class="c1">#&gt; &lt;body class=&quot;skin-blue&quot; style=&quot;min-height: 611px;&quot;&gt;</span><span class="w">
</span><span class="c1">#&gt; &lt;div class=&quot;wrapper&quot;&gt;</span><span class="w">
</span><span class="c1">#&gt; &lt;header class=&quot;main-header&quot;&gt;</span><span class="w">
</span><span class="c1">#&gt; &lt;span class=&quot;logo&quot;&gt;&lt;/span&gt;</span><span class="w">
</span><span class="c1">#&gt; &lt;nav class=&quot;navbar navbar-static-top&quot; role=&quot;navigation&quot;&gt;</span><span class="w">
</span><span class="c1">#&gt; &lt;span style=&quot;display:none;&quot;&gt;</span><span class="w">
</span><span class="c1">#&gt; &lt;i class=&quot;fa fa-bars&quot;&gt;&lt;/i&gt;</span><span class="w">
</span><span class="c1">#&gt; &lt;/span&gt;</span><span class="w">
</span><span class="c1">#&gt; &lt;a href=&quot;#&quot; class=&quot;sidebar-toggle&quot; data-toggle=&quot;offcanvas&quot; role=&quot;button&quot;&gt;</span><span class="w">
</span><span class="c1">#&gt; &lt;span class=&quot;sr-only&quot;&gt;Toggle navigation&lt;/span&gt;</span><span class="w">
</span><span class="c1">#&gt; &lt;/a&gt;</span><span class="w">
</span><span class="c1">#&gt; &lt;div class=&quot;navbar-custom-menu&quot;&gt;</span><span class="w">
</span><span class="c1">#&gt; &lt;ul class=&quot;nav navbar-nav&quot;&gt;&lt;/ul&gt;</span><span class="w">
</span><span class="c1">#&gt; &lt;/div&gt;</span><span class="w">
</span><span class="c1">#&gt; &lt;/nav&gt;</span><span class="w">
</span><span class="c1">#&gt; &lt;/header&gt;</span><span class="w">
</span><span class="c1">#&gt; &lt;aside class=&quot;main-sidebar&quot; data-collapsed=&quot;false&quot;&gt;</span><span class="w">
</span><span class="c1">#&gt; &lt;section class=&quot;sidebar&quot;&gt;&lt;/section&gt;</span><span class="w">
</span><span class="c1">#&gt; &lt;/aside&gt;</span><span class="w">
</span><span class="c1">#&gt; &lt;div class=&quot;content-wrapper&quot;&gt;</span><span class="w">
</span><span class="c1">#&gt; &lt;section class=&quot;content&quot;&gt;&lt;/section&gt;</span><span class="w">
</span><span class="c1">#&gt; &lt;/div&gt;</span><span class="w">
</span><span class="c1">#&gt; &lt;/div&gt;</span><span class="w">
</span><span class="c1">#&gt; &lt;/body&gt;</span><span class="w">
</span></code></pre>

<p>
O arquivo <code class="highlighter-rouge">server.R</code> deve se
encerrar em uma função com três parâmetros:
<code class="highlighter-rouge">input</code>,
<code class="highlighter-rouge">output</code> e
<code class="highlighter-rouge">session</code>, sendo o último opcional.
Logo, o arquivo <code class="highlighter-rouge">server.R</code> mais
simples é o seguinte:
</p>
<pre class="highlight"><code><span class="c1"># server.R</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">input</span><span class="p">,</span><span class="w"> </span><span class="n">output</span><span class="p">,</span><span class="w"> </span><span class="n">session</span><span class="p">)</span><span class="w"> </span><span class="p">{</span><span class="w"> </span><span class="p">}</span><span class="w">
</span></code></pre>

<p>
Tendo esses três arquivos, já é possível gerar nosso primeiro aplicativo
Shiny. No RStudio, clique no botão “Run App” que está onde o botão
“Source” costumava estar.
</p>
<p>
<img src="https://lurodrigo.github.io/images/principios/vazio.PNG" alt="Bastante interessante">
</p>
<h2 id="estrutura-da-ui">
Estrutura da UI
</h2>
<p>
Podemos, é claro, customizar a interface. Podemos passar para a função
<code class="highlighter-rouge">dashboardHeader()</code>, entre outras
coisas, o parâmetro title. Também é possível criar menus
<em>dropdown</em>.
</p>
<pre class="highlight"><code><span class="n">dashboardHeader</span><span class="p">(</span><span class="n">title</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Appzinho&quot;</span><span class="p">)</span><span class="w">
</span></code></pre>

<p>
As abas são criadas utilizando a função
<code class="highlighter-rouge">sidebarMenu()</code> e passadas como
parâmetro para o
<code class="highlighter-rouge">dashboardSidebar()</code>. Para a função
<code class="highlighter-rouge">sidebarMenu()</code> devem ser passados
items criados com a função
<code class="highlighter-rouge">menuItem()</code>. O primeiro item é o
nome da aba como ela deve aparecer na sidebar. O parâmetro
<code class="highlighter-rouge">tabName</code> é o mais importante: deve
ser id único para identificar aquela aba. O parâmetro
<code class="highlighter-rouge">icon</code>, opcional, associa à aba um
ícone. Os identificadores que a função
<code class="highlighter-rouge">icon</code> aceita podem ser encontrados
<a href="http://fontawesome.io/icons">neste link</a>.
</p>
<pre class="highlight"><code><span class="n">dashboardSidebar</span><span class="p">(</span><span class="w"> </span><span class="n">sidebarMenu</span><span class="p">(</span><span class="w"> </span><span class="n">menuItem</span><span class="p">(</span><span class="s2">&quot;Aba 1&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">tabName</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;aba1&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">icon</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">icon</span><span class="p">(</span><span class="s2">&quot;star&quot;</span><span class="p">)),</span><span class="w"> </span><span class="n">menuItem</span><span class="p">(</span><span class="s2">&quot;Aba 2&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">tabName</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;aba2&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">icon</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">icon</span><span class="p">(</span><span class="s2">&quot;tag&quot;</span><span class="p">))</span><span class="w"> </span><span class="p">)</span><span class="w">
</span><span class="p">)</span><span class="w">
</span></code></pre>

<p>
De modo similar, o <em>conteúdo</em> é especificado na função
<code class="highlighter-rouge">tabItems()</code>, que deve ser passada
como parâmetro para
<code class="highlighter-rouge">dashboardBody()</code>. O conteúdo de
cada aba é criado dentro da função
<code class="highlighter-rouge">tabItem()</code>. Seu parâmetro mais
importante é o <code class="highlighter-rouge">tabName</code>, que liga
o link de uma aba na sidebar ao seu conteúdo. Obviamente, o valor de
<code class="highlighter-rouge">tabName</code> deve corresponder ao de
algum <code class="highlighter-rouge">menuItem()</code> da sidebar.
</p>
<pre class="highlight"><code><span class="n">dashboardBody</span><span class="p">(</span><span class="w"> </span><span class="n">tabItems</span><span class="p">(</span><span class="w"> </span><span class="n">tabItem</span><span class="p">(</span><span class="n">tabName</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;aba1&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;Conte&#xFA;do da primeira aba&quot;</span><span class="w"> </span><span class="p">),</span><span class="w"> </span><span class="n">tabItem</span><span class="p">(</span><span class="n">tabName</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;aba2&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;Conte&#xFA;do da segunda aba&quot;</span><span class="w"> </span><span class="p">)</span><span class="w"> </span><span class="p">)</span><span class="w">
</span><span class="p">)</span><span class="w">
</span></code></pre>

<p>
Com todas essas modificações no arquivo
<code class="highlighter-rouge">ui.R</code>:
</p>
<pre class="highlight"><code><span class="c1"># ui.R</span><span class="w"> </span><span class="n">dashboardPage</span><span class="p">(</span><span class="w"> </span><span class="n">dashboardHeader</span><span class="p">(</span><span class="n">title</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Appzinho&quot;</span><span class="p">),</span><span class="w"> </span><span class="n">dashboardSidebar</span><span class="p">(</span><span class="w"> </span><span class="n">sidebarMenu</span><span class="p">(</span><span class="w"> </span><span class="n">menuItem</span><span class="p">(</span><span class="s2">&quot;Aba 1&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">tabName</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;aba1&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">icon</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">icon</span><span class="p">(</span><span class="s2">&quot;star&quot;</span><span class="p">)),</span><span class="w"> </span><span class="n">menuItem</span><span class="p">(</span><span class="s2">&quot;Aba 2&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">tabName</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;aba2&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">icon</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">icon</span><span class="p">(</span><span class="s2">&quot;tag&quot;</span><span class="p">))</span><span class="w"> </span><span class="p">)</span><span class="w"> </span><span class="p">),</span><span class="w"> </span><span class="n">dashboardBody</span><span class="p">(</span><span class="w"> </span><span class="n">tabItems</span><span class="p">(</span><span class="w"> </span><span class="n">tabItem</span><span class="p">(</span><span class="n">tabName</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;aba1&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;Conte&#xFA;do da primeira aba&quot;</span><span class="w"> </span><span class="p">),</span><span class="w"> </span><span class="n">tabItem</span><span class="p">(</span><span class="n">tabName</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;aba2&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;Conte&#xFA;do da segunda aba&quot;</span><span class="w"> </span><span class="p">)</span><span class="w"> </span><span class="p">)</span><span class="w"> </span><span class="p">)</span><span class="w">
</span><span class="p">)</span><span class="w">
</span></code></pre>

<p>
<img src="https://lurodrigo.github.io/images/principios/ui.PNG" alt="">
</p>
<p>
O conteúdo se organiza dentro de caixinhas (<em>boxes</em>) que podem
ser de quatro tipos diferentes:
<code class="highlighter-rouge">box()</code>,
<code class="highlighter-rouge">tabBox()</code>,
<code class="highlighter-rouge">infoBox()</code>,
<code class="highlighter-rouge">valueBox()</code>. A forma como eles se
distribuem pela página pode ser por colunas, por linhas, ou um misto dos
dois. A
<a href="http://rstudio.github.io/shinydashboard/structure.html">página
do shinydashboard</a> explica melhor essas possibilidades. Por enquanto,
vou apenas criar duas caixinhas vazias para, nas próximas seções, criar
alguma funcionalidade.
</p>
<pre class="highlight"><code><span class="n">dashboardBody</span><span class="p">(</span><span class="w"> </span><span class="n">tabItems</span><span class="p">(</span><span class="w"> </span><span class="n">tabItem</span><span class="p">(</span><span class="n">tabName</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;aba1&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">fluidRow</span><span class="p">(</span><span class="w"> </span><span class="n">box</span><span class="p">(</span><span class="n">title</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Op&#xE7;&#xF5;es&quot;</span><span class="p">),</span><span class="w"> </span><span class="n">box</span><span class="p">(</span><span class="n">title</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Resultado&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">status</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;primary&quot;</span><span class="p">)</span><span class="w"> </span><span class="p">)</span><span class="w"> </span><span class="p">),</span><span class="w"> </span><span class="n">tabItem</span><span class="p">(</span><span class="n">tabName</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;aba2&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;Conte&#xFA;do da segunda aba&quot;</span><span class="w"> </span><span class="p">)</span><span class="w"> </span><span class="p">)</span><span class="w"> </span><span class="p">)</span><span class="w">
</span></code></pre>

<p>
<img src="https://lurodrigo.github.io/images/principios/boxes.PNG" alt="">
</p>
<h2 id="eventos-vs-reatividade">
Eventos vs Reatividade
</h2>
<p>
A lógica pela qual as interações usuário-sistema ocorrem no Shiny é um
pouco diferente do que ocorre em outros frameworks. A grande maioria
deles utiliza uma lógica baseada em eventos. Isto inclui VBA, jQuery,
.NET… Esses frameworks functionam, essencialmente, a partir da definição
de <em>handlers</em> para eventos que te interessam. Por exemplo,
imagine que uma interface tem uma caixinha “Sim/Não” cujo valor
interferisse na interface. Você teria que escrever código que
transformasse a interface do estado “sim” para o estado “não” e
vice-versa.
</p>
<p>
O principal problema do <em>approach</em> de eventos é que você tem que
se preocupar com o estado atual da aplicação e definir como chegar no
próximo estado. Usando uma analogia péssima, é como se precisássemos
programar como chegar ao estado <em>s</em><sub><em>n</em> + 1</sub> em
função do estado <em>s</em><sub><em>n</em></sub>.
</p>
<p>
Já o Shiny usa um approach chamado <em>reatividade</em>. A ideia é
evitar que nos preocupemos com o estado da aplicação: descrevemos como
<em>s</em><sub><em>n</em></sub> depende de <em>n</em> somente. O estado
do aplicativo é definido como uma <em>função</em> de determinadas
variáveis. Isto é, você definir como a interface deve estar quando as
variáveis assumirem seus valores. Toda vez que os valores forem
atualizados, o Shiny <em>reage</em> e atualiza automaticamente os
elementos da interface que dependem dele.
</p>
<p>
Vários frameworks novos, como o Angular (da Google) e o React (do
Facebook) seguem essa ideia, mas ela na verdade é bem antiga. Planilhas
do excel são exemplos clássicos de ambientes reativos: você define o
valor de uma célula como um cálculo a partir do valor de outras. Toda
vez que uma dessas células é atualizada, o valor é recalculado.
</p>
<h2 id="um-primeiro-exemplo-de-reatividade">
Um primeiro exemplo de reatividade
</h2>
<p>
Vamos produzir uma funcionalidade bem simples: o usuário deve os
fornecer uma texto e um número, e a saída produzida deve ser o texto
dado repetido n vezes. Para isso, precisamos primeiramente definir
objetos de entrada e de saída.
</p>
<h3 id="objetos-de-entrada-e-saída">
Objetos de entrada e saída
</h3>
<p>
Os valores resultantes das interações do usuário com o aplicativo entram
através de objetos de input. Eles devem ser definidas no arquivo
<code class="highlighter-rouge">ui.R</code> através de funções que
tipicamente terminam em <em>Input</em> \[1\]. Precisamos de uma caixa de
texto e de uma caixa numérica. O código abaixo faz isso. O parâmetro
mais importante é o primeiro: define um id para esses elementos. É
através desses ids que conseguiremos recuperar seus valores mais tarde.
</p>
<pre class="highlight"><code><span class="n">textInput</span><span class="p">(</span><span class="s2">&quot;texto&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">label</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Texto: &quot;</span><span class="p">)</span><span class="w"> </span><span class="n">numericInput</span><span class="p">(</span><span class="s2">&quot;numero&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">label</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;N&#xFA;mero: &quot;</span><span class="p">,</span><span class="w"> </span><span class="n">value</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">0</span><span class="p">,</span><span class="w"> </span><span class="n">min</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">0</span><span class="p">)</span><span class="w">
</span></code></pre>

<p>
Precisamos também de um objeto de output para exibir o resultado.
Objetos de output também são definidos no
<code class="highlighter-rouge">ui.R</code>, tipicamente por via de
funções terminadas em <em>Output</em>. No caso, queremos uma saída de
texto. Nesse caso simples passamos um único parâmetro, o seu id.
</p>
<p>
Aplicando isso ao <code class="highlighter-rouge">ui.R</code>:
</p>
<pre class="highlight"><code><span class="n">tabItem</span><span class="p">(</span><span class="n">tabName</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;aba1&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">fluidRow</span><span class="p">(</span><span class="w"> </span><span class="n">box</span><span class="p">(</span><span class="n">title</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Op&#xE7;&#xF5;es&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">solidHeader</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">TRUE</span><span class="p">,</span><span class="w"> </span><span class="n">textInput</span><span class="p">(</span><span class="s2">&quot;texto&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">label</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Texto: &quot;</span><span class="p">),</span><span class="w"> </span><span class="n">numericInput</span><span class="p">(</span><span class="s2">&quot;numero&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">label</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;N&#xFA;mero: &quot;</span><span class="p">,</span><span class="w"> </span><span class="n">value</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">0</span><span class="p">,</span><span class="w"> </span><span class="n">min</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">0</span><span class="p">)</span><span class="w"> </span><span class="p">),</span><span class="w"> </span><span class="n">box</span><span class="p">(</span><span class="n">title</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Resultado&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">status</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;primary&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">textOutput</span><span class="p">(</span><span class="s2">&quot;saida&quot;</span><span class="p">)</span><span class="w"> </span><span class="p">)</span><span class="w"> </span><span class="p">)</span><span class="w">
</span><span class="p">)</span><span class="w">
</span></code></pre>

<p>
Obtemos o seguinte:
</p>
<p>
<img src="https://lurodrigo.github.io/images/principios/inputs.PNG" alt="">
</p>
<p>
Já podemos brincar com os elementos de entrada, mas nada acontece ainda
porque precisamos definir o que a aplicação deve fazer.
</p>
<h3 id="definindo-o-comportamento-da-aplicação">
Definindo o comportamento da aplicação
</h3>
<p>
É nesse pedaço que entra o arquivo
<code class="highlighter-rouge">server.R</code>. O código que faz a
funcionalidade que queremos é bem simples:
</p>
<pre class="highlight"><code><span class="nf">rep</span><span class="p">(</span><span class="n">texto</span><span class="p">,</span><span class="w"> </span><span class="n">numero</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">paste</span><span class="p">(</span><span class="n">collapse</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot; &quot;</span><span class="p">)</span><span class="w">
</span></code></pre>

<p>
Basta então aplicar a lógica do Shiny. Os valores de entrada devem ser
acessados através da variável
<code class="highlighter-rouge">input</code> e os de saída,
especificados através da variável
<code class="highlighter-rouge">output</code>. Com um detalhe: esse
código deve estar dentro de uma função renderizadora correspondente ao
tipo de output. Como temos um
<code class="highlighter-rouge">textOutput</code>, precisamos enviar
esse código para a função
<code class="highlighter-rouge">renderText()</code> e então atribuir
esse valor algum output.
</p>
<p>
Vejamos como isto fica na prática:
</p>
<pre class="highlight"><code><span class="c1"># global.R</span><span class="w"> </span><span class="n">library</span><span class="p">(</span><span class="n">shiny</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">shinydashboard</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">dplyr</span><span class="p">)</span><span class="w">
</span></code></pre>

<pre class="highlight"><code><span class="c1"># server.R</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">input</span><span class="p">,</span><span class="w"> </span><span class="n">output</span><span class="p">,</span><span class="w"> </span><span class="n">session</span><span class="p">)</span><span class="w"> </span><span class="p">{</span><span class="w"> </span><span class="n">output</span><span class="o">$</span><span class="n">saida</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">renderText</span><span class="p">({</span><span class="w"> </span><span class="nf">rep</span><span class="p">(</span><span class="n">input</span><span class="o">$</span><span class="n">texto</span><span class="p">,</span><span class="w"> </span><span class="n">input</span><span class="o">$</span><span class="n">numero</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">paste</span><span class="p">(</span><span class="n">collapse</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot; &quot;</span><span class="p">)</span><span class="w"> </span><span class="p">})</span><span class="w">
</span><span class="p">}</span><span class="w">
</span></code></pre>

<p>
Obtemos o seguinte resultado:
</p>
<p>
<img src="https://lurodrigo.github.io/images/principios/rep.PNG" alt="">
</p>
<p>
Note que, anteriormente, eu havia falado que a ideia da reatividade é
definir elementos da interface em <em>função</em> do valor das outras.
Neste caso, <code class="highlighter-rouge">saida</code> é uma função
dos valores de
<code class="highlighter-rouge">input$texto&lt;/code&gt; e &lt;code class="highlighter-rouge"&gt;input$numero</code>.
Note que isso não ocorre de maneira explicita: não definimos nenhuma
<code class="highlighter-rouge">function</code> com esses dois
parâmetros. Os mecanismos internos do Shiny leem o bloco de código que
passamos para a função renderizadora e conseguem detectar quais os
<em>valores reativos</em> de que esse código depende. Neste caso são
apenas dois. Sabendo disso, o Shiny reexecuta o bloco de código toda vez
que um dos valores for atualizado.
</p>
<h2 id="um-segundo-exemplo-de-reatividade">
Um segundo exemplo de reatividade
</h2>
<p>
O próximo exemplo irá mostrar que descrever interações através da
reatividade não é uma tarefa tão trivial.
</p>
<h3 id="parando-reações-isolate">
Parando reações: isolate()
</h3>
<p>
Teremos inicialmente um input numérico e um botão. Deve ser gerado um
gráfico contendo n pontos aleatórios. Esse botão deve gerar um novo plot
aleatório toda vez que for clicado.
</p>
<p>
Começamos definindo os novos elementos gráficos necessários.
Precisaremos de uma caixa numérica, um botão e uma saída de plot. O
código seguinte para a segunda aba faz isso:
</p>
<pre class="highlight"><code><span class="n">tabItem</span><span class="p">(</span><span class="n">tabName</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;aba2&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">fluidRow</span><span class="p">(</span><span class="w"> </span><span class="n">box</span><span class="p">(</span><span class="n">title</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Par&#xE2;metros&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">numericInput</span><span class="p">(</span><span class="s2">&quot;npontos&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;N&#xFA;mero de pontos:&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">value</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">10</span><span class="p">,</span><span class="w"> </span><span class="n">min</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">0</span><span class="p">),</span><span class="w"> </span><span class="n">actionButton</span><span class="p">(</span><span class="s2">&quot;atualizar&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;Atualizar&quot;</span><span class="p">)</span><span class="w"> </span><span class="p">),</span><span class="w"> </span><span class="n">box</span><span class="p">(</span><span class="n">title</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Plot&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">plotOutput</span><span class="p">(</span><span class="s2">&quot;plot&quot;</span><span class="p">)</span><span class="w"> </span><span class="p">)</span><span class="w"> </span><span class="p">)</span><span class="w"> </span><span class="p">)</span><span class="w">
</span></code></pre>

<p>
O código corresponde no server seria o seguinte:
</p>
<pre class="highlight"><code><span class="n">output</span><span class="o">$</span><span class="n">plot</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">renderPlot</span><span class="p">({</span><span class="w"> </span><span class="n">df</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">data.frame</span><span class="p">(</span><span class="w"> </span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">rnorm</span><span class="p">(</span><span class="n">input</span><span class="o">$</span><span class="n">npontos</span><span class="p">),</span><span class="w"> </span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">rnorm</span><span class="p">(</span><span class="n">input</span><span class="o">$</span><span class="n">npontos</span><span class="p">)</span><span class="w"> </span><span class="p">)</span><span class="w"> </span><span class="n">ggplot</span><span class="p">(</span><span class="n">df</span><span class="p">,</span><span class="w"> </span><span class="n">aes</span><span class="p">(</span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">x</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">y</span><span class="p">))</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">geom_point</span><span class="p">()</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">geom_smooth</span><span class="p">(</span><span class="n">method</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;lm&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">se</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">FALSE</span><span class="p">)</span><span class="w">
</span><span class="p">})</span><span class="w">
</span></code></pre>

<p>
O exemplo anterior, do modo como está, tem um pequeno contratempo: Ele
gera um gráfico novo toda vez que o valor de npontos mudar. Ocorre que
esse talvez não seja o melhor comportamento, pois quando digitamos um
número grande, serão gerados alguns plots intermediários com duração
efêmera, o que pode, dependendo do tipo de processamento, causar
travamentos ou impacto visual desagradável.
</p>
<p>
Precisamos então colocar o botão de atualizar para funcionar, mas temos
uma questão conceitual para pensar primeiro. Num framework reativo, as
expressões reativas são recalculadas toda vez que um dos valores
reativos muda. Queremos que o plot seja gerado novamente a cada clique
no botão, então é claro que o plot depende, de certa forma, do botão.
Mas o que seria o <em>valor</em> do botão? Claramente, um botão não tem
armazena nenhum valor intrinsecamente. A solução implementada pelos
engenheiros do Shiny é associar ao botão o número de vezes que ele foi
clicado. Dessa forma, toda vez que for clicado, a contagem aumenta e as
reações são desencadeadas.
</p>
<p>
Voltando ao nosso código, basta que adicionemos uma referência a
<code class="highlighter-rouge">input$atualizar&lt;/code&gt; em algum momento no interior de &lt;code class="highlighter-rouge"&gt;renderPlot()&lt;/code&gt;. No caso, ter&\#xE1; de ser uma refer&\#xEA;ncia um tanto vazia:&lt;/p&gt; &lt;div class="language-r highlighter-rouge"&gt;&lt;div class="highlight"&gt;&lt;pre class="highlight"&gt;&lt;code&gt;&lt;span class="n"&gt;output&lt;/span&gt;&lt;span class="o"&gt;$</span><span
class="n">plot</span><span class="w"> </span><span
class="o">=</span><span class="w"> </span><span
class="n">renderPlot</span><span class="p">({</span><span class="w">
</span><span class="n">input</span><span
class="o">$&lt;/span&gt;&lt;span class="n"&gt;atualizar&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="n"&gt;df&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="o"&gt;=&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="n"&gt;data.frame&lt;/span&gt;&lt;span class="p"&gt;(&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="n"&gt;x&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="o"&gt;=&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="n"&gt;rnorm&lt;/span&gt;&lt;span class="p"&gt;(&lt;/span&gt;&lt;span class="n"&gt;input&lt;/span&gt;&lt;span class="o"&gt;$</span><span
class="n">npontos</span><span class="p">),</span><span class="w">
</span><span class="n">y</span><span class="w"> </span><span
class="o">=</span><span class="w"> </span><span
class="n">rnorm</span><span class="p">(</span><span
class="n">input</span><span
class="o">$&lt;/span&gt;&lt;span class="n"&gt;npontos&lt;/span&gt;&lt;span class="p"&gt;)&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="p"&gt;)&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="n"&gt;ggplot&lt;/span&gt;&lt;span class="p"&gt;(&lt;/span&gt;&lt;span class="n"&gt;df&lt;/span&gt;&lt;span class="p"&gt;,&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="n"&gt;aes&lt;/span&gt;&lt;span class="p"&gt;(&lt;/span&gt;&lt;span class="n"&gt;x&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="o"&gt;=&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="n"&gt;x&lt;/span&gt;&lt;span class="p"&gt;,&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="n"&gt;y&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="o"&gt;=&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="n"&gt;y&lt;/span&gt;&lt;span class="p"&gt;))&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="o"&gt;+&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="n"&gt;geom\_point&lt;/span&gt;&lt;span class="p"&gt;()&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="o"&gt;+&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="n"&gt;geom\_smooth&lt;/span&gt;&lt;span class="p"&gt;(&lt;/span&gt;&lt;span class="n"&gt;method&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="o"&gt;=&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="s2"&gt;&quot;lm&quot;&lt;/span&gt;&lt;span class="p"&gt;,&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="n"&gt;se&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="o"&gt;=&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="kc"&gt;FALSE&lt;/span&gt;&lt;span class="p"&gt;)&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="p"&gt;})&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;/code&gt;&lt;/pre&gt;&lt;/div&gt;&lt;/div&gt; &lt;p&gt;O bot&\#xE3;o agora funciona, mas ainda precisamos fazer com que o plot pare de atualizar toda vez que o n&\#xFA;mero de pontos for alterado. Ele certamente depende desse n&\#xFA;mero de pontos, por&\#xE9;m. E agora?&lt;/p&gt; &lt;p&gt;Esse &\#xE9; um caso de uso t&\#xED;pico da fun&\#xE7;&\#xE3;o &lt;code class="highlighter-rouge"&gt;isolate()&lt;/code&gt;: queremos usar um valor ou express&\#xE3;o reativa, mas n&\#xE3;o queremos criar uma rela&\#xE7;&\#xE3;o de depend&\#xEA;ncia reativa. Basta colocar o valor ou a express&\#xE3;o reativa dentro de &lt;code class="highlighter-rouge"&gt;isolate()&lt;/code&gt;:&lt;/p&gt; &lt;div class="language-r highlighter-rouge"&gt;&lt;div class="highlight"&gt;&lt;pre class="highlight"&gt;&lt;code&gt;&lt;span class="n"&gt;output&lt;/span&gt;&lt;span class="o"&gt;$</span><span
class="n">plot</span><span class="w"> </span><span
class="o">=</span><span class="w"> </span><span
class="n">renderPlot</span><span class="p">({</span><span class="w">
</span><span class="n">input</span><span
class="o">$&lt;/span&gt;&lt;span class="n"&gt;atualizar&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="n"&gt;npontos&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="o"&gt;=&lt;/span&gt;&lt;span class="w"&gt; &lt;/span&gt;&lt;span class="n"&gt;isolate&lt;/span&gt;&lt;span class="p"&gt;(&lt;/span&gt;&lt;span class="n"&gt;input&lt;/span&gt;&lt;span class="o"&gt;$</span><span
class="n">npontos</span><span class="p">)</span><span class="w">
</span><span class="n">df</span><span class="w"> </span><span
class="o">=</span><span class="w"> </span><span
class="n">data.frame</span><span class="p">(</span><span class="w">
</span><span class="n">x</span><span class="w"> </span><span
class="o">=</span><span class="w"> </span><span
class="n">rnorm</span><span class="p">(</span><span
class="n">npontos</span><span class="p">),</span><span class="w">
</span><span class="n">y</span><span class="w"> </span><span
class="o">=</span><span class="w"> </span><span
class="n">rnorm</span><span class="p">(</span><span
class="n">npontos</span><span class="p">)</span><span class="w">
</span><span class="p">)</span><span class="w"> </span><span
class="n">ggplot</span><span class="p">(</span><span
class="n">df</span><span class="p">,</span><span class="w"> </span><span
class="n">aes</span><span class="p">(</span><span
class="n">x</span><span class="w"> </span><span class="o">=</span><span
class="w"> </span><span class="n">x</span><span class="p">,</span><span
class="w"> </span><span class="n">y</span><span class="w"> </span><span
class="o">=</span><span class="w"> </span><span class="n">y</span><span
class="p">))</span><span class="w"> </span><span class="o">+</span><span
class="w"> </span><span class="n">geom\_point</span><span
class="p">()</span><span class="w"> </span><span class="o">+</span><span
class="w"> </span><span class="n">geom\_smooth</span><span
class="p">(</span><span class="n">method</span><span class="w">
</span><span class="o">=</span><span class="w"> </span><span
class="s2">"lm"</span><span class="p">,</span><span class="w">
</span><span class="n">se</span><span class="w"> </span><span
class="o">=</span><span class="w"> </span><span
class="kc">FALSE</span><span class="p">)</span><span class="w">
</span><span class="p">})</span><span class="w"> </span></code>
</pre>
</div>
</div>
<h3 id="condutores-reativos-reactive">
Condutores reativos: reactive()
</h3>
<p>
No caso em que trabalhamos só com um plot, é aceitável gerar esses dados
aleatórios dentro do renderPlot(). Suponha que queiramos gerar dois (ou
mais) gráficos diferentes a partir da mesma tabela. Não poderíamos mais
simplesmente gerar os tabela dentro de um dos renderizadores, pois ela
não seria acessível dentro do outro renderizador. Também não faria
sentido colocar o código que gera os pontos em cada renderizador, pois
seriam gerados <em>com alta probabilidade</em> plots diferentes.
</p>
<p>
Precisamos, então, gerar os pontos <em>fora</em> dos renderizadores de
algum modo. Tente o seguinte:
</p>
<pre class="highlight"><code><span class="c1"># server.R</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">input</span><span class="p">,</span><span class="w"> </span><span class="n">output</span><span class="p">,</span><span class="w"> </span><span class="n">session</span><span class="p">)</span><span class="w"> </span><span class="p">{</span><span class="w"> </span><span class="n">output</span><span class="o">$</span><span class="n">saida</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">renderText</span><span class="p">({</span><span class="w"> </span><span class="nf">rep</span><span class="p">(</span><span class="n">input</span><span class="o">$</span><span class="n">texto</span><span class="p">,</span><span class="w"> </span><span class="n">input</span><span class="o">$</span><span class="n">numero</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">paste</span><span class="p">(</span><span class="n">collapse</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot; &quot;</span><span class="p">)</span><span class="w"> </span><span class="p">})</span><span class="w"> </span><span class="n">npontos</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">isolate</span><span class="p">(</span><span class="n">input</span><span class="o">$</span><span class="n">npontos</span><span class="p">)</span><span class="w"> </span><span class="n">df</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">data.frame</span><span class="p">(</span><span class="w"> </span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">rnorm</span><span class="p">(</span><span class="n">npontos</span><span class="p">),</span><span class="w"> </span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">rnorm</span><span class="p">(</span><span class="n">npontos</span><span class="p">)</span><span class="w"> </span><span class="p">)</span><span class="w"> </span><span class="n">output</span><span class="o">$</span><span class="n">plot</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">renderPlot</span><span class="p">({</span><span class="w"> </span><span class="n">input</span><span class="o">$</span><span class="n">atualizar</span><span class="w"> </span><span class="n">ggplot</span><span class="p">(</span><span class="n">df</span><span class="p">,</span><span class="w"> </span><span class="n">aes</span><span class="p">(</span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">x</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">y</span><span class="p">))</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">geom_point</span><span class="p">()</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">geom_smooth</span><span class="p">(</span><span class="n">method</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;lm&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">se</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">FALSE</span><span class="p">)</span><span class="w"> </span><span class="p">})</span><span class="w">
</span><span class="p">}</span><span class="w">
</span></code></pre>

<p>
Agora o plot não atualiza mais <em>de jeito nenhum</em>! Por quê? Porque
df não está definido num contexto reativo, ela está no corpo da função
do modo usual. Isso implica que aquele trecho de código só será
executado uma vez, logo que o server.R é carregado no início. Note que
isso independe do uso de
<code class="highlighter-rouge">isolate()</code>.
</p>
<p>
Para resolver esse tipo de situação (e outras mais) foi pensado o
conceito de <em>condutor reativo</em>, que se aplica ao que queremos
fazer com o <code class="highlighter-rouge">df</code>. Queremos que ele
seja uma função de npontos (e do botão de atualizar) e que, por sua vez,
os plots sejam uma função de <code class="highlighter-rouge">df</code>.
A terminologia surge por analogia:
<code class="highlighter-rouge">df</code> estará <em>conduzindo</em>
reações dos inputs até os outputs.
</p>
<p>
Ok, como sempre, primeiro temos que definir os plots na ui:
</p>
<pre class="highlight"><code><span class="n">tabItem</span><span class="p">(</span><span class="n">tabName</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;aba2&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">fluidRow</span><span class="p">(</span><span class="w"> </span><span class="n">box</span><span class="p">(</span><span class="n">title</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Par&#xE2;metros&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">numericInput</span><span class="p">(</span><span class="s2">&quot;npontos&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;N&#xFA;mero de pontos:&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">value</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">10</span><span class="p">,</span><span class="w"> </span><span class="n">min</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">0</span><span class="p">),</span><span class="w"> </span><span class="n">actionButton</span><span class="p">(</span><span class="s2">&quot;atualizar&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;Atualizar&quot;</span><span class="p">)</span><span class="w"> </span><span class="p">),</span><span class="w"> </span><span class="n">box</span><span class="p">(</span><span class="n">title</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Plot&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">plotOutput</span><span class="p">(</span><span class="s2">&quot;plot&quot;</span><span class="p">)</span><span class="w"> </span><span class="p">)</span><span class="w"> </span><span class="p">),</span><span class="w"> </span><span class="n">fluidRow</span><span class="p">(</span><span class="w"> </span><span class="n">box</span><span class="p">(</span><span class="n">title</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Distribui&#xE7;&#xE3;o do x&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">plotOutput</span><span class="p">(</span><span class="s2">&quot;plotx&quot;</span><span class="p">)</span><span class="w"> </span><span class="p">),</span><span class="w"> </span><span class="n">box</span><span class="p">(</span><span class="n">title</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Distribui&#xE7;&#xE3;o do y&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">plotOutput</span><span class="p">(</span><span class="s2">&quot;ploty&quot;</span><span class="p">)</span><span class="w"> </span><span class="p">)</span><span class="w"> </span><span class="p">)</span><span class="w">
</span><span class="p">)</span><span class="w">
</span></code></pre>

<p>
Para definir condutores reativos, usamos a função
<code class="highlighter-rouge">reactive()</code> com um valor ou
expressão dentro. Um detalhe chato é que, para usar os valores definidos
deste modo, precisamos suceder o nome com parênteses, do mesmo modo que
chamamos funções.
</p>
<pre class="highlight"><code><span class="c1"># server.R</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">input</span><span class="p">,</span><span class="w"> </span><span class="n">output</span><span class="p">,</span><span class="w"> </span><span class="n">session</span><span class="p">)</span><span class="w"> </span><span class="p">{</span><span class="w"> </span><span class="n">output</span><span class="o">$</span><span class="n">saida</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">renderText</span><span class="p">({</span><span class="w"> </span><span class="nf">rep</span><span class="p">(</span><span class="n">input</span><span class="o">$</span><span class="n">texto</span><span class="p">,</span><span class="w"> </span><span class="n">input</span><span class="o">$</span><span class="n">numero</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">paste</span><span class="p">(</span><span class="n">collapse</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot; &quot;</span><span class="p">)</span><span class="w"> </span><span class="p">})</span><span class="w"> </span><span class="n">df</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">reactive</span><span class="p">({</span><span class="w"> </span><span class="n">input</span><span class="o">$</span><span class="n">atualizar</span><span class="w"> </span><span class="n">npontos</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">isolate</span><span class="p">(</span><span class="n">input</span><span class="o">$</span><span class="n">npontos</span><span class="p">)</span><span class="w"> </span><span class="n">data.frame</span><span class="p">(</span><span class="w"> </span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">rnorm</span><span class="p">(</span><span class="n">npontos</span><span class="p">),</span><span class="w"> </span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">rnorm</span><span class="p">(</span><span class="n">npontos</span><span class="p">)</span><span class="w"> </span><span class="p">)</span><span class="w"> </span><span class="p">})</span><span class="w"> </span><span class="n">output</span><span class="o">$</span><span class="n">plot</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">renderPlot</span><span class="p">({</span><span class="w"> </span><span class="n">ggplot</span><span class="p">(</span><span class="n">df</span><span class="p">(),</span><span class="w"> </span><span class="n">aes</span><span class="p">(</span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">x</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">y</span><span class="p">))</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">geom_point</span><span class="p">()</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">geom_smooth</span><span class="p">(</span><span class="n">method</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;lm&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">se</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">FALSE</span><span class="p">)</span><span class="w"> </span><span class="p">})</span><span class="w"> </span><span class="n">output</span><span class="o">$</span><span class="n">plotx</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">renderPlot</span><span class="p">({</span><span class="w"> </span><span class="n">ggplot</span><span class="p">(</span><span class="n">df</span><span class="p">())</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">geom_density</span><span class="p">(</span><span class="n">mapping</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">aes</span><span class="p">(</span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">x</span><span class="p">))</span><span class="w"> </span><span class="p">})</span><span class="w"> </span><span class="n">output</span><span class="o">$</span><span class="n">ploty</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">renderPlot</span><span class="p">({</span><span class="w"> </span><span class="n">ggplot</span><span class="p">(</span><span class="n">df</span><span class="p">())</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">geom_density</span><span class="p">(</span><span class="n">mapping</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">aes</span><span class="p">(</span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">y</span><span class="p">))</span><span class="w"> </span><span class="p">})</span><span class="w">
</span><span class="p">}</span><span class="w">
</span></code></pre>

<p>
<img src="https://lurodrigo.github.io/images/principios/densidade.PNG" alt="">
</p>
<h3 id="ações-event-like-observe-e-observeevent">
Ações event-like: observe() e observeEvent()
</h3>
<p>
Existem casos de uso que simplesmente não se encaixam de uma forma óbvia
no paradigma de reatividade. Casos envolvendo botões são os mais
clássicos. Imagine que queremos colocar uma caixa de texto para definir
o título do plot. É conveniente um botão para apagar a caixa de texto. A
ação de apagar o texto claramente acontece como reação ao aperto de
botão, mas ela não gera valor nenhum. Nesse caso, usamos observadores.
Eles observam toda vez que os valores reativos no código mudam e, quando
isso ocorre, o reexecuta, mas nenhum valor precisa ser gerado.
</p>
<p>
Primeiro, adicionemos os elementos necessários à UI.
</p>
<pre class="highlight"><code><span class="n">box</span><span class="p">(</span><span class="n">title</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Par&#xE2;metros&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">textInput</span><span class="p">(</span><span class="s2">&quot;titulo&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;T&#xED;tulo do plot: &quot;</span><span class="p">),</span><span class="w"> </span><span class="n">numericInput</span><span class="p">(</span><span class="s2">&quot;npontos&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;N&#xFA;mero de pontos:&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">value</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">10</span><span class="p">,</span><span class="w"> </span><span class="n">min</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">0</span><span class="p">),</span><span class="w"> </span><span class="n">actionButton</span><span class="p">(</span><span class="s2">&quot;atualizar&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;Atualizar&quot;</span><span class="p">),</span><span class="w"> </span><span class="n">actionButton</span><span class="p">(</span><span class="s2">&quot;limpar&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;Limpar&quot;</span><span class="p">)</span><span class="w">
</span><span class="p">)</span><span class="w">
</span></code></pre>

<p>
Para implementar observadores, podemos usar equivalentemente
<code class="highlighter-rouge">observe()</code> ou
<code class="highlighter-rouge">observeEvent()</code>. A diferença entre
as duas é que <code class="highlighter-rouge">observeEvent()</code>
observa apenas um valor reativo, enquanto
<code class="highlighter-rouge">observe()</code> observa todos os
valores reativos no seu interior. Utilizamos a função
<code class="highlighter-rouge">updateTextInput()</code> para mudar o
valor contido na caixa de texto.
</p>
<pre class="highlight"><code><span class="n">output</span><span class="o">$</span><span class="n">plot</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">renderPlot</span><span class="p">({</span><span class="w"> </span><span class="n">ggplot</span><span class="p">(</span><span class="n">df</span><span class="p">(),</span><span class="w"> </span><span class="n">aes</span><span class="p">(</span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">x</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">y</span><span class="p">))</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">geom_point</span><span class="p">()</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">geom_smooth</span><span class="p">(</span><span class="n">method</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;lm&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">se</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">FALSE</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">ggtitle</span><span class="p">(</span><span class="n">input</span><span class="o">$</span><span class="n">titulo</span><span class="p">)</span><span class="w">
</span><span class="p">})</span><span class="w"> </span><span class="n">observeEvent</span><span class="p">(</span><span class="n">input</span><span class="o">$</span><span class="n">limpar</span><span class="p">,</span><span class="w"> </span><span class="p">{</span><span class="w"> </span><span class="n">updateTextInput</span><span class="p">(</span><span class="n">session</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;titulo&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">value</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;&quot;</span><span class="p">)</span><span class="w">
</span><span class="p">})</span><span class="w"> </span><span class="c1"># com observe():</span><span class="w"> </span><span class="c1"># observe({</span><span class="w">
</span><span class="c1"># input$limpar</span><span class="w">
</span><span class="c1"># updateTextInput(session, &quot;titulo&quot;, value = &quot;&quot;)</span><span class="w">
</span><span class="c1"># })</span><span class="w">
</span></code></pre>

<p>
\[1\] Uma lista mais completa de tipos de elementos de input e output
disponíveis no Shiny pode ser encontrada
<a href="http://shiny.rstudio.com/reference/shiny/latest/">aqui</a>.
</p>
</section>
<footer class="page__meta">
<p class="page__taxonomy">
<strong><i class="fa fa-fw fa-tags"></i> Tags: </strong> <span>
<a href="https://lurodrigo.github.io/tags/#r" class="page__taxonomy-item">R</a><span
class="sep">, </span>
<a href="https://lurodrigo.github.io/tags/#reatividade" class="page__taxonomy-item">Reatividade</a><span
class="sep">, </span>
<a href="https://lurodrigo.github.io/tags/#shiny" class="page__taxonomy-item">Shiny</a><span
class="sep">, </span>
<a href="https://lurodrigo.github.io/tags/#shinydashboard" class="page__taxonomy-item">shinydashboard</a>
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
<time>March 05, 2018</time>
</p>
</footer>
<section class="page__share">
<a href="https://twitter.com/intent/tweet?via=lu_rodrigo&amp;text=Uma%20introdu&#xE7;&#xE3;o%20ao%20Shiny%20e%20reatividade%20https://lurodrigo.github.io/2018/03/shiny-dashboard-reatividade/" class="btn btn--twitter"><i class="fa fa-fw fa-twitter"></i><span>
Twitter</span></a>
<a href="https://www.facebook.com/sharer/sharer.php?u=https://lurodrigo.github.io/2018/03/shiny-dashboard-reatividade/" class="btn btn--facebook"><i class="fa fa-fw fa-facebook"></i><span>
Facebook</span></a>
<a href="https://plus.google.com/share?url=https://lurodrigo.github.io/2018/03/shiny-dashboard-reatividade/" class="btn btn--google-plus"><i class="fa fa-fw fa-google-plus"></i><span>
Google+</span></a>
<a href="https://www.linkedin.com/shareArticle?mini=true&amp;url=https://lurodrigo.github.io/2018/03/shiny-dashboard-reatividade/" class="btn btn--linkedin"><i class="fa fa-fw fa-linkedin"></i><span>
LinkedIn</span></a>
</section>
</p>

