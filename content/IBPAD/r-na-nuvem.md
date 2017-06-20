+++
title = "R na Nuvem!"
date = "2017-04-28 01:48:04"
categories = ["IBPAD"]
original_url = "http://www.ibpad.com.br/blog/r-na-nuvem/"
+++

<p>
Computação na “nuvem” é uma área muito animadora para quem está
trabalhando com dados. Pense na possibilidade de não precisar deixar o
computador ligado um tempão pra fazer aquela captura, ou de conseguir
bem mais memória só para rodar aquela análise? O céu é o limite.
</p>
<p>
Existem várias opções para trabalhar com o R em uma nuvem. Neste post
nós vamos focar na Amazon Web Services (AWS), um dos serviços mais
populares da área. Você pode ler os
<a href="https://aws.amazon.com/blogs/big-data/running-r-on-aws/">guias</a>
no website do AWS, ou usar pacotes do R mesmo (do projeto
<a href="http://cloudyr.github.io/">cloudyR</a>), ou usar uma Amazon
Machine Image (AMI), que cria uma máquina virtual no EC2, o <em>Amazon
Elastic Compute Cloud</em>. A terceira é uma ótima opção para R, dado
que <a href="http://www.louisaslett.com/">Louis Aslett</a> tem criado
uma AMI que já tem RStudio na máquina virtual.
</p>
<p>
O primeiro passo é criar conta na AWS. Se tiver conta, pode fazer o
login, e depois ir para o site do Louis que tem as AMIs do Rstudio:
<a href="http://www.louisaslett.com/RStudio_AMI/">http://www.louisaslett.com/RStudio\_AMI/</a>.
No lado direito, tem uma lista de regiões e tipos de instâncias. Eu usei
a de ‘US East, Virginia’; tentei a de São Paulo mas não funcionou.
</p>
<p>
<img data-attachment-id="4890" data-permalink="http://www.ibpad.com.br/blog/r-na-nuvem/attachment/louis/" data-orig-file="https://i0.wp.com/www.ibpad.com.br/wp-content/uploads/2017/03/louis.png?fit=505%2C573" data-orig-size="505,573" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;}" data-image-title="louis" data-image-description="" data-medium-file="https://i0.wp.com/www.ibpad.com.br/wp-content/uploads/2017/03/louis.png?fit=260%2C295" data-large-file="https://i0.wp.com/www.ibpad.com.br/wp-content/uploads/2017/03/louis.png?fit=505%2C573" class="alignnone size-medium wp-image-4890" src="https://i0.wp.com/www.ibpad.com.br/wp-content/uploads/2017/03/louis.png?resize=260%2C295" alt="" srcset="https://i0.wp.com/www.ibpad.com.br/wp-content/uploads/2017/03/louis.png?resize=260%2C295 260w, https://i0.wp.com/www.ibpad.com.br/wp-content/uploads/2017/03/louis.png?resize=88%2C100 88w, https://i0.wp.com/www.ibpad.com.br/wp-content/uploads/2017/03/louis.png?resize=80%2C90 80w, https://i0.wp.com/www.ibpad.com.br/wp-content/uploads/2017/03/louis.png?w=505 505w" sizes="(max-width: 260px) 100vw, 260px" data-recalc-dims="1" />
</p>
<p>
Ao clicar, você vai acessar a uma serie de guias no site da AWS para
iniciar a sua máquina virtual com uma lista de opções.
</p>
<p>
<img data-attachment-id="4893" data-permalink="http://www.ibpad.com.br/blog/r-na-nuvem/attachment/sec_group/" data-orig-file="https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/03/sec_group.png?fit=671%2C63" data-orig-size="671,63" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;}" data-image-title="sec_group" data-image-description="" data-medium-file="https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/03/sec_group.png?fit=260%2C24" data-large-file="https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/03/sec_group.png?fit=671%2C63" class="alignnone size-medium wp-image-4893" src="https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/03/sec_group.png?resize=260%2C24" alt="" srcset="https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/03/sec_group.png?resize=260%2C24 260w, https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/03/sec_group.png?resize=100%2C9 100w, https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/03/sec_group.png?w=671 671w" sizes="(max-width: 260px) 100vw, 260px" data-recalc-dims="1" />
</p>
<p>
Nessa lista, você pode escolher o tipo de instância — pode escolher uma
máquina de memória maior etc. Umas são pagas, e outras são de graça. Uma
opção que é importante é a segurança (‘Security Groups’). Aqui, temos
que criar um novo grupo de segurança para usar RStudio diretamente
do<br /> browser.
</p>
<p>
<img data-attachment-id="4894" data-permalink="http://www.ibpad.com.br/blog/r-na-nuvem/attachment/tcp/" data-orig-file="https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/03/tcp.png?fit=1253%2C259" data-orig-size="1253,259" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;}" data-image-title="tcp" data-image-description="" data-medium-file="https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/03/tcp.png?fit=260%2C54" data-large-file="https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/03/tcp.png?fit=900%2C186" class="alignnone size-medium wp-image-4894" src="https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/03/tcp.png?resize=260%2C54" alt="" srcset="https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/03/tcp.png?resize=260%2C54 260w, https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/03/tcp.png?resize=768%2C159 768w, https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/03/tcp.png?resize=1024%2C212 1024w, https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/03/tcp.png?resize=100%2C21 100w, https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/03/tcp.png?w=1253 1253w" sizes="(max-width: 260px) 100vw, 260px" data-recalc-dims="1" />
</p>
<p>
Você pode chamar o grupo ‘Rstudio’. Da lista drop-down, selecione
‘Create Custom TCP Rule’. Põe 22 no Port Range, ou algo que inclua 22,
como 0-80. Depois pode clicar em ‘Launch’.
</p>
<p>
<img data-attachment-id="4892" data-permalink="http://www.ibpad.com.br/blog/r-na-nuvem/attachment/keys/" data-orig-file="https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/03/keys.png?fit=695%2C373" data-orig-size="695,373" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;}" data-image-title="keys" data-image-description="" data-medium-file="https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/03/keys.png?fit=260%2C140" data-large-file="https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/03/keys.png?fit=695%2C373" class="alignnone size-medium wp-image-4892" src="https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/03/keys.png?resize=260%2C140" alt="" srcset="https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/03/keys.png?resize=260%2C140 260w, https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/03/keys.png?resize=100%2C54 100w, https://i1.wp.com/www.ibpad.com.br/wp-content/uploads/2017/03/keys.png?w=695 695w" sizes="(max-width: 260px) 100vw, 260px" data-recalc-dims="1" />
</p>
<p>
O AWS vai te perguntar sobre key pairs. Não é necessário para usar
RStudio no AWS, então pode clicar ‘Continue without keys’. Se você quer
utilizar o ssh para acessar o RStudio server depois, esta etapa vai ser
necessária. Agora nós podemos ir na página das instâncias. Pode ser que
demore um pouquinho para a sua instância começar, mas quando começar vai
ter um circulo verde ao lado da instância e a palavra ‘running’ ao lado.
Se você clica na instância, vai te mostrar as detalhes dela, onde pode
achar o endereço IP para fazer login no RStudio.
</p>
<p>
Copie o ‘IPv4 Public IP’ e cole no search bar no seu browser. Vai te
levar a uma página de Rstudio para fazer login: o Username é ‘rstudio’ e
a senha é ‘rstudio’ também (você pode mudar depois). Vai abrir o Rstudio
no seu browser, rodando dos servidores do Amazon!
</p>
<p>
<img data-attachment-id="4891" data-permalink="http://www.ibpad.com.br/blog/r-na-nuvem/attachment/rstudio/" data-orig-file="https://i0.wp.com/www.ibpad.com.br/wp-content/uploads/2017/03/Rstudio.png?fit=1262%2C660" data-orig-size="1262,660" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;}" data-image-title="Rstudio" data-image-description="" data-medium-file="https://i0.wp.com/www.ibpad.com.br/wp-content/uploads/2017/03/Rstudio.png?fit=260%2C136" data-large-file="https://i0.wp.com/www.ibpad.com.br/wp-content/uploads/2017/03/Rstudio.png?fit=900%2C471" class="alignnone size-medium wp-image-4891" src="https://i0.wp.com/www.ibpad.com.br/wp-content/uploads/2017/03/Rstudio.png?resize=260%2C136" alt="" srcset="https://i0.wp.com/www.ibpad.com.br/wp-content/uploads/2017/03/Rstudio.png?resize=260%2C136 260w, https://i0.wp.com/www.ibpad.com.br/wp-content/uploads/2017/03/Rstudio.png?resize=768%2C402 768w, https://i0.wp.com/www.ibpad.com.br/wp-content/uploads/2017/03/Rstudio.png?resize=1024%2C536 1024w, https://i0.wp.com/www.ibpad.com.br/wp-content/uploads/2017/03/Rstudio.png?resize=100%2C52 100w, https://i0.wp.com/www.ibpad.com.br/wp-content/uploads/2017/03/Rstudio.png?w=1262 1262w" sizes="(max-width: 260px) 100vw, 260px" data-recalc-dims="1" />
</p>
<p>
No <code>Welcome.R</code>, o script que vai abrir nessa página, tem umas
instruções para mudar senhas e tal. O Louis também tem feito um pacote
para R para cuidar dos detalhes para você e tem mais detalhes nesse
script (em inglês). É simples: carrega o pacote e usar a função
<code>passwd()</code>, que vai te pedir para a sua senha existente
(“rstudio”) e para uma nova. Daí clica no <code>Edit</code> no RStudio,
e <code>Clear Console</code> (ou <code>Cntrl + L</code>).
</p>
<pre class="crayon-plain-tag">library('RStudioAMI')

passwd()

# Current password (rstudio if not changed yet):</pre>
<p>
Agora você está pronto para fazer análise no R na nuvem!
</p>
<p>
O post
<a rel="nofollow" href="http://www.ibpad.com.br/blog/r-na-nuvem/">R na
Nuvem!</a> apareceu primeiro em
<a rel="nofollow" href="http://www.ibpad.com.br">IBPAD</a>.
</p>

