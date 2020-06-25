import 'package:flutter/widgets.dart';
import 'package:game_on/screens/home/screen.dart';
import 'package:game_on/screens/intro/screen.dart';
import 'package:game_on/screens/chaosvsorder/screen.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => Home(),
  "/intro": (BuildContext context) => IntroScreen(),
  "/game": (BuildContext context) => ChaosVsOrder(),
};
