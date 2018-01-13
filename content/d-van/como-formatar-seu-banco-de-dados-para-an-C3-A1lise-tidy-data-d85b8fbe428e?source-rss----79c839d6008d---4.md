+++
title = "Como formatar seu banco de dados para análise — tidy data"
date = "2016-07-05 22:58:00"
categories = ["d-van"]
original_url = "https://d-van.org/como-formatar-seu-banco-de-dados-para-an%C3%A1lise-tidy-data-d85b8fbe428e?source=rss----79c839d6008d---4"
+++

<p id="ba46" class="graf graf--p graf-after--h3">
Existem muitas formas de armazenar e ler dados. Por esse motivo, uma das
tarefas que leva mais tempo no processo de análise é a
<em class="markup--em markup--p-em">limpeza </em>e formatação dos
arquivos antes da obtenção de informações, ajuste de modelos e outras
operações.
</p>
<p id="70d8" class="graf graf--p graf-after--p">
Esse texto é útil para os leigos que querem formatar um banco de dados
antes de entregá-lo a um analista e também para aqueles que começaram a
jornada em análise de dados.
</p>
<figure id="2d38" class="graf graf--figure graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/0*MQXBLmrllSZ526EE.jpg">
<figcaption class="imageCaption">
<a href="http://jp.servicesource.com/blog/3-steps-getting-your-customer-data-clean-and-lean" class="markup--anchor markup--figure-anchor">http://jp.servicesource.com/blog/3-steps-getting-your-customer-data-clean-and-lean</a>
</figcaption>
</figure>
<p id="187c" class="graf graf--p graf-after--h4">
Existe uma forma de organizar dados que é bastante popular e recomendada
entre analistas. Dizemos que um banco de dados está limpo
(<em class="markup--em markup--p-em">tidy</em>) quando:
</p>
<p id="9e0e" class="graf graf--p graf-after--p">
1 — Cada variável corresponde a uma coluna.
</p>
<p id="97fe" class="graf graf--p graf-after--p">
2 — Cada observação corresponde a uma linha.
</p>
<p id="5e8c" class="graf graf--p graf-after--p">
3 — Cada tipo de unidade observacional forma uma tabela.
</p>
<p id="9cda" class="graf graf--p graf-after--p">
Um exemplo visual torna as coisas mais fáceis. A seguir, um recorte do
banco de dados usado no
<a href="https://medium.com/@felipeargolo/o-brasil-precisa-de-mais-m%C3%A9dicos-aa3bbf0f3bd3#.4a3zqvny1" class="markup--anchor markup--p-anchor">post</a>
sobre a quantidade de médicos no Brasil. Temos uma variável categórica
(<strong class="markup--strong markup--p-strong">País</strong>) e duas
numéricas (<strong class="markup--strong markup--p-strong">Número de
médicos por 1.000 habitantes em 2011</strong> e
<strong class="markup--strong markup--p-strong">Expectativa de vida ao
nascer</strong>):
</p>
<figure id="e446" class="graf graf--figure graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/1*zDM65bjZRAWC5tAyIkjlbQ.png">
<figcaption class="imageCaption">
País, Número de médicos a cada 1000 habitantes em 2011 e Expectativa de
vida ao nascer. “<em class="markup--em markup--figure-em">NA”
corresponde a dados faltantes no
</em><a href="https://www.r-project.org/" class="markup--anchor markup--figure-anchor"><em class="markup--em markup--figure-em">R</em></a><em class="markup--em markup--figure-em">.
Layout do
</em><a href="http://www.rstudio.com/" class="markup--anchor markup--figure-anchor"><em class="markup--em markup--figure-em">RStudio</em></a><em class="markup--em markup--figure-em">
</em>Fonte: <a href="http://data.worldbank.org/indicator/SH.MED.PHYS.ZS" class="markup--anchor markup--figure-anchor">WHO</a>
</figcaption>
</figure>
<p id="b68c" class="graf graf--p graf-after--figure">
Note que cada linha corresponde a apenas um país (observação) e cada
coluna representa uma variável. Se queremos ver a observação 9, vamos à
linha correspondente e podemos encontrar os valores: “Armenia”
(<strong class="markup--strong markup--p-strong">País</strong>), “2,845”
(<strong class="markup--strong markup--p-strong">Médicos/1.000
hab</strong>. <strong class="markup--strong markup--p-strong">em
2011</strong>) e “71”
(<strong class="markup--strong markup--p-strong">Expectativa de vida ao
nascer</strong>).
</p>
<p id="ba02" class="graf graf--p graf-after--p">
Caso esteja começando a tabular um banco de dados ou escrevendo um
programa que gere um, essa forma facilita bastante o trabalho de análise
posterior.
</p>
<p id="019b" class="graf graf--p graf-after--p">
Caso seja um analista se deparando com dados brutos, uma boa ideia é
limpá-los, colocando no formato
<em class="markup--em markup--p-em">tidy. </em>Assim, a análise será
fluida e você poderá usar a maior parte das funções já desenvolvidas sem
dificuldades.
</p>
<p id="ecd0" class="graf graf--p graf-after--h3">
A seguir, alguns problemas mais frequentes encontrados durante o
processo de limpeza e algumas maneiras de resolvê-los. Conhecer também é
uma boa maneira de evitar.
</p>
<p id="7c50" class="graf graf--p graf-after--h4">
É importante dar nome aos bois. No contexto de pesquisa clínica, manter
o nome de um paciente no banco de dados não é permitido, então uma
alternativa é atribuir um número de identificação para cada paciente.
Isso facilita a manipulação dos casos no banco de dados.
</p>
<p id="fcec" class="graf graf--p graf-after--h4">
Muitas vezes, o dados são resgatados de bancos não projetados para
análise. Em saúde, por exemplo, é comum resgatar informações de
prontuários eletrônicos. Muitas vezes, a maneira como cada usuário
digitou não é uniforme.
</p>
<p id="712f" class="graf graf--p graf-after--p">
Assim, é comum termos algumas maneiras diferentes de se referir à mesma
informação: “Hipertensão Arterial Sistêmica”, “HAS”, “Has”, “has”, “Hip.
Art. Sist.”, “Diabetes Mellitus”, “DM”, “Dm”.
</p>
<p id="a840" class="graf graf--p graf-after--p">
Caso as palavras sejam digitadas manualmente, é importante estabelecer
um padrão. Uma alternativa para evitar erros é usar códigos numéricos.
Ex: Podemos digitar 1 para pacientes que possuam hipertensão. Fazer o
processo inverso (números para palavras) usando softwares adequados é
bastante simples.
</p>
<figure id="c52a" class="graf graf--figure graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/1*vtzVsnH7WOlbU4eHUpIh2Q.png">
</figure>
<p id="218d" class="graf graf--p graf-after--figure">
Na segunda coluna, temos dados digitados de várias formas. Na
terceira\*, o uso de códigos durante a digitação impediu
inconsistências: os pacientes com código 1 são hipertensos.
</p>
<p id="16a5" class="graf graf--p graf-after--h4">
Ainda com o exemplo acima, um outro problema é que temos informações
sobre duas variáveis (presença de hipertensão e presença de diabetes) em
apenas uma coluna. Queremos deixar cada variável em apenas uma coluna e
vamos aproveitar para usar códigos, como descrito acima. O valor 1
corresponde a “Sim” e 0 a “Não”.
</p>
<figure id="cbdb" class="graf graf--figure graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/1*BVkTw4DNtJg6xRlJYHOIuw.png">
</figure>
<p id="b05a" class="graf graf--p graf-after--figure">
Assim, o primeiro 1º paciente apresenta apenas hipertensão (has) e o 6º
apresenta hipertensão e diabetes (dm).
</p>
<p id="b31d" class="graf graf--p graf-after--h4">
O ideal é que os dados sejam tabulados (ou extraídos) já na maneira
<em class="markup--em markup--p-em">tidy</em>. Entretanto, o analista se
depara com dados sujos muitas vezes, seja por falhas no planejamento ou
no processo de obtenção dos dados.
</p>
<p id="913d" class="graf graf--p graf-after--p">
As maneiras como os dados podem se apresentar são infinitas, assim como
os procedimentos para deixá-los limpos. Ainda assim, na maioria das
vezes, a tarefa consiste em transformar texto não padronizado (“Dm,
HAS”, como nos exemplos da 2ª coluna da figura) em códigos uniformes
(1’s e 0’s, como nas colunas 3 e 4).
</p>
<p id="17d1" class="graf graf--p graf-after--p">
Para evitar o trabalho braçal de ler cada célula e digitar os códigos,
podemos usar o computador e funções especiais para automatizar o
processo.
</p>
<p id="48f2" class="graf graf--p graf-after--p">
Antes, vamos gerar dados fictícios para nossa pesquisa:
</p>
<figure id="d7cc" class="graf graf--figure graf--iframe graf-after--p">
<iframe width="700" height="250" src="https://d-van.org/media/95c85662f42a4e54594173d799ebdfc4?postId=d85b8fbe428e" class>
</iframe>

</figure>
<p id="519d" class="graf graf--p graf-after--figure">
Primeiras 9 linhas de nosso banco de dados:
</p>
<figure id="5a0d" class="graf graf--figure graf-after--p">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/1*BHmbyrg9koqRdyBvFN3TfQ.png">
</figure>
<p id="7133" class="graf graf--p graf-after--figure">
Para uniformizar, podemos fazer uso de algumas funções para manipulação
de strings. O universo por trás disso é grande, mas mostrarei uma
implementação simples com a função
<em class="markup--em markup--p-em">grep</em> do R:
</p>
<figure id="b0e8" class="graf graf--figure graf--iframe graf-after--p">
<iframe width="700" height="250" src="https://d-van.org/media/7c9154b5146392663a1876e9ee7738c8?postId=d85b8fbe428e" class>
</iframe>

</figure>
<figure id="8d6d" class="graf graf--figure graf-after--figure">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/1*rXP37NXjOdOLVKuSCTaJ3Q.png">
<figcaption class="imageCaption">
Banco com nova variável após nosso script
</figcaption>
</figure>
<p id="acec" class="graf graf--p graf-after--figure">
Agora temos uma variável, ‘clean’, com apenas um código para hipertensão
(HAS) e outro para (DM).
</p>
<p id="1b90" class="graf graf--p graf-after--p">
Dica: A função <em class="markup--em markup--p-em">agrep </em>ajuda e
faz uso de Fuzzy Matching. Ela compara o que foi pesquisado com os dados
e calcula o número mínimo de inserções, deleções e substituições para
transformar um valor em outro
(<em class="markup--em markup--p-em">Levenshtein edit distance</em>).
Ex: HAS pode se tornar HAs com apenas uma substituição. Você também pode
especificar o número máximo de cada modificação.
</p>
<figure id="33e5" class="graf graf--figure graf--iframe graf-after--p">
<iframe width="700" height="250" src="https://d-van.org/media/32f50f327b50f78e6c73cefffac806f5?postId=d85b8fbe428e" class>
</iframe>

</figure>
<p id="c44c" class="graf graf--p graf-after--figure">
O universo das expressões regulares é vasto
<a href="http://blog.ricbit.com/2010/07/aritmetica-com-regexp.html" class="markup--anchor markup--p-anchor">e
dá para fazer muita coisa com elas</a>, portanto não vamos nos
aprofundar no assunto, mas conseguimos
</p>
<p id="31bd" class="graf graf--p graf-after--h4">
Codd EF (1990).
<a href="http://codeblab.com/wp-content/uploads/2009/12/rmdb-codd.pdf" class="markup--anchor markup--p-anchor">The
Relational Model for Database Management: Version 2.</a> Addison-Wesley
Longman Publishing, Boston.
</p>
<p id="0973" class="graf graf--p graf-after--p">
Wickham, H. (2014). Tidy Data.
<em class="markup--em markup--p-em">Journal of Statistical Software,
59</em>(10), 1–23.
doi:<a href="http://dx.doi.org/10.18637/jss.v059.i10" class="markup--anchor markup--p-anchor">http://dx.doi.org/10.18637/jss.v059.i10</a>
</p>
<p id="ebcd" class="graf graf--p graf-after--p graf--trailing">
\*Obrigado,
<a href="https://medium.com/@maurciovancine" class="markup--user markup--p-user">Maurício
Vancine</a> por notar o erro no último período da parte
<strong class="markup--strong markup--p-strong">“Digitação não
padronizada”</strong>
</p>

