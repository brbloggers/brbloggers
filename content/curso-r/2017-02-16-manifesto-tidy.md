+++
title = "Manifesto tidy"
date = "2017-02-15 11:07:31"
categories = ["curso-r"]
+++

<p class="text-muted text-uppercase mb-small text-right">
Por <a href="http://curso-r.com/author/daniel">Daniel</a> 15/02/2017
</p>
<p>
O
<a href="https://cran.r-project.org/web/packages/tidyverse/vignettes/manifesto.html">manifesto
das ferramentas tidy</a> do Hadley Wickham é um dos documentos mais
importantes sobre R dos últimos tempos. Esse documento formaliza uma
série de princípios que norteiam o desenvolvimento do
<a href="http://tidyverse.org/"><code>tidyverse</code></a>.
</p>
<p>
O <a href="http://tidyverse.org/"><code>tidyverse</code></a>, também
chamado por muitos de <em>hadleyverse</em>, é um conjunto de pacotes
que, por compartilharem esses princípios do manifesto tidy, podem ser
utilizados naturalmente em conjunto. Pode-se dizer que existe o R antes
do <code>tidyverse</code> e o R depois do <code>tidyverse</code>. A
linguagem mudou muito, a comunidade abraçou fortemente o uso desses
princípios e tem muita gente criando pacotes para conversar uns com os
outros dessa forma. No entanto, usar a filosofia <em>tidy</em> não é a
única forma de fazer pacotes do R, existem muitos pacotes excelentes que
não utilizam essa filosofia. Como o próprio texto diz “O contrário de
<em>tidyverse</em> não é o <strong>messy</strong>verse, e sim muitos
outros universos de pacotes interconectados.”.
</p>
<p>
Os princípios fundamentais do <code>tidyverse</code> são:
</p>
<ol>
<li>
Reutilizar estruturas de dados existentes.
</li>
<li>
Organizar funções simples usando o <em>pipe</em>.
</li>
<li>
Aderir à programação funcional.
</li>
<li>
Projetado para ser usado por seres humanos.
</li>
</ol>
<p>
No
<a href="https://cran.r-project.org/web/packages/tidyverse/vignettes/manifesto.html">texto
do manifesto tidy</a> cada um dos lemas é descrito de forma detalhada.
Aqui, selecionei os aspectos que achei mais importante de cada um deles.
</p>
<h3>
Reutilizar estruturas de dados existentes
</h3>
<ul>
<li>
Quando possível, é melhor utilizar estruturas de dados comuns do que
criar uma estrutura específica para o seu pacote.
</li>
<li>
Geralmente, é melhor reutilizar uma estrutura existente mesmo que ela
não se encaixe perfeitamente.
</li>
</ul>
<h3>
Organizar funções simples usando o <em>pipe</em>
</h3>
<ul>
<li>
Faça com que suas funções sejam o mais simples possíveis. Uma função
deve poder ser descrita com apenas uma sentença.
</li>
<li>
A sua função deve fazer uma transformação no estilo
<em>copy-on-modify</em> ou ter um efeito colateral. Nunca os dois.
</li>
<li>
O nome das funções devem ser verbos. Exceto quando as funções do pacote
usam sempre o mesmo verbo. Ex: adicionar ou modificar.
</li>
</ul>
<h3>
Aderir à programação funcional
</h3>
<ul>
<li>
O R é uma linguagem de
<a href="https://pt.wikipedia.org/wiki/Programa%C3%A7%C3%A3o_funcional">programação
funcional</a>, não lute contra isso.
</li>
</ul>
<ul>
<li>
Desenvolva o seu pacote para ser usado por humanos. Foque em ter uma API
clara para que você escreva o código de maneira intuitiva e rápida.
Eficiência dos algoritmos é uma preocupação secundária, pois gastamos
mais tempo escrevendo o código do que executando.
</li>
</ul>
<p>
Esses princípios são bem gerais, mas ajudam bastante a tomar decisões
quando estamos escrevendo o nosso código. Para finalizar, clique
<a href="https://github.com/search?utf8=%E2%9C%93&amp;q=tidy+language%3Ar">aqui</a>
e veja uma busca no Github por “tidy” em repositórios de R. São mais de
2000 resultados quase todos seguindo essa filosofia e estendendo o
<em>universo arrumado</em>.
</p>

