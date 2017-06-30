+++
title = "Tomando Notas em uma Aula de Exatas"
date = "2017-06-13"
categories = ["mind-and-iron"]
original_url = "http://ctlente.com/pt/note-taking/"
+++

<p>
Meu maior problema na faculdade (fora passar nas matérias) sempre foi
anotar as aulas. Eu sou o tipo de pessoa que gosta anotar absolutamente
tudo que o(a) professor(a) fala para o caso de algum detalhe obscuro de
uma aula perdida ser cobrado na prova.
</p>
<p>
Em pouco tempo percebi que anotar tudo em papel era impraticável. Fora o
cansaço de copiar lousas intermináveis, muitos professores são
desorganizados demais para que seja possível anotar linearmente o que
está sendo dito em aula. Que atire a primeira pedra aquele aluno que
nunca desistiu de anotar uma aula ao perceber que o(a) professor(a)
havia cometido um erro duas lousas atrás.
</p>
<p>
A primeira coisa que todo aluno pensa nesses momentos de raiva é em
fazer suas anotações no computador (caso ele(a) o tenha). Por um segundo
essa pode parecer a solução perfeita, mas ela nem sempre funciona; se
você é um aluno de humanas pode até ser que um editor de texto comum
como Word ou Pages funcione para anotar as suas aulas, mas se você tiver
que anotar ao menos uma equação esses programas já se tornam uma solução
menos que ideal.
</p>
<p>
Como sou aluno de Ciência da Computação ainda tenho um problema a mais:
anotar código. Falando com meus amigos, chegamos à conclusão de que
anotar as nossas aulas em
<a href="https://pt.wikipedia.org/wiki/LaTeX">LaTeX</a> talvez fosse a
única saída. Dito isso, sugiro que o leitor tente anotar pelo menos uma
aula na vida em LaTeX para entender porque descarto essa ideia…
</p>
<p>
Dessa forma cheguei a três critérios que qualquer solução deveria
atender para ser considerada ótima:
</p>
<ul>
<li>
Praticidade (descartamos dessa forma anotar as aulas em papel)
</li>
<li>
Facilidade de anotar equações e código (descartamos editores de texto
comuns)
</li>
<li>
Velocidade na hora de escrever (descartamos LaTeX)
</li>
</ul>
<p>
Não ia ser fácil…
</p>

<p>
Depois de muito tempo procurando uma solução ideal, acabei a encontrando
debaixo do meu nariz. Para programar eu já usava há alguns anos um
editor de código chamado <a href="https://atom.io/">Atom</a>, mas o que
eu ainda não sabia é que esse editor é extremamente customizável,
permitindo que o usuário baixe plugins cuja função é extender a
funcionalidade do editor.
</p>
<p>
Um desses plugins se chama
<a href="https://atom.io/packages/markdown-preview-plus">Markdown
Preview Plus</a> (MMP) e ele foi a luz no fim do túnel que era o meu
caderno de anotações. Ele junta duas tecnologias opostas de forma que
temos o melhor dois dois mundos! Para texto e código ele nos permite
usar <a href="https://pt.wikipedia.org/wiki/Markdown">Markdown</a>,
enquanto para equações ele nos permite usar LaTeX (mas sem a parte de
formatação de texto, que tornava qualquer solução LaTeX-pura lenta e
ineficiente).
</p>
<p>
Ler essas duas palavras juntas na mesma frase pode ser intimidador, mas
acredite em mim quando digo que ela salvou minha vida. Não posso dizer
que não existe uma curva de aprendizado, porém a recompensa é muito
maior que os poucos dias que você perderá aprendendo Markdown ou LaTeX.
</p>

<p>
Para que tudo isso funcione, você precisa primeiro instalar o Atom.
Feito isso, navegue até o menu do editor e procure a aba denominada
<strong>Install</strong> e instale também o Markdown Preview Plus. O
passo final é ir até a aba <strong>Packages</strong>, procurar o MMP e,
em suas configurações, habilitar a opção <strong>Enable Math Rendering
By Default</strong>.
</p>
<p>
Crie um arquivo <code>.md</code> e pressione a combinação <code>ctrl +
shift + M</code> para ativar o <em>preview</em> do Markdown. Agora é só
escrever em Markdown e colocar qualquer código LaTeX entre dois cifrões
para renderizar qualquer fórmula matemática!
</p>
<p>
E em teoria isso é tudo 😊 Essa solução une a praticidade do computador,
as funcionalidades do LaTeX e a velocidade do Markdown de forma que eu
nunca imaginei que fosse possível. Mas para aqueles que não estão
familiarizados com Markdown ou LaTeX, ainda resta o desafio de
aprendê-los…
</p>

<p>
Para saber mais sobre Markdown, sugiro o tutorial criado pelo GitHub:
<a href="https://guides.github.com/features/mastering-markdown/">Mastering
Markdown</a>. Já LaTeX não precisa exatamente de um tutorial no nosso
caso, mas sim de uma cola:
<a href="https://en.wikibooks.org/wiki/LaTeX/Mathematics">LaTeX/Mathematics</a>.
</p>
<p>
Para fins ilustrativos, veja o texto escrito abaixo:
</p>
<pre><code># Mat&#xE9;ria Importante ## Aula de hoje Com Markdown podemos criar
- *Uma lista*
- `Com itens`
- **Em diversas**
- formata&#xE7;&#xF5;es Seja $X$ o n&#xFA;mero de compara&#xE7;&#xF5;es executadas na linha 4 da fun&#xE7;&#xE3;o
`particione()`. Observe que $X$ &#xE9; uma vari&#xE1;vel aleat&#xF3;ria.
Tome $X_{ab}$ a vari&#xE1;vel aleat&#xF3;ria bin&#xE1;ria com interpreta&#xE7;&#xE3;o
$X_{ab} = 1$ se e somente se $a$ e $b$ s&#xE3;o comparados na linha 4. Algo bem complicado (e sem sentido): $m = \begin{cases} m[i, j] = n + \sum_{k = 0}^{\lfloor \lg n \rfloor} 2^k = n + 2^{\lfloor \lg n \rfloor} - 1 &#x2264; n + 2.2^{\lg n} &amp; i = j \\ m[i, j] = min_{\ i &#x2264; k &#x2264; j-1}\{ m[i, k] + m[k+1, j] + p_{i-1} \ p_k \ p_j\} &amp; i \not = j
\end{cases}$</code></pre>
<p>
Esse é o seu resultado quando renderizado pelo MMP:
</p>

<p>
Se você quiser maximizar a velocidade com que você faz as anotações,
sugiro tirar vantagem de <em>snippets</em> do Atom. Os que eu uso estão
disponíveis em um
<a href="https://gist.github.com/ctlente/cfabebcc7555286f491aa7ce3ac700fe">Gist</a>.
</p>
<p>
Para exportar suas anotações como PDF, clique com o botão direito no
<em>preview</em> e selecione <strong>Save as HTML</strong>. Esse arquivo
pode ser aberto no seu navegador e assim ser salvo como PDF com
<code>cmd/ctrl + P</code>.
</p>

