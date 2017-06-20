+++
title = "INTRODUÇÃO AO R - Exercício 2"
date = "2016-09-27 03:00:00"
categories = ["r-python-e-redes"]
original_url = "http://neylsoncrepalde.github.io/2016-09-27-introducao-ao-r-exercicio2/"
+++

<div>
<article class="blog-post">
<p>
<strong>Data de entrega: 28 de setembro</strong>
</p>
<h3 id="pnad">
PNAD
</h3>
<p>
Abra o banco de dados da PNAD 2012. Você precisará usar um comando de um
pacote específico já que o arquivo é do SPSS (.sav). Depois disso:
</p>
<p>
1.  Usando um comando, tire as estatísticas descritivas de todas as
    variáveis do banco de dados.
    </p>
    <p>
    1.  Tire um histograma da variável renda mensal do trabalho
        principal (use o dicionário disponibilizado para descobrir o
        código da variável). Não se esqueça de codificar 999999999999
        como NA antes. Use o comando abaixo:
        </p>
        <pre class="highlight"><code><span class="n">pnad</span><span class="o">$</span><span class="n">V</span><span class="m">4718</span><span class="p">[</span><span class="n">pnad</span><span class="o">$</span><span class="n">V</span><span class="m">4718</span><span class="w"> </span><span class="o">&gt;=</span><span class="w"> </span><span class="m">999999999999</span><span class="p">]</span><span class="w"> </span><span class="o">=</span><span class="w"> </span><span class="kc">NA</span><span class="w">
        </span></code></pre>

        <p>
        1.  Tire um boxplot da variável idade por categorias de sexo. O
            que você pode comentar de relevante sobre o gráfico?
            </p>
            <p>
            1.  Agora, com um comando, execute um teste estatístico para
                verificar se as médias da renda mensal do trabalho
                principal entre homens e mulheres são
                estatisticamente diferentes. Interprete o resultado.
                </p>
                <h3 id="enade">
                Enade
                </h3>
                <p>
                Agora, abra o banco de dados do Enade 2014.
                </p>
                <p>
                1.  Tire um histograma da nota geral dos alunos no
                    Enade (nt\_ger).
                    </p>
                    <p>
                    1.  Agora tire um histograma da nota geral dos
                        alunos apenas para os alunos do curso de
                        licenciatura em ciências sociais (dica: faça um
                        <em>subsetting</em> das linhas onde a variável
                        co\_grupo seja igual a 5402).
                        </p>
                        <p>
                        1.  Agora, use um comando para gerar uma tabela
                            de frequência e um gráfico para verificar as
                            categorias de renda dos estudantes (qe\_i8).
                            Antes disso, transforme a variável numa
                            classe
                            <code class="highlighter-rouge">factor</code>
                            e coloque os labels corretos (use o comando
                            <code class="highlighter-rouge">levels()</code>
                            e o questionário do aluno para ajudar).
                            </p>
                            <p>
                            1.  Vamos investigar se os alunos que
                                entraram nas faculdades via ações
                                afirmativas tem desempenho no Enade
                                diferente dos que não entraram por
                                esse mecanismo. Para isso precisamos
                                recodificar a variável <strong>Entrou
                                por ação afirmativa</strong> (qe\_i15)
                                para uma variável binária. Use o
                                seguinte comando:
                                </p>
                                <pre class="highlight"><code><span class="c1"># Criando a variavel dummy acao.afirmativa. 0 = N&#xE3;o, 1 = Sim
                                </span><span class="n">enade</span><span class="o">$</span><span class="n">acao.afirmativa</span><span class="w"> </span><span class="o">&lt;-</span><span class="w"> </span><span class="n">ifelse</span><span class="p">(</span><span class="n">enade</span><span class="o">$</span><span class="n">qe_i15</span><span class="o">==</span><span class="s2">&quot;a&quot;</span><span class="p">,</span><span class="w"> </span><span class="m">0</span><span class="p">,</span><span class="w"> </span><span class="m">1</span><span class="p">)</span><span class="w">
                                </span></code></pre>

                                <p>
                                Agora você já sabe qual teste
                                estatístico usar. Comente o resultado.
                                </p>
                                <p>
                                1.  Vamos montar um modelo de
                                    regressão linear. O seu objetivo é
                                    modelizar o desempenho do aluno
                                    (medido pela sua nota geral) como
                                    função da cor, do sexo e da
                                    escolarização da mãe (qe\_i5). Não
                                    se esqueça de recodificar a variável
                                    sexo renomeando a categoria
                                    <strong>N</strong> para NA. Você já
                                    sabe como fazer isso. Após estimar o
                                    modelo, apresente os resultados
                                    e interprete.
                                    </p>
                                    <h2 id="divirta-se">
                                    Divirta-se!
                                    </h2>
                                    </article>
                                    <p class="blog-tags">
                                    Tags: R programming, rstats
                                    </p>
                                    </div>

