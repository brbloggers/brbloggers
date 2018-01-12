+++
title = "Instalando Anaconda + TensorFlow + Keras para R no Ubuntu 16.04 Server"
date = "2017-06-08 18:12:00"
categories = ["curso-r"]
original_url = "http://curso-r.com/blog/2017/06/08/2017-06-08-keras-no-ubuntu/"
+++

<p class="text-muted text-uppercase mb-small text-right">
Por <a href="http://curso-r.com/author/athos">Athos</a> 08/06/2017
</p>
<p>
Compilei um passo a passo mais simplificado dos posts que usei pra
conseguir usar o Keras num servidor Ubuntu.
</p>
<p>
Esse tutorial ensinará como instalar o
<a href="https://docs.continuum.io/">Anaconda</a> com Python 3.5 em um
servidor Ubuntu 16.04 + Keras para R. Então ao final desse post você
terá o Keras direto do seu R pronto para abalar os profundos mares da
aprendizagem de máquinas.
</p>
<p>
O tutorial supõe que você possui um servidor Ubuntu 16.04 com R 3.4.0 ou
versão superior instalado.
</p>

<p>
O Keras só funciona com o Python 2.7 ou 3.5, por isso temos que instalar
o Anaconda 4.2.0 que é a versão que vem com o Python 3.5.
</p>
<p>
<strong>Passo 1)</strong> Primeiro, sugiro que vá ao diretório
<code>/tmp</code> para baixar o arquivo bash do Anaconda.
</p>
<pre class="bash"><code>cd /tmp</code></pre>
<p>
<strong>Passo 2)</strong> Agora faça o download do bash do Anaconda
4.2.0.
</p>
<pre class="bash"><code>curl -O https://repo.continuum.io/archive/Anaconda3-4.2.0-Linux-x86_64.sh</code></pre>
<p>
<strong>Passo 3)</strong> Execute o bash.
</p>
<pre class="bash"><code>bash Anaconda3-4.2.0-Linux-x86_64.sh</code></pre>
<p>
<strong>Passo 4)</strong> Você verá a seguinte saída. Aperta ENTER para
continuar.
</p>
<pre class="bash"><code>Welcome to Anaconda3 4.2.0 (by Continuum Analytics, Inc.) In order to continue the installation process, please review the license
agreement.
Please, press ENTER to continue</code></pre>
<p>
<strong>Passo 5)</strong> Daí vai apertando mais ENTER para ir até o
final dos termos de uso. Quando chegar lá embaixo, vai perguntar se vc
aceita o termos.
</p>
<pre class="bash"><code>Do you approve the license terms? [yes|no]</code></pre>
<p>
<strong>Passo 6)</strong> Escreva <code>yes</code> para aceitar os
termos. Deve aparecer um prompt como o mostrado abaixo: hora de escolha
o local de instalação. Solte um ENTER caso goste do local padrão
oferecido.
</p>
<pre class="bash"><code>Anaconda3 will now be installed into this location: /home/athos/anaconda3 - Press ENTER to confirm the location
- Press CTRL-C to abort the installation
- Or specify a different location below [/home/athos/anaconda3] &gt;&gt;&gt; </code></pre>
<p>
<strong>Passo 7)</strong> Daí a pergunta seguinte é para saber se você
gostaria de fazer o comando <code>conda</code> funcionar quando for
chamado no terminal. Pode aceitar.
</p>
<pre class="bash"><code>...
installation finished.
Do you wish the installer to prepend the Anaconda3 install location
to PATH in your /home/athos/.bashrc ? [yes|no]
[no] &gt;&gt;&gt; </code></pre>
<p>
Neste momento você terá o Anaconda 4.2.0 pronto para rodar.
</p>
<p>
<strong>Agora, ao R!</strong>
</p>

<p>
<strong>Passo 8)</strong> Essa parte é fácil. Rode os códigos abaixo
para para instalar o pacote Keras e o
<a href="https://www.tensorflow.org/">Tensorflow</a>.
</p>
<pre class="r"><code>devtools::install_github(&quot;rstudio/keras&quot;) # instalar o pacote do Keras para R
keras::install_tensorflow() # instalar o Tensorflow</code></pre>
<p>
Pronto! Agora é só ser impressionante e destruir no DeepLearning. No
<a href="https://rstudio.github.io/keras/">github do Keras</a> tem a
documentação completa pra você aprender mais sobre como usá-lo.
</p>
<p>
Aquele axé.
</p>

