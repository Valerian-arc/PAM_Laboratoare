import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../../data/models/course_overview_data.dart';
import 'overview_text.dart';

class CourseTabs extends StatelessWidget {
  final List<CourseTab> tabs;
  final String selectedId;
  final ValueChanged<String> onSelected;

  const CourseTabs({
    super.key,
    required this.tabs,
    required this.selectedId,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < tabs.length; i++) ...[
          if (i > 0) const SizedBox(width: 14.6),
          _TabItem(
            label: tabs[i].label,
            selected: tabs[i].id == selectedId,
            onTap: () => onSelected(tabs[i].id),
          ),
        ],
      ],
    );
  }
}

class _TabItem extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _TabItem({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      selected: selected,
      button: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: SizedBox(
          width: 96.2,
          child: Column(
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: overviewText(
                  17,
                  selected ? AppColors.orange : AppColors.tabGrey,
                  FontWeight.w500,
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(label, maxLines: 1, softWrap: false),
                ),
              ),
              const SizedBox(height: 3.6),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 1.5,
                color: selected ? AppColors.orange : Colors.transparent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
