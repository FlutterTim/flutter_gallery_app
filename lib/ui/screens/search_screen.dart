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

  final iconButtonSize = 48.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var localizations = context.localizations;
    var searchController = useTextEditingController();
    var imagesProviderNotifier = ref.watch(imagesProvider.notifier);
    // TODO: replace this valuenotifier with the corresponding values from the imagesprovider.
    ValueNotifier<SearchResult?> searchResult = useState(null);
    final FocusNode textFieldFocusNode = FocusNode();

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
                    focusNode: textFieldFocusNode,
                  ),
                ),
                Button(
                  onPressed: () async {
                    textFieldFocusNode.unfocus();
                    return searchResult.value = await imagesProviderNotifier
                        .fetchImages(searchController.text);
                  },
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
                Expanded(
                  child: ImagesOverview(
                    images: searchResult.value!.images,
                    notifier: imagesProviderNotifier,
                    allowInteraction: false,
                  ),
                ),
                if (searchResult.value != null) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      searchResult.value!.pageNumber > 1
                          ? SizedBox(
                              height: iconButtonSize,
                              width: iconButtonSize,
                              child: IconButton(
                                icon: const Icon(Icons.chevron_left),
                                onPressed: () async => searchResult.value =
                                    await imagesProviderNotifier.fetchImages(
                                  searchController.text,
                                  pageNumber:
                                      searchResult.value!.pageNumber - 1,
                                ),
                              ),
                            )
                          : SizedBox(width: iconButtonSize),
                      Text(
                        searchResult.value!.pageNumber.toString(),
                      ),
                      searchResult.value!.nextPage.isNotEmpty
                          ? SizedBox(
                              height: iconButtonSize,
                              width: iconButtonSize,
                              child: IconButton(
                                icon: const Icon(Icons.chevron_right),
                                onPressed: () async => searchResult.value =
                                    await imagesProviderNotifier.fetchImages(
                                  searchController.text,
                                  pageNumber:
                                      searchResult.value!.pageNumber + 1,
                                ),
                              ),
                            )
                          : SizedBox(width: iconButtonSize),
                    ],
                  ),
                ],
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
