+++
title = "Pacote folhar"
date = "2016-12-16"
categories = ["dfalbel"]
original_url = "http://dfalbel.github.io/2016/12/folhar-pacote.html"
+++

<p class="post">
<article class="post-content">
<p>
Esse post serve apenas para divulgar um pacote que estou desenvolvendo.
Ele ainda não está totalmente pronto, mas se como é difícil de testar, é
bom que mais pessoas usem e vejam se encontram errros, ou
funcionalidades faltando.
</p>
<p>
Esse pacote faz um wrapper em volta do sistema de buscas do site da
Folha de São Paulo:
<a href="http://search.folha.uol.com.br/">http://search.folha.uol.com.br/</a>.
As funções, permitem a partir do R, fazer uma busca no site da Folha por
meio de uma palavra-chave e de duas datas (para pesquisar noticias entre
essas datas).
</p>
<p>
Depois de feita a busca, permite obter o texto de algumas notícias. Como
o site da Folha, possui diversos <em>cadernos</em> fica difícil decidir
uma forma generalizada de fazer o parse de todas as notícias possíveis.
Conforme as pessoas pedirem, irei adicionando parser, ou, é
relativamente simples fazer um pull request adicionando mais parsers
<a href="https://github.com/dfalbel/folhar/blob/master/R/noticia.R">neste
arquivo</a>.
</p>
<p>
Depois de instalar o pacote usando:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">devtools</span><span class="o">::</span><span class="n">install_github</span><span class="p">(</span><span class="s2">&quot;dfalbel/folhar&quot;</span><span class="p">)</span></code></pre>
</figure>
<p>
Você pode fazer uma busca pelo termo <em>estatistica</em>, por exemplo:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">library</span><span class="p">(</span><span class="n">folhar</span><span class="p">)</span><span class="w">
</span><span class="n">busca</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">folha_buscar</span><span class="p">(</span><span class="s2">&quot;estatistica&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;01/11/2016&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;30/11/2016&quot;</span><span class="p">)</span><span class="w"> </span></code></pre>
</figure>
<p>
Veja que <code class="highlighter-rouge">busca</code> é um data.frame
com todas as variáveis:
</p>
<p>
Agora você pode obter o texto completo de algumas notícias e mais alguns
detalhes. As possíveis notícias são as com url iniciado em:
</p>
<ul>
<li>
<http://www1.folha.uol.com.br/>
</li>
<li>
<http://f5.folha.uol.com.br/>
</li>
<li>
<http://www.agora.uol.com.br/>
</li>
</ul>
<p>
Por exemplo, para uma notícia com a URL:
“[http://www1.folha.uol.com.br/poder/2016/11/1836519-pacote-de-dez-medidas-atinge-os-mais-pobres-diz-defensoria-do-rio.shtml”](http://www1.folha.uol.com.br/poder/2016/11/1836519-pacote-de-dez-medidas-atinge-os-mais-pobres-diz-defensoria-do-rio.shtml”)
pode-se usar a função
<code class="highlighter-rouge">folha\_noticias</code> para obter mais
detalhes.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">url</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="s2">&quot;http://www1.folha.uol.com.br/poder/2016/11/1836519-pacote-de-dez-medidas-atinge-os-mais-pobres-diz-defensoria-do-rio.shtml&quot;</span><span class="w">
</span><span class="n">noticia</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">folha_noticias</span><span class="p">(</span><span class="n">url</span><span class="p">)</span></code></pre>
</figure>
<p>
Desta vez um data.frame com as seguintes coluans é retornado:
</p>
<ul>
<li>
url
</li>
<li>
datahora
</li>
<li>
titulo
</li>
<li>
autor
</li>
<li>
texto
</li>
</ul>
</article>
<br> <ins class="adsbygoogle"></ins> <br>
</p>

