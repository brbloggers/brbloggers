+++
title = "Como eu consegui descobrir a localização dos meus matches no Tinder (ou quase)"
date = "2017-06-05 18:00:00"
categories = ["lurodrigo"]
original_url = "https://lurodrigo.github.io/2017/06/tinder-localizacao"
+++

<p class="page__inner-wrap">
<header>
<p class="page__meta">
<i class="fa fa-clock-o"></i> 23 minutos de leitura
</p>
</header>
<section class="page__content">
<p>
Eu já havia percebido uma possível vulnerabilidade de segurança no
Tinder havia um tempo. Ele permite que você saiba as distâncias em que
outros usuários se encontram em relação a você. Embora pareçam
inofensivas, informações sobre distâncias, somadas a um pouco de
perspicácia, permitem descobrir a posição exata de qualquer pessoa. Para
isso, usa-se uma técnica chamada
<a href="https://en.wikipedia.org/wiki/Trilateration"><em>trilateração</em></a>.
Evidentemente, não fui o primeiro a pensar neste problema: a técnica é
usada no GPS, por exemplo, e também já foi empregada com precisamente a
mesma finalidade que a minha pela
<a href="http://blog.includesecurity.com/2014/02/how-i-was-able-to-track-location-of-any.html">Include
Security</a>.
</p>
<p>
De todo modo, precisava de um tema para o projeto da disciplina de
Cálculo Numérico este semestre e essa ideia parecia viável (dadas as
minhas limitações de tempo) e suficientemente divertida, e cá estamos.
Este artigo vai explicar como defini matematicamente o problema,
utilizei programação para implementar um protótipo e quais conclusões
obtive, além de uma visualização como a do header acima.
</p>
<h2 id="a-ideia">
A ideia
</h2>
<p>
A técnica é baseada em geometria elementar. Consideremos, inicialmente,
que a terra é perfeitamente plana. Imagine que um contato está a uma
distância de 5 quilômetros de você, que se encontra no ponto A. O
conjunto de possíveis localizações dele determina uma circunferência de
5km de raio. Agora você vai para uma segunda posição B e verifica
novamente a distância dita pelo aplicativo, que agora é de 7km. Se o
problema for bem posto, tipicamente a busca será reduzida para duas
possibilidades:
</p>
<p>
<img src="https://lurodrigo.github.io/images/01.png" alt="" class="full">
</p>
<p>
Movendo-se para uma terceira localização, basta comparar a distância
fornecida pelo aplicativo com a distância aos dois pontos que restaram,
e será possível eliminar o caso falso. Pronto, localização descoberta!
Claro, você deve ter algumas objeções agora:
</p>
<ol>
<li>
<strong>A distância fornecida pelo Tinder é arredondada, não é a
distância real.</strong> No aplicativo não, mas a
<a href="https://github.com/charliewolf/pynder"><em>Pynder</em></a>, API
pirata do Tinder para Python, permite pegar a distância com precisão
dupla. Se essa distância for a correta, estamos bem.
</li>
<li>
<strong>A premissa de que a pessoa não se move enquanto mudamos de
posição é muito forte!</strong> De fato, mas a verdade é que esse
deslocamento nunca será feito na prática. A API nos permite definir
nossa latitude e longitude de forma arbitrária, sem precisarmos ter nos
movido de fato.
</li>
<li>
<strong>A terra não é plana, Luiz</strong>. Claro, tanto que irei
modelar a Terra como uma esfera ao longo do texto. Apesar disso, em
muitos aspectos a geometria da superfície da esfera é análoga a do
plano, <em>quando os conceitos envolvidos são corretamente
correspondidos</em>, e essa intuição é de muito uso.
</li>
</ol>
<h2 id="a-formulação-matemática-do-problema">
A formulação matemática do problema
</h2>
<p>
A terra será modelada como uma esfera de raio 6378.008km, que é o valor
calculado para o
<a href="https://en.wikipedia.org/wiki/Earth_radius#Mean_radius">raio
médio da Terra</a> a partir do elipsoide
<a href="https://en.wikipedia.org/wiki/World_Geodetic_System#WGS84">WGS-84</a>.
A precisão obtida será, obviamente, menor que aquela que eu teria caso
usasse o próprio WGS-84, mas ao menos para esse projeto o
<em>trade-off</em> entre 0.5% de precisão e o grande ganho em
simplicidade das contas compensa. A posição de um ponto na superfície
dessa esfera é especificada por uma latitude e uma longitude,
costumeiramente representados pelas letras *ϕ* e *λ*, respectivamente.
</p>
<p>
<img src="https://lurodrigo.github.io/images/Central_angle.svg" alt="" class="align-center">
</p>
<p>
Neste caso, o ângulo central *Δ**σ* entre os pontos
*ϕ*<sub>1</sub>, *λ*<sub>1</sub> e *ϕ*<sub>2</sub>, *λ*<sub>2</sub> é
dado pela fórmula
</p>
<p>
Para obter a distância de fato, basta multiplicar este ângulo pelo raio
*r*<sub>*T*</sub> da Terra. Medições são feitas em três pontos
*A* = (*ϕ*<sub>*A*</sub>, *λ*<sub>*A*</sub>),
*B* = (*ϕ*<sub>*B*</sub>, *λ*<sub>*B*</sub>) e
*C* = (*ϕ*<sub>*C*</sub>, *λ*<sub>*C*</sub>) arbitrários. A única
restrição é que os três pontos não sejam colineares, ou melhor, que não
estejam na mesma <em>geodésia</em>, o análogo ao conceito de reta quanto
falamos da superfície da Terra. Isso deve ser observado porque, neste
caso, o terceiro ponto é inútil para distinguir entre a posição real a
posição falsa, pois as distâncias observadas serão as mesmas.
</p>
<p>
<img src="https://lurodrigo.github.io/images/02.png" alt="" class="full">
</p>
<p>
O objetivo é descobrir qual o ponto
*P* = (*ϕ*<sup>\*</sup>, *λ*<sup>\*</sup>) com medições de distância
*d*<sub>*A*</sub> = *r*<sub>*T*</sub>*Δ**σ*(*P*, *A*),
*d*<sub>*B*</sub> = *r*<sub>*T*</sub>*Δ**σ*(*P*, *B*) e
*d*<sub>*C*</sub> = *r*<sub>*T*</sub>*Δ**σ*(*P*, *C*). Definindo a
função
*F*(*X*)=(*r*<sub>*T*</sub>*Δ**σ*(*X*, *A*)−*d*<sub>*A*</sub>, *r*<sub>*T*</sub>*Δ**σ*(*X*, *B*)−*d*<sub>*B*</sub>),
vê-se claramente que o ponto que estamos procurando é uma raiz de F.
Portanto, podemos nos concentrar em encontrar as soluções
*S* = {*P*<sub>1</sub>, *P*<sub>2</sub>} da equação *F*(*X*)=0.
</p>
<p>
Por último, devemos usar o terceiro ponto para fazer uma escolha entre
as duas opções que restaram. A localização final é dada por
*a**r**g**m**i**n*<sub>*P* ∈ *S*</sub>|*r*<sub>*T*</sub>*Δ**σ*(*P*, *C*)−*d*<sub>*C*</sub>|.
Note que, em termos estritamente matemáticos, a solução final deveria
ser o ponto *P*<sub>1</sub> ou *P*<sub>2</sub> que satisfizesse
*r*<sub>*T*</sub>*Δ**σ*(*P*, *C*)=*d*<sub>*C*</sub> de forma exata, mas
admitimos uma imprecisão devido aos métodos numéricos envolvidos no
processo.
</p>
<h2 id="a-coleta-dos-dados">
A coleta dos dados
</h2>
<p>
Para a coleta dos dados eu usei a API
<a href="https://github.com/charliewolf/pynder">Pynder</a>. O script é
bastante simples e não precisa de muitos comentários. Em linhas gerais,
capturo as informações de nome, foto, última hora em que seu
posicionamento foi atualizado, e faço três medições a partir de pontos
mais ou menos arbitrários. No fim, jogo tudo isso para a saída padrão
como JSON.
</p>
<pre class="highlight"><code><span class="c"># py/get_coords.py</span> <span class="kn">import</span> <span class="nn">pynder</span>
<span class="kn">import</span> <span class="nn">json</span> <span class="c"># l&#xEA; id e senha da entrada padr&#xE3;o</span>
<span class="n">facebook_id</span> <span class="o">=</span> <span class="nb">input</span><span class="p">()</span>
<span class="n">facebook_token</span> <span class="o">=</span> <span class="nb">input</span><span class="p">()</span> <span class="c"># loga</span>
<span class="n">session</span> <span class="o">=</span> <span class="n">pynder</span><span class="o">.</span><span class="n">Session</span><span class="p">(</span><span class="n">facebook_id</span> <span class="o">=</span> <span class="n">facebook_id</span><span class="p">,</span> <span class="n">facebook_token</span> <span class="o">=</span> <span class="n">facebook_token</span><span class="p">)</span> <span class="c"># pega o posicionamento atual</span>
<span class="n">lat</span> <span class="o">=</span> <span class="n">session</span><span class="o">.</span><span class="n">profile</span><span class="o">.</span><span class="n">_data</span><span class="p">[</span><span class="s">&apos;pos&apos;</span><span class="p">][</span><span class="s">&apos;lat&apos;</span><span class="p">]</span>
<span class="n">lng</span> <span class="o">=</span> <span class="n">session</span><span class="o">.</span><span class="n">profile</span><span class="o">.</span><span class="n">_data</span><span class="p">[</span><span class="s">&apos;pos&apos;</span><span class="p">][</span><span class="s">&apos;lon&apos;</span><span class="p">]</span> <span class="n">data</span> <span class="o">=</span> <span class="nb">dict</span><span class="p">()</span>
<span class="n">data</span><span class="p">[</span><span class="s">&apos;pos1&apos;</span><span class="p">]</span> <span class="o">=</span> <span class="p">[</span><span class="n">lat</span><span class="p">,</span> <span class="n">lng</span><span class="p">]</span>
<span class="n">data</span><span class="p">[</span><span class="s">&apos;pos2&apos;</span><span class="p">]</span> <span class="o">=</span> <span class="p">[</span><span class="n">lat</span> <span class="o">-</span> <span class="o">.</span><span class="mi">25</span><span class="p">,</span> <span class="n">lng</span> <span class="o">-</span> <span class="o">.</span><span class="mi">25</span><span class="p">]</span>
<span class="n">data</span><span class="p">[</span><span class="s">&apos;pos3&apos;</span><span class="p">]</span> <span class="o">=</span> <span class="p">[</span><span class="n">lat</span> <span class="o">-</span> <span class="o">.</span><span class="mi">25</span><span class="p">,</span> <span class="n">lng</span><span class="p">]</span>
<span class="n">data</span><span class="p">[</span><span class="s">&apos;matches&apos;</span><span class="p">]</span> <span class="o">=</span> <span class="p">[]</span> <span class="c"># varre os matches coletando infos e dist&#xE2;ncias ao ponto atual</span>
<span class="k">for</span> <span class="n">match</span> <span class="ow">in</span> <span class="n">session</span><span class="o">.</span><span class="n">matches</span><span class="p">():</span> <span class="n">photos</span> <span class="o">=</span> <span class="n">match</span><span class="o">.</span><span class="n">user</span><span class="o">.</span><span class="n">get_photos</span><span class="p">()</span> <span class="n">picture</span> <span class="o">=</span> <span class="n">photos</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span> <span class="k">if</span> <span class="p">(</span><span class="nb">len</span><span class="p">(</span><span class="n">photos</span><span class="p">)</span> <span class="o">&gt;</span> <span class="mi">0</span><span class="p">)</span> <span class="k">else</span> <span class="s">&quot;egg.png&quot;</span> <span class="n">data</span><span class="p">[</span><span class="s">&apos;matches&apos;</span><span class="p">]</span><span class="o">.</span><span class="n">append</span><span class="p">({</span> <span class="s">&apos;name&apos;</span><span class="p">:</span> <span class="n">match</span><span class="o">.</span><span class="n">user</span><span class="o">.</span><span class="n">name</span><span class="p">,</span> <span class="s">&apos;picture&apos;</span><span class="p">:</span> <span class="n">picture</span><span class="p">,</span> <span class="s">&apos;last_online&apos;</span><span class="p">:</span> <span class="n">match</span><span class="o">.</span><span class="n">user</span><span class="o">.</span><span class="n">ping_time</span><span class="p">,</span> <span class="s">&apos;dist1&apos;</span><span class="p">:</span> <span class="n">match</span><span class="o">.</span><span class="n">user</span><span class="o">.</span><span class="n">distance_km</span> <span class="p">})</span> <span class="c"># segunda medi&#xE7;&#xE3;o: atualiza a posi&#xE7;&#xE3;o e pega as novas dist&#xE2;ncias</span>
<span class="n">session</span><span class="o">.</span><span class="n">update_location</span><span class="p">(</span><span class="n">lat</span> <span class="o">-</span> <span class="o">.</span><span class="mi">25</span><span class="p">,</span> <span class="n">lng</span> <span class="o">-</span> <span class="o">.</span><span class="mi">25</span><span class="p">)</span> <span class="n">i</span> <span class="o">=</span> <span class="mi">0</span>
<span class="k">for</span> <span class="n">match</span> <span class="ow">in</span> <span class="n">session</span><span class="o">.</span><span class="n">matches</span><span class="p">():</span> <span class="n">data</span><span class="p">[</span><span class="s">&apos;matches&apos;</span><span class="p">][</span><span class="n">i</span><span class="p">][</span><span class="s">&apos;dist2&apos;</span><span class="p">]</span> <span class="o">=</span> <span class="n">match</span><span class="o">.</span><span class="n">user</span><span class="o">.</span><span class="n">distance_km</span> <span class="n">i</span> <span class="o">+=</span> <span class="mi">1</span> <span class="c"># terceira medi&#xE7;&#xE3;o: atualiza a posi&#xE7;&#xE3;o e pega as novas dist&#xE2;ncias</span>
<span class="n">session</span><span class="o">.</span><span class="n">update_location</span><span class="p">(</span><span class="n">lat</span> <span class="o">-</span> <span class="o">.</span><span class="mi">25</span><span class="p">,</span> <span class="n">lng</span><span class="p">)</span> <span class="n">i</span> <span class="o">=</span> <span class="mi">0</span>
<span class="k">for</span> <span class="n">match</span> <span class="ow">in</span> <span class="n">session</span><span class="o">.</span><span class="n">matches</span><span class="p">():</span> <span class="n">data</span><span class="p">[</span><span class="s">&apos;matches&apos;</span><span class="p">][</span><span class="n">i</span><span class="p">][</span><span class="s">&apos;dist3&apos;</span><span class="p">]</span> <span class="o">=</span> <span class="n">match</span><span class="o">.</span><span class="n">user</span><span class="o">.</span><span class="n">distance_km</span> <span class="n">i</span> <span class="o">+=</span> <span class="mi">1</span> <span class="c"># joga os dados coletados na sa&#xED;da padr&#xE3;o</span>
<span class="k">print</span><span class="p">(</span><span class="n">json</span><span class="o">.</span><span class="n">dumps</span><span class="p">(</span><span class="n">data</span><span class="p">))</span>
</code></pre>

<h2 id="a-solução-numérica">
A solução numérica
</h2>
<p>
Queremos encontrar a raiz de uma função *F* que foi definida de um modo
bastante complicado. Parece trabalhosa (provavelmente impossível) de
resolver analiticamente, isto é, utilizando somente manipulações
algébricas. No entanto, é possível encontrar aproximações para as raízes
usando métodos numéricos. Neste caso, podemos usar uma versão do
<em>método de Newton</em>.
</p>
<p>
A ideia é simples. Damos um chute inicial *X*<sub>0</sub> de onde a raiz
deve estar e, chegando lá, usamos informações sobre a função e suas
derivadas parciais para estimar onde a raiz dessa função deveria estar
localizada <em>caso a função variasse de um modo linear</em>. Claro, a
função não é realmente linear, mas ao menos devemos ficar mais perto da
raiz do que estávamos antes. Com isso, chegamos ao um novo ponto
*X*<sub>1</sub>. Repetimos esse processo até que nos demos por
satisfeitos.
</p>
<p>
<img src="https://lurodrigo.github.io/images/05.png" alt="">
</p>
<p>
Matematicamente, a relação entre um chute e o próximo é expressa por
*X*<sub>*n* + 1</sub> = *X*<sub>*n*</sub> − *J*<sub>*F*</sub>(*X*<sub>*n*</sub>)<sup>−1</sup>*F*(*X*<sub>*n*</sub>),
onde *J*<sub>*F*</sub> é a jacobiana de *F*. Essa relação sugere
claramente o uso de um loop. No código abaixo, eu defino
<code class="highlighter-rouge">dist</code>, que é essencialmente a
função *F* definida anteriormente, sem a subtração das distâncias
medidas. A partir dela, crio uma função que gera as funções *F* para
cada contato em que estamos interessados, que nada mais são que
deslocamentos da <code class="highlighter-rouge">dist</code> original.
Defino também a jacobiana e a função para calcular a raiz de F usando o
método de Newton. Programei o método de Newton de modo a parar quando já
estiver dando passos menores que 10<sup>−12</sup> ou já tiver dado mais
de 20000 passos.
</p>
<pre class="highlight"><code><span class="c1"># R/newton.R
</span><span class="w">
</span><span class="n">dist</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">P</span><span class="p">,</span><span class="w"> </span><span class="n">A</span><span class="p">,</span><span class="w"> </span><span class="n">B</span><span class="p">)</span><span class="w"> </span><span class="p">{</span><span class="w"> </span><span class="n">lat</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">radians</span><span class="p">(</span><span class="n">P</span><span class="p">[</span><span class="m">1</span><span class="p">])</span><span class="w"> </span><span class="n">lng</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">radians</span><span class="p">(</span><span class="n">P</span><span class="p">[</span><span class="m">2</span><span class="p">])</span><span class="w"> </span><span class="n">lat_i</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">radians</span><span class="p">(</span><span class="nf">c</span><span class="p">(</span><span class="n">A</span><span class="p">[</span><span class="m">1</span><span class="p">],</span><span class="w"> </span><span class="n">B</span><span class="p">[</span><span class="m">1</span><span class="p">]))</span><span class="w"> </span><span class="n">lng_i</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">radians</span><span class="p">(</span><span class="nf">c</span><span class="p">(</span><span class="n">A</span><span class="p">[</span><span class="m">2</span><span class="p">],</span><span class="w"> </span><span class="n">B</span><span class="p">[</span><span class="m">2</span><span class="p">]))</span><span class="w"> </span><span class="n">cosines</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">sin</span><span class="p">(</span><span class="n">lat_i</span><span class="p">)</span><span class="o">*</span><span class="nf">sin</span><span class="p">(</span><span class="n">lat</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="nf">cos</span><span class="p">(</span><span class="n">lat_i</span><span class="p">)</span><span class="o">*</span><span class="nf">cos</span><span class="p">(</span><span class="n">lat</span><span class="p">)</span><span class="o">*</span><span class="nf">cos</span><span class="p">(</span><span class="n">lng</span><span class="w"> </span><span class="o">-</span><span class="w"> </span><span class="n">lng_i</span><span class="p">)</span><span class="w"> </span><span class="n">EARTH_RADIUS</span><span class="w"> </span><span class="o">*</span><span class="w"> </span><span class="nf">acos</span><span class="p">(</span><span class="n">cosines</span><span class="p">)</span><span class="w">
</span><span class="p">}</span><span class="w"> </span><span class="n">jacobianOfDist</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">P</span><span class="p">,</span><span class="w"> </span><span class="n">A</span><span class="p">,</span><span class="w"> </span><span class="n">B</span><span class="p">)</span><span class="w"> </span><span class="p">{</span><span class="w"> </span><span class="n">lat</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">radians</span><span class="p">(</span><span class="n">P</span><span class="p">[</span><span class="m">1</span><span class="p">])</span><span class="w"> </span><span class="n">lng</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">radians</span><span class="p">(</span><span class="n">P</span><span class="p">[</span><span class="m">2</span><span class="p">])</span><span class="w"> </span><span class="n">lat_i</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">radians</span><span class="p">(</span><span class="nf">c</span><span class="p">(</span><span class="n">A</span><span class="p">[</span><span class="m">1</span><span class="p">],</span><span class="w"> </span><span class="n">B</span><span class="p">[</span><span class="m">1</span><span class="p">]))</span><span class="w"> </span><span class="n">lng_i</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">radians</span><span class="p">(</span><span class="nf">c</span><span class="p">(</span><span class="n">A</span><span class="p">[</span><span class="m">2</span><span class="p">],</span><span class="w"> </span><span class="n">B</span><span class="p">[</span><span class="m">2</span><span class="p">]))</span><span class="w"> </span><span class="n">cosines</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">sin</span><span class="p">(</span><span class="n">lat_i</span><span class="p">)</span><span class="o">*</span><span class="nf">sin</span><span class="p">(</span><span class="n">lat</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="nf">cos</span><span class="p">(</span><span class="n">lat_i</span><span class="p">)</span><span class="o">*</span><span class="nf">cos</span><span class="p">(</span><span class="n">lat</span><span class="p">)</span><span class="o">*</span><span class="nf">cos</span><span class="p">(</span><span class="n">lng</span><span class="w"> </span><span class="o">-</span><span class="w"> </span><span class="n">lng_i</span><span class="p">)</span><span class="w"> </span><span class="n">dlat</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">EARTH_RADIUS</span><span class="w"> </span><span class="o">*</span><span class="w"> </span><span class="p">(</span><span class="o">-</span><span class="nf">sin</span><span class="p">(</span><span class="n">lat_i</span><span class="p">)</span><span class="o">*</span><span class="nf">cos</span><span class="p">(</span><span class="n">lat</span><span class="p">)</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="nf">cos</span><span class="p">(</span><span class="n">lat_i</span><span class="p">)</span><span class="o">*</span><span class="nf">sin</span><span class="p">(</span><span class="n">lat</span><span class="p">)</span><span class="o">*</span><span class="nf">cos</span><span class="p">(</span><span class="n">lng</span><span class="w"> </span><span class="o">-</span><span class="w"> </span><span class="n">lng_i</span><span class="p">))</span><span class="w"> </span><span class="o">/</span><span class="w"> </span><span class="nf">sqrt</span><span class="p">(</span><span class="m">1</span><span class="w"> </span><span class="o">-</span><span class="w"> </span><span class="n">cosines</span><span class="o">*</span><span class="n">cosines</span><span class="p">)</span><span class="w"> </span><span class="n">dlng</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">EARTH_RADIUS</span><span class="w"> </span><span class="o">*</span><span class="w"> </span><span class="nf">cos</span><span class="p">(</span><span class="n">lat_i</span><span class="p">)</span><span class="o">*</span><span class="nf">cos</span><span class="p">(</span><span class="n">lat</span><span class="p">)</span><span class="o">*</span><span class="nf">sin</span><span class="p">(</span><span class="n">lng</span><span class="w"> </span><span class="o">-</span><span class="w"> </span><span class="n">lng_i</span><span class="p">)</span><span class="w"> </span><span class="o">/</span><span class="w"> </span><span class="nf">sqrt</span><span class="p">(</span><span class="m">1</span><span class="w"> </span><span class="o">-</span><span class="w"> </span><span class="n">cosines</span><span class="o">*</span><span class="n">cosines</span><span class="p">)</span><span class="w"> </span><span class="n">cbind</span><span class="p">(</span><span class="n">dlat</span><span class="p">,</span><span class="w"> </span><span class="n">dlng</span><span class="p">)</span><span class="w">
</span><span class="p">}</span><span class="w"> </span><span class="n">getDistFunction</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">dist0</span><span class="p">,</span><span class="w"> </span><span class="n">A</span><span class="p">,</span><span class="w"> </span><span class="n">B</span><span class="p">)</span><span class="w"> </span><span class="p">{</span><span class="w"> </span><span class="n">dist0</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">P</span><span class="p">)</span><span class="w"> </span><span class="p">{</span><span class="w"> </span><span class="n">dist</span><span class="p">(</span><span class="n">P</span><span class="p">,</span><span class="w"> </span><span class="n">A</span><span class="p">,</span><span class="w"> </span><span class="n">B</span><span class="p">)</span><span class="w"> </span><span class="o">-</span><span class="w"> </span><span class="n">dist0</span><span class="w"> </span><span class="p">}</span><span class="w">
</span><span class="p">}</span><span class="w"> </span><span class="n">getJacobianFunction</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">A</span><span class="p">,</span><span class="w"> </span><span class="n">B</span><span class="p">)</span><span class="w"> </span><span class="p">{</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">P</span><span class="p">)</span><span class="w"> </span><span class="p">{</span><span class="w"> </span><span class="n">jacobianOfDist</span><span class="p">(</span><span class="n">P</span><span class="p">,</span><span class="w"> </span><span class="n">A</span><span class="p">,</span><span class="w"> </span><span class="n">B</span><span class="p">)</span><span class="w"> </span><span class="p">}</span><span class="w">
</span><span class="p">}</span><span class="w"> </span><span class="n">newton</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">f</span><span class="p">,</span><span class="w"> </span><span class="n">x</span><span class="m">0</span><span class="p">,</span><span class="w"> </span><span class="n">j</span><span class="p">,</span><span class="w"> </span><span class="n">epsilon</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">1E-12</span><span class="p">,</span><span class="w"> </span><span class="n">max</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">20000</span><span class="p">)</span><span class="w"> </span><span class="p">{</span><span class="w"> </span><span class="n">oldGuess</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">x</span><span class="m">0</span><span class="w"> </span><span class="k">for</span><span class="w"> </span><span class="p">(</span><span class="n">i</span><span class="w"> </span><span class="k">in</span><span class="w"> </span><span class="m">1</span><span class="o">:</span><span class="n">max</span><span class="p">)</span><span class="w"> </span><span class="p">{</span><span class="w"> </span><span class="n">guess</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">oldGuess</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="n">solve</span><span class="p">(</span><span class="n">j</span><span class="p">(</span><span class="n">oldGuess</span><span class="p">),</span><span class="w"> </span><span class="o">-</span><span class="n">f</span><span class="p">(</span><span class="n">oldGuess</span><span class="p">))</span><span class="w"> </span><span class="k">if</span><span class="w"> </span><span class="p">(</span><span class="n">norm</span><span class="p">(</span><span class="n">guess</span><span class="w"> </span><span class="o">-</span><span class="w"> </span><span class="n">oldGuess</span><span class="p">,</span><span class="w"> </span><span class="n">type</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;2&quot;</span><span class="p">)</span><span class="w"> </span><span class="o">&lt;</span><span class="w"> </span><span class="n">epsilon</span><span class="p">)</span><span class="w"> </span><span class="k">break</span><span class="w"> </span><span class="n">oldGuess</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">guess</span><span class="w"> </span><span class="p">}</span><span class="w"> </span><span class="n">guess</span><span class="w">
</span><span class="p">}</span><span class="w">
</span></code></pre>

<p>
Uma questão ainda ficou em aberto: precisamos das duas raízes, mas o
método de Newton só encontra uma delas. Pra ser mais preciso, a raiz que
o método de Newton encontra depende exclusivamente do chute inicial que
damos. O problema é que, no caso geral, é muito difícil identificar para
qual das raízes o sistema vai convergir dependendo do chute inicial. De
primeira pensei em dar chutes iniciais aleatórios. Ora, a estrutura do
problema parece bastante simétrica, <em>fifty-fifty</em> e seria
improvável que, partindo de pontos iniciais aleatórios, eu chegasse
sempre na mesma raiz. <em>Uma hora</em> o método vai ter que me dar as
duas raízes!
</p>
<p>
Funcionou, mas resolvi pensar um pouco mais sobre a simetria do
problema. Consegui provar, por exemplo, que as duas raízes são reflexões
uma da outra em torno da geodésia que liga A a B. Uma intuição que tive
é que, se dermos chutes iniciais refletidos em torno dessa geodésia,
cada chute inicial deveria resultar numa raiz diferente. Não consegui
provar esse fato, mas a intuição pareceu funcionar na prática. Se
*A* = (*ϕ*<sub>*A*</sub>, *λ*<sub>*A*</sub>) e
*B* = (*ϕ*<sub>*B*</sub>, *λ*<sub>*B*</sub>), dou chutes iniciais em
(*ϕ*<sub>*A*</sub>, *λ*<sub>*B*</sub>) e
(*ϕ*<sub>*B*</sub>, *λ*<sub>*A*</sub>). Se a terra fosse plana, estes
quatro pontos formariam um quadrado e os chutes iniciais seriam
reflexões um do outro. A terra não é plana, mas a figura formada fica
muito perto de ser um quadrado quando os pontos A e B são escolhidos
suficientemente próximos. Na prática, esses chutes funcionaram e
consegui obter as duas raízes deste modo.
</p>
<h2 id="o-resultado-final">
O resultado final
</h2>
<p>
Para visualizar os resultados, criei um aplicativo Shiny usando o pacote
Leaflet, que permite a criação de mapas interativos. Os cálculos dos
pontos são feitos no arquivo
<code class="highlighter-rouge">global.R</code> utilizando as ideias
descritas acima:
</p>
<pre class="highlight"><code><span class="c1"># global.R
</span><span class="n">library</span><span class="p">(</span><span class="n">shiny</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">shinydashboard</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">purrr</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">jsonlite</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">leaflet</span><span class="p">)</span><span class="w">
</span><span class="n">library</span><span class="p">(</span><span class="n">glue</span><span class="p">)</span><span class="w"> </span><span class="n">source</span><span class="p">(</span><span class="s2">&quot;R/newton.R&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">encoding</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;UTF-8&quot;</span><span class="p">)</span><span class="w"> </span><span class="n">EARTH_RADIUS</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">6371.008</span><span class="w"> </span><span class="n">data</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">fromJSON</span><span class="p">(</span><span class="s2">&quot;out.json&quot;</span><span class="p">)</span><span class="w">
</span><span class="n">matches</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">data</span><span class="o">$</span><span class="n">matches</span><span class="w"> </span><span class="n">pos1</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">data</span><span class="o">$</span><span class="n">pos1</span><span class="w">
</span><span class="n">pos2</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">data</span><span class="o">$</span><span class="n">pos2</span><span class="w">
</span><span class="n">pos3</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">data</span><span class="o">$</span><span class="n">pos3</span><span class="w"> </span><span class="c1"># gera as fun&#xE7;&#xF5;es objetivo e a jacobiana
</span><span class="n">funcs</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">map</span><span class="p">(</span><span class="m">1</span><span class="o">:</span><span class="n">n</span><span class="p">,</span><span class="w"> </span><span class="o">~</span><span class="w"> </span><span class="n">getDistFunction</span><span class="p">(</span><span class="nf">c</span><span class="p">(</span><span class="n">matches</span><span class="o">$</span><span class="n">dist1</span><span class="p">[</span><span class="n">.</span><span class="p">],</span><span class="w"> </span><span class="n">matches</span><span class="o">$</span><span class="n">dist2</span><span class="p">[</span><span class="n">.</span><span class="p">]),</span><span class="w"> </span><span class="n">pos1</span><span class="p">,</span><span class="w"> </span><span class="n">pos2</span><span class="p">))</span><span class="w">
</span><span class="n">jacobian</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">getJacobianFunction</span><span class="p">(</span><span class="n">pos1</span><span class="p">,</span><span class="w"> </span><span class="n">pos2</span><span class="p">)</span><span class="w"> </span><span class="c1"># calcula numericamente as duas poss&#xED;veis solu&#xE7;&#xF5;es
</span><span class="n">solution1</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">map</span><span class="p">(</span><span class="n">funcs</span><span class="p">,</span><span class="w"> </span><span class="n">newton</span><span class="p">,</span><span class="w"> </span><span class="n">j</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">jacobian</span><span class="p">,</span><span class="w"> </span><span class="n">x</span><span class="m">0</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="n">pos1</span><span class="p">[</span><span class="m">1</span><span class="p">],</span><span class="w"> </span><span class="n">pos2</span><span class="p">[</span><span class="m">2</span><span class="p">]))</span><span class="w">
</span><span class="n">solution2</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">map</span><span class="p">(</span><span class="n">funcs</span><span class="p">,</span><span class="w"> </span><span class="n">newton</span><span class="p">,</span><span class="w"> </span><span class="n">j</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">jacobian</span><span class="p">,</span><span class="w"> </span><span class="n">x</span><span class="m">0</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="nf">c</span><span class="p">(</span><span class="n">pos2</span><span class="p">[</span><span class="m">1</span><span class="p">],</span><span class="w"> </span><span class="n">pos1</span><span class="p">[</span><span class="m">2</span><span class="p">]))</span><span class="w"> </span><span class="n">decide</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="k">function</span><span class="p">(</span><span class="n">p</span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="n">p</span><span class="m">2</span><span class="p">,</span><span class="w"> </span><span class="n">d</span><span class="p">,</span><span class="w"> </span><span class="n">p</span><span class="m">3</span><span class="p">)</span><span class="w"> </span><span class="p">{</span><span class="w"> </span><span class="n">distances</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">dist</span><span class="p">(</span><span class="n">p</span><span class="m">3</span><span class="p">,</span><span class="w"> </span><span class="n">p</span><span class="m">1</span><span class="p">,</span><span class="w"> </span><span class="n">p</span><span class="m">2</span><span class="p">)</span><span class="w"> </span><span class="k">if</span><span class="w"> </span><span class="p">(</span><span class="nf">abs</span><span class="p">(</span><span class="n">distances</span><span class="p">[</span><span class="m">1</span><span class="p">]</span><span class="w"> </span><span class="o">-</span><span class="w"> </span><span class="n">d</span><span class="p">)</span><span class="w"> </span><span class="o">&lt;</span><span class="w"> </span><span class="nf">abs</span><span class="p">(</span><span class="n">distances</span><span class="p">[</span><span class="m">2</span><span class="p">]</span><span class="w"> </span><span class="o">-</span><span class="w"> </span><span class="n">d</span><span class="p">))</span><span class="w"> </span><span class="n">p</span><span class="m">1</span><span class="w"> </span><span class="k">else</span><span class="w"> </span><span class="n">p</span><span class="m">2</span><span class="w">
</span><span class="p">}</span><span class="w"> </span><span class="n">definiteSolution</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">pmap</span><span class="p">(</span><span class="nf">list</span><span class="p">(</span><span class="n">solution1</span><span class="p">,</span><span class="w"> </span><span class="n">solution2</span><span class="p">,</span><span class="w"> </span><span class="n">matches</span><span class="o">$</span><span class="n">dist3</span><span class="p">),</span><span class="w"> </span><span class="n">decide</span><span class="p">,</span><span class="w"> </span><span class="n">p</span><span class="m">3</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">pos3</span><span class="p">)</span><span class="w"> </span><span class="n">matches</span><span class="o">$</span><span class="n">lat</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">map_dbl</span><span class="p">(</span><span class="m">1</span><span class="o">:</span><span class="n">n</span><span class="p">,</span><span class="w"> </span><span class="o">~</span><span class="w"> </span><span class="n">definiteSolution</span><span class="p">[[</span><span class="n">.</span><span class="p">]][</span><span class="m">1</span><span class="p">])</span><span class="w">
</span><span class="n">matches</span><span class="o">$</span><span class="n">lng</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">map_dbl</span><span class="p">(</span><span class="m">1</span><span class="o">:</span><span class="n">n</span><span class="p">,</span><span class="w"> </span><span class="o">~</span><span class="w"> </span><span class="n">definiteSolution</span><span class="p">[[</span><span class="n">.</span><span class="p">]][</span><span class="m">2</span><span class="p">])</span><span class="w">
</span></code></pre>

<p>
O código dos outros arquivos não é muito interessante.
</p>
<pre class="highlight"><code><span class="c1"># ui.R
</span><span class="n">dashboardPage</span><span class="p">(</span><span class="w"> </span><span class="n">dashboardHeader</span><span class="p">(</span><span class="n">title</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Match Locator&quot;</span><span class="p">),</span><span class="w"> </span><span class="n">dashboardSidebar</span><span class="p">(</span><span class="n">disable</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">TRUE</span><span class="p">),</span><span class="w"> </span><span class="n">dashboardBody</span><span class="p">(</span><span class="w"> </span><span class="n">fluidRow</span><span class="p">(</span><span class="w"> </span><span class="n">column</span><span class="p">(</span><span class="n">width</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">12</span><span class="p">,</span><span class="w"> </span><span class="n">box</span><span class="p">(</span><span class="n">title</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;Mapa&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">width</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">NULL</span><span class="p">,</span><span class="w"> </span><span class="n">leafletOutput</span><span class="p">(</span><span class="s2">&quot;mapa&quot;</span><span class="p">,</span><span class="w"> </span><span class="n">height</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">600</span><span class="p">),</span><span class="w"> </span><span class="n">solidHeader</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">TRUE</span><span class="p">,</span><span class="w"> </span><span class="n">status</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="s2">&quot;primary&quot;</span><span class="w"> </span><span class="p">)</span><span class="w"> </span><span class="p">)</span><span class="w"> </span><span class="p">)</span><span class="w"> </span><span class="p">)</span><span class="w">
</span><span class="p">)</span><span class="w">
</span></code></pre>

<pre class="highlight"><code><span class="c1"># server.R
</span><span class="k">function</span><span class="p">(</span><span class="n">input</span><span class="p">,</span><span class="w"> </span><span class="n">output</span><span class="p">,</span><span class="w"> </span><span class="n">session</span><span class="p">)</span><span class="w"> </span><span class="p">{</span><span class="w"> </span><span class="n">output</span><span class="o">$</span><span class="n">mapa</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">renderLeaflet</span><span class="p">({</span><span class="w"> </span><span class="n">leaflet</span><span class="p">()</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">addTiles</span><span class="p">()</span><span class="w"> </span><span class="o">%&gt;%</span><span class="w"> </span><span class="n">addMarkers</span><span class="p">(</span><span class="n">lat</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">matches</span><span class="o">$</span><span class="n">lat</span><span class="p">,</span><span class="w"> </span><span class="n">lng</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">matches</span><span class="o">$</span><span class="n">lng</span><span class="p">,</span><span class="w"> </span><span class="n">popup</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">matches</span><span class="o">$</span><span class="n">name</span><span class="p">,</span><span class="w"> </span><span class="n">icon</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">icons</span><span class="p">(</span><span class="n">matches</span><span class="o">$</span><span class="n">picture</span><span class="p">,</span><span class="w"> </span><span class="n">iconWidth</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">32</span><span class="p">,</span><span class="w"> </span><span class="n">iconHeight</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="m">32</span><span class="p">))</span><span class="w"> </span><span class="p">})</span><span class="w">
</span><span class="p">}</span><span class="w">
</span></code></pre>

<p>
O importante é que isso me gerou a seguinte visualização no mapa:
</p>
<p>
<img src="https://lurodrigo.github.io/images/06.png" alt="">
</p>
<p>
Aparentemente as posições encontradas fazem sentido. Não tem ninguém
dentro da floresta da tijuca ou da Baía de Guanabara, por exemplo.
Quando dei zoom maior, no entanto, vi que havia uma moça usando o Tinder
enquanto morria afogada… ou então o método que falhou mesmo.
</p>
<p>
<img src="https://lurodrigo.github.io/images/07.png" alt="">
</p>
<p>
Fui investigar a questão mais um pouco e montei uma tabela com as
diferenças entre as distâncias medidas pelo Tinder e as distâncias dos
pontos que obtive em relação aos pontos A, B e C onde das medições foram
feitas. Se tudo estivesse correto, esta diferença deveria ser muito
próxima de zero. Isso aconteceu com as distâncias até A e B, afinal, foi
para isso que usei o método de Newton. No entanto, quando comparados com
o ponto C, a distância real do ponto encontrado e a distância dada pelo
Tinder diferiam, na média, em 624m. Erros desta magnitude não deveriam
acontecer mesmo levando em consideração que estou aproximando a Terra
por uma esfera e não por um elipsoide.
</p>
<p>
Não tenho como confirmar minhas suspeitas, mas acredito que o Tinder
fornece as distâncias reais somadas a um ruído aleatório de magnitude
menor que 1km. Esse ruído muda muito pouco a vida do usuário comum, que
afinal lê as distâncias arredondadas, mas é suficiente para impedir que
alguém com acesso a API possa usá-la para localizar alguém. Essa é uma
ideia que me parece até mais inteligente que dar acesso ao valor
arredondado da distância pela API, como faziam antes, pois neste caso
ainda seria possível conseguir uma boa estimativa da localização do
usuário usando uma quantidade grande de medições. De todo modo, os
resultados que obtive parecem precisos o suficiente ao menos para ter
uma ideia do bairro onde os seus matches estão.
</p>
<p class="notice--danger">
<strong>Conclusão:</strong> Parece que o Tinder já tinha ouvido a
Include Security e bolou um mecanismo inteligente que elimina essa
brecha.
</p>
<h2 id="try-it-yourself">
Try it yourself!
</h2>
<p>
Caso você tenha algum conhecimento de R e Python, você pode testar o
protótipo que desenvolvi, cujo código está disponível
<a href="https://github.com/lurodrigo/MatchLocator-public">neste
repositório</a>. Primeiro, você vai precisar usar o script
<code class="highlighter-rouge">py/auth.py</code> para pegar o <em>auth
token</em> do facebook. Pegue também o seu id do Facebook
<a href="https://findmyfbid.com/">nesse site</a>. Crie um arquivo texto
contendo o id na primeira linha e o auth token na segunda. Depois, rode
o seguinte comando:
</p>
<pre class="highlight"><code>python py/get_coords.py &lt; arquivo.txt &gt; out.json
</code></pre>

<p>
Isso bastará para gerar o arquivo JSON contendo as informações do
Tinder. Por último, basta rodar o aplicativo Shiny e ver os resultados.
O uso do RStudio é bem conveniente para isso. Para rodar tudo, você
precisará dos pacotes
<code class="highlighter-rouge">RoboBrowser</code>,
<code class="highlighter-rouge">Pynder</code> e
<code class="highlighter-rouge">lxml</code> no Python e
<code class="highlighter-rouge">shiny</code>,
<code class="highlighter-rouge">shinydashboard</code>,
<code class="highlighter-rouge">purrr</code>,
<code class="highlighter-rouge">jsonlite</code> e
<code class="highlighter-rouge">leaflet</code> no R.
</p>
</section>
<footer class="page__meta">
<p class="page__taxonomy">
<strong><i class="fa fa-fw fa-tags"></i> Tags: </strong> <span>
<a href="https://lurodrigo.github.io/tags/#geometria-anal&#xED;tica" class="page__taxonomy-item">Geometria
analítica</a><span class="sep">, </span>
<a href="https://lurodrigo.github.io/tags/#geometria-esf&#xE9;rica" class="page__taxonomy-item">Geometria
esférica</a><span class="sep">, </span>
<a href="https://lurodrigo.github.io/tags/#geometria" class="page__taxonomy-item">Geometria</a><span
class="sep">, </span>
<a href="https://lurodrigo.github.io/tags/#m&#xE9;todos-num&#xE9;ricos" class="page__taxonomy-item">Métodos
numéricos</a><span class="sep">, </span>
<a href="https://lurodrigo.github.io/tags/#tinder" class="page__taxonomy-item">Tinder</a>
</span>
</p>
<p class="page__taxonomy">
<strong><i class="fa fa-fw fa-folder-open"></i> Categorias: </strong>
<span>
<a href="https://lurodrigo.github.io/categories/#matem&#xE1;tica" class="page__taxonomy-item">Matemática</a><span
class="sep">, </span>
<a href="https://lurodrigo.github.io/categories/#portugu&#xEA;s" class="page__taxonomy-item">Português</a><span
class="sep">, </span>
<a href="https://lurodrigo.github.io/categories/#python" class="page__taxonomy-item">Python</a><span
class="sep">, </span>
<a href="https://lurodrigo.github.io/categories/#r" class="page__taxonomy-item">R</a><span
class="sep">, </span>
<a href="https://lurodrigo.github.io/categories/#r-pt" class="page__taxonomy-item">R\_pt</a>
</span>
</p>
<p class="page__date">
<strong><i class="fa fa-fw fa-calendar"></i> Atualizado em:</strong>
<time>June 05, 2017</time>
</p>
</footer>
<section class="page__share">
<a href="https://twitter.com/intent/tweet?via=lu_rodrigo&amp;text=Como%20eu%20consegui%20descobrir%20a%20localiza&#xE7;&#xE3;o%20dos%20meus%20matches%20no%20Tinder%20(ou%20quase)%20https://lurodrigo.github.io/2017/06/tinder-localizacao/" class="btn btn--twitter"><i class="fa fa-fw fa-twitter"></i><span>
Twitter</span></a>
<a href="https://www.facebook.com/sharer/sharer.php?u=https://lurodrigo.github.io/2017/06/tinder-localizacao/" class="btn btn--facebook"><i class="fa fa-fw fa-facebook"></i><span>
Facebook</span></a>
<a href="https://plus.google.com/share?url=https://lurodrigo.github.io/2017/06/tinder-localizacao/" class="btn btn--google-plus"><i class="fa fa-fw fa-google-plus"></i><span>
Google+</span></a>
<a href="https://www.linkedin.com/shareArticle?mini=true&amp;url=https://lurodrigo.github.io/2017/06/tinder-localizacao/" class="btn btn--linkedin"><i class="fa fa-fw fa-linkedin"></i><span>
LinkedIn</span></a>
</section>
</p>

