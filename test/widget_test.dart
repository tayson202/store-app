import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Smoke test: MaterialApp can be created', (WidgetTester tester) async {
    // A lightweight smoke test that doesn't require platform plugins.
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(child: Text('Store App')),
        ),
      ),
    );
    expect(find.text('Store App'), findsOneWidget);
  });
}
