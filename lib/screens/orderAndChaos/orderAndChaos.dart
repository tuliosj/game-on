import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'package:game_on/custom_flutter/dialog.dart' as customDialog;

class OrderAndChaos {
  BehaviorSubject<bool> _resetExtended = BehaviorSubject<bool>.seeded(false);
  Stream get resetExtended$ => _resetExtended.stream;
  bool get currentResetExtended => _resetExtended.value;

  BehaviorSubject<List<Color>> _board = BehaviorSubject<List<Color>>.seeded(
      new List<Color>.filled(36, Colors.grey[300], growable: false));
  Stream get board$ => _board.stream;
  List<Color> get currentBoard => _board.value;

  BehaviorSubject<bool> _red = BehaviorSubject<bool>.seeded(true);
  Stream get red$ => _red.stream;
  bool get currentRed => _red.value;

  BehaviorSubject<bool> _order = BehaviorSubject<bool>.seeded(true);
  Stream get order$ => _order.stream;
  bool get currentOrder => _order.value;

  BehaviorSubject<String> _winner = BehaviorSubject<String>.seeded('');
  Stream get winner$ => _winner.stream;
  String get currentWinner => _winner.value;

  // Gesture Handling

  color(int index) {
    _resetExtended.add(false);
    if (currentWinner == '' && currentBoard[index] == Colors.grey[300]) {
      currentBoard[index] = currentRed ? Colors.red[400] : Colors.blue[400];
      _winner.add(checkWinner());
      _board.add(currentBoard);
      _order.add(!currentOrder);
    }
  }

  changePalette() {
    _resetExtended.add(false);
    _red.add(!currentRed);
  }

  reset() {
    if (currentResetExtended) {
      _order.add(true);
      _board.add(new List<Color>.filled(36, Colors.grey[300], growable: false));
      _winner.add(checkWinner());
    }
    _resetExtended.add(!currentResetExtended);
  }

  // Board controller

  checkWinner() {
    var colors = [Colors.red[400], Colors.blue[400]];
    bool order = false;
    for (var color in colors) {
      for (int i = 0; i < 6; i++) {
        for (int j = 0; j < 6; j++) {
          if (currentBoard[i * 6 + j] == color) {
            order = checkDirection([1, 0], [i, j], color, 4) ||
                checkDirection([0, 1], [i, j], color, 4) ||
                checkDirection([1, 1], [i, j], color, 4) ||
                checkDirection([-1, 1], [i, j], color, 4);
            if (order) {
              return 'Order';
            }
          }
        }
      }
    }

    if (!order) {
      bool chaos = true;
      for (var color in currentBoard) {
        if (color == Colors.grey[300]) {
          chaos = false;
        }
      }
      if (chaos) {
        return 'Chaos';
      }
    }

    return '';
  }

  checkDirection(direction, index, color, verifications) {
    if (verifications == 0) {
      if (color == Colors.red[400]) {
        currentBoard[index[0] * 6 + index[1]] = Colors.red[200];
      } else {
        currentBoard[index[0] * 6 + index[1]] = Colors.blue[200];
      }
      return true;
    }

    var nextIndex = [0, 0];
    nextIndex[0] = index[0] + direction[0];
    nextIndex[1] = index[1] + direction[1];
    if (nextIndex[0] > 5 ||
        nextIndex[0] < 0 ||
        nextIndex[1] > 5 ||
        nextIndex[1] < 0) {
      return false;
    }

    if (currentBoard[nextIndex[0] * 6 + nextIndex[1]] == color &&
        checkDirection(direction, nextIndex, color, (verifications - 1))) {
      if (color == Colors.red[400]) {
        currentBoard[index[0] * 6 + index[1]] = Colors.red[200];
      } else {
        currentBoard[index[0] * 6 + index[1]] = Colors.blue[200];
      }
      return true;
    }
    return false;
  }

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
