+++
title = "Manipulação de Strings e Text Mining"
date = "2017-12-17"
categories = ["felippe-gomes"]
original_url = "https://gomesfellipe.github.io/post/2017-12-17-string/string/"
+++

<p id="main">
<article class="post">
<header>
<p>
Algumas dicas e truques úteis de pacotes especiais para a manipulação e
tratamento de strings
</p>

</header>
<a href="https://gomesfellipe.github.io/post/2017-12-17-string/string/" class="image featured">
<img src="https://gomesfellipe.github.io/img/2017/12/imagem2.png" alt="">
</a>
<p>
Estudamos números e mais números na graduação de estatística (não sei
nem se ainda consigo enxergar algarismos gregos como letras) e mesmo
assim um problema frequente na vida de quem trabalha com dados é a
manipulação de variáveis do tipo <em>string</em>.
</p>
<p>
Uma variável do tipo <em>string</em> é uma variável do tipo texto e esse
tipo de objeto costuma causar alguns problemas na análise de dados se
não forem devidamente tratados.
</p>
<p>
Desde modificações em nomes de colunas em data.frames até as mais
espertas aplicações de text mining com corpus, a limpeza e manipulação
de strings é quase sempre necessária
</p>

<p>
Antes de apresentar alguns pacotes com funções úteis para manipular
strings, gostaria de comentar que pode ser bem útil desenvolvermos
funções para nosso próprio uso, não é raro realizarmos o mesmo
procedimento em diferentes etapas das análises, o que pode tornar o
código desorganizado ou poluído com tantas linhas repetidas.
</p>
<p>
Trago aqui de exemplo uma função que encontrei recentemente para remover
acentos no
<a href="https://pt.stackoverflow.com/questions/46473/remover-acentos">stackoverflow</a>
que já me ajudou bastante, veja a função:
</p>
<pre class="r"><code>rm_accent &lt;- function(str,pattern=&quot;all&quot;) { # Rotinas e fun&#xE7;&#xF5;es &#xFA;teis V 1.0 # rm.accent - REMOVE ACENTOS DE PALAVRAS # Fun&#xE7;&#xE3;o que tira todos os acentos e pontua&#xE7;&#xF5;es de um vetor de strings. # Par&#xE2;metros: # str - vetor de strings que ter&#xE3;o seus acentos retirados. # patterns - vetor de strings com um ou mais elementos indicando quais acentos dever&#xE3;o ser retirados. # Para indicar quais acentos dever&#xE3;o ser retirados, um vetor com os s&#xED;mbolos dever&#xE3;o ser passados. # Exemplo: pattern = c(&quot;&#xB4;&quot;, &quot;^&quot;) retirar&#xE1; os acentos agudos e circunflexos apenas. # Outras palavras aceitas: &quot;all&quot; (retira todos os acentos, que s&#xE3;o &quot;&#xB4;&quot;, &quot;`&quot;, &quot;^&quot;, &quot;~&quot;, &quot;&#xA8;&quot;, &quot;&#xE7;&quot;) if(!is.character(str)) str &lt;- as.character(str) pattern &lt;- unique(pattern) if(any(pattern==&quot;&#xC7;&quot;)) pattern[pattern==&quot;&#xC7;&quot;] &lt;- &quot;&#xE7;&quot; symbols &lt;- c( acute = &quot;&#xE1;&#xE9;&#xED;&#xF3;&#xFA;&#xC1;&#xC9;&#xCD;&#xD3;&#xDA;&#xFD;&#xDD;&quot;, grave = &quot;&#xE0;&#xE8;&#xEC;&#xF2;&#xF9;&#xC0;&#xC8;&#xCC;&#xD2;&#xD9;&quot;, circunflex = &quot;&#xE2;&#xEA;&#xEE;&#xF4;&#xFB;&#xC2;&#xCA;&#xCE;&#xD4;&#xDB;&quot;, tilde = &quot;&#xE3;&#xF5;&#xC3;&#xD5;&#xF1;&#xD1;&quot;, umlaut = &quot;&#xE4;&#xEB;&#xEF;&#xF6;&#xFC;&#xC4;&#xCB;&#xCF;&#xD6;&#xDC;&#xFF;&quot;, cedil = &quot;&#xE7;&#xC7;&quot; ) nudeSymbols &lt;- c( acute = &quot;aeiouAEIOUyY&quot;, grave = &quot;aeiouAEIOU&quot;, circunflex = &quot;aeiouAEIOU&quot;, tilde = &quot;aoAOnN&quot;, umlaut = &quot;aeiouAEIOUy&quot;, cedil = &quot;cC&quot; ) accentTypes &lt;- c(&quot;&#xB4;&quot;,&quot;`&quot;,&quot;^&quot;,&quot;~&quot;,&quot;&#xA8;&quot;,&quot;&#xE7;&quot;) if(any(c(&quot;all&quot;,&quot;al&quot;,&quot;a&quot;,&quot;todos&quot;,&quot;t&quot;,&quot;to&quot;,&quot;tod&quot;,&quot;todo&quot;)%in%pattern)) # opcao retirar todos return(chartr(paste(symbols, collapse=&quot;&quot;), paste(nudeSymbols, collapse=&quot;&quot;), str)) for(i in which(accentTypes%in%pattern)) str &lt;- chartr(symbols[i],nudeSymbols[i], str) return(str) }</code></pre>
<p>
Criar nossas próprias funções é muito simples em R e eu encorajo a todos
a começarem a trabalhar com funções próprias também (além das nativas do
R), pois o programa fica muito mais dinâmico e limpo.
</p>

<p>
Além do pacote <code>dplyr</code>, mais uma vez
<a href="https://github.com/hadley">Hadley Wickham</a> trás uma solução
bastante útil para facilitar nossa vida de programador estatístico (ou
cientista de dados se preferir, seguindo as “tendências da moda” de
“data scientist”) com o pacote <code>stringr</code>, que possui uma
sintaxe consistente, permitindo a manipulação de textos com muito mais
facilidade.
</p>
<p>
Seu uso consiste em uma variedade de utilidades que podem ser
consultadas diretamente de dentro do R ao escrever <code>str\_</code>
(após carregar o pacote) e aguardar um instante que a seguinte lista de
funções será exibida:
</p>
<img src="https://gomesfellipe.github.io/img/2017-12-17-string/imagem1.png" alt="Note que essa aplica&#xE7;&#xE3;o funciona para qualquer pacote do R">
<p class="caption">
Note que essa aplicação funciona para qualquer pacote do R
</p>

<p>
Portanto, inicialmente vamos carregar o pacote:
</p>
<pre class="r"><code>library(stringr)</code></pre>
<p>
Com o pacote carregado já podemos fazer o uso de algumas das funções que
são bem úteis.
</p>
<p>
É muito comum que os cabeçalhos de uma base de dados venha repleta de
caracteres especiais como este exemplo:
</p>
<pre class="r"><code>nomes=c(&apos;Anivers&#xE1;rio&apos;, &apos;Situa&#xE7;&#xE3;o&apos;, &apos;Ra&#xE7;a&apos;, &apos;IMC&apos;, &apos;Tipo f&#xED;sico&apos;, &apos;tabaco por dia (cig/dia)&apos;, &apos;Alcool (dose/semana)&apos;, &apos;Drogas/g&apos;, &apos;Caf&#xE9;/dia&apos;, &apos;Suco/dia&apos;);nomes</code></pre>
<pre><code>## [1] &quot;Anivers&#xE1;rio&quot; &quot;Situa&#xE7;&#xE3;o&quot; ## [3] &quot;Ra&#xE7;a&quot; &quot;IMC&quot; ## [5] &quot;Tipo f&#xED;sico&quot; &quot;tabaco por dia (cig/dia)&quot; ## [7] &quot;Alcool (dose/semana)&quot; &quot;Drogas/g&quot; ## [9] &quot;Caf&#xE9;/dia&quot; &quot;Suco/dia&quot;</code></pre>
<p>
Unindo as funções deste pacote com a sintaxe do pacote
<code>dplyr</code> podemos elaborar uma função que irá facilitar
bastante nas chamadas das colunas do data.frame na hora da análise,
veja:
</p>
<pre class="r"><code>ajustar_nomes=function(x){ x%&gt;% stringr::str_trim() %&gt;% #Remove espa&#xE7;os em branco sobrando stringr::str_to_lower() %&gt;% #Converte todas as strings para minusculo rm_accent() %&gt;% #Remove os acentos com a funcao criada acima stringr::str_replace_all(&quot;[/&apos; &apos;.()]&quot;, &quot;_&quot;) %&gt;% #Substitui os caracteres especiais por &quot;_&quot; stringr::str_replace_all(&quot;_+&quot;, &quot;_&quot;) %&gt;% #Substitui os caracteres especiais por &quot;_&quot; stringr::str_replace(&quot;_$&quot;, &quot;&quot;) #Substitui o caracter especiais por &quot;_&quot; } nomes=ajustar_nomes(nomes) nomes</code></pre>
<pre><code>## [1] &quot;aniversario&quot; &quot;situacao&quot; ## [3] &quot;raca&quot; &quot;imc&quot; ## [5] &quot;tipo_fisico&quot; &quot;tabaco_por_dia_cig_dia&quot; ## [7] &quot;alcool_dose_semana&quot; &quot;drogas_g&quot; ## [9] &quot;cafe_dia&quot; &quot;suco_dia&quot;</code></pre>
<p>
Esse é o tipo de função que é utilizada com frequência. Utilizada para
substituir ou remover uma (ou todas) as ocorrências de determinado
carácter no objeto, suponha a seguinte situação:
</p>
<pre class="r"><code>exemplo &lt;- c(&quot;o esperto&quot;, &quot;o doido&quot;, &quot;o normal&quot;)</code></pre>
<p>
Para remover a primeira vogal de cada string:
</p>
<pre class="r"><code>str_replace(exemplo, &quot;[aeiou]&quot;, &quot;&quot;) </code></pre>
<pre><code>## [1] &quot; esperto&quot; &quot; doido&quot; &quot; normal&quot;</code></pre>
<p>
Para substitui todas as vogais por “\_"
</p>
<pre class="r"><code>str_replace_all(exemplo, &quot;[aeiou]&quot;, &quot;_&quot;) </code></pre>
<pre><code>## [1] &quot;_ _sp_rt_&quot; &quot;_ d__d_&quot; &quot;_ n_rm_l&quot;</code></pre>
<p>
Considere este novo exemplo:
</p>
<pre class="r"><code>exemplo2 &lt;- &quot;O- ffffzx2, faifavuvuifoovvv fovvo&quot;</code></pre>
<p>
Para substitui o primeiro f (ou f’s) por “v”:
</p>
<pre class="r"><code>exemplo2 &lt;- str_replace(exemplo2, &quot;f+&quot;, &quot;v&quot;) exemplo2</code></pre>
<pre><code>## [1] &quot;O- vzx2, faifavuvuifoovvv fovvo&quot;</code></pre>
<p>
Para substituir todos os v’s (em sequência ou não) por “c”:
</p>
<pre class="r"><code>exemplo2 &lt;- str_replace_all(exemplo2, &quot;v+&quot;, &quot;c&quot;) exemplo2</code></pre>
<pre><code>## [1] &quot;O- czx2, faifacucuifooc foco&quot;</code></pre>

<p>
Essas funções separam uma string em várias de acordo com um separador.
</p>
<pre class="r"><code>frase &lt;- &apos;Analisar palavras &#xE9; muito legal. Apesar de todos os desafios as informa&#xE7;&#xF5;es que podemos extrair podem revelar informa&#xE7;&#xF5;es incr&#xED;velmente &#xFA;teis. Esse exemplo esta sendo escrito pois vamos retirar cada frase desse paragrafo separadamente.&apos; str_split(frase, fixed(&apos;.&apos;))</code></pre>
<pre><code>## [[1]] ## [1] &quot;Analisar palavras &#xE9; muito legal&quot; ## [2] &quot; Apesar de todos os desafios as informa&#xE7;&#xF5;es que podemos extrair podem revelar informa&#xE7;&#xF5;es incr&#xED;velmente &#xFA;teis&quot; ## [3] &quot; Esse exemplo esta sendo escrito pois vamos retirar cada frase desse paragrafo separadamente&quot; ## [4] &quot;&quot;</code></pre>

<p>
Para obter uma parte fixa de uma string podemos utilizar o comando
<code>str\_sub()</code> da seguinte maneira:
</p>
<pre class="r"><code>#Suponha as seguintes palavras: words=c(&quot;00-casados&quot;, &quot;01-casamento&quot;, &quot;02-emprego&quot;, &quot;03-empregado&quot;)</code></pre>
<p>
Selecionado apenas do quarto até o último caracteres da string:
</p>
<pre class="r"><code>str_sub(words, start = 4) # come&#xE7;a no 4 caractere</code></pre>
<pre><code>## [1] &quot;casados&quot; &quot;casamento&quot; &quot;emprego&quot; &quot;empregado&quot;</code></pre>
<p>
Selecionando apenas os dois primeiros caracteres da string:
</p>
<pre class="r"><code>str_sub(words, end = 2) # termina no 2 caractere</code></pre>
<pre><code>## [1] &quot;00&quot; &quot;01&quot; &quot;02&quot; &quot;03&quot;</code></pre>
<p>
Para obter caracteres utilizando o sinal de negação <code>-</code>
</p>
<pre class="r"><code>#Suponha: words &lt;- c(&quot;casamento-01&quot;, &quot;emprego-02&quot;, &quot;empregado-03&quot;) str_sub(words, end = -4) #Seleciona todos os valores menos os &#xFA;ltimos 3</code></pre>
<pre><code>## [1] &quot;casamento&quot; &quot;emprego&quot; &quot;empregado&quot;</code></pre>
<pre class="r"><code>str_sub(words, start = -2) #Seleciona todos os valores at&#xE9; o segundo valor</code></pre>
<pre><code>## [1] &quot;01&quot; &quot;02&quot; &quot;03&quot;</code></pre>
<p>
Também é possível utilizar os argumentos <code>end</code> e
<code>start</code> conjuntamente, veja
</p>
<pre class="r"><code>#&#xC9; poss&#xED;vel usar os argumentos start e end conjuntamente. words &lt;- c(&quot;__casamento__&quot;, &quot;__emprego__&quot;, &quot;__empregado__&quot;) str_sub(words, start=3, end=-3)</code></pre>
<pre><code>## [1] &quot;casamento&quot; &quot;emprego&quot; &quot;empregado&quot;</code></pre>
<p>
A manipulação de strings é uma tarefa bem trabalhosa e algumas vezes até
complexa porém cada desafio que surge ajuda bastante a entender esse
mecanismo para manipulação de strings.
</p>

<p>
O pacote <code>tm</code> é um clássico para o text mining em R, quando
os dados se apresentam de forma não estrutura, necessitam de uma
preparação prévia que pode ser considerada um tipo de pré-processamento.
</p>
<p>
Inicialmente, carregando o pacote:
</p>
<pre class="r"><code>suppressMessages( library(tm))</code></pre>
<p>
Em bases de dados textuais, conhecidos como <em>corpus</em> ou
<em>corpora</em> são tratado como “documentos” e cada “documento” em um
<em>corpus</em> pode assumir diferentes características em relação ao
tamanho do texto (sequências de caracteres), tipo de conteúdo (assunto
abordado), língua na qual é escrito ou tipo de linguagem adotada dentro
outros exemplos.
</p>
<p>
A transformação de um <em>corpus</em> em um conjunto de dados que possa
ser submetido à procedimentos de análise consiste em um processo que
gera uma representação capaz de descrever cada documento em termos de
suas características.
</p>
<p>
Para criar um <em>corpus</em> a partir de um <code>data.frame</code>
basta utilizar o seguinte comando:
</p>
<pre class="r"><code>#Criando o corpus para o tratamento das variaveis com pacote library(tm): corpus &lt;- Corpus(DataframeSource(data.frame(x)))</code></pre>
<p>
A seguir veremos algumas dos possíveis procedimentos para a manipulação
de dados em um <em>corpus</em>.
</p>
<p>
Uma sequência de comando interessantes para a limpeza de um
<em>corpus</em> que já utilizei bastante é a seguinte:
</p>
<pre class="r"><code>#Realizando a limpeza da base de dados: #Acrescentar mais stopwords para retirada; #novas=c() #Tratamento do corpus tratar_corpus=function(x){ x%&gt;% tm_map(stripWhitespace)%&gt;% #remover excessos de espa&#xE7;os em branco tm_map(removePunctuation)%&gt;% #remover pontuacao tm_map(removeNumbers)%&gt;% #remover numeros tm_map(removeWords, c(stopwords(&quot;portuguese&quot;),novas))%&gt;% #remmover as stopwords,crie um vetor chamado &quot;novas&quot; para incluir novas stopwords tm_map(stripWhitespace)%&gt;% #remover excessos de espa&#xE7;os em branco novamente tm_map(removeNumbers)%&gt;% #remover numeros novamente tm_map(content_transformer(tolower))%&gt;% #colocar todos caracteres como minusculo tm_map(stemDocument) #Extraindo os radicais } corpus=tratar_corpus(corpus) #inspect(corpus[[3]]) #Leitura de algum documento espec&#xED;fico</code></pre>
<p>
Para criar a matriz de termos podemos utilizar o comando:
</p>
<pre class="r"><code>#Criando a matrix de termos: corpus_tf=TermDocumentMatrix(corpus, control = list(minWordLength=2,minDocFreq=5))</code></pre>
<p>
Caso precise trabalhar com a transformação <code>tf-idf</code> basta
utilizar:
</p>
<pre class="r"><code>#Caso precise utilizar a medida tf-idf em um corpus: corpus_tf_idf=weightTfIdf(corpus_tf,normalize=T)</code></pre>

<p>
Criando uma matriz para facilitar a manipulação dos dados
</p>
<pre class="r"><code>#Transformando em matrix para permitir a manipula&#xE7;&#xE3;o: matriz = as.matrix(corpus_tf) #organizar os dados de forma decrescente matriz = sort(rowSums(matriz), decreasing=T) #criando um data.frame para a matriz matriz = data.frame(word=names(matriz), freq = matriz)</code></pre>
<p>
Caso seja necessário conferir visualmente as palavras mais mencionadas,
também podemos utilizar gráficos, como por exemplo:
</p>
<pre class="r"><code>#Vejamos os primeiros 10 registros: head(matriz, n=10)</code></pre>
<pre><code>## word freq ## ano ano 296 ## pra pra 226 ## site site 156 ## todo todo 144 ## cadastro cadastro 134 ## faz faz 124 ## fazer fazer 124 ## dia dia 114 ## receb receb 114 ## ver ver 114</code></pre>
<pre class="r"><code>#Vejamos visualmente: head(matriz, n=10) %&gt;% ggplot(aes(word, freq)) + geom_bar(stat = &quot;identity&quot;, color = &quot;black&quot;, fill = &quot;#87CEFA&quot;) + geom_text(aes(hjust = 1.3, label = freq)) + coord_flip() + labs(title = &quot;20 Palavras mais mensionadas&quot;, x = &quot;Palavras&quot;, y = &quot;N&#xFA;mero de usos&quot;)</code></pre>
<p>
<img src="https://gomesfellipe.github.io/post/2017-12-17-string/2017-12-17-string_files/figure-html/unnamed-chunk-26-1.png" width="672">
</p>

<p>
Embora a análise de palavras realizada neste documento seja útil para a
exploração inicial, o cientista de dados precisará construir um
dicionário de bigrams, trigrams e quatro grams, coletivamente chamados
de n-grams, que são frases de n palavras.
</p>
<p>
“O <a href="https://www.cs.waikato.ac.nz/ml/weka/">Weka</a> tem como
objectivo agregar algoritmos provenientes de diferentes
abordagens/paradigmas na sub-área da inteligência artificial dedicada ao
estudo de aprendizagem de
máquina.”-<a href="https://pt.wikipedia.org/wiki/Weka">Wikipedia</a>
</p>
<p>
Carregando o pacote <code>RWeka</code>:
</p>
<pre class="r"><code>library(rJava) suppressMessages(library(RWeka)) BigramTokenizer &lt;- function(x) NGramTokenizer(x, Weka_control(min = 2, max = 2)) TrigramTokenizer &lt;- function(x) NGramTokenizer(x, Weka_control(min = 3, max = 3)) FourgramTokenizer &lt;- function(x) NGramTokenizer(x, Weka_control(min = 4, max = 4))</code></pre>
<p>
Como exemplo, criaremos um dicionário de trigrams (frases de três
palavras) e a função para construir um dicionário de n-gramas utilizando
o pacote <code>tm</code> e o <code>RWeka</code> é:
</p>
<pre class="r"><code># tokenize into tri-grams trigram.Tdm &lt;- tm::TermDocumentMatrix(corpus, control = list(tokenize = TrigramTokenizer))</code></pre>
<p>
Criando uma matriz para facilitar a manipulação dos dados
</p>
<pre class="r"><code>#Transformando em matrix para permitir a manipula&#xE7;&#xE3;o: matriz = as.matrix(trigram.Tdm) #organizar os dados de forma decrescente matriz = sort(rowSums(matriz), decreasing=T) #criando um data.frame para a matriz matriz = data.frame(word=names(matriz), freq = matriz)</code></pre>
<pre class="r"><code>#Vejamos os primeiros 20 registros: head(matriz, n=10)</code></pre>
<pre><code>## word freq ## cadastro site httpstcofawilc cadastro site httpstcofawilc 92 ## vc consegu ver vc consegu ver 92 ## conferir gent vc conferir gent vc 90 ## consegu ver historico consegu ver historico 90 ## faz cadastro site faz cadastro site 90 ## gent vc faz gent vc faz 90 ## httpstcofawilc q vc httpstcofawilc q vc 90 ## pra conferir gent pra conferir gent 90 ## q vc consegu q vc consegu 90 ## site httpstcofawilc q site httpstcofawilc q 90</code></pre>
<pre class="r"><code>#Vejamos visualmente: head(matriz, n=10) %&gt;% ggplot(aes(word, freq)) + geom_bar(stat = &quot;identity&quot;, color = &quot;black&quot;, fill = &quot;#87CEFA&quot;) + geom_text(aes(hjust = 1.3, label = freq)) + coord_flip() + labs(title = &quot;20 frases mais mensionadas&quot;, x = &quot;Palavras&quot;, y = &quot;N&#xFA;mero de usos&quot;)</code></pre>
<p>
<img src="https://gomesfellipe.github.io/post/2017-12-17-string/2017-12-17-string_files/figure-html/unnamed-chunk-30-1.png" width="672">
</p>
<p>
Caso seja necessário retirar o radical de um vetor de strings podemos
utilizar a função ´wordStem´ do pacote <code>SnowballC</code>, caso
queria conferir, existe o
<a href="https://cran.r-project.org/web/packages/SnowballC/SnowballC.pdf">manual
do pacote</a> no
<a href="https://cran.r-project.org/web/packages/SnowballC">CRAN</a>
</p>
<pre class="r"><code>words=c(&quot;casados&quot;, &quot;casamento&quot;, &quot;emprego&quot;, &quot;empregado&quot;) SnowballC::getStemLanguages()</code></pre>
<pre><code>## [1] &quot;danish&quot; &quot;dutch&quot; &quot;english&quot; &quot;finnish&quot; &quot;french&quot; ## [6] &quot;german&quot; &quot;hungarian&quot; &quot;italian&quot; &quot;norwegian&quot; &quot;porter&quot; ## [11] &quot;portuguese&quot; &quot;romanian&quot; &quot;russian&quot; &quot;spanish&quot; &quot;swedish&quot; ## [16] &quot;turkish&quot;</code></pre>
<pre class="r"><code>SnowballC::wordStem(words, language = &quot;portuguese&quot;)</code></pre>
<pre><code>## [1] &quot;cas&quot; &quot;casament&quot; &quot;empreg&quot; &quot;empreg&quot;</code></pre>

<footer>
<ul class="stats">
<li>
Categories
</li>
<li>
<a href="https://gomesfellipe.github.io/categories/r">R</a>
</li>
<li>
<a href="https://gomesfellipe.github.io/categories/package">package</a>
</li>
<li>
<a href="https://gomesfellipe.github.io/categories/utilidades">utilidades</a>
</li>
<li>
<a href="https://gomesfellipe.github.io/categories/pr%C3%A1tica">Prática</a>
</li>
<li>
<a href="https://gomesfellipe.github.io/categories/text-mining">text
mining</a>
</li>
</ul>
</footer>
</article>
<article class="post">
<a href="https://disqus.com/" class="dsq-brlink">comments powered by
</a>
</article>
</p>

