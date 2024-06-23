import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gallery/models/image.dart';
import 'package:flutter_gallery/routes.dart';
import 'package:flutter_gallery/services/image.dart';
import 'package:flutter_gallery/ui/widgets/alert_dialog.dart';
import 'package:flutter_gallery/utilities/localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ImagesOverview extends ConsumerWidget {
  const ImagesOverview({
    super.key,
    required this.images,
    this.notifier,
    this.isSearchScreen = false,
  });

  final List<ImageModel> images;
  final ImagesNotifier? notifier;
  final bool isSearchScreen;

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
            onTap: () => !isSearchScreen
                ? context.push(
                    imageScreenRoute,
                    extra: image,
                  )
                : null,
            onLongPress: () => !isSearchScreen
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
