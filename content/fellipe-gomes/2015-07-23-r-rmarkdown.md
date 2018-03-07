+++
title = "Hello R Markdown"
date = "2015-07-24 02:13:14"
categories = ["fellipe-gomes"]
original_url = "https://gomesfellipe.github.io/post/2015-07-23-r-rmarkdown/"
+++

<p id="main">
<article class="post">
<header>
</header>
<p>
This is an R Markdown document. Markdown is a simple formatting syntax
for authoring HTML, PDF, and MS Word documents. For more details on
using R Markdown see
<a href="http://rmarkdown.rstudio.com/" class="uri">http://rmarkdown.rstudio.com</a>.
</p>
<p>
You can embed an R code chunk like this:
</p>
<pre class="r"><code>summary(cars) ## speed dist ## Min. : 4.0 Min. : 2.00 ## 1st Qu.:12.0 1st Qu.: 26.00 ## Median :15.0 Median : 36.00 ## Mean :15.4 Mean : 42.98 ## 3rd Qu.:19.0 3rd Qu.: 56.00 ## Max. :25.0 Max. :120.00 fit &lt;- lm(dist ~ speed, data = cars) fit ## ## Call: ## lm(formula = dist ~ speed, data = cars) ## ## Coefficients: ## (Intercept) speed ## -17.579 3.932</code></pre>

<p>
You can also embed plots. See Figure
<a href="https://gomesfellipe.github.io/post/2015-07-23-r-rmarkdown/#fig:pie">1</a>
for example:
</p>
<pre class="r"><code>par(mar = c(0, 1, 0, 1)) pie( c(280, 60, 20), c(&apos;Sky&apos;, &apos;Sunny side of pyramid&apos;, &apos;Shady side of pyramid&apos;), col = c(&apos;#0292D8&apos;, &apos;#F7EA39&apos;, &apos;#C4B632&apos;), init.angle = -50, border = NA )</code></pre>
<span id="fig:pie"></span>
<img src="https://gomesfellipe.github.io/post/2015-07-23-r-rmarkdown_files/figure-html/pie-1.png" alt="A fancy pie chart." width="672">
<p class="caption">
Figure 1: A fancy pie chart.
</p>

<footer>
<ul class="stats">
<li class="categories">
</li>
<li class="tags">
<ul>
<i class="fa fa-tags"></i>
<li>
<a class="article-category-link" href="https://gomesfellipe.github.io/tags/r-markdown">R
Markdown</a>
</li>
<li>
<a class="article-category-link" href="https://gomesfellipe.github.io/tags/plot">plot</a>
</li>
<li>
<a class="article-category-link" href="https://gomesfellipe.github.io/tags/regression">regression</a>
</li>
</ul>
</li>
</ul>
</footer>
</article>
<article class="post">
<a href="https://disqus.com/" class="dsq-brlink">comments powered by
</a>
</article>
</p>

