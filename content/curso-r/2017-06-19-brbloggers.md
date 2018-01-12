+++
title = "bR Bloggers está no ar"
date = "2017-06-19 11:07:31"
categories = ["curso-r"]
original_url = "http://curso-r.com/blog/2017/06/19/2017-06-19-brbloggers/"
+++

<div>
<p class="text-muted text-uppercase mb-small text-right">
Por <a href="http://curso-r.com/author/daniel">Daniel</a> 19/06/2017
</p>
<div id="post-content">
<p>
Está no ar o <a href="https://brbloggers.com.br/">bR Bloggers</a>! bR
Bloggers é um agregador de blogs sobre R escritos em língua portuguesa.
</p>
<p>
Atualmente uma das melhores formas de aprender R e de ficar a par da
comunidade R é ler o
<a href="https://www.r-bloggers.com/">R-Bloggers</a>. O R-Bloggers é um
agregador que conta com mais de 700 blogs, que escrevem aproximadamente
300 posts por mês. Lendo tudo isso, não tem como você não aprender muito
R!
</p>
<p>
No entanto, para muitas pessoas, uma barreira para ler os posts do
R-Bloggers pode ser o fato de que todos os posts estão em inglês. Por
isso, a criação do bR Bloggers.
</p>
<p>
A ideia de um agregador de blogs para o português não é original, hoje
mesmo descobri esse link:
<a href="https://www.r-bloggers.com/lang/-/portuguese" class="uri">https://www.r-bloggers.com/lang/-/portuguese</a>:
Uma versão do R-Bloggers em português mantida pelo próprio criador do
R-Bloggers. No entanto, a última postagem data de 2012: 5 anos atrás.
Ainda não existia nem o <code>dplyr</code>(que é de Jan/2014). Não se
falava em <code>tidyverse</code> e nem nada disso também. Pelo menos o
<code>ggplot2</code> já tinha seus 5 anos. Ou seja, tudo no R era
diferente, menos a melhor forma de fazer os seus gráficos.
</p>
<p>
Recentemente o <a href="https://github.com/sillasgonzaga">Sillas
Gonzaga</a> autor do <a href="https://sillasgonzaga.github.io/">Paixão
por Dados</a> criou o
<a href="https://github.com/sillasgonzaga/rbloggers-BR">R-Bloggers
BR</a> um bot do twitter que “twita” toda vez que algum blog da lista
tem um novo post. Também temos uma
<a href="https://github.com/marcosvital/blogs-de-R-no-Brasil">lista de
blogs</a> de R em português mantida pelo
<a href="https://github.com/marcosvital">Marcos Vital</a> do
<a href="https://cantinhodor.wordpress.com/">Cantinho do R</a>.
</p>
<p>
Esses foram bons avanços para a comunidade R brasileira, mas ainda
assim, dado o sucesso do R-Bloggers, sentíamos falta de um agregador no
mesmo estilo para blogs em português. Por isso surgiu o
<a href="https://brbloggers.com.br/">bR Bloggers</a>.
</p>
<p>
Esperamos que o bR Bloggers incentive a comunidade a escrever bastante
conteúdo sobre R em português! Que ele seja uma vitrine para que todos
possam mostrar os seus trabalhos e que ajude muitas pessoas a aprender
R.
</p>
<div id="como-funciona" class="section level1">
<p>
O br Bloggers foi feito em R. E todo o código fonte está disponível em
uma organização do Github:
<a href="https://github.com/brbloggers" class="uri">https://github.com/brbloggers</a>.
São dois repositórios:
</p>
<ul>
<li>
<code>brbloggers</code>: armazena o código front-end do site.
Basicamente é um tema do Hugo.
</li>
<li>
<code>brloggers-backend</code>: armazena o código responsável por
atualizar os posts.
</li>
</ul>
<p>
Dentro do <code>brbloggers-backend</code> o principal arquivo é o
<code>main.R</code>, que contém toda a lógica para obter os novos posts
e salvá-los no seu diretório <code>content</code>.
</p>
<p>
Esse script <code>main.R</code> é chamado pelo script
<code>run.sh</code> que controla o processo de atualização do site:
</p>
<ul>
<li>
faz pull do repositório <code>brbloggers-backend</code>
</li>
<li>
roda o <code>main.R</code>
</li>
<li>
faz commits e push desse repositório
</li>
<li>
atualiza o repo <code>brbloggers</code>
</li>
</ul>
<p>
O <code>run.sh</code> é por sua vez chamado de 30 em 30 minutos por meio
de um <code>cronjob</code> que foi definido em um servidor na Google
Cloud Platform. Esse servidor é uma instância micro do GCP com R
instalado para rodar esses códigos. Ou seja, o backend do brbloggers
custa
U$5,00 por m&\#xEA;s para ficar no ar.&lt;/p&gt; &lt;p&gt;J&\#xE1; o reposit&\#xF3;rio &lt;code&gt;brbloggers&lt;/code&gt; est&\#xE1; linkado com um servi&\#xE7;o chamado &lt;a href="https://www.netlify.com/"&gt;Netlify&lt;/a&gt;. Basicamente o Netlify recebe o c&\#xF3;digo do front-end a cada novo commit no reposit&\#xF3;rio do site e &lt;em&gt;builda&lt;/em&gt; o site est&\#xE1;tico usando o Hugo. O Netlify tamb&\#xE9;m hospeda o site est&\#xE1;tico.&lt;/p&gt; &lt;/div&gt; &lt;div id="o-logo-do-br-bloggers" class="section level1"&gt; &lt;p&gt;O logo do bR Bloggers foio criado pelo &lt;a href="http://curso-r.com/author/julio"&gt;Julio&lt;/a&gt; usando o R. O c&\#xF3;digo est&\#xE1; dispon&\#xED;vel abaixo:&lt;/p&gt; &lt;pre class="r"&gt;&lt;code&gt;library(tidyverse) library(ggforce) \# https://pt.wikipedia.org/wiki/Bandeira\_do\_Brasil\#Cores cores\_br &lt;- list(verde = &apos;\#009C3B&apos;, amarelo = &apos;\#FFDF00&apos;, azul = &apos;\#002776&apos;, branco = &quot;\#FFFFFF&quot;) p &lt;- tibble(x = 1, y = 1, lab1 = &apos;b&apos;, lab2 = &apos;R&apos;) %&gt;% ggplot(aes(x0 = x, y0 = y, r = y)) + geom\_circle(size = 5, n = 5.5, fill = &apos;transparent&apos;, color = cores\_br$verde,
linetype = 1) + geom\_circle(size = 4, n = 5.5, fill = 'transparent',
color =
cores\_br$amarelo, linetype = 2) + geom\_text(aes(x, y, label = lab1), family = &quot;Ubuntu&quot;, size = 45, nudge\_x = -.3, nudge\_y = -.1, colour = cores\_br$azul)
+ geom\_text(aes(x, y, label = lab2), family = "Century", size = 60,
nudge\_x = .3, colour = cores\_br$azul, fontface = 'bold') +
coord\_equal() + theme\_minimal(0) p</code>
</pre>
<p>
<img src="http://curso-r.com/blog/2017-06-19-brbloggers_files/figure-html/unnamed-chunk-2-1.png" width="672">
</p>
</div>
</div>
</div>

