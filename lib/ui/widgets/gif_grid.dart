import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:morphosis_flutter_demo/non_ui/modal/gif.dart';

class GIFGrid extends StatelessWidget {
  const GIFGrid({
    required this.gifs,
    Key? key,
  }) : super(key: key);

  final List<GIF> gifs;

  @override
  Widget build(BuildContext context) {
    final int crossAxisCount =
        (MediaQuery.of(context).size.width / 200).round();

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
      ),
      itemCount: gifs.length,
      itemBuilder: (_, int i) => GridTile(
        child: CachedNetworkImage(
          imageUrl: gifs[i].url,
          fit: BoxFit.cover,
          progressIndicatorBuilder: (_, __, DownloadProgress downloadProgress) {
            return Center(
              child: CircularProgressIndicator(
                value: downloadProgress.progress,
              ),
            );
          },
          errorWidget: (_, __, ___) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
