import 'package:flutter_test/flutter_test.dart';
import 'package:morphosis_flutter_demo/env.dart';
import 'package:morphosis_flutter_demo/non_ui/modal/gif.dart';
import 'package:morphosis_flutter_demo/non_ui/repo/giphy_manager.dart';

void main() {
  test('Success GIF search', () async {
    final GiphyManager giphyManager = GiphyManager(
      'https://api.giphy.com/v1/gifs',
      'VfFMZ84IYhALNJEWpdLPSsFplBWjD29E',
    );

    final List<GIF>? gifs = await giphyManager.searchGifs('pokemon');

    expect(gifs!.length, 25);
  });

  test('Failed GIF search', () async {
    final GiphyManager giphyManager = GiphyManager(
      'https://api.giphy.com/v1/gifs',
      'VfFMZ84IYhALNJEWpdLPSsFplBWjD29E_INVALID',
    );

    final List<GIF>? gifs = await giphyManager.searchGifs('pokemon');

    expect(gifs, null);
  });
}
