import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../../data/models/course_overview_data.dart';
import '../../../widgets/common/app_network_image.dart';
import 'overview_painters.dart';
import 'overview_text.dart';

/// Course banner: photo with the purple tint, label, play button and the
/// videos/classes badges. Positions are relative to the 319 x 198 design.
class CourseHeroBanner extends StatelessWidget {
  final CourseHero hero;
  final VoidCallback onPlay;

  const CourseHeroBanner({super.key, required this.hero, required this.onPlay});

  static const _w = 319.2;
  static const _h = 197.9;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: _w / _h,
      child: LayoutBuilder(
        builder: (context, c) {
          final k = c.maxWidth / _w;
          return DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF8C9BC8).withAlpha(28),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(11),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  const DecoratedBox(decoration: _tint),
                  AppNetworkImage(
                    url: hero.imageUrl,
                    alignment: const Alignment(0, -0.4),
                    fallback: const SizedBox.shrink(),
                  ),
                  // Purple → pink tint over the photo, as in the design.
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0xFF6A4BF0).withAlpha(170),
                          const Color(0xFFC88A9A).withAlpha(140),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10 * k,
                    left: 0,
                    right: 0,
                    child: Text(
                      hero.label,
                      textAlign: TextAlign.center,
                      style: overviewText(
                        17 * k,
                        Colors.white,
                        FontWeight.w900,
                      ).copyWith(letterSpacing: 0.5 * k),
                    ),
                  ),
                  Positioned(
                    left: (159.6 - 25.5) * k,
                    top: (98.6 - 25.5) * k,
                    width: 51 * k,
                    height: 51 * k,
                    child: Semantics(
                      button: true,
                      label: 'Play course preview',
                      child: GestureDetector(
                        onTap: onPlay,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          padding: EdgeInsets.only(left: 3 * k),
                          alignment: Alignment.center,
                          child: CustomPaint(
                            size: Size(17.4 * k, 22.3 * k),
                            painter: const PlayPainter(color: AppColors.orange),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 165 * k,
                    height: 26.5 * k,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _HeroBadge(
                          k: k,
                          icon: Icons.account_balance_rounded,
                          text: '${hero.videoCount} Videos',
                        ),
                        SizedBox(width: 5 * k),
                        _HeroBadge(
                          k: k,
                          icon: Icons.co_present_rounded,
                          text: '${hero.classCount} Class',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  static const _tint = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFF7553F2), Color(0xFFD69A9A)],
    ),
  );
}

class _HeroBadge extends StatelessWidget {
  final double k;
  final IconData icon;
  final String text;

  const _HeroBadge({required this.k, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12 * k),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(3 * k),
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11 * k, color: const Color(0xFF3FA2E6)),
          SizedBox(width: 4 * k),
          Text(
            text,
            style: overviewText(
              11 * k,
              const Color(0xFF2B2B2B),
              FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
