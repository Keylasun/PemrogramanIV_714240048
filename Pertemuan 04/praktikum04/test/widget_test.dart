import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:praktikum04/main.dart';

void main() {
  testWidgets('shows Ranca Upas detail screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Ranca Upas'), findsOneWidget);
    expect(find.text('Open Every Day'), findsOneWidget);
    expect(find.text('09:00 - 20:00'), findsOneWidget);
    expect(find.text('Rp 20.000'), findsOneWidget);
    expect(find.byIcon(Icons.calendar_today), findsOneWidget);
    expect(find.byIcon(Icons.access_time), findsOneWidget);
    expect(find.byIcon(Icons.monetization_on), findsOneWidget);
  });
}
