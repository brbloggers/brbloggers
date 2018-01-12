+++
title = "Transparência (5): Trabalhando com datas"
date = "2016-01-18 03:00:00"
categories = ["paixao-por-dados"]
original_url = "http://sillasgonzaga.github.io/2016-01-18-transparenciaParte5/"
+++

<article class="blog-post">
<p>
O dataset do Portal da Transparência traz três colunas relacionadas com
datas: <em>DATA\_INGRESSO\_CARGOFUNCAO</em>,
<em>DATA\_INGRESSO\_ORGAO</em> e
<em>DATA\_DIPLOMA\_INGRESSO\_SERVICOPUBLICO</em>, as quais geram umas
análises curiosas, principalmente se relacionadas com a variável
salário.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">library</span><span class="p">(</span><span class="n">treemap</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">dplyr</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">ggplot2</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">ggrepel</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">ggthemes</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">lubridate</span><span class="p">)</span><span class="w">
</span><span class="n">df</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">read.csv2</span><span class="p">(</span><span class="s2">&quot;/home/sillas/R/data/transparenciaComSalarios.csv&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">stringsAsFactors</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">FALSE</span><span class="p">,</span><span class="w"> </span><span class="n">fileEncoding</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;ISO-8859-15&quot;</span><span class="p">)</span></code></pre>
</figure>
<p>
Primeiro, as datas vêm neste formato:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">df</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">select</span><span class="p">(</span><span class="n">DATA_INGRESSO_CARGOFUNCAO</span><span class="p">,</span><span class="w"> </span><span class="n">DATA_INGRESSO_ORGAO</span><span class="p">,</span><span class="w"> </span><span class="n">DATA_DIPLOMA_INGRESSO_SERVICOPUBLICO</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">head</span><span class="p">()</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## DATA_INGRESSO_CARGOFUNCAO DATA_INGRESSO_ORGAO
## 1 01/07/2006 01/01/1984
## 2 22/10/2014 20/10/2014
## 3 &lt;NA&gt; 01/08/2015
## 4 30/11/2014 03/09/2014
## 5 19/05/2010 19/05/2010
## 6 02/02/2009 30/12/2008
## DATA_DIPLOMA_INGRESSO_SERVICOPUBLICO
## 1 01/06/1984
## 2 17/02/2010
## 3 01/08/2015
## 4 28/06/2006
## 5 19/05/2010
## 6 30/12/2008</code></pre>
</figure>
<p>
O R, nativamente, não reconhece este formato como data e sim como texto.
O formato de datas que o R aceita é o americano, YYYYMMDD. Felizmente, o
package <em>lubridate</em> torna muito fácil converter as datas:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">df</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">df</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">mutate</span><span class="p">(</span><span class="n">dataCargo</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">dmy</span><span class="p">(</span><span class="n">DATA_INGRESSO_CARGOFUNCAO</span><span class="p">),</span><span class="w"> </span><span class="n">dataOrgao</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">dmy</span><span class="p">(</span><span class="n">DATA_INGRESSO_ORGAO</span><span class="p">),</span><span class="w"> </span><span class="n">dataServico</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">dmy</span><span class="p">(</span><span class="n">DATA_DIPLOMA_INGRESSO_SERVICOPUBLICO</span><span class="p">))</span></code></pre>
</figure>
<p>
Essas três variáveis nos dão o dia em que os servidores começaram a
trabalhar. Para termos a quantidade de tempo que se passou desde então,
criei duas funções que fazem esse cálculo:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">CalcMeses</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">t</span><span class="m">0</span><span class="p">,</span><span class="w"> </span><span class="n">t</span><span class="o">=</span><span class="n">today</span><span class="p">())</span><span class="w"> </span><span class="p">{</span><span class="w"> </span><span class="n">x</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">interval</span><span class="p">(</span><span class="n">t</span><span class="m">0</span><span class="p">,</span><span class="w"> </span><span class="n">t</span><span class="p">)</span><span class="w"> </span><span class="n">x</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">as.period</span><span class="p">(</span><span class="n">x</span><span class="p">)</span><span class="w"> </span><span class="n">x</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">year</span><span class="p">(</span><span class="n">x</span><span class="p">)</span><span class="o">*</span><span class="m">12</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">month</span><span class="p">(</span><span class="n">x</span><span class="p">)</span><span class="w"> </span><span class="nf">return</span><span class="p">(</span><span class="n">x</span><span class="p">)</span><span class="w">
</span><span class="p">}</span><span class="w"> </span><span class="n">CalcAnos</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">t</span><span class="m">0</span><span class="p">,</span><span class="w"> </span><span class="n">t</span><span class="o">=</span><span class="n">today</span><span class="p">())</span><span class="w"> </span><span class="p">{</span><span class="w"> </span><span class="n">x</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">interval</span><span class="p">(</span><span class="n">t</span><span class="m">0</span><span class="p">,</span><span class="w"> </span><span class="n">t</span><span class="p">)</span><span class="w"> </span><span class="n">x</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">as.period</span><span class="p">(</span><span class="n">x</span><span class="p">)</span><span class="w"> </span><span class="n">x</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="nf">ceiling</span><span class="p">(</span><span class="n">year</span><span class="p">(</span><span class="n">x</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">month</span><span class="p">(</span><span class="n">x</span><span class="p">)</span><span class="o">/</span><span class="m">12</span><span class="p">)</span><span class="w"> </span><span class="nf">return</span><span class="p">(</span><span class="n">x</span><span class="p">)</span><span class="w">
</span><span class="p">}</span><span class="w"> </span><span class="n">df</span><span class="o">$</span><span class="n">meses.no.cargo</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">CalcMeses</span><span class="p">(</span><span class="n">df</span><span class="o">$</span><span class="n">dataCargo</span><span class="p">)</span><span class="w">
</span><span class="n">df</span><span class="o">$</span><span class="n">meses.no.orgao</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">CalcMeses</span><span class="p">(</span><span class="n">df</span><span class="o">$</span><span class="n">dataOrgao</span><span class="p">)</span><span class="w">
</span><span class="n">df</span><span class="o">$</span><span class="n">meses.como.servidor</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">CalcMeses</span><span class="p">(</span><span class="n">df</span><span class="o">$</span><span class="n">dataServico</span><span class="p">)</span><span class="w"> </span><span class="n">df</span><span class="o">$</span><span class="n">anos.no.cargo</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">CalcAnos</span><span class="p">(</span><span class="n">df</span><span class="o">$</span><span class="n">dataCargo</span><span class="p">)</span><span class="w">
</span><span class="n">df</span><span class="o">$</span><span class="n">anos.no.orgao</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">CalcAnos</span><span class="p">(</span><span class="n">df</span><span class="o">$</span><span class="n">dataOrgao</span><span class="p">)</span><span class="w">
</span><span class="n">df</span><span class="o">$</span><span class="n">anos.como.servidor</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">CalcAnos</span><span class="p">(</span><span class="n">df</span><span class="o">$</span><span class="n">dataServico</span><span class="p">)</span></code></pre>
</figure>
<p>
Agora podemos começar a fazer algumas perguntas aos nossos dados:
</p>
<h3 id="1-qual-o-tempo-m&#xE9;dio-em-meses-dos-servidores-no-brasil">
1.  Qual o tempo médio (em meses) dos servidores no Brasil?
    </h3>
    <figure class="highlight">
    <pre><code class="language-r"><span class="n">ggplot</span><span class="p">(</span><span class="n">df</span><span class="p">,</span><span class="w"> </span><span class="n">aes</span><span class="p">(</span><span class="n">x</span><span class="o">=</span><span class="n">anos.como.servidor</span><span class="p">))</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">geom_histogram</span><span class="p">(</span><span class="n">binwidth</span><span class="o">=</span><span class="m">1</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">scale_x_continuous</span><span class="p">(</span><span class="n">breaks</span><span class="o">=</span><span class="nf">c</span><span class="p">(</span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="n">seq</span><span class="p">(</span><span class="m">5</span><span class="p">,</span><span class="w"> </span><span class="nf">max</span><span class="p">(</span><span class="n">df</span><span class="o">$</span><span class="n">anos.como.servidor</span><span class="p">,</span><span class="w"> </span><span class="n">na.rm</span><span class="o">=</span><span class="nb">T</span><span class="p">)</span><span class="m">+1</span><span class="p">,</span><span class="w"> </span><span class="n">by</span><span class="o">=</span><span class="m">5</span><span class="p">)))</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">theme_bw</span><span class="p">()</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">labs</span><span class="p">(</span><span class="n">title</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Tempo em que os servidores federais est&#xE3;o trabalhando no Estado&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Tempo no servi&#xE7;o p&#xFA;blico em anos&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;N&#xFA;mero de servidores&quot;</span><span class="p">)</span></code></pre>
    </figure>
    <p>
    <img src="http://sillasgonzaga.github.io/figs/transparenciaParte5/unnamed-chunk-4-1.png" alt="center">
    </p>
    <p>
    <strong>Observações</strong>:
    </p>
    <ul>
    <li>
    A maioria dos servidores tomou posse há 3 anos.
    </li>
    <li>
    Existe um número absurdamente grande de servidores com mais de 30
    anos no serviço público. Na verdade, é mais comum encontrar um
    servidor que tenha mais de 30 anos de serviço do que entre 15 a 25.
    </li>
    <li>
    Existem alguns outliers que têm mais de 55 anos que causaram a
    distorção do histograma.
    </li>
    </ul>
    <p>
    Separado por região e excluindo os outliers:
    </p>
    <figure class="highlight">
    <pre><code class="language-r"><span class="n">escala</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="n">seq</span><span class="p">(</span><span class="m">5</span><span class="p">,</span><span class="w"> </span><span class="nf">max</span><span class="p">(</span><span class="n">df</span><span class="o">$</span><span class="n">anos.como.servidor</span><span class="p">,</span><span class="w"> </span><span class="n">na.rm</span><span class="o">=</span><span class="nb">T</span><span class="p">)</span><span class="m">+1</span><span class="p">,</span><span class="w"> </span><span class="n">by</span><span class="o">=</span><span class="m">5</span><span class="p">))</span><span class="w"> </span><span class="n">ggplot</span><span class="p">(</span><span class="n">subset</span><span class="p">(</span><span class="n">df</span><span class="p">,</span><span class="w"> </span><span class="n">anos.como.servidor</span><span class="w"> </span><span class="o">&lt;=</span><span class="w"> </span><span class="m">50</span><span class="p">),</span><span class="w"> </span><span class="n">aes</span><span class="p">(</span><span class="n">x</span><span class="o">=</span><span class="n">anos.como.servidor</span><span class="p">))</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">geom_histogram</span><span class="p">(</span><span class="n">binwidth</span><span class="o">=</span><span class="m">1</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">scale_x_continuous</span><span class="p">(</span><span class="n">breaks</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">escala</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">facet_grid</span><span class="p">(</span><span class="n">REGIAO</span><span class="o">~</span><span class="n">.</span><span class="p">,</span><span class="w"> </span><span class="n">scales</span><span class="o">=</span><span class="s2">&quot;free&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">theme_bw</span><span class="p">()</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">labs</span><span class="p">(</span><span class="n">title</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Tempo em que os servidores federais est&#xE3;o trabalhando no Estado&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Tempo no servi&#xE7;o p&#xFA;blico em anos&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;N&#xFA;mero de servidores&quot;</span><span class="p">)</span></code></pre>
    </figure>
    <p>
    <img src="http://sillasgonzaga.github.io/figs/transparenciaParte5/unnamed-chunk-5-1.png" alt="center">
    </p>
    <p>
    Fica muito fácil detectar a anomalia nos dados: o número de
    servidores que são funcionários do governo há mais de 35 anos na
    região Norte é assustador. São mais de 6000, muito mais do que em
    qualquer região. Na verdade, essa é a faixa de idade com mais
    pessoas dessa região.
    </p>
    <p>
    Separado por região, mas mostrado por boxplots:
    </p>
    <figure class="highlight">
    <pre><code class="language-r"><span class="c1">#Boxplot</span><span class="w">
    </span><span class="c1"># Regi&#xF5;es</span><span class="w">
    </span><span class="n">ggplot</span><span class="p">(</span><span class="n">data</span><span class="o">=</span><span class="n">df</span><span class="p">,</span><span class="w"> </span><span class="n">aes</span><span class="p">(</span><span class="n">x</span><span class="o">=</span><span class="n">REGIAO</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="o">=</span><span class="n">anos.como.servidor</span><span class="p">,</span><span class="w"> </span><span class="n">fill</span><span class="o">=</span><span class="n">REGIAO</span><span class="p">))</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">geom_boxplot</span><span class="p">()</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">scale_fill_brewer</span><span class="p">(</span><span class="n">palette</span><span class="o">=</span><span class="s2">&quot;Set1&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">guides</span><span class="p">(</span><span class="n">fill</span><span class="o">=</span><span class="kc">FALSE</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">scale_y_continuous</span><span class="p">(</span><span class="n">breaks</span><span class="o">=</span><span class="n">escala</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">labs</span><span class="p">(</span><span class="n">title</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Distribui&#xE7;&#xE3;o do tempo no servi&#xE7;o p&#xFA;blico de acordo com a regi&#xE3;o&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Regi&#xE3;o&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Anos como servidor&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">theme_bw</span><span class="p">()</span></code></pre>
    </figure>
    <p>
    <img src="http://sillasgonzaga.github.io/figs/transparenciaParte5/unnamed-chunk-6-1.png" alt="center">
    </p>
    <p>
    Depois do gráfico acima, acredito que não restam mais dúvidas que o
    Boxplot é uma ferramenta muito superior ao histograma quando o
    objetivo é comparar a distribuição de uma mesma variável numérica de
    acordo com outra variável categórica. Aqui, é muito mais fácil
    detectar que existe algo muito estranho no Norte: Os servidores de
    lá têm, em média, 25 anos de serviço público. A diferença para as
    outras regiões é colossal.
    </p>
    <p>
    As diferenças ficam ainda mais gritantes quando se faz a
    estratificação por estado. A linha verde horizontal representa a
    mediana geral do tempo em que as pessoas do dataset estão
    trabalhando para o governo:
    </p>
    <figure class="highlight">
    <pre><code class="language-r"><span class="c1">#: Agrupar estados por regi&#xE3;o</span><span class="w"> </span><span class="c1">#Vetor de cores:</span><span class="w">
    </span><span class="n">coresEstados</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="w"> </span><span class="c1">#Norte</span><span class="w"> </span><span class="s2">&quot;AM&quot;</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;#8dd3c7&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;AP&quot;</span><span class="o">=</span><span class="s2">&quot;#ffffb3&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;AC&quot;</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;#bebada&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;PA&quot;</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;#fb8072&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;RO&quot;</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;#80b1d3&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;RR&quot;</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;#fdb462&quot;</span><span class="p">,</span><span class="w"> </span><span class="c1">#Nordeste</span><span class="w"> </span><span class="s2">&quot;AL&quot;</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;#8dd3c7&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;BA&quot;</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;#ffffb3&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;CE&quot;</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;#bebada&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;MA&quot;</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;#fb8072&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;PB&quot;</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;#80b1d3&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;PE&quot;</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;#fdb462&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;PI&quot;</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;#b3de69&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;RN&quot;</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;#fccde5&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;SE&quot;</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;#d9d9d9&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;TO&quot;</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;#bc80bd&quot;</span><span class="p">,</span><span class="w"> </span><span class="c1">#CO</span><span class="w"> </span><span class="s2">&quot;DF&quot;</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;#8dd3c7&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;GO&quot;</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;#ffffb3&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;MS&quot;</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;#bebada&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;MT&quot;</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;#fb8072&quot;</span><span class="p">,</span><span class="w"> </span><span class="c1">#SUDESTE</span><span class="w"> </span><span class="s2">&quot;SP&quot;</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;#8dd3c7&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;RJ&quot;</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;#ffffb3&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;ES&quot;</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;#bebada&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;MG&quot;</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;#fb8072&quot;</span><span class="p">,</span><span class="w"> </span><span class="c1">#SUL</span><span class="w"> </span><span class="s2">&quot;PR&quot;</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;#b3de69&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;SC&quot;</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;#fccde5&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;RS&quot;</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;#d9d9d9&quot;</span><span class="w"> </span><span class="p">)</span><span class="w"> </span><span class="n">ggplot</span><span class="p">(</span><span class="n">data</span><span class="o">=</span><span class="n">df</span><span class="p">,</span><span class="w"> </span><span class="n">aes</span><span class="p">(</span><span class="n">x</span><span class="o">=</span><span class="n">UF_EXERCICIO</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="o">=</span><span class="n">anos.como.servidor</span><span class="p">,</span><span class="w"> </span><span class="n">fill</span><span class="o">=</span><span class="n">UF_EXERCICIO</span><span class="p">))</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">geom_boxplot</span><span class="p">()</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">facet_grid</span><span class="p">(</span><span class="n">.</span><span class="w"> </span><span class="o">~</span><span class="w"> </span><span class="n">REGIAO</span><span class="p">,</span><span class="w"> </span><span class="n">scales</span><span class="o">=</span><span class="s2">&quot;free&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">scale_y_continuous</span><span class="p">(</span><span class="n">breaks</span><span class="o">=</span><span class="n">escala</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">labs</span><span class="p">(</span><span class="n">title</span><span class="o">=</span><span class="s2">&quot;Tempo m&#xE9;dio dos servidores no\n funcionalismo p&#xFA;blico por estado&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">x</span><span class="o">=</span><span class="s2">&quot;Estado&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="o">=</span><span class="s2">&quot;Tempo como servidor em anos&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">scale_fill_manual</span><span class="p">(</span><span class="n">values</span><span class="o">=</span><span class="w"> </span><span class="n">coresEstados</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">guides</span><span class="p">(</span><span class="n">fill</span><span class="o">=</span><span class="kc">FALSE</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">geom_hline</span><span class="p">(</span><span class="n">aes</span><span class="p">(</span><span class="n">yintercept</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">median</span><span class="p">(</span><span class="n">df</span><span class="o">$</span><span class="n">anos.como.servidor</span><span class="p">,</span><span class="w"> </span><span class="n">na.rm</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">TRUE</span><span class="p">)),</span><span class="w"> </span><span class="n">color</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;green&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">theme</span><span class="p">(</span><span class="n">axis.text.x</span><span class="o">=</span><span class="n">element_text</span><span class="p">(</span><span class="n">angle</span><span class="o">=</span><span class="m">45</span><span class="p">))</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">theme_bw</span><span class="p">()</span></code></pre>
    </figure>
    <p>
    <img src="http://sillasgonzaga.github.io/figs/transparenciaParte5/unnamed-chunk-7-1.png" alt="center">
    </p>
    <p>
    <strong>Parem e percebam o quão absurda é a situação em
    Amapá</strong>, que merece dois comentários a parte:
    </p>
    <ul>
    <li>
    A mediana é igual a cerca de 37 anos. Na verdade, a distribuição é
    tão bagunçada que a mediana deixa de fazer sentido aqui nesse
    contexto.
    </li>
    <li>
    Os servidores com menos de 11 anos, que é a mediana geral, são
    considerados anomalia no estado.
    </li>
    <li>
    Em comparação, Tocantins parece ser uma situação oposta ao estado do
    Norte.
    </li>
    </ul>
    </article>

