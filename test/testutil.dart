import 'package:flutter/material.dart';

/// Wraps widget in MaterialApp. Required by widgets with a Scaffold
Widget createWidgetForTesting({Widget child}) {
  return MaterialApp(
    home: child,
  );
}
