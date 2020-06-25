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

  color(int index) {
    currentBoard[index] = currentRed ? Colors.red[400] : Colors.blue[400];
    _board.add(currentBoard);
    checkWinner();
  }

  changeColor() {
    _red.add(!currentRed);
  }

  reset() {
    _board.add(new List<Color>.filled(36, Colors.grey[300], growable: false));
  }

  checkWinner() {}
}
