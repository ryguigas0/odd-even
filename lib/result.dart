import 'package:flutter/material.dart';

// As apostas são comparadas e o resultado exibido
class Result extends StatelessWidget {
  // funcao para trocar de tela
  Function anotherBetCallback;
  Function playerProfileCallback;
  String challenger;
  String challenged;
  String currBetResult;

  Result(this.anotherBetCallback, this.playerProfileCallback, this.challenged,
      this.challenger, this.currBetResult);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result: ' + challenger + ' vs. ' + challenged),
      ),
      body: Column(
        children: [
          Text(currBetResult),
          ElevatedButton(
              child: const Text('Make another bet'),
              onPressed: () => anotherBetCallback()),
          ElevatedButton(
              child: const Text('Profile'),
              onPressed: () => playerProfileCallback())
        ],
      ),
    );
  }
}
