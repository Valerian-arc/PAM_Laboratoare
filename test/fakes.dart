import 'dart:convert';
import 'dart:io';

import 'package:copiere_interfata_lab2/data/models/course_overview_data.dart';
import 'package:copiere_interfata_lab2/data/models/home_page_data.dart';
import 'package:copiere_interfata_lab2/data/repositories/learning_repository.dart';

/// Repository backed by the real JSON file, without delays, that can be
/// told to fail.
class FakeLearningRepository implements LearningRepository {
  bool shouldFail;
  int homeCalls = 0;
  int courseCalls = 0;
  final List<String> enrolledCourses = [];

  FakeLearningRepository({this.shouldFail = false});

  static final Map<String, dynamic> _json = jsonDecode(
    File('assets/data/lab_v4.json').readAsStringSync(),
  ) as Map<String, dynamic>;

  @override
  Future<HomePageData> fetchHomePage({bool forceRefresh = false}) async {
    homeCalls++;
    if (shouldFail) throw Exception('offline');
    return HomePageData.fromJson(_json['homePage']);
  }

  @override
  Future<CourseOverviewData> fetchCourseOverview({
    bool forceRefresh = false,
  }) async {
    courseCalls++;
    if (shouldFail) throw Exception('offline');
    return CourseOverviewData.fromJson(_json['courseOverviewPage']);
  }

  @override
  Future<void> enroll(String courseId) async {
    if (shouldFail) throw Exception('offline');
    enrolledCourses.add(courseId);
  }
}
