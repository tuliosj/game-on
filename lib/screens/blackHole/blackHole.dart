import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'package:game_on/custom_flutter/dialog.dart' as customDialog;

class BlackHole {
  BehaviorSubject<bool> _resetExtended = BehaviorSubject<bool>.seeded(false);
  Stream get resetExtended$ => _resetExtended.stream;
  bool get currentResetExtended => _resetExtended.value;

  BehaviorSubject<List<int>> _board = BehaviorSubject<List<int>>.seeded(
      new List<int>.filled(21, 0, growable: false));
  Stream get board$ => _board.stream;
  List<int> get currentBoard => _board.value;

  BehaviorSubject<int> _red = BehaviorSubject<int>.seeded(0);
  Stream get red$ => _red.stream;
  int get currentRed => _red.value;

  BehaviorSubject<int> _blue = BehaviorSubject<int>.seeded(0);
  Stream get blue$ => _blue.stream;
  int get currentBlue => _blue.value;

  BehaviorSubject<bool> _order = BehaviorSubject<bool>.seeded(true);
  Stream get order$ => _order.stream;
  bool get currentOrder => _order.value;

  BehaviorSubject<String> _winner = BehaviorSubject<String>.seeded('');
  Stream get winner$ => _winner.stream;
  String get currentWinner => _winner.value;

  List<int> availablePositions = [];

  // Gesture Handling

  color(int index) {
    _resetExtended.add(false);
    if (currentWinner == '' && currentBoard[index] == 0) {
      if (currentBlue == currentRed) {
        // Red's turn
        _red.add(currentRed + 1);
        currentBoard[index] = currentRed;
      } else {
        // Blue's turn
        _blue.add(currentBlue + 1);
        currentBoard[index] = -currentBlue;
      }
      _board.add(currentBoard);
      _order.add(!currentOrder);
    }
  }

  reset() {
    if (currentResetExtended) {
      _order.add(true);
      _red.add(0);
      _blue.add(0);
      _board.add(new List<int>.filled(21, 0, growable: false));
    }
    _resetExtended.add(!currentResetExtended);
  }

  // Board controller

  checkVictory() {}

  // Builders
  void infoDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return customDialog.AlertDialog(
          title: new Text("How to Play"),
          content: new IntrinsicHeight(
            child: Column(
              children: <Widget>[
                Text(
                    "Red and Blue alternate turns, starting by Red. Each player has 10 discs with a value, but there are 21 tiles."),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                    "The remaining tile is the Black Hole. When all tiles have been placed, the Black Hole sucks in all of its neighbouring discs. Each player then sums the value of their discs and whoever has LESS wins!"),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Got it!"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
