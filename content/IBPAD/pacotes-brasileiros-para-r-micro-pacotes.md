+++
title = "Pacotes brasileiros para R: micro-pacotes"
date = "2017-07-31 23:02:54"
categories = ["IBPAD"]
original_url = "http://www.ibpad.com.br/blog/pacotes-brasileiros-para-r-micro-pacotes/"
+++

    <div class="wpb_text_column wpb_content_element " >
        <div class="wpb_wrapper">
            <div>

<p>
Tem pacotes para R que têm muitas funções, e têm outros que possuem só
uma função principal. Neste post, olhamos os pacotes brasileiros para R
que caem nesta segunda categoria — ‘micro-pacotes’.
</p>
<h5>
<strong>RSLP</strong>
</h5>
<p>
O pacote
<a href="https://github.com/dfalbe" class="broken_link">rlsp</a>, por
Daniel Falbel, vai fazer a vida de quem trabalha com mineração de textos
em português bem mais fácil. O pacote usa ‘stemming’ para a língua
portuguesa. Em outras palavras, ele reduz palavras às suas raízes,
facilitando a análise de textos. Um exemplo:
</p>

<p>
 
</p>
<pre class="crayon-plain-tag">install.packages(&quot;rslp&quot;)

palavras</pre>
<p>
 
</p>
<p>
Um outro pacote do Daniel,
<a href="https://github.com/dfalbel/ptstem">ptstem</a> traz mais
ferramentas para a análise de texto, para quem tem interesse em nesta
área.
</p>
<h5>
<strong>cepR</strong>
</h5>
<p>
O pacote cepR acessa dados postais do Brasil tais como nomes de
bairros, cidades, estados, logradouros, CEPs e outras informações de
interesse como altitude, longitude e latitude. O usuário precisa de um
<em>token</em> do website
<a href="http://cepaberto.com/users/register">CEPaberto</a>, e daí
pode procurar ou por CEPs ou por detalhes de bairros com o CEP. Por
exemplo, a rua João Moura onde moro em São Paulo:
</p>

<p>
</p>
<pre class="crayon-plain-tag">install.packages(&quot;cepR&quot;)

cepR::busca_cep(cep = &quot;005412002&quot;, token = XXXXXXXXX)


    ## # A tibble: 1 x 10
    ##   estado    cidade    bairro      cep
    ##                  
    ## 1     SP S&atilde;o Paulo Pinheiros 05412002
    ##
    ## # ... with 6 more variables: logradouro , latitude ,
    ## #   longitude , altitude , ddd , cod_IBGE</pre>
<p>
 
</p>
<h5>
<strong>GetTDData</strong>
</h5>
<p>
O pacote <a href="https://github.com/cran/GetTDData">GetTDData</a> baixa
dados do Tesouro do governo brasileiro, do website
<a href="http://www.tesouro.gov.br/tesouro-direto-balanco-e-estatisticas">Tesouro
Direto</a>. O pacote arruma estes arquivos para você usar no R. Para
quem está interessado em dados financeiras, é bem mais fácil do que
baixar tudo e tentar importar um por um para R! O autor, Marcelo Perlin,
<a href="http://www.ibpad.com.br/blog/pacotes-brasileiros-do-r-parte-3-analisando-financas-no-r/">tem
outros pacotes</a> para R que tratam com dados financeiros também.
</p>
<h5>
<strong>riscoBrasil</strong>
</h5>
<p>
Falando de dados financeiros, o pacote
<a href="https://github.com/RobertMyles/riscoBrasil">riscoBrasil</a> baixa
dados do índice do J.P. Morgan sobre o ‘risco Brasil’. O J.P. Morgan
mantenha um <em>Emerging Markets Bond Index</em> com índices de risco
para vários países, e o IBGE disponibiliza estes dados no caso do
Brasil. O pacote tem uma função, <code>riscoBrasil()</code>, fazendo ele
um ‘micro-pacote’ mesmo! Mais detalhes podem ser vistos na página do
pacote, e pode ser instalado com
<code>install.packages("riscoBrasil")</code>.
</p>
<h5>
<strong>sabesp</strong>
</h5>
<p>
O pacote <a href="https://github.com/jtrecenti/sabesp">sabesp</a> do
Júlio Trecenti, baixa e arruma dados da SABESP (a Companhia de
Saneamento Básico do Estado de São Paulo). Júlio mostra como, com poucas
linhas de código, pode produzir um gráfico bem informativo sobre o
estado dos reservatórios de água em São Paulo:
</p>
<pre class="crayon-plain-tag"># install.packages(&quot;devtools&quot;)  ## se n&atilde;o tem
# install.packages(&quot;lubridate&quot;) ## idem


devtools::install_github(&quot;jtrecenti/sabesp&quot;)
library(dplyr)
library(sabesp)
library(ggplot2)

datas %
  filter(titulo == 'volume armazenado') %&amp;gt;%
  ggplot(aes(x = data, y = info, colour = lugar)) +
  geom_line() +
  theme_bw() +
  geom_hline(yintercept = 0, colour = 'gray') +
  scale_x_date(date_labels = '%b %Y', date_breaks = '3 months',
               limits = as.Date(c('2012-12-01', '2015-12-01'))) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))</pre>
<p>
</p>
        </div>
    </div>

    <div  class="wpb_single_image wpb_content_element vc_align_left">
        
        <figure class="wpb_wrapper vc_figure">
            <div class="vc_single_image-wrapper   vc_box_border_grey"><img width="1039" height="561" src="https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/07/sabesp-1.png?fit=1039%2C561" class="vc_single_image-img attachment-full" alt="" srcset="https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/07/sabesp-1.png?w=1039 1039w, https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/07/sabesp-1.png?resize=260%2C140 260w, https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/07/sabesp-1.png?resize=768%2C415 768w, https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/07/sabesp-1.png?resize=1024%2C553 1024w, https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/07/sabesp-1.png?resize=100%2C54 100w" sizes="(max-width: 900px) 100vw, 900px" data-attachment-id="10133" data-permalink="http://www.ibpad.com.br/blog/pacotes-brasileiros-para-r-micro-pacotes/attachment/sabesp-2/" data-orig-file="https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/07/sabesp-1.png?fit=1039%2C561" data-orig-size="1039,561" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;}" data-image-title="sabesp" data-image-description="" data-medium-file="https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/07/sabesp-1.png?fit=260%2C140" data-large-file="https://i2.wp.com/www.ibpad.com.br/wp-content/uploads/2017/07/sabesp-1.png?fit=900%2C486" /></div>
        </figure>
    </div>

</div>
<p>
O post
<a rel="nofollow" href="http://www.ibpad.com.br/blog/pacotes-brasileiros-para-r-micro-pacotes/">Pacotes
brasileiros para R: micro-pacotes</a> apareceu primeiro em
<a rel="nofollow" href="http://www.ibpad.com.br">IBPAD</a>.
</p>

