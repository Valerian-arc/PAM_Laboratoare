import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/app_colors.dart';
import '../../data/models/course_overview_data.dart';
import '../../state/course_overview_provider.dart';
import '../../state/load_status.dart';
import '../../widgets/common/state_views.dart';
import 'widgets/course_hero.dart';
import 'widgets/course_info.dart';
import 'widgets/course_tabs.dart';
import 'widgets/enroll_bar.dart';
import 'widgets/lesson_tile.dart';
import 'widgets/overview_header.dart';
import 'widgets/overview_text.dart';

/// "Course - Overview - 1" page, driven by `courseOverviewPage` in the JSON.
class CourseOverviewScreen extends StatelessWidget {
  final VoidCallback onBack;

  const CourseOverviewScreen({super.key, required this.onBack});

  static const _padL = 35.0;
  static const _padR = 21.0;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseOverviewProvider>();
    final data = provider.data;

    final Widget content;
    if (data == null && provider.status == LoadStatus.failure) {
      content = ErrorView(
        message: provider.error ?? 'Something went wrong.',
        color: AppColors.orange,
        onRetry: provider.load,
      );
    } else if (data == null) {
      content = const LoadingView(color: AppColors.orange);
    } else {
      content = Stack(
        children: [
          RefreshIndicator(
            color: AppColors.orange,
            onRefresh: () => provider.load(refresh: true),
            child: _Body(data: data, provider: provider),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: EnrollBar(
              actions: data.actions,
              isEnrolled: provider.isEnrolled,
              isEnrolling: provider.isEnrolling,
              onEnroll: provider.canEnroll
                  ? () => _enroll(context, provider)
                  : null,
            ),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: AppColors.overviewBackground,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            OverviewHeader(
              title: data?.navigationTitle ?? 'Course Overview',
              onBack: onBack,
            ),
            Expanded(child: content),
          ],
        ),
      ),
    );
  }

  Future<void> _enroll(
    BuildContext context,
    CourseOverviewProvider provider,
  ) async {
    final messenger = ScaffoldMessenger.of(context);
    final ok = await provider.enroll();
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            ok
                ? 'You are enrolled! All lessons are unlocked.'
                : provider.error ?? 'Enrollment failed.',
          ),
        ),
      );
  }
}

class _Body extends StatelessWidget {
  final CourseOverviewData data;
  final CourseOverviewProvider provider;

  const _Body({required this.data, required this.provider});

  @override
  Widget build(BuildContext context) {
    final course = data.course;
    final showLessons = provider.selectedTabId == 'lessons';

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(
        left: CourseOverviewScreen._padL,
        right: CourseOverviewScreen._padR,
        top: 37.6,
        bottom: 130,
      ),
      children: [
        CourseHeroBanner(
          hero: course.hero,
          onPlay: () => _playSelected(context),
        ),
        const SizedBox(height: 32),
        CourseInfo(course: course, icons: data.uiIcons),
        const SizedBox(height: 20),
        CourseTabs(
          tabs: course.tabs,
          selectedId: provider.selectedTabId,
          onSelected: provider.selectTab,
        ),
        const SizedBox(height: 25.8),
        if (showLessons)
          for (final lesson in provider.lessons)
            LessonTile(
              key: ValueKey(lesson.id),
              lesson: lesson,
              selected: lesson.id == provider.selectedLessonId,
              onTap: () {
                if (!provider.selectLesson(lesson)) {
                  _snack(context, 'Enroll to unlock "${lesson.title}".');
                }
              },
            )
        else
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              course.description.trim().isEmpty
                  ? 'No description available for this course yet.'
                  : course.description,
              textAlign: course.description.trim().isEmpty
                  ? TextAlign.center
                  : TextAlign.start,
              style: overviewText(14, AppColors.metaGrey).copyWith(height: 1.5),
            ),
          ),
      ],
    );
  }

  void _playSelected(BuildContext context) {
    final id = provider.selectedLessonId;
    final lesson = provider.lessons.where((l) => l.id == id).firstOrNull;
    _snack(
      context,
      lesson == null ? 'No lesson available' : 'Playing "${lesson.title}"',
    );
  }

  void _snack(BuildContext context, String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(text), duration: const Duration(seconds: 2)),
      );
  }
}
