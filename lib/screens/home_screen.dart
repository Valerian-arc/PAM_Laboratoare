import 'package:flutter/material.dart';
import '../models/course_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<LearningPlan> learningPlans = const [
    LearningPlan(title: 'Packaging Design', completed: 40, total: 48),
    LearningPlan(title: 'Product Design', completed: 6, total: 24),
  ];

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF3D5CFF);
    const primaryDark = Color(0xFF1F1F39);
    const accentOrange = Color(0xFFFF6B00);
    const textGrey = Color(0xFF858597);
    const learnCardBlue = Color(0xFFD4EBFB);
    const meetupPurple = Color(0xFF440687);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Blue Header with Overlapping Learned Today Card
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  color: primaryBlue,
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    top: 54.0,
                    bottom: 80.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Hi, Kristin',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Let's start learning",
                        style: TextStyle(
                          color: Color(0xFFEAEAFF),
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                // Profile Avatar (shirt is transparent so it blends into the header)
                Positioned(
                  top: 45.5,
                  right: 13.5,
                  child: Image.asset(
                    'assets/images/avatar_home.png',
                    width: 53,
                    height: 57,
                    fit: BoxFit.fill,
                  ),
                ),
                // Learned Today Floating Card
                Positioned(
                  left: 20,
                  right: 20,
                  bottom: -50,
                  child: Container(
                    padding: const EdgeInsets.all(18.0),
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
                          children: const [
                            Text(
                              'Learned today',
                              style: TextStyle(
                                color: textGrey,
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              'My courses',
                              style: TextStyle(
                                color: primaryBlue,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '46min ',
                                style: TextStyle(
                                  color: primaryDark,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: '/ 60min',
                                style: TextStyle(
                                  color: textGrey,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: 46 / 60,
                            minHeight: 8,
                            backgroundColor: const Color(0xFFEAEAFF),
                            valueColor: const AlwaysStoppedAnimation<Color>(accentOrange),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 70),

            // Horizontal Carousel Banner (illustration sits inside the card, as in Figma)
            SizedBox(
              height: 153,
              child: ListView(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  SizedBox(
                    width: 248,
                    height: 153,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // Card background + character on the right
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              color: learnCardBlue,
                              alignment: Alignment.centerRight,
                              child: Image.asset(
                                'assets/images/learn_illustration.png',
                                width: 126,
                                height: 153,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        // Title drawn over the raised arm, single line like in Figma
                        const Positioned(
                          left: 18.5,
                          top: 20,
                          width: 241,
                          child: Text(
                            'What do youwant to learn today',
                            maxLines: 1,
                            softWrap: false,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              color: primaryDark,
                              fontSize: 15.8,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 18,
                          top: 104,
                          width: 84,
                          height: 30,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: accentOrange,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              padding: EdgeInsets.zero,
                            ),
                            child: const Text(
                              'Get Started',
                              style: TextStyle(
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
                  const SizedBox(width: 13),
                  // Peek of the next card
                  SizedBox(
                    width: 248,
                    height: 153,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        color: learnCardBlue,
                        alignment: Alignment.centerLeft,
                        child: Image.asset(
                          'assets/images/learn_peek.png',
                          width: 94,
                          height: 153,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Learning Plan Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Learning Plan',
                    style: TextStyle(
                      color: primaryDark,
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
                      children: learningPlans.asMap().entries.map((entry) {
                        final index = entry.key;
                        final plan = entry.value;
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 28,
                                    height: 28,
                                    child: CircularProgressIndicator(
                                      value: plan.progress,
                                      strokeWidth: 3.5,
                                      backgroundColor: const Color(0xFFEAEAFF),
                                      valueColor: const AlwaysStoppedAnimation<Color>(
                                        primaryBlue,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Text(
                                      plan.title,
                                      style: const TextStyle(
                                        color: primaryDark,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '${plan.completed}',
                                          style: const TextStyle(
                                            color: primaryDark,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '/${plan.total}',
                                          style: const TextStyle(
                                            color: textGrey,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (index < learningPlans.length - 1)
                              const Divider(height: 1, color: Color(0xFFF0F0F5)),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Meetup Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: double.infinity,
                  height: 120,
                  color: const Color(0xFFEDE0FC),
                  child: Stack(
                    children: [
                      // Group illustration (with its soft circle) on the right edge
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Image.asset(
                          'assets/images/meetup_illustration.png',
                          width: 120,
                          height: 120,
                          fit: BoxFit.fill,
                        ),
                      ),
                      const Positioned(
                        left: 23.5,
                        top: 28.5,
                        child: Text(
                          'Meetup',
                          style: TextStyle(
                            color: meetupPurple,
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      // Subtitle runs into the illustration and is cut at the girl's hair
                      const Positioned(
                        left: 23.5,
                        top: 54,
                        width: 225,
                        child: Text(
                          'Off-line exchange of learning experience',
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            color: meetupPurple,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 35),
          ],
        ),
      ),
    );
  }
}
