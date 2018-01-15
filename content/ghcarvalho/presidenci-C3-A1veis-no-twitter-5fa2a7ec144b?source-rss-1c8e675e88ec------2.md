+++
title = "Presidenciáveis no Twitter"
date = "2018-01-09 16:05:55"
categories = ["ghcarvalho"]
original_url = "https://medium.com/@ghcarvalho/presidenci%C3%A1veis-no-twitter-5fa2a7ec144b?source=rss-1c8e675e88ec------2"
+++

<p id="892c" class="graf graf--p graf-after--h3">
Análise dos tweets que mais geram retweets
</p>
<p id="fa11" class="graf graf--p graf-after--p">
<em class="markup--em markup--p-em">Obs: O código do R para reproduzir
esta postagem está no meu
</em><a href="https://www.github.com/gustavobio" class="markup--anchor markup--p-anchor"><em class="markup--em markup--p-em">github</em></a><em class="markup--em markup--p-em">.</em>
</p>
<p id="c742" class="graf graf--p graf-after--p">
As eleições de 2018 se aproximam trazendo com elas um enxurrada de
comícios virtuais, agora em até 280 caracteres. O alcance de plataformas
como o Twitter seduziu os candidatos. Com um clique, a mensagem é
transmitida instantaneamente a centenas de milhares de pessoas. Foi-se o
tempo dos discursos nas praças para meia dúzia de curiosos. Neste ano,
com a disparidade prevista nos tempos de TV entre os presidenciáveis, as
plataformas virtuais terão papel ainda mais central. A capacidade de
engajar e inflamar os ânimos da militância online será fundamental. A
pergunta que fica é: que tipo de tweet mais gera retweets? Vejamos.
</p>
<p id="3fa6" class="graf graf--p graf-after--p">
Dos candidatos ao planalto mais lembrados nas pesquisas, apenas Ciro
Gomes tem menos de 100 mil seguidores no Twitter. Na outra ponta, Marina
Silva tem quase 2 milhões, mais que Geraldo Alckmin (924 mil) e
Bolsonaro (842 mil) juntos. Lula criou uma nova conta recentemente e
hoje tem 185 mil seguidores.
</p>
<p id="fb5f" class="graf graf--p graf-after--p">
Há uma grande disparidade no número de mensagens postadas. Em Janeiro de
2018, Geraldo Alckmin tem mais tweets que todos os outros candidatos
somados. Ciro Gomes, por outro lado, postou cerca de 200 vezes. Lula
desponta na segunda posição, com pouco mais de 10 mil postagens, mas a
sua conta é bem mais recente que as outras. Marina Silva vem depois,
seguida de Bolsonaro:
</p>
<figure id="edc8" class="graf graf--figure graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/1*Koi8zZRGhFzo-TVnneAQCQ.png">
</figure>
<p id="20e3" class="graf graf--p graf-after--figure">
A API do Twitter permite baixar os últimos 3200 tweets de uma timeline,
incluindo os retweets. Portanto, daqui para baixo, utilizei os últimos
3200 tweets de cada candidato. Como Ciro Gomes tem poucos tweets,
retirei a conta dele das análises subsequentes. Também retirei as
postagens que não eram próprias do candidato (retweets). De maneira
geral, não mais que 25% das postagens eram desse tipo (figura abaixo).
Mantive os compartilhamentos em que eles escrevem algo adicional. Quem
mais retuíta é o Lula, e quem menos retuíta é o Alckmin.
</p>
<figure id="275e" class="graf graf--figure graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/1*R9Z7IGK5GhTTdakU1sUevQ.png">
</figure>
<p id="007c" class="graf graf--p graf-after--figure">
Apesar do Bolsonaro ter tuitado pouco quando comparado aos outros
candidatos, o engajamento de seus seguidores é grande. Cada postagem
dele gera um número muito maior de retuítes em relação aos outros
presidenciáveis. Alckmin é o que menos empolga, enquanto Lula e Marina
estão no mesmo barco.
</p>
<figure id="a9c0" class="graf graf--figure graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/1*DRI5nBsBYmuZ4yotkoVYQQ.png">
</figure>
<p id="54ca" class="graf graf--p graf-after--figure">
A evolução no número de compartilhamentos do Bolsonaro no último ano foi
grande. No gráfico abaixo é possível ver o número médio de retuítes por
semana de cada candidato. Lembre-se que usei as últimas 3200 postagens.
Pelo gráfico também é possível ver que as 3200 postagens foram feitas em
mais de 3 anos por Bolsonaro e Marina. Alckmin, quase um ano. Lula levou
menos de 6 meses. Ele é de longe quem mais usa o Twitter hoje.
</p>
<figure id="6247" class="graf graf--figure graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/1*Q-xB2E7WLwIZiiu5CGzLUw.png">
</figure>
<p id="7332" class="graf graf--p graf-after--figure">
O número de retuítes flutua bastante, mas é difícil ver alguma tendência
a não ser a do Bolsonaro. Transformando a escala e ajustando um modelo
aditivo fica mais fácil.
</p>
<figure id="b092" class="graf graf--figure graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/1*ZueEZFu5Em3Hw7nZJImJCA.png">
</figure>
<p id="9947" class="graf graf--p graf-after--figure">
O número de compartilhamentos da Marina Silva vem diminuindo desde as
eleições de 2014. Os do Bolsonaro, subindo de maneira constante. Não dá
pra dizer muito sobre o Lula com uma conta tão nova. O Twitter do
Alckmin teve um salto nos compartilhamentos à partir de Outubro de 2017,
mais ou menos na época que ficou mais certo que ele seria o candidato do
PSDB. Acho que os marqueteiros já entraram em ação.
</p>
<p id="a7c6" class="graf graf--p graf-after--p">
Com um gráfico da variação do número de compartilhamentos ao longo do
tempo, as variações ficam ainda mais evidentes. Veja a figura abaixo.
Nela, podemos ver o número de retweets de cada postagem ao londo do
tempo. As escalas de tempo são diferentes já que os candidatos levaram
tempos diferentes para postar as 3200 últimas mensagens.
</p>

<figure id="7b71" class="graf graf--figure graf--layoutOutsetCenter graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/2000/1*bsYPrpcU5zX2F0J3bNWeaw.png">
</figure>

<p id="02a3" class="graf graf--p graf-after--figure">
Na figura acima dá para ver algumas coisas:
</p>
<ul class="postList">
<li id="810e" class="graf graf--li graf-after--p">
O aumento repentino no número de retweets do Alckmin no fim de Outubro
</li>
<li id="b9da" class="graf graf--li graf-after--li">
O número de postagens da conta do Lula é bem irregular ao longo do tempo
</li>
<li id="7386" class="graf graf--li graf-after--li">
Nos tweets analisados ainda há mensagens das eleições de 2014. Veja como
o engajamento na conta da Marina Silva foi muito maior nessa época
</li>
<li id="a090" class="graf graf--li graf-after--li">
As mensagens do Bolsonaro estão sendo consistentemente mais
compartilhadas
</li>
</ul>
<p id="99eb" class="graf graf--p graf-after--li">
Agora, que tipo de tweet de cada candidato gera mais compartilhamentos?
Olhando para as palavras que mais ocorrem nos 300 tweets mais
compartilhados de cada candidato, temos isso:
</p>
<figure id="d7d7" class="graf graf--figure graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/1*N-zly9nJdCwPHcszJQgT4A.png">
</figure>
<p id="43e6" class="graf graf--p graf-after--figure">
Os tweets do Alckmin que falam do Estado de São Paulo, como entrega de
obras, parecem fazer mais sucesso. Os do Bolsonaro são aqueles que falam
do PT, corrupção, esquerda. Nos do Lula não consegui ver muita coisa,
mas parece ser aqueles que falam de voltar à Presidência, povo, e da sua
caravana. Os da Marina são residuais da campanha de 2014.
</p>
<p id="93d6" class="graf graf--p graf-after--p">
Uma outra pergunta que fica é quanto ao horário da postagem. Será que
isso faz diferença? Os candidatos postam praticamente o dia todo.
Certamente, são assessores que cuidam das contas. Provavelmente mais de
um por presidenciável.
</p>
<figure id="be6e" class="graf graf--figure graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/1*ZPtapHqpPymhzvzttLforw.png">
</figure>
<p id="8add" class="graf graf--p graf-after--figure">
A maioria das postagens do Alckmin são feitas à noite. Deve ser o
horário de trabalho de algum assessor ou uma forma de tentar maior
penetração. A conta do Lula posta mais por volta do meio-dia e depois
das 21 horas. A da Marina apresenta padrão similar. Bolsonaro posta
durante todo o dia.
</p>
<p id="f5fa" class="graf graf--p graf-after--p">
O horário da postagem não parece fazer muita diferença no número de
retuítes. Só no caso da Marina Silva é que dá pra ver claramente que as
postagens dela da época da eleição que foram feitas depois da meia-noite
tiveram mais compartilhamentos. Provavelmente apareceram em primeiro nas
timelines quando o pessoal acordava no dia seguinte. Enfim, teria que
testar tudo isso pra ver se há alguma influência de fato.
</p>
<figure id="5bfa" class="graf graf--figure graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/1*TPk1oSOcDxmVAf0STQx2pQ.png">
</figure>
<p id="e140" class="graf graf--p graf-after--figure">
Seria interessante saber que tipo de tweet foi realmente postado por
cada candidato, mas é difícil. Na conta do Trump, por exemplo, havia até
um tempo atrás praticamente certeza que todos os tweets vindos do
Android eram dele mesmo e os de outros meios, de assessores. Isso gerou
um conjunto de validação valioso que permite usar
<a href="http://didtrumptweetit.com/" class="markup--anchor markup--p-anchor">machine
learning</a> para ver, atualmente, quem de fato posta cada mensagem
dele.
</p>
<p id="cae5" class="graf graf--p graf-after--p">
Olhando para as tendências de postagem por dispositivo, algumas coisas
aparecem. Note que na figura abaixo as escalas temporais são diferentes
para cada candidato, novamente para acomodar os últimos 3200 tweets.
</p>
<figure id="6713" class="graf graf--figure graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/1*i_-kPCNh_Thhqt88nnyJpw.png">
</figure>
<p id="25d7" class="graf graf--p graf-after--figure">
A maioria dos tweets dos candidatos vêm de iPhones ou de navegadores. A
conta do Lula posta de vários dispositivos, indicando vários assessores.
As mensagens do Bolsonaro são provenientes principalmente de iPhones,
mas não acho que seja ele quem de fato as digita. Quando ele foi
fotografado conversando pelo Whatsapp com um dos filhos, o dispositivo
era um Android e a conta dele nunca postou de um Android. A Marina
sempre postou principalmente via navegador, assim como o Alckmin.
</p>
<p id="d4ef" class="graf graf--p graf-after--p">
Creio que no final das contas o que mais importa para determinar o
número de retweets é quem de fato cria a postagem. Os seguidores
percebem e concordam com o tom dessas mensagens. Mesmo quando o
candidato apenas transmite o que deve ser escrito para que outra pessoa
poste.
</p>
<p id="ea91" class="graf graf--p graf-after--p">
Para finalizar e por pura curiosidade, abaixo os dois tweets com mais
compartilhamentos de cada candidato. Mais uma vez, o código desta
postagem está no meu
<a href="https://www.github.com/gustavobio" class="markup--anchor markup--p-anchor">github</a>.
</p>
<figure id="d06c" class="graf graf--figure graf--iframe graf-after--h3">

</figure>
<figure id="47ab" class="graf graf--figure graf--iframe graf-after--figure">

</figure>
<figure id="9e4a" class="graf graf--figure graf--iframe graf-after--h3">

</figure>
<figure id="8c9d" class="graf graf--figure graf--iframe graf-after--figure">

</figure>
<figure id="bd32" class="graf graf--figure graf--iframe graf-after--h3">

</figure>
<figure id="b4d9" class="graf graf--figure graf--iframe graf-after--figure">

</figure>
<figure id="6e35" class="graf graf--figure graf--iframe graf-after--h3">

</figure>
<figure id="641c" class="graf graf--figure graf--iframe graf-after--figure graf--trailing">

</figure>

