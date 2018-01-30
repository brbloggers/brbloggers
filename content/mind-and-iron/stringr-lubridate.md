+++
title = ""
date = "1-01-01"
categories = ["mind-and-iron"]
original_url = "http://ctlente.com/pt/teaching/stringr-lubridate/"
+++

<body>
<textarea id="source">
class: center, middle, inverse, title-slide \# Introdução ao R:
Stringr/Lubridate \#\#\# Caio Lente + Curso-R \#\#\# 2018-01-22 --- \#
Índice O que veremos hoje: -- - Stringr - O que são strings? 🎻 - Mexer
com strings é fácil 😄 - Regex 🤢 - Mexer com strings é dífícil 😞 -- -
Lubridate - O que são datas? 📆 - Criando datas 🤕 - Mexer com datas é
fácil 😄 - Mexer com datas é difícil 😞 --- \# Nossa motivação "Por que
vamos aprender a mexer com strings e datas?" e "Por que tem que ser com
esses pacotes dos quais eu nunca ouvi falar?" Porque: - Variáveis que
trazem textos ou datas são extremamente **importantes** - Raramente
encontramos tabelas que contém somente números e valores binários - O R
`base` tem funções muito <s>ruins</s> pouco consistentes para lidar com
esses tipos de dados - Os pacotes `lubridate` e `stringr` são excelentes
opções que já vêm embutidas no **tidyverse** - Ambos foram idealizados
por <s>um anjo que roubou meu coração</s> Hadley Wickham ---
background-image:
url("<https://images.unsplash.com/photo-1505218795627-2b9746a5343f?dpr=1&auto=format&fit=crop&w=1000&q=80&cs=tinysrgb%22>)
background-position: 50% 50% class: center, middle, inverse \# STRINGR
--- class: inverse, center, middle \# O que são strings? --- \# O básico
Strings não passam de sequências de caracteres! Em português o termo é
literalmente traduzido como *cadeia de caracteres*.
`r minha_primeira_string &lt;- &quot;Eu adoro o IME!&quot; minha_primeira_string`
`#&gt; [1] &quot;Eu adoro o IME!&quot;` -- Strings aceitam praticamente
qualquer coisa que está entre aspas, então podemos ir à loucura:
`r minha_segunda_string &lt;- &quot;&#x3053;&#x3093;&#x306B;&#x3061;&#x306F;! Est&#xE1; 40\u00BAC na l&#xE1; &#x250;&#x279;o&#x25F;&quot; minha_segunda_string`
`#&gt; [1] &quot;&#x3053;&#x3093;&#x306B;&#x3061;&#x306F;! Est&#xE1; 40&#xBA;C na l&#xE1; &#x250;&#x279;o&#x25F;&quot;`
-- **EX:** Rode a função `class()` em uma string. O que ela realmente é?
--- \# Escapando pela tangente O que acontece se tentarmos colocar uma
expressão entre aspas dentro de uma string?
`r &quot;Meu nome &#xE9; &quot;Caio Lente&quot;&quot;` -- O R não nos
permite fazer isso! Temos duas alternativas:
`r &quot;Meu nome &#xE9; &apos;Caio Lente&apos;&quot; &quot;Meu nome &#xE9; \&quot;Caio Lente\&quot;&quot;`
-- A segunda estratégia usa o que chamamos de *escaping*: um símbolo
(`\`) que indica que o próximo caractere não é o que parece.
`r cat(&quot;Meu nome &#xE9; \&quot;Caio Lente\&quot;&quot;)`
`#&gt; Meu nome &#xE9; &quot;Caio Lente&quot;` -- **EX:** Verifique as
diferenças entre o comportamento entre `print()` e `cat()`. --- \#
Caracteres especiais Usando a nossa nova ferramenta, podemos descrever
uma infinitude de caracteres não tradicionais.
`r cat(&quot;Uma lista feita &#xE0; m&#xE3;o:\n\t-Item 1;\n\t-Item dois.&quot;)`
`#&gt; Uma lista feita &#xE0; m&#xE3;o: #&gt; -Item 1; #&gt; -Item dois.`
Os caracteres especiais `\n` e `\t` indicam respectivamente uma nova
linha e uma tabulação. -- Se não pudermos usar caracteres não-ASCII
(como é com o CRAN), podemos usar a barra oblíqua aliada a códigos
Unicode para descrever qualquer caractere imaginável:
`r &quot;\u03b1\u03b2\u03b3&quot;`
`#&gt; [1] &quot;&#x3B1;&#x3B2;&#x3B3;&quot;` --- \# Vetores de strings
Em outras linguagens (como C), strings são vetores, o que quer dizer que
cada posição de uma string corresponde a um caractere! Já no R,
`character` é uma **classe atômica** e então isso não acontece.
`r c(&quot;Um&quot;, &quot;vetor&quot;, &quot;de&quot;, &quot;strings&quot;)[4]`
`#&gt; [1] &quot;strings&quot;` -- Isso pode ser um pouco difícil de
entender se você já programou em alguma linguagem diferente de R, mas
não demora pra pegar o jeito. A única coisa com que precisamos tomar
cuidado é **fechar todas as aspas**! Mesmo que estejamos em um vetor,
deixar uma aspa aberta vai fazer o console ficar esperando pelo final da
string:
`r &gt; c(&quot;Estou declarando&quot;, &quot;um vetor&quot;, &quot;de strings + + + SOCORRO!`
--- \# Até agora - `character` (genericamente conhecido como "string") é
um tipo de dado que serve para amazenar textos - Podemos incluir
praticamente qualquer coisa em uma string - Usando a barra oblíqua para
a esquerda, espapamos o caractere que a segue - Podemos criar vetores de
strings como com qualquer outro tipo de dado -- \#\#\# Exercício Crie um
vetor que carrega dois pequenos textos. Cada texto deve ter dois
parágrafos cada e cada parágrafo deve ter pelo menos 3 linhas. Cada
parágrafo deve começar com uma tabulação e nenhuma linha pode passar de
80 caracteres. Pelo menos um dos textos deve ter uma citação. **Dicas:**
Para saber quantos caracteres tem cada linha, use o contador na esquerda
inferior do RStudio. Escreva cada linha separadamente e depois junte-as
com caracteres especiais.d --- class: inverse, center, middle \# Mexer
com strings é fácil --- \# O pacote stringr Todas as funções do
`stringr` começam com o prefixo `str_`. Isso facilita muito quando
precisamos buscar buscar alguma coisa no nosso environment!
`r library(stringr)` -- **EX:** Carregue o `stringr` e procure por suas
funções usando a tecla TAB. -- A função mais básica do pacote é
`str_length()`, que retorna o número de caracteres em uma string. Como
todas as funções do `stringr` são vetorizadas, o primeiro argumento
delas pode ter tanto uma única string quando um vetor de strings.
`r str_length(c(&quot;Um&quot;, &quot;Dois&quot;, &quot;Tr&#xEA;s &quot;, &quot;Quatro&quot;, &quot;Cinco&quot;))`
`#&gt; [1] 2 4 5 6 5` -- **EX:** Verifique como são contados caracteres
escapados. --- \# As maravilhas da formatação Uma das tarefas mais
comuns que precisamos executar quando se trata de strings é transformar
um texto de formatação duvidosa em um texto com a formatação que
desejamos:
`r s &lt;- &quot;nAh uNIaUM xOvIeHtIkA, U MiGuXeixxXXxx ixXxKreVi vC&quot; str_to_lower(s)`
`#&gt; [1] &quot;nah uniaum xoviehtika, u miguxeixxxxxx ixxxkrevi vc&quot;`
`r str_to_upper(s)`
`#&gt; [1] &quot;NAH UNIAUM XOVIEHTIKA, U MIGUXEIXXXXXX IXXXKREVI VC&quot;`
`r str_to_title(s)`
`#&gt; [1] &quot;Nah Uniaum Xoviehtika, U Miguxeixxxxxx Ixxxkrevi Vc&quot;`
Agora o texto está muito mais compreensível! --- \# Tirando pedaços
Outra utilidade importante é retirar fatias indesejadas de strings. Se
tivermos um texto com espaços extras no início e no final, podemos
recorrer à função `str_trim()`:
`r str_trim(c(&quot;M&quot;, &quot;F&quot;, &quot;F&quot;, &quot; M&quot;, &quot; F &quot;, &quot;M&quot;))`
`#&gt; [1] &quot;M&quot; &quot;F&quot; &quot;F&quot; &quot;M&quot; &quot;F&quot; &quot;M&quot;`
-- **EX:** Tabulações são consideradas espaços? -- Já a função
`str_sub()` usa as posições dos caracteres nas strings para determinar o
que remover:
`r str_sub(c(&quot;__SP__&quot;, &quot;__MG__&quot;, &quot;__RJ__&quot;), start = 3, end = 4)`
`#&gt; [1] &quot;SP&quot; &quot;MG&quot; &quot;RJ&quot;` -- **EX:**
Teste `str_sub()` dando valor só para `start` ou só para `end`. O que
acontece se passarmos números negativos para ambos os parâmetros? --- \#
Concatenação Assim como temos `length()` e `str_length()`, temos `c()` e
`str_c()`: `r str_c(&quot;O valor p &#xE9;: &quot;, &quot;0.03&quot;)`
`#&gt; [1] &quot;O valor p &#xE9;: 0.03&quot;` -- **EX:** E se
passássemos uma variável numérica para essa função? -- Vetorização
também não é um problema para a `str_c()`:
`r s1 &lt;- c(&quot;O R&quot;, &quot;O Java&quot;) s2 &lt;- c(&quot;bom&quot;, &quot;ruim&quot;) str_c(s1, &quot; &#xE9; muito &quot;, s2)`
`#&gt; [1] &quot;O R &#xE9; muito bom&quot; &quot;O Java &#xE9; muito ruim&quot;`
-- **EX:** Use o argumento `sep` para remover a repetição de espaços.
Use o argumento `collapse` para juntar as duas frases em uma. --- \# Até
agora - Com `str_length()` podemos contar quantos caracteres tem uma
string - Com `str_to_*()` podemos formatar uma string facilmente - Com
`str_trim()` e `str_sub()` podemos retirar pedaços de strings - Com
`str_c()` podemos concatenar strings -- \#\#\# Exercício Partindo do
vetor de strigs `vs`, obtenha o texto `s`:
`r vs &lt;- c(&quot;***O n&#xFA;mero &quot; , &quot;de caRACTeres&quot;, &quot; nEste TexTO&quot;, &quot;&#xE9;&quot;) s &lt;- &quot;o n&#xFA;mero de caracteres neste texto &#xE9; 36&quot;`
**Dicas:** Use pipes (você só precisará de uma pipeline) e lembre-se do
*placeholder*. Para saber se ambos os textos obtidos são iguais, use o
operador de igualdade (`=`) normalmente. ??? vs %&gt;% str\_trim()
%&gt;% str\_c(collapse = " ") %&gt;% str\_to\_lower() %&gt;%
str\_sub(start = 4) %&gt;% str\_c(str\_length(.), sep = " ") --- class:
inverse, center, middle \# Regex --- \# Expressões regulares *Regular
expressions* ou somente "regex" são uma ferramenta que usamos para
capturar padrões em strings. Veja um pequeno exemplo com a função
`str_detect()` (que detecta se uma determinada string apresenta um certo
padrão):
`r str_detect(c(&quot;banana&quot;, &quot;BANANA&quot;, &quot;maca&quot;, &quot;nona&quot;), pattern = &quot;na&quot;)`
`#&gt; [1] TRUE FALSE FALSE TRUE` -- Alguns caracteres tem significados
especiais dentro de expressões regulares para que possamos fazer
casamentos (*matchings*) mais interessantes. Os caracteres `.`, `^` e
`$` casam respectivamente com qualquer caractere, o início de uma string
e o final de uma string. -- **EX:** Mude o valor do argumento `pattern`
no código acima para que a expressão dê match com qualquer string que
tenha como segunda letra um `a` minúsculo. --- \# Caracteres especiais
(o retorno) Mas o que acontece se quisermos dar match em um ponto? Ou em
um cifrão? Assim como fizemos na primeira parte da aula, usando a `\`
podemos escapar um caractere também em regex! Mas tem um problema... Se
usarmos `\.` para tentar dar match em um ponto, o R vai escapar a barra
e assim obter somente um ponto (concluíndo erroneamente que falta alguma
coisa no padrão). Precisamos então escapar **duas vezes**!
`r str_detect(c(&quot;ba.ana&quot;, &quot;BANA.A&quot;, &quot;ma.a&quot;, &quot;n.na&quot;), pattern = &quot;a\\.a&quot;)`
`#&gt; [1] TRUE FALSE TRUE FALSE` -- **EX:** Como faríamos para dar
match em um padrão já escapado (como "\\\\.")? Dê match em um caractere
de nova linha e em um caractere de tabulação. -- **REGRA GERAL**: Quando
em dúvida, divida ou multiplique o número de barras por 2... Não é
elegante, mas com o tempo você vai pegando o jeito. --- \# Quantos e
quais Outra funcionalidade interessante do regex é a possibilidade de
passar um número de vezes para um padrão se repetir. `+` indica que um
padrão se repete uma ou mais vezes, `*` indica que um padrão se repete
zero ou mais vezes, e `{m,n}` indica que um padrão se repete entre `m` e
`n` vezes (variações importantes são `{m}`, `{,n}` e `{m,}`).
`r str_detect(c(&quot;oi&quot;, &quot;oii&quot;, &quot;oiii&quot;, &quot;oiiii&quot;), pattern = &quot;oi{3,}e*&quot;)`
`#&gt; [1] FALSE FALSE TRUE TRUE` -- Também importante são os marcadores
de conjuntos. Tudo que estiver dentro de um `()` vai ser tratado como
uma unidade indivisível; já colocando caracteres dentro de um `[]`,
casamos com qualquer um deles.
`r str_detect(c(&quot;banana&quot;, &quot;baNANA&quot;, &quot;BAnana&quot;), &quot;.[Aa](na){2}&quot;)`
`#&gt; [1] TRUE FALSE TRUE` --- \# Miscelânea Alguns outros padrões de
regex que podem se fazer úteis: - `[a-z]`, `[A-Z]` e `[0-9]` casam com
letras minúsculas, letras maiúsculas e números (é possível usá-los
juntos) - `[^abc]` casa com qualquer coisa **menos** `a`, `b` e `c` -
`a?` casa com 0 ou 1 `a`
`r str_detect(c(&quot;ba ana&quot;, &quot;BANANA&quot;, &quot;maca&quot;, &quot;nona&quot;), &quot;[^Bn]a ?[ca]&quot;)`
`#&gt; [1] TRUE FALSE TRUE FALSE` -- Se você estiver se sentindo um
pouco perdido, não se preocupe: regex não é um assunto simples. Não
fique com medo de consultar tutoriais ou *cheat sheets* na hora que
bater uma dúvida! O melhor recurso ao qual temos acesso quando
programando em R é o comando a seguir, que mostra todos os padrões que o
`stringr` aceita: `r ?stringi::stringi-search-regex` --- \# Até agora -
Regex é uma ferramenta que nos permite detectar padrões em strings -
Caracteres como `.`, `^` e `$` casam em situações especiais -
Quantificadores como `?`, `+`, `*` e `{m,n}` determinam quantas vezes um
padrão casa - `[]` e `()` determinam conjuntos de padrões -- \#\#\#
Exercício Dado o corpus presente em `stringr::words`, crie expressões
regulares que casem com as palavras que: - Começam com 3 consoantes -
Têm 3 ou mais vogais em sequência - Têm duas ou mais ocorrências onde
uma vogal precede uma consoante **Dica:** Usem `str_view()` com
`match = TRUE` para ver todas as palavras retornadas pelo matching. ---
class: inverse, center, middle \# Mexer com strings é dífícil --- \# Não
entre em pânico Essa seção tem "difícil" no nome, mas ela não é tão
difícil assim. Não vou ensinar praticamente nenhum outro comando de
regex, mas aqui você vai precisar entender como o regex se encaixa com
as funções mais importantes do stringr. Também não perca de vista que,
apesar de os exemplos até agora terem sido em vetores de strings, na
vida real você proavavelmente estaria aplicando essas funções nas
colunas de uma tabela. -- E se você precisar de um incentivo... ---
class: center, middle
![](https://media.giphy.com/media/100QWMdxQJzQC4/giphy.gif) --- \#
Substituição Uma das tarefas mais comuns no tratamento de strings é a
substituição de um padrão por outro. Para isso temos as funções
`str_replace()` e `str_replace_all()` que substituem, respectivamente, o
primeiro ou todos os padrões encontrados.
`r str_replace(&quot;banana&quot;, pattern = &quot;na&quot;, replacement = &quot;XX&quot;)`
`#&gt; [1] &quot;baXXna&quot;` -- Uma funcionalidade destas (e outras)
funções é a possibilidade de usar o padrão procurado na substituição
usando referências. Simplesmente use padrões da forma `\\N` no
`replacement` onde `N` é o índice de um `()`:
`r str_replace_all(&quot;banana&quot;, pattern = &quot;(na)&quot;, replacement = &quot;XX\\1&quot;)`
`#&gt; [1] &quot;baXXnaXXna&quot;` -- **EX:** Dado um número de 11
dígitos, transforme-o em um CPF da forma `544.916.518-84`. --- \#
Extração Com `str_extract()` e `str_extract_all()`, extraímos padrões de
strings. Podemos usar isso para tirar de uma string apenas a parte de
casa com um padrão:
`r pessoas &lt;- c(&quot;Jo&#xE3;o Silva&quot;, &quot;Joana Lima&quot;, &quot;Madonna&quot;) str_extract(pessoas, pattern = &quot;[:alpha:]+$&quot;)`
`#&gt; [1] &quot;Silva&quot; &quot;Lima&quot; &quot;Madonna&quot;`
`r str_extract_all(pessoas, pattern = &quot;[A-Z]&quot;)`
`#&gt; [[1]] #&gt; [1] &quot;J&quot; &quot;S&quot; #&gt; #&gt; [[2]] #&gt; [1] &quot;J&quot; &quot;L&quot; #&gt; #&gt; [[3]] #&gt; [1] &quot;M&quot;`
--- \# Matching Com `str_match()` e `str_match_all()` conseguimos
quebrar strings em matrizes onde cada coluna é uma parte do match. No
caso abaixo, a primeira coluna é o match todo, a segunda é o primeiro
`()` e a terceira é o segundo `()`.
`r pessoas &lt;- c(&quot;Silva, Jo&#xE3;o&quot;, &quot;Lima, Joana&quot;, &quot;Madonna&quot;) str_match(pessoas, pattern = &quot;(.*), ([:alpha:]+)&quot;)`
`#&gt; [,1] [,2] [,3] #&gt; [1,] &quot;Silva, Jo&#xE3;o&quot; &quot;Silva&quot; &quot;Jo&#xE3;o&quot; #&gt; [2,] &quot;Lima, Joana&quot; &quot;Lima&quot; &quot;Joana&quot; #&gt; [3,] NA NA NA`
-- No código acima, `:alpha:` representa o conjunto dos caracteres
alfabéticos (tanto com quanto sem acento). Isso resolve o problema no
qual `[a-zA-Z]` não casaria com `Jo&#xE3;o`. -- **EX:** O que acontece
quando quebramos as strings do vetor `pessoas` em todas as letras
(usando `str_match_all()`)? --- \# Quebra Se quisermos quebrar uma
string em certos pontos podemos usar `str_split()`. Essa função usa um
padrão e divide uma string em um vetor de strings quebrando-a exatamente
onde encontrar o padrão.
`r str_split(&quot;Voc&#xEA; quer um vetor @?&quot;, pattern = &quot; &quot;)`
`#&gt; [[1]] #&gt; [1] &quot;Voc&#xEA;&quot; &quot;quer&quot; &quot;um&quot; &quot;vetor&quot; &quot;@?&quot;`
-- Através de `str_split_fixed()` podemos limitar o número máximo de
quebras (mas aí voltamos a obter uma tabela):
`r str_split_fixed(&quot;Voc&#xEA; quer um vetor @?&quot;, pattern = &quot; &quot;, n = 3)`
`#&gt; [,1] [,2] [,3] #&gt; [1,] &quot;Voc&#xEA;&quot; &quot;quer&quot; &quot;um vetor @?&quot;`
--- \# Até agora - Para substituir um padrão por um texto, podemos usar
`str_replace()` - Para extrar um padrão de uma string, podemos usar
`str_extract()` - Para casar um padrão com um texto, podemos usar
`str_match()` - Para quebrar uma string onde ocorre um padrão, podemos
usar `str_split()` -- \#\#\# Exercício Partindo de `stringr::sentences`,
crie o vetor `no_the`, onde todas as ocorrências da palavra "the" (ou
"The") são removidas (mas tendo em mente que as frases devem continuar
começando com letra maiúscula) **Dica:** Tente criar uma tabela com
`stringr::sentences` para poder operar em colunas usando
`dplyr::mutate()`. É possível resolver esse problema com apenas uma
pipeline. ??? ss %&gt;% str\_replace\_all("\[Tt\]he ?", "") %&gt;%
dplyr::tibble(sentence = .) %&gt;% dplyr::mutate( first =
str\_extract(sentence, "[1]"), first = str\_to\_upper(first), sentence =
str\_replace(sentence, "[2]", first)) %&gt;% dplyr::pull(sentence) ---
background-image:
url("<https://images.unsplash.com/photo-1435527173128-983b87201f4d?dpr=1&auto=format&fit=crop&w=1000&q=80&cs=tinysrgb%22>)
background-position: 50% 50% class: center, middle, inverse \# LUBRIDATE
--- class: inverse, center, middle \# O que são datas? --- \# O básico
Quando tratamos de datas e horários em liguagens de programação,
geralmente estamos falando sobre um **número** que será expresso como
uma **string**. `r library(lubridate) now()`
`#&gt; [1] &quot;2018-01-29 20:35:19 -02&quot;` -- Acima vemos que
`now()` retorna o *datetime* (data-hora) atual*, incluindo o fuso
horário no qual estamos. Mas se convertermos essa pseudo-string para
`integer`, vemos que o número retornado não faz muito sentido...
`r as.integer(now())` `#&gt; [1] 1517265319` .footnote\[\[\*\] Ele era
atual quando eu fiz os slides...\] --- \# Unix time *Unix time\* é a
forma como todos os aparelhos eletrônicos modernos sabem que horas são.
O número enorme que vimos no slide anterior represente quantos
**segundos** se passaram desde o início do dia 01/01/1970.
`r as.integer(as_datetime(&quot;1970-01-01 00:00:00&quot;))`
`#&gt; [1] 0` -- **EX:** O que acontece quando convertemos uma data-hora
anterior a 1970? -- Agora que você sabe como datas e horas são
armazenadas, já é possível deduzir por que esse é um tipo de dado
problemático: nós pensamos em datas como um texto mas na verdade estamos
trabalhando com um número! `r now() + 2592000`
`#&gt; [1] &quot;2018-02-28 19:35:19 -03&quot;` -- **EX:** O que de
interessante aconteceu quando adicionamos 1 mês a `now()`? --- \# ISO
8601 Como você já deve ter notado, todas as funções até agora retornavam
as datas e horários na forma `AAAA-MM-DD HH:MM:SS`. Isso não é à toa!
Este formato é... &gt; ... definido pela *Organização Internacional para
Padronização* no padrão "ISO 8601" que define "elementos de dados e
formatos de intercâmbio para representação e manipulação de datas e
horas”. -- Desta forma, todos os outros formatos (inclusive o que usamos
no dia-a-dia) precisa ser convertido antes de poder ser interpretado
pelos aparelhos eletrônicos. `r as_date(&quot;20/01/2018&quot;)`
`#&gt; [1] NA` -- Agora já temos todos os ingredientes para um
problemão... Datas e horas são escritos como strings, mas representados
internamente como números e existe um padrão internacional para escrever
datas, mas nenhum país o usa. --- \# Até agora - Existem dois tipos
principais para trabalhar com datas e horários: `date` e `datetime` -
Com `today()` e `now()` podemos obter informações sobre a data-hora
atual (incluindo fuso horário) - Com `as_date()` e `as_datetime()`
conseguimos converter uma data ou data-hora no padrão ISO 8601 para o
formato compreendido pelo R -- \#\#\# Exercício Analise 3 conjuntos de
funções: `as_date()` e `as_datetime()`, `make_date()` e
`make_datetime()`, `date()`. O que diferencia esses grupos de funções?
Por que não existe uma função `datime()`? **Dica:** Para ler a
documentação de uma função, execute um comando da forma
`?nome_da_funcao`. Não se preocupe com os conceitos que você ainda não
viu, você não precisa deles para entender essas funções. --- class:
inverse, center, middle \# Criando datas --- \# Com datas bem formatadas
O jeito mais simples de criar uma data ou uma data-hora é com as
primeiras funções que vimos: `as_date()` e `as_datetime()`. Para que
elas funcionem, a entrada precisa estar praticamente 100% formatada no
ISO 8601. `r as_datetime(&quot;2018-01-20 00:02:05&quot;)`
`#&gt; [1] &quot;2018-01-20 00:02:05 UTC&quot;` -- **EX:** Passe uma
data para `as_datetime()` e uma data-hora para `as_date()`. -- Como
também vimos na seção anterior, outro jeito de criar datas é passando
seus componentes individuais para `make_date()` e `make_datetime()`.
Este método é particularmente útil quando tratando tabelas!
`r make_date(2018, 01, 20)` `#&gt; [1] &quot;2018-01-20&quot;` --- \#
Fugindo do ISO 8601 Se quisermos criar uma data (sem horário), podemos
usar a família `dmy()`, `ymd()`, `mdy()` e assim por diante... Elas
procuram os campos (*day*, *month* e *year*) na ordem em que a
respectiva letra aparece no nome da função.
`r dmy(&quot;20/01/2018&quot;)` `#&gt; [1] &quot;2018-01-20&quot;` --
**EX:** O que acontece se passarmos o número `20012018` para a função
acima? -- Para data-horas, a lógica é a mesma: `dmy_hms()`, `ymd_hms()`,
etc. Agora as letras depois do sublinhado representam *hour*, *minute* e
*second*. `r dmy_hms(&quot;20/01/2018 12:02:50&quot;)`
`#&gt; [1] &quot;2018-01-20 12:02:50 UTC&quot;` -- **EX:** E se não
quisermos especificar os minutos ou segundos de um datetime? --- \#
Fusos horários Um componente importante de datetimes que ainda não
abordamos diretamente são os fusos horários. Praticamente todas as
funções de criação de datas têm um argumento `tz` que nos permite
especificar o fuso.
`r t1 &lt;- dmy_hms(&quot;01/06/2015 12:00:00&quot;, tz = &quot;America/New_York&quot;) t2 &lt;- dmy_hms(&quot;01/06/2015 13:00:00&quot;, tz = &quot;America/Sao_Paulo&quot;) t1 == t2`
`#&gt; [1] TRUE` -- **EX:** Crie um vetor `c(t1, t2)`. O que acontece
quando você o imprime? -- Para trocar o fuso de um datetime, basta usar
`with_tz()`: `r with_tz(t1, tzone = &quot;Australia/Lord_Howe&quot;)`
`#&gt; [1] &quot;2015-06-02 02:30:00 +1030&quot;` -- **EX:** Dê uma
olhada na lista de fusos presentes em `OlsonNames()`. --- \# Até agora -
Com `as_date()` e `as_datetime()` podemos criar datas a partir do ISO
8601 - Com `make_*()` podemos criar datas a partir de seus componentes -
Com as famílias `ymd()` e `ymd_hms()` podemos criar datas a partir de
qualquer formato - Podemos atribuir fusos a data-horas com o argumento
`tz` -- \#\#\# Exercício Partindo do vetor de strigs `vt`, obtenha a
data-hora `t`. Você deve fazer isso de duas formas diferentes: uma deve
usar somente o pacote `lubridate` e a outra deve usar o pacote `stringr`
também.
`r vt &lt;- c(&quot;2015&quot;, &quot;31&quot;, &quot;03&quot;, &quot;02&quot;, &quot;59&quot;) t &lt;- ymd_hm(&quot;2015-03-31 02:59&quot;)`
--- class: inverse, center, middle \# Mexer com datas é fácil --- \#
Componentes Depois que aprendemos a construir datas, entender seus
componentes é uma tareafa razoavelmente simples. Usando os nomes em
inglês das diferentes unidades de medida de uma data-hora, podemos
extrair cada unidade separadamente.
`r dt &lt;- ymd_hms(&quot;2016-07-08 12:34:56&quot;) c(year(dt), month(dt), day(dt), hour(dt), minute(dt), second(dt))`
`#&gt; [1] 2016 7 8 12 34 56` -- Além destas funções básicas, também
temos acesso a algumas variações. `yday()` nos dá o dia do ano, enquanto
`wday()` nos dá o dia da semana (1 = domingo e 7 = sábado).
`r c(yday(dt), wday(dt))` `#&gt; [1] 190 6` -- **EX:** Para que servem
os argumentos de `wday()`? --- \# Componentes (cont.) Uma propriedade
interessante dos componentes é que podemos atribuir valores diretamente
a eles. Basta usar o operador de atribuição (`&lt;-`) na seleção de um
componente: `r year(dt) &lt;- 2020 dt`
`#&gt; [1] &quot;2020-07-08 12:34:56 UTC&quot;` -- **EX:** Tente
atribuir um valor inválido (maior que `31`) para `day(dt)` -- Também é
possível arredondar uma data-hora para o componente mais próximo: use
`roud_date()` e passe o nome de um componente para o argumento `unit`.
Se você precisar dos operadores de teto e chão, eles também estão
disponíveis (`floor_date()` e `ceiling_date()`).
`r round_date(dt, &quot;day&quot;)`
`#&gt; [1] &quot;2020-07-09 UTC&quot;` --- class: inverse, center,
middle \# Mexer com datas é difícil --- \# Talvez entre em pânico Como
você deve ter notado, a seção passada foi bastante curta e nem teve uma
recapitulação... Foi esse o caso porque a utilidade real do pacote
lubridate não está em extrair os componentes das data-horas (apesar de
as vezes isso vir a calhar). O que veremos nesta seção é a real vantagem
do pacote, mas infelizmente não é um assunto tão simples, então pode ser
que você fique meio perdido. Isso é normal e demora um bom tempo até que
as coisas comecem a fazer sentido. -- E se você precisar de um
incentivo... --- class: center, middle
![](https://media.giphy.com/media/bkKvvzE9PEcTK/giphy.gif) --- \#
Durações No R tradicional, mexer com a diferença entre dois objetos
data-hora pode ser algo muito complicado e de comportamento
imprevisível, mas o `lubridate` nos fornece uma interface consistente
com `duration` que sempre retorna a duração em segundos.
`r as.duration(today() - dmy(&quot;28/12/1995&quot;))`
`#&gt; [1] &quot;697075200s (~22.09 years)&quot;` -- Se quisermos
construir uma duração, basta utilizar as funções de componente que já
aprendemos no plural e com um `d` na frente:
`r dyears(1) + dweeks(12) + dhours(15)`
`#&gt; [1] &quot;38847600s (~1.23 years)&quot;` -- **EX:** Encontre a
data de amanhã usando `today()` e um construtor de duração. --- \#
Períodos Como nem sempre queremos diferenças de tempo e aritmética com
datas resumidas a uma duração em segundos, o `lubridate` nos fornece o
conceito de `periods` (durações que são legíveis para um humano). Seus
contrutures são os componentes no plural:
`r years(1) + weeks(12) + hours(15)`
`#&gt; [1] &quot;1y 0m 84d 15H 0M 0S&quot;` -- A maior diferença entre
durações e períodos aparece quando lidamos com as variações naturais no
comprimento das unidades temporais. Veja por exemplo o que acontece
quando adicionamos `dyears(1)` e `years(1)` a um ano bissexto:
`r c(ymd(&quot;2016-01-01&quot;) + dyears(1), ymd(&quot;2016-01-01&quot;) + years(1))`
`#&gt; [1] &quot;2016-12-31&quot; &quot;2017-01-01&quot;` -- **EX:**
Onde mais esse tipo de diferença poderia aparecer? ??? Mudança no
horário de verão --- \# Intervalos Para complicar ainda mais o que
acabamos de ver, imagine que precisamos determinar quantos dias cabem em
um mês. Isso naturalmente depende porque tem todo mês tem o mesmo número
de dias... `r months(1) / days(1)`
`#&gt; estimate only: convert to intervals for accuracy`
`#&gt; [1] 30.4375` -- Para isso temos o conceito de `interval`, uma
duração com um ponto de início. Usando o operador infixo `%--%`,
determinamos um intervalo e assim fica fácil de obter um resultado
preciso: `r (today() %--% (today() + months(1))) / days(1)`
`#&gt; [1] NA` -- **EX:**
`(today() %--% (today() + years(1))) / months(1)` funciona? --- \# Até
agora - Usando componentes (`day()`, `month()`, `year()`, etc.) podemos
trabalhar com as partes de uma data-hora - Com durações podemos realizar
operações com diferenças de tempo - Com períodos temos acesso a durações
em uma forma mais legível e interpretável - Com intervalos podemos dar
um ponto inicial a uma operação temporal -- \#\#\# Exercício Partindo de
`lubridate::lakers`, determine, em média, quanto tempo o Lakers
(`team == &quot;LAL&quot;`) demora para arremessar a primeira bola
(`etype == &quot;shot&quot;`) no primeiro período (`period == 1`).
**Dicas:** Lembre-se da aula de `dplyr`! É possível resolver esse
exercício com apenas uma pipeline (na qual precisa haver apenas um
`mutate()`). Entenda a função `ms()` (ela não é o que parece). ???
lakers %&gt;% dplyr::filter(etype == "shot", period == 1, team == "LAL")
%&gt;%::mutate(time = as.duration(ms(time))) %&gt;%
dplyr::group\_by(date) %&gt;% dplyr::summarise(first = min(time)) %&gt;%
dplyr::pull(first) %&gt;% mean() --- class: center, middle, inverse \#
OBRIGADO!
</textarea>
</body>

[1] :alpha:

[2] :alpha:

