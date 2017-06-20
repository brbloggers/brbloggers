+++
title = "Data Frames"
date = "2017-02-07 07:58:17"
categories = ["analise-real"]
original_url = "https://analisereal.com/2017/02/07/data-frames/"
+++

<div class="entry-content">
<br>
<p>
\*\*\*
</p>
<p>
Parte do
livro <a href="https://analisereal.com/introducao-a-analise-de-dados-com-r/">Introdução
à análise de dados com R</a>.<em>  Este trabalho está em andamento, o
texto é bastante preliminar e sofrerá muitas alterações. </em>
</p>
<p>
Quer fazer sugestões? Deixe um comentário abaixo ou, se você sabe
utilizar o
github, <a href="https://github.com/carloscinelli/livroR">acesse
aqui.</a>
</p>
<p>
Não copie ou reproduza este material sem autorização.
</p>
<p>
Volte para ver atualizações!
</p>
<p>
\*\*\*
</p>
<h2>
Data Frames: seu banco de dados no R
</h2>
<h4>
Por que um <code>data.frame</code>?
</h4>
<p>
Até agora temos utilizado apenas dados de uma mesma classe, armazenados
ou em um vetor ou em uma matriz. Mas uma base de dados, em geral, é
feita de dados de diversas classes diferentes: no exemplo anterior, por
exemplo, podemos querer ter uma coluna com os nomes dos funcionários,
outra com o sexo dos funcionários, outra com valores… note que essas
colunas são de classes diferentes, como textos e números. Como guardar
essas informações?
</p>
<p>
A solução para isso é o <code>data.frame</code>. O
<code>data.frame</code> é talvez o formato de dados mais importante do
R. No <code>data.frame</code> cada coluna representa uma variável e cada
linha uma observação. Essa é a estrutura ideal para quando você tem
várias variáveis de classes diferentes em um banco de dados.
</p>
<h4>
Criando um data.frame: <code>data.frame()</code> e
<code>as.data.frame()</code>
</h4>
<p>
É possível criar um <code>data.frame</code> diretamente com a função
<code>data.frame()</code>:
</p>
<pre class="brush: r; title: ; notranslate">funcionarios &lt;- data.frame(nome = c(&quot;Jo&#xE3;o&quot;, &quot;Maria&quot;, &quot;Jos&#xE9;&quot;), sexo = c(&quot;M&quot;, &quot;F&quot;, &quot;M&quot;), salario = c(1000, 1200, 1300), stringsAsFactors = FALSE)
funcionarios
## nome sexo salario
## 1 Jo&#xE3;o M 1000
## 2 Maria F 1200
## 3 Jos&#xE9; M 1300
</pre>
<p>
Também é coverter outros objetos em um <code>data.frame</code> com a
função <code>as.data.frame()</code>.
</p>
<p>
<strong><em>Discutiremos a opção <code>stringsAsFactors = FALSE</code>
mais a frente</em></strong>.
</p>
<p>
Vejamos a estrutura do <code>data.frame</code>. Note que cada coluna tem
sua própria classe.
</p>
<pre class="brush: r; title: ; notranslate">str(funcionarios)
## &apos;data.frame&apos;: 3 obs. of 3 variables:
## $ nome : chr &quot;Jo&#xE3;o&quot; &quot;Maria&quot; &quot;Jos&#xE9;&quot;
## $ sexo : chr &quot;M&quot; &quot;F&quot; &quot;M&quot;
## $ salario: num 1000 1200 1300
</pre>
<h4>
Nomes de linhas e colunas
</h4>
<p>
O <code>data.frame</code> sempre terá rownames e colnames.
</p>
<pre class="brush: r; title: ; notranslate">rownames(funcionarios)
## [1] &quot;1&quot; &quot;2&quot; &quot;3&quot; colnames(funcionarios)
## [1] &quot;nome&quot; &quot;sexo&quot; &quot;salario&quot;
</pre>
<p>
Detalhe: a função <code>names()</code> no <code>data.fram</code> trata
de suas colunas, pois <strong>os elementos fundamentais do data.frame
são seus vetores coluna</strong>.
</p>
<pre class="brush: r; title: ; notranslate">names(funcionarios)
## [1] &quot;nome&quot; &quot;sexo&quot; &quot;salario&quot;
</pre>
<h4>
Não parece tão diferente de uma matriz…
</h4>
<p>
O que ocorreria com o <code>data.frame</code> <code>funcionarios</code>
se o transformássemos em uma matriz? Vejamos:
</p>
<pre class="brush: r; title: ; notranslate">as.matrix(funcionarios)
## nome sexo salario
## [1,] &quot;Jo&#xE3;o&quot; &quot;M&quot; &quot;1000&quot;
## [2,] &quot;Maria&quot; &quot;F&quot; &quot;1200&quot;
## [3,] &quot;Jos&#xE9;&quot; &quot;M&quot; &quot;1300&quot;
</pre>
<p>
Perceba que todas as variáveis viraram <code>character</code>! Uma
matriz aceita apenas elementos da mesma classe, e é exatamente por isso
precisamos de um <code>data.frame</code> neste caso.
</p>
<h4>
Manipulando <code>data.frames</code> como matrizes
</h4>
<p>
Ok, temos mais um objeto do R, o data.frame … vou ter que reaprender
tudo novamente? Não! Você pode manipular data.frames como se fossem
matrizes!
</p>
<p>
Praticamente tudo o que vimos para selecionar e modificar elementos em
matrizes funciona no <code>data.frame</code>. Podemos selecionar linhas
e colunas do nosso <code>data.frame</code> como se fosse uma matriz:
</p>
<pre class="brush: r; title: ; notranslate">## tudo menos linha 1
funcionarios[-1, ]
## nome sexo salario
## 2 Maria F 1200
## 3 Jos&#xE9; M 1300 ## seleciona primeira linha e primeira coluna (vetor)
funcionarios[1, 1]
## [1] &quot;Jo&#xE3;o&quot; ## seleciona primeira linha e primeira coluna (data.frame)
funcionarios[1, 1, drop = FALSE]
## nome
## 1 Jo&#xE3;o ## seleciona linha 3, colunas &quot;nome&quot; e &quot;salario&quot;
funcionarios[3 , c(&quot;nome&quot;, &quot;salario&quot;)]
## nome salario
## 3 Jos&#xE9; 1300
</pre>
<p>
E também alterar seus valores tal como uma matriz.
</p>
<pre class="brush: r; title: ; notranslate">## aumento de salario para o Jo&#xE3;o
funcionarios[1, &quot;salario&quot;] &lt;- 1100 funcionarios
## nome sexo salario
## 1 Jo&#xE3;o M 1100
## 2 Maria F 1200
## 3 Jos&#xE9; M 1300
</pre>
<h4>
Extra do data.frame: selecionando e modificando com
<code>$&lt;/code&gt; e &lt;code&gt;\[\[ \]\]&lt;/code&gt;&lt;/h4&gt; &lt;p&gt;Outras formas alternativas de selecionar colunas em um &lt;code&gt;data.frame&lt;/code&gt; s&\#xE3;o o &lt;code&gt;$</code>
e o <code>\[\[ \]\]</code>:
</p>
<pre class="brush: r; title: ; notranslate">## Seleciona coluna nome
funcionarios$nome
## [1] &quot;Jo&#xE3;o&quot; &quot;Maria&quot; &quot;Jos&#xE9;&quot; funcionarios[[&quot;nome&quot;]]
## [1] &quot;Jo&#xE3;o&quot; &quot;Maria&quot; &quot;Jos&#xE9;&quot; ## Seleciona coluna salario
funcionarios$salario
## [1] 1100 1200 1300 funcionarios[[&quot;salario&quot;]]
## [1] 1100 1200 1300
</pre>
<p>
Tanto o
<code>$&lt;/code&gt; quanto o &lt;code&gt;\[\[ \]\]&lt;/code&gt; &lt;strong&gt;sempre&lt;/strong&gt; retornam um vetor como resultado.&lt;/p&gt; &lt;p&gt;Tamb&\#xE9;m &\#xE9; poss&\#xED;vel alterar a coluna combinando &lt;code&gt;$</code>
ou <code>\[\[ \]\]</code> com <code>&lt;-</code>:
</p>
<pre class="brush: r; title: ; notranslate">## outro aumento para o Jo&#xE3;o
funcionarios$salario[1] &lt;- 1150 ## equivalente
funcionarios[[&quot;salario&quot;]][1] &lt;- 1150
funcionarios
## nome sexo salario
## 1 Jo&#xE3;o M 1150
## 2 Maria F 1200
## 3 Jos&#xE9; M 1300
</pre>
<h4>
Extra do data.frame: retornando sempre um data.frame com <code>\[
\]</code>
</h4>
<p>
Se você quiser garantir que o resultado da seleção será sempre um
data.frame use <code>drop = FALSE</code> ou selecione sem a vírgula:
</p>
<pre class="brush: r; title: ; notranslate">## Retorna data.frame
funcionarios[ ,&quot;salario&quot;, drop = FALSE]
## salario
## 1 1150
## 2 1200
## 3 1300 ## Retorna data.frame
funcionarios[&quot;salario&quot;]
## salario
## 1 1150
## 2 1200
## 3 1300
</pre>
<h4>
Tabela resumo: selecionando uma coluna em um data.frame
</h4>
<p>
Resumindo as formas de seleção de uma coluna de um data.frame.
</p>
<p>
<img class="alignnone size-full wp-image-3747" src="https://analisereal.files.wordpress.com/2017/02/screen-shot-2017-02-07-at-12-02-02-am.png?w=440%20440w,%20https://analisereal.files.wordpress.com/2017/02/screen-shot-2017-02-07-at-12-02-02-am.png?w=880%20880w,%20https://analisereal.files.wordpress.com/2017/02/screen-shot-2017-02-07-at-12-02-02-am.png?w=150%20150w,%20https://analisereal.files.wordpress.com/2017/02/screen-shot-2017-02-07-at-12-02-02-am.png?w=300%20300w,%20https://analisereal.files.wordpress.com/2017/02/screen-shot-2017-02-07-at-12-02-02-am.png?w=768%20768w" alt="screen-shot-2017-02-07-at-12-02-02-am" srcset="https://analisereal.files.wordpress.com/2017/02/screen-shot-2017-02-07-at-12-02-02-am.png?w=440 440w, https://analisereal.files.wordpress.com/2017/02/screen-shot-2017-02-07-at-12-02-02-am.png?w=880 880w, https://analisereal.files.wordpress.com/2017/02/screen-shot-2017-02-07-at-12-02-02-am.png?w=150 150w, https://analisereal.files.wordpress.com/2017/02/screen-shot-2017-02-07-at-12-02-02-am.png?w=300 300w, https://analisereal.files.wordpress.com/2017/02/screen-shot-2017-02-07-at-12-02-02-am.png?w=768 768w">
</p>
<h4>
Criando colunas novas
</h4>
<p>
Há diversas formas de criar uma coluna nova em um
<code>data.frame</code>. O principal segredo é o seguinte: faça de conta
que a coluna já exista, selecione ela com
<code>$&lt;/code&gt;, &lt;code&gt;\[,\]&lt;/code&gt; ou &lt;code&gt;\[\[\]\]&lt;/code&gt; e atribua o valor que deseja.&lt;/p&gt; &lt;p&gt;Para ilustrar, vamos adicionar ao nosso &lt;code&gt;data.frame&lt;/code&gt; funcionarios mais tr&\#xEA;s colunas.&lt;/p&gt; &lt;p&gt;Com &lt;code&gt;$</code>:
</p>
<pre class="brush: r; title: ; notranslate">funcionarios$escolaridade &lt;- c(&quot;Ensino M&#xE9;dio&quot;, &quot;Gradua&#xE7;&#xE3;o&quot;, &quot;Mestrado&quot;)
</pre>
<p>
Com <code>\[ , \]</code>:
</p>
<pre class="brush: r; title: ; notranslate">funcionarios[, &quot;experiencia&quot;] &lt;- c(10, 12, 15)
</pre>
<p>
Com <code>\[\[ \]\]</code>:
</p>
<pre class="brush: r; title: ; notranslate">funcionarios[[&quot;avaliacao_anual&quot;]] &lt;- c(7, 9, 10)
</pre>
<p>
Uma última forma de adicionar coluna a um <code>data.frame</code> é, tal
como uma matriz, utilizar a função <code>cbind()</code> (column bind).
</p>
<pre class="brush: r; title: ; notranslate">funcionarios &lt;- cbind(funcionarios, prim_emprego = c(&quot;sim&quot;, &quot;nao&quot;, &quot;nao&quot;), stringsAsFactors = FALSE)
</pre>
<p>
Vejamos como ficou nosso <code>data.frame</code> com as novas colunas:
</p>
<pre class="brush: r; title: ; notranslate">funcionarios
## nome sexo salario escolaridade experiencia avaliacao_anual prim_emprego
## 1 Jo&#xE3;o M 1150 Ensino M&#xE9;dio 10 7 sim
## 2 Maria F 1200 Gradua&#xE7;&#xE3;o 12 9 nao
## 3 Jos&#xE9; M 1300 Mestrado 15 10 nao
</pre>
<p>
E agora, temos colunas demais, como remover algumas delas?
</p>
<h4>
Removendo colunas
</h4>
<p>
A forma mais fácil de remover coluna de um <code>data.fram</code> é
atribuir o valor <code>NULL</code> a ela:
</p>
<pre class="brush: r; title: ; notranslate">## deleta coluna prim_emprego
funcionarios$prim_emprego &lt;- NULL
</pre>
<p>
Mas a forma mais segura e universal de remover qualquer elemento de um
objeto do R é <em>selecionar tudo exceto aquilo que você não
deseja</em>. Isto é, selecione todas colunas menos as que você não quer
e atribua o resultado de volta ao seu <code>data.frame</code>:
</p>
<pre class="brush: r; title: ; notranslate">## deleta colunas 4 e 6
funcionarios &lt;- funcionarios[, c(-4, -6)]
</pre>
<h4>
Adicionando linhas
</h4>
<p>
Uma forma simples de adicionar linhas é atribuir a nova linha com
<code>&lt;-</code>. Mas cuidado! O que irá acontecer com o
<code>data.frame</code> com o código abaixo?
</p>
<pre class="brush: r; title: ; notranslate">## CUIDADO!
funcionarios[4, ] &lt;- c(&quot;Ana&quot;, &quot;F&quot;, 2000, 15)
</pre>
<p>
Note que nosso data.frame inteiro se transformou em texto! Você sabe
explicar por que isso aconteceu? <em>relembrar coerção</em>
</p>
<pre class="brush: r; title: ; notranslate">str(funcionarios)
## &apos;data.frame&apos;: 4 obs. of 4 variables:
## $ nome : chr &quot;Jo&#xE3;o&quot; &quot;Maria&quot; &quot;Jos&#xE9;&quot; &quot;Ana&quot;
## $ sexo : chr &quot;M&quot; &quot;F&quot; &quot;M&quot; &quot;F&quot;
## $ salario : chr &quot;1150&quot; &quot;1200&quot; &quot;1300&quot; &quot;2000&quot;
## $ experiencia: chr &quot;10&quot; &quot;12&quot; &quot;15&quot; &quot;15&quot;
</pre>
<p>
Antes de prosseguir, transformemos as colunas <code>salario</code> e
<code>experiencia</code> em números novamente:
</p>
<pre class="brush: r; title: ; notranslate">funcionarios$salario &lt;- as.numeric(funcionarios$salario) funcionarios$experiencia &lt;- as.numeric(funcionarios$experiencia)
</pre>
<p>
Se os elementos forem de classe diferente, use a função
<code>data.frame</code> para evitar coerção:
</p>
<pre class="brush: r; title: ; notranslate">funcionarios[4, ] &lt;- data.frame(nome = &quot;Ana&quot;, sexo = &quot;F&quot;, salario = 2000, experiencia = 15, stringsAsFactors = FALSE)
</pre>
<p>
Também é possível adicionar linhas com <code>rbind()</code>:
</p>
<pre class="brush: r; title: ; notranslate">rbind(funcionarios, data.frame(nome = &quot;Ana&quot;, sexo = &quot;F&quot;, salario = 2000, experiencia = 15, stringsAsFactors = FALSE))
</pre>
<p>
<strong>Atenção! Não fique aumentando um <code>data.frame</code> de
tamanho adicionando linhas ou colunas. Sempre que possível pré-aloque
espaço!</strong>
</p>
<h4>
Removendo linhas
</h4>
<p>
Para remover linhas, basta selecionar apenas aquelas linhas que você
deseja manter:
</p>
<pre class="brush: r; title: ; notranslate">## remove linha 4 do data.frame
funcionarios &lt;- funcionarios[-4, ]
</pre>
<pre class="brush: r; title: ; notranslate">## remove linhas em que salario &lt;= 1150
funcionarios &lt;- funcionarios[funcionarios$salario &gt; 1150, ]
</pre>
<h4>
Filtrando linhas com vetores logicos
</h4>
<p>
Relembrando: se passarmos um vetor lógico na dimensão das linhas,
selecionamos apenas aquelas que são <code>TRUE</code>. Assim, por
exemplo, se quisermos selecionar aquelas linhas em que a coluna
<code>salario</code> é maior do que um determinado valor, basta colocar
esta condição como filtro das linhas:
</p>
<pre class="brush: r; title: ; notranslate">## Apenas linhas com salario &gt; 1000
funcionarios[funcionarios$salario &gt; 1000, ]
## nome sexo salario experiencia
## 2 Maria F 1200 12
## 3 Jos&#xE9; M 1300 15 ## Apenas linhas com sexo == &quot;F&quot;
funcionarios[funcionarios$sexo == &quot;F&quot;, ]
## nome sexo salario experiencia
## 2 Maria F 1200 12
</pre>
<h4>
Funções de conveniência: <code>subset()</code>
</h4>
<p>
Uma função de conveniência para selecionar linhas e colunas de um
<code>data.frame</code> é a função <code>subset()</code>, que tem a
seguinte estrutura:
</p>
<pre class="brush: r; title: ; notranslate">subset(nome_do_data_frame, subset = expressao_logica_para_filtrar_linhas, select = nomes_das_colunas, drop = simplicar_para_vetor?)
</pre>
<p>
Vejamos alguns exemplos:
</p>
<pre class="brush: r; title: ; notranslate">## funcionarios[funcionarios$sexo == &quot;F&quot;,]
subset(funcionarios, sexo == &quot;F&quot;)
## nome sexo salario experiencia
## 2 Maria F 1200 12 ## funcionarios[funcionarios$sexo == &quot;M&quot;, c(&quot;nome&quot;, &quot;salario&quot;)]
subset(funcionarios, sexo == &quot;M&quot;, select = c(&quot;nome&quot;, &quot;salario&quot;))
## nome salario
## 3 Jos&#xE9; 1300
</pre>
<h4>
Funções de conveniência: <code>with</code>
</h4>
<p>
A função <code>with()</code> permite que façamos operações com as
colunas do <code>data.frame</code> sem ter que ficar repetindo o nome do
<code>data.frame</code> seguido de
<code>$&lt;/code&gt; , &lt;code&gt;\[ , \]&lt;/code&gt; ou &lt;code&gt;\[\[\]\]&lt;/code&gt; o tempo inteiro.&lt;/p&gt; &lt;p&gt;Para ilustrar:&lt;/p&gt; &lt;pre class="brush: r; title: ; notranslate"&gt;\#\# Com o with with(funcionarios, (salario^3 - salario^2)/log(salario)) \#\# \[1\] 2.4e+08 3.1e+08 \#\# Sem o with (funcionarios$salario^3
-
funcionarios*s**a**l**a**r**i**o*<sup>2</sup>)/*l**o**g*(*f**u**n**c**i**o**n**a**r**i**o**s*salario)
\#\# \[1\] 2.4e+08 3.1e+08
</pre>
<p>
Quatro formas de fazer a mesma coisa (pense em outras formas possíveis):
</p>
<pre class="brush: r; title: ; notranslate">subset(funcionarios, sexo == &quot;M&quot;, select = &quot;salario&quot;, drop = TRUE)
## [1] 1300 with(funcionarios, salario[sexo == &quot;M&quot;])
## [1] 1300 funcionarios$salario[funcionarios$sexo == &quot;M&quot;]
## [1] 1300 funcionarios[funcionarios$sexo == &quot;M&quot;, &quot;salario&quot;]
## [1] 1300
</pre>
<h4>
Aplicando funções no data.frame: <code>sapply</code> e
<code>lapply</code>, funções nas colunas (elementos)
</h4>
<p>
Outras duas funções bastante utilizadas no R são as funções
<code>sapply()</code> e <code>lapply()</code>.
</p>
<ul>
<li>
As funções <code>sapply</code> e <code>lapply</code> aplicam uma função
em cada elemento de um objeto.
</li>
<li>
Como vimos, os elementos de um <code>data.frame</code> são suas colunas.
Deste modo, as funções <code>sapply</code> e <code>lapply</code> aplicam
uma função nas colunas de um data.frame.
</li>
<li>
A diferença entre uma e outra é que a primeira tenta
<strong>s</strong>implificar o resultado enquanto que a segunda sempre
retorna uma lista.
</li>
</ul>
<p>
Testando no nosso <code>data.frame</code>:
</p>
<pre class="brush: r; title: ; notranslate">sapply(funcionarios[3:4], mean)
## salario experiencia
## 1250 14 lapply(funcionarios[3:4], mean)
## $salario
## [1] 1250
##
## $experiencia
## [1] 14
</pre>
<h4>
Filtrando variáveis antes de aplicar funções: <code>filter()</code>
</h4>
<p>
Como <code>data.frames</code> podem ter variáveis de classe diferentes,
muitas vezes é conveniente filtrar apenas aquelas colunas de determinada
classe (ou que satisfaçam determinada condição). A função
<code>Filter()</code> é uma maneira rápida de fazer isso:
</p>
<pre class="brush: r; title: ; notranslate"># seleciona apenas colunas num&#xE9;ricas
Filter(is.numeric, funcionarios)
## salario experiencia
## 2 1200 12
## 3 1300 15 # seleciona apenas colunas de texto
Filter(is.character, funcionarios)
## nome sexo
## 2 Maria F
## 3 Jos&#xE9; M
</pre>
<p>
Juntando <code>filter()</code> com <code>sapply()</code> você pode
aplicar funções em apenas certas colunas, como por exemplo, calcular a
média e máximo apenas nas colunas numéricas do nosso
<code>data.frame</code>:
</p>
<pre class="brush: r; title: ; notranslate">sapply(Filter(is.numeric, funcionarios), mean)
## salario experiencia
## 1250 14 sapply(Filter(is.numeric, funcionarios), max)
## salario experiencia
## 1300 15
</pre>
<h4>
Manipulando data.frames
</h4>
<p>
Ainda temos muita coisa para falar de manipulação de
<code>data.frames</code>e isso merece um espaço especial. Veremos além
de outras funções base do R alguns pacotes importantes como
<code>dplyr</code>, <code>reshape2</code> e <code>tidyr</code> em uma
seção separada.
</p>
</div>

