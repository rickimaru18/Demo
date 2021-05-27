import 'package:morphosis_flutter_demo/env.dart';
import 'package:morphosis_flutter_demo/non_ui/modal/gif.dart';
import 'package:morphosis_flutter_demo/non_ui/repo/giphy_manager.dart';
import 'package:morphosis_flutter_demo/non_ui/repo/hive_db.dart';
import 'package:morphosis_flutter_demo/non_ui/utils/logger.dart';

class Repository {
  final GiphyManager _giphyManager = GiphyManager(Env.gifAPI, Env.gifAPIKey);
  final HiveDB _hiveDB = HiveDB();

  /// Search GIFs based from [keyword].
  ///
  /// If [keyword] already searched, it will retrieve
  /// the list of GIFs stored in the database.
  Future<List<GIF>?> searchGifs(String keyword) async {
    await _hiveDB.isInitComplete;

    if (_hiveDB.isKeywordExist(keyword)) {
      logger('Repository', 'Keyword exists, fetching from local DB.');
      return _hiveDB.getGIFs(keyword);
    }

    final List<GIF>? gifs = await _giphyManager.searchGifs(keyword);

    if (gifs != null && keyword.isNotEmpty) {
      logger('Repository', 'Saving new keyword and GIFs to local DB.');
      await _hiveDB.save(keyword, gifs);
    }

    return gifs;
  }
}
