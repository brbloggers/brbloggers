+++
title = ""
date = "1-01-01"
categories = ["mind-and-iron"]
original_url = "http://ctlente.com/pt/teaching/decryptr/libs/leaflet-binding/lib/leaflet-providers/rstudio_install/"
+++

<section id="content">
<h2 id="location">
Location
</h2>
<ul>
<li>
<p>
Copy/paste provider information into <code>providers.json</code>
</p>
var providers = L.TileLayer.Provider.providers;
JSON.stringify(providers, null, " ");
<ul>
<li>
<code>./data-raw/providerNames.R</code> was re-ran to update to the
latest providers
</li>
</ul>
</li>
<li>
<p>
Some providers had their protocols turned into ‘//’.
</p>
<ul>
<li>
This allows browsers to pick the protocol
</li>
<li>
To stop files from the protocols staying as files, a ducktape patch was
applied to <code>L.TileLayer.prototype.initialize</code> and
<code>L.TileLayer.WMS.prototype.initialize</code>
</li>
</ul>
</li>
</ul>
</section>

