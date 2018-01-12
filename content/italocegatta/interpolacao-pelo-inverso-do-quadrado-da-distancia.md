+++
title = "Interpolação pelo inverso do quadrado da distância"
date = "2017-04-30"
categories = ["italocegatta"]
original_url = "https://italocegatta.github.io/interpolacao-pelo-inverso-do-quadrado-da-distancia/"
+++

<p>
É comum quando temos um determinado valor distribuído espacialmente e
queremos estimá-lo para um ponto específico. Existem inúmeras formas de
se chegar nesta estimativa, mas quero mostrar apenas uma neste post. O
objetivo é estimar o quanto choveu em Itapetininga-SP, a partir de dados
de chuva de outras 6 cidades próximas. Utilizaremos para isso os dados
das estações automáticas do
<a href="http://www.inmet.gov.br/portal/index.php?r=estacoes/estacoesAutomaticas">INMET</a>.
</p>
<p>
Primeiro, vamos importar e visualizar os dados que temos disponível.
</p>
<pre class="r"><code>if (!require(&quot;pacman&quot;)) install.packages(&quot;pacman&quot;)
pacman::p_load(readr, dplyr, leaflet)</code></pre>
<pre class="r"><code># importa o arquivo os dados de chuva
dados &lt;- read_csv2( &quot;https://raw.githubusercontent.com/italocegatta/italocegatta.github.io_source/master/content/dados/chuva_inmet.csv&quot;
) dados</code></pre>
<pre><code>## # A tibble: 6 x 4
## cidade lon lat p
## &lt;chr&gt; &lt;dbl&gt; &lt;dbl&gt; &lt;dbl&gt;
## 1 Sorocaba -47.58555 -23.42603 27.0
## 2 Itapeva -48.88582 -23.98192 33.4
## 3 Sao Miguel Arcanjo -48.16482 -23.85202 34.6
## 4 Avare -48.94100 -23.10175 18.2
## 5 Piracicaba -47.62332 -22.70313 30.8
## 6 Barra Bonita -48.55757 -22.47121 42.8</code></pre>
<p>
O mapa a seguir mostra o total de chuva resgistrado pela estação
meteorológica de cada cidade no dia 26/04/2017. Nosso objetivo é estimar
o quanto choveu em Itapetininga utilizando a interpolação pelo inverso
do quadrado da distância ou IDW (Inverse Distance Weighting).
</p>
<pre class="r"><code>leaflet(dados) %&gt;% addTiles() %&gt;% addMarkers(-48.0530600, -23.5916700) %&gt;% addCircleMarkers( ~lon, ~lat, radius = ~p * 0.8, label = ~as.character(p), popup = ~cidade, fillOpacity = 0.6, labelOptions = labelOptions( style = list(&quot;color&quot; = &quot;white&quot;), offset = c(5, -10), noHide = TRUE, textOnly = TRUE, direction = &quot;bottom&quot; ) )</code></pre>
<p>
A expressão que define o método é dada abaixo. Basicamente considera-se
o valor de cada vizinho ponderado pelo inverso da distância entre ele e
o ponto de interesse. Assim, vizinhos distantes contribuem com menos
peso para o valor final que vizinhos mais próximos.
</p>
<p>
<img src="http://bit.ly/2oN3IlI" alt="x_{p} =\frac{\sum_{i=1}^n(\frac{1}{d_{i}^{2}}\times x_{i})}{\sum_{i=1}^n(\frac{1}{d_{i}^{2}})}" width="153">
</p>
<p>
onde: xp = valor interpolado; xi = valor da i-ésimo ponto vizinho; di =
distância entre o i-ésimo ponto de vizinho e o ponto de interesse.
</p>
<p>
Agora que já definimos o método, vamos começar os cálculos. O primeiro
valor calculado será a distância entre os pontos. Utilizaremos a formula
de Haversine que retorna a distâncias entre dois pontos de uma esfera a
partir de suas latitudes e longitudes.
</p>
<pre class="r"><code>haversine &lt;- function(lon1, lat1, lon2, lat2) { # converte graus pra radiano rad &lt;- pi/180 # raio medio da terra no equador em km R &lt;- 6378.1 dlon &lt;- (lon2 - lon1) * rad dlat &lt;- (lat2 - lat1) * rad a &lt;- (sin(dlat/2))^2 + cos(lat1 * rad) * cos(lat2 * rad) * (sin(dlon/2))^2 c &lt;- 2 * atan2(sqrt(a), sqrt(1 - a)) d &lt;- R * c # distancia em km return(d)
}</code></pre>
<pre class="r"><code>dist &lt;- dados %&gt;% mutate(d_itape = haversine(lon, lat, -48.0530600, -23.5916700)) dist</code></pre>
<pre><code>## # A tibble: 6 x 5
## cidade lon lat p d_itape
## &lt;chr&gt; &lt;dbl&gt; &lt;dbl&gt; &lt;dbl&gt; &lt;dbl&gt;
## 1 Sorocaba -47.58555 -23.42603 27.0 51.16089
## 2 Itapeva -48.88582 -23.98192 33.4 95.30342
## 3 Sao Miguel Arcanjo -48.16482 -23.85202 34.6 31.13972
## 4 Avare -48.94100 -23.10175 18.2 105.87726
## 5 Piracicaba -47.62332 -22.70313 30.8 108.25070
## 6 Barra Bonita -48.55757 -22.47121 42.8 135.01301</code></pre>
<p>
O cálculo do IDW é relativamente simples, basta reproduzir a expressão
do método.
</p>
<pre class="r"><code>idw &lt;- function(x, dist, na.rm = TRUE) { s1 &lt;- sum(x / dist^2, na.rm = na.rm) s2 &lt;- sum(1 / dist^2, na.rm = na.rm) return(s1 / s2)
}</code></pre>
<pre class="r"><code>dados_itape &lt;- dist %&gt;% add_row( ., cidade = &quot;Itapetininga&quot;, lon = -48.0530600, lat = -23.5916700, p = round(idw(.$p, .$d_itape), 1) ) dados_itape</code></pre>
<pre><code>## # A tibble: 7 x 5
## cidade lon lat p d_itape
## &lt;chr&gt; &lt;dbl&gt; &lt;dbl&gt; &lt;dbl&gt; &lt;dbl&gt;
## 1 Sorocaba -47.58555 -23.42603 27.0 51.16089
## 2 Itapeva -48.88582 -23.98192 33.4 95.30342
## 3 Sao Miguel Arcanjo -48.16482 -23.85202 34.6 31.13972
## 4 Avare -48.94100 -23.10175 18.2 105.87726
## 5 Piracicaba -47.62332 -22.70313 30.8 108.25070
## 6 Barra Bonita -48.55757 -22.47121 42.8 135.01301
## 7 Itapetininga -48.05306 -23.59167 32.1 NA</code></pre>
<p>
Muito bom, agora vamos retornar ao mapa e adicionar o quanto choveu em
Itapetiniga, de acordo com a interpolação por IDW.
</p>

