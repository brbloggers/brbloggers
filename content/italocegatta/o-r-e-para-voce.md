+++
title = "O R é para você"
date = "2016-04-26"
categories = ["italocegatta"]
original_url = "https://italocegatta.github.io/o-r-e-para-voce/"
+++

<p id="main" class="hasCover">
<article class="post">
<time> 26 Abril 2016 </time> <span>em</span>
<a class="category-link" href="https://italocegatta.github.io/categories/r">R</a>,
<a class="category-link" href="https://italocegatta.github.io/categories/data-science">Data
Science</a>

<p>
Se dedicar para aprender uma nova linguagem de programação não é uma
tarefa fácil. Principalmente para quem não tem um background de lógica
de programação. Não me lembro de me perguntar se valeria a pena ou não
estudar o R. Eu estava tão entusiasmado com toda aquela situação de
gráficos, tabelas e estatísticas que, quando vi, já tinha passado
algumas madrugadas programando.
</p>
<p>
Vou tentar focar esse texto em duas perguntas muito importantes para
quem está chegando agora na comunidade R: será que vale a pena aprender
a programar em R? Se sim, por onde posso começar?
</p>
<p>
O R é um software open-source mantido por um grupo de voluntários de
vários países, o R-core team. No site oficial do
<a href="https://www.r-project.org/">projeto</a> <span
class="citation">(R Core Team
<a href="https://italocegatta.github.io/o-r-e-para-voce/#ref-r_development_core_team_r:_2016">2016</a>)</span>
a primeira descrição sobre ele é a seguinte:
</p>
<blockquote>
<p>
O R é uma linguagem e ambiente para computação estatística e gráficos.
</p>
</blockquote>
<p>
Esse grupo mantem o sistema base que possibilita a interação com a
linguagem R para computação numérica, manipulação de dados, gráficos e
uma variedade de outras tarefas. No R, tudo o que acontece é o resultado
de uma função. Eu, você e tantos outros usuários podemos desenvolver
funções para facilitar a nossa vida, posteriormente organizá-las em
pacotes (ou <em>packages</em>) e depois disponibilizar para todo o mundo
<span class="citation">(Chambers
<a href="https://italocegatta.github.io/o-r-e-para-voce/#ref-chambers_software_2008">2008</a>)</span>.
</p>
<p>
O projeto do R teve início com Ross Ihaka e Robert Gentleman nos anos 90
a partir de uma implementação da linguagem S, que foi desenvolvida anos
antes por um grupo de pesquisadores liderados por John Chambers no Bell
Laboratories <span class="citation">(Chambers
<a href="https://italocegatta.github.io/o-r-e-para-voce/#ref-chambers_software_2008">2008</a>)</span>.
Desde então, o R tem crescido em um ritmo absurdo e pode ser considerado
o principal software livre para programação estatística e um dos mais
usados no mundo <span class="citation">(Revolution Analitics
<a href="https://italocegatta.github.io/o-r-e-para-voce/#ref-revolution_analitics_rs_2016">2016</a>;
Docsity
<a href="https://italocegatta.github.io/o-r-e-para-voce/#ref-docsity_statistical_2014">2014</a>)</span>.
Não vou listar todas potencialidades do R aqui neste post, em primeiro
lugar por que eu não domino todas elas e segundo por que com certeza o
post ficaria muito grande. Com o tempo vou apresentar nos posts algumas
aplicações pontuais do R com relação aos problemas que precisei
resolver. Mas já adianto, é comum dizermos que a pergunta certa sobre
uma tarefa no R não é <em>se podemos fazer</em>, mas sim <em>como</em>
podemos fazer.
</p>

<p>
O R tem uma curva de aprendizado um tanto íngreme, no começo é realmente
muito frustrante. Uma vez, me lembro de passar horas para conseguir
deixar a legenda com as cores que eu queria. Dá vontade de largar tudo e
fazer o gráfico no Excel. Mas se você é um pouco persistente no começo e
encara como um desafio, as coisas melhoram e essa etapa logo passa.
</p>
<p>
Minha formação é em Eng. Florestal, na grade curricular do meu curso não
há nada relacionado à lógica e conceitos de programação, ou seja, tive
que me motivar muito para aprender a programar, por que para mim
abstrair a lógica de um código ou rotina em R não foi (e nem é) fácil.
De fato, não é todo mundo que sabe programar e nem por isso se torna um
mal profissional, pois há vários softwares que possuem uma interface
gráfica totalmente adaptada para o usuário em forma de botões e cliques.
Mas com muita certeza, os profissionais que podem programar tem um
horizonte de possibilidades devido a flexibilidade de poder escrever seu
próprio programa de processamento.
</p>
<p>
Costumo dizer para os meus amigos que o grande trunfo de um programador
é a preguiça. Eu particularmente sou bem preguiçoso quando tenho de
fazer atividades repetitivas. A Figura
<a href="https://italocegatta.github.io/o-r-e-para-voce/#fig:geek-task">1</a>
ilustra bem uma situação que já ocorreu comigo muitas vezes, onde meus
amigos (e até minha namorada!) faziam processos repetitivos usando o
Excel, enquanto eu só conseguia pensar em como fazer aquilo de uma forma
rápida e eficiente no R.
</p>
<span id="fig:geek-task"></span>
<img src="http://i.imgur.com/e8otnTl.png" alt="Programadores versus n&#xE3;o-programadores quando fazem tarefas repetitivas [@iwaya_geeks_2012].">
<p class="caption">
Figura 1: Programadores versus não-programadores quando fazem tarefas
repetitivas <span class="citation">(Iwaya
<a href="https://italocegatta.github.io/o-r-e-para-voce/#ref-iwaya_geeks_2012">2012</a>)</span>.
</p>

<p>
Se você está na dúvida e é daqueles que preferem respostas rápidas, meu
professor de biometria pode te ajudar nesse sentido <span
class="citation">(Batista
<a href="https://italocegatta.github.io/o-r-e-para-voce/#ref-batista_curso_2015">2015</a>)</span>,
com estas afirmações:
</p>
<ul>
<li>
Você não quer aprender uma linguagem e realizar análises utilizando
comandos.
</li>
<li>
Você acredita que análise estatística é um simples protocolo para obter
alguns resultados numéricos.
</li>
<li>
Você acredita que para cada situação ou conjunto de dados existe <em>a
análise</em> estatística correta.
</li>
<li>
Você não sabe o que é análise estatística baseada em modelos e não está
nenhum pouco interessado em saber.
</li>
</ul>
<p>
Se você concorda com essas afirmações, pense bem antes de dedicar seu
tempo nesse caminho. Continue no Excel eu em outro programa amigável e
seja feliz. Mas se você já programa em alguma linguagem, ou tem uma
certa facilidade para isso, a situação é outra. Veja quais benefícios o
R tem em relação ao seu atual software e avalie se essa empreitada vale
a pena.
</p>
<p>
No meu caso, o SAS resolve a maioria dos problemas relacionados ao
processamento de dados e análise estatística de um florestal. Então, a
decisão nesse sentido tem que ser bem pontual e depende essencialmente
das tarefas que você realiza. Para mim, o R sai na frente por ser uma
linguagem livre e com um grupo de desenvolvedores muito grande, o que
possibilita a criação de diversas funcionalidades de vanguarda. Outro
trunfo do R é a integração com outros softwares e linguagens, que nos
possibilita criar aplicações web e em servidores.
</p>
<p>
Para fechar o tópico, se as suas tarefas estão relacionadas à análise e
processamento de dados e você sente que perde um tempo em atividades
repetitivas, talvez seja preciso rever o método. Programando você fará
as coisas de forma rapida, considere isso como um investimento a longo
prazo.
</p>

<p>
A parte boa de um software livre é que a comunidade que trabalha com ele
normalmente disponibiliza seus produtos e projetos gratuitamente. Se
você chegou nesse post por que está interessado no R mas não sabe nada
ou muito pouco, vou listar algumas dicas que me ajudaram e ainda me
ajudam quando preciso fazer algo no R.
</p>
<p>
Existe uma infinidade de sites e blogs dedicados a te ensinar a
programar em R. Mas a maioria espera que você já tenha uma mínima noção
de como a linguagem funciona. Com certeza você vai precisar acessar um
desses links para resolver algo com o R. Esses são alguns dos links que
eu tenho salvo na minha pasta de favoritos no navegador.
</p>
<ul>
<li>
<a href="https://www.rstudio.com/online-learning/">RStudio.</a>
</li>
<li>
<a href="http://www.r-tutor.com/%22%20target=%22_blank">R tutor.</a>
</li>
<li>
<a href="http://www.statmethods.net/">Quik R.</a>
</li>
<li>
<a href="http://rstatistics.net/">R Statistics.net.</a>
</li>
<li>
<a href="http://www.r-bloggers.com/">R-bloggers.</a>
</li>
<li>
<a href="http://stackoverflow.com/tags/r">Stackoverflow.</a>
</li>
</ul>

<p>
No começo, eu acabei juntando uma pasta com muitos livros e apostilas do
R. Uns foram úteis outros não. Meu conselho é que você escolha 3 livros
para estudar de verdade. Depois disso os livros vão servir apenas para
consultas de questões muito específicas. Segue algumas sugestões de
livros e apostilas disponíveis gratuitamente na web.
</p>

<p>
A interface gráfica do R é bem simples. Acostume-se, isso não mudar. Mas
felizmente muitas empresas desenvolveram ambientes de desenvolvimento
integrado para facilitar a vida do usuário. Nesse sentido, eu recomendo
fortemente utilizar o <a href="https://www.rstudio.com/">RStudio</a>
como ambiente de programação. O RStudio tem uma das equipes mais
atuantes da comunidade R e a cada dia que passa estão tornando a
programação mais eficiente e prazerosa.
</p>

</article>
<footer id="footer" class="main-content-wrap">
<span class="copyrights"> © 2017 Ítalo Cegatta. All Rights Reserved
</span>
</footer>
</p>

<img id="about-card-picture" src="http://i.imgur.com/9MOS3vs.png" alt="Foto do autor">
<p id="about-card-bio">
R, Floresta e Data Science
</p>
<p id="about-card-job">
<i class="fa fa-briefcase"></i> <br> Suzano Papel e celulose
</p>
<p id="about-card-location">
<i class="fa fa-map-marker"></i> <br> Itapetininga-SP
</p>

