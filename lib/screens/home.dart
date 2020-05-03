import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocy_app/screens/configuration/configuration.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => Configuration()));
            },
          )
        ],
      ),
      body: Flex(
        direction: Axis.vertical,
        children: <Widget>[Text("Widget1"), Text("Widget2"), Text("Widget3")],
      ),
    );
  }
}
