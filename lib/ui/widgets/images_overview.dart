import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gallery/models/image.dart';
import 'package:flutter_gallery/routes.dart';
import 'package:flutter_gallery/services/image.dart';
import 'package:flutter_gallery/ui/widgets/alert_dialog.dart';
import 'package:flutter_gallery/utilities/localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// [ImagesOverview] provides a [GridView] with all the images in the required
/// [images] list. You can provide an option [notifier] which is a
/// [ImagesNotifier] if you use one in your screen or other widget already
/// There is also a [allowInteraction] boolean that you can use to stop the
/// images from being interactable so you can't delete/view them.
class ImagesOverview extends ConsumerWidget {
  const ImagesOverview({
    super.key,
    required this.images,
    this.notifier,
    this.allowInteraction = true,
  });

  final List<ImageModel> images;
  final ImagesNotifier? notifier;
  final bool allowInteraction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var localizations = context.localizations;
    ImagesNotifier imagesProviderNotifier =
        notifier ?? ref.watch(imagesProvider.notifier);

    return GridView.count(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: <Widget>[
        for (var image in images) ...[
          GestureDetector(
            onTap: () => allowInteraction
                ? context.push(
                    imageScreenRoute,
                    extra: image,
                  )
                : null,
            onLongPress: () => allowInteraction
                ? showDialog(
                    context: context,
                    builder: (context) => GalleryAlertDialog(
                      title: localizations.removeImageTitle,
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            localizations.removeImageDescription(image.name),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          FastCachedImage(url: image.url),
                        ],
                      ),
                      onConfirm: () async {
                        await imagesProviderNotifier.removeImage(image.url);
                        if (context.mounted) {
                          context.pop();
                        }
                      },
                    ),
                  )
                : null,
            child: Image(
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
          ),
        ],
      ],
    );
  }
}
