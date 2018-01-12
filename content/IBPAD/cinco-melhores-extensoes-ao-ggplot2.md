+++
title = "As cinco melhores extensões ao ggplot2"
date = "2017-08-01 14:34:49"
categories = ["IBPAD"]
original_url = "https://www.ibpad.com.br/blog/cinco-melhores-extensoes-ao-ggplot2/"
+++

<p>
É bem conhecido que o ggplot2 é um dos melhores pacotes do R, com
versões em outras linguagens como Python e Matlab. O que é menos
conhecido é que o ggplot2 criou um mundo de pacotes adicionais que
aumentam as capacidades do pacote original para outras situações. Estes
extensões variam das boas até as ruins. Neste post olhamos às cinco
melhores extensões ao ggplot2.
</p>

<h2 style="font-size: 16px;color: #d68000;text-align: left;font-family:Open Sans;font-weight:600;font-style:normal" class="vc_custom_heading">
1 - ggiraph
</h2>
<p>
O <a href="https://github.com/davidgohel/ggiraph">\[ggiraph\]</a> é uma
extensão ao ggplot que torna os seus gráficos interativos. Vem
com *geoms* adicionais para integrar elementos de javascript
(como *tooltips*, *onclick* etc.) e é simples usar. Basta criar um
gráfico normal com ggplot2, usando os novos geoms se quiser
(como <code>geom\_point\_interactive</code>, por exemplo), salva o
objeto no R e usar o método *print* do ggiraph. Voilà! Um gráfico
interativo!
</p>
<p>
Relacionado:<a href="https://github.com/dgrtwo/gganimate"> \[gganimate\]</a>
</p>

<h2 style="font-size: 16px;color: #d68000;text-align: left;font-family:Open Sans;font-weight:600;font-style:normal" class="vc_custom_heading">
2 - ggthemes
</h2>

<figure class="wpb_wrapper vc_figure">
<a data-rel="prettyPhoto[rel-10077-928483161]" href="https://www.ibpad.com.br/wp-content/uploads/2017/07/ggthemes.png" target="_self" class="vc_single_image-wrapper   vc_box_border_grey prettyphoto"><img width="378" height="270" src="https://www.ibpad.com.br/wp-content/uploads/2017/07/ggthemes.png" class="vc_single_image-img attachment-full" alt="" srcset="https://www.ibpad.com.br/wp-content/uploads/2017/07/ggthemes.png 378w, https://www.ibpad.com.br/wp-content/uploads/2017/07/ggthemes-260x186.png 260w, https://www.ibpad.com.br/wp-content/uploads/2017/07/ggthemes-100x71.png 100w" sizes="(max-width: 378px) 100vw, 378px"></a>
</figure>

<p>
Uma das primeiras extensões criadas foi o
<a href="https://github.com/jrnold/ggthemes">\[ggthemes\]</a>. Com temas
para reproduzir o estilo da revista Economist, ou o uso de cores para
daltônicos, o pacote tem muitas opções para acostumizar os seus
gráficos.
</p>
<p>
Relacionado:
<strong><a href="https://github.com/ricardo-bion/ggtech">\[ggtech\]</a></strong>
</p>

<h2 style="font-size: 16px;color: #d68000;text-align: left;font-family:Open Sans;font-weight:600;font-style:normal" class="vc_custom_heading">
3 - ggally
</h2>

<p>
A proposta de ggally é para aumentar a capacidade de ggplot fazer
imegens relacionadas aos resultados de modelagem. Tem funções que fazem
plots dos coeficientes de uma regressão, por exemplo, ou funções que
criam ‘matrizes de gráficos’ para comparar variáveis.
</p>
<p>
Relacionado:
<a href="https://github.com/thomasp85/ggforc">\[ggforce\]</a>
</p>

<figure class="wpb_wrapper vc_figure">
<img width="900" height="720" src="https://www.ibpad.com.br/wp-content/uploads/2017/07/ggally-1024x819.png" class="vc_single_image-img attachment-large" alt="" srcset="https://www.ibpad.com.br/wp-content/uploads/2017/07/ggally-1024x819.png 1024w, https://www.ibpad.com.br/wp-content/uploads/2017/07/ggally-260x208.png 260w, https://www.ibpad.com.br/wp-content/uploads/2017/07/ggally-768x614.png 768w, https://www.ibpad.com.br/wp-content/uploads/2017/07/ggally-100x80.png 100w" sizes="(max-width: 900px) 100vw, 900px">

</figure>

<h2 style="font-size: 16px;color: #d68000;text-align: left;font-family:Open Sans;font-weight:600;font-style:normal" class="vc_custom_heading">
4 - ggalt
</h2>

<figure class="wpb_wrapper vc_figure">
<img width="900" height="642" src="https://www.ibpad.com.br/wp-content/uploads/2017/07/lollipop-1024x731.png" class="vc_single_image-img attachment-large" alt="" srcset="https://www.ibpad.com.br/wp-content/uploads/2017/07/lollipop-1024x731.png 1024w, https://www.ibpad.com.br/wp-content/uploads/2017/07/lollipop-260x186.png 260w, https://www.ibpad.com.br/wp-content/uploads/2017/07/lollipop-768x549.png 768w, https://www.ibpad.com.br/wp-content/uploads/2017/07/lollipop-100x71.png 100w, https://www.ibpad.com.br/wp-content/uploads/2017/07/lollipop.png 1344w" sizes="(max-width: 900px) 100vw, 900px">

</figure>

<p>
<a href="https://github.com/hrbrmstr/ggalt">\[ggalt\]</a> é uma extensão
ao ggplot2 que vem com visuais ‘opinativas’ segundo o autor Bob Rudis. O
pacote tem funções para criar uma variedade de gráficos que não são
muito faceis criar no ggplot2. Um deles é o *lollipop chart*.
</p>
<p>
Relacionado:<a href="https://github.com/hrbrmstr/hrbrthemes">
\[hrbrthemes\]</a>
</p>

<h2 style="font-size: 16px;color: #d68000;text-align: left;font-family:Open Sans;font-weight:600;font-style:normal" class="vc_custom_heading">
5 - ggedit
</h2>
<p>
<a href="https://github.com/metrumresearchgroup/ggedit">\[ggedit\]</a> é
diferente do que os outros em cima pelo fato que faz possível editar os
seus gráficos interativamente. Para quem está aprendendo como usar o
gpplot2, pode parecer que existe literalmente milhares de opções. ggedit
ajuda com isso, dado que você pde ver os resultados das suas mudanças na
hora! Tem um livro (em inglês) de graça que explica como usar o pacote,
disponível aqui:
\[<a href="https://metrumresearchgroup.github.io/ggedit/">https://metrumresearchgroup.github.io/ggedit/</a>\](<a href="https://metrumresearchgroup.github.io/ggedit/">https://metrumresearchgroup.github.io/ggedit/</a>)
</p>

