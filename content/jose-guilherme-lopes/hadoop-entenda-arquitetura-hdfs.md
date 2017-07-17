+++
title = "HDFS e MapReduce: entenda a arquitetura do Hadoop"
date = "2017-07-16 16:46:27"
categories = ["jose-guilherme-lopes"]
original_url = "http://joseguilhermelopes.com.br/hadoop-entenda-arquitetura-hdfs/"
+++

<p>
O <a href="http://hadoop.apache.org/">Apache Hadoop </a>trouxe uma
tecnologia inovadora que permitiu que Big Data se tornasse mais
acessível para pessoas e empresas.
</p>
<p>
O software open-source possui uma alta taxa de crescimento e estima-se
que o mercado do Hadoop
<a href="http://dataconomy.com/2014/05/hadoop-market-expected-to-grow-25x-by-2020/">cresça
25 vezes até 2020</a>.
</p>
<p>
Alguns exemplos de empresas que utilizam o Hadoop:
</p>
<ul>
<li>
Google
</li>
<li>
IBM
</li>
<li>
Microsoft
</li>
<li>
Amazon
</li>
<li>
Facebook
</li>
<li>
Twitter
</li>
<li>
Samsung
</li>
<li>
Apple
</li>
<li>
LinkedIn
</li>
<li>
Netflix
</li>
<li>
Twitter
</li>
<li>
eBay
</li>
</ul>
<p>
<img class="aligncenter wp-image-263 size-full" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/07/123.png%20608w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/07/123-300x174.png%20300w" alt="" width="608" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/07/123.png 608w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/07/123-300x174.png 300w">
</p>
<p>
Ainda que o projeto, instalação e manutenção de sistemas de
gerenciamento de dados em uma companhia seja da área de Engenharia de
Dados, entender a arquitetura e os conceitos básicos do Hadoop é
fundamental para um Cientista de Dados.
</p>
<h2>
<strong><br> O que é o Hadoop</strong>
</h2>
<p>
O Hadoop é um framework open-source que permite o armazenamento e
processamento de grandes quantidades de dados através de um
<strong>cluster</strong> de computadores.
</p>
<p>
É possível utilizar o Hadoop desde servidores simples de uma pequena
empresa até clusters com milhares de máquinas de uma grande corporação.
O sucesso do Hadoop se dá graças à sua <strong>tolerância sobre falhas,
baixo custo e a possibilidade de ser altamente escalável.</strong>
</p>
<p>
Baseado em linguagem de programação Java, o Hadoop é feito para que
várias máquinas compartilhem o mesmo trabalho, otimizando assim a
performance. Além disso, na sua forma de armazenamento, os dados são
replicados em diversas máquinas e é assegurado que o processamento
desses dados não será interrompido ou danificado caso uma ou várias
máquinas parem de funcionar.
</p>
<p>
O software vem sendo amplamente desenvolvido ao longo dos últimos anos e
novas tecnologias e ferramentas surgem a cada dia. Todas estas
ferramentas compõem o denominado<strong> Ecossistema Hadoop.</strong>
</p>
<p>
Neste artigo, irei focar nos dois principais e fundamentais componentes
do Hadoop: o <strong>HDFS</strong> e o <strong>MapReduce</strong>.
</p>
<h2>
<strong><br> HDFS</strong>
</h2>
<p>
HDFS é uma sigla para High Distributed File System e é a chave para
administrar Big Data e utilizar ferramentas analíticas de uma forma
escalável, com baixo custo e em alta velocidade.
</p>
<p>
O HDFS divide os dados em pequenos blocos, os replica e os distribui em
diferentes máquinas do cluster (cada máquina é denominada node),
permitindo assim o processamento paralelo desses dados.
</p>
<p>
A importância do HDFS se dá por sua:
</p>
<ul>
<li>
<strong>Portabilidade</strong>: funcionamento em diferentes hardwares e
sistemas operacionais; e
</li>
<li>
<strong>Escalabilidade</strong>: se o seu volume de dados está
aumentando, basta aumentar a quantidade de máquinas (nodes) e estender o
sistema do HDFS para estas novas máquinas.
</li>
<li>
<strong>Eficiência:</strong> como os dados estão divididos ao longo do
cluster, a leitura dos dados é feita muito rapidamente.
</li>
<li>
<strong>Segurança: </strong>com a replicação dos dados, não há o perigo
de perda de dados caso algum node deixe de funcionar.
</li>
</ul>
<p>
O cluster feito em HDFS possui dois tipos de nodes:
o <strong>Masternode</strong>, que gerencia o sistema, e
os <strong>Slavesnodes (ou Datanodes)</strong>, que armazenam os dados.
</p>
<p>
<img class="aligncenter wp-image-265 size-full" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/07/hdfs-hadoop.png%20793w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/07/hdfs-hadoop-300x282.png%20300w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/07/hdfs-hadoop-768x722.png%20768w" alt="" width="793" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/07/hdfs-hadoop.png 793w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/07/hdfs-hadoop-300x282.png 300w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/07/hdfs-hadoop-768x722.png 768w">
</p>
<p>
Desta forma, a função do HDFS é basicamente:
</p>
<ul>
<li>
Receber os dados;
</li>
<li>
Replicar os dados em blocos, mantendo a sua originalidade e segurança; e
</li>
<li>
Distribuir estes blocos ao longo dos slavesnodes;
</li>
</ul>
<p>
E assim, quando necessário realizar consulta dos dados, utiliza-se o
Masternode através de um processamento conhecido por MapReduce.
</p>
<h2>
<strong>MapReduce</strong>
</h2>
<p>
MapReduce é um modelo de programação projetado para processamento
paralelo e distribuído de grandes conjuntos de dados.
</p>
<p>
A distribuição dos dados é feita no
formato <strong>chave-valor</strong>, onde a <em>chave</em> é o
identificador do registro e <em>valor</em> é o seu conteúdo.
</p>
<p>
Como o próprio nome diz, as funções do MapReduce são:
</p>
<ul>
<li>
<strong>Mapeamento:</strong> os dados são separados em pares
(chave-valor) e assim distribuídos para os nodes e então processados;
</li>
<li>
<strong>Redução:</strong> os dados são agregados em conjuntos de dados
(datasets) menores.
</li>
</ul>
<p>
O processo do MapReduce se inicia com a requisição feita pelo usuário e
assim os dados são distribuídos pelos nodes do cluster no formato
chave-valor e divididos em fragmentos.
</p>
<p>
A etapa de redução processa cada fragmento e produz um output (saída de
dados) que são distribuídos pelos diferentes nodes do cluster.
</p>
<p>
Ao final do processo, um output é gravado.
</p>
<p>
<img class="aligncenter wp-image-266 size-full" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/07/mapreduce.jpg%20572w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/07/mapreduce-300x215.jpg%20300w" alt="" width="572" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/07/mapreduce.jpg 572w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/07/mapreduce-300x215.jpg 300w">
</p>
<p>
A imagem a seguir possui uma ótima representação do processo de
MapReduce:
</p>
<p>
<img class="aligncenter wp-image-267 size-full" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/07/Capture-1.png%20634w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/07/Capture-1-300x223.png%20300w" alt="" width="634" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/07/Capture-1.png 634w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/07/Capture-1-300x223.png 300w">
</p>
<p>
Desta forma, o HDFS e o MapReduce realizam as operações de armazenamento
e processamento de grandes conjuntos de dados através de um cluster:
</p>
<p>
<img class="aligncenter wp-image-268 size-full" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/07/pastedImage0.png%201438w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/07/pastedImage0-300x168.png%20300w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/07/pastedImage0-768x431.png%20768w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/07/pastedImage0-1024x575.png%201024w" alt="" width="1438" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/07/pastedImage0.png 1438w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/07/pastedImage0-300x168.png 300w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/07/pastedImage0-768x431.png 768w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/07/pastedImage0-1024x575.png 1024w">
</p>
<h2>
<strong><br> Ecossistema Hadoop</strong>
</h2>
<p>
Os componentes que formam a essência do Hadoop são o HDFS e o MapReduce.
Entretanto, há uma grande quantidade de ferramentas com diferentes
aplicações que em conjunto formam o ecossistema Hadoop.
</p>
<p>
Entre essas aplicações, destacam-se o <strong>Pig, o Hive e o
HBase.</strong>
</p>
<p>
<img class="aligncenter wp-image-269 size-full" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/07/87375_orig.jpg%20706w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/07/87375_orig-300x205.jpg%20300w" alt="" width="706" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/07/87375_orig.jpg 706w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/07/87375_orig-300x205.jpg 300w">
</p>
<h2>
<strong><br> Soluções Comerciais com Hadoop</strong>
</h2>
<p>
Existem diversas empresas que criam um sistema Hadoop como serviço e
assim o fornecem como uma distribuição comercial para quem deseja
implementar um sistema de Big Data.
</p>
<p>
Entre as vantagens, está o <strong>suporte</strong> oferecido por estas
empresas e o fato de que elas já vendem o<strong> pacote
completo</strong> com todas as ferramentas necessárias para os seus
objetivos.
</p>
<p>
Algumas das  empresas que fornecem uma distribuição comercial do Hadoop
são:
</p>
<p>
Em algumas das empresas citadas acima (como o da Amazon e da
HortonWorks) é possível encontrar links para teste do Hadoop. Se você
deseja conhecer mais à fundo sobre como <strong>operacionalizar um
sistema Hadoop,</strong> recomendo explorar estes sites.
</p>

