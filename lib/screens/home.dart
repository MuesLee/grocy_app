import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Flex(
        direction: Axis.vertical,
        children: <Widget>[Text("Widget1"), Text("Widget2"), Text("Widget3")],
      ),
    );
  }
}
