+++
title = "Pacotes brasileiros do R, parte 4: Flora e Brasil 2020"
date = "2017-03-10 14:16:46"
categories = ["IBPAD"]
original_url = "http://www.ibpad.com.br/blog/analise-de-dados/flora-e-brasil-2020/"
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
<pre class="crayon-plain-tag">install.packages(&quot;flora&quot;)

library(flora)</pre>
<p>
<code>flora</code> tem vários jeitos de fornecer os dados do Brasil
2020. Um método é usar a função <code>get.taxa()</code>, que te dá
informação sobre uma espécie específica. Por exemplo, dado que eu gosto
de café, posso usar esta com o argumento <code>states = TRUE</code> para
ver nos quais estados café ocorre.
</p>
<pre class="crayon-plain-tag">cafe &lt;- get.taxa(&quot;Coffea arabica&quot;, states = TRUE)

cafe$occurrence

[1] &quot;BR-AC|BR-AL|BR-BA|BR-CE|BR-DF|BR-ES|BR-GO|BR-MG|BR-MS|BR-PB|BR-PE|BR-PR|BR-RJ|BR-RS|BR-SC|BR-SE|BR-SP&quot;</pre>
<p>
Com o pacote <code>tidyverse</code>, podemos rapidamente arrumar isso
para algo mais fácil usar. E com o uso de
<a href="http://robertmyles.github.io/2016/10/09/map-making-with-r-and-electionsbr/" target="_blank">shapefiles</a>,
podemos mapear onde ocorre café no Brasil.
</p>
<p>
<img src="https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/03/Screen-Shot-2017-03-07-at-4.25.45-PM.png?w=900" alt="" data-recalc-dims="1" />
</p>
<p>
<code>flora</code> também cuida dos nomes complexos dos itens. Se você
escreve errado, ele adivinha:
</p>
<pre class="crayon-plain-tag">suggest.names(&quot;Cofee arabyca&quot;)

## [1] &quot;Coffea arabica&quot;</pre>
<p>
Podemos também combinar o pacote com as imagens excelentes do
<a href="http://phylopic.org/" target="_blank">Phylopic</a> com
<code>flora</code>. Por exemplo, podemos pegar dados de quatro árvores
brasileiras, inclusive a <em>Dimorphandra wilsonii</em>, a árvore mais
rara no país, e ver em qual estados achamos essas árvores. O pacote
<code>rphylopic</code> baixa a imagem do Phylopic.
</p>
<pre class="crayon-plain-tag">caju &lt;- get.taxa(&quot;Anacardium occidentale&quot;, states = T) %&gt;% 
  mutate(occurrence = gsub(&quot;BR-&quot;, &quot;&quot;, occurrence)) %&gt;% 
  separate(occurrence, into = c(&quot;AC&quot;, &quot;AL&quot;, &quot;AM&quot;, &quot;AP&quot;, &quot;BA&quot;, &quot;CE&quot;, &quot;DF&quot;,
                                &quot;ES&quot;, &quot;GO&quot;, &quot;MA&quot;, &quot;MG&quot;, &quot;MS&quot;, &quot;MT&quot;, &quot;PA&quot;,
                                &quot;PB&quot;, &quot;PE&quot;, &quot;PI&quot;, &quot;RJ&quot;, &quot;RN&quot;, &quot;RR&quot;, &quot;SE&quot;,
                                &quot;SP&quot;, &quot;TO&quot;), sep = &quot;\\|&quot;) %&gt;% 
  gather(state, st, AC:TO) %&gt;% 
  select(-st, -id) 

para &lt;- get.taxa(&quot;Bertholletia excelsa&quot;, states = T) %&gt;% 
  mutate(occurrence = gsub(&quot;BR-&quot;, &quot;&quot;, occurrence)) %&gt;% 
  separate(occurrence, into = c(&quot;AC&quot;, &quot;AM&quot;, &quot;AP&quot;, &quot;MT&quot;, &quot;PA&quot;, &quot;RO&quot;, &quot;RR&quot;), 
           sep = &quot;\\|&quot;) %&gt;% 
  gather(state, st, AC:RR) %&gt;% 
  select(-st, -id)   

dal &lt;- get.taxa(&quot;Dalbergia nigra&quot;, states = T) %&gt;% 
  mutate(occurrence = gsub(&quot;BR-&quot;, &quot;&quot;, occurrence)) %&gt;% 
  separate(occurrence, into = c(&quot;AL&quot;, &quot;BA&quot;, &quot;ES&quot;, &quot;MG&quot;, &quot;PB&quot;, &quot;PE&quot;, &quot;PR&quot;,
                                &quot;RJ&quot;, &quot;SE&quot;, &quot;SP&quot;), 
           sep = &quot;\\|&quot;) %&gt;% 
  gather(state, st, AL:SP) %&gt;% 
  select(-st, -id)   

wil &lt;- get.taxa(&quot;Dimorphandra wilsonii&quot;, states = T) %&gt;% 
  mutate(occurrence = gsub(&quot;BR-&quot;, &quot;&quot;, occurrence)) %&gt;% 
  separate(occurrence, into = c(&quot;MG&quot;), 
           sep = &quot;\\|&quot;) %&gt;% 
  gather(state, st, MG) %&gt;% 
  select(-st, -id) 
  
arv &lt;- full_join(caju, para) %&gt;% 
  full_join(dal) %&gt;% 
  full_join(wil)


library(rphylopic)
tree &lt;- image_data(&quot;f86235e3-f437-4630-9e77-73732b9bcf41&quot;, size = &quot;512&quot;)[[1]]

ggplot(arv, aes(x = state)) +
  geom_bar(alpha = 0.6) +
  add_phylopic(tree, alpha = 0.7) +
  theme_classic() +
  ylab(&quot;&quot;)</pre>
<p>
<img src="https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/03/unnamed-chunk-6-1.png?w=900" alt="" data-recalc-dims="1" />
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
<pre class="crayon-plain-tag">pim &lt;- vernacular(&quot;Pimenta&quot;)

head(pim$vernacular.name)

[1] &quot;alecrim-de-cobra/PORTUGUES/Alagoas | alfavaca brava/PORTUGUES/Par&aacute; | alfavaca de cobra/PORTUGUES/Amazonas | maricutinha/PORTUGUES/Bahia | pimenta de lagarta/PORTUGUES/Par&aacute;&quot;
[2] &quot;arengueiro/PORTUGUES/Bahia | catinga-de-porco/PORTUGUES/Bahia | jaborandi-da-restinga/PORTUGUES/Rio de Janeiro | jaburandi/PORTUGUES/Cear&aacute; | pimentinha/PORTUGUES/Cear&aacute;&quot;    
[3] &quot;pimentinha/PORTUGUES/Nordeste | guarda-orvalho/PORTUGUES/Nordeste | cumix&aacute;/PORTUGUES/Nordeste | cocarana-do-cerrado/PORTUGUES/Norte&quot;                                        
[4] &quot;chapadinho/PORTUGUES/Goi&aacute;s, Minas Gerais | fruta-de-tucano/PORTUGUES/Minas Gerais | merc&uacute;rio/PORTUGUES/Mato Grosso | pimenta/PORTUGUES/Minas Gerais&quot;                        
[5] &quot;pimentinha/PORTUGUES/Nordeste | cuminx&aacute;/PORTUGUES/Nordeste | cumix&aacute;/cumich&aacute;/PORTUGUES/Nordeste | atracador/PORTUGUES/Mato Grosso&quot;                                           
[6] &quot;canela-jacu&aacute;/PORTUGUES/Sudeste | canela-pimenta/PORTUGUES/Sudeste&quot;</pre>
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
<p>
O post
<a rel="nofollow" href="http://www.ibpad.com.br/blog/analise-de-dados/flora-e-brasil-2020/">Pacotes
brasileiros do R, parte 4: Flora e Brasil 2020</a> apareceu primeiro em
<a rel="nofollow" href="http://www.ibpad.com.br">IBPAD</a>.
</p>

