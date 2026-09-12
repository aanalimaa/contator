import 'package:flutter/material.dart';

void main() {
  runApp(const ContadorApp());
  // Liga o motor do Flutter e entrega o widget raiz (ContatorApp)
}
class ContadorApp extends StatelessWidget {
  // Essa classe é apenas uma casca de configuração do app
  // Ela não guarda nenhum dado, por isso é statelesswidget
  const ContadorApp({super.key});
  // Construtorm, repaasando a key para o widget pai identificar

  @override
  Widget build(BuildContext context) {
    //Monta e devolve a configuração geral do Aplicativo
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contador de Inspeção',
      // Título interno do App, do navegador
      home: const TelaContador(),
      // A tela inicial do App é o widget TelaContador, definido logo abaixo
    );
  }
}
class TelaContador extends StatefulWidget {
  // Isso é novo em relação ao Projeto 1 (crachá);
  // Agora, a tela precisa lembrar de dados que mudam (a contagem, o nome digitado e o histórico).
  // Esta classe ainda não está guardando nada sozinha, mas ela já declara que existe um State associado a ela.
  const TelaContador({super.key});

  @override
  State<TelaContador> createState() => _TelaContadorState();
  //creastate é o método que o Flutter chama para criar o objeto
  //de estado (_TelaContadorState) ligado a este widget.
}
  class _TelaContadorState extends State<TelaContador>{
    //esta é a classe que efetivamente guarda os dados que podem mudar
    //durante o uso do app. funciona como um 'cofre' que sobrevive entre
    //uma reconstrução e outras telas.
    int _pecasAprovadas = 0;
    //variavel que guarda a contagem atual de peças aprovadas, começando em 0.
    final _nomeController = TextEditingController();
    //TestEditingController é a ponte entre o que apare na tela (textfild)
    //eo nosso código dart. guarda o texto digitado e o permite lê-lo a qualquer momento
    //em '_nomeController.text'. o final é pq o Controller em si nunca muda (msp aponta para o mesmo objeto),
    //quem muda é o texto dentro dele.

    final List<String>_registros=[];
    //Lista vazia de textos que vai guardar o histórico de registros
    //de inspeção fechados no turno.

    void _aprovarPeca(){
      //Função chamada toda vez que o botão "+1 peça" é tocado pelo usuário
      setState((){
        //Sempre que um dado do "state" muda, essa alteração
        //precisa ocorrer dentro do SetState, para que o Flutter
        //saiba que precisa redesenhar a tela com o novo valor.
        _pecasAprovadas += 1;
        //incrementa a contagem de peças em1.
      });
    }

    void _registrarEZerar(){
      //função chamada quando o botão "registrar e zerar" é tocado pelo usuário
      final nome=_nomeController.text.trim().isEmpty
          ? 'Sem nome'
          : _nomeController.text.trim();
          //operador ternário (condição?valorVerdadeiro : valorFalso)
          //.trim() remove espaços em branco do texto 
          // se, depois disso o texto estiver vazio, usamos
          //"não informado"; senão, usamos o nome digitado.

          setState((){
            // de novo, toda mudança do State entra no SetState.
            _registros.add('$nome - $_pecasAprovadas peças(s)');
            //monta um texto combinando o nome e a contagem atual (interpolação de string)
            //adiciona esse texto montado no final da lista de registros
            _pecasAprovadas = 0;
            //zera o contador para o inspetor começar a contar o próximo lote de peças.
          });

    }

    @override
    void dispose(){
      //dispose é chamado pelo Flutter quando a tela é removida da árvore 
      //de widgets, ou seja, quando o usuário sai da tela.
      _nomeController.dispose();
      //libera os recursos do controller (evita deixar memória alocada/em uso)
      super.dispose();
      //chama a implementação original/nativa do dispose da classe pai
      //deve ser sempre a última linha da função dispose, para garantir
      //que tudo seja limpo corretamente.

    }

    @override
    Widget build(BuildContext context){
      //monta e devolve a árvore de widgets que representa a tela 
      //no estado ATUAL (com os valores atuais de _pecasAprovadas,
      //_nomeController.text e _registros)
      return Scaffold(
        //esqueleto padrão de uma tela do Flutter
        appBar:AppBar(
          title: Text('Inspeção de Peças'),
          //título fixo na barra do topo da tela
        ),

        body: Padding(
          //corpo da tela com espaçamento interno ao redor de todos os elementos
          padding: const EdgeInsets.all(16.0),
          child: Column(
            //já sabemos que o column organiza todo o conteúdo da tela verticalmente
            //ex: (nome, textos, números da contagem, botões, etc)
            children: [
              TextField(
                //campo de texto onde o inspetor digita o nome dele
                controller: _nomeController,
                //liga este campo ao controller declarado lá emm cima
                //é assim que conseguimos ler o texto digitado
                decoration: const InputDecoration(
                  labelText: "Nome do Inspetor do Turno",
                  border: OutlineInputBorder(),
                  //desenha um contorno ao redor da caixa de texto
                ),

                onChanged:(texto){
                  //onChanged é chamado pelo Flutter toda vez que o usuário digita ou apaga 
                  //um caractere
                  setState((){});
                    //chamamos o setState com um bloco vazio só para forçar a tela
                    //a se redesenhar. O dado em si (_nomeController.text) já 
                    //foi atualizado pelo controller, só precisamos avisar o Flutter
                    //para reler esse valor no Text logo abaixo.                  
                },
              ),

              const SizedBox(height: 16),
              //espaço vertical entre esse campo de textp e a linha de "responsável..."

              Text(
                _nomeController.text.trim().isEmpty
                  ? 'Responsável: Não informado'
                  : 'Resposável: ${_nomeController.text.trim()}',
                  //se o campo ainda está vazio, mostramos um aviso, senão,
                  //mostramos o nome digitado (interpolado dentro do texto com ${})
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),

              const SizedBox(height: 16),
              Text(
                '$_pecasAprovadas',
                style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                //fonte bem grande e em negrito, para destacar a contagem de peças
              ),

              Row(
                //linha horizontal com os dois botões
                mainAxisAlignment: MainAxisAlignment.center,
                //centraliza os botões no eixo principal da row (horizontal)
                children: [
                  FilledButton.icon(
                    //estilo de botão já preenchido.
                    //será usado para aprovar a peça.
                    onPressed: _aprovarPeca,
                    //quando tocado, o botão chama a função _aprovarPeca
                    //essa é uma forma curta/abreviada de escrever: onPressed: (){_aprovarPeca();}
                    icon: const Icon(Icons.add),
                    label: const Text('1 Peca'),
                    //texto do botão
                  ),

                  const SizedBox(width: 12),

                  OutlinedButton.icon(
                    //botão com apenas contorno, sem preenchimento
                    //usado aqui para indicar uma ação 'secundária' (registrar e zerar).
                    onPressed: _registrarEZerar,
                    //ao tocar, chama a funçaõ registrar e zerar
                    icon: const Icon(Icons.save_alt),
                    label: const Text('Registrar e Zerar'),
                  ),

                ],
              ),

               const SizedBox(width: 16),
                  
                  const Align(
                    //Align posiciona seus filhos dentro do espaço disponível
                    //vamos usar aqui para forçar o título da lista a ficar alinhado à esquerda,
                    //mesmo estando dentro de uma row que centraliza os botões.
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Histórico do Turno',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),

                  const SizedBox(height: 8),
                  Expanded(
                    //dentro da column, o expanded força  espaço vertical disponível/restante;
                    //é ele que dá a altura disponível para rolar.
                    child: _registros.isEmpty
                      ? const Center(child: Text('Nenhum registro ainda'))
                      : ListView.builder(
                          itemCount: _registros.length,
                          itemBuilder: (context, index){
                            //List.View.builder é um widget que contrói uma lista rolável
                            return Card(
                              child: ListTile(
                                leading: const Icon(Icons.history),
                                //leading é o ícone à esquerda do texto
                                title: Text(_registros[index]),
                                //title é o texto principal do item da lista
                              ),
                            );
                          },
                    ),
                  ),
            ],
          ),
        ),
      );
    }

  }
