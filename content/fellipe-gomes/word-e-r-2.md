+++
title = "Produzindo e formatando um documento Word direto em R"
date = "2018-03-07"
categories = ["fellipe-gomes"]
original_url = "https://gomesfellipe.github.io/post/2018-03-07-word-e-r-2/word-e-r-2/"
+++

<p id="main">
<article class="post">
<header>
<p>
As análises foram feitas em R, e agora? Geralmente um bom PDF ou HTML
são suficientes mas e se o destino da análise tiver que ser um documento
Word?
</p>

</header>
<a href="https://gomesfellipe.github.io/post/2018-03-07-word-e-r-2/word-e-r-2/" class="image featured">
<img src="https://gomesfellipe.github.io/img/2018/03/Word-R.png" alt="">
</a>
<p>
Como já mencionei no
<a href="https://gomesfellipe.github.io/post/2018-01-12-tabelas-incriveis-com-r/tabelas-incriveis-com-r/">post
sobre tabelas incríveis com R</a>, a tarefa de um estatístico (ou Data
Scient, em sua versão diluída e mais comercial) vai muito além do
planejamento, análises, inferência, sumarização e interpretação de
observações para fornecer a melhor informação possível a partir do dados
disponíveis. A produção final dos relatórios é fundamental e na grande
maioria das vezes utiliza-se a linguagem <span
class="math inline">$\\LaTeX$</span>, mas será que ela é realmente a
única opção?
</p>
<p>
A escrita para a produção de documentação técnica e científica de alta
qualidade é tão importante que até o
<a href="https://www.prof-edigleyalexandre.com/2017/10/agora-facebook-messenger-permite-que-voce-escreva-formulas-matematicas-basicas-laTex.html">Facebook
permite usar a linguagem <span class="math inline">$\\LaTeX$</span> no
messenger</a>. Normalmente para gerar arquivos em <span
class="math inline">$\\LaTeX$</span> existem muitas opções de softwares
ou mesmo opções online como o
<a href="https://www.overleaf.com/">overleaf</a> ou o
<a href="https://pt.sharelatex.com/">sharelatex</a> que permitem
escrever os documentos online com compilação em tempo real e
armazenamento automático na nuvem. Para esse tipo de relatório escrito
puramente em <span class="math inline">$\\LaTeX$</span>, as funções dos
pacotes
<a href="https://cran.r-project.org/web/packages/stargazer/">stargazer</a>,
<a href="https://cran.r-project.org/web/packages/xtable/index.html">xtable</a>,
<a href="https://cran.r-project.org/web/packages/pander/index.html">pander</a>
dentre outros, podem ser muito úteis na tarefa de produzir as tabelas
dos resultados obtidos das análises em R para o formato <span
class="math inline">$\\LaTeX$</span>.
</p>
<p>
Além desses softwares a linguagem <span
class="math inline">$\\LaTeX$</span> pode ser utilizada diretamente de
dentro do R em duas opções: O documento R Sweave e o documento
Rmarkdown. Se for em Rmarkdown será necessária algumas configurações,
como por exemplo algumas vezes a opção <code>results = "asis"</code>
deve ser incluída nos chunks que deseja-se renderizar as tabelas <span
class="math inline">$\\LaTeX$</span>, caso seja R Sweave, pode ser que
<a href="https://stat.epfl.ch/webdav/site/stat/shared/Regression/EPFL-Sweave-powerdot.pdf">essa
documentação</a> ajude, pois as configurações dos chunks podem ser
diferentes das configurações utilizadas em R markdown).
</p>
<p>
Porém, não basta obter informação através dos dados e com técnicas
específicas transformá-los em conhecimento, geralmente tal conhecimento
será destinado para alguma finalidade e não necessariamente a pessoa que
irá receber nossos resultados vai desejar um documento em PDF ou html,
além de não trabalhar com <a href="https://www.latex-project.org/"><span
class="math inline">$\\LaTeX$</span></a> nem conhecer as linguagens de
programação muito utilizadas por nós, como
<a href="https://www.r-project.org/">R</a> ou
<a href="https://pt.wikipedia.org/wiki/Markdown">Markdown</a>. Na
verdade isso nem é mesmo uma obrigação para quem contrata serviços de
analytics.
</p>

<p>
A partir do momento que é assumida que a responsabilidade do
entendimento da informação que passamos, acaba sendo necessário sair da
nossa zona de conforto e aprender a falar na língua de quem nos ouve,
para que a informação seja passada da maneira mais clara possível.
</p>
<p>
É muito comum criarmos nossas figuras e tabelas super elegantes e
rechear nossos relatórios com as mais espertas interpretações a cerca
dos resultados e compilar tudo em um arquivo .PDF (geralmente ao se
utilizar <span class="math inline">$\\LaTeX$</span>) ou mesmo em .html
(muito comum ao se utilizar Rmarkdown), porém muitas vezes nossos
resultados serão reaproveitados em documentos escritos em outros
formatos e uma das escolhas optadas em escala mundial é escrever
documentos em Word.
</p>
<p>
Geralmente quem trabalha com programação está sempre atento a otimizar
seus processos, portanto integrar nossos resultados do R com um
documento em Word é uma tarefa que pode ser muito útil dependendo da
finalidade dos nossos dados.
</p>
<p>
Existem extensões para escrever <span
class="math inline">$\\LaTeX$</span> diretamente no word, como por
exemplo o <a href="http://texpoint.necula.org/">TexPoint</a> que permite
escrever invocações e definições de macro <span
class="math inline">$\\LaTeX$</span> junto com seu texto normal ou o
<a href="http://aurora.pt.downloadastro.com/">Aurora</a> que é um
programa de edição de texto que permite introduzir funções matemáticas
complexas em texto de modo a esboçar relatórios e outras mensagens com
caracteres únicos e equações. Particularmente nunca usei nenhuma das
duas opções mas elas estão aí para quem quiser testar.
</p>
<p>
A extensão para word chamada
<a href="http://www.grindeq.com/index.php?p=latex2word">GrindEQ™ Math
Utilities</a> que permite fazer a conversão do documento <span
class="math inline">$\\LaTeX$</span> para word já foi muito útil para
mim, porém muitas vezes ocorriam bugs na formatação e com a finalidade
de focar meus esforços nas análises e não na formatação comecei uma
busca por alguma maneira de que a formatação pudesse ser feita toda em R
e o arquivo final ser um documento word já formatado.
</p>
<center>
<img src="http://www.grindeq.com/img/ribbon.jpg">

</center>
<p>
Em minhas pesquisas descobri que existem diversas outras maneiras de se
produzir um documento Word através do R, vou apresentar aqui duas
maneiras com alguns truques, mas por favor, sintam-se a vontade para dar
sugestões de outras maneiras de se fazer isso nos comentários, será de
grande ajuda!
</p>
<p>
O primeiro método envolve o uso da opção nativa do R de produzir esse
tipo de documento. Segundo este
<a href="https://rmarkdown.rstudio.com/articles_docx.html">guia
disponível pela RStudio</a> basta selecionar o tipo de arquivo Rmarkdown
da seguinte maneira:
</p>
<center>
<img src="https://d33wubrfki0l68.cloudfront.net/a419c1c8f567e88f1ed51ade70752254d630de49/fc1b2/articles/images/new-file-screenshot.png">
</center>
<p>
Então selecione o formato Word para o documento, e se desejar já pode
alterar o nome do título e autor do documento (não é obrigado a fazer
isso nesse momento)
</p>
<center>
<img src="https://d33wubrfki0l68.cloudfront.net/66a92ebda97ab32fc7b4dc3a919fcc688a15482c/32107/articles/images/new-r-markdown-box.png">
</center>
<p>
Um novo documento será exibido com o preâmbulo default para esse tipo de
arquivo. O interessante aqui é que você pode compilar seu documento,
alterar o estilo e salvar na mesma pasta do arquivo que você está
trabalhando, de forma que as alterações no estilo sejam salvas e
utilizadas como referência ao incluir no preâmbulo o nome deste
documento como no exemplo a seguir:
</p>
<pre><code>---
title: &quot;T&#xED;tulo do trabalho&quot;
author: &quot;Fellipe&quot;
date: &quot; 06 de mar&#xE7;o de 2018&quot;
output: word_document: reference_docx: word-styles-reference-01.docx
---</code></pre>
<p>
Outros recursos interessantes são os de formatar tabelas e figuras. Para
formatar as tabelas podemos utilizar os pacotes que já usávamos em
documentos <span class="math inline">$\\LaTeX$</span> para PDF ou Rmd
para html. como por exemplo veja uma tabela simples produzida por
códigos em R gerando uma tabela em Word usando a função
<code>kable</code>:
</p>
<center>
<img src="https://gomesfellipe.github.io/img/2018-03-07-word-e-r-2/img4.png">
</center>
<p>
Muitas outras opções podem ser utilizadas, mais informações podem ser
conferidas na
<a href="https://rmarkdown.rstudio.com/articles_docx.html">documentação
no site da RStudio</a> ou então conferir as opções de formatação de
tabelas utilizando a função <code>kable()</code> e o pacote
<code>kableExtra</code>, mais opções podem ser obtidas no
<a href="https://cran.r-project.org/web/packages/kableExtra/vignettes/awesome_table_in_html.html">manual
do pacote kableExtra</a>.
</p>
<p>
Para alterar as dimensões de todas as figuras do documento ou mesmo
incluir um sumário também basta alterar as especificações do preâmbulo,
como por exemplo:
</p>
<pre><code>---
title: &quot;T&#xED;tulo do trabalho&quot;
author: &quot;Fellipe&quot;
date: &quot; 06 de mar&#xE7;o de 2018&quot;
output: word_document reference_docx: word-styles-reference-01.docx fig_width: 7 fig_height: 4 fig_caption: true toc: true
---</code></pre>
<p>
Muito simples gerar o arquivo diretamente em Word!
</p>

<p>
Mesmo com a simplicidade oferecida pelo recurso nativo do R, eu não
estava conseguido formatar as tabelas da maneira que eu desejava, já fiz
um post falando sobre
<a href="https://gomesfellipe.github.io/post/2018-01-12-tabelas-incriveis-com-r/tabelas-incriveis-com-r/">como
criar tabelas incríveis com R</a> porém a maioria das opções dos pacotes
apresentados lá servem apenas para documentos no formato html.
</p>
<p>
Pensando nisso pesquisei se havia algum jeito de criar o documento em
html que pudesse ser aberto no Word e encontrei este pacote disponível
no github chamado
<a href="https://github.com/gforge/Grmd"><code>Grmd</code></a> que
serviu como uma luva! Sua finalidade é trabalhar com a publicação
rápida, escrevendo o documento como já fazíamos em RMarkdown e
permitindo que o documento html gerado possa ser aberto em Word sem
problemas de formatação!
</p>
<p>
Por exemplo, uma formatação da tabela que é muito simples de se fazer em
html com o <code>knitr::kable()</code>:
</p>
<pre class="r"><code>dt &lt;- mtcars[1:5, 1:6]
#Tabela gerada:
kable(dt, &quot;html&quot;, caption= &quot;T&#xED;tulo&quot;, align = c(&quot;l&quot;,&quot;r&quot;,&quot;l&quot;,&quot;r&quot;,&quot;l&quot;,&quot;r&quot;,&quot;l&quot;)) %&gt;% add_header_above(c(&quot; &quot; = 1, &quot;Group 1&quot; = 2, &quot;Group 2&quot; = 2, &quot;Group 3&quot; = 2))%&gt;% group_rows(&quot;Grupo A&quot;,1,3)%&gt;% group_rows(&quot;Grupo B&quot;,4,5)</code></pre>
<table>
<caption>
<span id="tab:unnamed-chunk-1">Table 1: </span>Título
</caption>
<thead>
<tr>
<th>
</th>
<th>
</th>
<th>
</th>
<th>
</th>
</tr>
<tr>
<th>
</th>
<th>
mpg
</th>
<th>
cyl
</th>
<th>
disp
</th>
<th>
hp
</th>
<th>
drat
</th>
<th>
wt
</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<strong>Grupo A</strong>
</td>
</tr>
<tr>
<td>
Mazda RX4
</td>
<td>
21.0
</td>
<td>
6
</td>
<td>
160
</td>
<td>
110
</td>
<td>
3.90
</td>
<td>
2.620
</td>
</tr>
<tr>
<td>
Mazda RX4 Wag
</td>
<td>
21.0
</td>
<td>
6
</td>
<td>
160
</td>
<td>
110
</td>
<td>
3.90
</td>
<td>
2.875
</td>
</tr>
<tr>
<td>
Datsun 710
</td>
<td>
22.8
</td>
<td>
4
</td>
<td>
108
</td>
<td>
93
</td>
<td>
3.85
</td>
<td>
2.320
</td>
</tr>
<tr>
<td>
<strong>Grupo B</strong>
</td>
</tr>
<tr>
<td>
Hornet 4 Drive
</td>
<td>
21.4
</td>
<td>
6
</td>
<td>
258
</td>
<td>
110
</td>
<td>
3.08
</td>
<td>
3.215
</td>
</tr>
<tr>
<td>
Hornet Sportabout
</td>
<td>
18.7
</td>
<td>
8
</td>
<td>
360
</td>
<td>
175
</td>
<td>
3.15
</td>
<td>
3.440
</td>
</tr>
</tbody>
</table>
<p>
Pode ser muito útil utilizar da mesma praticidade de construir as
tabelas em html nos documentos words. Utilizando o pacote
<a href="https://github.com/gforge/Grmd"><code>Grmd</code></a>, ao abrir
o documento no Word a tabela ao lado ficará da seguinte maneira em word:
</p>
<center>
<img src="https://gomesfellipe.github.io/img/2018-03-07-word-e-r-2/img2.png">
</center>
<p>
Para utilizar o pacote basta instala-lo através da função
<code>devtools::install\_github("gforge/Grmd")</code>, após o pacote
instalado é só modificar onde estiver escrito
<code>output:word\_document</code> no preâmbulo por
<code>Grmd::docx\_document</code> e ficar tranquilo, porque todas as
funcionalidades apresentadas acima continuam funcionando! Veja o exemplo
acima alterado:
</p>
<pre><code>---
title: &quot;T&#xED;tulo do trabalho&quot;
author: &quot;Fellipe&quot;
date: &quot; 06 de mar&#xE7;o de 2018&quot;
output: word_document reference_docx: word-styles-reference-01.docx fig_width: 7 fig_height: 4 fig_caption: true toc: true
---</code></pre>
<p>
Portanto ao deixar o preâmbulo dessa nova maneira, seu documento será
renderizado em html e poderá ser aberto e editado como documento Word
tranquilamente! Assim a pessoa que receber o relatório final estará em
contato direto com suas análises em um formato que seja amigável para
ela e ela se sinta confortável em editar, copiar, colar ou fazer o que
bem entender!
</p>
<p>
Atenção! Pois no github do desenvolvedor possui um aviso de que o pacote
“provavelmente será fundido com o pacote Gmisc”, portanto é bom ficar
atento a possíveis alterações!
</p>

<p>
A principal dica quando não sabemos resolver um problema é: MANTENHA A
CALMA! Mesmo com todas essas opções, ainda existem casos que nenhum
esses artifícios será o bastante! Para isso muitas vezes é preciso
explorar o desconhecido e usar a criatividade!
</p>
<p>
Um problema prático que eu tive e precisava solucionar em um tempo
razoavelmente curto era que de as margens das tabelas que eu criei não
cabiam de maneira satisfatória na página. Diante disso pesquisei
bastante e me lembrei que assim como o Excel, o Word também possui
Macros! Portanto pesquisando mais um pouco na internet encontrei
<a href="https://datascienceplus.com/r-markdown-how-to-format-tables-and-figures-in-docx-files/">este
artigo</a> que ensina como formatar tabelas e figuras em documentos
.docx!
</p>
<center>
<img src="https://lh6.googleusercontent.com/-pgLFnuWFV7E/UDVVoRcvmrI/AAAAAAAAAxU/1qTUIIrvxpA/s347/Bot%25C3%25A3o%2520Macro.png">
</center>
<p>
<a href="https://datascienceplus.com/r-markdown-how-to-format-tables-and-figures-in-docx-files/">No
artigo</a> é apresentada uma Macro para formatar as tabelas então depois
de pesquisar um pouco e fazer algumas alterações foi bem útil para
resolver meu problema com o tamanho da letra e a posição das tabelas! A
Macro adaptada foi a seguinte:
</p>
<pre><code>Sub FormatTables() Dim tbl As Table For Each tbl In ActiveDocument.Tables tbl.AutoFormat wdTableFormatList6 tbl.Range.Font.Name = &quot;Arial&quot; tbl.Range.Font.Size = 6 tbl.Range.ParagraphFormat.SpaceBefore = 1 tbl.Range.ParagraphFormat.SpaceAfter = 2 tbl.Range.Cells.SetHeight RowHeight:=18, HeightRule:=wdRowHeightExactly Next End Sub</code></pre>
<p>
Esta macro formata todas as tabelas o documento, selecionando o estilo
<code>TableFormatList6</code>, a fonte <code>Arial</code> com o tamanho
<code>6</code> e altera os espaçamentos de parágrafos, resumindo todo
esse processo em um único botão
</p>

<center>
<img src="https://gomesfellipe.github.io/img/2018-03-07-word-e-r-2/img3.jpg">
</center>
<p>
Após usar o o recurso <code>Grmd::docx\_document</code> em conjunto com
a Macro <code>FormatTables</code> foi possível focar nas análises dos
resultados e deixar a tarefa de formatação muito mais ágil, porém este
método não é definitivo e a busca por novas maneiras de fazer e otimizar
esse e outros tipos de tarefas integradas com R continua!
</p>

<footer>
</footer>
</article>
<article class="post">
<a href="https://disqus.com/" class="dsq-brlink">comments powered by
</a>
</article>
</p>

