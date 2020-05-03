import 'package:flutter/material.dart';
import 'package:preferences/preference_service.dart';

import 'screens/configuration/configuration.dart';
import 'screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PrefService.init(prefix: 'pref_');

  runApp(GrocyApp());
}

class GrocyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    'configuration': (context) => Configuration(),
    'home': (context) => Home(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grocy Mobile',
      debugShowMaterialGrid: false,
      initialRoute: 'configuration',
      theme:
          ThemeData(primarySwatch: Colors.deepPurple, fontFamily: 'Montserrat'),
      routes: routes,
    );
  }
}
