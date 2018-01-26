+++
title = "Roubos de celular aumentam em Ribeirão Preto, SP"
date = "2017-11-20 20:15:06"
categories = ["ghcarvalho"]
original_url = "https://medium.com/@ghcarvalho/roubos-de-celulares-aumentam-em-ribeir%C3%A3o-preto-sp-d67c7d09a1e8?source=rss-1c8e675e88ec------2"
+++

<p id="444c" class="graf graf--p graf-after--h3">
Apesar do
<a href="http://www.ssp.sp.gov.br/Estatistica/Pesquisa.aspx" class="markup--anchor markup--p-anchor">leve
crescimento</a> no número de roubos em geral em Ribeirão Preto desde
2010, as ocorrências de roubos (subtração mediante grave ameaça ou
violência) de celulares de transeuntes têm crescido bastante. Os dados
que utilizei aqui são disponibilizados na página da
<a href="http://www.ssp.sp.gov.br/transparenciassp/Consulta.aspx" class="markup--anchor markup--p-anchor">Secretaria
de Segurança Pública de São Paulo</a> na forma de boletins de ocorrência
agrupados por tipo de delito. Para esta análise retirei os furtos,
quando não há violência. Retirei também os roubos onde as vítimas
estavam dentro de veículos, estabelecimentos comerciais e residências.
Inclui, portanto, apenas os roubos à transeuntes. As rotinas do R para
download dos dados e criação dos gráficos e mapas estão na minha página
do
<a href="http://github.com/gustavobio" class="markup--anchor markup--p-anchor">github</a>.
</p>
<p id="2482" class="graf graf--p graf-after--p">
Somente nos nove primeiros meses de 2017 foram registrados 1482 roubos,
número maior do que em qualquer ano desde 2010.
</p>
<figure id="6c8f" class="graf graf--figure graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/1*ceQEtNNMYPQ6dIJ51DawBQ.jpeg">
</figure>
<p id="5629" class="graf graf--p graf-after--figure">
Entre 2010 e meados de 2012 não houve aumento nesse tipo de crime.
Entretanto, desde então, há uma tendência de crescimento, apesar das
grandes variações no número dentro dos anos. A linha cinza indica a
flutuação dentro dos anos, enquanto a linha vermelha indica a tendência
entre os anos.
</p>

<figure id="009e" class="graf graf--figure graf--layoutOutsetCenter graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/2000/1*M6IKITa0j6OR6gCzzBp6-w.jpeg">
</figure>

<p id="515a" class="graf graf--p graf-after--figure">
De maneira geral, dentro dos anos, há um aumento no número de roubos de
janeiro ao meio de abril, quando as ocorrências começam a diminuir,
mantendo essa tendência até o fim do ano. Ainda assim, há dois picos
acentuados no número de ocorrências: o primeiro na metade de abril,
perto da Páscoa, e o segundo no meio de agosto, no Dia dos Pais. Seriam
resultado de saídas temporárias?
</p>

<figure id="6d95" class="graf graf--figure graf--layoutOutsetCenter graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/2000/1*9mfBo3YiOLFt7amPa7EqkQ.jpeg">
</figure>

<p id="7182" class="graf graf--p graf-after--figure">
Dos 9346 boletins disponibilizados, por volta de metade tinham
coordenadas geográficas confiáveis, georreferenciadas por meio de
logradouro e número. Retirei os boletins com endereços sem número e sem
as coordenadas geográficas. O mapa dessas ocorrências mostra que a
região central, incluindo avenidas com grande fluxo de pessoas como
Avenida da Saudade, Avenida Francisco Junqueira e Avenida Jerônimo
Gonçalves, principalmente nas proximidades da rodoviária, apresentam
grande número de ocorrências. Pontos de ônibus também são locais onde os
assaltantes agem preferencialmente. Na região sul, destaque para o
entorno do Ribeirão Shopping e da UNIP. A maioria dos roubos acontece à
noite e de madrugada, mas a diferença para os roubos durante o dia é
pequena.
</p>

<figure id="892f" class="graf graf--figure graf--layoutOutsetCenter graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/2000/1*wd0mSayUYNsPxFi9y_Q0ew.jpeg">
</figure>

<figure id="3fb6" class="graf graf--figure graf--layoutOutsetLeft graf-after--figure">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1200/1*jHYqNsqLRLQmC_eh2T4QPw.jpeg">
</figure>
<p id="1dd5" class="graf graf--p graf-after--figure">
O mapa com a densidade de pontos reforça a região central como sendo a
campeã no número de roubos, seguida pela zona oeste, principalmente nas
proximidades da rodoviária. Os entornos do aeroporto, dos shoppings e de
algumas universidades também apresentam grande quantidade de
ocorrências. Ainda assim, apesar de haver regiões com maior incidência
de roubos, eles acontecem em toda a cidade, à qualquer hora do dia.
</p>
<p id="62bd" class="graf graf--p graf-after--p">
Entre os meses, a distribuição dos crimes também não aponta mudanças na
distribuição espacial. O mapa abaixo mostra os pontos para cada um dos
meses entre janeiro e maio de 2017. Não há grandes diferenças entre os
meses, apenas pequenas variações em algumas regiões.
</p>

<figure id="42b5" class="graf graf--figure graf--layoutOutsetCenter graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/2000/1*eXlN4J2zqtN89z5wOoXA5g.jpeg">
</figure>

<p id="afff" class="graf graf--p graf-after--figure graf--trailing">
Assim, apesar de haver regiões com maior incidência de roubos, eles
acontecem em toda a cidade, à qualquer hora do dia. Vale ressaltar ainda
que o número de pontos nos mapas é, provavelmente, muito menor do que o
número real de ocorrências, já que nem todas as pessoas conseguem
descrever exatamente onde o roubo aconteceu e há também aquelas que
preferem não registrar boletins de ocorrência.
</p>

