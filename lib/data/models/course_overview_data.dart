import 'json_utils.dart';

/// Root model for `courseOverviewPage` in the JSON file.
class CourseOverviewData {
  final String navigationTitle;
  final String backIconUrl;
  final Course course;
  final CourseActions actions;
  final CourseUiIcons uiIcons;

  const CourseOverviewData({
    required this.navigationTitle,
    required this.backIconUrl,
    required this.course,
    required this.actions,
    required this.uiIcons,
  });

  factory CourseOverviewData.fromJson(Json json) {
    final navigation = jsonMap(json['navigation']);
    return CourseOverviewData(
      navigationTitle: jsonString(navigation['title']),
      backIconUrl: jsonString(navigation['backIconUrl']),
      course: Course.fromJson(jsonMap(json['course'])),
      actions: CourseActions.fromJson(jsonMap(json['actions'])),
      uiIcons: CourseUiIcons.fromJson(jsonMap(json['uiIcons'])),
    );
  }

  CourseOverviewData copyWith({Course? course}) => CourseOverviewData(
    navigationTitle: navigationTitle,
    backIconUrl: backIconUrl,
    course: course ?? this.course,
    actions: actions,
    uiIcons: uiIcons,
  );
}

class Course {
  final String id;
  final String title;
  final String duration;
  final int durationMinutes;
  final int lessonCount;
  final double rating;
  final CourseHero hero;
  final List<CourseTab> tabs;
  final String selectedTabId;
  final List<Lesson> lessons;
  final String description;

  const Course({
    required this.id,
    required this.title,
    required this.duration,
    required this.durationMinutes,
    required this.lessonCount,
    required this.rating,
    required this.hero,
    required this.tabs,
    required this.selectedTabId,
    required this.lessons,
    required this.description,
  });

  factory Course.fromJson(Json json) {
    final tabsJson = jsonMap(json['tabs']);
    final tabs = jsonList(tabsJson['items']).map(CourseTab.fromJson).toList();
    final lessons = jsonList(json['lessons']).map(Lesson.fromJson).toList();
    return Course(
      id: jsonString(json['id']),
      title: jsonString(json['title']),
      duration: jsonString(json['duration']),
      durationMinutes: jsonInt(json['durationMinutes']),
      lessonCount: jsonInt(json['lessonCount'], lessons.length),
      rating: jsonDouble(json['rating']),
      hero: CourseHero.fromJson(jsonMap(json['hero'])),
      tabs: tabs,
      selectedTabId: jsonString(
        tabsJson['selected'],
        tabs.isNotEmpty ? tabs.first.id : '',
      ),
      lessons: lessons,
      description: jsonString(jsonMap(json['description'])['text']),
    );
  }

  Course copyWith({List<Lesson>? lessons}) => Course(
    id: id,
    title: title,
    duration: duration,
    durationMinutes: durationMinutes,
    lessonCount: lessonCount,
    rating: rating,
    hero: hero,
    tabs: tabs,
    selectedTabId: selectedTabId,
    lessons: lessons ?? this.lessons,
    description: description,
  );
}

class CourseHero {
  final String label;
  final String imageUrl;
  final String playIconUrl;
  final int videoCount;
  final int classCount;

  const CourseHero({
    required this.label,
    required this.imageUrl,
    required this.playIconUrl,
    required this.videoCount,
    required this.classCount,
  });

  factory CourseHero.fromJson(Json json) => CourseHero(
    label: jsonString(json['label']),
    imageUrl: jsonString(json['imageUrl']),
    playIconUrl: jsonString(json['playIconUrl']),
    videoCount: jsonInt(json['videoCount']),
    classCount: jsonInt(json['classCount']),
  );
}

class CourseTab {
  final String id;
  final String label;

  const CourseTab({required this.id, required this.label});

  factory CourseTab.fromJson(Json json) =>
      CourseTab(id: jsonString(json['id']), label: jsonString(json['label']));
}

class Lesson {
  final String id;
  final String title;

  /// "mm:ss" as provided in the JSON.
  final String duration;
  final int durationSeconds;
  final bool completed;
  final bool locked;
  final String playIconUrl;
  final String arrowIconUrl;

  const Lesson({
    required this.id,
    required this.title,
    required this.duration,
    required this.durationSeconds,
    required this.completed,
    required this.locked,
    required this.playIconUrl,
    required this.arrowIconUrl,
  });

  factory Lesson.fromJson(Json json) => Lesson(
    id: jsonString(json['id']),
    title: jsonString(json['title']),
    duration: jsonString(json['duration']),
    durationSeconds: jsonInt(json['durationSeconds']),
    completed: jsonBool(json['completed']),
    locked: jsonBool(json['locked']),
    playIconUrl: jsonString(json['playIconUrl']),
    arrowIconUrl: jsonString(json['arrowIconUrl']),
  );

  /// Text shown under the title, e.g. "04:28 min".
  String get durationLabel => '$duration min';

  Lesson copyWith({bool? locked, bool? completed}) => Lesson(
    id: id,
    title: title,
    duration: duration,
    durationSeconds: durationSeconds,
    completed: completed ?? this.completed,
    locked: locked ?? this.locked,
    playIconUrl: playIconUrl,
    arrowIconUrl: arrowIconUrl,
  );
}

class CourseActions {
  final String priceLabel;
  final num priceAmount;
  final String currency;
  final String enrollLabel;
  final bool enrollEnabled;

  const CourseActions({
    required this.priceLabel,
    required this.priceAmount,
    required this.currency,
    required this.enrollLabel,
    required this.enrollEnabled,
  });

  factory CourseActions.fromJson(Json json) {
    final price = jsonMap(json['price']);
    final enroll = jsonMap(json['enroll']);
    return CourseActions(
      priceLabel: jsonString(price['label']),
      priceAmount: price['amount'] is num ? price['amount'] as num : 0,
      currency: jsonString(price['currency'], 'USD'),
      enrollLabel: jsonString(enroll['label'], 'Enroll Now'),
      enrollEnabled: jsonBool(enroll['enabled'], true),
    );
  }

  bool get isFree => priceAmount == 0;
}

class CourseUiIcons {
  final String durationIconUrl;
  final String lessonsIconUrl;
  final String ratingIconUrl;

  const CourseUiIcons({
    required this.durationIconUrl,
    required this.lessonsIconUrl,
    required this.ratingIconUrl,
  });

  factory CourseUiIcons.fromJson(Json json) => CourseUiIcons(
    durationIconUrl: jsonString(json['durationIconUrl']),
    lessonsIconUrl: jsonString(json['lessonsIconUrl']),
    ratingIconUrl: jsonString(json['ratingIconUrl']),
  );
}
