+++
title = "A Fixação de Colbert"
date = "2017-06-22"
categories = ["mind-and-iron"]
original_url = "http://ctlente.com/pt/trump-colbert/"
+++

<p>
Stephen Colbert é um comediante americano e apresentador do programa de
TV <em>The Late Show</em>. Em seus quase 2 anos apresentando o programa,
Colbert consolidou um estilo extremamente próprio que eu só consigo
descrever muito vagamente; seria algo como as entrevistas de Jô Soares +
os stand ups de Fábio Porchat + o jornalismo de Willian Bonner.
</p>
<p>
Se você ainda não o conhece e não pretende mudar isso, eu vou te dar o
resumo mais curto possível da sua rotina: ele tira sarro do Donald
Trump.
</p>
<p>
Ele é um esquerdista bastante vocal e não tem medo de fazer piada com a
pessoa que ele enxerga como um maluco liderando seu país. Concorde ou
não com ele, você precisa admitir que ele é bem engraçado…
</p>
<p>
Mas mesmo sabendo que Colbert é conhecido por fazer piada com o
presidente dos EUA, assistindo a seu programa no
<a href="https://www.youtube.com/channel/UCMtFAi84ehTSYSE9XoHefig">YouTube</a>
comecei a achar que talvez ele falasse um pouco demais sobre Trump. No
fim eu não consegui me segurar e tive que fazer a pergunta: quanto, de
fato, Stephen Colbert fala sobre Donald Trump?
</p>
<p>
Resposta curta: muito, tipo, <em>muito</em>.
</p>
<p>
Resposta longa:
</p>
<p>
Na minha busca para encontrar a resposta, o primeiro passo era coletar
as transcrições do seu programa. Eu criei
<a href="https://gist.github.com/ctlente/84d72770db65667add6fe8531408c0af">um
script</a> que baixou a legenda de mais ou menos um terço (990 para ser
preciso) dos vídeos de seu canal do YouTube e decidi que essa era uma
amostra grande o suficiente.
</p>
<p>
O segundo passo era limpar as legendas. Elas estavam cheias de símbolos
(como notas musicais), indicadores de quem estava falando e ações da
platéia (palmas, gritos, …) que tinham que ser removidos para que
ficássemos apenas com a informação relevante. Outro passo importante na
mineração de texto é se livrar das palavras vazias (coisas como “o”,
“a”, “um”, etc.), então eu fui em frente e fiz isso também.
</p>
<p>
Depois que acabei os procedimentos descritos acima, eu ainda tinha mais
de 260.000 palavras de áudio transcrito! E ainda que isso tudo não é
100% Colbert falando, é o suficiente para que tenhamos uma boa
estimativa do conteúdo de seu programa.
</p>
<p>
A primeira coisa que eu queria saber era quais palavras ele mais fala.
Dê uma olhada na vencedora…
</p>
<img src="http://ctlente.com/trump-colbert/top_terms_pt.png" alt="">

<p>
É isso mesmo, excluindo palavras vazias, o termo mais usado no seu
programa foi “Trump”. Ele apareceu nas legendas 3252 vezes, chegando a
1,2% de todas as palavras não-vazias. Se considerarmos a nossa amostra
como representativa dos mais de 2600 vídeos em seu canal do YouTube e
assumirmos que metade de todo programa é disponibilizado online e que
ele é a pessoa falando 3/4 do tempo, concluímos que <strong>Stephen
Colbert falou “Trump” mais de 12.000 vezes em seu programa!</strong>
</p>
<p>
Mas só porque ele fala a palavra “Trump” tantas vezes, isso não quer
necessariamente dizer que ele fala muito <em>sobre</em> o Trump. Para
descobrir se todas essas 12.000 citações são simplesmente referências
sem contexto, eu tive que usar uma técnica mais complexa chamada
modelagem de tópico.
</p>

<p>
De acordo com a
<a href="https://en.wikipedia.org/wiki/Topic_model">Wikipedia</a>, um
modelo de tópico é “um tipo de modelo estatístico usado para descobrir
os ‘tópicos’ abstratos que ocorrem em uma coleção de documentos”. O
modelo que escolhi se chama
<a href="https://en.wikipedia.org/wiki/Latent_Dirichlet_allocation">Alocação
Latente de Dirichlet (LDA)</a> e o ajustei para que ele procurasse 2
tópicos no nosso conjunto de textos.
</p>
<p>
Como esperado, o modelo foi capaz de dividir as palavras de Colbert em
dois temas principais: entrevistas e política. Podemos ver isso dando
uma olhada nas palavras que o modelo considerou mais características de
cada tópico.
</p>
<img src="http://ctlente.com/trump-colbert/log_ratio_pt.png" alt="">

<p>
De forma simples, a “razão dos logs” na abscissa de cada gráfico indica
se um termo aparece mais em um tópico do que no outro; quanto mais
negativo o valor, mais o termo apareceu no tópico A e não no tópico B e
vice-versa.
</p>
<p>
O tópico A é claramente sobre política: outros termos desse tópico não
mostrados no gráfico são “campaign”, “tax” e “republicans”. O tópico B
por outro lado é mais representado pelas conversas de Colbert com seus
convidados: outros termos incluem “comedy”, “song” e “band”.
</p>
<p>
Mas você pode estar se perguntando para onde foi a palavra “Trump”… Ela
não aparece nesses gráficos porque não existe um tópico em que ela
apareça muito mais que no outro! Com isso, podemos concluir que, não
somente Colbert fala muito a palavra “Trump”, mas também que o
presidente dos EUA é um assunto constante no programa mesmo quando
consideramos apenas as conversas com convidados.
</p>
<p>
Isso é Trump o suficiente para você?
</p>

<p>
A análise nesse post foi conduzida inteiramente em R. A limpeza e
modelagem foram realizadas com a ajuda dos pacotes <code>tidytext</code>
and <code>topicmodels</code>. Para criar o procedimento analítico, eu
segui os exemplos de <a href="http://tidytextmining.com/">Text Mining
with R</a> passo-a-passo. Meu
<a href="https://gist.github.com/ctlente/84d72770db65667add6fe8531408c0af">script</a>
baixa todas as legendas de <a href="http://ccsubs.com/">ccSubs</a>. E,
por último mas não menos importante, se você quiser reproduzir as
análises por conta própria, o código que utilizei está disponível como
um
<a href="https://gist.github.com/ctlente/da6434ce9de312fedd848d813df39303">Gist</a>.
</p>

