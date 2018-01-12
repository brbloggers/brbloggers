+++
title = "5 dicas para aprender R"
date = "2017-09-11 17:13:53"
categories = ["IBPAD"]
original_url = "https://www.ibpad.com.br/blog/5-dicas-para-aprender-r/"
+++

<p>
Eu estou usando R de uma forma ou outra desde 2012. Comecei antes do
‘Tidyverse’ e o pipe do margrittr, o que é chamado o ‘novo
<em>workflow</em> do R’, ou seja, hoje aprender R é bem mais fácil!
Também não tive a quantidade de recursos que tem hoje em dia — muitos
blogs, livros, cursos on-line e presenciais. Bem, enquanto eu posso
dizer que demorei mais do que eu demoraria hoje, eu ainda aprendi umas
coisinhas. Neste post, compartilho umas dicas para aprender R rápido e
bem.
</p>
<h5>
1 – Copie exemplos
</h5>
<p>
Existem <em>muitos</em> exemplos de análises no R na internet e em
livros. Eu acho que um dos melhores jeitos de começar a aprender R é
simplesmente copiar um exemplo que você achou interessante (para
começar, o melhor é escolher um que tem código simples). Daí, quando
você recria o exemplo no seu computador, pode começar a mudar umas
coisinhas. Eu vou dar um exemplo, no qual eu crio uma <em>dataframe</em>
simples. Esta base tem os nomes dos países da América do Sul, e uma
escala imaginária do quão bom é o churrasco em cada país (inventei estes
números, desculpe, Bolívia!). Eu carrego cada pacote que vou usar,
inclusive a versão em desenvolvimento do pacote<code>ggplot2</code>, que
tem uma função (<code>geom\_sf()</code>) que eu quero. A minha dica é o
seguinte: faz tudo isso, e depois muda para um outro lugar, Europa, por
exemplo. Depois, muda os dados um pouco. Talvez use outros dados de uma
base externa — votos ou algo assim. Você irá enfrentar novos desafios
quando você muda o código, e esse é um ótimo jeito de aprender como usar
R (a frustração, nesse caso, é vantajosa!).
</p>
<span class="crayon-title"></span>

<textarea wrap="soft" class="crayon-plain print-no" data-settings="dblclick" readonly style="-moz-tab-size:4; -o-tab-size:4; -webkit-tab-size:4; tab-size:4; font-size: 12px !important; line-height: 15px !important;">
library(dplyr) SA % rename(country = sovereignt)

library(devtools) install\_github("tidyverse/ggplot2")

library(sf) SA % st\_as\_sf()

library(ggplot2) ggplot() + geom\_sf(data = SA, aes(fill = churrasco)) +
scale\_fill\_continuous(low = "\#F7E9C8", high = "\#612419")
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

10

11

12

13

14

</td>
<td class="crayon-code">
<span class="crayon-e">library</span><span
class="crayon-sy">(</span><span class="crayon-v">dplyr</span><span
class="crayon-sy">)</span>

<span class="crayon-v">SA</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-h"> </span>

<span class="crayon-h"> </span><span class="crayon-e">rename</span><span
class="crayon-sy">(</span><span class="crayon-v">country</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-v">sovereignt</span><span
class="crayon-sy">)</span>

 

<span class="crayon-e">library</span><span
class="crayon-sy">(</span><span class="crayon-v">devtools</span><span
class="crayon-sy">)</span>

<span class="crayon-e">install\_github</span><span
class="crayon-sy">(</span><span
class="crayon-s">"tidyverse/ggplot2"</span><span
class="crayon-sy">)</span>

 

<span class="crayon-e">library</span><span
class="crayon-sy">(</span><span class="crayon-v">sf</span><span
class="crayon-sy">)</span>

<span class="crayon-v">SA</span><span class="crayon-h"> </span><span
class="crayon-o">%</span><span class="crayon-h"> </span><span
class="crayon-e">st\_as\_sf</span><span class="crayon-sy">(</span><span
class="crayon-sy">)</span>

 

<span class="crayon-e">library</span><span
class="crayon-sy">(</span><span class="crayon-v">ggplot2</span><span
class="crayon-sy">)</span>

<span class="crayon-e">ggplot</span><span
class="crayon-sy">(</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">+</span>

<span class="crayon-h"> </span><span
class="crayon-e">geom\_sf</span><span class="crayon-sy">(</span><span
class="crayon-v">data</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-v">SA</span><span class="crayon-sy">,</span><span
class="crayon-h"> </span><span class="crayon-e">aes</span><span
class="crayon-sy">(</span><span class="crayon-v">fill</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-v">churrasco</span><span
class="crayon-sy">)</span><span class="crayon-sy">)</span><span
class="crayon-h"> </span><span class="crayon-o">+</span>

<span class="crayon-h"> </span><span
class="crayon-e">scale\_fill\_continuous</span><span
class="crayon-sy">(</span><span class="crayon-v">low</span><span
class="crayon-h"> </span><span class="crayon-o">=</span><span
class="crayon-h"> </span><span class="crayon-s">"\#F7E9C8"</span><span
class="crayon-sy">,</span><span class="crayon-h"> </span><span
class="crayon-v">high</span><span class="crayon-h"> </span><span
class="crayon-o">=</span><span class="crayon-h"> </span><span
class="crayon-s">"\#612419"</span><span class="crayon-sy">)</span>

</td>
</tr>
</table>

<p>
</p>

<figure class="wpb_wrapper vc_figure">
<img width="490" height="458" src="https://www.ibpad.com.br/wp-content/uploads/2017/09/5_dicas_para-_aprender_R_grafico-1.png" class="vc_single_image-img attachment-full" alt="" srcset="https://www.ibpad.com.br/wp-content/uploads/2017/09/5_dicas_para-_aprender_R_grafico-1.png 490w, https://www.ibpad.com.br/wp-content/uploads/2017/09/5_dicas_para-_aprender_R_grafico-1-260x243.png 260w, https://www.ibpad.com.br/wp-content/uploads/2017/09/5_dicas_para-_aprender_R_grafico-1-100x93.png 100w" sizes="(max-width: 490px) 100vw, 490px">

</figure>

<h5>
2 – Faça um blog e compartilhe seu trabalho
</h5>
<p>
É impressionante quanto você pode aprender ao fazer um blog. Além
do fato de você ter que produzir algo de qualidade para mostrar para o
resto do mundo, receberá <em>feedback</em> da comunidade do R. Os
comentários podem conter dicas, elogios ou críticas, e também é uma
ótima oportunidade de conhecer pessoas com interesses semelhantes. Não
vai demorar muito até alguém entrar em contato para procurar a sua ajuda
com código do R!
</p>
<p>
Um jeito fácil para criar um blog usando R é utilizar o
pacote <a href="https://github.com/rstudio/blogdown">blogdown</a> e o
website <a href="https://www.netlify.com/">netlify</a>. É o que eu faço
com <a href="http://robertmylesmcdonnell.netlify.com/">meu blog</a>, é
simples e rápido, recomendo. O fato de mostrar o seu trabalho e código
para o mundo vai melhorar muito o seu conhecimento de R.
</p>
<h5>
3 – Use Stack Overflow
</h5>
<p>
<a href="https://stackoverflow.com/">Stack Overflow</a> é um recurso
fantástico para quem tem dúvidas sobre uma linguagem de programação. A
comunidade de R é mais simpática do que umas outras — se você pesquisa
antes para<br> ver se ninguém já teve a mesma dúvida que você, tem boas
chances de receber ajuda da comunidade.
</p>
<p>
<b>Resumindo:</b> Faz a conta, entra, procura ajuda e se não achar,faz
pergunta. Tem em <a href="https://pt.stackoverflow.com/">português</a>,
também.
</p>
<p>
<b>Dica:</b> Para procurar perguntas sobre R, basta incluir “R” ou
“\[R\]” na busca.
</p>
<h5>
4 – Faça uma análise de verdade
</h5>
<p>
Livros e blogs são cheios de análises e exemplos com R, mas não há
nada como fazer a sua própria análise, com algo que importa para você.
Essa dica é mais simples se você é estudante — procure fazer uma análise
importante no R. Se você usa Excel, SPSS ou algo semelhante, troca para
R e continua até você produzir o que é necessário. Você irá aprender
bastante! Se você não é<br> estudante, mas trabalha com dados, faça o
mesmo quando você tiver algo para fazer, aprende muito mesmo. Se for
algo que é importante — na faculdade, emprego etc. — vai te forçar
buscar confiança na sua análise e dominar o processo no R.
</p>
<h5>
5 – Faça um curso presencial
</h5>
<p>
Não há comparação em aprender pessoalmente com alguém que é perito
no assunto. Eu aprendi tanto de amigos e colegas que manjam no R,
e sinceramente, não sei se eu conheceria tanto de R hoje em dia se
não fosse por eles. No IBPAD, oferecemos
<a href="https://www.ibpad.com.br/produto/ciencia-de-dados-com-r-df/" target="_blank">cursos presenciais</a>. Eu
sou um dos professores, mas uma coisa é fato: quando você conversa
pessoalmente com alguém que tem conhecimento sobre o R, você pode
aprender em 10 minutos algo que demoraria horas só pesquisando. Teria
sido bom para mim em 2012!!
</p>
<p>
Demorei uns anos para conhecer R bem, mas eu acredito que isso não
tem que ser o caso hoje em dia, dado que temos tantos recursos!
Para qualquer você escolha, te desejo a melhor sorte!
</p>

<figure class="wpb_wrapper vc_figure">
<a href="https://www.ibpad.com.br/produto/ciencia-de-dados-com-r-df/" target="_blank" class="vc_single_image-wrapper   vc_box_border_grey"><img width="1112" height="1180" src="https://www.ibpad.com.br/wp-content/uploads/2016/11/CDR.jpg" class="vc_single_image-img attachment-full" alt="" srcset="https://www.ibpad.com.br/wp-content/uploads/2016/11/CDR.jpg 1112w, https://www.ibpad.com.br/wp-content/uploads/2016/11/CDR-260x276.jpg 260w, https://www.ibpad.com.br/wp-content/uploads/2016/11/CDR-768x815.jpg 768w, https://www.ibpad.com.br/wp-content/uploads/2016/11/CDR-965x1024.jpg 965w, https://www.ibpad.com.br/wp-content/uploads/2016/11/CDR-94x100.jpg 94w" sizes="(max-width: 1112px) 100vw, 1112px"></a>
</figure>

<p>
Se interessa em aprender mais sobre a programação e linguagem R na
prática? Conheça o curso presencial <strong>Ciência de Dados com
R</strong> que acontecerá no mês de novembro em
<a href="https://www.ibpad.com.br/produto/ciencia-de-dados-com-r-df/" target="_blank">Brasília</a>
e em
<a href="https://www.ibpad.com.br/produto/ciencia-de-dados-com-r-sp/" target="_blank">São
Paulo</a>. Este curso foi desenvolvido para que você aprenda a programar
e ter uma base sólida.
</p>

