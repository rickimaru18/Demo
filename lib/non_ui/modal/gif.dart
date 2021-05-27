import 'package:hive/hive.dart';

part 'gif.g.dart';

@HiveType(typeId: 0)
class GIF {
  const GIF(this.id, this.width, this.height, this.url);

  @HiveField(0)
  final String id;

  @HiveField(1)
  final int width;

  @HiveField(2)
  final int height;

  @HiveField(3)
  final String url;

  factory GIF.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> imageData =
        json['images']['preview_gif'] as Map<String, dynamic>;

    return GIF(
      json['id'] as String,
      int.parse(imageData['width'] as String),
      int.parse(imageData['height'] as String),
      imageData['url'] as String,
    );
  }
}
