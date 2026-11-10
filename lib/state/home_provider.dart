import 'package:flutter/foundation.dart';

import '../data/models/home_page_data.dart';
import '../data/repositories/learning_repository.dart';
import 'load_status.dart';

class HomeProvider extends ChangeNotifier {
  final LearningRepository _repository;

  HomeProvider(this._repository);

  LoadStatus _status = LoadStatus.initial;
  HomePageData? _data;
  String? _error;

  LoadStatus get status => _status;
  HomePageData? get data => _data;
  String? get error => _error;
  bool get hasUnreadNotifications =>
      _data?.header.notification.hasUnread ?? false;

  /// Loads the page. With [refresh] the current content stays visible while
  /// new data is fetched (pull-to-refresh), otherwise a loader is shown.
  Future<void> load({bool refresh = false}) async {
    if (_status == LoadStatus.loading) return;
    _status = LoadStatus.loading;
    _error = null;
    if (!refresh) _data = null;
    notifyListeners();

    try {
      _data = await _repository.fetchHomePage(forceRefresh: refresh);
      _status = LoadStatus.success;
    } catch (e) {
      _error = 'Could not load the home page.\n$e';
      _status = _data == null ? LoadStatus.failure : LoadStatus.success;
    }
    notifyListeners();
  }

  void markNotificationsRead() {
    final data = _data;
    if (data == null || !data.header.notification.hasUnread) return;
    _data = data.copyWith(
      header: data.header.copyWith(
        notification: data.header.notification.copyWith(hasUnread: false),
      ),
    );
    notifyListeners();
  }
}
