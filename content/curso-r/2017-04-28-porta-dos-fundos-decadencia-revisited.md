+++
title = "O Porta dos Fundos está em decadência? (REVISITED)"
date = "2017-04-28 20:26:00"
categories = ["curso-r"]
+++

<p>
Às vezes a venda de uma empresa é um sinal de que algo não vai bem. Até
pode ser verdade que nada ruim estivesse acontecendo e, por qualquer
motivo que seja, alguém achou melhor parar enquanto estava ganhando, mas
eu custo a acreditar que o Porta Dos Fundos estava nessa situação.
Principalmente considerando o futuro sombrio que pode esperá-los.
</p>
<p>
A última aquisição da Viacom no Brasil foi a finada MTV. Depois de 20
anos de presença relevante no cenário musical brasileiro, o peso dos
anos culminou na venda da MTV para a gigante americana. Hoje, a MTV se
limita a produzir versões brasileiras péssimas de séries americanas
ruins, dar emprego a subcelebridades ligadas ao Supla e reprisar lixos
enlatados estadunidenses. Talvez esse não seja o destino que aguarda os
integrantes do Porta, até porque alguns deles já tiveram relações
diretas com a Viacom e o resultado não foi desastroso, mas, se eu fosse
um deles, o triste fim da MTV Brasil soaria o meu alarme de cilada.
</p>
<p>
Inconformados com a venda e buscando entender com mais afinco os motivos
que levaram à venda, neste post revisitamos a análise sobre a decadência
do Porta dos Fundos.
</p>
<p>
Vamos proceder de uma maneira muito parecida com a que fizemos na última
vez. O dataset do Willy era composto por informações sobre todos os
vídeos do Porta e as suas colunas eram:
</p>
<ol>
<li>
O título do vídeo.
</li>
<li>
A data de publicação.
</li>
<li>
A contagem de visualizações.
</li>
<li>
A contagem de Likes.
</li>
<li>
Acontagem de Dislikes.
</li>
<li>
O número de comentários.
</li>
</ol>
<p>
Neste post vamos usar o mesmo dataset, mas atualizado-o até a data da
publicação deste post. Isso pode ser feito rodando o código abaixo, que
também carrega os pactoes necessários para a análise.
</p>
<pre class="r"><code>library(tuber) yt_oauth(&quot;seus&quot;, &quot;dados&quot;)</code></pre>
<pre class="r"><code>library(dplyr) # Manipula&#xE7;&#xE3;o de dados
library(tidyr) # Manipula&#xE7;&#xE3;o de dados
library(tibble) # Cria&#xE7;&#xE3;o de dataframes
library(lubridate) # Manipula&#xE7;&#xE3;o de datas
library(purrr) # Funcionais
library(ggplot2) # Gr&#xE1;ficos</code></pre>
<pre class="r"><code>get_videos_porta &lt;- function(dates) { yt_search(term = &quot;&quot;, type = &quot;video&quot;, channel_id = &quot;UCEWHPFNilsT0IfQfutVzsag&quot;, published_after = dates$start, published_before = dates$end) }</code></pre>
<pre class="r"><code>dates &lt;- tibble(start = seq(ymd(&quot;2012-01-01&quot;), ymd(&quot;2017-01-01&quot;), by = &quot;years&quot;), end = seq(ymd(&quot;2012-12-31&quot;), ymd(&quot;2017-12-31&quot;), by = &quot;years&quot;)) %&gt;% mutate(start = paste(start, &quot;T0:00:00Z&quot;, sep = &quot;&quot;), end = paste(end, &quot;T0:00:00Z&quot;, sep = &quot;&quot;))</code></pre>
<pre class="r"><code>videos &lt;- by_row(.d = dates, ..f = get_videos_porta, .to = &quot;videos_info&quot;)</code></pre>
<pre class="r"><code>get_videos_stats &lt;- function(df_row) { get_stats(video_id = df_row$video_id)
}</code></pre>
<pre class="r"><code>dados &lt;- bind_rows(videos$videos_info) %&gt;% select(title, publishedAt, video_id) %&gt;% by_row(..f = get_videos_stats, .to = &quot;videos_stats&quot;)</code></pre>
<p>
Nas subseções seguintes, vamos revisitar as análises anteriores
colocando algumas novas ideias no caldeirão.
</p>

<p>
Menos do que a compra pela Viacom, a série temporal de visualizações foi
o que realmente me motivou a escrever esse texto.
</p>
<pre class="r"><code>dados %&gt;% mutate(views = map(videos_stats, .f = &apos;viewCount&apos;)) %&gt;% unnest(views) %&gt;% mutate(views = as.numeric(views), publishedAt = as_date(publishedAt)) %&gt;% ggplot(aes(x = publishedAt, y = views)) + geom_line() + labs(x = &quot;Data de publica&#xE7;&#xE3;o&quot;, y = &quot;Visualiza&#xE7;&#xF5;es&quot;) + theme_bw()</code></pre>
<p>
<img src="http://curso-r.com/blog/2017-04-28-porta-dos-fundos-decadencia-revisited_files/figure-html/unnamed-chunk-9-1.png" width="672">
</p>
<p>
O número de visualizações está em uma queda contínua, isso quer dizer
que o porta dos fundos está recebendo menos <em>views</em>? Depende de
como você interpreta esse dado. A resposta será “sim” se você assumir
que o número de visualizações de longo prazo é negligenciável e que o
grosso do número de <em>views</em> de um vídeo vem dos seus primeiros
dias de vida. Pensando assim, interpretamos que o que a gente observa é
aproximadamente igual à quantidade de <em>views</em> no começo da vida
de cada um dos vídeos do PDF, de tal forma que se esse número desce,
quer dizer que a quantidade de visualizações de um vídeo logo que ele
sai também deve estar caindo.
</p>
<p>
Para analisar esses dados de outra forma, eu vou abandonar a suposição
de que a quantidade de views é negligenciável no longo prazo. Dessa vez,
eu vou supor que quanto mais velho for o vídeo, mais visualizações ele
tem, afinal as pessoas provavelmente voltam nele de tempos em tempos.
Pra simplificar as coisas, também vou admitir que a quantidade de
pessoas que fica voltando nele é mais ou menos constante. Juntando tudo
isso, o que eu quero dizer é que o número esperado de pessoas que
assistem a um vídeo velho em um certo dia muito distante da sua
publicação não é negligenciável, mas é pequeno e contante.
</p>
<p>
Em termos um pouco mais precisos, podemos entender toda essa conversa
através da equação
</p>
<p>
<span class="math display">
N&\#xFA;mero de Views de um v&\#xED;deo=
</span> <span class="math display">
Views no come&\#xE7;o da vida do v&\#xED;deo + Idade do v&\#xED;deo × Taxa + Erro aleat&\#xF3;rio,
</span>
</p>
<p>
onde <span class="math inline">*T**a**x**a*</span> é o número de
esperado de views de um vídeo velho em um dia qualquer. Nesses termos, a
diferença entre o ponto que quero defender e o ponto que o Willy
defendeu no post anterior é que ele assume que a Taxa é pequena demais
para importar, enquanto eu não acho que ela seja negligenciável.
</p>
<p>
Podemos dar uma olhada no que esse modelo diz sobre os dados
considerando que, se um vídeo for muito velho, podemos obter uma
estimativa razoável da quantidade de pessoas que ainda assistem um vídeo
se dividirmos o número de visualizações pelo número de dias desde a sua
publicação.
</p>
<pre class="r"><code>dados %&gt;% mutate(views = map(videos_stats, .f = &apos;viewCount&apos;)) %&gt;% unnest(views) %&gt;% mutate(views = as.numeric(views), publishedAt = as_date(publishedAt), idade = as.numeric(Sys.Date() - publishedAt)) %&gt;% filter(publishedAt &lt; as.Date(&quot;2017-01-01&quot;)) %&gt;% ggplot(aes(x = publishedAt, y = (views)/idade)) + geom_line() + labs(x = &quot;Data de publica&#xE7;&#xE3;o&quot;, y = &quot;Visualiza&#xE7;&#xF5;es/Idade&quot;) + theme_bw() + geom_smooth(alpha = 0)</code></pre>
<p>
<img src="http://curso-r.com/blog/2017-04-28-porta-dos-fundos-decadencia-revisited_files/figure-html/unnamed-chunk-10-1.png" width="672">
</p>
<p>
O gráfico acima suporta parcialmente a nossa teoria: a estabilidade na
razão entre o número de visualizações e a idade não seria identificada a
menos que todos os vídeos antigos do Porta estivessem sujeitos à mesma
audiência recorrente (mais ou menos), mesmo com uma variabilidade
grande. Além disso, se os vídeos antigos fossem simplesmente abandonados
(caso em que a Taxa é igual a <span class="math inline">0</span>), então
deveríamos observar razões de Visualização por Idade muito menores para
vídeos mais velhos.
</p>
<p>
Entretanto, nosso modelo tem uma deficiência séria: sempre vamos
observar um aumento na razão de <em>views</em> por idade no final da
amostra, pois a idade desses vídeos vai ficando cada vez menor, dando
mais peso ao número de <em>views</em> na infância do vídeo, o que pode
distorcer as nossas interpretações.
</p>
<p>
De toda a forma, a establidade do começo do gráfico me convenceu de que
a taxa é constante. Disso decorre que, como a curva está subindo, não
ficando estável, devo assumir alguma das duas hipóteses: ou o porta dos
fundos está sendo mais assitido de 2016 pra cá ou o meu modelo está se
comportando exatamente do jeito que deveria. Como em nenhuma dessas
Porta Dos Fundos está perdendo <em>views</em>, sou obrigado a concluir
que, no mínimo, tudo está estável.
</p>

<p>
O Willy nos contou que a proporção de Likes por Dislike é muitíssimo
grande nos vídeos do PDF: eles devem ter uma média de 26 likes por cada
dislike, o que significa que o vídeo médio do PDF tem 96% de likes.
</p>
<pre class="r"><code>dados %&gt;% mutate(likes = map(videos_stats, .f = &apos;likeCount&apos;), dislikes = map(videos_stats, .f = &apos;dislikeCount&apos;)) %&gt;% unnest(likes, dislikes) %&gt;% mutate(likes = as.numeric(likes), dislikes = as.numeric(dislikes), publishedAt = as_date(publishedAt), prop = likes/dislikes) %&gt;% ggplot(aes(x = publishedAt)) + geom_line(aes(y = prop)) + labs(x = &quot;Data de publica&#xE7;&#xE3;o&quot;, y = &quot;Likes/Dislikes&quot;) + theme_bw()</code></pre>
<p>
<img src="http://curso-r.com/blog/2017-04-28-porta-dos-fundos-decadencia-revisited_files/figure-html/unnamed-chunk-11-1.png" width="672">
</p>
<p>
A despeito disso, também é verdade que existe uma classe de vídeos do
PDF que é fuzilada pelo público. Pra se ter uma ideia, um vídeo de 2016,
o “Delação”, chegou a ter apenas 40% de likes! Isso é o mesmo que dizer
que para cada duas pessoas que gostaram do vídeos existem outras que não
gostaram.
</p>
<pre class="r"><code>g &lt;- dados %&gt;% mutate(likes = map(videos_stats, .f = &apos;likeCount&apos;), dislikes = map(videos_stats, .f = &apos;dislikeCount&apos;)) %&gt;% unnest(likes, dislikes) %&gt;% mutate(likes = as.numeric(likes), dislikes = as.numeric(dislikes), publishedAt = as_date(publishedAt), prop = likes/(likes+dislikes)) %&gt;% ggplot(aes(x = publishedAt, label = title, y = prop)) + geom_line(color = &apos;black&apos;) + labs(x = &quot;Data de publica&#xE7;&#xE3;o&quot;, y = &quot;Propor&#xE7;&#xE3;o de Likes&quot;) + theme_bw() + scale_y_continuous(labels = scales::percent) plotly::ggplotly(g)</code></pre>
<p>
<br> O comportamento geral desse gráfico dá a entender que nada muito
importante aconteceu com a proporção de likes dos vídeos do PDF: quase
todo mundo que clicou em alguma das mãozinhas embaixo do vídeo terminou
escolhendo um jóinha. Existe um exército de excessões, que estão quase
sempre relacionadas à religião, mas a estabilidade do gráfico já é
suficiente para os nossos propósitos.
</p>

<p>
As minhas análises não foram 100% conclusivas, mas indicam que o Porta
navegava por águas mais ou menos tranquilas antes da aquisição. É
verdade que o número de views é bastante difícil de interpretar, mas
identificamos um padrão esquisito no começo de 2016. Sob uma certa
perspectiva, pode-se dizer que os vídeos começaram a ficar um pouco mais
populares do que os seus antecessores. A proporção de likes, por outro
lado, é um pouco mais fácil de interpretar: ela ficou estável, ainda que
o PDF costume enraivecer o seu público de tempos em tempos.
</p>
<p>
Considerando essas coisas, talvez a aquisição não seja tão terrível
quanto parece. O Porta não estava tão ruim e é verdade que eles venderam
apenas metade da empresa. Seguindo o provérbio que diz que “Em time que
está ganhando não se mexe”, tudo indica que o canal do Youtube vai
continuar nos mesmos moldes que vive hoje e é possível que as coisas que
eles façam na TV fiquem razoavelmente boas. Pra finalizar, só torço para
que dessa vez eles façam algo melhor do que o Show do Kibe, os programas
do Danili Gentili e qualquer coisa do Hermes e Renato na TV paga.
</p>
<p>
E que não chamem o Supla pra nada.
</p>

