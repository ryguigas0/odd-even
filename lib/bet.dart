import 'package:flutter/material.dart';

class Bet extends StatefulWidget {
  Function callback;
  String playerName;

  Bet(this.callback, this.playerName);

  @override
  State<StatefulWidget> createState() => BetState(callback, playerName);
}

class BetState extends State<Bet> {
  // funcao para trocar de tela
  Function callback;
  String playerName;
  int num = 1;
  int betValue = 0;
  int oddEven = 1;

  BetState(this.callback, this.playerName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$playerName bet'),
      ),
      body: Column(
        children: [
          const Text('Choose a number (1-5)'),
          Slider(
            label: '$num',
            min: 1,
            max: 5,
            divisions: 5,
            value: num.toDouble(),
            onChanged: (value) {
              setState(() {
                num = value.toInt();
              });
            },
          ),
          const Text('Bet value'),
          Slider(
            label: '$betValue',
            min: 0,
            max: 100,
            divisions: 10,
            value: betValue.toDouble(),
            onChanged: (value) {
              setState(() {
                betValue = value.toInt();
              });
            },
          ),
          Row(
            children: [
              const Text('Odd'),
              Radio(
                  value: 1,
                  groupValue: oddEven,
                  onChanged: (int? value) {
                    setState(() {
                      oddEven = 1;
                    });
                  }),
              const Text('Even'),
              Radio(
                  value: 2,
                  groupValue: oddEven,
                  onChanged: (int? value) {
                    setState(() {
                      oddEven = 2;
                    });
                  })
            ],
          ),
          ElevatedButton(
              child: const Text('Choose adversary'),
              onPressed: () => callback(betValue, oddEven, num))
        ],
      ),
    );
  }
}
