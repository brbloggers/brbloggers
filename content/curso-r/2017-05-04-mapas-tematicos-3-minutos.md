+++
title = "Gráficos miojo: Mapas temáticos do Brasil em 3 minutos ou menos"
date = "2017-05-04 20:26:00"
categories = ["curso-r"]
original_url = "http://curso-r.com/blog/2017/05/04/2017-05-04-mapas-tematicos-3-minutos/"
+++

<p class="text-muted text-uppercase mb-small text-right">
Por <a href="http://curso-r.com/author/fernando">Fernando</a> 04/05/2017
</p>
<p>
De todas as visualizações, mapas são aquelas que impressionam mais. É
muito mais fácil alguém se maravilhar com o mapa mais simples do que com
o <code>ggplot2</code> mais complicado. Felizmente, considerando essa
comparação, o R disponibiliza muitos recursos para construir mapas.
</p>
<p>
Dentro do <code>tidyverse</code> é possível construir mapas usando a
função <code>geom\_map</code>, do pacote <code>ggplot2</code>, mas está
fora do escopo deste post explicar como ela funciona. Aqui vamos apenas
descobrir como usá-la para agilizar a construção de um gráfico simples.
</p>
<p>
Na Associação Brasileira de Jurimetria, nós temos um tipo favorito de
mapa. Tipicamente temos interesse em diferenciar as unidades da
federação por alguma variável quantitativa, seja ela categorizada ou
não, e a ferramenta certa para isso é um mapa temático dos estados. Essa
necessidade é tão frequente que as ferramentas mais importantes para
construção desses gráficos estão num pacote chamado
<code>abjData</code>.
</p>
<p>
As coisas estão dispostas de tal forma que, a partir de uma tabela que
relaciona uma variavel e os estados brasileiros, construir um gráfico
similar ao mapa abaixo pode ser feito chamando apenas uma
função<a href="http://curso-r.com/blog/2017/05/04/2017-05-04-mapas-tematicos-3-minutos/#fn1" class="footnoteRef" id="fnref1"><sup>1</sup></a>.
</p>
<pre class="r"><code>dataset %&gt;% constroi_mapa_tematico()</code></pre>
<p>
<img src="http://curso-r.com/blog/2017-05-04-mapas-tematicos-3-minutos_files/figure-html/unnamed-chunk-4-1.png" width="672">
</p>
<p>
Neste post, vamos construir a função
<code>constroi\_mapa\_tematico</code> e aprender a implementar alguns
<code>tweaks</code>.
</p>
<p>
O <code>geom\_map</code> é uma função do <code>ggplot2</code> que
renderiza coordenadas de mapas. Ela pega um data\_frame especial que diz
quais coordenadas usar (e como usá-las) e plota no gráfico. Esse mapa
normalmente é obtido aplicando a função <code>fortify</code> em um
conjunto de dados geospaciais.
</p>
<p>
Para os gráficos que vamos construir aqui, não vai ser necessário
aplicar a função <code>fortify</code>, pois o resultado desse passo já
está disponível no pacote <code>abjData</code> e ele é o data\_frame
<code>br\_uf\_map</code>. Tudo que vamos precisar fazer é pedir que o
<code>geom\_map</code> use esse cara.
</p>
<pre class="r"><code>devtools::install_github(&apos;abjur/abjData&apos;)
#instala o pacote</code></pre>
<pre class="r"><code>constroi_mapa_tematico &lt;- function(dataset){ dataset %&gt;% inner_join(abjData::br_uf_map) %&gt;% { ggplot(.) + geom_map(aes(x = long, y = lat, map_id = id, fill = variavel), color = &apos;gray30&apos;, map = ., data = .) + theme_void() + coord_equal() }
}</code></pre>
<p>
O <code>input</code> da função é uma tabela <code>dataset</code> com
duas colunas
</p>
<ul>
<li>
<code>id</code>, que representa as unidades da federação abreviada;
</li>
<li>
<code>variavel</code>, variável numérica (ou fator) que vai colorir o
gráfico.
</li>
</ul>
<p>
No exemplo acima essa tabela era:
</p>
<pre class="r"><code>dataset %&gt;% head(10)</code></pre>
<pre><code>FALSE # A tibble: 10 x 2
FALSE id variavel
FALSE &lt;chr&gt; &lt;dbl&gt;
FALSE 1 TO 94.93079
FALSE 2 SP 278.79676
FALSE 3 SE 35.50231
FALSE 4 SC 204.85650
FALSE 5 RS 169.19369
FALSE 6 RR 114.90413
FALSE 7 RO 152.47085
FALSE 8 RN 26.22847
FALSE 9 RJ 107.42855
FALSE 10 PR 148.47011</code></pre>

<p>
A função <code>constroi\_mapa\_tematico</code> devolve um
<code>ggplot2</code>, então ainda dá pra mexer em alguns parâmetros
estéticos após a construção do mapa. As três coisas que vamos aprender a
fazer são
</p>
<ol>
<li>
Adicionar labels e títulos
</li>
</ol>
<pre class="r"><code>dataset %&gt;% constroi_mapa_tematico() + ggtitle(&quot;Roubos de carros no Brasil em 2014&quot;) + scale_fill_continuous(name = &quot;Taxa/100 mil hab.&quot;)</code></pre>
<p>
<img src="http://curso-r.com/blog/2017-05-04-mapas-tematicos-3-minutos_files/figure-html/unnamed-chunk-8-1.png" width="672">
</p>
<ol>
<li>
Alterar as cores da escala
</li>
</ol>
<pre class="r"><code>dataset %&gt;% constroi_mapa_tematico() + ggtitle(&quot;Roubos de carros no Brasil em 2014&quot;) + scale_fill_continuous(name = &quot;Taxa/100 mil hab.&quot;, low = &apos;white&apos;, high = &apos;red&apos;, na.value = &apos;white&apos;)</code></pre>
<p>
<img src="http://curso-r.com/blog/2017-05-04-mapas-tematicos-3-minutos_files/figure-html/unnamed-chunk-9-1.png" width="672">
</p>
<pre class="r"><code>dataset %&gt;% constroi_mapa_tematico() + ggtitle(&quot;Roubos de carros no Brasil em 2014&quot;) + scale_fill_continuous(name = &quot;Taxa/100 mil hab.&quot;, low = &apos;green&apos;, high = &apos;red&apos;, na.value = &apos;white&apos;, breaks = seq(0,300,50))</code></pre>
<p>
<img src="http://curso-r.com/blog/2017-05-04-mapas-tematicos-3-minutos_files/figure-html/unnamed-chunk-10-1.png" width="672">
</p>

