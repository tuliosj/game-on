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
      _red.add(0);
      _blue.add(0);
      _board.add(new List<int>.filled(21, 0, growable: false));
    }
    _resetExtended.add(!currentResetExtended);
  }

  // Board controller

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
                    "In this game, you can control both colors. One of you is Order and the other is Chaos."),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                    "Order plays first, and aims to get five like pieces in a row either vertically, horizontally, or diagonally."),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                    "Chaos aims to fill the board without completion of a line of five like pieces."),
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
