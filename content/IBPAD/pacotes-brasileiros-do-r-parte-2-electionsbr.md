+++
title = "Pacotes brasileiros do R, parte 2: electionsBR"
date = "2017-02-14 18:39:48"
categories = ["IBPAD"]
original_url = "http://www.ibpad.com.br/blog/analise-de-dados/pacotes-brasileiros-do-r-parte-2-electionsbr/"
+++

<p>
<img class="alignleft" src="https://i0.wp.com/i.imgur.com/8oS3gxW.png?resize=144%2C108" data-recalc-dims="1" /><br />
O próximo pacote R da nossa série é o
<a href="https://github.com/silvadenisson/electionsBR" target="_blank">electionsBR</a>
de Denisson Silva, Fernando Meireles, e Beatriz Costa. Assim como
o <em>SciencesPo</em>, também lida com dados de política – neste caso,
eleições brasileiras. O pacote faz o download, organiza e agrega os
dados do Tribunal Superior Eleitoral para os anos 1996-2016. Neste post,
vamos dar uma olhada nas suas principais funções. Primeiro, pode
instalar e carregar o pacote assim:
</p>
<pre class="crayon-plain-tag">install.packages(&quot;electionsBR&quot;)
library(electionsBR)</pre>
<p>
Para ver a lista complete das funções, digite: <code>help(package =
"electionsBR")</code>. Por exemplo, o pacote tem a função
<code>candidate\_fed()</code>, que baixa os dados dos candidatos nas
eleições federais no Brasil.
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
<p>
Esses dados têm detalhes das profissões dos candidatos, partidos, data
de nascimento, etc. Vamos ver a descrição das profissões dos candidatos
para Governador nos estados de São Paulo, Rio de Janeiro, Minas Gerias e
Bahia nas eleições federais de 2006:
</p>
<pre class="crayon-plain-tag">library(tidyverse)

cand &lt;- candidate_fed(year = 2006)

gov &lt;- cand %&gt;% 
  filter(DESCRICAO_CARGO == &quot;GOVERNADOR&quot;,
         SIGLA_UF %in% c(&quot;BA&quot;, &quot;MG&quot;, &quot;SP&quot;, &quot;RJ&quot;))


ggplot(gov, aes(x = DESCRICAO_OCUPACAO)) +
  geom_bar() +
  coord_flip() +
  theme_classic() +
  labs(y = &quot;&quot;, x = &quot;&quot;)</pre>
<p>
<img src="https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/electionsBR_2.png?w=900" alt="" data-recalc-dims="1" /><br />
O pacote também pode ser usado para analisar dados de eleições locais.
Por exemplo, podemos ver a quantidade de candidatos que cada partido no
Sul tinha para o cargo de prefeito nas eleições de 2016 – que mostra a
forte presença tradicional do PT e PP no Rio Grande do Sul, por exemplo.
</p>
<pre class="crayon-plain-tag">par &lt;- party_mun_zone_local(year = 2016)

sul &lt;- par %&gt;% 
  filter(SIGLA_UF %in% c(&quot;RS&quot;, &quot;PR&quot;, &quot;SC&quot;),
         DESCRICAO_CARGO == &quot;Prefeito&quot;)


ggplot(sul, aes(x =SIGLA_PARTIDO)) +
  geom_bar() +
  coord_flip() +
  facet_wrap(nrow = 1, ~ SIGLA_UF) +
  labs(x = &quot;&quot;, y = &quot;&quot;)</pre>
<p>
<img src="https://i0.wp.com/www.ibpad.com.br/wp-content/uploads/2017/02/parties_electionsBR.png?w=900" alt="" data-recalc-dims="1" /><br />
E o pacote possui mais funções para ver os resultados das eleições,
sejam locais ou federais. Também podemos analisar, por exemplo, os
eleitores. A função <code>voter\_affiliation()</code> faz o download e
arruma dados das afiliações dos eleitores aos partidos. A função tem
dois argumentos, <code>party</code> e <code>uf</code>, que indica
que podemos investigar só um estado e partido por vez. Neste exemplo,
vou ver quantos comunistas temos no Acre, e em qual município.
</p>
<pre class="crayon-plain-tag">v_ac &lt;- voter_affiliation(party = &quot;PC do B&quot;, uf = &quot;AC&quot;) %&gt;% 
      filter(SITUACAO_DO_REGISTRO == &quot;REGULAR&quot;) %&gt;% 
      group_by(NOME_DO_MUNICIPIO) %&gt;% 
      summarise(N = n()) %&gt;%
      arrange(desc(N)) %&gt;% 
      top_n(n = 10)

# install.packages(&quot;knitr&quot;)
knitr::kable(v_ac, &quot;markdown&quot;)</pre>
<p>
</p>
<table>
<thead>
<tr class="header">
<th align="left">
NOME DO MUNICIPIO
</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">
TARAUACÁ
</td>
<td align="right">
2119
</td>
</tr>
<tr class="even">
<td align="left">
RIO BRANCO
</td>
<td align="right">
1870
</td>
</tr>
<tr class="odd">
<td align="left">
CRUZEIRO DO SUL
</td>
<td align="right">
731
</td>
</tr>
<tr class="even">
<td align="left">
ASSIS BRASIL
</td>
<td align="right">
374
</td>
</tr>
<tr class="odd">
<td align="left">
MÂNCIO LIMA
</td>
<td align="right">
364
</td>
</tr>
<tr class="even">
<td align="left">
JORDÃO
</td>
<td align="right">
358
</td>
</tr>
<tr class="odd">
<td align="left">
FEIJÓ
</td>
<td align="right">
252
</td>
</tr>
<tr class="even">
<td align="left">
BRASILÉIA
</td>
<td align="right">
237
</td>
</tr>
<tr class="odd">
<td align="left">
SENADOR GUIOMARD
</td>
<td align="right">
186
</td>
</tr>
<tr class="even">
<td align="left">
PLÁCIDO DE CASTRO
</td>
<td align="right">
182
</td>
</tr>
</tbody>
</table>
<p>
 
</p>
<p>
Rio Branco não é uma surpresa, dado que é a cidade maior do estado, e
tem boa chance que vai ter mais membros do partido do que outros
lugares. Tarauacá, contudo, é a quarta cidade em termos de população.
</p>
<p>
electionsBR tem bem mais para explorar, e os dados são ricos e vêm em
bases grandes (eventualmente, pode demorar um pouco para baixar tudo). É
um ótimo pacote para utilizar nas suas análises das eleições no Brasil.
É ótimo para incluir na produção de
<a href="http://robertmyles.github.io/ElectionsBR.html" target="_blank">mapas</a>,
por exemplo.
</p>
</blockquote>
<p>
Gostando da série? Veja o primeiro post:
<a href="http://www.ibpad.com.br/blog/analise-de-dados/pacotes-brasileiros-do-r-parte-1-sciencespo-e-soundexbr-do-daniel-marcelino/" target="_blank">SciencesPo
e SoudexBR</a>
</p>
<p>
O post
<a rel="nofollow" href="http://www.ibpad.com.br/blog/analise-de-dados/pacotes-brasileiros-do-r-parte-2-electionsbr/">Pacotes
brasileiros do R, parte 2: electionsBR</a> apareceu primeiro em
<a rel="nofollow" href="http://www.ibpad.com.br">IBPAD</a>.
</p>

