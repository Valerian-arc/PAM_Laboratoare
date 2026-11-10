import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/navigation_provider.dart';
import '../widgets/common/custom_bottom_nav.dart';
import 'course_overview/course_overview_screen.dart';
import 'home/home_screen.dart';

class MainNavigationScreen extends StatelessWidget {
  const MainNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<NavigationProvider>();
    final index = nav.currentIndex;

    return PopScope(
      // Android back button on another tab returns to Home first.
      canPop: index == NavigationProvider.homeTab,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) nav.select(NavigationProvider.homeTab);
      },
      child: Scaffold(
        body: IndexedStack(
          index: index,
          children: [
            const HomeScreen(),
            CourseOverviewScreen(
              onBack: () => nav.select(NavigationProvider.homeTab),
            ),
            const _PlaceholderTab('Search Screen'),
            const _PlaceholderTab('Message Screen'),
            const _PlaceholderTab('Account Screen'),
          ],
        ),
        // The Course Overview page is full-screen in the design.
        bottomNavigationBar: index == NavigationProvider.coursesTab
            ? null
            : CustomBottomNav(currentIndex: index, onTap: nav.select),
      ),
    );
  }
}

class _PlaceholderTab extends StatelessWidget {
  final String text;

  const _PlaceholderTab(this.text);

  @override
  Widget build(BuildContext context) => Center(
    child: Text(text, style: const TextStyle(color: Color(0xFF858597))),
  );
}
