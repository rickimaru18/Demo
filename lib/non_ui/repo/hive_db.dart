import 'dart:async';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:morphosis_flutter_demo/non_ui/modal/gif.dart';

class HiveDB {
  HiveDB() {
    _init();
  }

  final Completer<void> _initCompleter = Completer<void>();

  late final Box<List<GIF>> _gifsBox;

  /// Initialization.
  Future<void> _init() async {
    await Hive.initFlutter();

    final GIFAdapter gifAdapter = GIFAdapter();
    if (!Hive.isAdapterRegistered(gifAdapter.typeId)) {
      Hive.registerAdapter<GIF>(gifAdapter);
    }

    _gifsBox = await Hive.openBox<List<GIF>>('gifs');
    _initCompleter.complete();
  }

  /// Initialization status.
  Future<void> get isInitComplete => _initCompleter.future;

  /// Check if [keyword] exist.
  bool isKeywordExist(String keyword) {
    if (keyword.isEmpty) {
      return false;
    }

    return _gifsBox.containsKey(keyword.trim().toLowerCase());
  }

  /// Get GIFs.
  List<GIF>? getGIFs(String keyword) =>
      _gifsBox.get(keyword.trim().toLowerCase());

  /// Save [gifs] with [keyword] as the key.
  Future<bool> save(String keyword, List<GIF> gifs) async {
    if (keyword.isEmpty) {
      return false;
    }

    await _gifsBox.put(keyword.trim().toLowerCase(), gifs);
    return true;
  }
}
