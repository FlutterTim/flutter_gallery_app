import 'package:flutter/material.dart';
import 'package:flutter_gallery/models/image.dart';
import 'package:flutter_gallery/services/image.dart';
import 'package:flutter_gallery/ui/widgets/alert_dialog.dart';
import 'package:flutter_gallery/ui/widgets/images_overview.dart';
import 'package:flutter_gallery/utilities/localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CachedImagesScreen extends ConsumerWidget {
  const CachedImagesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<ImageModel> images = ref.watch(imagesProvider);
    var imagesProviderNotifier = ref.watch(imagesProvider.notifier);

    var localizations = context.localizations;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          localizations.cachedImagesScreenTitle,
        ),
        actions: images.isNotEmpty
            ? [
                IconButton(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => GalleryAlertDialog(
                      title: localizations.removeAllImagesTitle,
                      content: Text(localizations.removeAllImagesDescription),
                      onConfirm: () async {
                        await imagesProviderNotifier.removeAllImages();
                        if (context.mounted) {
                          context.pop();
                        }
                      },
                    ),
                  ),
                  icon: const Icon(
                    Icons.delete,
                  ),
                ),
              ]
            : null,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            images.isNotEmpty
                ? ImagesOverview(
                    images: images,
                  )
                : Text(
                    localizations.noCachedImages,
                  ),
          ],
        ),
      ),
    );
  }
}
