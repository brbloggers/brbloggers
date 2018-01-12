+++
title = "Velozes e Furiosos com a função sapply e computação paralela"
date = "2017-03-05 03:00:00"
categories = ["r-python-e-redes"]
original_url = "http://neylsoncrepalde.github.io/2017-03-05-velozes-e-furiosos-funcao-sapply-computacao-paralela/"
+++

<article class="blog-post">
<p>
Quando iniciamos nossa caminhada na programação em R, é muito comum uma
expressão que mistura surpresa e indignação ao descobrir que um trabalho
de coleta de dados efetuado em 3 meses pode ser executado de forma
automatizada pelo R em poucos minutos! Essa proeza é executada
normalmente usando um loop <code class="highlighter-rouge">for</code>
que permite executar a mesma tarefa repetidas vezes.
</p>
<p>
Depois de algum tempo de uso e convivência com a comunidade, percebemos
que o loop <code class="highlighter-rouge">for</code> do R não possui um
desempenho muito bom. Está mais para um fusquinha. Uma Ferrari seria a
família de funções <code class="highlighter-rouge">apply</code>, aliás
uma das principais vantagens da linguagem R sobre outras linguagens, em
minha opinião. A maioria das funções da família
<code class="highlighter-rouge">apply</code> foi escrita em C e tem um
desempenho muito superior ao loop
<code class="highlighter-rouge">for</code>. Vamos efetuar uma rotina
básica de cálculos usando um loop for e uma função da família apply para
compará-los.
</p>
<p>
Digamos que você tem um banco de dados com um milhão de linhas
(razoavelmente grande, heim…) e quer executar algumas transformações em
uma das variáveis: multiplicar por 10 e tirar a raiz quadrada. Usando o
comando <code class="highlighter-rouge">system.time()</code> vamos
verificar quanto tempo (em segundos) a máquina gasta para executar esses
cálculos. Vale lembrar que estamos usando um notebook simples com
processador <strong>core i3</strong> e <strong>4 Gb de RAM</strong>.
</p>
<pre><code class="language-{r}">numeros &lt;- 1:1000000 system.time({ teste1 = c() for (x in numeros){ y = x*10 z = sqrt(y) teste1 = c(teste1, z) }
})
</code></pre>
<pre class="highlight"><code>## user system elapsed ## 5427.453 418.447 5846.278
</code></pre>

<p>
Hum… O tempo de processamento foi de aproximadamente 1h e 37 min (5846
segundos). Vamos ver agora o desempenho da máquina com a função sapply
(sapply é uma função da família apply que retorna vetores simples ao
invés de listas).
</p>
<pre><code class="language-{r}">system.time({ teste2 = sapply(numeros, function(x){ y = x*10 z = sqrt(y) return(z)} )
})
</code></pre>
<pre class="highlight"><code>## user system elapsed ## 3.113 0.026 3.139
</code></pre>

<p>
Wow!!! Conseguimos reduzir 1 hora e meia para 3 segundos!!! Estamos
super velozes!!!
</p>
<p>
Quando as instruções a serem executadas são mais complexas, esse tempo
de processamento pode ser ainda grande. Há outra otimização desenvolvida
pelos cientistas da computação muito útil: a computação paralela.
</p>
<p>
Por default, qualquer operação executada em R é feita de modo serial, ou
seja, os cálculos acontecem um de cada vez. Se esse processo será
repetido um milhão de vezes, para otimizá-lo podemos dividir os cálculos
em 4 partes e enviar uma delas para cada núcleo do processador para
serem executados simultaneamente. Isso pode reduzir drasticamente o
tempo de processamento.
</p>
<p>
Não vamos apresentar aqui um exemplo complexo mas simplesmente a
implementação do mesmo processo executado acima agora com computação
paralela (talvez num próximo post…). Para isso, carregaremos o pacote
<code class="highlighter-rouge">parallel</code> e usaremos uma função
muito parecida com a função sapply. Vamos ver como fica o tempo de
processamento aqui.
</p>
<pre><code class="language-{r}">library(parallel) # carrega o pacote no_cores = detectCores() # define o n&#xFA;mero de n&#xFA;cleos a serem usados
cl = makeCluster(no_cores) # faz os clusters # exporta para os cluster a vari&#xE1;vel a ser trabalhada
# sem esse comando os clusters n&#xE3;o reconhecem a vari&#xE1;vel direto do global env.
clusterExport(cl, &quot;numeros&quot;) # A&#xE7;&#xE3;o!
system.time({ teste3 = parSapply(cl, numeros, function(x){ y = x*10 z = sqrt(y) return(z)} )
}) stopCluster(cl) # interrompe os clusters
</code></pre>
<pre class="highlight"><code>## user system elapsed ## 1.456 0.050 2.735
</code></pre>

<p>
WOW!!! Os cálculos ficaram ainda mais rápidos!!! Agora estamos velozes e
furiosos!!!
</p>
<p>
Ao executar tarefas complexas, o paralelismo pode ser uma grande
ferramenta. Para um maior aprofundamento no tema, consulte
<a href="https://www.r-bloggers.com/how-to-go-parallel-in-r-basics-tips/">este
post</a>. Comentários são sempre bem vindos! Grande abraço!
</p>
</article>
<p class="blog-tags">
Tags: R, Apply, Sapply, Parallel, Parallel Computing
</p>

