+++
title = "Google Trends no R"
date = "2017-02-14 01:52:16"
categories = ["analise-real"]
original_url = "https://analisereal.com/2017/02/13/google-trends-no-r/"
+++

<article id="post-3754" class="post-3754 post type-post status-publish format-standard hentry category-dados category-programacao category-r category-visualizacao tag-aecio-neves tag-dilma-rousseff tag-donald-trump tag-eleicoes tag-google-trends tag-hillary-clinton tag-marina-silva">
<br>
<p>
O pacote gtrendsR está passando por uma reformulação e parece que vai
ficar ainda mais fácil analisar dados do Google Trends no R.
<a href="https://github.com/PMassicotte/gtrendsR/tree/new-api">A nova
versão ainda não está no CRAN, mas já pode ser testada pelo github</a>.
Para instalar:
</p>
<pre class="brush: r; title: ; notranslate">
install.packages(&quot;devtools&quot;)
devtools::install_github(&apos;PMassicotte/gtrendsR&apos;, ref = &apos;new-api&apos;)
</pre>
<p>
A grande novidade dessa versão é que não será mais preciso fazer login
no google trends para ter acesso. Para brasileiros, outra novidade é que
os bugs com problema de encoding parecem estar diminuindo.
</p>
<p>
Vejamos um exemplo simples, pegando dados das buscas pelos nomes dos
candidatos nas eleições de 2014 no Brasil:
</p>
<pre class="brush: r; title: ; notranslate">
library(gtrendsR)
eleicoes2014 &lt;- gtrends(c(&quot;Dilma Rousseff&quot;, &quot;A&#xE9;cio Neves&quot;, &quot;Marina Silva&quot;), geo = c(&quot;BR&quot;), time = &quot;2014-01-01 2014-12-31&quot;)
plot(eleicoes2014)
</pre>
<p>
<img class=" size-full wp-image-3767 aligncenter" src="https://analisereal.files.wordpress.com/2017/02/rplot01.png?w=440%20440w,%20https://analisereal.files.wordpress.com/2017/02/rplot01.png?w=150%20150w,%20https://analisereal.files.wordpress.com/2017/02/rplot01.png?w=300%20300w,%20https://analisereal.files.wordpress.com/2017/02/rplot01.png%20622w" alt="rplot01" srcset="https://analisereal.files.wordpress.com/2017/02/rplot01.png?w=440 440w, https://analisereal.files.wordpress.com/2017/02/rplot01.png?w=150 150w, https://analisereal.files.wordpress.com/2017/02/rplot01.png?w=300 300w, https://analisereal.files.wordpress.com/2017/02/rplot01.png 622w">
</p>
<p>
Para ilustrar novamente, vejamos um exemplo mais recente — as buscas
pelos nomes dos candidatos das eleições norte-americanas:
</p>
<pre class="brush: r; title: ; notranslate">
USelections2016 &lt;- gtrends(c(&quot;Donald Trump&quot;, &quot;Hillary Clinton&quot;), geo = c(&quot;US&quot;), time = &quot;2016-01-01 2016-12-31&quot;)
plot(USelections2016)
</pre>
<p>
<img class=" size-full wp-image-3759 aligncenter" src="https://analisereal.files.wordpress.com/2017/02/rplot.png?w=440%20440w,%20https://analisereal.files.wordpress.com/2017/02/rplot.png?w=150%20150w,%20https://analisereal.files.wordpress.com/2017/02/rplot.png?w=300%20300w,%20https://analisereal.files.wordpress.com/2017/02/rplot.png%20622w" alt="rplot" srcset="https://analisereal.files.wordpress.com/2017/02/rplot.png?w=440 440w, https://analisereal.files.wordpress.com/2017/02/rplot.png?w=150 150w, https://analisereal.files.wordpress.com/2017/02/rplot.png?w=300 300w, https://analisereal.files.wordpress.com/2017/02/rplot.png 622w">
</p>

</article>

