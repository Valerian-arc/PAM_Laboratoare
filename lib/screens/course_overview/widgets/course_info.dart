import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../../data/models/course_overview_data.dart';
import '../../../widgets/common/app_svg_icon.dart';
import 'overview_text.dart';

/// Title, "6h 30min · 7 lessons" and the rating pill.
class CourseInfo extends StatelessWidget {
  final Course course;
  final CourseUiIcons icons;

  const CourseInfo({super.key, required this.course, required this.icons});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          course.title,
          style: overviewText(19, AppColors.dark, FontWeight.w500),
        ),
        const SizedBox(height: 9),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  children: [
                    AppSvgIcon(
                      url: icons.durationIconUrl,
                      fallbackIcon: Icons.schedule_rounded,
                      fallbackColor: AppColors.metaGrey,
                      size: 14,
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        course.duration,
                        overflow: TextOverflow.ellipsis,
                        style: overviewText(13, AppColors.metaGrey),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        '·',
                        style: overviewText(
                          13,
                          AppColors.metaGrey,
                          FontWeight.w700,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        '${course.lessonCount} lessons',
                        overflow: TextOverflow.ellipsis,
                        style: overviewText(13, AppColors.metaGrey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 23,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: AppColors.ratingBackground,
                borderRadius: BorderRadius.circular(5),
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppSvgIcon(
                    url: icons.ratingIconUrl,
                    fallbackIcon: Icons.star_rounded,
                    fallbackColor: AppColors.star,
                    size: 16,
                  ),
                  const SizedBox(width: 3),
                  Text(
                    course.rating.toStringAsFixed(1),
                    style: overviewText(13, AppColors.orange, FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
