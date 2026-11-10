import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import 'overview_painters.dart';
import 'overview_text.dart';

class OverviewHeader extends StatelessWidget {
  final String title;
  final VoidCallback onBack;

  const OverviewHeader({super.key, required this.title, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: Row(
        children: [
          Semantics(
            button: true,
            label: 'Back',
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onBack,
              child: const SizedBox(
                width: 53,
                height: 46,
                child: Padding(
                  padding: EdgeInsets.only(left: 24.4),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: CustomPaint(
                      size: Size(10.5, 19),
                      painter: ChevronPainter(
                        color: Colors.black,
                        strokeWidth: 2.6,
                        pointsLeft: true,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: overviewText(18.5, AppColors.dark, FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
