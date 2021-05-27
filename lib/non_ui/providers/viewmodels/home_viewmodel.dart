import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:morphosis_flutter_demo/non_ui/modal/gif.dart';
import 'package:morphosis_flutter_demo/non_ui/providers/repository.dart';

class HomeViewModel with ChangeNotifier {
  HomeViewModel(this.repository) {
    searchGIFs('');
  }

  final Repository repository;

  /// Get GIFs.
  UnmodifiableListView<GIF>? get gifs =>
      _gifs != null ? UnmodifiableListView(_gifs!) : null;
  List<GIF>? _gifs;

  /// Searching state.
  bool get isSearching => _isSearching;
  bool _isSearching = false;

  /// Search GIFs based from [keyword].
  Future<void> searchGIFs(String keyword) async {
    _isSearching = true;
    notifyListeners();

    _gifs = await repository.searchGifs(keyword);

    _isSearching = false;
    notifyListeners();
  }
}
