+++
title = "t-SNE"
date = "2016-12-15"
categories = ["dfalbel"]
original_url = "http://dfalbel.github.io/2016/12/tsne.html"
+++

<article class="post-content">
<p>
t-SNE: t-Distributed Stochastic Neighbor Embedding é uma técnica de
<a href="https://en.wikipedia.org/wiki/Dimensionality_reduction">redução
de dimensionalidade</a> que é particularmente bem adaptada para
visualizar bancos de dados com muitas dimensões.
</p>
<p>
A
<a href="https://lvdmaaten.github.io/publications/papers/JMLR_2008.pdf">técnica
foi introduzida</a> em 2008 por Laurens van der Maaten e Geoffrey
Hinton, o segundo bem famoso por causa do seu trabalho com redes
neurais. Hinton é um dos primeiros pesquisadores a treinar redes neurais
de muitas camadas usando backpropagation.
</p>
<p>
O objetivo do t-SNE é a partir de um conjunto de pontos em um espaço
multi-dimensional encontrar uma representação fiel desses pontos em um
espaço de dimensão menor, geralmente um plano 2D. O algoritmo é
não-linear e se adapta aos dados, realizando diferentes transformações
em diferentes regiões do espaço multi-dimensional. O t-SNE é capaz de
capturar muito da estrutura local do espaço multi-dimensional enquanto
também revela a estrutura global do banco de dados como a presença de
<em>clusters</em>.
</p>
<p>
Neste post vamos tentar definir matematicamente (não muito
rigorosamente) o que é o t-SNE para depois mostrar algumas aplicações
usando o R.
</p>
<h2 id="definindo-melhor-matemticamente">
Definindo melhor matemáticamente
</h2>
<p>
O t-SNE é baseado no SNE com duas principais diferenças:
</p>
<ul>
<li>
usa uma função de custo simétrica que é mais fácil de otimizar
</li>
<li>
usa a distribuição <strong>t</strong> ao invés da distribuição Normal
para calcular a similaridade entre os pontos no espaço de dimensão
menor, o que também ajuda na otimização e no chamado <em>crowding
problem</em>.
</li>
</ul>
<p>
Em primeiro lugar, o t-SNE converte a matriz de distâncias euclidianas
nos espaço de maior dimensão em probabilidades condicionais que
representam similaridades. A similaridade entre dois pontos e é a
probabilidade condicional de pegar como seu vizinho se os vizinhos
fossem escolhidos em proporção à densidade de uma distribuição Normal
com média em .
</p>
<p>
Para pontos próximos, é relativamente alta e para pontos distantes será
muito pequena (para valores rasoáveis da variância da Normal escolhida).
</p>
<p>
Essa matriz não é simétrica e isso causa problemas, principalmente na
presença de outliers. Para corrigir isso, o t-SNE simplesmente
transforma a matriz de probabilidades condicionais em uma matriz de
probabilidades conjuntas, definindo
</p>
<p>
Em seguida, considere a representação num espaço de menor dimensão de .
Queremos que a matriz de similaridades entre e seja a mais parecida
possível das smimilaridades entre e .
</p>
<p>
Agora as similaridades entre e são definidas pela probabilidade de ter
como vizinho se os vizinhos fossem escolhidos proporcionalmente à
densidade de uma distribuição t de Student com 1 grau de liberdade
(equivalente a à distribuição Cauchy) com centro em .
</p>
<p>
O objetivo do t-SNE é que seja o mais parecido possível com . Para isso,
ele define uma função de custo (no caso a divergência de
Kullback-Leibler) e a minimiza usando o método do gradiente.
</p>
<p>
Para completar o problema, fica faltando apenas definir o valor de ,
variância da distribuição Normal utilizada para calcular as
similaridades no espaço de maior dimensão. Essa variância é definida a
partir de um hiper-parâmetro da técnica, chamado de perplexidade, que
pode ser interpretado pela quantidade de vizinhos muito próximos que
cada ponto tem. Esse parâmetro balanceia a <em>atenção</em> do modelo
pelos aspectos locais da estrutura dos dados e pelos aspectos mais
globais.
</p>
<p>
Claro que toda essa explciação foi feita por alguém que não entende
tanto do assunto, para se aprofundar, vale a pena ler com calma o
<a href="https://lvdmaaten.github.io/publications/papers/JMLR_2008.pdf">artigo
original</a> da técnica.
</p>
<h2 id="aplicao">
Aplicação
</h2>
<p>
No R existem dois pacotes que podem ser usados para o t-SNE:
</p>
<ul>
<li>
<a href="https://cran.r-project.org/web/packages/tsne/"><code class="highlighter-rouge">tsne</code></a>:
Em puro R, mais lento
</li>
<li>
<a href="https://github.com/jkrijthe/Rtsne"><code class="highlighter-rouge">Rtsne</code></a>
wrapper de um código em C++ (otimizado)
</li>
</ul>
<figure class="highlight">
<pre><code class="language-r"><span class="n">library</span><span class="p">(</span><span class="n">Rtsne</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">ggplot2</span><span class="p">)</span><span class="w"> </span><span class="n">iris_unicos</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">unique</span><span class="p">(</span><span class="n">iris</span><span class="p">)</span><span class="w">
</span><span class="n">tsne</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">Rtsne</span><span class="p">(</span><span class="n">as.matrix</span><span class="p">(</span><span class="n">iris_unicos</span><span class="p">[,</span><span class="m">1</span><span class="o">:</span><span class="m">4</span><span class="p">]),</span><span class="w"> </span><span class="n">perplexity</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">30</span><span class="p">)</span><span class="w"> </span><span class="c1"># Run TSNE
</span><span class="n">qplot</span><span class="p">(</span><span class="n">tsne</span><span class="o">$</span><span class="n">Y</span><span class="p">[,</span><span class="m">1</span><span class="p">],</span><span class="w"> </span><span class="n">tsne</span><span class="o">$</span><span class="n">Y</span><span class="p">[,</span><span class="m">2</span><span class="p">],</span><span class="w"> </span><span class="n">geom</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;point&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">colour</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">iris_unicos</span><span class="o">$</span><span class="n">Species</span><span class="p">)</span><span class="w"> </span><span class="err">#</span><span class="w"> </span><span class="n">Plot</span><span class="w"> </span><span class="n">the</span><span class="w"> </span><span class="n">result</span></code></pre>
</figure>
<p>
<img src="http://dfalbel.github.io/images/2016-12-15-tsne/unnamed-chunk-1-1.png" alt="plot of chunk unnamed-chunk-1">
</p>
<p>
Essa é uma aplicação bem simples. No próximo post irei aplicar o t-SNE
em bancos de dados mais interessantes. Por enquanto, mostro aqui alguns
exemplos de visualizações obtidas por outras pessoas.
</p>
<p>
Abaixo, a visualização do
<a href="http://yann.lecun.com/exdb/mnist/">banco de dados MNIST</a>
</p>
<p>
<img src="https://lvdmaaten.github.io/tsne/examples/mnist_tsne.jpg" alt="mnist">
</p>
<p>
A técninca funcionou muito bem também no
<a href="http://qwone.com/~jason/20Newsgroups/">http://qwone.com/~jason/20Newsgroups/</a>
</p>
<p>
<img src="https://lvdmaaten.github.io/tsne/examples/20news_tsne.jpg" alt="20news">
</p>
<h2 id="referncias">
Referências
</h2>
<p>
Quase tudo que eu escrevi aqui pode ser encontrado nos seguintes links:
</p>
<p>
Outros lugares com usos interessantes:
</p>
<ul>
<li>
<a href="https://research.googleblog.com/2016/12/open-sourcing-embedding-projector-tool.html">Blog
de pesquisa do Google</a>
</li>
</ul>
<p>
Inclusive, você pode fazer quantos você quiser usando o novo
<a href="http://projector.tensorflow.org/">http://projector.tensorflow.org/</a>.
</p>
<p>
Além de visualizações essa técnica tem sido bastante utilizada como
<em>feature engneering</em> em copetições de machine learning. No
<a href="https://numer.ai/">Numerai</a>, por exemplo, é responsável por
melhorar bastante os resultados.
</p>
</article>

