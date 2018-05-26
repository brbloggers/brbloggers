+++
title = ""
date = "1-01-01"
categories = ["mind-and-iron"]
original_url = "http://ctlente.com/pt/teaching/decryptr/"
+++

<body>
<textarea id="source">
class: center, middle, inverse, title-slide \# R DAY 2018: UMA API
EXTENSÍVEL PARA QUEBRAR CAPTCHAS \#\#\# Caio Lente \#\#\# 2018-05-22 ---
background-image:
url(<https://avatars2.githubusercontent.com/u/7017340?s=460&v=4>)
background-size: 38% background-position: 85% 20% \# Sobre Mim
&lt;br&gt;&lt;/br&gt; &lt;br&gt;&lt;/br&gt; &lt;br&gt;&lt;/br&gt;
&lt;br&gt;&lt;/br&gt; - Nome: Caio Truzzi Lente - Idade: Mais do que
parece - Cidade: São Paulo, SP - Graduação: Ciência da Computação no
IME-USP - Estágio: Platipus + Associação Brasileira de Jurimetria -
Ensino: Curso-R + R6 --- class: inverse, center, middle \# Decryptr ---
\# Motivação - O `decryptr` nasceu com o objetivo de facilitar a quebra
de captchas textuais de serviços públicos - Muitas vezes os dados são
públicos, mas não *acessíveis*, impedindo que um cidadão comum
analise-os &lt;center&gt; &lt;img src="static/trt.png" width="251" /&gt;
&lt;/center&gt; - Talvez seja possível quebrar o captcha usando apenas
transformações na imagem e um OCR padrão, mas isso acarreta dois
problemas: - O tratamentos das imagens dos captchas de cada fonte não
pode ser generalizado para outra fonte - Transcrição de textos através
de OCR não só tem uma taxa de acerto muito pequena, bem como não é
escalável --- \# Keras - Nossa solução para esses problemas foi o
`Keras`, uma API de redes neurais de alto nível que pode rodar em cima
de múltiplos backends como `TensorFlow` - Usando este framework, Daniel
Falbel&lt;sup&gt;1&lt;/sup&gt; e Julio Trecenti criaram um uma rede
neural que consegue aprender os padrões de famílias de captchas - Dado
um conjunto de treinamento adequado, é possível quebrá-los com acerto e
velocidade impressionantes. - O pacote já vem com alguns modelos
pré-treinados, mas o grande benefício de usar o `decryptr` é que ele
permite que qualquer usuário crie seus próprios modelos - Os captchas da
família precisam ter o mesmo comprimento e a cor de cada letra não pode
ser relevante para a quebra do captcha .footnote\[ \[1\] O Daniel
inclusive chegou a contribuir para o desenvolvimento do *port* da
biblioteca `Keras` para o R.\] --- \# O Pacote - São essencialmente dois
módulos: um para quebrar captchas (`decrypt()`) e um para treinar novos
modelos (`train_model()`) - Temos funções auxiliares como
`read_captcha()` para ler e plotar uma imagem, `classify()` para
auxiliar na criação de bases de treino e `load_model()` para carregar
modelos que o usuário já tenha treinado &lt;center&gt; &lt;div
id="htmlwidget-ad592dee8f59ab6ce76f" style="width:500px;height:250px;"
class="grViz html-widget"&gt;&lt;/div&gt; &lt;script
type="application/json"
data-for="htmlwidget-ad592dee8f59ab6ce76f"&gt;{"x":{"diagram":"rmarkdown
{-&gt;read-&gt;plot-&gt;classify-&gt;classify-&gt;train-&gt;decrypt-&gt;decrypt}","config":{"engine":"dot","options":null}},"evals":\[\],"jsHooks":\[\]}&lt;/script&gt;
&lt;/center&gt; --- \# Exemplo
`r library(decryptr) file &lt;- download_captcha(&quot;trt&quot;, path = &quot;./img&quot;) captcha &lt;- read_captcha(file) plot(captcha[[1]]) *decrypt(file, model = &quot;trt&quot;) files &lt;- download_captcha(&quot;trt&quot;, n = 3, path = &quot;./img&quot;) new_files &lt;- classify(files, path = &quot;./img&quot;) captchas &lt;- read_captcha(new_files, ans_in_path = TRUE) *model &lt;- train_model(captchas, verbose = FALSE) decrypt(file, model = model) microbenchmark::microbenchmark(decrypt = decrypt(captcha, model))`
--- \# Demonstração ![](static/decryptr_demo.gif)&lt;!-- --&gt; ---
class: inverse, center, middle \# Obrigado <ctlente@curso-r.com>
decryptr.ctlente.com github.com/ctlente
</textarea>
</body>

