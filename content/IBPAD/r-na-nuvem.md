+++
title = "R na Nuvem!"
date = "2017-04-28 01:48:04"
categories = ["IBPAD"]
original_url = "https://www.ibpad.com.br/blog/analise-de-dados/r-na-nuvem/"
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
<a href="https://cloudyr.github.io/">cloudyR</a>), ou usar uma Amazon
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
<img class="alignnone size-medium wp-image-4890" src="https://www.ibpad.com.br/wp-content/uploads/2017/03/louis-260x295.png" alt="" width="260" height="295" srcset="https://www.ibpad.com.br/wp-content/uploads/2017/03/louis-260x295.png 260w, https://www.ibpad.com.br/wp-content/uploads/2017/03/louis-88x100.png 88w, https://www.ibpad.com.br/wp-content/uploads/2017/03/louis-80x90.png 80w, https://www.ibpad.com.br/wp-content/uploads/2017/03/louis.png 505w" sizes="(max-width: 260px) 100vw, 260px">
</p>
<p>
Ao clicar, você vai acessar a uma serie de guias no site da AWS para
iniciar a sua máquina virtual com uma lista de opções.
</p>
<p>
<img class="alignnone size-medium wp-image-4893" src="https://www.ibpad.com.br/wp-content/uploads/2017/03/sec_group-260x24.png" alt="" width="260" height="24" srcset="https://www.ibpad.com.br/wp-content/uploads/2017/03/sec_group-260x24.png 260w, https://www.ibpad.com.br/wp-content/uploads/2017/03/sec_group-100x9.png 100w, https://www.ibpad.com.br/wp-content/uploads/2017/03/sec_group.png 671w" sizes="(max-width: 260px) 100vw, 260px">
</p>
<p>
Nessa lista, você pode escolher o tipo de instância — pode escolher uma
máquina de memória maior etc. Umas são pagas, e outras são de graça. Uma
opção que é importante é a segurança (‘Security Groups’). Aqui, temos
que criar um novo grupo de segurança para usar RStudio diretamente
do<br> browser.
</p>
<p>
<img class="alignnone size-medium wp-image-4894" src="https://www.ibpad.com.br/wp-content/uploads/2017/03/tcp-260x54.png" alt="" width="260" height="54" srcset="https://www.ibpad.com.br/wp-content/uploads/2017/03/tcp-260x54.png 260w, https://www.ibpad.com.br/wp-content/uploads/2017/03/tcp-768x159.png 768w, https://www.ibpad.com.br/wp-content/uploads/2017/03/tcp-1024x212.png 1024w, https://www.ibpad.com.br/wp-content/uploads/2017/03/tcp-100x21.png 100w, https://www.ibpad.com.br/wp-content/uploads/2017/03/tcp.png 1253w" sizes="(max-width: 260px) 100vw, 260px">
</p>
<p>
Você pode chamar o grupo ‘Rstudio’. Da lista drop-down, selecione
‘Create Custom TCP Rule’. Põe 22 no Port Range, ou algo que inclua 22,
como 0-80. Depois pode clicar em ‘Launch’.
</p>
<p>
<img class="alignnone size-medium wp-image-4892" src="https://www.ibpad.com.br/wp-content/uploads/2017/03/keys-260x140.png" alt="" width="260" height="140" srcset="https://www.ibpad.com.br/wp-content/uploads/2017/03/keys-260x140.png 260w, https://www.ibpad.com.br/wp-content/uploads/2017/03/keys-100x54.png 100w, https://www.ibpad.com.br/wp-content/uploads/2017/03/keys.png 695w" sizes="(max-width: 260px) 100vw, 260px">
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
<img class="alignnone size-medium wp-image-4891" src="https://www.ibpad.com.br/wp-content/uploads/2017/03/Rstudio-260x136.png" alt="" width="260" height="136" srcset="https://www.ibpad.com.br/wp-content/uploads/2017/03/Rstudio-260x136.png 260w, https://www.ibpad.com.br/wp-content/uploads/2017/03/Rstudio-768x402.png 768w, https://www.ibpad.com.br/wp-content/uploads/2017/03/Rstudio-1024x536.png 1024w, https://www.ibpad.com.br/wp-content/uploads/2017/03/Rstudio-100x52.png 100w, https://www.ibpad.com.br/wp-content/uploads/2017/03/Rstudio.png 1262w" sizes="(max-width: 260px) 100vw, 260px">
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
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
library('RStudioAMI')

passwd()

Current password (rstudio if not changed yet):
==============================================

</textarea>

<table class="crayon-table">
<tr class="crayon-row">
<td class="crayon-nums " data-settings="show">
1

2

3

4

5

6

7

8

9

</td>
<td class="crayon-code">
 

 

<span class="crayon-e">library</span><span
class="crayon-sy">(</span><span
class="crayon-s">'RStudioAMI'</span><span class="crayon-sy">)</span>

 

<span class="crayon-e">passwd</span><span
class="crayon-sy">(</span><span class="crayon-sy">)</span>

 

<span class="crayon-p">\# Current password (rstudio if not changed yet):
</span>

 

 

</td>
</tr>
</table>

<p>
Agora você está pronto para fazer análise no R na nuvem!
</p>

