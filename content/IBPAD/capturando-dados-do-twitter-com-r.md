+++
title = "Capturando dados do Twitter com R"
date = "2016-03-12 16:00:44"
categories = ["IBPAD"]
original_url = "http://www.ibpad.com.br/blog/comunicacao-digital/capturando-dados-do-twitter-com-r/"
+++

<p>
 
</p>
<p style="text-align: justify;">
<img class="alignleft wp-image-540" src="https://i1.wp.com/ibpad.com.br/wp-content/uploads/2016/03/Imagem1-1-300x211.png?resize=183%2C138" alt="Twitter R" data-recalc-dims="1" />Um
dos primeiros desafios para qualquer analista de dados oriundos de
mídias sociais é a captura dos dados. Existem vários softwares pagos e
gratuitos, mas nem todos são claros sobre como exatamente esta captura
está sendo realizada. O R, que é gratuito, pode te ajudar bastante nesse
processo.
</p>
<p style="text-align: right;">
 Mostro aqui o primeiro passo nessa direção.
</p>
<p>
 
</p>
<blockquote>
<p style="text-align: right;">
<span style="color: #808080;">Carlos Cinelli é professor do curso de
<a style="color: #808080;" href="http://www.ibpad.com.br/produto/programacao-em-r/" target="_blank">Programação
em R </a></span>
</p>
<p style="text-align: right;">
</blockquote>
<p>
<span id="more-533"></span>
</p>
<p>
A primeira coisa que você tem que fazer é criar uma aplicação no
Twitter,
<a href="https://apps.twitter.com/app/new" target="_blank" class="broken_link">a
partir deste link.</a>
</p>
<p>
Após seguir as instruções do site, você irá copiar os códigos em
<strong>Consumer Key (API Key) </strong>e <strong>Consumer Secret (API
Secret)</strong>.
</p>
<p>
Verifique se o seu nível de acesso (Access Level) está como <strong>Read
and write</strong>, para você poder consultar e tuitar por meio da API.
Em seguida, peça para gerar seus <em>tokens</em> de acesso e copie os
códigos em <strong>Access Token</strong> e <strong>Access Token
Secret</strong>.
</p>
<p>
Uma vez com os códigos em mãos, instale o pacote <code>twitteR</code> na
sua máquina.
</p>
<pre class="crayon-plain-tag">install.packages("twitteR")</pre>
<p>
 
</p>
<p>
Pronto! A a partir de agora você pode tanto consultar quanto tuitar,
retuitar – tudo a partir do R. Vamos fazer alguns testes simples.
Primeiramente precisamos passar as chaves de acesso para o
<code>twitteR</code>.
</p>

<pre class="crayon-plain-tag">library(twitteR)
 
# coloque suas chaves
api_key             &lt;- "xxxx"
api_secret          &lt;- "xxxx"
access_token        &lt;- "xxxx"
access_token_secret &lt;- "xxxx"
 
setup_twitter_oauth(api_key, api_secret, access_token, access_token_secret)</pre>
<br />  
</p>

Para começar, que tal buscar os <em>trends</em> de Brasília neste
momento?

<pre class="crayon-plain-tag"># woeid -&gt; where on earth id
# 455819 é o código de Brasília
trendsBrasilia &lt;- getTrends(woeid = 455819)
# 10 primeiros apenas
trendsBrasilia$name[1:10]</pre>
<br /> Resultado:
</p>

<pre class="crayon-plain-tag">##  [1] "#PurposeTourVancouver"      "#ARegraFinal"             
##  [3] "#GloboGolpista"             "Louise"                   
##  [5] "DIRECTIONERS AO ATAQUE"     "#SemJesusEu"              
##  [7] "#NoFuturoEu"                "HOJE TEM FLAMENGO"        
##  [9] "Doctor Who Back To Netflix" "Atlanta"</pre>
<br /> Os demais <code>woied</code> disponíveis podem ser obtidos com a
função <code>availableTrendLocations()</code>.
</p>

<p>
Vejamos outro exemplo: quais os últimos 50 tweets contendo a palavra
‘impeachment’?
</p>

<pre class="crayon-plain-tag">imp &lt;- searchTwitter('impeachment', n = 50)
imp[c(1, 25, 50)]</pre>
<br />  
</p>

Resultado:

<pre class="crayon-plain-tag"> 
## [[1]]
## [1] "GeizeStella: RT @BlogOlhoNaMira: Específico: impeachment. Pedir fim da corrupção pra deputado corrupto é mandar lembrança pra quem não conhece https://t…"
##
## [[2]]
## [1] "paulogmmoura: De acordo com a literatura sobre impeachment, a consistência e a extensão dos protestos de rua são os aspectos... https://t.co/W3H92BUXtu"
##
## [[3]]
## [1] "prof_xico: RT @radaronline: Se impeachment passar, TSE deve sustar processo contra Temer https://t.co/y9tCw6jWJf"</pre>

<p>
E, como último exemplo, vamos utilizar a função <code>tweet()</code>
para tuitar diretamente do R.
</p>
<pre class="crayon-plain-tag">tweet("Tweet gerado com twitteR https://cran.r-project.org/web/packages/twitteR/index.html")</pre>
</p>
<blockquote class="twitter-tweet" data-width="550">
<p lang="en" dir="ltr">
Tweet gerado com twitteR
<a href="https://t.co/LN62PvMBMB">https://t.co/LN62PvMBMB</a>
</p>
<p>
— Análise Real (@analisereal)
<a href="https://twitter.com/analisereal/status/706263873997946880">March
5, 2016</a>
</p>
</blockquote>
<p>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>
</p>
<p>
 
</p>

<p>
Esses são alguns dos comandos básicos. A partir daí é possível fazer
consultas mais elaboradas e criar o seu próprio sistema de monitoramento
de Twitter.
</p>
<p>
<a href="https://dev.twitter.com/rest/public/rate-limiting" target="_blank">Atenção:
lembre-se sempre de respeitar os limites
</a><a href="https://dev.twitter.com/rest/public/rate-limiting" target="_blank">estabelecidos
pelo
Twitter</a><a href="https://dev.twitter.com/rest/public/rate-limiting" target="_blank">
para a API.</a>
</p>
<p>
<a href="http://www.ibpad.com.br/produto/programacao-em-r/" target="_blank">Conheça
o nosso curso de Programação em R. Turmas abertas em São Paulo e no Rio
de Janeiro.</a>
</p>

<p>
 
</p>
<p>
O post
<a rel="nofollow" href="http://www.ibpad.com.br/blog/comunicacao-digital/capturando-dados-do-twitter-com-r/">Capturando
dados do Twitter com R</a> apareceu primeiro em
<a rel="nofollow" href="http://www.ibpad.com.br">IBPAD</a>.
</p>

