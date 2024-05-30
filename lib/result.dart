import 'package:flutter/material.dart';

// As apostas são comparadas e o resultado exibido
class Result extends StatelessWidget {

  // funcao para trocar de tela
  Function callback;

  Result(this.callback);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Result'),),
      body: TextButton(child: Text('New bet'), onPressed: () => callback(1)),
    );
  }

}