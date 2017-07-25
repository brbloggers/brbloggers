+++
title = "Criando gráficos interativos e dinâmicos com o Plotly"
date = "2017-07-25 12:28:05"
categories = ["jose-guilherme-lopes"]
original_url = "http://joseguilhermelopes.com.br/criando-graficos-interativos-com-o-plotly/"
+++

<p>
Esboçar um gráfico é a principal forma para visualizar um conjunto de
dados.
</p>
<p>
Um gráfico estático é muito útil quando estamos realizando uma
apresentação através de um relatório impresso, por exemplo.
</p>
<p>
Mas se você estiver apresentando a sua análise por um meio digital,
utilizar um gráfico dinâmico muitas vezes pode deixar a sua apresentação
mais compreensível e atrativa.
</p>
<p>
Além disso, se o seu gráfico apresentar valores extremos ou qualquer
curva fora do padrão, a possibilidade de passar o mouse para ver com
mais detalhes sobre a determinada anomalia, pode ser muito útil.
</p>
<p>
Uma boa ferramenta para criar gráficos dinâmicos é o
<a href="https://plot.ly/">Plotly</a>.
</p>
<p>
Você pode utilizar o Plotly através do website ou através dos pacotes
disponíveis para
<a href="https://plot.ly/r/">R</a> e <a href="https://plot.ly/python/">Python</a>.
</p>
<h2>
<strong>Exemplos de gráficos dinâmicos feitos com o Plotly</strong>
</h2>
<p>
O gráfico a seguir é oriundo de um dataset sobre diamantes e exibe as
informações sobre o preço (variável <em>price)</em> e peso (variável
<em>carat</em>). Veja que ao passar o curso do mouse sobre um
determinado ponto, é possível ver mais detalhes sobre o diamante, como
por exemplo a sua claridade).
</p>
<a href="https://plot.ly/~joseguilhermelopes/37"><img src="http://joseguilhermelopes.com.br/criando-graficos-interativos-com-o-plotly/this.onerror=null;this.src=%22https://plot.ly/404.png%22"></a>

<p>
Com o Box Plot criado com o Plotly, é possível ver com mais detalhes
informações sobre os quartis, limites inferior e superior, bem como
sobre os outliers da variável.
</p>
<a href="https://plot.ly/~joseguilhermelopes/38"><img src="http://joseguilhermelopes.com.br/criando-graficos-interativos-com-o-plotly/this.onerror=null;this.src=%22https://plot.ly/404.png%22"></a>

<p>
O gráfico a seguir mostra o valor do PIB para diferentes países. Para
ver detalhes sobre um determinado país, basta passar o cursor do mouse
sobre ele:
</p>
<a href="https://plot.ly/~joseguilhermelopes/40"><img src="http://joseguilhermelopes.com.br/criando-graficos-interativos-com-o-plotly/this.onerror=null;this.src=%22https://plot.ly/404.png%22"></a>

<p>
O gráfico a seguir exibe as coordenadas de um vulcão:
</p>
<a href="https://plot.ly/~joseguilhermelopes/42"><img src="http://joseguilhermelopes.com.br/criando-graficos-interativos-com-o-plotly/this.onerror=null;this.src=%22https://plot.ly/404.png%22"></a>

<h2>
<strong><br> Inserir caixa suspensa para alterar variáveis ou outras
características</strong>
</h2>
<p>
Uma grande utilidade do Plotly é a possibilidade de inserir caixas
suspensas no gráfico. Assim, você não precisa criar um gráfico para
expressar diferentes variáveis de um mesmo estudo, basta alterar a
seleção da caixa.
</p>
<p>
Mostro a seguir um exemplo bem simples, onde é possível alterar o
gráfico do seno e do cosseno, bem como a cor da linha:
</p>
<a href="https://plot.ly/~joseguilhermelopes/44"><img src="http://joseguilhermelopes.com.br/criando-graficos-interativos-com-o-plotly/this.onerror=null;this.src=%22https://plot.ly/404.png%22"></a>

<h2>
<strong>Criando animações</strong>
</h2>
<p>
Também é possível criar uma animação com o gráfico. Este recurso é muito
interessante para ser utilizado em uma apresentação, onde o gráfico vai
sendo exibido à medida em que você o explica para o seu público.
</p>
<p>
Para exibir a animação a seguir, basta clicar em <em>Play.</em>
</p>
<a href="https://plot.ly/~joseguilhermelopes/45"><img src="http://joseguilhermelopes.com.br/criando-graficos-interativos-com-o-plotly/this.onerror=null;this.src=%22https://plot.ly/404.png%22"></a>

<p>
Veja mais sobre criar animações com o R
<a href="https://plot.ly/r/animations/">neste link</a>.
</p>
<h2>
<strong>Criando Dashboards – Paineis</strong>
</h2>
<p>
Um outro recurso muito interessante do Plotly é a possibilidade de unir
vários gráficos em um único painel e assim obter uma visão geral sobre
um determinado assunto, como por exemplo as principais métricas da sua
empresa. É possível compartilhar os gráficos e os paineis com outros
usuários.
</p>
<p>
<img class="aligncenter wp-image-294 size-full" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/07/dashboard.jpg%201837w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/07/dashboard-300x155.jpg%20300w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/07/dashboard-768x397.jpg%20768w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/07/dashboard-1024x529.jpg%201024w" alt="" width="1837" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/07/dashboard.jpg 1837w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/07/dashboard-300x155.jpg 300w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/07/dashboard-768x397.jpg 768w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/07/dashboard-1024x529.jpg 1024w">
</p>
<h2>
<strong>Utilizando o Plotly pelo website</strong>
</h2>
<p>
Você pode criar os gráficos e o painel através do próprio website do
Plotly, através <a href="https://plot.ly/create/">deste link</a>. Nesta
página há um espaço para inserção dos dados e no canto esquerdo, todas
as ferramentas necessárias para criação do gráfico.
</p>
<p>
Veja um exemplo:
</p>
<p>
<img class="aligncenter wp-image-295 size-full" src="http://joseguilhermelopes.com.br/wp-content/uploads/2017/07/dashboard2.jpg%201821w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/07/dashboard2-300x159.jpg%20300w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/07/dashboard2-768x407.jpg%20768w,%20http://joseguilhermelopes.com.br/wp-content/uploads/2017/07/dashboard2-1024x542.jpg%201024w" alt="" width="1821" srcset="http://joseguilhermelopes.com.br/wp-content/uploads/2017/07/dashboard2.jpg 1821w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/07/dashboard2-300x159.jpg 300w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/07/dashboard2-768x407.jpg 768w, http://joseguilhermelopes.com.br/wp-content/uploads/2017/07/dashboard2-1024x542.jpg 1024w">
</p>
<h2>
<strong>Utilizando o Plotly com o R</strong>
</h2>
<p>
Para linguagem R, você pode encontrar todas as informações e exemplos de
códigos <a href="https://plot.ly/r/">neste link</a>.
</p>
<p>
O pacote é o próprio nome da ferramenta: <em>plotly. </em>Logo para
instalação, basta rodar o código:
</p>
<pre class="brush: r; title: ; notranslate"> install.packages(&quot;plotly&quot;) </pre>
<p>
Se você utiliza o <em>ggplot, </em>é possível fazer a integração
do <em>ggplot</em> com o <em>plotly.</em> Basta criar normalmente o
gráfico com o ggplot e então executar a
função <em>ggplotly(), </em>inserindo como argumento o nome do gráfico
criado.
</p>
<p>
Veja um exemplo:
</p>
<pre class="brush: r; title: ; notranslate"> p &lt;- ggplot(data = d, aes(x = carat, y = price)) + geom_point(aes(text = paste(&quot;Clarity:&quot;, clarity))) + geom_smooth(aes(colour = cut, fill = cut)) + facet_wrap(~ cut) ggplotly(p) </pre>
<p>
Eis o resultado:
</p>
<a href="https://plot.ly/~RPlotBot/3262"><img src="http://joseguilhermelopes.com.br/criando-graficos-interativos-com-o-plotly/this.onerror=null;this.src=%22https://plot.ly/404.png%22"></a>

<p>
Mais exemplos sobre criação de gráficos com o R
<a href="https://plot.ly/r/basic-charts/">neste link</a>.
</p>
<p>
Espero que este artigo lhe tenha sido útil e que você possa criar ótimas
apresentações com a ferramenta Plotly.
</p>
<p>
Obrigado pela leitura e até a próxima!
</p>

