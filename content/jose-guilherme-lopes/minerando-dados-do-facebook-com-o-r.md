+++
title = "Minerando dados do Facebook com o R"
date = "2017-07-06 02:24:01"
categories = ["jose-guilherme-lopes"]
original_url = "http://joseguilhermelopes.com.br/minerando-dados-do-facebook-com-o-r/"
+++

<p>
Em junho de 2017 o Facebook atingiu a marca de
<strong><a href="https://techcrunch.com/2017/06/27/facebook-2-billion-users/">2
bilhões de usuários ativos</a>. </strong>Com tantos usuários publicando,
curtindo, comentando e compartilhando informações, a quantidade de dados
gerados pela rede social ultrapassa
os <a href="https://techcrunch.com/2012/08/22/how-big-is-facebooks-data-2-5-billion-pieces-of-content-and-500-terabytes-ingested-every-day/">500
petabytes</a> por dia.
</p>
<p>
Com essa quantidade de dados, <strong>muitos insights e informações
valiosas podem ser obtidos quando estes dados são coletados e
analisados.</strong>
</p>
<h2>
<strong>O pacote Rfacebook</strong>
</h2>
<p>
Descobri recentemente um pacote
do <strong><a href="https://www.r-project.org/">R</a></strong> que se
conecta à API do Facebook. Com este pacote é possível executar comandos
que <strong>coletam dados sobre publicações, páginas e grupos</strong>
dentro da rede social.
</p>
<p>
O
<a href="https://cran.r-project.org/web/packages/Rfacebook/Rfacebook.pdf">pacote
Rfacebook</a>  possui uma série de funções que permitem extrair essas
informações, bem como <strong>cruzar os dados para se obter melhores
insights. </strong>Também é possível, nos argumentos das funções,
inserir vetores e/ou matrizes para se extrair dados mais específicos
para a sua análise.
</p>
<p>
Neste artigo vou explicar sobre como conectar à API do Facebook e sobre
as funções básicas do pacote Rfacebook. À medida que você for se
familiarizando com as funções, use a sua criatividade e conhecimento em
programação em R para explorar os dados mais profundamente.
</p>
<p>
Para se conectar à API do Facebook, é necessário criar um aplicativo no
Facebook e gerar um token de acesso.
</p>
<p>
Não há muito mistério, é um processo bem simples de se realizar. Vamos
lá:
</p>
<p>
<strong><br> Criando o seu aplicativo</strong>
</p>
<p>
Para se conectar à API do Facebook, é necessário criar um aplicativo
dentro da plataforma
<strong><a href="https://developers.facebook.com/">Facebook for
Developers</a>. </strong>
</p>
<p>
A criação do aplicativo é gratuita e bastante simples, você pode acessar
a página utilizando o seu login pessoal do Facebook.
</p>
<p>
<img class="aligncenter wp-image-117" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/1.1.jpg%201073w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/1.1-300x20.jpg%20300w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/1.1-768x51.jpg%20768w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/1.1-1024x68.jpg%201024w" alt="" width="1315" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/1.1.jpg 1073w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/1.1-300x20.jpg 300w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/1.1-768x51.jpg 768w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/1.1-1024x68.jpg 1024w">
</p>
<p>
Após aceitar os termos, clique em <strong>Adicionar um novo
aplicativo, </strong>insira um nome para o aplicativo e um e-mail para
contato.
</p>
<p>
Em seguida clique em <strong>Crie um número de identificação do
aplicativo</strong>.
</p>
<p>
<img class="aligncenter wp-image-119 size-full" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/2.jpg%201304w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/2-300x189.jpg%20300w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/2-768x483.jpg%20768w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/2-1024x644.jpg%201024w" alt="" width="1304" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/2.jpg 1304w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/2-300x189.jpg 300w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/2-768x483.jpg 768w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/2-1024x644.jpg 1024w">
</p>
<p>
Dentro do painel do seu novo aplicativo, repare na <strong>ID do
Aplicativo</strong> e na <strong>Chave Secreta do Aplicativo</strong>,
elas serão importantes na hora de realizar a autenticação dentro do R.
</p>
<p>
<img class="aligncenter wp-image-120 size-full" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/3.jpg%201692w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/3-300x87.jpg%20300w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/3-768x223.jpg%20768w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/3-1024x297.jpg%201024w" alt="" width="1692" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/3.jpg 1692w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/3-300x87.jpg 300w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/3-768x223.jpg 768w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/3-1024x297.jpg 1024w">
</p>
<p>
Na aba <strong>Produtos</strong>, clique em <strong>+ Adicionar
produto</strong>.
</p>
<p>
Selecione <strong>Login do Facebook.</strong>
</p>
<p>
Dentro das configurações, certifique-se que o campus <strong>Login no
OAuth do cliente</strong> esteja marcado como <strong>Sim.</strong>
</p>
<p>
No campo<strong> URIs de redirecionamento do OAuth
válidos</strong> insira
<em><strong><http://localhost:1410/></strong></em>
</p>
<p>
Salve as alterações.
</p>
<p>
<img class="aligncenter wp-image-121 size-full" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/4.jpg%201702w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/4-300x133.jpg%20300w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/4-768x342.jpg%20768w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/4-1024x455.jpg%201024w" alt="" width="1702" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/4.jpg 1702w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/4-300x133.jpg 300w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/4-768x342.jpg 768w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/4-1024x455.jpg 1024w">
</p>
<p>
Com essas configurações, já é possível conectar o R com a API do
Facebook via o aplicativo que você criou.
</p>
<p>
Em alguns casos, pode levar alguns minutos ou até horas para que o seu
aplicativo seja “liberado” pelo Facebook. Mas em geral, você já pode ir
diretamente para os próximos passos.
</p>
<p>
<strong><br> Obtendo o token de acesso</strong>
</p>
<p>
Para executar os scripts do R e realizar consultas no Facebook, é
necessário ter um <strong>token de acesso</strong>.
</p>
<p>
Quase todas as funções do pacote Rfacebook pedem como um dos argumentos
o token de acesso. O token é válido por 2 horas e sempre que ele
expirar, basta voltar ao Facebook for Developers e gerá-lo novamente.
</p>
<p>
Para obter o token, acesse <strong>Ferramentas e Suporte </strong>e em
seguida <strong>Explorador de Graph API</strong>.
</p>
<p>
Clique em <strong>Obter token de acesso do usuário</strong>.
</p>
<p>
Irá abrir um campo para você selecionar as permissões do token. Se você
criou o aplicativo somente para minerar dados com o R e não
compartilhará o seu aplicativo com terceiros, é indiferente os campos
que você selecionar.
</p>
<p>
<img class="aligncenter wp-image-122 size-full" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/5.jpg%201152w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/5-300x97.jpg%20300w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/5-768x247.jpg%20768w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/5-1024x330.jpg%201024w" alt="" width="1152" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/5.jpg 1152w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/5-300x97.jpg 300w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/5-768x247.jpg 768w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/5-1024x330.jpg 1024w">
</p>
<p>
<strong><br> Conectando o R com a API do Facebook</strong>
</p>
<p>
Dentro do R, instale o pacote <strong>Rfacebook</strong>.
</p>
<pre class="brush: r; title: ; notranslate"> install.packages(&quot;Rfacebook&quot;) library(&quot;Rfacebook&quot;) </pre>
<p>
Faça a autenticação do seu aplicativo com o comando a seguir, inserindo
o ID e a chave secreta que estão disponíveis dentro do painel do seu
aplicativo.
</p>
<pre class="brush: r; title: ; notranslate"> fbOAuth &lt;- fbOAuth(app_id=&quot;ID&quot;, app_secret=&quot;Chave secreta&quot;, extended_permissions = FALSE) </pre>
<p>
Ao executar o comando, irá aparecer no console do R a seguinte
mensagem: <em>“Copy and paste into Site URL on Facebook App Settings:
<http://localhost:1410/> When done, press any key to continue…”</em>
</p>
<p>
Aperte qualquer tecla para continuar (se você estiver executando os
comandos na tela de script, clique na tela de console e dê um enter).
</p>
<p>
Assim irábrir uma página no seu navegador dizendo
<strong><em>“Authentication complete. Please close this page and return
to R.”</em></strong>
</p>
<p>
Pronto, a sua autenticação está feita.
</p>
<p>
<img class="aligncenter wp-image-124 size-full" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/6.jpg%201000w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/6-300x125.jpg%20300w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/6-768x321.jpg%20768w" alt="" width="1000" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/6.jpg 1000w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/6-300x125.jpg 300w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/6-768x321.jpg 768w">
</p>
<p>
Depois da autenticação, insira o token. Atribua à uma variável com o
nome “token” o código do token de acesso que você gerou.
</p>
<pre class="brush: r; title: ; notranslate"> token &lt;- &apos;token de acesso&apos; </pre>
<p>
Pronto. Agora você já pode executar as funções do pacote e realizar
consultas e análises com os dados do Facebook.
</p>
<p>
<strong><br> Páginas curtidas</strong>
</p>
<p>
A função <strong>getLikes</strong> retorna as páginas curtidas por um
determinada usuário, bem como o ID e o website referente a cada página.
</p>
<pre class="brush: r; title: ; notranslate"> my_likes &lt;- getLikes(user=&quot;me&quot;, token=token)</pre>
<p>
Para limitar a quantidade de páginas, basta inserir o argumento
<em>“n=”</em> na função.
</p>
<p>
Você pode realizar a consulta para uma ou mais pessoas, desde que elas
mostrem publicamente as páginas que curtem ou se elas utilizarem o seu
aplicativo.
</p>
<p>
No exemplo, eu fiz a consulta para o meu perfil pessoal. Veja o output:
</p>
<p>
<img class="aligncenter wp-image-125 size-full" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/7.jpg%201013w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/7-300x170.jpg%20300w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/7-768x434.jpg%20768w" alt="" width="1013" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/7.jpg 1013w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/7-300x170.jpg 300w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/7-768x434.jpg 768w">
</p>
<p>
<strong><br> Informações de uma página</strong>
</p>
<p>
A função <strong>getPage</strong> retorna informações das publicações de
uma determinada página, tais como:
</p>
<ul>
<li>
ID da publicação
</li>
<li>
Qual foi a mensagem escrita
</li>
<li>
Data e hora que foi publicada
</li>
<li>
Qual o formato da publicação (link, imagem, texto, vídeo)
</li>
<li>
O link da publicação, caso exista
</li>
<li>
Quantidade de curtidas
</li>
<li>
Quantidade de comentários
</li>
<li>
Quantidade de compartilhamentos
</li>
</ul>
<p>
Também é possível obter, para uma determinada publicação, a quantidade
de cada uma das suas<strong> <em>reações</em> (curtir, amei, haha, uau,
triste, grr)</strong> através da função <strong>getReactions</strong>.
</p>
<p>
No argumento “<em>page”</em> pode ser inserido a string do nome da
página (sem os espaços) ou o ID da página.<br> O argumento <em>“n”</em>
retorna a quantidade de publicações a serem exibidas.<br> Também é
possível limitar o período das publicações com os argumentos
<em>“since”</em> e <em>“until”</em> (por exemplo: since=’2017/05/01′,
until=’2017/05/31).
</p>
<p>
Como exemplo, executei o comando para obter as últimas 200 publicações
da página <strong>BBC Brasil.</strong>
</p>
<pre class="brush: r; title: ; notranslate"> posts_BBC &lt;- getPage(page=&quot;bbcbrasil&quot;, token=token, n=200) </pre>
<p>
Veja o resultado (clique na imagem para visualizar em maior resolução):
</p>
<p>
<a href="http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/8.jpg"><img class="aligncenter wp-image-126 size-full" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/8.jpg%201854w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/8-300x171.jpg%20300w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/8-768x437.jpg%20768w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/8-1024x583.jpg%201024w" alt="" width="1854" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/8.jpg 1854w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/8-300x171.jpg 300w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/8-768x437.jpg 768w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/8-1024x583.jpg 1024w"></a>
</p>
<p>
<strong><br> Pesquisa por páginas</strong>
</p>
<p>
A função <strong>searchPages</strong> retorna uma quantidade determinada
de páginas que tenham uma string em comum. Para cada página, são geradas
informações tais como:
</p>
<ul>
<li>
ID da página
</li>
<li>
Informações “sobre”
</li>
<li>
Categoria
</li>
<li>
Descrição
</li>
<li>
Quantidade de curtidas da página
</li>
<li>
Link para a página
</li>
<li>
Cidade, estado e país
</li>
<li>
Coordenadas da localização da página, se existir
</li>
<li>
Nome da página
</li>
<li>
Quantidade de usuários que estão falando sobre
</li>
<li>
Nome de usuário da página
</li>
<li>
Website
</li>
</ul>
<p>
Como exemplo, executei o comando para buscar 200 páginas que tenham em
comum a string <strong>startup</strong>:
</p>
<pre class="brush: r; title: ; notranslate"> paginas_startups &lt;- searchPages(string=&quot;startup&quot;, token=token, n=200) </pre>
<p>
Acabei classificando as páginas pela quantidade de curtidas para uma
visualização mais interessante aqui.
</p>
<p>
Veja o resultado (clique na imagem para visualizar em maior resolução):
</p>
<p>
<a href="http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/9.jpg"><img class="aligncenter wp-image-127 size-full" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/9.jpg%201852w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/9-300x171.jpg%20300w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/9-768x439.jpg%20768w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/9-1024x585.jpg%201024w" alt="" width="1852" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/9.jpg 1852w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/9-300x171.jpg 300w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/9-768x439.jpg 768w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/9-1024x585.jpg 1024w"></a><a href="http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/10.jpg"><img class="aligncenter wp-image-128 size-full" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/10.jpg%201234w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/10-300x257.jpg%20300w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/10-768x657.jpg%20768w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/10-1024x876.jpg%201024w" alt="" width="1234" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/10.jpg 1234w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/10-300x257.jpg 300w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/10-768x657.jpg 768w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/10-1024x876.jpg 1024w"></a>
</p>
<p>
<strong><br> Atualizar status</strong>
</p>
<p>
É possível publicar no seu perfil pessoal (ou do usuário que utiliza o
seu aplicativo) através da função <strong>updateStatus:</strong>
</p>
<pre class="brush: r; title: ; notranslate"> updateStatus(&quot;texto a ser publicado&quot;, token)</pre>
<p>
<strong><br> Informações de um grupo</strong>
</p>
<p>
A função <strong>getGroup</strong> retorna as informações das
publicações de um determinado grupo (se este for aberto), tais como:
</p>
<ul>
<li>
ID e nome do usuário que fez a publicação
</li>
<li>
Mensagem
</li>
<li>
Data e hora
</li>
<li>
Tipo
</li>
<li>
Link, se houver
</li>
<li>
Quantidade de curtidas
</li>
<li>
Quantidade de comentários
</li>
<li>
Quantidade de compartilhamentos
</li>
</ul>
<p>
No exemplo, executei o comando para obter as últimas 100 publicações do
grupo <strong>R Brasil – Programadores.</strong>
</p>
<pre class="brush: r; title: ; notranslate"> grupo_R &lt;- getGroup(&quot;1410023525939155&quot;, token, n=100) </pre>
<p>
Veja o resultado (clique na imagem para visualizar em maior resolução):
</p>
<p>
<a href="http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/11.jpg"><br>
<img class="aligncenter wp-image-131 size-full" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/11.jpg%201855w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/11-300x171.jpg%20300w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/11-768x438.jpg%20768w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/11-1024x583.jpg%201024w" alt="" width="1855" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/11.jpg 1855w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/11-300x171.jpg 300w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/11-768x438.jpg 768w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/11-1024x583.jpg 1024w"></a>
</p>
<p>
<strong>Pesquisa por grupos</strong>
</p>
<p>
A função <strong>searchGroup</strong> retorna grupos do Facebook que
possuem uma string em comum.
</p>
<p>
Além do nome e ID de cada grupo, também é informado se o grupo é aberto
ou fechado.
</p>
<p>
Como exemplo, executei o comando para buscar grupos que tenham em comum
a string <strong>Linux</strong>
</p>
<pre class="brush: r; title: ; notranslate"> grupos_linux &lt;- searchGroup(&quot;linux&quot;, token=token) </pre>
<p>
Veja o resultado:
</p>
<p>
<img class="aligncenter wp-image-132 size-full" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/12.jpg%20430w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/12-198x300.jpg%20198w" alt="" width="430" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/12.jpg 430w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/06/12-198x300.jpg 198w">
</p>
<p>
<strong>Código com os exemplos</strong>
</p>
<p>
Caso você queira explorar o pacote começando pelos exemplos que eu citei
neste artigo, disponibilizo a seguir o código com os comandos que
utilizei (junto com comentários para facilitar o entendimento).
</p>
<p>
Ressalto que antes de tudo é necessário instalar o pacote com o comando
<strong>install.packages(“Rfacebook”)</strong>.
</p>
<pre class="brush: r; title: ; notranslate"># Bibliotecas library(&quot;Rfacebook&quot;) # Autentica&#xE7;&#xE3;o fb_oauth &lt;- fbOAuth(app_id=&quot;id&quot;, app_secret=&quot;chave secreta&quot;, extended_permissions = FALSE) # Token token &lt;- &apos;token de acesso&apos; # Informa&#xE7;&#xE3;o de Usu&#xE1;rio # A fun&#xE7;&#xE3;o getUsers retorna as informa&#xE7;&#xF5;es b&#xE1;sicas de um usu&#xE1;rio meu_perfil &lt;- getUsers(user=&apos;me&apos;, token=token) # &#xC9; poss&#xED;vel criar um vetor no argumento &quot;user&quot; e assim obter informa&#xE7;&#xF5;es de diferentes usu&#xE1;rios obama_trump &lt;- getUsers(users = c(&quot;barackobama&quot;, &quot;donaldtrump&quot;), token=token) # Curtidas # A fun&#xE7;&#xE3;o getLikes retorna as p&#xE1;ginas curtidas por um determinada usu&#xE1;rio, juntamente ao ID e ao website referente a cada p&#xE1;gina minhas_curtidas &lt;- getLikes(user=&quot;me&quot;, token=token) # Informa&#xE7;&#xF5;es de uma p&#xE1;gina # A fun&#xE7;&#xE3;o getPage retorna as informa&#xE7;&#xF5;es das publica&#xE7;&#xF5;es de uma determinada p&#xE1;gina # no argumento &quot;page&quot; pode ser inserido a string do nome da p&#xE1;gina(sem os espa&#xE7;os) ou o ID # o argumento &quot;n&quot; retorna a quantidade de publica&#xE7;&#xF5;es a serem exibidas # tamb&#xE9;m &#xE9; poss&#xED;vel limitar o per&#xED;odo das publica&#xE7;&#xF5;es com os argumentos &quot;since&quot; e &quot;until&quot; (ex: since=&apos;2017/05/01&apos;, until=&apos;2017/05/31) posts_BBC &lt;- getPage(page=&quot;bbcbrasil&quot;, token=token, n=200) # Busca por p&#xE1;ginas # A fun&#xE7;&#xE3;o searchPages retorna uma quantidade determinada de p&#xE1;ginas com uma string em comum paginas_startups &lt;- searchPages(string=&quot;startup&quot;, token=token, n=200) # Atualiza&#xE7;&#xE3;o de status # A fun&#xE7;&#xE3;o updateStatus permite publicar no perfil do usu&#xE1;rio updateStatus(&quot;texto a ser publicado&quot;, token) # Informa&#xE7;&#xF5;es de um grupo # A fun&#xE7;&#xE3;o getGroup retorna as informa&#xE7;&#xF5;es das publica&#xE7;&#xF5;es de um determinado grupo grupo_R &lt;- getGroup(&quot;1410023525939155&quot;, token, n=100) # Busca por grupos # A fun&#xE7;&#xE3;o searchGroup retorna grupos que possuem uma string em comum grupos_linux &lt;- searchGroup(&quot;linux&quot;, token=token) </pre>
<p>
<strong>Para ir além</strong>
</p>
<p>
Este artigo teve como propósito mostrar como se cria um aplicativo pelo
Facebook for Developers, como conectá-lo ao R e apresentar o pacote
Rfacebook e as suas funções básicas.
</p>
<p>
O pacote possui diversas outras funções, muitas delas possuem restrições
que dependem da versão da sua API ou da permissão que você tem com o seu
aplicativo. Apresentei aqui as funções que não possuem nenhuma destas
restrições.
</p>
<p>
Além disso, citei as funções em suas formas mais básicas. É possível
realizar incontáveis cruzamentos desses dados utilizando outras funções
e/ou algoritmos.
</p>
<p>
O Facebook é uma mina de ouro dos dados. Existe um universo de
informações que podem ser extraídas com o pacote Rfacebook.
</p>
<p>
Consulte
o <strong><a href="https://cran.r-project.org/web/packages/Rfacebook/Rfacebook.pdf">Manual
do pacote Rfacebook</a></strong> para maiores detalhes. Veja também o
<strong><a href="https://github.com/pablobarbera/Rfacebook/">GitHub do
desenvolvedor do pacote</a></strong> para estar por dentro de
aplicações, informações sobre bugs e sobre atualizações do pacote.
</p>
<p>
Para aprender mais sobre programação em R, recomendo o site
<a href="http://r4ds.had.co.nz/"><strong>R for Data
Science.</strong></a>
</p>
<p>
Espero que este artigo tenha sido útil e que você possa obter grandes
insights analisando os dados do Facebook.
</p>
<p>
Qualquer comentário, sugestão ou dúvida, utilize o campo abaixo ou as
redes sociais que participo. Ficarei muito feliz em te ouvir.
</p>

