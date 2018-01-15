+++
title = "Como corrigir nomes e buscar informações taxonômicas de plantas no R"
date = "2017-12-01 20:54:05"
categories = ["ghcarvalho"]
original_url = "https://medium.com/@ghcarvalho/como-corrigir-nomes-e-buscar-informa%C3%A7%C3%B5es-taxon%C3%B4micas-de-plantas-no-r-cdd019d5de8f?source=rss-1c8e675e88ec------2"
+++

<p id="3a0c" class="graf graf--p graf-after--h3">
Digamos que você tenha alguns nomes de plantas e que queira verificar se
a grafia está correta e se há sinônimos entre eles. Se a sua lista for
curta, basta entra na
<a href="http://floradobrasil.jbrj.gov.br/" class="markup--anchor markup--p-anchor">Flora
2020</a> e conferir manualmente. Entretanto, caso sejam muitos nomes,
esse trabalho logo se torna cansativo e propenso a erros. Uma forma de
automatizar a pesquisa é por meio do
<a href="https://cran.r-project.org/package=flora" class="markup--anchor markup--p-anchor">pacote
flora</a> para o
<a href="https://www.r-project.org/" class="markup--anchor markup--p-anchor">R</a>.
Para quem não tem familiaridade com o R, é possível obter os mesmos
resultados submetendo a lista de espécies para o
<a href="http://www.plantminer.com/" class="markup--anchor markup--p-anchor">Plantminer</a>,
que usa o pacote flora por trás das cortinas. A fonte dos dados de ambos
é a Flora 2020, mas nem sempre na última versão. Normalmente eu atualizo
os dados a cada dois meses, tanto no flora quanto no Plantminer.
</p>
<p id="298a" class="graf graf--p graf-after--p">
Agora, suponha que você tenha as seguintes espécies:
</p>
<pre id="ab89" class="graf graf--pre graf-after--p">Myrcia lingua<br>Banisteriopsis paraguariensis<br>Cassia caespitosa<br>Eriocaulon bahiense<br>Parkya igneiflora<br>Adipe longicornis<br>Ardisia panurenses x<br>Manettia pleiodon<br>Cipocereus bradei (Backeb. &amp; Voll) Zappi &amp; N.P.Taylor<br>Sporobolus purpurascens<br>Caesalpynia cf. peltophoroides<br>Protium sp.1 <br>Hypolytrum ceylanicum<br>Caladium picturatum var. lemaireanum<br>Ouratea ovalis<br>Cryptarrhena kegelii<br>Acer tataricum</pre>
<p id="6413" class="graf graf--p graf-after--pre">
Normalmente as listas são bem mais extensas, mas o tamanho não importa.
Para conferir grafia, presença de sinonímias, ocorrência, hábito, estado
de conservação e qualquer outra informação disponível na Flora 2020 de
maneira automatizada no R, o primeiro passo é instalar o pacote flora.
Há duas formas de se fazer isso: 1) direto do CRAN, que é o repositório
oficial de pacotes do R e 2) pelo
<a href="http://github.com/gustavobio" class="markup--anchor markup--p-anchor">github</a>,
que é um repositório de códigos, não só de R, e onde a maioria dos
pacotes são desenvolvidos. Normalmente instalando-se pelo github tem-se
acesso à versões mais atuais dos pacotes, pois as versões ali são
espelho daquelas em que os desenvolvedores estão trabalhando. No caso do
flora, geralmente a versão do github é bem mais atual devido à
burocracia necessária para submeter o pacote no CRAN. A desvantagem das
versões disponíveis no github é que elas são mais difíceis de serem
instaladas.
</p>
<p id="80fa" class="graf graf--p graf-after--p">
Para instalar a versão do R via CRAN, basta digitar o comando abaixo no
console do R:
</p>
<pre id="b92a" class="graf graf--pre graf-after--p">install.packages(&quot;flora&quot;)</pre>
<p id="3f2f" class="graf graf--p graf-after--pre">
Com isso, o você instalará o pacote flora e suas dependências (pacotes
adicionais que são necessários para que o flora funcione).
</p>
<p id="c6df" class="graf graf--p graf-after--p">
Já a versão do github, que é a que eu recomendo, requer alguns passos
adicionais. O primeiro deles é a instalação do pacote
<code class="markup--code markup--p-code">devtools</code> . A instalação
básica do R não disponibiliza uma função para instalação de pacotes
diretamente do github. Com o devtools, instale o pacote da seguinte
forma:
</p>
<pre id="5008" class="graf graf--pre graf-after--p">devtools::install_github(&quot;gustavobio/flora&quot;)</pre>
<p id="fa87" class="graf graf--p graf-after--pre">
Pode ser necessário passos adicionais. Veja a
<a href="http://github.com/hadley/devtools" class="markup--anchor markup--p-anchor">página
do pacote</a> caso encontre algum erro. Normalmente eles são resolvidos
com a instalação do
<a href="https://cran.r-project.org/bin/windows/Rtools/" class="markup--anchor markup--p-anchor">Rtools</a>
no Windows e do Xcode no mac.
</p>
<p id="1ca5" class="graf graf--p graf-after--p">
Com o pacote instalado, basta carregá-lo:
</p>
<pre id="d57a" class="graf graf--pre graf-after--p">library(flora)</pre>
<p id="9399" class="graf graf--p graf-after--pre">
Dessa forma, várias funções são disponibilizadas. Elas podem ser vistas
da seguinte forma:
</p>
<pre id="680b" class="graf graf--pre graf-after--p">?flora</pre>
<p id="5d95" class="graf graf--p graf-after--pre">
Agora que o pacote foi instalado e carregado, podemos começar a
utilizá-lo. A principal função é a
<code class="markup--code markup--p-code">get.taxa</code> , que
“processa” um ou mais nomes de plantas. Por processar entenda, corrigir
grafia, sinonímias, buscar informações taxonômicas, de ocorrência,
hábito, forma de vida, nome vulgar e qualquer outra informação
disponível no Flora 2020. Por exemplo:
</p>

<figure id="409d" class="graf graf--figure graf--layoutOutsetCenter graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/2000/1*bTFIUTTbMd5klyOQxdvPwg.png">
</figure>

<p id="3b0a" class="graf graf--p graf-after--figure">
A função get.taxa busca o nome em um banco da Flora 2020 disponível
diretamente no pacote, sem necessidade de internet. Esse é o banco que
eu atualizo a cada dois meses. Por padrão, quando nenhum argumento é
modificado, ela retorna um objeto do tipo data.frame como o da imagem
acima, onde cada linha corresponde a um nome fornecido. As colunas desse
objeto variam de acordo com os argumentos utilizados. Na imagem eu
anotei à que algumas das colunas se referem. No caso de
<em class="markup--em markup--p-em">Myrcia lingua, </em>a função
detectou que é um sinônimo cujo nome aceito é
<em class="markup--em markup--p-em">Myrcia guianensis</em>, fazendo a
correção de maneira automática. É possível desabilitar esse
comportamento padrão utilizando o argumento
<code class="markup--code markup--p-code">replace.synonyms =
FALSE:</code>
</p>

<figure id="2a09" class="graf graf--figure graf--layoutOutsetCenter graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/2000/1*swqNdzYCgHcGQ147Bi0IzQ.png">
</figure>

<p id="ada3" class="graf graf--p graf-after--figure">
Quando um nome tem grafia errada, a função procura corrigi-la. Abaixo,
escrevi <em class="markup--em markup--p-em">Myrcia lyngua</em>, com o
“y” no lugar do “i”.
</p>

<figure id="5cf2" class="graf graf--figure graf--layoutOutsetCenter graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/2000/1*zNazE__tvazG8gNJOc0Qjg.png">
</figure>

<p id="0626" class="graf graf--p graf-after--figure">
A função corrigiu o nome automaticamente. O código que faz essa correção
é bem conservador, sugerindo nomes com apenas uma ou duas letras de
diferença. Dessa forma, é improvável que o nome sugerido não corresponda
ao nome de interesse. O argumento que controla o conservadorismo da
sugestão de nomes é o
<code class="markup--code markup--p-code">sugestion.distance.</code> Ele
aceita um número de 0 a 1, sendo que quanto mais próximo do 1 mais
conservadora será a sugestão. O padrão é 0.9.
</p>
<p id="3937" class="graf graf--p graf-after--p">
Nem todos os nomes precisam fazer referência à espécies. Veja os casos
abaixo:
</p>

<figure id="5d32" class="graf graf--figure graf--layoutOutsetCenter graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/2000/1*8TdcsTP5vTEcO010UdYOAA.png">
</figure>

<p id="e66c" class="graf graf--p graf-after--figure">
Os nomes podem fazer referência à famílias, gêneros e espécies
desconhecidas com “sp.”, “sp.1”, “sp.2”,
<em class="markup--em markup--p-em">etc.</em> Outra situação comum é a
conferência de nomes com autores:
</p>

<figure id="e529" class="graf graf--figure graf--layoutOutsetCenter graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/2000/1*Q8ts1raxz4OaHc7E7Ys3sg.png">
</figure>

<p id="787e" class="graf graf--p graf-after--figure">
Veja que, no primeiro caso, com o nome do autor, a função não encontrou
a espécie. Lidar com nomes de autores é extremamente difícil. Uma forma
de contornar essa dificuldade é usar o argumento
<code class="markup--code markup--p-code">parse = TRUE</code> , que
indica que o nome deve ser processado antes pelo
<a href="http://www.gbif.org/" class="markup--anchor markup--p-anchor">GBIF</a>,
que tenta separar o autor. Nem sempre funciona e as consultas ficam bem
mais demoradas, pois a função faz uma chamada via internet para a API do
GBIF. O ideal é que as consultas não tenham nomes de autores.
</p>
<p id="69b8" class="graf graf--p graf-after--p">
A caixa das fontes pouco importa, então não vale a pena ficar perdendo
tempo corrigindo isso:
</p>

<figure id="d099" class="graf graf--figure graf--layoutOutsetCenter graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/2000/1*R39n_0BqGQgFd8aH281K2A.png">
</figure>

<p id="592b" class="graf graf--p graf-after--figure">
Como dito anteriormente, há vários outros argumentos e eles podem ser
combinados de qualquer forma:
</p>

<figure id="7fd1" class="graf graf--figure graf--layoutOutsetCenter graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/2000/1*vF3gF4LAL_JU9Jkq5N4Xag.png">
</figure>

<p id="64ab" class="graf graf--p graf-after--figure">
No caso acima, eu procurei por
<em class="markup--em markup--p-em">Myrcia guianensis </em>e pedi para
que a função retornasse, além das informações básicas, também os estados
do Brasil em que ela ocorre, a forma de vida e o hábitat. Todos os
argumentos podem ser consultados
via <code class="markup--code markup--p-code">?get.taxa</code> no
console do R. Lembrando que absolutamente todas as informações são
provenientes da Flora 2020.
</p>
<p id="c95e" class="graf graf--p graf-after--p">
Normalmente, as consultas não são tão pontuais, com apenas um nome. Mais
comum é que elas sejam feitas para vários nomes ao mesmo tempo. Veja por
exemplo a planilha abaixo, que representa uma situação mais real.
</p>
<figure id="188a" class="graf graf--figure graf--layoutOutsetLeft graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1200/1*GNoqDa2x0-jfe5H4MTq9fA.png">
</figure>
<p id="f85a" class="graf graf--p graf-after--figure">
Nesse caso, para processar todos essas nomes no R, o primeiro passo é
salvar o arquivo em algum formato de texto, como csv ou txt. Para isso,
basta ir no gerenciador de planilhas de sua preferência e “Salvar como”,
selecionando o formado “Separado por vírgulas”, “Separado por ponto e
vírgulas” ou “Separado por tabulações”. Qualquer um deles serve. O ideal
é que nesse arquivo seja mantida apenas a coluna com os nomes a serem
procurados, para evitar problemas no momento de importar para o R. É
importante evitar espaços e acentos nos nomes das colunas. Depois, basta
ler o arquivo no R usando as funções
<code class="markup--code markup--p-code">read.csv</code> ,
<code class="markup--code markup--p-code">read.csv2</code> , ou
<code class="markup--code markup--p-code">read.table</code> , dependendo
do formato em que ele foi salvo:
</p>
<figure id="56c0" class="graf graf--figure graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/1*9QuoX8xJFiM-ZBdQ5a4ZsQ.png">
</figure>
<p id="4a37" class="graf graf--p graf-after--figure">
Como eu salvei em um arquivo separado por vírgulas, usei a função
<code class="markup--code markup--p-code">read.csv.</code> Há vários
tutoriais sobre como importar dados para o R caso encontre alguma
dificuldade nesse passo.
</p>
<p id="068e" class="graf graf--p graf-after--p">
Depois, basta passar o vetor com os nomes das espécies para a função
<code class="markup--code markup--p-code">get.taxa</code>:
</p>

<figure id="3b65" class="graf graf--figure graf--layoutOutsetCenter graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/2000/1*lhe73X8aMc8-CVzbGK6q3w.png">
</figure>

<p id="b208" class="graf graf--p graf-after--figure">
Todos os nomes foram processados de uma vez. A velocidade com que isso
ocorre depende do seu computador. Normalmente a função processa por
volta de 1000 nomes a cada 10 segundos. Uma lista com 10 mil nomes
demoraria, portanto, pouco mais de 1 minuto. Caso queira exportar os
resultados para uma planilha, basta salvar o objeto retornado pela
função e usar
<code class="markup--code markup--p-code">write.csv</code>,
<code class="markup--code markup--p-code">write.csv2</code>, ou
<code class="markup--code markup--p-code">write.table</code>:
</p>

<figure id="cbdd" class="graf graf--figure graf--layoutOutsetCenter graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/2000/1*zyrIPCgRgY8nUOhc5qZr7A.png">
</figure>

<p id="8e10" class="graf graf--p graf-after--figure">
<code class="markup--code markup--p-code">NA</code> são valores não
disponíveis (<em class="markup--em markup--p-em">not available</em>).
</p>
<p id="15e9" class="graf graf--p graf-after--p">
Além da função
<code class="markup--code markup--p-code">get.taxa</code>, há outras
funções que podem ser úteis. Por exemplo, a função
<code class="markup--code markup--p-code">lower.taxa</code>lista todos
os nomes de uma família ou gênero:
</p>
<figure id="cfa2" class="graf graf--figure graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/1*MRyTJU5eaZ8KFdbNgiyEMw.png">
</figure>
<p id="18a7" class="graf graf--p graf-after--figure">
Há mais nomes para o gênero Myrcia, mas eu cortei a tela para não ocupar
muito espaço. Outra função que pode ser útil é a
<code class="markup--code markup--p-code">vernacular</code>, que faz
buscas por nomes vulgares:
</p>

<figure id="b266" class="graf graf--figure graf--layoutOutsetCenter graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/2000/1*EzDpkZjI40Tnw418dJjqcg.png">
</figure>

<p id="c803" class="graf graf--p graf-after--figure">
Neste caso, procurei por “pimenta de macaco” e voltaram duas espécies de
<em class="markup--em markup--p-em">Xylopia</em>, incluindo todos os
outros pelos quais elas são conhecidas. A busca pelos nomes populares
usando nomes científicos pode ser feita pela função
<code class="markup--code markup--p-code">get.taxa</code> via argumento
<code class="markup--code markup--p-code">vernacular = TRUE</code>.
</p>
<p id="23dc" class="graf graf--p graf-after--p">
Finalmente, as funções
<code class="markup--code markup--p-code">remove.authors</code> procura
remover autores de nomes na força bruta, comparando com uma base de
autores que vai com o pacote,
<code class="markup--code markup--p-code">suggest.names</code> procura
sugerir nomes para aquelas com grafias erradas e
<code class="markup--code markup--p-code">fixCase</code> arruma a
capitalização:
</p>
<figure id="b0c8" class="graf graf--figure graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/1*-NRoHv-2UB9VxnduQONdJA.png">
</figure>
<p id="6bb1" class="graf graf--p graf-after--figure graf--trailing">
Caso tenha alguma sugestão de mudança para o pacote, por favor envie um
email para <gustavobio@gmail> ou abra um chamado na minha
<a href="http://www.github.com/gustavobio/" class="markup--anchor markup--p-anchor">página
do github.</a> Aproveite e dê uma olhadinha na página, pois pode ser que
algum outro pacote de minha autoria lhe seja útil:
<a href="https://github.com/gustavobio/tpl" class="markup--anchor markup--p-anchor">tpl</a>,
similar ao flora mas para o The Plant List,
<a href="https://github.com/gustavobio/reflora" class="markup--anchor markup--p-anchor">reflora</a>
e
<a href="https://github.com/gustavobio/RB" class="markup--anchor markup--p-anchor">RB</a>
para buscar ocorrências e imagens no species link e JBRJ,
<a href="https://github.com/gustavobio/plantminer" class="markup--anchor markup--p-anchor">plantminer</a>
para instalar uma versão local do Plantminer,
<a href="https://github.com/gustavobio/brclimate" class="markup--anchor markup--p-anchor">brclimate</a>
e
<a href="https://github.com/gustavobio/inmet" class="markup--anchor markup--p-anchor">inmet</a>
para buscar dados climáticos de estações climáticas pelo Brasil.
</p>

