import 'dart:convert';
import 'dart:io';

import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gallery/main.dart';
import 'package:flutter_gallery/models/image.dart';
import 'package:flutter_gallery/models/searchresult.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';

final imagesProvider =
    StateNotifierProvider<ImagesNotifier, List<ImageModel>>((ref) {
  return ImagesNotifier();
});

final bookmarkedImagesProvider = StateProvider<List<ImageModel>>((ref) =>
    ref.watch(imagesProvider).where((image) => image.bookmark).toList());

class ImagesNotifier extends StateNotifier<List<ImageModel>> {
  ImagesNotifier() : super([]);

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

  void addImage(ImageModel image) {
    state = [...state, image];
  }

  Future<void> removeAllImages() async {
    state = [];
    await FastCachedImageConfig.clearAllCachedImages(showLog: true);
  }

  Future<void> removeImage(String imageUrl) async {
    state = [
      for (final image in state)
        if (image.url != imageUrl) image,
    ];
    await FastCachedImageConfig.deleteCachedImage(imageUrl: imageUrl);
  }

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
