+++
title = "Iniciando na linguagem Python"
date = "2017-12-10"
categories = ["fellipe-gomes"]
original_url = "https://gomesfellipe.github.io/post/python/b%C3%A1sico-de-python/"
+++

<p id="main">
<article class="post">
<header>
</header>
<img src="https://gomesfellipe.github.io/img/2017-12-10-b&#xE1;sico-de-python/imagem1.png">

<p>
Python e R são as duas linguagens de programação mais utilizadas pelos
cientistas de dados. Basta navegar pelas soluções de machine learning do
<a href="https://www.kaggle.com/">Kaggle</a> (Um playgroud para nós) que
iremos notar que essas linguagens de programação são utilizadas de forma
massiva nas análises.
</p>
<p>
Todo bom programador entende que programar <strong>NÃO</strong> é a
mesma coisa que decorar. Uma linguagem de programação tem vários
comandos e ninguém precisa decorar todos eles. Certamente nós iremos
memorizar muitos comandos de cabeça mas isso é possível apenas depois de
praticar, praticar, praticar… (e praticar mais um pouquinho…)
</p>
<p>
A linguagem Python é muito interessante por sua simplicidade e
objetividade, é uma linguagem fácil de aprender, muito poderosa e possui
uma comunidade muito grande. É livre e inúmeras pessoas contribuem para
a linguagem (inclusive você também pode contribuir).
</p>
<p>
Como o estudo de uma linguagem de programação envolve muita consulta nos
materiais e comandos básicos, resolvi unir neste post uma especie de
“manual” para usuários iniciantes que volta e meia precisam tirar uma
dúvida ou curiosidade (diga-se de passagem, a dúvida e curiosidade são
as melhores amigas de um cientista de dados!)
</p>

<p>
Para instalar o Python no windowns, basta aessar o
<a href="https://gomesfellipe.github.io/post/python/b%C3%A1sico-de-python/www.python.org">site
oficial</a> e baixar a versão mais recente
(<a href="https://www.python.org/ftp/python/3.6.3/python-3.6.3.exe">python-3.6.3</a>)
e seguir com o instalador.
</p>
<p>
Após isso , precisamos de algum Ambiente Integrado de Desenvolvimento
(IDE, do inglês “Integrated Development Environment”), pois a linguagem
python por si só não oferece editores de código ou ambientes de
programação.
</p>
<p>
Existem diversos ambientes como o
<a href="https://www.jetbrains.com/pycharm/">PyCharm</a>, o
<a href="https://github.com/yhat/rodeo">Rodeo</a> (esse parece mais com
o <a href="https://www.rstudio.com/">RStudio</a>). Até mesmo o próprio
<a href="https://www.rstudio.com/">RStudio</a> pode compilar a linguagem
Python através de
<a href="https://cran.r-project.org/web/packages/reticulate/index.html">pacotes</a>
ou pelo
<a href="https://gomesfellipe.github.io/post/python/b%C3%A1sico-de-python/rmarkdown.rstudio.com/">Rmarkdown</a>.
</p>
<p>
Pretendo abordar melhor este assunto de compilar Python dentro do R em
um próximo post.
</p>
<p>
Um dos IDEs mais utilizados por diversas razões é o
<a href="https://jupyter.org/">Jupyter</a> que pode ser instalado
diretamente do link do download. O jupyter irá pedir para que
<a href="https://www.anaconda.com/download/">Anaconda</a> seja instalado
neste mesmo link basta seguir as instruções e estaremos prontos para
rodar todos os comandos de python s seguir!
</p>

<p>
Em python tudo é tratado como objeto, até funções são objetos. A seguir
podemos conferir quais os tipos de variáveis podem ser encontradas.
</p>
<ul>
<li>
Tipos Integrais:
<ul>
<li>
Inteiro: (<strong>int</strong>)
</li>
<li>
Lógico (ou Booleano): (<strong>bool</strong>)
</li>
</ul>
</li>
<li>
Tipos de Ponto-Flutuante
<ul>
<li>
Número de ponto-flutuante: (<strong>float</strong>)
</li>
<li>
Número Complexo: (<strong>complex</strong>)
</li>
</ul>
</li>
<li>
String (<strong>str</strong>)
</li>
</ul>

<ul>
<li>
<code>int()</code>: para inteiro
</li>
<li>
<code>float()</code>: para ponto flutuante
</li>
<li>
<code>bool()</code>: para booleano
</li>
<li>
<code>str()</code>: para string
</li>
</ul>

<ul>
<li>
<code>+</code>: Operador numérico positivo
</li>
<li>
<code>-</code>: Operador numérico negativo
</li>
<li>
<code>not</code>: Operador lógico de negação
</li>
</ul>

<ul>
<li>
<code>+</code>: Soma
</li>
<li>
<code>-</code>: Subtração
</li>
<li>
<code>&lt;/code&gt;\* : Produto
</li>
<li>
<code>/</code>: Divisão de ponto flutuante
</li>
<li>
<code>//</code>: Divisão inteira
</li>
<li>
<code>%</code>: Resto da divisão inteira
</li>
<li>
<code>\*&lt;/code&gt;\*: Potencialização
</li>
</ul>

<ul>
<li>
<code>or</code>: Disjunção lógica ou soma lógica
</li>
<li>
<code>and</code>: Conjunção lógica ou produto lógico
</li>
</ul>

<ul>
<li>
<code>==</code>: Igual a
</li>
<li>
<code>!=</code>: Diferente de
</li>
<li>
<code>&gt;</code>: Maior que
</li>
<li>
<code>&lt;</code>: Menor que
</li>
<li>
<code>&gt;=</code>: Maior ou igual
</li>
<li>
<code>&lt;=</code>: Menor ou igual
</li>
</ul>

<p>
A estrutura de repetição indefinida <strong>while</strong> deve ser
utilizada quando se deseja executar zero ou mais vezes uma suite
enquanto a condição estipulada for verdadeira.
</p>
<p>
Exemplo de uso:
</p>
<pre class="python"><code>i=1
while i&lt;=10: print(i, end=&quot; &quot;) i=i+1
print()</code></pre>
<pre><code>## 1 2 3 4 5 6 7 8 9 10</code></pre>

<p>
A estrutura de repetição definida \*\*for\* deve ser utilizada quando se
deseja, um determinado número de vezes, executar uma mesma suite,
enumerado ou nao por uma lista de valores.
</p>
<p>
Exemplo de uso:
</p>
<pre class="python"><code>for i in [2,3,4,5,6,7,8,9]: print(i, end=&quot; &quot;)
print()</code></pre>
<p>
Obs.: Para a estrutura de repetição definida com <code>for</code>,
podemos utilizar o comando <code>range()</code>, que fornece uma lista
com P.A. de itens de razão determinada (razão 1 como default), iniciada
pelo valor zero (ou um valor previamente definido) e termina no valor
que antecede o limite, exemplo:
</p>
<pre class="python"><code>print(range(7)) #[0,1,2,3,4,5,6]
print(range(7,20)) #[7,8,9,10,11,12,13,14,15,16,17,18,19]
print(range(10,50,5)) #[10,15,20,25,30,35,40,45]</code></pre>

<p>
Um vetor é um <strong>agregado</strong> de elementos (também chamados de
valores) de um <strong>mesmo</strong> tipo.
</p>
<p>
Imagine um vetor, do qual para a seleção de elementos dentro desse
vetor, podemos utilizar um índice ou seletor do elemento que indica sua
posição ou ordem.
</p>
<pre class="python"><code>vetor=[4,3,2,1] print(vetor[0])
print(vetor[3])</code></pre>
<ul>
<li>
Caracteristicas:
<ul>
<li>
É uma estrutura <strong>homogênea</strong>
</li>
<li>
Todos os elementos da estrutura são igualmente acessíveis
</li>
<li>
Cada elementro da estrutura tem um nome próprio
</li>
</ul>
</li>
</ul>
<p>
Um vetor pode ser simples ou estruturado
</p>
<ul>
<li>
A leitura de um vetor pode ser realizada:
<ul>
<li>
Elemento a elemento
</li>
<li>
Todas as informações podem ser lidas de uma vez, como uma linha de
caracteres, sobre o qual se aplica a operação <code>split()</code> para
separá-las
</li>
</ul>
</li>
<li>
A escrita de um vetor pode ser realizada;
<ul>
<li>
Toda de uma vez
</li>
<li>
Elemento a elemento
</li>
</ul>
</li>
</ul>

<p>
A matriz 2D é um vetor de vetores, vejamos um exemplo de uma matrix e
como acessar seus elementos:
</p>
<pre class="python"><code>aposta = [[&quot; &quot;,&quot;X&quot;,&quot; &quot;], [&quot; &quot;,&quot; &quot;,&quot;X&quot;], [&quot; &quot;,&quot;X&quot;,&quot; &quot;], [&quot;X&quot;,&quot; &quot;,&quot; &quot;], [&quot; &quot;,&quot;X&quot;,&quot; &quot;], [&quot; &quot;,&quot; &quot;,&quot;X&quot;], [&quot; &quot;,&quot;X&quot;,&quot; &quot;]] print(aposta) #Representa uma matriz de 7 linhas por 3 colunas
print(aposta[0]) #Representa a primeira linha da matriz
print(aposta[0][1]) #Representa o caractere da primeira linha da segunda coluna</code></pre>
<pre><code>## [[&apos; &apos;, &apos;X&apos;, &apos; &apos;], [&apos; &apos;, &apos; &apos;, &apos;X&apos;], [&apos; &apos;, &apos;X&apos;, &apos; &apos;], [&apos;X&apos;, &apos; &apos;, &apos; &apos;], [&apos; &apos;, &apos;X&apos;, &apos; &apos;], [&apos; &apos;, &apos; &apos;, &apos;X&apos;], [&apos; &apos;, &apos;X&apos;, &apos; &apos;]]
## [&apos; &apos;, &apos;X&apos;, &apos; &apos;]
## X</code></pre>
<p>
Em python, vetores e matrizes são implementados por listas, uma forma
alteranativa é utilizando a operação que <em>anexa um valor ao final de
uma lista</em>: <code>append()</code>
</p>

<p>
Um objeto do tipo <strong>str</strong> representa uma cadeia de
caracteres, de tamnho e valor imutáveis, veja um exemplo de declaração e
atribuição:
</p>
<pre class="python"><code>nome = &quot;Ana&quot;
print(len(nome)) # confima o comprimento ou quantidade de caracteres na string</code></pre>
<ul>
<li>
Comparação de Strings
<ul>
<li>
comparação lexicografica de strings com os operadores ==,!=, &lt;=,
&gt;=, &lt;, &gt;
</li>
</ul>
</li>
<li>
Indexação de cada caractere
<ul>
<li>
O tipo de String pode ser tratado tambem como vetor, vejamos:
</li>
</ul>
</li>
</ul>
<pre class="python"><code>#Se:
nome = &quot;Ana&quot;
#Ent&#xE3;o:
print(nome[0])
print(nome[1])
print(nome[2])</code></pre>
<pre><code>## A
## n
## a</code></pre>
<ul>
<li>
<p>
O operador <strong>+</strong>, quando aplicado a dois Strings <em>a</em>
e <em>b</em> retorna uma String concatenada das Strings <em>a</em> e
<em>b</em>
</p>
</li>
<li>
Método
<strong>find(</strong><em>subStringProcurada</em><strong>)</strong>
<ul>
<li>
Retorna a posição do indice da primeira ocorrencia da subStringProcurada
na String sendo consultada. Caso nao seja encontrada, retorna menor um
(-1)
</li>
</ul>
</li>
<li>
Outros métodos <strong>importantes</strong>:
<ul>
<li>
<code>replace(subStringProcurada, subStringNova)</code>
<ul>
<li>
Retorna uma copia da string sendo consultada, substituindo
</li>
</ul>
</li>
<li>
<code>count(subStringProcurada)</code>
<ul>
<li>
Retorna a quantidade de ocorrencias
</li>
</ul>
</li>
<li>
<code>upper()</code>
<ul>
<li>
Retorna uma cópia da String, convertendo tudo para maiúsculo
</li>
</ul>
</li>
<li>
<code>lower()</code>
<ul>
<li>
retorna uma cópia da String, convertendo tudo para minusculo
</li>
</ul>
</li>
<li>
<code>strip()</code>
<ul>
<li>
Retorna uma cópia da String, removendo todos caracteres brancos do
início e do final
</li>
</ul>
</li>
<li>
<code>split()</code>
<ul>
<li>
Retorna uma lista de todas as palavras String
</li>
</ul>
</li>
<li>
<code>split(subStringSeparadora)</code>
<ul>
<li>
Retorna uma lista de todas as palavras String, sendo o delimitador
procurado entre palavras aquele especificado em subStringSeparadora.
</li>
</ul>
</li>
</ul>
</li>
<li>
Metodos para leitura e escrita:
<ul>
<li>
<code>input()</code>, <code>readline</code>, <code>print</code>,
<code>write</code>
</li>
</ul>
</li>
</ul>

<p>
Uma sequência ordenada de zero ou mais referências a objetos. Tuplas
suportam o mesmo fatiamento, o mesmo acesso por iteradores e o mesmo
desempacotamento que Vetores e Strings. São imutáveis e pode ser vazia.
</p>
<p>
Exemplo:
</p>
<pre class="python"><code>vazio = tuple()
print(vazio)</code></pre>
<pre><code>## ()</code></pre>
<p>
Mais exemplos, agora de tuplas não vazias:
</p>
<pre class="python"><code>val = (&quot;abacaxi&quot;, 500, 4.99)
print(val)
#ou ainda:
val = &quot;abacaxi&quot;, 500, 4.99
print(val)</code></pre>
<pre><code>## (&apos;abacaxi&apos;, 500, 4.99)
## (&apos;abacaxi&apos;, 500, 4.99)</code></pre>
<ul>
<li>
<code>count(valor)</code>
<ul>
<li>
Retorna a quantidade de ocorrencias de um determinado valor da tupla,
exemplo:
</li>
</ul>
</li>
</ul>
<pre class="python"><code>v = (&quot;morango&quot;, 500, 4.99, 500)
print(v.count(500)) #Retorna quantidade</code></pre>
<pre><code>## 2</code></pre>
<ul>
<li>
<code>index(valor)</code>
<ul>
<li>
Retorna o índice da primeira ocorrência do valor informado como
argumento, exemplo:
</li>
</ul>
</li>
</ul>
<pre class="python"><code>v = (&quot;morango&quot;, 500, 4.99, 500)
print(v.index(500)) #Retorna indice</code></pre>
<pre><code>## 1</code></pre>

<ul>
<li>
<strong>concatenação:</strong> <em>a+b</em>
<ul>
<li>
Gera uma nova tupla a partir do conteúdo de a seguido de b
</li>
</ul>
</li>
<li>
<strong>replicação:</strong> \_a\*n\_
<ul>
<li>
Gera uma nova Tupla a partir do conteúdo de (a) repetida n-1 vezes
</li>
</ul>
</li>
<li>
<strong>fatiamento:</strong> a\[<em>posição inicial : posição
final+1</em>\]
<ul>
<li>
Gera uma nova Tupla a partir do subconjunto de elementos contidos em a
</li>
</ul>
</li>
<li>
<strong>atribuição incremental:</strong> <em>a +=b</em> ou \_a\*=n\_
<ul>
<li>
Equivalente a concatenação e repetição, porém atribui à variável (a) a
referência para a nova tupla gerada
</li>
</ul>
</li>
<li>
<strong>comparação:</strong> <em>&lt; , &lt;+ , == , !=, &gt;,
&gt;=</em>
</li>
<li>
<strong>associação:</strong> <em>in</em> e <em>not in</em>
<ul>
<li>
Verifica a pertinência de um valor em uma tupla
</li>
</ul>
</li>
</ul>

<p>
Uma lista é uma sequencia ordenada pelo índice, de zero ou mais
referências a objetos.
</p>
<p>
Características: \* É uma estrutura de dado recursiva \* Representada
por uma sequência, fechada por colchetes ( <strong>\[\*\* e
\*\*\]</strong>) \* O primeiro elemento esta na posição zero \* Lista
são mutáveis, podem receber novos elementos, substituir ou remover
antigos elementos
</p>
<ul>
<li>
Operações de <strong>inclusão</strong> de novos elementos:
<ul>
<li>
<code>apend(novoElemento)</code>: anexa um <em>novoElemento no
final</em> da lista
</li>
<li>
<code>insert(pos,novoElemento)</code>: insere o <em>novoElemento</em> na
posição <em>pos</em> da lista, caso essa posição não exista, será criada
</li>
</ul>
</li>
</ul>
<p>
Exemplo:
</p>
<pre class="python"><code>#Incluindo valores:
salada = [&quot;manda&quot;, &quot;pera&quot;, &quot;uva&quot;]
print(salada)
salada.append(&quot;banana&quot;) print(salada)
salada.insert(2,&quot;goiaba&quot;)
print(salada)</code></pre>
<pre><code>## [&apos;manda&apos;, &apos;pera&apos;, &apos;uva&apos;]
## [&apos;manda&apos;, &apos;pera&apos;, &apos;uva&apos;, &apos;banana&apos;]
## [&apos;manda&apos;, &apos;pera&apos;, &apos;goiaba&apos;, &apos;uva&apos;, &apos;banana&apos;]</code></pre>
<ul>
<li>
Operações de <strong>exclusão</strong>: de novos elementos:
<ul>
<li>
<strong>pop(</strong> <strong>)</strong>: retorna e remove o último
elemento da lista.
</li>
<li>
<strong>pop(</strong> <em>pos</em> <strong>)</strong>: retorna e remove
o elemento na posição <em>pos</em> da lista.
</li>
<li>
<strong>remove(</strong> <em>x</em> <strong>)</strong>: remove a
primeira ocorrência do item <em>x</em>.
</li>
</ul>
</li>
<li>
Outras operações úteis com listas:
<ul>
<li>
<strong>les(</strong> <strong>)</strong>: retorna o comprimento da
lista.
</li>
<li>
lista.<strong>count(</strong> <em>elemento</em> <strong>)</strong>:
retorna quantas vezes o <em>elemento</em> aparece na lista
</li>
<li>
lista.<strong>sort(</strong> <em>lista</em> <strong>)</strong>: ordena o
conteúdo da <em>lista</em>
</li>
</ul>
</li>
</ul>

<ul>
<li>
Fatiamento de Listas:
<ul>
<li>
<em>listaAntiga</em>\[<em>posInicio</em> : <em>posFim</em> \*\]\*:
retorna uma nova lista composta de referências para elementos existentes
na listAntiga
</li>
</ul>
</li>
</ul>
<p>
Exemplo:
</p>
<pre class="python"><code>saladaComposta = [&quot;banana&quot;, &quot;caju&quot;, &quot;uva&quot;, &quot;pera&quot;, &quot;manga&quot;, &quot;kiwi&quot;]
print(saladaComposta)
saladaSimples = saladaComposta[1:4]
print(saladaSimples)</code></pre>
<pre><code>## [&apos;banana&apos;, &apos;caju&apos;, &apos;uva&apos;, &apos;pera&apos;, &apos;manga&apos;, &apos;kiwi&apos;]
## [&apos;caju&apos;, &apos;uva&apos;, &apos;pera&apos;]</code></pre>

<p>
Os indices fazem referências a novas listas contidas no seu interior
</p>
<p>
Veja um exemplo:
</p>
<pre class="python"><code>mercado = [[&quot;pera&quot;, 100, 4.9], [&quot;manga&quot;, 20, 3.9], [&quot;uva&quot;, 30,5.9], [&quot;caju&quot;, 15.35]]
print(mercado)</code></pre>
<pre><code>## [[&apos;pera&apos;, 100, 4.9], [&apos;manga&apos;, 20, 3.9], [&apos;uva&apos;, 30, 5.9], [&apos;caju&apos;, 15.35]]</code></pre>
<p>
Confira:
</p>
<pre class="python"><code>#Seja a seguinte lista de listas:
mercado = [[&quot;pera&quot;, 100, 4.9], [&quot;manga&quot;, 20, 3.9], [&quot;uva&quot;, 30,5.9], [&quot;caju&quot;, 15.35]] print(mercado) mercado[1][2] *= 0.5 #Manga pela metade do pre&#xE7;o
print(mercado) mercado[3][1] -= 10 #caju com dez quilos a menos
print(mercado) mercado.remove([&quot;uva&quot;, 30,5.9]) #O produto uva &#xE9; removido do mercado
print(mercado) mercado.insert(1, [&quot;kiwi&quot;, 200, 1.99]) #O produto kiwi &#xE9; inserido
print(mercado)</code></pre>
<pre><code>## [[&apos;pera&apos;, 100, 4.9], [&apos;manga&apos;, 20, 3.9], [&apos;uva&apos;, 30, 5.9], [&apos;caju&apos;, 15.35]]
## [[&apos;pera&apos;, 100, 4.9], [&apos;manga&apos;, 20, 1.95], [&apos;uva&apos;, 30, 5.9], [&apos;caju&apos;, 15.35]]
## [[&apos;pera&apos;, 100, 4.9], [&apos;manga&apos;, 20, 1.95], [&apos;uva&apos;, 30, 5.9], [&apos;caju&apos;, 5.35]]
## [[&apos;pera&apos;, 100, 4.9], [&apos;manga&apos;, 20, 1.95], [&apos;caju&apos;, 5.35]]
## [[&apos;pera&apos;, 100, 4.9], [&apos;kiwi&apos;, 200, 1.99], [&apos;manga&apos;, 20, 1.95], [&apos;caju&apos;, 5.35]]</code></pre>

<p>
É uma estrutura de dados mutável, desordenada e sem elementos repetidos.
Seu uso se dá quando existe a necessidade de testar a pertinência de um
elemento em um conjunto ou eliminar dados duplicados.
</p>
<p>
Conjuntos suportam as operações matemáticas: união, interseção,
diferença etc..
</p>
<p>
Diferentemente dos vetores, conjuntos não têm seus elementos acesados
por um índice, no entanto são conjuntos iteráveis, podendo seus
elementos serem acessador por uma estrutura <strong>for</strong>.
</p>
<p>
Exemplo de conjunto:
</p>
<pre class="python"><code>base = set()
print(base)</code></pre>
<pre><code>## set()</code></pre>
<ul>
<li>
<code>.add()</code>
<ul>
<li>
Adiciona um elemento ao conjunto, caso o elemento ainda não esteja
presente
</li>
</ul>
</li>
</ul>
<pre class="python"><code>base = set()
base.add(5)
print(base)</code></pre>
<pre><code>## {5}</code></pre>
<ul>
<li>
<code>.discard()</code>
<ul>
<li>
retira um elemento do conjunto, caso o elemento esteja nele
</li>
</ul>
</li>
</ul>
<pre class="python"><code>base = {52,8,91,47}
base.discard(91)
print(base)</code></pre>
<pre><code>## {8, 52, 47}</code></pre>
<ul>
<li>
<code>len()</code>
<ul>
<li>
retorna a cardinalidade do conjunto (seu tamanho)
</li>
</ul>
</li>
</ul>
<pre class="python"><code>base = {52,8,91,47}
print(len(base))</code></pre>
<pre><code>## 4</code></pre>

<ul>
<li>
<code>a.union(b)</code> ou <code>a|b</code>
<ul>
<li>
retorna um novo conjunto resultante da união de <em>a</em> e <em>b</em>
</li>
</ul>
</li>
</ul>
<pre class="python"><code># Exemplos de uniao
a={1,3,4}.union({1,2,4})
print(a)
a={1,3,4}|{1,2,4}
print(a)</code></pre>
<pre><code>## {1, 2, 3, 4}
## {1, 2, 3, 4}</code></pre>
<ul>
<li>
<code>a.intersection(b)</code> ou <code>a&b</code>
<ul>
<li>
retorna um novo conjunto resultante da interseção de <em>a</em> e
<em>b</em>
</li>
</ul>
</li>
</ul>
<pre class="python"><code># Exemplo de interce&#xE7;&#xE3;o
a={1,3,4}.intersection({1,2,4})
print(a)
a={1,3,4}&amp;{1,2,4}
print(a)</code></pre>
<pre><code>## {1, 4}
## {1, 4}</code></pre>
<ul>
<li>
<code>a.difference(b)</code> ou <code>a-b</code>
<ul>
<li>
retorna um novo conjunto resultante da diferença entre <em>a</em> e
<em>b</em>, com todos elementos de <em>a</em> que não estão em
<em>b</em>
</li>
</ul>
</li>
</ul>
<pre class="python"><code># Exemplo de diferen&#xE7;a
a={1,3,4}.difference({1,2,4})
print(a)
a={1,3,4}-{1,2,4}
print(a)</code></pre>
<pre><code>## {3}
## {3}</code></pre>

<ul>
<li>
Igual <code>==</code> e Diferente <code>!=</code>
<ul>
<li>
é verdeiro se <em>a</em> contém os mesmo elementos que <em>b</em>
</li>
</ul>
</li>
</ul>
<pre class="python"><code>a={1,3}=={1,3}
b={1,3}!={1,3}
print(a,&quot;\n&quot;,b)</code></pre>
<pre><code>## True ## False</code></pre>
<ul>
<li>
Contém <code>&gt;=</code> ou <code>issubset</code>
<ul>
<li>
<code>a&lt;=b</code> é <code>True</code> todo elemento <em>a</em> está
em <em>b</em>
</li>
</ul>
</li>
<li>
Está contido <code>&lt;=</code> ou <code>issuperset</code>
<ul>
<li>
<code>a&gt;=b</code> é <code>True</code> todo elemento <em>b</em> está
em <em>a</em><br>
</li>
<li>
<code>a&lt;=b</code> é <code>True</code> todo elemento <em>a</em> está
em <em>b</em>
</li>
</ul>
</li>
<li>
Pertinência <code>in</code>
<ul>
<li>
<em>a</em> in <em>b</em> é verdadeiro caso <em>a</em> seja um elemento
de <em>b</em>
</li>
</ul>
</li>
</ul>

<p>
Uma variável pode ser um dicionário contendo chave de tipo imutável
(como número inteiros e de ponto flutuante, Strings, Tuplas ou qualquer
tipo de valor).
</p>
<p>
Dicionários têm pares, compostos por <strong>chave:valor</strong>,
iteráveis sobre a <strong>chave</strong>, podendo seus elementos serem
acessados por uma estrutura <strong>for</strong>.
</p>
<pre class="python"><code>pares=dict() #ou
pares={}
print(pares)</code></pre>
<pre><code>## {}</code></pre>
<p>
Para adicionar um novo par ao dicionário, por exemplo um par
número:string, basta atribuir o valor ao nome do dicionário seguido pela
chave entre colchetes, caso já exista o valor será atualizado. exemplo:
</p>
<pre class="python"><code>pares={}
pares[7]=&quot;Valor que eu quero&quot;
print(pares)</code></pre>
<pre><code>## {7: &apos;Valor que eu quero&apos;}</code></pre>
<p>
Criando um dicionário diretamente
</p>
<p>
Veja:
</p>
<pre class="python"><code>pares={&quot;Maria&quot;:3468-4618, &quot;Ana Maria&quot;: 4674-4318, &quot;Jos&#xE9;&quot;:1346-4133}
print(pares)</code></pre>
<pre><code>## {&apos;Maria&apos;: -1150, &apos;Ana Maria&apos;: 356, &apos;Jos&#xE9;&apos;: -2787}</code></pre>
<p>
Para visualização dos dados contidos no dicionário, podemos utilizar:
</p>
<ul>
<li>
<strong>d.items()</strong>:retorna uma visualização de todos os pares
(chave,valor) de um dicionário <strong>d</strong>
</li>
<li>
<strong>d.keys()</strong>: retorna uma visualização de todas as chaves
de um dicionário <strong>d</strong>
</li>
<li>
<strong>d.values()</strong>: retorna uma visualizacao de todos os
valores de um dicionário <strong>d</strong>
</li>
</ul>
<p>
Para manipular os dados contidos em um dicionário, podemos utilizar:
</p>
<p>
A função <code>del</code> nomeDict\[<strong>chave</strong>\] retira o
par <strong>chave:valor</strong> do dicionário. Caso a chave não esteja
no dicionário um erro ocorre, veja:
</p>
<pre class="python"><code>pares={5=&quot;Boa ideia&quot;,7=&quot;Valor que eu quero&quot;, 31=&quot;mes sim mes nao&quot;}
pares.pop(7) print(pares)</code></pre>
<p>
A função <code>len()</code> retorna o tamanho do dicionário, veja:
</p>
<pre class="python"><code>pares={5=&quot;Boa ideia&quot;, 7=&quot;valor que eu quero&quot;, 31=&quot;mes sim mes nao&quot;}
print(len(pares))</code></pre>

<p>
A função <strong>get(chave)</strong> retorna <strong>None</strong> se
não existir aquela <strong>chave</strong> no dicionário, caso contrário
retorna o respectivo <strong>valor</strong>, veja:
</p>
<pre class="python"><code>pares={}
print(pares.get(4)) #retorna None</code></pre>
<pre class="python"><code>pares = {5=&quot;Boa&quot;, 7=&quot;Meu&quot;, 3=&quot;Mal&quot;}
print(pares.get(7)) #Escreve: Meu</code></pre>
<p>
A função <code>get(chave,default)</code> retorna
<strong>default</strong> se não existir aquela <strong>chave</strong> no
dicionário, caso contrário retorna o respectivo <strong>valor</strong>
</p>
<pre class="python"><code>pares = {5=&quot;Boa&quot;, 7=&quot;Meu&quot;, 3=&quot;Mal&quot;}
print(pares.get(2,&quot;Vazia&quot;)) #Escreve: vazia
print(pares.get(5,&quot;Vazia&quot;)) #escreve: Boa</code></pre>

<p>
São suites, comandos e/ou estruturas de controle, ao qual atribuímos um
nome e após a sua execução obtemos um valor.
</p>
<p>
A utilização de funções permite que o programa possa ser desenvolvido e
testado separadamente, além de permitir a reutilização de algumas partes
em diferentes pontos do programa.
</p>
<p>
Sendo assim, é possível montar programas mais complexos a partir de
funções menores já desenvolvidas e testadas.
</p>
<p>
A função deve ser declarada da seguinte forma:
</p>
<pre class="python"><code>def nomeEscolhido(_lista_) suite do corpo da funcao return None</code></pre>
<p>
onde:
</p>
<ul>
<li>
a <em>lista</em> de parâmetros pode ter zero ou mais parâmetros
separados por vírgulas
</li>
<li>
A <em>suite do corpo da função</em> deve possuir zero ou mais retornos
de valores, expressos por <strong>return</strong> <em>valor
apropriado</em> (caso nenhum valor seja retornado, <strong>return
None</strong>)
</li>
</ul>

<p>
Caso uma função possa ser aplicada a diferentes valores de entrada, esta
função deve conter parâmetros em sua definição.
</p>
<p>
Caso não se saiba ao certo número de parâmetros que podem ser
espeficicados na entrada da função, podemos utilizar o comando
<code>\*arg</code>, veja:
</p>
<pre class="python"><code>def soma(*args): return sum(*args) print(soma([1,2,3])) print(soma([1,2,3,7,8,9,10]))
print(soma(range(9))) </code></pre>
<pre><code>## 6
## 40
## 36</code></pre>

<p>
Chama-se de função recursiva quando a função possui no seu corpo uma
chamada a ela própria
</p>
<p>
Exemplo, no cálculo de fatorial:
</p>
<pre class="python"><code>def fat(n): if n==0: return 1 else: return n*fat(n-1) #Aqui esta a chamada recursiva</code></pre>

<p>
Programas interativos sao diferentes de manusear arquivos. Arquivos
podem ser de diversas fontes, veremos aqui como trabalhar com os
arquivos de texto
</p>
<p>
Arquivos texto são sequencias de caracteres organizadas em linhas
</p>
<p>
Em python, a leitura de arquivos é feito da seguinte maneira:
</p>
<pre class="python"><code>dados = open(caminho do arquivo, &quot;r&quot;) #r: leitura ; #w: apenas escrita; #a: escreve no final do arquivo
dados.close() # o arquivo nao sera mais utilizado</code></pre>
<p>
Aplicada sob um arquivo txt aberto, retorna uma linha completa, incluind
o final da linha (\* que pula a linha). Portando o inicio do leitor
avança para a proxima linha, veja:
</p>
<pre class="python"><code>dados = open(&quot;dataset.txt&quot;, &quot;r&quot;)
linha = dados.readline()
print(linha, end=&quot;&quot;)
dados.close()</code></pre>

<p>
Funciona apenas para pequenos arquivos, veja:
</p>
<pre class="python"><code>dados_abrir = &quot;dataset.txt&quot;
dados=open(dados_abrir, &quot;r&quot;) linhas = dados.readlines()
for linha in linhas: print(linha, end=&quot;&quot;) dados.close()</code></pre>

<p>
Serve para abrir o arquivo inteiro, veja:
</p>
<pre class="python"><code>dados_abrir = &quot;dataset.txt&quot;
dados=open(dados_abrir, &quot;r&quot;) print(dados.read())</code></pre>

<p>
O comando a seguir irá abrir um arquivo chamado “teste.txt” com o
comando <code>open("nome do arquivo", "w")</code> (caso não exista um
arquivo com esse nome no diretório, será criado) e o arquivo está
preparado para a escrita, veja:
</p>
<pre class="python"><code>dados=open(&quot;teste.txt&quot;, &quot;w&quot;)
dados.write(&quot;qualquercoisa&quot;)</code></pre>

<p>
Este método possibilita que o arquivo já existente receba no seu final
novas informações, preservando seu conteúdo. Caso o arquivo não exista
ele será criado e se o método for usado posteriormente de novo, este
mesmo arquivo receberá mais informação.
</p>
<p>
Veja um exemplo de programa iterativo onde o usuário informa o nome do
arquivo que ele deseja anexar novas linhas e depois o método é
utilizado:
</p>
<pre class="python"><code>nome=input(&quot;Diga o nome do arquivo que deseja anexar&quot;)
arquivo=open(nome, &quot;a&quot;)
noma_linha = input(&quot;Diga a nova linha:&quot;)
arquivo.write(nova_linha + &quot;\n&quot;)
arquivo.close()</code></pre>

<p>
Bom, é isso! Esta página não tem o intuito de servir como uma espécie de
“curso” de Python, até porque aprender uma nova linguagem de programação
não é uma tarefa trivial.
</p>
<p>
Esse post é fruto de meus estudos e espero que seja útil como material
de consulta para tirar dúvidas daqueles que, como eu, estão buscando
aprender mais a cada dia!
</p>

<footer>
<ul class="stats">
<li class="categories">
<ul>
<i class="fa fa-folder"></i>
<li>
<a class="article-category-link" href="https://gomesfellipe.github.io/categories/pr%C3%A1tica">Prática</a>
</li>
<li>
<a class="article-category-link" href="https://gomesfellipe.github.io/categories/utilidades">utilidades</a>
</li>
<li>
<a class="article-category-link" href="https://gomesfellipe.github.io/categories/python">Python</a>
</li>
</ul>
</li>
<li class="tags">
<ul>
<i class="fa fa-tags"></i>
<li>
<a class="article-category-link" href="https://gomesfellipe.github.io/tags/aprendendo">Aprendendo</a>
</li>
<li>
<a class="article-category-link" href="https://gomesfellipe.github.io/tags/python">python</a>
</li>
<li>
<a class="article-category-link" href="https://gomesfellipe.github.io/tags/jupyter">jupyter</a>
</li>
</ul>
</li>
</ul>
</footer>
</article>
<article class="post">
<a href="https://disqus.com/" class="dsq-brlink">comments powered by
</a>
</article>
</p>

