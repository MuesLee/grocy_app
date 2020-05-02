import 'package:flutter/material.dart';

class Configuration extends StatefulWidget {
  @override
  _ConfigurationState createState() => _ConfigurationState();
}

class _ConfigurationState extends State<Configuration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: Key('configuration'),
        appBar: AppBar(
          title: Center(child: Text("Configuration")),
        ),
        body: Column(
          children: <Widget>[
            Center(
              child: Text("Configure me"),
            ),
            RaisedButton(
              child: Text("Continue"),
              onPressed: onButtonPress,
            )
          ],
        ));
  }

  void onButtonPress() {
    Navigator.pushReplacementNamed(context, "home");
  }
}
