import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/course_overview_data.dart';
import '../models/home_page_data.dart';
import '../models/json_utils.dart';

/// Contract used by the state layer. The UI never knows where data comes
/// from, so the asset source can later be swapped for a real HTTP API.
abstract class LearningRepository {
  Future<HomePageData> fetchHomePage({bool forceRefresh = false});

  Future<CourseOverviewData> fetchCourseOverview({bool forceRefresh = false});

  /// Enrolls the user in a course. Completes when the "server" confirms.
  Future<void> enroll(String courseId);
}

/// Reads `assets/data/lab_v4.json` and simulates network latency.
class AssetLearningRepository implements LearningRepository {
  final String assetPath;
  final Duration latency;
  final AssetBundle _bundle;

  Future<Json>? _cache;

  AssetLearningRepository({
    this.assetPath = 'assets/data/lab_v4.json',
    this.latency = const Duration(milliseconds: 900),
    AssetBundle? bundle,
  }) : _bundle = bundle ?? rootBundle;

  Future<Json> _loadJson({required bool forceRefresh}) {
    if (forceRefresh || _cache == null) {
      _cache = _readFile().catchError((Object e) {
        _cache = null; // don't keep a failed result around
        throw e;
      });
    }
    return _cache!;
  }

  Future<Json> _readFile() async {
    await Future<void>.delayed(latency);
    final raw = await _bundle.loadString(assetPath, cache: false);
    final decoded = jsonDecode(raw);
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('Root of the JSON file must be an object');
    }
    return decoded;
  }

  @override
  Future<HomePageData> fetchHomePage({bool forceRefresh = false}) async {
    final json = await _loadJson(forceRefresh: forceRefresh);
    return HomePageData.fromJson(jsonMap(json['homePage']));
  }

  @override
  Future<CourseOverviewData> fetchCourseOverview({
    bool forceRefresh = false,
  }) async {
    final json = await _loadJson(forceRefresh: forceRefresh);
    return CourseOverviewData.fromJson(jsonMap(json['courseOverviewPage']));
  }

  @override
  Future<void> enroll(String courseId) =>
      Future<void>.delayed(const Duration(milliseconds: 1200));
}
