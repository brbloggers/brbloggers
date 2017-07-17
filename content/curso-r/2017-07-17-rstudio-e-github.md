+++
title = "RStudio e Github no dia a dia"
date = "2017-07-16 21:26:00"
categories = ["curso-r"]
original_url = "http://curso-r.com/blog/2017/07/17/2017-07-17-rstudio-e-github/"
+++

<p class="text-muted text-uppercase mb-small text-right">
Por <a href="http://curso-r.com/author/athos">Athos</a> 17/07/2017
</p>
<p>
Versionamento de código é uma ferramenta que veio para ficar. Não dá
para calcular o quanto de dor de cabeça, horas perdidas e frustrações
ela economiza e já economizou na história da humanidade.
</p>
<p>
Um dos programas que faz isso para a gente se chama
<a href="https://git-scm.com/">Git</a>. E não confundir com
<a href="https://github.com/">Github</a> (que vamos usar para
exemplificar mais para frente) que é um serviço que hospeda repositórios
“controlados” pelo Git.
</p>
<p>
Ao final do post você estará apto(a) a trabalhar com Github no seu
RStudio.
</p>
<p>
<strong>1) Deixa seu código atualizado e acessível de qualquer
computador.</strong>
</p>
<p>
Casa -&gt; Trabalho, Trabalho -&gt; Casa, por exemplo. Não há
necessidade de carregar o laptop pra lá e pra cá caso você tenha vários
Quartéis Generais.
</p>
<p>
<strong>2) Colaboradores conseguirão contribuir sempre a partir da
versão mais atualizada.</strong>
</p>
<p>
Seu colega não vai mais precisar te pedir aquele
versao\_final\_20170711.zip por email. Ele pode acessar o seu
repositório quando quiser, mexer no código e depois pedir autorização
para atualizar o projeto.
</p>
<p>
<strong>3) Recupere uma versão funcional em caso de
imprevistos.</strong>
</p>
<p>
Arrumar um bugzinho singelo, salvar o código, dormir, acordar no dia
seguinte, perceber que o programa não funciona mais. Uma história de
terror, porém corriqueira. O Github consegue recuperar o seu código a
partir de uma atualização anterior.
</p>
<p>
<strong>4) Seu projeto no ar.</strong>
</p>
<p>
Github é, além de tudo, uma rede social e é prática comum pessoas
acessarem Githubs de projetos alheios para consumí-los. Além disso te
fornece uma página em branco para você documentar e deixar seu trabalho
para a posteridade. Existem pacotes de R que nem estão no CRAN, mas já
estão no Github! A função <code>devtools::install\_github()</code>
existe para isso.
</p>

<p>
Você precisa ter instalado na sua máquina…
</p>
<ul>
<li>
<a href="https://cran.r-project.org/">R</a>/<a href="https://www.rstudio.com/products/rstudio/download/">RStudio</a>
(versões recentes para que tudo funcione direitinho)
</li>
<li>
<a href="https://git-scm.com/download/">Git</a>
</li>
<li>
Uma conta no <a href="https://github.com/">Github</a>
</li>
</ul>

<p>
A vida com Github + RStudio segue a seguinte rotina (escreva esse fluxo
num pedaço de papel e guarde na sua carteira):
</p>
<p>
<img src="http://curso-r.com/blog/2017/07/17/2017-07-17-rstudio-e-github/2017-07-17-rstudio-e-github/fluxo_github_rstudio.png" width="588">
</p>
<p>
Vá à sua conta do Github e crie um repositório com o nome do seu
projeto.
</p>
<p>
<img src="http://curso-r.com/blog/2017/07/17/2017-07-17-rstudio-e-github/2017-07-17-rstudio-e-github/passo_1_criar_repo.gif">
</p>
<p>
No exemplo acima eu poderia acessar o conteúdo do meu projeto no link
<code><https://github.com/athospd/projecao_de_precos></code>. Mas de
modo geral, você acessaria o seu projeto no link
<code><https://github.com/%3Cnome-do-usuario%3E/%3Cnome-do-projeto%3E></code>.
</p>
<p>
Boas práticas:
</p>
<ul>
<li>
<p>
Nomes sem espaço e sem caracteres estranhos. Deixe o nome bem simples!
</p>
<ul>
<li>
RUIM: <code>projeção de preços</code>
</li>
<li>
BOM: <code>projecao\_de\_precos</code>
</li>
</ul>
</li>
<li>
Coloque uma descrição sucinta e direta sobre o seu projeto. Um link para
um site com maiores detalhes também pode colocar aí.
</li>
<li>
<p>
Crie um README.md. Logo mais volto a tocar nesse assunto, mas no momento
da criação do seu repositório, já deixe um engatilhado!
</p>
</li>
</ul>
<p>
OBS: Incluir uma licença open-source é opcional, mas é fácil colocar,
deixa claro que as outras pessoas podem usar e deixa seu projeto
parecendo profissa rs.
</p>

<p>
Agora precisamos criar um .Rproj que esteja atrelado ao seu repositório
no Github. Por sorte, o RStudio já pensou em tudo e fez disso uma tarefa
fácil.
</p>
<p>
<img src="http://curso-r.com/blog/2017/07/17/2017-07-17-rstudio-e-github/2017-07-17-rstudio-e-github/passo_2_criacao_do_rproj_pt2.gif">
</p>
<p>
O caminho é:
</p>
<blockquote>
<p>
New Project &gt; Version Control &gt; Git &gt; Copia e cola URL do
repositório &gt; Create Project
</p>
</blockquote>
<p>
Ao final do processo você terá todos os arquivos do prjeto no seu
computador local.
</p>

<p>
Dar ‘commit’ é o que se faz quando você resolve aceitar as mudanças que
você fez no seu código/projeto.
</p>
<p>
Vamos montar uma história simulando duas mudanças no código, resultando
em dois commits.
</p>
<p>
<strong>Mudança 1</strong> Implementei a função <code>soma</code> e
depois dei commit porque achei que já estava muito boa.
</p>
<p>
<img src="http://curso-r.com/blog/2017/07/17/2017-07-17-rstudio-e-github/2017-07-17-rstudio-e-github/passo_3_commit_1.gif">
</p>
<p>
<strong>Mudança 2</strong> Implementei a função <code>subtrai</code> e
apesar de ter estar ainda com muitos bugs eu resolvi commitar porque
precisava ir embora do Trabalho. Chegando chegando em casa eu arrumo.
</p>
<p>
<img src="http://curso-r.com/blog/2017/07/17/2017-07-17-rstudio-e-github/2017-07-17-rstudio-e-github/passo_3_commit_2.gif">
</p>
<p>
Agora tem dois commits prontos para serem guardados no nosso repositório
central do Github. Lembre-se que é no Github que todos os colaboradores
vão continuar o projeto. Hora do PUSH!
</p>

<p>
Suponha que entre o trajeto do meu trabalho para a minha casa meu colega
tenha aprimorado a função soma.
</p>
<p>
Para eu continuar da onde ele parou eu devo dar um
<strong>PULL</strong>, ou seja, puxar pra minha máquina o código que
está lá no Github.
</p>
<p>
<img src="http://curso-r.com/blog/2017/07/17/2017-07-17-rstudio-e-github/2017-07-17-rstudio-e-github/passo_5_pull.gif">
</p>
<p>
Então, toda vez que abrir seu projeto, dê um PULL para voltar a ficar de
onde parou.
</p>

<p>
Issues são questões em aberto sobre seu projeto. Geralmente se descreve
um bug a ser consertado ou uma ideia a ser implementada no futuro. O
Github permite delegar essas tarefas a alguém e também classificá-las se
quiser.
</p>
<p>
<img src="http://curso-r.com/blog/2017/07/17/2017-07-17-rstudio-e-github/2017-07-17-rstudio-e-github/passo_extra_issue.gif">
</p>

<p>
O fluxo mostrado acima representa o dia a dia de um programador
solitário com eventuais parceiros colaboradores, mas o mundo da
programação colaborativa com Git e RStudio é vasto! Para você saber,
algumas coisas que não cobrimos aqui, mas que são bem comuns:
</p>
<ul>
<li>
Fork
</li>
<li>
Pull request
</li>
<li>
Branches
</li>
<li>
Gist
</li>
</ul>

<p>
Em relação a programas de versionamento, o RStudio também trabalha bem
com o <a href="https://subversion.apache.org/">SVN</a>.
</p>
<p>
Já serviços de hospedagem de repositórios, qualquer um funciona. O
<a href="https://bitbucket.org/">Bitbucket</a> é muito bom!
</p>

<ul>
<li>
Passo 1 - <strong>Repositório:</strong> Criar repositório do projeto no
Github
</li>
<li>
Passo 2 - <strong>.Rproj:</strong> Criação do Projeto no RStudio
</li>
<li>
Passo 3 - <strong>Commit:</strong> Editando e “Commitando” as mudanças
no código
</li>
<li>
Passo 4 - <strong>Push:</strong> Subindo os commits para o Github
</li>
<li>
Passo 5 - <strong>Pull:</strong> Baixando o estado atual do projeto
</li>
<li>
Passo extra - <strong>Issues:</strong> Documentando e delegando
problemas
</li>
</ul>
<p>
Essa é uma prática que facilita a vida do analista e que nós
incentivamos nos cursos que ministramos. Se houver dúvida o Curso-R.com
está sempre a disposição!
</p>

