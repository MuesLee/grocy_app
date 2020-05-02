import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grocy_app/main.dart';

void main() {
  testWidgets('App starts with Configuration screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(GrocyApp());
    expect(find.byKey(Key('configuration')), findsOneWidget);
  });
}
