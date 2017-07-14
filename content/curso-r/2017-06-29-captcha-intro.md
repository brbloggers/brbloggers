+++
title = "Quebrando CAPTCHAs - Introdução"
date = "2017-06-28 11:07:31"
categories = ["curso-r"]
original_url = "http://curso-r.com/blog/2017/06/28/2017-06-29-captcha-intro/"
+++

<p class="text-muted text-uppercase mb-small text-right">
Por <a href="http://curso-r.com/author/julio">Julio</a> 28/06/2017
</p>
<p>
Sabe aquelas imagens chatas que aparecem quando você está preenchendo um
formulário ou quer acessar uma página específica, pedindo para você
decifrar o texto? Isso é o que chamamos de CAPTCHA (<em>Completely
Automated Public Turing test to tell Computers and Humans Apart</em>).
Captchas foram criados para impedir que robôs acessem determinadas
páginas na web de forma irrestrita. Algumas empresas como a Google
também <a href="https://www.google.com/recaptcha/intro/index.html">usam
essas coisinhas para utilizar o conhecimento de seres humanos para
dominar o mundo</a>.
</p>
<span id="fig:unnamed-chunk-1"></span>
<img src="http://curso-r.com/blog/2017/06/28/2017-06-29-captcha-intro/2017-06-29-captcha-intro_files/figure-html/unnamed-chunk-1-1.png" alt="Exemplo de CAPTCHA: Consulta de CNPJ da Receita Federal." width="768">
<p class="caption">
Figure 1: Exemplo de CAPTCHA: Consulta de CNPJ da Receita Federal.
</p>

<p>
Existem captchas de todo tipo: difíceis, fáceis, que fazem sentido e que
não fazem sentido. Um exemplo de CAPTCHA que faz sentido são os
presentes em formulários para criação de emails. Imagine se alguém
fizesse um programa que criasse bilhões de contas de e-mail do gmail!
Morte horrível.
</p>
<p>
Um exemplo de CAPTCHA que não faz sentido são os sites de serviços
públicos, como a Receita Federal ou de alguns Tribunais de Justiça.
Algumas justificativas para isso são: i) não onerar os sistemas (me
poupe, basta fazer uma API) ou ii) a falsa ideia de que assim estão
protegendo as pessoas (de acessar dados públicos?). Se uma informação é
pública ela deve ser acessível, ponto. O que é errado não é acessar a
informação, e sim fazer mau uso dela.
</p>
<p>
Pensando nisso, fiquei imaginando:
</p>
<blockquote>
<p>
Será que é possível quebrar CAPTCHAs usando modelos estatísticos?
</p>
</blockquote>
<p>
Tornando curta uma história longa, sim, é possível! O resultado dessa
brincadeira está na organização
<a href="https://github.com/decryptr">decryptr</a>. Claro que não são
todos os CAPTCHAs que conseguimos quebrar, mas estamos fazendo pesquisa,
brincando nas Rackathons (hackathons com R) e discutindo várias ideias
para tornar isso viável. É um esforço da comunidade para tornar os
serviços públicos mais acessíveis.
</p>

<p>
Como esse tema é extenso e envolve várias técnicas estatísticas e
computacionais avançadas, decidimos montar uma série de posts. O plano
de posts segue abaixo, mas pode mudar conforme os trabalhos forem
realizados.
</p>
<ol>
<li>
Introdução - feito! 😊
</li>
<li>
O pacote <code>decryptr</code>: baixar, visualizar e classificar
CAPTCHAs.
</li>
<li>
Resolvendo CAPTCHAs com segmentação manual.
</li>
<li>
Trabalhando com as imagens completas.
</li>
<li>
Arquitetura do pacote <code>decryptr</code>.
</li>
<li>
Estendendo o <code>decryptr</code> para quebrar seus próprios CAPTCHAs.
</li>
<li>
Redes neurais aplicadas a CAPTCHAs.
</li>
<li>
Utilizando o Keras para quebrar CAPTCHAs.
</li>
<li>
Quebrando CAPTCHAs usando o áudio - case da Receita Federal.
</li>
<li>
Tópicos e opiniões sobre o tema.
</li>
</ol>
<p>
É isso! Happy coding ;)
</p>

