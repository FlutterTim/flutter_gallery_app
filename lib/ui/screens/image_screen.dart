import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gallery/models/image.dart';
import 'package:flutter_gallery/services/image.dart';
import 'package:flutter_gallery/utilities/localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// The [ImageScreen] shows the [image] in more detail. It also shows the
/// name of the image and who made the image. You can also bookmark an image
/// here.
class ImageScreen extends HookConsumerWidget {
  const ImageScreen({
    super.key,
    required this.image,
  });

  final ImageModel image;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    var localizations = context.localizations;
    ValueNotifier<bool> bookmarked = useState(image.bookmark);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          image.name,
        ),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(imagesProvider.notifier).bookmarkImage(
                    image.url,
                  );
              bookmarked.value = !bookmarked.value;
            },
            icon: Icon(
              bookmarked.value ? Icons.star : Icons.star_border,
            ),
          ),
        ],
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
