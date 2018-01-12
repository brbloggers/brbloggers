+++
title = "Análise de Séries Temporais Usando o BETS"
date = "2017-11-30"
categories = ["NMEC"]
original_url = "http://pedrocostaferreira.github.io/blog/2017/11/30/analise-de-series-bets"
+++

<div class="notebody">
<p>
Vamos modelar a série de produção de bens intermediários (PBI) com o
BETS usando a metodologia Box & Jenkins. No final, seremos capazes de
usar o modelo para fazer previsões.
</p>
<h3 id="metodologia-box--jenkins">
Metodologia Box & Jenkins
</h3>
<p>
O método de Box & Jenkins permite que os valores futuros da série em
estudo sejam previstos somente com base nos valores passados e presentes
da mesma série, isto é, as previsões são feitas a partir de modelos
univariados.
</p>
<p>
Estes modelos são chamados SARIMA, uma sigla para o termo em inglês
<em>Seasonal Auto-Regressive Integrated Moving Average</em>, e têm a
forma:
</p>
<p>
<img src="http://pedrocostaferreira.github.io/images/eq.png">
</p>
<p>
onde
</p>
<ul>
<li>
<em>Z</em><sub><em>t</em></sub> é a série em estudo
</li>
<li>
<em>a</em><sub><em>t</em></sub> é um ruído branco
</li>
<li>
∇<sup><em>d</em></sup> = (1 − <em>B</em>)<sup><em>d</em></sup> é o
operador de diferenças e <em>d</em> o número de raizes unitárias
</li>
<li>
∇<sup><em>D</em></sup> = (1 − <em>B</em><sup><em>s</em></sup>)<sup><em>D</em></sup>
é o operador de diferenças na frequência sazonal <em>s</em> e <em>D</em>
o número de raízes unitárias sazonais
</li>
<li>
<em>ϕ</em><sub><em>p</em></sub>(<em>B</em>) é o polinômio
autorregressivo
</li>
<li>
<em>Φ</em><sub><em>P</em></sub>(<em>B</em>) é o polinômio
autorregressivo sazonal
</li>
<li>
<em>θ</em><sub><em>q</em></sub>(<em>B</em>) é o polinômio de médias
móveis
</li>
<li>
<em>Θ</em><sub><em>Q</em></sub>(<em>B</em>) é o polinômio de médias
móveis sazonal
</li>
</ul>
<p>
Em sua concepção original, que será adotada aqui, a metodologia de Box &
Jenkins se divide em três estágios iterativos:
</p>
<ol>
<li>
Identificação e seleção dos modelos: verificação da estacionariedade e
da sazonalidade, com as devidas correções para os casos não
estacionários e sazonais, e determinação das ordens dos polinômios
descritos acima, fazendo uso das funções de autocorrelação (FAC) e
autocorrelação parcial(FACP).
</li>
<li>
Estimação dos parâmetros do modelo, usando máxima verossimilhança ou
regressão dinâmica.
</li>
<li>
Diagnóstico da conformidade do modelo, através de testes estatísticos.
</li>
</ol>
<p>
Se o modelo não for aprovado na fase (iii), volta-se ao passo (i). Caso
contrário, o modelo pode ser utilizado para fazer previsões. Na próxima
seção, conforme o exemplo for evoluindo, cada um desses estágios será
observado de perto e mais será dito sobre a metodologia.
</p>
<h3 id="modelagem">
Modelagem
</h3>
<h4 id="preliminares">
Preliminares
</h4>
<p>
O primeiro passo é encontrar a série PBI na base de dados do BETS. Isso
pode ser feito com a função
<code class="highlighter-rouge">BETS.search</code>. O comando e sua
saída são mostrados abaixo.
</p>
<pre class="highlight"><code>&gt; # Busca em portugu&#xEA;s pela s&#xE9;rie de produ&#xE7;&#xE3;o de bens intermedi&#xE1;rios
&gt; results = BETS.search(description = &quot;&apos;bens intermediarios&apos;&quot;, lang = &quot;pt&quot;, view = F)
&gt; results ## code
## 1 1334
## 2 11068
## 3 21864
## 4 25302
## 5 25328
## description
## 1 Indicadores da produ&#xE7;&#xE3;o (1991=100) - Por categoria de uso - Bens intermedi&#xE1;rios
## 2 Indicadores da produ&#xE7;&#xE3;o (2002=100) - Por categoria de uso - Bens intermedi&#xE1;rios
## 3 Indicadores da produ&#xE7;&#xE3;o (2012=100) - Bens intermedi&#xE1;rios
## 4 Importa&#xE7;&#xF5;es - Bens intermedi&#xE1;rios (CGCE)
## 5 Importa&#xE7;&#xF5;es (kg) - Bens intermedi&#xE1;rios (CGCE)
## unit periodicity start source
## 1 &#xCD;ndice M 31/01/1975 IBGE
## 2 &#xCD;ndice M 31/01/1991 IBGE
## 3 &#xCD;ndice M 01/01/2002 IBGE
## 4 US$ M 01/01/1997 MDIC/Secex
## 5 kg M 01/01/1997 MDIC/Secex
</code></pre>

<p>
Agora, carregamos a série através da função
<code class="highlighter-rouge">BETS.get</code> e guardamos alguns
valores para, posteriormente, comparar com as previsões do modelo que
será estabelecido. Também criaremos um gráfico (figura ), pois ele ajuda
a formular hipóteses sobre o comportamento do processo estocástico
subjacente.
</p>
<pre class="highlight"><code>&gt; # Obten&#xE7;&#xE3;o da s&#xE9;rie de c&#xF3;digo 21864 (Produ&#xE7;&#xE3;o de Bens Intermedi&#xE1;rios, IBGE)
&gt; data &lt;- BETS.get(21864)
&gt; &gt; # Guardar &#xFA;ltimos valores para comparar com as previs&#xF5;es
&gt; data_test &lt;- window(data, start = c(2015,11), end = c(2016,4), frequency = 12)
&gt; data &lt;- window(data, start = c(2002,1), end = c(2015,10), frequency = 12) &gt; # Gr&#xE1;fico da s&#xE9;rie
&gt; plot(data, main = &quot;&quot;, col = &quot;royalblue&quot;, ylab = &quot;PBI (N&#xFA;mero &#xCD;ndice)&quot;)
&gt; abline(v = seq(2002,2016,1), col = &quot;gray60&quot;, lty = 3)
</code></pre>

<p>
<img src="http://pedrocostaferreira.github.io/images/chart-1.png" alt="Gr&#xE1;fico da s&#xE9;rie de produ&#xE7;&#xE3;o de bens intermedi&#xE1;rios no Brasil.">
</p>
<p class="caption">
Gráfico da série de produção de bens intermediários no Brasil.
</p>
<p>
Quatro características ficam evidentes. Primeiramente, trata-se de uma
série homocedástica e sazonal na frequência mensal. Este último fato é
corroborado pelo gráfico mensal da série (figura ), que mostra o nível
de produção por mês (a média é a linha tracejada).
</p>
<pre class="highlight"><code>&gt; # Gr&#xE1;fico mensal da s&#xE9;rie
&gt; monthplot(data, labels = month.abb, lty.base = 2, col = &quot;red&quot;, + ylab = &quot;PBI (N&#xFA;mero &#xCD;ndice)&quot;, xlab = &quot;Month&quot;)
</code></pre>

<p>
<img src="http://pedrocostaferreira.github.io/images/month-1.png" alt="Gr&#xE1;fico mensal da s&#xE9;rie em estudo.">
</p>
<p class="caption">
Gráfico mensal da série em estudo.
</p>
<p>
Um terceiro aspecto marcante da série é a quebra estrutural em novembro
de 2008, quando ocorreu a crise financeira internacional e a confiança
dos investidores despencou. A quebra impactou diretamente na quarta
característica importante da série: a tendência. Incialmente, a
tendência era claramente crescente, mas não explosiva. A partir de
novembro de 2008, porém, parece que o nível da série se manteve
constante ou até mesmo descresceu. Em um primeiro momento, a quebra
estrutural será desconsiderada na estimação dos modelos, mas logo o
benefício de levá-la em conta explicitamente ficará claro.
</p>
<p>
A seguir, criaremos um modelo para a série escolhida de acordo com os
passos definidos anteriormente.
</p>
<h3 id="1-identifica&#xE7;&#xE3;o">
1.  Identificação
    </h3>
    <h4 id="11-testes-para-estacionariedade">
    1.1. Testes para Estacionariedade
    </h4>
    <p>
    Esta subseção trata de um passo crucial na abordagem de Box &
    Jenkins: a determinação da existência e da quantidade total de
    raízes unitárias no polinômio autorregressivo não-sazonal e sazonal
    do modelo. De posse desses resultados, obtemos uma série
    estacionária através da diferenciação da série original. Assim,
    poderemos identificar a ordem dos parâmetros através da FAC e FACP,
    pois isso deve feito através de séries estacionárias de segunda
    ordem.
    </p>
    <p>
    A função <code class="highlighter-rouge">BETS.ur\_test</code>
    executa o teste <em>Augmented Dickey Fuller</em> (ADF). Ela foi
    construída em cima da função
    <code class="highlighter-rouge">ur.df</code> do pacote
    <code class="highlighter-rouge">urca</code>, que é instalado
    juntamente com o BETS. A vantagem da
    <code class="highlighter-rouge">BETS.ur\_test</code> é a saída,
    desenhada para que o usuário visualize rapidamente o resultado do
    teste e tenha todas as informações de que realmente necessita.
    Trata-se de um objeto com dois campos: uma tabela mostrando as
    estatísticas de teste, os valores críticos e se a hipótese nula é
    rejeitada ou não, e um vetor contendo os resíduos da equação do
    teste. Esta equação é mostrada abaixo.
    </p>
    <p>
    As estatísticas de teste da tabela do objeto de saída se referem aos
    coeficientes <em>ϕ</em> (média ou <em>drift</em>),
    <em>τ</em><sub>1</sub> (tendência determinística) e
    <em>τ</em><sub>2</sub> (raiz unitária). A inclusão da média e da
    tendência determinística é opcional. Para controlar os parâmetros do
    teste, a <code class="highlighter-rouge">BETS.ur\_test</code> aceita
    os mesmos parâmetros da
    <code class="highlighter-rouge">ur.df</code>, além do nível de
    significância desejado.
    </p>
    <pre class="highlight"><code>&gt; df = BETS.ur_test(y = diff(data), type = &quot;none&quot;, lags = 11, + selectlags = &quot;BIC&quot;, level = &quot;1pct&quot;)
    &gt; &gt; # Exibir resultado dos testes
    &gt; df$results ## statistic crit.val rej.H0
    ## tau1 -3.041155 -2.58 yes
    </code></pre>

    <p>
    Portanto, para a série em nível, observa-se que não se pode rejeitar
    a hipotése nula de existência de uma raiz unitária ao nível de
    confiança de 95%, pois a estatística de teste é maior do que o valor
    crítico. Agora, iremos aplicar a função
    <code class="highlighter-rouge">diff</code> à série repetidas vezes
    e verificar se a série diferenciada possui uma raiz unitária.
    </p>
    <div class="highlighter-rouge">
    <div class="highlight">
    <pre class="highlight">
    <code>&gt; ns\_roots = 0 &gt; d\_ts = diff(data) &gt; &gt; \# Loop
    de testes de Dickey-Fuller. &gt; \# A execução é interrompida quando
    não for possível rejeitar a hipótese nula &gt;
    while(df$results\[1,&quot;statistic&quot;\]&gt; df$results\[1,"crit.val"\]){

-   ns\_roots = ns\_roots + 1
-   d\_ts = diff(d\_ts)
-   df = BETS.ur\_test(y = d\_ts, type = "none", lags = 11, + selectlags
    = "BIC", level = "1pct")
-   } &gt; &gt; ns\_roots \#\# \[1\] 0 </code>
    </pre>
    </div>
    </div>
    <p>
    Logo, para a série em primeira diferença, rejeita-se a hipótese nula
    de que há raiz unitária a 5% de significância. A FAC dos resíduos da
    equação do teste evidencia que ele foi bem especificado, pois a
    autocorrelação não é significativa até a décima primeira defasagem.
    </p>
    <pre class="highlight"><code>&gt; # Fazer FAC dos res&#xED;duos, com intervalo de confian&#xE7;a de 99%
    &gt; BETS.corrgram(df$residuals,ci=0.99,style=&quot;normal&quot;,lag.max = 11)
    </code></pre>

    <p>
    <img src="http://pedrocostaferreira.github.io/images/unnamed-chunk-4-1.png">
    </p>
    <p>
    Um outro pacote bastante útil que é instalado com o BETS é o
    <code class="highlighter-rouge">forecast</code>. Usaremos a função
    <code class="highlighter-rouge">nsdiffs</code> deste pacote para
    realizar o teste de Osborn-Chui-Smith-Birchenhall e identificar
    raízes unitárias na frequência sazonal (em nosso caso, mensal).
    </p>
    <pre class="highlight"><code>&gt; library(forecast)
    &gt; &gt; # Testes OCSB para ra&#xED;zes unit&#xE1;rias na frequencia sazonal
    &gt; nsdiffs(data, test = &quot;ocsb&quot;) ## [1] 1
    </code></pre>

    <p>
    Infelizmente, a <code class="highlighter-rouge">nsdiffs</code> não
    fornece nenhuma outra informação sobre o resultado do teste além do
    número de diferenças sazonais que devem ser tiradas para eliminar as
    raizes unitárias. Para o caso da série em análise, o programa indica
    que não há raiz unitária mensal, não sendo necessária, portanto,
    diferenças nesta frequência.
    </p>
    <h4 id="12-funções-de-autocorrelação">
    1.2. Funções de Autocorrelação
    </h4>
    <p>
    As conclusões anteriores são corroboradas pela função de
    autocorrelação da série em primeira diferença (figura ). Ela mostra
    que autocorrelações estatisticamente significativas, isto é, fora do
    intervalo de confiança, não são persistentes para defasagens
    múltiplas de 12 e no entorno destas, indicado a ausência da raiz
    unitária sazonal.
    </p>
    <p>
    As funções do BETS que utilizamos para desenhar correlogramas é a
    <code class="highlighter-rouge">BETS.corrgram</code>. Diferentemente
    de sua principal alternativa, a
    <code class="highlighter-rouge">Acf</code> do pacote
    <code class="highlighter-rouge">forecast</code>, a
    <code class="highlighter-rouge">BETS.corrgram</code> retorna uma
    gráfico atraente e oferece a opção de calcular os intervalos de
    confiança de acordo com a fórmula proposta por Bartlett. Sua maior
    vantagem, contudo, não pôde ser exibida aqui, pois depende de
    recursos em <em>flash</em>. Caso o parâmetro
    <code class="highlighter-rouge">style</code> seja definido como
    <code class="highlighter-rouge">'plotly'</code>, o gráfico torna-se
    interativo e mostra todos os valores de interesse (autocorrelações,
    defasagens e intervalos de confiança) com a passagem do
    <em>mouse</em>, além de oferecer opções de <em>zoom</em>,
    <em>pan</em> e para salvar o gráfico no formato png.
    </p>
    <pre class="highlight"><code>&gt; # Correlograma de diff(data)
    &gt; BETS.corrgram(diff(data), lag.max = 48, mode = &quot;bartlett&quot;, style=&quot;plotly&quot;, knit = T)
    </code></pre>

    <p>
    <img src="http://pedrocostaferreira.github.io/images/fac1-1.png" alt="Fun&#xE7;&#xE3;o de Autocorrela&#xE7;&#xE3;o de $\nabla Z_t$">
    </p>
    <p class="caption">
    Função de Autocorrelação de ∇*Z*<sub>*t*</sub>
    </p>
    <p>
    O correlograma acima ainda não é suficiente para determinamos um
    modelo para a série. Faremos, então, o gráfico da função de
    autocorrelação parcial (FACP) de ∇<em>Z</em><sub><em>t</em></sub>. A
    <code class="highlighter-rouge">BETS.corrgram</code> também pode ser
    utilizada para este fim.
    </p>
    <pre class="highlight"><code>&gt; # Fun&#xE7;&#xE3;o de autocorrela&#xE7;&#xE3;o parcial de diff(data)
    &gt; BETS.corrgram(diff(data), lag.max = 36, type = &quot;partial&quot;, style=&quot;plotly&quot;, knit = T)
    </code></pre>

    <p>
    <img src="http://pedrocostaferreira.github.io/images/fac2-1.png" alt="Fun&#xE7;&#xE3;o de Autocorrela&#xE7;&#xE3;o Parcial de $\nabla Z_t$">
    </p>
    <p class="caption">
    Função de Autocorrelação Parcial de ∇*Z*<sub>*t*</sub>
    </p>
    <p>
    A FAC da figura e a FACP da figura podem ter sido geradas por um
    processo <code class="highlighter-rouge">SARIMA(0,0,2)
    (1,0,0)</code>. Esta conjectura se baseia na observação de que as
    defasagens múltiplas de 12 parecem apresentar corte brusco na FACP a
    partir da segunda (isto é, a de número 24) e decaimento exponencial
    na FAC. Além disso, as duas primeiras defasagens da FAC parecem
    significativas, enquanto as demais, não. Há, ainda, alguma evidência
    de decaimento exponencial na FACP, exceto na frequência sazonal. Os
    dois últimos fatos indicam que o polinômio de médias móveis (não
    sazonal) pode ter ordem 2. Por estas razões, o primeiro modelo
    proposto para <em>Z</em><sub><em>t</em></sub> será um
    <code class="highlighter-rouge">SARIMA(0,1,2)(1,0,0)\[12\]</code>.
    </p>
    <h3 id="2-estima&#xE7;&#xE3;o">
    1.  Estimação
        </h3>
        <p>
        Para estimar os coeficientes do modelo
        <code class="highlighter-rouge">SARIMA(0,1,2)(1,0,0)\[12\]</code>,
        será aplicada a função
        <code class="highlighter-rouge">Arima</code> do pacote
        <code class="highlighter-rouge">forecast</code>. Os testes t
        serão feitos através da função
        <code class="highlighter-rouge">BETS.t\_test</code> do BETS, que
        recebe um objeto do tipo
        <code class="highlighter-rouge">arima</code> ou
        <code class="highlighter-rouge">Arima</code>, o número de
        variáveis exógenas do modelo e o nível de significância
        desejado, devolvendo um
        <code class="highlighter-rouge">data.frame</code> contendo as
        informações do teste e do modelo (coeficientes estimados, erros
        padrão, estatísticas de teste, valores críticos e resultados dos
        testes).
        </p>
        <pre class="highlight"><code>&gt; # Estimacao dos par&#xE2;metros do modelo
        &gt; model1 = Arima(data, order = c(0,1,2), seasonal = c(1,0,0))
        &gt; &gt; # Teste t com os coeficientes estimados
        &gt; # N&#xED;vel de signific&#xE2;ncia de 1%
        &gt; BETS.t_test(model1, alpha = 0.01) ## Coeffs Std.Errors t Crit.Values Rej.H0
        ## ma1 -0.2359196 0.07510197 3.141324 2.606518 TRUE
        ## ma2 0.2505574 0.08515366 2.942415 2.606518 TRUE
        ## sar1 0.8266259 0.03941792 20.970815 2.606518 TRUE
        </code></pre>

        <p>
        Concluímos pela coluna
        <code class="highlighter-rouge">Rej.H0</code> que os dois
        coeficientes do modelo, quando estimados por máxima
        verossimilhança, são estatisticamente significativos a 99% de
        confiança.
        </p>
        <h3 id="3-testes-de-diagn&#xF3;stico">
        1.  Testes de Diagnóstico
            </h3>
            <p>
            O objetivo dos testes de diagnóstico é verificar se o modelo
            escolhido é adequado. Neste trabalho, duas conhecidas
            ferramentas serão empregadas: a análise dos resídos
            padronizados e o teste de Llung-Box.
            </p>
            <p>
            O gráfico dos resíduos padronizados (figura ) será feito com
            o auxílio da função
            <code class="highlighter-rouge">BETS.std\_resid</code>, que
            foi implementada especificamente para isso.
            </p>
            <pre class="highlight"><code>&gt; # Gr&#xE1;fico dos res&#xED;duos padronizados
            &gt; resids = BETS.std_resid(model1, alpha = 0.01)
            &gt; &gt; # Evidenciar outlier
            &gt; points(2008 + 11/12, resids[84], col = &quot;red&quot;)
            </code></pre>

            <p>
            <img src="http://pedrocostaferreira.github.io/images/stdr1-1.png" alt="Res&#xED;duos padronizados do primeiro modelo proposto">
            </p>
            <p class="caption">
            Resíduos padronizados do primeiro modelo proposto
            </p>
            <p>
            Observamos que há um <em>outlier</em> proeminente e
            estatisticamente significativo em novembro de 2008. Este
            ponto corresponde à data da quebra estrutural que
            identificamos na figura . Portanto, foi proposto um segundo
            modelo, que inclui uma <em>dummy</em> definida como se
            segue:
            </p>
            <p>
            Esta <em>dummy</em> pode ser criada com a função
            <code class="highlighter-rouge">BETS.dummy</code>, como
            mostramos abaixo. Os parâmetros
            <code class="highlighter-rouge">start</code> e
            <code class="highlighter-rouge">end</code> indicam o início
            e o fim do período coberto pela <em>dummy</em>, que nada
            mais é que uma série temporal cujos valores podem ser apenas
            0 ou 1. Os campos
            <code class="highlighter-rouge">from</code> e
            <code class="highlighter-rouge">to</code> indicam o
            intervalo em que a <em>dummy</em> deve assumir valor 1.
            </p>
            <pre class="highlight"><code>&gt; dummy = BETS.dummy(start = c(2002,1), end = c(2015,10), from = c(2008,9), to = c(2008,11))
            &gt; dummy ## Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec
            ## 2002 0 0 0 0 0 0 0 0 0 0 0 0
            ## 2003 0 0 0 0 0 0 0 0 0 0 0 0
            ## 2004 0 0 0 0 0 0 0 0 0 0 0 0
            ## 2005 0 0 0 0 0 0 0 0 0 0 0 0
            ## 2006 0 0 0 0 0 0 0 0 0 0 0 0
            ## 2007 0 0 0 0 0 0 0 0 0 0 0 0
            ## 2008 0 0 0 0 0 0 0 0 1 1 1 0
            ## 2009 0 0 0 0 0 0 0 0 0 0 0 0
            ## 2010 0 0 0 0 0 0 0 0 0 0 0 0
            ## 2011 0 0 0 0 0 0 0 0 0 0 0 0
            ## 2012 0 0 0 0 0 0 0 0 0 0 0 0
            ## 2013 0 0 0 0 0 0 0 0 0 0 0 0
            ## 2014 0 0 0 0 0 0 0 0 0 0 0 0
            ## 2015 0 0 0 0 0 0 0 0 0 0
            </code></pre>

            <p>
            Como podemos ver nos resultados da execução do trecho de
            código a seguir, a estimação deste modelo através de máxima
            verossimilhança resultou em coeficientes estatisticamente
            diferentes de 0 ao nível de significância de 5%, inclusive
            para a <em>dummy</em>. O gráfico dos resíduos padronizados
            dos valores ajustados pelo novo modelo (figura ) também
            mostra que a inclusão de <em>D</em><sub><em>t</em></sub> foi
            adequada, uma vez que não há mais evidência de quebra
            estrutural.
            </p>
            <pre class="highlight"><code>&gt; # Estimacao dos par&#xE2;metros do modelo com a dummy &gt; model2 = Arima(data, order = c(0,1,2), seasonal = c(1,0,0), xreg = dummy)
            &gt; &gt; # Teste t com os coeficientes estimados
            &gt; # N&#xED;vel de signific&#xE2;ncia de 1%
            &gt; BETS.t_test(model2, alpha = 0.01) ## Coeffs Std.Errors t Crit.Values Rej.H0
            ## ma1 -0.2515672 0.07266577 3.461976 2.606518 TRUE
            ## ma2 0.3194837 0.09032412 3.537080 2.606518 TRUE
            ## sar1 0.8365482 0.03819343 21.902937 2.606518 TRUE
            ## dummy 5.1083323 1.29640546 3.940382 2.606518 TRUE &gt; resids = BETS.std_resid(model2, alpha = 0.01)
            &gt; &gt; # Evidenciar novembro de 2008
            &gt; points(2008 + 11/12, resids[84], col = &quot;red&quot;)
            </code></pre>

            <p>
            <img src="http://pedrocostaferreira.github.io/images/stdr2-1.png" alt="Res&#xED;duos padronizados do modelo proposto ap&#xF3;s a detec&#xE7;&#xE3;o de quebra estrutural">
            </p>
            <p class="caption">
            Resíduos padronizados do modelo proposto após a detecção de
            quebra estrutural
            </p>
            <pre class="highlight"><code>&gt; # Mostrar BIC dos dois modelos estimados
            &gt; model1$bic ## [1] 847.2932 &gt; model2$bic ## [1] 838.1663
            </code></pre>

            <p>
            Notamos, ainda, que o <em>Bayesian Information Criteria</em>
            (BIC) do modelo com a <em>dummy</em> é menor. Logo, também
            por este critério, o modelo com a <em>dummy</em> deve ser
            preferido ao anterior.
            </p>
            <p>
            O teste de Ljung-Box para o modelo escolhido pode ser
            executado através da função
            <code class="highlighter-rouge">Box.test</code> do pacote
            <code class="highlighter-rouge">stats</code>. Para confirmar
            o resultado dos testes, fazemos os correlogramas dos
            resíduos e vemos se há algum padrão de autocorrelação.
            </p>
            <pre class="highlight"><code>&gt; # Teste de Ljung-Box nos res&#xED;duos do modelo com a dummy
            &gt; boxt = Box.test(resid(model2), type = &quot;Ljung-Box&quot;,lag = 11)
            &gt; boxt ## ## Box-Ljung test
            ## ## data: resid(model2)
            ## X-squared = 10.885, df = 11, p-value = 0.4529 &gt; # Correlograma dos res&#xED;duos do modelo com a dummy
            &gt; BETS.corrgram(resid(model2), lag.max = 20, mode = &quot;bartlett&quot;, style = &quot;normal&quot;)
            </code></pre>

            <p>
            <img src="http://pedrocostaferreira.github.io/images/lb-1.png" alt="Fun&#xE7;&#xE3;o de autocorrela&#xE7;&#xE3;o dos res&#xED;duos do modelo com a {\it dummy}.">
            </p>
            <p class="caption">
            Função de autocorrelação dos resíduos do modelo com a {}.
            </p>
            <p>
            O p-valor de 0.4529 indica que há grande probabilidade de a
            hipótese nula de que não há autocorrelação nos resíduos não
            seja rejeitada. Parece ser o caso, como mostra a figura .
            Concluímos, então, que o modelo foi bem especificado.
            </p>
            <h3 id="4-previs&#xF5;es">
            1.  Previsões
                </h3>
                <p>
                O <code class="highlighter-rouge">BETS</code> fornece
                uma maneira conveniente para fazer previsões de modelos
                <code class="highlighter-rouge">SARIMA</code>. A função
                <code class="highlighter-rouge">BETS.predict</code>
                recebe os parâmetros da função
                <code class="highlighter-rouge">forecast</code> do
                pacote homônimo ou da
                <code class="highlighter-rouge">BETS.grnn.test</code> (a
                ser tratada adiante, no segundo estudo de caso) e
                devolve não apenas os objetos contendo as informações da
                previsão, mas também um gráfico da série com os valores
                preditos. Essa visualização é importante para que se
                tenha uma ideia mais completa da adequação do modelo.
                Opcionalmente, podem também ser mostrados os valores
                efetivos do período de previsão.
                </p>
                <p>
                Chamaremos a
                <code class="highlighter-rouge">BETS.predict</code> para
                gerar as previsões do modelo proposto. Os parâmetros
                <code class="highlighter-rouge">object</code> (objeto do
                tipo <code class="highlighter-rouge">arima</code> ou
                <code class="highlighter-rouge">Arima</code>),
                <code class="highlighter-rouge">h</code> (horizonte de
                previsão) e <code class="highlighter-rouge">xreg</code>
                (a <em>dummy</em> para o período de previsão) são
                herdados da função
                <code class="highlighter-rouge">forecast</code>. Os
                demais são da própia
                <code class="highlighter-rouge">BETS.predict</code>,
                sendo todos parâmetros do gráfico, com exceção de
                <code class="highlighter-rouge">actual</code>, os
                valores efetivos da série no período de previsão.
                </p>
                <pre class="highlight"><code>&gt; new_dummy = BETS.dummy(start = start(data_test), end = end(data_test))
                &gt; &gt; preds = BETS.predict(object = model2, xreg = new_dummy, + actual = data_test, xlim = c(2012, 2016.2), ylab = &quot;Milh&#xF5;es de Reais&quot;, + style = &quot;normal&quot;, legend.pos = &quot;bottomleft&quot;)
                </code></pre>

                <p>
                <img src="http://pedrocostaferreira.github.io/images/unnamed-chunk-8-1.png" alt="Gr&#xE1;fico das previs&#xF5;es do modelo SARIMA proposto.">
                </p>
                <p class="caption">
                Gráfico das previsões do modelo SARIMA proposto.
                </p>
                <p>
                As áreas em azul em torno da previsão são os intervalos
                de confiança de 85% (azul escuro) e 95% (azul claro).
                Parece que a aderência das previsões foi satisfatória.
                Para dar mais significado a esta afirmação, podemos
                verificar várias medidas de ajuste acessando o campo
                <code class="highlighter-rouge">'accuracy'</code> do
                objeto retornado.
                </p>
                <pre class="highlight"><code>&gt; preds[[&apos;accuracy&apos;]] ## ME RMSE MAE MPE MAPE ACF1
                ## Test set -3.453621 3.754918 3.453621 -4.254203 4.254203 -0.2252521
                ## Theil&apos;s U
                ## Test set 0.8333718
                </code></pre>

                <p>
                o outro campo deste objeto,
                <code class="highlighter-rouge">'predictions'</code>,
                contém o objeto retornado pela
                <code class="highlighter-rouge">forecast</code> (ou pela
                <code class="highlighter-rouge">BETS.grnn.test</code>,
                se for o caso). Na realidade, este campo ainda conta com
                um dado adicional: os erros de previsão, caso sejam
                fornecidos os valores efetivos da série no período de
                previsão.
                </p>
                <h3 id="o-uso-da-betsreport-para-a-modelagem-sarima">
                O uso da BETS.report para a modelagem SARIMA
                </h3>
                <p>
                A função
                <code class="highlighter-rouge">BETS.report</code>
                executa toda a modelagem Box & Jenkins para qualquer
                conjunto de séries à escolha e gera relatórios com os
                resultados, como foi dito no início desta seção. Ela
                permite que as previsões feitas através do modelo sejam
                salvas em um arquivo de dados
                </p>
                <div class="highlighter-rouge">
                <div class="highlight">
                <pre class="highlight">
                <code>&gt; parameters = list(

-   lag.max = 48,
-   n.ahead = 12 ) &gt; &gt; BETS.report(ts = 21864, parameters =
    parameters) </code>
    </pre>
    </div>
    </div>
    <p>
    O resultado abre automaticamente, na forma de um arquivo
    <code class="highlighter-rouge">html</code>.
    </p>
    </div>

