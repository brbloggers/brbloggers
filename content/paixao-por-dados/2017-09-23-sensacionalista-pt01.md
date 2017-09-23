+++
title = "O Sensacionalista e Text Mining: Análise de sentimento usando o lexiconPT"
date = "2017-09-23 03:00:00"
categories = ["paixao-por-dados"]
original_url = "http://sillasgonzaga.github.io/2017-09-23-sensacionalista-pt01/"
+++

<article class="blog-post">
<p>
De volta à ativa no blog!
</p>
<p>
Recentemente, quando precisei fazer pela primeira vez algum tipo de
análise em cima de textos (o chamado Text Mining ou Mineração de Texto)
em Português, senti falta de ter um acesso fácil a um léxico na
linguagem. O R já tem a sua disposição vários recursos para quem quer
fazer Text Mining em inglês, como os pacotes
<code class="highlighter-rouge">tokenizer</code>,
<code class="highlighter-rouge">tidytext</code>,
<code class="highlighter-rouge">tm</code> e
<code class="highlighter-rouge">lexicon</code>, além de vários blog
posts sobre Sentiment Analysis que você encontra no R-bloggers. Contudo,
existe uma séria escassez de material de referência na língua
portuguesa.
</p>
<p>
O pacote
<a href="https://github.com/sillasgonzaga/lexiconPT"><code class="highlighter-rouge">lexiconPT</code></a>,
que eu lancei em 20/09/2017 no Github (e em breve no CRAN também) nasceu
para resolver parte desse problema. Até o momento, o
<code class="highlighter-rouge">lexiconPT</code> possui três datasets de
léxicos: o OpLexicon (versões 2.1 e 3.0) e o SentiLex-PT02. Não pretendo
(nem tenho competência para tal, pois sou iniciante em Text Mining - sem
falsa modéstia) destrinchar como cada um deles funciona e em quê eles
diferem. Para isso, sugiro ler as referências citadas na documentação
dos próprios datasets (ex.:
<code class="highlighter-rouge">help("oplexicon\_v2.1")</code>).
</p>
<p>
Mas ter o léxico em mãos só resolve parte dos problemas: ainda faltam os
textos em si para serem analisados. Algumas ideias de datasets poderiam
ser notícias, letras de músicas, livros (tem vários em Domínio Público),
tweets, etc. Para demonstrar um simples uso do pacote, eu decidi por
analisar comentários feitos por usuários na página do
<a href="https://www.facebook.com/sensacionalista/">Sensacionalista</a>,
uma das mais populares do Facebook. A coleta dos dados foi relativamente
fácil graças ao pacote <code class="highlighter-rouge">Rfacebook</code>.
</p>
<p>
Com o pacote <code class="highlighter-rouge">lexiconPT</code>, podemos
responder a perguntas como:
</p>
<ul>
<li>
Os comentários no Sensacionalista são mais negativos ou positivos?
</li>
<li>
Qual termo está mais associado a comentários negativos? PT ou PSDB?
Temer ou Dilma? Bolsonaro ou Lula?
</li>
<li>
Qual o comentário feito por um usuário mais negativo da história do
Sensacionalista (dentro da amostra coletada)? E qual o mais positivo?
</li>
</ul>
<p>
Vamos ao código.
</p>
<h2 id="coleta-dos-dados">
Coleta dos dados
</h2>
<figure class="highlight">
<pre><code class="language-r"><span class="n">library</span><span class="p">(</span><span class="n">Rfacebook</span><span class="p">)</span><span class="w"> </span><span class="c1"># usado para extrair dados do facebook
</span><span class="n">library</span><span class="p">(</span><span class="n">tidyverse</span><span class="p">)</span><span class="w"> </span><span class="c1"># pq nao da pra viver sem
</span><span class="n">library</span><span class="p">(</span><span class="n">ggExtra</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">magrittr</span><span class="p">)</span><span class="w"> </span><span class="c1"># &lt;3
</span><span class="n">library</span><span class="p">(</span><span class="n">lubridate</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">stringr</span><span class="p">)</span><span class="w"> </span><span class="c1"># essencial para trabalhar com textos
</span><span class="n">library</span><span class="p">(</span><span class="n">tidytext</span><span class="p">)</span><span class="w"> </span><span class="c1"># um dos melhores pacotes para text mining
</span><span class="n">library</span><span class="p">(</span><span class="n">lexiconPT</span><span class="p">)</span></code></pre>
</figure>
<p>
Este post só foi possível graças ao
<code class="highlighter-rouge">Rfacebook</code>. Para aprender como ele
funciona, leia a documentação presente em seu
<a href="https://github.com/pablobarbera/Rfacebook">repo</a> no Github.
Para este primeiro, primeiro usei a função
<code class="highlighter-rouge">getPage()</code> para extrair as últimas
5000 publicações do Sensacionalista.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="c1"># token que eu gerei com minha API key.
# Essa parte vc obviamente nao vai conseguir reproduzir.
# leia o README do Rfacebook para saber como obter seu token
</span><span class="n">fb_token</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">readRDS</span><span class="p">(</span><span class="s2">&quot;/home/sillas/R/data/facebook_token.Rds&quot;</span><span class="p">)</span><span class="w"> </span><span class="c1"># demora cerca de 10 min pra rodar:
</span><span class="n">pg</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">getPage</span><span class="p">(</span><span class="s2">&quot;sensacionalista&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">fb_token</span><span class="p">,</span><span class="w"> </span><span class="n">n</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">5000</span><span class="p">)</span></code></pre>
</figure>
<p>
É necessário corrigir o encoding do corpo da publicação para o R parar
de reclamar sobre isso:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="c1"># corrigir encoding do texto do post
</span><span class="n">pg</span><span class="o">$</span><span class="n">message</span><span class="w"> </span><span class="o">%&lt;&gt;%</span><span class="w"> </span><span class="n">iconv</span><span class="p">(</span><span class="n">to</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;ASCII//TRANSLIT&quot;</span><span class="p">)</span><span class="w">
</span><span class="c1"># remover emojis
</span><span class="n">pg</span><span class="o">$</span><span class="n">message</span><span class="w"> </span><span class="o">%&lt;&gt;%</span><span class="w"> </span><span class="n">iconv</span><span class="p">(</span><span class="n">sub</span><span class="o">=</span><span class="s2">&quot;&quot;</span><span class="p">,</span><span class="w"> </span><span class="s1">&apos;UTF-8&apos;</span><span class="p">,</span><span class="w"> </span><span class="s1">&apos;ASCII&apos;</span><span class="p">)</span><span class="w">
</span><span class="c1"># visualizar dataframe
</span><span class="n">glimpse</span><span class="p">(</span><span class="n">pg</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## Observations: 4,666
## Variables: 11
## $ from_id &lt;chr&gt; &quot;108175739225302&quot;, &quot;108175739225302&quot;, &quot;10817573...
## $ from_name &lt;chr&gt; &quot;Sensacionalista&quot;, &quot;Sensacionalista&quot;, &quot;Sensacio...
## $ message &lt;chr&gt; &quot;Apos liminar da Justica do DF permitir o trata...
## $ created_time &lt;chr&gt; &quot;2017-09-18T18:58:53+0000&quot;, &quot;2017-09-18T17:25:0...
## $ type &lt;chr&gt; &quot;link&quot;, &quot;link&quot;, &quot;link&quot;, &quot;link&quot;, &quot;video&quot;, &quot;link&quot;...
## $ link &lt;chr&gt; &quot;http://www.sensacionalista.com.br/2017/09/18/l...
## $ id &lt;chr&gt; &quot;108175739225302_1638598099516384&quot;, &quot;1081757392...
## $ story &lt;chr&gt; NA, NA, NA, NA, &quot;Sensacionalista shared Gshow -...
## $ likes_count &lt;dbl&gt; 10172, 2162, 2503, 5793, 4676, 2585, 821, 766, ...
## $ comments_count &lt;dbl&gt; 230, 164, 285, 221, 329, 104, 32, 58, 493, 586,...
## $ shares_count &lt;dbl&gt; 2290, 453, 410, 2751, 0, 930, 26, 36, 900, 92, ...</code></pre>
</figure>
<p>
Só esse dataset por si só já renderia (e renderá) análises
interessantes, mas vou as deixar para um futuro post para não deixar
este aqui grande demais.
</p>
<p>
A coluna <code class="highlighter-rouge">id</code> é a que usaremos como
referência como input na função
<code class="highlighter-rouge">getPost()</code> para extrair os
comentários dos usuários na publicação. Infelizmente, a API do Facebook
apresenta uma certa instabilidade para requests de dados muito grandes.
Em várias tentativas que fiz, o máximo de dados que consegui extrair
foram 200 comentários de 500 publicações da página. Portanto, vou usar
esses parâmetros:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="c1"># roda em cerca de 8 minutos:
</span><span class="n">df_posts</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">pg</span><span class="o">$</span><span class="n">id</span><span class="p">[</span><span class="m">1</span><span class="o">:</span><span class="m">500</span><span class="p">]</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">map</span><span class="p">(</span><span class="n">getPost</span><span class="p">,</span><span class="w"> </span><span class="n">fb_token</span><span class="p">,</span><span class="w"> </span><span class="n">n</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">200</span><span class="p">,</span><span class="w"> </span><span class="n">comments</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">TRUE</span><span class="p">,</span><span class="w"> </span><span class="n">likes</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">FALSE</span><span class="p">,</span><span class="w"> </span><span class="n">reactions</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">FALSE</span><span class="p">)</span></code></pre>
</figure>
<p>
A função <code class="highlighter-rouge">getPost()</code> fornece o
seguinte output:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">str</span><span class="p">(</span><span class="n">df_posts</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## List of 500
## $ :List of 2
## ..$ post :&apos;data.frame&apos;:    1 obs. of 10 variables:
## .. ..$ from_id : chr &quot;108175739225302&quot;
## .. ..$ from_name : chr &quot;Sensacionalista&quot;
## .. ..$ message : chr &quot;Ap&#xF3;s liminar da Justi&#xE7;a do DF permitir o tratamento da homossexualidade como doen&#xE7;a&quot;
## .. ..$ created_time : chr &quot;2017-09-18T18:58:53+0000&quot;
## .. ..$ type : chr &quot;link&quot;
## .. ..$ link : chr &quot;http://www.sensacionalista.com.br/2017/09/18/liminar-que-chancela-cura-gay-permite-tratar-justica-brasileira-como-doenca/&quot;
## .. ..$ id : chr &quot;108175739225302_1638598099516384&quot;
## .. ..$ likes_count : num 11340
## .. ..$ comments_count: num 248
## .. ..$ shares_count : num 2590
## ..$ comments:&apos;data.frame&apos;: 200 obs. of 7 variables:
## .. ..$ from_id : chr [1:200] &quot;1437254732976789&quot; &quot;1445900342154501&quot; &quot;10209941046899919&quot; &quot;173469923210786&quot; ...
## .. ..$ from_name : chr [1:200] &quot;S&#xE9;rgio Henrique Reis&quot; &quot;Renata Gil&quot; &quot;Lucas Ferreira&quot; &quot;Leonardo Wesley&quot; ...
## .. ..$ message :</code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## Error in strtrim(encodeString(object, quote = &quot;\&quot;&quot;, na.encode = FALSE), : string multibyte inv&#xE1;lida em &apos;&lt;a0&gt;&lt;be&gt;\xed&apos;</code></pre>
</figure>
<p>
Para extrair os dataframes relativos aos comentários e aos metadados das
publicações, o <code class="highlighter-rouge">purrr</code> é uma mão na
roda:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">df_comments</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">df_posts</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">map_df</span><span class="p">(</span><span class="s2">&quot;comments&quot;</span><span class="p">)</span><span class="w">
</span><span class="n">df_posts</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">df_posts</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">map_df</span><span class="p">(</span><span class="s2">&quot;post&quot;</span><span class="p">)</span><span class="w">
</span><span class="c1"># repetir procedimento de consertar o encoding
</span><span class="n">df_comments</span><span class="o">$</span><span class="n">message</span><span class="w"> </span><span class="o">%&lt;&gt;%</span><span class="w"> </span><span class="n">iconv</span><span class="p">(</span><span class="n">to</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;ASCII//TRANSLIT&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">iconv</span><span class="p">(</span><span class="n">sub</span><span class="o">=</span><span class="s2">&quot;&quot;</span><span class="p">,</span><span class="w"> </span><span class="s1">&apos;UTF-8&apos;</span><span class="p">,</span><span class="w"> </span><span class="s1">&apos;ASCII&apos;</span><span class="p">)</span><span class="w">
</span><span class="n">df_posts</span><span class="o">$</span><span class="n">message</span><span class="w"> </span><span class="o">%&lt;&gt;%</span><span class="w"> </span><span class="n">iconv</span><span class="p">(</span><span class="n">to</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;ASCII//TRANSLIT&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">iconv</span><span class="p">(</span><span class="n">sub</span><span class="o">=</span><span class="s2">&quot;&quot;</span><span class="p">,</span><span class="w"> </span><span class="s1">&apos;UTF-8&apos;</span><span class="p">,</span><span class="w"> </span><span class="s1">&apos;ASCII&apos;</span><span class="p">)</span><span class="w">
</span><span class="c1"># por questoes de anonimizacao, vou remover os dados pessoais referentes aos usuarios
</span><span class="n">df_comments</span><span class="w"> </span><span class="o">%&lt;&gt;%</span><span class="w"> </span><span class="n">select</span><span class="p">(</span><span class="o">-</span><span class="n">from_id</span><span class="p">,</span><span class="w"> </span><span class="o">-</span><span class="n">from_name</span><span class="p">)</span><span class="w"> </span><span class="c1"># olhar estrutura dos dataframes
</span><span class="n">str</span><span class="p">(</span><span class="n">df_comments</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## &apos;data.frame&apos;: 72100 obs. of 5 variables:
## $ message : chr &quot;Entao pode faltar no servico, ligar pro chefe(a), levar atestado e dizer que acordou com vontade de chupar rola?&quot; &quot;Nunca o sensacionalista foi tao verdadeiro. Pq a justica brasileira se demonstrou uma verdadeira praga na socie&quot;| __truncated__ &quot;O unico que precisa de tratamento e o sr juiz que autorizou.&quot; &quot;Isso viola todas os acordos internacionais e uma aberracao contra qqr liberdade individual e humana. Logo essa liminar cai.&quot; ...
## $ created_time : chr &quot;2017-09-18T19:01:21+0000&quot; &quot;2017-09-18T19:03:57+0000&quot; &quot;2017-09-18T19:01:26+0000&quot; &quot;2017-09-18T19:00:54+0000&quot; ...
## $ likes_count : num 575 392 270 227 310 145 113 73 38 50 ...
## $ comments_count: num 58 5 4 3 12 16 10 0 0 8 ...
## $ id : chr &quot;1638598099516384_1638600206182840&quot; &quot;1638598099516384_1638602159515978&quot; &quot;1638598099516384_1638600266182834&quot; &quot;1638598099516384_1638599869516207&quot; ...</code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-r"><span class="n">str</span><span class="p">(</span><span class="n">df_posts</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## &apos;data.frame&apos;:   500 obs. of 10 variables:
## $ from_id : chr &quot;108175739225302&quot; &quot;108175739225302&quot; &quot;108175739225302&quot; &quot;108175739225302&quot; ...
## $ from_name : chr &quot;Sensacionalista&quot; &quot;Sensacionalista&quot; &quot;Sensacionalista&quot; &quot;Sensacionalista&quot; ...
## $ message : chr &quot;Apos liminar da Justica do DF permitir o tratamento da homossexualidade como doenca&quot; &quot;Ja recebeu encomendas de quarteis&quot; &quot;Aparelho esta sendo oferecido por importadores por ate 6 mil reais&quot; &quot;Temer desembarcou nos Estados Unidos para jantar com Trump e participacao na Assembleia Geral da ONU&quot; ...
## $ created_time : chr &quot;2017-09-18T18:58:53+0000&quot; &quot;2017-09-18T17:25:00+0000&quot; &quot;2017-09-18T17:05:41+0000&quot; &quot;2017-09-18T17:00:02+0000&quot; ...
## $ type : chr &quot;link&quot; &quot;link&quot; &quot;link&quot; &quot;link&quot; ...
## $ link : chr &quot;http://www.sensacionalista.com.br/2017/09/18/liminar-que-chancela-cura-gay-permite-tratar-justica-brasileira-como-doenca/&quot; &quot;http://www.sensacionalista.com.br/2017/09/18/fabricante-de-pau-de-arara-comemora-falta-de-resposta-a-general-qu&quot;| __truncated__ &quot;http://www.sensacionalista.com.br/2017/09/18/empresa-lanca-servico-de-escolta-armada-para-quem-comprar-o-iphone-x/&quot; &quot;http://www.sensacionalista.com.br/2017/09/18/coreia-do-norte-nega-ter-lancado-temer-nos-eua/&quot; ...
## $ id : chr &quot;108175739225302_1638598099516384&quot; &quot;108175739225302_1638510679525126&quot; &quot;108175739225302_1638503796192481&quot; &quot;108175739225302_1638456466197214&quot; ...
## $ likes_count : num 11340 2271 2826 6361 4990 ...
## $ comments_count: num 248 167 315 242 347 106 32 58 494 590 ...
## $ shares_count : num 2590 478 441 3008 0 ...</code></pre>
</figure>
<p>
Só pode ser trollagem da API do Facebook retornar aquela mensagem logo
no topo do dataframe, mas enfim.
</p>
<p>
O dataframe <code class="highlighter-rouge">df\_comments</code>, o
objeto da nossa análise, não possui alguns dados que serão valiosos para
a análise, como o link para o artigo no site do Sensacionalista. Por
isso, vamos um <code class="highlighter-rouge">left\_join</code> com o
<code class="highlighter-rouge">df\_posts</code>.
</p>
<p>
Percebeu que nas colunas
<code class="highlighter-rouge">df\_comments$id&lt;/code&gt; e &lt;code class="highlighter-rouge"&gt;df\_posts$id</code>
existe um traço separando dois conjuntos numéricos? Por alguma razão que
beira a imbecilidade, não é possível combinar imediatamente essas duas
colunas para formatar um dataframe só com o
<code class="highlighter-rouge">left\_join</code>. A sintaxe de
identificação do Facebook funciona assim: O post é identificado
<code class="highlighter-rouge">IDPAGINA\_IDPUBLICAÇÃO</code> e o
comentário na publicação é identificado como
<code class="highlighter-rouge">IDPUBLICAÇÃO\_IDCOMENTÁRIO</code>. Ou
seja, para poder juntar os dois dataframes, vamos ter que combinar a
sequência númerica à esquerda do underline (acho que esse traço tem
algum outro nome, mas não me lembro no momento) em
<code class="highlighter-rouge">df\_comments$id&lt;/code&gt; e &\#xE0; direita em &lt;code class="highlighter-rouge"&gt;df\_posts$id</code>.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="c1"># consertar colunas de id: no df_comments, deixar &#xE0; esquerda do underline. no df_posts, deixar &#xE0; direita.
</span><span class="n">df_comments</span><span class="o">$</span><span class="n">id_post_real</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">df_comments</span><span class="o">$</span><span class="n">id</span><span class="w">
</span><span class="n">df_comments</span><span class="o">$</span><span class="n">id</span><span class="w"> </span><span class="o">%&lt;&gt;%</span><span class="w"> </span><span class="n">str_replace_all</span><span class="p">(</span><span class="s2">&quot;_.*&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;&quot;</span><span class="p">)</span><span class="w">
</span><span class="n">df_posts</span><span class="o">$</span><span class="n">id</span><span class="w"> </span><span class="o">%&lt;&gt;%</span><span class="w"> </span><span class="n">str_replace_all</span><span class="p">(</span><span class="s2">&quot;.*_&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;&quot;</span><span class="p">)</span><span class="w"> </span><span class="c1"># juntar as duas tabelas
</span><span class="n">df_posts</span><span class="w"> </span><span class="o">%&lt;&gt;%</span><span class="w"> </span><span class="n">dplyr</span><span class="o">::</span><span class="n">select</span><span class="p">(</span><span class="n">id</span><span class="p">,</span><span class="w"> </span><span class="n">post_message</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">message</span><span class="p">,</span><span class="w"> </span><span class="n">horario_post</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">created_time</span><span class="p">,</span><span class="w"> </span><span class="n">type</span><span class="p">,</span><span class="w"> </span><span class="n">post_comments_count</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">comments_count</span><span class="p">,</span><span class="w"> </span><span class="n">post_link</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">link</span><span class="p">,</span><span class="w"> </span><span class="n">post_type</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">type</span><span class="p">,</span><span class="w"> </span><span class="n">post_likes_count</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">likes_count</span><span class="p">)</span><span class="w">
</span><span class="n">df_comments</span><span class="w"> </span><span class="o">%&lt;&gt;%</span><span class="w"> </span><span class="n">rename</span><span class="p">(</span><span class="n">horario_comentario</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">created_time</span><span class="p">)</span><span class="w"> </span><span class="n">df_comments</span><span class="w"> </span><span class="o">%&lt;&gt;%</span><span class="w"> </span><span class="n">left_join</span><span class="p">(</span><span class="n">df_posts</span><span class="p">,</span><span class="w"> </span><span class="n">by</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;id&quot;</span><span class="p">)</span><span class="w">
</span><span class="c1"># remover NAs (nao sao muitos casos)
</span><span class="n">df_comments</span><span class="w"> </span><span class="o">%&lt;&gt;%</span><span class="w"> </span><span class="n">filter</span><span class="p">(</span><span class="o">!</span><span class="nf">is.na</span><span class="p">(</span><span class="n">horario_post</span><span class="p">))</span><span class="w">
</span><span class="c1"># converter colunas de horario
</span><span class="n">df_comments</span><span class="o">$</span><span class="n">horario_comentario</span><span class="w"> </span><span class="o">%&lt;&gt;%</span><span class="w"> </span><span class="n">str_sub</span><span class="p">(</span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="m">19</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">str_replace_all</span><span class="p">(</span><span class="s2">&quot;T&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">ymd_hms</span><span class="p">()</span><span class="w">
</span><span class="n">df_comments</span><span class="o">$</span><span class="n">horario_post</span><span class="w"> </span><span class="o">%&lt;&gt;%</span><span class="w"> </span><span class="n">str_sub</span><span class="p">(</span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="m">19</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">str_replace_all</span><span class="p">(</span><span class="s2">&quot;T&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">ymd_hms</span><span class="p">()</span><span class="w">
</span><span class="c1"># Como ficou:
</span><span class="n">glimpse</span><span class="p">(</span><span class="n">df_comments</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## Observations: 71,891
## Variables: 12
## $ message &lt;chr&gt; &quot;Entao pode faltar no servico, ligar pro c...
## $ horario_comentario &lt;dttm&gt; 2017-09-18 19:01:21, 2017-09-18 19:03:57,...
## $ likes_count &lt;dbl&gt; 575, 392, 270, 227, 310, 145, 113, 73, 38,...
## $ comments_count &lt;dbl&gt; 58, 5, 4, 3, 12, 16, 10, 0, 0, 8, 69, 3, 0...
## $ id &lt;chr&gt; &quot;1638598099516384&quot;, &quot;1638598099516384&quot;, &quot;1...
## $ id_post_real &lt;chr&gt; &quot;1638598099516384_1638600206182840&quot;, &quot;1638...
## $ post_message &lt;chr&gt; &quot;Apos liminar da Justica do DF permitir o ...
## $ horario_post &lt;dttm&gt; 2017-09-18 18:58:53, 2017-09-18 18:58:53,...
## $ post_type &lt;chr&gt; &quot;link&quot;, &quot;link&quot;, &quot;link&quot;, &quot;link&quot;, &quot;link&quot;, &quot;l...
## $ post_comments_count &lt;dbl&gt; 248, 248, 248, 248, 248, 248, 248, 248, 24...
## $ post_link &lt;chr&gt; &quot;http://www.sensacionalista.com.br/2017/09...
## $ post_likes_count &lt;dbl&gt; 11340, 11340, 11340, 11340, 11340, 11340, ...</code></pre>
</figure>
<h2 id="uso-do-lexiconpt">
Uso do lexiconPT
</h2>
<p>
Agora temos o dataset em mãos para usar o
<code class="highlighter-rouge">lexiconPT</code>. Acho muito importante
ressaltar que Text Mining é uma atividade razoavelmente complexa que
envolve uma extensa etapa de limpeza e tratamento de dados, como remover
(ou não) acentos e corrigir palavras com letras duplicadas
(trist<em>ee</em>) ou erros gramaticais (infelismente). Para fins de
simplicidade, não vou me ater muito a esses detalhes e pular direto para
a utilização dos léxicos portugueses e apresentação dos resultados.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="c1"># carregar datasets
</span><span class="n">data</span><span class="p">(</span><span class="s2">&quot;oplexicon_v3.0&quot;</span><span class="p">)</span><span class="w">
</span><span class="n">data</span><span class="p">(</span><span class="s2">&quot;sentiLex_lem_PT02&quot;</span><span class="p">)</span><span class="w"> </span><span class="n">op30</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">oplexicon_v3.0</span><span class="w">
</span><span class="n">sent</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">sentiLex_lem_PT02</span><span class="w"> </span><span class="n">glimpse</span><span class="p">(</span><span class="n">op30</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## Observations: 32,191
## Variables: 4
## $ term &lt;chr&gt; &quot;=[&quot;, &quot;=@&quot;, &quot;=p&quot;, &quot;=P&quot;, &quot;=x&quot;, &quot;=d&quot;, &quot;=D&quot;, &quot;;...
## $ type &lt;chr&gt; &quot;emot&quot;, &quot;emot&quot;, &quot;emot&quot;, &quot;emot&quot;, &quot;emot&quot;, &quot;emo...
## $ polarity &lt;int&gt; -1, -1, -1, -1, -1, 1, 1, 1, 1, -1, -1, -1, ...
## $ polarity_revision &lt;chr&gt; &quot;A&quot;, &quot;A&quot;, &quot;A&quot;, &quot;A&quot;, &quot;A&quot;, &quot;A&quot;, &quot;A&quot;, &quot;A&quot;, &quot;A&quot;,...</code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-r"><span class="n">glimpse</span><span class="p">(</span><span class="n">sent</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## Observations: 7,014
## Variables: 5
## $ term &lt;chr&gt; &quot;&#xE0;-vontade&quot;, &quot;abafado&quot;, &quot;abafante&quot;, &quot;a...
## $ grammar_category &lt;chr&gt; &quot;N&quot;, &quot;Adj&quot;, &quot;Adj&quot;, &quot;Adj&quot;, &quot;Adj&quot;, &quot;Adj&quot;...
## $ polarity &lt;dbl&gt; 1, -1, -1, -1, -1, 1, -1, 1, 1, -1, -1...
## $ polarity_target &lt;chr&gt; &quot;N0&quot;, &quot;N0&quot;, &quot;N0&quot;, &quot;N0&quot;, &quot;N0&quot;, &quot;N0&quot;, &quot;N...
## $ polarity_classification &lt;chr&gt; &quot;MAN&quot;, &quot;JALC&quot;, &quot;MAN&quot;, &quot;JALC&quot;, &quot;JALC&quot;, ...</code></pre>
</figure>
<p>
Ambos os datasets possuem colunas de polaridade de sentimento, que é a
que usaremos para quantificar o quão negativo ou positivo é um
comentário.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="c1"># criar ID unica para cada comentario
</span><span class="n">df_comments</span><span class="w"> </span><span class="o">%&lt;&gt;%</span><span class="w"> </span><span class="n">mutate</span><span class="p">(</span><span class="n">comment_id</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">row_number</span><span class="p">())</span><span class="w">
</span><span class="c1"># usar fun&#xE7;ao do tidytext para criar uma linha para cada palavra de um comentario
</span><span class="n">df_comments_unnested</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">df_comments</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">unnest_tokens</span><span class="p">(</span><span class="n">term</span><span class="p">,</span><span class="w"> </span><span class="n">message</span><span class="p">)</span><span class="w"> </span><span class="n">df_comments_unnested</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">select</span><span class="p">(</span><span class="n">comment_id</span><span class="p">,</span><span class="w"> </span><span class="n">term</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">head</span><span class="p">(</span><span class="m">20</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## comment_id term
## 1 1 entao
## 1.1 1 pode
## 1.2 1 faltar
## 1.3 1 no
## 1.4 1 servico
## 1.5 1 ligar
## 1.6 1 pro
## 1.7 1 chefe
## 1.8 1 a
## 1.9 1 levar
## 1.10 1 atestado
## 1.11 1 e
## 1.12 1 dizer
## 1.13 1 que
## 1.14 1 acordou
## 1.15 1 com
## 1.16 1 vontade
## 1.17 1 de
## 1.18 1 chupar
## 1.19 1 rola</code></pre>
</figure>
<p>
*De novo esse comentário… *
</p>
<p>
Enfim, veja que foi criada uma linha para cada palavra presetnte no
comentário. Será essa nova coluna
<code class="highlighter-rouge">term</code> que usaremos como referência
para quantificar o sentimento de um comentário.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">df_comments_unnested</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">left_join</span><span class="p">(</span><span class="n">op30</span><span class="p">,</span><span class="w"> </span><span class="n">by</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;term&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">left_join</span><span class="p">(</span><span class="n">sent</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">select</span><span class="p">(</span><span class="n">term</span><span class="p">,</span><span class="w"> </span><span class="n">lex_polarity</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">polarity</span><span class="p">),</span><span class="w"> </span><span class="n">by</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;term&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">select</span><span class="p">(</span><span class="n">comment_id</span><span class="p">,</span><span class="w"> </span><span class="n">term</span><span class="p">,</span><span class="w"> </span><span class="n">polarity</span><span class="p">,</span><span class="w"> </span><span class="n">lex_polarity</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">head</span><span class="p">(</span><span class="m">10</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## comment_id term polarity lex_polarity
## 1 1 entao NA NA
## 2 1 pode NA NA
## 3 1 faltar 1 NA
## 4 1 no NA NA
## 5 1 servico NA NA
## 6 1 ligar -1 NA
## 7 1 pro NA NA
## 8 1 chefe NA NA
## 9 1 a NA NA
## 10 1 levar -1 NA</code></pre>
</figure>
<p>
A amostra acima mostra que nem toads as palavras possuem uma polaridade
registrada nos léxicos. Não só isso, mas algumas palavras (como
<strong>faltar</strong>, <strong>ligar</strong> e
<strong>levar</strong>) estão presentes no OpLexicon mas não no
SentiLex. A polaridade 1 em faltar significa que, de acordo com esse
léxico, a palavra está associada a comentários positivos. Saber essa
diferença é fundamental, pois a escolha do léxico pode ter uma grande
influência nos resultados da análise.
</p>
<p>
Vamos então manter no dataframe apenas as palavras que possuem
polaridade tanto no OpLexicon como no SentiLex:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">df_comments_unnested</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">df_comments_unnested</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">inner_join</span><span class="p">(</span><span class="n">op30</span><span class="p">,</span><span class="w"> </span><span class="n">by</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;term&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">inner_join</span><span class="p">(</span><span class="n">sent</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">select</span><span class="p">(</span><span class="n">term</span><span class="p">,</span><span class="w"> </span><span class="n">lex_polarity</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">polarity</span><span class="p">),</span><span class="w"> </span><span class="n">by</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;term&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">group_by</span><span class="p">(</span><span class="n">comment_id</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">summarise</span><span class="p">(</span><span class="w"> </span><span class="n">comment_sentiment_op</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">sum</span><span class="p">(</span><span class="n">polarity</span><span class="p">),</span><span class="w"> </span><span class="n">comment_sentiment_lex</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">sum</span><span class="p">(</span><span class="n">lex_polarity</span><span class="p">),</span><span class="w"> </span><span class="n">n_words</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">n</span><span class="p">()</span><span class="w"> </span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">ungroup</span><span class="p">()</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">rowwise</span><span class="p">()</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">mutate</span><span class="p">(</span><span class="w"> </span><span class="n">most_neg</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">min</span><span class="p">(</span><span class="n">comment_sentiment_lex</span><span class="p">,</span><span class="w"> </span><span class="n">comment_sentiment_op</span><span class="p">),</span><span class="w"> </span><span class="n">most_pos</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">max</span><span class="p">(</span><span class="n">comment_sentiment_lex</span><span class="p">,</span><span class="w"> </span><span class="n">comment_sentiment_op</span><span class="p">)</span><span class="w"> </span><span class="p">)</span><span class="w"> </span><span class="n">head</span><span class="p">(</span><span class="n">df_comments_unnested</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## # A tibble: 6 x 6
## comment_id comment_sentiment_op comment_sentiment_lex n_words most_neg
## &lt;int&gt; &lt;int&gt; &lt;dbl&gt; &lt;int&gt; &lt;dbl&gt;
## 1 2 0 0 2 0
## 2 7 -2 -3 3 -3
## 3 8 1 1 2 1
## 4 9 0 0 3 0
## 5 11 -2 -2 2 -2
## 6 12 -2 -2 2 -2
## # ... with 1 more variables: most_pos &lt;dbl&gt;</code></pre>
</figure>
<h2 id="apresentação-dos-resultados">
Apresentação dos resultados
</h2>
<p>
O gráfico de pontos abaixo mostra a distribuição de polaridade para cada
léxico:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">p</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">df_comments_unnested</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">ggplot</span><span class="p">(</span><span class="n">aes</span><span class="p">(</span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">comment_sentiment_op</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">comment_sentiment_lex</span><span class="p">))</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">geom_point</span><span class="p">(</span><span class="n">aes</span><span class="p">(</span><span class="n">color</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">n_words</span><span class="p">))</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">scale_color_continuous</span><span class="p">(</span><span class="n">low</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;green&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">high</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;red&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">labs</span><span class="p">(</span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Polaridade no OpLexicon&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Polaridade no SentiLex&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="c1">#geom_smooth(method = &quot;lm&quot;) +
</span><span class="w"> </span><span class="n">geom_vline</span><span class="p">(</span><span class="n">xintercept</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">0</span><span class="p">,</span><span class="w"> </span><span class="n">linetype</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;dashed&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">geom_hline</span><span class="p">(</span><span class="n">yintercept</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">0</span><span class="p">,</span><span class="w"> </span><span class="n">linetype</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;dashed&quot;</span><span class="p">)</span><span class="w"> </span><span class="n">p</span></code></pre>
</figure>
<p>
<img src="http://sillasgonzaga.github.io/figs/sensacionalista-pt01/unnamed-chunk-37-1.png" alt="center">
</p>
<p>
Existem pelo menos três outliers nos dados, todos causados pela grande
quantidade de palavras do comentário, o que pode ser um indício de que
simplesmente somar a polaridade de cada palavra do comentário pode não
ser um bom método. Outra informação revelada pelo gráfico é que existem
palavras que possuem sentimentos diferentes de acordo com o léxico
usado. Ter isso em mente é fundamental para a análise.
</p>
<p>
Após remover os outliers, já é possível descobrir quais os comentários
mais positivos e mais negativos da amostra coletada:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">df_comments_unnested</span><span class="w"> </span><span class="o">%&lt;&gt;%</span><span class="w"> </span><span class="n">filter</span><span class="p">(</span><span class="n">between</span><span class="p">(</span><span class="n">comment_sentiment_op</span><span class="p">,</span><span class="w"> </span><span class="m">-10</span><span class="p">,</span><span class="w"> </span><span class="m">10</span><span class="p">))</span><span class="w"> </span><span class="c1"># comentario mais positivo da historia do sensacionalista
</span><span class="n">most_pos</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">which.max</span><span class="p">(</span><span class="n">df_comments_unnested</span><span class="o">$</span><span class="n">most_pos</span><span class="p">)</span><span class="w">
</span><span class="n">most_neg</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">which.min</span><span class="p">(</span><span class="n">df_comments_unnested</span><span class="o">$</span><span class="n">most_neg</span><span class="p">)</span><span class="w"> </span><span class="c1"># mais positivo
</span><span class="n">cat</span><span class="p">(</span><span class="n">df_comments</span><span class="o">$</span><span class="n">message</span><span class="p">[</span><span class="n">df_comments</span><span class="o">$</span><span class="n">comment_id</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="n">df_comments_unnested</span><span class="o">$</span><span class="n">comment_id</span><span class="p">[</span><span class="n">most_pos</span><span class="p">]])</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## O mundo a esquerda e sempre melhor. A musica, o pincel, a pena e a talha. Sempre esteve para a esquerda. As grandes mentes criativas, os grandes pensadores, os humanistas, os geniais. Tudo que e original e belo e oriundo da esquerda.
## E tendencia natural do ser humano, ao passo q alcanca um minimo de consciencia critica do mundo sempre tender a esquerda.
## Todavia o mundo tambem precisa de mentes computacionais, a esse papel a direita tem seu valor. A direita funciona bem quando o objetivo e produzir o fisico, o tangivel e operacional. Embora isso tambem pudesse ser feito por maquinas, robos, ou mesmo por animais adestrados.
## A exemplo, os EUA, onde o cidadao comum e um ser vegetativo, destinado a operar, produzir e consumir. Sao seres incapazes de formular um pensamento critico e original. Uma nacao que por forca do capital tem seu vies ideologico voltado pra direita. Ainda q por vezes elejam um presidente com vies de esquerda, nunca irao evoluir sua consciencia. Sera sempre uma nacao de dementes e ignorantes.
## Nao por acaso que o capital, na sua forma economica ou politica sempre se poe sobre a direita quando tem por objetivo o ganho, financeiro ou de poder. E sobre a direita q se faz os movimentos de massa imbecilizada, pois como seres roboticos sao facilmente levados aonde se quer levar.
## A esquerda liga-se ao mundo das ideias, ao pensamento critico, a modelagem do ser humano como ser consciente. A esquerda e a construcao do pensamento, e o
## individuo pensante e critico, tudo que evolui e eleva o ser humano a um patamar de consciencia superior, provem da esquerda.
## Nacoes capitalistas, ainda q direitista, mas q sua massa possui em sua construcao um vies ideologico de esquerda serao sempre nacoes ricas financeiramente e ricas de estado de consciencia critica. Observa se isto em paises europeus, onde o
## capital existe por forca do consumo, mas coexiste com o estado de bem estar social, com a beleza das artes e com tudo aquilo e natural da esquerda, enquanto consciencia e beleza.
## A direita tem por tendencia natural, o simples, o computacional e robotizado. O argumento da direita e sempre algoritmo, linear e raso. A direita sera sempre um universo de seres ocos, massivos e imbecilizados.
## A.L.C.</code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-r"><span class="c1"># mais negativo
</span><span class="n">cat</span><span class="p">(</span><span class="n">df_comments</span><span class="o">$</span><span class="n">message</span><span class="p">[</span><span class="n">df_comments</span><span class="o">$</span><span class="n">comment_id</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="n">df_comments_unnested</span><span class="o">$</span><span class="n">comment_id</span><span class="p">[</span><span class="n">most_neg</span><span class="p">]])</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## Ditadura Comunista ## ## Em pleno 2017 hoje o Brasil debate o tema comunismo, pare estranho falar uma coisa dessa mais e isso que gerou esse grande populismo do Jair Bolsonaro. O Jair Bolsonaro criou um inimigo da sociedade um inimigo do Brasil que e o comunismo e hoje ele bate em cima dessa ideia de comunismo mais agente pensa a Uniao das Republicas Socialistas Sovieticas deixou de ser comunista sera que o Brasil vai querer ser hoje comunista, sera que alguem ja viu algum partido do Brasil nos ultimos 40 anos viu algum partido do Brasil tentar implementar comunismo no Brasil. O comunismo e um regime onde ninguem tem propriedade o estado tem tudo sera que um politico de hoje em dia gostaria de perder tudo que tem para poder implementar um comunismo eu acredito que nao exista no Brasil inclusive o PSDB que e um partido comunista do Brasil, eu acredito que eles nao tem ideologias de implementacao do comunismo, entao quando a gente tem um partido de esquerda e um partido onde tem aquela ideia que reverter o dinheiro do rico para o pobre atraves de educacao, saude ou ate mesmo a bolsa familia eles chama isso de comunismo, mais na hora que eles agridem a ideologia comunista eles falam do comunismo radical aquele comunismo de tomar tudo das pessoas e entregar para o estado isso mostra que existe realmente uma carencia de educacao na juventude brasileira que e a maioria dessas pessoas que estao defendendo o Bolsonaro, elas realmente acreditam nessa historia de que um partido brasileiro vai implementar um ditadura e vai implementar o comunismo no Brasil. ## So que a coisa e muito controversia porque eles acreditam que as forcas armadas sao integras agora eu pergunto e chamo para uma reflexao. Existe a possibilidade de um presidente de um estado que era democratico hoje e ditadura mais era democratico vamos pensar eles acusam o Lula de tentar implementar o comunismo, existe a possibilidade de um presidente em um pais que eles consideram as forcas armadas integra implementar um comunismo? Entao nao tem como o presidente implementar o comunismo sem a ajuda das forcas armadas ai a gente ve que tem uma discrepancia muito forte da informacao e essas lacunas de informacao que sao os caminhos para educar essa molecada que esta com esse tipo de ideia, realmente foi despertado um medo muito grande do comunismo por mais que parece estranho mesma coisa de falar para criancas terem medo do lobo mal hoje em dia parece absurdo pra quem e adulto mais eles estao com medo do comunismo. E esse tipo de dialogo e esse tipo de conversa que esta criando essa massa de jovens eleitores do Bolsonaro o medo do comunismo.</code></pre>
</figure>
<p>
Por incrível que pareça, tanto o comentário mais positivo quanto o mais
negativo falam sobre a esquerda.
</p>
<p>
Para prosseguir com a análise, usaremos o léxico OpLexicon para a
análise de sentimento:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">df_comments</span><span class="w"> </span><span class="o">%&lt;&gt;%</span><span class="w"> </span><span class="n">inner_join</span><span class="p">(</span><span class="w"> </span><span class="n">df_comments_unnested</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">select</span><span class="p">(</span><span class="n">comment_id</span><span class="p">,</span><span class="w"> </span><span class="n">sentiment</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">comment_sentiment_op</span><span class="p">),</span><span class="w"> </span><span class="n">by</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;comment_id&quot;</span><span class="w"> </span><span class="p">)</span><span class="w">
</span><span class="c1"># criar coluna de data (variavel da classe Date)
</span><span class="n">df_comments</span><span class="o">$</span><span class="n">data</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">as.Date</span><span class="p">(</span><span class="n">df_comments</span><span class="o">$</span><span class="n">horario_post</span><span class="p">)</span></code></pre>
</figure>
<p>
Agora sim podemos demonstrar uma visualização de uma análise básica de
sentimento: Como tem sido o sentimento geral dos comentários no
Sensacionalista ao longo do tempo?
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">df_comments_wide</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">df_comments</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="c1"># filtrar fora palavras neutras
</span><span class="w"> </span><span class="n">filter</span><span class="p">(</span><span class="n">sentiment</span><span class="w"> </span><span class="o">!=</span><span class="w"> </span><span class="m">0</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="c1"># converter numerico para categorico
</span><span class="w"> </span><span class="n">mutate</span><span class="p">(</span><span class="n">sentiment</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">ifelse</span><span class="p">(</span><span class="n">sentiment</span><span class="w"> </span><span class="o">&lt;</span><span class="w"> </span><span class="m">0</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;negativo&quot;</span><span class="p">,</span><span class="w"> </span><span class="s2">&quot;positivo&quot;</span><span class="p">))</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="c1"># agrupar os dados
</span><span class="w"> </span><span class="n">count</span><span class="p">(</span><span class="n">data</span><span class="p">,</span><span class="w"> </span><span class="n">post_link</span><span class="p">,</span><span class="w"> </span><span class="n">post_type</span><span class="p">,</span><span class="w"> </span><span class="n">sentiment</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="c1"># converter para formato wide
</span><span class="w"> </span><span class="n">spread</span><span class="p">(</span><span class="n">sentiment</span><span class="p">,</span><span class="w"> </span><span class="n">n</span><span class="p">,</span><span class="w"> </span><span class="n">fill</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">0</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">mutate</span><span class="p">(</span><span class="n">sentimento</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">positivo</span><span class="w"> </span><span class="o">-</span><span class="w"> </span><span class="n">negativo</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">ungroup</span><span class="p">()</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">arrange</span><span class="p">(</span><span class="n">data</span><span class="p">)</span><span class="w"> </span><span class="n">head</span><span class="p">(</span><span class="n">df_comments_wide</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">knitr</span><span class="o">::</span><span class="n">kable</span><span class="p">()</span></code></pre>
</figure>
<table>
<thead>
<tr>
<th>
data
</th>
<th>
post\_link
</th>
<th>
post\_type
</th>
<th>
negativo
</th>
<th>
positivo
</th>
<th>
sentimento
</th>
</tr>
</thead>
<tbody>
<tr>
<td>
2017-04-13
</td>
<td>
<https://www.facebook.com/sensacionalista/photos/a.187587037950838.39557.108175739225302/1460990897277106/?type=3>
</td>
<td>
photo
</td>
<td>
9
</td>
<td>
13
</td>
<td>
4
</td>
</tr>
<tr>
<td>
2017-04-13
</td>
<td>
<http://www.sensacionalista.com.br/2017/04/13/temer-lula-e-fhc-articulam-pacto-de-nao-rir-de-brasileiro-que-desfez-amizade-no-facebook-por-politica/>
</td>
<td>
link
</td>
<td>
31
</td>
<td>
24
</td>
<td>
-7
</td>
</tr>
<tr>
<td>
2017-04-14
</td>
<td>
<https://www.facebook.com/sensacionalista/photos/a.187587037950838.39557.108175739225302/1462221330487396/?type=3>
</td>
<td>
photo
</td>
<td>
42
</td>
<td>
9
</td>
<td>
-33
</td>
</tr>
<tr>
<td>
2017-04-15
</td>
<td>
<https://www.facebook.com/sensacionalista/photos/a.187587037950838.39557.108175739225302/1463589740350555/?type=3>
</td>
<td>
photo
</td>
<td>
5
</td>
<td>
8
</td>
<td>
3
</td>
</tr>
<tr>
<td>
2017-04-16
</td>
<td>
<https://www.sensacionalista.com.br/2016/03/25/laja-jato-diz-que-lula-comprou-ovo-da-kopenhagen-em-nome-de-amigo/>
</td>
<td>
link
</td>
<td>
19
</td>
<td>
27
</td>
<td>
8
</td>
</tr>
<tr>
<td>
2017-04-16
</td>
<td>
<http://www.sensacionalista.com.br/2017/04/10/as-18-melhores-coisas-com-sentimentos-a-nova-obsessao-da-internet/>
</td>
<td>
link
</td>
<td>
17
</td>
<td>
14
</td>
<td>
-3
</td>
</tr>
</tbody>
</table>
<p>
Por exemplo, o primeiro link coletado na amostra, uma foto, teve 9
palavras contadas como negativas e 13 como positivas. O score geral dos
comentários nessa publicação foi 13 - 9 = 4.
</p>
<p>
Qual a publicação do Sensacionalista com maior nível de “positividade”?
E o de “negatividade”?
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">df_comments_wide</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">arrange</span><span class="p">(</span><span class="n">sentimento</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">filter</span><span class="p">(</span><span class="n">row_number</span><span class="p">()</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="m">1</span><span class="w"> </span><span class="o">|</span><span class="w"> </span><span class="n">row_number</span><span class="p">()</span><span class="w"> </span><span class="o">==</span><span class="w"> </span><span class="n">nrow</span><span class="p">(</span><span class="n">df_comments_wide</span><span class="p">))</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">knitr</span><span class="o">::</span><span class="n">kable</span><span class="p">()</span></code></pre>
</figure>
<table>
<thead>
<tr>
<th>
data
</th>
<th>
post\_link
</th>
<th>
post\_type
</th>
<th>
negativo
</th>
<th>
positivo
</th>
<th>
sentimento
</th>
</tr>
</thead>
<tbody>
<tr>
<td>
2017-09-11
</td>
<td>
<http://www.sensacionalista.com.br/2017/09/11/projeto-do-mbl-pretende-vestir-obras-de-arte-em-museus-ao-redor-do-mundo/>
</td>
<td>
link
</td>
<td>
90
</td>
<td>
28
</td>
<td>
-62
</td>
</tr>
<tr>
<td>
2017-06-05
</td>
<td>
<http://www.sensacionalista.com.br/2017/06/05/festa-se-nada-der-certo-em-colegio-debocha-de-garis-e-faxineiras-e-mostra-que-ja-deu-tudo-errado/>
</td>
<td>
link
</td>
<td>
33
</td>
<td>
84
</td>
<td>
51
</td>
</tr>
</tbody>
</table>
<p>
A publicação que mais recebeu comentários negativos (não tenho certeza
se é essa a interpretação mais correta dos resultados, mas enfim) é um
link sobre o MBL, enquanto o mais positivo é sobre o famoso caso do “E
se der errado”.
</p>
<p>
O gráfico abaixo mostra a evolução do sentimento dos comentários nas
publicações do Sensacionalista ao longo do tempo:
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">df_comments_wide</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">mutate</span><span class="p">(</span><span class="n">index</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">row_number</span><span class="p">())</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">ggplot</span><span class="p">(</span><span class="n">aes</span><span class="p">(</span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">index</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">sentimento</span><span class="p">))</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">geom_col</span><span class="p">(</span><span class="n">aes</span><span class="p">(</span><span class="n">fill</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">post_type</span><span class="p">))</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">scale_y_continuous</span><span class="p">(</span><span class="n">breaks</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">seq</span><span class="p">(</span><span class="m">-60</span><span class="p">,</span><span class="w"> </span><span class="m">60</span><span class="p">,</span><span class="w"> </span><span class="m">20</span><span class="p">),</span><span class="w"> </span><span class="n">limits</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="m">-60</span><span class="p">,</span><span class="w"> </span><span class="m">60</span><span class="p">))</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">labs</span><span class="p">(</span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;&#xCD;ndice da publica&#xE7;&#xE3;o&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Sentimento&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">fill</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">NULL</span><span class="p">,</span><span class="w"> </span><span class="n">title</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Evolu&#xE7;&#xE3;o do sentimento em publica&#xE7;&#xF5;es do Sensacionalista&quot;</span><span class="p">)</span></code></pre>
</figure>
<p>
<img src="http://sillasgonzaga.github.io/figs/sensacionalista-pt01/unnamed-chunk-42-1.png" alt="center">
</p>
<p>
Uma possível interpretação do gráfico é que a série temporal não possui
uma clara tendência, apesar de os picos de negatividade serem bem mais
frequentes que os de positividade.
</p>
<p>
Outra análise que dá para fazer é investigar o nível de sentimento de
comentários associados a determinadas palavras. Por exemplo, o quão
negativo costuma ser um comentário quando ele menciona a palavra
<strong>bolsonaro</strong>?
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="c1"># qual o sentimento mais associado a palavras em especifico
</span><span class="n">df_comments</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">mutate</span><span class="p">(</span><span class="w"> </span><span class="n">temer</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">str_detect</span><span class="p">(</span><span class="n">str_to_lower</span><span class="p">(</span><span class="n">message</span><span class="p">),</span><span class="w"> </span><span class="s2">&quot;temer&quot;</span><span class="p">),</span><span class="w"> </span><span class="n">lula</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">str_detect</span><span class="p">(</span><span class="n">str_to_lower</span><span class="p">(</span><span class="n">message</span><span class="p">),</span><span class="w"> </span><span class="s2">&quot;lula&quot;</span><span class="p">),</span><span class="w"> </span><span class="n">pmdb</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">str_detect</span><span class="p">(</span><span class="n">str_to_lower</span><span class="p">(</span><span class="n">message</span><span class="p">),</span><span class="w"> </span><span class="s2">&quot;pmdb&quot;</span><span class="p">),</span><span class="w"> </span><span class="n">psdb</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">str_detect</span><span class="p">(</span><span class="n">str_to_lower</span><span class="p">(</span><span class="n">message</span><span class="p">),</span><span class="w"> </span><span class="s2">&quot;psdb&quot;</span><span class="p">),</span><span class="w"> </span><span class="n">pt</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">str_detect</span><span class="p">(</span><span class="n">str_to_lower</span><span class="p">(</span><span class="n">message</span><span class="p">),</span><span class="w"> </span><span class="s2">&quot;pt&quot;</span><span class="p">),</span><span class="w"> </span><span class="n">dilma</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">str_detect</span><span class="p">(</span><span class="n">str_to_lower</span><span class="p">(</span><span class="n">message</span><span class="p">),</span><span class="w"> </span><span class="s2">&quot;dilma&quot;</span><span class="p">),</span><span class="w"> </span><span class="n">doria</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">str_detect</span><span class="p">(</span><span class="n">str_to_lower</span><span class="p">(</span><span class="n">message</span><span class="p">),</span><span class="w"> </span><span class="s2">&quot;doria&quot;</span><span class="p">),</span><span class="w"> </span><span class="n">governo</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">str_detect</span><span class="p">(</span><span class="n">str_to_lower</span><span class="p">(</span><span class="n">message</span><span class="p">),</span><span class="w"> </span><span class="s2">&quot;governo&quot;</span><span class="p">),</span><span class="w"> </span><span class="n">bolsonaro</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">str_detect</span><span class="p">(</span><span class="n">str_to_lower</span><span class="p">(</span><span class="n">message</span><span class="p">),</span><span class="w"> </span><span class="s2">&quot;bolsonaro&quot;</span><span class="p">)</span><span class="w"> </span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">gather</span><span class="p">(</span><span class="n">termo</span><span class="p">,</span><span class="w"> </span><span class="n">eh_presente</span><span class="p">,</span><span class="w"> </span><span class="n">temer</span><span class="o">:</span><span class="n">bolsonaro</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">filter</span><span class="p">(</span><span class="n">eh_presente</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">group_by</span><span class="p">(</span><span class="n">termo</span><span class="p">)</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">summarise</span><span class="p">(</span><span class="n">sentiment</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">mean</span><span class="p">(</span><span class="n">sentiment</span><span class="p">))</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">ggplot</span><span class="p">(</span><span class="n">aes</span><span class="p">(</span><span class="n">x</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">termo</span><span class="p">,</span><span class="w"> </span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">sentiment</span><span class="p">))</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">geom_col</span><span class="p">(</span><span class="n">fill</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;#C10534&quot;</span><span class="p">)</span></code></pre>
</figure>
<p>
<img src="http://sillasgonzaga.github.io/figs/sensacionalista-pt01/unnamed-chunk-43-1.png" alt="center">
</p>
<p>
Temer e Dilma, os dois presidentes com os piores níveis de popularidade
de República, estarem associados a comentários positivos é bem
surpreendente. Na verdade, isso ocorre porque a própria palavra
<strong>temer</strong> possui polaridade positiva. Para consultar a
polaridade de uma palavra nos datasets presentes no
<code class="highlighter-rouge">lexiconPT</code>, use a função
<code class="highlighter-rouge">lexiconPT::get\_word\_sentiment()</code>.
</p>
<figure class="highlight">
<pre><code class="language-r"><span class="n">get_word_sentiment</span><span class="p">(</span><span class="s2">&quot;temer&quot;</span><span class="p">)</span></code></pre>
</figure>
<figure class="highlight">
<pre><code class="language-text">## $oplexicon_v2.1
## term type polarity
## 28711 temer vb 1
## ## $oplexicon_v3.0
## term type polarity polarity_revision
## 30160 temer vb 1 A
## ## $sentilex
## term grammar_category polarity polarity_target
## 6546 temer V -1 N0:N1
## polarity_classification
## 6546 MAN</code></pre>
</figure>
<h2 id="conclusão-e-chamada-para-futuros-trabalhos">
Conclusão e chamada para futuros trabalhos
</h2>
<p>
O pacote <code class="highlighter-rouge">lexiconPT</code>, apesar de
simples, tem um enorme potencial para enriquecer o conteúdo de Text
Mining em Português na comunidade brasileira de R. O exemplo dado nesse
post pode ser considerado deveras simplório. Muitas etapas foram puladas
ou desconsideradas com o intuito de fornecer a você uma rápida
introdução às possibilidades criadas pelo pacote. Espero que o leitor
deste post tenha se sentido motivado a fazer suas próprias análises de
sentimento. As possibilidade são incontáveis.
</p>
<h2 id="referências">
Referências
</h2>
</article>

