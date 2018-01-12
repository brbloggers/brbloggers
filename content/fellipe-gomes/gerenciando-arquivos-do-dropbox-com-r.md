+++
title = "Gerenciando arquivos do Dropbox com R"
date = "2017-12-04"
categories = ["fellipe-gomes"]
original_url = "https://gomesfellipe.github.io/post/gerenciando-arquivos-do-dropbox-com-r/gerenciando-arquivos-do-dropbox-com-r/"
+++

<p id="main">
<article class="post">
<header>
</header>
<a href="https://gomesfellipe.github.io/post/gerenciando-arquivos-do-dropbox-com-r/gerenciando-arquivos-do-dropbox-com-r/" class="image featured">
<img src="https://gomesfellipe.github.io/img/2017/12/dropbox-R.png" alt="">
</a>
<p>
Armazenar arquivos na nuvem é uma prática muito comum nos dias de hoje.
O Dropbox é um dos muitos exemplos de repositórios baseados no conceito
de “computação em nuvem”, que oferece o serviço para compartilhar e
armazenar arquivos.
</p>
<p>
Não é novidade que a “computação em nuvem” tem impulsionado muitos
projetos, em especial projetos de Big Data ocorrendo em diversos setores
e existe um volume absurdo de dados sendo gerados.
</p>
<p>
Então essa habilidade de lidar com arquivos em nuvem parece bem razoável
para um cientista de dados. Mesmo que nossos repositórios não sejam
repositórios que se qualifiquem como “Big Data” é interessante como
algumas práticas podem ser úteis de uma maneira geral.
</p>
<p>
Já existem diversas opções de para extrair grandes volumes de dados que
estão disponíveis gratuitamente, como o projeto da
<a href="https://www.elastic.co/">elastic</a> com a
<a href="https://www.elastic.co/webinars/introduction-elk-stack">stack
ELK</a>.
</p>
<p>
Mas quero abordar aqui sobre o pacote
<a href="https://cran.r-project.org/web/packages/rdrop2/rdrop2.pdf">rdrop2</a>,
ele apresenta funções muito úteis para gerenciar os arquivos armazenados
na nuvem diretamente de dentro do RStudio.
</p>

<p>
Procurei pela internet alguma página que fornecesse as instruções do
pacote em português mas não encontrei. Então trago aqui algumas das
instruções e funções úteis que estão disponíveis no
<a href="https://github.com/karthik/rdrop2">manual do pacote</a>.
</p>
<p>
Primeiramente é necessário instalar o pacote cado ainda não o tenha
feito
</p>
<pre class="r"><code>install.packages(&quot;rdrop2&quot;) devtools::install_github(&quot;karthik/rdrop2&quot;) # ou a vers&#xE3;o de desenvolvimento</code></pre>
<p>
Feito isso já podemos carregar o pacote:
</p>
<pre class="r"><code>library(rdrop2)</code></pre>
<p>
Para que o dropbox libere o uso dos arquivos é necessária a
autenticação, que pode ser feita através deste comando:
</p>
<pre class="r"><code>drop_auth()</code></pre>
<p>
Isso irá iniciar o seu navegador e solicitar o acesso à sua conta
Dropbox, ai é só fazer o login (caso ainda não esteja logado) e em
seguida podemos retornar ao R.
</p>
<p>
Podemos salvar o token para o do uso local ou remoto:
</p>
<pre class="r"><code>token &lt;- drop_auth() saveRDS(token, file = &quot;token.rds&quot;)</code></pre>

<p>
Para acessar as pastas ou arquivos em seu dropbox, podemos utilizar a
função <code>drop\_dir()</code>, veja:
</p>
<pre class="r"><code>#Listagem do diret&#xF3;rio Dropbox diretorio=drop_dir() #Para ver os arquivos contidos no diretorio: diretorio$name #ou especificar um caminho drop_dir(&apos;RPubs/dplyr&apos;)$name #Listagem de diret&#xF3;rio de filtro por tipo de objeto (arquivo / pasta) drop_dir() %&gt;% filter(.tag == &quot;folder&quot;)</code></pre>

<p>
Podemos criar pastas no Dropbox de maneira muito conveniente sem ter de
de sair do RStudio de forma tão simples como utilizar um comando
<code>drop\_creat()</code>, veja:
</p>
<pre class="r"><code>#Nome da pasta que ser&#xE1; criada ser&#xE1; &quot;drop_test&quot; veja: drop_create(&apos;drop_test&apos;) #Para acessar a posi&#xE7;&#xE3;o de onde a pasta foi salva: which(drop_dir()$name==&apos;drop_test&apos;) #Acessando a pasta pela posi&#xE7;&#xE3;o: drop_dir()$name[86] #Tamb&#xE9;m podemos fornecer o caminho completo onde ele precisa ser criado: drop_create(&apos;drop_test/drop_test&apos;)</code></pre>

<p>
Da mesma maneira que criar pastas no Dropbox, para salvar basta utilizar
o comando <code>drop\_upload()</code>, veja:
</p>
<pre class="r"><code>#escrevendo um arquivo csv: write.csv(trees, &apos;trees.csv&apos;) #carregando o arquivo para a pasta raiz: drop_upload(&apos;trees.csv&apos;) # ou carregar para uma pasta espec&#xED;fica drop_upload(&apos;trees.csv&apos;, path = &quot;drop_test/drop_test&quot;)</code></pre>
<p>
Isso também pode ser fazer isso para qualquer outro tipo de arquivo e
arquivos grandes são suportados independentemente da sua memória.
</p>

<p>
Muito simples, veja:
</p>
<pre class="r"><code>#Baixe um arquivo drop_download(&apos;trees.csv&apos;) # ou adicionar caminho se o arquivo n&#xE3;o estiver na raiz drop_download(&quot;drop_test/drop_test/trees.csv&quot;) #Se desejar subescrever o arquivo ja existente: drop_download(&quot;drop_test/drop_test/trees.csv&quot;, overwrite = T)</code></pre>

<p>
Tão fácil quando apertar <code>DELETE</code>.
</p>
<pre class="r"><code>#Delete um arquivo: drop_delete(&apos;drop_test/drop_test/trees.csv&apos;)</code></pre>

<p>
As vezes desejamos apenar mover um arquivo, continua sendo bastante
simples:
</p>
<pre class="r"><code>#Criando um novo diret&#xF3;rio drop_create(&quot;drop_test/new_folder&quot;) #Mova um arquivo: drop_move(&quot;drop_test/drop_test/trees.csv&quot;, &quot;drop_test/new_folder/trees.csv&quot;)</code></pre>

<pre class="r"><code>#Criando um novo repositorio novamente: drop_create(&quot;drop_test/new_folder2&quot;) #Copiando o arquivo para l&#xE1;: drop_copy(&quot;drop_test/new_folder/trees.csv&quot;, &quot;drop_test/new_folder2/trees.csv&quot;)</code></pre>

<p>
Essa é extremamente útil para não ter que ficar baixando os arquivos
toda hora
</p>
<pre class="r"><code>#Escrevendo um arquivo csv write.csv(cars, file = &quot;cars.csv&quot;) #Enviando para o dropbox: drop_upload(&quot;cars.csv&quot;,&quot;drop_test/new_folder/&quot;)</code></pre>
<p>
Agora vamos ler isso de volta em uma sessão R com o comando
<code>drop\_read\_csv()</code>
</p>
<pre class="r"><code># Baixando o arquivo: new_cars &lt;- drop_read_csv(&quot;drop_test/new_folder/cars.csv&quot;)</code></pre>
<p>
Observe que há um download silencioso acontecendo com seu diretório
temporário.
</p>

<footer>
</footer>
</article>
<article class="post">
<a href="https://disqus.com/" class="dsq-brlink">comments powered by
</a>
</article>
</p>

