import 'package:flutter/material.dart';

// As apostas são comparadas e o resultado exibido
class Result extends StatelessWidget {
  // funcao para trocar de tela
  Function callback;
  String challenger;
  String challenged;
  String currBetResult;

  Result(this.callback, this.challenged, this.challenger, this.currBetResult);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result: ' + challenger + ' vs. ' + challenged),
      ),
      body: Column(
        children: [
          Text(currBetResult),
          TextButton(child: Text('New bet'), onPressed: () => callback(1))
        ],
      ),
    );
  }
}
