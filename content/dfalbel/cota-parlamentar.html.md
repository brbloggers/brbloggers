+++
title = "Uso da cota parlamentar"
date = "2016-09-30"
categories = ["dfalbel"]
original_url = "http://dfalbel.github.io/2016/09/cota-parlamentar.html"
+++

<p class="post">
<article class="post-content">
<p>
Na semana passada adicionei o repositório
<a href="https://github.com/dfalbel/cota-parlamentar">cota-parlamentar</a>
no meu <a href="https://github.com/dfalbel">github</a>.
</p>
<p>
Neste repositório é possível encontrar uma base de os dados relativa aos
gastos parlamentares registrados na Câmara dos Deputados. Esses dados
são disponibilizados <em>abertamente</em> no
<a href="http://www2.camara.leg.br/transparencia/cota-para-exercicio-da-atividade-parlamentar/dados-abertos-cota-parlamentar">site
do câmara</a>. Digo <em>abertamente</em> pois, o formato disponibilizado
(xml), apesar de completo, é longe de ser o ideal para fazer alguma
análise.
</p>
<p>
Portanto, o que está no meu repositório, é o banco de dados
<em>parseado</em> e em csv, em formato de colunas.
</p>
<h2 id="ler">
Ler
</h2>
<p>
Os dados têm 48MB e podem ser lidos tranquilamente no R da seguinte
forma:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">dados</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">readr</span><span class="o">::</span><span class="n">read_csv</span><span class="p">(</span><span class="s2">&quot;https://github.com/dfalbel/cota-parlamentar/blob/master/data/cota-parlamentar-2016.csv?raw=true&quot;</span><span class="p">)</span></code></pre>
</figure>
<h2 id="anlise-mais-simples">
Análise mais simples
</h2>
<p>
Deputados que mais gastaram em 2016:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">library</span><span class="p">(</span><span class="n">tidyverse</span><span class="p">)</span><span class="w">
</span><span class="n">dados</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">group_by</span><span class="p">(</span><span class="n">txNomeParlamentar</span><span class="p">,</span><span class="w"> </span><span class="n">sgPartido</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">summarise</span><span class="p">(</span><span class="n">vlrLiquido</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">sum</span><span class="p">(</span><span class="n">vlrLiquido</span><span class="p">,</span><span class="w"> </span><span class="n">na.rm</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nb">T</span><span class="p">))</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">ungroup</span><span class="p">()</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">arrange</span><span class="p">(</span><span class="n">desc</span><span class="p">(</span><span class="n">vlrLiquido</span><span class="p">))</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">slice</span><span class="p">(</span><span class="m">1</span><span class="o">:</span><span class="m">10</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## # A tibble: 10 &#xD7; 3
## txNomeParlamentar sgPartido vlrLiquido
## &lt;chr&gt; &lt;chr&gt; &lt;dbl&gt;
## 1 ROCHA PSDB 424778.6
## 2 HIRAN GON&#xC7;ALVES PP 404409.8
## 3 ZENAIDE MAIA PR 386474.9
## 4 CARLOS ANDRADE PHS 385338.9
## 5 ANT&#xD4;NIO J&#xC1;COME PTN 380091.1
## 6 EDIO LOPES PR 379983.8
## 7 HILDO ROCHA PMDB 379095.8
## 8 S&#xC1;GUAS MORAES PT 377859.1
## 9 VINICIUS GURGEL PR 377258.6
## 10 NILTON CAPIXABA PTB 375241.1</code></pre>
</figure>
<p>
Deputados que menos gastaram em 2016:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">dados</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">group_by</span><span class="p">(</span><span class="n">txNomeParlamentar</span><span class="p">,</span><span class="w"> </span><span class="n">sgPartido</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">summarise</span><span class="p">(</span><span class="n">vlrLiquido</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">sum</span><span class="p">(</span><span class="n">vlrLiquido</span><span class="p">,</span><span class="w"> </span><span class="n">na.rm</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nb">T</span><span class="p">))</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">ungroup</span><span class="p">()</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">arrange</span><span class="p">(</span><span class="n">vlrLiquido</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">slice</span><span class="p">(</span><span class="m">1</span><span class="o">:</span><span class="m">10</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## # A tibble: 10 &#xD7; 3
## txNomeParlamentar sgPartido vlrLiquido
## &lt;chr&gt; &lt;chr&gt; &lt;dbl&gt;
## 1 ROS&#xC2;NGELA CURADO PDT -1335.98
## 2 F&#xC1;TIMA BEZERRA PT -21.49
## 3 MERLONG SOLANO PT 11.73
## 4 MIGUEL CORR&#xCA;A PT 14.13
## 5 REINHOLD STEPHANES PSD 53.52
## 6 SEBASTI&#xC3;O OLIVEIRA PR 108.24
## 7 MARCO ANT&#xD4;NIO CABRAL PMDB 133.52
## 8 SERGIO ZVEITER PMDB 314.11
## 9 JOSIAS GOMES PT 899.29
## 10 CAPIT&#xC3;O F&#xC1;BIO ABREU PTB 963.67</code></pre>
</figure>
<h2 id="prximos-passos">
Próximos passos
</h2>
<ul>
<li>
No site são disponibilizados arquivos de diversos anos. No repositório,
só disponibilizei o arquivo do ano de 2016.
</li>
<li>
Esses dados são atualizados diariamente. Ainda não tive tempo de criar
uma rotina de atualização automática.
</li>
<li>
Ainda vou fazer mais posts de análises desse banco de dados.
</li>
</ul>
</article>
<br> <ins class="adsbygoogle"></ins> <br>
</p>

