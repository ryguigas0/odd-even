// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'bet.dart';
import 'playerList.dart';
import 'register.dart';
import 'result.dart';

void main() => runApp(OddEven());

class OddEven extends StatefulWidget {
  @override
  State<OddEven> createState() => OddEvenState();
}

class Player {
  var username;
  var points;

  Player(this.username, this.points);

  factory Player.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'username': String username,
        'pontos': int point,
      } =>
        Player(
          username,
          point,
        ),
      _ => throw const FormatException('Failed to load Player.'),
    };
  }
}

class OddEvenState extends State<OddEven> {
  // 0 -> register
  // 1 -> player board
  // 2 -> game
  // 3 -> game result
  int currScreen = 0;
  String playerName = '';
  List<Player> playerList = [];

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

  Future<void> registerPlayer(String name) async {
    var url = Uri.https('par-impar.glitch.me', 'novo');
    var response = await http.post(url,
        body: jsonEncode(<String, String>{'username': playerName}));

    if (response.statusCode == 200 || response.statusCode == 204) {
      print(playerList);
      playerName = name;

      changeScreen(1);
    } else {
      throw const HttpException('Failed to register player');
    }
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
