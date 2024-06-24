import 'dart:convert';
import 'dart:io';

import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gallery/main.dart';
import 'package:flutter_gallery/models/image.dart';
import 'package:flutter_gallery/models/searchresult.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';

/// Provides a [StateNotifierProvider] which can be used in a
/// `ref.read(imageProvider)` or a `ref.watch(imageProvider)`
/// to watch or read the [List] of [ImageModel] objects.
/// It can also be called as [imageProvider.notifier] which
/// provides the [ImageNotifier].
final imagesProvider =
    StateNotifierProvider<ImagesNotifier, List<ImageModel>>((ref) {
  return ImagesNotifier();
});

/// Provides the state of the [List] of [ImageModel] objects in
/// the [ImageNotifier] but only includes the [ImageModel] objects
/// that have the [bookmark] property on [True].
final bookmarkedImagesProvider = StateProvider<List<ImageModel>>((ref) =>
    ref.watch(imagesProvider).where((image) => image.bookmark).toList());

/// The [StateNotifier] that provides the state, in this case the
/// state of the [List] of [ImageModel] objects. It also has some functions
/// that can be called when using the [StateNotifier].
class ImagesNotifier extends StateNotifier<List<ImageModel>> {
  ImagesNotifier() : super([]);

  /// The [fetchImages] function fetches the images from an URL.
  /// To search for images a [searchTerm] is required. If you want
  /// more or less images on a page you can use the [amountOfImagesPerPage]
  /// parameter to specify how many you want. If you want to see a specific
  /// page you can use the [pageNumber] parameter, and last but not least, you
  /// can use the [url] parameter to provide an URL that can be used to fetch
  /// from. It returns a [Future] of a [SearchResult] object when it's done
  /// fetching.
  Future<SearchResult> fetchImages(String searchTerm,
      {int pageNumber = 1, int amountOfImagesPerPage = 9, String? url}) async {
    if (amountOfImagesPerPage > 80) amountOfImagesPerPage = 80;
    if (amountOfImagesPerPage < 1) amountOfImagesPerPage = 1;
    var response = await get(
      Uri.parse(url ??
          'https://api.pexels.com/v1/search?query=$searchTerm&page=$pageNumber&per_page=$amountOfImagesPerPage&locale=$locale'),
      headers: {
        HttpHeaders.authorizationHeader: dotenv.env['IMAGE_API_KEY']!,
      },
    );
    var responseJson = jsonDecode(response.body) as Map<String, dynamic>;

    var searchResult = SearchResult.fromMap(responseJson);

    for (var image in searchResult.images) {
      if (!state.contains(image)) {
        addImage(image);
      }
    }

    return searchResult;
  }

  /// [addImage] adds the [image] to the state.
  void addImage(ImageModel image) {
    state = [...state, image];
  }

  /// [removeAllImages] removes all images from the state and from the
  /// cache.
  Future<void> removeAllImages() async {
    state = [];
    await FastCachedImageConfig.clearAllCachedImages(showLog: true);
  }

  /// [removeImage] removes the image with the given [imageUrl]
  /// from the state and the cache.
  Future<void> removeImage(String imageUrl) async {
    state = [
      for (final image in state)
        if (image.url != imageUrl) image,
    ];
    await FastCachedImageConfig.deleteCachedImage(imageUrl: imageUrl);
  }

  /// [bookmarkImage] changes the [bookmark] parameter of the image
  /// in the state with the given [imageUrl].
  void bookmarkImage(String imageUrl) {
    state = [
      for (final image in state)
        if (image.url == imageUrl)
          image.copyWith(bookmark: !image.bookmark)
        else
          image,
    ];
  }
}
