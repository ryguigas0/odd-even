// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'bet.dart';
import 'playerList.dart';
import 'register.dart';
import 'result.dart';

void main() => runApp(OddEven());

class OddEven extends StatefulWidget {
  @override
  State<OddEven> createState() => OddEvenState();
}

class OddEvenState extends State<OddEven> {
  // 0 -> register
  // 1 -> player board
  // 2 -> game
  // 3 -> game result
  var currScreen = 0;
  var playerName = "";

  void changeScreen(int newScreen) {
    setState(() {
      currScreen = newScreen;
    });
  }

  void setPlayerName(String newPlayerName) {
    setState(() {
      playerName = newPlayerName;
    });
  }

  void registerPlayer(String name) {
    playerName = name;
    changeScreen(1);
  }

  Widget showScreen() {
    switch (currScreen) {
      case 1:
        return Bet(changeScreen, playerName);
      case 2:
        return PlayerList(changeScreen);
      case 3:
        return Result(changeScreen);
      default:
        return Register(registerPlayer);
    }
  }

  @override
  Widget build(BuildContext ctx) {
    return MaterialApp(
      title: 'Odd or Even',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
          useMaterial3: true),
      home: showScreen(),
    );
  }
}
