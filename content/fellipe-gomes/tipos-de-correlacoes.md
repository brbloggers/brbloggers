+++
title = "Tipos de Correlacoes"
date = "2017-12-01"
categories = ["fellipe-gomes"]
original_url = "https://gomesfellipe.github.io/post/tipos-de-correlacoes/"
+++

<p id="main">
<article class="post">
<header>
</header>
<p>
De maneira geral, quando estamos interessados em avaliar o grau de
associação entre duas variáveis calculamos os <em>coeficientes de
associação</em> ou <em>correlação</em> entre variáveis.
</p>
<p>
Essas medidas descrevem por meio de um único número a associação (ou
dependência) entre duas variáveis.
</p>
<p>
De modo a facilitar a compreensão, esses coeficientes geralmente variam
entre 0 e 1 ou entre -1 e +1, de maneira que a proximidade de zero
indique a falta de associação entre elas.
</p>
<p>
Existem muitas medidas disponíveis para quantificar a associação entre
variáveis, porém, um primeiro conceito que deve ser levado em conta é:
quais são os tipos de variáveis?
</p>

<p>
Existem dois tipos de variáveis que podem ser abordadas de maneiras
diferentes, veja:
</p>
<p>
<strong>Quantitativas</strong>
</p>
<ul>
<li>
Continua: Medidas (Peso, altura, renda, dinheiro, comprimento)
</li>
<li>
Discreta: Contagem (qnt. de coisas)
</li>
</ul>
<p>
<strong>Qualitativas</strong>
</p>
<ul>
<li>
Nominais: Nomes
</li>
<li>
Ordinais: Quando é possível ordenar os arquivos
</li>
</ul>
<p>
E para cada relação ou associação que buscamos calcular, existe um tipo
diferente de coeficiente, mas de maneira geral, todos eles possuem tais
características em comum:
</p>

<p>
Coeficientes de correlação informam:
</p>
<ul>
<li>
Intensidade
<ul>
<li>
Fortemente relacionadas (Valores próximos de 1 ou -1)
</li>
<li>
Fracamente relacionadas (Valores próximos de 0)
</li>
</ul>
</li>
<li>
Direção
<ul>
<li>
Positiva (Se ambas as variáveis crescem no mesmo sentido)
</li>
<li>
Negativa (Se as variáveis crescem em sentidos opostos)
</li>
</ul>
</li>
<li>
Significância
</li>
</ul>
<p>
IMPORTANTE: CORRELAÇÃO NÃO INDICA RELAÇÃO DE CAUSALIDADE
</p>
<p>
E além dos coeficientes de correlação, existem outras medidas de
associação igualmente importantes, veja:
</p>
<p>
Sejam duas variáveis X e Y, ambas quantitativas, preferencialmente
contínuas. A existência de relação linear entre essas variáveis pode ser
detectada com auxílio do Diagrama de Dispersão, mas, também, com auxílio
do Coeficiente de Correlação Linear de Pearson.
</p>

<p>
Utilizado quando não existe normalidade e/ou não existe relação linear,
deve ser usado quando não se deseja utilizar nenhuma suposição de
normalidade ou da presença de qualquer outra distribuição para a
variável ou para a estatística de teste.
</p>
<p>
Este coeficiente se baseia nos postos das observações dentro de cada
variável e se baseia sobre as diferenças entre os postos observados, nas
variáveis X e Y, para um mesmo objeto de estudo.
</p>
<p>
Ideal quando temos variáveis medidas apenas em uma escala ordinal.
</p>

<p>
O coeficiente de correlação Tau de Kendall serve para verificar se
existe correlação entre duas variáveis ordinais. É um método adequado
quando amostras têm tamanhos reduzidos, pois o método é mais preciso. E
pode ser estendido a correlações parciais, quando o efeito de uma
terceira variável, que age sobre X e Y, é retirado antes de determinar
se X e Y estão relacionadas.
</p>
<p>
Coeficiente de Kendall é, muitas vezes, interpretado como uma medida de
concordância entre dois conjuntos de classificações relativas a um
conjunto de objetos de estudo.
</p>

<p>
Utiliza-se esta prova quando os dados da pesquisa se apresentam sob
forma de frequências em categorias discretas. Pode aplicar a prova <span
class="math inline">*χ*<sup>2</sup></span> para determinar a
significância de diferenças entre dois grupos independentes e
conseqüentemente, com respeito a frequências relativas com que os
componentes do grupo se enquadram nas diversas categorias.
</p>
<p>
Suas hipóteses:
</p>
<p>
<span class="math display">
$$ H\_0: \\text{S&\#xE3;o independentes (N&\#xE3;o associadas)} \\\\ H\_1: \\text{N&\#xE3;o s&\#xE3;o independentes (S&\#xE3;o associadas) } $$
</span>
</p>

<p>
O teste qui-quadrado quando aplicado a amostras pequenas, como por
exemplo com tamanho inferior a 20, veja:
</p>

<p>
os testes fornecem apenas a resposta se as variáveis estão ou não
correlacionadas. Para saber a intensidade desta relação, utilizam-se
medidas de associação.
</p>
<p>
Considere as seguintes medidas:
</p>
<p>
O coeficiente phi é uma medida de associação entre duas variáveis
binárias. A interpretação é similar a de um coeficiente de correlação.
Duas variáveis binárias são consideradas positivamente associadas se a
maior parte dos dados (frequências) cai ao longo das células da diagonal
(a e d maiores que b e c). E serão consideradas negativamente associadas
se a maior parte dos dados cai fora da diagonal.
</p>

<p>
O coeficiente V de Cramer serve para medir associação em tabelas não
quadradas.
</p>

<p>
O Coeficiente de Contingência C é uma medida de associação, relacionada
à estatística de teste do teste qui-quadrado, e ajustada para diferentes
tamanhos de amostra. Ele também está diretamente relacionado à
estatística de teste do teste qui-quadrado e ao Coeficiente Phi (possui
as mesmas vantagens e desvantagens de Phi).
</p>
<p>
Ambos variam de 0 (ausência de associação) a 1 (associação muito forte).
</p>

<p>
O coeficiente Kappa é uma medida de concordância inter observador e mede
o grau de concordância além do que seria esperado só por conta do acaso.
Muitas vezes é usado no lugar do teste de McNemar.
</p>
<p>
<strong>Obs</strong>: Também pode ser utilizado o coeficiente de Kappa
ponderado
</p>

<p>
É impressionante a gama de opções que já existe para avaliarmos
variáveis por diversas perspectivas!
</p>
<p>
É bom ressaltar que é extremamente fácil se perder no meio de tantos
resultados em tantas situações possíveis, por isso meu
<a href="https://gomesfellipe.github.io/post/tipos-de-relacoes-entre-variaveis/">próximo
post</a> irá tratar justamente dos diferentes tipos de relações entre
variáveis e quais tipos de medidas são possíveis para cada caso, até a
próxima!
</p>

<footer>
<ul class="stats">
<li>
Categories
</li>
<li>
<a href="https://gomesfellipe.github.io/categories/r">R</a>
</li>
<li>
<a href="https://gomesfellipe.github.io/categories/estatistica">Estatistica</a>
</li>
<li>
<a href="https://gomesfellipe.github.io/categories/teoria">Teoria</a>
</li>
</ul>
</footer>
</article>
<article class="post">
<a href="https://disqus.com/" class="dsq-brlink">comments powered by
</a>
</article>
</p>

