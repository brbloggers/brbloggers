+++
title = "As cinco melhores extensões ao ggplot2"
date = "2017-08-01 14:34:49"
categories = ["IBPAD"]
original_url = "http://www.ibpad.com.br/blog/cinco-melhores-extensoes-ao-ggplot2/"
+++

    <div class="wpb_text_column wpb_content_element " >
        <div class="wpb_wrapper">
            <p>É bem conhecido que o ggplot2 é um dos melhores pacotes do R, com versões em outras linguagens como Python e Matlab. O que é menos conhecido é que o ggplot2 criou um mundo de pacotes adicionais que aumentam as capacidades do pacote original para outras situações. Estes extensões variam das boas até as ruins. Neste post olhamos às cinco melhores extensões ao ggplot2.</p>

        </div>
    </div>

<h2 style="font-size: 16px;color: #d68000;text-align: left;font-family:Open Sans;font-weight:600;font-style:normal" class="vc_custom_heading">
1 - ggiraph
</h2>
    <div class="wpb_text_column wpb_content_element " >
        <div class="wpb_wrapper">
            <p>O <a href="https://github.com/davidgohel/ggiraph">[ggiraph]</a> é uma extensão ao ggplot que torna os seus gráficos interativos. Vem com *geoms* adicionais para integrar elementos de javascript (como *tooltips*, *onclick* etc.) e é simples usar. Basta criar um gráfico normal com ggplot2, usando os novos geoms se quiser (como <code>geom_point_interactive</code>, por exemplo), salva o objeto no R e usar o método *print* do ggiraph. Voilà! Um gráfico interativo!</p>

<p>
Relacionado:<a href="https://github.com/dgrtwo/gganimate"> \[gganimate\]</a>
</p>
        </div>
    </div>

<h2 style="font-size: 16px;color: #d68000;text-align: left;font-family:Open Sans;font-weight:600;font-style:normal" class="vc_custom_heading">
2 - ggthemes
</h2>

    <div  class="wpb_single_image wpb_content_element vc_align_center">
        
        <figure class="wpb_wrapper vc_figure">
            <a data-rel="prettyPhoto[rel-10077-936213219]" href="https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/07/ggthemes.png?fit=378%2C270" target="_self" class="vc_single_image-wrapper   vc_box_border_grey prettyphoto"><img width="378" height="270" src="https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/07/ggthemes.png?fit=378%2C270" class="vc_single_image-img attachment-full" alt="" srcset="https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/07/ggthemes.png?w=378 378w, https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/07/ggthemes.png?resize=260%2C186 260w, https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/07/ggthemes.png?resize=100%2C71 100w" sizes="(max-width: 378px) 100vw, 378px" data-attachment-id="10082" data-permalink="http://www.ibpad.com.br/blog/cinco-melhores-extensoes-ao-ggplot2/attachment/ggthemes/" data-orig-file="https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/07/ggthemes.png?fit=378%2C270" data-orig-size="378,270" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;}" data-image-title="ggthemes" data-image-description="" data-medium-file="https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/07/ggthemes.png?fit=260%2C186" data-large-file="https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/07/ggthemes.png?fit=378%2C270" /></a>
        </figure>
    </div>

    <div class="wpb_text_column wpb_content_element " >
        <div class="wpb_wrapper">
            <p>Uma das primeiras extensões criadas foi o <a href="https://github.com/jrnold/ggthemes">[ggthemes]</a>. Com temas para reproduzir o estilo da revista Economist, ou o uso de cores para daltônicos, o pacote tem muitas opções para acostumizar os seus gráficos.</p>

<p>
Relacionado:
<strong><a href="https://github.com/ricardo-bion/ggtech">\[ggtech\]</a></strong>
</p>
        </div>
    </div>

<h2 style="font-size: 16px;color: #d68000;text-align: left;font-family:Open Sans;font-weight:600;font-style:normal" class="vc_custom_heading">
3 - ggally
</h2>

    <div class="wpb_text_column wpb_content_element " >
        <div class="wpb_wrapper">
            <p>A proposta de ggally é para aumentar a capacidade de ggplot fazer imegens relacionadas aos resultados de modelagem. Tem funções que fazem plots dos coeficientes de uma regressão, por exemplo, ou funções que criam &#8216;matrizes de gráficos&#8217; para comparar variáveis.</p>

<p>
Relacionado:
<a href="https://github.com/thomasp85/ggforc" class="broken_link">\[ggforce\]</a>
</p>
        </div>
    </div>

    <div  class="wpb_single_image wpb_content_element vc_align_left">
        
        <figure class="wpb_wrapper vc_figure">
            <div class="vc_single_image-wrapper   vc_box_border_grey"><img width="900" height="720" src="https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/07/ggally.png?fit=900%2C720" class="vc_single_image-img attachment-large" alt="" srcset="https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/07/ggally.png?w=1920 1920w, https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/07/ggally.png?resize=260%2C208 260w, https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/07/ggally.png?resize=768%2C614 768w, https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/07/ggally.png?resize=1024%2C819 1024w, https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/07/ggally.png?resize=100%2C80 100w, https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/07/ggally.png?w=1800 1800w" sizes="(max-width: 900px) 100vw, 900px" data-attachment-id="10081" data-permalink="http://www.ibpad.com.br/ggally/" data-orig-file="https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/07/ggally.png?fit=1920%2C1536" data-orig-size="1920,1536" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;}" data-image-title="ggally" data-image-description="" data-medium-file="https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/07/ggally.png?fit=260%2C208" data-large-file="https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/07/ggally.png?fit=900%2C720" /></div>
        </figure>
    </div>

<h2 style="font-size: 16px;color: #d68000;text-align: left;font-family:Open Sans;font-weight:600;font-style:normal" class="vc_custom_heading">
4 - ggalt
</h2>

    <div  class="wpb_single_image wpb_content_element vc_align_left">
        
        <figure class="wpb_wrapper vc_figure">
            <div class="vc_single_image-wrapper   vc_box_border_grey"><img width="900" height="642" src="https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/07/lollipop.png?fit=900%2C642" class="vc_single_image-img attachment-large" alt="" srcset="https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/07/lollipop.png?w=1344 1344w, https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/07/lollipop.png?resize=260%2C186 260w, https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/07/lollipop.png?resize=768%2C549 768w, https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/07/lollipop.png?resize=1024%2C731 1024w, https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/07/lollipop.png?resize=100%2C71 100w" sizes="(max-width: 900px) 100vw, 900px" data-attachment-id="10080" data-permalink="http://www.ibpad.com.br/lollipop/" data-orig-file="https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/07/lollipop.png?fit=1344%2C960" data-orig-size="1344,960" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;}" data-image-title="lollipop" data-image-description="" data-medium-file="https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/07/lollipop.png?fit=260%2C186" data-large-file="https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/07/lollipop.png?fit=900%2C642" /></div>
        </figure>
    </div>

    <div class="wpb_text_column wpb_content_element " >
        <div class="wpb_wrapper">
            <p><a href="https://github.com/hrbrmstr/ggalt">[ggalt]</a> é uma extensão ao ggplot2 que vem com visuais &#8216;opinativas&#8217; segundo o autor Bob Rudis. O pacote tem funções para criar uma variedade de gráficos que não são muito faceis criar no ggplot2. Um deles é o *lollipop chart*.</p>

<p>
Relacionado:<a href="https://github.com/hrbrmstr/hrbrthemes">
\[hrbrthemes\]</a>
</p>
        </div>
    </div>

<h2 style="font-size: 16px;color: #d68000;text-align: left;font-family:Open Sans;font-weight:600;font-style:normal" class="vc_custom_heading">
5 - ggedit
</h2>
    <div class="wpb_text_column wpb_content_element " >
        <div class="wpb_wrapper">
            <p><a href="https://github.com/metrumresearchgroup/ggedit">[ggedit]</a> é diferente do que os outros em cima pelo fato que faz possível editar os seus gráficos interativamente. Para quem está aprendendo como usar o gpplot2, pode parecer que existe literalmente milhares de opções. ggedit ajuda com isso, dado que você pde ver os resultados das suas mudanças na hora! Tem um livro (em inglês) de graça que explica como usar o pacote, disponível aqui: [<a href="https://metrumresearchgroup.github.io/ggedit/">https://metrumresearchgroup.github.io/ggedit/</a>](<a href="https://metrumresearchgroup.github.io/ggedit/">https://metrumresearchgroup.github.io/ggedit/</a>)</p>

        </div>
    </div>

<p>
O post
<a rel="nofollow" href="http://www.ibpad.com.br/blog/cinco-melhores-extensoes-ao-ggplot2/">As
cinco melhores extensões ao ggplot2</a> apareceu primeiro em
<a rel="nofollow" href="http://www.ibpad.com.br">IBPAD</a>.
</p>

