import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/courses_screen.dart';
import 'widgets/custom_bottom_nav.dart';

void main() {
  runApp(const LearningApp());
}

class LearningApp extends StatelessWidget {
  const LearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learning App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: const Color(0xFFF8F9FB),
        primaryColor: const Color(0xFF3D5CFF),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3D5CFF),
          primary: const Color(0xFF3D5CFF),
          secondary: const Color(0xFFFF6B00),
        ),
      ),
      home: const MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const CoursesScreen(),
    const Center(child: Text('Search Screen', style: TextStyle(color: Color(0xFF858597)))),
    const Center(child: Text('Message Screen', style: TextStyle(color: Color(0xFF858597)))),
    const Center(child: Text('Account Screen', style: TextStyle(color: Color(0xFF858597)))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
