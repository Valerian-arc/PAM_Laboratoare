import 'package:flutter_test/flutter_test.dart';
import 'package:copiere_interfata_lab2/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const LearningApp());
    expect(find.text('Hi, Kristin'), findsOneWidget);
  });
}
