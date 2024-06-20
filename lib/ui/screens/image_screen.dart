import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gallery/models/image.dart';
import 'package:flutter_gallery/utilities/localizations.dart';

class ImageScreen extends StatelessWidget {
  const ImageScreen({
    super.key,
    required this.image,
  });

  final ImageModel image;

  @override
  Widget build(BuildContext context) {
    var localizations = context.localizations;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          image.name,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FastCachedImage(
              fadeInDuration: Duration.zero,
              loadingBuilder: (context, fastCachedProgressData) =>
                  const CircularProgressIndicator(),
              url: image.url,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              localizations.imageDescription(
                image.name,
                image.author,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
