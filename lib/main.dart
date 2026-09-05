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
  }
