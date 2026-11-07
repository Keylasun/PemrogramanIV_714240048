import 'package:flutter_test/flutter_test.dart';
import 'package:ats_pemrograman4/main.dart';

void main() {
  testWidgets('App renders correctly smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Verify that the title PORSCHE is displayed
    expect(find.text('PORSCHE'), findsWidgets);
  });
}
