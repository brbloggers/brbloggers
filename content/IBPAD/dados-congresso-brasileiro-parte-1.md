+++
title = "Dados do Congresso Brasileiro – Parte 1"
date = "2017-05-01 15:18:31"
categories = ["IBPAD"]
original_url = "http://www.ibpad.com.br/blog/dados-congresso-brasileiro-parte-1/"
+++

<p>
O movimento por Dados Abertos está contribuindo imensamente para uma
maior transparência e consequente maior fiscalização. Mas outro ponto
super relevante é como os nossos cientistas políticos estão adorando
todo esse processo. Nunca foi tão fácil obter dados que antes eram
extremamente trabalhosos e difíceis de serem obtidos.
</p>
<p>
A mais recente novidade é o pacote para R
<a href="https://cran.r-project.org/web/packages/congressbr/" target="_blank">congressbr</a>,
desenvolvido por Guilherme Duarte e Robert McDonnell
(<a href="http://www.ibpad.com.br/produto/programacao-em-r-sp" target="_blank">professores
dos cursos de R do IBPAD</a>) e Danilo Freire. O que o pacote faz é
buscar nas APIs da Câmara dos Deputados e Senado Federal os dados e é
uma “mão na roda”. Muitas vezes os dados das APIs são bem confusos e,
principalmente, Senado e Câmara não se conversam muito.
</p>
<p>
Vou mostrar um rápido exemplo do pacote:
</p>
<pre class="crayon-plain-tag">#Instalando o pacote direto do repositório do GitHub
devtools::install_github("RobertMyles/congressbr")

#Carregando o pacote
library("congressbr")


#Buscando a lista de PLs na Câmara em 2017. Você pode escolher entre "PEC" e outras proposições.

PLsCamara &lt;- cham_bills(type = "PL", year = 2017)


#Buscando as informações detalhadas de cada PL

datalist = list() #criando uma lista vazia

for(i in 1:nrow(PLsCamara)){
  cat(i, "\n ")
    dat2 &lt;- cham_bill_info_id(PLsCamara$bill_id[i])
  datalist[[i]] &lt;- dat2 # adicionando cada chamada na minha lista
  
}

#transformando minha lista em um dataframe
PLDetalhadosCamara &lt;- dplyr::bind_rows(datalist)</pre>
<p>
Depois de ter rodado esse código, você terá um data.frame com
informações detalhadas de todos os PLs que foram apresentados em 2017.
Uma variável que eu acho super legal é a variável de
<pre class="crayon-plain-tag">bill_index</pre>
 . Essa é uma variável de texto com a indexação em termos da proposição.
Quem faz a inserção é a Mesa da Câmara dos Deputados, o que nos garante
uma certa qualidade nos termos. Vou utilizar essa variável para fazer
alguns tratamentos de texto e entender um pouco o que nossos Deputados
Federais andaram apresentando em 2017.
</p>
<p>
 
</p>
<pre class="crayon-plain-tag">#carregando o pacote TM
library(tm)

#definindo meu corpus
myCorpus &lt;- Corpus(VectorSource(PLDetalhadosCamara$bill_index))

#procedimentos de limpeza e tratamento

#deixando tudo minúsculo, removendo espaços e pontuação
myCorpus &lt;- tm_map(myCorpus, content_transformer(tolower))
myCorpus &lt;- tm_map(myCorpus, stripWhitespace)
myCorpus &lt;- tm_map(myCorpus,removePunctuation)

#removendo palavras que atrapalhariam a análise, atente-se que estou utilizando um dicionário padrão de "stopwords" do pacote e um conjunto de outros termos, ok? você pode continuar essa lista ou remover alguns termos daí também.
limpeza = c(stopwords("portuguese"), 
              "federal", "lei", "nacional", "alteracao", "criacao")
myCorpus = tm_map(myCorpus, removeWords, limpeza)

#gerando as tabelas de frequencia
myCorpus &lt;- tm_map(myCorpus, PlainTextDocument)
tdm &lt;- TermDocumentMatrix(myCorpus, 
                          control = list(wordLengths = c(1, Inf)))
tdm

dtm &lt;- as.DocumentTermMatrix(tdm)


(freq.terms &lt;- findFreqTerms(tdm, lowfreq = 2)) 
term.freq &lt;- rowSums(as.matrix(tdm))
#optei por deixar um valor mínimo de frequencia de 2 nos termos. você pode trabalhar isso conforme desejar.
term.freq &lt;- subset(term.freq, term.freq &gt;= 2) 
term.freqdf &lt;- data.frame(term = names(term.freq), freq = term.freq)</pre>
<p>
Os tratamentos feitos aqui são “padrões” e é muito provável que você vá
utilizá-los em bases diferentes. Vou mostrar nesse post uma simples
nuvem de palavras e nos próximos posts pretendo avançar um pouco na área
de “text mining”.
</p>
<pre class="crayon-plain-tag">#carregando o pacote
library(wordcloud)

#vou colocar uma semente aqui para quando você gerar aí a nuvem ficar igual
set.seed(1234)

#gerando a nuvem
wordcloud(words = term.freqdf$term, freq = term.freqdf$freq, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0, 
          colors=brewer.pal(8, "Dark2"))</pre>
<p>
Resultado:
</p>
<p>
<img data-attachment-id="5829" data-permalink="http://www.ibpad.com.br/blog/dados-congresso-brasileiro-parte-1/attachment/camarapl2017/" data-orig-file="https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/05/camaraPL2017.png?fit=808%2C411" data-orig-size="808,411" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;}" data-image-title="camaraPL2017" data-image-description="" data-medium-file="https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/05/camaraPL2017.png?fit=260%2C132" data-large-file="https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/05/camaraPL2017.png?fit=808%2C411" class="alignnone size-full wp-image-5829" src="https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/05/camaraPL2017.png?resize=808%2C411" alt="" srcset="https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/05/camaraPL2017.png?w=808 808w, https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/05/camaraPL2017.png?resize=260%2C132 260w, https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/05/camaraPL2017.png?resize=768%2C391 768w, https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/05/camaraPL2017.png?resize=100%2C51 100w" sizes="(max-width: 808px) 100vw, 808px" data-recalc-dims="1" />
</p>
<p>
 
</p>
<p>
Resultado simples, mas tenho certeza que você já pensou em vááárias
possibilidades, não é?  Não esquece de comentar aqui.
</p>
<p>
Ficou curioso e não sabe trabalhar com R?
<a href="http://www.ibpad.com.br/nossos-cursos/formacao-em-r/" target="_blank">Que
tal aprender conosco em nossa formação</a>? O curso de Programação em R
em São Paulo começa dia 6 de maio. Em Brasília nós teremos o curso de
<a href="http://www.ibpad.com.br/produto/dados-para-relacoes-governamentais-brasilia/" target="_blank">Dados
para Relações Governamentais. </a>
</p>
<p>
 
</p>
<p>
 
</p>
<p>
 
</p>
<p>
O post
<a rel="nofollow" href="http://www.ibpad.com.br/blog/dados-congresso-brasileiro-parte-1/">Dados
do Congresso Brasileiro – Parte 1</a> apareceu primeiro em
<a rel="nofollow" href="http://www.ibpad.com.br">IBPAD</a>.
</p>

