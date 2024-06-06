import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  Function callback;
  String playerName;
  int playerPoints;

  Profile(this.callback, this.playerName, this.playerPoints);

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${playerName} profile'),
        ),
        body: Column(
          children: [
            Text('Points: ${playerPoints}'),
            ElevatedButton(
                child: const Text('Make another bet'),
                onPressed: () => callback(1))
          ],
        ));
  }
}
