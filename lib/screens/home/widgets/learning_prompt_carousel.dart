import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../../data/models/home_page_data.dart';
import '../../../widgets/common/app_network_image.dart';

/// Horizontal carousel with the "What do you want to learn today?" card
/// and a peek of the next card.
class LearningPromptCarousel extends StatelessWidget {
  final LearningPrompt data;
  final VoidCallback onGetStarted;

  const LearningPromptCarousel({
    super.key,
    required this.data,
    required this.onGetStarted,
  });

  static const _cardWidth = 248.0;
  static const _cardHeight = 153.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _cardHeight,
      child: ListView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          _PromptCard(data: data, onGetStarted: onGetStarted),
          const SizedBox(width: 13),
          SizedBox(
            width: _cardWidth,
            height: _cardHeight,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AppNetworkImage(
                url: data.imageUrl,
                alignment: Alignment.centerRight,
                fallback: Container(
                  color: AppColors.learnCardBlue,
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    'assets/images/learn_peek.png',
                    width: 94,
                    height: _cardHeight,
                    fit: BoxFit.fill,
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

class _PromptCard extends StatelessWidget {
  final LearningPrompt data;
  final VoidCallback onGetStarted;

  const _PromptCard({required this.data, required this.onGetStarted});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: LearningPromptCarousel._cardWidth,
      height: LearningPromptCarousel._cardHeight,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          color: AppColors.learnCardBlue,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                bottom: 0,
                width: 118,
                child: AppNetworkImage(
                  url: data.imageUrl,
                  fallback: Image.asset(
                    'assets/images/learn_illustration.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                left: 18,
                top: 18,
                width: 118,
                child: Text(
                  data.title,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.primaryDark,
                    fontSize: 15,
                    height: 1.3,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Positioned(
                left: 18,
                top: 104,
                height: 30,
                child: ElevatedButton(
                  onPressed: onGetStarted,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentOrange,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  child: Text(
                    data.actionLabel,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
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
