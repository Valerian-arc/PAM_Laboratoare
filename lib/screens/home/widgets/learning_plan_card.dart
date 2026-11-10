import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../../data/models/home_page_data.dart';

class LearningPlanCard extends StatelessWidget {
  final LearningPlan plan;

  const LearningPlanCard({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          plan.title,
          style: const TextStyle(
            color: AppColors.primaryDark,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(8),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              for (var i = 0; i < plan.items.length; i++) ...[
                LearningPlanRow(item: plan.items[i]),
                if (i < plan.items.length - 1)
                  const Divider(height: 1, color: Color(0xFFF0F0F5)),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class LearningPlanRow extends StatelessWidget {
  final LearningPlanItem item;

  const LearningPlanRow({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          SizedBox(
            width: 28,
            height: 28,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: item.progress),
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeOutCubic,
              builder: (context, value, _) => CircularProgressIndicator(
                value: value,
                strokeWidth: 3.5,
                backgroundColor: AppColors.progressTrack,
                valueColor: const AlwaysStoppedAnimation(AppColors.primaryBlue),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              item.title,
              style: const TextStyle(
                color: AppColors.primaryDark,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${item.completed}',
                  style: const TextStyle(
                    color: AppColors.primaryDark,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: '/${item.total}',
                  style: const TextStyle(
                    color: AppColors.textGrey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
