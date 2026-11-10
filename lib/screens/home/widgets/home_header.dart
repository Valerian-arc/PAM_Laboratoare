import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../../data/models/home_page_data.dart';
import '../../../widgets/common/app_network_image.dart';
import '../../../widgets/common/app_svg_icon.dart';

/// Blue header (greeting, notifications, avatar) with the floating
/// "Learned today" card overlapping its bottom edge.
class HomeHeaderSection extends StatelessWidget {
  final HomeHeader data;
  final LearnedToday learnedToday;
  final SectionLink myCourses;
  final VoidCallback onNotificationsTap;
  final VoidCallback onMyCoursesTap;

  const HomeHeaderSection({
    super.key,
    required this.data,
    required this.learnedToday,
    required this.myCourses,
    required this.onNotificationsTap,
    required this.onMyCoursesTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          color: AppColors.primaryBlue,
          padding: const EdgeInsets.only(
            left: 20,
            right: 130,
            top: 54,
            bottom: 80,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.greeting,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                data.subtitle,
                style: const TextStyle(color: Color(0xFFEAEAFF), fontSize: 15),
              ),
            ],
          ),
        ),
        Positioned(
          top: 58,
          right: 78,
          child: _NotificationBell(
            iconUrl: data.notification.iconUrl,
            hasUnread: data.notification.hasUnread,
            onTap: onNotificationsTap,
          ),
        ),
        Positioned(
          top: 48,
          right: 16,
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: ClipOval(
              child: AppNetworkImage(
                url: data.avatarUrl,
                fallbackAsset: 'assets/images/avatar_home.png',
              ),
            ),
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          bottom: -50,
          child: _LearnedTodayCard(
            data: learnedToday,
            myCourses: myCourses,
            onMyCoursesTap: onMyCoursesTap,
          ),
        ),
      ],
    );
  }
}

class _NotificationBell extends StatelessWidget {
  final String iconUrl;
  final bool hasUnread;
  final VoidCallback onTap;

  const _NotificationBell({
    required this.iconUrl,
    required this.hasUnread,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: hasUnread ? 'Notifications, unread' : 'Notifications',
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: SizedBox(
          width: 36,
          height: 36,
          child: Stack(
            alignment: Alignment.center,
            children: [
              AppSvgIcon(
                url: iconUrl,
                fallbackIcon: Icons.notifications_none_rounded,
                fallbackColor: Colors.white,
                size: 26,
              ),
              Positioned(
                top: 6,
                right: 7,
                child: AnimatedScale(
                  scale: hasUnread ? 1 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    width: 9,
                    height: 9,
                    decoration: BoxDecoration(
                      color: AppColors.accentOrange,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primaryBlue,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LearnedTodayCard extends StatelessWidget {
  final LearnedToday data;
  final SectionLink myCourses;
  final VoidCallback onMyCoursesTap;

  const _LearnedTodayCard({
    required this.data,
    required this.myCourses,
    required this.onMyCoursesTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(18),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  data.title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.textGrey,
                    fontSize: 13,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onMyCoursesTap,
                child: Text(
                  myCourses.actionLabel,
                  style: const TextStyle(
                    color: AppColors.primaryBlue,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${data.learnedMinutes}min ',
                  style: const TextStyle(
                    color: AppColors.primaryDark,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: '/ ${data.goalMinutes}min',
                  style: const TextStyle(
                    color: AppColors.textGrey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Animates from 0 to the value from the JSON when data arrives.
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: data.progress),
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeOutCubic,
            builder: (context, value, _) => ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: value,
                minHeight: 8,
                backgroundColor: AppColors.progressTrack,
                valueColor: const AlwaysStoppedAnimation(
                  AppColors.accentOrange,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
