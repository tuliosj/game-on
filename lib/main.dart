import 'package:flutter/material.dart';
import 'package:game_on/screens/orderAndChaos/orderAndChaos.dart';
import 'package:get_it/get_it.dart';
import 'routes.dart';

final getIt = GetIt.instance;

void main() {
  getIt.registerSingleton<OrderAndChaos>(OrderAndChaos());
  runApp(GameOn());
}

class GameOn extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Game On',
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: "/intro",
      routes: routes,
    );
  }
}
