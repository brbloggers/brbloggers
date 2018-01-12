+++
title = "Utilizando o pacote BETS (Brazilian Economic Time Series)"
date = "2017-07-27"
categories = ["NMEC"]
original_url = "http://pedrocostaferreira.github.io/blog/2017/07/27/utilizando-o-pacote-bets"
+++

<p>
O BETS é um pacote R que disponibiliza milhares de séries econômicas
brasileiras de diferentes centros, como Banco Central, IBGE e FGV,
através de uma interface bastante simples e flexível. O pacote também
conta com ferramentas poderosas de análise e visualização de séries
temporais, como relatórios automatizados da aplicação de métodos
conhecidos de análise de séries (SARIMA, redes neurais e Holt-Winters),
ou a criação de dashboards e gráficos de aparência profissional.
</p>
<p>
Discutiremos aqui as formas básicas de uso do pacote (busca, obtenção e
armazenamento de séries) e apenas tangenciaremos os usos mais avançados,
que serão temas de outros posts.
</p>
<p>
Caso o leitor se interesse, há ao final deste post um formulário para
assinar a Mailing List do BETS. Através dela, informaremos o usuários
acerca de atualizações do pacote e daremos dicas periódicas de como
usá-lo.
</p>
<h3 id="betssearch">
BETS.search
</h3>
<p>
Devido ao tamanho considerável da base de dados, foi necessário criar um
modo de pesquisar por séries a partir de seus metadados, isto é, uma
ferramenta de busca que utilizasse uma ou mais informações das séries
como palavras-chave. A função
<code class="highlighter-rouge">BETS.search</code> realiza as pesquisas
por cada campo da tabela de metadados.
</p>
<p>
O protótipo da <code class="highlighter-rouge">BETS.search</code> tem a
forma:
</p>
<pre class="highlight"><code>BETS.search(description, src, periodicity, unit, code, view = TRUE, lang = &quot;en&quot;)
</code></pre>

<p>
Onde os argumentos recebem, respectivamente:
</p>
<ul>
<li>
<code class="highlighter-rouge">description</code>: um
<code class="highlighter-rouge">character</code>. <em>String</em> de
busca com os termos que devem ou não estar presentes na descrição da
série desejada.
</li>
<li>
<code class="highlighter-rouge">src</code>: um . A fonte dos dados.
</li>
<li>
<code class="highlighter-rouge">periodicity</code> um
<code class="highlighter-rouge">character</code>. A frequência na qual a
série é observada.
</li>
<li>
<code class="highlighter-rouge">unit</code>: um
<code class="highlighter-rouge">character</code>. A unidade na qual os
dados foram medidos.
</li>
<li>
<code class="highlighter-rouge">code</code>: um
<code class="highlighter-rouge">integer</code>. O código único da série
na base do <code class="highlighter-rouge">BETS</code>.
</li>
<li>
<code class="highlighter-rouge">view</code>: um
<code class="highlighter-rouge">boolean</code>. Por padrão,
<code class="highlighter-rouge">TRUE</code>. Se
<code class="highlighter-rouge">FALSE</code>, os resultados serão
mostrados direto no console do R.
</li>
<li>
<code class="highlighter-rouge">lang</code>: um
<code class="highlighter-rouge">character</code>. Idioma da pesquisa.
Por padrão, <code class="highlighter-rouge">'en'</code>, para inglês.
Também é possivel fazer a pesquisa em português, bastando mudar o valor
para <code class="highlighter-rouge">'pt'</code>.
</li>
</ul>
<p>
Para refinar as buscas, há regras de sintaxe para o parâmetro
<code class="highlighter-rouge">description</code>:
</p>
<ol>
<li>
<p>
Para procurar palavras alternativas, separe-as por espaços em branco.
Exemplo: <code class="highlighter-rouge">description = 'núcleo
ipca'</code> significa que a descrição da série deve conter
<code class="highlighter-rouge">'ipca'</code> <strong>e</strong>
<code class="highlighter-rouge">'núcleo'</code>.
</p>
</li>
<li>
<p>
Para procurar expressões inteiras, basta cercá-las com
<code class="highlighter-rouge">' '</code>. Exemplo:
<code class="highlighter-rouge">description = 'índice de 'núcleo
ipca''</code> significa que deve conter na descrição da série
<code class="highlighter-rouge">'núcleo ipca'</code> <strong>e</strong>
<code class="highlighter-rouge">'índice'</code>.
</p>
</li>
<li>
<p>
Para excluir palavras da busca, insira um ∼ antes de cada um delas.
Exemplo: <code class="highlighter-rouge">description = 'ipca ∼
núcleo'</code> significa que a descrição da série deve conter
<code class="highlighter-rouge">'ipca'</code> e <strong>não</strong>
pode conter <code class="highlighter-rouge">'núcleo'</code>.
</p>
</li>
<li>
<p>
Para excluir todas as expressões da busca, de forma semelhante ao item
anteiror, basta cercá-los com <code class="highlighter-rouge">' '</code>
e inserir um ∼ antes de cada uma delas. Exemplo:
<code class="highlighter-rouge">description = '∼ índice 'núcleo
ipca''</code> significa que a descrição da série deve conter
<code class="highlighter-rouge">'índice'</code> e <strong>não</strong>
pode conter <code class="highlighter-rouge">'núcleo ipca'</code>.
</p>
</li>
<li>
<p>
É possível pesquisar ou negar várias palavras ou expressões, desde que
sejam respeitadas as regras precedentes.
</p>
</li>
<li>
<p>
O espaço em branco após o sinal de negação (∼) não é necessário. Mas os
espaços em branco depois de expressões ou palavras são necessários.
</p>
</li>
</ol>
<p>
Alguns exemplos de uso podem ser visto abaixo:
</p>
<pre class="highlight"><code>&gt; BETS.search(description = &quot;sales ~ retail&quot;)
&gt; BETS.search(description = &quot;&apos;sales volume index&apos; ~ vehicles&quot;)
&gt; BETS.search(description = &quot;&apos;distrito federal&apos;&quot;, periodicity = &apos;A&apos;, src = &apos;IBGE&apos;) &gt; BETS.search(description = &quot;gdp accumulated&quot;, unit = &quot;US&quot;, view = F) ## code description
## 1 4192 GDP accumulated in the last 12 months - in US$ million
## 2 4386 GDP accumulated in the year - in US$ million
## unit periodicity start last_value source
## 1 US$ (million) M 31/01/1990 may/2017 BCB-Depec
## 2 US$ (million) M 31/01/1990 may/2017 BCB-Depec &gt; results = BETS.search(description = &quot;consumption ~ &apos;seasonally adjusted&apos; ~ private&quot;, view = F)
&gt; head(results) ## code description
## 1 1393 Petroleum derivatives consumption - Gasoline
## 2 1394 Petroleum derivatives consumption - GLP
## 3 1395 Petroleum derivatives consumption - Fuel oil
## 4 1396 Petroleum derivatives consumption - Diesel oil
## 5 1397 Petroleum derivatives consumption - Other derivatives
## 6 1398 Petroleum derivatives consumption - Total derivatives
## unit periodicity start last_value source
## 1 Barrels/day (thousand) M 31/01/1979 apr/2017 ANP
## 2 Barrels/day (thousand) M 31/01/1979 apr/2017 ANP
## 3 Barrels/day (thousand) M 31/01/1979 apr/2017 ANP
## 4 Barrels/day (thousand) M 31/01/1979 apr/2017 ANP
## 5 Barrels/day (thousand) M 31/01/1979 apr/2017 ANP
## 6 Barrels/day (thousand) M 31/01/1979 apr/2017 ANP
</code></pre>

<p>
Para mais informações sobre a
<code class="highlighter-rouge">BETS.search</code>, incluindo os valores
válidos em cada campo, consulte o manual de referência, digitando
<code class="highlighter-rouge">?BETS.search</code> no console do R.
</p>
<h2 id="betsget">
BETS.get
</h2>
<p>
A <code class="highlighter-rouge">BETS.get</code> funciona unicamente
através do código de referência da série, obtido com as consultas feita
com a . Sua assinatura é:
</p>
<pre class="highlight"><code>BETS.get(code, data.frame = FALSE)
</code></pre>

<p>
O parâmetro <code class="highlighter-rouge">code</code> é, obviamente,
obrigatório. O argumento opcional
<code class="highlighter-rouge">data.frame</code> representa o tipo do
objeto que será retornado. Por padrão, seu valor é
<code class="highlighter-rouge">FALSE</code>, indicando que o objeto
devolvido pela função será um <code class="highlighter-rouge">ts</code>
(<em>time series</em>). Caso <code class="highlighter-rouge">data.frame
= TRUE</code>, a série será armazenada em um objeto do tipo
<code class="highlighter-rouge">data.frame</code>.
</p>
<p>
Vamos extrair duas das séries pesquisadas anteriormente.
</p>
<pre class="highlight"><code>&gt; # Obter a serie do PIB acumulado em 12 meses, em dolares
&gt; gdp_accum = BETS.get(4192)
&gt; window(gdp_accum, start = c(2014,1)) ## Jan Feb Mar Apr May Jun Jul Aug
## 2014 2472533 2481284 2481924 2479634 2480629 2475636 2471898 2465860
## 2015 2403690 2349150 2301000 2246336 2189805 2141042 2085474 2029582
## 2016 1792830 1792407 1788570 1787263 1786178 1788167 1786639 1789734
## 2017 1815461 1830139 1848533 1864606 1879933 1895371 ## Sep Oct Nov Dec
## 2014 2465907 2462505 2457480 2454846
## 2015 1970754 1911276 1854424 1797601
## 2016 1791403 1790562 1794418 1799436
## 2017 &gt; # Obter a serie do PIB do Distrito Federal, a precos de mercado
&gt; gdp_df = BETS.get(23992, data.frame = T)
&gt; head(gdp_df) ## date value
## 1 2002-01-01 53902199799
## 2 2003-01-01 58456124319
## 3 2004-01-01 67076505202
## 4 2005-01-01 75732681210
## 5 2006-01-01 84661405538
## 6 2007-01-01 93404000766
</code></pre>

<h2 id="betssave">
BETS.save
</h2>
<p>
Para conferir versatilidade às formas de armazenamento das séries do ,
há a possibilidade de criar arquivos com as séries em formatos
proprietários, isto é, formatos que pertencem a <em>softwares</em>
pagos.
</p>
<p>
A <code class="highlighter-rouge">BETS.save</code> extrai a série
temporal da base de dados do pacote na forma de um
<code class="highlighter-rouge">data.frame</code> e cria um arquivo no
formato especificado. No arquivo, há uma tabela onde a primeira coluna
conterá as datas e a segunda, os dados.
</p>
<p>
A função possui três variações:
</p>
<pre class="highlight"><code>BETS.save.sas(code, data = NULL, file.name = &quot;series&quot;)
BETS.save.spss(code, data = NULL, file.name = &quot;series&quot;)
BETS.save.stata(code, data = NULL, file.name = &quot;series&quot;)
</code></pre>

<p>
Novamente, o parâmetro <code class="highlighter-rouge">code</code>
recebe o código da série. O usuário pode fornecer sua própria série
através do argumento <code class="highlighter-rouge">data</code>, que
pode ser um <code class="highlighter-rouge">data.frame</code> ou um
<code class="highlighter-rouge">ts</code>. Não é necessário acrescentar
a extensão ao nome do arquivo no parãmetro
<code class="highlighter-rouge">file.name</code>.
</p>
<p>
Alguns exemplos típicos de uso seriam:
</p>
<pre class="highlight"><code>&gt; # Salvar a s&#xE9;rie da d&#xED;vida p&#xFA;blica l&#xED;quida no formato padr&#xE3;o do Excel
&gt; BETS.save.stata(code = 2078, file.name = &quot;series_stata.dta&quot;)
&gt; &gt; # Salvar uma s&#xE9;rie qualquer no formato do SPSS
&gt; BETS.save.spss(data = myseries, file.name = &quot;series_spss&quot;)
</code></pre>

<h2 id="betschart">
BETS.chart
</h2>
<p>
A <code class="highlighter-rouge">BETS.chart</code> foi inicialmente
projetada para ser uma função privada, auxiliar da
<code class="highlighter-rouge">BETS.dashboard</code>. No entanto,
pensamos ser de grande valia para o usuário dispor de um meio de obter
os gráficos dos <em>dashboard</em>s separadamente, de modo a poder
incorporá-los em seus trabalhos.
</p>
<p>
O protótipo da <code class="highlighter-rouge">BETS.chart</code> é o que
se segue:
</p>
<pre class="highlight"><code>BETS.chart(ts, file = NULL, open = TRUE, params = NULL)
</code></pre>

<p>
O parâmetro <code class="highlighter-rouge">ts</code> pode receber uma
dentre as várias opções pré-definidas de gráficos ou uma série do
usuário. Há também a opção de salvar a saída no <em>working
directory</em>, definindo o nome do arquivo
<code class="highlighter-rouge">file</code>. Caso o arquivo deva ser
aberto após a criação, <code class="highlighter-rouge">open</code> deve
ser mantido como <code class="highlighter-rouge">TRUE</code>. O
parâmetro <code class="highlighter-rouge">params</code> é reservado para
gráficos de séries do usuário. É uma lista que pode conter o campo
<code class="highlighter-rouge">codace</code>, que recebe um booleano e
indica se devem ser desenhadas áreas sombreadas representando recessões
datadas pelo CODACE (FGV/IBRE), e o campo
<code class="highlighter-rouge">start</code>, que especifica qual deve
ser a data de início da série. Uma vez que se tratam de gráficos de
conjuntura, a data de fim não pode ser alterada e é sempre o último dado
disponível.
</p>
<p>
Vejamos dois exemplos de uso da
<code class="highlighter-rouge">BETS.chart</code>.
</p>
<pre class="highlight"><code>&gt; BETS.chart(ts = &apos;iie_br&apos;, file = &quot;iie_br&quot;, open = TRUE)
</code></pre>

<p>
<img src="http://pedrocostaferreira.github.io/images/iie_br.png" alt="&#xCD;ndice de Incerteza da Economia Brasileira" class="img-responsive center-image">
</p>
<pre class="highlight"><code>&gt; BETS.chart(ts = &quot;misery_index&quot;, file = &quot;misery_index.png&quot;, open = TRUE)
</code></pre>

<p>
<img src="http://pedrocostaferreira.github.io/images/misery_index.png" alt="&#xCD;ndice de Mis&#xE9;ria" class="img-responsive center-image">
</p>
<p>
Para uma lista completa dos gráficos diponíveis, consulte o manual de
referência da <code class="highlighter-rouge">BETS.chart</code>.
</p>
<h2 id="betsdashboard">
BETS.dashboard
</h2>
<p>
O <code class="highlighter-rouge">BETS</code> possui uma poderosa
ferramenta de análise de conjuntura, os <em>dashboards</em>. Para criar
um <em>dashboard</em>, chamamos a
<code class="highlighter-rouge">BETS.dashboard</code>, cuja assinatura
é:
</p>
<pre class="highlight"><code>BETS.dashboard(type = &quot;business_cycle&quot;, saveas = NA)
</code></pre>

<p>
Assim, obtemos um arquivo <em>.pdf</em>. No exemplo, o usuário escolhe
salvar o arquivo com o nome de <em>survey.pdf</em>. Os gráficos que são
exibidos também são de escolha do usuário, selecionados através do
parâmetro <code class="highlighter-rouge">charts</code> (por
<em>default</em>, seu valor é
<code class="highlighter-rouge">'all'</code>). O manual de referência
possui uma lista completa dos gráficos disponíveis.
</p>
<pre class="highlight"><code>&gt; BETS.dashboard(type = &quot;business_cycle&quot;, saveas = &quot;survey.pdf&quot;)
</code></pre>

<p>
<img src="http://pedrocostaferreira.github.io/images/dashboard.png" alt="Terceira p&#xE1;gina do *Business Cycle Dashboard*" class="img-responsive center-image">
</p>
<h2 id="mailing-list">
Mailing List
</h2>
<p>
Abaixo você encontra um formulário para assinar a Mailing List do BETS.
Através dela você saberá muito mais sobre o BETS e suas novas versões.
Se você se interessou pelo pacote, não deixe de assinar!
</p>

