+++
title = "A polarização política no Brasil em 2016 – Big Data e Social Network Analysis"
date = "2016-11-21 15:21:22"
categories = ["IBPAD"]
original_url = "https://www.ibpad.com.br/blog/analise-de-dados/polarizacao-politica-no-brasil-em-2016-big-data-e-social-network-analysis/"
+++

<div class="post-inner-content">
<p style="text-align: right; padding-left: 180px;">
<em>\[Texto do prof.
<a href="https://neylsoncrepalde.github.io/" target="_blank">Neylson
Crepalde</a>,  Doutorando e Mestre em Sociologia pela Universidade
Federal de Minas Gerais e membro do GIARS (Grupo Interdisciplinar de
Pesquisa em Análise de Redes Sociais)\]</em>
</p>
<p>
Neste post vamos usar ferramentas de <em>Big Data</em> para estudar o
grande movimento de polarização política que vem ocorrendo no Brasil nos
últimos meses. Para isso, vamos analisar posts das páginas da UNE e do
MBL, organizações estudantis assumidamente de esquerda e direita
respectivamente. Para isso, utilizamos a ferramenta <em>Netvizz</em>.
</p>
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
Carregando os pacotes necessários
=================================

library(magrittr) library(readr) library(descr) library(tm)
library(wordcloud) library(igraph) library(lubridate) library(ggplot2)
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

</td>
<td class="crayon-code">
<span class="crayon-p">\# Carregando os pacotes necessários</span>

<span class="crayon-e">library</span><span
class="crayon-sy">(</span><span class="crayon-v">magrittr</span><span
class="crayon-sy">)</span>

<span class="crayon-e">library</span><span
class="crayon-sy">(</span><span class="crayon-v">readr</span><span
class="crayon-sy">)</span>

<span class="crayon-e">library</span><span
class="crayon-sy">(</span><span class="crayon-v">descr</span><span
class="crayon-sy">)</span>

<span class="crayon-e">library</span><span
class="crayon-sy">(</span><span class="crayon-v">tm</span><span
class="crayon-sy">)</span>

<span class="crayon-e">library</span><span
class="crayon-sy">(</span><span class="crayon-v">wordcloud</span><span
class="crayon-sy">)</span>

<span class="crayon-e">library</span><span
class="crayon-sy">(</span><span class="crayon-v">igraph</span><span
class="crayon-sy">)</span>

<span class="crayon-e">library</span><span
class="crayon-sy">(</span><span class="crayon-v">lubridate</span><span
class="crayon-sy">)</span>

<span class="crayon-e">library</span><span
class="crayon-sy">(</span><span class="crayon-v">ggplot2</span><span
class="crayon-sy">)</span>

</td>
</tr>
</table>

<p>
</p>
<h2>
UNE
</h2>
<p>
A UNE (União Nacional dos Estudantes) é uma organização da sociedade
civil de representação estudantil com posicionamento político
assumidamente de esquerda. De acordo com a própria página da
organização:
</p>
<blockquote>
<p>
“A UNE foi fundada em 1937 e ao longo de seus 78 anos, marcou presença
nos principais acontecimentos políticos, sociais e culturais do Brasil.
Desde a luta pelo fim da ditadura do Estado Novo, atravessando a luta do
desenvolvimento nacional, a exemplo da campanha do Petróleo, os anos de
chumbo do regime militar, as Diretas Já e o impeachment do presidente
Collor. Da mesma forma, foi um dos principais focos de resistência às
privatizações e ao neoliberalismo que marcou a Era FHC.”
</p>
</blockquote>
<p>
Vamos começar com uma análise preliminar dos dados usando uma nuvem de
palavras. Maiores informações sobre o procedimento de limpeza das
postagens e sobre o uso do pacote <strong>tm</strong> podem ser vistas
<a href="https://neylsoncrepalde.github.io/2016-03-18-analise-de-conteudo-twitter/" target="_blank">aqui</a>.
</p>
<div id="crayon-5a5818d00ba5e855318644" class="crayon-syntax crayon-theme-classic crayon-font-monaco crayon-os-pc print-yes notranslate" data-settings=" minimize scroll-mouseover" style=" margin-top: 12px; margin-bottom: 12px; font-size: 12px !important; line-height: 15px !important;">
<span class="crayon-title"></span>

<div class="crayon-plain-wrap">
<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
UNE = read\_tsv('/home/neylson/Documentos/Neylson
Crepalde/Doutorado/UNE\_MBL/UNE/page\_241149405912525\_2016\_11\_18\_02\_59\_37\_comments.tab')
posts\_une = UNE*p**o**s**t*<sub>*t*</sub>*e**x**t*</span><span
class="crayon-v">post\_text</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&gt;</span><span
class="crayon-o">%</span><span class="crayon-h"> </span><span
class="crayon-v">unique</span>
</div>
<span class="crayon-p">\# identificando alguns assuntos</span>

<span class="crayon-v">unep</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-e">Corpus</span><span class="crayon-sy">(</span><span
class="crayon-e">VectorSource</span><span
class="crayon-sy">(</span><span class="crayon-v">posts\_une</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span>

<span class="crayon-v">unep</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-e">tm\_map</span><span
class="crayon-sy">(</span><span class="crayon-v">unep</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-e">content\_transformer</span><span
class="crayon-sy">(</span><span class="crayon-v">tolower</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span>

<span class="crayon-v">unep</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-e">tm\_map</span><span
class="crayon-sy">(</span><span class="crayon-v">unep</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">removePunctuation</span><span
class="crayon-sy">)</span>

<span class="crayon-v">unep</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-e">tm\_map</span><span
class="crayon-sy">(</span><span class="crayon-v">unep</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-t">function</span><span class="crayon-sy">(</span><span
class="crayon-v">x</span><span class="crayon-sy">)</span><span
class="crayon-e">removeWords</span><span class="crayon-sy">(</span><span
class="crayon-v">x</span><span class="crayon-sy">,</span><span
class="crayon-e">stopwords</span><span class="crayon-sy">(</span><span
class="crayon-s">"pt"</span><span class="crayon-sy">)</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span>

<span class="crayon-v">unep</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-e">tm\_map</span><span
class="crayon-sy">(</span><span class="crayon-v">unep</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-t">function</span><span class="crayon-sy">(</span><span
class="crayon-v">x</span><span class="crayon-sy">)</span><span
class="crayon-e">removeWords</span><span class="crayon-sy">(</span><span
class="crayon-v">x</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-s">'campus'</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span>

<span class="crayon-v">pal</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">brewer</span><span class="crayon-sy">.</span><span
class="crayon-e">pal</span><span class="crayon-sy">(</span><span
class="crayon-cn">5</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-s">"Set2"</span><span
class="crayon-sy">)</span>

<span class="crayon-p">\# Nuvem de palavras</span>

<span class="crayon-e">wordcloud</span><span
class="crayon-sy">(</span><span class="crayon-v">unep</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">min</span><span class="crayon-sy">.</span><span
class="crayon-v">freq</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-cn">3</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">max</span><span
class="crayon-sy">.</span><span class="crayon-v">words</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-cn">100</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">random</span><span class="crayon-sy">.</span><span
class="crayon-v">order</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">F</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">colors</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-v">pal</span><span
class="crayon-sy">)</span>

<span class="crayon-e">title</span><span class="crayon-sy">(</span><span
class="crayon-v">xlab</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"Facebook - UNE17/09/2016 a 17/11/2016"</span><span
class="crayon-sy">)</span>

</div>
</td>
</tr>
</table>
</div>
</div>
<p>
<a href="http://ibpad.com.br/wp-content/uploads/2016/11/facebook-une.png"><img class="aligncenter size-full wp-image-1792" src="https://ibpad.com.br/wp-content/uploads/2016/11/facebook-une.png" alt="facebook-une" width="650" height="401"></a>
</p>
<p>
Agora vamos tentar identificar alguns assuntos através da clusterização
hierárquica das palavras das postagens.
</p>
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
tdm &lt;- TermDocumentMatrix(unep) tdm &lt;- removeSparseTerms(tdm,
sparse = 0.91) df &lt;- as.data.frame(inspect(tdm))
</textarea>

<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
1

2

3

</td>
<td class="crayon-code">
<span class="crayon-v">tdm</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span
class="crayon-e">TermDocumentMatrix</span><span
class="crayon-sy">(</span><span class="crayon-v">unep</span><span
class="crayon-sy">)</span>

<span class="crayon-v">tdm</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span
class="crayon-e">removeSparseTerms</span><span
class="crayon-sy">(</span><span class="crayon-v">tdm</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">sparse</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-cn">0.91</span><span class="crayon-sy">)</span>

<span class="crayon-v">df</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-st">as</span><span
class="crayon-sy">.</span><span class="crayon-v">data</span><span
class="crayon-sy">.</span><span class="crayon-e">frame</span><span
class="crayon-sy">(</span><span class="crayon-e">inspect</span><span
class="crayon-sy">(</span><span class="crayon-v">tdm</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span>

</td>
</tr>
</table>

<p>
</p>
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
&lt;&lt;TermDocumentMatrix (terms: 36, documents: 244)&gt;&gt;
Non-/sparse entries: 1332/7452 Sparsity : 85% Maximal term length: 13
Weighting : term frequency (tf)

               Docs

Terms 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25
26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 241 0 0 0 0 0 1 0 1 1 1
0 0 1 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 0 0 0 0 brasil 0 1
0 1 0 2 1 2 2 0 0 0 2 3 2 1 1 1 0 2 1 2 2 0 0 0 0 0 0 0 0 0 0 0 0 0 2 0
0 0 1 contra 0 0 1 0 0 1 1 3 0 0 0 0 3 1 0 0 0 0 1 0 0 1 0 1 0 0 0 0 1 2
1 0 1 0 0 0 1 0 0 0 1 dia 1 0 0 0 0 0 0 4 3 0 0 0 4 0 0 1 1 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 Docs Terms 42 43 44 45 46 47 48 49
50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73
74 75 76 77 78 79 241 0 0 1 0 1 0 0 0 1 0 1 0 0 0 0 0 0 0 1 1 0 0 0 1 0
0 0 0 0 0 0 0 0 0 0 0 0 1 brasil 0 0 2 0 0 1 0 0 1 0 0 0 0 1 0 0 1 0 0 0
0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 1 0 contra 0 0 1 0 0 0 0 0 1 0 0 0 0 0 0
0 0 0 0 0 0 0 0 1 0 0 0 0 1 0 0 1 0 0 0 0 0 0 dia 0 0 0 1 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 Docs Terms 80 81
82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103
104 105 106 107 108 109 110 111 112 241 0 0 0 1 0 1 1 0 0 0 2 1 0 0 0 0
1 1 0 0 0 1 1 1 1 0 1 0 0 1 0 0 1 brasil 0 0 1 0 0 1 0 0 0 0 1 0 0 0 0 2
1 0 0 0 0 3 0 1 0 0 0 0 0 0 0 1 0 contra 0 0 2 2 0 0 2 0 0 0 3 0 0 0 0 0
0 1 0 0 1 2 2 1 0 0 1 0 0 1 0 0 1 dia 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1
0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 1 Docs Terms 113 114 115 116 117 118 119
120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137
138 139 140 241 0 2 0 1 0 0 0 0 0 2 1 1 2 0 0 1 1 0 1 0 0 1 0 0 0 1 0 1
brasil 0 0 0 1 0 1 0 0 1 1 0 0 0 0 0 0 0 0 1 0 0 1 0 1 0 0 0 0 contra 2
4 1 0 0 0 0 0 0 3 1 1 2 0 0 1 1 0 1 0 0 0 0 0 0 1 0 0 dia 0 0 0 1 0 0 0
0 0 2 0 0 0 0 0 0 0 0 0 2 1 1 0 0 0 1 0 0 Docs Terms 141 142 143 144 145
146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163
164 165 166 167 168 241 0 1 0 0 0 0 0 0 1 1 1 0 2 1 1 0 0 0 1 0 0 0 0 1
1 0 0 0 brasil 0 0 1 0 0 0 0 1 2 1 0 1 0 0 0 0 0 0 0 1 0 0 0 0 0 1 0 0
contra 1 0 0 1 1 0 0 1 0 1 1 2 2 0 0 0 0 0 3 0 0 0 0 1 1 0 0 2 dia 0 0 0
0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 2 0 2 0 2 Docs Terms 169 170 171
172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189
190 191 192 193 194 195 196 241 0 0 1 0 0 2 2 1 0 0 1 2 1 1 1 2 1 2 1 0
0 2 1 2 1 1 1 1 brasil 1 0 1 0 0 1 0 0 0 0 0 0 0 0 0 1 0 3 0 0 0 2 0 1 0
0 0 0 contra 0 0 0 1 0 0 2 1 0 1 0 1 1 1 2 0 0 1 1 0 0 1 1 3 0 1 1 0 dia
0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 Docs Terms 197
198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215
216 217 218 219 220 221 222 223 224 241 0 0 0 1 0 2 1 0 0 2 0 0 0 0 0 0
0 1 0 0 0 0 0 0 0 0 0 0 brasil 0 0 0 1 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0
0 0 0 0 1 1 0 contra 1 0 0 1 0 0 1 2 0 0 1 0 1 2 0 0 0 1 0 0 0 0 0 0 0 1
0 0 dia 0 0 0 1 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 Docs
Terms 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240
241 242 243 244 241 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 brasil 0 1 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 contra 0 0 0 0 0 0 0 0 0 1 1 0 0 2 0 0
0 0 0 0 dia 0 0 0 0 1 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 \[ reached
getOption("max.print") -- omitted 32 rows \]
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

50

51

52

53

54

55

</td>
<td class="crayon-code">
<span class="crayon-o">&</span><span class="crayon-v">lt</span><span
class="crayon-sy">;</span><span class="crayon-o">&</span><span
class="crayon-v">lt</span><span class="crayon-sy">;</span><span
class="crayon-e">TermDocumentMatrix</span><span class="crayon-h">
</span><span class="crayon-sy">(</span><span
class="crayon-v">terms</span><span class="crayon-o">:</span><span
class="crayon-h"> </span><span class="crayon-cn">36</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">documents</span><span class="crayon-o">:</span><span
class="crayon-h"> </span><span class="crayon-cn">244</span><span
class="crayon-sy">)</span><span class="crayon-o">&</span><span
class="crayon-v">gt</span><span class="crayon-sy">;</span><span
class="crayon-o">&</span><span class="crayon-v">gt</span><span
class="crayon-sy">;</span>

<span class="crayon-v">Non</span><span class="crayon-o">-</span><span
class="crayon-o">/</span><span class="crayon-e">sparse </span><span
class="crayon-v">entries</span><span class="crayon-o">:</span><span
class="crayon-h"> </span><span class="crayon-cn">1332</span><span
class="crayon-o">/</span><span class="crayon-cn">7452</span>

<span class="crayon-v">Sparsity</span><span class="crayon-h">          
</span><span class="crayon-o">:</span><span class="crayon-h">
</span><span class="crayon-cn">85</span><span class="crayon-o">%</span>

<span class="crayon-e">Maximal </span><span class="crayon-e">term
</span><span class="crayon-v">length</span><span
class="crayon-o">:</span><span class="crayon-h"> </span><span
class="crayon-cn">13</span>

<span class="crayon-v">Weighting</span><span
class="crayon-h">          </span><span class="crayon-o">:</span><span
class="crayon-h"> </span><span class="crayon-e">term </span><span
class="crayon-e">frequency</span><span class="crayon-h"> </span><span
class="crayon-sy">(</span><span class="crayon-v">tf</span><span
class="crayon-sy">)</span>

 

<span class="crayon-h">               </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span class="crayon-h">          
</span><span class="crayon-cn">1</span><span class="crayon-h">
</span><span class="crayon-cn">2</span><span class="crayon-h">
</span><span class="crayon-cn">3</span><span class="crayon-h">
</span><span class="crayon-cn">4</span><span class="crayon-h">
</span><span class="crayon-cn">5</span><span class="crayon-h">
</span><span class="crayon-cn">6</span><span class="crayon-h">
</span><span class="crayon-cn">7</span><span class="crayon-h">
</span><span class="crayon-cn">8</span><span class="crayon-h">
</span><span class="crayon-cn">9</span><span class="crayon-h">
</span><span class="crayon-cn">10</span><span class="crayon-h">
</span><span class="crayon-cn">11</span><span class="crayon-h">
</span><span class="crayon-cn">12</span><span class="crayon-h">
</span><span class="crayon-cn">13</span><span class="crayon-h">
</span><span class="crayon-cn">14</span><span class="crayon-h">
</span><span class="crayon-cn">15</span><span class="crayon-h">
</span><span class="crayon-cn">16</span><span class="crayon-h">
</span><span class="crayon-cn">17</span><span class="crayon-h">
</span><span class="crayon-cn">18</span><span class="crayon-h">
</span><span class="crayon-cn">19</span><span class="crayon-h">
</span><span class="crayon-cn">20</span><span class="crayon-h">
</span><span class="crayon-cn">21</span><span class="crayon-h">
</span><span class="crayon-cn">22</span><span class="crayon-h">
</span><span class="crayon-cn">23</span><span class="crayon-h">
</span><span class="crayon-cn">24</span><span class="crayon-h">
</span><span class="crayon-cn">25</span><span class="crayon-h">
</span><span class="crayon-cn">26</span><span class="crayon-h">
</span><span class="crayon-cn">27</span><span class="crayon-h">
</span><span class="crayon-cn">28</span><span class="crayon-h">
</span><span class="crayon-cn">29</span><span class="crayon-h">
</span><span class="crayon-cn">30</span><span class="crayon-h">
</span><span class="crayon-cn">31</span><span class="crayon-h">
</span><span class="crayon-cn">32</span><span class="crayon-h">
</span><span class="crayon-cn">33</span><span class="crayon-h">
</span><span class="crayon-cn">34</span><span class="crayon-h">
</span><span class="crayon-cn">35</span><span class="crayon-h">
</span><span class="crayon-cn">36</span><span class="crayon-h">
</span><span class="crayon-cn">37</span><span class="crayon-h">
</span><span class="crayon-cn">38</span><span class="crayon-h">
</span><span class="crayon-cn">39</span><span class="crayon-h">
</span><span class="crayon-cn">40</span><span class="crayon-h">
</span><span class="crayon-cn">41</span>

<span class="crayon-h">  </span><span class="crayon-cn">241</span><span
class="crayon-h">           </span><span class="crayon-cn">0</span><span
class="crayon-h"> </span><span class="crayon-cn">0</span><span
class="crayon-h"> </span><span class="crayon-cn">0</span><span
class="crayon-h"> </span><span class="crayon-cn">0</span><span
class="crayon-h"> </span><span class="crayon-cn">0</span><span
class="crayon-h"> </span><span class="crayon-cn">1</span><span
class="crayon-h"> </span><span class="crayon-cn">0</span><span
class="crayon-h"> </span><span class="crayon-cn">1</span><span
class="crayon-h"> </span><span class="crayon-cn">1</span><span
class="crayon-h">  </span><span class="crayon-cn">1</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">1</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">1</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">1</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">1</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span>

<span class="crayon-h">  </span><span
class="crayon-i">brasil</span><span
class="crayon-h">        </span><span class="crayon-cn">0</span><span
class="crayon-h"> </span><span class="crayon-cn">1</span><span
class="crayon-h"> </span><span class="crayon-cn">0</span><span
class="crayon-h"> </span><span class="crayon-cn">1</span><span
class="crayon-h"> </span><span class="crayon-cn">0</span><span
class="crayon-h"> </span><span class="crayon-cn">2</span><span
class="crayon-h"> </span><span class="crayon-cn">1</span><span
class="crayon-h"> </span><span class="crayon-cn">2</span><span
class="crayon-h"> </span><span class="crayon-cn">2</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">2</span><span
class="crayon-h">  </span><span class="crayon-cn">3</span><span
class="crayon-h">  </span><span class="crayon-cn">2</span><span
class="crayon-h">  </span><span class="crayon-cn">1</span><span
class="crayon-h">  </span><span class="crayon-cn">1</span><span
class="crayon-h">  </span><span class="crayon-cn">1</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">2</span><span
class="crayon-h">  </span><span class="crayon-cn">1</span><span
class="crayon-h">  </span><span class="crayon-cn">2</span><span
class="crayon-h">  </span><span class="crayon-cn">2</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">2</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">1</span>

<span class="crayon-h">  </span><span
class="crayon-i">contra</span><span
class="crayon-h">        </span><span class="crayon-cn">0</span><span
class="crayon-h"> </span><span class="crayon-cn">0</span><span
class="crayon-h"> </span><span class="crayon-cn">1</span><span
class="crayon-h"> </span><span class="crayon-cn">0</span><span
class="crayon-h"> </span><span class="crayon-cn">0</span><span
class="crayon-h"> </span><span class="crayon-cn">1</span><span
class="crayon-h"> </span><span class="crayon-cn">1</span><span
class="crayon-h"> </span><span class="crayon-cn">3</span><span
class="crayon-h"> </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">3</span><span
class="crayon-h">  </span><span class="crayon-cn">1</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">1</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">1</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">1</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">1</span><span
class="crayon-h">  </span><span class="crayon-cn">2</span><span
class="crayon-h">  </span><span class="crayon-cn">1</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">1</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">1</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">1</span>

<span class="crayon-h">  </span><span class="crayon-i">dia</span><span
class="crayon-h">           </span><span class="crayon-cn">1</span><span
class="crayon-h"> </span><span class="crayon-cn">0</span><span
class="crayon-h"> </span><span class="crayon-cn">0</span><span
class="crayon-h"> </span><span class="crayon-cn">0</span><span
class="crayon-h"> </span><span class="crayon-cn">0</span><span
class="crayon-h"> </span><span class="crayon-cn">0</span><span
class="crayon-h"> </span><span class="crayon-cn">0</span><span
class="crayon-h"> </span><span class="crayon-cn">4</span><span
class="crayon-h"> </span><span class="crayon-cn">3</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">4</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">1</span><span
class="crayon-h">  </span><span class="crayon-cn">1</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span>

<span class="crayon-h">               </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span class="crayon-h">          
</span><span class="crayon-cn">42</span><span class="crayon-h">
</span><span class="crayon-cn">43</span><span class="crayon-h">
</span><span class="crayon-cn">44</span><span class="crayon-h">
</span><span class="crayon-cn">45</span><span class="crayon-h">
</span><span class="crayon-cn">46</span><span class="crayon-h">
</span><span class="crayon-cn">47</span><span class="crayon-h">
</span><span class="crayon-cn">48</span><span class="crayon-h">
</span><span class="crayon-cn">49</span><span class="crayon-h">
</span><span class="crayon-cn">50</span><span class="crayon-h">
</span><span class="crayon-cn">51</span><span class="crayon-h">
</span><span class="crayon-cn">52</span><span class="crayon-h">
</span><span class="crayon-cn">53</span><span class="crayon-h">
</span><span class="crayon-cn">54</span><span class="crayon-h">
</span><span class="crayon-cn">55</span><span class="crayon-h">
</span><span class="crayon-cn">56</span><span class="crayon-h">
</span><span class="crayon-cn">57</span><span class="crayon-h">
</span><span class="crayon-cn">58</span><span class="crayon-h">
</span><span class="crayon-cn">59</span><span class="crayon-h">
</span><span class="crayon-cn">60</span><span class="crayon-h">
</span><span class="crayon-cn">61</span><span class="crayon-h">
</span><span class="crayon-cn">62</span><span class="crayon-h">
</span><span class="crayon-cn">63</span><span class="crayon-h">
</span><span class="crayon-cn">64</span><span class="crayon-h">
</span><span class="crayon-cn">65</span><span class="crayon-h">
</span><span class="crayon-cn">66</span><span class="crayon-h">
</span><span class="crayon-cn">67</span><span class="crayon-h">
</span><span class="crayon-cn">68</span><span class="crayon-h">
</span><span class="crayon-cn">69</span><span class="crayon-h">
</span><span class="crayon-cn">70</span><span class="crayon-h">
</span><span class="crayon-cn">71</span><span class="crayon-h">
</span><span class="crayon-cn">72</span><span class="crayon-h">
</span><span class="crayon-cn">73</span><span class="crayon-h">
</span><span class="crayon-cn">74</span><span class="crayon-h">
</span><span class="crayon-cn">75</span><span class="crayon-h">
</span><span class="crayon-cn">76</span><span class="crayon-h">
</span><span class="crayon-cn">77</span><span class="crayon-h">
</span><span class="crayon-cn">78</span><span class="crayon-h">
</span><span class="crayon-cn">79</span>

<span class="crayon-h">  </span><span class="crayon-cn">241</span><span
class="crayon-h">            </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">1</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">1</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">1</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">1</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">1</span><span class="crayon-h">  </span><span
class="crayon-cn">1</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">1</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">1</span>

<span class="crayon-h">  </span><span
class="crayon-i">brasil</span><span class="crayon-h">        
</span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">2</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">1</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">1</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">1</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">1</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">1</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">1</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span>

<span class="crayon-h">  </span><span
class="crayon-i">contra</span><span class="crayon-h">        
</span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">1</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">1</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">1</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">1</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">1</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span>

<span class="crayon-h">  </span><span class="crayon-i">dia</span><span
class="crayon-h">            </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">1</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">1</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span>

<span class="crayon-h">               </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span class="crayon-h">          
</span><span class="crayon-cn">80</span><span class="crayon-h">
</span><span class="crayon-cn">81</span><span class="crayon-h">
</span><span class="crayon-cn">82</span><span class="crayon-h">
</span><span class="crayon-cn">83</span><span class="crayon-h">
</span><span class="crayon-cn">84</span><span class="crayon-h">
</span><span class="crayon-cn">85</span><span class="crayon-h">
</span><span class="crayon-cn">86</span><span class="crayon-h">
</span><span class="crayon-cn">87</span><span class="crayon-h">
</span><span class="crayon-cn">88</span><span class="crayon-h">
</span><span class="crayon-cn">89</span><span class="crayon-h">
</span><span class="crayon-cn">90</span><span class="crayon-h">
</span><span class="crayon-cn">91</span><span class="crayon-h">
</span><span class="crayon-cn">92</span><span class="crayon-h">
</span><span class="crayon-cn">93</span><span class="crayon-h">
</span><span class="crayon-cn">94</span><span class="crayon-h">
</span><span class="crayon-cn">95</span><span class="crayon-h">
</span><span class="crayon-cn">96</span><span class="crayon-h">
</span><span class="crayon-cn">97</span><span class="crayon-h">
</span><span class="crayon-cn">98</span><span class="crayon-h">
</span><span class="crayon-cn">99</span><span class="crayon-h">
</span><span class="crayon-cn">100</span><span class="crayon-h">
</span><span class="crayon-cn">101</span><span class="crayon-h">
</span><span class="crayon-cn">102</span><span class="crayon-h">
</span><span class="crayon-cn">103</span><span class="crayon-h">
</span><span class="crayon-cn">104</span><span class="crayon-h">
</span><span class="crayon-cn">105</span><span class="crayon-h">
</span><span class="crayon-cn">106</span><span class="crayon-h">
</span><span class="crayon-cn">107</span><span class="crayon-h">
</span><span class="crayon-cn">108</span><span class="crayon-h">
</span><span class="crayon-cn">109</span><span class="crayon-h">
</span><span class="crayon-cn">110</span><span class="crayon-h">
</span><span class="crayon-cn">111</span><span class="crayon-h">
</span><span class="crayon-cn">112</span>

<span class="crayon-h">  </span><span class="crayon-cn">241</span><span
class="crayon-h">            </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">1</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">1</span><span class="crayon-h">  </span><span
class="crayon-cn">1</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">2</span><span class="crayon-h">  </span><span
class="crayon-cn">1</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">1</span><span class="crayon-h">  </span><span
class="crayon-cn">1</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span>

<span class="crayon-h">  </span><span
class="crayon-i">brasil</span><span class="crayon-h">        
</span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">1</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">1</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">1</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">2</span><span
class="crayon-h">  </span><span class="crayon-cn">1</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">3</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span>

<span class="crayon-h">  </span><span
class="crayon-i">contra</span><span class="crayon-h">        
</span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">2</span><span
class="crayon-h">  </span><span class="crayon-cn">2</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">2</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">3</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">1</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">  </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">2</span><span
class="crayon-h">   </span><span class="crayon-cn">2</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span>

<span class="crayon-h">  </span><span class="crayon-i">dia</span><span
class="crayon-h">            </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">1</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">0</span><span class="crayon-h">  </span><span
class="crayon-cn">1</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span>

<span class="crayon-h">               </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span class="crayon-h">          
</span><span class="crayon-cn">113</span><span class="crayon-h">
</span><span class="crayon-cn">114</span><span class="crayon-h">
</span><span class="crayon-cn">115</span><span class="crayon-h">
</span><span class="crayon-cn">116</span><span class="crayon-h">
</span><span class="crayon-cn">117</span><span class="crayon-h">
</span><span class="crayon-cn">118</span><span class="crayon-h">
</span><span class="crayon-cn">119</span><span class="crayon-h">
</span><span class="crayon-cn">120</span><span class="crayon-h">
</span><span class="crayon-cn">121</span><span class="crayon-h">
</span><span class="crayon-cn">122</span><span class="crayon-h">
</span><span class="crayon-cn">123</span><span class="crayon-h">
</span><span class="crayon-cn">124</span><span class="crayon-h">
</span><span class="crayon-cn">125</span><span class="crayon-h">
</span><span class="crayon-cn">126</span><span class="crayon-h">
</span><span class="crayon-cn">127</span><span class="crayon-h">
</span><span class="crayon-cn">128</span><span class="crayon-h">
</span><span class="crayon-cn">129</span><span class="crayon-h">
</span><span class="crayon-cn">130</span><span class="crayon-h">
</span><span class="crayon-cn">131</span><span class="crayon-h">
</span><span class="crayon-cn">132</span><span class="crayon-h">
</span><span class="crayon-cn">133</span><span class="crayon-h">
</span><span class="crayon-cn">134</span><span class="crayon-h">
</span><span class="crayon-cn">135</span><span class="crayon-h">
</span><span class="crayon-cn">136</span><span class="crayon-h">
</span><span class="crayon-cn">137</span><span class="crayon-h">
</span><span class="crayon-cn">138</span><span class="crayon-h">
</span><span class="crayon-cn">139</span><span class="crayon-h">
</span><span class="crayon-cn">140</span>

<span class="crayon-h">  </span><span class="crayon-cn">241</span><span
class="crayon-h">             </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">2</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">2</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span><span class="crayon-h">   </span><span
class="crayon-cn">2</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span>

<span class="crayon-h">  </span><span
class="crayon-i">brasil</span><span
class="crayon-h">          </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span>

<span class="crayon-h">  </span><span
class="crayon-i">contra</span><span
class="crayon-h">          </span><span class="crayon-cn">2</span><span
class="crayon-h">   </span><span class="crayon-cn">4</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">3</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">2</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span>

<span class="crayon-h">  </span><span class="crayon-i">dia</span><span
class="crayon-h">             </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">2</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">2</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span>

<span class="crayon-h">               </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span class="crayon-h">          
</span><span class="crayon-cn">141</span><span class="crayon-h">
</span><span class="crayon-cn">142</span><span class="crayon-h">
</span><span class="crayon-cn">143</span><span class="crayon-h">
</span><span class="crayon-cn">144</span><span class="crayon-h">
</span><span class="crayon-cn">145</span><span class="crayon-h">
</span><span class="crayon-cn">146</span><span class="crayon-h">
</span><span class="crayon-cn">147</span><span class="crayon-h">
</span><span class="crayon-cn">148</span><span class="crayon-h">
</span><span class="crayon-cn">149</span><span class="crayon-h">
</span><span class="crayon-cn">150</span><span class="crayon-h">
</span><span class="crayon-cn">151</span><span class="crayon-h">
</span><span class="crayon-cn">152</span><span class="crayon-h">
</span><span class="crayon-cn">153</span><span class="crayon-h">
</span><span class="crayon-cn">154</span><span class="crayon-h">
</span><span class="crayon-cn">155</span><span class="crayon-h">
</span><span class="crayon-cn">156</span><span class="crayon-h">
</span><span class="crayon-cn">157</span><span class="crayon-h">
</span><span class="crayon-cn">158</span><span class="crayon-h">
</span><span class="crayon-cn">159</span><span class="crayon-h">
</span><span class="crayon-cn">160</span><span class="crayon-h">
</span><span class="crayon-cn">161</span><span class="crayon-h">
</span><span class="crayon-cn">162</span><span class="crayon-h">
</span><span class="crayon-cn">163</span><span class="crayon-h">
</span><span class="crayon-cn">164</span><span class="crayon-h">
</span><span class="crayon-cn">165</span><span class="crayon-h">
</span><span class="crayon-cn">166</span><span class="crayon-h">
</span><span class="crayon-cn">167</span><span class="crayon-h">
</span><span class="crayon-cn">168</span>

<span class="crayon-h">  </span><span class="crayon-cn">241</span><span
class="crayon-h">             </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">2</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span>

<span class="crayon-h">  </span><span
class="crayon-i">brasil</span><span
class="crayon-h">          </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">2</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span>

<span class="crayon-h">  </span><span
class="crayon-i">contra</span><span
class="crayon-h">          </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">2</span><span
class="crayon-h">   </span><span class="crayon-cn">2</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">3</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">2</span>

<span class="crayon-h">  </span><span class="crayon-i">dia</span><span
class="crayon-h">             </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">2</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">2</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">2</span>

<span class="crayon-h">               </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span class="crayon-h">          
</span><span class="crayon-cn">169</span><span class="crayon-h">
</span><span class="crayon-cn">170</span><span class="crayon-h">
</span><span class="crayon-cn">171</span><span class="crayon-h">
</span><span class="crayon-cn">172</span><span class="crayon-h">
</span><span class="crayon-cn">173</span><span class="crayon-h">
</span><span class="crayon-cn">174</span><span class="crayon-h">
</span><span class="crayon-cn">175</span><span class="crayon-h">
</span><span class="crayon-cn">176</span><span class="crayon-h">
</span><span class="crayon-cn">177</span><span class="crayon-h">
</span><span class="crayon-cn">178</span><span class="crayon-h">
</span><span class="crayon-cn">179</span><span class="crayon-h">
</span><span class="crayon-cn">180</span><span class="crayon-h">
</span><span class="crayon-cn">181</span><span class="crayon-h">
</span><span class="crayon-cn">182</span><span class="crayon-h">
</span><span class="crayon-cn">183</span><span class="crayon-h">
</span><span class="crayon-cn">184</span><span class="crayon-h">
</span><span class="crayon-cn">185</span><span class="crayon-h">
</span><span class="crayon-cn">186</span><span class="crayon-h">
</span><span class="crayon-cn">187</span><span class="crayon-h">
</span><span class="crayon-cn">188</span><span class="crayon-h">
</span><span class="crayon-cn">189</span><span class="crayon-h">
</span><span class="crayon-cn">190</span><span class="crayon-h">
</span><span class="crayon-cn">191</span><span class="crayon-h">
</span><span class="crayon-cn">192</span><span class="crayon-h">
</span><span class="crayon-cn">193</span><span class="crayon-h">
</span><span class="crayon-cn">194</span><span class="crayon-h">
</span><span class="crayon-cn">195</span><span class="crayon-h">
</span><span class="crayon-cn">196</span>

<span class="crayon-h">  </span><span class="crayon-cn">241</span><span
class="crayon-h">             </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">2</span><span class="crayon-h">   </span><span
class="crayon-cn">2</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span><span class="crayon-h">   </span><span
class="crayon-cn">2</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span><span class="crayon-h">   </span><span
class="crayon-cn">2</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span><span class="crayon-h">   </span><span
class="crayon-cn">2</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">2</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span><span class="crayon-h">   </span><span
class="crayon-cn">2</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span>

<span class="crayon-h">  </span><span
class="crayon-i">brasil</span><span
class="crayon-h">          </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">3</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">2</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span>

<span class="crayon-h">  </span><span
class="crayon-i">contra</span><span
class="crayon-h">          </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">2</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">2</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">3</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span>

<span class="crayon-h">  </span><span class="crayon-i">dia</span><span
class="crayon-h">             </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span>

<span class="crayon-h">               </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span class="crayon-h">          
</span><span class="crayon-cn">197</span><span class="crayon-h">
</span><span class="crayon-cn">198</span><span class="crayon-h">
</span><span class="crayon-cn">199</span><span class="crayon-h">
</span><span class="crayon-cn">200</span><span class="crayon-h">
</span><span class="crayon-cn">201</span><span class="crayon-h">
</span><span class="crayon-cn">202</span><span class="crayon-h">
</span><span class="crayon-cn">203</span><span class="crayon-h">
</span><span class="crayon-cn">204</span><span class="crayon-h">
</span><span class="crayon-cn">205</span><span class="crayon-h">
</span><span class="crayon-cn">206</span><span class="crayon-h">
</span><span class="crayon-cn">207</span><span class="crayon-h">
</span><span class="crayon-cn">208</span><span class="crayon-h">
</span><span class="crayon-cn">209</span><span class="crayon-h">
</span><span class="crayon-cn">210</span><span class="crayon-h">
</span><span class="crayon-cn">211</span><span class="crayon-h">
</span><span class="crayon-cn">212</span><span class="crayon-h">
</span><span class="crayon-cn">213</span><span class="crayon-h">
</span><span class="crayon-cn">214</span><span class="crayon-h">
</span><span class="crayon-cn">215</span><span class="crayon-h">
</span><span class="crayon-cn">216</span><span class="crayon-h">
</span><span class="crayon-cn">217</span><span class="crayon-h">
</span><span class="crayon-cn">218</span><span class="crayon-h">
</span><span class="crayon-cn">219</span><span class="crayon-h">
</span><span class="crayon-cn">220</span><span class="crayon-h">
</span><span class="crayon-cn">221</span><span class="crayon-h">
</span><span class="crayon-cn">222</span><span class="crayon-h">
</span><span class="crayon-cn">223</span><span class="crayon-h">
</span><span class="crayon-cn">224</span>

<span class="crayon-h">  </span><span class="crayon-cn">241</span><span
class="crayon-h">             </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">2</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">2</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span>

<span class="crayon-h">  </span><span
class="crayon-i">brasil</span><span
class="crayon-h">          </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span>

<span class="crayon-h">  </span><span
class="crayon-i">contra</span><span
class="crayon-h">          </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">2</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">2</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span>

<span class="crayon-h">  </span><span class="crayon-i">dia</span><span
class="crayon-h">             </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span>

<span class="crayon-h">               </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span class="crayon-h">          
</span><span class="crayon-cn">225</span><span class="crayon-h">
</span><span class="crayon-cn">226</span><span class="crayon-h">
</span><span class="crayon-cn">227</span><span class="crayon-h">
</span><span class="crayon-cn">228</span><span class="crayon-h">
</span><span class="crayon-cn">229</span><span class="crayon-h">
</span><span class="crayon-cn">230</span><span class="crayon-h">
</span><span class="crayon-cn">231</span><span class="crayon-h">
</span><span class="crayon-cn">232</span><span class="crayon-h">
</span><span class="crayon-cn">233</span><span class="crayon-h">
</span><span class="crayon-cn">234</span><span class="crayon-h">
</span><span class="crayon-cn">235</span><span class="crayon-h">
</span><span class="crayon-cn">236</span><span class="crayon-h">
</span><span class="crayon-cn">237</span><span class="crayon-h">
</span><span class="crayon-cn">238</span><span class="crayon-h">
</span><span class="crayon-cn">239</span><span class="crayon-h">
</span><span class="crayon-cn">240</span><span class="crayon-h">
</span><span class="crayon-cn">241</span><span class="crayon-h">
</span><span class="crayon-cn">242</span><span class="crayon-h">
</span><span class="crayon-cn">243</span><span class="crayon-h">
</span><span class="crayon-cn">244</span>

<span class="crayon-h">  </span><span class="crayon-cn">241</span><span
class="crayon-h">             </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span>

<span class="crayon-h">  </span><span
class="crayon-i">brasil</span><span
class="crayon-h">          </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span>

<span class="crayon-h">  </span><span
class="crayon-i">contra</span><span
class="crayon-h">          </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">1</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">2</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span><span
class="crayon-h">   </span><span class="crayon-cn">0</span>

<span class="crayon-h">  </span><span class="crayon-i">dia</span><span
class="crayon-h">             </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">1</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span><span class="crayon-h">   </span><span
class="crayon-cn">0</span>

<span class="crayon-h"> </span><span class="crayon-sy">\[</span><span
class="crayon-h"> </span><span class="crayon-e">reached </span><span
class="crayon-e">getOption</span><span class="crayon-sy">(</span><span
class="crayon-s">"max.print"</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">--</span><span
class="crayon-h"> </span><span class="crayon-i">omitted</span><span
class="crayon-h"> </span><span class="crayon-cn">32</span><span
class="crayon-h"> </span><span class="crayon-i">rows</span><span
class="crayon-h"> </span><span class="crayon-sy">\]</span>

</td>
</tr>
</table>

<p>
</p>
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
dim(df)
</textarea>

<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
1

</td>
<td class="crayon-code">
<span class="crayon-e">dim</span><span class="crayon-sy">(</span><span
class="crayon-v">df</span><span class="crayon-sy">)</span>

</td>
</tr>
</table>

<p>
</p>
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
\[1\] 36 244
</textarea>

<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
1

</td>
<td class="crayon-code">
<span class="crayon-sy">\[</span><span
class="crayon-cn">1</span><span class="crayon-sy">\]</span><span
class="crayon-h">  </span><span class="crayon-cn">36</span><span
class="crayon-h"> </span><span class="crayon-cn">244</span>

</td>
</tr>
</table>

<p>
</p>
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
df.scale &lt;- scale(df) d &lt;- dist(df.scale, method = "euclidean")
fit.ward2 &lt;- hclust(d, method = "ward.D2") plot(fit.ward2,
main="Clusterização Hierárquica- UNE", xlab = "De 17/09/2016 a
17/11/2016") rect.hclust(fit.ward2, k=7)
</textarea>

<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
1

2

3

4

5

</td>
<td class="crayon-code">
<span class="crayon-v">df</span><span class="crayon-sy">.</span><span
class="crayon-v">scale</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-e">scale</span><span
class="crayon-sy">(</span><span class="crayon-v">df</span><span
class="crayon-sy">)</span>

<span class="crayon-v">d</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-e">dist</span><span
class="crayon-sy">(</span><span class="crayon-v">df</span><span
class="crayon-sy">.</span><span class="crayon-v">scale</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">method</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"euclidean"</span><span class="crayon-sy">)</span>

<span class="crayon-v">fit</span><span class="crayon-sy">.</span><span
class="crayon-v">ward2</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-e">hclust</span><span
class="crayon-sy">(</span><span class="crayon-v">d</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">method</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"ward.D2"</span><span class="crayon-sy">)</span>

<span class="crayon-e">plot</span><span class="crayon-sy">(</span><span
class="crayon-v">fit</span><span class="crayon-sy">.</span><span
class="crayon-v">ward2</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">main</span><span
class="crayon-o">=</span><span class="crayon-s">"Clusterização
Hierárquica- UNE"</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">xlab</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-s">"De 17/09/2016 a
17/11/2016"</span><span class="crayon-sy">)</span>

<span class="crayon-v">rect</span><span class="crayon-sy">.</span><span
class="crayon-e">hclust</span><span class="crayon-sy">(</span><span
class="crayon-v">fit</span><span class="crayon-sy">.</span><span
class="crayon-v">ward2</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">k</span><span
class="crayon-o">=</span><span class="crayon-cn">7</span><span
class="crayon-sy">)</span>

</td>
</tr>
</table>

<p>
<a href="http://ibpad.com.br/wp-content/uploads/2016/11/facebook-une2.png"><img class="aligncenter size-full wp-image-1793" src="https://ibpad.com.br/wp-content/uploads/2016/11/facebook-une2.png" alt="facebook-une2" width="650" height="401"></a>
</p>
<p>
O vocábulo mais citado nas postagens da UNE foi a palavra
<strong>campus</strong>. A UNE tem se preocupado em atualizar os
leitores sobre quantas e quais são as universidades ocupadas no Brasil.
Por se tratar disso, a palavra foi retirada de nosso <em>Corpus</em> de
análise para que possamos identificar outros assuntos relevantes. O
momento das ocupações estudantis nas escolas e universidades acontece em
oposição à
<a href="https://www25.senado.leg.br/web/atividade/materias/-/materia/127337" target="_blank">PEC
55</a> e à
<a href="https://www.planalto.gov.br/ccivil_03/_Ato2015-2018/2016/Mpv/mpv746.htm" target="_blank">MP
do ensino médio</a>. As palavras <strong>contra, pec</strong> e
<strong>241</strong> formando um <em>cluster</em> reforçam a ideia de
oposição à PEC 55 e à MP do ensino médio. O grande <em>cluster</em>
posicionado no meio da figura tem palavras como <strong>reforma, ensino,
médio, luta, ocupações, resistência</strong> reforçando ainda o mesmo
assunto.
</p>
<p>
Usaremos agora uma matriz <em>termos X documentos</em> para elaborar uma
rede semântica.
</p>
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
matriz &lt;- as.matrix(df) g = graph\_from\_incidence\_matrix(matriz) p
= bipartite\_projection(g, which = "FALSE")
V(p)$shape = "none" deg = degree(p) plot(p, vertex.label.cex=deg/35, edge.width=(E(p)$weight)/10,
edge.color=adjustcolor("grey60", .5),
vertex.label.color=adjustcolor("\#005d26", .7), main = "Facebook - UNE",
xlab = "De 17/09/2016 a 17/11/2016")
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

</td>
<td class="crayon-code">
<span class="crayon-v">matriz</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-st">as</span><span
class="crayon-sy">.</span><span class="crayon-e">matrix</span><span
class="crayon-sy">(</span><span class="crayon-v">df</span><span
class="crayon-sy">)</span>

<span class="crayon-v">g</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-e">graph\_from\_incidence\_matrix</span><span
class="crayon-sy">(</span><span class="crayon-v">matriz</span><span
class="crayon-sy">)</span>

<span class="crayon-v">p</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-e">bipartite\_projection</span><span
class="crayon-sy">(</span><span class="crayon-v">g</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">which</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"FALSE"</span><span class="crayon-sy">)</span>

<span class="crayon-e">V</span><span class="crayon-sy">(</span><span
class="crayon-v">p</span><span class="crayon-sy">)</span><span
class="crayon-sy">$&lt;/span&gt;&lt;span class="crayon-v"&gt;shape&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;=&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-s"&gt;"none"&lt;/span&gt; &lt;/div&gt; &lt;div class="crayon-line" id="crayon-5a5818d00ba6e628169979-5"&gt; &lt;span class="crayon-v"&gt;deg&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;=&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-e"&gt;degree&lt;/span&gt;&lt;span class="crayon-sy"&gt;(&lt;/span&gt;&lt;span class="crayon-v"&gt;p&lt;/span&gt;&lt;span class="crayon-sy"&gt;)&lt;/span&gt; &lt;/div&gt; &lt;div class="crayon-line crayon-striped-line" id="crayon-5a5818d00ba6e628169979-6"&gt; &lt;span class="crayon-e"&gt;plot&lt;/span&gt;&lt;span class="crayon-sy"&gt;(&lt;/span&gt;&lt;span class="crayon-v"&gt;p&lt;/span&gt;&lt;span class="crayon-sy"&gt;,&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-v"&gt;vertex&lt;/span&gt;&lt;span class="crayon-sy"&gt;.&lt;/span&gt;&lt;span class="crayon-v"&gt;label&lt;/span&gt;&lt;span class="crayon-sy"&gt;.&lt;/span&gt;&lt;span class="crayon-v"&gt;cex&lt;/span&gt;&lt;span class="crayon-o"&gt;=&lt;/span&gt;&lt;span class="crayon-v"&gt;deg&lt;/span&gt;&lt;span class="crayon-o"&gt;/&lt;/span&gt;&lt;span class="crayon-cn"&gt;35&lt;/span&gt;&lt;span class="crayon-sy"&gt;,&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-v"&gt;edge&lt;/span&gt;&lt;span class="crayon-sy"&gt;.&lt;/span&gt;&lt;span class="crayon-v"&gt;width&lt;/span&gt;&lt;span class="crayon-o"&gt;=&lt;/span&gt;&lt;span class="crayon-sy"&gt;(&lt;/span&gt;&lt;span class="crayon-e"&gt;E&lt;/span&gt;&lt;span class="crayon-sy"&gt;(&lt;/span&gt;&lt;span class="crayon-v"&gt;p&lt;/span&gt;&lt;span class="crayon-sy"&gt;)&lt;/span&gt;&lt;span class="crayon-sy"&gt;$</span><span
class="crayon-v">weight</span><span class="crayon-sy">)</span><span
class="crayon-o">/</span><span class="crayon-cn">10</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span>

<span class="crayon-h">     </span><span
class="crayon-v">edge</span><span class="crayon-sy">.</span><span
class="crayon-v">color</span><span class="crayon-o">=</span><span
class="crayon-e">adjustcolor</span><span class="crayon-sy">(</span><span
class="crayon-s">"grey60"</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-sy">.</span><span
class="crayon-cn">5</span><span class="crayon-sy">)</span><span
class="crayon-sy">,</span>

<span class="crayon-h">     </span><span
class="crayon-v">vertex</span><span class="crayon-sy">.</span><span
class="crayon-v">label</span><span class="crayon-sy">.</span><span
class="crayon-v">color</span><span class="crayon-o">=</span><span
class="crayon-e">adjustcolor</span><span class="crayon-sy">(</span><span
class="crayon-s">"\#005d26"</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-sy">.</span><span
class="crayon-cn">7</span><span class="crayon-sy">)</span><span
class="crayon-sy">,</span>

<span class="crayon-h">     </span><span
class="crayon-v">main</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"Facebook - UNE"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">xlab</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"De 17/09/2016 a 17/11/2016"</span><span
class="crayon-sy">)</span>

</td>
</tr>
</table>

<p>
<a href="http://ibpad.com.br/wp-content/uploads/2016/11/facebook-une3.png"><img class="aligncenter size-full wp-image-1794" src="https://ibpad.com.br/wp-content/uploads/2016/11/facebook-une3.png" alt="facebook-une3" width="650" height="401"></a>
</p>
<p>
Como podemos ver, a rede reforça os resultados da clusterização
hierárquica mostrando um grande assunto sendo desenvolvido nas postagens
da UNE. Não há diversificação mas todas as palavras formam um componente
gigante conectado.
</p>
<div id="comentarios" class="section level3">
<h3>
Comentários
</h3>
<p>
Vamos olhar agora para os comentários na página da UNE. Seguiremos as
mesmas estratégias analíticas, inclusive a exclusão da palavra
<strong>campus</strong>.
</p>
<div id="crayon-5a5818d00ba70156901503" class="crayon-syntax crayon-theme-classic crayon-font-monaco crayon-os-pc print-yes notranslate" data-settings=" minimize scroll-mouseover" style=" margin-top: 12px; margin-bottom: 12px; font-size: 12px !important; line-height: 15px !important;">
<span class="crayon-title"></span>

<div class="crayon-plain-wrap">
<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
comments\_une =
UNE*c**o**m**m**e**n**t*<sub>*m*</sub>*e**s**s**a**g**e*</span><span
class="crayon-v">comment\_message</span><span class="crayon-h">
</span><span class="crayon-o">%</span><span
class="crayon-o">&gt;</span><span class="crayon-o">%</span><span
class="crayon-h"> </span><span class="crayon-e">unique</span>
</div>
<span class="crayon-v">unec</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-e">Corpus</span><span class="crayon-sy">(</span><span
class="crayon-e">VectorSource</span><span
class="crayon-sy">(</span><span
class="crayon-v">comments\_une</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span>

<span class="crayon-v">unec</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-e">tm\_map</span><span
class="crayon-sy">(</span><span class="crayon-v">unec</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-e">content\_transformer</span><span
class="crayon-sy">(</span><span class="crayon-v">tolower</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span>

<span class="crayon-v">unec</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-e">tm\_map</span><span
class="crayon-sy">(</span><span class="crayon-v">unec</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">removePunctuation</span><span
class="crayon-sy">)</span>

<span class="crayon-v">unec</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-e">tm\_map</span><span
class="crayon-sy">(</span><span class="crayon-v">unec</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-t">function</span><span class="crayon-sy">(</span><span
class="crayon-v">x</span><span class="crayon-sy">)</span><span
class="crayon-e">removeWords</span><span class="crayon-sy">(</span><span
class="crayon-v">x</span><span class="crayon-sy">,</span><span
class="crayon-e">stopwords</span><span class="crayon-sy">(</span><span
class="crayon-s">"pt"</span><span class="crayon-sy">)</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span>

<span class="crayon-v">unec</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-e">tm\_map</span><span
class="crayon-sy">(</span><span class="crayon-v">unec</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-t">function</span><span class="crayon-sy">(</span><span
class="crayon-v">x</span><span class="crayon-sy">)</span><span
class="crayon-e">removeWords</span><span class="crayon-sy">(</span><span
class="crayon-v">x</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-s">'campus'</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span>

<span class="crayon-v">pal</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">brewer</span><span class="crayon-sy">.</span><span
class="crayon-e">pal</span><span class="crayon-sy">(</span><span
class="crayon-cn">5</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-s">"Set2"</span><span
class="crayon-sy">)</span>

<span class="crayon-p">\# Nuvem de palavras</span>

<span class="crayon-e">wordcloud</span><span
class="crayon-sy">(</span><span class="crayon-v">unec</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">min</span><span class="crayon-sy">.</span><span
class="crayon-v">freq</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-cn">3</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">max</span><span
class="crayon-sy">.</span><span class="crayon-v">words</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-cn">100</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">random</span><span class="crayon-sy">.</span><span
class="crayon-v">order</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">F</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">colors</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-v">pal</span><span
class="crayon-sy">)</span>

<span class="crayon-e">title</span><span class="crayon-sy">(</span><span
class="crayon-v">xlab</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"Facebook - UNE - Comments17/09/2016 a
17/11/2016"</span><span class="crayon-sy">)</span>

</div>
</td>
</tr>
</table>
</div>
</div>
<p>
<a href="http://ibpad.com.br/wp-content/uploads/2016/11/facebook-une4.png"><img class="aligncenter size-full wp-image-1795" src="https://ibpad.com.br/wp-content/uploads/2016/11/facebook-une4.png" alt="facebook-une4" width="650" height="401"></a>
</p>
<p>
As principais palavras encontradas na nuvem de palavras são bastante
parecidas com aquelas das postagens. Vamos investigar o fluxo de
comentários no tempo.
</p>
<div id="crayon-5a5818d00ba72024380609" class="crayon-syntax crayon-theme-classic crayon-font-monaco crayon-os-pc print-yes notranslate" data-settings=" minimize scroll-mouseover" style=" margin-top: 12px; margin-bottom: 12px; font-size: 12px !important; line-height: 15px !important;">
<span class="crayon-title"></span>

<div class="crayon-plain-wrap">
<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
UNE*c**o**m**m**e**n**t*<sub>*d*</sub>*a**t**e* = *y**m**d*<sub>*h*</sub>*m**s*(*U**N**E*comment\_published)
UNE*c**o**m**m**e**n**t*<sub>*d*</sub>*a**t**e* = *r**o**u**n**d*<sub>*d*</sub>*a**t**e*(*U**N**E*comment\_date,
'day') datas =
as.data.frame(table(UNE*c**o**m**m**e**n**t*<sub>*d*</sub>*a**t**e*),*s**t**r**i**n**g**s**A**s**F**a**c**t**o**r**s* = *F*)*d**a**t**a**s*Var1
=
as.Date(datas*V**a**r*1)*l**i**m**i**t**s* = *y**m**d*(*c*(20160916, 20161118))</span><span
class="crayon-v">comment\_date</span><span class="crayon-h">
</span><span class="crayon-o">=</span><span class="crayon-h">
</span><span class="crayon-e">ymd\_hms</span><span
class="crayon-sy">(</span><span class="crayon-v">UNE</span><span
class="crayon-sy">$&lt;/span&gt;&lt;span class="crayon-v"&gt;comment\_published&lt;/span&gt;&lt;span class="crayon-sy"&gt;)&lt;/span&gt; &lt;/div&gt; &lt;div class="crayon-line crayon-striped-line" id="crayon-5a5818d00ba72024380609-2"&gt; &lt;span class="crayon-v"&gt;UNE&lt;/span&gt;&lt;span class="crayon-sy"&gt;$</span><span
class="crayon-v">comment\_date</span><span class="crayon-h">
</span><span class="crayon-o">=</span><span class="crayon-h">
</span><span class="crayon-e">round\_date</span><span
class="crayon-sy">(</span><span class="crayon-v">UNE</span><span
class="crayon-sy">$&lt;/span&gt;&lt;span class="crayon-v"&gt;comment\_date&lt;/span&gt;&lt;span class="crayon-sy"&gt;,&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-s"&gt;'day'&lt;/span&gt;&lt;span class="crayon-sy"&gt;)&lt;/span&gt; &lt;/div&gt; &lt;div class="crayon-line" id="crayon-5a5818d00ba72024380609-3"&gt; &lt;span class="crayon-v"&gt;datas&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;=&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-st"&gt;as&lt;/span&gt;&lt;span class="crayon-sy"&gt;.&lt;/span&gt;&lt;span class="crayon-v"&gt;data&lt;/span&gt;&lt;span class="crayon-sy"&gt;.&lt;/span&gt;&lt;span class="crayon-e"&gt;frame&lt;/span&gt;&lt;span class="crayon-sy"&gt;(&lt;/span&gt;&lt;span class="crayon-e"&gt;table&lt;/span&gt;&lt;span class="crayon-sy"&gt;(&lt;/span&gt;&lt;span class="crayon-v"&gt;UNE&lt;/span&gt;&lt;span class="crayon-sy"&gt;$</span><span
class="crayon-v">comment\_date</span><span
class="crayon-sy">)</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span
class="crayon-v">stringsAsFactors</span><span class="crayon-h">
</span><span class="crayon-o">=</span><span class="crayon-h">
</span><span class="crayon-v">F</span><span class="crayon-sy">)</span>
</div>
<span class="crayon-v">datas</span><span
class="crayon-sy">$&lt;/span&gt;&lt;span class="crayon-v"&gt;Var1&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;=&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-st"&gt;as&lt;/span&gt;&lt;span class="crayon-sy"&gt;.&lt;/span&gt;&lt;span class="crayon-e"&gt;Date&lt;/span&gt;&lt;span class="crayon-sy"&gt;(&lt;/span&gt;&lt;span class="crayon-v"&gt;datas&lt;/span&gt;&lt;span class="crayon-sy"&gt;$</span><span
class="crayon-v">Var1</span><span class="crayon-sy">)</span>

<span class="crayon-v">limits</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-e">ymd</span><span class="crayon-sy">(</span><span
class="crayon-e">c</span><span class="crayon-sy">(</span><span
class="crayon-cn">20160916</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-cn">20161118</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">%</span><span
class="crayon-o">&gt;</span><span class="crayon-o">%</span><span
class="crayon-h"> </span><span class="crayon-st">as</span><span
class="crayon-sy">.</span><span class="crayon-e">Date</span>

<span class="crayon-e">ggplot</span><span
class="crayon-sy">(</span><span class="crayon-v">datas</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-e">aes</span><span class="crayon-sy">(</span><span
class="crayon-v">x</span><span class="crayon-o">=</span><span
class="crayon-v">Var1</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">y</span><span
class="crayon-o">=</span><span class="crayon-v">Freq</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span><span
class="crayon-o">+</span><span class="crayon-e">geom\_line</span><span
class="crayon-sy">(</span><span class="crayon-sy">)</span><span
class="crayon-o">+</span><span
class="crayon-e">scale\_x\_date</span><span
class="crayon-sy">(</span><span
class="crayon-v">date\_minor\_breaks</span><span class="crayon-h">
</span><span class="crayon-o">=</span><span class="crayon-h">
</span><span class="crayon-s">'1 day'</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">date\_breaks</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">'1 week'</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">date\_labels</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-s">'%d-%m'</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">limits</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">limits</span><span class="crayon-sy">)</span><span
class="crayon-o">+</span>

<span class="crayon-h">  </span><span class="crayon-e">labs</span><span
class="crayon-sy">(</span><span class="crayon-v">x</span><span
class="crayon-o">=</span><span class="crayon-s">'UNE'</span><span
class="crayon-sy">,</span><span class="crayon-v">y</span><span
class="crayon-o">=</span><span class="crayon-s">'Número de
Comentários'</span><span class="crayon-sy">)</span>

</div>
</td>
</tr>
</table>
</div>
</div>
<p>
<a href="http://ibpad.com.br/wp-content/uploads/2016/11/facebook-une5.png"><img class="aligncenter size-full wp-image-1796" src="https://ibpad.com.br/wp-content/uploads/2016/11/facebook-une5.png" alt="facebook-une5" width="650" height="401"></a>
</p>
<p>
O gráfico apresenta três picos de comentários nos dias 12/10, 26/10 e
15/11. Após uma rápida consulta ao Google, não parece haver nenhum
motivo especial para esses picos para além dos feriados.
</p>
<h2>
MBL
</h2>
<p>
A análise da página do MBL (Movimento Brasil Livre) foi um pouco mais
difícil. Trata-se de uma página muito mais movimentada do que a página
da UNE. No período selecionado (17/09 a 17/11), o
<em>Netvizz</em> identificou 2248 posts. Para viabilizar a análise,
foram coletados apenas os 200 comentários mais relevantes.
</p>
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
MBL = read\_tsv('/home/neylson/Documentos/Neylson
Crepalde/Doutorado/UNE\_MBL/MBL/page\_204223673035117\_2016\_11\_18\_14\_11\_51\_topcomments.tab')
</textarea>

<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
1

</td>
<td class="crayon-code">
<span class="crayon-v">MBL</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-e">read\_tsv</span><span class="crayon-sy">(</span><span
class="crayon-s">'/home/neylson/Documentos/Neylson
Crepalde/Doutorado/UNE\_MBL/MBL/page\_204223673035117\_2016\_11\_18\_14\_11\_51\_topcomments.tab'</span><span
class="crayon-sy">)</span>

</td>
</tr>
</table>

<p>
</p>
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
|== | 2% 3 MB |=== | 3% 4 MB |==== | 5% 6 MB |==== | 6% 7 MB |===== | 6%
7 MB |====== | 7% 9 MB |======= | 8% 10 MB |======== | 10% 12 MB
|========= | 11% 13 MB |========= | 12% 14 MB |========== | 13% 15 MB
|=========== | 14% 17 MB |============ | 15% 18 MB |============= | 16%
19 MB |============== | 17% 21 MB |=============== | 18% 22 MB
|================ | 20% 24 MB |================= | 21% 25 MB
|================== | 22% 27 MB |================== | 23% 28 MB
|==================== | 25% 30 MB |==================== | 25% 31 MB
|===================== | 26% 32 MB |====================== | 27% 33 MB
|====================== | 28% 33 MB |======================= | 29% 34 MB
|======================== | 30% 36 MB |======================== | 31% 37
MB |========================== | 32% 39 MB |===========================
| 33% 40 MB |=========================== | 34% 41 MB
|============================ | 35% 42 MB |=============================
| 37% 44 MB |============================== | 38% 46 MB
|=============================== | 39% 47 MB
|================================ | 40% 48 MB
|================================ | 41% 49 MB
|================================= | 42% 50 MB
|================================== | 43% 52 MB
|=================================== | 44% 53 MB
|==================================== | 45% 54 MB
|===================================== | 46% 56 MB
|===================================== | 47% 57 MB
|====================================== | 47% 57 MB
|====================================== | 48% 58 MB
|======================================= | 49% 59 MB
|======================================== | 50% 60 MB
|========================================= | 51% 62 MB
|========================================= | 52% 62 MB
|========================================== | 53% 63 MB
|=========================================== | 54% 65 MB
|============================================ | 55% 66 MB
|============================================ | 55% 67 MB
|============================================= | 57% 68 MB
|============================================== | 58% 70 MB
|=============================================== | 59% 71 MB
|================================================ | 60% 72 MB
|================================================= | 61% 74 MB
|================================================== | 62% 75 MB
|================================================== | 63% 76 MB
|=================================================== | 64% 77 MB
|==================================================== | 65% 78 MB
|===================================================== | 66% 79 MB
|====================================================== | 67% 81 MB
|====================================================== | 68% 82 MB
|======================================================= | 69% 83 MB
|======================================================== | 70% 84 MB
|======================================================== | 70% 85 MB
|========================================================= | 71% 85 MB
|========================================================== | 72% 87 MB
|=========================================================== | 74% 89 MB
|=========================================================== | 74% 90 MB
|============================================================ | 75% 91
MB |============================================================ | 76%
91 MB |============================================================= |
76% 92 MB |=============================================================
| 77% 92 MB
|============================================================== | 78% 93
MB |=============================================================== |
78% 94 MB
|=============================================================== | 79%
95 MB |================================================================
| 80% 97 MB
|================================================================= | 81%
98 MB
|================================================================== |
82% 99 MB
|================================================================== |
83% 100 MB
|=================================================================== |
84% 101 MB
|==================================================================== |
85% 102 MB
|==================================================================== |
85% 103 MB
|===================================================================== |
87% 104 MB
|======================================================================
| 88% 106 MB
|=======================================================================
| 89% 107 MB
|========================================================================
| 90% 108 MB
|========================================================================
| 90% 108 MB
|========================================================================
| 91% 109 MB
|==========================================================================
| 92% 111 MB
|==========================================================================
| 93% 112 MB
|===========================================================================
| 93% 112 MB
|===========================================================================
| 94% 113 MB
|============================================================================
| 95% 114 MB
|=============================================================================
| 96% 115 MB
|=============================================================================
| 97% 117 MB
|==============================================================================
| 98% 117 MB
|===============================================================================|
98% 118 MB
|===============================================================================|
99% 119 MB
|================================================================================|
100% 120 MB
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

50

51

52

53

54

55

56

57

58

59

60

61

62

63

64

65

66

67

68

69

70

71

72

73

74

75

76

77

78

79

80

81

82

83

84

85

86

87

88

89

90

91

92

93

94

95

96

97

98

99

100

101

102

103

</td>
<td class="crayon-code">
<span class="crayon-o">|=</span><span class="crayon-o">=</span><span
class="crayon-h">                                                                            
</span><span class="crayon-o">|</span><span class="crayon-h">  
</span><span class="crayon-cn">2</span><span
class="crayon-o">%</span><span class="crayon-h">    </span><span
class="crayon-cn">3</span><span class="crayon-h"> </span><span
class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">==</span><span
class="crayon-h">                                                                            </span><span
class="crayon-o">|</span><span class="crayon-h">   </span><span
class="crayon-cn">3</span><span class="crayon-o">%</span><span
class="crayon-h">    </span><span class="crayon-cn">4</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-h">                                                                          
</span><span class="crayon-o">|</span><span class="crayon-h">  
</span><span class="crayon-cn">5</span><span
class="crayon-o">%</span><span class="crayon-h">    </span><span
class="crayon-cn">6</span><span class="crayon-h"> </span><span
class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-h">                                                                          
</span><span class="crayon-o">|</span><span class="crayon-h">  
</span><span class="crayon-cn">6</span><span
class="crayon-o">%</span><span class="crayon-h">    </span><span
class="crayon-cn">7</span><span class="crayon-h"> </span><span
class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">=</span><span
class="crayon-h">                                                                          </span><span
class="crayon-o">|</span><span class="crayon-h">   </span><span
class="crayon-cn">6</span><span class="crayon-o">%</span><span
class="crayon-h">    </span><span class="crayon-cn">7</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">==</span><span
class="crayon-h">                                                                        
</span><span class="crayon-o">|</span><span class="crayon-h">  
</span><span class="crayon-cn">7</span><span
class="crayon-o">%</span><span class="crayon-h">    </span><span
class="crayon-cn">9</span><span class="crayon-h"> </span><span
class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span
class="crayon-h">                                                                        </span><span
class="crayon-o">|</span><span class="crayon-h">   </span><span
class="crayon-cn">8</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">10</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">=</span><span
class="crayon-h">                                                                      
</span><span class="crayon-o">|</span><span
class="crayon-h">  </span><span class="crayon-cn">10</span><span
class="crayon-o">%</span><span class="crayon-h">   </span><span
class="crayon-cn">12</span><span class="crayon-h"> </span><span
class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">==</span><span
class="crayon-h">                                                                      </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">11</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">13</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">==</span><span
class="crayon-h">                                                                      </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">12</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">14</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-h">                                                                    
</span><span class="crayon-o">|</span><span
class="crayon-h">  </span><span class="crayon-cn">13</span><span
class="crayon-o">%</span><span class="crayon-h">   </span><span
class="crayon-cn">15</span><span class="crayon-h"> </span><span
class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">=</span><span
class="crayon-h">                                                                    </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">14</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">17</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">==</span><span
class="crayon-h">                                                                  
</span><span class="crayon-o">|</span><span
class="crayon-h">  </span><span class="crayon-cn">15</span><span
class="crayon-o">%</span><span class="crayon-h">   </span><span
class="crayon-cn">18</span><span class="crayon-h"> </span><span
class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span
class="crayon-h">                                                                  </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">16</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">19</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">=</span><span
class="crayon-h">                                                                
</span><span class="crayon-o">|</span><span
class="crayon-h">  </span><span class="crayon-cn">17</span><span
class="crayon-o">%</span><span class="crayon-h">   </span><span
class="crayon-cn">21</span><span class="crayon-h"> </span><span
class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">==</span><span
class="crayon-h">                                                                </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">18</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">22</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-h">                                                              
</span><span class="crayon-o">|</span><span
class="crayon-h">  </span><span class="crayon-cn">20</span><span
class="crayon-o">%</span><span class="crayon-h">   </span><span
class="crayon-cn">24</span><span class="crayon-h"> </span><span
class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">=</span><span
class="crayon-h">                                                              </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">21</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">25</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">==</span><span
class="crayon-h">                                                            
</span><span class="crayon-o">|</span><span
class="crayon-h">  </span><span class="crayon-cn">22</span><span
class="crayon-o">%</span><span class="crayon-h">   </span><span
class="crayon-cn">27</span><span class="crayon-h"> </span><span
class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">==</span><span
class="crayon-h">                                                            
</span><span class="crayon-o">|</span><span
class="crayon-h">  </span><span class="crayon-cn">23</span><span
class="crayon-o">%</span><span class="crayon-h">   </span><span
class="crayon-cn">28</span><span class="crayon-h"> </span><span
class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">=</span><span
class="crayon-h">                                                          
</span><span class="crayon-o">|</span><span
class="crayon-h">  </span><span class="crayon-cn">25</span><span
class="crayon-o">%</span><span class="crayon-h">   </span><span
class="crayon-cn">30</span><span class="crayon-h"> </span><span
class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">=</span><span
class="crayon-h">                                                          
</span><span class="crayon-o">|</span><span
class="crayon-h">  </span><span class="crayon-cn">25</span><span
class="crayon-o">%</span><span class="crayon-h">   </span><span
class="crayon-cn">31</span><span class="crayon-h"> </span><span
class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">==</span><span
class="crayon-h">                                                          </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">26</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">32</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-h">                                                        
</span><span class="crayon-o">|</span><span
class="crayon-h">  </span><span class="crayon-cn">27</span><span
class="crayon-o">%</span><span class="crayon-h">   </span><span
class="crayon-cn">33</span><span class="crayon-h"> </span><span
class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-h">                                                        
</span><span class="crayon-o">|</span><span
class="crayon-h">  </span><span class="crayon-cn">28</span><span
class="crayon-o">%</span><span class="crayon-h">   </span><span
class="crayon-cn">33</span><span class="crayon-h"> </span><span
class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">=</span><span
class="crayon-h">                                                        </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">29</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">34</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">==</span><span
class="crayon-h">                                                      
</span><span class="crayon-o">|</span><span
class="crayon-h">  </span><span class="crayon-cn">30</span><span
class="crayon-o">%</span><span class="crayon-h">   </span><span
class="crayon-cn">36</span><span class="crayon-h"> </span><span
class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">==</span><span
class="crayon-h">                                                      
</span><span class="crayon-o">|</span><span
class="crayon-h">  </span><span class="crayon-cn">31</span><span
class="crayon-o">%</span><span class="crayon-h">   </span><span
class="crayon-cn">37</span><span class="crayon-h"> </span><span
class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">=</span><span
class="crayon-h">                                                    
</span><span class="crayon-o">|</span><span
class="crayon-h">  </span><span class="crayon-cn">32</span><span
class="crayon-o">%</span><span class="crayon-h">   </span><span
class="crayon-cn">39</span><span class="crayon-h"> </span><span
class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">==</span><span
class="crayon-h">                                                    </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">33</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">40</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">==</span><span
class="crayon-h">                                                    </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">34</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">41</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-h">                                                  
</span><span class="crayon-o">|</span><span
class="crayon-h">  </span><span class="crayon-cn">35</span><span
class="crayon-o">%</span><span class="crayon-h">   </span><span
class="crayon-cn">42</span><span class="crayon-h"> </span><span
class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">=</span><span
class="crayon-h">                                                  </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">37</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">44</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">==</span><span
class="crayon-h">                                                
</span><span class="crayon-o">|</span><span
class="crayon-h">  </span><span class="crayon-cn">38</span><span
class="crayon-o">%</span><span class="crayon-h">   </span><span
class="crayon-cn">46</span><span class="crayon-h"> </span><span
class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span
class="crayon-h">                                                </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">39</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">47</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">=</span><span
class="crayon-h">                                              
</span><span class="crayon-o">|</span><span
class="crayon-h">  </span><span class="crayon-cn">40</span><span
class="crayon-o">%</span><span class="crayon-h">   </span><span
class="crayon-cn">48</span><span class="crayon-h"> </span><span
class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">=</span><span
class="crayon-h">                                              
</span><span class="crayon-o">|</span><span
class="crayon-h">  </span><span class="crayon-cn">41</span><span
class="crayon-o">%</span><span class="crayon-h">   </span><span
class="crayon-cn">49</span><span class="crayon-h"> </span><span
class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">==</span><span
class="crayon-h">                                              </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">42</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">50</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-h">                                            
</span><span class="crayon-o">|</span><span
class="crayon-h">  </span><span class="crayon-cn">43</span><span
class="crayon-o">%</span><span class="crayon-h">   </span><span
class="crayon-cn">52</span><span class="crayon-h"> </span><span
class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">=</span><span
class="crayon-h">                                            </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">44</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">53</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">==</span><span
class="crayon-h">                                           </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">45</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">54</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span
class="crayon-h">                                          </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">46</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">56</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span
class="crayon-h">                                          </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">47</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">57</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">=</span><span
class="crayon-h">                                         </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">47</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">57</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">=</span><span
class="crayon-h">                                         </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">48</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">58</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">==</span><span
class="crayon-h">                                        </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">49</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">59</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-h">                                       </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">50</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">60</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">=</span><span
class="crayon-h">                                      </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">51</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">62</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">=</span><span
class="crayon-h">                                      </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">52</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">62</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">==</span><span
class="crayon-h">                                     </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">53</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">63</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span
class="crayon-h">                                    </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">54</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">65</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">=</span><span
class="crayon-h">                                   </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">55</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">66</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">=</span><span
class="crayon-h">                                   </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">55</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">67</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">==</span><span
class="crayon-h">                                  </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">57</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">68</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-h">                                 </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">58</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">70</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">=</span><span
class="crayon-h">                                </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">59</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">71</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">==</span><span
class="crayon-h">                               </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">60</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">72</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span
class="crayon-h">                              </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">61</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">74</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">=</span><span
class="crayon-h">                             </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">62</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">75</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">=</span><span
class="crayon-h">                             </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">63</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">76</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">==</span><span
class="crayon-h">                            </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">64</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">77</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-h">                           </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">65</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">78</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">=</span><span
class="crayon-h">                          </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">66</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">79</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">==</span><span
class="crayon-h">                         </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">67</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">81</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">==</span><span
class="crayon-h">                         </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">68</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">82</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span
class="crayon-h">                        </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">69</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">83</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">=</span><span
class="crayon-h">                       </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">70</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">84</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">=</span><span
class="crayon-h">                       </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">70</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">85</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">==</span><span
class="crayon-h">                      </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">71</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">85</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-h">                     </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">72</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">87</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">=</span><span
class="crayon-h">                    </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">74</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">89</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">=</span><span
class="crayon-h">                    </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">74</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">90</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">==</span><span class="crayon-h">                  
</span><span class="crayon-o">|</span><span
class="crayon-h">  </span><span class="crayon-cn">75</span><span
class="crayon-o">%</span><span class="crayon-h">   </span><span
class="crayon-cn">91</span><span class="crayon-h"> </span><span
class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">==</span><span class="crayon-h">                  
</span><span class="crayon-o">|</span><span
class="crayon-h">  </span><span class="crayon-cn">76</span><span
class="crayon-o">%</span><span class="crayon-h">   </span><span
class="crayon-cn">91</span><span class="crayon-h"> </span><span
class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span
class="crayon-h">                  </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">76</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">92</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span
class="crayon-h">                  </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">77</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">92</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">=</span><span
class="crayon-h">                 </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">78</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">93</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">==</span><span
class="crayon-h">                </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">78</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">94</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">==</span><span
class="crayon-h">                </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">79</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">95</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-h">               </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">80</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">97</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">=</span><span
class="crayon-h">              </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">81</span><span class="crayon-o">%</span><span
class="crayon-h">   </span><span class="crayon-cn">98</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">==</span><span class="crayon-h">            
</span><span class="crayon-o">|</span><span
class="crayon-h">  </span><span class="crayon-cn">82</span><span
class="crayon-o">%</span><span class="crayon-h">   </span><span
class="crayon-cn">99</span><span class="crayon-h"> </span><span
class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">==</span><span class="crayon-h">            
</span><span class="crayon-o">|</span><span
class="crayon-h">  </span><span class="crayon-cn">83</span><span
class="crayon-o">%</span><span class="crayon-h">  </span><span
class="crayon-cn">100</span><span class="crayon-h"> </span><span
class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span
class="crayon-h">            </span><span class="crayon-o">|</span><span
class="crayon-h">  </span><span class="crayon-cn">84</span><span
class="crayon-o">%</span><span class="crayon-h">  </span><span
class="crayon-cn">101</span><span class="crayon-h"> </span><span
class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">=</span><span
class="crayon-h">           </span><span class="crayon-o">|</span><span
class="crayon-h">  </span><span class="crayon-cn">85</span><span
class="crayon-o">%</span><span class="crayon-h">  </span><span
class="crayon-cn">102</span><span class="crayon-h"> </span><span
class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">=</span><span
class="crayon-h">           </span><span class="crayon-o">|</span><span
class="crayon-h">  </span><span class="crayon-cn">85</span><span
class="crayon-o">%</span><span class="crayon-h">  </span><span
class="crayon-cn">103</span><span class="crayon-h"> </span><span
class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">==</span><span
class="crayon-h">          </span><span class="crayon-o">|</span><span
class="crayon-h">  </span><span class="crayon-cn">87</span><span
class="crayon-o">%</span><span class="crayon-h">  </span><span
class="crayon-cn">104</span><span class="crayon-h"> </span><span
class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-h">         </span><span class="crayon-o">|</span><span
class="crayon-h">  </span><span class="crayon-cn">88</span><span
class="crayon-o">%</span><span class="crayon-h">  </span><span
class="crayon-cn">106</span><span class="crayon-h"> </span><span
class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">=</span><span class="crayon-h">        </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">89</span><span class="crayon-o">%</span><span
class="crayon-h">  </span><span class="crayon-cn">107</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">==</span><span class="crayon-h">       </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">90</span><span class="crayon-o">%</span><span
class="crayon-h">  </span><span class="crayon-cn">108</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">==</span><span class="crayon-h">       </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">90</span><span class="crayon-o">%</span><span
class="crayon-h">  </span><span class="crayon-cn">108</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">==</span><span class="crayon-h">       </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">91</span><span class="crayon-o">%</span><span
class="crayon-h">  </span><span class="crayon-cn">109</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">=</span><span
class="crayon-h">     </span><span class="crayon-o">|</span><span
class="crayon-h">  </span><span class="crayon-cn">92</span><span
class="crayon-o">%</span><span class="crayon-h">  </span><span
class="crayon-cn">111</span><span class="crayon-h"> </span><span
class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">=</span><span
class="crayon-h">     </span><span class="crayon-o">|</span><span
class="crayon-h">  </span><span class="crayon-cn">93</span><span
class="crayon-o">%</span><span class="crayon-h">  </span><span
class="crayon-cn">112</span><span class="crayon-h"> </span><span
class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">==</span><span
class="crayon-h">    </span><span class="crayon-o">|</span><span
class="crayon-h">  </span><span class="crayon-cn">93</span><span
class="crayon-o">%</span><span class="crayon-h">  </span><span
class="crayon-cn">112</span><span class="crayon-h"> </span><span
class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">==</span><span
class="crayon-h">    </span><span class="crayon-o">|</span><span
class="crayon-h">  </span><span class="crayon-cn">94</span><span
class="crayon-o">%</span><span class="crayon-h">  </span><span
class="crayon-cn">113</span><span class="crayon-h"> </span><span
class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-h">   </span><span class="crayon-o">|</span><span
class="crayon-h">  </span><span class="crayon-cn">95</span><span
class="crayon-o">%</span><span class="crayon-h">  </span><span
class="crayon-cn">114</span><span class="crayon-h"> </span><span
class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">=</span><span class="crayon-h">  </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">96</span><span class="crayon-o">%</span><span
class="crayon-h">  </span><span class="crayon-cn">115</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">=</span><span class="crayon-h">  </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">97</span><span class="crayon-o">%</span><span
class="crayon-h">  </span><span class="crayon-cn">117</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">==</span><span class="crayon-h"> </span><span
class="crayon-o">|</span><span class="crayon-h">  </span><span
class="crayon-cn">98</span><span class="crayon-o">%</span><span
class="crayon-h">  </span><span class="crayon-cn">117</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">|</span><span
class="crayon-h">  </span><span class="crayon-cn">98</span><span
class="crayon-o">%</span><span class="crayon-h">  </span><span
class="crayon-cn">118</span><span class="crayon-h"> </span><span
class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">|</span><span
class="crayon-h">  </span><span class="crayon-cn">99</span><span
class="crayon-o">%</span><span class="crayon-h">  </span><span
class="crayon-cn">119</span><span class="crayon-h"> </span><span
class="crayon-v">MB</span>

<span class="crayon-o">|=</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">===</span><span
class="crayon-o">===</span><span class="crayon-o">=</span><span
class="crayon-o">|</span><span class="crayon-h"> </span><span
class="crayon-cn">100</span><span class="crayon-o">%</span><span
class="crayon-h">  </span><span class="crayon-cn">120</span><span
class="crayon-h"> </span><span class="crayon-v">MB</span>

</td>
</tr>
</table>

<p>
</p>
<div id="crayon-5a5818d00ba7c163332233" class="crayon-syntax crayon-theme-classic crayon-font-monaco crayon-os-pc print-yes notranslate" data-settings=" minimize scroll-mouseover" style=" margin-top: 12px; margin-bottom: 12px; font-size: 12px !important; line-height: 15px !important;">
<span class="crayon-title"></span>

<div class="crayon-plain-wrap">
<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
posts\_mbl = MBL*p**o**s**t*<sub>*t*</sub>*e**x**t*</span><span
class="crayon-v">post\_text</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-o">&gt;</span><span
class="crayon-o">%</span><span class="crayon-h"> </span><span
class="crayon-v">unique</span>
</div>
<span class="crayon-p">\# identificando alguns assuntos</span>

<span class="crayon-v">mblp</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-e">Corpus</span><span class="crayon-sy">(</span><span
class="crayon-e">VectorSource</span><span
class="crayon-sy">(</span><span class="crayon-v">posts\_mbl</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span>

<span class="crayon-v">mblp</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-e">tm\_map</span><span
class="crayon-sy">(</span><span class="crayon-v">mblp</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-e">content\_transformer</span><span
class="crayon-sy">(</span><span class="crayon-v">tolower</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span>

<span class="crayon-v">mblp</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-e">tm\_map</span><span
class="crayon-sy">(</span><span class="crayon-v">mblp</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">removePunctuation</span><span
class="crayon-sy">)</span>

<span class="crayon-v">mblp</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-e">tm\_map</span><span
class="crayon-sy">(</span><span class="crayon-v">mblp</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-t">function</span><span class="crayon-sy">(</span><span
class="crayon-v">x</span><span class="crayon-sy">)</span><span
class="crayon-e">removeWords</span><span class="crayon-sy">(</span><span
class="crayon-v">x</span><span class="crayon-sy">,</span><span
class="crayon-e">stopwords</span><span class="crayon-sy">(</span><span
class="crayon-s">"pt"</span><span class="crayon-sy">)</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span>

<span class="crayon-v">mblp</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-e">tm\_map</span><span
class="crayon-sy">(</span><span class="crayon-v">mblp</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-t">function</span><span class="crayon-sy">(</span><span
class="crayon-v">x</span><span class="crayon-sy">)</span><span
class="crayon-e">removeWords</span><span class="crayon-sy">(</span><span
class="crayon-v">x</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-e">c</span><span
class="crayon-sy">(</span><span
class="crayon-s">'httpswwwkickantecombrcampanhasiicongressonacionaldomovimentobrasillivre'</span><span
class="crayon-sy">,</span>

<span class="crayon-h">                                                
</span><span
class="crayon-s">'httpswwwsymplacombriicongressonacionaldomovimentobrasillivre96736'</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span><span
class="crayon-sy">)</span>

<span class="crayon-v">pal</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">brewer</span><span class="crayon-sy">.</span><span
class="crayon-e">pal</span><span class="crayon-sy">(</span><span
class="crayon-cn">5</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-s">"Set2"</span><span
class="crayon-sy">)</span>

<span class="crayon-p">\# Nuvem de palavras</span>

<span class="crayon-e">wordcloud</span><span
class="crayon-sy">(</span><span class="crayon-v">mblp</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">min</span><span class="crayon-sy">.</span><span
class="crayon-v">freq</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-cn">3</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">max</span><span
class="crayon-sy">.</span><span class="crayon-v">words</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-cn">100</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">random</span><span class="crayon-sy">.</span><span
class="crayon-v">order</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">F</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">colors</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-v">pal</span><span
class="crayon-sy">)</span>

<span class="crayon-e">title</span><span class="crayon-sy">(</span><span
class="crayon-v">xlab</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"Facebook - MBL17/09/2016 a 17/11/2016"</span><span
class="crayon-sy">)</span>

</div>
</td>
</tr>
</table>
</div>
</div>
<p>
<a href="http://ibpad.com.br/wp-content/uploads/2016/11/facebook-mbl1.png"><img class="aligncenter size-full wp-image-1797" src="https://ibpad.com.br/wp-content/uploads/2016/11/facebook-mbl1.png" alt="facebook-mbl1" width="650" height="401"></a>
</p>
<p>
Agora fazendo a clusterização hierárquica.
</p>
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
tdm &lt;- TermDocumentMatrix(mblp) tdm &lt;- removeSparseTerms(tdm,
sparse = 0.965) df &lt;- as.data.frame(inspect(tdm))
</textarea>

<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
1

2

3

</td>
<td class="crayon-code">
<span class="crayon-v">tdm</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span
class="crayon-e">TermDocumentMatrix</span><span
class="crayon-sy">(</span><span class="crayon-v">mblp</span><span
class="crayon-sy">)</span>

<span class="crayon-v">tdm</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span
class="crayon-e">removeSparseTerms</span><span
class="crayon-sy">(</span><span class="crayon-v">tdm</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">sparse</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-cn">0.965</span><span class="crayon-sy">)</span>

<span class="crayon-v">df</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-st">as</span><span
class="crayon-sy">.</span><span class="crayon-v">data</span><span
class="crayon-sy">.</span><span class="crayon-e">frame</span><span
class="crayon-sy">(</span><span class="crayon-e">inspect</span><span
class="crayon-sy">(</span><span class="crayon-v">tdm</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span>

</td>
</tr>
</table>

<p>
</p>
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
&lt;&lt;TermDocumentMatrix (terms: 32, documents: 1425)&gt;&gt;
Non-/sparse entries: 3512/42088 Sparsity : 92% Maximal term length: 16
Weighting : term frequency (tf)

                  Docs

Terms 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25
26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 Docs Terms 41 42 43 44 45
46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69
70 71 72 73 74 75 76 77 Docs Terms 78 79 80 81 82 83 84 85 86 87 88 89
90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109
110 Docs Terms 111 112 113 114 115 116 117 118 119 120 121 122 123 124
125 126 127 128 129 130 131 132 133 134 135 136 137 Docs Terms 138 139
140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157
158 159 160 161 162 163 164 Docs Terms 165 166 167 168 169 170 171 172
173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190
191 Docs Terms 192 193 194 195 196 197 198 199 200 201 202 203 204 205
206 207 208 209 210 211 212 213 214 215 216 217 218 Docs Terms 219 220
221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238
239 240 241 242 243 244 245 Docs Terms 246 247 248 249 250 251 252 253
254 255 256 257 258 259 260 261 262 263 264 265 266 267 268 269 270 271
272 Docs Terms 273 274 275 276 277 278 279 280 281 282 283 284 285 286
287 288 289 290 291 292 293 294 295 296 297 298 299 Docs Terms 300 301
302 303 304 305 306 307 308 309 310 311 312 313 314 315 316 317 318 319
320 321 322 323 324 325 326 Docs Terms 327 328 329 330 331 332 333 334
335 336 337 338 339 340 341 342 343 344 345 346 347 348 349 350 351 352
353 Docs Terms 354 355 356 357 358 359 360 361 362 363 364 365 366 367
368 369 370 371 372 373 374 375 376 377 378 379 380 Docs Terms 381 382
383 384 385 386 387 388 389 390 391 392 393 394 395 396 397 398 399 400
401 402 403 404 405 406 407 Docs Terms 408 409 410 411 412 413 414 415
416 417 418 419 420 421 422 423 424 425 426 427 428 429 430 431 432 433
434 Docs Terms 435 436 437 438 439 440 441 442 443 444 445 446 447 448
449 450 451 452 453 454 455 456 457 458 459 460 461 Docs Terms 462 463
464 465 466 467 468 469 470 471 472 473 474 475 476 477 478 479 480 481
482 483 484 485 486 487 488 Docs Terms 489 490 491 492 493 494 495 496
497 498 499 500 501 502 503 504 505 506 507 508 509 510 511 512 513 514
515 Docs Terms 516 517 518 519 520 521 522 523 524 525 526 527 528 529
530 531 532 533 534 535 536 537 538 539 540 541 542 Docs Terms 543 544
545 546 547 548 549 550 551 552 553 554 555 556 557 558 559 560 561 562
563 564 565 566 567 568 569 Docs Terms 570 571 572 573 574 575 576 577
578 579 580 581 582 583 584 585 586 587 588 589 590 591 592 593 594 595
596 Docs Terms 597 598 599 600 601 602 603 604 605 606 607 608 609 610
611 612 613 614 615 616 617 618 619 620 621 622 623 Docs Terms 624 625
626 627 628 629 630 631 632 633 634 635 636 637 638 639 640 641 642 643
644 645 646 647 648 649 650 Docs Terms 651 652 653 654 655 656 657 658
659 660 661 662 663 664 665 666 667 668 669 670 671 672 673 674 675 676
677 Docs Terms 678 679 680 681 682 683 684 685 686 687 688 689 690 691
692 693 694 695 696 697 698 699 700 701 702 703 704 Docs Terms 705 706
707 708 709 710 711 712 713 714 715 716 717 718 719 720 721 722 723 724
725 726 727 728 729 730 731 Docs Terms 732 733 734 735 736 737 738 739
740 741 742 743 744 745 746 747 748 749 750 751 752 753 754 755 756 757
758 Docs Terms 759 760 761 762 763 764 765 766 767 768 769 770 771 772
773 774 775 776 777 778 779 780 781 782 783 784 785 Docs Terms 786 787
788 789 790 791 792 793 794 795 796 797 798 799 800 801 802 803 804 805
806 807 808 809 810 811 812 Docs Terms 813 814 815 816 817 818 819 820
821 822 823 824 825 826 827 828 829 830 831 832 833 834 835 836 837 838
839 Docs Terms 840 841 842 843 844 845 846 847 848 849 850 851 852 853
854 855 856 857 858 859 860 861 862 863 864 865 866 Docs Terms 867 868
869 870 871 872 873 874 875 876 877 878 879 880 881 882 883 884 885 886
887 888 889 890 891 892 893 Docs Terms 894 895 896 897 898 899 900 901
902 903 904 905 906 907 908 909 910 911 912 913 914 915 916 917 918 919
920 Docs Terms 921 922 923 924 925 926 927 928 929 930 931 932 933 934
935 936 937 938 939 940 941 942 943 944 945 946 947 Docs Terms 948 949
950 951 952 953 954 955 956 957 958 959 960 961 962 963 964 965 966 967
968 969 970 971 972 973 974 Docs Terms 975 976 977 978 979 980 981 982
983 984 985 986 987 988 989 990 991 992 993 994 995 996 997 998 999 1000
1001 Docs Terms 1002 1003 1004 1005 1006 1007 1008 1009 1010 1011 1012
1013 1014 1015 1016 1017 1018 1019 1020 1021 1022 1023 Docs Terms 1024
1025 1026 1027 1028 1029 1030 1031 1032 1033 1034 1035 1036 1037 1038
1039 1040 1041 1042 1043 1044 1045 Docs Terms 1046 1047 1048 1049 1050
1051 1052 1053 1054 1055 1056 1057 1058 1059 1060 1061 1062 1063 1064
1065 1066 1067 Docs Terms 1068 1069 1070 1071 1072 1073 1074 1075 1076
1077 1078 1079 1080 1081 1082 1083 1084 1085 1086 1087 1088 1089 Docs
Terms 1090 1091 1092 1093 1094 1095 1096 1097 1098 1099 1100 1101 1102
1103 1104 1105 1106 1107 1108 1109 1110 1111 Docs Terms 1112 1113 1114
1115 1116 1117 1118 1119 1120 1121 1122 1123 1124 1125 1126 1127 1128
1129 1130 1131 1132 1133 Docs Terms 1134 1135 1136 1137 1138 1139 1140
1141 1142 1143 1144 1145 1146 1147 1148 1149 1150 1151 1152 1153 1154
1155 Docs Terms 1156 1157 1158 1159 1160 1161 1162 1163 1164 1165 1166
1167 1168 1169 1170 1171 1172 1173 1174 1175 1176 1177 Docs Terms 1178
1179 1180 1181 1182 1183 1184 1185 1186 1187 1188 1189 1190 1191 1192
1193 1194 1195 1196 1197 1198 1199 Docs Terms 1200 1201 1202 1203 1204
1205 1206 1207 1208 1209 1210 1211 1212 1213 1214 1215 1216 1217 1218
1219 1220 1221 Docs Terms 1222 1223 1224 1225 1226 1227 1228 1229 1230
1231 1232 1233 1234 1235 1236 1237 1238 1239 1240 1241 1242 1243 Docs
Terms 1244 1245 1246 1247 1248 1249 1250 1251 1252 1253 1254 1255 1256
1257 1258 1259 1260 1261 1262 1263 1264 1265 Docs Terms 1266 1267 1268
1269 1270 1271 1272 1273 1274 1275 1276 1277 1278 1279 1280 1281 1282
1283 1284 1285 1286 1287 Docs Terms 1288 1289 1290 1291 1292 1293 1294
1295 1296 1297 1298 1299 1300 1301 1302 1303 1304 1305 1306 1307 1308
1309 Docs Terms 1310 1311 1312 1313 1314 1315 1316 1317 1318 1319 1320
1321 1322 1323 1324 1325 1326 1327 1328 1329 1330 1331 Docs Terms 1332
1333 1334 1335 1336 1337 1338 1339 1340 1341 1342 1343 1344 1345 1346
1347 1348 1349 1350 1351 1352 1353 Docs Terms 1354 1355 1356 1357 1358
1359 1360 1361 1362 1363 1364 1365 1366 1367 1368 1369 1370 1371 1372
1373 1374 1375 Docs Terms 1376 1377 1378 1379 1380 1381 1382 1383 1384
1385 1386 1387 1388 1389 1390 1391 1392 1393 1394 1395 1396 1397 Docs
Terms 1398 1399 1400 1401 1402 1403 1404 1405 1406 1407 1408 1409 1410
1411 1412 1413 1414 1415 1416 1417 1418 1419 Docs Terms 1420 1421 1422
1423 1424 1425 \[ reached getOption("max.print") -- omitted 32 rows \]
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

50

51

52

53

54

55

56

57

58

59

60

61

62

63

64

65

66

67

68

69

70

71

72

73

74

75

76

77

78

79

80

81

82

83

84

85

86

87

88

89

90

91

92

93

94

95

96

97

98

99

100

101

102

103

104

105

106

107

108

109

110

111

112

113

114

115

116

117

118

119

</td>
<td class="crayon-code">
<span class="crayon-o">&</span><span class="crayon-v">lt</span><span
class="crayon-sy">;</span><span class="crayon-o">&</span><span
class="crayon-v">lt</span><span class="crayon-sy">;</span><span
class="crayon-e">TermDocumentMatrix</span><span class="crayon-h">
</span><span class="crayon-sy">(</span><span
class="crayon-v">terms</span><span class="crayon-o">:</span><span
class="crayon-h"> </span><span class="crayon-cn">32</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">documents</span><span class="crayon-o">:</span><span
class="crayon-h"> </span><span class="crayon-cn">1425</span><span
class="crayon-sy">)</span><span class="crayon-o">&</span><span
class="crayon-v">gt</span><span class="crayon-sy">;</span><span
class="crayon-o">&</span><span class="crayon-v">gt</span><span
class="crayon-sy">;</span>

<span class="crayon-v">Non</span><span class="crayon-o">-</span><span
class="crayon-o">/</span><span class="crayon-e">sparse </span><span
class="crayon-v">entries</span><span class="crayon-o">:</span><span
class="crayon-h"> </span><span class="crayon-cn">3512</span><span
class="crayon-o">/</span><span class="crayon-cn">42088</span>

<span class="crayon-v">Sparsity</span><span class="crayon-h">          
</span><span class="crayon-o">:</span><span class="crayon-h">
</span><span class="crayon-cn">92</span><span class="crayon-o">%</span>

<span class="crayon-e">Maximal </span><span class="crayon-e">term
</span><span class="crayon-v">length</span><span
class="crayon-o">:</span><span class="crayon-h"> </span><span
class="crayon-cn">16</span>

<span class="crayon-v">Weighting</span><span
class="crayon-h">          </span><span class="crayon-o">:</span><span
class="crayon-h"> </span><span class="crayon-e">term </span><span
class="crayon-e">frequency</span><span class="crayon-h"> </span><span
class="crayon-sy">(</span><span class="crayon-v">tf</span><span
class="crayon-sy">)</span>

 

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">1</span><span class="crayon-h"> </span><span
class="crayon-cn">2</span><span class="crayon-h"> </span><span
class="crayon-cn">3</span><span class="crayon-h"> </span><span
class="crayon-cn">4</span><span class="crayon-h"> </span><span
class="crayon-cn">5</span><span class="crayon-h"> </span><span
class="crayon-cn">6</span><span class="crayon-h"> </span><span
class="crayon-cn">7</span><span class="crayon-h"> </span><span
class="crayon-cn">8</span><span class="crayon-h"> </span><span
class="crayon-cn">9</span><span class="crayon-h"> </span><span
class="crayon-cn">10</span><span class="crayon-h"> </span><span
class="crayon-cn">11</span><span class="crayon-h"> </span><span
class="crayon-cn">12</span><span class="crayon-h"> </span><span
class="crayon-cn">13</span><span class="crayon-h"> </span><span
class="crayon-cn">14</span><span class="crayon-h"> </span><span
class="crayon-cn">15</span><span class="crayon-h"> </span><span
class="crayon-cn">16</span><span class="crayon-h"> </span><span
class="crayon-cn">17</span><span class="crayon-h"> </span><span
class="crayon-cn">18</span><span class="crayon-h"> </span><span
class="crayon-cn">19</span><span class="crayon-h"> </span><span
class="crayon-cn">20</span><span class="crayon-h"> </span><span
class="crayon-cn">21</span><span class="crayon-h"> </span><span
class="crayon-cn">22</span><span class="crayon-h"> </span><span
class="crayon-cn">23</span><span class="crayon-h"> </span><span
class="crayon-cn">24</span><span class="crayon-h"> </span><span
class="crayon-cn">25</span><span class="crayon-h"> </span><span
class="crayon-cn">26</span><span class="crayon-h"> </span><span
class="crayon-cn">27</span><span class="crayon-h"> </span><span
class="crayon-cn">28</span><span class="crayon-h"> </span><span
class="crayon-cn">29</span><span class="crayon-h"> </span><span
class="crayon-cn">30</span><span class="crayon-h"> </span><span
class="crayon-cn">31</span><span class="crayon-h"> </span><span
class="crayon-cn">32</span><span class="crayon-h"> </span><span
class="crayon-cn">33</span><span class="crayon-h"> </span><span
class="crayon-cn">34</span><span class="crayon-h"> </span><span
class="crayon-cn">35</span><span class="crayon-h"> </span><span
class="crayon-cn">36</span><span class="crayon-h"> </span><span
class="crayon-cn">37</span><span class="crayon-h"> </span><span
class="crayon-cn">38</span><span class="crayon-h"> </span><span
class="crayon-cn">39</span><span class="crayon-h"> </span><span
class="crayon-cn">40</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">41</span><span class="crayon-h"> </span><span
class="crayon-cn">42</span><span class="crayon-h"> </span><span
class="crayon-cn">43</span><span class="crayon-h"> </span><span
class="crayon-cn">44</span><span class="crayon-h"> </span><span
class="crayon-cn">45</span><span class="crayon-h"> </span><span
class="crayon-cn">46</span><span class="crayon-h"> </span><span
class="crayon-cn">47</span><span class="crayon-h"> </span><span
class="crayon-cn">48</span><span class="crayon-h"> </span><span
class="crayon-cn">49</span><span class="crayon-h"> </span><span
class="crayon-cn">50</span><span class="crayon-h"> </span><span
class="crayon-cn">51</span><span class="crayon-h"> </span><span
class="crayon-cn">52</span><span class="crayon-h"> </span><span
class="crayon-cn">53</span><span class="crayon-h"> </span><span
class="crayon-cn">54</span><span class="crayon-h"> </span><span
class="crayon-cn">55</span><span class="crayon-h"> </span><span
class="crayon-cn">56</span><span class="crayon-h"> </span><span
class="crayon-cn">57</span><span class="crayon-h"> </span><span
class="crayon-cn">58</span><span class="crayon-h"> </span><span
class="crayon-cn">59</span><span class="crayon-h"> </span><span
class="crayon-cn">60</span><span class="crayon-h"> </span><span
class="crayon-cn">61</span><span class="crayon-h"> </span><span
class="crayon-cn">62</span><span class="crayon-h"> </span><span
class="crayon-cn">63</span><span class="crayon-h"> </span><span
class="crayon-cn">64</span><span class="crayon-h"> </span><span
class="crayon-cn">65</span><span class="crayon-h"> </span><span
class="crayon-cn">66</span><span class="crayon-h"> </span><span
class="crayon-cn">67</span><span class="crayon-h"> </span><span
class="crayon-cn">68</span><span class="crayon-h"> </span><span
class="crayon-cn">69</span><span class="crayon-h"> </span><span
class="crayon-cn">70</span><span class="crayon-h"> </span><span
class="crayon-cn">71</span><span class="crayon-h"> </span><span
class="crayon-cn">72</span><span class="crayon-h"> </span><span
class="crayon-cn">73</span><span class="crayon-h"> </span><span
class="crayon-cn">74</span><span class="crayon-h"> </span><span
class="crayon-cn">75</span><span class="crayon-h"> </span><span
class="crayon-cn">76</span><span class="crayon-h"> </span><span
class="crayon-cn">77</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">78</span><span class="crayon-h"> </span><span
class="crayon-cn">79</span><span class="crayon-h"> </span><span
class="crayon-cn">80</span><span class="crayon-h"> </span><span
class="crayon-cn">81</span><span class="crayon-h"> </span><span
class="crayon-cn">82</span><span class="crayon-h"> </span><span
class="crayon-cn">83</span><span class="crayon-h"> </span><span
class="crayon-cn">84</span><span class="crayon-h"> </span><span
class="crayon-cn">85</span><span class="crayon-h"> </span><span
class="crayon-cn">86</span><span class="crayon-h"> </span><span
class="crayon-cn">87</span><span class="crayon-h"> </span><span
class="crayon-cn">88</span><span class="crayon-h"> </span><span
class="crayon-cn">89</span><span class="crayon-h"> </span><span
class="crayon-cn">90</span><span class="crayon-h"> </span><span
class="crayon-cn">91</span><span class="crayon-h"> </span><span
class="crayon-cn">92</span><span class="crayon-h"> </span><span
class="crayon-cn">93</span><span class="crayon-h"> </span><span
class="crayon-cn">94</span><span class="crayon-h"> </span><span
class="crayon-cn">95</span><span class="crayon-h"> </span><span
class="crayon-cn">96</span><span class="crayon-h"> </span><span
class="crayon-cn">97</span><span class="crayon-h"> </span><span
class="crayon-cn">98</span><span class="crayon-h"> </span><span
class="crayon-cn">99</span><span class="crayon-h"> </span><span
class="crayon-cn">100</span><span class="crayon-h"> </span><span
class="crayon-cn">101</span><span class="crayon-h"> </span><span
class="crayon-cn">102</span><span class="crayon-h"> </span><span
class="crayon-cn">103</span><span class="crayon-h"> </span><span
class="crayon-cn">104</span><span class="crayon-h"> </span><span
class="crayon-cn">105</span><span class="crayon-h"> </span><span
class="crayon-cn">106</span><span class="crayon-h"> </span><span
class="crayon-cn">107</span><span class="crayon-h"> </span><span
class="crayon-cn">108</span><span class="crayon-h"> </span><span
class="crayon-cn">109</span><span class="crayon-h"> </span><span
class="crayon-cn">110</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">111</span><span class="crayon-h"> </span><span
class="crayon-cn">112</span><span class="crayon-h"> </span><span
class="crayon-cn">113</span><span class="crayon-h"> </span><span
class="crayon-cn">114</span><span class="crayon-h"> </span><span
class="crayon-cn">115</span><span class="crayon-h"> </span><span
class="crayon-cn">116</span><span class="crayon-h"> </span><span
class="crayon-cn">117</span><span class="crayon-h"> </span><span
class="crayon-cn">118</span><span class="crayon-h"> </span><span
class="crayon-cn">119</span><span class="crayon-h"> </span><span
class="crayon-cn">120</span><span class="crayon-h"> </span><span
class="crayon-cn">121</span><span class="crayon-h"> </span><span
class="crayon-cn">122</span><span class="crayon-h"> </span><span
class="crayon-cn">123</span><span class="crayon-h"> </span><span
class="crayon-cn">124</span><span class="crayon-h"> </span><span
class="crayon-cn">125</span><span class="crayon-h"> </span><span
class="crayon-cn">126</span><span class="crayon-h"> </span><span
class="crayon-cn">127</span><span class="crayon-h"> </span><span
class="crayon-cn">128</span><span class="crayon-h"> </span><span
class="crayon-cn">129</span><span class="crayon-h"> </span><span
class="crayon-cn">130</span><span class="crayon-h"> </span><span
class="crayon-cn">131</span><span class="crayon-h"> </span><span
class="crayon-cn">132</span><span class="crayon-h"> </span><span
class="crayon-cn">133</span><span class="crayon-h"> </span><span
class="crayon-cn">134</span><span class="crayon-h"> </span><span
class="crayon-cn">135</span><span class="crayon-h"> </span><span
class="crayon-cn">136</span><span class="crayon-h"> </span><span
class="crayon-cn">137</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">138</span><span class="crayon-h"> </span><span
class="crayon-cn">139</span><span class="crayon-h"> </span><span
class="crayon-cn">140</span><span class="crayon-h"> </span><span
class="crayon-cn">141</span><span class="crayon-h"> </span><span
class="crayon-cn">142</span><span class="crayon-h"> </span><span
class="crayon-cn">143</span><span class="crayon-h"> </span><span
class="crayon-cn">144</span><span class="crayon-h"> </span><span
class="crayon-cn">145</span><span class="crayon-h"> </span><span
class="crayon-cn">146</span><span class="crayon-h"> </span><span
class="crayon-cn">147</span><span class="crayon-h"> </span><span
class="crayon-cn">148</span><span class="crayon-h"> </span><span
class="crayon-cn">149</span><span class="crayon-h"> </span><span
class="crayon-cn">150</span><span class="crayon-h"> </span><span
class="crayon-cn">151</span><span class="crayon-h"> </span><span
class="crayon-cn">152</span><span class="crayon-h"> </span><span
class="crayon-cn">153</span><span class="crayon-h"> </span><span
class="crayon-cn">154</span><span class="crayon-h"> </span><span
class="crayon-cn">155</span><span class="crayon-h"> </span><span
class="crayon-cn">156</span><span class="crayon-h"> </span><span
class="crayon-cn">157</span><span class="crayon-h"> </span><span
class="crayon-cn">158</span><span class="crayon-h"> </span><span
class="crayon-cn">159</span><span class="crayon-h"> </span><span
class="crayon-cn">160</span><span class="crayon-h"> </span><span
class="crayon-cn">161</span><span class="crayon-h"> </span><span
class="crayon-cn">162</span><span class="crayon-h"> </span><span
class="crayon-cn">163</span><span class="crayon-h"> </span><span
class="crayon-cn">164</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">165</span><span class="crayon-h"> </span><span
class="crayon-cn">166</span><span class="crayon-h"> </span><span
class="crayon-cn">167</span><span class="crayon-h"> </span><span
class="crayon-cn">168</span><span class="crayon-h"> </span><span
class="crayon-cn">169</span><span class="crayon-h"> </span><span
class="crayon-cn">170</span><span class="crayon-h"> </span><span
class="crayon-cn">171</span><span class="crayon-h"> </span><span
class="crayon-cn">172</span><span class="crayon-h"> </span><span
class="crayon-cn">173</span><span class="crayon-h"> </span><span
class="crayon-cn">174</span><span class="crayon-h"> </span><span
class="crayon-cn">175</span><span class="crayon-h"> </span><span
class="crayon-cn">176</span><span class="crayon-h"> </span><span
class="crayon-cn">177</span><span class="crayon-h"> </span><span
class="crayon-cn">178</span><span class="crayon-h"> </span><span
class="crayon-cn">179</span><span class="crayon-h"> </span><span
class="crayon-cn">180</span><span class="crayon-h"> </span><span
class="crayon-cn">181</span><span class="crayon-h"> </span><span
class="crayon-cn">182</span><span class="crayon-h"> </span><span
class="crayon-cn">183</span><span class="crayon-h"> </span><span
class="crayon-cn">184</span><span class="crayon-h"> </span><span
class="crayon-cn">185</span><span class="crayon-h"> </span><span
class="crayon-cn">186</span><span class="crayon-h"> </span><span
class="crayon-cn">187</span><span class="crayon-h"> </span><span
class="crayon-cn">188</span><span class="crayon-h"> </span><span
class="crayon-cn">189</span><span class="crayon-h"> </span><span
class="crayon-cn">190</span><span class="crayon-h"> </span><span
class="crayon-cn">191</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">192</span><span class="crayon-h"> </span><span
class="crayon-cn">193</span><span class="crayon-h"> </span><span
class="crayon-cn">194</span><span class="crayon-h"> </span><span
class="crayon-cn">195</span><span class="crayon-h"> </span><span
class="crayon-cn">196</span><span class="crayon-h"> </span><span
class="crayon-cn">197</span><span class="crayon-h"> </span><span
class="crayon-cn">198</span><span class="crayon-h"> </span><span
class="crayon-cn">199</span><span class="crayon-h"> </span><span
class="crayon-cn">200</span><span class="crayon-h"> </span><span
class="crayon-cn">201</span><span class="crayon-h"> </span><span
class="crayon-cn">202</span><span class="crayon-h"> </span><span
class="crayon-cn">203</span><span class="crayon-h"> </span><span
class="crayon-cn">204</span><span class="crayon-h"> </span><span
class="crayon-cn">205</span><span class="crayon-h"> </span><span
class="crayon-cn">206</span><span class="crayon-h"> </span><span
class="crayon-cn">207</span><span class="crayon-h"> </span><span
class="crayon-cn">208</span><span class="crayon-h"> </span><span
class="crayon-cn">209</span><span class="crayon-h"> </span><span
class="crayon-cn">210</span><span class="crayon-h"> </span><span
class="crayon-cn">211</span><span class="crayon-h"> </span><span
class="crayon-cn">212</span><span class="crayon-h"> </span><span
class="crayon-cn">213</span><span class="crayon-h"> </span><span
class="crayon-cn">214</span><span class="crayon-h"> </span><span
class="crayon-cn">215</span><span class="crayon-h"> </span><span
class="crayon-cn">216</span><span class="crayon-h"> </span><span
class="crayon-cn">217</span><span class="crayon-h"> </span><span
class="crayon-cn">218</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">219</span><span class="crayon-h"> </span><span
class="crayon-cn">220</span><span class="crayon-h"> </span><span
class="crayon-cn">221</span><span class="crayon-h"> </span><span
class="crayon-cn">222</span><span class="crayon-h"> </span><span
class="crayon-cn">223</span><span class="crayon-h"> </span><span
class="crayon-cn">224</span><span class="crayon-h"> </span><span
class="crayon-cn">225</span><span class="crayon-h"> </span><span
class="crayon-cn">226</span><span class="crayon-h"> </span><span
class="crayon-cn">227</span><span class="crayon-h"> </span><span
class="crayon-cn">228</span><span class="crayon-h"> </span><span
class="crayon-cn">229</span><span class="crayon-h"> </span><span
class="crayon-cn">230</span><span class="crayon-h"> </span><span
class="crayon-cn">231</span><span class="crayon-h"> </span><span
class="crayon-cn">232</span><span class="crayon-h"> </span><span
class="crayon-cn">233</span><span class="crayon-h"> </span><span
class="crayon-cn">234</span><span class="crayon-h"> </span><span
class="crayon-cn">235</span><span class="crayon-h"> </span><span
class="crayon-cn">236</span><span class="crayon-h"> </span><span
class="crayon-cn">237</span><span class="crayon-h"> </span><span
class="crayon-cn">238</span><span class="crayon-h"> </span><span
class="crayon-cn">239</span><span class="crayon-h"> </span><span
class="crayon-cn">240</span><span class="crayon-h"> </span><span
class="crayon-cn">241</span><span class="crayon-h"> </span><span
class="crayon-cn">242</span><span class="crayon-h"> </span><span
class="crayon-cn">243</span><span class="crayon-h"> </span><span
class="crayon-cn">244</span><span class="crayon-h"> </span><span
class="crayon-cn">245</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">246</span><span class="crayon-h"> </span><span
class="crayon-cn">247</span><span class="crayon-h"> </span><span
class="crayon-cn">248</span><span class="crayon-h"> </span><span
class="crayon-cn">249</span><span class="crayon-h"> </span><span
class="crayon-cn">250</span><span class="crayon-h"> </span><span
class="crayon-cn">251</span><span class="crayon-h"> </span><span
class="crayon-cn">252</span><span class="crayon-h"> </span><span
class="crayon-cn">253</span><span class="crayon-h"> </span><span
class="crayon-cn">254</span><span class="crayon-h"> </span><span
class="crayon-cn">255</span><span class="crayon-h"> </span><span
class="crayon-cn">256</span><span class="crayon-h"> </span><span
class="crayon-cn">257</span><span class="crayon-h"> </span><span
class="crayon-cn">258</span><span class="crayon-h"> </span><span
class="crayon-cn">259</span><span class="crayon-h"> </span><span
class="crayon-cn">260</span><span class="crayon-h"> </span><span
class="crayon-cn">261</span><span class="crayon-h"> </span><span
class="crayon-cn">262</span><span class="crayon-h"> </span><span
class="crayon-cn">263</span><span class="crayon-h"> </span><span
class="crayon-cn">264</span><span class="crayon-h"> </span><span
class="crayon-cn">265</span><span class="crayon-h"> </span><span
class="crayon-cn">266</span><span class="crayon-h"> </span><span
class="crayon-cn">267</span><span class="crayon-h"> </span><span
class="crayon-cn">268</span><span class="crayon-h"> </span><span
class="crayon-cn">269</span><span class="crayon-h"> </span><span
class="crayon-cn">270</span><span class="crayon-h"> </span><span
class="crayon-cn">271</span><span class="crayon-h"> </span><span
class="crayon-cn">272</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">273</span><span class="crayon-h"> </span><span
class="crayon-cn">274</span><span class="crayon-h"> </span><span
class="crayon-cn">275</span><span class="crayon-h"> </span><span
class="crayon-cn">276</span><span class="crayon-h"> </span><span
class="crayon-cn">277</span><span class="crayon-h"> </span><span
class="crayon-cn">278</span><span class="crayon-h"> </span><span
class="crayon-cn">279</span><span class="crayon-h"> </span><span
class="crayon-cn">280</span><span class="crayon-h"> </span><span
class="crayon-cn">281</span><span class="crayon-h"> </span><span
class="crayon-cn">282</span><span class="crayon-h"> </span><span
class="crayon-cn">283</span><span class="crayon-h"> </span><span
class="crayon-cn">284</span><span class="crayon-h"> </span><span
class="crayon-cn">285</span><span class="crayon-h"> </span><span
class="crayon-cn">286</span><span class="crayon-h"> </span><span
class="crayon-cn">287</span><span class="crayon-h"> </span><span
class="crayon-cn">288</span><span class="crayon-h"> </span><span
class="crayon-cn">289</span><span class="crayon-h"> </span><span
class="crayon-cn">290</span><span class="crayon-h"> </span><span
class="crayon-cn">291</span><span class="crayon-h"> </span><span
class="crayon-cn">292</span><span class="crayon-h"> </span><span
class="crayon-cn">293</span><span class="crayon-h"> </span><span
class="crayon-cn">294</span><span class="crayon-h"> </span><span
class="crayon-cn">295</span><span class="crayon-h"> </span><span
class="crayon-cn">296</span><span class="crayon-h"> </span><span
class="crayon-cn">297</span><span class="crayon-h"> </span><span
class="crayon-cn">298</span><span class="crayon-h"> </span><span
class="crayon-cn">299</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">300</span><span class="crayon-h"> </span><span
class="crayon-cn">301</span><span class="crayon-h"> </span><span
class="crayon-cn">302</span><span class="crayon-h"> </span><span
class="crayon-cn">303</span><span class="crayon-h"> </span><span
class="crayon-cn">304</span><span class="crayon-h"> </span><span
class="crayon-cn">305</span><span class="crayon-h"> </span><span
class="crayon-cn">306</span><span class="crayon-h"> </span><span
class="crayon-cn">307</span><span class="crayon-h"> </span><span
class="crayon-cn">308</span><span class="crayon-h"> </span><span
class="crayon-cn">309</span><span class="crayon-h"> </span><span
class="crayon-cn">310</span><span class="crayon-h"> </span><span
class="crayon-cn">311</span><span class="crayon-h"> </span><span
class="crayon-cn">312</span><span class="crayon-h"> </span><span
class="crayon-cn">313</span><span class="crayon-h"> </span><span
class="crayon-cn">314</span><span class="crayon-h"> </span><span
class="crayon-cn">315</span><span class="crayon-h"> </span><span
class="crayon-cn">316</span><span class="crayon-h"> </span><span
class="crayon-cn">317</span><span class="crayon-h"> </span><span
class="crayon-cn">318</span><span class="crayon-h"> </span><span
class="crayon-cn">319</span><span class="crayon-h"> </span><span
class="crayon-cn">320</span><span class="crayon-h"> </span><span
class="crayon-cn">321</span><span class="crayon-h"> </span><span
class="crayon-cn">322</span><span class="crayon-h"> </span><span
class="crayon-cn">323</span><span class="crayon-h"> </span><span
class="crayon-cn">324</span><span class="crayon-h"> </span><span
class="crayon-cn">325</span><span class="crayon-h"> </span><span
class="crayon-cn">326</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">327</span><span class="crayon-h"> </span><span
class="crayon-cn">328</span><span class="crayon-h"> </span><span
class="crayon-cn">329</span><span class="crayon-h"> </span><span
class="crayon-cn">330</span><span class="crayon-h"> </span><span
class="crayon-cn">331</span><span class="crayon-h"> </span><span
class="crayon-cn">332</span><span class="crayon-h"> </span><span
class="crayon-cn">333</span><span class="crayon-h"> </span><span
class="crayon-cn">334</span><span class="crayon-h"> </span><span
class="crayon-cn">335</span><span class="crayon-h"> </span><span
class="crayon-cn">336</span><span class="crayon-h"> </span><span
class="crayon-cn">337</span><span class="crayon-h"> </span><span
class="crayon-cn">338</span><span class="crayon-h"> </span><span
class="crayon-cn">339</span><span class="crayon-h"> </span><span
class="crayon-cn">340</span><span class="crayon-h"> </span><span
class="crayon-cn">341</span><span class="crayon-h"> </span><span
class="crayon-cn">342</span><span class="crayon-h"> </span><span
class="crayon-cn">343</span><span class="crayon-h"> </span><span
class="crayon-cn">344</span><span class="crayon-h"> </span><span
class="crayon-cn">345</span><span class="crayon-h"> </span><span
class="crayon-cn">346</span><span class="crayon-h"> </span><span
class="crayon-cn">347</span><span class="crayon-h"> </span><span
class="crayon-cn">348</span><span class="crayon-h"> </span><span
class="crayon-cn">349</span><span class="crayon-h"> </span><span
class="crayon-cn">350</span><span class="crayon-h"> </span><span
class="crayon-cn">351</span><span class="crayon-h"> </span><span
class="crayon-cn">352</span><span class="crayon-h"> </span><span
class="crayon-cn">353</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">354</span><span class="crayon-h"> </span><span
class="crayon-cn">355</span><span class="crayon-h"> </span><span
class="crayon-cn">356</span><span class="crayon-h"> </span><span
class="crayon-cn">357</span><span class="crayon-h"> </span><span
class="crayon-cn">358</span><span class="crayon-h"> </span><span
class="crayon-cn">359</span><span class="crayon-h"> </span><span
class="crayon-cn">360</span><span class="crayon-h"> </span><span
class="crayon-cn">361</span><span class="crayon-h"> </span><span
class="crayon-cn">362</span><span class="crayon-h"> </span><span
class="crayon-cn">363</span><span class="crayon-h"> </span><span
class="crayon-cn">364</span><span class="crayon-h"> </span><span
class="crayon-cn">365</span><span class="crayon-h"> </span><span
class="crayon-cn">366</span><span class="crayon-h"> </span><span
class="crayon-cn">367</span><span class="crayon-h"> </span><span
class="crayon-cn">368</span><span class="crayon-h"> </span><span
class="crayon-cn">369</span><span class="crayon-h"> </span><span
class="crayon-cn">370</span><span class="crayon-h"> </span><span
class="crayon-cn">371</span><span class="crayon-h"> </span><span
class="crayon-cn">372</span><span class="crayon-h"> </span><span
class="crayon-cn">373</span><span class="crayon-h"> </span><span
class="crayon-cn">374</span><span class="crayon-h"> </span><span
class="crayon-cn">375</span><span class="crayon-h"> </span><span
class="crayon-cn">376</span><span class="crayon-h"> </span><span
class="crayon-cn">377</span><span class="crayon-h"> </span><span
class="crayon-cn">378</span><span class="crayon-h"> </span><span
class="crayon-cn">379</span><span class="crayon-h"> </span><span
class="crayon-cn">380</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">381</span><span class="crayon-h"> </span><span
class="crayon-cn">382</span><span class="crayon-h"> </span><span
class="crayon-cn">383</span><span class="crayon-h"> </span><span
class="crayon-cn">384</span><span class="crayon-h"> </span><span
class="crayon-cn">385</span><span class="crayon-h"> </span><span
class="crayon-cn">386</span><span class="crayon-h"> </span><span
class="crayon-cn">387</span><span class="crayon-h"> </span><span
class="crayon-cn">388</span><span class="crayon-h"> </span><span
class="crayon-cn">389</span><span class="crayon-h"> </span><span
class="crayon-cn">390</span><span class="crayon-h"> </span><span
class="crayon-cn">391</span><span class="crayon-h"> </span><span
class="crayon-cn">392</span><span class="crayon-h"> </span><span
class="crayon-cn">393</span><span class="crayon-h"> </span><span
class="crayon-cn">394</span><span class="crayon-h"> </span><span
class="crayon-cn">395</span><span class="crayon-h"> </span><span
class="crayon-cn">396</span><span class="crayon-h"> </span><span
class="crayon-cn">397</span><span class="crayon-h"> </span><span
class="crayon-cn">398</span><span class="crayon-h"> </span><span
class="crayon-cn">399</span><span class="crayon-h"> </span><span
class="crayon-cn">400</span><span class="crayon-h"> </span><span
class="crayon-cn">401</span><span class="crayon-h"> </span><span
class="crayon-cn">402</span><span class="crayon-h"> </span><span
class="crayon-cn">403</span><span class="crayon-h"> </span><span
class="crayon-cn">404</span><span class="crayon-h"> </span><span
class="crayon-cn">405</span><span class="crayon-h"> </span><span
class="crayon-cn">406</span><span class="crayon-h"> </span><span
class="crayon-cn">407</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">408</span><span class="crayon-h"> </span><span
class="crayon-cn">409</span><span class="crayon-h"> </span><span
class="crayon-cn">410</span><span class="crayon-h"> </span><span
class="crayon-cn">411</span><span class="crayon-h"> </span><span
class="crayon-cn">412</span><span class="crayon-h"> </span><span
class="crayon-cn">413</span><span class="crayon-h"> </span><span
class="crayon-cn">414</span><span class="crayon-h"> </span><span
class="crayon-cn">415</span><span class="crayon-h"> </span><span
class="crayon-cn">416</span><span class="crayon-h"> </span><span
class="crayon-cn">417</span><span class="crayon-h"> </span><span
class="crayon-cn">418</span><span class="crayon-h"> </span><span
class="crayon-cn">419</span><span class="crayon-h"> </span><span
class="crayon-cn">420</span><span class="crayon-h"> </span><span
class="crayon-cn">421</span><span class="crayon-h"> </span><span
class="crayon-cn">422</span><span class="crayon-h"> </span><span
class="crayon-cn">423</span><span class="crayon-h"> </span><span
class="crayon-cn">424</span><span class="crayon-h"> </span><span
class="crayon-cn">425</span><span class="crayon-h"> </span><span
class="crayon-cn">426</span><span class="crayon-h"> </span><span
class="crayon-cn">427</span><span class="crayon-h"> </span><span
class="crayon-cn">428</span><span class="crayon-h"> </span><span
class="crayon-cn">429</span><span class="crayon-h"> </span><span
class="crayon-cn">430</span><span class="crayon-h"> </span><span
class="crayon-cn">431</span><span class="crayon-h"> </span><span
class="crayon-cn">432</span><span class="crayon-h"> </span><span
class="crayon-cn">433</span><span class="crayon-h"> </span><span
class="crayon-cn">434</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">435</span><span class="crayon-h"> </span><span
class="crayon-cn">436</span><span class="crayon-h"> </span><span
class="crayon-cn">437</span><span class="crayon-h"> </span><span
class="crayon-cn">438</span><span class="crayon-h"> </span><span
class="crayon-cn">439</span><span class="crayon-h"> </span><span
class="crayon-cn">440</span><span class="crayon-h"> </span><span
class="crayon-cn">441</span><span class="crayon-h"> </span><span
class="crayon-cn">442</span><span class="crayon-h"> </span><span
class="crayon-cn">443</span><span class="crayon-h"> </span><span
class="crayon-cn">444</span><span class="crayon-h"> </span><span
class="crayon-cn">445</span><span class="crayon-h"> </span><span
class="crayon-cn">446</span><span class="crayon-h"> </span><span
class="crayon-cn">447</span><span class="crayon-h"> </span><span
class="crayon-cn">448</span><span class="crayon-h"> </span><span
class="crayon-cn">449</span><span class="crayon-h"> </span><span
class="crayon-cn">450</span><span class="crayon-h"> </span><span
class="crayon-cn">451</span><span class="crayon-h"> </span><span
class="crayon-cn">452</span><span class="crayon-h"> </span><span
class="crayon-cn">453</span><span class="crayon-h"> </span><span
class="crayon-cn">454</span><span class="crayon-h"> </span><span
class="crayon-cn">455</span><span class="crayon-h"> </span><span
class="crayon-cn">456</span><span class="crayon-h"> </span><span
class="crayon-cn">457</span><span class="crayon-h"> </span><span
class="crayon-cn">458</span><span class="crayon-h"> </span><span
class="crayon-cn">459</span><span class="crayon-h"> </span><span
class="crayon-cn">460</span><span class="crayon-h"> </span><span
class="crayon-cn">461</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">462</span><span class="crayon-h"> </span><span
class="crayon-cn">463</span><span class="crayon-h"> </span><span
class="crayon-cn">464</span><span class="crayon-h"> </span><span
class="crayon-cn">465</span><span class="crayon-h"> </span><span
class="crayon-cn">466</span><span class="crayon-h"> </span><span
class="crayon-cn">467</span><span class="crayon-h"> </span><span
class="crayon-cn">468</span><span class="crayon-h"> </span><span
class="crayon-cn">469</span><span class="crayon-h"> </span><span
class="crayon-cn">470</span><span class="crayon-h"> </span><span
class="crayon-cn">471</span><span class="crayon-h"> </span><span
class="crayon-cn">472</span><span class="crayon-h"> </span><span
class="crayon-cn">473</span><span class="crayon-h"> </span><span
class="crayon-cn">474</span><span class="crayon-h"> </span><span
class="crayon-cn">475</span><span class="crayon-h"> </span><span
class="crayon-cn">476</span><span class="crayon-h"> </span><span
class="crayon-cn">477</span><span class="crayon-h"> </span><span
class="crayon-cn">478</span><span class="crayon-h"> </span><span
class="crayon-cn">479</span><span class="crayon-h"> </span><span
class="crayon-cn">480</span><span class="crayon-h"> </span><span
class="crayon-cn">481</span><span class="crayon-h"> </span><span
class="crayon-cn">482</span><span class="crayon-h"> </span><span
class="crayon-cn">483</span><span class="crayon-h"> </span><span
class="crayon-cn">484</span><span class="crayon-h"> </span><span
class="crayon-cn">485</span><span class="crayon-h"> </span><span
class="crayon-cn">486</span><span class="crayon-h"> </span><span
class="crayon-cn">487</span><span class="crayon-h"> </span><span
class="crayon-cn">488</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">489</span><span class="crayon-h"> </span><span
class="crayon-cn">490</span><span class="crayon-h"> </span><span
class="crayon-cn">491</span><span class="crayon-h"> </span><span
class="crayon-cn">492</span><span class="crayon-h"> </span><span
class="crayon-cn">493</span><span class="crayon-h"> </span><span
class="crayon-cn">494</span><span class="crayon-h"> </span><span
class="crayon-cn">495</span><span class="crayon-h"> </span><span
class="crayon-cn">496</span><span class="crayon-h"> </span><span
class="crayon-cn">497</span><span class="crayon-h"> </span><span
class="crayon-cn">498</span><span class="crayon-h"> </span><span
class="crayon-cn">499</span><span class="crayon-h"> </span><span
class="crayon-cn">500</span><span class="crayon-h"> </span><span
class="crayon-cn">501</span><span class="crayon-h"> </span><span
class="crayon-cn">502</span><span class="crayon-h"> </span><span
class="crayon-cn">503</span><span class="crayon-h"> </span><span
class="crayon-cn">504</span><span class="crayon-h"> </span><span
class="crayon-cn">505</span><span class="crayon-h"> </span><span
class="crayon-cn">506</span><span class="crayon-h"> </span><span
class="crayon-cn">507</span><span class="crayon-h"> </span><span
class="crayon-cn">508</span><span class="crayon-h"> </span><span
class="crayon-cn">509</span><span class="crayon-h"> </span><span
class="crayon-cn">510</span><span class="crayon-h"> </span><span
class="crayon-cn">511</span><span class="crayon-h"> </span><span
class="crayon-cn">512</span><span class="crayon-h"> </span><span
class="crayon-cn">513</span><span class="crayon-h"> </span><span
class="crayon-cn">514</span><span class="crayon-h"> </span><span
class="crayon-cn">515</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">516</span><span class="crayon-h"> </span><span
class="crayon-cn">517</span><span class="crayon-h"> </span><span
class="crayon-cn">518</span><span class="crayon-h"> </span><span
class="crayon-cn">519</span><span class="crayon-h"> </span><span
class="crayon-cn">520</span><span class="crayon-h"> </span><span
class="crayon-cn">521</span><span class="crayon-h"> </span><span
class="crayon-cn">522</span><span class="crayon-h"> </span><span
class="crayon-cn">523</span><span class="crayon-h"> </span><span
class="crayon-cn">524</span><span class="crayon-h"> </span><span
class="crayon-cn">525</span><span class="crayon-h"> </span><span
class="crayon-cn">526</span><span class="crayon-h"> </span><span
class="crayon-cn">527</span><span class="crayon-h"> </span><span
class="crayon-cn">528</span><span class="crayon-h"> </span><span
class="crayon-cn">529</span><span class="crayon-h"> </span><span
class="crayon-cn">530</span><span class="crayon-h"> </span><span
class="crayon-cn">531</span><span class="crayon-h"> </span><span
class="crayon-cn">532</span><span class="crayon-h"> </span><span
class="crayon-cn">533</span><span class="crayon-h"> </span><span
class="crayon-cn">534</span><span class="crayon-h"> </span><span
class="crayon-cn">535</span><span class="crayon-h"> </span><span
class="crayon-cn">536</span><span class="crayon-h"> </span><span
class="crayon-cn">537</span><span class="crayon-h"> </span><span
class="crayon-cn">538</span><span class="crayon-h"> </span><span
class="crayon-cn">539</span><span class="crayon-h"> </span><span
class="crayon-cn">540</span><span class="crayon-h"> </span><span
class="crayon-cn">541</span><span class="crayon-h"> </span><span
class="crayon-cn">542</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">543</span><span class="crayon-h"> </span><span
class="crayon-cn">544</span><span class="crayon-h"> </span><span
class="crayon-cn">545</span><span class="crayon-h"> </span><span
class="crayon-cn">546</span><span class="crayon-h"> </span><span
class="crayon-cn">547</span><span class="crayon-h"> </span><span
class="crayon-cn">548</span><span class="crayon-h"> </span><span
class="crayon-cn">549</span><span class="crayon-h"> </span><span
class="crayon-cn">550</span><span class="crayon-h"> </span><span
class="crayon-cn">551</span><span class="crayon-h"> </span><span
class="crayon-cn">552</span><span class="crayon-h"> </span><span
class="crayon-cn">553</span><span class="crayon-h"> </span><span
class="crayon-cn">554</span><span class="crayon-h"> </span><span
class="crayon-cn">555</span><span class="crayon-h"> </span><span
class="crayon-cn">556</span><span class="crayon-h"> </span><span
class="crayon-cn">557</span><span class="crayon-h"> </span><span
class="crayon-cn">558</span><span class="crayon-h"> </span><span
class="crayon-cn">559</span><span class="crayon-h"> </span><span
class="crayon-cn">560</span><span class="crayon-h"> </span><span
class="crayon-cn">561</span><span class="crayon-h"> </span><span
class="crayon-cn">562</span><span class="crayon-h"> </span><span
class="crayon-cn">563</span><span class="crayon-h"> </span><span
class="crayon-cn">564</span><span class="crayon-h"> </span><span
class="crayon-cn">565</span><span class="crayon-h"> </span><span
class="crayon-cn">566</span><span class="crayon-h"> </span><span
class="crayon-cn">567</span><span class="crayon-h"> </span><span
class="crayon-cn">568</span><span class="crayon-h"> </span><span
class="crayon-cn">569</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">570</span><span class="crayon-h"> </span><span
class="crayon-cn">571</span><span class="crayon-h"> </span><span
class="crayon-cn">572</span><span class="crayon-h"> </span><span
class="crayon-cn">573</span><span class="crayon-h"> </span><span
class="crayon-cn">574</span><span class="crayon-h"> </span><span
class="crayon-cn">575</span><span class="crayon-h"> </span><span
class="crayon-cn">576</span><span class="crayon-h"> </span><span
class="crayon-cn">577</span><span class="crayon-h"> </span><span
class="crayon-cn">578</span><span class="crayon-h"> </span><span
class="crayon-cn">579</span><span class="crayon-h"> </span><span
class="crayon-cn">580</span><span class="crayon-h"> </span><span
class="crayon-cn">581</span><span class="crayon-h"> </span><span
class="crayon-cn">582</span><span class="crayon-h"> </span><span
class="crayon-cn">583</span><span class="crayon-h"> </span><span
class="crayon-cn">584</span><span class="crayon-h"> </span><span
class="crayon-cn">585</span><span class="crayon-h"> </span><span
class="crayon-cn">586</span><span class="crayon-h"> </span><span
class="crayon-cn">587</span><span class="crayon-h"> </span><span
class="crayon-cn">588</span><span class="crayon-h"> </span><span
class="crayon-cn">589</span><span class="crayon-h"> </span><span
class="crayon-cn">590</span><span class="crayon-h"> </span><span
class="crayon-cn">591</span><span class="crayon-h"> </span><span
class="crayon-cn">592</span><span class="crayon-h"> </span><span
class="crayon-cn">593</span><span class="crayon-h"> </span><span
class="crayon-cn">594</span><span class="crayon-h"> </span><span
class="crayon-cn">595</span><span class="crayon-h"> </span><span
class="crayon-cn">596</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">597</span><span class="crayon-h"> </span><span
class="crayon-cn">598</span><span class="crayon-h"> </span><span
class="crayon-cn">599</span><span class="crayon-h"> </span><span
class="crayon-cn">600</span><span class="crayon-h"> </span><span
class="crayon-cn">601</span><span class="crayon-h"> </span><span
class="crayon-cn">602</span><span class="crayon-h"> </span><span
class="crayon-cn">603</span><span class="crayon-h"> </span><span
class="crayon-cn">604</span><span class="crayon-h"> </span><span
class="crayon-cn">605</span><span class="crayon-h"> </span><span
class="crayon-cn">606</span><span class="crayon-h"> </span><span
class="crayon-cn">607</span><span class="crayon-h"> </span><span
class="crayon-cn">608</span><span class="crayon-h"> </span><span
class="crayon-cn">609</span><span class="crayon-h"> </span><span
class="crayon-cn">610</span><span class="crayon-h"> </span><span
class="crayon-cn">611</span><span class="crayon-h"> </span><span
class="crayon-cn">612</span><span class="crayon-h"> </span><span
class="crayon-cn">613</span><span class="crayon-h"> </span><span
class="crayon-cn">614</span><span class="crayon-h"> </span><span
class="crayon-cn">615</span><span class="crayon-h"> </span><span
class="crayon-cn">616</span><span class="crayon-h"> </span><span
class="crayon-cn">617</span><span class="crayon-h"> </span><span
class="crayon-cn">618</span><span class="crayon-h"> </span><span
class="crayon-cn">619</span><span class="crayon-h"> </span><span
class="crayon-cn">620</span><span class="crayon-h"> </span><span
class="crayon-cn">621</span><span class="crayon-h"> </span><span
class="crayon-cn">622</span><span class="crayon-h"> </span><span
class="crayon-cn">623</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">624</span><span class="crayon-h"> </span><span
class="crayon-cn">625</span><span class="crayon-h"> </span><span
class="crayon-cn">626</span><span class="crayon-h"> </span><span
class="crayon-cn">627</span><span class="crayon-h"> </span><span
class="crayon-cn">628</span><span class="crayon-h"> </span><span
class="crayon-cn">629</span><span class="crayon-h"> </span><span
class="crayon-cn">630</span><span class="crayon-h"> </span><span
class="crayon-cn">631</span><span class="crayon-h"> </span><span
class="crayon-cn">632</span><span class="crayon-h"> </span><span
class="crayon-cn">633</span><span class="crayon-h"> </span><span
class="crayon-cn">634</span><span class="crayon-h"> </span><span
class="crayon-cn">635</span><span class="crayon-h"> </span><span
class="crayon-cn">636</span><span class="crayon-h"> </span><span
class="crayon-cn">637</span><span class="crayon-h"> </span><span
class="crayon-cn">638</span><span class="crayon-h"> </span><span
class="crayon-cn">639</span><span class="crayon-h"> </span><span
class="crayon-cn">640</span><span class="crayon-h"> </span><span
class="crayon-cn">641</span><span class="crayon-h"> </span><span
class="crayon-cn">642</span><span class="crayon-h"> </span><span
class="crayon-cn">643</span><span class="crayon-h"> </span><span
class="crayon-cn">644</span><span class="crayon-h"> </span><span
class="crayon-cn">645</span><span class="crayon-h"> </span><span
class="crayon-cn">646</span><span class="crayon-h"> </span><span
class="crayon-cn">647</span><span class="crayon-h"> </span><span
class="crayon-cn">648</span><span class="crayon-h"> </span><span
class="crayon-cn">649</span><span class="crayon-h"> </span><span
class="crayon-cn">650</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">651</span><span class="crayon-h"> </span><span
class="crayon-cn">652</span><span class="crayon-h"> </span><span
class="crayon-cn">653</span><span class="crayon-h"> </span><span
class="crayon-cn">654</span><span class="crayon-h"> </span><span
class="crayon-cn">655</span><span class="crayon-h"> </span><span
class="crayon-cn">656</span><span class="crayon-h"> </span><span
class="crayon-cn">657</span><span class="crayon-h"> </span><span
class="crayon-cn">658</span><span class="crayon-h"> </span><span
class="crayon-cn">659</span><span class="crayon-h"> </span><span
class="crayon-cn">660</span><span class="crayon-h"> </span><span
class="crayon-cn">661</span><span class="crayon-h"> </span><span
class="crayon-cn">662</span><span class="crayon-h"> </span><span
class="crayon-cn">663</span><span class="crayon-h"> </span><span
class="crayon-cn">664</span><span class="crayon-h"> </span><span
class="crayon-cn">665</span><span class="crayon-h"> </span><span
class="crayon-cn">666</span><span class="crayon-h"> </span><span
class="crayon-cn">667</span><span class="crayon-h"> </span><span
class="crayon-cn">668</span><span class="crayon-h"> </span><span
class="crayon-cn">669</span><span class="crayon-h"> </span><span
class="crayon-cn">670</span><span class="crayon-h"> </span><span
class="crayon-cn">671</span><span class="crayon-h"> </span><span
class="crayon-cn">672</span><span class="crayon-h"> </span><span
class="crayon-cn">673</span><span class="crayon-h"> </span><span
class="crayon-cn">674</span><span class="crayon-h"> </span><span
class="crayon-cn">675</span><span class="crayon-h"> </span><span
class="crayon-cn">676</span><span class="crayon-h"> </span><span
class="crayon-cn">677</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">678</span><span class="crayon-h"> </span><span
class="crayon-cn">679</span><span class="crayon-h"> </span><span
class="crayon-cn">680</span><span class="crayon-h"> </span><span
class="crayon-cn">681</span><span class="crayon-h"> </span><span
class="crayon-cn">682</span><span class="crayon-h"> </span><span
class="crayon-cn">683</span><span class="crayon-h"> </span><span
class="crayon-cn">684</span><span class="crayon-h"> </span><span
class="crayon-cn">685</span><span class="crayon-h"> </span><span
class="crayon-cn">686</span><span class="crayon-h"> </span><span
class="crayon-cn">687</span><span class="crayon-h"> </span><span
class="crayon-cn">688</span><span class="crayon-h"> </span><span
class="crayon-cn">689</span><span class="crayon-h"> </span><span
class="crayon-cn">690</span><span class="crayon-h"> </span><span
class="crayon-cn">691</span><span class="crayon-h"> </span><span
class="crayon-cn">692</span><span class="crayon-h"> </span><span
class="crayon-cn">693</span><span class="crayon-h"> </span><span
class="crayon-cn">694</span><span class="crayon-h"> </span><span
class="crayon-cn">695</span><span class="crayon-h"> </span><span
class="crayon-cn">696</span><span class="crayon-h"> </span><span
class="crayon-cn">697</span><span class="crayon-h"> </span><span
class="crayon-cn">698</span><span class="crayon-h"> </span><span
class="crayon-cn">699</span><span class="crayon-h"> </span><span
class="crayon-cn">700</span><span class="crayon-h"> </span><span
class="crayon-cn">701</span><span class="crayon-h"> </span><span
class="crayon-cn">702</span><span class="crayon-h"> </span><span
class="crayon-cn">703</span><span class="crayon-h"> </span><span
class="crayon-cn">704</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">705</span><span class="crayon-h"> </span><span
class="crayon-cn">706</span><span class="crayon-h"> </span><span
class="crayon-cn">707</span><span class="crayon-h"> </span><span
class="crayon-cn">708</span><span class="crayon-h"> </span><span
class="crayon-cn">709</span><span class="crayon-h"> </span><span
class="crayon-cn">710</span><span class="crayon-h"> </span><span
class="crayon-cn">711</span><span class="crayon-h"> </span><span
class="crayon-cn">712</span><span class="crayon-h"> </span><span
class="crayon-cn">713</span><span class="crayon-h"> </span><span
class="crayon-cn">714</span><span class="crayon-h"> </span><span
class="crayon-cn">715</span><span class="crayon-h"> </span><span
class="crayon-cn">716</span><span class="crayon-h"> </span><span
class="crayon-cn">717</span><span class="crayon-h"> </span><span
class="crayon-cn">718</span><span class="crayon-h"> </span><span
class="crayon-cn">719</span><span class="crayon-h"> </span><span
class="crayon-cn">720</span><span class="crayon-h"> </span><span
class="crayon-cn">721</span><span class="crayon-h"> </span><span
class="crayon-cn">722</span><span class="crayon-h"> </span><span
class="crayon-cn">723</span><span class="crayon-h"> </span><span
class="crayon-cn">724</span><span class="crayon-h"> </span><span
class="crayon-cn">725</span><span class="crayon-h"> </span><span
class="crayon-cn">726</span><span class="crayon-h"> </span><span
class="crayon-cn">727</span><span class="crayon-h"> </span><span
class="crayon-cn">728</span><span class="crayon-h"> </span><span
class="crayon-cn">729</span><span class="crayon-h"> </span><span
class="crayon-cn">730</span><span class="crayon-h"> </span><span
class="crayon-cn">731</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">732</span><span class="crayon-h"> </span><span
class="crayon-cn">733</span><span class="crayon-h"> </span><span
class="crayon-cn">734</span><span class="crayon-h"> </span><span
class="crayon-cn">735</span><span class="crayon-h"> </span><span
class="crayon-cn">736</span><span class="crayon-h"> </span><span
class="crayon-cn">737</span><span class="crayon-h"> </span><span
class="crayon-cn">738</span><span class="crayon-h"> </span><span
class="crayon-cn">739</span><span class="crayon-h"> </span><span
class="crayon-cn">740</span><span class="crayon-h"> </span><span
class="crayon-cn">741</span><span class="crayon-h"> </span><span
class="crayon-cn">742</span><span class="crayon-h"> </span><span
class="crayon-cn">743</span><span class="crayon-h"> </span><span
class="crayon-cn">744</span><span class="crayon-h"> </span><span
class="crayon-cn">745</span><span class="crayon-h"> </span><span
class="crayon-cn">746</span><span class="crayon-h"> </span><span
class="crayon-cn">747</span><span class="crayon-h"> </span><span
class="crayon-cn">748</span><span class="crayon-h"> </span><span
class="crayon-cn">749</span><span class="crayon-h"> </span><span
class="crayon-cn">750</span><span class="crayon-h"> </span><span
class="crayon-cn">751</span><span class="crayon-h"> </span><span
class="crayon-cn">752</span><span class="crayon-h"> </span><span
class="crayon-cn">753</span><span class="crayon-h"> </span><span
class="crayon-cn">754</span><span class="crayon-h"> </span><span
class="crayon-cn">755</span><span class="crayon-h"> </span><span
class="crayon-cn">756</span><span class="crayon-h"> </span><span
class="crayon-cn">757</span><span class="crayon-h"> </span><span
class="crayon-cn">758</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">759</span><span class="crayon-h"> </span><span
class="crayon-cn">760</span><span class="crayon-h"> </span><span
class="crayon-cn">761</span><span class="crayon-h"> </span><span
class="crayon-cn">762</span><span class="crayon-h"> </span><span
class="crayon-cn">763</span><span class="crayon-h"> </span><span
class="crayon-cn">764</span><span class="crayon-h"> </span><span
class="crayon-cn">765</span><span class="crayon-h"> </span><span
class="crayon-cn">766</span><span class="crayon-h"> </span><span
class="crayon-cn">767</span><span class="crayon-h"> </span><span
class="crayon-cn">768</span><span class="crayon-h"> </span><span
class="crayon-cn">769</span><span class="crayon-h"> </span><span
class="crayon-cn">770</span><span class="crayon-h"> </span><span
class="crayon-cn">771</span><span class="crayon-h"> </span><span
class="crayon-cn">772</span><span class="crayon-h"> </span><span
class="crayon-cn">773</span><span class="crayon-h"> </span><span
class="crayon-cn">774</span><span class="crayon-h"> </span><span
class="crayon-cn">775</span><span class="crayon-h"> </span><span
class="crayon-cn">776</span><span class="crayon-h"> </span><span
class="crayon-cn">777</span><span class="crayon-h"> </span><span
class="crayon-cn">778</span><span class="crayon-h"> </span><span
class="crayon-cn">779</span><span class="crayon-h"> </span><span
class="crayon-cn">780</span><span class="crayon-h"> </span><span
class="crayon-cn">781</span><span class="crayon-h"> </span><span
class="crayon-cn">782</span><span class="crayon-h"> </span><span
class="crayon-cn">783</span><span class="crayon-h"> </span><span
class="crayon-cn">784</span><span class="crayon-h"> </span><span
class="crayon-cn">785</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">786</span><span class="crayon-h"> </span><span
class="crayon-cn">787</span><span class="crayon-h"> </span><span
class="crayon-cn">788</span><span class="crayon-h"> </span><span
class="crayon-cn">789</span><span class="crayon-h"> </span><span
class="crayon-cn">790</span><span class="crayon-h"> </span><span
class="crayon-cn">791</span><span class="crayon-h"> </span><span
class="crayon-cn">792</span><span class="crayon-h"> </span><span
class="crayon-cn">793</span><span class="crayon-h"> </span><span
class="crayon-cn">794</span><span class="crayon-h"> </span><span
class="crayon-cn">795</span><span class="crayon-h"> </span><span
class="crayon-cn">796</span><span class="crayon-h"> </span><span
class="crayon-cn">797</span><span class="crayon-h"> </span><span
class="crayon-cn">798</span><span class="crayon-h"> </span><span
class="crayon-cn">799</span><span class="crayon-h"> </span><span
class="crayon-cn">800</span><span class="crayon-h"> </span><span
class="crayon-cn">801</span><span class="crayon-h"> </span><span
class="crayon-cn">802</span><span class="crayon-h"> </span><span
class="crayon-cn">803</span><span class="crayon-h"> </span><span
class="crayon-cn">804</span><span class="crayon-h"> </span><span
class="crayon-cn">805</span><span class="crayon-h"> </span><span
class="crayon-cn">806</span><span class="crayon-h"> </span><span
class="crayon-cn">807</span><span class="crayon-h"> </span><span
class="crayon-cn">808</span><span class="crayon-h"> </span><span
class="crayon-cn">809</span><span class="crayon-h"> </span><span
class="crayon-cn">810</span><span class="crayon-h"> </span><span
class="crayon-cn">811</span><span class="crayon-h"> </span><span
class="crayon-cn">812</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">813</span><span class="crayon-h"> </span><span
class="crayon-cn">814</span><span class="crayon-h"> </span><span
class="crayon-cn">815</span><span class="crayon-h"> </span><span
class="crayon-cn">816</span><span class="crayon-h"> </span><span
class="crayon-cn">817</span><span class="crayon-h"> </span><span
class="crayon-cn">818</span><span class="crayon-h"> </span><span
class="crayon-cn">819</span><span class="crayon-h"> </span><span
class="crayon-cn">820</span><span class="crayon-h"> </span><span
class="crayon-cn">821</span><span class="crayon-h"> </span><span
class="crayon-cn">822</span><span class="crayon-h"> </span><span
class="crayon-cn">823</span><span class="crayon-h"> </span><span
class="crayon-cn">824</span><span class="crayon-h"> </span><span
class="crayon-cn">825</span><span class="crayon-h"> </span><span
class="crayon-cn">826</span><span class="crayon-h"> </span><span
class="crayon-cn">827</span><span class="crayon-h"> </span><span
class="crayon-cn">828</span><span class="crayon-h"> </span><span
class="crayon-cn">829</span><span class="crayon-h"> </span><span
class="crayon-cn">830</span><span class="crayon-h"> </span><span
class="crayon-cn">831</span><span class="crayon-h"> </span><span
class="crayon-cn">832</span><span class="crayon-h"> </span><span
class="crayon-cn">833</span><span class="crayon-h"> </span><span
class="crayon-cn">834</span><span class="crayon-h"> </span><span
class="crayon-cn">835</span><span class="crayon-h"> </span><span
class="crayon-cn">836</span><span class="crayon-h"> </span><span
class="crayon-cn">837</span><span class="crayon-h"> </span><span
class="crayon-cn">838</span><span class="crayon-h"> </span><span
class="crayon-cn">839</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">840</span><span class="crayon-h"> </span><span
class="crayon-cn">841</span><span class="crayon-h"> </span><span
class="crayon-cn">842</span><span class="crayon-h"> </span><span
class="crayon-cn">843</span><span class="crayon-h"> </span><span
class="crayon-cn">844</span><span class="crayon-h"> </span><span
class="crayon-cn">845</span><span class="crayon-h"> </span><span
class="crayon-cn">846</span><span class="crayon-h"> </span><span
class="crayon-cn">847</span><span class="crayon-h"> </span><span
class="crayon-cn">848</span><span class="crayon-h"> </span><span
class="crayon-cn">849</span><span class="crayon-h"> </span><span
class="crayon-cn">850</span><span class="crayon-h"> </span><span
class="crayon-cn">851</span><span class="crayon-h"> </span><span
class="crayon-cn">852</span><span class="crayon-h"> </span><span
class="crayon-cn">853</span><span class="crayon-h"> </span><span
class="crayon-cn">854</span><span class="crayon-h"> </span><span
class="crayon-cn">855</span><span class="crayon-h"> </span><span
class="crayon-cn">856</span><span class="crayon-h"> </span><span
class="crayon-cn">857</span><span class="crayon-h"> </span><span
class="crayon-cn">858</span><span class="crayon-h"> </span><span
class="crayon-cn">859</span><span class="crayon-h"> </span><span
class="crayon-cn">860</span><span class="crayon-h"> </span><span
class="crayon-cn">861</span><span class="crayon-h"> </span><span
class="crayon-cn">862</span><span class="crayon-h"> </span><span
class="crayon-cn">863</span><span class="crayon-h"> </span><span
class="crayon-cn">864</span><span class="crayon-h"> </span><span
class="crayon-cn">865</span><span class="crayon-h"> </span><span
class="crayon-cn">866</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">867</span><span class="crayon-h"> </span><span
class="crayon-cn">868</span><span class="crayon-h"> </span><span
class="crayon-cn">869</span><span class="crayon-h"> </span><span
class="crayon-cn">870</span><span class="crayon-h"> </span><span
class="crayon-cn">871</span><span class="crayon-h"> </span><span
class="crayon-cn">872</span><span class="crayon-h"> </span><span
class="crayon-cn">873</span><span class="crayon-h"> </span><span
class="crayon-cn">874</span><span class="crayon-h"> </span><span
class="crayon-cn">875</span><span class="crayon-h"> </span><span
class="crayon-cn">876</span><span class="crayon-h"> </span><span
class="crayon-cn">877</span><span class="crayon-h"> </span><span
class="crayon-cn">878</span><span class="crayon-h"> </span><span
class="crayon-cn">879</span><span class="crayon-h"> </span><span
class="crayon-cn">880</span><span class="crayon-h"> </span><span
class="crayon-cn">881</span><span class="crayon-h"> </span><span
class="crayon-cn">882</span><span class="crayon-h"> </span><span
class="crayon-cn">883</span><span class="crayon-h"> </span><span
class="crayon-cn">884</span><span class="crayon-h"> </span><span
class="crayon-cn">885</span><span class="crayon-h"> </span><span
class="crayon-cn">886</span><span class="crayon-h"> </span><span
class="crayon-cn">887</span><span class="crayon-h"> </span><span
class="crayon-cn">888</span><span class="crayon-h"> </span><span
class="crayon-cn">889</span><span class="crayon-h"> </span><span
class="crayon-cn">890</span><span class="crayon-h"> </span><span
class="crayon-cn">891</span><span class="crayon-h"> </span><span
class="crayon-cn">892</span><span class="crayon-h"> </span><span
class="crayon-cn">893</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">894</span><span class="crayon-h"> </span><span
class="crayon-cn">895</span><span class="crayon-h"> </span><span
class="crayon-cn">896</span><span class="crayon-h"> </span><span
class="crayon-cn">897</span><span class="crayon-h"> </span><span
class="crayon-cn">898</span><span class="crayon-h"> </span><span
class="crayon-cn">899</span><span class="crayon-h"> </span><span
class="crayon-cn">900</span><span class="crayon-h"> </span><span
class="crayon-cn">901</span><span class="crayon-h"> </span><span
class="crayon-cn">902</span><span class="crayon-h"> </span><span
class="crayon-cn">903</span><span class="crayon-h"> </span><span
class="crayon-cn">904</span><span class="crayon-h"> </span><span
class="crayon-cn">905</span><span class="crayon-h"> </span><span
class="crayon-cn">906</span><span class="crayon-h"> </span><span
class="crayon-cn">907</span><span class="crayon-h"> </span><span
class="crayon-cn">908</span><span class="crayon-h"> </span><span
class="crayon-cn">909</span><span class="crayon-h"> </span><span
class="crayon-cn">910</span><span class="crayon-h"> </span><span
class="crayon-cn">911</span><span class="crayon-h"> </span><span
class="crayon-cn">912</span><span class="crayon-h"> </span><span
class="crayon-cn">913</span><span class="crayon-h"> </span><span
class="crayon-cn">914</span><span class="crayon-h"> </span><span
class="crayon-cn">915</span><span class="crayon-h"> </span><span
class="crayon-cn">916</span><span class="crayon-h"> </span><span
class="crayon-cn">917</span><span class="crayon-h"> </span><span
class="crayon-cn">918</span><span class="crayon-h"> </span><span
class="crayon-cn">919</span><span class="crayon-h"> </span><span
class="crayon-cn">920</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">921</span><span class="crayon-h"> </span><span
class="crayon-cn">922</span><span class="crayon-h"> </span><span
class="crayon-cn">923</span><span class="crayon-h"> </span><span
class="crayon-cn">924</span><span class="crayon-h"> </span><span
class="crayon-cn">925</span><span class="crayon-h"> </span><span
class="crayon-cn">926</span><span class="crayon-h"> </span><span
class="crayon-cn">927</span><span class="crayon-h"> </span><span
class="crayon-cn">928</span><span class="crayon-h"> </span><span
class="crayon-cn">929</span><span class="crayon-h"> </span><span
class="crayon-cn">930</span><span class="crayon-h"> </span><span
class="crayon-cn">931</span><span class="crayon-h"> </span><span
class="crayon-cn">932</span><span class="crayon-h"> </span><span
class="crayon-cn">933</span><span class="crayon-h"> </span><span
class="crayon-cn">934</span><span class="crayon-h"> </span><span
class="crayon-cn">935</span><span class="crayon-h"> </span><span
class="crayon-cn">936</span><span class="crayon-h"> </span><span
class="crayon-cn">937</span><span class="crayon-h"> </span><span
class="crayon-cn">938</span><span class="crayon-h"> </span><span
class="crayon-cn">939</span><span class="crayon-h"> </span><span
class="crayon-cn">940</span><span class="crayon-h"> </span><span
class="crayon-cn">941</span><span class="crayon-h"> </span><span
class="crayon-cn">942</span><span class="crayon-h"> </span><span
class="crayon-cn">943</span><span class="crayon-h"> </span><span
class="crayon-cn">944</span><span class="crayon-h"> </span><span
class="crayon-cn">945</span><span class="crayon-h"> </span><span
class="crayon-cn">946</span><span class="crayon-h"> </span><span
class="crayon-cn">947</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">948</span><span class="crayon-h"> </span><span
class="crayon-cn">949</span><span class="crayon-h"> </span><span
class="crayon-cn">950</span><span class="crayon-h"> </span><span
class="crayon-cn">951</span><span class="crayon-h"> </span><span
class="crayon-cn">952</span><span class="crayon-h"> </span><span
class="crayon-cn">953</span><span class="crayon-h"> </span><span
class="crayon-cn">954</span><span class="crayon-h"> </span><span
class="crayon-cn">955</span><span class="crayon-h"> </span><span
class="crayon-cn">956</span><span class="crayon-h"> </span><span
class="crayon-cn">957</span><span class="crayon-h"> </span><span
class="crayon-cn">958</span><span class="crayon-h"> </span><span
class="crayon-cn">959</span><span class="crayon-h"> </span><span
class="crayon-cn">960</span><span class="crayon-h"> </span><span
class="crayon-cn">961</span><span class="crayon-h"> </span><span
class="crayon-cn">962</span><span class="crayon-h"> </span><span
class="crayon-cn">963</span><span class="crayon-h"> </span><span
class="crayon-cn">964</span><span class="crayon-h"> </span><span
class="crayon-cn">965</span><span class="crayon-h"> </span><span
class="crayon-cn">966</span><span class="crayon-h"> </span><span
class="crayon-cn">967</span><span class="crayon-h"> </span><span
class="crayon-cn">968</span><span class="crayon-h"> </span><span
class="crayon-cn">969</span><span class="crayon-h"> </span><span
class="crayon-cn">970</span><span class="crayon-h"> </span><span
class="crayon-cn">971</span><span class="crayon-h"> </span><span
class="crayon-cn">972</span><span class="crayon-h"> </span><span
class="crayon-cn">973</span><span class="crayon-h"> </span><span
class="crayon-cn">974</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">975</span><span class="crayon-h"> </span><span
class="crayon-cn">976</span><span class="crayon-h"> </span><span
class="crayon-cn">977</span><span class="crayon-h"> </span><span
class="crayon-cn">978</span><span class="crayon-h"> </span><span
class="crayon-cn">979</span><span class="crayon-h"> </span><span
class="crayon-cn">980</span><span class="crayon-h"> </span><span
class="crayon-cn">981</span><span class="crayon-h"> </span><span
class="crayon-cn">982</span><span class="crayon-h"> </span><span
class="crayon-cn">983</span><span class="crayon-h"> </span><span
class="crayon-cn">984</span><span class="crayon-h"> </span><span
class="crayon-cn">985</span><span class="crayon-h"> </span><span
class="crayon-cn">986</span><span class="crayon-h"> </span><span
class="crayon-cn">987</span><span class="crayon-h"> </span><span
class="crayon-cn">988</span><span class="crayon-h"> </span><span
class="crayon-cn">989</span><span class="crayon-h"> </span><span
class="crayon-cn">990</span><span class="crayon-h"> </span><span
class="crayon-cn">991</span><span class="crayon-h"> </span><span
class="crayon-cn">992</span><span class="crayon-h"> </span><span
class="crayon-cn">993</span><span class="crayon-h"> </span><span
class="crayon-cn">994</span><span class="crayon-h"> </span><span
class="crayon-cn">995</span><span class="crayon-h"> </span><span
class="crayon-cn">996</span><span class="crayon-h"> </span><span
class="crayon-cn">997</span><span class="crayon-h"> </span><span
class="crayon-cn">998</span><span class="crayon-h"> </span><span
class="crayon-cn">999</span><span class="crayon-h"> </span><span
class="crayon-cn">1000</span><span class="crayon-h"> </span><span
class="crayon-cn">1001</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">1002</span><span class="crayon-h"> </span><span
class="crayon-cn">1003</span><span class="crayon-h"> </span><span
class="crayon-cn">1004</span><span class="crayon-h"> </span><span
class="crayon-cn">1005</span><span class="crayon-h"> </span><span
class="crayon-cn">1006</span><span class="crayon-h"> </span><span
class="crayon-cn">1007</span><span class="crayon-h"> </span><span
class="crayon-cn">1008</span><span class="crayon-h"> </span><span
class="crayon-cn">1009</span><span class="crayon-h"> </span><span
class="crayon-cn">1010</span><span class="crayon-h"> </span><span
class="crayon-cn">1011</span><span class="crayon-h"> </span><span
class="crayon-cn">1012</span><span class="crayon-h"> </span><span
class="crayon-cn">1013</span><span class="crayon-h"> </span><span
class="crayon-cn">1014</span><span class="crayon-h"> </span><span
class="crayon-cn">1015</span><span class="crayon-h"> </span><span
class="crayon-cn">1016</span><span class="crayon-h"> </span><span
class="crayon-cn">1017</span><span class="crayon-h"> </span><span
class="crayon-cn">1018</span><span class="crayon-h"> </span><span
class="crayon-cn">1019</span><span class="crayon-h"> </span><span
class="crayon-cn">1020</span><span class="crayon-h"> </span><span
class="crayon-cn">1021</span><span class="crayon-h"> </span><span
class="crayon-cn">1022</span><span class="crayon-h"> </span><span
class="crayon-cn">1023</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">1024</span><span class="crayon-h"> </span><span
class="crayon-cn">1025</span><span class="crayon-h"> </span><span
class="crayon-cn">1026</span><span class="crayon-h"> </span><span
class="crayon-cn">1027</span><span class="crayon-h"> </span><span
class="crayon-cn">1028</span><span class="crayon-h"> </span><span
class="crayon-cn">1029</span><span class="crayon-h"> </span><span
class="crayon-cn">1030</span><span class="crayon-h"> </span><span
class="crayon-cn">1031</span><span class="crayon-h"> </span><span
class="crayon-cn">1032</span><span class="crayon-h"> </span><span
class="crayon-cn">1033</span><span class="crayon-h"> </span><span
class="crayon-cn">1034</span><span class="crayon-h"> </span><span
class="crayon-cn">1035</span><span class="crayon-h"> </span><span
class="crayon-cn">1036</span><span class="crayon-h"> </span><span
class="crayon-cn">1037</span><span class="crayon-h"> </span><span
class="crayon-cn">1038</span><span class="crayon-h"> </span><span
class="crayon-cn">1039</span><span class="crayon-h"> </span><span
class="crayon-cn">1040</span><span class="crayon-h"> </span><span
class="crayon-cn">1041</span><span class="crayon-h"> </span><span
class="crayon-cn">1042</span><span class="crayon-h"> </span><span
class="crayon-cn">1043</span><span class="crayon-h"> </span><span
class="crayon-cn">1044</span><span class="crayon-h"> </span><span
class="crayon-cn">1045</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">1046</span><span class="crayon-h"> </span><span
class="crayon-cn">1047</span><span class="crayon-h"> </span><span
class="crayon-cn">1048</span><span class="crayon-h"> </span><span
class="crayon-cn">1049</span><span class="crayon-h"> </span><span
class="crayon-cn">1050</span><span class="crayon-h"> </span><span
class="crayon-cn">1051</span><span class="crayon-h"> </span><span
class="crayon-cn">1052</span><span class="crayon-h"> </span><span
class="crayon-cn">1053</span><span class="crayon-h"> </span><span
class="crayon-cn">1054</span><span class="crayon-h"> </span><span
class="crayon-cn">1055</span><span class="crayon-h"> </span><span
class="crayon-cn">1056</span><span class="crayon-h"> </span><span
class="crayon-cn">1057</span><span class="crayon-h"> </span><span
class="crayon-cn">1058</span><span class="crayon-h"> </span><span
class="crayon-cn">1059</span><span class="crayon-h"> </span><span
class="crayon-cn">1060</span><span class="crayon-h"> </span><span
class="crayon-cn">1061</span><span class="crayon-h"> </span><span
class="crayon-cn">1062</span><span class="crayon-h"> </span><span
class="crayon-cn">1063</span><span class="crayon-h"> </span><span
class="crayon-cn">1064</span><span class="crayon-h"> </span><span
class="crayon-cn">1065</span><span class="crayon-h"> </span><span
class="crayon-cn">1066</span><span class="crayon-h"> </span><span
class="crayon-cn">1067</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">1068</span><span class="crayon-h"> </span><span
class="crayon-cn">1069</span><span class="crayon-h"> </span><span
class="crayon-cn">1070</span><span class="crayon-h"> </span><span
class="crayon-cn">1071</span><span class="crayon-h"> </span><span
class="crayon-cn">1072</span><span class="crayon-h"> </span><span
class="crayon-cn">1073</span><span class="crayon-h"> </span><span
class="crayon-cn">1074</span><span class="crayon-h"> </span><span
class="crayon-cn">1075</span><span class="crayon-h"> </span><span
class="crayon-cn">1076</span><span class="crayon-h"> </span><span
class="crayon-cn">1077</span><span class="crayon-h"> </span><span
class="crayon-cn">1078</span><span class="crayon-h"> </span><span
class="crayon-cn">1079</span><span class="crayon-h"> </span><span
class="crayon-cn">1080</span><span class="crayon-h"> </span><span
class="crayon-cn">1081</span><span class="crayon-h"> </span><span
class="crayon-cn">1082</span><span class="crayon-h"> </span><span
class="crayon-cn">1083</span><span class="crayon-h"> </span><span
class="crayon-cn">1084</span><span class="crayon-h"> </span><span
class="crayon-cn">1085</span><span class="crayon-h"> </span><span
class="crayon-cn">1086</span><span class="crayon-h"> </span><span
class="crayon-cn">1087</span><span class="crayon-h"> </span><span
class="crayon-cn">1088</span><span class="crayon-h"> </span><span
class="crayon-cn">1089</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">1090</span><span class="crayon-h"> </span><span
class="crayon-cn">1091</span><span class="crayon-h"> </span><span
class="crayon-cn">1092</span><span class="crayon-h"> </span><span
class="crayon-cn">1093</span><span class="crayon-h"> </span><span
class="crayon-cn">1094</span><span class="crayon-h"> </span><span
class="crayon-cn">1095</span><span class="crayon-h"> </span><span
class="crayon-cn">1096</span><span class="crayon-h"> </span><span
class="crayon-cn">1097</span><span class="crayon-h"> </span><span
class="crayon-cn">1098</span><span class="crayon-h"> </span><span
class="crayon-cn">1099</span><span class="crayon-h"> </span><span
class="crayon-cn">1100</span><span class="crayon-h"> </span><span
class="crayon-cn">1101</span><span class="crayon-h"> </span><span
class="crayon-cn">1102</span><span class="crayon-h"> </span><span
class="crayon-cn">1103</span><span class="crayon-h"> </span><span
class="crayon-cn">1104</span><span class="crayon-h"> </span><span
class="crayon-cn">1105</span><span class="crayon-h"> </span><span
class="crayon-cn">1106</span><span class="crayon-h"> </span><span
class="crayon-cn">1107</span><span class="crayon-h"> </span><span
class="crayon-cn">1108</span><span class="crayon-h"> </span><span
class="crayon-cn">1109</span><span class="crayon-h"> </span><span
class="crayon-cn">1110</span><span class="crayon-h"> </span><span
class="crayon-cn">1111</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">1112</span><span class="crayon-h"> </span><span
class="crayon-cn">1113</span><span class="crayon-h"> </span><span
class="crayon-cn">1114</span><span class="crayon-h"> </span><span
class="crayon-cn">1115</span><span class="crayon-h"> </span><span
class="crayon-cn">1116</span><span class="crayon-h"> </span><span
class="crayon-cn">1117</span><span class="crayon-h"> </span><span
class="crayon-cn">1118</span><span class="crayon-h"> </span><span
class="crayon-cn">1119</span><span class="crayon-h"> </span><span
class="crayon-cn">1120</span><span class="crayon-h"> </span><span
class="crayon-cn">1121</span><span class="crayon-h"> </span><span
class="crayon-cn">1122</span><span class="crayon-h"> </span><span
class="crayon-cn">1123</span><span class="crayon-h"> </span><span
class="crayon-cn">1124</span><span class="crayon-h"> </span><span
class="crayon-cn">1125</span><span class="crayon-h"> </span><span
class="crayon-cn">1126</span><span class="crayon-h"> </span><span
class="crayon-cn">1127</span><span class="crayon-h"> </span><span
class="crayon-cn">1128</span><span class="crayon-h"> </span><span
class="crayon-cn">1129</span><span class="crayon-h"> </span><span
class="crayon-cn">1130</span><span class="crayon-h"> </span><span
class="crayon-cn">1131</span><span class="crayon-h"> </span><span
class="crayon-cn">1132</span><span class="crayon-h"> </span><span
class="crayon-cn">1133</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">1134</span><span class="crayon-h"> </span><span
class="crayon-cn">1135</span><span class="crayon-h"> </span><span
class="crayon-cn">1136</span><span class="crayon-h"> </span><span
class="crayon-cn">1137</span><span class="crayon-h"> </span><span
class="crayon-cn">1138</span><span class="crayon-h"> </span><span
class="crayon-cn">1139</span><span class="crayon-h"> </span><span
class="crayon-cn">1140</span><span class="crayon-h"> </span><span
class="crayon-cn">1141</span><span class="crayon-h"> </span><span
class="crayon-cn">1142</span><span class="crayon-h"> </span><span
class="crayon-cn">1143</span><span class="crayon-h"> </span><span
class="crayon-cn">1144</span><span class="crayon-h"> </span><span
class="crayon-cn">1145</span><span class="crayon-h"> </span><span
class="crayon-cn">1146</span><span class="crayon-h"> </span><span
class="crayon-cn">1147</span><span class="crayon-h"> </span><span
class="crayon-cn">1148</span><span class="crayon-h"> </span><span
class="crayon-cn">1149</span><span class="crayon-h"> </span><span
class="crayon-cn">1150</span><span class="crayon-h"> </span><span
class="crayon-cn">1151</span><span class="crayon-h"> </span><span
class="crayon-cn">1152</span><span class="crayon-h"> </span><span
class="crayon-cn">1153</span><span class="crayon-h"> </span><span
class="crayon-cn">1154</span><span class="crayon-h"> </span><span
class="crayon-cn">1155</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">1156</span><span class="crayon-h"> </span><span
class="crayon-cn">1157</span><span class="crayon-h"> </span><span
class="crayon-cn">1158</span><span class="crayon-h"> </span><span
class="crayon-cn">1159</span><span class="crayon-h"> </span><span
class="crayon-cn">1160</span><span class="crayon-h"> </span><span
class="crayon-cn">1161</span><span class="crayon-h"> </span><span
class="crayon-cn">1162</span><span class="crayon-h"> </span><span
class="crayon-cn">1163</span><span class="crayon-h"> </span><span
class="crayon-cn">1164</span><span class="crayon-h"> </span><span
class="crayon-cn">1165</span><span class="crayon-h"> </span><span
class="crayon-cn">1166</span><span class="crayon-h"> </span><span
class="crayon-cn">1167</span><span class="crayon-h"> </span><span
class="crayon-cn">1168</span><span class="crayon-h"> </span><span
class="crayon-cn">1169</span><span class="crayon-h"> </span><span
class="crayon-cn">1170</span><span class="crayon-h"> </span><span
class="crayon-cn">1171</span><span class="crayon-h"> </span><span
class="crayon-cn">1172</span><span class="crayon-h"> </span><span
class="crayon-cn">1173</span><span class="crayon-h"> </span><span
class="crayon-cn">1174</span><span class="crayon-h"> </span><span
class="crayon-cn">1175</span><span class="crayon-h"> </span><span
class="crayon-cn">1176</span><span class="crayon-h"> </span><span
class="crayon-cn">1177</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">1178</span><span class="crayon-h"> </span><span
class="crayon-cn">1179</span><span class="crayon-h"> </span><span
class="crayon-cn">1180</span><span class="crayon-h"> </span><span
class="crayon-cn">1181</span><span class="crayon-h"> </span><span
class="crayon-cn">1182</span><span class="crayon-h"> </span><span
class="crayon-cn">1183</span><span class="crayon-h"> </span><span
class="crayon-cn">1184</span><span class="crayon-h"> </span><span
class="crayon-cn">1185</span><span class="crayon-h"> </span><span
class="crayon-cn">1186</span><span class="crayon-h"> </span><span
class="crayon-cn">1187</span><span class="crayon-h"> </span><span
class="crayon-cn">1188</span><span class="crayon-h"> </span><span
class="crayon-cn">1189</span><span class="crayon-h"> </span><span
class="crayon-cn">1190</span><span class="crayon-h"> </span><span
class="crayon-cn">1191</span><span class="crayon-h"> </span><span
class="crayon-cn">1192</span><span class="crayon-h"> </span><span
class="crayon-cn">1193</span><span class="crayon-h"> </span><span
class="crayon-cn">1194</span><span class="crayon-h"> </span><span
class="crayon-cn">1195</span><span class="crayon-h"> </span><span
class="crayon-cn">1196</span><span class="crayon-h"> </span><span
class="crayon-cn">1197</span><span class="crayon-h"> </span><span
class="crayon-cn">1198</span><span class="crayon-h"> </span><span
class="crayon-cn">1199</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">1200</span><span class="crayon-h"> </span><span
class="crayon-cn">1201</span><span class="crayon-h"> </span><span
class="crayon-cn">1202</span><span class="crayon-h"> </span><span
class="crayon-cn">1203</span><span class="crayon-h"> </span><span
class="crayon-cn">1204</span><span class="crayon-h"> </span><span
class="crayon-cn">1205</span><span class="crayon-h"> </span><span
class="crayon-cn">1206</span><span class="crayon-h"> </span><span
class="crayon-cn">1207</span><span class="crayon-h"> </span><span
class="crayon-cn">1208</span><span class="crayon-h"> </span><span
class="crayon-cn">1209</span><span class="crayon-h"> </span><span
class="crayon-cn">1210</span><span class="crayon-h"> </span><span
class="crayon-cn">1211</span><span class="crayon-h"> </span><span
class="crayon-cn">1212</span><span class="crayon-h"> </span><span
class="crayon-cn">1213</span><span class="crayon-h"> </span><span
class="crayon-cn">1214</span><span class="crayon-h"> </span><span
class="crayon-cn">1215</span><span class="crayon-h"> </span><span
class="crayon-cn">1216</span><span class="crayon-h"> </span><span
class="crayon-cn">1217</span><span class="crayon-h"> </span><span
class="crayon-cn">1218</span><span class="crayon-h"> </span><span
class="crayon-cn">1219</span><span class="crayon-h"> </span><span
class="crayon-cn">1220</span><span class="crayon-h"> </span><span
class="crayon-cn">1221</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">1222</span><span class="crayon-h"> </span><span
class="crayon-cn">1223</span><span class="crayon-h"> </span><span
class="crayon-cn">1224</span><span class="crayon-h"> </span><span
class="crayon-cn">1225</span><span class="crayon-h"> </span><span
class="crayon-cn">1226</span><span class="crayon-h"> </span><span
class="crayon-cn">1227</span><span class="crayon-h"> </span><span
class="crayon-cn">1228</span><span class="crayon-h"> </span><span
class="crayon-cn">1229</span><span class="crayon-h"> </span><span
class="crayon-cn">1230</span><span class="crayon-h"> </span><span
class="crayon-cn">1231</span><span class="crayon-h"> </span><span
class="crayon-cn">1232</span><span class="crayon-h"> </span><span
class="crayon-cn">1233</span><span class="crayon-h"> </span><span
class="crayon-cn">1234</span><span class="crayon-h"> </span><span
class="crayon-cn">1235</span><span class="crayon-h"> </span><span
class="crayon-cn">1236</span><span class="crayon-h"> </span><span
class="crayon-cn">1237</span><span class="crayon-h"> </span><span
class="crayon-cn">1238</span><span class="crayon-h"> </span><span
class="crayon-cn">1239</span><span class="crayon-h"> </span><span
class="crayon-cn">1240</span><span class="crayon-h"> </span><span
class="crayon-cn">1241</span><span class="crayon-h"> </span><span
class="crayon-cn">1242</span><span class="crayon-h"> </span><span
class="crayon-cn">1243</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">1244</span><span class="crayon-h"> </span><span
class="crayon-cn">1245</span><span class="crayon-h"> </span><span
class="crayon-cn">1246</span><span class="crayon-h"> </span><span
class="crayon-cn">1247</span><span class="crayon-h"> </span><span
class="crayon-cn">1248</span><span class="crayon-h"> </span><span
class="crayon-cn">1249</span><span class="crayon-h"> </span><span
class="crayon-cn">1250</span><span class="crayon-h"> </span><span
class="crayon-cn">1251</span><span class="crayon-h"> </span><span
class="crayon-cn">1252</span><span class="crayon-h"> </span><span
class="crayon-cn">1253</span><span class="crayon-h"> </span><span
class="crayon-cn">1254</span><span class="crayon-h"> </span><span
class="crayon-cn">1255</span><span class="crayon-h"> </span><span
class="crayon-cn">1256</span><span class="crayon-h"> </span><span
class="crayon-cn">1257</span><span class="crayon-h"> </span><span
class="crayon-cn">1258</span><span class="crayon-h"> </span><span
class="crayon-cn">1259</span><span class="crayon-h"> </span><span
class="crayon-cn">1260</span><span class="crayon-h"> </span><span
class="crayon-cn">1261</span><span class="crayon-h"> </span><span
class="crayon-cn">1262</span><span class="crayon-h"> </span><span
class="crayon-cn">1263</span><span class="crayon-h"> </span><span
class="crayon-cn">1264</span><span class="crayon-h"> </span><span
class="crayon-cn">1265</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">1266</span><span class="crayon-h"> </span><span
class="crayon-cn">1267</span><span class="crayon-h"> </span><span
class="crayon-cn">1268</span><span class="crayon-h"> </span><span
class="crayon-cn">1269</span><span class="crayon-h"> </span><span
class="crayon-cn">1270</span><span class="crayon-h"> </span><span
class="crayon-cn">1271</span><span class="crayon-h"> </span><span
class="crayon-cn">1272</span><span class="crayon-h"> </span><span
class="crayon-cn">1273</span><span class="crayon-h"> </span><span
class="crayon-cn">1274</span><span class="crayon-h"> </span><span
class="crayon-cn">1275</span><span class="crayon-h"> </span><span
class="crayon-cn">1276</span><span class="crayon-h"> </span><span
class="crayon-cn">1277</span><span class="crayon-h"> </span><span
class="crayon-cn">1278</span><span class="crayon-h"> </span><span
class="crayon-cn">1279</span><span class="crayon-h"> </span><span
class="crayon-cn">1280</span><span class="crayon-h"> </span><span
class="crayon-cn">1281</span><span class="crayon-h"> </span><span
class="crayon-cn">1282</span><span class="crayon-h"> </span><span
class="crayon-cn">1283</span><span class="crayon-h"> </span><span
class="crayon-cn">1284</span><span class="crayon-h"> </span><span
class="crayon-cn">1285</span><span class="crayon-h"> </span><span
class="crayon-cn">1286</span><span class="crayon-h"> </span><span
class="crayon-cn">1287</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">1288</span><span class="crayon-h"> </span><span
class="crayon-cn">1289</span><span class="crayon-h"> </span><span
class="crayon-cn">1290</span><span class="crayon-h"> </span><span
class="crayon-cn">1291</span><span class="crayon-h"> </span><span
class="crayon-cn">1292</span><span class="crayon-h"> </span><span
class="crayon-cn">1293</span><span class="crayon-h"> </span><span
class="crayon-cn">1294</span><span class="crayon-h"> </span><span
class="crayon-cn">1295</span><span class="crayon-h"> </span><span
class="crayon-cn">1296</span><span class="crayon-h"> </span><span
class="crayon-cn">1297</span><span class="crayon-h"> </span><span
class="crayon-cn">1298</span><span class="crayon-h"> </span><span
class="crayon-cn">1299</span><span class="crayon-h"> </span><span
class="crayon-cn">1300</span><span class="crayon-h"> </span><span
class="crayon-cn">1301</span><span class="crayon-h"> </span><span
class="crayon-cn">1302</span><span class="crayon-h"> </span><span
class="crayon-cn">1303</span><span class="crayon-h"> </span><span
class="crayon-cn">1304</span><span class="crayon-h"> </span><span
class="crayon-cn">1305</span><span class="crayon-h"> </span><span
class="crayon-cn">1306</span><span class="crayon-h"> </span><span
class="crayon-cn">1307</span><span class="crayon-h"> </span><span
class="crayon-cn">1308</span><span class="crayon-h"> </span><span
class="crayon-cn">1309</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">1310</span><span class="crayon-h"> </span><span
class="crayon-cn">1311</span><span class="crayon-h"> </span><span
class="crayon-cn">1312</span><span class="crayon-h"> </span><span
class="crayon-cn">1313</span><span class="crayon-h"> </span><span
class="crayon-cn">1314</span><span class="crayon-h"> </span><span
class="crayon-cn">1315</span><span class="crayon-h"> </span><span
class="crayon-cn">1316</span><span class="crayon-h"> </span><span
class="crayon-cn">1317</span><span class="crayon-h"> </span><span
class="crayon-cn">1318</span><span class="crayon-h"> </span><span
class="crayon-cn">1319</span><span class="crayon-h"> </span><span
class="crayon-cn">1320</span><span class="crayon-h"> </span><span
class="crayon-cn">1321</span><span class="crayon-h"> </span><span
class="crayon-cn">1322</span><span class="crayon-h"> </span><span
class="crayon-cn">1323</span><span class="crayon-h"> </span><span
class="crayon-cn">1324</span><span class="crayon-h"> </span><span
class="crayon-cn">1325</span><span class="crayon-h"> </span><span
class="crayon-cn">1326</span><span class="crayon-h"> </span><span
class="crayon-cn">1327</span><span class="crayon-h"> </span><span
class="crayon-cn">1328</span><span class="crayon-h"> </span><span
class="crayon-cn">1329</span><span class="crayon-h"> </span><span
class="crayon-cn">1330</span><span class="crayon-h"> </span><span
class="crayon-cn">1331</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">1332</span><span class="crayon-h"> </span><span
class="crayon-cn">1333</span><span class="crayon-h"> </span><span
class="crayon-cn">1334</span><span class="crayon-h"> </span><span
class="crayon-cn">1335</span><span class="crayon-h"> </span><span
class="crayon-cn">1336</span><span class="crayon-h"> </span><span
class="crayon-cn">1337</span><span class="crayon-h"> </span><span
class="crayon-cn">1338</span><span class="crayon-h"> </span><span
class="crayon-cn">1339</span><span class="crayon-h"> </span><span
class="crayon-cn">1340</span><span class="crayon-h"> </span><span
class="crayon-cn">1341</span><span class="crayon-h"> </span><span
class="crayon-cn">1342</span><span class="crayon-h"> </span><span
class="crayon-cn">1343</span><span class="crayon-h"> </span><span
class="crayon-cn">1344</span><span class="crayon-h"> </span><span
class="crayon-cn">1345</span><span class="crayon-h"> </span><span
class="crayon-cn">1346</span><span class="crayon-h"> </span><span
class="crayon-cn">1347</span><span class="crayon-h"> </span><span
class="crayon-cn">1348</span><span class="crayon-h"> </span><span
class="crayon-cn">1349</span><span class="crayon-h"> </span><span
class="crayon-cn">1350</span><span class="crayon-h"> </span><span
class="crayon-cn">1351</span><span class="crayon-h"> </span><span
class="crayon-cn">1352</span><span class="crayon-h"> </span><span
class="crayon-cn">1353</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">1354</span><span class="crayon-h"> </span><span
class="crayon-cn">1355</span><span class="crayon-h"> </span><span
class="crayon-cn">1356</span><span class="crayon-h"> </span><span
class="crayon-cn">1357</span><span class="crayon-h"> </span><span
class="crayon-cn">1358</span><span class="crayon-h"> </span><span
class="crayon-cn">1359</span><span class="crayon-h"> </span><span
class="crayon-cn">1360</span><span class="crayon-h"> </span><span
class="crayon-cn">1361</span><span class="crayon-h"> </span><span
class="crayon-cn">1362</span><span class="crayon-h"> </span><span
class="crayon-cn">1363</span><span class="crayon-h"> </span><span
class="crayon-cn">1364</span><span class="crayon-h"> </span><span
class="crayon-cn">1365</span><span class="crayon-h"> </span><span
class="crayon-cn">1366</span><span class="crayon-h"> </span><span
class="crayon-cn">1367</span><span class="crayon-h"> </span><span
class="crayon-cn">1368</span><span class="crayon-h"> </span><span
class="crayon-cn">1369</span><span class="crayon-h"> </span><span
class="crayon-cn">1370</span><span class="crayon-h"> </span><span
class="crayon-cn">1371</span><span class="crayon-h"> </span><span
class="crayon-cn">1372</span><span class="crayon-h"> </span><span
class="crayon-cn">1373</span><span class="crayon-h"> </span><span
class="crayon-cn">1374</span><span class="crayon-h"> </span><span
class="crayon-cn">1375</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">1376</span><span class="crayon-h"> </span><span
class="crayon-cn">1377</span><span class="crayon-h"> </span><span
class="crayon-cn">1378</span><span class="crayon-h"> </span><span
class="crayon-cn">1379</span><span class="crayon-h"> </span><span
class="crayon-cn">1380</span><span class="crayon-h"> </span><span
class="crayon-cn">1381</span><span class="crayon-h"> </span><span
class="crayon-cn">1382</span><span class="crayon-h"> </span><span
class="crayon-cn">1383</span><span class="crayon-h"> </span><span
class="crayon-cn">1384</span><span class="crayon-h"> </span><span
class="crayon-cn">1385</span><span class="crayon-h"> </span><span
class="crayon-cn">1386</span><span class="crayon-h"> </span><span
class="crayon-cn">1387</span><span class="crayon-h"> </span><span
class="crayon-cn">1388</span><span class="crayon-h"> </span><span
class="crayon-cn">1389</span><span class="crayon-h"> </span><span
class="crayon-cn">1390</span><span class="crayon-h"> </span><span
class="crayon-cn">1391</span><span class="crayon-h"> </span><span
class="crayon-cn">1392</span><span class="crayon-h"> </span><span
class="crayon-cn">1393</span><span class="crayon-h"> </span><span
class="crayon-cn">1394</span><span class="crayon-h"> </span><span
class="crayon-cn">1395</span><span class="crayon-h"> </span><span
class="crayon-cn">1396</span><span class="crayon-h"> </span><span
class="crayon-cn">1397</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">1398</span><span class="crayon-h"> </span><span
class="crayon-cn">1399</span><span class="crayon-h"> </span><span
class="crayon-cn">1400</span><span class="crayon-h"> </span><span
class="crayon-cn">1401</span><span class="crayon-h"> </span><span
class="crayon-cn">1402</span><span class="crayon-h"> </span><span
class="crayon-cn">1403</span><span class="crayon-h"> </span><span
class="crayon-cn">1404</span><span class="crayon-h"> </span><span
class="crayon-cn">1405</span><span class="crayon-h"> </span><span
class="crayon-cn">1406</span><span class="crayon-h"> </span><span
class="crayon-cn">1407</span><span class="crayon-h"> </span><span
class="crayon-cn">1408</span><span class="crayon-h"> </span><span
class="crayon-cn">1409</span><span class="crayon-h"> </span><span
class="crayon-cn">1410</span><span class="crayon-h"> </span><span
class="crayon-cn">1411</span><span class="crayon-h"> </span><span
class="crayon-cn">1412</span><span class="crayon-h"> </span><span
class="crayon-cn">1413</span><span class="crayon-h"> </span><span
class="crayon-cn">1414</span><span class="crayon-h"> </span><span
class="crayon-cn">1415</span><span class="crayon-h"> </span><span
class="crayon-cn">1416</span><span class="crayon-h"> </span><span
class="crayon-cn">1417</span><span class="crayon-h"> </span><span
class="crayon-cn">1418</span><span class="crayon-h"> </span><span
class="crayon-cn">1419</span>

<span class="crayon-h">                  </span><span
class="crayon-e">Docs</span>

<span class="crayon-i">Terms</span><span
class="crayon-h">              </span><span
class="crayon-cn">1420</span><span class="crayon-h"> </span><span
class="crayon-cn">1421</span><span class="crayon-h"> </span><span
class="crayon-cn">1422</span><span class="crayon-h"> </span><span
class="crayon-cn">1423</span><span class="crayon-h"> </span><span
class="crayon-cn">1424</span><span class="crayon-h"> </span><span
class="crayon-cn">1425</span>

<span class="crayon-h"> </span><span class="crayon-sy">\[</span><span
class="crayon-h"> </span><span class="crayon-e">reached </span><span
class="crayon-e">getOption</span><span class="crayon-sy">(</span><span
class="crayon-s">"max.print"</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">--</span><span
class="crayon-h"> </span><span class="crayon-i">omitted</span><span
class="crayon-h"> </span><span class="crayon-cn">32</span><span
class="crayon-h"> </span><span class="crayon-i">rows</span><span
class="crayon-h"> </span><span class="crayon-sy">\]</span>

</td>
</tr>
</table>

<p>
</p>
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
dim(df)
</textarea>

<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
1

</td>
<td class="crayon-code">
<span class="crayon-e">dim</span><span class="crayon-sy">(</span><span
class="crayon-v">df</span><span class="crayon-sy">)</span>

</td>
</tr>
</table>

<p>
</p>
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
\[1\] 32 1425
</textarea>

<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
1

</td>
<td class="crayon-code">
<span class="crayon-sy">\[</span><span
class="crayon-cn">1</span><span class="crayon-sy">\]</span><span
class="crayon-h">   </span><span class="crayon-cn">32</span><span
class="crayon-h"> </span><span class="crayon-cn">1425</span>

</td>
</tr>
</table>

<p>
</p>
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
df.scale &lt;- scale(df) d &lt;- dist(df.scale, method = "euclidean")
fit.ward2 &lt;- hclust(d, method = "ward.D2") plot(fit.ward2,
main="Clusterização Hierárquica- MBL", xlab = "De 17/09/2016 a
17/11/2016") rect.hclust(fit.ward2, k=8)
</textarea>

<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
1

2

3

4

5

</td>
<td class="crayon-code">
<span class="crayon-v">df</span><span class="crayon-sy">.</span><span
class="crayon-v">scale</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-e">scale</span><span
class="crayon-sy">(</span><span class="crayon-v">df</span><span
class="crayon-sy">)</span>

<span class="crayon-v">d</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-e">dist</span><span
class="crayon-sy">(</span><span class="crayon-v">df</span><span
class="crayon-sy">.</span><span class="crayon-v">scale</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">method</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"euclidean"</span><span class="crayon-sy">)</span>

<span class="crayon-v">fit</span><span class="crayon-sy">.</span><span
class="crayon-v">ward2</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-e">hclust</span><span
class="crayon-sy">(</span><span class="crayon-v">d</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">method</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"ward.D2"</span><span class="crayon-sy">)</span>

<span class="crayon-e">plot</span><span class="crayon-sy">(</span><span
class="crayon-v">fit</span><span class="crayon-sy">.</span><span
class="crayon-v">ward2</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">main</span><span
class="crayon-o">=</span><span class="crayon-s">"Clusterização
Hierárquica- MBL"</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">xlab</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-s">"De 17/09/2016 a
17/11/2016"</span><span class="crayon-sy">)</span>

<span class="crayon-v">rect</span><span class="crayon-sy">.</span><span
class="crayon-e">hclust</span><span class="crayon-sy">(</span><span
class="crayon-v">fit</span><span class="crayon-sy">.</span><span
class="crayon-v">ward2</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">k</span><span
class="crayon-o">=</span><span class="crayon-cn">8</span><span
class="crayon-sy">)</span>

</td>
</tr>
</table>

<p>
<a href="http://ibpad.com.br/wp-content/uploads/2016/11/facebook-mbl2.png"><img class="aligncenter size-full wp-image-1798" src="https://ibpad.com.br/wp-content/uploads/2016/11/facebook-mbl2.png" alt="facebook-mbl2" width="650" height="401"></a>
</p>
<p>
Tanto na nuvem de palavras quanto no dendograma é posível observar dois
sites, a saber, a loja da MBL e um site PayPal para fazer doações para a
organização. Além desses sites, outros dois aparecem com grande
frequência (foram retirados da nuvem e do dendograma por serem
excessivamente grandes): um deles para inscrições no congresso nacional
do MBL e outro para doações financeiras para o mesmo congresso através
da plataforma kickante.
</p>
<p>
Para além de palavras como <strong>movimento, brasil, livre,
mbl</strong> que caracterizam a organização, percebemos que
<strong>Lula</strong> também recebe grande atenção nas postagens (tanto
quanto o nome da organização em quantidade). Há um <em>cluster</em>
apenas com a palavra <strong>contra</strong> indicando um posicionamento
político específico, outro <em>cluster</em> com o nome do político
recém-eleito <strong>Fernando Holiday</strong> e um grande
<em>cluster</em> com as palavras <strong>dilma, esquerda,
petistas</strong> e com as palavras <strong>congresso, nacional,
colabore, participe</strong>.
</p>
<p>
O MBL parece claramente chamar a atenção para seu congresso nacional
convidando as pessoas a participarem e também com reiterados pedidos de
ajuda financeira. Ao mesmo tempo, se posicionam contra o movimento de
esquerda brasileiro. A palavra <strong>escolas</strong> sugere um
posicionamento também contra as ocupações estudantis.
</p>
<p>
Usaremos a matriz <em>termos X documentos</em> gerada pela clusterização
hierárquica para elaborar uma rede semântica.
</p>
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
matriz &lt;- as.matrix(df) g = graph\_from\_incidence\_matrix(matriz) p
= bipartite\_projection(g, which = "FALSE")
V(p)$shape = "none" deg = degree(p) plot(p, vertex.label.cex=deg/35, edge.width=(E(p)$weight)/10,
edge.color=adjustcolor("grey60", .5),
vertex.label.color=adjustcolor("\#005d26", .7), main = "Facebook - MBL",
xlab = "De 17/09/2016 a 17/11/2016")
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

</td>
<td class="crayon-code">
<span class="crayon-v">matriz</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-st">as</span><span
class="crayon-sy">.</span><span class="crayon-e">matrix</span><span
class="crayon-sy">(</span><span class="crayon-v">df</span><span
class="crayon-sy">)</span>

<span class="crayon-v">g</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-e">graph\_from\_incidence\_matrix</span><span
class="crayon-sy">(</span><span class="crayon-v">matriz</span><span
class="crayon-sy">)</span>

<span class="crayon-v">p</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-e">bipartite\_projection</span><span
class="crayon-sy">(</span><span class="crayon-v">g</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">which</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"FALSE"</span><span class="crayon-sy">)</span>

<span class="crayon-e">V</span><span class="crayon-sy">(</span><span
class="crayon-v">p</span><span class="crayon-sy">)</span><span
class="crayon-sy">$&lt;/span&gt;&lt;span class="crayon-v"&gt;shape&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;=&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-s"&gt;"none"&lt;/span&gt; &lt;/div&gt; &lt;div class="crayon-line" id="crayon-5a5818d00ba8f003244572-5"&gt; &lt;span class="crayon-v"&gt;deg&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;=&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-e"&gt;degree&lt;/span&gt;&lt;span class="crayon-sy"&gt;(&lt;/span&gt;&lt;span class="crayon-v"&gt;p&lt;/span&gt;&lt;span class="crayon-sy"&gt;)&lt;/span&gt; &lt;/div&gt; &lt;div class="crayon-line crayon-striped-line" id="crayon-5a5818d00ba8f003244572-6"&gt; &lt;span class="crayon-e"&gt;plot&lt;/span&gt;&lt;span class="crayon-sy"&gt;(&lt;/span&gt;&lt;span class="crayon-v"&gt;p&lt;/span&gt;&lt;span class="crayon-sy"&gt;,&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-v"&gt;vertex&lt;/span&gt;&lt;span class="crayon-sy"&gt;.&lt;/span&gt;&lt;span class="crayon-v"&gt;label&lt;/span&gt;&lt;span class="crayon-sy"&gt;.&lt;/span&gt;&lt;span class="crayon-v"&gt;cex&lt;/span&gt;&lt;span class="crayon-o"&gt;=&lt;/span&gt;&lt;span class="crayon-v"&gt;deg&lt;/span&gt;&lt;span class="crayon-o"&gt;/&lt;/span&gt;&lt;span class="crayon-cn"&gt;35&lt;/span&gt;&lt;span class="crayon-sy"&gt;,&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-v"&gt;edge&lt;/span&gt;&lt;span class="crayon-sy"&gt;.&lt;/span&gt;&lt;span class="crayon-v"&gt;width&lt;/span&gt;&lt;span class="crayon-o"&gt;=&lt;/span&gt;&lt;span class="crayon-sy"&gt;(&lt;/span&gt;&lt;span class="crayon-e"&gt;E&lt;/span&gt;&lt;span class="crayon-sy"&gt;(&lt;/span&gt;&lt;span class="crayon-v"&gt;p&lt;/span&gt;&lt;span class="crayon-sy"&gt;)&lt;/span&gt;&lt;span class="crayon-sy"&gt;$</span><span
class="crayon-v">weight</span><span class="crayon-sy">)</span><span
class="crayon-o">/</span><span class="crayon-cn">10</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span>

<span class="crayon-h">     </span><span
class="crayon-v">edge</span><span class="crayon-sy">.</span><span
class="crayon-v">color</span><span class="crayon-o">=</span><span
class="crayon-e">adjustcolor</span><span class="crayon-sy">(</span><span
class="crayon-s">"grey60"</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-sy">.</span><span
class="crayon-cn">5</span><span class="crayon-sy">)</span><span
class="crayon-sy">,</span>

<span class="crayon-h">     </span><span
class="crayon-v">vertex</span><span class="crayon-sy">.</span><span
class="crayon-v">label</span><span class="crayon-sy">.</span><span
class="crayon-v">color</span><span class="crayon-o">=</span><span
class="crayon-e">adjustcolor</span><span class="crayon-sy">(</span><span
class="crayon-s">"\#005d26"</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-sy">.</span><span
class="crayon-cn">7</span><span class="crayon-sy">)</span><span
class="crayon-sy">,</span>

<span class="crayon-h">     </span><span
class="crayon-v">main</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"Facebook - MBL"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">xlab</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"De 17/09/2016 a 17/11/2016"</span><span
class="crayon-sy">)</span>

</td>
</tr>
</table>

<p>
<a href="http://ibpad.com.br/wp-content/uploads/2016/11/facebook-mbl3.png"><img class="aligncenter size-full wp-image-1799" src="https://ibpad.com.br/wp-content/uploads/2016/11/facebook-mbl3.png" alt="facebook-mbl3" width="650" height="401"></a>
</p>
<h3>
Comentários
</h3>
<p>
Vamos olhar agora para os comentários na página da MBL.
</p>
<div id="crayon-5a5818d00ba92640988669" class="crayon-syntax crayon-theme-classic crayon-font-monaco crayon-os-pc print-yes notranslate" data-settings=" minimize scroll-mouseover" style=" margin-top: 12px; margin-bottom: 12px; font-size: 12px !important; line-height: 15px !important;">
<span class="crayon-title"></span>

<div class="crayon-plain-wrap">
<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
comments\_mbl =
MBL*c**o**m**m**e**n**t*<sub>*m*</sub>*e**s**s**a**g**e*</span><span
class="crayon-v">comment\_message</span><span class="crayon-h">
</span><span class="crayon-o">%</span><span
class="crayon-o">&gt;</span><span class="crayon-o">%</span><span
class="crayon-h"> </span><span class="crayon-e">unique</span>
</div>
<span class="crayon-v">mblc</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-e">Corpus</span><span class="crayon-sy">(</span><span
class="crayon-e">VectorSource</span><span
class="crayon-sy">(</span><span
class="crayon-v">comments\_mbl</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span>

<span class="crayon-v">mblc</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-e">tm\_map</span><span
class="crayon-sy">(</span><span class="crayon-v">mblc</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-e">content\_transformer</span><span
class="crayon-sy">(</span><span class="crayon-v">tolower</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span>

<span class="crayon-v">mblc</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-e">tm\_map</span><span
class="crayon-sy">(</span><span class="crayon-v">mblc</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">removePunctuation</span><span
class="crayon-sy">)</span>

<span class="crayon-v">mblc</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-e">tm\_map</span><span
class="crayon-sy">(</span><span class="crayon-v">mblc</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-t">function</span><span class="crayon-sy">(</span><span
class="crayon-v">x</span><span class="crayon-sy">)</span><span
class="crayon-e">removeWords</span><span class="crayon-sy">(</span><span
class="crayon-v">x</span><span class="crayon-sy">,</span><span
class="crayon-e">stopwords</span><span class="crayon-sy">(</span><span
class="crayon-s">"pt"</span><span class="crayon-sy">)</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span>

<span class="crayon-v">mblc</span><span class="crayon-h"> </span><span
class="crayon-o">&lt;</span><span class="crayon-o">-</span><span
class="crayon-h"> </span><span class="crayon-e">tm\_map</span><span
class="crayon-sy">(</span><span class="crayon-v">mblc</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-t">function</span><span class="crayon-sy">(</span><span
class="crayon-v">x</span><span class="crayon-sy">)</span><span
class="crayon-e">removeWords</span><span class="crayon-sy">(</span><span
class="crayon-v">x</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-e">c</span><span
class="crayon-sy">(</span><span
class="crayon-s">'httpswwwkickantecombrcampanhasiicongressonacionaldomovimentobrasillivre'</span><span
class="crayon-sy">,</span>

<span class="crayon-h">                                                
</span><span
class="crayon-s">'httpswwwsymplacombriicongressonacionaldomovimentobrasillivre96736'</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span><span
class="crayon-sy">)</span>

<span class="crayon-v">pal</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">brewer</span><span class="crayon-sy">.</span><span
class="crayon-e">pal</span><span class="crayon-sy">(</span><span
class="crayon-cn">5</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-s">"Set2"</span><span
class="crayon-sy">)</span>

<span class="crayon-p">\# Nuvem de palavras</span>

<span class="crayon-e">wordcloud</span><span
class="crayon-sy">(</span><span class="crayon-v">mblc</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">min</span><span class="crayon-sy">.</span><span
class="crayon-v">freq</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-cn">3</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">max</span><span
class="crayon-sy">.</span><span class="crayon-v">words</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-cn">100</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">random</span><span class="crayon-sy">.</span><span
class="crayon-v">order</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">F</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">colors</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-v">pal</span><span
class="crayon-sy">)</span>

<span class="crayon-e">title</span><span class="crayon-sy">(</span><span
class="crayon-v">xlab</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"Facebook - MBL - Comments17/09/2016 a
17/11/2016"</span><span class="crayon-sy">)</span>

</div>
</td>
</tr>
</table>
</div>
</div>
<p>
<a href="http://ibpad.com.br/wp-content/uploads/2016/11/facebook-mbl4.png"><img class="aligncenter size-full wp-image-1800" src="https://ibpad.com.br/wp-content/uploads/2016/11/facebook-mbl4.png" alt="facebook-mbl4" width="650" height="401"></a>
</p>
<p>
A nuvem de palavras dos comentários do MBL também é bastante parecida
com a nuvem das postagens. Vamos investigar o fluxo de comentários no
tempo.
</p>
<div id="crayon-5a5818d00ba94059879787" class="crayon-syntax crayon-theme-classic crayon-font-monaco crayon-os-pc print-yes notranslate" data-settings=" minimize scroll-mouseover" style=" margin-top: 12px; margin-bottom: 12px; font-size: 12px !important; line-height: 15px !important;">
<span class="crayon-title"></span>

<div class="crayon-plain-wrap">
<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
MBL*c**o**m**m**e**n**t*<sub>*d*</sub>*a**t**e* = *y**m**d*<sub>*h*</sub>*m**s*(*M**B**L*comment\_published)
MBL*c**o**m**m**e**n**t*<sub>*d*</sub>*a**t**e* = *r**o**u**n**d*<sub>*d*</sub>*a**t**e*(*M**B**L*comment\_date,
'day') datas =
as.data.frame(table(MBL*c**o**m**m**e**n**t*<sub>*d*</sub>*a**t**e*),*s**t**r**i**n**g**s**A**s**F**a**c**t**o**r**s* = *F*)*d**a**t**a**s*Var1
=
as.Date(datas*V**a**r*1)*l**i**m**i**t**s* = *y**m**d*(*c*(20160916, 20161118))</span><span
class="crayon-v">comment\_date</span><span class="crayon-h">
</span><span class="crayon-o">=</span><span class="crayon-h">
</span><span class="crayon-e">ymd\_hms</span><span
class="crayon-sy">(</span><span class="crayon-v">MBL</span><span
class="crayon-sy">$&lt;/span&gt;&lt;span class="crayon-v"&gt;comment\_published&lt;/span&gt;&lt;span class="crayon-sy"&gt;)&lt;/span&gt; &lt;/div&gt; &lt;div class="crayon-line crayon-striped-line" id="crayon-5a5818d00ba94059879787-2"&gt; &lt;span class="crayon-v"&gt;MBL&lt;/span&gt;&lt;span class="crayon-sy"&gt;$</span><span
class="crayon-v">comment\_date</span><span class="crayon-h">
</span><span class="crayon-o">=</span><span class="crayon-h">
</span><span class="crayon-e">round\_date</span><span
class="crayon-sy">(</span><span class="crayon-v">MBL</span><span
class="crayon-sy">$&lt;/span&gt;&lt;span class="crayon-v"&gt;comment\_date&lt;/span&gt;&lt;span class="crayon-sy"&gt;,&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-s"&gt;'day'&lt;/span&gt;&lt;span class="crayon-sy"&gt;)&lt;/span&gt; &lt;/div&gt; &lt;div class="crayon-line" id="crayon-5a5818d00ba94059879787-3"&gt; &lt;span class="crayon-v"&gt;datas&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;=&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-st"&gt;as&lt;/span&gt;&lt;span class="crayon-sy"&gt;.&lt;/span&gt;&lt;span class="crayon-v"&gt;data&lt;/span&gt;&lt;span class="crayon-sy"&gt;.&lt;/span&gt;&lt;span class="crayon-e"&gt;frame&lt;/span&gt;&lt;span class="crayon-sy"&gt;(&lt;/span&gt;&lt;span class="crayon-e"&gt;table&lt;/span&gt;&lt;span class="crayon-sy"&gt;(&lt;/span&gt;&lt;span class="crayon-v"&gt;MBL&lt;/span&gt;&lt;span class="crayon-sy"&gt;$</span><span
class="crayon-v">comment\_date</span><span
class="crayon-sy">)</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span
class="crayon-v">stringsAsFactors</span><span class="crayon-h">
</span><span class="crayon-o">=</span><span class="crayon-h">
</span><span class="crayon-v">F</span><span class="crayon-sy">)</span>
</div>
<span class="crayon-v">datas</span><span
class="crayon-sy">$&lt;/span&gt;&lt;span class="crayon-v"&gt;Var1&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-o"&gt;=&lt;/span&gt;&lt;span class="crayon-h"&gt; &lt;/span&gt;&lt;span class="crayon-st"&gt;as&lt;/span&gt;&lt;span class="crayon-sy"&gt;.&lt;/span&gt;&lt;span class="crayon-e"&gt;Date&lt;/span&gt;&lt;span class="crayon-sy"&gt;(&lt;/span&gt;&lt;span class="crayon-v"&gt;datas&lt;/span&gt;&lt;span class="crayon-sy"&gt;$</span><span
class="crayon-v">Var1</span><span class="crayon-sy">)</span>

<span class="crayon-v">limits</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-e">ymd</span><span class="crayon-sy">(</span><span
class="crayon-e">c</span><span class="crayon-sy">(</span><span
class="crayon-cn">20160916</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-cn">20161118</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">%</span><span
class="crayon-o">&gt;</span><span class="crayon-o">%</span><span
class="crayon-h"> </span><span class="crayon-st">as</span><span
class="crayon-sy">.</span><span class="crayon-e">Date</span>

<span class="crayon-e">ggplot</span><span
class="crayon-sy">(</span><span class="crayon-v">datas</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-e">aes</span><span class="crayon-sy">(</span><span
class="crayon-v">x</span><span class="crayon-o">=</span><span
class="crayon-v">Var1</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">y</span><span
class="crayon-o">=</span><span class="crayon-v">Freq</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span><span
class="crayon-o">+</span><span class="crayon-e">geom\_line</span><span
class="crayon-sy">(</span><span class="crayon-sy">)</span><span
class="crayon-o">+</span><span
class="crayon-e">scale\_x\_date</span><span
class="crayon-sy">(</span><span
class="crayon-v">date\_minor\_breaks</span><span class="crayon-h">
</span><span class="crayon-o">=</span><span class="crayon-h">
</span><span class="crayon-s">'1 day'</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">date\_breaks</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">'1 week'</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-v">date\_labels</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-s">'%d-%m'</span><span
class="crayon-sy">,</span><span class="crayon-h">  </span><span
class="crayon-v">limits</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">limits</span><span class="crayon-sy">)</span><span
class="crayon-o">+</span>

<span class="crayon-h">  </span><span class="crayon-e">labs</span><span
class="crayon-sy">(</span><span class="crayon-v">x</span><span
class="crayon-o">=</span><span class="crayon-s">'MBL'</span><span
class="crayon-sy">,</span><span class="crayon-v">y</span><span
class="crayon-o">=</span><span class="crayon-s">'Número de
Comentários'</span><span class="crayon-sy">)</span>

</div>
</td>
</tr>
</table>
</div>
</div>
<p>
<a href="http://ibpad.com.br/wp-content/uploads/2016/11/facebook-mbl5.png"><img class="aligncenter size-full wp-image-1801" src="https://ibpad.com.br/wp-content/uploads/2016/11/facebook-mbl5.png" alt="facebook-mbl5" width="650" height="401"></a>
</p>
<p>
É possível perceber que a página da MBL possui uma movimentação bem
maior em relação à pagina da UNE. Os comentários giram em torno dos 2500
comentários com apenas um pico no último dia registrado (17/11).
</p>

<h2>
Por fim…
</h2>
<p>
A página da MBL possui uma quantidade maior de comentários em relação à
UNE e também possui uma regularidade maior nesses comentários. Mais
pessoas interajem regularmente com essa página. Os pedidos constantes de
ajuda financeira e as propagandas sempre presentes do congresso nacional
do MBL e de sua loja de <em>souvenirs </em>onde vendem camisetas com os
dizeres “O Brasil venceu o PT”, “Eu derrotei o PT”, “Fora PT”, algumas
autografadas pelo apresentador Danilo Gentilli, canecas com a foto do
juiz Sérgio Moro, dentre outros.
</p>
<p>
A página da UNE, por sua vez, tem menos comentários e menos postagens.
Suas postagens convergem para a temática das ocupações e da resistência
contra a PEC 55 e a MP do ensino médio. Apesar de haver na página
pedidos de auxílio financeiro, esses parecem ser mais esporádicos em
comparação com o MBL. Parece não haver vendas de <em>souvenirs</em>.
</p>

</div>
</div>

