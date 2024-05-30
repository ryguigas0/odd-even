import 'package:flutter/material.dart';

class PlayerList extends StatelessWidget {
  Function callback;

  PlayerList(this.callback);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Player list'),
      ),
      body: TextButton(child: Text('Results'), onPressed: () => callback(3)),
    );
  }
}
