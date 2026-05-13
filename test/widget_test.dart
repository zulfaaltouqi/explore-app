import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/welcome.dart';

void main() {
  testWidgets('Welcome page shows get started flow', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: WelcomePage(),
      ),
    );

    expect(find.text('JOIN US AND\nEXPLORE OMAN'), findsOneWidget);
    expect(find.text('GET STARTED!'), findsOneWidget);
  });
}
