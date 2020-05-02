import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grocy_app/screens/home.dart';

import 'testutil.dart';

void main() {
  testWidgets('Home screen can be instantiated', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(child: Home()));
    expect(find.byType(Flex), findsOneWidget);
  });
}
