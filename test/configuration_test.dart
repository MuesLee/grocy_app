import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grocy_app/screens/configuration/configuration.dart';

import 'testutil.dart';

void main() {
  testWidgets('Configuration screen has button', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(child: Configuration()));
    expect(find.byType(RaisedButton), findsOneWidget);
  });
}
