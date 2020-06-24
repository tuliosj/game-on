import 'package:flutter/widgets.dart';
import 'screens/example1/examplescreen1.dart';
import 'screens/example2/examplescreen2.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => ExScreen1(),
  "/ExScreen2": (BuildContext context) => ExScreen2(),
};
