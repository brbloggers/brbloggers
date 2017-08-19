+++
title = "Como fazer o R avisar pelo telegram que bitcoin tá barato"
date = "2017-08-19 07:26:00"
categories = ["curso-r"]
original_url = "http://curso-r.com/blog/2017/08/19/2017-08-19-r-telegram-bitcoin/"
+++

<div class="col-md-9" id="blog-post">
<p class="text-muted text-uppercase mb-small text-right">
Por <a href="http://curso-r.com/author/athos">Athos</a> 19/08/2017
</p>
<div id="post-content">
<p>
O ponto máximo da história é o R mandando mensagem pro Telegram. Só para
motivar, vou contar o que fiz de divertido usando telegram e preços de
bitcoin.
</p>
<p>
<img src="http://curso-r.com/blog/2017-08-19-r-telegram-bitcoin/r_telegram.gif">
</p>
<p>
Herói do dia: <a href="https://github.com/lbraglia">Luca Biglia</a>,
autor do pacote <code>telegram</code> do R.
</p>
<div id="o-que-faremos" class="section level1">
<p>
Como mencionei, Vou construir um <strong>Acompanhador de
bitcoin</strong> pra ilustrar e ao fim do post teremos feito o R mandar
um telegram quando o preço da bitcoin atingir um dado patamar.
</p>
<p>
<img src="http://curso-r.com/blog/2017-08-19-r-telegram-bitcoin/serie_bitcoin.png">
</p>
<p>
Na arte de hoje vamos precisar de:
</p>
<p>
Os passos que precisamos seguir para alcançar isso são:
</p>
<ol>
<li>
Criar um .Rproj (projeto do RStudio).
</li>
<li>
instalar e carregar o pacote <code>telegram</code> do R.
</li>
<li>
Criar um bot do telegram com a ajuda do
<a href="https://telegram.me/botfather">BotFather</a>.
</li>
<li>
Conectar o R com o bot.
</li>
<li>
Consultar e guardar os preços da bitcoin de 30 em 30 segundos.
</li>
<li>
criar um loop infinito no R para acompanhar os preços sem parar.
</li>
<li>
Fazer o R mandar mensagem pra gente quando o preço da bitcoin for maior
que X, por exemplo.
</li>
<li>
(extra) Pensar em ideias mirabolantes do que fazer com telegram + R.
</li>
</ol>

<p>
Antes de mais nada, uma breve introdução às coisas que aparecerão por
aqui:
</p>
<ul>
<li>
<a href="https://telegram.org/">telegram</a>: é igual ao Whatsapp, mas
melhorado.
</li>
<li>
<a href="https://telegram.me/botfather">BotFather</a>: um contato do seu
celular (no telegram) que te ajuda a criar um bot do telegram.
</li>
<li>
<a href="https://en.wikipedia.org/wiki/Bitcoin">bitcoin</a>: moeda
digital de sucesso.
</li>
<li>
<a href="https://blinktrade.com/docs/">BlinkTrade</a>: dentre outras
coisas, fornece API para valores da bitcoin em tempo real.
</li>
</ul>

<div id="acompanhador-de-bitcoin" class="section level2">
<p>
Já crie o seu .Rproj, rode
<code>install.packages("telegram");library(telegram)</code> e vamos
direto ao terceiro passo.
</p>
<p>
Bot é como se fosse uma pessoa a mais na sua lista de contato do
telegram, mas que são máquinas em vez de humanos e respondem a comandos
específicos. A graça é que você pode customizar esses comandos do jeito
que quiser! Basta ter um propósito e saber programá-lo.
</p>
<p>
O README que tá no <a href="https://github.com/lbraglia/telegram">github
do pacote</a> é muito bom! Vou resumir com pequenas mudanças o que está
lá:
</p>
<ol>
<li>
Vá ao seu telegram e procure pelo BotFather como se estivesse procurando
uma pessoa da sua lista de contato. Abra uma conversa com ele!
</li>
<li>
Envie o texto “/start” e em seguida “/newbot”. Dê um nome ao seu bot
(pode ser um nome fofo) e depois um nome de usuário para o seu bot que
necessariamente termina em <em>bot</em>.
</li>
<li>
Agora copie e cole o token que o BotFather te enviou no
<code>.Renviron</code>. O meu bot tem o username
<code>AthosDamianiBot</code>, então eu devo colocar o nome da variável
assim:
</li>
</ol>
<p>
<img src="http://curso-r.com/blog/2017-08-19-r-telegram-bitcoin/Renvirom_1.png">
</p>
<p>
Se você usar essa convenção de nome você poderá usar a função
<code>bot\_token()</code> pra pegar o seu token. Caso contrário vai ter
que apelar para a <code>Sys.getenv()</code>.
</p>
<p>
<strong>OBS:</strong> Reinicie o R para o <code>.Renviron</code> ficar
configurado.
</p>

<div id="passo-4-bot-do-telegram---conectar-ao-r" class="section level3">
<ol>
<li>
Carregue o pacote e crie um objeto <code>TGBot</code> para o seu bot
criando anteriormente:
</li>
</ol>
<pre class="r"><code>library(telegram) bot &lt;- TGBot$new(token = bot_token(&apos;AthosDamianiBot&apos;)) bot$getMe()</code></pre>
<ol>
<li>
<p>
Agora precisamos do <code>chat\_id</code>. Para isso, no seu telegram,
procure o seu bot como se fosse um contato (que nem você fez com o
BotFather) e comece uma conversa com ele.
</p>
</li>
<li>
<p>
No R, chame o método
<code>bot$getUpdates()&lt;/code&gt; para pegar no R as mensagens que voc&\#xEA; enviou a ele e, finalmente, encontre o &lt;code&gt;chat\_id&lt;/code&gt; escondido no &lt;code&gt;msgs&lt;/code&gt;.&lt;/p&gt;&lt;/li&gt; &lt;/ol&gt; &lt;pre class="r"&gt;&lt;code&gt;msgs &lt;- bot$getUpdates()
msgs*m**e**s**s**a**g**e*chat$id\[1\] \[1\] 135717340&lt;/code&gt;&lt;/pre&gt; &lt;ol&gt; &lt;li&gt;Com o &lt;code&gt;chat\_id&lt;/code&gt; em m&\#xE3;os, configure ele como &lt;code&gt;chat\_id&lt;/code&gt; padr&\#xE3;o.&lt;/li&gt; &lt;/ol&gt; &lt;pre class="r"&gt;&lt;code&gt;bot$set\_default\_chat\_id(135717340)</code>
</pre>
<p>
Neste momento já estamos prontos para interagir com o nosso bot!
</p>
</div>
<p>
Os preços da bitcoin são fornecidos pela API da
<a href="https://blinktrade.com/docs/">BlinkTrade</a> que é bem simples
usar: basta pegar o json que a url do código abaixo solta. Aproveito e
dou um tapinha para deixar em forma de data.frame e com a data de
consulta junto.
</p>
<pre class="r"><code>library(jsonlite)
library(tidyverse) safe_fromJSON &lt;- safely(fromJSON, as.numeric(NA)) nova_consulta_list &lt;- safe_fromJSON(&quot;https://api.blinktrade.com/api/v1/BRL/ticker?crypto_currency=BTC&quot;) nova_consulta &lt;- nova_consulta_list$result %&gt;% as.tibble %&gt;% mutate(timestamp = lubridate::now()) nova_consulta
# A tibble: 1 x 9 high vol buy last low pair sell vol_brl timestamp &lt;dbl&gt; &lt;dbl&gt; &lt;dbl&gt; &lt;dbl&gt; &lt;dbl&gt; &lt;chr&gt; &lt;dbl&gt; &lt;dbl&gt; &lt;dttm&gt;
1 14438.21 511.5911 14077.01 14200 13801.04 BTCBRL 14200 7257317 2017-08-18 17:09:44</code></pre>
<p>
<strong>OBS:</strong> Usei o advérbio <code>safely()</code> porque a API
pode engasgar a qualquer momento, fazendo assim o R retornar um erro que
interromperia o acompanhamento do preço.
</p>

<p>
O esqueleto do acompanhador é composto por um loop infinito
(<code>while(TRUE)</code>), um data.frame <code>historico.RData</code>,
um tempo entre uma consulta e outra (30 segundos por padrão) e a
consulta propriamente dita.
</p>
<pre class="r"><code># inicializa o historico.RData
# historico &lt;- nova_consulta
# save(historico, file = &quot;historico.RData&quot;) acompanhar_bitcoin &lt;- function(frequencia = 30) { load(&quot;historico.RData&quot;) # loop infinito while(TRUE) { # pega a cota&#xE7;&#xE3;o do bitcoin brasil (BTCBRL) da API do blinktrade nova_consulta_list &lt;- safe_fromJSON(&quot;https://api.blinktrade.com/api/v1/BRL/ticker?crypto_currency=BTC&quot;) # verifica se a API retornou uma lista if(&quot;list&quot; %in% class(nova_consulta_list$result)) { nova_consulta &lt;- nova_consulta_list$result %&gt;% as.tibble %&gt;% mutate(timestamp = lubridate::now()) # --------------------- # # espa&#xE7;o reservado para as regras! # # --------------------- # guarda a consulta historico &lt;- bind_rows(historico, nova_consulta) save(historico, file = &quot;historico.RData&quot;) } } Sys.sleep(frequencia)
}</code></pre>

<div id="passo-7-regras-para-mensagens-de-telegram" class="section level3">
<p>
Agora é a hora de decidir o que o bot deve nos avisar! Deixei dois
exemplos simples abaixo usando o método <code>bot$sendMessage()</code>,
que como o nome sugere faz o bot enviar mensagem pra gente. Agora, toda
vez que o preço da bitcoin valer menos que R$13.600 ou valer mais que
R$14.600 eu vou ficar sabendo na hora!&lt;/p&gt; &lt;pre class="r"&gt;&lt;code&gt;\# caso o valor da cota&\#xE7;&\#xE3;o atinja algum crit&\#xE9;rio, envia uma mensagem via telegram. if(nova\_consulta$buy
&lt; 13600 & nova\_consulta$last &gt; 13900) { bot$sendMessage('baixa!')
bot*s**e**n**d**M**e**s**s**a**g**e*(*n**o**v**a*<sub>*c*</sub>*o**n**s**u**l**t**a*buy)
} \# ... if(nova\_consulta$buy &gt; 14600 &amp; nova\_consulta$last &lt;
14500) {
bot$sendMessage(&apos;alta!&apos;) bot$sendMessage(nova\_consulta$buy)
}</code>
</pre>
</div>
</div>
</div>
</div>
</div>

