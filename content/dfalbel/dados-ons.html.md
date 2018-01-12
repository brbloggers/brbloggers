+++
title = "Dados públicos do ONS (Operador Nacional do Sistema Elétrico)"
date = "2016-05-17"
categories = ["dfalbel"]
original_url = "http://dfalbel.github.io/2016/05/dados-ons.html"
+++

<p class="post">
<article class="post-content">
<p>
Iniciei um projeto (<a href="https://github.com/dfalbel/ons">Github</a>)
que visa disponibilizar de maneira mais acessível os dados do sistema
elétrico que podem ser encontrados no
<a href="http://www.ons.org.br/home/">site do ONS (Operador Nacional do
Sistema Elétrico)</a>. A idéia de criar este repositório surgiu um bom
tempo depois de responder
<a href="http://pt.stackoverflow.com/a/103838/6036">esta</a> pergunta no
<a href="http://pt.stackoverflow.com/">Stack Overflow PT</a>.
</p>
<p>
Os dados podem ser encontrados na seção
<a href="http://www.ons.org.br/historico/geracao_energia.aspx">histórico
da operação do site</a>.
</p>
<h2 id="por-que-disponibiliz-los-de-maneira-mais-acessvel">
Por que disponibilizá-los de maneira mais acessível?
</h2>
<p>
Para fazer análises estatísticas de dados precisamos de uma base de
dados. Da maneira com que os dados estão disponíveis no site, é
necessário que o analista faça cada consulta selecionando os parâmetros
e copiando a tabela para algum outro arquivo. Desse modo a chance de
algum erro ocorrer é muito grande e também fere o princípio de
reproducibilidade científica.
</p>
<h2 id="como-os-dados-esto-organizados">
Como os dados estão organizados?
</h2>
<p>
O <a href="https://github.com/dfalbel/ons">repositório</a> está
organizado em pastas, uma para cada seção do “histórico da operação” do
portal do ONS.
</p>
<p>
Até agora as seções
<a href="http://www.ons.org.br/historico/geracao_energia.aspx">geração
de energia</a>,
<a href="http://www.ons.org.br/historico/carga_propria_de_energia.aspx">carga
de energia</a> e
<a href="http://www.ons.org.br/historico/carga_propria_de_demanda.aspx">carga
de demanda</a> já estão disponíveis no
<a href="https://github.com/dfalbel/ons">Github</a>.
</p>
<p>
A pasta de cada um dos bancos de dados está organizada da seguinte
maneira:
</p>
<ul>
<li>
<code class="highlighter-rouge">R/</code>: contém o código em R
utilizado para fazer o download e processamento dos dados, bem como um
script que pode ser utilizado para a atualização do banco de dados.
</li>
<li>
<code class="highlighter-rouge">data-raw/</code>: contém todos os
arquivos <code class="highlighter-rouge">.html</code> que foram baixados
do portal do ONS. Esses arquivos são o formato mais “puro” dos dados.
</li>
<li>
<code class="highlighter-rouge">data/</code>: contém os banco de dados.
O <code class="highlighter-rouge">base\_arquivos.csv</code> que é
utilizado para controlar os arquivos que já foram baixados e que já
estão processados. E a <code class="highlighter-rouge">base.csv</code>
que contém todos os dados da seção compilados.
</li>
</ul>
<h2 id="leitura-dos-arquivos-no-r">
Leitura dos arquivos no R
</h2>
<p>
O link direto pode ser utilizado para a leitura dos dados no
<code class="highlighter-rouge">R</code>. Abaixo seguem as funções para
ler os três arquivos já disponíveis no repositório.
</p>
<ul>
<li>
Geração de Energia:
<code class="highlighter-rouge">read.csv("<https://raw.githubusercontent.com/dfalbel/ons/master/geracao-energia/data/base.csv%22>)</code>
</li>
<li>
Carga de Demanda:
<code class="highlighter-rouge">read.csv("<https://raw.githubusercontent.com/dfalbel/ons/master/carga-de-demanda/data/base.csv%22>)</code>
</li>
<li>
Carga de Energia:
<code class="highlighter-rouge">read.csv("<https://raw.githubusercontent.com/dfalbel/ons/master/carga-de-demanda/data/base.csv%22>)</code>
</li>
</ul>
<p>
Espero que a disponibilização neste formato seja uma ajuda para quem
está procurando analisar estes dados.
</p>
</article>
<br> <ins class="adsbygoogle"></ins> <br>
</p>

