import 'package:even_odd/main.dart';
import 'package:flutter/material.dart';

class PlayerList extends StatelessWidget {
  Function callback;
  List<Player> playerList = [];
  var currPlayerName;

  PlayerList(this.callback, this.playerList, this.currPlayerName);

  @override
  Widget build(BuildContext context) {
    print(playerList);
    return Scaffold(
        appBar: AppBar(
          title: Text('Player list'),
        ),
        body: Column(
          children: [
            Column(
              children: playerList
                  .where((player) => player.username != currPlayerName)
                  .map((player) => Row(
                        children: [
                          Text(player.username),
                          ElevatedButton(
                              child: const Text('Bet against'),
                              onPressed: () => callback(3)),
                        ],
                      ))
                  .toList(),
            ),
            ElevatedButton(
                child: const Text('Results'), onPressed: () => callback(3)),
          ],
        ));
  }
}
