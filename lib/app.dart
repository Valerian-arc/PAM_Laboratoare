import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/app_colors.dart';
import 'data/repositories/learning_repository.dart';
import 'screens/main_navigation_screen.dart';
import 'state/course_overview_provider.dart';
import 'state/home_provider.dart';
import 'state/navigation_provider.dart';

class LearningApp extends StatelessWidget {
  /// Injected in tests; the app uses the JSON asset repository by default.
  final LearningRepository? repository;

  const LearningApp({super.key, this.repository});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<LearningRepository>(
          create: (_) => repository ?? AssetLearningRepository(),
        ),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(
          create: (context) =>
              HomeProvider(context.read<LearningRepository>())..load(),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              CourseOverviewProvider(context.read<LearningRepository>())
                ..load(),
        ),
      ],
      child: MaterialApp(
        title: 'Learning App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Poppins',
          scaffoldBackgroundColor: AppColors.homeBackground,
          primaryColor: AppColors.primaryBlue,
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primaryBlue,
            primary: AppColors.primaryBlue,
            secondary: AppColors.accentOrange,
          ),
        ),
        home: const MainNavigationScreen(),
      ),
    );
  }
}
