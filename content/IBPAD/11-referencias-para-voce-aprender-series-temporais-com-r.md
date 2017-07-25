+++
title = "11 referências para você aprender Séries Temporais com R"
date = "2017-07-25 12:28:51"
categories = ["IBPAD"]
original_url = "http://www.ibpad.com.br/blog/analise-de-dados/11-referencias-para-voce-aprender-series-temporais-com-r/"
+++

    <div class="wpb_text_column wpb_content_element " >
        <div class="wpb_wrapper">
            <p>Quando uma variável é medida e registrada sequencialmente em tempo durante ou em um intervalo fixo, chamado de intervalo amostral, os dados resultantes são chamados de <strong>Série Temporal</strong>. Observações coletadas em um intervalo amostral no passado recebem o nome de série temporal histórica e são usadas para analisar e entender o passado e para prever o futuro.</p>

<p>
Em outras palavras, série temporal é uma sequência de dados em ordem
cronológica.
</p>
<p>
Séries Temporais são um vasto assunto em estatística que possui seus
próprios subcampos de conhecimento: análise de séries temporais,
previsão, análise e tratamento de outliers, análise de changepoints,
séries temporais interrompidas, estudo de eventos, trading, etc. A
quantidade de material em livros, artigos científicos e textos em blogs
acompanha esse ritmo, o que pode tornar difícil saber por onde começar a
estudar.
</p>
<p>
Durante o desenvolvimento do meu TCC na Graduação(MULTIPLE AUTOMATIC
FORECAST SELECTION (MAFS): PROPOSTA DE SISTEMA DE AUTOMAÇÃO DE PREVISÃO
DE DEMANDA, que você pode ler
<a href="https://www.scribd.com/document/336226569/TCC-Sillas-MULTIPLE-AUTOMATIC-FORECAST-SELECTION-MAFS-PROPOSTA-DE-SISTEMA-DE-AUTOMACAO-DE-PREVISAO-DE-DEMANDA" target="_blank" rel="noopener">aqui</a>),
tive de ler diversas referências sobre Séries Temporais.
</p>
<p>
Como os livros de Séries Temporais acabam sendo meio repetitivos, trago
aqui os dois melhores na minha opinião, além de dicas de outros tipos de
materiais:
</p>
<h2>
Livros
</h2>
        </div>
    </div>

    <div class="wpb_text_column wpb_content_element " >
        <div class="wpb_wrapper">
            <h4>1 &#8211; HYNDMAN, R.J., ATHANASOPOULOS, G. (2017) Forecasting: principles and practice.</h4>

        </div>
    </div>

    <div  class="wpb_single_image wpb_content_element vc_align_center">
        
        <figure class="wpb_wrapper vc_figure">
            <div class="vc_single_image-wrapper   vc_box_border_grey"><img class="vc_single_image-img"  src="https://i1.wp.com/i.imgur.com/YCTRIZ3.png?resize=245%2C394&#038;ssl=1" data-recalc-dims="1" /></div>
        </figure>
    </div>

    <div class="wpb_text_column wpb_content_element " >
        <div class="wpb_wrapper">
            <p><em>Forecasting: principles and practices</em> é um excelente referência escrita por Rob Hyndman, uma das maiores autoridades sobre Séries Temporais do mundo. Felizmente, Hyndman publicou este livro de graça <a href="https://www.otexts.org/fpp/">na Internet</a>. Além de aprender conceitos teóricos fundamentais para o entendimento do assunto, o livro também é rico em exemplos de código R, permitindo ao leitor colocar em prática imediatamente o que aprende durante a leitura. A linguagem usada no livro é bem acessível mesmo para quem não é acadêmico.</p>

<p>
Para quem não sabe, Hyndman é autor do pacote <code>forecast</code>, o
principal pacote de previsão de séries temporais da linguagem R.
</p>
        </div>
    </div>

    <div class="wpb_text_column wpb_content_element " >
        <div class="wpb_wrapper">
            <h4>2 &#8211; COWPERTWAIT; METCALFE. Introductory Time Series with R (2009).</h4>

        </div>
    </div>

    <div  class="wpb_single_image wpb_content_element vc_align_left">
        
        <figure class="wpb_wrapper vc_figure">
            <div class="vc_single_image-wrapper   vc_box_border_grey"><img class="vc_single_image-img"  src="https://i0.wp.com/i.imgur.com/ICWCl1r.png?zoom=0.8999999761581421&amp;resize=300%2C300" /></div>
        </figure>
    </div>

    <div class="wpb_text_column wpb_content_element " >
        <div class="wpb_wrapper">
            <p>Apesar da palavra <em>introdução</em> constar no título do livro, <em>Introductory Time Series with R</em> é notoriamente mais teórico que o primeiro da lista, apesar de também trazer exemplos práticos em R para quem deseja colocar as mãos na massa. Ideal para quem deseja se aprofundar na formulação matemática dos conceitos apresentados, aboda ainda alguns assuntos não cobertos por <em>Forecasting: principles and practice</em>, como <a href="https://en.wikipedia.org/wiki/Long-range_dependence">processos de memória longa</a>, análise de espectro, correlação espúria e testes unitários. Todos os capítulos acompanham exemplos de aplicação das técnicas estudadas.</p>

        </div>
    </div>

<div class="vc_row wpb_row vc_row-fluid">
<div class="wpb_column vc_column_container vc_col-sm-12">
<div class="vc_column-inner ">
<div class="wpb_wrapper">
    <div class="wpb_text_column wpb_content_element " >
        <div class="wpb_wrapper">
            <blockquote><p>

<span style="color: #ff6600;">Que aprender mais? Conheça nosso curso de
<strong>Séries Temporais</strong> em
<a href="http://www.ibpad.com.br/produto/series-temporais-df/" target="_blank" rel="noopener">Brasília
</a>e
<a href="http://www.ibpad.com.br/produto/series-temporais-sp/" target="_blank" rel="noopener">São
Paulo</a></span>
</p>
</blockquote>
        </div>
    </div>

    <div class="wpb_text_column wpb_content_element " >
        <div class="wpb_wrapper">
            <h2>Papers</h2>

<p>
Artigos acadêmicos sobre séries temporais existem em abundância. Para
achar uma boa referência que seja útil aos interesses, vale pesquisar no
<a href="http://scholar.google.com/" class="broken_link">Google
Scholar</a> temas específicos. Por exemplo:
</p>
<p>
 
</p>
<p>
<strong>3. Séries temporais intermitentes</strong>: KOENIG, A.
<strong>Previsão de demanda em séries temporais intermitentes mediante a
utilização do método de Croston.</strong> 2014. Dissertação (Mestrado em
Engenharia de Produção) – Universidade Federal de Santa Catarina,
Florianópolis, 2014;
</p>
<p>
<strong>4. Métodos qualitativos para previsão</strong>: LEE, C. K.;
SONG, H. J.; MJELDE, J. W. (2008). <strong>The forecasting of
International Expo tourism using quantitative and qualitative
techniques</strong>. Tourism Management, v.29, p.1084-1098, 2008;5
</p>
<p>
<strong>5. Aplicação de redes neurais em séries temporais</strong>:
BRANCO, S. T.; SAMPAIO, R. J. B. <strong>Aplicação de redes neurais
artificiais em modelos de previsão da demanda para equipamentos de
infraestrutura de telecomunicações.</strong> In: XXVII ENCONTRO NACIONAL
DE ENGENHARIA DE PRODUÇÃO. Rio de Janeiro, 2008.
</p>
<h2>
Conteúdo online
</h2>
<p>
1.  Texto no blog do
    <a href="http://blog.revolutionanalytics.com/2013/06/learning-time-series-with-r.html">Revolution
    Analytics</a> com mais dicas de livros sobre séries temporais;
    </p>
    <p>
    1.  Um breve porém completo tutorial de modelagem de séries
        temporais no
        <a href="https://www.analyticsvidhya.com/blog/2015/12/complete-tutorial-time-series-modeling/">Analytics
        Vidhya</a>;
        </p>
        <p>
        1.  <a href="http://www.thertrader.com/">The R Trader</a>, um
            blog sobre R aplicado ao mercado financeiro;
            </p>
            <p>
            1.   <a href="https://robjhyndman.com/hyndsight/">Hyndsight</a>,
                o blog do Rob Hyndman;
                </p>
                <p>
                1.  <a href="http://ellisp.github.io/">Peter’s stats
                    stuff</a>, o blog do autor do pacote
                    <code>forecastHybrid</code>;
                    </p>
                    <p>
                    <strong>11. Google</strong> em geral: Uma boa dica
                    para achar conteúdo bom relacionado a um tema bem
                    específico de séries temporais é usar truques do
                    Google de busca avançada, como
                    <code>filetype:pdf</code> ou <code>site:edu</code>.
                    Por exemplo, se você deseja aprender mais sobre
                    <a href="https://en.wikipedia.org/wiki/Interrupted_time_series">séries
                    temporais interrompidas</a>, você pode pesquisar por
                    <code>interrupted time series site:edu</code>.
                    </p>

        </div>
        </div>
        </div>
        </div>
        </div>
        </div>
        <p>
        O post
        <a rel="nofollow" href="http://www.ibpad.com.br/blog/analise-de-dados/11-referencias-para-voce-aprender-series-temporais-com-r/">11
        referências para você aprender Séries Temporais com R</a>
        apareceu primeiro em
        <a rel="nofollow" href="http://www.ibpad.com.br">IBPAD</a>.
        </p>

