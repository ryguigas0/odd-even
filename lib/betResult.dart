import 'package:flutter/material.dart';

class BetResult extends StatefulWidget {
  Function callback;

  BetResult(this.callback);

  @override
  State<StatefulWidget> createState() => BetResultState(callback);
}

class BetResultState extends State<BetResult> {
  // funcao para trocar de tela
  Function callback;
  
  BetResultState(this.callback);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bet result'),
      ),
      body: ElevatedButton(
                child: const Text('Make another bet'), onPressed: () => callback(2))
    );
  }
}
