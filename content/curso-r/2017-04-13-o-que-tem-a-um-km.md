+++
title = "Você está a menos de 1 km de um Hambúrguer?"
date = "2017-04-10 20:26:00"
categories = ["curso-r"]
original_url = "http://curso-r.com/blog/2017/04/10/2017-04-13-o-que-tem-a-um-km/"
+++

<p>
Se você estiver no centro de São Paulo, quanto será que você precisa
andar para achar uma hamburgueria? Será que a sua casa fica a menos de 1
km de hospitais, delagacias ou corpo de bombeiros? Neste post, veremos
como utilizar uma das APIs do Google Maps para obter informações de
geolocalização a partir de uma pesquisa simples. Em seguida, vamos gerar
mapas com o pacote <code>leaflet</code> para visualizar os dados
coletados e responder essas perguntas.
</p>
<p>
A API que vamos utilizar para acessar os dados do Google Maps é a
<a href="https://developers.google.com/places/web-service/?hl=pt-br">Google
Places</a>. Para configurá-la, você precisa fazer o seguinte:
</p>
<ol>
<li>
criar um projeto no
<a href="https://console.developers.google.com/iam-admin/projects">Google
APIs</a>;
</li>
<li>
adicionar a <strong>Google Places API Web Service</strong> à sua
biblioteca de APIs;
</li>
<li>
obter uma
<a href="https://support.google.com/googleapi/answer/6158862">chave de
API</a>; e
</li>
<li>
enviar uma requisição.
</li>
</ol>
<p>
Para mais informações sobre os itens 1, 2 e 3, bastar acessar os links
acima. Aqui, vamos focar em como fazer o item 4.
</p>

<p>
A API do Google Places permite fazer
<a href="https://developers.google.com/places/web-service/search">alguns
tipos de buscas</a>, como estabelecimentos específicos próximos a um
local ou dentro de uma região pré-delimitada. Nosso objetivo aqui é
requisitar os dados de todos os estabelecimentos, como hospitais,
delegacias, supermercados, escolas etc, dentro de um raio de busca em
torno de um ponto específico. Neste contexto, a requisição deve ser
feita a partir de um link da forma
</p>
<blockquote>
<p>
<a href="https://maps.googleapis.com/maps/api/place/radarsearch/output?parameters" class="uri">https://maps.googleapis.com/maps/api/place/radarsearch/output?parameters</a>
</p>
</blockquote>
<p>
substituindo <em>output</em> pelo formato da saída, <code>xml</code> ou
<code>json</code>, e <em>parameters</em> pelos parâmetros de busca.
Utilizaremos aqui o formato <code>json</code>, <em>Javascript Object
Notation</em>. Para mais informações sobre JSON, consulte
<a href="http://www.devmedia.com.br/introducao-ao-formato-json/25275">este
link</a>.
</p>
<p>
Utilizaremos as seguintes bibliotecas nesta análise:
</p>
<pre class="r"><code>library(tibble)
library(magrittr)
library(dplyr)
library(stringr)
library(purrr)
library(RCurl)
library(jsonlite)
library(leaflet)</code></pre>
<p>
O que precisamos fazer é criar a url de requisição, acessá-la, guardar
os dados no formato <code>json</code> em um objeto e convertê-lo para um
data frame. A função <code>get\_googlemaps\_data()</code> abaixo faz
exatamente isso. Mais especificamente, ela recebe os parâmetros de
busca, uma chave de API e retorna um data frame com os dados de
geolocalização (latitude e longitude) dos resultados encontrados.
</p>
<ul>
<li>
O argumento <code>keyword=</code> recebe o termo a ser pesquisado, isto
é, se estivermos pesquisando por escolas, esse argumento receberá a
string <code>'escola'</code>.
</li>
<li>
O argumento <code>type=</code> recebe um termo para filtrar os
estabelecimentos pesquisados. Por exemplo: <code>keyword =
'restaurante'</code> e <code>type = 'vegetariano'</code>.
</li>
<li>
Os argumentos <code>central\_lat=</code> e <code>central\_log=</code>
representam, respectivamente, a latitude e a longitude do ponto central
da busca. Os valores <em>default</em> são os do centro da cidade de São
Paulo.
</li>
<li>
O argumento <code>radius=</code> indica o raio máximo de busca. O
<em>default</em> é 15 Km.
</li>
<li>
O argumento <code>key=</code> deve receber a sua chave de API.
</li>
</ul>
<pre class="r"><code>get_googlemaps_data &lt;- function(keyword, type = &quot;&quot;, central_lat = -23.55052, central_log = -46.63331, radius = 15000, key) { basic_url = &quot;https://maps.googleapis.com/maps/api/place/radarsearch/json?&quot; if(type != &quot;&quot;) { type %&lt;&gt;% str_replace_all(&quot; &quot;, &quot;+&quot;) %&gt;% # Os espa&#xE7;os precisam ser str_c(&quot;&amp;type=&quot;, .) # substitu&#xED;dos por &apos;+&apos;. } complete_url &lt;- str_c(basic_url, # Criando a url de requisi&#xE7;&#xE3;o &quot;location=&quot;, # com os par&#xE2;metros de busca. central_lat, &quot;,&quot;, central_log, &quot;&amp;radius=&quot;, radius, type, &quot;&amp;keyword=&quot;, str_replace_all(keyword, &quot; &quot;, &quot;+&quot;), &quot;&amp;key=&quot;, key) json &lt;- RCurl::getURL(complete_url) # Acessando a URL. list_info &lt;- jsonlite::fromJSON(json) # Transformando json em lista. # Guardando a latitude e longitude em um df, assim como o lugar pesquisado. df &lt;- tibble::tibble(lat = list_info$results$geometry$location$lat, long = list_info$results$geometry$location$lng, place = keyword) return(df)
}
</code></pre>
<p>
Com a função <code>get\_googlemaps\_data()</code> em mão, basta rodar o
código <code>get\_googlemaps\_data("mercado", key =
sua\_API\_key)</code> para obter a geolocalização de até 200 mercados em
um raio de até 15 Km do centro de São Paulo. Sim, o limite é de 200
resultados. Não encontrei maneiras de aumentar esse limite.
</p>
<p>
Também podemos utilizar a função <code>purrr:map\_df()</code> para gerar
um data frame com várias buscas. A função <em>map</em> mapeia uma
determinada função em cada elemento de um vetor/lista, retornando um
data frame. Ainda não estamos construindo os mapas.
</p>
<pre class="r"><code>places &lt;- c(&quot;pronto socorro&quot;, &quot;delegacia&quot;, &quot;bombeiros&quot;, &quot;hamburguer&quot;, &quot;pizza&quot;) df_places &lt;- places %&gt;% purrr::map_df(.f = get_googlemaps_data, key = key)</code></pre>
<p>
Às vezes, a requisição pode retornar com algum erro. Não consegui
descobrir o porquê isso acontece. Nestes casos, a função
<code>get\_googlemaps\_data()</code> também retornará um erro,
provavelmente na construção do data frame. Se isso acontecer, basta
rodar a função novamente, gerando uma nova requisição.
</p>

<p>
Para construir os mapas, vamos utilizar a função
<code>leaflet::leaflet()</code>. A ideia é, para cada ponto da pesquisa,
adicionar um círculo de raio igual a 1 Km. Dessa forma, se você estiver
fora desses círculos, quer dizer que você estará a mais de um quilômetro
de um dos estabelecimentos pesquisados. Veja os exemplos a seguir.
</p>
<p>
Eu pesquisei por “pronto socorro” porque a pesquisa hospitais também
resulta em hospitais veterinários. Um desafio para quem for reproduzir a
análise: coletar apenas a geolocalização de hospitais públicos.
</p>
<pre class="r"><code>library(leaflet)
df_places %&gt;% dplyr::filter(place == &quot;pronto socorro&quot;) %&gt;% leaflet %&gt;% addTiles() %&gt;% addCircles(lng = ~long, lat = ~lat, weight = 5, radius = 1000, color = &quot;blue&quot;, fillOpacity = 0.5)</code></pre>

<pre class="r"><code>df_places %&gt;% dplyr::filter(place == &quot;delegacia&quot;) %&gt;% leaflet %&gt;% addTiles() %&gt;% addCircles(lng = ~long, lat = ~lat, weight = 5, radius = 1000, color = &quot;blue&quot;, fillOpacity = 0.5)</code></pre>

<pre class="r"><code>df_places %&gt;% dplyr::filter(place == &quot;delegacia&quot;) %&gt;% leaflet %&gt;% addTiles() %&gt;% addCircles(lng = ~long, lat = ~lat, weight = 5, radius = 1000, color = &quot;blue&quot;, fillOpacity = 0.5)</code></pre>

<p>
Repare que o único local na região mais central de SP em que você pode
ficar a mais de um quilômetro de uma hamburgueria é no meio do parque
Ibirapuera.
</p>
<pre class="r"><code>df_places %&gt;% dplyr::filter(place == &quot;hamburguer&quot;) %&gt;% leaflet %&gt;% addTiles() %&gt;% addCircles(lng = ~long, lat = ~lat, weight = 5, radius = 1000, color = &quot;blue&quot;, fillOpacity = 0.5)</code></pre>

<p>
Se a busca devolvesse todos os resultados possíveis, esse mapa teria um
círculo azul com ~15 km de raio formado por milhares de círculos
menores. =D
</p>
<pre class="r"><code>df_places %&gt;% dplyr::filter(place == &quot;pizza&quot;) %&gt;% leaflet %&gt;% addTiles() %&gt;% addCircles(lng = ~long, lat = ~lat, weight = 5, radius = 1000, color = &quot;blue&quot;, fillOpacity = 0.5)</code></pre>
<p>
Sem dúvidas, a utilização dos dados aqui foi bem superficial, apenas
ilustrativa. O ideal seria juntar essas informações de geolocalização
com dados de criminalidade, saúde pública, socioeconômicos, consumo etc.
Dependendo da disponibilidade de dados, há espaço para muitas análises
interessantes utilizando essas informações do Google Maps. Com certeza
voltaremos neste assunto em posts futuros. =)
</p>
<p>
Comentários? Sugestões? Críticas? Você está a menos de um quilômetro dos
comentários! Deixe a sua mensagem!
</p>

