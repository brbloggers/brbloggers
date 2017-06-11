+++
title = "Transparência (7): Os famosos Cargos Comissionados"
date = "2016-02-03 03:00:00"
categories = ["paixao-por-dados"]
+++

<article class="blog-post">
<p>
No
<a href="http://sillasgonzaga.github.io/blog/transparenciaParte4/">quarto
post</a> da minha série sobre dados do Portal da Transparência, eu
introduzi um tema interessante a ser olhado a fundo: os servidores cujo
vínculo com o Estado é descrito como cargo comissionado. Vimos que, no
Ceará, o salário médio de um servidor é muito alto. E nos outros
estados?
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">library</span><span class="p">(</span><span class="n">ggplot2</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">dplyr</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">ggthemes</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">ggrepel</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">reshape2</span><span class="p">)</span><span class="w">
</span><span class="n">df</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">read.csv2</span><span class="p">(</span><span class="s2">&quot;/home/sillas/R/data/transparenciaComSalarios.csv&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">stringsAsFactors</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">FALSE</span><span class="p">,</span><span class="w"> </span><span class="n">fileEncoding</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;ISO-8859-15&quot;</span><span class="p">)</span><span class="w"> </span><span class="n">cor1</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="s2">&quot;#C10534&quot;</span><span class="w"> </span><span class="err">#</span><span class="n">cor</span><span class="w"> </span><span class="n">das</span><span class="w"> </span><span class="n">barras</span></code></pre>
</figure>
<p>
Para começar, quais são os 10 tipos de vínculo mais comuns?
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">df</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">group_by</span><span class="p">(</span><span class="n">SITUACAO_VINCULO</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">summarise</span><span class="p">(</span><span class="n">servidores</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">n</span><span class="p">())</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">arrange</span><span class="p">(</span><span class="n">desc</span><span class="p">(</span><span class="n">servidores</span><span class="p">))</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">top_n</span><span class="p">(</span><span class="m">10</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## Source: local data frame [10 x 2]
## ## SITUACAO_VINCULO servidores
## (chr) (int)
## 1 ATIVO PERMANENTE 461963
## 2 CONTRATO TEMPORARIO 11946
## 3 CONT.PROF.SUBSTITUTO 10512
## 4 NOMEADO CARGO COMIS. 7445
## 5 REQUISITADO 6459
## 6 SEM VINCULO 4117
## 7 EXERC DESCENT CARREI 3870
## 8 EXERC.&#xF7;7&#xBA; ART93 8112 2475
## 9 APOSENTADO 2294
## 10 REQ.DE OUTROS ORGAOS 1570</code></pre>
</figure>
<p>
Felizmente, a maioria é composta por servidores ativos, enquanto que
cargo comissionado é o quarto vínculo mais comum.
</p>
<p>
Antes de adentrarmos a questão dos CCs, vamos ver qual o tipo de vínculo
que possui os maiores salários:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">df</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">group_by</span><span class="p">(</span><span class="n">SITUACAO_VINCULO</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">summarise</span><span class="p">(</span><span class="n">servidores</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">n</span><span class="p">(),</span><span class="w"> </span><span class="n">salario</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">median</span><span class="p">(</span><span class="n">SALARIO</span><span class="p">))</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">arrange</span><span class="p">(</span><span class="n">desc</span><span class="p">(</span><span class="n">salario</span><span class="p">))</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">top_n</span><span class="p">(</span><span class="m">10</span><span class="p">,</span><span class="w"> </span><span class="n">salario</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## Source: local data frame [10 x 3]
## ## SITUACAO_VINCULO servidores salario
## (chr) (int) (dbl)
## 1 NATUREZA ESPECIAL 40 30934.70
## 2 QUADRO ESPEC.-QE/MRE 44 21961.89
## 3 EXERC DESCENT CARREI 3870 20429.09
## 4 CEDIDO 102 19946.32
## 5 APOSENTADO 2294 17923.85
## 6 RESERVA CBM / PM 1 17348.72
## 7 APOSENTADO TCU733/94 1 11650.25
## 8 EXCEDENTE A LOT/MRE 8 11005.08
## 9 CELETISTA/EMPREGADO 408 10796.80
## 10 COLABORADOR ICT 46 10208.36</code></pre>
</figure>
<p>
Temos algumas surpresas aqui. Alguns termos são novos para mim, por isso
postei a definição deles abaixo:
</p>
<ul>
<li>
<a href="https://pt.wikipedia.org/wiki/Cargo_de_Natureza_Especial">NATUREZA
ESPECIAL</a>: Cargo de Natureza Especial (CNE) são cargos públicos que
dispensam concursos públicos para sua efetivação. No Brasil estes cargos
estão vinculados a entidades públicas que têm o direito de contratar
funcionários de sua confiança, podendo os salários variarem de 1.200
reais a mais de 8.000 reais. Segue um exemplo: o Presidente da Câmara
dos Deputados do Congresso Nacional tem o direito a contratar 46 pessoas
na forma de CNE, e cada um dos 7 membros da mesa diretora da Câmara tem
direito a 33 cargos, além de 11 cargos para cada um dos 4 suplentes da
mesa, perfazendo um total de 321 CNEs. Com base neste exemplo fica
evidente a importância da sociedade fiscalizar os critérios de nomeação,
a justificativa dos gastos e o desempenho dos CNEs, pois infelizmente
ainda são muito utilizados para atender a interesses restritos de quem
nomeia e do pequeno grupo favorecido, ao invés de suprirem alguma
demanda técnica da administração pública.
</li>
<li>
QUADRO ESPEC.-QE/MRE: Não encontrei uma definição precisa mas aparentam
ser algo relacionados a diplomacia.
</li>
<li>
EXERC DESCENT CARREI: Servidores das carreiras típicas de Estado
vinculadas aos Ministérios do Planejamento, Orçamento e Gestão e
Ministério da Fazenda que exercem as suas atividades na UJ mediante
exercício descentralizado de atividade.
</li>
<li>
<a href="https://jus.com.br/artigos/21640/cessao-e-requisicao-de-servidor-publico-federal">CEDIDO</a>:
O servidor da Administração Pública Federal poderá ser cedido a outro
órgão ou entidade de qualquer ente federativo, incuindo as empresas
públicas e sociedades de economia mista, para o exercício de cargo em
comissão ou função de confiança e, ainda, nos termos de leis
específicas.
</li>
<li>
COLABORADOR ICT: Também não encontrei informações sobre, mas parece
estar relacionado à Inovação, Ciência e Tecnologia.
</li>
</ul>
<p>
Voltando aos nossos CCs: existe diferença na distribuição de salários
entre CCs e servidores ativos?
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">df2</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">filter</span><span class="p">(</span><span class="n">df</span><span class="p">,</span><span class="w"> </span><span class="n">SITUACAO_VINCULO</span><span class="w"> </span><span class="o">%in%</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="s2">&quot;ATIVO PERMANENTE&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;NOMEADO CARGO COMIS.&quot;</span><span class="p">))</span><span class="w"> </span><span class="n">ggplot</span><span class="p">(</span><span class="n">df2</span><span class="p">,</span><span class="w"> </span><span class="n">aes</span><span class="p">(</span><span class="n">SALARIO</span><span class="p">))</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">geom_histogram</span><span class="p">(</span><span class="n">binwidth</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">1000</span><span class="p">,</span><span class="w"> </span><span class="n">fill</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">cor1</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">facet_grid</span><span class="p">(</span><span class="n">SITUACAO_VINCULO</span><span class="w"> </span><span class="o">~</span><span class="w"> </span><span class="n">.</span><span class="p">,</span><span class="w"> </span><span class="n">scales</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;free_y&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">xlim</span><span class="p">(</span><span class="m">0</span><span class="p">,</span><span class="w"> </span><span class="m">35000</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">labs</span><span class="p">(</span><span class="n">title</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Distribui&#xE7;&#xE3;o dos sal&#xE1;rios de acordo com o v&#xED;nculo&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Sal&#xE1;rio&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Frequ&#xEA;ncia&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">theme_bw</span><span class="p">()</span></code></pre>
</figure>
<p>
<img src="http://sillasgonzaga.github.io/figs/transparenciaParte7/unnamed-chunk-4-1.png" alt="center">
</p>
<p>
O interessante aqui é que, sob nenhuma hipótese, é possível afirmar que
a distribuição dos salários para os CCs é normal.
</p>
<p>
Próxima pergunta: existe uma relação entre o número de cargos
comissionados e o número total de servidores por estado?
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">df2</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">group_by</span><span class="p">(</span><span class="n">UF_EXERCICIO</span><span class="p">,</span><span class="w"> </span><span class="n">SITUACAO_VINCULO</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">summarise</span><span class="p">(</span><span class="n">quantidade</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">n</span><span class="p">())</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">ggplot</span><span class="p">(</span><span class="n">aes</span><span class="p">(</span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">UF_EXERCICIO</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">quantidade</span><span class="p">))</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">geom_bar</span><span class="p">(</span><span class="n">stat</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;identity&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">fill</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">cor1</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">facet_grid</span><span class="p">(</span><span class="n">SITUACAO_VINCULO</span><span class="w"> </span><span class="o">~</span><span class="w"> </span><span class="n">.</span><span class="p">,</span><span class="w"> </span><span class="n">scales</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;free_y&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">labs</span><span class="p">(</span><span class="n">title</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Quantidade de servidores por estado e por v&#xED;nculo&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Quantidade de servidores&quot;</span><span class="p">)</span></code></pre>
</figure>
<p>
<img src="http://sillasgonzaga.github.io/figs/transparenciaParte7/unnamed-chunk-5-1.png" alt="center">
</p>
<p>
Deu para perceber a aberração que existe no Distrito Federal, não deu? O
DF possui mais de 5000 CCs, enquanto que o segundo estado com mais
servidores do tipo, o RJ, tem cerca de 500.
</p>
<p>
E em relação aos salários?
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">df2</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">group_by</span><span class="p">(</span><span class="n">REGIAO</span><span class="p">,</span><span class="w"> </span><span class="n">UF_EXERCICIO</span><span class="p">,</span><span class="w"> </span><span class="n">SITUACAO_VINCULO</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">summarise</span><span class="p">(</span><span class="n">salario</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">median</span><span class="p">(</span><span class="n">SALARIO</span><span class="p">))</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">ggplot</span><span class="p">(</span><span class="n">aes</span><span class="p">(</span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">UF_EXERCICIO</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">salario</span><span class="p">,</span><span class="w"> </span><span class="n">fill</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">REGIAO</span><span class="p">))</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">geom_bar</span><span class="p">(</span><span class="n">stat</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;identity&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">facet_grid</span><span class="p">(</span><span class="n">SITUACAO_VINCULO</span><span class="w"> </span><span class="o">~</span><span class="w"> </span><span class="n">.</span><span class="p">,</span><span class="w"> </span><span class="n">scales</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;free_y&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">labs</span><span class="p">(</span><span class="n">title</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Sal&#xE1;rio mediano por estado\n e v&#xED;nculo do servidor&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Sal&#xE1;rio (R$)&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">theme_bw</span><span class="p">()</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">theme</span><span class="p">(</span><span class="n">legend.position</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;bottom&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">legend.title</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">element_blank</span><span class="p">())</span></code></pre>
</figure>
<p>
<img src="http://sillasgonzaga.github.io/figs/transparenciaParte7/unnamed-chunk-6-1.png" alt="center">
</p>
<p>
Como já havia comentado no terceiro post da série, a situação dos CCs no
Ceará é estranha: lá, eles têm o maior salário mediano (R$ 8554, 70)
dentre os CCs do Brasil, mais de R$ 3000,00 de diferença para o segundo
lugar, Sergipe.
</p>
<p>
<strong>Por hoje é só!</strong>
</p>
</article>

