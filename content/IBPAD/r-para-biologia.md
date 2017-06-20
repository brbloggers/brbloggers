+++
title = "R para Biologia"
date = "2016-11-03 17:12:47"
categories = ["IBPAD"]
original_url = "http://www.ibpad.com.br/blog/analise-de-dados/r-para-biologia/"
+++

<p style="text-align: right;">
<em>\[Texto do prof.
<a href="http://www.ibpad.com.br/nosso-time/robert-mcdonnell/">Robert
McDonnell</a>, professor do curso de Programação em R\]</em>
</p>
<p>
Uma das maiores vantagens de usar o R é o grande número de pacotes
especializados disponíveis. Um ótimo lugar para ver estes pacotes,
agrupados por área, é a página do
CRAN <a href="https://cran.r-project.org/web/views/">Task Views</a>.
Aqui você pode encontrar pacotes R que lidam com tudo, desde
Quimiometria até Ambientometria e pacotes que lidam com Tecnologias Web
e Pesquisa de Reprodução. Neste post, apresentarei pacotes R na área de
Biologia, que na verdade pertencem a várias subáreas no CRAN Task View,
visto que existem páginas sobre genética, ensaios clínicos, análise de
sobrevivência, filogenética e farmacocinética, por exemplo. Já que a
biologia é um campo enorme que requer conhecimentos especializados, vou
me concentrar apenas em maneiras simples de visualizar dados desse tipo
(visto que não sou biólogo). Também é possível encontrar recursos
on-line para lidar com Biologia em R, por
exemplo: <a href="http://varianceexplained.org/r/tidy-genomics-biobroom/">aqui</a>,
<a href="https://cran.r-project.org/doc/contrib/Seefeld_StatsRBio.pdf">aqui</a> e <a href="https://www.amazon.com/Getting-Started-R-Introduction-Biologists/dp/0199601623">aqui</a>.
</p>
<p>
Uma maneira visualmente impressionante para apresentar seus dados
biológicos é usando o phylopics da
página <a href="http://phylopic.org/">phylopic.org</a>, que
disponibiliza imagens de silhuetas. Vamos imaginar que queremos
representar graficamente o surto do Zika Vírus. No código a seguir, eu
carrego as bibliotecas necessárias (que você precisará instalar com
install.packages() caso não as tenha), baixamos a imagem de
phylopic.org, simulamos o surto de vírus e o plotamos usando ggplot2. O
pacote OutbreakTools irá automaticamente gerar um lote semelhante para
você, mas aqui eu decidi adicionar o phylopic, então eu mesmo construí o
gráfico.
</p>
<pre class="crayon-plain-tag">library(dplyr)
library(tidyr)
library(rphylopic)
library(OutbreakTools)

# baixar imagem
mosquito &lt;- image_data("f538aa99-5c08-4f96-97d9-2e094ef5d84f", 
                       size = "512")[[1]]

# simular surto
set.seed(1)
virus &lt;- simuEpi(N = 100, D = 20, beta = 0.01, 
             makePhylo = TRUE, plot = FALSE)

# plotar gráfico
v &lt;- virus$dynamics %&gt;% 
  gather(category, tally, Susceptible:Recovered)

ggplot(v, aes(x = date, y = tally, group = category, 
              colour = category)) +
  add_phylopic(mosquito, alpha = .3, color = "black") +
  geom_line(size = 1, linetype = 1) + 
  scale_color_manual(values = c("#CD2626", "gold", "#FF7F00")) +
  theme_minimal() +
  theme(axis.title = element_blank())</pre>
<p>
<a href="https://i0.wp.com/ibpad.com.br/wp-content/uploads/2016/11/im1-4.png"><img data-attachment-id="1703" data-permalink="http://www.ibpad.com.br/blog/175-autosave-v1/" data-orig-file="" data-orig-size="" data-comments-opened="0" data-image-meta="[]" data-image-title="Análise de Redes com R" data-image-description="&lt;p&gt;[vc_row][vc_column][vc_tta_tour color=&quot;sandy-brown&quot; active_section=&quot;1&quot; el_class=&quot;data-tab-curso&quot;][vc_tta_section i_icon_fontawesome=&quot;fa fa-info-circle&quot; add_icon=&quot;true&quot; title=&quot;Informações Gerais&quot; tab_id=&quot;informacoes&quot; el_class=&quot;data-tab-info&quot;][vc_column_text]&lt;/p&gt;
&lt;div class=&quot;three_fourth&quot;&gt;
&lt;div class=&quot;heading-and-icon&quot;&gt;
&lt;h3 class=&quot;black mb&quot;&gt;Objetivos do curso&lt;/h3&gt;
&lt;/div&gt;
&lt;p&gt;Capacitar profissionais na utilização das ferramentas teóricas e aplicadas para o entendimento e modelagem de redes utilizando o software estatístico R.&lt;/p&gt;&lt;/div&gt;
&lt;div class=&quot;three_fourth&quot;&gt;
&lt;div class=&quot;heading-and-icon&quot;&gt;
&lt;h3 class=&quot;black mb&quot;&gt;&lt;i class=&quot;icon-user&quot;&gt;&lt;/i&gt; A quem se destina&lt;/h3&gt;
&lt;/div&gt;
&lt;p&gt;Profissionais que lidem com análise de redes diversas (como redes sociais ou análises políticas) bem como todos aqueles que queiram aprender análise de redes utilizando o R.&lt;/p&gt;&lt;/div&gt;
&lt;div class=&quot;three_fourth&quot;&gt;
&lt;div class=&quot;heading-and-icon&quot;&gt;
&lt;h3 class=&quot;black mb&quot;&gt;&lt;i class=&quot;icon-ban-circle&quot;&gt;&lt;/i&gt; A quem NÃO se destina&lt;/h3&gt;
&lt;/div&gt;
&lt;p&gt;Iniciantes que não tenham familiaridade com R; e profissionais que já saibam lidar com análise de redes no R.&lt;/p&gt;&lt;/div&gt;
&lt;div class=&quot;three_fourth&quot;&gt;
&lt;div class=&quot;heading-and-icon&quot;&gt;
&lt;h3 class=&quot;black mb&quot;&gt;&lt;i class=&quot;icon-list&quot;&gt;&lt;/i&gt; Você vai sair do curso capaz de&lt;/h3&gt;
&lt;/div&gt;
&lt;ul&gt;
&lt;li class=&quot;square&quot;&gt;Entender os componentes básicos de uma rede;&lt;/li&gt;
&lt;li class=&quot;square&quot;&gt;Realizar análise descritivas e modelagem de redes em casos concretos.&lt;/li&gt;
&lt;li&gt;&lt;/li&gt;
&lt;/ul&gt;
&lt;/div&gt;
&lt;div class=&quot;three_fourth&quot;&gt;
&lt;div class=&quot;heading-and-icon&quot;&gt;
&lt;h3 class=&quot;black mb&quot;&gt;&lt;i class=&quot;icon-exclamation-sign &quot;&gt;&lt;/i&gt;O que você precisa para o curso&lt;/h3&gt;
&lt;/div&gt;
&lt;ul&gt;
&lt;li class=&quot;square&quot;&gt;Noções básicas de estatística;&lt;/li&gt;
&lt;li class=&quot;square&quot;&gt;Domínio básico da linguagem R.&lt;/li&gt;
&lt;/ul&gt;
&lt;/div&gt;
&lt;p&gt;[/vc_column_text][/vc_tta_section][vc_tta_section i_icon_fontawesome=&quot;fa fa-road&quot; add_icon=&quot;true&quot; title=&quot;Programa do Curso&quot; tab_id=&quot;programa&quot;][vc_column_text]&lt;/p&gt;
&lt;ul&gt;
&lt;li class=&quot;square&quot;&gt;1. Introdução à análise de redes e R:&lt;/li&gt;
&lt;li class=&quot;square&quot;&gt;1.1. A linguagem R e análise de redes: principais pacotes;&lt;/li&gt;
&lt;li class=&quot;square&quot;&gt;1.2. Grafos direcionados e não direcionados;&lt;/li&gt;
&lt;li class=&quot;square&quot;&gt;1.3. Vértices, arestas e atributos;&lt;/li&gt;
&lt;li class=&quot;square&quot;&gt;2. Estatísticas descritivas e visualização de redes:&lt;/li&gt;
&lt;li class=&quot;square&quot;&gt;2.1. Características dos vértices e arestas:&lt;/li&gt;
&lt;li class=&quot;square&quot;&gt;2.2. Subgrafos, densidade, conectividade, cluster;&lt;/li&gt;
&lt;li class=&quot;square&quot;&gt;2.3. Elementos de visualização e layouts;&lt;/li&gt;
&lt;li class=&quot;square&quot;&gt;3. Modelos matemáticos e estatísticos de redes:&lt;/li&gt;
&lt;li class=&quot;square&quot;&gt;3.1. Modelos de grafos aleatório;&lt;/li&gt;
&lt;li class=&quot;square&quot;&gt;3.2. Redes de pequeno-mundo;&lt;/li&gt;
&lt;li class=&quot;square&quot;&gt;3.3. Modelos de fixação preferencial;&lt;/li&gt;
&lt;li class=&quot;square&quot;&gt;3.4. Modelos exponenciais;&lt;/li&gt;
&lt;li class=&quot;square&quot;&gt;4. Estudos de casos;&lt;/li&gt;
&lt;li class=&quot;square&quot;&gt;4.1. Análise de Redes Sociais: Facebook; Twitter.&lt;/li&gt;
&lt;li class=&quot;square&quot;&gt;4.2. As Redes do Congresso Nacional&lt;/li&gt;
&lt;/ul&gt;
&lt;p&gt;[/vc_column_text][/vc_tta_section][vc_tta_section i_icon_fontawesome=&quot;fa fa-heart&quot; add_icon=&quot;true&quot; title=&quot;Professores do Curso&quot; tab_id=&quot;professores&quot;][vc_column_text]&lt;b&gt;&lt;img class=&quot; wp-image-2106 alignleft&quot; src=&quot;http://www.ibpad.com.br/wp-content/uploads/2016/10/robert-236x300.jpg&quot; alt=&quot;robert&quot; width=&quot;180&quot; height=&quot;229&quot; /&gt;&lt;br /&gt;
Robert McDonnell –&lt;/b&gt;Pesquisador e Cientista de Dados, doutorado em Relações Internacionais pela USP. Especialista em R, Visualização de Dados e estatística Bayesiana.[/vc_column_text][/vc_tta_section][vc_tta_section i_icon_fontawesome=&quot;fa fa-calendar&quot; add_icon=&quot;true&quot; title=&quot;Calendário e Local&quot; tab_id=&quot;calendario&quot;][vc_gmaps link=&quot;#E-8_JTNDaWZyYW1lJTIwc3JjJTNEJTIyaHR0cHMlM0ElMkYlMkZ3d3cuZ29vZ2xlLmNvbSUyRm1hcHMlMkZlbWJlZCUzRnBiJTNEJTIxMW0xNCUyMTFtOCUyMTFtMyUyMTFkNjE0MjYuNzA1NjQ5MDUxNDclMjEyZC00Ny45MTM0Njg4NjU3NTY0JTIxM2QtMTUuNzk1MDM0OTcxNzI0NTAxJTIxM20yJTIxMWkxMDI0JTIxMmk3NjglMjE0ZjEzLjElMjEzbTMlMjExbTIlMjExczB4OTM1YTNhYmZiMThiODkyNSUyNTNBMHgzMTIzYTM0NzA4MzM1YjRiJTIxMnNGYWN1bGRhZGUlMkJQcmVzYml0ZXJpYW5hJTJCTWFja2VuemllJTIxNWUwJTIxM20yJTIxMXNwdC1CUiUyMTJzYnIlMjE0djE0ODE4MTA4MzM2ODIlMjIlMjB3aWR0aCUzRCUyMjYwMCUyMiUyMGhlaWdodCUzRCUyMjQ1MCUyMiUyMGZyYW1lYm9yZGVyJTNEJTIyMCUyMiUyMHN0eWxlJTNEJTIyYm9yZGVyJTNBMCUyMiUyMGFsbG93ZnVsbHNjcmVlbiUzRSUzQyUyRmlmcmFtZSUzRQ==&quot; title=&quot;Faculdade Mackenzie - 8 906, SGAS I St. de Grandes Áreas Sul 906 - Asa Sul, Brasília - DF&quot;][/vc_tta_section][/vc_tta_tour][/vc_column][/vc_row]&lt;/p&gt;
" data-medium-file="" data-large-file="" class="alignnone size-full wp-image-1703" src="https://i0.wp.com/ibpad.com.br/wp-content/uploads/2016/11/im1-4.png?resize=900%2C643" alt="im1" data-recalc-dims="1" /></a>
</p>
<p>
Esse pacote também torna a plotagem de redes de transmissão muito
fáceis:
</p>
<pre class="crayon-plain-tag">plot(virus$x, "contacts", main="Transmission tree")</pre>
<p>
<code class="r"><span
class="paren"> </span></code><a href="https://i2.wp.com/ibpad.com.br/wp-content/uploads/2016/11/im2-1.png"><img data-attachment-id="1685" data-permalink="http://www.ibpad.com.br/aula/amostragem/" data-orig-file="" data-orig-size="" data-comments-opened="1" data-image-meta="[]" data-image-title="Amostragem" data-image-description="&lt;p&gt;Questões sobre amostragem são muito frequentes no planejamento e prospecção de projetos. Com pesquisa qualitativa, entretanto, as regras são bem diferentes. Veja um pouco sobre amostragem e seleção de casos para estudo:&lt;/p&gt;
&lt;p&gt;&lt;iframe src=&quot;https://player.vimeo.com/video/189537355&quot; width=&quot;640&quot; height=&quot;360&quot; frameborder=&quot;0&quot; allowfullscreen=&quot;allowfullscreen&quot;&gt;&lt;/iframe&gt;&lt;/p&gt;
" data-medium-file="" data-large-file="" class="alignnone size-full wp-image-1685" src="https://i2.wp.com/ibpad.com.br/wp-content/uploads/2016/11/im2-1.png?resize=900%2C643" alt="im2" data-recalc-dims="1" /></a>
</p>
<blockquote>
<p>
<em>Conheça mais do curso de
<a href="http://www.ibpad.com.br/produto/programacao-em-r/">Programação
em R</a> oferecido pelo IBPAD – Inscrições abertas em São Paulo e no Rio
de Janeiro!</em>
</p>
</blockquote>
<p>
Podemos também usar esse método de visualização para representar
estatísticas descritivas, como o número de espécies observadas em uma
determinada área ao longo de um período de trinta dias. Primeiro vamos
simular alguns dados, e então podemos criar gráficos como fizemos acima.
</p>
<pre class="crayon-plain-tag"># simular dados 
species &lt;- data_frame(animals = rep(c("tarantula", "tiger", "bear"), 
                                    each = 30),
                      days = c(1:30, 1:30, 1:30),
                      count = c(rnorm(30, mean = 15, sd = 2),
                                rnorm(30, 9, 2),
                                rnorm(30, 30, 2))) %&gt;% 
  mutate(count = ceiling(count))


# baixar imagens
tarantula &lt;- get_image("d780fdc0-311f-4bc5-b4fc-1a45f4206d27", 
                  size = "512")[[1]]

lizard &lt;- get_image("9cae2028-126b-416f-9094-250782c5bc22", 
                    size = "512")[[1]]

moth &lt;- get_image("8229756b-82c3-4a9f-a1c6-e88f958e623e", 
                  size = "512")[[1]]

# plotar gráfico

library(gridExtra) # put plots side by side

plot_1 &lt;- ggplot(species[1:30,], aes(x = days, y = count)) +  
  add_phylopic(tarantula, alpha = 0.5) + 
  theme_minimal() + 
  geom_point()

plot_2 &lt;- ggplot(species[31:60,], aes(x = days, y = count)) +  
  add_phylopic(lizard, color = "palegreen4", alpha = 0.5) + 
  theme_minimal() + 
  geom_point(colour = "palegreen4")

plot_3 &lt;- ggplot(species[61:90,], aes(x = days, y = count)) +  
  add_phylopic(moth, color = "firebrick", alpha = 0.5) + 
  theme_minimal() + 
  geom_point(colour = "firebrick")
  
  
grid.arrange(plot_1, plot_2, plot_3, ncol=3)</pre>
<p>
<code class="r"><span class="comment"> </span></code>
</p>
<p>
<a href="https://i0.wp.com/ibpad.com.br/wp-content/uploads/2016/11/im3-1.png"><img data-attachment-id="1686" data-permalink="http://www.ibpad.com.br/teste/amostragem/" data-orig-file="" data-orig-size="" data-comments-opened="0" data-image-meta="[]" data-image-title="Amostragem" data-image-description="" data-medium-file="" data-large-file="" class="alignnone size-full wp-image-1686" src="https://i0.wp.com/ibpad.com.br/wp-content/uploads/2016/11/im3-1.png?resize=900%2C643" alt="im3" data-recalc-dims="1" /></a>
</p>
<p>
E pronto! Com algumas linhas de código R, você pode criar visualizações
impressionantes para a pesquisa nas Ciências Biológicas.
</p>
<p>
O post
<a rel="nofollow" href="http://www.ibpad.com.br/blog/analise-de-dados/r-para-biologia/">R
para Biologia</a> apareceu primeiro em
<a rel="nofollow" href="http://www.ibpad.com.br">IBPAD</a>.
</p>

