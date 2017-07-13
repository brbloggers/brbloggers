+++
title = "Arrumando BDs: nome das variáveis"
date = "2017-07-12 20:26:00"
categories = ["curso-r"]
original_url = "http://curso-r.com/blog/2017/07/12/2017-07-13-bds_nomes_variaveis/"
+++

<div id="post-content">
<p>
Arrumar base de dados é uma tarefa chata, perigosa e pode consumir uma
grande parcela do tempo total do projeto.
</p>
<p>
A tarefa é chata porque é um grande retrabalho que muitas vezes cai na
mão dos estatísticos. Mandar de volta para o responsável corrigir é uma
opção, mas já passei por situações em que o tempo perdido no vai-e-vem
da bd foi bem maior do que o tempo que eu gastaria para arrumar eu mesmo
(e no fim, o banco ainda continha erros). Bds apropriadas para a análise
poderiam (e deveriam) ser montados pelo pesquisador ou responsável desde
o início, pois, em geral, são bem mais simples do que as que costumamos
receber. Por isso, sempre vale espalhar as boas práticas de construção
de bds na hora de pegar um trabalho.
</p>
<p>
É uma tarefa perigosa porque mexer nos dados é sempre uma fonte de erro,
principalmente quando fazemos alterações diretamente na planilha e/ou
não temos conhecimento técnico sobre as variáveis.
</p>
<p>
Por fim, se a base é muito grande e tem muitos erros, precisamos
encontrar formas eficientes para corrigi-la, pois mexer em variável por
variável, se não for inviável, pode demandar muito tempo.
</p>
<p>
Sendo assim, vamos começar aqui uma pequena série de posts para ajudar
nessa tarefa, utilizando sempre as ferramentas do
<code>tidyverse</code>, em especial do pacote <code>stringr</code>.
Neste post, começarei mostrando uma forma rápida para padronizar os
nomes das variáveis da bd, deixando-os mais adequados para o restante da
análise.
</p>
<p>
Para isso, vou utilizar como exemplo algumas variáveis de uma base com
que trabalhei alguns anos atrás. A bd original (que continha informações
de pacientes do Instituto do Coração) tinha cerca 170 variáveis, então
selecionei apenas algumas.
</p>
<pre class="r"><code>library(tidyverse)
## Warning: Installed Rcpp (0.12.11.4) different from Rcpp used to build dplyr (0.12.11.3).
## Please reinstall dplyr to avoid random crashes or undefined behavior. dados %&gt;% names
## [1] &quot;Sexo&quot; &quot;Nascimento&quot; &quot;Idade&quot; ## [4] &quot;Inclus&#xE3;o&quot; &quot;Cor&quot; &quot;Peso&quot; ## [7] &quot;Altura&quot; &quot;cintura&quot; &quot;IMC&quot; ## [10] &quot;Superf&#xED;cie corporal&quot; &quot;Tabagismo&quot; &quot;cg.tabag (cig/dia)&quot; ## [13] &quot;Alcool (dose/semana)&quot; &quot;Drogas il&#xED;citas&quot; &quot;Cafe&#xED;na/dia&quot; ## [16] &quot;Refrig/dia&quot; &quot;Sedentario&quot; &quot;ativ. Fisica&quot;</code></pre>
<p>
Vejam que os nomes têm letras maiúsculas, acentos, parênteses, pontos e
barras. Não é impossível fazer a análise com esses nomes, mas geralmente
atrapalha bastante quando precisamos selecionar algumas dessas colunas.
O ideal seria ter os nomes padronizados, até para ficar mais fácil de
lembrarmos deles.
</p>
<p>
Para deixar o exemplo reprodutível sem a necessidade de baixar a bd,
gerei o código para criar um vetor com o nome das variáveis.
</p>
<pre class="r"><code>dados %&gt;% names %&gt;% paste0(&quot;&apos;&quot;, ., &quot;&apos;&quot;, collapse = &quot;, &quot;) %&gt;% paste0(&quot;c(&quot;, ., &quot;)&quot;)
## [1] &quot;c(&apos;Sexo&apos;, &apos;Nascimento&apos;, &apos;Idade&apos;, &apos;Inclus&#xE3;o&apos;, &apos;Cor&apos;, &apos;Peso&apos;, &apos;Altura&apos;, &apos;cintura&apos;, &apos;IMC&apos;, &apos;Superf&#xED;cie corporal&apos;, &apos;Tabagismo&apos;, &apos;cg.tabag (cig/dia)&apos;, &apos;Alcool (dose/semana)&apos;, &apos;Drogas il&#xED;citas&apos;, &apos;Cafe&#xED;na/dia&apos;, &apos;Refrig/dia&apos;, &apos;Sedentario&apos;, &apos;ativ. Fisica&apos;)&quot;</code></pre>
<p>
Para padronizar os nomes (todos ao mesmo tempo), utilizei o código
abaixo. Se você não está familiarizado com as expressões regulares
(regex), temos um
<a href="http://material.curso-r.com/stringr/#express%C3%B5es-regulares">pequeno
tuturial no material do nosso curso</a>. Veja o que cada linha faz.
</p>
<ul>
<li>
<code>stringr::str\_trim()</code>: remove espaços do começo e do final.
Não tinha nenhum caso neste exemplo, mas é sempre bom garantir.
</li>
<li>
<code>stringr::str\_to\_lower()</code>: transforma letras maiúsculas em
minúsculas.
</li>
<li>
<code>abjutils::rm\_accent()</code>: remove os acentos das palavras.
</li>
<li>
<code>stringr::str\_replace\_all("\[/' '.()\]", "*")</code>: substitui
barras, espaços e parênteses por subtraço <code>*</code>.
</li>
<li>
<code>stringr::str\_replace\_all("*+", "*")</code>: substitui um ou mais
subtraços juntos por apenas um subtraço.
</li>
<li>
<code>stringr::str\_replace("\_$&quot;, &quot;&quot;)&lt;/code&gt;: remove os subtra&\#xE7;os no final dos nomes.&lt;/li&gt; &lt;/ul&gt; &lt;pre class="r"&gt;&lt;code&gt;nomes &lt;- dados %&gt;% names %&gt;% stringr::str\_trim() %&gt;% stringr::str\_to\_lower() %&gt;% abjutils::rm\_accent() %&gt;% stringr::str\_replace\_all(&quot;\[/&apos; &apos;.()\]&quot;, &quot;\_&quot;) %&gt;% stringr::str\_replace\_all(&quot;\_+&quot;, &quot;\_&quot;) %&gt;% stringr::str\_replace(&quot;\_$",
"") nomes \#\# \[1\] "sexo" "nascimento" "idade" \#\# \[4\] "inclusao"
"cor" "peso" \#\# \[7\] "altura" "cintura" "imc" \#\# \[10\]
"superficie\_corporal" "tabagismo" "cg\_tabag\_cig\_dia" \#\# \[13\]
"alcool\_dose\_semana" "drogas\_ilicitas" "cafeina\_dia" \#\# \[16\]
"refrig\_dia" "sedentario" "ativ\_fisica"</code>
</pre>
<p>
Agora basta atribuir os nomes de volta aos dados.
</p>
<pre class="r"><code>names(dados) &lt;- nomes</code></pre>
<p>
Claro que o código utilizado funciona bem para esse exemplo. Se os nomes
tivessem outros problemas, precisaríamos acrescentar mais linhas
contendo outras mudanças. No entanto, essas alterações já resolvem a
maioria dos casos mais comuns e é bem fácil modificar o código para
lidar com outros problemas.
</p>
<p>
Dúvidas, críticas ou sugestões, deixe um comentário ou nos envie uma
mensagem. :)
</p>
</div>

