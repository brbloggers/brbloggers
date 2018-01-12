+++
title = "Misturando Dados Espaciais e Temporais em R"
date = "2017-01-17"
categories = ["mind-and-iron"]
original_url = "http://ctlente.com/pt/map-animation/"
+++

<p>
Enquanto criava um <a href="https://www.kaggle.com/kernels">Kaggle
Kernel</a> para a base de dados
<a href="https://www.kaggle.com/the-guardian/the-counted">Killed by
Police, 2015–2016</a>, eu tive a ideia de visualizar os dados com uma
animação. Já que as tabelas tinham informações sobre toda morte causada
por policiais entre 2015 e 2016 com as coordenadas de cada morte, pensei
que cada <em>frame</em> poderia ser um gráfico que representasse todas
as mortes até um dia em particular. Parecia bastante simples, mas no
final demorou mais do que eu imaginava.
</p>
<p>
O primeiro passo era criar um gráfico estático para que eu pudesse ter
uma ideia de como eu queria que a imagem final ficasse. Eu nunca tinha
feito nenhum gráfico em R com dados geográficos, então demorei um pouco
antes de ter certeza de que tudo estava funcionando. Eu decidi criar uma
camada base para o gráfico e só então me preocupar com os dados.
</p>
<pre class="r"><code>plot_deaths &lt;- ggplot() + geom_polygon(data = map_data(&quot;usa&quot;), aes(long, lat, group = group), fill = &quot;#e6e6e6&quot;) + theme(axis.text.x = element_blank(), axis.text.y = element_blank(), axis.title.x = element_blank(), axis.title.y = element_blank(), axis.line = element_blank(), axis.ticks = element_blank(), panel.background = element_blank(), panel.border = element_blank(), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), legend.position = &quot;none&quot;) + coord_quickmap()</code></pre>
<p>
O código acima cria essa imagem:
</p>
<img src="http://ctlente.com/map-animation/simple.png" alt="">

<p>
Então filtrei a base para que ela contivesse apenas informação sobre os
Estados Unidos continentais, que eu chamei de <code>cont\_deaths</code>.
Depois de uma limpeza, eu também criai a lista de cidades (e suas
respectivas localizações) que tinha mais de 5 mortes registradas na
base: <code>deadly\_cities</code>.
</p>
<pre class="r"><code>plot_deaths + geom_text_repel(data = deadly_cities, aes(long, lat, label = city), size = 4) + geom_point(data = cont_deaths, aes(longitude, latitude), alpha = 0.2, color = &quot;red&quot;) + ggtitle(&quot;Killed by Police (showing cities with most deaths)&quot;)</code></pre>
<p>
Eu tentei usar a função <code>geom\_text</code> do pacote
<code>ggplot</code> mas muitas cidades se sobrepunham, então procurei
uma solução e acamei descobrindo o pacote <code>ggrepel</code>. Com
<code>ggrepel::geom\_text\_repel</code>, o gráfico acabou ficando bem
legal.
</p>
<p>
Na imagem abaixo, as cidades nomeadas são as com 5 ou mais mortes.
</p>
<img src="http://ctlente.com/map-animation/killings.png" alt="">

<p>
Eu estava satisfeito com os resultados, então decidi começar a trabalhar
na animação.
</p>

<p>
Para criar a animação, usei o pacote <code>animation</code> e instalei
um programa chamado ImageMagick. Com <code>animation::saveGIF</code>
tudo que tive que fazer foi um loop em que gerava o gráfico de fada
<em>frame</em> e o pacote cuidava do resto.
</p>
<pre class="r"><code>saveGIF(for (i in 0:730) { # Filter deaths up to a certain date time_deaths &lt;- cont_deaths %&gt;% filter(date &lt;= ymd(&quot;2015-01-01&quot;) + i) # Get the cities that have already had more than 5 deaths time_cities &lt;- deadly_cities %&gt;% left_join(time_deaths, c(&quot;city&quot; = &quot;city&quot;, &quot;country.etc&quot; = &quot;state&quot;)) %&gt;% group_by(city, country.etc) %&gt;% summarise(count = n(), long = long[1], lat = lat[1]) %&gt;% ungroup() %&gt;% mutate(alph = count &gt; 5) # Plot deaths print(plot_deaths + geom_text_repel(data = time_cities, size = 4, segment.alpha = 0, aes(long, lat, label = city, alpha = factor(alph))) + scale_alpha_manual(values = c(0, 1)) + geom_point(data = time_deaths, aes(longitude, latitude), alpha = 0.2, color = &quot;red&quot;) + ggtitle(paste0(&quot;Deaths until &quot;, ymd(&quot;2015-01-01&quot;) + i, &quot; (showing when each city crosses the 5 deaths line)&quot;))) }, &quot;deaths.gif&quot;, interval = 0.005, ani.width = 900, ani.height = 630)</code></pre>
<p>
Neste código fiz um loop nos 730 dias da base e gerei gráficos somente
com as mortes até cada data. Também verifiquei para ver se nenhuma
cidade tinha cruzado a linha das 5 mortes para começar a mostrar o seu
nome.
</p>
<p>
Esta é a animação final:
</p>
<img src="http://ctlente.com/map-animation/animation.gif" alt="">

<p>
Tentar criar essa animação foi uma experiência muito interessante. Eu
tive que procurar quase tudo que tentava fazer, mas no final aprendi
bastante. Créditos especiais para Rob Harrand, pessoa cujo whose
<a href="https://www.kaggle.com/tentotheminus9/d/cdc/zika-virus-epidemic/the-spread-of-the-zika-virus/code">Kernel</a>
me ensinou a usar o pacote <code>animation</code>.
</p>
<p>
A pior parte foi fazer os rótulos das cidades se comportarem. Dado que
<code>ggrepel::geom\_text\_repel</code> acha o melhor lugar para cada
rótulo, conforme novas cidades cruzavam a linha das 5 mortes, os outros
rótulos pulavam de um lado para o outro por alguns <em>frames</em>. Eu
consertei isso fazendo com que todos os rótulos fossem mostrados desde o
primeiro <em>frame</em> e deixando os rótulos das cidades que ainda não
deveriam aparecer com o texto transparente.
</p>
<p>
Se você quiser dar uma olhada no código fonte completo, dê uma olhada no
meu
<a href="https://www.kaggle.com/ctlente/d/the-guardian/the-counted/the-counted-geographic-and-temporal-overview">Kernel</a>.
</p>

