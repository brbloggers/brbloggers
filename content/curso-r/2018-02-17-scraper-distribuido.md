+++
title = "Web Scraper Distribuído"
date = "2018-02-17"
categories = ["curso-r"]
original_url = "http://curso-r.com/blog/2018/02/17/2018-02-17-scraper-distribuido/"
+++

<p class="text-muted text-uppercase mb-small text-right">
Por <a href="http://curso-r.com/author/caio">Caio</a> 17/02/2018
</p>
<p>
Caso você já tenha se aventurado no mundo do web scraping, é provável
que tenha se deparado com um grande problema: volume. Muitas vezes,
antes fazer uma análise, precisamos scrapear um número colossal de
páginas até que tenhamos dados o suficiente para a nossa tarefa, número
esse que chega a ser proibitivo a ponto de não conseguirmos fazer aquilo
que queremos.
</p>
<p>
Neste post vou explicar duas técnicas para aumentar em dezenas de vezes
a velocidade dos seus scrapers de forma que você nunca mais precise de
preocupar com a quantidade de dados necessária para uma análise.
</p>
<p>
Um scraper sequencial é qualquer scraper que baixe uma página por vez,
ou seja, que varra as páginas em sequência baixando uma a uma. Como
veremos na seção a seguir isso não é muito eficiente, mas é mesmo assim
o que a maioria de nós faz.
</p>
<p>
<strong>Nota:</strong> Nos exemplos que darei daqui em diante estarei
baixando uma lista de 1441 artigos da Wikipédia obtida com o pacote
<code>WikipediR</code>. Se você quiser reproduzir os meus achados,
disponibilizei um arquivo com o código completo em um
<a href="https://gist.github.com/ctlente/84f230a88cae01537ac5ca4eff091221">Gist</a>
</p>
<p>
Veja mais ou menos como funcionaria para baixar um link da Wikipédia por
vez:
</p>
<pre class="r"><code># Fun&#xE7;&#xE3;o para baixar uma p&#xE1;gina da Wikip&#xE9;dia
download_wiki &lt;- function(url, path) { # Converter um URL em um nome de arquivo file &lt;- url %&gt;% utils::URLdecode() %&gt;% stringr::str_extract(&quot;(?&lt;=/)[^/]+$&quot;) %&gt;% stringr::str_replace_all(&quot;[:punct:]&quot;, &quot;&quot;) %&gt;% stringr::str_to_lower() %&gt;% stringr::str_c(normalizePath(path), &quot;/&quot;, ., &quot;.html&quot;) # Salvar a p&#xE1;gina no disco httr::GET(url, httr::write_disk(file, TRUE)) return(file)
} # Baixar arquivos sequencialmente
files &lt;- purrr::map_chr(links, download_wiki, &quot;~/Desktop/Wiki&quot;)</code></pre>
<p>
Nada muito complexo até aí. Com a <code>purrr::map\_chr()</code> itero
com facilidade nos links e os baixo sequencialmente (se você quiser
saber mais sobre a função <code>map()</code> veja
<a href="http://ctlente.com/pt/purrr-magic/">este post</a>). O código
acima demorou mais ou menos 5 minutos para executar na minha máquina.
</p>

<p>
Uma das formas mais simples de aumentar a eficiência de um web scraper é
através de paralelização. Um fato que nem todos sabem é que praticamente
qualquer scraper passa a maior parte do tempo esperando respostas do
servidor; seja para carregar uma nova página ou seja para baixar a
página em questão, ficar esperando é o que o seu scraper provavelmente
mais faz.
</p>
<p>
Isso quer dizer que seu computador poderia ter, em qualquer dado
momento, múltiplos scrapers rodando simultaneamente sem perder
eficiência! Enquanto o processador está salvando no disco os resultados
de um scraper, é perfeitamente possível ter muitos outros ativos e
esperando uma resposta do servidor.
</p>
<p>
No exemplo de código abaixo uso uma função muito simples para
paralelizar a execução do scraper. <code>parallel::mcmapply()</code>
(<em>multicore mapply()</em>) é análoga a <code>map()</code>, com a
diferença de que ela instancia as chamadas para a função
<code>download\_wiki()</code> em múltiplos threads de execução, tirando
vantagem do fato de que cada instância fica parada a maior parte do
tempo.
</p>
<pre class="r"><code># Criar uma vers&#xE3;o empacotada de download_wiki()
download_wiki_ &lt;- purrr::partial( download_wiki, path = &quot;~/Desktop/Wiki&quot;, .first = FALSE) # Baixar arquivos em paralelo
files &lt;- parallel::mcmapply( download_wiki_, links, SIMPLIFY = TRUE, mc.cores = 4)</code></pre>
<p>
No código acima, crio uma versão pré-preenchida de
<code>download\_wiki()</code> para não precisar lidar com argumentos
constantes na chamada para <code>parallel::mcmapply()</code>, mas depois
disso a única coisa que preciso fazer é especificar o número de cores
disponíveis no meu computador para que o pacote <code>parallel</code>
faça a sua magia. Desta forma, com uma chamada marginalmente mais
complexa, consegui baixar os mesmos arquivos em meros 1.2 minutos.
</p>

<p>
Para o nosso <em>grand finale</em> temos um pequeno salto de
dificuldade. Agora que somos capazes de usar todo o potencial do nosso
computador, a única forma de fazer scraping mais rápido é usando
<strong>mais</strong> computadores.
</p>
<p>
Isso parece loucura, mas usando máquinas virtuais da
<a href="https://aws.amazon.com/pt/ec2/">Amazon</a> ou da
<a href="https://cloud.google.com/compute/">Google</a> essa é na verdade
uma tarefa bastante simples! Podemos criar algumas instâncias virtuais e
enviar os links para que elas os baixem, distribuindo o download entre
várias máquinas.
</p>
<img src="http://curso-r.com/blog/2018-02-17-scraper-distribuido/scheme.png">

<p>
Para permitir que uma máquina virtual receba o comando de download,
criei um pequeno servidor HTTP em cada uma, assim elas ficarão esperando
por uma chamada POST contendo os URLs a serem baixados.
</p>
<pre class="python"><code># Trecho do c&#xF3;digo em python do servidor que lida com POSTs
def do_POST(self): content_length = int(self.headers[&apos;Content-Length&apos;]) post_data = self.rfile.read(content_length) call([&quot;Rscript&quot;, &quot;~/script.R&quot;, post_data])</code></pre>
<p>
Como pode-se ver no código acima, a única coisa que o servidor faz é
coletar os dados enviados pelo post e redirecioná-los para o script
<code>script.R</code>. Lá o R coleta os links vindos de
<code>post\_data</code> e os baixa (usando, é claro,
<code>parallel::mcmapply</code>).
</p>
<pre class="r"><code>#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE) # Tratar o pacote de dados enviado no POST
links &lt;- stringr::str_split(args[1], &quot; &quot;)[[1]]</code></pre>
<p>
Acima temos a única diferença no código em R (que agora se encontra nas
máquinas virtuais): o tratamento necessário em <code>script.R</code> dos
dados trazidos pela chamada POST.
</p>
<p>
O último passo é, em nossa máquina local, quebrar a lista de links em um
pacote para cada máquina serva; assim que as máquinas receberem esses
links via HTTP elas começarão, distribuidamente, a baixá-los em
paralelo.
</p>
<pre class="r"><code># Quebrar os links de acordo com o n&#xFA;mero de servos
num_workers &lt;- 3
links_split &lt;- links %&gt;% split(., ceiling(seq_along(.)/(length(.)/num_workers))) %&gt;% purrr::map(stringr::str_c, collapse = &quot; &quot;) # Dados do endpoint
workers &lt;- &quot;localhost&quot; # AQUI V&#xC3;O OS IPS DOS SERVOS
endpoints &lt;- stringr::str_c(&quot;http://&quot;, workers, &quot;:8000&quot;) # Chamar todos os servos mas n&#xE3;o esperar por eles
for (i in seq_len(num_workers)) { command &lt;- paste0(&quot;curl -d &apos;&quot;, links_split[[i]], &quot;&apos; &quot;, endpoints[i]) system(command, wait = FALSE)
}</code></pre>
<p>
Usando 3 máquinas virtuais de 4 cores cada no Google Cloud Platform, o
download das 1400 páginas demorou meros 34 segundos. Isso é uma melhora
de aproximadamente 10 vezes na performance em relação à execução
sequencial!
</p>

<p>
Como vimos nos exemplos acima, scrapers são por padrão processos lentos
e ineficientes. Usando uma arquitetura razoavelmente simples distribuída
e paralela podemos aumentar em até uma ordem de grandeza a eficiência de
um scraper sem nem pensar sobre o seu código! Na prática, podemos
aumentar e diminuir o quanto quisermos o número de servos ou de cores em
cada servo, permitindo que qualquer scraper possa virar uma máquina
incrível de coleta de dados.
</p>
<p>
Caso você tenha se interessado pelo conteúdo abordado nesse post, eu e o
pessoal da <a href="http://curso-r.com/">Curso-R</a> vamos dar no dia
10/03/2018 um workshop em São Paulos sobre
<a href="http://workshop.curso-r.com/web-scraping/">web scraping com
R</a>. Lá você vai ter a oportunidade de aprender, do zero, como fazer
bons web scrapers em R além de muitas dicas como a desse post para
tornar seus scrapers ainda melhores.
</p>

