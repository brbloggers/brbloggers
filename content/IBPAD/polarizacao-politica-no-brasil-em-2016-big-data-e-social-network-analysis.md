+++
title = "A polarização política no Brasil em 2016 – Big Data e Social Network Analysis"
date = "2016-11-21 15:21:22"
categories = ["IBPAD"]
original_url = "http://www.ibpad.com.br/blog/analise-de-dados/polarizacao-politica-no-brasil-em-2016-big-data-e-social-network-analysis/"
+++

<p style="text-align: right; padding-left: 180px;">
<em>\[Texto do prof.
<a href="http://neylsoncrepalde.github.io/" target="_blank">Neylson
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
<pre class="crayon-plain-tag"># Carregando os pacotes necessários
library(magrittr)
library(readr)
library(descr)
library(tm)
library(wordcloud)
library(igraph)
library(lubridate)
library(ggplot2)</pre>
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
<a href="http://neylsoncrepalde.github.io/2016-03-18-analise-de-conteudo-twitter/" target="_blank">aqui</a>.
</p>
<pre class="crayon-plain-tag">UNE = read_tsv('/home/neylson/Documentos/Neylson Crepalde/Doutorado/UNE_MBL/UNE/page_241149405912525_2016_11_18_02_59_37_comments.tab')
posts_une = UNE$post_text %&gt;% unique
# identificando alguns assuntos
unep = Corpus(VectorSource(posts_une))
unep &lt;- tm_map(unep, content_transformer(tolower))
unep &lt;- tm_map(unep, removePunctuation)
unep &lt;- tm_map(unep, function(x)removeWords(x,stopwords("pt")))
unep &lt;- tm_map(unep, function(x)removeWords(x, 'campus'))
pal = brewer.pal(5, "Set2")
# Nuvem de palavras
wordcloud(unep, min.freq = 3, max.words = 100, random.order = F, colors = pal)
title(xlab = "Facebook - UNE\nDe 17/09/2016 a 17/11/2016")</pre>
<p>
<a href="https://i1.wp.com/ibpad.com.br/wp-content/uploads/2016/11/facebook-une.png"><img data-attachment-id="1792" data-permalink="http://www.ibpad.com.br/blog/about-page-with-gallery/" data-orig-file="" data-orig-size="" data-comments-opened="0" data-image-meta="[]" data-image-title="About Page With Gallery" data-image-description="&lt;p&gt;[vc_row][vc_column width=&quot;1/4&quot;][vc_single_image image=&quot;1793&quot; img_size=&quot;full&quot; style=&quot;vc_box_rounded&quot;][vc_single_image image=&quot;1794&quot; img_size=&quot;full&quot; style=&quot;vc_box_rounded&quot;][/vc_column][vc_column width=&quot;3/4&quot;][vc_custom_heading text=&quot;Restructuring State Enterprises&quot; font_container=&quot;tag:h1|text_align:left&quot; use_theme_fonts=&quot;yes&quot;][vc_column_text]A business, also known as an enterprise, company or a firm is an organizational entity involved in the provision of goods and services to consumers. Businesses are prevalent in capitalist economies, where most of them are privately owned and provide goods and services to customers in exchange for other goods, services, or money. Businesses may also be social non-profit enterprises or state-owned public enterprises targeted for specific social and economic objectives. A business owned by multiple individuals may be formed as an incorporated company or jointly organised as a partnership. Countries have different laws that may ascribe different rights to the various business entities.&lt;/p&gt;
&lt;p&gt;Business can refer to a particular organization or to an entire market sector, e.g. &#8220;the music business&#8221;. Compound forms such as agribusiness represent subsets of the word&#8217;s broader meaning, which encompasses all activity by suppliers of goods and services. The goal is for sales to be more than expenditures resulting in a profit or gain or surplus.[/vc_column_text][vc_custom_heading text=&quot;Restructuring State Enterprises&quot; use_theme_fonts=&quot;yes&quot;][vc_column_text]&nbsp;&lt;/p&gt;
&lt;p&gt;Owners may administer their businesses themselves, or employ managers to do this for them. Whether they are owners or employees, managers administer three primary components of the business&#8217; value: its financial resources, capital or tangible resources, and human resources. These resources are administered in at least five functional areas: legal contracting, manufacturing or service production, marketing, accounting, financing, and human resources.[/vc_column_text][/vc_column][/vc_row]&lt;/p&gt;
" data-medium-file="" data-large-file="" class="aligncenter size-full wp-image-1792" src="https://i1.wp.com/ibpad.com.br/wp-content/uploads/2016/11/facebook-une.png?resize=650%2C401" alt="facebook-une" data-recalc-dims="1" /></a>
</p>
<p>
Agora vamos tentar identificar alguns assuntos através da clusterização
hierárquica das palavras das postagens.
</p>
<pre class="crayon-plain-tag">tdm &lt;- TermDocumentMatrix(unep)
tdm &lt;- removeSparseTerms(tdm, sparse = 0.91)
df &lt;- as.data.frame(inspect(tdm))</pre>
<p>
</p>
<pre class="crayon-plain-tag">&amp;lt;&amp;lt;TermDocumentMatrix (terms: 36, documents: 244)&amp;gt;&amp;gt;
Non-/sparse entries: 1332/7452
Sparsity           : 85%
Maximal term length: 13
Weighting          : term frequency (tf)

               Docs
Terms           1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41
  241           0 0 0 0 0 1 0 1 1  1  0  0  1  0  0  0  0  0  0  0  0  1  0  0  0  0  0  0  0  0  0  0  1  0  0  0  1  0  0  0  0
  brasil        0 1 0 1 0 2 1 2 2  0  0  0  2  3  2  1  1  1  0  2  1  2  2  0  0  0  0  0  0  0  0  0  0  0  0  0  2  0  0  0  1
  contra        0 0 1 0 0 1 1 3 0  0  0  0  3  1  0  0  0  0  1  0  0  1  0  1  0  0  0  0  1  2  1  0  1  0  0  0  1  0  0  0  1
  dia           1 0 0 0 0 0 0 4 3  0  0  0  4  0  0  1  1  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
               Docs
Terms           42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79
  241            0  0  1  0  1  0  0  0  1  0  1  0  0  0  0  0  0  0  1  1  0  0  0  1  0  0  0  0  0  0  0  0  0  0  0  0  0  1
  brasil         0  0  2  0  0  1  0  0  1  0  0  0  0  1  0  0  1  0  0  0  0  0  0  0  0  0  0  0  1  0  0  0  0  0  0  0  1  0
  contra         0  0  1  0  0  0  0  0  1  0  0  0  0  0  0  0  0  0  0  0  0  0  0  1  0  0  0  0  1  0  0  1  0  0  0  0  0  0
  dia            0  0  0  1  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  1  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
               Docs
Terms           80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112
  241            0  0  0  1  0  1  1  0  0  0  2  1  0  0  0  0  1  1  0  0   0   1   1   1   1   0   1   0   0   1   0   0   1
  brasil         0  0  1  0  0  1  0  0  0  0  1  0  0  0  0  2  1  0  0  0   0   3   0   1   0   0   0   0   0   0   0   1   0
  contra         0  0  2  2  0  0  2  0  0  0  3  0  0  0  0  0  0  1  0  0   1   2   2   1   0   0   1   0   0   1   0   0   1
  dia            0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  1  0  0  1   0   0   0   0   0   0   0   0   0   0   0   0   1
               Docs
Terms           113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140
  241             0   2   0   1   0   0   0   0   0   2   1   1   2   0   0   1   1   0   1   0   0   1   0   0   0   1   0   1
  brasil          0   0   0   1   0   1   0   0   1   1   0   0   0   0   0   0   0   0   1   0   0   1   0   1   0   0   0   0
  contra          2   4   1   0   0   0   0   0   0   3   1   1   2   0   0   1   1   0   1   0   0   0   0   0   0   1   0   0
  dia             0   0   0   1   0   0   0   0   0   2   0   0   0   0   0   0   0   0   0   2   1   1   0   0   0   1   0   0
               Docs
Terms           141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168
  241             0   1   0   0   0   0   0   0   1   1   1   0   2   1   1   0   0   0   1   0   0   0   0   1   1   0   0   0
  brasil          0   0   1   0   0   0   0   1   2   1   0   1   0   0   0   0   0   0   0   1   0   0   0   0   0   1   0   0
  contra          1   0   0   1   1   0   0   1   0   1   1   2   2   0   0   0   0   0   3   0   0   0   0   1   1   0   0   2
  dia             0   0   0   0   0   0   0   0   0   0   1   0   0   0   0   0   0   0   0   0   0   0   0   2   0   2   0   2
               Docs
Terms           169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196
  241             0   0   1   0   0   2   2   1   0   0   1   2   1   1   1   2   1   2   1   0   0   2   1   2   1   1   1   1
  brasil          1   0   1   0   0   1   0   0   0   0   0   0   0   0   0   1   0   3   0   0   0   2   0   1   0   0   0   0
  contra          0   0   0   1   0   0   2   1   0   1   0   1   1   1   2   0   0   1   1   0   0   1   1   3   0   1   1   0
  dia             0   0   0   1   1   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
               Docs
Terms           197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224
  241             0   0   0   1   0   2   1   0   0   2   0   0   0   0   0   0   0   1   0   0   0   0   0   0   0   0   0   0
  brasil          0   0   0   1   0   0   0   0   0   0   0   1   0   0   0   0   0   0   0   0   0   0   0   0   0   1   1   0
  contra          1   0   0   1   0   0   1   2   0   0   1   0   1   2   0   0   0   1   0   0   0   0   0   0   0   1   0   0
  dia             0   0   0   1   0   0   1   1   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   1   0   0
               Docs
Terms           225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244
  241             0   0   0   0   0   0   0   0   0   1   0   0   0   0   0   0   0   0   0   0
  brasil          0   1   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   1   0   0
  contra          0   0   0   0   0   0   0   0   0   1   1   0   0   2   0   0   0   0   0   0
  dia             0   0   0   0   1   0   0   0   0   1   0   0   0   0   0   0   0   0   0   0
 [ reached getOption(&quot;max.print&quot;) -- omitted 32 rows ]</pre>
<p>
</p>
<pre class="crayon-plain-tag">dim(df)</pre>
<p>
</p>
<pre class="crayon-plain-tag">[1]  36 244</pre>
<p>
</p>
<pre class="crayon-plain-tag">df.scale &lt;- scale(df)
d &lt;- dist(df.scale, method = "euclidean")
fit.ward2 &lt;- hclust(d, method = "ward.D2")
plot(fit.ward2, main="Clusterização Hierárquica\nFacebook - UNE", xlab = "De 17/09/2016 a 17/11/2016")
rect.hclust(fit.ward2, k=7)</pre>
<p>
<a href="https://i2.wp.com/ibpad.com.br/wp-content/uploads/2016/11/facebook-une2.png"><img data-attachment-id="1793" data-permalink="http://www.ibpad.com.br/01-3/" data-orig-file="https://i0.wp.com/www.ibpad.com.br/wp-content/uploads/2015/09/about-page-with-gallery-3258.jpg?fit=800%2C600" data-orig-size="800,600" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;}" data-image-title="01" data-image-description="" data-medium-file="https://i0.wp.com/www.ibpad.com.br/wp-content/uploads/2015/09/about-page-with-gallery-3258.jpg?fit=260%2C195" data-large-file="https://i0.wp.com/www.ibpad.com.br/wp-content/uploads/2015/09/about-page-with-gallery-3258.jpg?fit=800%2C600" class="aligncenter size-full wp-image-1793" src="https://i2.wp.com/ibpad.com.br/wp-content/uploads/2016/11/facebook-une2.png?resize=650%2C401" alt="facebook-une2" data-recalc-dims="1" /></a>
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
<pre class="crayon-plain-tag">matriz &lt;- as.matrix(df)
g = graph_from_incidence_matrix(matriz)
p = bipartite_projection(g, which = "FALSE")
V(p)$shape = "none"
deg = degree(p)
plot(p, vertex.label.cex=deg/35, edge.width=(E(p)$weight)/10, 
     edge.color=adjustcolor("grey60", .5),
     vertex.label.color=adjustcolor("#005d26", .7),
     main = "Facebook - UNE", xlab = "De 17/09/2016 a 17/11/2016")</pre>
<p>
<a href="https://i2.wp.com/ibpad.com.br/wp-content/uploads/2016/11/facebook-une3.png"><img data-attachment-id="1794" data-permalink="http://www.ibpad.com.br/02-3/" data-orig-file="https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2015/09/about-page-with-gallery-3259.jpg?fit=800%2C600" data-orig-size="800,600" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;}" data-image-title="02" data-image-description="" data-medium-file="https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2015/09/about-page-with-gallery-3259.jpg?fit=260%2C195" data-large-file="https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2015/09/about-page-with-gallery-3259.jpg?fit=800%2C600" class="aligncenter size-full wp-image-1794" src="https://i2.wp.com/ibpad.com.br/wp-content/uploads/2016/11/facebook-une3.png?resize=650%2C401" alt="facebook-une3" data-recalc-dims="1" /></a>
</p>
<p>
Como podemos ver, a rede reforça os resultados da clusterização
hierárquica mostrando um grande assunto sendo desenvolvido nas postagens
da UNE. Não há diversificação mas todas as palavras formam um componente
gigante conectado.
</p>
<h3>
Comentários
</h3>
<p>
Vamos olhar agora para os comentários na página da UNE. Seguiremos as
mesmas estratégias analíticas, inclusive a exclusão da palavra
<strong>campus</strong>.
</p>
<pre class="crayon-plain-tag">comments_une = UNE$comment_message %&gt;% unique
unec = Corpus(VectorSource(comments_une))
unec &lt;- tm_map(unec, content_transformer(tolower))
unec &lt;- tm_map(unec, removePunctuation)
unec &lt;- tm_map(unec, function(x)removeWords(x,stopwords("pt")))
unec &lt;- tm_map(unec, function(x)removeWords(x, 'campus'))
pal = brewer.pal(5, "Set2")
# Nuvem de palavras
wordcloud(unec, min.freq = 3, max.words = 100, random.order = F, colors = pal)
title(xlab = "Facebook - UNE - Comments\nDe 17/09/2016 a 17/11/2016")</pre>
<p>
<a href="https://i1.wp.com/ibpad.com.br/wp-content/uploads/2016/11/facebook-une4.png"><img data-attachment-id="1795" data-permalink="http://www.ibpad.com.br/blog/about-page-with-features/" data-orig-file="" data-orig-size="" data-comments-opened="0" data-image-meta="[]" data-image-title="About Page With Features" data-image-description="&lt;p&gt;[vc_row][vc_column][vc_custom_heading text=&quot;Nature of Description&quot; font_container=&quot;tag:h1|text_align:left&quot; use_theme_fonts=&quot;yes&quot;][vc_column_text]Description is one of four rhetorical modes, along with exposition, argumentation, and narration. Each of the rhetorical modes is present in a variety of forms and each has its own purpose and conventions. The act of description may be related to that of definition.[/vc_column_text][/vc_column][/vc_row][vc_row][vc_column width=&quot;1/3&quot;][vc_single_image image=&quot;1796&quot; img_size=&quot;full&quot; alignment=&quot;center&quot; style=&quot;vc_box_rounded&quot;][vc_column_text]Description is also the fiction-writing mode for transmitting a mental image of the particulars of a story.[/vc_column_text][/vc_column][vc_column width=&quot;1/3&quot;][vc_single_image image=&quot;1797&quot; img_size=&quot;full&quot; alignment=&quot;center&quot; style=&quot;vc_box_rounded&quot;][vc_column_text]The pattern of development that presents a word picture of a thing, a person, a situation, or a series of events.[/vc_column_text][/vc_column][vc_column width=&quot;1/3&quot;][vc_single_image image=&quot;1798&quot; img_size=&quot;full&quot; alignment=&quot;center&quot; style=&quot;vc_box_rounded&quot;][vc_column_text]The most appropriate and effective techniques for presenting description are a matter of ongoing discussion among writers and writing coaches.[/vc_column_text][/vc_column][/vc_row]&lt;/p&gt;
" data-medium-file="" data-large-file="" class="aligncenter size-full wp-image-1795" src="https://i1.wp.com/ibpad.com.br/wp-content/uploads/2016/11/facebook-une4.png?resize=650%2C401" alt="facebook-une4" data-recalc-dims="1" /></a>
</p>
<p>
As principais palavras encontradas na nuvem de palavras são bastante
parecidas com aquelas das postagens. Vamos investigar o fluxo de
comentários no tempo.
</p>
<pre class="crayon-plain-tag">UNE$comment_date = ymd_hms(UNE$comment_published)
UNE$comment_date = round_date(UNE$comment_date, 'day')
datas = as.data.frame(table(UNE$comment_date), stringsAsFactors = F)
datas$Var1 = as.Date(datas$Var1)
limits = ymd(c(20160916, 20161118)) %&gt;% as.Date
ggplot(datas, aes(x=Var1, y=Freq))+geom_line()+scale_x_date(date_minor_breaks = '1 day', date_breaks = '1 week', date_labels = '%d-%m', limits = limits)+
  labs(x='UNE',y='Número de Comentários')</pre>
<p>
<a href="https://i2.wp.com/ibpad.com.br/wp-content/uploads/2016/11/facebook-une5.png"><img data-attachment-id="1796" data-permalink="http://www.ibpad.com.br/01-2/" data-orig-file="https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2015/09/about-page-with-features-3255.jpg?fit=800%2C600" data-orig-size="800,600" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;}" data-image-title="01" data-image-description="" data-medium-file="https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2015/09/about-page-with-features-3255.jpg?fit=260%2C195" data-large-file="https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2015/09/about-page-with-features-3255.jpg?fit=800%2C600" class="aligncenter size-full wp-image-1796" src="https://i2.wp.com/ibpad.com.br/wp-content/uploads/2016/11/facebook-une5.png?resize=650%2C401" alt="facebook-une5" data-recalc-dims="1" /></a>
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
<pre class="crayon-plain-tag">MBL = read_tsv('/home/neylson/Documentos/Neylson Crepalde/Doutorado/UNE_MBL/MBL/page_204223673035117_2016_11_18_14_11_51_topcomments.tab')</pre>
<p>
</p>
<pre class="crayon-plain-tag">|==                                                                             |   2%    3 MB
|===                                                                            |   3%    4 MB
|====                                                                           |   5%    6 MB
|====                                                                           |   6%    7 MB
|=====                                                                          |   6%    7 MB
|======                                                                         |   7%    9 MB
|=======                                                                        |   8%   10 MB
|========                                                                       |  10%   12 MB
|=========                                                                      |  11%   13 MB
|=========                                                                      |  12%   14 MB
|==========                                                                     |  13%   15 MB
|===========                                                                    |  14%   17 MB
|============                                                                   |  15%   18 MB
|=============                                                                  |  16%   19 MB
|==============                                                                 |  17%   21 MB
|===============                                                                |  18%   22 MB
|================                                                               |  20%   24 MB
|=================                                                              |  21%   25 MB
|==================                                                             |  22%   27 MB
|==================                                                             |  23%   28 MB
|====================                                                           |  25%   30 MB
|====================                                                           |  25%   31 MB
|=====================                                                          |  26%   32 MB
|======================                                                         |  27%   33 MB
|======================                                                         |  28%   33 MB
|=======================                                                        |  29%   34 MB
|========================                                                       |  30%   36 MB
|========================                                                       |  31%   37 MB
|==========================                                                     |  32%   39 MB
|===========================                                                    |  33%   40 MB
|===========================                                                    |  34%   41 MB
|============================                                                   |  35%   42 MB
|=============================                                                  |  37%   44 MB
|==============================                                                 |  38%   46 MB
|===============================                                                |  39%   47 MB
|================================                                               |  40%   48 MB
|================================                                               |  41%   49 MB
|=================================                                              |  42%   50 MB
|==================================                                             |  43%   52 MB
|===================================                                            |  44%   53 MB
|====================================                                           |  45%   54 MB
|=====================================                                          |  46%   56 MB
|=====================================                                          |  47%   57 MB
|======================================                                         |  47%   57 MB
|======================================                                         |  48%   58 MB
|=======================================                                        |  49%   59 MB
|========================================                                       |  50%   60 MB
|=========================================                                      |  51%   62 MB
|=========================================                                      |  52%   62 MB
|==========================================                                     |  53%   63 MB
|===========================================                                    |  54%   65 MB
|============================================                                   |  55%   66 MB
|============================================                                   |  55%   67 MB
|=============================================                                  |  57%   68 MB
|==============================================                                 |  58%   70 MB
|===============================================                                |  59%   71 MB
|================================================                               |  60%   72 MB
|=================================================                              |  61%   74 MB
|==================================================                             |  62%   75 MB
|==================================================                             |  63%   76 MB
|===================================================                            |  64%   77 MB
|====================================================                           |  65%   78 MB
|=====================================================                          |  66%   79 MB
|======================================================                         |  67%   81 MB
|======================================================                         |  68%   82 MB
|=======================================================                        |  69%   83 MB
|========================================================                       |  70%   84 MB
|========================================================                       |  70%   85 MB
|=========================================================                      |  71%   85 MB
|==========================================================                     |  72%   87 MB
|===========================================================                    |  74%   89 MB
|===========================================================                    |  74%   90 MB
|============================================================                   |  75%   91 MB
|============================================================                   |  76%   91 MB
|=============================================================                  |  76%   92 MB
|=============================================================                  |  77%   92 MB
|==============================================================                 |  78%   93 MB
|===============================================================                |  78%   94 MB
|===============================================================                |  79%   95 MB
|================================================================               |  80%   97 MB
|=================================================================              |  81%   98 MB
|==================================================================             |  82%   99 MB
|==================================================================             |  83%  100 MB
|===================================================================            |  84%  101 MB
|====================================================================           |  85%  102 MB
|====================================================================           |  85%  103 MB
|=====================================================================          |  87%  104 MB
|======================================================================         |  88%  106 MB
|=======================================================================        |  89%  107 MB
|========================================================================       |  90%  108 MB
|========================================================================       |  90%  108 MB
|========================================================================       |  91%  109 MB
|==========================================================================     |  92%  111 MB
|==========================================================================     |  93%  112 MB
|===========================================================================    |  93%  112 MB
|===========================================================================    |  94%  113 MB
|============================================================================   |  95%  114 MB
|=============================================================================  |  96%  115 MB
|=============================================================================  |  97%  117 MB
|============================================================================== |  98%  117 MB
|===============================================================================|  98%  118 MB
|===============================================================================|  99%  119 MB
|================================================================================| 100%  120 MB</pre>
<p>
</p>
<pre class="crayon-plain-tag">posts_mbl = MBL$post_text %&gt;% unique
# identificando alguns assuntos
mblp = Corpus(VectorSource(posts_mbl))
mblp &lt;- tm_map(mblp, content_transformer(tolower))
mblp &lt;- tm_map(mblp, removePunctuation)
mblp &lt;- tm_map(mblp, function(x)removeWords(x,stopwords("pt")))
mblp &lt;- tm_map(mblp, function(x)removeWords(x, c('httpswwwkickantecombrcampanhasiicongressonacionaldomovimentobrasillivre',
                                                 'httpswwwsymplacombriicongressonacionaldomovimentobrasillivre96736')))
pal = brewer.pal(5, "Set2")
# Nuvem de palavras
wordcloud(mblp, min.freq = 3, max.words = 100, random.order = F, colors = pal)
title(xlab = "Facebook - MBL\nDe 17/09/2016 a 17/11/2016")</pre>
<p>
<a href="https://i1.wp.com/ibpad.com.br/wp-content/uploads/2016/11/facebook-mbl1.png"><img data-attachment-id="1797" data-permalink="http://www.ibpad.com.br/02-2/" data-orig-file="https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2015/09/about-page-with-features-3256.jpg?fit=800%2C600" data-orig-size="800,600" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;}" data-image-title="02" data-image-description="" data-medium-file="https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2015/09/about-page-with-features-3256.jpg?fit=260%2C195" data-large-file="https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2015/09/about-page-with-features-3256.jpg?fit=800%2C600" class="aligncenter size-full wp-image-1797" src="https://i1.wp.com/ibpad.com.br/wp-content/uploads/2016/11/facebook-mbl1.png?resize=650%2C401" alt="facebook-mbl1" data-recalc-dims="1" /></a>
</p>
<p>
Agora fazendo a clusterização hierárquica.
</p>
<pre class="crayon-plain-tag">tdm &lt;- TermDocumentMatrix(mblp)
tdm &lt;- removeSparseTerms(tdm, sparse = 0.965)
df &lt;- as.data.frame(inspect(tdm))</pre>
<p>
</p>
<pre class="crayon-plain-tag">&amp;lt;&amp;lt;TermDocumentMatrix (terms: 32, documents: 1425)&amp;gt;&amp;gt;
Non-/sparse entries: 3512/42088
Sparsity           : 92%
Maximal term length: 16
Weighting          : term frequency (tf)

                  Docs
Terms              1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40
                  Docs
Terms              41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77
                  Docs
Terms              78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110
                  Docs
Terms              111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137
                  Docs
Terms              138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164
                  Docs
Terms              165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191
                  Docs
Terms              192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218
                  Docs
Terms              219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245
                  Docs
Terms              246 247 248 249 250 251 252 253 254 255 256 257 258 259 260 261 262 263 264 265 266 267 268 269 270 271 272
                  Docs
Terms              273 274 275 276 277 278 279 280 281 282 283 284 285 286 287 288 289 290 291 292 293 294 295 296 297 298 299
                  Docs
Terms              300 301 302 303 304 305 306 307 308 309 310 311 312 313 314 315 316 317 318 319 320 321 322 323 324 325 326
                  Docs
Terms              327 328 329 330 331 332 333 334 335 336 337 338 339 340 341 342 343 344 345 346 347 348 349 350 351 352 353
                  Docs
Terms              354 355 356 357 358 359 360 361 362 363 364 365 366 367 368 369 370 371 372 373 374 375 376 377 378 379 380
                  Docs
Terms              381 382 383 384 385 386 387 388 389 390 391 392 393 394 395 396 397 398 399 400 401 402 403 404 405 406 407
                  Docs
Terms              408 409 410 411 412 413 414 415 416 417 418 419 420 421 422 423 424 425 426 427 428 429 430 431 432 433 434
                  Docs
Terms              435 436 437 438 439 440 441 442 443 444 445 446 447 448 449 450 451 452 453 454 455 456 457 458 459 460 461
                  Docs
Terms              462 463 464 465 466 467 468 469 470 471 472 473 474 475 476 477 478 479 480 481 482 483 484 485 486 487 488
                  Docs
Terms              489 490 491 492 493 494 495 496 497 498 499 500 501 502 503 504 505 506 507 508 509 510 511 512 513 514 515
                  Docs
Terms              516 517 518 519 520 521 522 523 524 525 526 527 528 529 530 531 532 533 534 535 536 537 538 539 540 541 542
                  Docs
Terms              543 544 545 546 547 548 549 550 551 552 553 554 555 556 557 558 559 560 561 562 563 564 565 566 567 568 569
                  Docs
Terms              570 571 572 573 574 575 576 577 578 579 580 581 582 583 584 585 586 587 588 589 590 591 592 593 594 595 596
                  Docs
Terms              597 598 599 600 601 602 603 604 605 606 607 608 609 610 611 612 613 614 615 616 617 618 619 620 621 622 623
                  Docs
Terms              624 625 626 627 628 629 630 631 632 633 634 635 636 637 638 639 640 641 642 643 644 645 646 647 648 649 650
                  Docs
Terms              651 652 653 654 655 656 657 658 659 660 661 662 663 664 665 666 667 668 669 670 671 672 673 674 675 676 677
                  Docs
Terms              678 679 680 681 682 683 684 685 686 687 688 689 690 691 692 693 694 695 696 697 698 699 700 701 702 703 704
                  Docs
Terms              705 706 707 708 709 710 711 712 713 714 715 716 717 718 719 720 721 722 723 724 725 726 727 728 729 730 731
                  Docs
Terms              732 733 734 735 736 737 738 739 740 741 742 743 744 745 746 747 748 749 750 751 752 753 754 755 756 757 758
                  Docs
Terms              759 760 761 762 763 764 765 766 767 768 769 770 771 772 773 774 775 776 777 778 779 780 781 782 783 784 785
                  Docs
Terms              786 787 788 789 790 791 792 793 794 795 796 797 798 799 800 801 802 803 804 805 806 807 808 809 810 811 812
                  Docs
Terms              813 814 815 816 817 818 819 820 821 822 823 824 825 826 827 828 829 830 831 832 833 834 835 836 837 838 839
                  Docs
Terms              840 841 842 843 844 845 846 847 848 849 850 851 852 853 854 855 856 857 858 859 860 861 862 863 864 865 866
                  Docs
Terms              867 868 869 870 871 872 873 874 875 876 877 878 879 880 881 882 883 884 885 886 887 888 889 890 891 892 893
                  Docs
Terms              894 895 896 897 898 899 900 901 902 903 904 905 906 907 908 909 910 911 912 913 914 915 916 917 918 919 920
                  Docs
Terms              921 922 923 924 925 926 927 928 929 930 931 932 933 934 935 936 937 938 939 940 941 942 943 944 945 946 947
                  Docs
Terms              948 949 950 951 952 953 954 955 956 957 958 959 960 961 962 963 964 965 966 967 968 969 970 971 972 973 974
                  Docs
Terms              975 976 977 978 979 980 981 982 983 984 985 986 987 988 989 990 991 992 993 994 995 996 997 998 999 1000 1001
                  Docs
Terms              1002 1003 1004 1005 1006 1007 1008 1009 1010 1011 1012 1013 1014 1015 1016 1017 1018 1019 1020 1021 1022 1023
                  Docs
Terms              1024 1025 1026 1027 1028 1029 1030 1031 1032 1033 1034 1035 1036 1037 1038 1039 1040 1041 1042 1043 1044 1045
                  Docs
Terms              1046 1047 1048 1049 1050 1051 1052 1053 1054 1055 1056 1057 1058 1059 1060 1061 1062 1063 1064 1065 1066 1067
                  Docs
Terms              1068 1069 1070 1071 1072 1073 1074 1075 1076 1077 1078 1079 1080 1081 1082 1083 1084 1085 1086 1087 1088 1089
                  Docs
Terms              1090 1091 1092 1093 1094 1095 1096 1097 1098 1099 1100 1101 1102 1103 1104 1105 1106 1107 1108 1109 1110 1111
                  Docs
Terms              1112 1113 1114 1115 1116 1117 1118 1119 1120 1121 1122 1123 1124 1125 1126 1127 1128 1129 1130 1131 1132 1133
                  Docs
Terms              1134 1135 1136 1137 1138 1139 1140 1141 1142 1143 1144 1145 1146 1147 1148 1149 1150 1151 1152 1153 1154 1155
                  Docs
Terms              1156 1157 1158 1159 1160 1161 1162 1163 1164 1165 1166 1167 1168 1169 1170 1171 1172 1173 1174 1175 1176 1177
                  Docs
Terms              1178 1179 1180 1181 1182 1183 1184 1185 1186 1187 1188 1189 1190 1191 1192 1193 1194 1195 1196 1197 1198 1199
                  Docs
Terms              1200 1201 1202 1203 1204 1205 1206 1207 1208 1209 1210 1211 1212 1213 1214 1215 1216 1217 1218 1219 1220 1221
                  Docs
Terms              1222 1223 1224 1225 1226 1227 1228 1229 1230 1231 1232 1233 1234 1235 1236 1237 1238 1239 1240 1241 1242 1243
                  Docs
Terms              1244 1245 1246 1247 1248 1249 1250 1251 1252 1253 1254 1255 1256 1257 1258 1259 1260 1261 1262 1263 1264 1265
                  Docs
Terms              1266 1267 1268 1269 1270 1271 1272 1273 1274 1275 1276 1277 1278 1279 1280 1281 1282 1283 1284 1285 1286 1287
                  Docs
Terms              1288 1289 1290 1291 1292 1293 1294 1295 1296 1297 1298 1299 1300 1301 1302 1303 1304 1305 1306 1307 1308 1309
                  Docs
Terms              1310 1311 1312 1313 1314 1315 1316 1317 1318 1319 1320 1321 1322 1323 1324 1325 1326 1327 1328 1329 1330 1331
                  Docs
Terms              1332 1333 1334 1335 1336 1337 1338 1339 1340 1341 1342 1343 1344 1345 1346 1347 1348 1349 1350 1351 1352 1353
                  Docs
Terms              1354 1355 1356 1357 1358 1359 1360 1361 1362 1363 1364 1365 1366 1367 1368 1369 1370 1371 1372 1373 1374 1375
                  Docs
Terms              1376 1377 1378 1379 1380 1381 1382 1383 1384 1385 1386 1387 1388 1389 1390 1391 1392 1393 1394 1395 1396 1397
                  Docs
Terms              1398 1399 1400 1401 1402 1403 1404 1405 1406 1407 1408 1409 1410 1411 1412 1413 1414 1415 1416 1417 1418 1419
                  Docs
Terms              1420 1421 1422 1423 1424 1425
 [ reached getOption(&quot;max.print&quot;) -- omitted 32 rows ]</pre>
<p>
</p>
<pre class="crayon-plain-tag">dim(df)</pre>
<p>
</p>
<pre class="crayon-plain-tag">[1]   32 1425</pre>
<p>
</p>
<pre class="crayon-plain-tag">df.scale &lt;- scale(df)
d &lt;- dist(df.scale, method = "euclidean")
fit.ward2 &lt;- hclust(d, method = "ward.D2")
plot(fit.ward2, main="Clusterização Hierárquica\nFacebook - MBL", xlab = "De 17/09/2016 a 17/11/2016")
rect.hclust(fit.ward2, k=8)</pre>
<p>
<a href="https://i0.wp.com/ibpad.com.br/wp-content/uploads/2016/11/facebook-mbl2.png"><img data-attachment-id="1798" data-permalink="http://www.ibpad.com.br/03/" data-orig-file="https://i0.wp.com/www.ibpad.com.br/wp-content/uploads/2015/09/about-page-with-features-3257.jpg?fit=800%2C600" data-orig-size="800,600" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;}" data-image-title="03" data-image-description="" data-medium-file="https://i0.wp.com/www.ibpad.com.br/wp-content/uploads/2015/09/about-page-with-features-3257.jpg?fit=260%2C195" data-large-file="https://i0.wp.com/www.ibpad.com.br/wp-content/uploads/2015/09/about-page-with-features-3257.jpg?fit=800%2C600" class="aligncenter size-full wp-image-1798" src="https://i0.wp.com/ibpad.com.br/wp-content/uploads/2016/11/facebook-mbl2.png?resize=650%2C401" alt="facebook-mbl2" data-recalc-dims="1" /></a>
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
<pre class="crayon-plain-tag">matriz &lt;- as.matrix(df)
g = graph_from_incidence_matrix(matriz)
p = bipartite_projection(g, which = "FALSE")
V(p)$shape = "none"
deg = degree(p)
plot(p, vertex.label.cex=deg/35, edge.width=(E(p)$weight)/10, 
     edge.color=adjustcolor("grey60", .5),
     vertex.label.color=adjustcolor("#005d26", .7),
     main = "Facebook - MBL", xlab = "De 17/09/2016 a 17/11/2016")</pre>
<p>
<a href="https://i1.wp.com/ibpad.com.br/wp-content/uploads/2016/11/facebook-mbl3.png"><img data-attachment-id="1799" data-permalink="http://www.ibpad.com.br/blog/307-autosave-v1/" data-orig-file="" data-orig-size="" data-comments-opened="0" data-image-meta="[]" data-image-title="Vertentes de Estudo da Cultura" data-image-description="&lt;p style=&quot;text-align: center;&quot;&gt;&lt;strong&gt;Artigo Exclusivo: Vertentes de Estudo da Cultura&lt;/strong&gt;&lt;/p&gt;
&lt;p&gt;Quando estudamos o método etnográfico, importante ter muito claro que tanto a aplicação prática da etnografia quanto o próprio conceito de cultura estão associados a uma ampla variedade de orientações teóricas.&lt;/p&gt;
&lt;p&gt;Para falarmos um pouco sobre este imenso campo, resumimos algumas linhas tradicionais de orientação teórica apresentadas no livro &lt;strong&gt;Etnografia e Observação Participante&lt;/strong&gt;, de Michael Agrosino, no qual o autor apresenta as linhas teóricas que perpassam os estudos etnográficos.&lt;/p&gt;
&lt;p&gt;Neste livro, AGROSINO (2009) nos diz que a medida que o método etnográfico se espalhou pelas disciplinas das ciências sociais, ele ficou associado a uma ampla variedade de orientações teóricas. As principais são:&lt;/p&gt;
&lt;ul&gt;
&lt;li&gt;Funcionalismo&lt;/li&gt;
&lt;li&gt;Interacionismo simbólico&lt;/li&gt;
&lt;li&gt;Feminismo&lt;/li&gt;
&lt;li&gt;Marxismo&lt;/li&gt;
&lt;li&gt;Etnometodologia&lt;/li&gt;
&lt;li&gt;Teoria crítica&lt;/li&gt;
&lt;li&gt;Estudos culturais&lt;/li&gt;
&lt;li&gt;Pós modernismo&lt;/li&gt;
&lt;/ul&gt;
&lt;p&gt;&nbsp;&lt;/p&gt;
&lt;p&gt;Ao estudar estas abordagens, é possível ver também as grandes mudanças conceituais do entendimento do conceito de cultura e da aplicação etnográfica ao longo da história da antropologia. Ao ler, fique atento a estas diferenças.&lt;/p&gt;
&lt;p&gt;Faremos neste artigo uma resenha das três mais populares linhas apresentadas pelo próprio autor AGROSINO (2009). Ao se apresentar estas três linhas, percebe-se as diferentes abordagens aos conceitos que sempre preocuparam as ciências sociais: cultura, sociedade, interação social.&lt;/p&gt;
&lt;p&gt;Para quem tiver interesse em se aprofundar, recomendamos a leitura do livro Etnografia e Observação Participante.&lt;/p&gt;
&lt;p&gt;&nbsp;&lt;/p&gt;
&lt;p&gt;&lt;strong&gt;Funcionalismo&lt;/strong&gt;&lt;/p&gt;
&lt;p&gt;Nesta linha, os funcionalistas enfocam em seus estudos a sociedade e seus subsistemas, como a família, a economia, as instituições políticas, as crenças, etc). Pouquíssima atenção foi dada ao estudo da arte, da linguagem, ao desenvolvimento da personalidade, à tecnologia e ao ambiente.&lt;/p&gt;
&lt;p&gt;Para os funcionalistas, a sociedade é concebida como um sistema biológico em que elemento social é entendido como parte de um sistema completo, em que apresenta funções e organizações específicas dentro deste um sistema. Assim como os órgãos de um organismo vivo, cada elemento social tem uma funcionalidade que faz com que o organismo/sociedade viva corretamente e seja dependente um do outro.&lt;/p&gt;
&lt;p&gt;As perturbações existentes em uma sociedade são, pelos funcionalistas, anomalias que precisam ser corrigidas pelos mecanismos existentes dentro da própria sociedade, assim como um organismo vivo.&lt;/p&gt;
&lt;p&gt;Houve uma grande predominância dos estudos de parentesco, pois os funcionalistas consideram os laços de família como uma ‘cola’ que mantém as sociedades coesas, a peça chave para a organização social. Nas sociedades modernas, os funcionalistas defendem que outras instituições também desenvolvem esta função de cola, mas fazem isso a partir do modelo de família.&lt;/p&gt;
&lt;p&gt;&nbsp;&lt;/p&gt;
&lt;p&gt;&nbsp;&lt;/p&gt;
&lt;p&gt;&lt;strong&gt;Interacionismo simbólico&lt;/strong&gt;&lt;/p&gt;
&lt;p&gt;Muito popular em sociologia e psicologia social. Ao contrário dos cientistas sociais que, na maioria das vezes, enfatizam muito o papel da cultura na formatação do comportamento humano, os interacionistas veem as pessoas como agentes ativos e não como partes permutáveis de um grande organismo, sofrendo passivamente da ação de forças externas.&lt;/p&gt;
&lt;p&gt;Para esta linha, a sociedade não é vista como algo estático e imutável em que cada pessoa e instituição cumpre uma função, como os funcionalistas defendem. A sociedade muda conforme as interações das pessoas mudam.&lt;/p&gt;
&lt;p&gt;Há uma grande variedade de teorias interacionistas, mas elas sempre compartilham dos mesmos princípios:&lt;/p&gt;
&lt;ol&gt;
&lt;li&gt;As pessoas vivem em um mundo de significados aprendidos que são codificados em símbolos compartilhados através de interações&lt;/li&gt;
&lt;li&gt;Símbolos são os motivos que fazem as pessoas a desempenharem suas atividades&lt;/li&gt;
&lt;li&gt;As interações sociais mudam a mente humana&lt;/li&gt;
&lt;li&gt;O self é uma construção social: nós nos construímos a partir da interação com os outros&lt;/li&gt;
&lt;/ol&gt;
&lt;p&gt;&nbsp;&lt;/p&gt;
&lt;p&gt;&lt;strong&gt;Etnometodologia&lt;/strong&gt;&lt;/p&gt;
&lt;p&gt;Linha teórica que ganhou destaque na sociologia pela sua forma de entender e estudar o comportamento humano. Os etnometodólogos se preocupam em explicar como o sentido de realidade de um grupo é constituído, mantido e transformado.&lt;/p&gt;
&lt;p&gt;As proposições principais são:&lt;/p&gt;
&lt;ol&gt;
&lt;li&gt;A interação humana é reflexiva. Ou seja, as pessoas interpretam palavras, gestos, linguagens corporais (ações significativas) para manter uma visão compartilhada da realidade. Qualquer evidência que pareça contradizer esta realidade é rejeitada ou incorporada ao interior de um sistema dominante.&lt;/li&gt;
&lt;li&gt;A informação é indexada: ela tem um significado dentro de um contexto específico, sendo que é importante olhar o sujeito dentro das suas relações, seus propósitos declarados.&lt;/li&gt;
&lt;/ol&gt;
&lt;p&gt;Assim, os etnometodológicos não se preocupam “em responder à ‘O que é cultura?’ ou ‘O que é sociedade?’, mas responder à questão ‘Como pessoas se convencem de que cultura e sociedade são proposições viáveis?’”  (AGROSINO, 2009, p. 27).&lt;/p&gt;
&lt;p&gt;&nbsp;&lt;/p&gt;
&lt;p&gt;&lt;strong&gt;Referências&lt;/strong&gt;&lt;/p&gt;
&lt;p&gt;ANGROSINO, MICHAEL V Etnografia e Observação Participante. Porto Alegre: Artmed, 2009&lt;/p&gt;
" data-medium-file="" data-large-file="" class="aligncenter size-full wp-image-1799" src="https://i1.wp.com/ibpad.com.br/wp-content/uploads/2016/11/facebook-mbl3.png?resize=650%2C401" alt="facebook-mbl3" data-recalc-dims="1" /></a>
</p>
<h3>
Comentários
</h3>
<p>
Vamos olhar agora para os comentários na página da MBL.
</p>
<pre class="crayon-plain-tag">comments_mbl = MBL$comment_message %&gt;% unique
mblc = Corpus(VectorSource(comments_mbl))
mblc &lt;- tm_map(mblc, content_transformer(tolower))
mblc &lt;- tm_map(mblc, removePunctuation)
mblc &lt;- tm_map(mblc, function(x)removeWords(x,stopwords("pt")))
mblc &lt;- tm_map(mblc, function(x)removeWords(x, c('httpswwwkickantecombrcampanhasiicongressonacionaldomovimentobrasillivre',
                                                 'httpswwwsymplacombriicongressonacionaldomovimentobrasillivre96736')))
pal = brewer.pal(5, "Set2")
# Nuvem de palavras
wordcloud(mblc, min.freq = 3, max.words = 100, random.order = F, colors = pal)
title(xlab = "Facebook - MBL - Comments\nDe 17/09/2016 a 17/11/2016")</pre>
<p>
<a href="https://i1.wp.com/ibpad.com.br/wp-content/uploads/2016/11/facebook-mbl4.png"><img data-attachment-id="1800" data-permalink="http://www.ibpad.com.br/blog/317-autosave-v1/" data-orig-file="" data-orig-size="" data-comments-opened="0" data-image-meta="[]" data-image-title="Ciberespaço, Cibercultura e Internet" data-image-description="&lt;p&gt;[vc_row][vc_column][vc_column_text]Nossa sociedade sempre passou por grandes transformações. Se nos séculos passados estudamos as grandes transformações que a agricultura e depois a indústria fizeram na sociedade, hoje estamos vivenciando o início da Era da Comunicação / Informação e percebemos as grandes mudanças que a internet está proporcionando.&lt;/p&gt;
&lt;p&gt;Nasce com a internet um novo modo de viver, uma nova forma de de atividade humana, de entendimento humano, de comportamento, novas formas de emprego, de rendimentos e, principalmente, uma nova forma de poder. “O que domina o saber domina o mundo”, COMBLIN, 2006.&lt;/p&gt;
&lt;p&gt;Distâncias físicas não são mais limitantes, concepção e percepção de tempo mudaram completamente, culturas se mesclam mais rapidamente e as formas de comunicação humana surgem e se transformam em uma velocidade assustadora. A Era da Informação constitui o novo momento histórico em que a base de todas as relações se estabelece através da informação e da sua capacidade de processamento e de geração de conhecimentos.&lt;/p&gt;
&lt;p&gt;A este fenômeno Castells (1999) denomina &lt;em&gt;“sociedade em rede”&lt;/em&gt;, que tem como base principal a apropriação da Internet com seus usos e aspectos incorporados pelo sistema capitalista.&lt;/p&gt;
&lt;p&gt;Se antes, por exemplo, a comunicação se dava apenas verbalmente,  não-verbalmente e gestualmente, hoje conhecemos a comunicação mediada (o processo de comunicação em que está envolvido algum tipo de aparato técnico que intermedia os locutores). Ora, se os componentes do processo de comunicação se dão por: o emissor da mensagem, o receptor, a mensagem em si, o canal de propagação, o meio de comunicação, a resposta e o ambiente onde o processo comunicativo acontece; qualquer mudança nestas variáveis tem muito impacto no processo de comunicação como um todo.&lt;/p&gt;
&lt;p&gt;“A possibilidade de participação e a exclusão do universo digital, integrando-se ao processamento de dados e à geração de conhecimentos, ou mesmo estando à margem dessa dinâmica, afeta, sobretudo, a relação humana em que a comunicação se faz atuante, perpassando os aspectos antropológico, social e mesmo filosófico. São linguagens, usos, percepções sensoriais, novas identidades formadas e trocas simbólicas que estão emaranhadas em rede, que não descarta nem mesmo o aspecto econômico dentro dessas novas relações. Do ponto de vista da economia, a rede trouxe mudanças profundas à sociedade, redefinindo as categorizações de Divisão Internacional do Trabalho (DIT) entre os países e as economias.” (SIMÕES, 2009)&lt;/p&gt;
&lt;p&gt;Dentro da mesma lógica da rede, essa congregação forma uma nova cultura que Lévy denomina de cultura do ciberespaço, ou “cibercultura”:&lt;/p&gt;
&lt;p&gt;&lt;em&gt;“O ciberespaço (que também chamarei de “rede”) é o novo meio de comunicação que surge da interconexão mundial dos computadores. O termo especifica não apenas a infra-estrutura material da comunicação digital, mas também o universo oceânico de informações que ela abriga, assim como os seres humanos que navegam e alimentam esse universo. Quanto ao neologismo “cibercultura”, especifica aqui o conjunto de técnicas (materiais e intelectuais), de práticas, de atitudes, de modos de pensamento e de valores que se desenvolvem juntamente com o crescimento do ciberespaço.” (LÉVY, 1999, p.17).&lt;/em&gt;&lt;/p&gt;
&lt;p&gt;E, dessa forma, não é à toa que estes temas são de grande interesse de estudiosos atuais, sejam eles das áreas das ciências sociais, comunicação, jornalismo, psicologia, marketing, entre vários outros.&lt;/p&gt;
&lt;p&gt;Lembra da afirmação: “O que domina o saber domina o mundo”? (COMBLIN, 2006). Pois então, hoje a corrida é pela informação e conhecimento rápido e acelerado. Porém não é a informação pela informação (ou comunicação pela comunicação) – elas sempre estiveram presentes na sociedade. O que é diferente agora é o poder relacionado a ela, como nos diz muito bem Castells:&lt;/p&gt;
&lt;p&gt;&lt;em&gt;“O termo sociedade da informação enfatiza o papel da informação na sociedade. Mas afirmo que informação, em seu sentido mais amplo, por exemplo, como comunicação de conhecimentos, foi crucial a todas as sociedades, inclusive à Europa medieval que era culturalmente estruturada e, até certo ponto, unificada pelo escolasticismo, ou seja, no geral uma infra-estrutura intelectual (ver Southern, 1995). Ao contrário, o termo informacional indica o atributo de uma forma específica de organização social em que a geração, o processamento e a transmissão da informação tornam-se as fontes fundamentais de produtividade e poder devido às novas condições tecnológicas surgidas nesse período histórico.” (CASTELLS, 1999, p.64-65).&lt;/em&gt;&lt;/p&gt;
&lt;p&gt;E assim, é nesta corrida que a Etnografia sai do espectro de importante apenas às Ciências Sociais, em específico a Antropologia, e ganha fama como uma das metodologias mais completas de entendimento deste novo mundo desconhecido.&lt;/p&gt;
&lt;p&gt;A Etnografia é uma metodologia que nos permite entender o outro através de sua cultura, seus hábitos, sua comunicação, seu comportamento.&lt;/p&gt;
&lt;p&gt;Como vimos em nosso vídeo, literalmente etnografia significa &lt;em&gt;descrição cultural de um povo –&lt;/em&gt;&lt;em&gt; &lt;/em&gt;Ethnos (cultura/povo) + graphein (escrita) – e, quando aplicada a este universo digital, permite entender estas novas relações e os novos comportamentos do ciberespaço e da cibercultura.&lt;/p&gt;
&lt;p&gt;&lt;strong&gt;Referências&lt;/strong&gt;&lt;br /&gt;
COMBLIN, José. O que é a verdade?, São Paulo: Editora Paulus, 2006&lt;/p&gt;
&lt;p&gt;CASTELLS, Manuel. A sociedade em rede. São Paulo: Paz e Terra, 1999. v. 1&lt;/p&gt;
&lt;p&gt;SIMÕES, Isabella de Araújo Garcia. A Sociedade em Rede e a Cibercultura: dialogando com o pensamento de Manuel Castells e de Pierre Lévy na era das novas tecnologias de comunicação. (2009). Revista eletrônica Temática.&lt;/p&gt;
&lt;p&gt;LEVY, Pierre. Cibercultura. São Paulo: Ed. 34, 1999&lt;/p&gt;
&lt;p&gt;[/vc_column_text][/vc_column][/vc_row]&lt;/p&gt;
" data-medium-file="" data-large-file="" class="aligncenter size-full wp-image-1800" src="https://i1.wp.com/ibpad.com.br/wp-content/uploads/2016/11/facebook-mbl4.png?resize=650%2C401" alt="facebook-mbl4" data-recalc-dims="1" /></a>
</p>
<p>
A nuvem de palavras dos comentários do MBL também é bastante parecida
com a nuvem das postagens. Vamos investigar o fluxo de comentários no
tempo.
</p>
<pre class="crayon-plain-tag">MBL$comment_date = ymd_hms(MBL$comment_published)
MBL$comment_date = round_date(MBL$comment_date, 'day')
datas = as.data.frame(table(MBL$comment_date), stringsAsFactors = F)
datas$Var1 = as.Date(datas$Var1)
limits = ymd(c(20160916, 20161118)) %&gt;% as.Date
ggplot(datas, aes(x=Var1, y=Freq))+geom_line()+scale_x_date(date_minor_breaks = '1 day', date_breaks = '1 week', date_labels = '%d-%m',  limits = limits)+
  labs(x='MBL',y='Número de Comentários')</pre>
<p>
<a href="https://i0.wp.com/ibpad.com.br/wp-content/uploads/2016/11/facebook-mbl5.png"><img data-attachment-id="1801" data-permalink="http://www.ibpad.com.br/conteudos/consultorias/" data-orig-file="" data-orig-size="" data-comments-opened="0" data-image-meta="[]" data-image-title="consultorias" data-image-description="" data-medium-file="" data-large-file="" class="aligncenter size-full wp-image-1801" src="https://i0.wp.com/ibpad.com.br/wp-content/uploads/2016/11/facebook-mbl5.png?resize=650%2C401" alt="facebook-mbl5" data-recalc-dims="1" /></a>
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

<p>
O post
<a rel="nofollow" href="http://www.ibpad.com.br/blog/analise-de-dados/polarizacao-politica-no-brasil-em-2016-big-data-e-social-network-analysis/">A
polarização política no Brasil em 2016 – Big Data e Social Network
Analysis</a> apareceu primeiro em
<a rel="nofollow" href="http://www.ibpad.com.br">IBPAD</a>.
</p>

