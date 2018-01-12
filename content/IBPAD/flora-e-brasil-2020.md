+++
title = "Pacotes brasileiros do R, parte 4: Flora e Brasil 2020"
date = "2017-03-10 14:16:46"
categories = ["IBPAD"]
original_url = "https://www.ibpad.com.br/blog/analise-de-dados/flora-e-brasil-2020/"
+++

<p>
Brasil é famoso no mundo inteiro pela sua natureza, e não é
surpreendente que até no R existe um pacote para tratar do tema!
<a href="https://github.com/gustavobio" target="_blank">Gustavo
Carvalho</a> criou o pacote
<a href="https://github.com/gustavobio/flora" target="_blank">flora</a>
para disponibilizar os dados do
<a href="http://floradobrasil.jbrj.gov.br/reflora/listaBrasil/PrincipalUC/PrincipalUC.do#CondicaoTaxonCP" target="_blank">Flora
do Brasil 2020</a> para usuários de R.
</p>
<p>
Se você não sabe, o Flora do Brasil é uma versão online da Lista de
Espécies da Flora do Brasil, um projeto entre brasileiros e estrangeiros
para fornecer uma lista das plantas e fungos que existe no país. Neste
post, vamos observar as possibilidades da <code>flora</code> para
analisar esses dados no R.
</p>
<p>
Como o pacote está no CRAN, podemos instalá-lo diretamente. Depois
carregamos com <code>library()</code>.
</p>
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
install.packages("flora")

library(flora)
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

</td>
<td class="crayon-code">
 

 

<span class="crayon-v">install</span><span
class="crayon-sy">.</span><span class="crayon-e">packages</span><span
class="crayon-sy">(</span><span class="crayon-s">"flora"</span><span
class="crayon-sy">)</span>

 

<span class="crayon-e">library</span><span
class="crayon-sy">(</span><span class="crayon-v">flora</span><span
class="crayon-sy">)</span>

 

</td>
</tr>
</table>

<p>
<code>flora</code> tem vários jeitos de fornecer os dados do Brasil
2020. Um método é usar a função <code>get.taxa()</code>, que te dá
informação sobre uma espécie específica. Por exemplo, dado que eu gosto
de café, posso usar esta com o argumento <code>states = TRUE</code> para
ver nos quais estados café ocorre.
</p>
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
cafe &lt;- get.taxa("Coffea arabica", states = TRUE)

cafe$occurrence

\[1\]
"BR-AC|BR-AL|BR-BA|BR-CE|BR-DF|BR-ES|BR-GO|BR-MG|BR-MS|BR-PB|BR-PE|BR-PR|BR-RJ|BR-RS|BR-SC|BR-SE|BR-SP"

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

</td>
<td class="crayon-code">
 

 

 

<span class="crayon-v">cafe</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-v">get</span><span
class="crayon-sy">.</span><span class="crayon-e">taxa</span><span
class="crayon-sy">(</span><span class="crayon-s">"Coffea
arabica"</span><span class="crayon-sy">,</span><span class="crayon-h">
</span><span class="crayon-v">states</span><span class="crayon-h">
</span><span class="crayon-o">=</span><span class="crayon-h">
</span><span class="crayon-t">TRUE</span><span
class="crayon-sy">)</span>

 

<span class="crayon-v">cafe</span><span class="crayon-sy">$</span><span
class="crayon-i">occurrence</span>

 

<span class="crayon-sy">\[</span><span
class="crayon-cn">1</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span
class="crayon-s">"BR-AC|BR-AL|BR-BA|BR-CE|BR-DF|BR-ES|BR-GO|BR-MG|BR-MS|BR-PB|BR-PE|BR-PR|BR-RJ|BR-RS|BR-SC|BR-SE|BR-SP"</span>

 

 

</td>
</tr>
</table>

<p>
Com o pacote <code>tidyverse</code>, podemos rapidamente arrumar isso
para algo mais fácil usar. E com o uso de
<a href="https://robertmyles.github.io/2016/10/09/map-making-with-r-and-electionsbr/" target="_blank">shapefiles</a>,
podemos mapear onde ocorre café no Brasil.
</p>
<p>
<img src="https://www.ibpad.com.br/wp-content/uploads/2017/03/Screen-Shot-2017-03-07-at-4.25.45-PM.png" alt="">
</p>
<p>
<code>flora</code> também cuida dos nomes complexos dos itens. Se você
escreve errado, ele adivinha:
</p>
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
suggest.names("Cofee arabyca")

\[1\] "Coffea arabica"
----------------------

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

</td>
<td class="crayon-code">
 

 

<span class="crayon-v">suggest</span><span
class="crayon-sy">.</span><span class="crayon-e">names</span><span
class="crayon-sy">(</span><span class="crayon-s">"Cofee
arabyca"</span><span class="crayon-sy">)</span>

 

<span class="crayon-p">\#\# \[1\] "Coffea arabica"</span>

 

 

</td>
</tr>
</table>

<p>
Podemos também combinar o pacote com as imagens excelentes do
<a href="http://phylopic.org/" target="_blank">Phylopic</a> com
<code>flora</code>. Por exemplo, podemos pegar dados de quatro árvores
brasileiras, inclusive a <em>Dimorphandra wilsonii</em>, a árvore mais
rara no país, e ver em qual estados achamos essas árvores. O pacote
<code>rphylopic</code> baixa a imagem do Phylopic.
</p>
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
caju &lt;- get.taxa("Anacardium occidentale", states = T) %&gt;%
mutate(occurrence = gsub("BR-", "", occurrence)) %&gt;%
separate(occurrence, into = c("AC", "AL", "AM", "AP", "BA", "CE", "DF",
"ES", "GO", "MA", "MG", "MS", "MT", "PA", "PB", "PE", "PI", "RJ", "RN",
"RR", "SE", "SP", "TO"), sep = "\\|") %&gt;% gather(state, st, AC:TO)
%&gt;% select(-st, -id)

para &lt;- get.taxa("Bertholletia excelsa", states = T) %&gt;%
mutate(occurrence = gsub("BR-", "", occurrence)) %&gt;%
separate(occurrence, into = c("AC", "AM", "AP", "MT", "PA", "RO", "RR"),
sep = "\\|") %&gt;% gather(state, st, AC:RR) %&gt;% select(-st, -id)

dal &lt;- get.taxa("Dalbergia nigra", states = T) %&gt;%
mutate(occurrence = gsub("BR-", "", occurrence)) %&gt;%
separate(occurrence, into = c("AL", "BA", "ES", "MG", "PB", "PE", "PR",
"RJ", "SE", "SP"), sep = "\\|") %&gt;% gather(state, st, AL:SP) %&gt;%
select(-st, -id)

wil &lt;- get.taxa("Dimorphandra wilsonii", states = T) %&gt;%
mutate(occurrence = gsub("BR-", "", occurrence)) %&gt;%
separate(occurrence, into = c("MG"), sep = "\\|") %&gt;% gather(state,
st, MG) %&gt;% select(-st, -id)

arv &lt;- full\_join(caju, para) %&gt;% full\_join(dal) %&gt;%
full\_join(wil)

library(rphylopic) tree &lt;-
image\_data("f86235e3-f437-4630-9e77-73732b9bcf41", size =
"512")\[\[1\]\]

ggplot(arv, aes(x = state)) + geom\_bar(alpha = 0.6) +
add\_phylopic(tree, alpha = 0.7) + theme\_classic() + ylab("")

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

42

43

44

45

46

47

48

49

</td>
<td class="crayon-code">
 

 

 

<span class="crayon-v">caju</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-v">get</span><span
class="crayon-sy">.</span><span class="crayon-e">taxa</span><span
class="crayon-sy">(</span><span class="crayon-s">"Anacardium
occidentale"</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">states</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-v">T</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&gt;</span><span
class="crayon-o">%</span><span class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">mutate</span><span class="crayon-sy">(</span><span
class="crayon-v">occurrence</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-e">gsub</span><span class="crayon-sy">(</span><span
class="crayon-s">"BR-"</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-s">""</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">occurrence</span><span class="crayon-sy">)</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&gt;</span><span
class="crayon-o">%</span><span class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">separate</span><span class="crayon-sy">(</span><span
class="crayon-v">occurrence</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">into</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-e">c</span><span
class="crayon-sy">(</span><span class="crayon-s">"AC"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-s">"AL"</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-s">"AM"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-s">"AP"</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-s">"BA"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-s">"CE"</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-s">"DF"</span><span
class="crayon-sy">,</span>

<span class="crayon-h">                                </span><span
class="crayon-s">"ES"</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-s">"GO"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-s">"MA"</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-s">"MG"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-s">"MS"</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-s">"MT"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-s">"PA"</span><span class="crayon-sy">,</span>

<span class="crayon-h">                                </span><span
class="crayon-s">"PB"</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-s">"PE"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-s">"PI"</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-s">"RJ"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-s">"RN"</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-s">"RR"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-s">"SE"</span><span class="crayon-sy">,</span>

<span class="crayon-h">                                </span><span
class="crayon-s">"SP"</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-s">"TO"</span><span
class="crayon-sy">)</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">sep</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-s">"\\|"</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&gt;</span><span
class="crayon-o">%</span><span class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">gather</span><span class="crayon-sy">(</span><span
class="crayon-v">state</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">st</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">AC</span><span class="crayon-o">:</span><span
class="crayon-st">TO</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">%</span><span
class="crayon-o">&gt;</span><span class="crayon-o">%</span><span
class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">select</span><span class="crayon-sy">(</span><span
class="crayon-o">-</span><span class="crayon-v">st</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-o">-</span><span class="crayon-v">id</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span>

 

<span class="crayon-v">para</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-v">get</span><span
class="crayon-sy">.</span><span class="crayon-e">taxa</span><span
class="crayon-sy">(</span><span class="crayon-s">"Bertholletia
excelsa"</span><span class="crayon-sy">,</span><span class="crayon-h">
</span><span class="crayon-v">states</span><span class="crayon-h">
</span><span class="crayon-o">=</span><span class="crayon-h">
</span><span class="crayon-v">T</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&gt;</span><span
class="crayon-o">%</span><span class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">mutate</span><span class="crayon-sy">(</span><span
class="crayon-v">occurrence</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-e">gsub</span><span class="crayon-sy">(</span><span
class="crayon-s">"BR-"</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-s">""</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">occurrence</span><span class="crayon-sy">)</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&gt;</span><span
class="crayon-o">%</span><span class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">separate</span><span class="crayon-sy">(</span><span
class="crayon-v">occurrence</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">into</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-e">c</span><span
class="crayon-sy">(</span><span class="crayon-s">"AC"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-s">"AM"</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-s">"AP"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-s">"MT"</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-s">"PA"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-s">"RO"</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-s">"RR"</span><span
class="crayon-sy">)</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span>

<span class="crayon-h">           </span><span
class="crayon-v">sep</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"\\|"</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">%</span><span
class="crayon-o">&gt;</span><span class="crayon-o">%</span><span
class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">gather</span><span class="crayon-sy">(</span><span
class="crayon-v">state</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">st</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">AC</span><span class="crayon-o">:</span><span
class="crayon-v">RR</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">%</span><span
class="crayon-o">&gt;</span><span class="crayon-o">%</span><span
class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">select</span><span class="crayon-sy">(</span><span
class="crayon-o">-</span><span class="crayon-v">st</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-o">-</span><span class="crayon-v">id</span><span
class="crayon-sy">)</span><span class="crayon-h">   </span>

 

<span class="crayon-v">dal</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-v">get</span><span
class="crayon-sy">.</span><span class="crayon-e">taxa</span><span
class="crayon-sy">(</span><span class="crayon-s">"Dalbergia
nigra"</span><span class="crayon-sy">,</span><span class="crayon-h">
</span><span class="crayon-v">states</span><span class="crayon-h">
</span><span class="crayon-o">=</span><span class="crayon-h">
</span><span class="crayon-v">T</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&gt;</span><span
class="crayon-o">%</span><span class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">mutate</span><span class="crayon-sy">(</span><span
class="crayon-v">occurrence</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-e">gsub</span><span class="crayon-sy">(</span><span
class="crayon-s">"BR-"</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-s">""</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">occurrence</span><span class="crayon-sy">)</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&gt;</span><span
class="crayon-o">%</span><span class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">separate</span><span class="crayon-sy">(</span><span
class="crayon-v">occurrence</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">into</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-e">c</span><span
class="crayon-sy">(</span><span class="crayon-s">"AL"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-s">"BA"</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-s">"ES"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-s">"MG"</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-s">"PB"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-s">"PE"</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-s">"PR"</span><span
class="crayon-sy">,</span>

<span class="crayon-h">                                </span><span
class="crayon-s">"RJ"</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-s">"SE"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-s">"SP"</span><span class="crayon-sy">)</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span>

<span class="crayon-h">           </span><span
class="crayon-v">sep</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"\\|"</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">%</span><span
class="crayon-o">&gt;</span><span class="crayon-o">%</span><span
class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">gather</span><span class="crayon-sy">(</span><span
class="crayon-v">state</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">st</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">AL</span><span class="crayon-o">:</span><span
class="crayon-v">SP</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">%</span><span
class="crayon-o">&gt;</span><span class="crayon-o">%</span><span
class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">select</span><span class="crayon-sy">(</span><span
class="crayon-o">-</span><span class="crayon-v">st</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-o">-</span><span class="crayon-v">id</span><span
class="crayon-sy">)</span><span class="crayon-h">   </span>

 

<span class="crayon-v">wil</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-v">get</span><span
class="crayon-sy">.</span><span class="crayon-e">taxa</span><span
class="crayon-sy">(</span><span class="crayon-s">"Dimorphandra
wilsonii"</span><span class="crayon-sy">,</span><span class="crayon-h">
</span><span class="crayon-v">states</span><span class="crayon-h">
</span><span class="crayon-o">=</span><span class="crayon-h">
</span><span class="crayon-v">T</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&gt;</span><span
class="crayon-o">%</span><span class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">mutate</span><span class="crayon-sy">(</span><span
class="crayon-v">occurrence</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-e">gsub</span><span class="crayon-sy">(</span><span
class="crayon-s">"BR-"</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-s">""</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">occurrence</span><span class="crayon-sy">)</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&gt;</span><span
class="crayon-o">%</span><span class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">separate</span><span class="crayon-sy">(</span><span
class="crayon-v">occurrence</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">into</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-e">c</span><span
class="crayon-sy">(</span><span class="crayon-s">"MG"</span><span
class="crayon-sy">)</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span>

<span class="crayon-h">           </span><span
class="crayon-v">sep</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"\\|"</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">%</span><span
class="crayon-o">&gt;</span><span class="crayon-o">%</span><span
class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">gather</span><span class="crayon-sy">(</span><span
class="crayon-v">state</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">st</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">MG</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">%</span><span
class="crayon-o">&gt;</span><span class="crayon-o">%</span><span
class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">select</span><span class="crayon-sy">(</span><span
class="crayon-o">-</span><span class="crayon-v">st</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-o">-</span><span class="crayon-v">id</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span>

<span class="crayon-h">  </span>

<span class="crayon-v">arv</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-e">full\_join</span><span
class="crayon-sy">(</span><span class="crayon-v">caju</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">para</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">%</span><span
class="crayon-o">&gt;</span><span class="crayon-o">%</span><span
class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">full\_join</span><span class="crayon-sy">(</span><span
class="crayon-v">dal</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">%</span><span
class="crayon-o">&gt;</span><span class="crayon-o">%</span><span
class="crayon-h"> </span>

<span class="crayon-h">  </span><span
class="crayon-e">full\_join</span><span class="crayon-sy">(</span><span
class="crayon-v">wil</span><span class="crayon-sy">)</span>

 

 

<span class="crayon-e">library</span><span
class="crayon-sy">(</span><span class="crayon-v">rphylopic</span><span
class="crayon-sy">)</span>

<span class="crayon-v">tree</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-e">image\_data</span><span
class="crayon-sy">(</span><span
class="crayon-s">"f86235e3-f437-4630-9e77-73732b9bcf41"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">size</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"512"</span><span class="crayon-sy">)</span><span
class="crayon-sy">\[</span><span class="crayon-sy">\[</span><span
class="crayon-cn">1</span><span class="crayon-sy">\]</span><span class="crayon-sy">\]</span>

 

<span class="crayon-e">ggplot</span><span
class="crayon-sy">(</span><span class="crayon-v">arv</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-e">aes</span><span class="crayon-sy">(</span><span
class="crayon-v">x</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">state</span><span class="crayon-sy">)</span><span
class="crayon-sy">)</span><span class="crayon-h"> </span><span
class="crayon-o">+</span>

<span class="crayon-h">  </span><span
class="crayon-e">geom\_bar</span><span class="crayon-sy">(</span><span
class="crayon-v">alpha</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-cn">0.6</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">+</span>

<span class="crayon-h">  </span><span
class="crayon-e">add\_phylopic</span><span
class="crayon-sy">(</span><span class="crayon-v">tree</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">alpha</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-cn">0.7</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">+</span>

<span class="crayon-h">  </span><span
class="crayon-e">theme\_classic</span><span
class="crayon-sy">(</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">+</span>

<span class="crayon-h">  </span><span class="crayon-e">ylab</span><span
class="crayon-sy">(</span><span class="crayon-s">""</span><span
class="crayon-sy">)</span>

 

<span class="crayon-h"> </span>

</td>
</tr>
</table>

<p>
<img src="https://www.ibpad.com.br/wp-content/uploads/2017/03/unnamed-chunk-6-1.png" alt="">
</p>
<p>
Dado que a <em>Dimorphandra wilsonii</em> só cresce em Minas Gerais, MG
‘ganha’ aqui.
</p>
<p>
Uma outra função útil do pacote é a <code>lower.taxa()</code>, que busca
por descendentes na linhagem da espécies. Por exemplo, podemos procurar
por detalhes sobre pimenta, usando esse nome comum, e daí buscar pela
taxa mais baixa. Eu particularmente gosto dos nomes vernáculos
(“alecrim-de-cobra”):
</p>
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
pim &lt;- vernacular("Pimenta")

head(pim$vernacular.name)

\[1\] "alecrim-de-cobra/PORTUGUES/Alagoas | alfavaca
brava/PORTUGUES/Pará | alfavaca de cobra/PORTUGUES/Amazonas |
maricutinha/PORTUGUES/Bahia | pimenta de lagarta/PORTUGUES/Pará" \[2\]
"arengueiro/PORTUGUES/Bahia | catinga-de-porco/PORTUGUES/Bahia |
jaborandi-da-restinga/PORTUGUES/Rio de Janeiro |
jaburandi/PORTUGUES/Ceará | pimentinha/PORTUGUES/Ceará"  
\[3\] "pimentinha/PORTUGUES/Nordeste | guarda-orvalho/PORTUGUES/Nordeste
| cumixá/PORTUGUES/Nordeste | cocarana-do-cerrado/PORTUGUES/Norte"  
\[4\] "chapadinho/PORTUGUES/Goiás, Minas Gerais |
fruta-de-tucano/PORTUGUES/Minas Gerais | mercúrio/PORTUGUES/Mato Grosso
| pimenta/PORTUGUES/Minas Gerais"  
\[5\] "pimentinha/PORTUGUES/Nordeste | cuminxá/PORTUGUES/Nordeste |
cumixá/cumichá/PORTUGUES/Nordeste | atracador/PORTUGUES/Mato Grosso"  
\[6\] "canela-jacuá/PORTUGUES/Sudeste |
canela-pimenta/PORTUGUES/Sudeste"

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

</td>
<td class="crayon-code">
 

 

<span class="crayon-v">pim</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-e">vernacular</span><span
class="crayon-sy">(</span><span class="crayon-s">"Pimenta"</span><span
class="crayon-sy">)</span>

 

<span class="crayon-e">head</span><span class="crayon-sy">(</span><span
class="crayon-v">pim</span><span class="crayon-sy">$</span><span
class="crayon-v">vernacular</span><span class="crayon-sy">.</span><span
class="crayon-v">name</span><span class="crayon-sy">)</span>

 

<span class="crayon-sy">\[</span><span
class="crayon-cn">1</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span
class="crayon-s">"alecrim-de-cobra/PORTUGUES/Alagoas | alfavaca
brava/PORTUGUES/Pará | alfavaca de cobra/PORTUGUES/Amazonas |
maricutinha/PORTUGUES/Bahia | pimenta de lagarta/PORTUGUES/Pará"</span>

<span class="crayon-sy">\[</span><span
class="crayon-cn">2</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span
class="crayon-s">"arengueiro/PORTUGUES/Bahia |
catinga-de-porco/PORTUGUES/Bahia | jaborandi-da-restinga/PORTUGUES/Rio
de Janeiro | jaburandi/PORTUGUES/Ceará |
pimentinha/PORTUGUES/Ceará"</span><span class="crayon-h">    </span>

<span class="crayon-sy">\[</span><span
class="crayon-cn">3</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span
class="crayon-s">"pimentinha/PORTUGUES/Nordeste |
guarda-orvalho/PORTUGUES/Nordeste | cumixá/PORTUGUES/Nordeste |
cocarana-do-cerrado/PORTUGUES/Norte"</span><span
class="crayon-h">                                        </span>

<span class="crayon-sy">\[</span><span
class="crayon-cn">4</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span
class="crayon-s">"chapadinho/PORTUGUES/Goiás, Minas Gerais |
fruta-de-tucano/PORTUGUES/Minas Gerais | mercúrio/PORTUGUES/Mato Grosso
| pimenta/PORTUGUES/Minas Gerais"</span><span
class="crayon-h">                        </span>

<span class="crayon-sy">\[</span><span
class="crayon-cn">5</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span
class="crayon-s">"pimentinha/PORTUGUES/Nordeste |
cuminxá/PORTUGUES/Nordeste | cumixá/cumichá/PORTUGUES/Nordeste |
atracador/PORTUGUES/Mato Grosso"</span><span
class="crayon-h">                                           </span>

<span class="crayon-sy">\[</span><span
class="crayon-cn">6</span><span class="crayon-sy">\]</span><span
class="crayon-h"> </span><span
class="crayon-s">"canela-jacuá/PORTUGUES/Sudeste |
canela-pimenta/PORTUGUES/Sudeste"</span><span class="crayon-h">  </span>

 

 

</td>
</tr>
</table>

<p>
<code>flora</code> também tem uma função para abrir um app Shiny no seu
browser. Basta usar o comando <code>web.flora()</code> e o aplicativo
abre. Do app, você pode buscar interativamente para os dados do
maravilhoso Brasil 2020!
</p>
<p>
O pacote <code>flora</code> tem mais opções para utilizar os dados do
Brasil 2020 nas suas análises. O manual
está <a href="https://cran.r-project.org/web/packages/flora/flora.pdf" target="_blank">aqui</a>
e o GitHub do pacote tem mais detalhes!
</p>

