import 'package:flutter/material.dart';

import 'screens/configuration.dart';
import 'screens/home.dart';

void main() => runApp(GrocyApp());

class GrocyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    '/': (context) => Configuration(),
    'home': (context) => Home(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grocy Mobile',
      debugShowMaterialGrid: false,
      initialRoute: '/',
      theme:
      ThemeData(primarySwatch: Colors.deepPurple, fontFamily: 'Montserrat'),
      routes: routes,
    );
  }
}
