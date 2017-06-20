+++
title = "Medidas de Risco em Análise de Redes Financeiras"
date = "2016-10-07 19:20:49"
categories = ["IBPAD"]
original_url = "http://www.ibpad.com.br/blog/analise-de-dados/medidas-de-risco-em-analise-de-redes-financeiras/"
+++

<p>
<img class="alignleft wp-image-1538" src="https://i2.wp.com/ibpad.com.br/wp-content/uploads/2016/10/Cinelli-1024x805.png?resize=185%2C143" alt="cinelli" data-recalc-dims="1" />No
dia 15 de junho O IBPAD realizou o sua primeira edição dos Seminários
IBPAD com o tema
“<a href="http://ibpad.com.br/index.php/2016/07/14/seminario-do-ibpad-discute-ciencia-de-dados-como-metodologia-para-estudos-da-sociedade-e-politica/" target="_blank">Ciência
de Dados e Sociedade</a>”, em parceria com o Núcleo de Estudos e
Pesquisa em Políticas Públicas, Governo e Gestão (NP3-UnB). Realizado na
Universidade de Brasília, o Seminário reuniu pesquisadores de várias
áreas para discutir como a análise de dados se propõe a compreender
diferentes elementos sociais e institucionais.
</p>
<p>
Professor do nosso curso de Programação em R, Carlos Cinelli apresentou
o seu pacote para R “Network Risk Measures”.
</p>
<p>
Confira:
</p>
<p>
 
</p>
<p>
<iframe class="youtube-player" type="text/html" width="900" height="537" src="http://www.youtube.com/embed/2ZfKt3hcaL0?version=3&amp;rel=1&amp;fs=1&amp;autohide=2&amp;showsearch=0&amp;showinfo=1&amp;iv_load_policy=1&amp;wmode=transparent" allowfullscreen="true" style="border:0;">
</iframe>
</p>
<p>
Por razões técnicas, refizemos a gravação da mesma apresentação feita no
seminário.
</p>
<p>
<span id="more-1535"></span>
</p>
<p>
Você pode ver os slides da apresentação
<a href="http://ibpad.com.br/apresentacaoCinelli.html" class="broken_link">aqui</a>.
</p>
<p>
Quer praticar? Faça o download da base de dados utilizada no exemplo
<a href="http://ibpad.com.br/wp-content/uploads/2016/10/rede.zip">aqui</a>.
</p>
<p>
Segue o código utilizado na apresentação:
</p>
<p>
 
</p>
<pre class="crayon-plain-tag"># Limpar nossa área de trabalho -------------------------------------------

rm(list = ls())


# Carregar os pacotes que vamos usar --------------------------------------

library(igraph)
library(NetworkRiskMeasures)


# Nossa Rede --------------------------------------------------------------

rede &lt;- readRDS("rede.rds")

rede_p &lt;- graph_from_adjacency_matrix(rede$rede, weighted = T)
plot(rede_p)

rede_a &lt;- graph_from_adjacency_matrix(t(rede$rede), weighted = T)
buffer &lt;- rede$buffer
peso   &lt;- rede$peso


# Métricas clássicas de rede ----------------------------------------------
degree(rede_p, mode = "out")
strength(rede_p, mode = "out")
betweenness(rede_p)
closeness(rede_p, weights =  1/E(rede_p)$weight)
page_rank(rede_a)$vector




# Simulação de contágio em cascata ----------------------------------------

cascata &lt;- contagion(exposures = rede_a, buffer = buffer, weights = peso, method = "threshold")
summary(cascata)


# DebtRank ----------------------------------------------------------------
debtrank &lt;- contagion(exposures = rede_a, buffer = buffer, weights = peso, method = "debtrank")
summary(debtrank)

# Reconstrução de redes ---------------------------------------------------

L &lt;- c(a = 4, b = 5, c = 5, d = 0, e = 0, f = 2, g = 4)
A &lt;- c(a = 7, b = 5, c = 3, d = 1, e = 3, f = 0, g = 1)

# maxima entropia
ME &lt;- matrix_estimation(A, L, method = "me")
ME &lt;- round(ME, 2)
ME

# minima densidade
set.seed(192)
MD &lt;- matrix_estimation(A, L, method = "md")
MD</pre>
<p>
Veja também o vídeo completo de palestra do prof. Rommel Carvalho sobre
<a href="http://ibpad.com.br/index.php/2016/08/16/ciencia-de-dados-no-combate-corrupcao/" target="_blank">Ciência
de Dados no Combate à Corrupção</a>.
</p>
<blockquote>
<p>
Quer aprender R?
<a href="http://www.ibpad.com.br/produto/programacao-em-r/" target="_blank">Conheça
nosso curso de Programação em R. Inscrições abertas em São Paulo e
Brasília</a>
</p>
</blockquote>
<p>
O post
<a rel="nofollow" href="http://www.ibpad.com.br/blog/analise-de-dados/medidas-de-risco-em-analise-de-redes-financeiras/">Medidas
de Risco em Análise de Redes Financeiras</a> apareceu primeiro em
<a rel="nofollow" href="http://www.ibpad.com.br">IBPAD</a>.
</p>

