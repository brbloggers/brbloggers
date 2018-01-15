+++
title = "Explorando os dados de criminalidade em São Paulo"
date = "2017-12-29 20:11:29"
categories = ["ghcarvalho"]
original_url = "https://medium.com/@ghcarvalho/explorando-os-dados-de-criminalidade-em-s%C3%A3o-paulo-479fa6943096?source=rss-1c8e675e88ec------2"
+++

<p id="2f87" class="graf graf--p graf-after--h3">
Nos últimos dias tenho pensado bastante nos fatores que influenciam nos
números da criminalidade aqui em Ribeirão Preto. Se eu tivesse poder
sobre onde investir recursos para diminuir esses números, onde
investiria? Educação? Economia? Polícia?
</p>
<p id="bffd" class="graf graf--p graf-after--p">
O primeiro passo para tentar responder a essa pergunta é conseguir dados
para comparar a quantidade de crimes com indicadores da educação e
economia nos municípios de São Paulo e ver se aparece algum padrão.
Agora, a ideia é explorar os dados de criminalidade principalmente,
relacionando-os com população, educação e economia. Depois, em outra
postagem, tentarei prever o número de roubos, furtos e homicídios usando
esse conjunto de dados.
</p>
<p id="70de" class="graf graf--p graf-after--p">
Os dados de educação e economia para os municípios de São Paulo foram
“retirados” do
<a href="https://cidades.ibge.gov.br/" class="markup--anchor markup--p-anchor">IBGE
Cidades</a>. Os da criminalidade foram retirados da página da
<a href="http://www.ssp.sp.gov.br/Estatistica/Pesquisa.aspx" class="markup--anchor markup--p-anchor">Secretaria
de Segurança Pública de São Paulo</a>. Entenda “retirados” como um
eufemismo para raspados das páginas. O IBGE até tem uma API, mas o uso é
praticamente impossível sem documentação detalhada. Até onde eu sei, a
SSP-SP não tem uma API. As funções do R que fiz para baixar todas as
informações estão no
<a href="https://github.com/gustavobio/medium-crimes/" class="markup--anchor markup--p-anchor">github</a>.
</p>
<p id="792c" class="graf graf--p graf-after--p">
Sem qualquer transformação, o conjunto de dados possui 349 variáveis
para cada um dos 645 municípios paulistas. Dentre elas, há número de
roubos e furtos de veículos e outros, número de homicídios, de
latrocínios, de estupros e outros indicadores da criminalidade no
município que podem ser encontrados
<a href="http://ssp.sp.gov.br/estatistica/pesquisa.aspx" class="markup--anchor markup--p-anchor">aqui</a>.
Já as variáveis que indicam o estado da educação em cada cidade são:
número de matrículas e docentes separados por nível de escolaridade,
número de pessoas sem estudo, número de pessoas com ensino médio ou
superior completo e incompleto, escolaridade por faixa etária e cor,
<em class="markup--em markup--p-em">etc.</em> Finalmente, a economia é
sintetizada pelo salário médio na cidade, produto interno bruto, número
de pessoas ocupadas, número de automóveis, número de motocicletas,
dentre outras. Como muitas variáveis são têm correlação muito alta e é
inviável trabalhar com todas elas aqui, selecionei um subconjunto com as
32 que acredito serem as mais relevantes. Os dados de população e
escolaridade são do censo de 2010. Os de economia, de 2014 e 2015. Os
números da criminalidade são de 2015.
</p>
<p id="2cf4" class="graf graf--p graf-after--p">
Caso queira acompanhar pelo código, a rotina está disponível no fim
desta postagem. Para não deixar o texto muito longo, pularei a parte em
que baixo e transformo os dados e analiso as distribuições, indo direto
para as relações entre as variáveis
(<code class="markup--code markup--p-code">sp\_all</code> é o data frame
com o conjunto). O primeiro passo é ver as correlações entre as
variáveis selecionadas:
</p>
<pre id="f0a7" class="graf graf--pre graf-after--p">corrplot(cor(select(sp_all, -id, -cidade)))</pre>
<figure id="429b" class="graf graf--figure graf-after--pre">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/1*7vBroofiKBphAyyI82uaOg.png">
</figure>
<p id="3a77" class="graf graf--p graf-after--figure">
Os tamanhos dos círculos e as cores indicam que quase todas as variáveis
são basicamente perfeitamente correlacionadas. Isso é uma
<a href="https://en.wikipedia.org/wiki/Simpson%27s_paradox" class="markup--anchor markup--p-anchor">correlação
espúria</a>, provavelmente fruto do efeito da influência do tamanho da
população do município sobre todas as outras variáveis. Podemos conferir
se é isso mesmo que está ocorrendo calculando os números por 1000
habitantes no lugar dos absolutos e refazer o diagrama de correlações:
</p>
<pre id="d32a" class="graf graf--pre graf-after--p">sp_all &lt;- sp_all %&gt;%<br>  mutate_at(vars(estupro:tentativa_homicidio), funs(./populacao*1000)) %&gt;%<br>  mutate_at(vars(docentes_fundamental:numero_empresas), funs(./populacao*1000)) %&gt;%<br>  mutate(populacao_urbana = populacao_urbana/populacao) %&gt;%<br>  mutate_at(vars(motocicleta:automovel), funs(./populacao*1000)) %&gt;%<br>  select(city, populacao, everything())</pre>
<pre id="aebc" class="graf graf--pre graf-after--pre">corrplot(cor(select(sp_all, -id, -cidade)))</pre>
<figure id="9b50" class="graf graf--figure graf-after--pre">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/1*gbJqcKzcVHd52lcvvsE6Ew.png">
</figure>
<p id="d5e3" class="graf graf--p graf-after--figure">
Pronto, agora as correlações são mais plausíveis. Ainda há algumas
variáveis com correlações altas e que eu poderia retirar, mas vou
mantê-las por enquanto. O que mais salta aos olhos é que o número de
pessoas sem estudo apresenta correlações negativas com alguns tipos de
crimes como furtos e roubos. Quanto mais pessoas sem instrução por 1000
habitantes, menos roubos e furtos. Creio que isso seja efeito das
cidades menores, que tendem a ter maior proporção de pessoas com baixa
escolaridade. Vejamos:
</p>
<pre id="fbae" class="graf graf--pre graf-after--p">sp_all %&gt;%<br>  filter(city != &quot;S&#xE3;o Paulo&quot;) %&gt;%<br>  ggplot(aes(x = populacao, y = n_pessoas_sem_instrucao, group = 1)) + <br>  geom_point() + <br>  geom_smooth() + <br>  xlab(&quot;Popula&#xE7;&#xE3;o&quot;) + <br>  ylab(&quot;N&#xFA;mero de pessoas sem instru&#xE7;&#xE3;o por 1000 habitantes&quot;) +<br>  theme_bw()</pre>
<figure id="ffaf" class="graf graf--figure graf-after--pre">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/1*5EswEScPB6d9jT8bjsqBVw.png">
</figure>
<p id="cef8" class="graf graf--p graf-after--figure">
Até aproximadamente 125 mil habitantes, quanto maior a cidade, menor a
proporção de pessoas sem estudo. Confesso que fiquei espantado com
alguns municípios:
</p>
<pre id="ff70" class="graf graf--pre graf-after--p">sp_all %&gt;%<br>  select(city, populacao, n_pessoas_sem_instrucao) %&gt;%<br>  mutate(pct_sem_instrucao = n_pessoas_sem_instrucao/10) %&gt;%<br>  select(-n_pessoas_sem_instrucao) %&gt;%<br>  arrange(desc(pct_sem_instrucao)) %&gt;%<br>  head(5)</pre>
<pre id="3cfc" class="graf graf--pre graf-after--pre">                      populacao pct_sem_instrucao<br>1            Balbinos      3702          70.42139<br>2 Natividade da Serra      6678          60.93142<br>3              Parisi      2032          59.79331<br>4              Quadra      3236          58.80717<br>5      Barra do Turvo      7729          57.56243</pre>
<p id="bc8a" class="graf graf--p graf-after--pre">
Onde estão as cidades com maior proporção de pessoas com baixa
escolaridade?
</p>
<pre id="0d2a" class="graf graf--pre graf-after--p">sp_sf %&gt;% <br>  right_join(select(sp_all, cidade, n_pessoas_sem_instrucao), by = c(&quot;municipio&quot; = &quot;cidade&quot;)) %&gt;%<br>  ggplot() + <br>  geom_sf(aes(fill = n_pessoas_sem_instrucao/10), colour = &quot;black&quot;, size = 0.2) + <br>  theme_minimal() + <br>  coord_sf(datum = NA) + <br>  scale_fill_viridis_c(option = &quot;plasma&quot;, name = &quot;% de habitantes com fundamental incompleto&quot;) + <br>  guides(fill = guide_colorbar(barwidth = 10, title.position = &quot;top&quot;)) + <br>  theme(legend.position = &quot;bottom&quot;)</pre>
<figure id="bfa6" class="graf graf--figure graf-after--pre">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/1*50n09j80CxA2VZp2WbNOzw.png">
</figure>
<p id="99fe" class="graf graf--p graf-after--figure">
Quando eu for construir os modelos, talvez eu tenha que ajustar modelos
separados de acordo com o tamanho da cidade. Aliás, quais são as 20
maiores cidades (em tamanho da população)?
</p>
<pre id="94a6" class="graf graf--pre graf-after--p">sp_all %&gt;%<br>  select(cidade, populacao) %&gt;%<br>  mutate(cidade = reorder(cidade, populacao)) %&gt;%<br>  arrange(desc(populacao)) %&gt;%<br>  top_n(20) %&gt;%<br>  ggplot(aes(x = cidade, y = populacao)) + <br>  geom_bar(stat = &quot;identity&quot;) + <br>  xlab(&quot;Munic&#xED;pio&quot;) + <br>  ylab(&quot;Popula&#xE7;&#xE3;o&quot;) + <br>  scale_y_continuous(labels = scales::format_format(big.mark = &quot;.&quot;, decimal.mark = &quot;,&quot;, scientific = FALSE)) + <br>  coord_flip() + <br>  theme_bw()</pre>
<figure id="9598" class="graf graf--figure graf-after--pre">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/1*OFke6XusEX4gpDJOgqkiYA.png">
</figure>
<p id="9284" class="graf graf--p graf-after--figure">
Será que o número de crimes por 1000 habitantes também tem uma relação
com a população? Vejamos os furtos (excluindo furtos de veículos):
</p>
<pre id="4b1c" class="graf graf--pre graf-after--p">sp_all %&gt;%<br>  filter(cidade != &quot;S&#xE3;o Paulo&quot;) %&gt;%<br>  ggplot(aes(x = populacao, y = furto_outros)) + <br>  geom_point(alpha = 0.5) + <br>  geom_smooth() + <br>  xlab(&quot;Popula&#xE7;&#xE3;o&quot;) + <br>  ylab(&quot;N&#xFA;mero de furtos por 1000 habitantes&quot;) +<br>  theme_bw()</pre>
<figure id="fcb9" class="graf graf--figure graf-after--pre">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/1*MoskPSd8Kt86imKVLvl4zQ.png">
</figure>
<p id="c8b2" class="graf graf--p graf-after--figure">
Excluí São Paulo para não ter que transformar os dados, mas os números
estão na média para outras cidades grandes. Até por volta de 60 mil
habitantes, quanto maior a população maior o número de furtos a cada
1000 pessoas. Depois disso, os furtos parecem não aumentar com o tamanho
da cidade. A distribuição deles também não parece ser agregada:
</p>
<pre id="b211" class="graf graf--pre graf-after--p">sp_sf %&gt;% <br>  right_join(select(sp_all, cidade, furto_outros), by = c(&quot;municipio&quot; = &quot;cidade&quot;)) %&gt;%<br>  ggplot() + <br>  geom_sf(aes(fill = furto_outros), colour = &quot;black&quot;, size = 0.2) + <br>  theme_minimal() + <br>  coord_sf(datum = NA) + <br>  scale_fill_viridis_c(option = &quot;plasma&quot;, name = &quot;Furtos por 1000 habitantes&quot;) + <br>  guides(fill = guide_colorbar(barwidth = 10, title.position = &quot;top&quot;)) + <br>  theme(legend.position = &quot;bottom&quot;)</pre>
<figure id="34b7" class="graf graf--figure graf-after--pre">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/1*jzWill-3ZpKZnKT45UJTgw.png">
</figure>
<p id="d817" class="graf graf--p graf-after--figure">
Agora os roubos (mais uma vez, excluindo São Paulo e roubos de
veículos):
</p>
<pre id="16c2" class="graf graf--pre graf-after--p">sp_all %&gt;%<br>  filter(cidade != &quot;S&#xE3;o Paulo&quot;) %&gt;%<br>  ggplot(aes(x = populacao, y = roubos_outros)) + <br>  geom_point(alpha = 0.5) + <br>  geom_smooth() + <br>  xlab(&quot;Popula&#xE7;&#xE3;o&quot;) + <br>  ylab(&quot;N&#xFA;mero de roubos por 1000 habitantes&quot;) +<br>  theme_bw()</pre>
<figure id="1bd9" class="graf graf--figure graf-after--pre">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/1*gBgLGm5ml3SVEpF4cuXFqQ.png">
</figure>
<p id="afd3" class="graf graf--p graf-after--figure">
Quanto maior a cidade, maior o número de roubos por 1000 habitantes.
Vejamos o mapa dos roubos:
</p>
<pre id="6e9f" class="graf graf--pre graf-after--p">sp_sf %&gt;% <br>  right_join(select(sp_all, cidade, roubos_outros), by = c(&quot;municipio&quot; = &quot;cidade&quot;)) %&gt;%<br>  ggplot() + <br>  geom_sf(aes(fill = roubos_outros), colour = &quot;black&quot;, size = 0.2) + <br>  theme_minimal() + <br>  coord_sf(datum = NA) + <br>  scale_fill_viridis_c(option = &quot;plasma&quot;, name = &quot;Roubos por 1000 habitantes&quot;) + <br>  guides(fill = guide_colorbar(barwidth = 10, title.position = &quot;top&quot;)) + <br>  theme(legend.position = &quot;bottom&quot;)</pre>
<figure id="d3f9" class="graf graf--figure graf-after--pre">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/1*h4SjSjt88TRkayK_MDF-jQ.png">
</figure>
<p id="a43a" class="graf graf--p graf-after--figure">
As cidades com maior número de roubos por habitante estão concentradas
na Grande São Paulo e litoral. Comparando os dois mapas não parece haver
uma relação tão grande entre o número de roubos e furtos. O diagrama de
dispersão abaixo mostra que há uma relação até um determinado ponto.
</p>
<pre id="3172" class="graf graf--pre graf-after--p">sp_all %&gt;%<br>  ggplot(aes(x = roubos_outros, y = furto_outros)) + <br>  geom_point() + <br>  geom_smooth() + <br>  xlab(&quot;Roubos por 1000 habitantes&quot;) + <br>  ylab(&quot;Furtos por 1000 habitantes&quot;) + <br>  theme_bw()</pre>
<figure id="1949" class="graf graf--figure graf-after--pre">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/1*vVrN6UNkuF4CLES7FGhmIg.png">
</figure>
<p id="08d0" class="graf graf--p graf-after--figure">
Será que a relação muda à partir de um certo tamanho dos municípios?
</p>
<pre id="ce56" class="graf graf--pre graf-after--p">sp_all %&gt;%<br>  ggplot(aes(x = roubos_outros, y = furto_outros)) + <br>  geom_point(alpha = 0.3, aes(size = sqrt(populacao))) + <br>  geom_smooth() + <br>  xlab(&quot;Roubos por 1000 habitantes&quot;) + <br>  ylab(&quot;Furtos por 1000 habitantes&quot;) + <br>  theme_bw() + <br>  theme(legend.position = &quot;none&quot;)</pre>
<figure id="5c5d" class="graf graf--figure graf-after--pre">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/1*m_MlXYBbCuhQOC89JgKHSQ.png">
</figure>
<p id="41bf" class="graf graf--p graf-after--figure">
Os tamanhos dos círculos são proporcionais aos tamanhos das cidades. Nas
cidades maiores, parece não haver relação entre furtos e roubos. Não há
muito mais furtos por habitante do que em cidades menores, mas há muito
mais roubos nelas. A violência das abordagens parece aumentar com o
tamanho das cidades. Agrupando roubos, furtos e homicídios com uma PCA
vemos as cidades que se destacam:
</p>
<pre id="1dfe" class="graf graf--pre graf-after--p">pca &lt;- prcomp(select(sp_all, <br>                     furto_outros,<br>                     furto_veiculos,<br>                     roubos_outros,<br>                     roubo_banco,<br>                     roubo_veiculo,<br>                     roubo_carga,<br>                     homicidio_doloso,<br>                     latrocinio))<br>pca_scores &lt;- data.frame(pca$x[, 1:2])<br>pca_scores$cidade &lt;- sp_all$cidade<br>pca_scores$populacao &lt;- sp_all$populacao</pre>
<pre id="4aec" class="graf graf--pre graf-after--pre">highlights &lt;- pca_scores %&gt;%<br>  arrange(desc(PC1)) %&gt;%<br>  head(6) %&gt;%<br>  bind_rows(., head(arrange(pca_scores, PC2)))</pre>
<pre id="2b1b" class="graf graf--pre graf-after--pre">ggplot(pca_scores, aes(x = PC1, y = PC2)) + <br>  geom_point(aes(size = sqrt(populacao)), alpha = 0.3, col = &quot;royalblue&quot;) + <br>  geom_text(aes(x = PC1 + 2, y = PC2, label = cidade), data = highlights, check_overlap = T, nudge_x = -5) + <br>  theme_bw() + <br>  theme(legend.position = &quot;none&quot;)</pre>
<figure id="4e23" class="graf graf--figure graf-after--pre">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/1*lzIzY1sLg2QeYHWEM9Z04w.png">
</figure>
<p id="e532" class="graf graf--p graf-after--figure">
Em Ilha Comprida há muitos furtos, enquanto em São Paulo, Santo André,
Osasco e Diadema há muitos roubos. As cidades ranqueadas quanto aos
roubos e furtos:
</p>
<pre id="5fad" class="graf graf--pre graf-after--p">sp_all %&gt;%<br>  mutate(furtos = furto_outros + furto_veiculos) %&gt;%<br>  select(cidade, furtos) %&gt;%<br>  mutate(cidade = reorder(cidade, furtos)) %&gt;%<br>  arrange(desc(furtos)) %&gt;%<br>  top_n(20) %&gt;%<br>  ggplot(aes(x = cidade, y = furtos)) + <br>  geom_bar(stat = &quot;identity&quot;) + <br>  xlab(&quot;Munic&#xED;pio&quot;) + <br>  ylab(&quot;N&#xFA;mero de furtos por 1000 habitantes&quot;) + <br>  coord_flip() + <br>  theme_bw()</pre>
<figure id="7f14" class="graf graf--figure graf-after--pre">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/1*Bs0fv9WT3RKP7Qev51sdjQ.png">
</figure>
<pre id="95dc" class="graf graf--pre graf-after--figure">sp_all %&gt;%<br>  mutate(roubos = roubos_outros + roubo_banco + roubo_carga + roubo_veiculo) %&gt;%<br>  select(cidade, roubos) %&gt;%<br>  mutate(cidade = reorder(cidade, roubos)) %&gt;%<br>  arrange(desc(roubos)) %&gt;%<br>  top_n(20) %&gt;%<br>  ggplot(aes(x = cidade, y = roubos)) + <br>  geom_bar(stat = &quot;identity&quot;) + <br>  xlab(&quot;Munic&#xED;pio&quot;) + <br>  ylab(&quot;N&#xFA;mero de roubos por 1000 habitantes&quot;) + <br>  coord_flip() + <br>  theme_bw()</pre>
<figure id="7217" class="graf graf--figure graf-after--pre">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/1*VWh7kUBOphmmsrFyDA1dYw.png">
</figure>
<p id="ebba" class="graf graf--p graf-after--figure">
Agora vamos ver as relações de roubos e furtos com indicadores da
economia. Primeiro as cidades com maiores PIBs per capita:
</p>
<pre id="5c27" class="graf graf--pre graf-after--p">sp_all %&gt;%<br>  select(cidade, pib) %&gt;%<br>  mutate(cidade = reorder(cidade, pib)) %&gt;%<br>  arrange(desc(pib)) %&gt;%<br>  top_n(20) %&gt;%<br>  ggplot(aes(x = cidade, y = pib)) + <br>  geom_bar(stat = &quot;identity&quot;) + <br>  xlab(&quot;Munic&#xED;pio&quot;) + <br>  ylab(&quot;PIB per capita&quot;) + <br>  scale_y_continuous(labels = scales::format_format(big.mark = &quot;.&quot;, decimal.mark = &quot;,&quot;, scientific = FALSE)) + <br>  coord_flip() + <br>  theme_bw()</pre>
<figure id="d8be" class="graf graf--figure graf-after--pre">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/1*PeK5Tddbh6dtF-iiarUiQA.png">
</figure>
<p id="5801" class="graf graf--p graf-after--figure">
Agora a relação do PIB com o número de furtos:
</p>
<pre id="c7ca" class="graf graf--pre graf-after--p">sp_all %&gt;%<br>  ggplot(aes(x = pib, y = furto_outros)) + <br>  geom_point(alpha = 0.3, aes(size = populacao)) + <br>  geom_smooth() + <br>  xlab(&quot;PIB per capita (reais)&quot;) + <br>  ylab(&quot;Furtos por 1000 habitantes&quot;) + <br>  theme_bw() + <br>  theme(legend.position = &quot;none&quot;) + <br>  scale_x_continuous(label = scales::unit_format(&quot;K&quot;, scale = 1e-3, sep = &quot;&quot;))</pre>
<figure id="2786" class="graf graf--figure graf-after--pre">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/1*lhDYATl0eawuhhamqv3_mw.png">
</figure>
<p id="8008" class="graf graf--p graf-after--figure">
A cidade com maior PIB per capita é Ilha Comprida, seguida por Louveira,
Ilhabela, Barueri e Paulínia. Quanto maior o PIB, mais furtos
aparentemente. Será um indicativo de desigualdade econômica? A relação
do PIB com os roubos:
</p>
<pre id="8818" class="graf graf--pre graf-after--p">sp_all %&gt;%<br>  ggplot(aes(x = pib, y = roubos_outros)) + <br>  geom_point(alpha = 0.3, aes(size = populacao)) + <br>  geom_smooth() + <br>  xlab(&quot;PIB per capita (reais)&quot;) + <br>  ylab(&quot;Roubos por 1000 habitantes&quot;) + <br>  theme_bw() + <br>  theme(legend.position = &quot;none&quot;) + <br>  scale_x_continuous(label = scales::unit_format(&quot;K&quot;, scale = 1e-3, sep = &quot;&quot;))</pre>
<figure id="8887" class="graf graf--figure graf-after--pre">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/1*vUurCWkzLw5Zf3APuTBJtA.png">
</figure>
<p id="d31c" class="graf graf--p graf-after--figure">
Não parece haver relação. As cidades com maiores salários médios:
</p>
<pre id="c5ba" class="graf graf--pre graf-after--p">sp_all %&gt;%<br>  select(cidade, salario_medio) %&gt;%<br>  mutate(cidade = reorder(cidade, salario_medio)) %&gt;%<br>  arrange(desc(salario_medio)) %&gt;%<br>  top_n(20) %&gt;%<br>  ggplot(aes(x = cidade, y = salario_medio)) + <br>  geom_bar(stat = &quot;identity&quot;) + <br>  xlab(&quot;Munic&#xED;pio&quot;) + <br>  ylab(&quot;Sal&#xE1;rio mensal m&#xE9;dio (sal&#xE1;rios m&#xED;nimos)&quot;) + <br>  coord_flip() + <br>  theme_bw()</pre>
<figure id="1c07" class="graf graf--figure graf-after--pre">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/1*Ty-SvTI-IZJO90o0UsMgvA.png">
</figure>
<p id="9194" class="graf graf--p graf-after--figure">
Relações de furtos e roubos com o salário:
</p>
<pre id="794c" class="graf graf--pre graf-after--p">sp_all %&gt;%<br>  ggplot(aes(x = salario_medio, y = furto_outros)) + <br>  geom_point(alpha = 0.3, aes(size = populacao)) + <br>  geom_smooth() + <br>  xlab(&quot;Sal&#xE1;rio mensal m&#xE9;dio (sal&#xE1;rios m&#xED;nimos)&quot;) + <br>  ylab(&quot;Furtos por 1000 habitantes&quot;) + <br>  theme_bw() + <br>  theme(legend.position = &quot;none&quot;)</pre>
<figure id="f4dc" class="graf graf--figure graf-after--pre">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/1*n1ivy177QTSt8WppRO6h2A.png">
</figure>
<p id="c8a9" class="graf graf--p graf-after--figure">
Furtos e salário médio mensal. Não parece haver nenhuma relação muito
importante. As cidades com maiores salários são Alumínio, Gavião
Peixoto, Macaubal, Cubatão e Paulínia. Roubos:
</p>
<pre id="fdcd" class="graf graf--pre graf-after--p">sp_all %&gt;%<br>  ggplot(aes(x = salario_medio, y = roubos_outros)) + <br>  geom_point(alpha = 0.3, aes(size = populacao)) + <br>  geom_smooth() + <br>  xlab(&quot;Sal&#xE1;rio mensal m&#xE9;dio (sal&#xE1;rios m&#xED;nimos)&quot;) + <br>  ylab(&quot;Roubos por 1000 habitantes&quot;) + <br>  theme_bw() + <br>  theme(legend.position = &quot;none&quot;)</pre>
<figure id="ea29" class="graf graf--figure graf-after--pre">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/1*cbYB6kEnBHzazWcropIaSA.png">
</figure>
<p id="694e" class="graf graf--p graf-after--figure">
Roubos em relação ao salário. Os mapas:
</p>
<pre id="a8ce" class="graf graf--pre graf-after--p">sp_sf %&gt;% <br>  right_join(select(sp_all, cidade, pib), by = c(&quot;municipio&quot; = &quot;cidade&quot;)) %&gt;%<br>  ggplot() + <br>  geom_sf(aes(fill = pib), colour = &quot;black&quot;, size = 0.2) + <br>  theme_minimal() + <br>  coord_sf(datum = NA) + <br>  scale_fill_viridis_c(label = scales::unit_format(&quot;K&quot;, scale = 1e-3, sep = &quot;&quot;), option = &quot;plasma&quot;, name = &quot;PIB per capita&quot;) + <br>  guides(fill = guide_colorbar(barwidth = 10, title.position = &quot;top&quot;)) + <br>  theme(legend.position = &quot;bottom&quot;)</pre>
<figure id="5104" class="graf graf--figure graf-after--pre">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/1*-LIf7q2-krGJzk_SPgLjWA.png">
</figure>
<p id="fc67" class="graf graf--p graf-after--figure">
O município amarelo brilhante no litoral sul é Ilha Comprida. Salários:
</p>
<pre id="f4e1" class="graf graf--pre graf-after--p">sp_sf %&gt;% <br>  right_join(select(sp_all, cidade, salario_medio), by = c(&quot;municipio&quot; = &quot;cidade&quot;)) %&gt;%<br>  ggplot() + <br>  geom_sf(aes(fill = salario_medio), colour = &quot;black&quot;, size = 0.2) + <br>  theme_minimal() + <br>  coord_sf(datum = NA) + <br>  scale_fill_viridis_c(option = &quot;plasma&quot;, name = &quot;Sal&#xE1;rio m&#xE9;dio mensal (sal&#xE1;rios m&#xED;nimos)&quot;) + <br>  guides(fill = guide_colorbar(barwidth = 10, title.position = &quot;top&quot;)) + <br>  theme(legend.position = &quot;bottom&quot;)</pre>
<figure id="61cd" class="graf graf--figure graf-after--pre">
<img class="progressiveMedia-noscript js-progressiveMedia-inner" src="https://cdn-images-1.medium.com/max/1600/1*tjS2GHhMhmXLG1AY25jUGw.png">
</figure>
<p id="805e" class="graf graf--p graf-after--figure graf--trailing">
O município amarelo no centro do estado é Gavião Peixoto. O mais ao sul,
perto de São Paulo, é Alumínio. No noroeste, temos Macaubal. Por
enquanto, deu para ter uma ideia das relações entre as principais
variáveis . Na próxima postagem vou tentar criar modelos que explicam o
número de furtos e roubos para identificar as variáveis mais
importantes. O código desta postagem está na minha
<a href="https://github.com/gustavobio" class="markup--anchor markup--p-anchor">página
do github.</a>
</p>

