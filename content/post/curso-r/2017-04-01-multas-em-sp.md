+++
title = "Multas em São Paulo"
date = "2017-04-01 11:07:31"
categories = ["curso-r"]
+++

<p>
Há bastante tempo tenho vontade de fazer análises usando dados de multas
de São Paulo. O problema é: estes dados estão disponíveis? Na teoria,
sim. Os dados de multas, como quantidade de multas por tipo de infração,
dia e horário, e outros são divulgados no
<a href="http://mobilidadesegura.prefeitura.sp.gov.br/QvAJAXZfc/opendoc.htm?document=Painel_Mobilidade_Segura.qvw&amp;host=QVS%40c65v27i&amp;anonymous=true">portal
da Mobilidade Segura</a> da Prefeitura de São Paulo. Na prática, é um
pouco diferente. Apesar do site fornecer uma opção de exportação, a
tabela exportada não é completa e muitas informações ficam faltando. Dá
bastante trabalho para exportar todas as informações.
</p>
<p>
Para não ter o trabalho de exportar tabela por tabela, fiz uma
requisição para a prefeitura, por meio da Lei de Acesso à Informação,
pedindo acesso direto ao banco de dados que fornece as informações para
o Portal. A resposta foi a seguinte:
</p>
<blockquote>
<p>
Prezado Senhor Daniel, Agradecemos o contato e informamos que o seu
pedido foi indeferido com fundamento no art. 16, inciso III, do Decreto
nº 53.623/2012, pois a base de dados contém informações pessoais que não
podem ser disponibilizadas a terceiros. Os demais dados encontram-se
inseridos no Painel Mobilidade Segura para consulta pelos interessados
com a possibilidade de exportar arquivos. Informamos ainda que na época
da sua solicitação, os painéis se encontravam atualizados, visto que a
atualização mensal ocorre após os 70 dias da data da infração
</p>
</blockquote>
<p>
A resposta ao meu ver é totalmente contraditória: ao mesmo tempo que eu
não posso receber os dados porque eles são confidenciais, eu posso
obtê-los pelo site, que “oferece possibilidade de exportação de
arquivos”. (???)
</p>
<p>
Antes mesmo de pedir acesso ao banco de dados tinha pensado em
desenvolver um webscrapper para fazer o download automático das
planilhas, mas a tecnologia com a qual o portal foi desenvolvido
(QlikView) dificulta muito o desenvolviento.
</p>
<p>
Sobrou fazer o download manual mesmo. Até agora fiz o download de todos
as planilhas de 2014 a 2016 contendo infrações capturadas tanto
eletrônica quanto manualmente de carros (ainda faltam ônibus,
utilitários, etc.) por hora do dia. Isso quer dizer que já temos
planilhas suficientes para criar uma tabela:
</p>
<ul>
<li>
tipo de veículo (sempre seria carro)
</li>
<li>
data (2014 a 2016)
</li>
<li>
hora do dia
</li>
<li>
eletronica/manual
</li>
<li>
motivo da multa
</li>
<li>
localizacao da multa (quando for um radar)
</li>
<li>
quantidade de multas
</li>
</ul>
<p>
Disponibilizei esses dados
<a href="https://github.com/dfalbel/spmultas">neste repositório</a> do
Github.
</p>
<p>
Agora com as análises a seguir, espero criar curiosidade e interesse
para que mais pessoas possam ajudar no download completo dos dados. Na
página inicial do repositório, adicionei, um mini-tutorial de como você
pode ajudar fazendo os downloads.
</p>
<p>
Vamos às análises.
</p>
<pre class="r"><code>download.file(&quot;https://github.com/dfalbel/spmultas/raw/master/data/carros_eletronicas.rda&quot;, &quot;carros_eletronicas.rda&quot;)
load(&quot;carros_eletronicas.rda&quot;)</code></pre>
<p>
A partir de agora, você possui carregado um <code>data.frame</code>
chamado <code>carros\_eletronicas</code> que possui as informações das
multas para carros de forma eletrônica.
</p>
<p>
Em primeiro lugar, vamos analisar a quantidade de multas por dia em São
Paulo desde 2014.
</p>

<pre class="r"><code>carros_eletronicas %&gt;% group_by(data) %&gt;% summarise(qtd = sum(qtd)) %&gt;% ggplot(aes(data, qtd)) + geom_line()</code></pre>
<p>
<img src="http://curso-r.com/blog/2017-04-01-multas-em-sp_files/figure-html/unnamed-chunk-3-1.png" width="672">
</p>
<p>
Vemos nesse gráfico que o número de multas (por radar) era sempre por
volta de 10.000 durante 2014, em 2015 foi aumentando bastante durante o
ano e em 2016 se estabilizou. Vamos ver agora, por tipo de
enquadramento, isto é, por motivo da multa.
</p>
<p>
Existem 11 tipos de enquadramentos eletrônicos. Para a visualização
ficar mais fácil, vamos primeiro agrupar em grandes temas:
</p>
<ul>
<li>
Avançar o sinal vermelho
</li>
<li>
Executar conversão proibida
</li>
<li>
Parar sobre faixa de pedestres
</li>
<li>
Rodízio
</li>
<li>
Velocidade
</li>
<li>
Transitar em faixa de ônibus ou exclusiva p/ determinado veículo
</li>
</ul>
<p>
O agrupamento final ficou assim:
</p>
<pre class="r"><code>depara &lt;- carros_eletronicas %&gt;% group_by(enquadramento) %&gt;% summarise(qtd = sum(qtd)) %&gt;% arrange(qtd) %&gt;% select(-qtd)
depara$agrup_enquadramento &lt;- c(&quot;Convers&#xE3;o proibida&quot;, &quot;Velocidade&quot;, &quot;Faixa de Pedestres&quot;, &quot;Faixa de &#xF4;nibus&quot;, &quot;Sinal vermelho&quot;, &quot;Faixa de &#xF4;nibus&quot;, &quot;Convers&#xE3;o proibida&quot;, &quot;Faixa de &#xF4;nibus&quot;, &quot;Velocidade&quot;, &quot;Rod&#xED;zio&quot;, &quot;Velocidade&quot; ) depara %&gt;% knitr::kable()</code></pre>
<table>
<thead>
</thead>
<tbody>
<tr class="odd">
<td>
Executar Operacao De Conversao A Esquerda Em Local Proibido Pela
Sinalizacao
</td>
<td>
Conversão proibida
</td>
</tr>
<tr class="even">
<td>
Transitar Em Velocidade Superior A Maxima Permitida Em Mais De 50%
</td>
<td>
Velocidade
</td>
</tr>
<tr class="odd">
<td>
Parar Sobre Faixa De Pedestres Na Mudanca De Sinal Luminoso (Fisc
Eletronica)
</td>
<td>
Faixa de Pedestres
</td>
</tr>
<tr class="even">
<td>
Transitar Na Faixa/Pista Da Esquerda Regul Circulacao Exclusiva Determ
Veiculo
</td>
<td>
Faixa de ônibus
</td>
</tr>
<tr class="odd">
<td>
Avancar O Sinal Vermelho Do Semaforo - Fiscalizacao Eletronica
</td>
<td>
Sinal vermelho
</td>
</tr>
<tr class="even">
<td>
Transitar Na Faixa/Pista Da Direita Regul Circulacao Exclusiva Determ
Veiculo
</td>
<td>
Faixa de ônibus
</td>
</tr>
<tr class="odd">
<td>
Executar Operacao De Conversao A Direita Em Local Proibido Pela
Sinalizacao
</td>
<td>
Conversão proibida
</td>
</tr>
<tr class="even">
<td>
Transitar Na Faixa Ou Via Exclusiva Regulam P/Transp Publ Coletivo
Passag
</td>
<td>
Faixa de ônibus
</td>
</tr>
<tr class="odd">
<td>
Transitar Em Velocidade Superior A Maxima Permitida Em Mais De 20% Ate
50%
</td>
<td>
Velocidade
</td>
</tr>
<tr class="even">
<td>
Transitar Em Local/Horario Nao Permitido Pela Regulamentacao - Rodizio
</td>
<td>
Rodízio
</td>
</tr>
<tr class="odd">
<td>
Transitar Em Velocidade Superior A Maxima Permitida Em Ate 20%
</td>
<td>
Velocidade
</td>
</tr>
</tbody>
</table>
<pre class="r"><code>carros_eletronicas %&gt;% left_join(depara, by = &quot;enquadramento&quot;) %&gt;% group_by(data, agrup_enquadramento) %&gt;% summarise(qtd = sum(qtd)) %&gt;% ggplot(aes(data, qtd, color = agrup_enquadramento)) + geom_line()</code></pre>
<p>
<img src="http://curso-r.com/blog/2017-04-01-multas-em-sp_files/figure-html/unnamed-chunk-5-1.png" width="672">
</p>
<p>
No gráfico, vemos que em 2015, o tipo de multa que mais aumentou em
quantidade foi velocidade e rodízio.
</p>

<p>
Anteriormente vimos como se comportou o número de multas de maneira
geral na cidade. Vamos agora matar algumas curiosidades.
</p>
<ol>
<li>
Quais são os horários com mais multas em SP?
</li>
</ol>
<pre class="r"><code>carros_eletronicas %&gt;% group_by(hora) %&gt;% summarise(qtd = sum(qtd)) %&gt;% ggplot(aes(x = hora, y = qtd)) + geom_bar(stat = &quot;identity&quot;)</code></pre>
<p>
<img src="http://curso-r.com/blog/2017-04-01-multas-em-sp_files/figure-html/unnamed-chunk-6-1.png" width="672">
</p>
<p>
Notamos que o maior número de multas ocorre justamente na hora do rush.
Isto é, entre 7 e 10 da manhã e 17h e 19h. Isso até faz sentido, mas
nessas horas o trânsito da cidade está todo parado. Será que a
distribuição fica diferente por tipo de multa? Principalmente as de
velocidade.
</p>
<pre class="r"><code>carros_eletronicas %&gt;% left_join(depara, by = &quot;enquadramento&quot;) %&gt;% group_by(hora, agrup_enquadramento) %&gt;% summarise(qtd = sum(qtd)) %&gt;% ggplot(aes(x = hora, y = qtd, fill = agrup_enquadramento)) + geom_bar(stat = &quot;identity&quot;)</code></pre>
<p>
<img src="http://curso-r.com/blog/2017-04-01-multas-em-sp_files/figure-html/unnamed-chunk-7-1.png" width="672">
</p>
<p>
Veja que interessante! O grande responsável pelo pico da hora do rush é
o rodízio. (Essa é justamente a hora em que ele está valendo.) As multas
de velocidade diminuem um pouco durante o trânsito e acontecem mais
durante o dia e não durante a noite como poderíamos imaginar. Vemos
também que as multas de farol vermelho acontecem mais durante a
madrugada.
</p>
<ol>
<li>
Qual é o dia da semana com mais multas?
</li>
</ol>
<pre class="r"><code>carros_eletronicas %&gt;% left_join(depara, by = &quot;enquadramento&quot;) %&gt;% group_by(dia_da_semana = wday(data), agrup_enquadramento) %&gt;% summarise(qtd = sum(qtd)) %&gt;% ggplot(aes(x = dia_da_semana, y = qtd, fill = agrup_enquadramento)) + geom_bar(stat = &quot;identity&quot;)</code></pre>
<p>
<img src="http://curso-r.com/blog/2017-04-01-multas-em-sp_files/figure-html/unnamed-chunk-8-1.png" width="672">
</p>
<p>
O dia da semana com mais multas é quinta feira. Nos finais de semana,
aumenta muito o número de multas por excesso de velocidade (claro, as
ruas estão mais vazias).
</p>
<ol>
<li>
Quais são os radares que mais multam em SP? E porque?
</li>
</ol>
<pre class="r"><code>top10_locais &lt;- carros_eletronicas %&gt;% group_by(local) %&gt;% summarise(n = sum(qtd)) %&gt;% arrange(desc(n)) %&gt;% slice(1:10)
knitr::kable(top10_locais)</code></pre>
<table>
<thead>
</thead>
<tbody>
<tr class="odd">
<td>
Avenida Assis Chateaubriand X Acesso Pte Das Bandeiras, A.Sen/C. Bran
</td>
<td>
321629
</td>
</tr>
<tr class="even">
<td>
Avenida Assis Chateaubriand (A. Senna/C. Branco), Alca Da Ponte Das
Bandeiras
</td>
<td>
318745
</td>
</tr>
<tr class="odd">
<td>
Av Dos Bandeirantes(Marginal/Imigrantes) A Mais 34 Metros Da Av
Washington Luis
</td>
<td>
291277
</td>
</tr>
<tr class="even">
<td>
Av Das Nacoes Unidas-Pista Central-(Interlagos/C.Branco) A Menos 7,3m Do
Km 5,5
</td>
<td>
162318
</td>
</tr>
<tr class="odd">
<td>
Av Morvan D De Figueiredo (As/Cb), A Mais 3m R Amazonas Da Silva-Fx Excl
Onibus
</td>
<td>
153131
</td>
</tr>
<tr class="even">
<td>
Rua Hungria (Interlagos/Castelo Branco) A Menos 20 Metros Da Avenida
Reboucas
</td>
<td>
139048
</td>
</tr>
<tr class="odd">
<td>
Av Morvan Dias De Figueiredo (As/Cb),A Mais 3m R Amazonas Da Silva
</td>
<td>
137064
</td>
</tr>
<tr class="even">
<td>
Rodovia Presidente Dutra (As/Cb), A Menos 75m Da Pte Pr J Quadros
</td>
<td>
134454
</td>
</tr>
<tr class="odd">
<td>
Av Aricanduva (Bairro/Centro), A Mais15m Da Av Matapi - Fx Exclusiva De
Onibus
</td>
<td>
127690
</td>
</tr>
<tr class="even">
<td>
Av Embaixador Macedo Soares, Sob Ponte Nova Fepasa, Sentido C. Branco/A.
Senna
</td>
<td>
124927
</td>
</tr>
</tbody>
</table>
<p>
Agora vamos ver os motivos, em cada um desses lugares.
</p>
<pre class="r"><code>top10_locais %&gt;% left_join(carros_eletronicas, by = &quot;local&quot;) %&gt;% left_join(depara, by = &quot;enquadramento&quot;) %&gt;% mutate(local = stringr::str_wrap(local, width = 20) %&gt;% forcats::fct_reorder(-n)) %&gt;% group_by(local, agrup_enquadramento) %&gt;% summarise(qtd = sum(qtd)) %&gt;% ggplot(aes(x = local, y = qtd, fill = agrup_enquadramento)) + geom_bar(stat = &quot;identity&quot;)</code></pre>
<p>
<img src="http://curso-r.com/blog/2017-04-01-multas-em-sp_files/figure-html/unnamed-chunk-10-1.png" width="1000px">
</p>
<p>
Por incrível que pareça, nos dois radares com mais multas, o motivo da
multa é conversão proibida. A foto de onde fica esse radar saiu em uma
<a href="http://www1.folha.uol.com.br/cotidiano/2015/07/1660793-radar-campeao-aplica-375-mil-multas-em-um-ano-na-ponte-das-bandeiras.shtml">notícia
sobre o mesmo tema</a> na Folha de São Paulo.
</p>
<p>
<img src="http://curso-r.com/blog/2017-04-01-multas-em-sp_files/figure-html/unnamed-chunk-11-1.png" width="672">
</p>

