+++
title = "A Plain Markdown Post"
date = "2016-12-31 04:49:57"
categories = ["fellipe-gomes"]
original_url = "https://gomesfellipe.github.io/post/2016-12-30-hello-markdown/"
+++

<div id="content">
<p>
This is a post written in plain Markdown (<code>*.md</code>) instead of
R Markdown (<code>*.Rmd</code>). The major differences are:
</p>
<ol>
<li>
You cannot run any R code in a plain Markdown document, whereas in an R
Markdown document, you can embed R code chunks
(<code>\`\``{r}</code>);</li> <li>A plain Markdown post is rendered through <a href="https://gohugo.io/overview/configuration/">Blackfriday</a>, and an R Markdown document is compiled by <a href="http://rmarkdown.rstudio.com/"><strong>rmarkdown</strong></a> and <a href="http://pandoc.org/">Pandoc</a>.</li> </ol> <p>There are many differences in syntax between Blackfriday&#x2019;s Markdown and Pandoc&#x2019;s Markdown. For example, you can write a task list with Blackfriday but not with Pandoc:</p> <p>Similarly, Blackfriday does not support LaTeX math and Pandoc does. I have added the MathJax support to this theme (<a href="https://github.com/yihui/hugo-lithium-theme">hugo-lithium-theme</a>) but there is a caveat for plain Markdown posts: you have to include math expressions in a pair of backticks (inline: <code>`$
$\`&lt;/code&gt;; display style: &lt;code&gt;\`$$
$$\`&lt;/code&gt;), e.g., &lt;code&gt;$S\_n = \_{i=1}^n X\_i$</code>.
For R Markdown posts, you do not need the backticks, because Pandoc can
identify and process math expressions.
</p>
<p>
When creating a new post, you have to decide whether the post format is
Markdown or R Markdown, and this can be done via the <code>ext</code>
argument of the function <code>blogdown::new\_post()</code>, e.g.
</p>
<pre><code class="language-r">blogdown::new_post(&quot;Post Title&quot;, ext = &apos;.Rmd&apos;)
</code></pre>
</div>

