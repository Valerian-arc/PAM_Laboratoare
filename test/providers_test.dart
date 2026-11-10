import 'package:copiere_interfata_lab2/state/course_overview_provider.dart';
import 'package:copiere_interfata_lab2/state/home_provider.dart';
import 'package:copiere_interfata_lab2/state/load_status.dart';
import 'package:copiere_interfata_lab2/state/navigation_provider.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fakes.dart';

void main() {
  group('HomeProvider', () {
    test('goes loading -> success and exposes the data', () async {
      final provider = HomeProvider(FakeLearningRepository());
      final statuses = <LoadStatus>[];
      provider.addListener(() => statuses.add(provider.status));

      await provider.load();

      expect(statuses, [LoadStatus.loading, LoadStatus.success]);
      expect(provider.data!.header.greeting, 'Hi, Kristin');
    });

    test('reports failure and recovers on retry', () async {
      final repo = FakeLearningRepository(shouldFail: true);
      final provider = HomeProvider(repo);

      await provider.load();
      expect(provider.status, LoadStatus.failure);
      expect(provider.error, isNotNull);

      repo.shouldFail = false;
      await provider.load();
      expect(provider.status, LoadStatus.success);
      expect(provider.error, isNull);
    });

    test('marking notifications as read updates the state', () async {
      final provider = HomeProvider(FakeLearningRepository());
      await provider.load();
      expect(provider.hasUnreadNotifications, isTrue);

      provider.markNotificationsRead();
      expect(provider.hasUnreadNotifications, isFalse);
    });
  });

  group('CourseOverviewProvider', () {
    test('initial selection comes from the JSON', () async {
      final provider = CourseOverviewProvider(FakeLearningRepository());
      await provider.load();
      expect(provider.selectedTabId, 'lessons');
      expect(provider.selectedLessonId, 'lesson-1');
    });

    test('locked lessons cannot be selected until enrolled', () async {
      final repo = FakeLearningRepository();
      final provider = CourseOverviewProvider(repo);
      await provider.load();
      final locked = provider.lessons.last;

      expect(provider.selectLesson(locked), isFalse);
      expect(provider.selectedLessonId, 'lesson-1');

      expect(await provider.enroll(), isTrue);
      expect(repo.enrolledCourses, ['react-front-to-back']);
      expect(provider.isEnrolled, isTrue);
      expect(provider.canEnroll, isFalse);
      expect(provider.lessons.every((l) => !l.locked), isTrue);

      expect(provider.selectLesson(provider.lessons.last), isTrue);
      expect(provider.selectedLessonId, 'lesson-4');
    });

    test('enroll exposes the in-progress flag', () async {
      final provider = CourseOverviewProvider(FakeLearningRepository());
      await provider.load();
      final future = provider.enroll();
      expect(provider.isEnrolling, isTrue);
      await future;
      expect(provider.isEnrolling, isFalse);
    });

    test('selectTab switches tabs', () async {
      final provider = CourseOverviewProvider(FakeLearningRepository());
      await provider.load();
      provider.selectTab('description');
      expect(provider.selectedTabId, 'description');
    });
  });

  test('NavigationProvider only notifies on change', () {
    final nav = NavigationProvider();
    var notified = 0;
    nav.addListener(() => notified++);
    nav.select(0);
    nav.select(1);
    expect(nav.currentIndex, 1);
    expect(notified, 1);
  });
}
