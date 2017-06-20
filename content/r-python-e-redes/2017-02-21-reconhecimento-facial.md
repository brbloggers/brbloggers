+++
title = "Reconhecimento facial com Python e OpenCV - Machine Learning"
date = "2017-02-21 03:00:00"
categories = ["r-python-e-redes"]
original_url = "http://neylsoncrepalde.github.io/2017-02-21-reconhecimento-facial/"
+++

<div>
<article class="blog-post">
<p>
Olá. Hoje vamos utilizar uma implementação de <em>machine learning</em>
para reconhecimento facial usando o Python 2.7 e a biblioteca
<a href="http://opencv.org/">OpenCV 3</a>. Vamos começar carregando
algumas bibliotecas necessárias para nosso trabalho de hoje. O
<em>numpy</em> é necessário para o OpenCV. Da biblioteca <em>scipy</em>,
vamos importar a função de moda. Além disso, carregamos as bibliotecas
<em>os</em> para mudar a pasta de trabalho no Python, <em>time</em> para
gerar nomes de bancos de dados atualizados por data e hora e
<em>csv</em> para exportar arquivos . Isso tem se mostrado bem
importante na minha experiência. Eu mesmo já perdi alguns dados rodando
scripts de coleta de dados sem atualizar o nome do arquivo de saída.
Desse modo, um banco de quase 1Gb de dados foi sobrescrito por outro de
200 Mb :(
</p>
<h3 id="plano-de-vôo">
Plano de vôo
</h3>
<p>
Nosso objetivo hoje é usar o reconhecimento facial para contar os rostos
em algumas imagens. Serão usados 4 modelos já treinados e implementados
no OpenCV para isso. Os resultados de cada um dos modelos serão
tabulados junto com a média das quatro medidas, a moda e a variância.
</p>
<h3 id="instalando-o-opencv">
Instalando o OpenCV
</h3>
<p>
A instalação do OpenCV 3 não é algo trivial. Eu encontrei alguma
dificuldade mas informações no stackoverflow e a boa vontade dos amigos
do grupo de Facebook
<a href="https://www.facebook.com/groups/python.brasil">Python
Brasil</a> foram imprescindíveis. Em breve, farei também uma postagem
apenas focando na instalação do OpenCV. Vamos aos códigos.
</p>
<pre class="highlight"><code><span class="kn">import</span> <span class="nn">numpy</span> <span class="kn">as</span> <span class="nn">np</span>
<span class="kn">from</span> <span class="nn">scipy.stats</span> <span class="kn">import</span> <span class="n">mode</span>
<span class="kn">import</span> <span class="nn">cv2</span>
<span class="kn">import</span> <span class="nn">os</span>
<span class="kn">import</span> <span class="nn">csv</span>
<span class="kn">import</span> <span class="nn">time</span>
</code></pre>

<p>
Agora, vamos mudar a pasta de trabalho, para onde estão alocadas as
imagens que vamos utilizar. Depois disso, vamos criar um arquivo .csv de
saida que receberá em seu nome a data e hora do processo.
</p>
<pre class="highlight"><code><span class="n">path</span> <span class="o">=</span> <span class="s">&apos;C:/Users/Admin2/Documents/RASTREIA/faces&apos;</span>
<span class="n">os</span><span class="o">.</span><span class="n">chdir</span><span class="p">(</span><span class="n">path</span><span class="p">)</span> <span class="c">#Salva o arquivo com titulo atualizado por data e hora</span>
<span class="n">titulo</span> <span class="o">=</span> <span class="n">time</span><span class="o">.</span><span class="n">strftime</span><span class="p">(</span><span class="s">&quot;</span><span class="si">%</span><span class="s">Y-</span><span class="si">%</span><span class="s">m-</span><span class="si">%</span><span class="s">d&quot;</span><span class="p">)</span> <span class="o">+</span> <span class="s">&apos;_&apos;</span> <span class="o">+</span> <span class="n">time</span><span class="o">.</span><span class="n">strftime</span><span class="p">(</span><span class="s">&quot;</span><span class="si">%</span><span class="s">H-</span><span class="si">%</span><span class="s">M-</span><span class="si">%</span><span class="s">S&quot;</span><span class="p">)</span>
<span class="n">saida</span> <span class="o">=</span> <span class="nb">open</span><span class="p">(</span><span class="s">&apos;face_recon_&apos;</span><span class="o">+</span><span class="n">titulo</span><span class="o">+</span><span class="s">&apos;.csv&apos;</span><span class="p">,</span> <span class="s">&apos;w&apos;</span><span class="p">)</span>
<span class="n">export</span> <span class="o">=</span> <span class="n">csv</span><span class="o">.</span><span class="n">writer</span><span class="p">(</span><span class="n">saida</span><span class="p">,</span> <span class="n">quoting</span><span class="o">=</span><span class="n">csv</span><span class="o">.</span><span class="n">QUOTE_NONNUMERIC</span><span class="p">)</span>
</code></pre>

<p>
Agora, vamos listar todos os arquivos .jpg existentes na pasta de
trabalho.
</p>
<pre class="highlight"><code><span class="n">file_list</span> <span class="o">=</span> <span class="p">[]</span> <span class="k">for</span> <span class="nb">file</span> <span class="ow">in</span> <span class="n">os</span><span class="o">.</span><span class="n">listdir</span><span class="p">(</span><span class="n">path</span><span class="p">):</span> <span class="k">if</span> <span class="nb">file</span><span class="o">.</span><span class="n">endswith</span><span class="p">(</span><span class="s">&quot;.jpg&quot;</span><span class="p">):</span> <span class="n">file_list</span><span class="o">.</span><span class="n">append</span><span class="p">(</span><span class="nb">file</span><span class="p">)</span>
</code></pre>

<p>
Agora, mãos na massa. Criaremos um loop <em>for</em> para realizar as
mesmas tarefas para cada foto. O algoritmo está construído da seguinte
maneira:
</p>
<p>
1.  Estabelecemos 4 objetos com os quatro classificadores;
    </p>
    <p>
    1.  Lê a imagem;
        </p>
        <p>
        1.  Transforma a imagem em tons de cinza (50? kkkkkk);
            </p>
            <p>
            1.  Executamos as quatro classificações e armazenamos os
                resultados em objetos;
                </p>
                <p>
                1.  Cria uma lista com os objetos de resultados;
                    </p>
                    <p>
                    1.  Para cada resultado, plotamos um retângulo onde
                        foram encontradas faces pelos classificadores;
                        </p>
                        <p>
                        1.  Diz ao usuário quantas faces foram
                            encontradas;
                            </p>
                            <p>
                            1.  Cria uma lista com os resultados,
                                transforma num array e calcula média,
                                moda e variância;
                                </p>
                                <p>
                                1.  Escreve no banco de dados .csv o
                                    nome do arquivo da imagem, o número
                                    de faces, média, moda e variância;
                                    </p>
                                    <p>
                                    1.  Exibe uma mensagem reconfortante
                                        de missão cumprida com os
                                        dizeres “Cabô, manolo!” (by
                                        <a href="https://www.facebook.com/wesley.matheus.777701">Wesley
                                        Matheus</a>).
                                        </p>
                                        <p>
                                        Há ainda uma opção para exibir,
                                        uma por uma, as figuras com
                                        os retângulos. Se forem apenas
                                        algumas poucas imagens, é
                                        interessante verificar em tempo
                                        real como está o reconhecimento.
                                        Se forem umas 500 imagens pode
                                        ser que você gaste um tempinho
                                        fazendo isso… Melhor não… Para
                                        habilitar, é só “descomentar” as
                                        três linhas.
                                        </p>
                                        <h3 id="o-comando-detectmultiscale">
                                        O comando detectMultiScale
                                        </h3>
                                        <p>
                                        O comando chave do
                                        reconhecimento facial que aplica
                                        os modelos já implementados no
                                        OpenCV às imagens recebe os
                                        seguintes argumentos: a própria
                                        imagem, um fator escalar que
                                        pode ser corrigido conforme o
                                        tamanho da imagem para melhorar
                                        a qualidade da classificação, um
                                        número mínimo de vizinhos, e o
                                        tamanho mínimo da área a ser
                                        investigada pelo classificador
                                        em pixels. Áreas menores do que
                                        o estabelecido aqui
                                        serão ignoradas.
                                        </p>
                                        <p>
                                        <em>detectMultiScale(image\[,
                                        scaleFactor\[, minNeighbors\[,
                                        flags\[,
                                        minSize\[, maxSize\]\]\]\]\])
                                        -&gt; objects</em>
                                        </p>
                                        <p>
                                        Vamos aos códigos!
                                        </p>
                                        <pre class="highlight"><code><span class="k">for</span> <span class="nb">file</span> <span class="ow">in</span> <span class="n">file_list</span><span class="p">:</span> <span class="c">#Para cada arquivo na lista fa&#xE7;a:</span> <span class="c">#Estabelece os classificadores de face</span> <span class="n">face_cascade</span> <span class="o">=</span> <span class="n">cv2</span><span class="o">.</span><span class="n">CascadeClassifier</span><span class="p">(</span><span class="s">&apos;C:/Users/Admin2/OpenCV3/opencv/sources/data/haarcascades/haarcascade_frontalface_default.xml&apos;</span><span class="p">)</span> <span class="n">face_alt_cascade</span> <span class="o">=</span> <span class="n">cv2</span><span class="o">.</span><span class="n">CascadeClassifier</span><span class="p">(</span><span class="s">&apos;C:/Users/Admin2/OpenCV3/opencv/sources/data/haarcascades/haarcascade_frontalface_alt.xml&apos;</span><span class="p">)</span> <span class="n">face_alt2_cascade</span> <span class="o">=</span> <span class="n">cv2</span><span class="o">.</span><span class="n">CascadeClassifier</span><span class="p">(</span><span class="s">&apos;C:/Users/Admin2/OpenCV3/opencv/sources/data/haarcascades/haarcascade_frontalface_alt2.xml&apos;</span><span class="p">)</span> <span class="n">face_alt_tree_cascade</span> <span class="o">=</span> <span class="n">cv2</span><span class="o">.</span><span class="n">CascadeClassifier</span><span class="p">(</span><span class="s">&apos;C:/Users/Admin2/OpenCV3/opencv/sources/data/haarcascades/haarcascade_frontalface_alt_tree.xml&apos;</span><span class="p">)</span> <span class="c">#L&#xEA; a imagem e converte para escala de cinza</span> <span class="n">img</span> <span class="o">=</span> <span class="n">cv2</span><span class="o">.</span><span class="n">imread</span><span class="p">(</span><span class="nb">file</span><span class="p">)</span> <span class="n">gray</span> <span class="o">=</span> <span class="n">cv2</span><span class="o">.</span><span class="n">cvtColor</span><span class="p">(</span><span class="n">img</span><span class="p">,</span> <span class="n">cv2</span><span class="o">.</span><span class="n">COLOR_BGR2GRAY</span><span class="p">)</span> <span class="c">#Faz as classifica&#xE7;&#xF5;es</span> <span class="n">faces</span> <span class="o">=</span> <span class="n">face_cascade</span><span class="o">.</span><span class="n">detectMultiScale</span><span class="p">(</span><span class="n">gray</span><span class="p">,</span> <span class="mf">1.1</span><span class="p">,</span> <span class="mi">5</span><span class="p">,</span> <span class="n">minSize</span><span class="o">=</span><span class="p">(</span><span class="mi">30</span><span class="p">,</span><span class="mi">30</span><span class="p">))</span> <span class="n">faces2</span> <span class="o">=</span> <span class="n">face_alt_cascade</span><span class="o">.</span><span class="n">detectMultiScale</span><span class="p">(</span><span class="n">gray</span><span class="p">,</span> <span class="mf">1.1</span><span class="p">,</span> <span class="mi">5</span><span class="p">,</span> <span class="n">minSize</span><span class="o">=</span><span class="p">(</span><span class="mi">30</span><span class="p">,</span><span class="mi">30</span><span class="p">))</span> <span class="n">faces3</span> <span class="o">=</span> <span class="n">face_alt2_cascade</span><span class="o">.</span><span class="n">detectMultiScale</span><span class="p">(</span><span class="n">gray</span><span class="p">,</span> <span class="mf">1.1</span><span class="p">,</span> <span class="mi">5</span><span class="p">,</span> <span class="n">minSize</span><span class="o">=</span><span class="p">(</span><span class="mi">30</span><span class="p">,</span><span class="mi">30</span><span class="p">))</span> <span class="n">faces4</span> <span class="o">=</span> <span class="n">face_alt_tree_cascade</span><span class="o">.</span><span class="n">detectMultiScale</span><span class="p">(</span><span class="n">gray</span><span class="p">,</span> <span class="mf">1.1</span><span class="p">,</span> <span class="mi">5</span><span class="p">,</span> <span class="n">minSize</span><span class="o">=</span><span class="p">(</span><span class="mi">30</span><span class="p">,</span><span class="mi">30</span><span class="p">))</span> <span class="c">#Organiza numa as classifica&#xE7;&#xF5;es numa lista para loop</span> <span class="n">classifiers</span> <span class="o">=</span> <span class="p">[</span><span class="n">faces</span><span class="p">,</span> <span class="n">faces2</span><span class="p">,</span> <span class="n">faces3</span><span class="p">,</span> <span class="n">faces4</span><span class="p">]</span> <span class="c"># Coloca os quadrados nas faces</span> <span class="k">for</span> <span class="n">classifier</span> <span class="ow">in</span> <span class="n">classifiers</span><span class="p">:</span> <span class="k">for</span> <span class="p">(</span><span class="n">x</span><span class="p">,</span><span class="n">y</span><span class="p">,</span><span class="n">w</span><span class="p">,</span><span class="n">h</span><span class="p">)</span> <span class="ow">in</span> <span class="n">classifier</span><span class="p">:</span> <span class="n">cv2</span><span class="o">.</span><span class="n">rectangle</span><span class="p">(</span><span class="n">img</span><span class="p">,(</span><span class="n">x</span><span class="p">,</span><span class="n">y</span><span class="p">),(</span><span class="n">x</span><span class="o">+</span><span class="n">w</span><span class="p">,</span><span class="n">y</span><span class="o">+</span><span class="n">h</span><span class="p">),(</span><span class="mi">255</span><span class="p">,</span><span class="mi">0</span><span class="p">,</span><span class="mi">0</span><span class="p">),</span><span class="mi">2</span><span class="p">)</span> <span class="n">roi_gray</span> <span class="o">=</span> <span class="n">gray</span><span class="p">[</span><span class="n">y</span><span class="p">:</span><span class="n">y</span><span class="o">+</span><span class="n">h</span><span class="p">,</span> <span class="n">x</span><span class="p">:</span><span class="n">x</span><span class="o">+</span><span class="n">w</span><span class="p">]</span> <span class="n">roi_color</span> <span class="o">=</span> <span class="n">img</span><span class="p">[</span><span class="n">y</span><span class="p">:</span><span class="n">y</span><span class="o">+</span><span class="n">h</span><span class="p">,</span> <span class="n">x</span><span class="p">:</span><span class="n">x</span><span class="o">+</span><span class="n">w</span><span class="p">]</span> <span class="k">print</span><span class="p">(</span><span class="s">&quot;Para a imagem &quot;</span><span class="o">+</span><span class="nb">file</span><span class="o">+</span><span class="s">&quot;, foram encontradas {0} faces!&quot;</span><span class="o">.</span><span class="n">format</span><span class="p">(</span><span class="nb">len</span><span class="p">(</span><span class="n">classifier</span><span class="p">)))</span> <span class="c">#Exibe as imagens com ret&#xE3;ngulos. Para exibir, descomente as tr&#xEA;s linhas abaixo</span> <span class="c">#cv2.imshow(&apos;img&apos;,img)</span> <span class="c">#cv2.waitKey(0)</span> <span class="c">#cv2.destroyAllWindows()</span> <span class="c"># Exibe a m&#xE9;dia, vari&#xE2;ncia e moda de cada classificador</span> <span class="n">encontrados</span> <span class="o">=</span> <span class="p">[]</span> <span class="k">for</span> <span class="p">(</span><span class="n">classifier</span><span class="p">)</span> <span class="ow">in</span> <span class="n">classifiers</span><span class="p">:</span> <span class="n">x</span> <span class="o">=</span> <span class="n">format</span><span class="p">(</span><span class="nb">len</span><span class="p">(</span><span class="n">classifier</span><span class="p">))</span> <span class="n">encontrados</span><span class="o">.</span><span class="n">append</span><span class="p">(</span><span class="n">x</span><span class="p">)</span> <span class="n">encontrados</span> <span class="o">=</span> <span class="n">np</span><span class="o">.</span><span class="n">asarray</span><span class="p">(</span><span class="n">encontrados</span><span class="p">,</span> <span class="n">dtype</span> <span class="o">=</span> <span class="n">np</span><span class="o">.</span><span class="n">float16</span><span class="p">)</span> <span class="n">media</span> <span class="o">=</span> <span class="n">np</span><span class="o">.</span><span class="n">mean</span><span class="p">(</span><span class="n">encontrados</span><span class="p">)</span> <span class="n">variancia</span> <span class="o">=</span> <span class="n">np</span><span class="o">.</span><span class="n">var</span><span class="p">(</span><span class="n">encontrados</span><span class="p">)</span> <span class="n">moda</span> <span class="o">=</span> <span class="nb">float</span><span class="p">(</span><span class="n">mode</span><span class="p">(</span><span class="n">encontrados</span><span class="p">)[</span><span class="mi">0</span><span class="p">])</span> <span class="k">if</span> <span class="nb">file</span> <span class="o">==</span> <span class="n">file_list</span><span class="p">[</span><span class="mi">0</span><span class="p">]:</span> <span class="n">export</span><span class="o">.</span><span class="n">writerow</span><span class="p">([</span><span class="s">&quot;imagem&quot;</span><span class="p">,</span><span class="s">&quot;media&quot;</span><span class="p">,</span><span class="s">&quot;variancia&quot;</span><span class="p">,</span><span class="s">&quot;moda&quot;</span><span class="p">])</span> <span class="n">export</span><span class="o">.</span><span class="n">writerow</span><span class="p">([</span><span class="nb">file</span><span class="p">,</span> <span class="n">media</span><span class="p">,</span> <span class="n">variancia</span><span class="p">,</span> <span class="n">moda</span><span class="p">])</span> <span class="k">else</span><span class="p">:</span> <span class="n">export</span><span class="o">.</span><span class="n">writerow</span><span class="p">([</span><span class="nb">file</span><span class="p">,</span> <span class="n">media</span><span class="p">,</span> <span class="n">variancia</span><span class="p">,</span> <span class="n">moda</span><span class="p">])</span> <span class="n">saida</span><span class="o">.</span><span class="n">close</span><span class="p">()</span> <span class="k">print</span> <span class="s">&apos;Cab&#xF4;, manolo!&apos;</span>
                                        </code></pre>

                                        <pre class="highlight"><code>Para a imagem galera2.jpg, foram encontradas 7 faces!
                                        Para a imagem galera2.jpg, foram encontradas 3 faces!
                                        Para a imagem galera2.jpg, foram encontradas 3 faces!
                                        Para a imagem galera2.jpg, foram encontradas 0 faces!
                                        Para a imagem image_preview (1).jpg, foram encontradas 0 faces!
                                        Para a imagem image_preview (1).jpg, foram encontradas 0 faces!
                                        Para a imagem image_preview (1).jpg, foram encontradas 0 faces!
                                        Para a imagem image_preview (1).jpg, foram encontradas 0 faces!
                                        Para a imagem image_preview (2).jpg, foram encontradas 0 faces!
                                        Para a imagem image_preview (2).jpg, foram encontradas 0 faces!
                                        Para a imagem image_preview (2).jpg, foram encontradas 0 faces!
                                        Para a imagem image_preview (2).jpg, foram encontradas 0 faces!
                                        Para a imagem image_preview (3).jpg, foram encontradas 0 faces!
                                        Para a imagem image_preview (3).jpg, foram encontradas 0 faces!
                                        Para a imagem image_preview (3).jpg, foram encontradas 0 faces!
                                        Para a imagem image_preview (3).jpg, foram encontradas 0 faces!
                                        Para a imagem image_preview (4).jpg, foram encontradas 0 faces!
                                        Para a imagem image_preview (4).jpg, foram encontradas 0 faces!
                                        Para a imagem image_preview (4).jpg, foram encontradas 0 faces!
                                        Para a imagem image_preview (4).jpg, foram encontradas 0 faces!
                                        Para a imagem image_preview.jpg, foram encontradas 0 faces!
                                        Para a imagem image_preview.jpg, foram encontradas 0 faces!
                                        Para a imagem image_preview.jpg, foram encontradas 0 faces!
                                        Para a imagem image_preview.jpg, foram encontradas 0 faces!
                                        Para a imagem Inauguracao-placa-turma.jpg, foram encontradas 2 faces!
                                        Para a imagem Inauguracao-placa-turma.jpg, foram encontradas 2 faces!
                                        Para a imagem Inauguracao-placa-turma.jpg, foram encontradas 3 faces!
                                        Para a imagem Inauguracao-placa-turma.jpg, foram encontradas 0 faces!
                                        Para a imagem letras 2010.jpg, foram encontradas 18 faces!
                                        Para a imagem letras 2010.jpg, foram encontradas 19 faces!
                                        Para a imagem letras 2010.jpg, foram encontradas 19 faces!
                                        Para a imagem letras 2010.jpg, foram encontradas 15 faces!
                                        Para a imagem turma-2010 (1).jpg, foram encontradas 0 faces!
                                        Para a imagem turma-2010 (1).jpg, foram encontradas 0 faces!
                                        Para a imagem turma-2010 (1).jpg, foram encontradas 0 faces!
                                        Para a imagem turma-2010 (1).jpg, foram encontradas 0 faces!
                                        Para a imagem turma-2010-2.jpg, foram encontradas 22 faces!
                                        Para a imagem turma-2010-2.jpg, foram encontradas 14 faces!
                                        Para a imagem turma-2010-2.jpg, foram encontradas 17 faces!
                                        Para a imagem turma-2010-2.jpg, foram encontradas 5 faces!
                                        Para a imagem Turma-2010.jpg, foram encontradas 47 faces!
                                        Para a imagem Turma-2010.jpg, foram encontradas 30 faces!
                                        Para a imagem Turma-2010.jpg, foram encontradas 33 faces!
                                        Para a imagem Turma-2010.jpg, foram encontradas 10 faces!
                                        Para a imagem Turma2010.jpg, foram encontradas 7 faces!
                                        Para a imagem Turma2010.jpg, foram encontradas 7 faces!
                                        Para a imagem Turma2010.jpg, foram encontradas 7 faces!
                                        Para a imagem Turma2010.jpg, foram encontradas 3 faces!
                                        Cab&#xF4;, manolo!
                                        </code></pre>

                                        <p>
                                        Depois disso, podemos importar o
                                        banco de dados para o Python
                                        (ou R) e verificar como foi
                                        a classificação. Vejam também um
                                        exemplo de uma imagem após o
                                        reconhecimento:
                                        </p>
                                        <pre class="highlight"><code><span class="kn">import</span> <span class="nn">pandas</span> <span class="kn">as</span> <span class="nn">pd</span>
                                        <span class="n">dados</span> <span class="o">=</span> <span class="n">pd</span><span class="o">.</span><span class="n">read_csv</span><span class="p">(</span><span class="s">&apos;face_recon_2017-02-21_11-38-28.csv&apos;</span><span class="p">)</span>
                                        <span class="k">print</span><span class="p">(</span><span class="n">dados</span><span class="p">)</span>
                                        </code></pre>

                                        <pre class="highlight"><code> imagem media variancia moda
                                        0 galera2.jpg 3.25 6.1875 3.0
                                        1 image_preview (1).jpg 0.00 0.0000 0.0
                                        2 image_preview (2).jpg 0.00 0.0000 0.0
                                        3 image_preview (3).jpg 0.00 0.0000 0.0
                                        4 image_preview (4).jpg 0.00 0.0000 0.0
                                        5 image_preview.jpg 0.00 0.0000 0.0
                                        6 Inauguracao-placa-turma.jpg 1.75 1.1875 2.0
                                        7 letras 2010.jpg 17.75 2.6875 19.0
                                        8 turma-2010 (1).jpg 0.00 0.0000 0.0
                                        9 turma-2010-2.jpg 14.50 38.2500 5.0
                                        10 Turma-2010.jpg 30.00 174.5000 10.0
                                        11 Turma2010.jpg 6.00 3.0000 7.0
                                        </code></pre>

                                        <p>
                                        <img src="http://neylsoncrepalde.github.io/img/2017-02-21-reconhecimento-facial/face_rec_marcado.jpg" alt="">
                                        </p>
                                        <p>
                                        Por hoje é só. Comentários são
                                        sempre bem vindos. Até a
                                        próxima! Abraços
                                        </p>
                                        </article>
                                        <p class="blog-tags">
                                        Tags: Python, Machine Learning,
                                        Facial Recognition, OpenCV
                                        </p>
                                        </div>

