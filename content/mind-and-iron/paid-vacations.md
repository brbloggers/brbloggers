+++
title = "Férias Pagas"
date = "2017-02-11"
categories = ["mind-and-iron"]
original_url = "http://ctlente.com/pt/paid-vacations/"
+++

<p>
Caso você não saiba (assim como eu mesmo não sabia até alguns dias
atrás), os nossos deputados federais têm direito a uma Cota para o
Exercício da Atividade Parlamentar (CEAP), ou seja “\[uma quantia\]
destinada a custear os gastos dos deputados exclusivamente vinculados ao
exercício da atividade parlamentar”.
</p>
<p>
Cada deputado tem direito a R$42.000,00 reembolsáveis todo mês, variando
um pouco de estado para estado.
</p>
<p>
Já que os dados sobre todos os reembolsos requisitados estão disponíveis
no
<a href="http://www2.camara.leg.br/transparencia/cota-para-exercicio-da-atividade-parlamentar/dados-abertos-cota-parlamentar">portal
da transparência</a> da Câmara, eu decidi fazer uma pequena análise para
descobrir se os deputados usaram a CEAP adequadamente em 2016. Ao meu
ver há duas formas de identificar reembolsos irregulares dada a
informação disponível:
</p>
<ul>
<li>
Se a categoria do reembolso for suspeita
</li>
<li>
Se o componente temporal do reembolso for suspeito
</li>
</ul>
<p>
Começemos pelo primeiro caminho.
</p>
<p>
Quando os deputados requisitam um reembolso, eles precisam inserí-lo em
uma das 17 categorias possíveis, dentre as quais temos “telefonia”,
“combustíveis e lubrificantes”, “emissão de bilhete aéreo”, etc. Para
ter uma ideia de com o que eu estava lidando, somei o valor de todos os
reembolsos atrelados a cada categoria e criei um gráfico com as top 7.
</p>
<img src="http://ctlente.com/paid-vacations/bar.png" alt="">

<p>
A categoria que custou mais para o bolso do brasileiro foi uma certa
surpresa para mim: divulgação da atividade parlamentar. Essa categoria
representou mais ou menos 23% (R$48.645.429,54) de um total de 212
milhões de reais reembolsados no ano passado.
</p>
<p>
Vendo esses números e o título estranhamente vago da categoria, fiquei
com a impressão de que ela estaria sendo utilizada por deputados para
cobrir gastos pessoais. De modo a ter certeza de que eu não estava sendo
rápido demais em meu julgamento, criei box-plots das 7 categorias com
maiores reembolsos medianos para que eu pudesse analisar seus outliers.
</p>
<img src="http://ctlente.com/paid-vacations/box.png" alt="">

<p>
Na imagem acima podemos ver que divulgação de atividade parlamentar
(terceiro box da esquerda para a direita) não tem a maior mediana, mas
seus outliers se destacam muito do resto. Se examinarmos o ponto mais
alto da figura toda, vemos que ele representa um deputado reembolsando
um total de R$184.500,00 gastos em <em>uma pequena gráfica</em>.
</p>
<p>
Esses outliers (muitos dos quais estouram o teto de reembolso mensal de
qualquer estado) corroboram para a teoria de que a divulgação de
atividade parlamentar está sendo usada para enrriquecimento pessoal por
parte de nossos deputados.
</p>

<p>
Partindo para a análise do componente temporal, tirei a média do valor
dos reembolsos de cada dia do ano; com isso pode-se descobrir se existe
algum período em que os reembolsos ficam mais caros.
</p>
<p>
Depois de criar inúmeras visualizações com essas médias (que você pode
reproduzir com o código disponível no
<a href="https://github.com/ctlente/Kaggle/tree/master/House">meu
repositório</a>), achei algo estranho no gráfico abaixo. Ele representa
a
<a href="https://pt.wikipedia.org/wiki/Fun%C3%A7%C3%A3o_densidade">distribuição
de densidade</a> do valor médio dos reembolsos de cada dia. Veja se você
consegue identificar o que chamou minha atenção…
</p>
<img src="http://ctlente.com/paid-vacations/density.png" alt="">

<p>
Observe as pequenas “lombadas” depois da marca dos 1,5 mil reais. Elas
idicam que há um número grande, porém irregular, de dias em que a média
do valor dos reembolsos estoura. Se encontrarmos um padrão teporal na
distribuição desses outliers, isso pode significar que existe algo
suspeito acontecendo.
</p>
<p>
Para estudar essa hipótese, gerei a série temporal do valor do reembolso
médio dia a dia. As subidas e descidas ao longo do ano são as tendências
semanais, mas preste atenção ao que acontece no lado direito do gráfico.
</p>
<img src="http://ctlente.com/paid-vacations/ts.png" alt="">

<p>
O pico em torno do final de dezembro e o início de janeiro representa
que nesses dias os reembolsos tiveram em média valores muito altos. Se
juntarmos isso com uma informação extra do portal da Câmara, vemos que
esse aumento repentino do valor se concentra no período após o dia 23 de
dezembro (linha laranja vertical), em que os deputados saem de férias.
</p>
<p>
Na minha opinião essa série temporal mostra que alguns deputados podem
estar utilizando A CEAP para pagar por suas férias.
</p>

<p>
Esta não foi de maneira alguma uma análise exaustiva, mas mostra
indícios de que nossos deputados estão usando dinheiro público para
cobrir despesas pessoais. No começo nos propusemos a investigar apenas
dois aspectos da base de dados e já fomos capazes de encontrar atividade
suspeita em ambos; provavelmente ainda há muitas outras formas de olhar
para esses dados para as quais não tive tempo ou habilidade, então lhes
encorajo a que tentem explorar as “maravilhas” da CEAP por conta
própria.
</p>
<p>
Se você quiser ver a versão a interativa da análise deste artigo ou
baixar os dados que utilizei, visite meu Kaggle Kernel
<a href="https://www.kaggle.com/ctlente/d/epattaro/brazils-house-of-deputies-reimbursements/paid-vacations-brazil-s-house-of-deputies">Paid
Vacations - Brazil’s House of Deputies</a>. E se você quiser ver outros
estudos sobre a CEAP, eu sugiro que você entre no site da
<a href="https://serenatadeamor.org/">Operação Serenata de Amor</a>.
</p>

