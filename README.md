# Batalha de Jatos

Trabalho desenvolvido para a disciplina de Inteligência Artificial da UFES, campus Alegre.

Ele segue a linha de trabalhos em Prolog que tenho elaborado para meus alunos. Os primeiros trabalhos foram:
* [Corrida em Prolog](https://github.com/jeiks/corrida_em_prolog)
* [Batalha de Tanques](https://github.com/jeiks/batalha_tanques)

O código inicial da corrida foi uma adaptação do projeto do Radu Mariescu-Istodor:
[Self-driding car - No libraries - JavaScript Course](https://www.youtube.com/watch?v=NkI9ia2cLhc)

Atualmente, já tiveram muitas modificações e a implementação da batalha de tanques e de jatos.

Se você quiser testar, acesse [http://jeiks.net/prolog_jatos](https://www.jeiks.net/prolog_jatos/)

Use as setas para direcionar seu Jato, ENTER ou ESPAÇO para atirar e tecla "s" para os placares instantâneos.
 
### Instruções
Há várias formas de utilizar esse código, escolhendo colocar um jato movido pelo teclado, nenhum ou vários jatos movidos aleatoriamente pelo JavaScript e nenhum ou vários jatos movidos pelo Prolog.

Para isso, edite as seguintes linhas do arquivo "main.js":

```js
dummyJets=10, // quantidade de jatos aleatórios
keysJet=true, // modifique para ter um jato controlado pelo teclado
prologJets=["Ligerin", "ApagaFogo"], // nomes (e quantidade) dos jatos movidos pelo prolog
```

Caso não tenham jatos movidos pelo Prolog, deixe o vetor referente vazio:
```js
prologJets=[],
```

Quando não há jatos movidos pelo Prolog, você pode executar o arquivo index.html diretamente no navegador de Internet (obs. foi testado no Brave Browser).

Caso existam jatos movidos pelo Prolog, siga os passos abaixo.

### Como executar o servidor pelo Prolog

1. Instale o SWI-Prolog [https://www.swi-prolog.org/](https://www.swi-prolog.org/)
2. Baixe esse repositório: ``git clone https://github.com/jeiks/prolog_jatos``
3. Entre no diretório criado: ``cd prolog_jatos``
4. E execute o comando: ``swipl -s servidor.pl`` (ou abra esse arquivo no swi-prolog)

Ele já inicia o servidor automaticamente e exibe a seguinte mensagem:
<pre>
   --========================================--

   % Started server at http://localhost:8080/


   --========================================--
</pre>

Agora então, é só ir ao navegador de internet e acessar o endereço acima.

A implentação aqui está fornecendo dois jatos que tem movimentos aleatórios.

O primeiro é implementado no arquivo "jato0.pl" e o seguindo no arquivo "jato1.pl".

Ao adicionar mais jatos no "main.js", edite o arquivo "jatos_controle.pl", seguindo os exemplos já apresentados lá.

Para implementar a inteligência dos jatos, edite e siga as intruções do arquivo "jato0.pl" ou "jato1.pl"

Have fun =)

### Informações adicionais

Abaixo estão os sensores e também o valor do ângulo do jato:

![informação](./doc/info.png)
