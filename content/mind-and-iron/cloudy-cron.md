+++
title = "Encoberto com Chance de Cron"
date = "2017-11-08"
categories = ["mind-and-iron"]
original_url = "http://ctlente.com/pt/cloudy-cron/"
+++

<p>
Nem sempre os dados que precisamos para uma análise podem ser
encontrados em uma base consolidada. Muitas vezes as informações que
queremos não estão imediatamente disponíveis e precisam ser coletadas
com o tempo através de um processo lento e monótono.
</p>
<p>
Imagine, por exemplo, que quiséssemos baixar os dados meteorológicos das
maiores cidades do mundo a cada 12 horas para uma análise sobre
previsões do tempo. Um programador desavisado talvez criasse alarmes em
seu relógio e para baixar as tabelas necessárias quando eles tocassem.
</p>
<p>
Mas isso não parece uma boa estratégia, certo?
</p>
<p>
Para demonstrar uma alternativa a este método, vamos usar um serviço de
previsões do tempo chamado <a href="https://darksky.net/">DarkSky</a>.
Esta plataforma ficou conhecida recentemente pela sua precisão incrível
e pelo seu
<a href="https://play.google.com/store/apps/details?id=net.darksky.darksky&amp;hl=en">aplicativo</a>
extremamente bem feito, mas uma coisa que poucos sabem é que a DarkSky
também disponibiliza uma API para qualquer um interessado em dados
meteorológicos.
</p>
<p>
Para a nossa sorte, o <a href="https://github.com/hrbrmstr">hrbrmstr</a>
já criou uma <a href="https://github.com/hrbrmstr/darksky">interface em
R</a> para essa API que pode ser instalada facilmente com o comando
abaixo:
</p>
<pre class="r"><code># install.packages(&quot;devtools&quot;)
devtools::install_github(&quot;hrbrmstr/darksky&quot;)</code></pre>
<p>
Depois de instalado o pacote, vá para o
<a href="https://darksky.net/dev">portal do desenvolvedor</a> da
DarkSky, crie uma conta e obtenha uma chave secreta para acessar a API.
</p>
<pre class="r"><code>Sys.setenv(DARKSKY_API_KEY = &quot;SUA CHAVE SECRETA&quot;)</code></pre>

<p>
O primeiro passo da nossa análise é determinar as latitudes e longitudes
das maiores cidades cidades do mundo para que possamos pedir as
previsões do tempo destas coordenadas.
</p>
<p>
Com o pacote <code>maps</code> podemos fazer isso de uma maneira
bastante simples:
</p>
<pre class="r"><code>forecasts &lt;- maps::world.cities %&gt;% dplyr::as_tibble() %&gt;% dplyr::filter(pop &gt; 2000000) %&gt;% dplyr::rename(country = country.etc) %&gt;% dplyr::select(name, country, lat, long) %&gt;% dplyr::mutate( currently = list(&quot;&quot;), hourly = list(&quot;&quot;), daily = list(&quot;&quot;))</code></pre>
<p>
No trecho de código acima pegamos todas as cidades com mais de 2 milhões
de habitantes (juntamente com suas localizações) da base
<code><maps::world.cities></code>. As últimas 4 linhas são uma
preparação para a obtenção das previsões do tempo que faremos logo a
seguir:
</p>
<pre class="r"><code>for (i in 1:nrow(forecasts)) { forecast &lt;- darksky::get_current_forecast(forecasts$lat[i], forecasts$long[i]) forecasts$currently[i] &lt;- forecast$currently %&gt;% dplyr::as_tibble() %&gt;% list() forecasts$hourly[i] &lt;- forecast$hourly %&gt;% dplyr::as_tibble() %&gt;% list() forecasts$daily[i] &lt;- forecast$daily %&gt;% dplyr::as_tibble() %&gt;% list()
}</code></pre>
<p>
Na coluna <code>currently</code> guardamos o estado meteorológico atual
da cidade, enquanto em <code>hourly</code> e <code>daily</code>
colocamos as previsões do tempo para as próximas 48 horas e para os
próximos 7 dias respectivamente. Agora só resta salvar isso tudo em um
arquivo RDS:
</p>
<pre class="r"><code>file &lt;- lubridate::now() %&gt;% lubridate::ymd_hms() %&gt;% as.character() %&gt;% stringr::str_replace_all(&quot;[-: ]&quot;, &quot;_&quot;) %&gt;% stringr::str_c(&quot;.rds&quot;)&#xA0; readr::write_rds(forecasts, stringr::str_c(&quot;DIRET&#xD3;RIO DOS ARQUIVOS&quot;, file))</code></pre>

<p>
Perceba que o script descrito na seção anterior não depende de nenhum
input do programador e pode ser rodado automaticamente. Agora só nos
resta automatizar essa execução, tarefa que realizaremos com o pacote
<code>cronR</code>.
</p>
<p>
Esse pacote nos permite agendar a execução de qualquer comando para que
ela ocorra a cada tantos minutos/horas/dias/… Certifique-se de que você
está em uma máquina ou servidor que não será desligado,
<a href="https://en.wikipedia.org/wiki/Cron">verifique se o cron daemon
está ativo</a> e agende a execução do nosso script:
</p>
<pre class="r"><code>cmd &lt;- cronR::cron_rscript(&quot;CAMINHO PARA SCRIPT&quot;) cronR::cron_add(cmd, &quot;daily&quot;, &quot;12AM&quot;)
cronR::cron_add(cmd, &quot;daily&quot;, &quot;12PM&quot;)</code></pre>
<p>
E isso é tudo! No meu caso, agendei o script para executar diariamente
às 00:00 e às 12:00, mas a frequência das chamadas fica a seu critério
(lembrando apenas que o plano gratuito da API do DarkSky só permite 1000
chamadas por dia). Para saber mais sobre como mudar a frequência das
execuções, consulte a
<a href="https://github.com/bnosac/cronR">documentação do cronR</a>.
</p>

<p>
Como vimos, não é difícil agendar a execução de um script. A maior parte
do nosso trabalho é criar um código que funcione independentemente do
programador (por exemplo nomeando os arquivos gerados automaticamente),
mas depois disso é só chamar <code>cronR::cron\_rscript()</code> e
<code>cronR::cron\_add()</code>.
</p>
<p>
No meu próximo post usarei os dados baixados com esse tutorial para uma
análise sobre previsões meteorológicas, então fique ligado na parte
dois!
</p>
<p>
P.S.: Se você quiser o código completo do meu arquivo
<code>get\_forecasts.R</code>, disponibilizei ele como
<a href="https://gist.github.com/ctlente/997f603f05883fcda573d96e310dad69">um
Gist</a>.
</p>

