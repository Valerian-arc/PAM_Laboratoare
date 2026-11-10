import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../../data/models/course_overview_data.dart';
import 'overview_painters.dart';
import 'overview_text.dart';

/// One lesson row. The selected lesson gets the filled orange circle;
/// locked lessons are drawn in the faded orange from the JSON (#FFE0CC).
class LessonTile extends StatelessWidget {
  final Lesson lesson;
  final bool selected;
  final VoidCallback onTap;

  const LessonTile({
    super.key,
    required this.lesson,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final accent = lesson.locked ? AppColors.orangeLocked : AppColors.orange;
    final titleColor = lesson.locked ? AppColors.tabGrey : AppColors.dark;

    return Semantics(
      button: true,
      selected: selected,
      label: lesson.locked ? '${lesson.title}, locked' : lesson.title,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          height: 66.2,
          child: Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: 39,
              child: OverflowBox(
                maxHeight: 60,
                child: Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      width: 39,
                      height: 39,
                      decoration: BoxDecoration(
                        color: selected ? AppColors.orange : Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: selected
                            ? null
                            : [
                                BoxShadow(
                                  color: const Color(0xFF6E7AA0).withAlpha(28),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                      ),
                      padding: const EdgeInsets.only(left: 2),
                      alignment: Alignment.center,
                      child: CustomPaint(
                        size: const Size(11, 14),
                        painter: PlayPainter(
                          color: selected ? Colors.white : accent,
                        ),
                      ),
                    ),
                    const SizedBox(width: 25),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            lesson.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: overviewText(
                              15,
                              titleColor,
                              FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            lesson.durationLabel,
                            style: overviewText(15, AppColors.durationGrey),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 9),
                      child: lesson.locked
                          ? const Icon(
                              Icons.lock_outline_rounded,
                              size: 16,
                              color: AppColors.orangeLocked,
                            )
                          : CustomPaint(
                              size: const Size(7.6, 14.6),
                              painter: ChevronPainter(
                                color: accent,
                                strokeWidth: 2,
                                pointsLeft: false,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
