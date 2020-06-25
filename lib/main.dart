import 'package:flutter/material.dart';
import 'routes.dart';

void main() {
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
