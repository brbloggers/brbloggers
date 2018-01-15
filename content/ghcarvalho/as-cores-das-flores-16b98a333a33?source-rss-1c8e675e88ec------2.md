+++
title = "As cores das flores"
date = "2017-11-30 03:24:15"
categories = ["ghcarvalho"]
original_url = "https://medium.com/@ghcarvalho/as-cores-das-flores-16b98a333a33?source=rss-1c8e675e88ec------2"
+++

<p id="b236" class="graf graf--p graf-after--h3">
Usando o R para mapear a coloração das flores no Brasil
</p>

<figure id="546f" class="graf graf--figure graf--layoutOutsetCenter graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/2000/1*TmGwYn_OHmilkRFrw1EYLg.png">
<figcaption class="imageCaption">
Clique na imagem para vê-la em tamanho maior
</figcaption>
</figure>

<p id="5a90" class="graf graf--p graf-after--figure">
O mapa acima mostra como a coloração das flores é distribuida pelo
Brasil. Dos 237 mil registros utilizados, mais da metade apresentavam
flores descritas como brancas, amarelas ou termos similares. Os dados
utilizados vieram de herbários, que são coleções onde pesquisadores que
trabalham com vegetação depositam partes de plantas fixadas à folhas de
papel para comparações e consultas futuras. As coletas são feitas
principalmente em locais mais acessíveis, como perto de estradas e nas
margens de rios. Por isso, há poucas coletas em regiões pouco populosas,
como o Norte e Centro-oeste. Nos herbários brasileiros há mais de cinco
milhões de registros.
</p>
<figure id="4319" class="graf graf--figure graf--layoutOutsetLeft graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1200/1*zZpBqAvWgIWOSmtPOUWH2w.jpeg">
<figcaption class="imageCaption">
Ramo de ipê-amarelo depositado em herbário.
</figcaption>
</figure>
<p id="dd56" class="graf graf--p graf-after--figure">
Cada um desses registros possui uma etiqueta onde a pessoa responsável
pela coleta descreve detalhes da planta e do local onde ela foi
encontrada. Em muitos casos, essa descrição inclui a cor das flores e
frutos da planta, já que com o tempo essas partes da planta escurecem e
a cor original é perdida.
</p>
<p id="542a" class="graf graf--p graf-after--p">
Uma das coisas que mais faço no meu pós-doutorado é processar o texto de
milhões de entradas dessas etiquetas que já foram digitadas para
determinar características das plantas, principalmente se elas estavam
com flores ou não no momento da coleta. O banco de dados que eu compilei
possui por volta de 5 milhões de etiquetas, parecidas com as seguintes:
</p>
<pre id="5e6d" class="graf graf--pre graf-after--p">[1] &quot;&#xE1;rvore de 18 m de altura x 35 cm de di&#xE2;metro  flores com c&#xE1;lice verde  p&#xE9;talas brancas  frutos at&#xE9; 15 cm de comprimento  casca pilosa de cor verde-ferruginosa  arilo branco  frutos separados  caatinga alta  solo arenoso humoso &quot;<br>[2] &quot;&#xE1;rvore de 10m de altura x 10cm de di&#xE2;metro  flores amarelas  frutos imaturos verdes  l&#xE1;tex branco  carpoteca &quot;                                                                                                                      <br>[3] &quot;arbusto de flores alvas com manchas roseas e bot&#xF5;es florais  l&#xE1;tex alvo  carpoteca &quot;</pre>
<p id="8d1d" class="graf graf--p graf-after--pre">
Recentemente, tenho usado modelos
<a href="https://en.wikipedia.org/wiki/Word2vec" class="markup--anchor markup--p-anchor">word2vec</a>
auxiliar no processamento desse mundo de etiquetas. Modelos word2vec são
basicamente redes neurais simples que agrupam termos dentro de contextos
baseados nas palavras que co-ocorrem entre eles. Dessa forma, é possível
identificar palavras que, no contexto das etiquetas, provavelmente se
referem à uma mesma coisa. Uma busca no modelo pela palavra “flores”,
por exemplo, retorna o seguinte:
</p>
<pre id="1e90" class="graf graf--pre graf-after--p">&gt; closest_to(model, &quot;flores&quot;)<br>              word similarity to &quot;flores&quot;<br>1           flores              1.0000000<br>2            flors              0.5962055<br>3            flore              0.4516035<br>4           flroes              0.4367272<br>5           fl&#xF4;res              0.4082263<br>6          p&#xE9;talas              0.4020755<br>7          corolas              0.3935502<br>8           fauces              0.3435436<br>9           floras              0.3199513<br>10 infloresc&#xEA;ncias              0.3145785</pre>
<p id="3dc5" class="graf graf--p graf-after--pre">
Sem saber a relação entre as palavras previamente, o modelo foi capaz de
agrupá-las simplesmente pelo contexto, ou seja, pelos termos que
normalmente aparecem próximos à essas palavras. Percebam que aqui ele
encontrou várias entradas em que a palavra “flores” foi digitada de
maneira errada, o que é bastante útil pra mim. Caso eu tivesse procurado
literalmente por “flores”, todas essas entradas teriam sido ignoradas. O
modelo também indicou outros termos usados no mesmo contexto, como
inflorescência, pétalas e corolas. Tudo isso sem ter ideia de que as
palavras são de fato relacionadas. A busca por “amarelas” tem como
retorno:
</p>
<pre id="c1a4" class="graf graf--pre graf-after--p">&gt; closest_to(model, &quot;amarelas&quot;, 20)<br>                  word similarity to &quot;amarelas&quot;<br>1             amarelas                1.0000000<br>2              brancas                0.7183580<br>3                roxas                0.7006725<br>4                alvas                0.6747162<br>5               r&#xF3;seas                0.6678736<br>6          alaranjadas                0.6614220<br>7           amareladas                0.6402489<br>8            vermelhas                0.5869951<br>9  amarelo-alaranjadas                0.5837175<br>10      amarelo-claras                0.5739101<br>11             lilases                0.5512847<br>12               rosas                0.5477697<br>13     amarelo-p&#xE1;lidas                0.5430483<br>14             amrelas                0.5351215<br>15              cremes                0.5329505<br>16             marelas                0.5304547<br>17    creme-amareladas                0.5187036<br>18            laranjas                0.5164795<br>19            azuladas                0.5120074<br>20              roseas                0.5092904</pre>
<p id="cab0" class="graf graf--p graf-after--pre">
O resultado da busca indica que o modelo soube agrupar diversas cores
dentro de um mesmo contexto. Assim, eu consigo determinar de que forma
os coletores descrevem cores nas etiquetas, sem precisar criar um
dicionário de todas as cores possíveis. Aliás, fazer isso seria muito
difícil, uma vez que aparecem combinações como “amarelo-pálidas”,
“creme-amareladas” e por aí vai.
</p>
<p id="5457" class="graf graf--p graf-after--p graf--trailing">
Eu treinei esse modelo em um corpus (conjunto de palavras) com 900 mil
etiquetas previamente selecionadas, o que gerou um vetor com milhões de
palavras, sendo que 12 mil delas foram usadas em pelo menos 20
etiquetas. Nas etiquetas, além das informações sobre as características
da planta, muitas vezes há também as coordenadas geográficas. Assim, por
pura curiosidade, resolvi criar um mapa com todos os registros com
coordenadas e em que nas etiquetas havia informações sobre as cores das
flores. Nesse mapa, cada ponto teria a cor da flor descrita para aquele
indivíduo.
</p>

<p id="c881" class="graf graf--p graf--leading">
Abaixo descrevo os passos mais importantes no R.
</p>
<p id="45f4" class="graf graf--p graf-after--p">
Primeiro, usei os modelos word2vec já treinados para criar vetores com
termos que indicam flores e cores:
</p>
<pre id="713b" class="graf graf--pre graf-after--p">require(dplyr)<br>require(stringr)<br>require(tidytext)<br>require(wordVectors)<br>require(tidyverse)<br>require(sf)<br>require(sp)</pre>
<pre id="a87d" class="graf graf--pre graf-after--pre">flores &lt;- closest_to(model, &quot;flores&quot;, 10)$word<br>&gt; flores<br> [1] &quot;flores&quot;          &quot;flors&quot;           &quot;flore&quot;           &quot;flroes&quot;         <br> [5] &quot;fl&#xF4;res&quot;          &quot;p&#xE9;talas&quot;         &quot;corolas&quot;         &quot;fauces&quot;         <br> [9] &quot;floras&quot;          &quot;infloresc&#xEA;ncias&quot;</pre>
<pre id="9490" class="graf graf--pre graf-after--pre">cores &lt;- unique(<br>  c(<br>    closest_to(model, &quot;amarelas&quot;, 20)$word,<br>    closest_to(model, &quot;brancas&quot;, 20)$word,<br>    closest_to(model, &quot;vermelhas&quot;, 20)$word,<br>    closest_to(model, &quot;rosas&quot;, 20)$word,<br>    closest_to(model, &quot;laranjas&quot;, 20)$word,<br>    closest_to(model, &quot;azuis&quot;, 20)$word,<br>    closest_to(model, &quot;pretas&quot;, 4)$word,<br>    closest_to(model, &quot;marrons&quot;, 3)$word<br>  )<br>)<br>&gt; cores<br> [1] &quot;amarelas&quot;             &quot;brancas&quot;              &quot;roxas&quot;               <br> [4] &quot;alvas&quot;                &quot;r&#xF3;seas&quot;               &quot;alaranjadas&quot;         <br> [7] &quot;amareladas&quot;           &quot;vermelhas&quot;            &quot;amarelo-alaranjadas&quot; <br>[10] &quot;amarelo-claras&quot;       &quot;lilases&quot;              &quot;rosas&quot;               <br>[13] &quot;amarelo-p&#xE1;lidas&quot;      &quot;amrelas&quot;              &quot;cremes&quot;              <br>[16] &quot;marelas&quot;              &quot;creme-amareladas&quot;     &quot;laranjas&quot;            <br>[19] &quot;azuladas&quot;             &quot;roseas&quot;               &quot;esbranqui&#xE7;adas&quot;      <br>[22] &quot;branco-esverdeadas&quot;   &quot;branco-amareladas&quot;    &quot;creme-esverdeadas&quot;   <br>[25] &quot;lilazes&quot;              &quot;amarelo-esverdeadas&quot;  &quot;branco-rosadas&quot;      <br>[28] &quot;azuis&quot;                &quot;vermelho-alaranjadas&quot; &quot;rosadas&quot;             <br>[31] &quot;avermelhadas&quot;         &quot;arroxeadas&quot;           &quot;vin&#xE1;ceas&quot;            <br>[34] &quot;purp&#xFA;reas&quot;            &quot;vinosas&quot;              &quot;esverdeadas&quot;         <br>[37] &quot;viol&#xE1;ceas&quot;            &quot;lil&#xE1;ses&quot;              &quot;violetas&quot;            <br>[40] &quot;laranja&quot;              &quot;laranjadas&quot;           &quot;laranja-avermelhadas&quot;<br>[43] &quot;amarelo-avermelhadas&quot; &quot;vermelho-amareladas&quot;  &quot;verde-amareladas&quot;    <br>[46] &quot;azul-arroxeadas&quot;      &quot;roxo-azuladas&quot;        &quot;lil&#xE1;zes&quot;             <br>[49] &quot;pretas&quot;               &quot;negras&quot;               &quot;enegrecidas&quot;         <br>[52] &quot;marrons&quot;              &quot;amarronzadas&quot;         &quot;castanhas&quot;</pre>
<p id="41be" class="graf graf--p graf-after--pre">
O próximo passo foi <em class="markup--em markup--p-em">tokenizar</em> o
corpus, ou seja, quebrá-lo em grupos de
<em class="markup--em markup--p-em">n </em>palavras. Para este exemplo,
criei grupos de duas palavras. A rotina do R é relativamente grande,
então mostro aqui só as partes relevantes. Para criar os
<em class="markup--em markup--p-em">tokens</em> usei o pacote
<code class="markup--code markup--p-code">tidytext</code> . A ideia era
quebrar todo o texto em grupos de duas palavras, mantendo aqueles grupos
em que a primeira palavra consta no vetor
<code class="markup--code markup--p-code">flores</code> e a segunda no
vetor <code class="markup--code markup--p-code">cores</code> . O objeto
<code class="markup--code markup--p-code">splink</code> contém o texto
das etiquetas, já extensivamente processados para o meu trabalho.
</p>
<pre id="5448" class="graf graf--pre graf-after--p">tokens &lt;- splink %&gt;%<br>  unnest_tokens(token, notes, token = &quot;ngrams&quot;, n = 2) %&gt;%<br>  separate(token, c(&quot;primeira_palavra&quot;, &quot;segunda_palavra&quot;), sep = &quot; &quot;) %&gt;%<br>  filter(primeira_palavra %in% flores, segunda_palavra %in% cores) %&gt;%<br>  distinct()</pre>
<pre id="1cf0" class="graf graf--pre graf-after--pre">tokens %&gt;%<br>select(primeira_palavra, segunda_palavra, latitude, longitude) %&gt;% head()</pre>
<pre id="cf51" class="graf graf--pre graf-after--pre">Simple feature collection with 6 features and 4 fields<br>geometry type:  POINT<br>dimension:      XY<br>bbox:           xmin: -60.02643 ymin: -19.9 xmax: -39.0333 ymax: -3.106409<br>epsg (SRID):    4326<br>proj4string:    +proj=longlat +datum=WGS84 +no_defs<br># A tibble: 6 x 5<br>  primeira_palavra segunda_palavra   latitude longitude          geometry<br>             &lt;chr&gt;           &lt;chr&gt;      &lt;dbl&gt;     &lt;dbl&gt;  &lt;simple_feature&gt;<br>1           flores         brancas -19.900000 -43.40000 &lt;POINT (-43.4...&gt;<br>2           flores         brancas -14.163600 -47.81110 &lt;POINT (-47.8...&gt;<br>3           flores         brancas -15.208600 -45.85190 &lt;POINT (-45.8...&gt;<br>4           flores         brancas -18.960275 -49.46002 &lt;POINT (-49.4...&gt;<br>5           flores           alvas -16.283300 -39.03330 &lt;POINT (-39.0...&gt;<br>6           flores         brancas  -3.106409 -60.02643 &lt;POINT (-60.0...&gt;</pre>
<p id="066b" class="graf graf--p graf-after--pre">
Depois, traduzi as cores indicadas pelos coletores em cores que o R
conhece:
</p>
<pre id="c948" class="graf graf--pre graf-after--p">cores_traduzidas &lt;- c(<br>  &quot;amarelas&quot; = &quot;yellow&quot;, <br>  &quot;brancas&quot;= &quot;white&quot;, <br>  &quot;roxas&quot; = &quot;purple&quot;, <br>  &quot;alvas&quot;  =&quot;white&quot;, <br>  &quot;r&#xF3;seas&quot; = &quot;pink1&quot;, <br>  &quot;alaranjadas&quot; = &quot;orange&quot;, <br>  &quot;amareladas&quot; = &quot;lightyellow&quot;, <br>  &quot;vermelhas&quot; = &quot;red&quot;, <br>  &quot;amarelo-alaranjadas&quot; = &quot;goldenrod&quot;, <br>  &quot;amarelo-claras&quot; = &quot;lightyellow2&quot;, <br>  &quot;lilases&quot; = &quot;violet&quot;,<br>  &quot;rosas&quot; = &quot;pink1&quot;,<br>  &quot;amarelo-p&#xE1;lidas&quot; = &quot;lightyellow2&quot;,<br>  &quot;amrelas&quot; = &quot;yellow&quot;,<br>  &quot;cremes&quot; = &quot;wheat4&quot;,<br>  &quot;marelas&quot; = &quot;yellow&quot;,<br>  &quot;creme-amareladas&quot; = &quot;lightgoldenrodyellow&quot;,<br>  &quot;laranjas&quot; = &quot;darkorange&quot;,<br>  &quot;azuladas&quot; = &quot;blueviolet&quot;,<br>  &quot;roseas&quot; = &quot;lightpink&quot;,<br>  &quot;esbranqui&#xE7;adas&quot; = &quot;wheat2&quot;,<br>  &quot;branco-esverdeadas&quot; = &quot;palegreen&quot;,<br>  &quot;branco-amareladas&quot; = &quot;lightyellow&quot;,<br>  &quot;creme-esverdeadas&quot; = &quot;darkseagreen3&quot;,<br>  &quot;lilazes&quot; = &quot;violet&quot;,<br>  &quot;amarelo-esverdeadas&quot; = &quot;greenyellow&quot;,<br>  &quot;branco-rosadas&quot; = &quot;lightpink&quot;,<br>  &quot;azuis&quot; = &quot;slateblue4&quot;,<br>  &quot;vermelho-alaranjadas&quot; = &quot;orangered1&quot;,<br>  &quot;rosadas&quot; = &quot;pink&quot;,<br>  &quot;avermelhadas&quot; = &quot;tomato&quot;,<br>  &quot;arroxeadas&quot; = &quot;thistle2&quot;,<br>  &quot;vin&#xE1;ceas&quot; = &quot;deeppink4&quot;,<br>  &quot;purp&#xFA;reas&quot; = &quot;violetred&quot;,<br>  &quot;vinosas&quot; = &quot;deeppink4&quot;,<br>  &quot;esverdeadas&quot; = &quot;palegreen&quot;,<br>  &quot;viol&#xE1;ceas&quot; = &quot;violet&quot;,<br>  &quot;lil&#xE1;ses&quot; = &quot;violet&quot;,<br>  &quot;violetas&quot; = &quot;violet&quot;,<br>  &quot;laranja&quot; = &quot;darkorange&quot;,<br>  &quot;laranjadas&quot; = &quot;orange1&quot;,<br>  &quot;laranja-avermelhadas&quot; = &quot;orangered1&quot;,<br>  &quot;amarelo-avermelhadas&quot; = &quot;darkorange1&quot;,<br>  &quot;vermelho-amareladas&quot; = &quot;orangered1&quot;,<br>  &quot;verde-amareladas&quot; = &quot;yellow4&quot;,<br>  &quot;azul-arroxeadas&quot; = &quot;blueviolet&quot;,<br>  &quot;roxo-azuladas&quot; = &quot;blueviolet&quot;,<br>  &quot;lil&#xE1;zes&quot; = &quot;violet&quot;,<br>  &quot;pretas&quot; = &quot;black&quot;,<br>  &quot;negras&quot; = &quot;black&quot;,<br>  &quot;enegrecidas&quot; = &quot;black&quot;,<br>  &quot;marrons&quot; = &quot;brown&quot;,<br>  &quot;amarronzadas&quot; = &quot;brown&quot;,<br>  &quot;castanhas&quot; = &quot;tan1&quot;<br>)</pre>
<p id="d282" class="graf graf--p graf-after--pre">
Por fim, criei o mapa do começo da postagem com os 237 mil registros que
restaram. O objeto <code class="markup--code markup--p-code">br</code> é
o shape do Brasil que eu já havia carregado:
</p>
<pre id="1d0b" class="graf graf--pre graf-after--p">p_colors &lt;- tokens %&gt;%<br>  ggplot() +<br>  geom_sf(data = br, fill = &quot;#313131&quot;, size = 0.1, colour = &quot;#414141&quot;) +<br>  geom_point(<br>    aes(x = longitude, y = latitude, colour = segunda_palavra),<br>    size = 0.8,<br>    alpha = 0.7<br>  ) +<br>  ggtitle(&quot;Cores de flores pelo Brasil&quot;, subtitle = &quot;Ocorr&#xEA;ncia de cores em 200 mil registros de herb&#xE1;rios&quot;) +<br>  scale_colour_manual(values = cores_traduzidas) +<br>  labs(x = NULL, y = NULL) +<br>  theme_plex() +<br>  theme(legend.position = &quot;none&quot;) + <br>  coord_sf(datum = NA)</pre>
<p id="768d" class="graf graf--p graf-after--pre">
Não gosto do fundo preto, mas é preciso para dar destaque a cores como o
branco. Flores amarelas e brancas são maioria:
</p>
<pre id="e7a4" class="graf graf--pre graf-after--p graf--trailing">&gt; tokens %&gt;% count(primeira_palavra, segunda_palavra, sort = TRUE)<br>Simple feature collection with 214 features and 3 fields<br>geometry type:  GEOMETRY<br>dimension:      XY<br>bbox:           xmin: -73.67256 ymin: -33.66056 xmax: -32.44806 ymax: 5.168889<br>epsg (SRID):    4326<br>proj4string:    +proj=longlat +datum=WGS84 +no_defs<br># A tibble: 214 x 4<br>   primeira_palavra segunda_palavra     n          geometry<br>              &lt;chr&gt;           &lt;chr&gt; &lt;int&gt;  &lt;simple_feature&gt;<br> 1           flores        amarelas 48761 &lt;MULTIPOINT (...&gt;<br> 2           flores         brancas 45468 &lt;MULTIPOINT (...&gt;<br> 3           flores           alvas 26662 &lt;MULTIPOINT (...&gt;<br> 4           flores           roxas 12008 &lt;MULTIPOINT (...&gt;<br> 5           flores       vermelhas  7568 &lt;MULTIPOINT (...&gt;<br> 6           flores          r&#xF3;seas  7197 &lt;MULTIPOINT (...&gt;<br> 7           flores     esverdeadas  7151 &lt;MULTIPOINT (...&gt;<br> 8          p&#xE9;talas         brancas  6909 &lt;MULTIPOINT (...&gt;<br> 9           flores         lilases  6574 &lt;MULTIPOINT (...&gt;<br>10          p&#xE9;talas        amarelas  5974 &lt;MULTIPOINT (...&gt;<br># ... with 204 more rows</pre>

