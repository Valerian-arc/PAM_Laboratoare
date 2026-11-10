import 'package:copiere_interfata_lab2/app.dart';
import 'package:copiere_interfata_lab2/widgets/common/custom_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fakes.dart';

void main() {
  Future<void> pumpApp(WidgetTester tester, FakeLearningRepository repo) async {
    tester.view.physicalSize = const Size(1125, 2436);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(LearningApp(repository: repo));
  }

  testWidgets('home page shows data from the JSON', (tester) async {
    await pumpApp(tester, FakeLearningRepository());
    await tester.pumpAndSettle();

    expect(find.text('Hi, Kristin'), findsOneWidget);
    expect(find.text('Packaging Design'), findsOneWidget);
    expect(find.text('Meetup'), findsOneWidget);
  });

  testWidgets('error view retries the load', (tester) async {
    final repo = FakeLearningRepository(shouldFail: true);
    await pumpApp(tester, repo);
    await tester.pumpAndSettle();
    expect(find.text('Try again'), findsOneWidget);

    repo.shouldFail = false;
    await tester.tap(find.text('Try again'));
    await tester.pumpAndSettle();
    expect(find.text('Hi, Kristin'), findsOneWidget);
  });

  testWidgets('course overview: tabs, locked lesson and enroll', (
    tester,
  ) async {
    await pumpApp(tester, FakeLearningRepository());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Courses'));
    await tester.pumpAndSettle();
    expect(find.byType(CustomBottomNav), findsNothing);
    expect(find.text('React Front To back'), findsOneWidget);
    expect(find.text('Introduction to React'), findsOneWidget);

    await tester.tap(find.text('Build React'));
    await tester.pump();
    expect(find.textContaining('Enroll to unlock'), findsOneWidget);

    await tester.tap(find.text('Enroll Now'));
    await tester.pumpAndSettle();
    expect(find.text('Enrolled'), findsOneWidget);

    await tester.tap(find.text('Description'));
    await tester.pumpAndSettle();
    expect(find.textContaining('No description'), findsOneWidget);

    await tester.tap(find.bySemanticsLabel('Back'));
    await tester.pumpAndSettle();
    expect(find.byType(CustomBottomNav), findsOneWidget);
  });
}
