+++
title = "Analisando o mercado de cryptomoedas com R"
date = "2017-12-04"
categories = ["fellipe-gomes"]
original_url = "https://gomesfellipe.github.io/post/analisando-o-mercado-de-cryptomoedas-com-r/"
+++

<p id="main">
<article class="post">
<header>
</header>
<a href="https://gomesfellipe.github.io/post/analisando-o-mercado-de-cryptomoedas-com-r/" class="image featured">
<img src="https://gomesfellipe.github.io/img/2017/12/cryptomoedas-R.png" alt="">
</a>
<img src="https://gomesfellipe.github.io/img/2017-12-04-analisando-o-mercado-de-cryptomoedas-com-r/imagem1.png">

<p>
Quem acompanha os jornais já deve ter notado que o mercado de
cryptomoedas vêm crescendo rapidamente. Grandes canais de informação já
abordam o assunto. Uma breve pesquisa no Google já nos retorna
<a href="http://g1.globo.com/jornal-da-globo/noticia/2016/07/bitcoin-moeda-virtual-se-populariza-no-brasil-e-tem-valorizacao-recorde.html">notícia
na globo</a>, notícia no
<a href="http://forbes.uol.com.br/tag/bitcoin/">site da Forbes</a>
dentre muitos outros.
</p>
<p>
Além disso sua <a href="http://dolarhoje.com/bitcoin-hoje/">cotação</a>
já pode ser acompanhada nos maiores sites de busca do mercado
financeiro.
</p>
<p>
Estamos diante de muitas novidades que vêm surgindo exponencialmente na
humanidade, talvez seja interessante buscar entender e desfrutar como a
programação pode nos ajudar nessa experiência relacionada a temas tão
recentes.
</p>
<p>
Portanto surge a pergunta que vem a tona: como o R pode nos ajudar a
cryptomoedas?
</p>
<p>
Vejamos o que o que encontramos no CRAN..
</p>

<p>
Tem disponível no <a href="https://cran.r-project.org/">CRAN</a> o
pacote
<a href="https://cran.r-project.org/web/packages/coinmarketcapr/index.html">coinmarketcapr</a>
que nos permite extrair e monitorar o preço e o limite de mercado das
cryptomoedas da API do
<a href="https://coinmarketcap.com/">coinmarketcap.com</a>
</p>
<p>
Primeiramente precisamos instalar o pacote:
</p>
<pre class="r"><code>install.packages(&quot;coinmarketcapr&quot;) library(coinmarketcapr)</code></pre>
<p>
O pacote conta com a função <code>plot\_top\_5\_currencies()</code> que
já apresenta de brinde um gráfico de barras com as 5 principais
cryptomoedas do mercado, veja:
</p>
<pre class="r"><code>plot_top_5_currencies()</code></pre>
<img src="https://gomesfellipe.github.io/img/2017-12-04-analisando-o-mercado-de-cryptomoedas-com-r/foto1.png">

<p>
Os resultados ficam disponíveis para quem quiser interpretar. É
importante notar que isso não nos da a imagem de como o mercado está
dividido entre várias cryptomoedas, então vamos obter os dados completos
de várias cryptomoedas:
</p>
<pre class="r"><code>mercado_hoje &lt;- get_marketcap_ticker_all() head(mercado_hoje[,1:8])</code></pre>
<img src="https://gomesfellipe.github.io/img/2017-12-04-analisando-o-mercado-de-cryptomoedas-com-r/foto3.png">

<p>
Após extrair os dados completos de várias cryptomoedas, vamos visualizar
essa distribuição através de um <code>treemap</code> com os códigos:
</p>
<pre class="r"><code>library(treemap) base &lt;- na.omit(mercado_hoje[,c(&apos;id&apos;,&apos;market_cap_usd&apos;)]) base$market_cap_usd &lt;- as.numeric(base$market_cap_usd) base$formatted_market_cap &lt;- paste0(base$id,&apos;\n&apos;,&apos;$&apos;,format(base$market_cap_usd,big.mark = &apos;,&apos;,scientific = F, trim = T)) treemap(base, index = &apos;formatted_market_cap&apos;, vSize = &apos;market_cap_usd&apos;, title = &apos;Cryptocurrency Market Cap&apos;, fontsize.labels=c(12, 8), palette=&apos;RdYlGn&apos;)</code></pre>
<img src="https://gomesfellipe.github.io/img/2017-12-04-analisando-o-mercado-de-cryptomoedas-com-r/foto2.png">

<p>
Vou deixar as interpretações para os analistas de mercado, mas como um
cientista de dados, muitos (muitos mesmo) insights podem ser extraídos
dos dados acima e pode ser interessante analisar esse mercado
</p>

<p>
O
<a href="https://cran.r-project.org/web/packages/jsonlite/index.html">pacote
jsonlite disponível no CRAN</a> trás série de recursos flexíveis,
robustos e de alto desempenho para trabalhar o R com JSON conjuntamente.
O pacote é capaz de interagir com API da Web e isso vai ser o recurso
que precisamos aqui.
</p>
<p>
Trazendo o foco para os Bitcoins, existe mais de uma maneira de se
extrair os dados do mercado que possam trazer grandes insights. Vamos
conferir aqui como este pacote pode ajudar nesta tarefa.
</p>
<p>
Inicialmente precisamos instalar e carregar o pacote:
</p>
<pre class="r"><code>#install.packages(&quot;jsonlite&quot;) library(jsonlite) suppressMessages(library(tidyverse)) #Para manipula&#xE7;&#xE3;o de dados</code></pre>
<p>
Com o pacote carregado já podemos realizar uma consulta diretamente de
dentro do R com o comando <code>safe\_fromJSON()</code>.
</p>
<p>
Os preços da bitcoin são fornecidos pela API da
<a href="https://blinktrade.com/">BlinkTrad</a> que é bem simples usar,
basta pegar o json que a url do código abaixo solta.
</p>
<p>
Aproveito e dou um tapinha para deixar em forma de data.frame e com a
data de consulta junto.
</p>
<pre class="r"><code>safe_fromJSON = safely(fromJSON, as.numneric(NA)) nova_consulta_list = safe_fromJSON(&quot;http://api.blinktrade.com/api/v1/BRL/ticker?crypto_currency=BTC&quot;) nova_consulta = nova_consulta_list$result %&gt;% as.tibble %&gt;% mutate(timestamp = lubridate::now()) nova_consulta</code></pre>
<p>
Existe um universo de infinitas possibilidades para acompanhar estes
dados, trago aqui um loop infinito <code>(while(TRUE))</code> composto
por um , um data.frame histórico.RData, um tempo entre uma consulta e
outra (30 segundos por padrão) e a consulta propriamente dita. Veja:
</p>
<pre class="r"><code>#Inicializa o historico.RData historico = nova_consulta save(historico, file = &quot;historico.RData&quot;)</code></pre>
<p>
Dando início ao loop:
</p>
<pre class="r"><code> #loop infinito while(TRUE){ #pega a cotacao do bitcoin brasil (BTCBRL) da API do blinktrade nova_consulta_list = safe_fromJSON(&quot;http://api.blinktrade.com/api/v1/BRL/ticker?crypto_currency=BTC&quot;) #verifica se a API retornou uma lista if(&quot;list&quot; %in% class(nova_consulta_list$result)){ nova_consulta = nova_consulta_list$result %&gt;% as.tibble %&gt;% mutate(timestamp = lubridate::now()) # # # espaco reservado para as regras! # # #guarda a consulta historico = bind_rows(historico, nova_consulta) save(historico, file = &quot;historico.RData&quot;) } #condicoes #Exemplo: #if(nova_consulta$buy &gt; 14600 &amp; nova_consulta$last &lt; 14500){ # #Fazer alguma coisa # # #} }</code></pre>
<p>
Também podemos acompanhar graficamente incluindo um gráfico dentro do
loop, veja:
</p>
<pre class="r"><code>while(TRUE){ #pega a cotacao do bitcoin brasil (BTCBRL) da API do blinktrade nova_consulta_list = safe_fromJSON(&quot;http://api.blinktrade.com/api/v1/BRL/ticker?crypto_currency=BTC&quot;) #verifica se a API retornou uma lista if(&quot;list&quot; %in% class(nova_consulta_list$result)){ nova_consulta = nova_consulta_list$result %&gt;% as.tibble %&gt;% mutate(timestamp = lubridate::now()) # # # espaco reservado para as regras! # # #guarda a consulta historico = bind_rows(historico, nova_consulta) save(historico, file = &quot;historico.RData&quot;) } #Cria um gr&#xE1;fico; ggplot(historico %&gt;% gather(indicador, valor, high, low, buy, sell, last))+ geom_line(aes(x=timestamp, y=valor, color=indicador)) #condicoes #if(nova_consulta$buy &gt; 14600 &amp; nova_consulta$last &lt; 14500){ # # Fazer alguma coisa # #} }</code></pre>
<p>
Este gráfico retornará algo como:
</p>
<img src="https://gomesfellipe.github.io/img/2017-12-04-analisando-o-mercado-de-cryptomoedas-com-r/foto4.png">

<p>
Este gráfico será atualizado em tempo real!
</p>

<footer>
<ul class="stats">
<li>
Categories
</li>
<li>
<a href="https://gomesfellipe.github.io/categories/r">R</a>
</li>
<li>
<a href="https://gomesfellipe.github.io/categories/utilidades">utilidades</a>
</li>
<li>
<a href="https://gomesfellipe.github.io/categories/bitcoin">bitcoin</a>
</li>
</ul>
</footer>
</article>
<article class="post">
<a href="https://disqus.com/" class="dsq-brlink">comments powered by
</a>
</article>
</p>

