+++
title = "Análise de Texto – Os discursos dos Deputados na sessão de votação do Impeachment"
date = "2016-04-19 17:14:03"
categories = ["IBPAD"]
original_url = "http://www.ibpad.com.br/blog/analise-de-dados/o-que-os-deputados-federais-disseram/"
+++

<p>
O Jornalista e Professor em Ciência Política Fábio Vasconcelos publicou
no Blog
<a href="http://blogs.oglobo.globo.com/na-base-dos-dados/post/o-que-os-votos-sim-e-o-nao-disseram-alem-do-impeachment.html">Na
Base dos Dados</a> uma rápida análise que fizemos sobre os discursos
parlamentares da sessão de votação do Impeachment do dia 17 de Abril na
Câmara dos Deputados.
</p>
<p>
Para quem ficou curioso, a base de dados foi o
<a href="http://www.camara.leg.br/internet/plenario/notas/extraord/2016/4/EV1704161400.pdf">PDF</a>
(sim, acreditem) da Câmara dos Deputados. Tentei puxar os dados dos
discursos via R utilizando o pacote
<a href="https://github.com/leobarone/bRasilLegis">bRasilLegis</a>, mas
descobri que os dados só serão liberados entre hoje (19) e amanhã.
(<a href="http://www.camara.gov.br/internet/sitaqweb/resultadoPesquisaDiscursos.asp?txOrador=&amp;txPartido=&amp;txUF=&amp;dtInicio=17%2F04%2F2016&amp;dtFim=17%2F04%2F2016&amp;txTexto=&amp;txSumario=&amp;basePesq=plenario&amp;CampoOrdenacao=dtSessao&amp;PageSize=50&amp;TipoOrdenacao=DESC&amp;btnPesq=Pesquisar">Atualizado:
os discursos já estão disponíveis)</a>
</p>
<p>
Depois do tratamento do PDF eu utilizei o
<a href="http://www.iramuteq.org">Iramuteq</a>. Para quem não conhece, o
Iramuteq é uma “interface visual ” para utilizar o R e produzir análise
de texto. É um “filho/primo” de um conhecido software de análise de
texto francês chamado Alceste. Suas técnicas, portanto, são fortemente
baseadas na literatura francesa de análise textual.
</p>
<p>
Uma das técnicas mais interessantes do Iramuteq é o método Reinert de
agrupamento de proximidade de palavras. De uma maneira <strong>bem
simples</strong>, ela permite achar grandes grupos temáticos em um
corpus de texto.
</p>
<p>
No exemplo que fizemos, encontramos quatro grandes grupos:<br />
<img class="size-large wp-image-629 aligncenter" src="https://i0.wp.com/ibpad.com.br/wp-content/uploads/2016/04/Termos-1024x1024.jpg?resize=648%2C648" alt="Termos" data-recalc-dims="1" />
</p>
<p>
<span id="more-627"></span>
</p>
<p>
É fácil verificar a posição de cada grupo em relação aos termos vizinhos
e em que medida cada grupo está próximo ao outro. Azul e Verde
representam a turma do SIM,   vermelho a turma do Não e em cinza uma
categoria um pouco mais residual (tem sim, não e também abstenção).
</p>
<p>
O Iramuteq utiliza um dicionário para tratar os termos, então o termo
querida foi tratado como “querido”, observem na nuvem azul. As UFs com
espaço no nome (Ex. “São Paulo”) foram substituídas no corpus por
“são\_paulo” para o Software não entender duas palavras distintas.
</p>
<p>
Outra saída super interessante é a AFC (Análise Fatorial de
Correspondência) das variáveis ilustrativas. Ela permite analisar as
variáveis de cada parlamentares em relação ao seu pronunciamento (UF,
Voto e Partido)
</p>
<p>
 
</p>
<p>
No exemplo, a análise feita foi apenas dos
partidos.<img class="size-large wp-image-628 aligncenter" src="https://i1.wp.com/ibpad.com.br/wp-content/uploads/2016/04/Partidos-1024x1024.jpg?resize=648%2C648" alt="Partidos" data-recalc-dims="1" />
</p>
<p>
 
</p>
<p>
Alguns trabalhos super interessantes como o
<a href="http://www.atlaspolitico.com.br/">Atlas Político</a> e o
<a href="http://radarparlamentar.polignu.org/">Radar Parlamentar</a>
utilizam técnicas “parecidas” para dar o posicionamento dos partidos com
relação ao conjunto de votações nominais feitas em plenário.  Aqui o
Iramuteq aproximou os partidos pelo conteúdo de seus discursos.
</p>
<p>
(Atualizado)
</p>
<p>
Um exemplo que não havia postado antes é a relação entre as UF:
</p>
<p>
<img class=" wp-image-636 aligncenter" src="https://i2.wp.com/ibpad.com.br/wp-content/uploads/2016/04/afcf_col.png?resize=716%2C810" alt="afcf_col" data-recalc-dims="1" />
</p>
<p>
\[:en\]Journalist and political science teacher, Fábio Vasconcelos,
published a quick analysis on the blog
<a href="http://blogs.oglobo.globo.com/na-base-dos-dados/post/o-que-os-votos-sim-e-o-nao-disseram-alem-do-impeachment.html">Na
Base dos Dados</a> which we created on the parliamentarians’ speeches
during the impeachment voting session in the Chamber of Deputies on
17<sup>th</sup> April.
</p>
<p>
For the curious, the database was the Chamber of Deputies’
<a href="http://www.camara.leg.br/internet/plenario/notas/extraord/2016/4/EV1704161400.pdf">PDF</a> (yes,
believe it or not). I tried to extract data from the speeches via R
using the
<a href="https://github.com/leobarone/bRasilLegis">bRasilLegis</a>
package but I discovered that it will only be released between today
(19<sup>th</sup>) and tomorrow.
(<a href="http://www.camara.gov.br/internet/sitaqweb/resultadoPesquisaDiscursos.asp?txOrador=&amp;txPartido=&amp;txUF=&amp;dtInicio=17%2F04%2F2016&amp;dtFim=17%2F04%2F2016&amp;txTexto=&amp;txSumario=&amp;basePesq=plenario&amp;CampoOrdenacao=dtSessao&amp;PageSize=50&amp;TipoOrdenacao=DESC&amp;btnPesq=Pesquisar">Update:
the speeches are now available)</a><u>.</u>
</p>
<p>
After handling the PDF, I used
<a href="http://www.iramuteq.org/">Iramuteq</a>. For those who do not
know about it, Iramuteq is a “visual interface” to use R and produce
textual analysis. It is the “offspring” of well-known French textual
analysis software called Alceste. However, its techniques are strongly
based on the textual analysis of French literature.
</p>
<p>
One of Iramuteq’s most interesting techniques is the Reinert method of
collecting together word proximity. It allows you to find large thematic
groups in the body of a text in a <strong>very simple</strong> way.
</p>
<p>
In this example, we found four large groups:
</p>
<p>
<img class="size-large wp-image-629 aligncenter" src="https://i0.wp.com/ibpad.com.br/wp-content/uploads/2016/04/Termos-1024x1024.jpg?resize=648%2C648" alt="Termos" data-recalc-dims="1" />
</p>
<p>
<!--more-->
</p>
<p>
Each group’s position can be easily confirmed with regards to the
neighbouring terms and the extent to which each group is close to
another. Blue and green represent the Yes group; red the No group and
there is a more residual group in grey (it has yes, no and also
abstentions).
</p>
<p>
Iramuteq uses a dictionary to process the terms, so the term “querida”
was dealt with as “querido”, as can be seen in the blue cloud. The
States with a space in their name (Eg “São Paulo”) were replaced in the
body by “são\_paulo” for the software not to understand two distinct
words.
</p>
<p>
Another really interesting option is factorial Correspondence Analysis
(CA) of the illustrative variables. It allows the variables of each
parliamentarian in relation to their speech (State, Vote and Party) to
be analysed
</p>
<p>
 
</p>
<p>
The analysis was only of the parties in the following example.
</p>
<p>
<img class="size-large wp-image-628 aligncenter" src="https://i1.wp.com/ibpad.com.br/wp-content/uploads/2016/04/Partidos-1024x1024.jpg?resize=648%2C648" alt="Partidos" data-recalc-dims="1" />
</p>
<p>
 
</p>
<p>
Some really interesting work such as
<a href="http://www.atlaspolitico.com.br/">Atlas Político</a> and
<a href="http://radarparlamentar.polignu.org/">Radar Parlamentar</a> use
similar techniques to give the parties’ position in relation to the
roll-call votes cast in the plenary session.  In this case, Iramuteq
brought the parties together from the speech content.
</p>
<p>
(Updated)
</p>
<p>
An example which was not previously posted is the relationship between
the States:
</p>
<p>
<img class=" wp-image-636 aligncenter" src="https://i2.wp.com/ibpad.com.br/wp-content/uploads/2016/04/afcf_col.png?resize=716%2C810" alt="afcf_col" data-recalc-dims="1" />
</p>
<p>
 
</p>
<p>
O post
<a rel="nofollow" href="http://www.ibpad.com.br/blog/analise-de-dados/o-que-os-deputados-federais-disseram/">Análise
de Texto – Os discursos dos Deputados na sessão de votação do
Impeachment</a> apareceu primeiro em
<a rel="nofollow" href="http://www.ibpad.com.br">IBPAD</a>.
</p>

