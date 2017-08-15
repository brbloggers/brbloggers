+++
title = "O pacote Tidyverse para R"
date = "2017-08-15 02:01:11"
categories = ["jose-guilherme-lopes"]
original_url = "http://joseguilhermelopes.com.br/o-pacote-tidyverse-para-r/"
+++

<p>
O <a href="http://tidyverse.org/">Tidyverse </a>é uma coleção de pacotes
do R que, em conjunto, formam um eficiente sistema para importação,
manipulação, exploração e visualização de dados.
</p>
<p>
Em outras palavras, carregar o pacote Tidyverse é carregar de uma só vez
todo um conjunto de ferramentas necessárias para um processo de análise
de dados.
</p>
<p>
Executar o comando:
</p>
<pre class="brush: r; title: ; notranslate"> install.packages(&quot;tidyverse&quot;) </pre>
<p>
é equivalente à executar o comando:
</p>
<pre class="brush: r; title: ; notranslate">install.packages(c( &quot;broom&quot;, &quot;dplyr&quot;, &quot;feather&quot;, &quot;forcats&quot;,&quot;ggplot2&quot;, &quot;haven&quot;, &quot;httr&quot;, &quot;hms&quot;, &quot;jsonlite&quot;, &quot;lubridate&quot;, &quot;magrittr&quot;, &quot;modelr&quot;, &quot;purrr&quot;, &quot;readr&quot;, &quot;readxl&quot;, &quot;stringr&quot;, &quot;tibble&quot;, &quot;rvest&quot;, &quot;tidyr&quot;, &quot;xml2&quot; )) </pre>
<p>
Ou seja, de uma só vez, o Tidyverse carrega os 20 pacotes que são
utilizados em praticamente qualquer análise de dados com o R.
</p>
<p>
Desenvolvido principalmente pelo cientista-chefe do
<a href="https://www.rstudio.com/">RStudio</a>, <a href="http://hadley.nz/">Hadley
Wickham</a>, e por mais uma série de colaboradores, os pacotes do
tidyverse dão ao programador uma maior produtividade, pois fornecem
funções que facilitam (e muito) o fluxo de trabalho.
</p>
<p>
Em essência, o Tidyverse se trata das conexões entre as ferramentas que
tornam o fluxo de trabalho possível.
</p>
<h2>
<strong>O Tidyverse em cada etapa de uma análise de dados</strong>
</h2>
<p>
O <em>Tidy,</em> da palavra Tidyverse, significa organizar; arrumar;
limpar; deixar em ordem.
</p>
<p>
A expressão “Tidy data” (organizar os dados) descreve o ato de
estruturar bancos de dados para tornar mais fácil a realização de
análises e visualizações de dados. No caso do Tidyverse, a manipulação
dos dados é, em geral, para datasets em formato <em>retangular</em>, ou
seja, no formato linhas e colunas.
</p>
<p>
Mas o Tidyverse, como já dito, traz um conjunto de pacotes utilizáveis
em todo um processo de análise de dados. Podemos resumir um fluxo de
trabalho em Ciência de Dados de acordo com a imagem a seguir:
</p>
<p>
<img class="aligncenter" src="https://rviews.rstudio.com/post/2017-06-09-What-is-the-tidyverse_files/tidyverse2.png" width="714">
</p>
<p>
Tendo a imagem acima como referência, a imagem a seguir mostra os
pacotes incluídos no Tidyverse para cada uma das etapas do fluxo de
trabalho:
</p>
<p>
<img src="https://rviews.rstudio.com/post/2017-06-09-What-is-the-tidyverse_files/tidyverse1.png">
</p>
<h2>
<strong><br> Os pacotes que formam o núcleo do Tidyverse</strong>
</h2>
<p>
<img class="alignnone wp-image-325" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/08/hex-ggplot2-259x300.png%20259w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/08/hex-ggplot2.png%20736w" alt="" width="140" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/08/hex-ggplot2-259x300.png 259w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/08/hex-ggplot2.png 736w">
</p>
<p>
O <strong>ggplot2</strong> é o mais popular pacote para visualização de
dados do R. Com ele, é possível criar gráficos incríveis nos
<a href="http://r-statistics.co/Top50-Ggplot2-Visualizations-MasterList-R-Code.html">mais
diversos formatos</a>.
</p>
<p>
Há uma infinidade de possíveis cruzamentos de dados para geração de
gráficos com o ggplot. Mas, em geral, o código para criar um gráfico
segue o seguinte formato:
</p>
<p>
Especifica-se o seu dataset como argumento da
função <strong>ggplot()</strong>, e em seguida especificam-se as
variáveis a serem exibidas, como argumentos da
função <strong>aes()</strong>. Por
exemplo: <strong>ggplot(</strong><em>DATASET, <strong>aes(</strong>VARIAVEL1,
VARIAVEL2<strong>))</strong></em>.
</p>
<p>
Em seguida, define-se o tipo de gráfico a ser utilizado. Em geral, os
nomes das funções para gráficos começam com <strong>geom\_</strong> (por
exemplo, <strong>geom\_point</strong><strong>()</strong> é para um
gráfico de dispersão).
</p>
<p>
Há ainda diversas outras funções para definir escalas, especificações e
sistemas de coordenadas.
</p>
<p>
Explore o pacote vendo a lista das funções que aparece ao digitar o
comando <strong>ggplot2::</strong>
</p>
<p>
Consulte também as referências para o ggplot feito pelo próprio criador
do Tidyverse
<a href="http://r4ds.had.co.nz/data-visualisation.html">neste link.</a>
</p>
<p>
<img class="wp-image-326 aligncenter" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/08/hex-dplyr-259x300.png%20259w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/08/hex-dplyr.png%20736w" alt="" width="140" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/08/hex-dplyr-259x300.png 259w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/08/hex-dplyr.png 736w">
</p>
<p>
O <strong>dplyr </strong>traz excelentes funções para manipulação e
transformação de dados.
</p>
<p>
O criador do Tidyverse escreveu um capítulo no livro R for Data Science
exclusivo sobre este pacote, confira
<a href="http://r4ds.had.co.nz/transform.html">aqui</a>.
</p>
<p>
As principais funções do dplyr são:
</p>
<ul>
<li>
<a href="http://dplyr.tidyverse.org/reference/mutate.html"><strong>mutate(
)</strong></a> cria novas varíaveis que são funções de variáveis já
existentes.
</li>
<li>
<a href="http://dplyr.tidyverse.org/reference/select.html"><strong>select(
)</strong></a> permite selecionar as variáveis que se deseja trabalhar e
assim criar um novo dataset.
</li>
<li>
<a href="http://dplyr.tidyverse.org/reference/filter.html"><strong>filter(
)</strong></a> realiza a mesma função dos filtros do Excel, selecionar
as linhas por um critério definido.
</li>
<li>
<a href="http://dplyr.tidyverse.org/reference/summarise.html"><strong>summarise(
)</strong></a> gera valores resumo de um agrupamento dos dados (ex: pela
média, por quantis, etc.).
</li>
<li>
<a href="http://dplyr.tidyverse.org/reference/arrange.html"><strong>arrange(
)</strong></a> edita a ordem das linhas de acordo com um critério.
</li>
</ul>
<p>
<img class="wp-image-330 aligncenter" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/08/hex-tidyr-259x300.png%20259w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/08/hex-tidyr.png%20736w" alt="" width="140" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/08/hex-tidyr-259x300.png 259w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/08/hex-tidyr.png 736w">
</p>
<p>
O <strong>tidyr</strong> é feito para colocar o seu banco de dados em
ordem, deixá-lo ordenado. Ou seja:
</p>
<p>
Cada variável está em uma coluna;
</p>
<p>
Cada observação está em uma linha; e
</p>
<p>
Cada valor está em uma célula.
</p>
<p>
<img class="alignleft" src="http://r4ds.had.co.nz/images/tidy-1.png" width="531">
</p>
<p>
O tidyr é um dos primeiros pacotes a serem utilizados em uma análise de
dados. Se você “limpa” o seu banco de dados logo no início, você já se
previne de possíveis problemas que podem aparecer na hora em que começar
a manipular os dados.
</p>
<p>
As principais funções do tidyr são:
</p>
<ul>
<li>
<a href="http://tidyr.tidyverse.org/reference/gather.html"><strong>gather(
)</strong></a> para união de colunas, no caso em que informações de uma
mesma variável estão divididas em diferentes colunas.
</li>
<li>
<strong><a href="http://tidyr.tidyverse.org/reference/spread.html">spread(
)</a> </strong>para divisão de colunas, no caso em que informações de
diferentes variáveis estão em uma mesma coluna.
</li>
</ul>
<p>
Veja mais sobre o tidyr
<a href="http://r4ds.had.co.nz/tidy-data.html">neste link.</a>
</p>
<p>
<img class="wp-image-328 aligncenter" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/08/hex-readr.png" alt="" width="140">
</p>
<p>
O <strong>readr</strong> é o pacote para importação de dados.
</p>
<p>
É um pacote feito para importar dados do tipo <em>retangular</em>
(linhas e colunas) para diferentes formatos de arquivos, sendo um pacote
bastante flexível.
</p>
<p>
Ainda que o RStudio possua um espaço no environment para importar dados
no clique, o readr se faz útil em muitas ocasiões.
</p>
<p>
Aprenda mais sobre o pacote
<a href="http://r4ds.had.co.nz/data-import.html">neste link.</a>
</p>
<p>
<img class=" wp-image-327 aligncenter" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/08/hex-purrr.png" alt="" width="141">
</p>
<p>
O <strong>purrr</strong> possui um conjunto de ferramentas para
<em>programação funcional</em>  dentro do R, fornecendo um conjunto
completo de ferramentas para se trabalhar com funções e vetores.
</p>
<p>
Para começar a se trabalhar com programação funcional, o conjunto de
funções <strong><a href="http://purrr.tidyverse.org/reference/map.html">map(
)</a> </strong>é uma ótima referência.
</p>
<p>
Veja mais sobre as funções map( )
<a href="http://r4ds.had.co.nz/iteration.html">neste link.</a>
</p>
<p>
<img class="wp-image-329 aligncenter" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/08/hex-tibble.png" alt="" width="141">
</p>
<p>
<strong>tibble</strong>, além do nome do pacote, é um tipo diferente e
moderno para bancos de dados (datasets). A funcionalidade de um tibble é
que ele te força a confrontar problemas no seu banco de dados logo no
início, te levando a organizá-lo e a escrever códigos mais expressivos.
</p>
<p>
Veja mais sobre tibbles
<a href="http://r4ds.had.co.nz/tibbles.html">neste link.</a>
</p>
<h2>
<strong><br> O operador pipe %&gt;%</strong>
</h2>
<p>
Uma das grandes vantagens do Tidyverse, é que ele traz o operador
<strong>%&gt;%</strong>, chamado de pipe, do pacote <em>magrittr</em>.
</p>
<p>
Este é um operador incrivelmente útil, pois torna dispensável a escrita
de comandos multi-operacionais e permite “desfragmentar” as funções de
um comando em partes. Isso torna o código mais fácil para escrever e
para ler.
</p>
<p>
O operador pipe leva a função do lado esquerdo e a carrega para a função
do lado direito. O operador, literalmente, deixa a primeira função como
argumento da função seguinte.
</p>
<p>
A imagem a seguir exemplifica a função do operador pipe, mostrando que
os dois comandos são equivalentes.
</p>
<p>
<img class="alignnone wp-image-339" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/08/the-tidyverse-and-the-future-of-the-monitoring-toolchain-80-638-300x169.jpg%20300w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/08/the-tidyverse-and-the-future-of-the-monitoring-toolchain-80-638.jpg%20638w" alt="" width="369" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/08/the-tidyverse-and-the-future-of-the-monitoring-toolchain-80-638-300x169.jpg 300w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/08/the-tidyverse-and-the-future-of-the-monitoring-toolchain-80-638.jpg 638w">
</p>
<p>
Se você pensa na palavra “<em>obtenha</em>” ao utilizar o operador
<strong>&lt;- </strong>,<strong> </strong> você pode pensar na palavra
“<em>então” </em>para o operador <strong>%&gt;%.</strong>
</p>
<h2>
<strong>Para ir além</strong>
</h2>
<p>
O criador do Tidyverse é também escritor do
livro <strong><a href="http://r4ds.had.co.nz/">R for Data
Science</a>, </strong>excelente material para aprendizado de programação
em R, que possui foco especial nos pacotes e funções carregadas pelo
Tidyverse.
</p>
<p>
Você também pode encontrar muitos tutoriais no
<a href="http://wp.me/p8PqTk-2U">Kaggle</a>, além de uma grande
quantidade de datasets para colocar em prática o seu aprendizado com o
Tidyverse. Caso queira colocar em prática com dados gerados por você
mesmo, veja este artigo sobre como minerar dados do
<a href="http://wp.me/p8PqTk-1E">Facebook com o R</a>.
</p>
<p>
Espero que este artigo lhe tenha sido útil e que você possa tirar grande
proveito das dicas que citei aqui.
</p>
<p>
Boas análises e até a próxima!
</p>

