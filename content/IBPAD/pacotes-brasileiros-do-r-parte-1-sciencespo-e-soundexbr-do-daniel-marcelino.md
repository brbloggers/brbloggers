+++
title = "Pacotes brasileiros de R: SciencesPo e SoundexBR do Daniel Marcelino"
date = "2017-02-10 14:36:02"
categories = ["IBPAD"]
original_url = "http://www.ibpad.com.br/blog/analise-de-dados/pacotes-brasileiros-do-r-parte-1-sciencespo-e-soundexbr-do-daniel-marcelino/"
+++

<p>
<img data-attachment-id="4329" data-permalink="http://www.ibpad.com.br/blog/analise-de-dados/pacotes-brasileiros-do-r-parte-1-sciencespo-e-soundexbr-do-daniel-marcelino/attachment/pacotes-br-1-card-2/" data-orig-file="https://i0.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Pacotes-br-1-card-1.png?fit=420%2C450" data-orig-size="420,450" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;}" data-image-title="Pacotes br &#8211; 1 card" data-image-description="" data-medium-file="https://i0.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Pacotes-br-1-card-1.png?fit=260%2C279" data-large-file="https://i0.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Pacotes-br-1-card-1.png?fit=420%2C450" class="size-thumbnail wp-image-4329 alignleft" src="https://i0.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Pacotes-br-1-card-1.png?resize=120%2C120" alt="" srcset="https://i0.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Pacotes-br-1-card-1.png?resize=120%2C120 120w, https://i0.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Pacotes-br-1-card-1.png?resize=180%2C180 180w, https://i0.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Pacotes-br-1-card-1.png?resize=300%2C300 300w, https://i0.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Pacotes-br-1-card-1.png?resize=100%2C100 100w, https://i0.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Pacotes-br-1-card-1.png?resize=70%2C70 70w, https://i0.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Pacotes-br-1-card-1.png?resize=160%2C160 160w, https://i0.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Pacotes-br-1-card-1.png?resize=320%2C320 320w, https://i0.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Pacotes-br-1-card-1.png?zoom=2&amp;resize=120%2C120 240w" sizes="(max-width: 120px) 100vw, 120px" data-recalc-dims="1" />Iniciamos com
esse artigo uma série de postagens sobre Pacotes e programadores
brasileiros. Nosso objetivo aqui é mostrar o grande desenvolvimento que
o R tem tido aqui no Brasil.
</p>
<p>
Começaremos, então, com o cientista
político <a href="http://danielmarcelino.github.io/" target="_blank">Daniel
Marcelino</a> , o autor de dois pacotes para R: o
<a href="https://cran.r-project.org/web/packages/SciencesPo/index.html" target="_blank">SciencesPo</a>
e o
<a href="https://github.com/danielmarcelino/soundexBR" target="_blank">SoundexBR</a>.
Neste post nós vamos dar uma olhada nesses pacotes mostrando uns
destaques interessantes e como utilizá-los nas suas análises.
</p>
<p>
Primeiro, é preciso instalar eles no R e os carregar:
</p>
<pre class="crayon-plain-tag">install.packages(&quot;SciencesPo&quot;)
install.packages(&quot;SoundexBR&quot;)

library(&quot;SciencesPo&quot;)
library(&quot;SoundexBR&quot;)</pre>
<p>
Para conhecer todas as funções do pacote, basta usar o comando
<code>help(package = "")</code> e nome do pacote entre aspas.
</p>
<hr />
<blockquote>
<p style="text-align: right;">
<a href="http://www.ibpad.com.br/blog/formacao-em-r/" target="_blank"><br />
</a><a href="http://www.ibpad.com.br/blog/formacao-em-r/" target="_blank"><img data-attachment-id="4138" data-permalink="http://www.ibpad.com.br/nossos-cursos/formacao-em-r/attachment/vitrine-r/" data-orig-file="https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Vitrine-R.png?fit=1225%2C1134" data-orig-size="1225,1134" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;}" data-image-title="Vitrine Formação em R" data-image-description="" data-medium-file="https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Vitrine-R.png?fit=260%2C241" data-large-file="https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Vitrine-R.png?fit=900%2C833" class="aligncenter wp-image-4138 size-medium" src="https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Vitrine-R.png?resize=260%2C241" srcset="https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Vitrine-R.png?resize=260%2C241 260w, https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Vitrine-R.png?resize=768%2C711 768w, https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Vitrine-R.png?resize=1024%2C948 1024w, https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Vitrine-R.png?resize=100%2C93 100w, https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/Vitrine-R.png?w=1225 1225w" sizes="(max-width: 260px) 100vw, 260px" data-recalc-dims="1" /></a>
</p>
<p style="text-align: center;">
<a href="http://www.ibpad.com.br/blog/formacao-em-r/" target="_blank">Conheça
a Formação em R do IBPAD</a>
</p>
<hr />
</blockquote>
<h2 id="sciencespo">
SciencesPo
</h2>
<p>
SciencesPo tem muitas funções ligadas a área de Ciência Política, em
particular aos temas de distribuição dos resultados de uma eleição. O
pacote também tem algumas bases de dados que você pode utilizar para
explorar – e que podem ser vistos com <code>data(package =
"SciencesPo")</code>.
</p>
<p>
Uma função que achei bem interessante é a
<code>PoliticalDiversity()</code>, que calcula a medida de competição
política num território, ou seja, quão perto ou longe de monopolia é o
“mercado” político. Primeiro, eu vou usar o pacote tidyverse para
importar e arrumar uns dados brasileiros, da eleição 2016, disponível do
<a href="http://www.tse.jus.br/eleicoes/estatisticas/estatisticas-eleitorais-2016/resultados" target="_blank">TSE</a>.
</p>
<pre class="crayon-plain-tag">library(tidyverse)
tse &lt;- read_csv(&quot;https://raw.githubusercontent.com/RobertMyles/Various_R-Scripts/master/data/quadro_partido_x_cargo.csv&quot;) %&gt;% 
  filter(Partido != &quot;Subtotal&quot;, Partido != &quot;Total Geral&quot;) %&gt;% 
  mutate(total = 39623213,
         prop = `Qt Votos Validos`/total)</pre>
<p>
33 partidos conseguiram representação nessas eleições. A função
<code>PolticalDiversity()</code> nos ajuda a ver o <em>peso</em> destes
partidos no sistema, considerando que uns partidos têm muitos membros
eleitos enquanto outros têm poucos.
</p>
<pre class="crayon-plain-tag">PoliticalDiversity(tse$prop, index = &quot;golosov&quot;)  

## [1] 27.89</pre>
<p>
A função mostra que é melhor pensar que os sistemas têm 28 partidos
efetivos, o que ainda é um número grande em comparação com outros
países. Por exemplo, podemos fazer a mesma coisa com dados dos Estados
Unidos:
</p>
<pre class="crayon-plain-tag">usa &lt;- read_csv(&quot;https://raw.githubusercontent.com/RobertMyles/Various_R-Scripts/master/data/tables2014.csv&quot;) %&gt;% 
  slice(58) %&gt;% 
  select(-1) %&gt;%
  gather(partido, prop)

PoliticalDiversity(usa$prop, index = &quot;golosov&quot;)

## [1] 2.299</pre>
<p>
Ou França, usando dados do governo francês que podemos “scrapear” do
website:
</p>
<pre class="crayon-plain-tag">library(rvest)
fr &lt;- read_html(&quot;http://www.interieur.gouv.fr/Elections/Les-resultats/Legislatives/elecresult__LG2012/(path)/LG2012//FE.html&quot;) %&gt;%
  html_node(css = &quot;#content-wrap &amp;gt; div &amp;gt; table:nth-child(15)&quot;) %&gt;%
  html_table(header = T, dec = &quot;,&quot;, trim = T) %&gt;%
  select(1, prop = 3)

PoliticalDiversity(fr$prop, index = &quot;golosov&quot;)

## [1] 15.325</pre>
<p>
Vamos visualizar tudo isso:
</p>
<pre class="crayon-plain-tag">prop &lt;- data_frame(prop = c(27.89, 2.299, 15.325),
                   pais = c(&quot;brasil&quot;, &quot;usa&quot;, &quot;france&quot;))
ggplot(prop, aes(x = pais, y = prop)) + 
  geom_bar(color = &quot;black&quot;, stat=&quot;identity&quot;, width=.5, 
           aes(fill = pais)) +
  theme_classic() +
  scale_fill_manual(values = c(&quot;#007600&quot;, &quot;#E0162B&quot;, &quot;#0052A5&quot;)) +
  ylab(&quot;propor&ccedil;&atilde;o&quot;) + xlab(&quot;pa&iacute;s&quot;)</pre>
<p>
<img src="https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/ibpad_BR_paises.png?w=900" alt="" data-recalc-dims="1" />
</p>
<h3 id="proporcionalidade-pol-tica">
Proporcionalidade Política
</h3>
<p>
Uma outra questão de interesse na área de Ciência Política é a de
proporcionalidade, ou seja, a quantidade de cadeiras que um partido
ganha numa eleição referente à proporção de votos ganhados pelo partido.
Um sistema no qual um partido ganha 30% das cadeiras depois ganha 30%
dos votos seria perfeitamente proporcional, por exemplo.
</p>
<p>
Podemos investigar este tema usando SciencesPo, com a função
<code>Proportionality()</code>. Vamos usar dados da Irlanda, de novo
tirando os dados da Wikipedia, que é bom para este tipo de análise.
Pegar dados da internet sempre envolve trabalho para arrumar, mas com
tidyverse essa tarefa vira simples. Depois fazemos a mesma coisa com
dados do Brasil para comparação.
</p>
<pre class="crayon-plain-tag">ire &lt;- read_html(&quot;https://en.wikipedia.org/wiki/Irish_general_election,_2016&quot;) %&gt;% 
  html_node(css = &quot;#mw-content-text &amp;gt; table:nth-child(41)&quot;) %&gt;% 
  html_table(header = F) %&gt;% 
  t() %&gt;%
  as_data_frame() %&gt;%
  select(-2, -5, -7)

colnames(ire) &lt;- ire[1, ]

ire &lt;- ire %&gt;%
  slice(-1) %&gt;%
  rename(Votes = `Votes,1st pref.`) %&gt;%
  separate(Votes, into = c(&quot;perc_votes&quot;, &quot;total_votes&quot;), sep = &quot;,&quot;) %&gt;%
  separate(Seats, into = c(&quot;total_seats&quot;, &quot;perc_seats&quot;), sep = &quot;\\(&quot;) %&gt;%
  distinct(Party, Leader, .keep_all = T) %&gt;% 
  mutate(perc_votes = as.numeric(gsub(&quot;%&quot;, &quot;&quot;, perc_votes)),
         perc_seats = as.numeric(gsub(&quot;%\\)&quot;, &quot;&quot;, perc_seats)))

Proportionality(ire$perc_votes, ire$perc_seats)

## 
## Gallagher's Index :  0.045</pre>
<p>
 
</p>
<pre class="crayon-plain-tag">br &lt;- read_html(&quot;https://en.wikipedia.org/wiki/Brazilian_general_election,_2014&quot;) %&gt;% 
  html_nodes(&quot;table&quot;) %&gt;%
  html_table(fill = T)
br &amp;lt;- br[[11]]
br &amp;lt;- br[-1, c(3, 5, 7)]

colnames(br)[2:3] &amp;lt;- c(&quot;perc_votos&quot;, &quot;perc_cadeiras&quot;)

'%ni%' &lt;- Negate('%in%')

br &lt;- br %&gt;% 
  filter(Parties %ni% c(&quot;Total&quot;, &quot;Total valid votes&quot;)) %&gt;% 
  mutate(perc_cadeiras = gsub(&quot;%&quot;, &quot;&quot;, perc_cadeiras),
         perc_cadeiras = as.numeric(gsub(&quot;,&quot;, &quot;\\.&quot;, perc_cadeiras)),
         perc_votos = gsub(&quot;%&quot;, &quot;&quot;, perc_votos),
         perc_votos = as.numeric(gsub(&quot;,&quot;, &quot;\\.&quot;, perc_votos)))

Proportionality(br$perc_votos, br$perc_cadeiras)

## 
## Gallagher's Index :  0.022</pre>
<p>
Dado que zero é perfeitamente proporcional, parece que o sistema
brasileiro é mais justo do que o sistema irlandês neste aspecto. Uma
visualização simples:
</p>
<pre class="crayon-plain-tag">ire_br &lt;- data_frame(pais = c(&quot;irlanda&quot;, &quot;brasil&quot;),
                     perc = c(0.045, 0.022))

ggplot(ire_br, aes(x = pais, y = perc)) + 
  geom_point(size = 3) + 
  geom_segment(aes(x = pais, xend = pais, 
                   y = -Inf, yend = perc)) + 
  labs(x = &quot;pa&iacute;s&quot;, y = &quot;&quot;,
       caption=&quot;source: Wikipedia&quot;) + 
  coord_flip() + 
  theme_classic() +
  theme(axis.ticks.y = element_blank())</pre>
<p>
<img src="https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/IBPAD_BR_ire_br.png?w=900" alt="" data-recalc-dims="1" />
</p>
<p>
O pacote SciencesPo é somente um dos ótimos pacotes feitos por
brasileiros que nós vamos explorar, e é só um dos pacotes feito por
Daniel. Veja
<a href="https://github.com/danielmarcelino/SciencesPo" target="_blank">o
site</a> do pacote para ver mais.
</p>
<h2 id="soundexbr">
SoundexBR
</h2>
<p>
A ideia do pacote SoundexBR, que é uma versão para português brasileiro
do algoritmo Soundex, disponível no R para a língua inglesa no pacote
<a href="http://www.markvanderloo.eu/yaRb/2014/08/22/stringdist-0-8-now-with-soundex/" target="_blank">stringdist</a>,
é identificar palavras que têm o mesmo som, dando a elas o mesmo código.
Por exemplo, as palavras “seção” e “sessão” retornam o mesmo código:
</p>
<pre class="crayon-plain-tag">soundexBR(term = c(&quot;se&ccedil;&atilde;o&quot;, &quot;sess&atilde;o&quot;))

## [1] &quot;S200&quot; &quot;S200&quot;</pre>
<p>
Alguém que já tentou reunir bases de dados com soletragem diferentes já
vê o valor neste pacote!! É muito comum que você tenha uma base com
diferenças pequenas que podem estragar o seu dia. Por exemplo, eu tive
este problema quando eu estava fazendo um mapa do Brasil, com duas bases
no qual os nomes dos municípios eram diferentes, por muito pouco, como
no exemplo em baixo:
</p>
<pre class="crayon-plain-tag">primeiros &lt;- c(&quot;ASSIS BRAZIL&quot;, &quot;JOINVILE&quot;, &quot;SAO GABRIEL DE CAHOEIRA&quot;, 
               &quot;NOVO BRAZIL&quot;, &quot;SEM-PEIXE&quot;)
segundos &lt;- c(&quot;ASSIS BRASIL&quot;, &quot;JOINVILLE&quot;, &quot;SAO GABRIEL DA CACHOEIRA&quot;,
              &quot;NOVO BRASIL&quot;, &quot;SEM PEIXE&quot;)</pre>
<p>
</p>
<pre class="crayon-plain-tag">soundexBR(primeiros)

## [1] &quot;A221&quot; &quot;J514&quot; &quot;S216&quot; &quot;N116&quot; &quot;S512&quot;</pre>
<p>
</p>
<pre class="crayon-plain-tag">soundexBR(segundos)

## [1] &quot;A221&quot; &quot;J514&quot; &quot;S216&quot; &quot;N116&quot; &quot;S512&quot;</pre>
<p>
E podemos ver que o pacote SoundexBR resolve este problema facilmente!
</p>
<p>
Você pode conferir mais sobre como a Ciência Política pode utilizar o R
para análise de dados na palestra de Daniel Marcelino em evento do IBPAD
no ano passado em Brasília:
</p>
<p>
<iframe class="youtube-player" type="text/html" width="900" height="537" src="http://www.youtube.com/embed/oCYWNQ6e4LQ?version=3&amp;rel=1&amp;fs=1&amp;autohide=2&amp;showsearch=0&amp;showinfo=1&amp;iv_load_policy=1&amp;wmode=transparent" allowfullscreen="true" style="border:0;">
</iframe>
</p>
<p>
O post
<a rel="nofollow" href="http://www.ibpad.com.br/blog/analise-de-dados/pacotes-brasileiros-do-r-parte-1-sciencespo-e-soundexbr-do-daniel-marcelino/">Pacotes
brasileiros de R: SciencesPo e SoundexBR do Daniel Marcelino</a>
apareceu primeiro em
<a rel="nofollow" href="http://www.ibpad.com.br">IBPAD</a>.
</p>

