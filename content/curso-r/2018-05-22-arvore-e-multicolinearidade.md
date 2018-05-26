+++
title = "Modelos beseados em árvores são imunes à multicolinearidade?"
date = "2018-05-22"
categories = ["curso-r"]
original_url = "http://curso-r.com/blog/2018/05/22/2018-05-22-arvore-e-multicolinearidade/"
+++

<p class="text-muted text-uppercase mb-small text-right">
Por <a href="http://curso-r.com/author/athos">Athos</a> ,
<a href="http://curso-r.com/author/julio">Julio</a> 22/05/2018
</p>
<p>
Modelos baseados em árvores como árvores de decisão, random forest,
ligthGBM e xgboost são conhecidos, dentre outras qualidades, pela sua
robustês diante do problema de multicolinearidade. É sabido que seu
poder preditivo não se abala na presença de variáveis extremamente
correlacionadas.
</p>
<p>
Porém, quem nunca usou um Random Forest pra fazer seleção de variáveis?
Pegar, por exemplo, as top 10 mais importantes e descartar o resto?
</p>
<p>
Ou até mesmo arriscou uma interpretação e concluiu sobre a ordem das
variáveis mais importantes?
</p>
<p>
Abaixo mostraremos o porquê não devemos ignorar a questão da
multicolinearidade completamente!
</p>
<p>
Primeiro vamos ajustar um modelo bonitinho, livre de multicolinearidade.
Suponha que queiramos prever <code>Petal.Length</code> utilizando as
medidas das sépalas (<code>Sepal.Width</code> e
<code>Sepal.Length</code>) da nossa boa e velha base <code>iris</code>.
</p>
<pre class="r"><code>library(tidyverse)
## &#x2500;&#x2500; Attaching packages &#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500; tidyverse 1.2.1 &#x2500;&#x2500;
## &#x2714; ggplot2 2.2.1.9000 &#x2714; purrr 0.2.4 ## &#x2714; tibble 1.4.2 &#x2714; dplyr 0.7.4 ## &#x2714; tidyr 0.8.0 &#x2714; stringr 1.3.1 ## &#x2714; readr 1.1.1 &#x2714; forcats 0.3.0
## &#x2500;&#x2500; Conflicts &#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500; tidyverse_conflicts() &#x2500;&#x2500;
## &#x2716; dplyr::filter() masks stats::filter()
## &#x2716; dplyr::lag() masks stats::lag()
## &#x2716; dplyr::vars() masks ggplot2::vars() iris2 &lt;- iris %&gt;% select(Sepal.Length, Sepal.Width, Petal.Length)
iris2 %&gt;% cor %&gt;% corrplot::corrplot()</code></pre>
<p>
<img src="http://curso-r.com/blog/2018-05-22-arvore-e-multicolinearidade_files/figure-html/unnamed-chunk-2-1.png" width="672">
</p>
<p>
O gráfico acima mostra que as variáveis explicativas não são fortemente
correlacionadas. Ajustando uma random fores, temos a seguinte ordem de
importância das variáveis:
</p>
<pre class="r"><code>library(randomForest)
iris2_rf &lt;- randomForest(Petal.Length ~ ., data = iris2)
varImpPlot(iris2_rf)</code></pre>
<p>
<img src="http://curso-r.com/blog/2018-05-22-arvore-e-multicolinearidade_files/figure-html/unnamed-chunk-3-1.png" width="672">
</p>
<p>
Sem surpresas. Agora vamos para o problema!
</p>

<p>
O gráfico abaixo mostra que quanto mais variáveis correlacionadas
tivermos, menor a importância de TODAS ELAS SIMULTANEAMENTE! É como se
as variáveis colineares repartissem a importância entre elas.
</p>
<pre class="r"><code># ajusta random forest para bases com 1 a 20 repeti&#xE7;&#xF5;es de `Sepal.Length`
rfs &lt;- map(iris3, ~ randomForest(Petal.Length ~ ., data = .x) %&gt;% importance) # extrai as import&#xE2;ncias das repeti&#xE7;&#xF5;es de `Sepal.Length`
importancia &lt;- map_dfr(rfs, ~{ .x %&gt;% as.data.frame() %&gt;% tibble::rownames_to_column() %&gt;% dplyr::filter(stringr::str_detect(rowname, &quot;^Sepal.Length&quot;))
}, .id = &quot;n_repeticoes&quot;) %&gt;% mutate(n_repeticoes = as.numeric(n_repeticoes)) # Gr&#xE1;fico do n&#xFA;mero de vari&#xE1;veis multicolineares vs import&#xE2;ncia
importancia %&gt;% ggplot(aes(x = n_repeticoes, y = IncNodePurity)) + geom_point() + geom_hline(yintercept = 40, size = 1, linetype = &quot;dashed&quot;, colour = &quot;red&quot;) + labs(x = &quot;Qtd de repeti&#xE7;&#xF5;es da coluna `Sepal.Length`&quot;, y = &quot;Import&#xE2;ncia&quot;, title = &quot;Gr&#xE1;fico da rela&#xE7;&#xE3;o entre o n&#xFA;mero de vari&#xE1;veis multicolineares vs import&#xE2;ncia&quot;)</code></pre>
<p>
<img src="http://curso-r.com/blog/2018-05-22-arvore-e-multicolinearidade_files/figure-html/unnamed-chunk-6-1.png" width="672">
</p>
<p>
Na prática, se estabelecessemos um corte no valor de importância pra
descartar variáveis (como ilustrado pela linha vermelha), teríamos um
problema em potencial: poderíamos estar jogando fora informação muito
importante.
</p>

<p>
Cuidado ao jogar tudo no caldeirão! Devemos sempre nos preocupar com
multicolinearidade, mesmo ajustando modelos baseados em árvores.
</p>
<p>
Abs!
</p>

