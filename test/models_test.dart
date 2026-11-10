import 'dart:convert';
import 'dart:io';

import 'package:copiere_interfata_lab2/data/models/course_overview_data.dart';
import 'package:copiere_interfata_lab2/data/models/home_page_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Map<String, dynamic> json;

  setUpAll(() {
    json = jsonDecode(
      File('assets/data/lab_v4.json').readAsStringSync(),
    ) as Map<String, dynamic>;
  });

  test('home page is parsed from lab_v4.json', () {
    final home = HomePageData.fromJson(json['homePage']);
    expect(home.header.greeting, 'Hi, Kristin');
    expect(home.header.notification.hasUnread, isTrue);
    expect(home.learnedToday.learnedMinutes, 46);
    expect(home.learnedToday.goalMinutes, 60);
    expect(home.learningPlan.items, hasLength(2));
    expect(home.learningPlan.items.first.title, 'Packaging Design');
    expect(home.learningPlan.items.first.completed, 40);
    expect(home.meetup.title, 'Meetup');
  });

  test('course overview is parsed from lab_v4.json', () {
    final page = CourseOverviewData.fromJson(json['courseOverviewPage']);
    final course = page.course;
    expect(page.navigationTitle, 'Course Overview');
    expect(course.title, 'React Front To back');
    expect(course.rating, 4.9);
    expect(course.hero.videoCount, 75);
    expect(course.hero.classCount, 35);
    expect(course.selectedTabId, 'lessons');
    expect(course.tabs.map((t) => t.label), ['Lessons', 'Description']);
    expect(course.lessons, hasLength(4));
    expect(course.lessons.first.durationLabel, '04:28 min');
    expect(course.lessons.last.locked, isTrue);
    expect(page.actions.priceLabel, 'Free');
    expect(page.actions.isFree, isTrue);
  });

  test('missing or wrongly typed fields fall back to safe defaults', () {
    final item = LearningPlanItem.fromJson({'completed': 3, 'total': '?'});
    expect(item.title, '');
    expect(item.total, 0);
    expect(item.progress, 0);

    final lesson = Lesson.fromJson(const {});
    expect(lesson.locked, isFalse);

    final learned = LearnedToday.fromJson({
      'learnedMinutes': 30,
      'goalMinutes': 60,
    });
    expect(learned.progress, 0.5); // computed when not provided
  });
}
