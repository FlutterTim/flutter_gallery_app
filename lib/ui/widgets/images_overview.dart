import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gallery/models/image.dart';

class ImagesOverview extends StatelessWidget {
  const ImagesOverview({
    super.key,
    required this.images,
  });

  final List<ImageModel> images;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: SingleChildScrollView(
        child: GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: <Widget>[
            for (var image in images) ...[
              Image(
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return child;
                  }
                },
                image: FastCachedImageProvider(
                  image.url,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
