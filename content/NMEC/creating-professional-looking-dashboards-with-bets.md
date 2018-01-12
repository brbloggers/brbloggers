+++
title = "Creating Professional-Looking Dashboards with BETS"
date = "2017-11-07"
categories = ["NMEC"]
original_url = "http://pedrocostaferreira.github.io/blog/2017/11/07/creating-professional-looking-dashboards-with-bets"
+++

<p>
The BETS package, besides providing thousands of Brazilian economic time
series and interesting analytical tools, has a powerful device to
visualize economic data. With a few lines of code - in some cases, only
one line - the user is able to create professional looking dashboards
exhibiting several thematic charts. These charts will always contain the
latest available data of each series, since BETS extracts series
directly from their original sources. The figure below shows a page of
one of such dashboards:
</p>
<p>
<img src="http://pedrocostaferreira.github.io/images/dashboard.png" alt="Third page of the Business Cycle Dashboard" class="img-responsive center-image">
</p>
<p>
In this example, we used a built-in theme - all charts inform something
about the Brazilian business cycles. However, dashboards are fully
customizable and charts are not constrained to BETS series. In fact, the
user can feed any time series in, as we are going to demonstrate later
on.
</p>
<p>
To create the dashboard we have just shown, run the following command:
</p>
<pre class="highlight"><code>BETS.dashboard(type = &quot;business_cycle&quot;, saveas = &quot;survey.pdf&quot;)
</code></pre>

<p>
The parameter <code class="highlighter-rouge">saveas</code> is not
required, but it is useful to know that you can save dashboards anywhere
you want to. You can download
<code class="highlighter-rouge">survey.pdf</code> here.
</p>
<p>
Now, let’s take another step in the customization direction. One of the
nice features of BETS dashboards is allowing the user to incorporate
text (e.g. a textual analysis). To do this, you have to provide an
external <code class="highlighter-rouge">.txt</code> file with your
text, obeying two simple synthax rules (separate paragraphs with ‘\\n’
and pages with ‘\#\#’). If you provide a text, authoring will be
required. You can also add your company logo or your email. The next
code snippet shows how to do it.
</p>
<pre class="highlight"><code>parameters = list(author = &quot;FGV/IBRE&quot;, url = &quot;http://portalibre.fgv.br/&quot;, text = &quot;text.txt&quot;, logo = &quot;logo_ibre.png&quot;) BETS.dashboard(type = &quot;macro_situation&quot;, parameters = parameters)
</code></pre>

<p>
Here we used another built-in theme:
<code class="highlighter-rouge">macro\_situation</code> (for
macroeconomic situation charts). The result of this straightforward call
is, again, a <code class="highlighter-rouge">.pdf</code> file. One of
its pages is displayed below.
</p>
<p>
<img src="http://pedrocostaferreira.github.io/images/dashboard2.png" alt="Second page of the Macro Situation Dashboard" class="img-responsive center-image">
</p>
<p>
You might be wondering how to insert your own series into BETS
dashboards. Firstly, we have to look into the main constituents of BETS
dashboards: BETS charts. The BETS function to create those charts is
<code class="highlighter-rouge">BETS.chart</code>, which is internally
called by <code class="highlighter-rouge">BETS.dashboard</code>, but is
also part of BETS’ public API.
</p>
<h3 id="using-betschart">
Using BETS.chart
</h3>
<p>
As detailed in the help files,
<code class="highlighter-rouge">BETS.chart</code> accept many predefined
series, as well as custom series (that is,
<code class="highlighter-rouge">ts</code> objects representing any time
series). For instance, suppose you want to observe the evolution of the
uncertainty level of the Brazilian economy. Then, all you have to do is
to run this command:
</p>
<pre class="highlight"><code>BETS.chart(ts = &quot;iie_br&quot;, file = &quot;uncertainty.png&quot;, open = T)
</code></pre>

<p>
Parameter <code class="highlighter-rouge">ts</code> receives
<em>iie\_br</em>, which is the code for the Economic Uncertainty Index
of the Getúlio Vargas Foundation. The fuction saves the chart in file
<em>uncertainty.png</em> and opens it to the user. Results are
reproduced below.
</p>
<p>
<img src="http://pedrocostaferreira.github.io/images/iie_br.png" alt="Uncertainty Index chart" class="img-responsive center-image">
</p>
<p>
All available codes are listed in the help files. To access them, type
<code class="highlighter-rouge">?BETS.chart</code> in the R console. You
will see that chart’s codes are divided into two categories,
<em>Business Cycle Dashboard (‘plotly’ style)</em> and <em>Macroeconomic
Situation Dashboard (‘normal’ style)</em>, referring to the dashboards
they belong to and the style in which they are drawn. The Uncertainty
Index chart is rendered using the package
<code class="highlighter-rouge">plotly</code>, but the National Consumer
Price Index chart is created with default R plotting functions
(<code class="highlighter-rouge">normal</code> style).
</p>
<p>
The call to create the National Consumer Price Index chart is simply
</p>
<pre class="highlight"><code>BETS.chart(&quot;ipca_with_core&quot;, file = &quot;cpi.pdf&quot;)
</code></pre>

<p>
Note that this time we specified that the file should be a
<code class="highlighter-rouge">.pdf</code> instead of a
<code class="highlighter-rouge">.png</code>. Both formats are accepted.
Nevertheless, it is reccomended that <em>plotly</em> charts be saved in
<code class="highlighter-rouge">.png</code> files and <em>normal</em>
charts in <em>.pdf</em> files, for better resolution.
</p>
<p>
The command just presented renders the follwing figure:
</p>
<p>
<img src="http://pedrocostaferreira.github.io/images/ipca_with_core.png" alt="IPCA chart" class="img-responsive center-image">
</p>
<p>
It is also possible to provide external time series (i.e. not
predefined). Let’s make a Brazilian current account and direct foreign
investment chart. You will see how simple it is to create beautiful,
clean and informative custom charts with BETS. Further on, we are going
to explain how to include them in custom dashboards.
</p>
<pre class="highlight"><code>##-- Get the series from the BETS database # Current Account, from 2006 on, in USD billions
curr_acnt &lt;- window(BETS.get(23461), start = 2006)/100 # Direct Foreign Investment, from 2006 on, in USD billions
dir_inv &lt;- window(BETS.get(23645), start = 2006)/100 ##-- Set chart parameters and call BETS.chart
params &lt;- list( type = &quot;bar&quot;, title = &quot;Current Account vs Direct Foreign Investment&quot;, subtitle = &quot;Net, Anual, US$ Billions&quot;, colors = c(&quot;royalblue&quot;,&quot;deepskyblue2&quot;), extra = dir_inv, legend.pos = &quot;bottomleft&quot;, legend = c(&quot;Current Account&quot;,&quot;Direct Foreign Investment&quot;), extra.arr.ort = &apos;v&apos;, extra.arr.len = 200
) BETS.chart(ts = curr_acnt, style = &quot;normal&quot;, file = &quot;ca_di.pdf&quot;, open = T, params = params)
</code></pre>

<p>
<img src="http://pedrocostaferreira.github.io/images/ca_di.png" alt="Current Account versus Foreing Direct Investiment chart" class="img-responsive center-image">
</p>
<p>
Most chart parameters are self-explanatory, but others deserve
clarification. <code class="highlighter-rouge">extra</code> receives the
second series and will always be plotted as a line;
<code class="highlighter-rouge">extra.arr.ort</code> is the orientation
of the arrow pointing to the last value of the second (“extra”) series
(you can also set this for the main series, using
<code class="highlighter-rouge">arr.ort</code>) and
<code class="highlighter-rouge">extra.arr.len</code> is the length of
this arrow (likewise, there is a
<code class="highlighter-rouge">arr.len</code> parameter).
</p>
<p>
We are now ready to build a custom dashboard. You will notice you don’t
even have to call <code class="highlighter-rouge">BETS.chart</code> -
<code class="highlighter-rouge">BETS.dashboard</code> will do the job.
</p>
<h3 id="using-betsdashboard-to-create-a-custom-dashboard">
Using BETS.dashboard to create a custom dashboard
</h3>
<p>
First of all, we have to create two empty lists. They will contain the
series and the setups of the graphs.
</p>
<pre class="highlight"><code>charts &lt;- list()
charts.opts &lt;- list()
</code></pre>

<p>
Then, we configure the parameters of each graph inside these lists.
</p>
<pre class="highlight"><code>##-- General Government Debt # The elements of &apos;charts&apos; will be the series to be plotted
charts[[1]] &lt;- window(BETS.get(4537),start = c(2006,1)) # The elements of &apos;charts.opts&apos; will be the setups of the graphs
charts.opts[[1]] &lt;- list( type = &quot;lines&quot;, title = &quot;General Government Debt&quot;, arr.len = 6, ylim = c(30,82), subtitle = &quot;% GDP&quot;, legend = c(&quot;Gross&quot;, &quot;Net&quot;), extra = window(BETS.get(4536),start = c(2006,1)), extra.arr.ort = &apos;h&apos;, extra.arr.len = 1 ) # International Reserves
charts[[2]] &lt;- window(BETS.get(3545),start = 2006)/100 charts.opts[[2]] &lt;- list( type = &quot;bar&quot;, title = &quot;International Reserves&quot;, subtitle = &quot;Total, US$ Billions&quot;, colors = &apos;chocolate1&apos;, trend = T
) # Current Account vc Direct Foreign Investment
charts[[3]] &lt;- window(BETS.get(23461), start = 2006)/100 charts.opts[[3]] &lt;- list( type = &quot;bar&quot;, title = &quot;Current Account vs Direct Foreign Investment&quot;, subtitle = &quot;Net, Anual, US$ Billions&quot;, colors = c(&quot;royalblue&quot;,&quot;deepskyblue2&quot;), extra = window(BETS.get(23645), start = 2006)/100, legend.pos = &quot;bottomleft&quot;, legend = c(&quot;Current Account&quot;,&quot;Direct Foreign Investment&quot;), extra.arr.ort = &apos;v&apos;, extra.arr.len = 200
) # External Debt # These series must be edited # Their frequency is anual until 1998, then it changes to quarterly
# We remove the anual part and then window the data we need
df &lt;- BETS.get(11407, data.frame = T)
df &lt;- df[-(1:30),2]
charts[[4]] &lt;- window(ts(df, start = c(2000,1), frequency = 4),start = c(2006,1)) df &lt;- BETS.get(11409, data.frame = T)
df &lt;- df[-(1:30),2]
extra &lt;- window(ts(df, start = c(2000,1), frequency = 4),start = c(2006,1)) charts.opts[[4]] &lt;- list( type = &quot;lines&quot;, title = &quot;External Debt&quot;, subtitle = &quot;% GDP&quot;, colors = c(&quot;aquamarine4&quot;,&quot;aquamarine3&quot;), legend = c(&quot;Gross&quot;, &quot;Net&quot;), extra = extra, arr.len = 5, extra.arr.ort = &apos;v&apos;, extra.arr.len = 5, legend.pos = &quot;bottomleft&quot;
)
</code></pre>

<p>
Next, we configure other options, such as the style of the graphs, the
name of the author (since we will provide a text to accompany the
plots), the logo and the website of the enterprise the author works in,
and the text with comments about the economic phenomenon we are seeking
to explain. These must all be placed inside a list whose elements have
pre-defined names (look into
<code class="highlighter-rouge">BETS.dashboard</code> help for a
complete listing of these elements and its names).
</p>
<pre class="highlight"><code>parameters &lt;- list( style = &quot;normal&quot;, charts.opts = charts.opts, author = &quot;FGV/IBRE&quot;, url = &quot;http://portalibre.fgv.br/&quot;, text = &quot;text2.txt&quot;, logo = &quot;logo_ibre.png&quot;
)
</code></pre>

<p>
Finally, we call <code class="highlighter-rouge">BETS.dashboard</code>:
</p>
<pre class="highlight"><code>BETS.dashboard(type = &quot;custom&quot;, charts = charts, saveas = &quot;custom_dashboard.pdf&quot;, parameters = parameters)
</code></pre>

<p>
This call creates a <code class="highlighter-rouge">.pdf</code> file
containing the dashboard. Its two pages are reproduced below.
</p>
<p>
<img src="http://pedrocostaferreira.github.io/images/custom_dashboard.png" alt="Custom dashboard created with BETS" class="img-responsive center-image">
</p>
<p>
And that’s it! With relatively few lines of code, we were able to design
a fully customizable, professional-looking economic dashboard using
BETS.
</p>

