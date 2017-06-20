+++
title = "leaflet com markerCluster"
date = "2017-03-01 20:26:00"
categories = ["curso-r"]
original_url = "http://curso-r.com/blog/2017/03/01/2017-02-21-markercluster/"
+++

<div>
<p class="text-muted text-uppercase mb-small text-right">
Por <a href="http://curso-r.com/author/julio">Julio</a> 01/03/2017
</p>
<div id="post-content">
<p>
O
<a href="http://curso-r.com/blog/2017/03/01/2017-02-21-markercluster/leafletjs.com"><em>leaflet</em></a>
é uma biblioteca javascript para criação de mapas interativos. O pacote
<a href="https://rstudio.github.io/leaflet/"><code>leaflet</code></a> do
R é um
<a href="http://curso-r.com/blog/2017/03/01/2017-02-21-markercluster/www.htmlwidgets.org/"><code>htmlwidget</code></a>
que permite gerar esses mapas de forma direta no R, para usar em
documentos <code>RMarkdown</code> e Shiny.
</p>
<p>
Uma das ferramentas que mais gosto do leaflet é a função
<code>markerClusterOptions()</code>, que permite agrupar pontos no mapa
em conjuntos de vários pontos.
</p>
<p>
Como exemplo, utilizaremos uma base de dados que contém a localização e
informações das varas da Justiça Estadual no Brasil. A Tabela
<a href="http://curso-r.com/blog/2017/03/01/2017-02-21-markercluster/#tab:aj">1</a>
mostra as cinco primeiras linhas dessa base. A coluna <code>lab</code>
já foi trabalhada para ser adicionada nos marcadores do mapa como popup.
</p>
<table>
<caption>
<span id="tab:aj">Table 1: </span>Primeiras cinco linhas da base de
dados de varas estaduais do Brasil.
</caption>
<thead>
</thead>
<tbody>
<tr class="odd">
<td>
-21.243369
</td>
<td>
-48.80407
</td>
<td>
SP
</td>
<td>
Santa Adélia
</td>
<td>
VARA ÚNICA
</td>
<td>
<b>VARA ÚNICA</b>PRAÇA DR. ADHEMAR DE BARROS 255Santa Adélia - SP, CEP
15950-000Santa Adélia - SP
<p>
Telefone indisponível
</p>
</td>
</tr>
<tr class="even">
<td>
-3.102226
</td>
<td>
-67.95186
</td>
<td>
AM
</td>
<td>
Santo Antônio do Içá
</td>
<td>
VARA DA COMARCA DE SANTO ANTÔNIO DO IÇÁ
</td>
<td>
<b>VARA DA COMARCA DE SANTO ANTÔNIO DO IÇÁ</b>HUGO RIBEIRO S/NSanto
Antônio do Içá - AM, CEP 69680-000Santo Antônio do Içá - AM
<p>
1.  9791-8763
    </p>
    </td>
    </tr>
    <tr class="odd">
    <td>
    -3.067617
    </td>
    <td>
    -59.95668
    </td>
    <td>
    AM
    </td>
    <td>
    Manaus
    </td>
    <td>
    2º VARA DE FAMÍLIA E SUCESSÕES
    </td>
    <td>
    <b>2º VARA DE FAMÍLIA E SUCESSÕES</b>RUA PARAIBA S/NManaus - AM, CEP
    69079-265Manaus - AM
    <p>
    1.  9233-0351
        </p>
        </td>
        </tr>
        <tr class="even">
        <td>
        -8.623957
        </td>
        <td>
        -35.95085
        </td>
        <td>
        PE
        </td>
        <td>
        Cupira
        </td>
        <td>
        VARA UNICA DA COMARCA DE CUPIRA
        </td>
        <td>
        <b>VARA UNICA DA COMARCA DE CUPIRA</b>RUA JOSE LUIZ DA SILVEIRA
        BARROS 146Cupira - PE, CEP 55460-000Cupira - PE
        <p>
        1.  8137-3813
            </p>
            </td>
            </tr>
            <tr class="odd">
            <td>
            -24.705883
            </td>
            <td>
            -47.55834
            </td>
            <td>
            SP
            </td>
            <td>
            Iguape
            </td>
            <td>
            JUIZADO ESPECIAL CÍVEL E CRIMINAL
            </td>
            <td>
            <b>JUIZADO ESPECIAL CÍVEL E CRIMINAL</b>RUA 9 DE JULHO
            169Iguape - SP, CEP 11920-000Iguape - SP
            <p>
            1.  3841-2401
                </p>
                </td>
                </tr>
                </tbody>
                </table>
                <p>
                Para utilizar o pacote <code>leaflet</code>, basta
                instalar o pacote via <code>install.packages()</code>.
                Na Figura
                <a href="http://curso-r.com/blog/2017/03/01/2017-02-21-markercluster/#fig:mapa">1</a>,
                experimente passear pelo mapa. Procure também algum
                lugar que tenha várias varas juntas, para ver o que o
                <code>markerCluster</code> faz nesse caso.
                </p>
                <pre class="r"><code>library(dplyr)
                library(leaflet)
                dados_aj_lab %&gt;% leaflet() %&gt;% addTiles() %&gt;% addMarkers(lng = ~long, lat = ~lat, popup = ~lab, clusterOptions = markerClusterOptions())</code></pre>
                <div class="figure">
                <span id="fig:mapa"></span>
                <p class="caption">
                Figure 1: Mapa das varas estaduais do Brasil.

</p>
</div>
<ul>
<li>
A função <code>leaflet()</code> carrega o motor do <em>leaflet</em>,
ainda em branco.
</li>
<li>
A função <code>addTiles()</code> adiciona as camadas de mapas de acordo
com o zoom. É possível escolher temas para essas camadas.
</li>
<li>
A função <code>addMarkers()</code> mapeia as varas da base de dados de
acordo com as respectivas latitude e longitude.
<ul>
<li>
Note que é necessário adicionar um <code>~</code> antes das variáveis
para mapeá-las da base de dados.
</li>
<li>
A opção <code>popup</code> permite adicionar um balão com informações ao
clicar num marcador.
</li>
<li>
A opção <code>clusterOptions</code> faz a mágica que agrupa os pontos. A
região azul observada ao colocar o mouse sobre um cluster é a casca
convexa dos marcadores agrupados.
</li>
</ul>
</li>
</ul>
</div>
</div>

