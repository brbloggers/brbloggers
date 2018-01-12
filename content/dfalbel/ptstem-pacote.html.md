+++
title = "Pacote ptstem"
date = "2016-09-30"
categories = ["dfalbel"]
original_url = "http://dfalbel.github.io/2016/09/ptstem-pacote.html"
+++

<p class="post">
<article class="post-content">
<p>
No <a href="https://github.com/dfalbel/">meu github</a> você pode
encontrar o pacote
<a href="https://github.com/dfalbel/ptstem"><code class="highlighter-rouge">ptstem</code></a>.
</p>
<p>
Esse pacote unifica a API de uso de três algoritmos de stemming para a
língua portuguesa disponíveis no R.
</p>
<h2 id="instalando">
Instalando
</h2>
<p>
Você pode instalar direto do
<a href="https://github.com/dfalbel/ptstem">github</a> com o seguinte
comando:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">devtools</span><span class="o">::</span><span class="n">install_github</span><span class="p">(</span><span class="s2">&quot;dfalbel/ptstem&quot;</span><span class="p">)</span></code></pre>
</figure>
<p>
ou pelo <a href="https://cran.r-project.org/package=ptstem">CRAN</a>
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">install.packages</span><span class="p">(</span><span class="s2">&quot;ptstem&quot;</span><span class="p">)</span></code></pre>
</figure>
<h2 id="usando">
Usando
</h2>
<p>
Considere o seguinte texto, extraído artigo
<a href="https://pt.wikipedia.org/wiki/Stemiza%C3%A7%C3%A3o"><em>Stemming</em>
da Wikipedia</a>
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">text</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="s2">&quot;Em morfologia lingu&#xED;stica e recupera&#xE7;&#xE3;o de informa&#xE7;&#xE3;o a stemiza&#xE7;&#xE3;o (do ingl&#xEA;s, stemming) &#xE9;
o processo de reduzir palavras flexionadas (ou &#xE0;s vezes derivadas) ao seu tronco (stem), base ou
raiz, geralmente uma forma da palavra escrita. O tronco n&#xE3;o precisa ser id&#xEA;ntico &#xE0; raiz morfol&#xF3;gica
da palavra; ele geralmente &#xE9; suficiente que palavras relacionadas sejam mapeadas para o mesmo
tronco, mesmo se este tronco n&#xE3;o for ele pr&#xF3;prio uma raiz v&#xE1;lida. O estudo de algoritmos para
stemiza&#xE7;&#xE3;o tem sido realizado em ci&#xEA;ncia da computa&#xE7;&#xE3;o desde a d&#xE9;cada de 60. V&#xE1;rios motores de
buscas tratam palavras com o mesmo tronco como sin&#xF4;nimos como um tipo de expans&#xE3;o de consulta, em
um processo de combina&#xE7;&#xE3;o.&quot;</span></code></pre>
</figure>
<p>
O seguinte código usa o pacote
<a href="https://github.com/dfalbel/rslp"><code class="highlighter-rouge">rslp</code></a>
para afzer o stemming do texto.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">library</span><span class="p">(</span><span class="n">ptstem</span><span class="p">)</span><span class="w">
</span><span class="n">ptstem</span><span class="p">(</span><span class="n">text</span><span class="p">,</span><span class="w"> </span><span class="n">algorithm</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;rslp&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">complete</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">FALSE</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## [1] &quot;Em morfolog linguis e recuper de inform a stemiz (do ingl, stemming) &#xE9;\no process de reduz palavr flexion (ou &#xE0;s vez deriv) ao seu tronc (st), bas ou\nraiz, geral uma form da palavr escrit. O tronc nao precis ser ident &#xE0; raiz morfolog\nda palavr; ele geral &#xE9; sufici que palavr relacion sej mape par o mesm\ntronc, mesm se est tronc nao for ele propri uma raiz val. O estud de algoritm par\nstemiz tem sid realiz em cienc da comput desd a dec de 60. Vari motor de\nbusc trat palavr com o mesm tronc com sinon com um tip de expans de consult, em\num process de combin.&quot;</code></pre>
</figure>
<p>
Você pode completar as palavras que foram <em>stemizadas</em> usando o
argumento <code class="highlighter-rouge">complete = T</code>.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">ptstem</span><span class="p">(</span><span class="n">text</span><span class="p">,</span><span class="w"> </span><span class="n">algorithm</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;rslp&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">complete</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">TRUE</span><span class="p">)</span></code></pre>
</figure>
<p>
Os outros algoritmos implementados são:
</p>
<ul>
<li>
hunspell: o mesmo algoritmo usado no corretor do OpenOffice. (disponível
via <a href="https://github.com/ropensci/hunspell">hunspell</a> package)
</li>
<li>
porter: disponível pelo pacote SnowballC.
</li>
</ul>
<p>
Você pode trocar o algoritmo utilziado por meio do argumento
<code class="highlighter-rouge">algorithm</code> da função
<code class="highlighter-rouge">ptstem</code>:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">library</span><span class="p">(</span><span class="n">ptstem</span><span class="p">)</span><span class="w">
</span><span class="n">ptstem</span><span class="p">(</span><span class="n">text</span><span class="p">,</span><span class="w"> </span><span class="n">algorithm</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;hunspell&quot;</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## [1] &quot;Em morfologia lingu&#xED;stica e recupera&#xE7;&#xE3;o de informa&#xE7;&#xE3;o a stemiza&#xE7;&#xE3;o (do ingl&#xEA;s, stemiza&#xE7;&#xE3;o) &#xE9;\no processo de reduzir palavras flexionadas (ou &#xE0;s vezes derivadas) ao seu tronco (stemiza&#xE7;&#xE3;o), base ou\nraiz, geralmente uma forma da palavras escrita. O tronco n&#xE3;o precisa ser id&#xEA;ntico &#xE0; raiz morfologia\nda palavras; ele geralmente &#xE9; suficiente que palavras relacionadas ser mapeadas para o mesmo\ntronco, mesmo se este tronco n&#xE3;o for ele pr&#xF3;prio uma raiz v&#xE1;lida. O estudo de algoritmos para\nstemiza&#xE7;&#xE3;o tem ser realizado em ci&#xEA;ncia da computa&#xE7;&#xE3;o desde a d&#xE9;cada de 60. V&#xE1;rios motores de\nbuscas tratam palavras com o mesmo tronco como sin&#xF4;nimos como um tipo de expans&#xE3;o de consulta, em\num processo de combina&#xE7;&#xE3;o.&quot;</code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-r"><span class="n">ptstem</span><span class="p">(</span><span class="n">text</span><span class="p">,</span><span class="w"> </span><span class="n">algorithm</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;porter&quot;</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## [1] &quot;Em morfologia lingu&#xED;stica e recupera&#xE7;&#xE3;o de informa&#xE7;&#xE3;o a stemiza&#xE7;&#xE3;o (do ingl&#xEA;s, stemming) &#xE9;\no processo de reduzir palavras flexionadas (ou &#xE0;s vezes derivadas) ao seu tronco (stem), base ou\nraiz, geralmente uma forma da palavras escrita. O tronco n&#xE3;o precisa ser id&#xEA;ntico &#xE0; raiz morfol&#xF3;gica\nda palavras; ele geralmente &#xE9; suficiente que palavras relacionadas sejam mapeadas para o mesmo\ntronco, mesmo se este tronco n&#xE3;o for ele pr&#xF3;prio uma raiz v&#xE1;lida. O estudo de algoritmos para\nstemiza&#xE7;&#xE3;o tem sido realizado em ci&#xEA;ncia da computa&#xE7;&#xE3;o desde a d&#xE9;cada de 60. V&#xE1;rios motores de\nbuscas tratam palavras com o mesmo tronco com sin&#xF4;nimos com um tipo de expans&#xE3;o de consulta, em\num processo de combina&#xE7;&#xE3;o.&quot;</code></pre>
</figure>
</article>
<br> <ins class="adsbygoogle"></ins> <br>
</p>

