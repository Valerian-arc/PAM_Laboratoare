import 'package:flutter/foundation.dart';

/// Index of the selected bottom-navigation tab.
class NavigationProvider extends ChangeNotifier {
  static const homeTab = 0;
  static const coursesTab = 1;

  int _currentIndex = homeTab;

  int get currentIndex => _currentIndex;

  void select(int index) {
    if (index == _currentIndex) return;
    _currentIndex = index;
    notifyListeners();
  }
}
