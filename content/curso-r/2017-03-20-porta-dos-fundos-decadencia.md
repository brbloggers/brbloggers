+++
title = "O Porta dos Fundos está em decadência?"
date = "2017-03-20 20:26:00"
categories = ["curso-r"]
original_url = "http://curso-r.com/blog/2017/03/20/2017-03-20-porta-dos-fundos-decadencia/"
+++

<div id="post-content">
<p>
Há alguns anos eu acompanho o canal Porta dos fundos no YouTube,
assistindo os vídeos quase sempre no dia de lançamento. Mesmo dividido
entre esquetes boas e ruins, me considero um fã da trupe de humoristas
(e do Totoro também), principalmente pelo humor sarcástico e pela
satirização de diversos tabus da nossa sociedade.
</p>
<p>
Nos últimos meses, no entanto, meu entusiasmo com o canal vem
diminuindo. A necessidade de postar três vídeos por semana para se
manter relevante no sistema de recomendações do YouTube, o que mantém o
canal rentável, me faz perdoar um ou outro conteúdo sem graça ou
rasteiro, mas sinto que o que era exceção começou a virar regra.
</p>
<p>
Não sei se eu que fiquei chato ou se outras pessoas compartilham a minha
opinião. Então resolvi scrapear informações do canal e montar algumas
visualizações para tirar essa dúvida.
</p>
<p>
Segue um passo a passo de como fiz isso utilizando o R.
</p>
<p>
O pacote <code>tuber</code> contém funções que permitem acessar a API do
YouTube utilizando o R. Assim, podemos ter acesso a diversas
estatísticas como número de likes, número de views, comentários de
vídeos, entre outras.
</p>
<p>
Para instalar o pacote, rode o código
<code>install.packages("tuber")</code> ou
<code>devtools::install\_github("soodoku/tuber", build\_vignettes =
TRUE)</code> para baixar a versão de desenvolvimento mais recente.
</p>
<p>
Para utilizar o <code>tuber</code> é preciso um <em>id</em> e um
<em>secret</em> do
<a href="https://developers.google.com/youtube/v3/getting-started">Console
de Desenvolvimento da Google</a>. Após criar uma conta, basta habilitar
todas as APIs do YouTube e a Freebase API.
</p>
<p>
Feito isso, rode o código abaixo com o <em>id</em> e <em>secret</em>
obtidos pela plataforma para configurar o acesso do <code>tuber</code> à
API.
</p>
<pre class="r"><code>library(tuber) yt_oauth(app_id = &quot;seu_app_id&quot;, app_secret = &quot;seu_app_secret&quot;)</code></pre>
<p>
Se tudo foi configurado corretamente, ele abrirá uma aba no seu
navegador confirmando a autenticação, e você poderá voltar ao R para
começar a scrapear.
</p>

<p>
Para organizar as informações dos vídeos em um banco de dados e gerar as
visualizações, vamos utilizar as seguintes bibliotecas.
</p>
<pre class="r"><code>library(dplyr) # Manipula&#xE7;&#xE3;o de dados
library(tidyr) # Manipula&#xE7;&#xE3;o de dados
library(tibble) # Cria&#xE7;&#xE3;o de dataframes
library(lubridate) # Manipula&#xE7;&#xE3;o de datas
library(purrr) # Funcionais
library(ggplot2) # Gr&#xE1;ficos</code></pre>
<p>
Precisamos do <em>id</em> de cada vídeo do Porta dos Fundos para baixar
as suas estatísticas. A função <code>tuber::yt\_search()</code> pesquisa
por vídeos e suas informações. Rodando <code>yt\_search(term = "Porta
dos fundos")</code>, obtemos informações de alguns vídeos do canal,
inclusive que o seu <em>channel id</em> é “UCEWHPFNilsT0IfQfutVzsag”. O
<em>channel id</em> é essencial para obtermos todos os vídeos do Porta.
</p>
<p>
Por default, a função <code>yt\_search()</code> retorna no máximo 50
resultados. Contudo, se setarmos os parâmetros <code>type =
"video"</code> e <code>channal\_id = "id\_de\_algum\_canal"</code>, o
número máximo passa a ser 500 resultados.
</p>
<p>
Para facilitar o trabalho, eu criei a função
<code>get\_videos\_porta()</code>. Ela recebe uma data de início e de
término (em um dataframe com apenas uma linha) e devolve todos os vídeos
do canal Porta dos Fundos nesse período.
</p>
<pre class="r"><code>get_videos_porta &lt;- function(dates) { yt_search(term = &quot;&quot;, type = &quot;video&quot;, channel_id = &quot;UCEWHPFNilsT0IfQfutVzsag&quot;, published_after = dates$start, published_before = dates$end) }</code></pre>
<p>
Cada linha do dataframe de datas a seguir representa períodos de um ano,
de 2012 a 2017. Isso implica que, em cada busca, vou receber os vídeos
do Porta dos Fundos para cada um desses anos. O mutate formata as datas
no padrão exigido pela função <code>yt\_search()</code>. Veja
<code>help(yt\_search)</code> para mais informações.
</p>
<pre class="r"><code>dates &lt;- tibble(start = seq(ymd(&quot;2012-01-01&quot;), ymd(&quot;2017-01-01&quot;), by = &quot;years&quot;), end = seq(ymd(&quot;2012-12-31&quot;), ymd(&quot;2017-12-31&quot;), by = &quot;years&quot;)) %&gt;% mutate(start = paste(start, &quot;T0:00:00Z&quot;, sep = &quot;&quot;), end = paste(end, &quot;T0:00:00Z&quot;, sep = &quot;&quot;))
</code></pre>
<p>
Por fim, atribuímos ao objeto <code>videos</code> as informações de
todos os videos do canal de 2012 a 2017.
</p>
<pre class="r"><code>
videos &lt;- by_row(.d = dates, ..f = get_videos_porta, .to = &quot;videos_info&quot;)
</code></pre>

<div id="passo-3-pegar-as-estatisticas-de-cada-video" class="section level1">
<p>
Para facilitar essa etapa, eu criei a função
<code>get\_videos\_stats()</code>, que recebe um dataframe de uma linha
contendo uma coluna
<code>$video\_id&lt;/code&gt; e, usando a fun&\#xE7;&\#xE3;o &lt;code&gt;tuber::get\_stats()&lt;/code&gt;, faz o scrape das estat&\#xED;sticas do v&\#xED;deo.&lt;/p&gt; &lt;pre class="r"&gt;&lt;code&gt;get\_videos\_stats &lt;- function(df\_row) { get\_stats(video\_id = df\_row$video\_id)
}</code>
</pre>
<p>
Cada elemento da coluna
<code>$video\_info&lt;/code&gt; cont&\#xE9;m um dataframe com as informa&\#xE7;&\#xF5;es dos v&\#xED;deos de um determinado ano. Com a fun&\#xE7;&\#xE3;o &lt;code&gt;dplyr::bind\_rows()&lt;/code&gt;, juntamos esses dataframes em um s&\#xF3;. Ent&\#xE3;o selecionamos as colunas de interesse: &lt;em&gt;title&lt;/em&gt;, &lt;em&gt;publishedAt&lt;/em&gt; e &lt;em&gt;video\_id&lt;/em&gt;. Por fim, utilizamos os &lt;em&gt;id&\#x2019;s&lt;/em&gt; para baixar as estat&\#xED;sticas de cada v&\#xED;deo usando a fun&\#xE7;&\#xE3;o &lt;code&gt;get\_videos\_stats()&lt;/code&gt;. As estat&\#xED;sticas s&\#xE3;o salvas na coluna &lt;code&gt;$videos\_stats</code>
do objeto <code>dados</code>.
</p>
<pre class="r"><code>dados &lt;- bind_rows(videos$videos_info) %&gt;% select(title, publishedAt, video_id) %&gt;% by_row(..f = get_videos_stats, .to = &quot;videos_stats&quot;)</code></pre>
</div>
<p>
A primeira visualização que resolvi fazer foi um gráfico do número de
visualizações pela data de publicação. Uma análise descuidada desse
gráfico pode indicar uma clara redução dos números de views ao longo do
tempo. No entanto, é preciso levar em conta que vídeos mais antigos
tendem a ter mais views por simplesmente estarem disponíveis há mais
tempo. Apesar disso, dois fatores me fazem acreditar que a magnitude do
número de views de um vídeo é alcançada nos primeiros dias após o
lançamento. O primeiro se deve ao sistema de recomendações do YouTube.
Na página inicial, nem sempre os vídeos recomendados são dos canais que
você se inscreveu. Na página de canais inscritos, se você tiver muitas
inscrições, é fácil perder um vídeo ou outro de um dos canais que
acompanha. O segundo se deve à enorme quantidade de conteúdo disponível
hoje em dia, muito² maior do que há quatro, cinco anos. Eu, por exemplo,
sou inscrito em mais de vinte canais e não consigo acompanhar nem cinco
deles. Para quem não pode ficar o dia todo vendo vídeos, realmente há
muita competição por espaço no YouTube.
</p>
<p>
E apresento ainda um terceiro fator, contrariando a expectativa de
existirem apenas dois. Vivemos na era do <em>hype</em>. O que é velho, o
que é notícia da semana passada, já não interessa mais.
</p>
<pre class="r"><code>dados %&gt;% mutate(views = map(videos_stats, .f = &apos;viewCount&apos;)) %&gt;% unnest(views) %&gt;% mutate(views = as.numeric(views), publishedAt = as_date(publishedAt)) %&gt;% ggplot(aes(x = publishedAt, y = views)) + geom_line(aes(y = 1000000, colour = &quot;1 Milh&#xE3;o&quot;)) + geom_line(aes(y = 10000000, colour = &apos;10 Milh&#xF5;es&apos;)) + geom_line(aes(y = 20000000, colour = &apos;20 Milh&#xF5;es&apos;)) + geom_line() + labs(x = &quot;Data de publica&#xE7;&#xE3;o&quot;, y = &quot;Visualiza&#xE7;&#xF5;es&quot;) + theme_bw()</code></pre>
<p>
<img src="http://curso-r.com/blog/2017-03-20-porta-dos-fundos-decadencia_files/figure-html/unnamed-chunk-9-1.png" width="4800">
</p>
<p>
Também fiz um gráfico da proporção likes/dislikes pela data de
publicação do vídeo. Parece haver uma leve redução dessa proporção no
último ano, mas é arriscado tirar uma conclusão. Refazendo essa análise
no fim de 2017, talvez fique mais claro se o público do canal concorda
comigo sobre a qualidade do conteúdo nos últimos tempos.
</p>
<pre class="r"><code>dados %&gt;% mutate(likes = map(videos_stats, .f = &apos;likeCount&apos;), dislikes = map(videos_stats, .f = &apos;dislikeCount&apos;)) %&gt;% unnest(likes, dislikes) %&gt;% mutate(likes = as.numeric(likes), dislikes = as.numeric(dislikes), publishedAt = as_date(publishedAt), prop = likes/dislikes) %&gt;% ggplot(aes(x = publishedAt)) + geom_line(aes(y = prop)) + labs(x = &quot;Data de publica&#xE7;&#xE3;o&quot;, y = &quot;Likes/Dislikes&quot;) + theme_bw()</code></pre>
<p>
<img src="http://curso-r.com/blog/2017-03-20-porta-dos-fundos-decadencia_files/figure-html/unnamed-chunk-11-1.png" width="4800">
</p>
<p>
O Porta dos Fundos é sem dúvida um gigante no YouTube, mas os indícios
dessa sucinta análise colaboram com a minha opinião de que o canal já
viveu dias (bem) melhores. Apesar de essa decadência poder ser só uma
fase ruim, nunca é cedo para se reinventar, ter novas ideias, definir as
regras do jogo, assim como eles fizeram no início.
</p>
<p>
E se faltar ideias, vídeos com o Totoro são sempre uma boa alternativa.
</p>

</div>

