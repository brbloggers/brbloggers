+++
title = "Teste a velocidade da sua internet usando R"
date = "2018-01-31 11:25:00"
categories = ["curso-r"]
original_url = "http://curso-r.com/blog/2018/01/31/2017-11-17-speedtest/"
+++

<p class="text-muted text-uppercase mb-small text-right">
Por <a href="http://curso-r.com/author/daniel">Daniel</a> 31/01/2018
</p>
<p>
Quem é viciado em R gosta de fazer tudo em R, iclusive atividades
cotidianas. Tem gente que
<a href="https://github.com/jimhester/gmailr">envia e-mais usando R</a>.
Tem gente que
<a href="http://curso-r.com/blog/2017/04/10/2017-04-13-o-que-tem-a-um-km/">procura
hamburguerias usando R</a>. Tem gente que
<a href="https://github.com/abjur/reunioes">anota reuniões e envia a ata
usando R</a>. Já ouvi discussões de gente queria fazer café usando R.
Enfim…
</p>
<p>
Agora temos uma nova utilidade! Você pode testar a velocidade da sua
conexão com a internet sem sair do R usando o pacote
<a href="https://github.com/hrbrmstr/speedtest"><code>speedtest</code></a>.
</p>
<p>
Para instalar o pacote basta um:
</p>
<pre class="r"><code>devtools::install_github(&quot;hrbrmstr/speedtest&quot;)</code></pre>
<p>
E para testar a velocidade:
</p>
<pre class="r"><code>library(speedtest)
spd_test()
# Gathering test configuration information...
# Gathering server list...
# Determining best server...
# Initiating test from Level 3 (meuip) to RedeConesul (Alegrete)
# # Analyzing download speed..........
# Download: 59 Mbit/s
# # Analyzing upload speed......
# Upload: 72 Mbit/s</code></pre>
<p>
Agora você nunca mais vai precisar daquele speedtest.com!
</p>

