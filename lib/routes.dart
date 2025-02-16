import 'package:flutter/widgets.dart';
import 'package:game_on/screens/home/index.dart';
import 'package:game_on/screens/orderAndChaos/index.dart';
import 'package:game_on/screens/blackHole/index.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => HomeScreen(),
  "/oac": (BuildContext context) => OacScreen(),
  "/blackhole": (BuildContext context) => BlackHoleScreen(),
};
