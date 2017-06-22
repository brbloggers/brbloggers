brbloggers
=====================

Esse repositório contém o código fonte do página do **brbloggers**, agregador
de blogs em português sobre R.

Qualquer um pode incluir o seu blog feed. Para isso, basta abrir um issue [aqui](https://github.com/brbloggers/brbloggers/issues) ou fazer um PR neste repositório
adicionando o seu blog no arquivo `feeds.R` e modificando o arquivo `main.R` para se adaptar
ao seu blog. Você terá que adiconar algo parecido com isso no `main.R`:

```
all_feeds$`curso-r` <- all_feeds$`curso-r` %>%
  select(
    feed_title,
    feed_link,
    item_title,
    item_date_published,
    item_link
  )
```

Basta ter certeza de que o seu feed tem todas e apenas essas colunas corretamente preenchidas.

# Algumas recomendações

Qualquer pessoa pode incluir o seu blog no **brbloggers** desde que siga as seguintes regras:

* O feed inscrito deve ser sobre R
* As postagens devem ser escritas em português

Também temos algumas recomendações:

* Prefira posts mais longos à posts no estilo *tweet*
* Não poste muitas vezes no mesmo dia (isso pode ser considerado spam)

# Copyrights

Ao inscrever o seu blog no **brbloggers**, você dá o direito ao site de reproduzir o seu conteúdo 
desde que com links diretos para as postagens originais. 
Você pode remover/solicitar a remoção do seu blog a qualquer momento.



