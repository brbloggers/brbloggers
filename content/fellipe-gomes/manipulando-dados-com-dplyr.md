+++
title = "Manipulando dados com dplyr"
date = "2017-12-07"
categories = ["fellipe-gomes"]
original_url = "https://gomesfellipe.github.io/post/2017-12-07-manipulando-dados-com-dplyr/manipulando-dados-com-dplyr/"
+++

<p id="main">
<article class="post">
<header>
<p>
Manipular bases de dados nunca foi tão simples
</p>

</header>
<a href="https://gomesfellipe.github.io/post/2017-12-07-manipulando-dados-com-dplyr/manipulando-dados-com-dplyr/" class="image featured">
<img src="https://gomesfellipe.github.io/img/2017/12/dplyr.png" alt="">
</a>
<p>
A análise exploratória dos dados é uma tarefa de bastante relevância
para entendermos a natureza dos dados e o tempo de análise gastro é
muito precioso. É necessária bastante curiosidade e criatividade para
fazer uma boa análise exploratória dos dados pois é difícil receber
aqueles dados bonitinhos igual aos nativos do banco de dados do
<strong>R</strong>.
</p>
<p>
Existem diversos pacotes para as mais variadas necessidades dos
cientistas de dados (ou qualquer pessoa que precise fazer alguma análise
ou programação estatística) disponíveis no
<a href="https://cran.r-project.org/">CRAN</a> e hoje quero registrar
aqui algumas das funcionalidades do pacote
<a href="https://cran.r-project.org/package=dplyr">dplyr</a> que são
muito úteis.
</p>
<p>
É um dos pacotes mais poderosos e populares do R, desenvolvido por
Hadley Wickham, faz a exploração de dados e permite a manipulação de
dados de forma fácil e rápida no R.
</p>
<p>
Segundo sua descrição no <a href="https://cran.r-project.org/">CRAN</a>,
o <a href="https://cran.r-project.org/package=dplyr">dplyr</a> é
definido como uma ferramenta rápida e consistente para trabalhar com
data.frames como objetos, tanto na memória quanto fora da memória. Vamos
conferir então o que de tão especial tem nesse pacote.
</p>
<p>
O operador <code>%&gt;%</code> é uma opção incrivelmente útil para a
manipulação dos dados, funcionando com uma lógica diferente da nativa do
<strong>R</strong>, que executa funções no formato <code>f(x)</code>, o
pipe permite que façamos operações no formato <code>x %&gt;% f()</code>
que basicamente funciona da maneira como raciocinamos: “Pega esse objeto
e executa isso, depois isso, depois isso…” Realiza múltiplas ações sem
guardar os passos intermediários.
</p>
<p>
Vamos começar carregando o pacote:
</p>
<pre class="r"><code># Carregando o pacote dplyr suppressMessages(library(dplyr))</code></pre>

<pre class="r"><code># Selecionando 5 linhas aleatoriamente df%&gt;% sample_n(5)</code></pre>

<pre class="r"><code># Selecionando a variavel ano e todas as vari&#xE1;veis de sucesso at&#xE9; tonalidade na df df%&gt;% select(ano, sucesso:tonalidade) # Selecionando todas as variaveis com exce&#xE7;&#xE3;o de ano e id df%&gt;% select(-c(ano,id)) # Selecionando todas as variaveis cujo nome inicia com e df%&gt;% select(starts_with(&quot;a&quot;))</code></pre>

<pre class="r"><code># reorganiza o data frame, iniciando com a vari&#xE1;vel Datas e depois as demais df%&gt;% select(Datas,everything())</code></pre>

<pre class="r"><code># Renomeando a vari&#xE1;vel Datas para micro df%&gt;% rename(Dia = Datas)</code></pre>

<pre class="r"><code># Ordenando os dados pela vari&#xE1;vel ano de forma crescente df%&gt;% arrange( ano ) # Ordenando os dados pela vari&#xE1;vel ano e consumo df%&gt;% arrange( ano ,consumo) # Ordenando os dados pela vari&#xE1;vel ano de forma decrescente df%&gt;% arrange( desc(ano) )</code></pre>

<pre class="r"><code># Criando a vari&#xE1;vel ano ao quadrado df%&gt;% mutate( ano2 = ano**2 ) # Criando a vari&#xE1;vel Dia e a vari&#xE1;vel Mes df%&gt;% mutate( Dia = substring(Datas,1,2), Mes = substring(mensalidade,1,1) ) # Se voc&#xEA; quiser somente manter as vari&#xE1;veis criadas df18 = transmute(mensalidade = substring(Datas,1,2), Mes = substring(mensalidade,1,1) )</code></pre>

<pre class="r"><code># Calculando a media e a mediana da vari&#xE1;vel ano df%&gt;% summarise( media.ano = mean(ano), mediana.ano = median(ano))</code></pre>

<pre class="r"><code># Calculando a media da vari&#xE1;vel ano para as combina&#xE7;&#xF5;es entre sexo, consumo e estado civil e a frequencia de indiv&#xED;duos em cada combina&#xE7;&#xE3;o df%&gt;% group_by(sexo, consumo, estado_civil)%&gt;% summarise(media.ano = mean(ano),frequencia=n()) # Calculando a media da vari&#xE1;vel ano para as combina&#xE7;&#xF5;es entre ano legal, consumo e estado civil e a frequencia de indiv&#xED;duos em cada combina&#xE7;&#xE3;o df%&gt;% group_by(id, consumo, estado_civil)%&gt;% summarise(media.ano = mean(ano),frequencia=n())</code></pre>

<p>
Portanto, o operador <code>%&gt;%</code> realiza múltiplas ações sem
guardar os passos intermediários. Mais alguns exemplos:
</p>
<pre class="r"><code># Selecionando as vari&#xE1;veis ano e id df %&gt;% select(ano,id) df %&gt;% select(-estado_civil) %&gt;% filter(sexo==&quot;Masculino&quot;) %&gt;% group_by(tonalidade,consumo) %&gt;% summarise(maximo=max(ano),media=mean(ano))</code></pre>

<pre class="r"><code>df%&gt;% mutate(ano2 = ano**2 )%&gt;% rowwise() %&gt;% mutate(Max= max(ano:ano2)) %&gt;% select(ano,ano2,Max)</code></pre>

<p>
O pacote dplyr possui um conjunto de funções que nos auxiliam a combinar
dos data frames do nosso interesse.
</p>
<pre class="r"><code># Fun&#xE7;&#xE3;o inner_join: Combina as duas bases incluindo todas as vari&#xE1;veis de ambas as bases e todas as linhas comuns as duas bases inner_join(df1,df2,by=&quot;ID&quot;) inner_join(df1,df3,by=c(&quot;ID&quot;=&quot;Identificacao&quot;))</code></pre>

<pre class="r"><code># Fun&#xE7;&#xE3;o left_join: Combina as duas bases incluindo todas as vari&#xE1;veis de ambas as bases e todas as linhas da base a esquerda left_join(df1,df2,by=&quot;ID&quot;)</code></pre>

<pre class="r"><code># Fun&#xE7;&#xE3;o right_join: Combina as duas bases incluindo todas as vari&#xE1;veis de ambas as bases e todas as linhas da base a direita right_join(df1,df2,by=&quot;ID&quot;)</code></pre>

<pre class="r"><code># Fun&#xE7;&#xE3;o full_join: Combina as duas bases incluindo todas as vari&#xE1;veis de ambas as bases e todas as linhas de ambas as bases full_join(df1,df2,by=&quot;ID&quot;)</code></pre>

<pre class="r"><code># Fun&#xE7;&#xE3;o semi_join: Combina as duas bases incluindo as vari&#xE1;veis da basea a esquerda e todas as linhas comuns as duas bases semi_join(df1,df2,by=&quot;ID&quot;)</code></pre>

<pre class="r"><code># Fun&#xE7;&#xE3;o anti_join: Combina as duas bases incluindo as vari&#xE1;veis da base a esquerda e todas as linhas que n&#xE3;o s&#xE3;o comuns as duas bases anti_join(df1,df2,by=&quot;ID&quot;)</code></pre>

<footer>
<ul class="stats">
<li>
Categories
</li>
<li>
<a href="https://gomesfellipe.github.io/categories/estatistica">Estatistica</a>
</li>
<li>
<a href="https://gomesfellipe.github.io/categories/r">R</a>
</li>
<li>
<a href="https://gomesfellipe.github.io/categories/pr%C3%A1tica">Prática</a>
</li>
<li>
<a href="https://gomesfellipe.github.io/categories/package">package</a>
</li>
<li>
<a href="https://gomesfellipe.github.io/categories/dplyr">dplyr</a>
</li>
</ul>
</footer>
</article>
<article class="post">
<a href="https://disqus.com/" class="dsq-brlink">comments powered by
</a>
</article>
</p>

