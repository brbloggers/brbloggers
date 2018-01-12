+++
title = "Tutorial de Globo 3D Interativo em R"
date = "2017-02-08"
categories = ["mind-and-iron"]
original_url = "http://ctlente.com/pt/interactive-globe/"
+++

<p>
Eu sou viciado em vizualizações geográficas; eu acho que ela realmente
colocam os dados em perspectiva, como se cada ponto tivesse seu lugar.
Neste tutorial vou te ensinar a criar um globo 3D interativo bastante
interessante com o pacote <code>threejs</code>.
</p>
<p>
Nosso objetivo é visualizar o comércio do Japão com arcos em uma
animação tridimensional da Terra. A base de dados que utilizaremos
(<a href="https://www.kaggle.com/zanjibar/japan-trade-statistics/kernels">Japan
Trade Statistics</a>, por
<a href="https://www.kaggle.com/zanjibar">Tadashi Nagao</a>) é um ótimo
exemplo do que encontramos no dia-a-dia: os dados têm informação apenas
sobre os países (seus nomes registrados de forma desordenada) e têm não
tem absolutamente nenhum dado sobre suas coordenadas.
</p>
<p>
Criaremos a visualização em 3 passos: pegar as coordenadas da capital de
cada país, converter os nomes dos países para um formado padrão e criar
o globo em si.
</p>

<p>
Nossa primeira tarefa é importar os dados.
</p>
<p>
Eu carreguei os dados com informação do comércio japonês, carreguei a
tabela com a relação país/código e então juntei as duas em um <em>data
frame</em>. Eu também converti os nomes das colunas para caixa baixa e
agrupei a tabela por país (somando os valores de todo o comércio com
cada país). Nada disso é mostrado aqui por ser muito pouco geral, mas
este foi o resultado:
</p>
<center>
<table>
<thead>
</thead>
<tbody>
<tr class="odd">
<td>
Afghanistan
</td>
<td>
130
</td>
<td>
8764947
</td>
</tr>
<tr class="even">
<td>
Albania
</td>
<td>
229
</td>
<td>
1473130
</td>
</tr>
<tr class="odd">
<td>
Algeria
</td>
<td>
503
</td>
<td>
59532804
</td>
</tr>
<tr class="even">
<td>
American\_Oceania
</td>
<td>
622
</td>
<td>
4914
</td>
</tr>
<tr class="odd">
<td>
American\_Samoa
</td>
<td>
621
</td>
<td>
276510
</td>
</tr>
<tr class="even">
<td>
Andorra
</td>
<td>
212
</td>
<td>
29382
</td>
</tr>
</tbody>
</table>
</center>
<p>
Depois desse setup inicial, podemos seguir em frente e pegar as
coordenadas da capital de cada país com o pacote <code>maps</code>
(vamos usar as coordenadas das capitais como os “pontos de aterrissagem”
dos arcos no globo 3D). Aqui vou carregar a tabela
<code>world.cities</code> e selecionar os nomes dos países, suas
capitais e suas coordenadas.
</p>
<pre><code># Pegar as coordenadas de cada capital
capitals &lt;- world.cities %&gt;% filter(capital == 1) %&gt;% transmute( country_name = country.etc, lat = lat, long = long ) %&gt;% rbind(c(&quot;Hong Kong&quot;, 22.39, 114.1))</code></pre>
<p>
Obs.: Não nos deixemos levar pela geopolítica, mas eu adicionei Hong
Kong manualmente porque aparentemente ela é/não é parte da China, então
ela não está na tabela <code>world.cities</code>…
</p>
<p>
Essa é a cara da tabela <code>capitals</code>:
</p>
<center>
<table>
<thead>
</thead>
<tbody>
<tr class="odd">
<td>
Jordan
</td>
<td>
31.95
</td>
<td>
35.93
</td>
</tr>
<tr class="even">
<td>
United Arab Emirates
</td>
<td>
24.48
</td>
<td>
54.37
</td>
</tr>
<tr class="odd">
<td>
Nigeria
</td>
<td>
9.18
</td>
<td>
7.17
</td>
</tr>
<tr class="even">
<td>
Ghana
</td>
<td>
5.56
</td>
<td>
-0.2
</td>
</tr>
<tr class="odd">
<td>
Pitcairn
</td>
<td>
-25.05
</td>
<td>
-130.1
</td>
</tr>
<tr class="even">
<td>
Ethiopia
</td>
<td>
9.03
</td>
<td>
38.74
</td>
</tr>
</tbody>
</table>
</center>

<p>
Preste atenção em como “American Samoa” and “United Arab Emirates” estão
escritos nas duas tabelas acima (esse é o principal motivo pelo qual eu
as incluí). Eles não estão formatados da mesma maneira.
</p>
<p>
Eu vou te poupar dos detalhes, mas esta é a parte mais difícil de
trabalhar com dados geográficos: os nomes são um saco. As duas tabelas
com as quais temos que trabalhar têm os nomes formatados de maneiras
muito diferentes, então temos que padronizá-los.
</p>
<p>
Vamos fazer isso com o pacote <code>countrycodes</code>, mais
especificamente com a base <code>countrycode\_data</code>. Ela têm uma
coluna com comandos regex que conseguem encontrar o nome de cada país
quase independentemente da forma que ele estiver escrito. Primeiramente
eu faço uma pequena limpeza em <code>trades$country\_name</code>, mas
depois é simple assim:
</p>
<pre class="r"><code># Pegar o regex de cada pa&#xED;s
regex &lt;- countrycode::countrycode_data$country.name.en.regex
# Pegar a correspond&#xEA;ncia entre os pa&#xED;ses de &apos;totals&apos; e
# &apos;capitals&apos;
trades_capitals &lt;- as_tibble(cbind( regex, trades_countries = match_country(regex, trades$country_name), capitals_countries = match_country(regex, capitals$country_name)
))</code></pre>
<p>
No código acima estou omitindo a função <code>match\_country</code>, que
simplesmente associa cada entrada em <code>regex</code> com uma entrada
do segundo argumento, mas o código em si é bem simples! E agora temos a
tabela que conecta os nomes em <code>trades</code> com os nomes em
<code>capitals</code>, que pode ser usada para juntas as duas em uma
nova tabela chamada <code>geo\_trades</code>.
</p>

<p>
Para criar os arcos no globo precisamos de uma tabela com um formato
bastante especial. Ela precisa conter 4 colunas:
<code>origin\_lat</code>, <code>origin\_long</code>,
<code>dest\_lat</code>, and <code>dest\_long</code> que serão os pontos
iniciais e finais para cada arco no globo.
</p>
<p>
Eu vou usar <code>geo\_trades</code> para criar uma nova tabela chamada
<code>arcs</code> (nossa tabela também terá o valor da comércio entre as
duas pontas, mas vamos excluir essa coluna quando passarmos a tabela
para a função que gerará o globo). É assim que eu criei
<code>arcs</code>:
</p>
<pre class="r"><code># Criar origem e destino dos arcos (origem &#xE9; sempre T&#xF3;quio)
arcs &lt;- geo_trades %&gt;% cbind( origin_lat = 35.68, origin_long = 139.69 ) %&gt;% select(-country_name) %&gt;% transmute( origin_lat = origin_lat, origin_long = origin_long, dest_lat = lat, dest_long = long, value = value )</code></pre>
<p>
E agora o grand finale: essa é a função que usamos para gerar o globo 😁
Se você olhar com cuidado para a imagem abaixo, é possível ver que a
grossura de cada linha representa o volume monetário total das trocas
comerciais entre o Japão e cada país.
</p>
<pre class="r"><code># Pegar a imagem do globo
earth &lt;- system.file(&quot;images/world.jpg&quot;, package = &quot;threejs&quot;)
# Criar globo
globejs( img = earth, lat = arcs$dest_lat, long = arcs$dest_long, arcs = arcs[, 1:4], arcsOpacity = 0.6, arcsHeight = 0.8, arcsLwd = arcs$value, arcsColor = &quot;green&quot;, atmosphere = TRUE, height = 800, width = 800, bg = &quot;white&quot;, value = 4
)</code></pre>
<img src="http://ctlente.com/interactive-globe/globe.png" alt="">

<p>
E se você quiser interagir com o globo, por favor vá para o meu
<a href="https://www.kaggle.com/ctlente/d/zanjibar/japan-trade-statistics/3d-interactive-globe-tutorial">Kaggle
kernel</a> onde o HTML funciona melhor.
</p>

