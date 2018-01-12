+++
title = "R para Biologia"
date = "2016-11-03 17:12:47"
categories = ["IBPAD"]
original_url = "https://www.ibpad.com.br/blog/analise-de-dados/r-para-biologia/"
+++

<div class="post-inner-content">
<p style="text-align: right;">
<em>\[Texto do prof.
<a href="https://www.ibpad.com.br/nosso-time/robert-mcdonnell/">Robert
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
<span class="crayon-title"></span>

<span class="crayon-language">R</span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
library(dplyr) library(tidyr) library(rphylopic) library(OutbreakTools)

baixar imagem
=============

mosquito &lt;- image\_data("f538aa99-5c08-4f96-97d9-2e094ef5d84f", size
= "512")\[\[1\]\]

simular surto
=============

set.seed(1) virus &lt;- simuEpi(N = 100, D = 20, beta = 0.01, makePhylo
= TRUE, plot = FALSE)

plotar gráfico
==============

v &lt;- virus$dynamics %&gt;% gather(category, tally,
Susceptible:Recovered)

ggplot(v, aes(x = date, y = tally, group = category, colour = category))
+ add\_phylopic(mosquito, alpha = .3, color = "black") + geom\_line(size
= 1, linetype = 1) + scale\_color\_manual(values = c("\#CD2626", "gold",
"\#FF7F00")) + theme\_minimal() + theme(axis.title = element\_blank())
</textarea>

<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
1

2

3

4

5

6

7

8

9

10

11

12

13

14

15

16

17

18

19

20

21

22

23

24

25

</td>
<td class="crayon-code">
<span class="crayon-r">library</span><span
class="crayon-sy">(</span><span class="crayon-v">dplyr</span><span
class="crayon-sy">)</span>

<span class="crayon-r">library</span><span
class="crayon-sy">(</span><span class="crayon-v">tidyr</span><span
class="crayon-sy">)</span>

<span class="crayon-r">library</span><span
class="crayon-sy">(</span><span class="crayon-v">rphylopic</span><span
class="crayon-sy">)</span>

<span class="crayon-r">library</span><span
class="crayon-sy">(</span><span
class="crayon-v">OutbreakTools</span><span class="crayon-sy">)</span>

 

<span class="crayon-c">\# baixar imagem</span>

<span class="crayon-v">mosquito</span><span class="crayon-h">
</span><span class="crayon-o">&lt;</span><span
class="crayon-o">-</span><span class="crayon-h"> </span><span
class="crayon-e">image\_data</span><span class="crayon-sy">(</span><span
class="crayon-s">"f538aa99-5c08-4f96-97d9-2e094ef5d84f"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span>

<span class="crayon-h">                       </span><span
class="crayon-v">size</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"512"</span><span class="crayon-sy">)</span><span
class="crayon-sy">\[</span><span class="crayon-sy">\[</span><span
class="crayon-cn">1</span><span class="crayon-sy">\]</span><span class="crayon-sy">\]</span>

 

<span class="crayon-c">\# simular surto</span>

<span class="crayon-v">set</span><span class="crayon-sy">.</span><span
class="crayon-e">seed</span><span class="crayon-sy">(</span><span
class="crayon-cn">1</span><span class="crayon-sy">)</span>

<span class="crayon-v">virus</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-e">simuEpi</span><span
class="crayon-sy">(</span><span class="crayon-v">N</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-cn">100</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">D</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-cn">20</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">beta</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-cn">0.01</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span>

<span class="crayon-h">             </span><span
class="crayon-v">makePhylo</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-t">TRUE</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">plot</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-t">FALSE</span><span
class="crayon-sy">)</span>

 

<span class="crayon-c">\# plotar gráfico</span>

<span class="crayon-v">v</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-v">virus</span><span
class="crayon-sy">$</span><span class="crayon-v">dynamics</span><span
class="crayon-h"> </span><span class="crayon-o">%</span><span
class="crayon-o">&gt;</span><span class="crayon-o">%</span><span
class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">gather</span><span class="crayon-sy">(</span><span
class="crayon-v">category</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">tally</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">Susceptible</span><span class="crayon-o">:</span><span
class="crayon-v">Recovered</span><span class="crayon-sy">)</span>

 

<span class="crayon-e">ggplot</span><span
class="crayon-sy">(</span><span class="crayon-v">v</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-e">aes</span><span class="crayon-sy">(</span><span
class="crayon-v">x</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">date</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">y</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-v">tally</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">group</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">category</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span>

<span class="crayon-h">              </span><span
class="crayon-v">colour</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">category</span><span class="crayon-sy">)</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">+</span>

<span class="crayon-h">  </span><span
class="crayon-e">add\_phylopic</span><span
class="crayon-sy">(</span><span class="crayon-v">mosquito</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">alpha</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-sy">.</span><span class="crayon-cn">3</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">color</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"black"</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">+</span>

<span class="crayon-h">  </span><span
class="crayon-e">geom\_line</span><span class="crayon-sy">(</span><span
class="crayon-v">size</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-cn">1</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">linetype</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-cn">1</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">+</span><span class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">scale\_color\_manual</span><span
class="crayon-sy">(</span><span class="crayon-v">values</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-e">c</span><span
class="crayon-sy">(</span><span class="crayon-s">"\#CD2626"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-s">"gold"</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-s">"\#FF7F00"</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">+</span>

<span class="crayon-h">  </span><span
class="crayon-e">theme\_minimal</span><span
class="crayon-sy">(</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">+</span>

<span class="crayon-h">  </span><span class="crayon-e">theme</span><span
class="crayon-sy">(</span><span class="crayon-v">axis</span><span
class="crayon-sy">.</span><span class="crayon-v">title</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span
class="crayon-e">element\_blank</span><span
class="crayon-sy">(</span><span class="crayon-sy">)</span><span
class="crayon-sy">)</span>

</td>
</tr>
</table>

<p>
<a href="http://ibpad.com.br/wp-content/uploads/2016/11/im1-4.png"><img class="alignnone size-full wp-image-1703" src="https://ibpad.com.br/wp-content/uploads/2016/11/im1-4.png" alt="im1" width="1344" height="960"></a>
</p>
<p>
Esse pacote também torna a plotagem de redes de transmissão muito
fáceis:
</p>
<div id="crayon-5a5818d475db4541709771" class="crayon-syntax crayon-theme-classic crayon-font-monaco crayon-os-pc print-yes notranslate" data-settings=" minimize scroll-mouseover" style=" margin-top: 12px; margin-bottom: 12px; font-size: 12px !important; line-height: 15px !important;">
<span class="crayon-title"></span>

<span class="crayon-language">R</span>

<div class="crayon-plain-wrap">
<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
plot(virus$x, "contacts", main="Transmission tree")&lt;/textarea&gt;&lt;/div&gt; &lt;div class="crayon-main" style=""&gt; &lt;table class="crayon-table"&gt;&lt;tr class="crayon-row"&gt; &lt;td class="crayon-nums " data-settings="show"&gt; &lt;div class="crayon-nums-content" style="font-size: 12px !important; line-height: 15px !important;"&gt;&lt;div class="crayon-num" data-line="crayon-5a5818d475db4541709771-1"&gt;1&lt;/div&gt;&lt;/div&gt; &lt;/td&gt; &lt;td class="crayon-code"&gt;&lt;div class="crayon-pre" style="font-size: 12px !important; line-height: 15px !important; -moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4;"&gt;&lt;div class="crayon-line" id="crayon-5a5818d475db4541709771-1"&gt; &lt;span class="crayon-e"&gt;plot&lt;/span&gt;&lt;span class="crayon-sy"&gt;(&lt;/span&gt;&lt;span class="crayon-v"&gt;virus&lt;/span&gt;&lt;span class="crayon-sy"&gt;$</span><span
class="crayon-v">x</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-s">"contacts"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">main</span><span class="crayon-o">=</span><span
class="crayon-s">"Transmission tree"</span><span
class="crayon-sy">)</span>
</div>
</div>
</td>
</tr>
</table>
</div>
</div>
<p>
<code class="r"><span
class="paren"> </span></code><a href="http://ibpad.com.br/wp-content/uploads/2016/11/im2-1.png"><img class="alignnone size-full wp-image-1685" src="https://ibpad.com.br/wp-content/uploads/2016/11/im2-1.png" alt="im2" width="1344" height="960"></a>
</p>
<blockquote>
<p>
<em>Conheça mais do curso de
<a href="https://www.ibpad.com.br/produto/programacao-em-r/">Programação
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
<span class="crayon-title"></span>

<span class="crayon-language">R</span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
simular dados
=============

species &lt;- data\_frame(animals = rep(c("tarantula", "tiger", "bear"),
each = 30), days = c(1:30, 1:30, 1:30), count = c(rnorm(30, mean = 15,
sd = 2), rnorm(30, 9, 2), rnorm(30, 30, 2))) %&gt;% mutate(count =
ceiling(count))

baixar imagens
==============

tarantula &lt;- get\_image("d780fdc0-311f-4bc5-b4fc-1a45f4206d27", size
= "512")\[\[1\]\]

lizard &lt;- get\_image("9cae2028-126b-416f-9094-250782c5bc22", size =
"512")\[\[1\]\]

moth &lt;- get\_image("8229756b-82c3-4a9f-a1c6-e88f958e623e", size =
"512")\[\[1\]\]

plotar gráfico
==============

library(gridExtra) \# put plots side by side

plot\_1 &lt;- ggplot(species\[1:30,\], aes(x = days, y = count)) +  
add\_phylopic(tarantula, alpha = 0.5) + theme\_minimal() + geom\_point()

plot\_2 &lt;- ggplot(species\[31:60,\], aes(x = days, y = count)) +  
add\_phylopic(lizard, color = "palegreen4", alpha = 0.5) +
theme\_minimal() + geom\_point(colour = "palegreen4")

plot\_3 &lt;- ggplot(species\[61:90,\], aes(x = days, y = count)) +  
add\_phylopic(moth, color = "firebrick", alpha = 0.5) + theme\_minimal()
+ geom\_point(colour = "firebrick")

grid.arrange(plot\_1, plot\_2, plot\_3, ncol=3)
</textarea>

<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
1

2

3

4

5

6

7

8

9

10

11

12

13

14

15

16

17

18

19

20

21

22

23

24

25

26

27

28

29

30

31

32

33

34

35

36

37

38

39

40

41

</td>
<td class="crayon-code">
<span class="crayon-c">\# simular dados </span>

<span class="crayon-v">species</span><span class="crayon-h">
</span><span class="crayon-o">&lt;</span><span
class="crayon-o">-</span><span class="crayon-h"> </span><span
class="crayon-e">data\_frame</span><span class="crayon-sy">(</span><span
class="crayon-v">animals</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-e">rep</span><span class="crayon-sy">(</span><span
class="crayon-e">c</span><span class="crayon-sy">(</span><span
class="crayon-s">"tarantula"</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-s">"tiger"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-s">"bear"</span><span class="crayon-sy">)</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span>

<span class="crayon-h">                                    </span><span
class="crayon-st">each</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-cn">30</span><span class="crayon-sy">)</span><span
class="crayon-sy">,</span>

<span class="crayon-h">                      </span><span
class="crayon-v">days</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-e">c</span><span class="crayon-sy">(</span><span
class="crayon-cn">1</span><span class="crayon-o">:</span><span
class="crayon-cn">30</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-cn">1</span><span
class="crayon-o">:</span><span class="crayon-cn">30</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-cn">1</span><span class="crayon-o">:</span><span
class="crayon-cn">30</span><span class="crayon-sy">)</span><span
class="crayon-sy">,</span>

<span class="crayon-h">                      </span><span
class="crayon-v">count</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-e">c</span><span class="crayon-sy">(</span><span
class="crayon-e">rnorm</span><span class="crayon-sy">(</span><span
class="crayon-cn">30</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">mean</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-cn">15</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">sd</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-cn">2</span><span class="crayon-sy">)</span><span
class="crayon-sy">,</span>

<span class="crayon-h">                                </span><span
class="crayon-e">rnorm</span><span class="crayon-sy">(</span><span
class="crayon-cn">30</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-cn">9</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-cn">2</span><span class="crayon-sy">)</span><span
class="crayon-sy">,</span>

<span class="crayon-h">                                </span><span
class="crayon-e">rnorm</span><span class="crayon-sy">(</span><span
class="crayon-cn">30</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-cn">30</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-cn">2</span><span class="crayon-sy">)</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">%</span><span
class="crayon-o">&gt;</span><span class="crayon-o">%</span><span
class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">mutate</span><span class="crayon-sy">(</span><span
class="crayon-v">count</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-e">ceiling</span><span class="crayon-sy">(</span><span
class="crayon-v">count</span><span class="crayon-sy">)</span><span
class="crayon-sy">)</span>

 

 

<span class="crayon-c">\# baixar imagens</span>

<span class="crayon-v">tarantula</span><span class="crayon-h">
</span><span class="crayon-o">&lt;</span><span
class="crayon-o">-</span><span class="crayon-h"> </span><span
class="crayon-e">get\_image</span><span class="crayon-sy">(</span><span
class="crayon-s">"d780fdc0-311f-4bc5-b4fc-1a45f4206d27"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span>

<span class="crayon-h">                  </span><span
class="crayon-v">size</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"512"</span><span class="crayon-sy">)</span><span
class="crayon-sy">\[</span><span class="crayon-sy">\[</span><span
class="crayon-cn">1</span><span class="crayon-sy">\]</span><span class="crayon-sy">\]</span>

 

<span class="crayon-v">lizard</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-e">get\_image</span><span
class="crayon-sy">(</span><span
class="crayon-s">"9cae2028-126b-416f-9094-250782c5bc22"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span>

<span class="crayon-h">                    </span><span
class="crayon-v">size</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"512"</span><span class="crayon-sy">)</span><span
class="crayon-sy">\[</span><span class="crayon-sy">\[</span><span
class="crayon-cn">1</span><span class="crayon-sy">\]</span><span class="crayon-sy">\]</span>

 

<span class="crayon-v">moth</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-e">get\_image</span><span
class="crayon-sy">(</span><span
class="crayon-s">"8229756b-82c3-4a9f-a1c6-e88f958e623e"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span>

<span class="crayon-h">                  </span><span
class="crayon-v">size</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"512"</span><span class="crayon-sy">)</span><span
class="crayon-sy">\[</span><span class="crayon-sy">\[</span><span
class="crayon-cn">1</span><span class="crayon-sy">\]</span><span class="crayon-sy">\]</span>

 

<span class="crayon-c">\# plotar gráfico</span>

 

<span class="crayon-r">library</span><span
class="crayon-sy">(</span><span class="crayon-v">gridExtra</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-c">\# put plots side by side</span>

 

<span class="crayon-v">plot\_1</span><span class="crayon-h">
</span><span class="crayon-o">&lt;</span><span
class="crayon-o">-</span><span class="crayon-h"> </span><span
class="crayon-e">ggplot</span><span class="crayon-sy">(</span><span
class="crayon-v">species</span><span class="crayon-sy">\[</span><span
class="crayon-cn">1</span><span class="crayon-o">:</span><span
class="crayon-cn">30</span><span
class="crayon-sy">,</span><span class="crayon-sy">\]</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-e">aes</span><span class="crayon-sy">(</span><span
class="crayon-v">x</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">days</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">y</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-v">count</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">+</span><span
class="crayon-h">  </span>

<span class="crayon-h">  </span><span
class="crayon-e">add\_phylopic</span><span
class="crayon-sy">(</span><span class="crayon-v">tarantula</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">alpha</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-cn">0.5</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">+</span><span
class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">theme\_minimal</span><span
class="crayon-sy">(</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">+</span><span
class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">geom\_point</span><span class="crayon-sy">(</span><span
class="crayon-sy">)</span>

 

<span class="crayon-v">plot\_2</span><span class="crayon-h">
</span><span class="crayon-o">&lt;</span><span
class="crayon-o">-</span><span class="crayon-h"> </span><span
class="crayon-e">ggplot</span><span class="crayon-sy">(</span><span
class="crayon-v">species</span><span class="crayon-sy">\[</span><span
class="crayon-cn">31</span><span class="crayon-o">:</span><span
class="crayon-cn">60</span><span
class="crayon-sy">,</span><span class="crayon-sy">\]</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-e">aes</span><span class="crayon-sy">(</span><span
class="crayon-v">x</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">days</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">y</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-v">count</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">+</span><span
class="crayon-h">  </span>

<span class="crayon-h">  </span><span
class="crayon-e">add\_phylopic</span><span
class="crayon-sy">(</span><span class="crayon-v">lizard</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">color</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"palegreen4"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">alpha</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-cn">0.5</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">+</span><span
class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">theme\_minimal</span><span
class="crayon-sy">(</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">+</span><span
class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">geom\_point</span><span class="crayon-sy">(</span><span
class="crayon-v">colour</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"palegreen4"</span><span class="crayon-sy">)</span>

 

<span class="crayon-v">plot\_3</span><span class="crayon-h">
</span><span class="crayon-o">&lt;</span><span
class="crayon-o">-</span><span class="crayon-h"> </span><span
class="crayon-e">ggplot</span><span class="crayon-sy">(</span><span
class="crayon-v">species</span><span class="crayon-sy">\[</span><span
class="crayon-cn">61</span><span class="crayon-o">:</span><span
class="crayon-cn">90</span><span
class="crayon-sy">,</span><span class="crayon-sy">\]</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-e">aes</span><span class="crayon-sy">(</span><span
class="crayon-v">x</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">days</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">y</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-v">count</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">+</span><span
class="crayon-h">  </span>

<span class="crayon-h">  </span><span
class="crayon-e">add\_phylopic</span><span
class="crayon-sy">(</span><span class="crayon-v">moth</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">color</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"firebrick"</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">alpha</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-cn">0.5</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">+</span><span class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">theme\_minimal</span><span
class="crayon-sy">(</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">+</span><span
class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">geom\_point</span><span class="crayon-sy">(</span><span
class="crayon-v">colour</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"firebrick"</span><span class="crayon-sy">)</span>

<span class="crayon-h">  </span>

<span class="crayon-h">  </span>

<span class="crayon-v">grid</span><span class="crayon-sy">.</span><span
class="crayon-e">arrange</span><span class="crayon-sy">(</span><span
class="crayon-v">plot\_1</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">plot\_2</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">plot\_3</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">ncol</span><span
class="crayon-o">=</span><span class="crayon-cn">3</span><span
class="crayon-sy">)</span>

</td>
</tr>
</table>

<p>
<code class="r"><span class="comment"> </span></code>
</p>
<p>
<a href="http://ibpad.com.br/wp-content/uploads/2016/11/im3-1.png"><img class="alignnone size-full wp-image-1686" src="https://ibpad.com.br/wp-content/uploads/2016/11/im3-1.png" alt="im3" width="1344" height="960"></a>
</p>
<p>
E pronto! Com algumas linhas de código R, você pode criar visualizações
impressionantes para a pesquisa nas Ciências Biológicas.
</p>
</div>

