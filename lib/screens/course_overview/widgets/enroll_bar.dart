import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../../data/models/course_overview_data.dart';
import 'overview_text.dart';

/// Bottom "Free" + "Enroll Now" bar, fading the list content behind it.
class EnrollBar extends StatelessWidget {
  final CourseActions actions;
  final bool isEnrolled;
  final bool isEnrolling;
  final VoidCallback? onEnroll;

  const EnrollBar({
    super.key,
    required this.actions,
    required this.isEnrolled,
    required this.isEnrolling,
    required this.onEnroll,
  });

  static const _bg = AppColors.overviewBackground;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;
    final priceText = actions.priceLabel.isNotEmpty
        ? actions.priceLabel
        : actions.isFree
        ? 'Free'
        : '${actions.priceAmount} ${actions.currency}';

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Fade over the list; it must not swallow taps on the rows behind.
        IgnorePointer(
          child: Container(
            height: 75,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [_bg.withAlpha(0), _bg.withAlpha(235), _bg],
                stops: const [0.0, 0.67, 1.0],
              ),
            ),
          ),
        ),
        Container(
          color: _bg,
          padding: EdgeInsets.only(
            left: 35,
            right: 21,
            bottom: 13.4 + bottomInset,
          ),
          child: _buttons(priceText),
        ),
      ],
    );
  }

  Widget _buttons(String priceText) {
    return SizedBox(
      height: 44.6,
      child: Row(
        children: [
          Container(
            constraints: const BoxConstraints(minWidth: 65.5),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFF0F0F2)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(8),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              priceText,
              style: overviewText(15, AppColors.orange, FontWeight.w500),
            ),
          ),
          const SizedBox(width: 14.6),
          Expanded(
            child: Material(
              color: isEnrolled ? const Color(0xFF2EB872) : AppColors.orange,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: onEnroll,
                child: Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: isEnrolling
                        ? const SizedBox(
                            key: ValueKey('spinner'),
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: Colors.white,
                            ),
                          )
                        : Row(
                            key: ValueKey(isEnrolled),
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (isEnrolled) ...[
                                const Icon(
                                  Icons.check_circle_rounded,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                const SizedBox(width: 6),
                              ],
                              Text(
                                isEnrolled ? 'Enrolled' : actions.enrollLabel,
                                style: overviewText(
                                  15,
                                  Colors.white,
                                  FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
