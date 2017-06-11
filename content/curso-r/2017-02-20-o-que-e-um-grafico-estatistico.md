+++
title = "O que é um gráfico estatístico?"
date = "2017-02-20 20:26:00"
categories = ["curso-r"]
+++

<p>
Os gráficos são técnicas de visualização de dados amplamente utilizadas
em todas as áreas da pesquisa. A sua popularidade se deve à maneira como
elucidam informações que estavam escondidas nas colunas do banco de
dados, sendo que muitos deles podem ser compreendidos até mesmo por
leigos no assunto que está sendo discutido.
</p>
<p>
Mas será que podemos definir formalmente o que é um gráfico estatístico?
</p>
<p>
<img src="http://curso-r.com/blog/2017-02-20-o-que-e-um-grafico-estatistico_files/figure-html/unnamed-chunk-1-1.png" width="672">
</p>
<p>
Graças ao estatístico norte-americano Leland Wilkinson, a resposta é
sim.
</p>
<p>
Em 2005, Leland publicou o livro <em>The Grammar of Graphics</em>, uma
fonte de princípios fundamentais para a construção de gráficos
estatísticos. No livro, ele defende que um gráfico é o mapeamento dos
dados a partir de atributos estéticos (posição, cor, forma, tamanho) de
objetos geométricos (pontos, linhas, barras, caixas). Simples assim.
</p>
<p>
Além de responder a pergunta levantada nesse post, os conceitos de
Leland tiveram outra grande importância para a visualização de dados.
Alguns anos mais tarde, o seu trabalho inspirou Hadley Wickham a criar o
pacote <code>ggplot2</code>, que enterrou com muitas pás de terra as
funções gráficas do R base.
</p>
<p>
Em <em>A Layered Grammar of Graphics</em>, Hadley sugeriu que os
principais aspectos de um gráfico (dados, sistema de coordenadas,
rótulos e anotações) podiam ser divididos em camadas, construídas uma a
uma na elaboração do gráfico. Essa é a essência do <code>ggplot2</code>.
</p>
<p>
No gráfico abaixo, temos informação de 32 carros com respeito a 4
variáveis: milhas por galão, tonelagem, transmissão e número de
cilindros. O objeto geométrico escolhido para representar os dados foi o
<strong>ponto</strong>. As posições dos pontos no eixo xy mapeia a
associação entre a tonelagem e a quantidade de milhas por galão. A cor
dos pontos mapeia o número de cilindros de cada carro, enquanto a forma
dos pontos mapeia o tipo de transmissão. Observando o código, fica claro
como cada linha/camada representa um aspecto diferente do gráfico.
</p>
<p>
Os conceitos criados por Leland e Hadley defendem que essa estrutura
pode ser utilizada para construir e entender qualquer tipo de gráfico,
dando a eles, dessa maneira, a sua definição formal.
</p>
<pre class="r"><code>ggplot(mtcars) + geom_point(aes(x = disp, y = mpg, shape = as.factor(am), color = cyl)) + labs(x = &quot;Tonelagem&quot;, y = &quot;Milhas por gal&#xE3;o&quot;, shape = &quot;Transmiss&#xE3;o&quot;, color = &quot;Cilindros&quot;) + scale_shape_discrete(labels = c(&quot;Autom&#xE1;tica&quot;,&quot;Manual&quot;)) + theme_bw() + theme(legend.position = &quot;bottom&quot;) </code></pre>
<p>
<img src="http://curso-r.com/blog/2017-02-20-o-que-e-um-grafico-estatistico_files/figure-html/unnamed-chunk-2-1.png" width="672">
</p>
<p>
Por fim, é preciso frisar que, apesar de a gramática prover uma forte
fundação para a construção de gráficos, ela não indica qual gráfico deve
ser usado ou como ele deve parecer. Essas escolhas, fundamentadas na
pergunta a ser respondida, nem sempre são triviais, e negligenciá-las
pode gerar gráficos mal construídos e conclusões equivocadas. Cabe a
nós, estatísticos, desenvolver, aprimorar e divulgar as técnicas de
visualização adequadas para cada tipo de variável, assim como apontar ou
denunciar os usos incorretos e mal-intencionados. Mas, em um mundo cuja
veracidade das notícias é cada vez menos importante, é papel de todos
ter senso crítico para entender e julgar as informações trazidas por um
gráfico.
</p>

