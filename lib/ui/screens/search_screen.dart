import 'package:flutter/material.dart';
import 'package:flutter_gallery/models/searchresult.dart';
import 'package:flutter_gallery/services/image.dart';
import 'package:flutter_gallery/ui/widgets/button.dart';
import 'package:flutter_gallery/ui/widgets/images_overview.dart';
import 'package:flutter_gallery/utilities/localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchScreen extends HookConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var localizations = context.localizations;
    var searchController = useTextEditingController();
    var imageService = ref.read(imageServiceProvider);
    ValueNotifier<SearchResult?> searchResult = useState(null);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          localizations.searchScreenTitle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                  ),
                ),
                Button(
                  onPressed: () async => searchResult.value =
                      await imageService.fetchImages(searchController.text),
                  buttonText: localizations.search,
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            if (searchResult.value != null) ...[
              if (searchResult.value!.amountOfImages == 0) ...[
                Text(localizations.noImagesFound),
              ] else ...[
                ImagesOverview(
                  images: searchResult.value!.images,
                ),
              ],
            ] else ...[
              Text(localizations.initialSearchMessage),
            ],
          ],
        ),
      ),
    );
  }
}
