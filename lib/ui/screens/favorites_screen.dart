import 'package:flutter/material.dart';
import 'package:flutter_gallery/models/image.dart';
import 'package:flutter_gallery/services/image.dart';
import 'package:flutter_gallery/ui/widgets/images_overview.dart';
import 'package:flutter_gallery/utilities/localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<ImageModel> images = ref.watch(bookmarkedImagesProvider);
    var localizations = context.localizations;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          localizations.favoritesScreenTitle,
        ),
      ),
      body: images.isNotEmpty
          ? ImagesOverview(
              images: images,
            )
          : Center(
              child: Text(
                localizations.noFavoriteImages,
              ),
            ),
    );
  }
}
