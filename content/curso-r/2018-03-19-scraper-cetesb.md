+++
title = "Web scraping do sistema de qualidade do ar da CETESB"
date = "2018-03-19 11:25:00"
categories = ["curso-r"]
original_url = "http://curso-r.com/blog/2018/03/19/2018-03-19-scraper-cetesb/"
+++

<p>
A minha tese de doutorado envolve a análise de dados de poluição do ar.
Parte do trabalho está em encontrar bases de dados que exemplifiquem
temas que eu precise discutir. Informações sobre poluição do ar
geralmente são disponibilizados por órgãos públicos de monitoramento
ambiental, o que deveria, por princípio, garantir a fácil acesso e a
coleta eficiente dos dados. Como sabemos, nem sempre é isso que
acontece.
</p>
<p>
O <a href="http://qualar.cetesb.sp.gov.br/qualar/home.do">Qualar</a> é o
sistema de informações de qualidade do ar da CETESB. Por meio dele,
podemos acessar os dados de todas as estações de monitoramento do estado
de São Paulo. O sistema exige a criação de um login e então o envio de
um pequeno formulário com quais informações você gostaria de visualizar.
</p>
<p>
O Qualar funciona muito bem para pequenas consultas, mas na extração de
uma massa grande de dados existem duas dificuldades:
</p>
<ol>
<li>
<p>
Se você precisa de dados de várias estações e de vários poluente, você
precisará repetir esse processo para cada combinação de
estação/poluente. Pegar todos os dados de ozônio da Grande São Paulo,
por exemplo, exigiria repetir a solicitação 23 vezes.
</p>
</li>
<li>
<p>
Como a planilha é impressa na tela, se você precisar de uma série muito
longa, você vai demorar bastante para carregar a página e seu computador
corre um grande risco de travar no meio do caminho por falta de RAM.
</p>
</li>
</ol>
<p>
Para contornar este problema, vamos usar o R para construir um código
que simule uma requisição de dados ao Qualar. Em seguida, vamos
transformar o código numa função para replicar o processo para diversos
parâmetros rodando apenas algumas linhas de códigos.
</p>
<p>
<strong>Observação</strong>: o sistema também tem uma opção “Exportar
dados Avançado”. Nela, é possível escolher até 3 parâmetros para cada
estação e os dados não são impressos na tela, sendo gerado diretamente
um arquivo csv para download. Porém, com a desculpa de praticar a
construção do scraper, não vamos usar essa opção.
</p>

<p>
Para construir o scraper, vamos seguir os passos definidos
<a href="http://curso-r.com/blog/2017/05/19/2017-05-19-scrapper-ssp/">neste
post</a> da Curso-R escrito pelo
<a href="https://github.com/azeloc">Fernando Corrêa</a>. São eles:
</p>
<ol>
<li>
Definir a página que você quer raspar.
</li>
<li>
Identificar exatamente as requisições que produzem o que você quer.
</li>
<li>
Construir um programa que imite as requisições que você faria
manualmente.
</li>
<li>
Repetir o passo (3) quantas vezes quiser.
</li>
</ol>
<p>
Um fluxo mais estruturado do web scraping é discutido
<a href="http://curso-r.com/blog/2018/02/18/2018-02-18-fluxo-scraping/">neste
post</a> do <a href="https://github.com/ctlente/">Caio Lente</a>.
</p>
<p>
Para chegar na página que queremos raspar, precisamos passar pelas
seguintes etapas dentro do Qualar: login, pesquisa e janela com os
dados. Veja abaixo como prosseguir.
</p>
<p>
<strong>Login</strong>: fazer o login
<a href="http://qualar.cetesb.sp.gov.br/qualar/home.do">na página
inicial</a>.
</p>
<p>
<strong>Pesquisa</strong>: na próxima página, acessar
“Consultas/Exportar Dados” no menu da esquerda e preencher a pesquisa
com os dados do parâmetro que você quer acessar.
</p>
<p>
<strong>Dados</strong>: na nova janela aberta pelo site estão os dados
que queremos raspar.
</p>

<p>
Para descobrir qual requisição é feita em cada momento, podemos utilizar
o “Inspect element” do navegador. Eu estou usando o Firefox neste post,
mas o procedimento é semelhante em outros navegadores.
</p>
<p>
O login é uma submissão de formulário. Inspecionando o html da página,
podemos ver que os itens que o formulário precisa enviar são o
“cetesb\_login” e o “cetesb\_passoword”.
</p>
<p>
Para descobrir que tipo de requisição o login faz, basta abrir o Inspect
element antes de fazer o login, logar no site e olhar a aba “Network”. A
requisição que queremos é a “autenticador”. Ela faz uma requisição POST
para a url
“<a href="http://qualar.cetesb.sp.gov.br/qualar/autenticador" class="uri">http://qualar.cetesb.sp.gov.br/qualar/autenticador</a>”.
</p>
<p>
Não vou mostrar aqui, mas a requisição que a pesquisa faz para acessar
os dados também é a submissão de um formulário e pode ser encontrada de
forma equivalente.
</p>
<p>
Assim, para acessar os dados, precisaremos enviar outra requisição POST,
agora para a url
“<a href="http://qualar.cetesb.sp.gov.br/qualar/exportaDados.do" class="uri">http://qualar.cetesb.sp.gov.br/qualar/exportaDados.do</a>”,
contendo os itens desse novo formulário, que são as informações que
preencheríamos na pesquisa. No próximo passo, vai ficar mais claro o que
estamos fazendo nessa etapa.
</p>

<p>
Vamos criar um código que imite essas requisições.
</p>
<p>
Primeiro, como o sistema Qualar exige login, precisamos capturar o
cookie do site para <em>manter a sessão logada</em> nas requisições
seguintes. O cookie da sessão é guardado no objeto
<code>my\_cookie</code>, que será passado em todas as requisições.
</p>
<pre class="r"><code>library(magrittr)
library(httr) res &lt;- GET(&quot;http://qualar.cetesb.sp.gov.br/qualar/home.do&quot;)
my_cookie &lt;- cookies(res)$value %&gt;% purrr::set_names(cookies(res)$name)</code></pre>
<p>
Agora, precisamos enviar a requisição POST para fazer o login e acessar
o sistema.
</p>
<ul>
<li>
<p>
Os parâmetros do formulário são colocados dentro do argumento
<code>body=</code> da função <code>POST()</code>. Se você estiver
replicando, basta substituir os valores <code>seu\_login</code> e
<code>sua\_senha</code> pelo login e senha que você obteve ao se
cadastrar no Qualar.
</p>
</li>
<li>
<p>
O argumento <code>encode = "form"</code> especifica que a requisição é
uma submissão de formulário.
</p>
</li>
<li>
<p>
O parâmetro <code>enviar = "OK"</code> indica que estamos submetendo o
formulário.
</p>
</li>
<li>
<p>
O cookie é passado usando a função <code>set\_cookies()</code>.
</p>
</li>
</ul>
<pre class="r"><code>url &lt;- &quot;http://qualar.cetesb.sp.gov.br/qualar/autenticador&quot; res &lt;- POST( url, body = list( cetesb_login = &quot;seu_login&quot;, cetesb_password = &quot;sua_senha&quot;, enviar = &quot;OK&quot; ), encode = &quot;form&quot;, set_cookies(my_cookie)
)</code></pre>
<p>
Então fazemos uma requisição POST para acessar os dados. Essa requisição
imita a pesquisa dentro da página “Exportar dados”. Nela, precisamos
definir quais dados queremos acessar.
</p>
<pre class="r"><code>url &lt;- &quot;http://qualar.cetesb.sp.gov.br/qualar/exportaDados.do&quot; res &lt;- POST( url, query = list(method = &quot;pesquisar&quot;), body = list( irede = &quot;A&quot;, dataInicialStr = &quot;04/03/2018&quot;, dataFinalStr = &quot;05/03/2018&quot;, cDadosInvalidos = &quot;on&quot;, iTipoDado = &quot;P&quot;, estacaoVO.nestcaMonto = &quot;72&quot;, parametroVO.nparmt = &quot;63&quot; ), encode = &quot;form&quot;, set_cookies(my_cookie)
)</code></pre>
<p>
Observe que, apesar de na pesquisa conseguirmos selecionar o nome da
estação e do parâmetro, a requisição envia ids numéricos. No Qualar, eu
encontrei apenas os ids das estações, mas os valores de ambos os
parâmetros podem ser encontrados inspecionando o html da página. Para
facilitar a nossa vida, eu salvei esses valores nos arquivos
<code>station\_ids.csv</code> e <code>param\_ids.csv</code>, que podem
ser baixados pelo
<a href="https://github.com/williamorim/Rpollution-blog/tree/master/content/blog/data">repositório
do blog no Github</a>.
</p>
<p>
Para finalizar, precisamos ler o resultado da nossa requisição e
transformar a tabela existe no html em um data frame.
</p>
<pre class="r"><code>content(res) %&gt;% rvest::html_table(fill = TRUE) %&gt;% extract2(2)</code></pre>

<p>
Agora, vamos transformar nosso código numa função para poder repetir o
processo várias vezes para diversos parâmetros.
</p>
<pre class="r"><code>scraper_CETESB &lt;- function(station, parameter, start, end, type = &quot;P&quot;, login, password, invalidData = &quot;on&quot;, network = &quot;A&quot;) { res &lt;- GET(&quot;http://qualar.cetesb.sp.gov.br/qualar/home.do&quot;) my_cookie &lt;- cookies(res)$value %&gt;% purrr::set_names(cookies(res)$name) url &lt;- &quot;http://qualar.cetesb.sp.gov.br/qualar/autenticador&quot; res &lt;- POST( url, body = list( cetesb_login = login, cetesb_password = password, enviar = &quot;OK&quot; ), encode = &quot;form&quot;, set_cookies(my_cookie) ) url &lt;- &quot;http://qualar.cetesb.sp.gov.br/qualar/exportaDados.do&quot; res &lt;- POST( url, query = list(method = &quot;pesquisar&quot;), body = list( irede = network, dataInicialStr = start, dataFinalStr = end, cDadosInvalidos = invalidData, iTipoDado = type, estacaoVO.nestcaMonto = station, parametroVO.nparmt = parameter ), encode = &quot;form&quot;, set_cookies(my_cookie) ) content(res) %&gt;% rvest::html_table(fill = TRUE) %&gt;% extract2(2) }</code></pre>
<p>
Assim, basta rodar a função abaixo com o seu login e senha para obter em
alguns segundos uma tabela com os dados solicitados. Veja um exemplo:
</p>
<pre class="r"><code>dados_cetesb &lt;- scraper_CETESB(station = &quot;72&quot;, parameter = &quot;63&quot;, start = &quot;04/03/2018&quot;, end = &quot;05/03/2018&quot;, type = &quot;P&quot;, login = &quot;seu_login&quot;, password = &quot;sua_senha&quot;, invalidData = &quot;on&quot;, network = &quot;A&quot;)</code></pre>
<p>
Precisamos apenas tirar as colunas vazias e corrigir o nome das colunas.
</p>
<pre class="r"><code>dados_cetesb &lt;- dados_cetesb %&gt;% janitor::remove_empty_cols() col_names &lt;- as.character(dados_cetesb[1,]) dados_cetesb &lt;- dados_cetesb %&gt;% magrittr::set_colnames(col_names) %&gt;% dplyr::slice(-1)</code></pre>
<p>
Assim obtemos os dados que queríamos:
</p>
<pre class="r"><code>dados_cetesb %&gt;% dplyr::select(`Nome Esta&#xE7;&#xE3;o`:`M&#xE9;dia Hor&#xE1;ria`) %&gt;% head %&gt;% knitr::kable()</code></pre>
<table>
<thead>
</thead>
<tbody>
<tr class="odd">
<td>
Parque D.Pedro II
</td>
<td>
O3 (Ozônio)
</td>
<td>
µg/m3
</td>
<td>
20
</td>
</tr>
<tr class="even">
<td>
Parque D.Pedro II
</td>
<td>
O3 (Ozônio)
</td>
<td>
µg/m3
</td>
<td>
19
</td>
</tr>
<tr class="odd">
<td>
Parque D.Pedro II
</td>
<td>
O3 (Ozônio)
</td>
<td>
µg/m3
</td>
<td>
18
</td>
</tr>
<tr class="even">
<td>
Parque D.Pedro II
</td>
<td>
O3 (Ozônio)
</td>
<td>
µg/m3
</td>
<td>
12
</td>
</tr>
<tr class="odd">
<td>
Parque D.Pedro II
</td>
<td>
O3 (Ozônio)
</td>
<td>
µg/m3
</td>
<td>
11
</td>
</tr>
<tr class="even">
<td>
Parque D.Pedro II
</td>
<td>
O3 (Ozônio)
</td>
<td>
µg/m3
</td>
<td>
12
</td>
</tr>
</tbody>
</table>
<p>
Iterando essa função fica fácil repetir o processo para diversas
estações e parâmetros.
</p>
<p>
É isso! Dúvidas, críticas e sugestões, deixe um comentário.
</p>
<p>
Até a próxima!
</p>

