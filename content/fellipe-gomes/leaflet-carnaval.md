+++
title = "leaflet carnaval"
date = "2018-02-01"
categories = ["fellipe-gomes"]
original_url = "https://gomesfellipe.github.io/post/2018-02-01-leaflet-carnaval/leaflet-carnaval/"
+++

<p id="main">
<article class="post">
<header>
<p>
Carnaval esta começando e muita gente quer saber: "Onde tem bloco??"
Para ajudar a responder essa pergunta e orientar os foliões hoje vou
mostrar como podemos obter referencias geograficas a partir de endereços
e criar mapas interativos usando R!
</p>

</header>
<a href="https://gomesfellipe.github.io/post/2018-02-01-leaflet-carnaval/leaflet-carnaval/" class="image featured">
<img src="https://gomesfellipe.github.io/img/2018/02/carnaval.png" alt="">
</a>
<p>
Fevereiro começando e o carnaval já está ai, especialmente se você mora
no Rio de Janeiro já deve ter passado por algum bloco e a pergunta que
todo mundo faz no carnaval pelo menos uma vez é: “Onde tem bloco?”.
</p>
<p>
Baseado nessa pergunta resolvi fazer esse post especial, vamos utilizar
os pacotes
<a href="https://cran.r-project.org/package=ggmap"><code>ggmap</code></a>
e
<a href="https://cran.r-project.org/package=leaflet"><code>leaflet</code></a>
para buscar as coordenadas geográficas do endereço dos blocos e
representa-los num mapa agradável de navegar
</p>
<p>
Além disso utilizaremos o pacote
<a href="https://cran.r-project.org/package=leaflet.extras"><code>leaflet.extras</code></a>
que conta com muitas opções para personaliza-lo.
</p>
<p>
Ao final do post você estará pronto para criar um mapa como (ou muito
melhor) que esse:
</p>

<p>
Existem diversas maneiras de se descobrir via R informações como: aonde
estão os blocos de carnaval, os endereços que ocorrem, suas coordenadas
geográficas etc mas por conveniência vou utilizar essa base de dados
obtida
<a href="http://www.radiosaara.com.br/noticias/carnaval-2018-lista-completa-blocos/">neste
link</a> com informações sobre os blocos que irão ocorrer no Rio de
Janeiro que já foi disponibilizada como uma planilha de Excel.
</p>
<p>
Caso tenha interesse em praticar a busca por outras localidades, talvez
<a href="http://curso-r.com/blog/2017/04/10/2017-04-13-o-que-tem-a-um-km/">este
post do blog curso-r sobre a API de busca do Google</a> e
<a href="https://stackoverflow.com/questions/37117472/loop-for-reverse-geocoding-in-r">este
tópico no stackoverflow sobre como fazer a busca por localização baseado
nas cordenadas (inverso da <code>geocode()</code> com
<code>revgeocode()</code>)</a> possam ser úteis)
</p>
<pre class="r"><code>library(readxl)
base &lt;- read_excel(&quot;Agenda_BL_Rua_Carnaval_Rio-2018_Imprensa.xlsx&quot;)</code></pre>
<p>
Uma vez obtida a base de dados, os nomes das variáveis serão ajustadas
de tal forma que possibilite sua manipulação. Para tal será utilizada a
função <code>ajustar\_nomes()</code> apresentada em um post que falo um
pouco sobre
<a href="https://gomesfellipe.github.io/post/2017-12-17-string/string/">Manipulação
de strings e text mining</a>.
</p>
<pre class="r"><code>names(base)=ajustar_nomes(names(base));names(base)</code></pre>
<pre><code>## [1] &quot;bloco&quot; &quot;bairro&quot; ## [3] &quot;regiao&quot; &quot;data&quot; ## [5] &quot;data_relativa&quot; &quot;concentracao&quot; ## [7] &quot;desfile&quot; &quot;final&quot; ## [9] &quot;local_da_concentracao&quot; &quot;percurso&quot; ## [11] &quot;publico_estimado&quot; &quot;ano_do_primeiro_desfile&quot;
## [13] &quot;lon&quot; &quot;lat&quot;</code></pre>
<p>
A seguir a limpeza das strings que carregam a informação de onde será
cada bloco também precisa passar por um processo de “limpeza” para
possibilitar a busca pelas localizações com a função
<code>geocode()</code>.
</p>
<p>
Para esse tipo de limpeza geralmente o uso de
<a href="https://pt.wikipedia.org/wiki/Express%C3%A3o_regular">regex/expressão
regular</a> (que nada mais é que uma ótima forma de identificar cadeias
de strings) facilita muito a forma como o computador entende e processa
o que desejamos executar.
</p>
<p>
Além de todo material gratuito disponível na internet com uma
<a href="https://www.google.com.br/search?q=regex&amp;oq=regex&amp;aqs=chrome.0.69i59l2j0l4.1259j0j7&amp;sourceid=chrome&amp;ie=UTF-8">simples
busca no Google</a>, para aprender a utilizar regex em suas aplicações
de text mining
<a href="http://www.cbs.dtu.dk/courses/27610/regular-expressions-cheat-sheet-v2.pdf">essa
Cheatsheet</a> pode ser útil para uma consulta rápida.
</p>
<p>
Veja a segui um exemplo de limpeza simples:
</p>
<pre class="r"><code>base$local_da_concentracao=base$local_da_concentracao%&gt;% stringr::str_trim() %&gt;% #Remove espa&#xE7;os em branco sobrando stringr::str_to_lower() %&gt;% #Converte todas as strings para minusculo rm_accent() %&gt;% #Remove acentos com a funcao dispon&#xED;vel em * stringr::str_replace_all(&quot;[/&apos; &apos;.()]&quot;, &quot; &quot;) %&gt;% #Substitui os caracteres especiais por &quot; &quot; stringr::str_replace_all(&quot;_+&quot;, &quot; &quot;) %&gt;% #Substitui os caracteres especiais por &quot; &quot; stringr::str_replace(&quot;_$&quot;, &quot; &quot;)%&gt;% #Remove o caracter especiais stringr::str_replace(&quot;, esquina.*&quot;,&quot;&quot;)%&gt;% #Remove a palavra &quot;esquina&quot; e tudo que vier depois dela stringr::str_replace(&quot;n[&#xBA;&#xB0;].*&quot;,&quot;&quot;)%&gt;% #Remove as strings &quot;n&#xBA;&quot; e &quot;n&#xB0;&quot; e tudo que vier depois delas stringr::str_replace(&quot;em frente a.*&quot;,&quot;&quot;)%&gt;% #Remove a senten&#xE7;a &quot;em frente a&quot; e tudo que vier depois dela stringr::str_replace_all(&quot;[0-9]&quot;,&quot;&quot;)%&gt;% #Remove numeros stringr::str_replace_all(&quot;[:punct:]&quot;,&quot;&quot;)%&gt;% #Remove pontuacao stringr::str_c(&quot; rio de janeiro&quot;) #Inclui a string &quot;rio de janeiro&quot;, que sera util em diante
base=na.omit(base) #Remove linhas que contenham NA</code></pre>
<ul>
<li>
<a href="https://pt.stackoverflow.com/questions/46473/remover-acentos">link
para página do stackoverflow sobre a função
<code>rm\_accent()</code></a>
</li>
</ul>
<p>
Feita a limpeza completa da base agora vamos criar uma nova coluna com a
tag que irá aparecer no mapa:
</p>
<pre class="r"><code>for(i in 1:nrow(base)){
base$label[i]=str_c(&quot;Bloco: &quot;,base$bloco[i],&quot; - &quot;,&quot;Bairro: &quot;,base$bairro[i],&quot; - &quot;,&quot;Regiao: &quot;, base$regiao, &quot;Data: &quot;, base$data[i], &quot; - &quot;, &quot;Concentra&#xE7;&#xE3;o&quot;, str_sub(base$concentracao[i], start = 11) )
}</code></pre>

<p>
Este pacote além de possuir uma coleção de funções para visualizar dados
espaciais e modelos em cima de mapas estáticos de várias fontes on-line
(por exemplo, Google Maps e Stamen Maps), inclui ferramentas comuns a
essas tarefas, incluindo funções de geolocalização e roteamento.
</p>
<p>
Utilizaremos a função de geolocalização com um loop pelos endereços para
obter a latitude e longitude de cada endereço e adiciona-os a base de
dados em novas colunas lat e lon, veja:
</p>
<pre class="r"><code>suppressMessages(library(ggmap)) for(i in 1:nrow(base)){ Print(&quot;Buscando...&quot;) result &lt;- geocode(base$local_da_concentracao[i], output = &quot;latlona&quot;, source = &quot;google&quot;) base$lon[i] &lt;- as.numeric(result[1]) base$lat[i] &lt;- as.numeric(result[2])
}</code></pre>
<p>
Obtendo algumas coordenadas geográficas para marcar no mapa:
</p>
<pre class="r"><code>lon_copacabana=geocode(&quot;Av. Atlantica&quot;)[1]
lat_copacabana=geocode(&quot;Av. Atlantica&quot;)[2]
lon_ipanema=geocode(&quot;Av. Vieira Souto&quot;)[1]
lat_ipanema=geocode(&quot;Av. Vieira Souto&quot;)[2]
lon_lapa=geocode(&quot;Rua da Lapa&quot;)[1]
lat_lapa=geocode(&quot;Rua da Lapa&quot;)[2]
lon_paqueta=geocode(&quot;Ilha de Paqueta&quot;)[1]
lat_paqueta=geocode(&quot;Ilha de Paqueta&quot;)[2]</code></pre>
<p>
Agora basta utilizar o pacote <code>leaflet</code> em conjunto com o
pacote <code>leaflet.extras</code> para criar o mapa:
</p>
<p>
(Mais detalhes de como formatar seu mapa estão disponíveis na
<a href="https://github.com/bhaskarvk/leaflet.extras">página do pacote
no github</a>)
</p>
<pre class="r"><code>suppressMessages(library(leaflet))
library(leaflet.extras)
base%&gt;% filter(lat&lt;(-7)&amp;lat&lt;(-22)&amp;lon&gt;(-57)&amp;lon&lt;(-43.1))%&gt;% #Removendo algumas cordenadas equivocadas leaflet() %&gt;% #carrega o leaflet addTiles() %&gt;% #adiciona as camadas de mapas de acordo com o zoom addMarkers(lng = ~lon, lat = ~lat,popup=~label, #mapeia a base de dados de acordo com as respectivas lat e lon clusterOptions = markerClusterOptions())%&gt;% addResetMapButton() %&gt;% #Adiciona bot&#xE3;o para resetar mapa addPulseMarkers( lng=lon_copacabana , lat=lat_copacabana, #Endere&#xE7;o da orla de copacabana label=&apos;Praia de Copacabana&apos;, icon = makePulseIcon(heartbeat = 0.5))%&gt;% addPulseMarkers( lng=lon_ipanema , lat=lat_ipanema, #Endere&#xE7;o da orla de ipanema label=&apos;Praia de Ipanema&apos;, icon = makePulseIcon(heartbeat = 0.5))%&gt;% addPulseMarkers( lng=lon_lapa , lat=lat_lapa, #Endere&#xE7;o da lapa label=&apos;Lapa&apos;, icon = makePulseIcon(heartbeat = 0.5))%&gt;% addPulseMarkers( lng=lon_paqueta , lat=lat_paqueta, #Endere&#xE7;o da ilha de paquet&#xE1; label=&apos;Ilha de Paquet&#xE1;&apos;, icon = makePulseIcon(heartbeat = 0.5))</code></pre>
<p>
Caso tenha interesse em consultar as informações da base de dados dos
blocos que vão ocorrer no Rio de Janeiro para saber qual o bloco mais
próximo de você e aproveitar o carnaval carioca a consulta pode ser
feita a seguir:
</p>
<iframe src="https://gomesfellipe.github.io/post/2018-02-01-leaflet-carnaval/d1/index.html" width="100%" height="500" class>
</iframe>

<p>
Além da combinação de elementos de circo, fantasias e toda a festa na
rua que permite às pessoas perderem um pouco sua individualidade
cotidiana e experimentarem um sentido diferente de unidade social, o
carnaval envolve também a produção cultural e desfile de escolas de
samba!
</p>
<p>
Dado esses diferentes aspectos de folia que envolvem o carnaval, com um
olhar mais analítico a onipresença dos dados pode ser notada e por vezes
conter informações relevantes.
</p>
<p>
Espero que o post tenha sido útil e desejo um bom carnaval a todos!
</p>

<footer>
</footer>
</article>
<article class="post">
<a href="https://disqus.com/" class="dsq-brlink">comments powered by
</a>
</article>
</p>

