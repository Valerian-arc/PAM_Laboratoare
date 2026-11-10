import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../../data/models/home_page_data.dart';
import '../../../widgets/common/app_network_image.dart';

class MeetupCard extends StatelessWidget {
  final Meetup data;

  const MeetupCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        height: 120,
        color: AppColors.meetupBackground,
        child: Stack(
          children: [
            Positioned(
              top: 12,
              right: 14,
              width: 96,
              height: 96,
              child: ClipOval(
                child: AppNetworkImage(
                  url: data.imageUrl,
                  fallback: Image.asset(
                    'assets/images/meetup_illustration.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 23.5,
              top: 26,
              right: 124,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title,
                    style: const TextStyle(
                      color: AppColors.meetupPurple,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    data.subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.meetupPurple,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
