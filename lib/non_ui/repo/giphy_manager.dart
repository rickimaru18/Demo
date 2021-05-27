import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/retry.dart';
import 'package:morphosis_flutter_demo/non_ui/modal/gif.dart';
import 'package:morphosis_flutter_demo/non_ui/utils/logger.dart';

class GiphyManager {
  GiphyManager(this.baseUrl, this.apiKey);

  final String baseUrl;
  final String apiKey;

  /// Get trending GIFs.
  String getSearchUrl(String keyword) =>
      '$baseUrl/search?api_key=$apiKey&limit=25&offset=0&rating=g&lang=en&q=$keyword';

  /// Get trending GIFs.
  String get trendingUrl =>
      '$baseUrl/trending?api_key=$apiKey&limit=25&rating=g';

  /// Search GIFs based from [keyword].
  Future<List<GIF>?> searchGifs(String keyword) async {
    final RetryClient client = RetryClient(Client());

    List<GIF>? res;

    try {
      final Response response = await client.get(
        Uri.parse(keyword.isEmpty ? trendingUrl : getSearchUrl(keyword)),
      );

      if (response.statusCode != 200) {
        return res;
      }

      final Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;

      res = (data['data'] as List)
          .cast<Map<String, dynamic>>()
          .map((Map<String, dynamic> gifJson) => GIF.fromJson(gifJson))
          .toList();
    } catch (e) {
      logger('GiphyManager', 'ERROR getting GIFs: $e');
    } finally {
      client.close();
    }

    return res;
  }
}
