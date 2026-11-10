import 'json_utils.dart';

/// Root model for `homePage` in the JSON file.
class HomePageData {
  final HomeHeader header;
  final LearnedToday learnedToday;
  final SectionLink myCourses;
  final LearningPrompt learningPrompt;
  final LearningPlan learningPlan;
  final Meetup meetup;

  const HomePageData({
    required this.header,
    required this.learnedToday,
    required this.myCourses,
    required this.learningPrompt,
    required this.learningPlan,
    required this.meetup,
  });

  factory HomePageData.fromJson(Json json) => HomePageData(
    header: HomeHeader.fromJson(jsonMap(json['header'])),
    learnedToday: LearnedToday.fromJson(jsonMap(json['learnedToday'])),
    myCourses: SectionLink.fromJson(jsonMap(json['myCourses'])),
    learningPrompt: LearningPrompt.fromJson(jsonMap(json['learningPrompt'])),
    learningPlan: LearningPlan.fromJson(jsonMap(json['learningPlan'])),
    meetup: Meetup.fromJson(jsonMap(json['meetup'])),
  );

  HomePageData copyWith({HomeHeader? header}) => HomePageData(
    header: header ?? this.header,
    learnedToday: learnedToday,
    myCourses: myCourses,
    learningPrompt: learningPrompt,
    learningPlan: learningPlan,
    meetup: meetup,
  );
}

class HomeHeader {
  final String greeting;
  final String subtitle;
  final String avatarUrl;
  final NotificationInfo notification;

  const HomeHeader({
    required this.greeting,
    required this.subtitle,
    required this.avatarUrl,
    required this.notification,
  });

  factory HomeHeader.fromJson(Json json) => HomeHeader(
    greeting: jsonString(json['greeting']),
    subtitle: jsonString(json['subtitle']),
    avatarUrl: jsonString(json['avatarUrl']),
    notification: NotificationInfo.fromJson(jsonMap(json['notification'])),
  );

  HomeHeader copyWith({NotificationInfo? notification}) => HomeHeader(
    greeting: greeting,
    subtitle: subtitle,
    avatarUrl: avatarUrl,
    notification: notification ?? this.notification,
  );
}

class NotificationInfo {
  final bool hasUnread;
  final String iconUrl;

  const NotificationInfo({required this.hasUnread, required this.iconUrl});

  factory NotificationInfo.fromJson(Json json) => NotificationInfo(
    hasUnread: jsonBool(json['hasUnread']),
    iconUrl: jsonString(json['iconUrl']),
  );

  NotificationInfo copyWith({bool? hasUnread}) => NotificationInfo(
    hasUnread: hasUnread ?? this.hasUnread,
    iconUrl: iconUrl,
  );
}

class LearnedToday {
  final String title;
  final int learnedMinutes;
  final int goalMinutes;
  final String formatted;
  final double progress;

  const LearnedToday({
    required this.title,
    required this.learnedMinutes,
    required this.goalMinutes,
    required this.formatted,
    required this.progress,
  });

  factory LearnedToday.fromJson(Json json) {
    final learned = jsonInt(json['learnedMinutes']);
    final goal = jsonInt(json['goalMinutes']);
    return LearnedToday(
      title: jsonString(json['title']),
      learnedMinutes: learned,
      goalMinutes: goal,
      formatted: jsonString(json['formatted'], '${learned}min / ${goal}min'),
      // Prefer the value from the file, otherwise compute it.
      progress: jsonDouble(
        json['progress'],
        goal > 0 ? learned / goal : 0,
      ).clamp(0.0, 1.0),
    );
  }
}

class SectionLink {
  final String title;
  final String actionLabel;

  const SectionLink({required this.title, required this.actionLabel});

  factory SectionLink.fromJson(Json json) => SectionLink(
    title: jsonString(json['title']),
    actionLabel: jsonString(json['actionLabel']),
  );
}

class LearningPrompt {
  final String title;
  final String actionLabel;
  final String imageUrl;

  const LearningPrompt({
    required this.title,
    required this.actionLabel,
    required this.imageUrl,
  });

  factory LearningPrompt.fromJson(Json json) => LearningPrompt(
    title: jsonString(json['title']),
    actionLabel: jsonString(json['actionLabel']),
    imageUrl: jsonString(json['imageUrl']),
  );
}

class LearningPlan {
  final String title;
  final List<LearningPlanItem> items;

  const LearningPlan({required this.title, required this.items});

  factory LearningPlan.fromJson(Json json) => LearningPlan(
    title: jsonString(json['title']),
    items: jsonList(json['items']).map(LearningPlanItem.fromJson).toList(),
  );
}

class LearningPlanItem {
  final String id;
  final String title;
  final int completed;
  final int total;
  final double progress;
  final String progressIconUrl;

  const LearningPlanItem({
    required this.id,
    required this.title,
    required this.completed,
    required this.total,
    required this.progress,
    required this.progressIconUrl,
  });

  factory LearningPlanItem.fromJson(Json json) {
    final completed = jsonInt(json['completed']);
    final total = jsonInt(json['total']);
    return LearningPlanItem(
      id: jsonString(json['id']),
      title: jsonString(json['title']),
      completed: completed,
      total: total,
      progress: jsonDouble(
        json['progress'],
        total > 0 ? completed / total : 0,
      ).clamp(0.0, 1.0),
      progressIconUrl: jsonString(json['progressIconUrl']),
    );
  }
}

class Meetup {
  final String title;
  final String subtitle;
  final String imageUrl;

  const Meetup({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });

  factory Meetup.fromJson(Json json) => Meetup(
    title: jsonString(json['title']),
    subtitle: jsonString(json['subtitle']),
    imageUrl: jsonString(json['imageUrl']),
  );
}
