+++
title = "Quebrando CAPTCHAs - Parte II: O pacote decryptr"
date = "2017-07-10 11:07:31"
categories = ["curso-r"]
original_url = "http://curso-r.com/blog/2017/07/10/2017-06-29-captcha-decryptr/"
+++

<p class="text-muted text-uppercase mb-small text-right">
Por <a href="http://curso-r.com/author/julio">Julio</a> 10/07/2017
</p>
<p>
No meu último post anunciei que começaríamos uma série sobre CAPTCHAs.
Uma da nossas iniciativas principais nesse tema é a criação do
<a href="https://github.com/decryptr/decryptr">pacote decryptr</a>. Hoje
veremos como usar algumas das funções principais desse pacote.
</p>
<p>
Ao criar o <code>decryptr</code> reduzimos um pouco o escopo de CAPTCHAs
que gostaríamos de incluir. Fizemos isso para não ficarmos malucos, pois
existem diversos tipos de testes disponíveis na web!
</p>
<p>
As suposições são:
</p>
<ol>
<li>
Apenas imagens <code>jpg</code> ou <code>png</code>.
</li>
<li>
Uma imagem possui apenas números e letras.
</li>
<li>
A quantidade de caracteres de um CAPTCHA é fixa.
</li>
<li>
Dois CAPTCHAs de mesma origem têm sempre as mesmas dimensões.
</li>
<li>
Não conseguimos nem queremos quebrar o
<a href="https://www.google.com/recaptcha/intro/invisible.html">reCAPTCHA</a>.
</li>
</ol>

<p>
O <code>decryptr</code> ainda não está no CRAN. Isso significa que para
instalá-lo você precisará do <code>devtools</code>:
</p>
<pre class="r"><code>if (!require(devtools)) install.packages(&apos;devtools&apos;)
devtools::install_github(&apos;decryptr/decryptr&apos;)</code></pre>
<p>
As funções principais do <code>decryptr</code> são
</p>
<ul>
<li>
<code>download()</code>: baixar imagens da web.
</li>
<li>
<code>read\_captcha()</code>: adiciona metadados úteis a uma string com
o caminho do CAPTCHA.
</li>
<li>
<code>load\_captcha()</code>: carrega a imagem na memória.
</li>
<li>
<code>plot.captcha()</code>: método <code>S3</code> para desenhar o
CAPTCHA na tela.
</li>
<li>
<code>classify.captcha()</code>: método <code>S3</code> para classificar
CAPTCHAs manualmente.
</li>
<li>
<code>prepare.captcha()</code>: método <code>S3</code> para carregar
CAPTCHAs em um formato adequado para modelagem usando o Keras.
</li>
<li>
<code>model.captcha()</code>: método <code>S3</code> para modelar os
CAPTCHAs.
</li>
<li>
<code>predict.captcha()</code>: método <code>S3</code> para classificar
um CAPTCHA a partir de um modelo ajustado e um caminho de imagem.
</li>
</ul>
<p>
O modo de uso planejado do <code>decryptr</code> está descrito na Figura
<a href="http://curso-r.com/blog/2017/07/10/2017-06-29-captcha-decryptr/#fig:fluxo">1</a>.
</p>
<pre><code>## Warning: Installed Rcpp (0.12.11.4) different from Rcpp used to build dplyr (0.12.11.3).
## Please reinstall dplyr to avoid random crashes or undefined behavior.</code></pre>
<span id="fig:fluxo"></span>
<p class="caption">
Figure 1: Fluxo de utilização do pacote <code>decryptr</code>.
</p>

<p>
Como ainda não temos a teoria completa para ajuste de modelos, nesse
post vamos ficar com a utilização das funções de download, visualização
e classificação.
</p>

<p>
Para plotar um CAPTCHA basta ler o arquivo com
<code>read\_captcha()</code> e depois usar a função <code>plot()</code>.
Exemplo:
</p>
<pre class="r"><code>library(decryptr)
&apos;img/tjmg/captcha4d2f795d4e4_92522.jpeg&apos; %&gt;% read_captcha() %&gt;% plot()</code></pre>
<span id="fig:unnamed-chunk-3"></span>
<img src="http://curso-r.com/blog/2017/07/10/2017-06-29-captcha-decryptr/2017-06-29-captcha-decryptr_files/figure-html/unnamed-chunk-3-1.png" alt="CAPTCHA do TJMG." width="384">
<p class="caption">
Figure 2: CAPTCHA do TJMG.
</p>

<p>
Vale mencionar que esse não é um <code>ggplot()</code> então nem tente
somar layers nesse gráfico 😄.
</p>

<p>
A classificação manual de CAPTCHAs é importante para possibilitar o
treino de modelos preditivos. Para classificar um CAPTCHA você pode
utilizar a função <code>classify()</code>, assim:
</p>
<pre class="r"><code>&apos;img/tjmg/captcha4d2f795d4e4_92522.jpeg&apos; %&gt;% read_captcha() %&gt;% classify()</code></pre>
<p>
Essa função fará duas coisas:
</p>
<ul>
<li>
Plota o CAPTCHA na tela.
</li>
<li>
Abre um console para o usuário digitar o valor do CAPTCHA manualmente.
</li>
</ul>
<p>
Ao escrever o valor o CAPTCHA, pressione <code>&lt;enter&gt;</code>.
Após isso, a função <code>classify()</code> irá adicionar sua
classificação após o nome da imagem, como no exemplo acima:
<code>\_92522</code>. A função <code>classify()</code> gera uma cópia
para que seja impossível de perder a imagem original.
</p>
<p>
Algumas opções do <code>classify()</code>:
</p>
<ul>
<li>
<code>dest=</code> colocar uma pasta para classificar os CAPTCHAs. Por
padrão é a pasta onde os originais estão.
</li>
<li>
<code>answer=</code> adicionar uma resposta ao invés de esperar abrir o
console. Essa opção é útil quando as classficações são feitas
automaticamente (e.g., por um quebrador de CAPTCHAs que usa o áudio no
lugar da imagem.)
</li>
</ul>

<ul>
<li>
Baixar com <code>download()</code> ou <code>download\_\*()</code>.
</li>
<li>
Visualizar com <code>read\_captcha()</code> pipe <code>plot()</code>.
</li>
<li>
Classificar com <code>read\_captcha()</code> pipe
<code>classify()</code>.
</li>
</ul>
<p>
Caso encontre problemas,
<a href="https://github.com/decryptr/decryptr/issues">adicione issues no
repositório do pacote</a>.
</p>
<p>
É isso. Happy coding ;)
</p>

