import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class OrderAndChaos {
  BehaviorSubject<List<Color>> _board = BehaviorSubject<List<Color>>.seeded(
      new List<Color>.filled(36, Colors.grey[300], growable: false));

  Stream get board$ => _board.stream;
  List<Color> get currentBoard => _board.value;

  BehaviorSubject<bool> _red = BehaviorSubject<bool>.seeded(true);
  Stream get red$ => _red.stream;
  bool get currentRed => _red.value;

  BehaviorSubject<String> _winner = BehaviorSubject<String>.seeded('');
  Stream get winner$ => _winner.stream;
  String get currentWinner => _winner.value;

  color(int index) {
    if (currentBoard[index] == Colors.grey[300]) {
      currentBoard[index] = currentRed ? Colors.red[400] : Colors.blue[400];
      _winner.add(checkWinner());
      _board.add(currentBoard);
    }
  }

  changeColor() {
    _red.add(!currentRed);
  }

  reset() {
    _board.add(new List<Color>.filled(36, Colors.grey[300], growable: false));
    _winner.add(checkWinner());
  }

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
      return true;
    }

    index[0] = index[0] + direction[0];
    index[1] = index[1] + direction[1];
    if (index[0] > 5 || index[0] < 0 || index[1] > 5 || index[1] < 0) {
      return false;
    }

    if (currentBoard[index[0] * 6 + index[1]] == color) {
      return checkDirection(direction, index, color, (verifications - 1));
    }
    return false;
  }
}
