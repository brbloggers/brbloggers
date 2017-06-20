+++
title = "INTRODUÇÃO AO R - Exercício 1"
date = "2016-09-26 03:00:00"
categories = ["r-python-e-redes"]
original_url = "http://neylsoncrepalde.github.io/2016-09-26-introducao-ao-r-exercicio-1/"
+++

<div>
<article class="blog-post">
<p>
Esses exercícios correspondem à aula 1. Você deve enviar por e-mail um
script com os códigos comentados que geram as respostas corretas das
questões. O e-mail deve ter o seguinte assunto: <strong>MQuinho -
Introdução ao R - Exercício 1</strong>. Atenção! Data de entrega:
<strong>27 de setembro!</strong>
</p>
<p>
1.  Execute cada um desses comandos no
    <code class="highlighter-rouge">R</code> e explique o que cada um
    faz num comentário.
    </p>
    <pre class="highlight"><code><span class="m">7</span><span class="w"> </span><span class="o">*</span><span class="w"> </span><span class="m">9</span><span class="w">
    </span><span class="m">4</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="m">4</span><span class="w">
    </span><span class="n">x</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="m">3</span><span class="w"> </span><span class="o">-</span><span class="w"> </span><span class="m">10</span><span class="w">
    </span><span class="n">y</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="n">x</span><span class="w"> </span><span class="o">+</span><span class="w"> </span><span class="m">8</span><span class="w">
    </span><span class="m">20</span><span class="w"> </span><span class="o">%%</span><span class="w"> </span><span class="m">3</span><span class="w">
    </span><span class="nf">sqrt</span><span class="p">(</span><span class="m">256</span><span class="p">)</span><span class="w">
    </span><span class="m">45</span><span class="o">^</span><span class="m">2</span><span class="w">
    </span><span class="m">968</span><span class="o">^</span><span class="p">(</span><span class="m">1</span><span class="o">/</span><span class="m">3</span><span class="p">)</span><span class="w">
    </span><span class="nf">exp</span><span class="p">(</span><span class="m">6</span><span class="p">)</span><span class="o">/</span><span class="nf">log</span><span class="p">(</span><span class="m">156</span><span class="p">)</span><span class="w">
    </span></code></pre>

    <p>
    1.  Crie dois vetores. 1 vetor chamado
        <code class="highlighter-rouge">nomes</code> com os nomes das
        pessoas que moram na sua casa e outro chamado
        <code class="highlighter-rouge">idades</code> com as idades de
        cada um deles.
        </p>
        <p>
        1.  Use um comando para mostrar a classe desses vetores e um
            comando para verificar o tamanho dos vetores.
            </p>
            <p>
            1.  Use um comando para juntar esses dois vetores como
                colunas e criar um
                <code class="highlighter-rouge">data.frame</code>.
                Verifique as dimensões do seu banco de dados.
                </p>
                <p>
                1.  Com apenas um comando, crie cada um dos seguintes
                    vetores:
                    </p>
                    <pre class="highlight"><code>## [1] 1 2 3 4 5 6 7 8 9 10 ## [1] 2 4 6 8 10 12 14 16 18 20 ## [1] 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0 2.1 2.2 2.3 2.4 2.5 2.6
                    ## [18] 2.7 2.8 2.9 3.0 3.1 3.2 3.3 3.4 3.5 3.6 3.7 3.8 3.9 4.0 4.1 4.2 4.3
                    ## [35] 4.4 4.5 4.6 4.7 4.8 4.9 5.0 ## [1] 1 2 3 1 2 3 1 2 3 ## [1] 1 1 1 1 1 2 2 2 2 2 3 3 3 3 3
                    </code></pre>

                    <p>
                    1.  Com apenas um comando, crie cada uma das
                        seguintes matrizes:
                        </p>
                        <pre class="highlight"><code>## [,1] [,2] [,3] [,4]
                        ## [1,] 1 11 21 31
                        ## [2,] 2 12 22 32
                        ## [3,] 3 13 23 33
                        ## [4,] 4 14 24 34
                        ## [5,] 5 15 25 35
                        ## [6,] 6 16 26 36
                        ## [7,] 7 17 27 37
                        ## [8,] 8 18 28 38
                        ## [9,] 9 19 29 39
                        ## [10,] 10 20 30 40 ## [,1] [,2] [,3] [,4]
                        ## [1,] 1 2 3 4
                        ## [2,] 5 6 7 8
                        ## [3,] 9 10 11 12
                        ## [4,] 13 14 15 16
                        ## [5,] 17 18 19 20
                        ## [6,] 21 22 23 24
                        ## [7,] 25 26 27 28
                        ## [8,] 29 30 31 32
                        ## [9,] 33 34 35 36
                        ## [10,] 37 38 39 40 ## [,1] [,2] [,3] [,4]
                        ## [1,] 16 80 144 208
                        ## [2,] 32 96 160 224
                        ## [3,] 48 112 176 240
                        ## [4,] 64 128 192 256
                        </code></pre>

                        <p>
                        1.  Crie uma lista com o
                            <code class="highlighter-rouge">data.frame</code>
                            que você criou, a primeira matriz, um vetor
                            numérico à sua escolha e um vetor de texto à
                            sua escolha. Apresente a lista.
                            </p>
                            <h3 id="divirta-se">
                            Divirta-se!
                            </h3>
                            </article>
                            <p class="blog-tags">
                            Tags: R programming, rstats
                            </p>
                            </div>

