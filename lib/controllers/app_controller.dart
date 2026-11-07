import 'package:flutter/foundation.dart';

import '../data/catalog.dart';
import '../models/media_item.dart';

class AppController extends ChangeNotifier {
  static const profiles = ['Naomi', 'Alex', 'Invitado'];
  String? profile;
  final Map<String, Set<String>> _saved = {};
  void selectProfile(String name) {
    profile = name;
    notifyListeners();
  }

  void clearProfile() {
    profile = null;
    notifyListeners();
  }

  bool isSaved(MediaItem item) => _saved[profile]?.contains(item.id) ?? false;
  List<MediaItem> get favorites => catalog.where(isSaved).toList();
  void toggle(MediaItem item) {
    if (profile == null) return;
    final ids = _saved.putIfAbsent(profile!, () => <String>{});
    if (!ids.add(item.id)) ids.remove(item.id);
    notifyListeners();
  }

  List<MediaItem> search(String query, String type) => catalog
      .where(
        (item) =>
            (type == 'Todos' || item.type == type) &&
            '${item.title} ${item.genre}'.toLowerCase().contains(
              query.trim().toLowerCase(),
            ),
      )
      .toList();
}
