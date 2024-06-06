// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:even_odd/profile.dart';
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
  String challengedPlayerName = '';
  List<Player> playerList = [];
  String currBetResult = '';
  int currPlayerPoints = 0;

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
    var response = await http.post(
      url,
      headers: {'Content-type': 'application/json'},
      body: jsonEncode({'username': name}),
    );

    if (response.statusCode == 200 || response.statusCode == 204) {
      List usuariosJson =
          ((jsonDecode(response.body) as Map<String, dynamic>)['usuarios']);

      playerList = usuariosJson
          .map((playerJson) => Player.fromJson(playerJson))
          .toList();

      playerName = name;

      changeScreen(1);
    } else {
      throw const HttpException('Failed to register player');
    }
  }

  Future<void> postBet(int betValue, int oddEven, int number) async {
    var url = Uri.https('par-impar.glitch.me', 'aposta');
    var response = await http.post(url,
        headers: {'Content-type': 'application/json'},
        body: jsonEncode({
          'username': playerName,
          'valor': betValue,
          'parimpar': oddEven, // 2 -> even, 1 -> odd
          'numero': number
        }));

    if (response.statusCode == 200 || response.statusCode == 204) {
      changeScreen(2);
    } else {
      throw const HttpException('Failed to register bet');
    }
  }

  Future<void> challengePlayer(String challengedName) async {
    challengedPlayerName = challengedName;

    var url = Uri.https(
        'par-impar.glitch.me', 'jogar/' + challengedName + '/' + playerName);
    var response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 204) {
      var json = jsonDecode(response.body) as Map<String, dynamic>;

      if (json.containsKey('msg')) {
        currBetResult = "Draw! No one wins points...";
      } else {
        var winner = json['vencedor'];
        var loser = json['perdedor'];
        if (winner['username'] == playerName) {
          currBetResult = 'You win! You earned ${loser['valor']} points!';
        } else {
          currBetResult = 'You lose! You lost ${winner['valor']} points!';
        }
      }

      changeScreen(3);
    } else {
      throw const HttpException('Failed to register bet');
    }
  }

  Future<void> getPlayerProfile() async {
    var url = Uri.https('par-impar.glitch.me', 'pontos/' + playerName);
    var response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 204) {
      var json = jsonDecode(response.body) as Map<String, dynamic>;

      currPlayerPoints = json['pontos'];

      changeScreen(4);
    } else {
      throw const HttpException('Failed to get bet');
    }
  }

  void anotherBet() {
    changeScreen(1);
  }

  Widget showScreen() {
    switch (currScreen) {
      case 1:
        return Bet(postBet, playerName);
      case 2:
        return PlayerList(challengePlayer, playerList, playerName);
      case 3:
        return Result(anotherBet, getPlayerProfile, challengedPlayerName,
            playerName, currBetResult);
      case 4:
        return Profile(changeScreen, playerName, currPlayerPoints);
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
