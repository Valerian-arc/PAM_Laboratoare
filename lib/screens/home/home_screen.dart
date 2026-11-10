import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/app_colors.dart';
import '../../state/home_provider.dart';
import '../../state/load_status.dart';
import '../../state/navigation_provider.dart';
import '../../widgets/common/state_views.dart';
import 'widgets/home_header.dart';
import 'widgets/learning_plan_card.dart';
import 'widgets/learning_prompt_carousel.dart';
import 'widgets/meetup_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeProvider>();
    final data = provider.data;

    final Widget body;
    if (data == null && provider.status == LoadStatus.failure) {
      body = ErrorView(
        message: provider.error ?? 'Something went wrong.',
        color: AppColors.primaryBlue,
        onRetry: provider.load,
      );
    } else if (data == null) {
      body = const LoadingView(color: AppColors.primaryBlue);
    } else {
      body = RefreshIndicator(
        color: AppColors.primaryBlue,
        onRefresh: () => provider.load(refresh: true),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeHeaderSection(
                data: data.header,
                learnedToday: data.learnedToday,
                myCourses: data.myCourses,
                onNotificationsTap: () {
                  final hadUnread = provider.hasUnreadNotifications;
                  provider.markNotificationsRead();
                  _snack(
                    context,
                    hadUnread
                        ? 'All notifications marked as read'
                        : 'No new notifications',
                  );
                },
                onMyCoursesTap: () => _openCourses(context),
              ),
              const SizedBox(height: 70),
              LearningPromptCarousel(
                data: data.learningPrompt,
                onGetStarted: () => _openCourses(context),
              ),
              const SizedBox(height: 28),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: LearningPlanCard(plan: data.learningPlan),
              ),
              const SizedBox(height: 28),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: MeetupCard(data: data.meetup),
              ),
              const SizedBox(height: 35),
            ],
          ),
        ),
      );
    }

    return Scaffold(backgroundColor: AppColors.homeBackground, body: body);
  }

  void _openCourses(BuildContext context) =>
      context.read<NavigationProvider>().select(NavigationProvider.coursesTab);

  void _snack(BuildContext context, String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(text), duration: const Duration(seconds: 2)),
      );
  }
}
