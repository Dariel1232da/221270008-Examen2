import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_app/main.dart';

void main() {
  testWidgets('Smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MiAplicacion());

    // Verify that our counter starts at 0.
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}