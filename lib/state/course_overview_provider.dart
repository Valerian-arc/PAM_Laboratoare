import 'package:flutter/foundation.dart';

import '../data/models/course_overview_data.dart';
import '../data/repositories/learning_repository.dart';
import 'load_status.dart';

class CourseOverviewProvider extends ChangeNotifier {
  final LearningRepository _repository;

  CourseOverviewProvider(this._repository);

  LoadStatus _status = LoadStatus.initial;
  CourseOverviewData? _data;
  String? _error;
  String _selectedTabId = '';
  String? _selectedLessonId;
  bool _isEnrolled = false;
  bool _isEnrolling = false;

  LoadStatus get status => _status;
  CourseOverviewData? get data => _data;
  String? get error => _error;
  String get selectedTabId => _selectedTabId;
  String? get selectedLessonId => _selectedLessonId;
  bool get isEnrolled => _isEnrolled;
  bool get isEnrolling => _isEnrolling;

  List<Lesson> get lessons => _data?.course.lessons ?? const [];

  bool get canEnroll =>
      (_data?.actions.enrollEnabled ?? false) && !_isEnrolled && !_isEnrolling;

  Future<void> load({bool refresh = false}) async {
    if (_status == LoadStatus.loading) return;
    _status = LoadStatus.loading;
    _error = null;
    if (!refresh) _data = null;
    notifyListeners();

    try {
      final data = await _repository.fetchCourseOverview(forceRefresh: refresh);
      // Keep lessons unlocked if the user already enrolled.
      _data = _isEnrolled ? _unlockAll(data) : data;
      if (_selectedTabId.isEmpty) _selectedTabId = data.course.selectedTabId;
      // First available lesson is the "current" one, as in the design.
      _selectedLessonId ??= _firstUnlocked(data.course.lessons)?.id;
      _status = LoadStatus.success;
    } catch (e) {
      _error = 'Could not load the course.\n$e';
      _status = _data == null ? LoadStatus.failure : LoadStatus.success;
    }
    notifyListeners();
  }

  void selectTab(String tabId) {
    if (tabId == _selectedTabId) return;
    _selectedTabId = tabId;
    notifyListeners();
  }

  /// Returns `false` when the lesson is locked and cannot be selected.
  bool selectLesson(Lesson lesson) {
    if (lesson.locked) return false;
    if (_selectedLessonId != lesson.id) {
      _selectedLessonId = lesson.id;
      notifyListeners();
    }
    return true;
  }

  /// Simulates an enroll request; on success every lesson is unlocked.
  Future<bool> enroll() async {
    final data = _data;
    if (data == null || !canEnroll) return false;
    _isEnrolling = true;
    notifyListeners();
    try {
      await _repository.enroll(data.course.id);
      _isEnrolled = true;
      _data = _unlockAll(data);
      return true;
    } catch (e) {
      _error = 'Enrollment failed. Please try again.';
      return false;
    } finally {
      _isEnrolling = false;
      notifyListeners();
    }
  }

  static Lesson? _firstUnlocked(List<Lesson> lessons) {
    for (final l in lessons) {
      if (!l.locked) return l;
    }
    return null;
  }

  static CourseOverviewData _unlockAll(CourseOverviewData data) =>
      data.copyWith(
        course: data.course.copyWith(
          lessons: [
            for (final l in data.course.lessons) l.copyWith(locked: false),
          ],
        ),
      );
}
