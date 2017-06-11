+++
title = "Transparência(4): Análise de salários usando Treemaps"
date = "2016-01-17 03:00:00"
categories = ["paixao-por-dados"]
+++

<article class="blog-post">
<figure class="highlight">
<pre><code class="language-r"><span class="n">library</span><span class="p">(</span><span class="n">treemap</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">dplyr</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">ggplot2</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">ggrepel</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">ggthemes</span><span class="p">)</span><span class="w">
</span><span class="n">df</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">read.csv2</span><span class="p">(</span><span class="s2">&quot;/home/sillas/R/data/transparenciaComSalarios.csv&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">stringsAsFactors</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">FALSE</span><span class="p">,</span><span class="w"> </span><span class="n">fileEncoding</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;ISO-8859-15&quot;</span><span class="p">)</span></code></pre>
</figure>
<p>
Para este post, continuaremos analisando os salários dos servidores
federais, mas agora usando uma visualização chamada Treemap ou Mapa de
árvores.
</p>
<p>
Por exemplo, o gráfico abaixo compara diferentes órgãos públicos de
acordo com a quantidade de servidores e o salário médio dos mesmos.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">aggSetor</span><span class="w"> </span><span class="o">&lt;-</span><span class="n">df</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">group_by</span><span class="p">(</span><span class="n">ORG_LOTACAO</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">summarise</span><span class="p">(</span><span class="n">quantidade</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">n</span><span class="p">(),</span><span class="w"> </span><span class="n">salarioMedio</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">median</span><span class="p">(</span><span class="n">SALARIO</span><span class="p">))</span><span class="w"> </span><span class="n">aggSetor</span><span class="o">$</span><span class="n">escala</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">scale</span><span class="p">(</span><span class="n">aggSetor</span><span class="o">$</span><span class="n">salarioMedio</span><span class="p">)</span><span class="w"> </span><span class="c1">#necess&#xE1;rio para criar valores negativos para deixar as disparidades mais evidentes
</span><span class="w">
</span><span class="n">x</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">treemap</span><span class="p">(</span><span class="n">aggSetor</span><span class="p">,</span><span class="w"> </span><span class="n">index</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;ORG_LOTACAO&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">vSize</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;quantidade&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">vColor</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;escala&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">type</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;value&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">palette</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;-RdGy&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">lowerbound.cex.labels</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">0.3</span><span class="p">,</span><span class="w"> </span><span class="n">title</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Treemap dos sal&#xE1;rios dos &#xF3;rg&#xE3;os federais brasileiros&quot;</span><span class="p">)</span></code></pre>
</figure>
<p>
<img src="http://sillasgonzaga.github.io/figs/transparenciaParte4/unnamed-chunk-2-1.png" alt="center">
</p>
<p>
<strong>Interpretação</strong>: Com o gráfico acima, aprendemos que:
</p>
<ul>
<li>
O Ministério da Saúde tem muitos servidores mas salários muito baixos.
</li>
<li>
O Ministério da Fazenda, a Advocacia-Geral da União e o Banco Central do
Brasil são os que possuem os maiores salários.
</li>
</ul>
<p>
O treemap é chamado assim por permitir uma visualização fácil de
hierarquias, isto é, de variáveis categóricas e seus respectivos
subníveis. Além disso, ele é excelente para representar visualmente
relações entre duas ou mais variáveis categóricas. Por exemplo, será que
existe alguma relação interessante entre o UF e o vínculo do servidor?
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">treemap</span><span class="p">(</span><span class="n">df</span><span class="p">,</span><span class="w"> </span><span class="n">index</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="s2">&quot;UF_EXERCICIO&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;SITUACAO_VINCULO&quot;</span><span class="p">),</span><span class="w"> </span><span class="n">vSize</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;x&quot;</span><span class="p">)</span></code></pre>
</figure>
<p>
<img src="http://sillasgonzaga.github.io/figs/transparenciaParte4/unnamed-chunk-3-1.png" alt="center">
</p>
<p>
Aparentemente, tem sim! O número de servidores de Contrário Temporário
no RJ e de Cargo Comissionado no DF parecem ser muito grandes. Podemos
ratificar isso filtrando fora os servidores ativos:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">treemap</span><span class="p">(</span><span class="n">subset</span><span class="p">(</span><span class="n">df</span><span class="p">,</span><span class="w"> </span><span class="n">SITUACAO_VINCULO</span><span class="w"> </span><span class="o">!=</span><span class="w"> </span><span class="s2">&quot;ATIVO PERMANENTE&quot;</span><span class="p">),</span><span class="w"> </span><span class="n">index</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="s2">&quot;UF_EXERCICIO&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;SITUACAO_VINCULO&quot;</span><span class="p">),</span><span class="w"> </span><span class="n">vSize</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;x&quot;</span><span class="p">)</span></code></pre>
</figure>
<p>
<img src="http://sillasgonzaga.github.io/figs/transparenciaParte4/unnamed-chunk-4-1.png" alt="center">
</p>
<p>
Vamos conferir essa informação com um gráfico de dispersão:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">df</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">filter</span><span class="p">(</span><span class="n">SITUACAO_VINCULO</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="s2">&quot;NOMEADO CARGO COMIS.&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">group_by</span><span class="p">(</span><span class="n">UF_EXERCICIO</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">summarise</span><span class="p">(</span><span class="n">servidores</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">n</span><span class="p">(),</span><span class="w"> </span><span class="n">salario</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">median</span><span class="p">(</span><span class="n">SALARIO</span><span class="p">))</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">ggplot</span><span class="p">(</span><span class="n">aes</span><span class="p">(</span><span class="n">servidores</span><span class="p">,</span><span class="w"> </span><span class="n">salario</span><span class="p">))</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">geom_point</span><span class="p">()</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">geom_text_repel</span><span class="p">(</span><span class="n">aes</span><span class="p">(</span><span class="n">label</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">UF_EXERCICIO</span><span class="p">))</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">labs</span><span class="p">(</span><span class="n">title</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Cargos comissionados de cada estado&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Quantidade de servidores&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Sal&#xE1;rio m&#xE9;dio&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">theme_few</span><span class="p">()</span></code></pre>
</figure>
<p>
<img src="http://sillasgonzaga.github.io/figs/transparenciaParte4/unnamed-chunk-5-1.png" alt="center">
</p>
<p>
Duas grandes descobertas aqui:
</p>
<ul>
<li>
O <strong>DF</strong> tem um número assustadoramente grande de CCs
(5384), tanto que chega a distorcer o gráfico.
</li>
<li>
Os CCs do <strong>CE</strong> tem um salário médio assustadoramente alto
(R$8554,70).
</li>
</ul>
<p>
<strong>Por hoje é só!</strong>
</p>
</article>

