class LearningPlan {
  final String title;
  final int completed;
  final int total;

  const LearningPlan({
    required this.title,
    required this.completed,
    required this.total,
  });

  double get progress => total > 0 ? completed / total : 0.0;
}

class CourseCategory {
  final String title;
  final int backgroundColor;
  final int textColor;

  const CourseCategory({
    required this.title,
    required this.backgroundColor,
    required this.textColor,
  });
}

class CourseItem {
  final String title;
  final String author;
  final double price;
  final int durationHours;
  final String imageAsset;

  const CourseItem({
    required this.title,
    required this.author,
    required this.price,
    required this.durationHours,
    required this.imageAsset,
  });
}
