+++
title = "Top 10 pacotes para data science"
date = "2017-02-21"
categories = ["curso-r"]
+++

<p class="text-muted text-uppercase mb-small text-right">
Por <a href="http://curso-r.com/author/athos">Athos</a> 21/02/2017
</p>
<p>
O R mudou muito nos últimos 5 anos graças a criações de novos pacotes
focados nas questões mais práticas do dia a dia de um cientista de
dados. Abaixo coloquei meu top 10 de pacotes que revolucionaram o jeito
de programar em R e fizeram meu trabalho mais ágil e prazeroso:
</p>
<p>
Nosso décimo lugar colocou o <code>for</code> em perigo de extinção. Com
ele, aplicar funções em vetores, listas ou combinações dos dois é uma
tarefa de poucas linhas e sem a necessidade de índices i, j, k’s
confusos. E ainda, com o advento das
<a href="https://cran.r-project.org/web/packages/tibble/tibble.pdf">tibbles</a>,
seus data.frames ganharam potencial de guardar muito mais do que meros
números e strings e o purrr é seu mais forte aliado na hora de criar as
chamadas
<a href="https://jennybc.github.io/purrr-tutorial/ls13_list-columns.html"><em>list-columns</em></a>.
</p>

<p>
Se você procura modelagem estatística (ferramenta básica do cientista de
dados), dê chance ao
<a href="http://caret.r-forge.r-project.org/">caret</a>. Esse pacote
compilou os mais consagrados algoritmos de modelos preditivos (vulgo
<em>machine learning</em>) já feitos no R e ainda implementou
ferramentas típicas de um processo de construção de modelos, por
exemplo, cross-validation, ajuste de hiperparâmetros, bases
treino/teste, pré-processamentos e até paralelização. Além das
diferentes técnicas de ajuste de modelos, os seus respectivos
diagnósticos e visualizações também foram convenientemente compiladas,
tudo num mesmo lugar, fazendo a procura de peças no gigantesco balde do
R ser menos custosa.
</p>

<p>
A dupla <a href="https://yihui.name/knitr/">knitr</a> e
<a href="http://rmarkdown.rstudio.com/">rmarkdown</a> fizeram do R de
patinho feio para o rei dos holofotes. Depois deles, relatórios no R são
fáceis, bonitos e flexíveis. Escrever em RMarkdown é como escrever um
rascunho, que depois é transformado em um arquivo decente em qualquer
formato: pdf, word e html são os mais comuns. A ideologia por trás do
RMarkdown é trazer o foco para a análise e deixar as perfumarias para
segundo plano o máximo possível.
</p>
<p>
OBS: todos os posts desse blog são feitos em RMarkdown!
</p>

<p>
Stringr te dá tudo para extrair, criar e transformar strings. As funções
aceitam
<a href="https://stat.ethz.ch/R-manual/R-devel/library/base/html/regex.html">regex</a>
extremamente versáril e eficiente. Mineração de texto vira brincadeira.
</p>

<p>
<a href="https://shiny.rstudio.com/">Shiny</a> dá o poder de fazer
aplicações na web a um analista de dados sem nenhum conhecimento prévio
de html, css e javascript. Acredite se quiser, agora, fazer sites
interativos e orientados por dados não é mais exclusividade dos
desenvolvedores web. Com uma curva de aprendizagem ligeiramente
alongada, pode-se criar de dashboards estáticos a mapas personalizados a
lá google maps! É uma ótima maneira de apresentar resultados e serve
muito bem como produto final de ferramentas de gestão.
</p>

<p>
As principais funções são <code>gather()</code> e <code>spread()</code>.
Elas pivotam/despivotam data.frames, ou derretem/condensam data.frames.
Ela merece nosso quarto lugar porque possui uma grande sinergia com os
terceiro e segundo lugares. Não raramente precisamos rearranjar conjunto
de colunas em um par de colunas chave/valor ou vice-versa.
Pivotar/despivotar é particularmente muito chato de fazer em SQL e o
<a href="https://blog.rstudio.org/2014/07/22/introducing-tidyr/">tidyr</a>
faz isso parecer trivial. Ele também possui outras funções úteis que
recomendo dar uma olhada (ex: <code>unite()</code>,
<code>separete()</code>).
</p>

<p>
Nossa medalha de bronze vai para
<a href="https://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html">dplyr</a>
porque ele trouxe os verbos de manipulação de base de dados para o nível
mais simples e intuitivo. São eles:
</p>
<ul>
<li>
<code>filter()</code> filtra linhas
</li>
<li>
<code>arrange()</code> ordena linhas
</li>
<li>
<code>select()</code> seleciona colunas
</li>
<li>
<code>distinct()</code> retira linhas duplicadas
</li>
<li>
<code>mutate()</code> constrói novas colunas
</li>
<li>
<code>group\_by()</code> + <code>summarise()</code> sumariza valores por
um ou mais fatores
</li>
</ul>
<p>
E o pacote vai muito além desses verbos. Vale a pena explorar suas
funções se você precisa deixar sua base pronta para analisar.
</p>
<p>
OBS: foi feito para funcionar com o <em>“pipe”</em> (%&gt;%).
</p>

<p>
A medalha de prata eu acho que é o pacote mais famoso do R.
</p>
<p>
O R é conhecido pela sua rica capacidade gráfica, mas foi o
<a href="http://docs.ggplot2.org/current/">ggplot2</a> que trouxe a
alegria de viver para os usuários minimamente preocupados com a boa
aparência de suas visualizações. O
<a href="http://docs.ggplot2.org/current/">ggplot2</a> permite usar a
“gramática de gráficos”
(<a href="http://vita.had.co.nz/papers/layered-grammar.pdf"><em>grammar
of graphics</em></a>) para construir gráficos em camadas e
customizáveis. Há uma pequena curva de aprendizado, mas o tempo
investido se paga no primeiro gráfico gerado. Gráficos que seriam
veradeiras obras da engenharia se feitas no R-base não passariam de 5
linhas de <a href="http://docs.ggplot2.org/current/">ggplot2</a> e ainda
ficariam mais bonitos!
</p>
<p>
Indispensável na caixa de ferramentas de qualquer cientista de dados.
</p>

<p>
A medalha de ouro nos fornece o tal do <em>pipe</em> (%&gt;%). Em vez de
<code>h(g(f(x)))</code>, escreva <code>x %&gt;% f %&gt;% g %&gt;%
h</code>. Pronto! É tudo o que o <em>pipe</em> faz. Você pode se
perguntar por que raios isso merece o nosso primeiro lugar, mas
acredite: o <em>pipe</em> é revolucionário. Ele mudou o jeito de se
programar em R. Com ele o ganho em legibilidade dos códigos e agilidade
na programação é inimaginável. E ainda abriu portas para desenvolvimento
de pacotes que sem ele não seriam viáveis, incluindo o dplyr e tidyr.
</p>
<p>
E por isso que ele merece estar no primeiro lugar na nossa lista e no
logo da nossa página.
</p>

<p>
Outros pacotes também merecem destaque! As medálhas de honra ao mérito
vão para:
</p>
<ul>
<li>
<strong>forcats</strong> (utilidades para fatores)
</li>
<li>
<strong>Rcpp</strong> (R para C++)
</li>
<li>
<strong>FactoMiner</strong> (análise multivariada)
</li>
<li>
<strong>RODBC</strong> (conexão com banco de dados)
</li>
<li>
<strong>httr/xml2/rvest</strong> (ferramentas para web)
</li>
<li>
<strong>flexdashboard</strong> (rmarkdown para formato de dashboard)
</li>
<li>
<strong>janitor</strong> (limpeza de dados para modelagem)
</li>
<li>
<strong>plyr</strong> (manipulação de vetores, listas e data.frames)
</li>
<li>
<strong>roxygen2</strong> (criação de pacotes de R)
</li>
<li>
<strong>devtools</strong> (ferramentas diversas)
</li>
<li>
<strong>htmlwidgets</strong> (integração entre R e bibliotecas
JavaScript)
</li>
<li>
<strong>leaflet</strong> (mapas interativos)
</li>
</ul>
<p>
E você, concorda? Coloque nos comentários os pacotes que moram em seu
coração! =)
</p>

