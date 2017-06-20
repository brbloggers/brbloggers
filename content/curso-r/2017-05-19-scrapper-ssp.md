+++
title = "Web scraping do site da Secretaria de Segurança Pública de São Paulo"
date = "2017-05-19 20:26:00"
categories = ["curso-r"]
original_url = "http://curso-r.com/blog/2017/05/19/2017-05-19-scrapper-ssp/"
+++

<div id="post-content">
<p>
Quando eu trabalhei no Núcleo de Estudos da Violência da USP, obter
informações da Secretaria de Segurança Pública de São Paulo (SSP) era
uma tarefa meio esotérica. Coletávamos os dados de todos os DP’s de São
Paulo, que são aproximadamente 100, e, como fazer isso manualmente era
demorado, aplicávamos uma solução automática em dois passos. Primeiro
<em>raspávamos</em> o site da SSP em Python e depois rodávamos uma macro
em VBA chamada “Mestre Dos Magos”, que era responsável por consolidar as
séries históricas em excel. Eu achava o procedimento um pouco hermético
porque nenhum deles tinha sido feito por mim ou pela minha equipe, era
uma herança que a gente não sabia como consertar se desse algum
problema. Para dar um exemplo, no final da minha breve estadia no NEV o
script não funcionava mais, então era necessário baixar tudo
manualmente.
</p>
<p>
Depois dessa época eu nunca mais mexi com esses dados. Eu sempre tive
vontade de implementar uma solução em R, mas sempre faltou motivação.
Felizmente, na ultima semana minha namorada precisou dos dados da SSP
para um trabalho que está fazendo, só que dessa vez o interesse era em
todos os 645 municípios do estado de São Paulo nos anos entre 2013 a
2016. Como não há como baixar todas essas informações de uma vez e
downloads individuais tomam muito tempo, eu me senti motivado o
suficiente para atacar o problema.
</p>
<p>
Pra ser sincero, foi bem mais fácil do que eu achei que seria. A
construção do programa foi tão simples que cabe até mesmo neste post de
blog, mas não é só por isso que ela está aqui. Esse é um exemplo minimal
de todas as fases de construção de um <em>scraper</em>.
</p>
<p>
Em um esquema aproximado, eu acredito que raspar (ou <em>scrappear</em>)
um site pode ser feito em 4 passos:
</p>
<ol>
<li>
Defina a página que você quer raspar;
</li>
<li>
Identifique <em>exatamente</em> as requisições que produzem o que você
quer;
</li>
<li>
Construa um programa que <em>imite</em> as requisições que você faria
manualmente;
</li>
<li>
Repita o passo 3. quantas vezes quiser.
</li>
</ol>
<p>
Mesmo que existam <em>scrapers</em> mais complicados, é verdade que
seguir esses passos pelo menos te ajuda a chegar mais perto do que você
realmente precisará fazer depois.
</p>

<p>
Tanto o NEV quanto a minha namorada tinham interesse nas tabelas que
apareciam numa URL específica do site:
<a href="http://www.ssp.sp.gov.br/Estatistica/Pesquisa.aspx" class="uri">http://www.ssp.sp.gov.br/Estatistica/Pesquisa.aspx</a>.
A lógica por trás da divulgação dessas informações é a seguinte: você
escolhe um ano, uma localidade geográfica/administrativa e um tipo de
informação e ele te devolve uma tabela. Os anos disponíveis são os anos
de 2001 a 2017, as localidades são os cruzamentos entre Municípios,
Regiões e Delegacias (notando que você sempre pode escolher “Todos”) e
os tipos de informação são taxas de delito, ocorrências registradas por
ano, ocorrências registradas por mês e produtividade policial. Nesta
aplicação vamos procurar contagens de ocorrências registradas por mês.
</p>

<div id="identifique-o-que-o-site-faz-por-tras" class="section level2">
<p>
Identificar o que o site faz por trás provavelmente é a fase mais
complicada da construção de um <em>scraper</em>. A dificuldade é que não
existe um algoritmo que faça isso pra você. Normalmente eu sigo alguns
passos, mas eles exigem uma dose de <em>insight</em> para funcionar, o
que implica que talvez não seja possível seguir todos os passos em
sequência.
</p>
<ol>
<li>
Entre na página imediatamente anterior à página que você quer acessar.
</li>
<li>
Abra as ferramentas de desenvolvedor dos seu navegador (isso normalmente
é equivalente à “aperte F12”).
</li>
<li>
Selecione a aba “Network” (ou “Rede”) na caixa de ferramentas do
desenvolvedor.
</li>
<li>
Vá para a página que você quer.
</li>
<li>
Na lista de requisições que o site fez ao servidor, identifique
aquela(s) que é(são) relevante(s) a sua pesquisa.
</li>
</ol>
<p>
Parece muito louco né? No geral, é muito louco sim, mas quando você dá
sorte é fácil. Vou mostrar o que acontece no nosso exemplo:
</p>
<p>
Em qualquer navegador, as ferramentas do desenvolvedor mostram o
<em>background</em> do que aparece na tela. Se estiver nessa aba, quando
você entrar em
<a href="http://www.ssp.sp.gov.br/Estatistica/Pesquisa.aspx" class="uri">http://www.ssp.sp.gov.br/Estatistica/Pesquisa.aspx</a>
e apertar F5, vai encontrar uma tela mais ou menos parecida com a tela
abaixo:
</p>
<p>
<img src="http://curso-r.com/blog/2017-05-19-scrapper-ssp_files/figure-html/unnamed-chunk-1-1.png" width="768">
</p>
<p>
Cada linha representa uma requisição, que é essencialmente o envio de um
arquivo .html ao servidor. O conteúdo que visualizamos na tela é o
resultado de todas essas requisições e, se destrincharmos cada uma
delas, podemos identificar aquelas que são relevantes para o nosso
problema.
</p>

<div id="a-requisicao" class="section level3">
<p>
O próximo passo é identificar o que é que o navegador pede ao servidor
quando te devolve o que você quer. Se você escolher o ano de 2017 na
caixa de seleção de anos, por exemplo, vai encontrar uma tela parecida
com essa aqui.
</p>
<p>
<img src="http://curso-r.com/blog/2017-05-19-scrapper-ssp_files/figure-html/unnamed-chunk-2-1.png" width="768">
</p>
<p>
Antes de prosseguir, é necessário fazer uma inspeção meticulosa de todas
as requisições que aparecem, mas vou encurtar a discussão afirmando que
a primeira delas é a mais importante. Existem muitas maneiras de deduzir
que ela é uma boa candidata, como por exemplo olhando que ela é a única
requisição <em>relevante</em> que recebe html, mas vou pular essa parte.
</p>
<p>
Segundo o nosso dedo duro, a requisição utiliza o método “POST” e,
quando clicamos nela, temos informações sobre ela no painel ao lado.
Como eu falei acima, uma requisição é um arquivo .html que “pede” alguma
ao servidor com base no seu conteúdo. No geral, um bom lugar para
procurar o que a requisição está pedindo é o seu conjunto de parâmetros,
na aba “Params” do painel de detalhamento da requisição.
</p>
<p>
<img src="http://curso-r.com/blog/2017-05-19-scrapper-ssp_files/figure-html/unnamed-chunk-3-1.png" width="768">
</p>
<p>
Quando inspecionamos essa requisição “POST”, identificamos que as coisas
que são relevantes para o conteúdo da página estão nesses parâmetros. De
fato, pensando ingenuamente, clicar apenas em “2017” deve mexer nos
parâmetros que tem a ver com isso mas deve deixar os demais parâmetros
fixos. Por sorte, os parâmetros observados batem com essa expectativa:
“\_\_EVENTTARGET" é
<code>ctl00*c**o**n**t**e**u**d**o*$ddlAnos&lt;/code&gt; &\#xE9; um &lt;em&gt;placeholder&lt;/em&gt; que tem a ver com a caixa de sele&\#xE7;&\#xE3;o em que mexemos, os dois pr&\#xF3;ximos par&\#xE2;metros est&\#xE3;o zerados, &\#x201C;\_\_VIEWSTATE&quot; e &\#x201C;\_\_EVENTVALIDATION&quot; s&\#xE3;o par&\#xE2;metros da sess&\#xE3;o, e, por fim, temos os par&\#xE2;metros da consulta, que est&\#xE3;o todos zerados com exce&\#xE7;&\#xE3;o de &lt;code&gt;ctl00$conteudo
$$ddlAnos&lt;/code&gt;.&lt;/p&gt;
&lt;p&gt;Parece que os par&\#xE2;metros tem tudo a ver com a sa&\#xED;da. Ser&\#xE1; que mexer apenas neles basta para copiar a requisi&\#xE7;&\#xE3;o do navegador?&lt;/p&gt;
&lt;/div&gt;
&lt;/div&gt;
&lt;div id="crie-um-robo-que-imita-o-que-um-humano-faria" class="section level2"&gt; &lt;p&gt;Agora que sabemos um pouco mais sobre como as requisi&\#xE7;&\#xF5;es funcionam, vamos tentar fazer o POST mais simples de todos: ele s&\#xF3; tem os par&\#xE2;metros da &\#xFA;ltima imagem. Em R, o jeito mais f&\#xE1;cil de fazer requisi&\#xE7;&\#xF5;es &\#xE9; usando o pacote &lt;code&gt;httr&lt;/code&gt;. Ele &\#xE9; bem intuitivo e flex&\#xED;vel, de tal forma que fazer um POST &\#xE9; feito simplesmente chamando a fun&\#xE7;&\#xE3;o &lt;code&gt;httr::POST&lt;/code&gt;:&lt;/p&gt;
&lt;pre class="r"&gt;&lt;code&gt;url &lt;- &apos;http://www.ssp.sp.gov.br/Estatistica/Pesquisa.aspx&apos;
\#c&\#xF3;digo para dar um POST vazio no site
httr::POST(url)
\#o resultado &\#xE9; simplesmente o resultado original da p&\#xE1;gina&lt;/code&gt;&lt;/pre&gt;
&lt;p&gt;Para colocar par&\#xE2;metros num POST, basta usar o par&\#xE2;metro &lt;code&gt;body&lt;/code&gt;. Antes de complicar, vamos tentar o conjunto de par&\#xE2;metros mais simples de todos: vamos ignorar tudo que a gente n&\#xE3;o sabe exatamente o que &\#xE9; e preencher s&\#xF3; o que sabemos:&lt;/p&gt;
&lt;pre class="r"&gt;&lt;code&gt;params &lt;- list(\`\_\_EVENTTARGET\` = &quot;ctl00$conteudo$$
ddlAnos", `__EVENTARGUMENT` = "", `__LASTFOCUS` = "", `__VIEWSTATE` =
"", `__EVENTVALIDATION` = "", `ctl00$conteudo$ddlAnos` = "2015",
`ctl00$conteudo$ddlRegioes` = "0", `ctl00$conteudo$ddlMunicipios` = "0",
`ctl00$conteudo$ddlDelegacias` = "0")</code>
</pre>
<p>
Agora vamos fazer a requisição. O passo seguinte é apenas pra traduzir o
resultado pra um formato mais fácil de mexer.
</p>
<pre class="r"><code>resposta &lt;- httr::POST(url, body = params, encode = &apos;form&apos;) %&gt;% xml2::read_html() # traduz o resultado</code></pre>
<p>
Como vamos saber se deu certo? Existem vários jeitos, mas, por
simplicidade, aqui vamos apenas checar se alguma tabela contida em
<code>resposta</code> é igual à tabela que extraímos manualmente do
site. Vamos fazer isso usando a função
<code>rvest::html\_table()</code>.
</p>
<pre class="r"><code>resposta %&gt;% rvest::html_table()
# extrai todas as tabelas de um c&#xF3;digo em html.</code></pre>
<p>
Como se vê acima, nada que <em>se parece</em> com uma tabela na resposta
da nossa requisição é a tabelinha que identificamos no site. Muita coisa
pode ter dado errado, mas vamos começar pelo que é mais evidente: nós
ignoramos os parâmetros <code>\_\_VIEWSTATE</code> e
<code>\_\_EVENTVALIDATION</code>. Em última instância, nos vamos
precisar <em>entender</em> o que esses parâmetros significam, mas
primeiro vamos tentar simplesmente obter uma cópia desses valores
diretamente do site. Dando um ctrl+f no painel de ferramentas de
desenvolvedor identificamos que o valores dessa variáveis sai de umas
tags <code>input</code> nomeadas de acordo com o parâmetro que
representam.
</p>
<pre class="r"><code>view_state &lt;- httr::POST(url) %&gt;% xml2::read_html() %&gt;% rvest::html_nodes(&quot;input[name=&apos;__VIEWSTATE&apos;]&quot;) %&gt;% rvest::html_attr(&quot;value&quot;) event_validation &lt;- httr::POST(url) %&gt;% xml2::read_html() %&gt;% rvest::html_nodes(&quot;input[name=&apos;__EVENTVALIDATION&apos;]&quot;) %&gt;% rvest::html_attr(&quot;value&quot;)</code></pre>
<p>
Com os nossos embustes em mãos, basta pular para a próxima etapa: tentar
simular um clique no site. Nosso novo conjunto de parâmetros fica:
</p>
<pre class="r"><code>params &lt;- list(`__EVENTTARGET` = &quot;ctl00$conteudo$$ddlAnos&quot;, `__EVENTARGUMENT` = &quot;&quot;, `__LASTFOCUS` = &quot;&quot;, `__VIEWSTATE` = view_state, `__EVENTVALIDATION` = event_validation, `ctl00$conteudo$ddlAnos` = &quot;2015&quot;, `ctl00$conteudo$ddlRegioes` = &quot;0&quot;, `ctl00$conteudo$ddlMunicipios` = &quot;0&quot;, `ctl00$conteudo$ddlDelegacias` = &quot;0&quot;)</code></pre>
<p>
E o código da requisição fica:
</p>
<pre class="r"><code>resposta &lt;- httr::POST(url, body = params, encode = &apos;form&apos;) %&gt;% xml2::read_html() %&gt;% rvest::html_table()</code></pre>
<p>
Exatamente a tabelinha que queríamos! Entretanto, nem tudo são flores.
Como eu mencionei ali em cima, tanto a minha namorada quanto o NEV
tinham interesse no número de BO’s, que não é o que obtivemos fazendo a
requisição via R. Fuçando um pouco, é fácil ver que o que obtivemos são
os números de produtividade policial. Será que é fácil mexer nos
parâmetros pra obter os números de BO’s?
</p>
<p>
Felizmente, a resposta é sim, mas não é tão simples quanto parece. Se de
outra tela qualquer você clicar em “Ocorrências Registradas por Mês”
você vai perceber que o “\_\_EVENTTARGET" mudou para
<code>ctl00*c**o**n**t**e**u**d**o*$btnMes&lt;/code&gt;, mas, a despeito do que se poderia imaginar, os outros par&\#xE2;metros permaneceram com os nomes intactos.&lt;/p&gt; &lt;p&gt;&lt;img src="http://curso-r.com/blog/2017-05-19-scrapper-ssp\_files/figure-html/unnamed-chunk-11-1.png" width="768"&gt;&lt;/p&gt; &lt;p&gt;Como essa requisi&\#xE7;&\#xE3;o sugere, voc&\#xEA; consegue variar os tipos de informa&\#xE7;&\#xE3;o simplesmente variando o &\#x201C;\_\_EVENTTARGET&\#x201C;. Com isso, uma requisi&\#xE7;&\#xE3;o para obter as&\#x201D;Ocorr&\#xEA;ncias Registradas por M&\#xEA;s&quot; ficaria:&lt;/p&gt; &lt;pre class="r"&gt;&lt;code&gt;params &lt;- list(\`\_\_EVENTTARGET\` = &quot;ctl00$conteudo
$$ddlAnos&quot;, \`\_\_EVENTARGUMENT\` = &quot;&quot;, \`\_\_LASTFOCUS\` = &quot;&quot;, \`\_\_VIEWSTATE\` = view\_state, \`\_\_EVENTVALIDATION\` = event\_validation, \`ctl00$conteudo$ddlAnos\` = &quot;2015&quot;, \`ctl00$conteudo$ddlRegioes\` = &quot;0&quot;, \`ctl00$conteudo$ddlMunicipios\` = &quot;0&quot;, \`ctl00$conteudo$ddlDelegacias\` = &quot;0&quot;) resposta &lt;- httr::POST(url, body = params, encode = &apos;form&apos;) %&gt;% xml2::read\_html()&lt;/code&gt;&lt;/pre&gt;
&lt;p&gt;&\#xC9; importante notar que cada vez que vamos um POST desse, &\#xE9; como se estivessemos entrando na p&\#xE1;gina novamente, de tal forma que as informa&\#xE7;&\#xF5;es que a p&\#xE1;gina tem quando damos v&\#xE1;rios cliques seguidos s&\#xE3;o diferentes das informa&\#xE7;&\#xF5;es de quando acessamos a p&\#xE1;gina pelo R. Por exemplo, quando estamos navegando pela p&\#xE1;gina pelos links, o &\#x201C;\_\_EVENTTARGET&quot; volta para &lt;code&gt;ctl00$conteudo$$
ddlAnos</code> se você trocar de página <em>saindo</em> de uma página de
“Ocorrências Registradas por Mês”, mas o tipo de informação vêm
corretamente. Isso acontece porque, se você acessar várias páginas em
sequência, a página sabe de onde você veio.
</p>
</div>
<p>
Agora vem a repetição, o passo final da raspagem. Antes de qualquer
coisa precisamos de duas pequenas generalizações: queremos baixar vários
anos e vários municípios. Isso é fácil de fazer pois os índices dos
municípios são as suas posições em ordem alfabética. Dessa forma, é
possível fazer uma função que baixa as “Ocorrências Registradas por Mês”
de um município em um determinado ano:
</p>
<pre class="r"><code>baixa_bo_municipio_ano &lt;- function(ano, municipio){
pivot &lt;- httr::GET(url)
#serve apenas para pegarmos um view_state e um event_validation valido view_state &lt;- pivot %&gt;% xml2::read_html() %&gt;% rvest::html_nodes(&quot;input[name=&apos;__VIEWSTATE&apos;]&quot;) %&gt;% rvest::html_attr(&quot;value&quot;) event_validation &lt;- pivot %&gt;% xml2::read_html() %&gt;% rvest::html_nodes(&quot;input[name=&apos;__EVENTVALIDATION&apos;]&quot;) %&gt;% rvest::html_attr(&quot;value&quot;) params &lt;- list(`__EVENTTARGET` = &quot;ctl00$conteudo$$btnMes&quot;, `__EVENTARGUMENT` = &quot;&quot;, `__LASTFOCUS` = &quot;&quot;, `__VIEWSTATE` = view_state, `__EVENTVALIDATION` = event_validation, `ctl00$conteudo$ddlAnos` = &quot;2015&quot;, `ctl00$conteudo$ddlRegioes` = &quot;0&quot;, `ctl00$conteudo$ddlMunicipios` = municipio, `ctl00$conteudo$ddlDelegacias` = &quot;0&quot;) httr::POST(url, body = params, encode = &apos;form&apos;) %&gt;% xml2::read_html() %&gt;% rvest::html_table() %&gt;% dplyr::first() %&gt;% #&apos; serve pra pegar apenas a primeira tabela da p&#xE1;gina, #&apos; se houver mais do que uma. Estou assumindo que a #&apos; tabela que eu quero &#xE9; sempre a primeira. dplyr::mutate(municipio = municipio, ano = ano) }</code></pre>
<p>
Pra ilustar um grande loop, vamos baixar os BO’s de todos os municípios,
no ano de 2016. A função demora um pouco pra rodar, então quem quiser
ver como fica o resultado final pode clicar
<a href="https://github.com/curso-r/site/blob/master/content/blog/2017-05-19-scrapper-ssp/dados_ssp.rds">neste
link</a>.
</p>
<pre class="r"><code>GRID &lt;- expand.grid(municipio = 1:645, ano = &apos;2016&apos;, stringsAsFactors = F) D &lt;- purrr::by_row(GRID, baixa_bo_municipio_ano, .to = &quot;ocorrencias&quot;) %&gt;% tidyr::unnest(ocorrencias)</code></pre>

<p>
Com esses dados dá pra fazer muitas coisas legais. É possível, por
exemplo, fazer mapas como esse, que representa o número de homicídios em
2016, por município. Ele foi feito em R, mas como fazê-lo é assunto pra
outro post!
</p>
<p>
<img src="http://curso-r.com/blog/2017-05-19-scrapper-ssp_files/figure-html/unnamed-chunk-15-1.png" width="672">
</p>

</div>

