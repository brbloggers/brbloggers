+++
title = "Censo da Educação Superior (2): Como plotar o movimento migratório universitário no Brasil em um mapa"
date = "2016-06-08 03:00:00"
categories = ["paixao-por-dados"]
original_url = "http://sillasgonzaga.github.io/2016-06-08-censo_educ_superior2/"
+++

<article class="blog-post">
<p>
No primeiro post sobre os microdados do Censo da Educação Superior,
falei sobre as cidades e estados que mais atraem universitários de fora.
Neste segundo post, discutirei mais a fundo este movimento migratório
universitário, incluindo a elaboração de um rebusco mapa de fluxo
migratório.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">library</span><span class="p">(</span><span class="n">stringr</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">tidyr</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">magrittr</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">dplyr</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">feather</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">maptools</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">maps</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">geosphere</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">knitr</span><span class="p">)</span></code></pre>
</figure>
<p>
Para plotar em um mapa os universitários que estudam em uma cidade
diferente da que nasceram, precisamos de dois tipos de dados:
</p>
<ul>
<li>
Dados espaciais dos municípios brasileiros;
</li>
<li>
Um <a href="https://pt.wikipedia.org/wiki/Shapefile">shapefile</a> dos
estados brasileiros
</li>
<li>
Dados de universitários que estudam em uma cidade diferente da que
nasceram;
</li>
</ul>
<h2 id="dados-espaciais">
Dados espaciais
</h2>
<p>
Para poder localizar os municípios brasileiros em um mapa, precisamos de
dados sobre suas latitudes e longitudes. Em minhas pesquisas, a melhor
fonte que eu encontrei foi
<a href="http://www.monolitonimbus.com.br/coordenadas-geograficas-das-cidades-do-brasil/">neste
site</a>, que fornece o link para baixar um arquivo KML contendo os
dados que precisamos. Para fazer a conversão de KML para um formato
tratável pelo R, usei comandos em linux, como indicado pelo próprio
site.
</p>
<p>
<strong>ATENÇÃO</strong>: Eu baixei o KML descrito acima em 08/06/2016,
mas no momento que escrevo este post, o ftp do IBGE para baixar esse
arquivo está fora do ar. Por isso, eu disponibilizei os arquivos KML e
CSV no
<a href="https://github.com/sillasgonzaga/sillasgonzaga.github.io/tree/master/data">meu
Github</a>.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">df_coord</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">read.csv2</span><span class="p">(</span><span class="s2">&quot;https://raw.githubusercontent.com/sillasgonzaga/sillasgonzaga.github.io/master/data/coordenadas_BR.csv&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">stringsAsFactors</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">FALSE</span><span class="p">,</span><span class="w"> </span><span class="n">header</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">FALSE</span><span class="p">)</span><span class="w"> </span><span class="c1"># Ver estrutura do arquivo</span><span class="w">
</span><span class="n">head</span><span class="p">(</span><span class="n">df_coord</span><span class="p">,</span><span class="w"> </span><span class="m">10</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## V1 V2
## 1 ## 2 ## 3 BARRA DO QUARA&#xCD; RIO GRANDE DO SUL
## 4 URUGUAIANA RIO GRANDE DO SUL
## 5 QUARA&#xCD; RIO GRANDE DO SUL
## 6 SANT&amp;apos ANA DO LIVRAMENTO
## 7 ANA DO LIVRAMENTO -55.5348142679597,-30.8893840103812,200.677824
## 8 ITAQUI RIO GRANDE DO SUL
## 9 ALEGRETE RIO GRANDE DO SUL
## 10 MA&#xC7;AMBAR&#xC1; RIO GRANDE DO SUL
## V3
## 1 ## 2 ## 3 BARRA DO QUARA&#xCD;
## 4 URUGUAIANA
## 5 QUARA&#xCD;
## 6 RIO GRANDE DO SUL
## 7 ## 8 ITAQUI
## 9 ALEGRETE
## 10 MA&#xC7;AMBAR&#xC1;
## V4
## 1 ## 2 ## 3 -57.5570603248122,-30.2110754071007,42.0408
## 4 -57.0818249090229,-29.7598231712009,78.23018999999999
## 5 -56.4536470403836,-30.3828679600575,118.674261
## 6 SANT&amp;apos
## 7 ## 8 -56.55713349703041,-29.128636898258,62.084645
## 9 -55.7958701453331,-29.78204320831051,94.73120299999999
## 10 -56.06361348173561,-29.146144198381,104.458392</code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-r"><span class="c1"># Acrescentar nomes de colunas</span><span class="w">
</span><span class="nf">names</span><span class="p">(</span><span class="n">df_coord</span><span class="p">)</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="s2">&quot;municipio&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;uf&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;municipio_localidade&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;coordenadas&quot;</span><span class="p">)</span><span class="w">
</span><span class="c1"># Remover duas primeiras linhas</span><span class="w">
</span><span class="n">df_coord</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">df_coord</span><span class="p">[</span><span class="o">-</span><span class="p">(</span><span class="m">1</span><span class="o">:</span><span class="m">2</span><span class="p">),]</span><span class="w">
</span><span class="c1"># Remover linha na coluna uf se cont&#xE9;m n&#xFA;mero</span><span class="w">
</span><span class="n">df_coord</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">df_coord</span><span class="p">[</span><span class="o">!</span><span class="n">grepl</span><span class="p">(</span><span class="s2">&quot;\\d&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">df_coord</span><span class="o">$</span><span class="n">uf</span><span class="p">),]</span><span class="w">
</span><span class="c1"># Remover linha na coluna coordenadas se NAO contem numero</span><span class="w">
</span><span class="n">df_coord</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">df_coord</span><span class="p">[</span><span class="n">grepl</span><span class="p">(</span><span class="s2">&quot;\\d&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">df_coord</span><span class="o">$</span><span class="n">coordenadas</span><span class="p">),]</span><span class="w">
</span><span class="c1"># Separar coluna de coordenadas em tr&#xEA;s e remover a &#xFA;ltima</span><span class="w">
</span><span class="n">df_coord</span><span class="w"> </span><span class="o">%&lt;&gt;%</span><span class="w"> </span><span class="n">separate</span><span class="p">(</span><span class="n">coordenadas</span><span class="p">,</span><span class="w"> </span><span class="n">into</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="s1">&apos;x1&apos;</span><span class="p">,</span><span class="w"> </span><span class="s1">&apos;x2&apos;</span><span class="p">,</span><span class="w"> </span><span class="s1">&apos;x3&apos;</span><span class="p">),</span><span class="w"> </span><span class="n">sep</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;,&quot;</span><span class="p">)</span><span class="w"> </span><span class="n">df_coord</span><span class="w"> </span><span class="o">%&lt;&gt;%</span><span class="w"> </span><span class="n">filter</span><span class="p">(</span><span class="n">municipio</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="n">municipio_localidade</span><span class="p">)</span><span class="w">
</span><span class="c1"># remover &#xFA;ltima coluna</span><span class="w">
</span><span class="n">df_coord</span><span class="w"> </span><span class="o">%&lt;&gt;%</span><span class="w"> </span><span class="n">select</span><span class="p">(</span><span class="o">-</span><span class="n">x</span><span class="m">3</span><span class="p">,</span><span class="w"> </span><span class="o">-</span><span class="n">municipio_localidade</span><span class="p">,</span><span class="w"> </span><span class="o">-</span><span class="n">uf</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">rename</span><span class="p">(</span><span class="n">lat</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">x</span><span class="m">2</span><span class="p">,</span><span class="w"> </span><span class="n">lon</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">x</span><span class="m">1</span><span class="p">)</span><span class="w">
</span><span class="c1"># remover acentos da coluna de municipio_localidade</span><span class="w">
</span><span class="n">df_coord</span><span class="o">$</span><span class="n">municipio</span><span class="w"> </span><span class="o">%&lt;&gt;%</span><span class="w"> </span><span class="n">iconv</span><span class="p">(</span><span class="n">to</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;ASCII//TRANSLIT&quot;</span><span class="p">)</span><span class="w">
</span><span class="c1"># remover duplicatas</span><span class="w">
</span><span class="n">df_coord</span><span class="w"> </span><span class="o">%&lt;&gt;%</span><span class="w"> </span><span class="n">distinct</span><span class="p">(</span><span class="n">municipio</span><span class="p">)</span><span class="w">
</span><span class="n">head</span><span class="p">(</span><span class="n">df_coord</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## municipio lon lat
## 1 BARRA DO QUARAI -57.5570603248122 -30.2110754071007
## 2 URUGUAIANA -57.0818249090229 -29.7598231712009
## 3 QUARAI -56.4536470403836 -30.3828679600575
## 4 ITAQUI -56.55713349703041 -29.128636898258
## 5 ALEGRETE -55.7958701453331 -29.78204320831051
## 6 MACAMBARA -56.06361348173561 -29.146144198381</code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-r"><span class="c1"># Precisamos de uma coluna com o c&#xF3;digo do munic&#xED;pio.</span><span class="w">
</span><span class="c1"># Para isso, usamos o arquivo df_cidades usado no post1 que eu disponibilizei tbm no github</span><span class="w">
</span><span class="n">df_cidades</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">read.csv2</span><span class="p">(</span><span class="s2">&quot;https://raw.githubusercontent.com/sillasgonzaga/sillasgonzaga.github.io/master/data/municipiosBR.csv&quot;</span><span class="p">)</span><span class="w">
</span><span class="nf">names</span><span class="p">(</span><span class="n">df_cidades</span><span class="p">)</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="s2">&quot;uf&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;cod_municipio&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;municipio&quot;</span><span class="p">)</span><span class="w"> </span><span class="n">df_cidades</span><span class="o">$</span><span class="n">municipio</span><span class="w"> </span><span class="o">%&lt;&gt;%</span><span class="w"> </span><span class="n">iconv</span><span class="p">(</span><span class="n">to</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;ASCII//TRANSLIT&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">str_to_upper</span><span class="p">()</span><span class="w">
</span><span class="n">df_cidades</span><span class="w"> </span><span class="o">%&lt;&gt;%</span><span class="w"> </span><span class="n">left_join</span><span class="p">(</span><span class="n">df_coord</span><span class="p">,</span><span class="w"> </span><span class="n">by</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s1">&apos;municipio&apos;</span><span class="p">)</span><span class="w">
</span><span class="n">df_cidades</span><span class="w"> </span><span class="o">%&lt;&gt;%</span><span class="w"> </span><span class="n">na.omit</span><span class="p">()</span><span class="w">
</span><span class="n">df_cidades</span><span class="o">$</span><span class="n">lon</span><span class="w"> </span><span class="o">%&lt;&gt;%</span><span class="w"> </span><span class="nf">as.numeric</span><span class="p">()</span><span class="w">
</span><span class="n">df_cidades</span><span class="o">$</span><span class="n">lat</span><span class="w"> </span><span class="o">%&lt;&gt;%</span><span class="w"> </span><span class="nf">as.numeric</span><span class="p">()</span><span class="w">
</span><span class="n">head</span><span class="p">(</span><span class="n">df_cidades</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## uf cod_municipio municipio lon lat
## 2 RO 1100379 ALTO ALEGRE DOS PARECIS -61.85308 -12.131777
## 3 RO 1100403 ALTO PARAISO -53.73289 -23.508131
## 5 RO 1100023 ARIQUEMES -63.03327 -9.908463
## 6 RO 1100452 BURITIS -63.82968 -10.209805
## 7 RO 1100031 CABIXI -60.54431 -13.499763
## 8 RO 1100601 CACAULANDIA -62.90319 -10.338873</code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-r"><span class="c1"># Importar o shapefile</span><span class="w">
</span><span class="c1"># dispon&#xED;vel em https://github.com/sillasgonzaga/sillasgonzaga.github.io/raw/master/data/estados_2010.shp</span><span class="w">
</span><span class="n">estados</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">readShapePoly</span><span class="p">(</span><span class="s2">&quot;/home/sillas/R/Projetos/CensoEducSuperior/Dados/shapefiles/estados_2010/estados_2010.shp&quot;</span><span class="p">)</span></code></pre>
</figure>
<h2 id="dados-de-universitários">
Dados de universitários
</h2>
<p>
O <code class="highlighter-rouge">DM\_ALUNO.csv</code>, tratado no post
anterior, e filtrado para os casos em que o município de nascimento não
é o mesmo do município da IES:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="c1"># importar df original</span><span class="w">
</span><span class="n">system.time</span><span class="p">(</span><span class="n">df</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">read_feather</span><span class="p">(</span><span class="s2">&quot;/home/sillas/R/Projetos/CensoEducSuperior/Dados/dm_aluno_tratado.feather&quot;</span><span class="p">))</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## user system elapsed ## 4.516 0.892 6.141</code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-r"><span class="n">df</span><span class="w"> </span><span class="o">%&lt;&gt;%</span><span class="w"> </span><span class="n">filter</span><span class="p">(</span><span class="n">municipio_diferente</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="m">1</span><span class="p">)</span><span class="w">
</span><span class="c1"># excluir cidades que n&#xE3;o est&#xE3;o presentes no df_cidades</span><span class="w">
</span><span class="n">df</span><span class="w"> </span><span class="o">%&lt;&gt;%</span><span class="w"> </span><span class="n">filter</span><span class="p">(</span><span class="n">CO_MUNICIPIO_NASCIMENTO</span><span class="w"> </span><span class="o">%in%</span><span class="w"> </span><span class="n">df_cidades</span><span class="o">$</span><span class="n">cod_municipio</span><span class="w"> </span><span class="o">&amp;</span><span class="w"> </span><span class="n">CO_MUNICIPIO_IES</span><span class="w"> </span><span class="o">%in%</span><span class="w"> </span><span class="n">df_cidades</span><span class="o">$</span><span class="n">cod_municipio</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-r"><span class="c1"># selecionar apenas colunas referentes &#xE0;s cidades</span><span class="w">
</span><span class="n">df_agg</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">df</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">select</span><span class="p">(</span><span class="n">cod_mun_aluno</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">CO_MUNICIPIO_NASCIMENTO</span><span class="p">,</span><span class="w"> </span><span class="n">nome_mun_aluno</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">municipioNascimento</span><span class="p">,</span><span class="w"> </span><span class="n">cod_mun_ies</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">CO_MUNICIPIO_IES</span><span class="p">,</span><span class="w"> </span><span class="n">nome_mun_ies</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">municipioIES</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">group_by</span><span class="p">(</span><span class="n">cod_mun_aluno</span><span class="p">,</span><span class="w"> </span><span class="n">nome_mun_aluno</span><span class="p">,</span><span class="w"> </span><span class="n">cod_mun_ies</span><span class="p">,</span><span class="w"> </span><span class="n">nome_mun_ies</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">tally</span><span class="p">(</span><span class="n">sort</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">TRUE</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">ungroup</span><span class="p">()</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">rename</span><span class="p">(</span><span class="n">qtd</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">n</span><span class="p">)</span><span class="w"> </span><span class="c1"># Os 10 fluxos migrat&#xF3;rios mais comuns</span><span class="w">
</span><span class="n">df_agg</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">top_n</span><span class="p">(</span><span class="n">n</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">10</span><span class="p">,</span><span class="w"> </span><span class="n">wt</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">qtd</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">select</span><span class="p">(</span><span class="n">nome_mun_aluno</span><span class="p">,</span><span class="w"> </span><span class="n">nome_mun_ies</span><span class="p">,</span><span class="w"> </span><span class="n">qtd</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">kable</span><span class="p">()</span></code></pre>
</figure>
<table>
<thead>
<tr>
<th>
nome\_mun\_aluno
</th>
<th>
nome\_mun\_ies
</th>
<th>
qtd
</th>
</tr>
</thead>
<tbody>
<tr>
<td>
Aracaju (SE)
</td>
<td>
Săo Cristóvăo (SE)
</td>
<td>
17574
</td>
</tr>
<tr>
<td>
Contagem (MG)
</td>
<td>
Belo Horizonte (MG)
</td>
<td>
11023
</td>
</tr>
<tr>
<td>
Niterói (RJ)
</td>
<td>
Rio de Janeiro (RJ)
</td>
<td>
16817
</td>
</tr>
<tr>
<td>
Rio de Janeiro (RJ)
</td>
<td>
Duque de Caxias (RJ)
</td>
<td>
12676
</td>
</tr>
<tr>
<td>
Rio de Janeiro (RJ)
</td>
<td>
Săo Gonçalo (RJ)
</td>
<td>
11029
</td>
</tr>
<tr>
<td>
São Bernardo do Campo (SP)
</td>
<td>
Săo Paulo (SP)
</td>
<td>
10811
</td>
</tr>
<tr>
<td>
São Paulo (SP)
</td>
<td>
Guarulhos (SP)
</td>
<td>
14762
</td>
</tr>
<tr>
<td>
São Paulo (SP)
</td>
<td>
Săo Bernardo do Campo (SP)
</td>
<td>
15408
</td>
</tr>
<tr>
<td>
Porto Alegre (RS)
</td>
<td>
Indaial (SC)
</td>
<td>
11902
</td>
</tr>
<tr>
<td>
Porto Alegre (RS)
</td>
<td>
Canoas (RS)
</td>
<td>
12571
</td>
</tr>
</tbody>
</table>
<p>
Uma curiosidade sobre o primeiro lugar da lista: o fluxo Aracaju &gt;
São Cristóvão é devido ao fato de a única universidade pública de
Sergipe, a Universidade Federal de Sergipe (UFS), estar localizado em
São Cristóvão, mas como a UFS é muito próxima a Sergipe, os
universitários aracajuanos vão à UFS e voltam para casa no mesmo dia.
</p>
<p>
Finalmente, vamos o código para plotar o mapa. O código abaixo foi
“inspirado”
<a href="http://flowingdata.com/2011/05/11/how-to-map-connections-with-great-circles/">deste
post do Flowing Data</a>, um ótimo blog sobre visualização de dados.
Adaptar o código do artigo não foi tão direto como eu imaginava, por
isso fiz questão de documentar todos os passos e explicar o que eles
fazem.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="c1"># Para deixar mais fortes os fluxos mais frequentes, precisamos classificar os dados em ordem crescente de frequ&#xEA;ncia</span><span class="w">
</span><span class="n">df_agg</span><span class="w"> </span><span class="o">%&lt;&gt;%</span><span class="w"> </span><span class="n">arrange</span><span class="p">(</span><span class="n">qtd</span><span class="p">)</span><span class="w"> </span><span class="c1"># Criar dataframes separados para os municipios do aluno (origem ou org) e da IES (destino ou dest)</span><span class="w">
</span><span class="n">df_org</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">select</span><span class="p">(</span><span class="n">df_agg</span><span class="p">,</span><span class="w"> </span><span class="n">org</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">cod_mun_aluno</span><span class="p">)</span><span class="w">
</span><span class="n">df_dest</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">select</span><span class="p">(</span><span class="n">df_agg</span><span class="p">,</span><span class="w"> </span><span class="n">dest</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">cod_mun_ies</span><span class="p">)</span><span class="w">
</span><span class="c1"># criar vari&#xE1;veis para a quantidade de cada fluxo</span><span class="w">
</span><span class="n">qtd</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">df_agg</span><span class="o">$</span><span class="n">qtd</span><span class="w">
</span><span class="n">maxqtd</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="nf">max</span><span class="p">(</span><span class="n">qtd</span><span class="p">)</span><span class="w">
</span><span class="c1"># acrescentar latitude e longitude para cada cidade dois dataframes</span><span class="w">
</span><span class="n">df_org</span><span class="w"> </span><span class="o">%&lt;&gt;%</span><span class="w"> </span><span class="n">left_join</span><span class="p">(</span><span class="n">df_cidades</span><span class="p">,</span><span class="w"> </span><span class="n">by</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="s1">&apos;org&apos;</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s1">&apos;cod_municipio&apos;</span><span class="p">))</span><span class="w">
</span><span class="n">df_dest</span><span class="w"> </span><span class="o">%&lt;&gt;%</span><span class="w"> </span><span class="n">left_join</span><span class="p">(</span><span class="n">df_cidades</span><span class="p">,</span><span class="w"> </span><span class="n">by</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="s1">&apos;dest&apos;</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s1">&apos;cod_municipio&apos;</span><span class="p">))</span><span class="w"> </span><span class="c1"># para ver quanto tempo levou para gerar o mapa</span><span class="w">
</span><span class="n">t</span><span class="m">1</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="nf">proc.time</span><span class="p">()</span><span class="w"> </span><span class="c1"># Para salvar em um PNG de alta resolu&#xE7;&#xE3;o, desmarque as duas linhas abaixo, al&#xE9;m da dev.off()</span><span class="w">
</span><span class="c1">#myPng &lt;- function(..., width=13, height=13, res=300) {png(..., width=width*res, height=height*res, res=res)}</span><span class="w">
</span><span class="c1">#myPng(&quot;mapa.png&quot;)</span><span class="w"> </span><span class="c1"># Para deixar o gr&#xE1;fico bonito, usaremos um fundo preto</span><span class="w">
</span><span class="n">map</span><span class="p">(</span><span class="n">estados</span><span class="p">,</span><span class="w"> </span><span class="n">col</span><span class="o">=</span><span class="s2">&quot;#191919&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">fill</span><span class="o">=</span><span class="kc">TRUE</span><span class="p">,</span><span class="w"> </span><span class="n">bg</span><span class="o">=</span><span class="s2">&quot;#000000&quot;</span><span class="p">)</span><span class="w">
</span><span class="c1"># al&#xE9;m de um escala que vai de preto (valores menores) a azul (valores maiores)</span><span class="w">
</span><span class="n">pal</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">colorRampPalette</span><span class="p">(</span><span class="nf">c</span><span class="p">(</span><span class="s2">&quot;#333333&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;white&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;#1292db&quot;</span><span class="p">))</span><span class="w">
</span><span class="n">colors</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">pal</span><span class="p">(</span><span class="m">100</span><span class="p">)</span><span class="w">
</span><span class="c1"># t&#xED;tulo</span><span class="w">
</span><span class="n">title</span><span class="p">(</span><span class="s2">&quot;Mapeamento do movimento migrat&#xF3;rio \nuniversit&#xE1;rio no Brasil&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">col.main</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;white&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">cex.main</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">1</span><span class="p">)</span><span class="w">
</span><span class="c1"># referencia abaixo do mapa</span><span class="w">
</span><span class="n">mtext</span><span class="p">(</span><span class="s2">&quot;Fonte: Censo do Ensino Superior 2014 \n Autor: Sillas Gonzaga (sillasgonzaga.github.io)&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">col</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;white&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">side</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="n">line</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="n">cex</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">1</span><span class="p">)</span><span class="w">
</span><span class="c1"># Para gerar as linhas, a fun&#xE7;&#xE3;o gcIntermediate &#xE9; necess&#xE1;ria,</span><span class="w">
</span><span class="c1"># por&#xE9;m dois dos argumentos dela, p1 e p2, s&#xF3; podem ser vetores de tamanho 2</span><span class="w">
</span><span class="c1"># portanto, preciamos fazer um for loop para plotar cada linha de df_org e df_dest individualmente</span><span class="w">
</span><span class="c1"># ao final do loop, todas as linhas estar&#xE3;o plotadas no mapa</span><span class="w">
</span><span class="k">for</span><span class="w"> </span><span class="p">(</span><span class="n">i</span><span class="w"> </span><span class="k">in</span><span class="w"> </span><span class="m">1</span><span class="o">:</span><span class="n">nrow</span><span class="p">(</span><span class="n">df_agg</span><span class="p">))</span><span class="w"> </span><span class="p">{</span><span class="w"> </span><span class="n">p</span><span class="m">1</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="n">df_org</span><span class="p">[</span><span class="n">i</span><span class="p">,</span><span class="w"> </span><span class="p">]</span><span class="o">$</span><span class="n">lon</span><span class="p">,</span><span class="w"> </span><span class="n">df_org</span><span class="p">[</span><span class="n">i</span><span class="p">,</span><span class="w"> </span><span class="p">]</span><span class="o">$</span><span class="n">lat</span><span class="p">)</span><span class="w"> </span><span class="n">p</span><span class="m">2</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="n">df_dest</span><span class="p">[</span><span class="n">i</span><span class="p">,</span><span class="w"> </span><span class="p">]</span><span class="o">$</span><span class="n">lon</span><span class="p">,</span><span class="w"> </span><span class="n">df_dest</span><span class="p">[</span><span class="n">i</span><span class="p">,</span><span class="w"> </span><span class="p">]</span><span class="o">$</span><span class="n">lat</span><span class="p">)</span><span class="w"> </span><span class="n">inter</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">gcIntermediate</span><span class="p">(</span><span class="n">p</span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="n">p</span><span class="m">2</span><span class="p">,</span><span class="w"> </span><span class="n">n</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">100</span><span class="p">,</span><span class="w"> </span><span class="n">addStartEnd</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">TRUE</span><span class="p">)</span><span class="w"> </span><span class="c1"># determinar cor de cada fluxo</span><span class="w"> </span><span class="n">colindex</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="p">((</span><span class="n">qtd</span><span class="p">[</span><span class="n">i</span><span class="p">]</span><span class="o">/</span><span class="n">maxqtd</span><span class="p">)</span><span class="o">*</span><span class="nf">length</span><span class="p">(</span><span class="n">colors</span><span class="p">))</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">round</span><span class="w"> </span><span class="n">mycol</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">colors</span><span class="p">[</span><span class="n">colindex</span><span class="p">]</span><span class="w"> </span><span class="n">lines</span><span class="p">(</span><span class="n">inter</span><span class="p">,</span><span class="w"> </span><span class="n">col</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">mycol</span><span class="p">,</span><span class="w"> </span><span class="n">lwd</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">0.8</span><span class="p">)</span><span class="w">
</span><span class="p">}</span></code></pre>
</figure>
<p>
<img src="http://sillasgonzaga.github.io/figs/11censo_educ_superior2/plotar%20mapa-2.png" alt="center">
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="c1">#dev.off()</span><span class="w">
</span><span class="n">t</span><span class="m">2</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="nf">proc.time</span><span class="p">()</span><span class="w">
</span><span class="c1"># Tempo necess&#xE1;rio para construir o mapa (em segundos)</span><span class="w">
</span><span class="n">t</span><span class="m">2</span><span class="w"> </span><span class="o">-</span><span class="w"> </span><span class="n">t</span><span class="m">1</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## user system elapsed ## 322.500 3.436 375.426</code></pre>
</figure>
</article>

