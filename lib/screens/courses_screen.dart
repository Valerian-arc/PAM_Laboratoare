import 'package:flutter/material.dart';
import '../models/course_model.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  int selectedCategoryIndex = 0;
  final List<String> categories = ['All', 'Popular', 'New'];

  final List<CourseItem> courses = const [
    CourseItem(
      title: 'Product Design v1.0',
      author: 'Robertson Connie',
      price: 190.0,
      durationHours: 16,
      imageAsset: 'assets/images/course_product_design.png',
    ),
    CourseItem(
      title: 'Java Development',
      author: 'Nguyen Shane',
      price: 190.0,
      durationHours: 16,
      imageAsset: 'assets/images/course_java.png',
    ),
    CourseItem(
      title: 'Visual Design',
      author: 'Bert Pullman',
      price: 250.0,
      durationHours: 14,
      imageAsset: 'assets/images/course_visual.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF3D5CFF);
    const primaryDark = Color(0xFF1F1F39);
    const accentOrange = Color(0xFFFF6B00);
    const textGrey = Color(0xFF858597);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row: Course title + Profile Avatar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Course',
                    style: TextStyle(
                      color: primaryDark,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Avatar: body spills out below the pink circle, as in Figma
                  Padding(
                    padding: const EdgeInsets.only(right: 3),
                    child: Image.asset(
                      'assets/images/avatar.png',
                      width: 50,
                      height: 60,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),

              // Search Bar Field with Filter Icon
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F3FD),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Find Course',
                    hintStyle: const TextStyle(
                      color: Color(0xFFB8B8D2),
                      fontSize: 15,
                    ),
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: Color(0xFFB8B8D2),
                      size: 24,
                    ),
                    suffixIcon: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Icon(
                        Icons.tune_rounded,
                        color: Color(0xFFB8B8D2),
                        size: 24,
                      ),
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 19),

              // Category cards: the image is the whole card (rounded background +
              // character whose head pokes a few px above the top edge).
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _categoryCard(
                    image: 'assets/images/language_illustration.png',
                    imageHeight: 88.8,
                    label: 'Languege',
                    labelColor: primaryBlue,
                    pillColor: const Color(0xFFF6FBFF),
                    pillLeft: 77,
                    pillTop: 54.5,
                  ),
                  _categoryCard(
                    image: 'assets/images/painting_illustration.png',
                    imageHeight: 90.2,
                    label: 'Painting',
                    labelColor: const Color(0xFF7E5FB2),
                    pillColor: const Color(0xFFF8F1FF),
                    pillLeft: 89,
                    pillTop: 55.2,
                  ),
                ],
              ),
              const SizedBox(height: 36),

              // Choice your course Section
              const Text(
                'Choice your course',
                style: TextStyle(
                  color: primaryDark,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Filter Tabs (All, Popular, New)
              Row(
                children: List.generate(categories.length, (index) {
                  final isSelected = selectedCategoryIndex == index;
                  return Padding(
                    padding: const EdgeInsets.only(right: 14.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategoryIndex = index;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryBlue : Colors.transparent,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Text(
                          categories[index],
                          style: TextStyle(
                            color: isSelected ? Colors.white : textGrey,
                            fontSize: 14,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),

              // Course List Items
              Column(
                children: courses.map((course) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 18),
                    padding: const EdgeInsets.all(16),
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
                    child: Row(
                      children: [
                        // Course Image Asset
                        ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.asset(
                            course.imageAsset,
                            width: 82,
                            height: 82,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 16),

                        // Course Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                course.title,
                                style: const TextStyle(
                                  color: primaryDark,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.person_outline_rounded,
                                    color: textGrey,
                                    size: 15,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    course.author,
                                    style: const TextStyle(
                                      color: textGrey,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Text(
                                    '\$${course.price.toInt()}',
                                    style: const TextStyle(
                                      color: primaryBlue,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFEBE0),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      '${course.durationHours} hours',
                                      style: const TextStyle(
                                        color: accentOrange,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _categoryCard({
    required String image,
    required double imageHeight,
    required String label,
    required Color labelColor,
    required Color pillColor,
    required double pillLeft,
    required double pillTop,
  }) {
    return SizedBox(
      width: 160,
      height: imageHeight,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(image, fit: BoxFit.fill),
          ),
          // Label pill hugging the right edge of the card
          Positioned(
            left: pillLeft,
            top: pillTop,
            right: 0.5,
            height: 26,
            child: Container(
              padding: const EdgeInsets.only(left: 9, top: 6),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: pillColor,
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(13),
                ),
              ),
              child: Text(
                label,
                style: TextStyle(
                  color: labelColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
