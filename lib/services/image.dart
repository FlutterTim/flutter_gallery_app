import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gallery/main.dart';
import 'package:flutter_gallery/models/searchresult.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';

final imageServiceProvider = Provider<ImageService>((ref) {
  return ImageService();
});

class ImageService {
  Future<SearchResult> fetchImages(String searchTerm,
      {int pageNumber = 1, int amountOfImagesPerPage = 9}) async {
    if (amountOfImagesPerPage > 80) amountOfImagesPerPage = 80;
    if (amountOfImagesPerPage < 1) amountOfImagesPerPage = 1;
    var response = await get(
      Uri.parse(
          'https://api.pexels.com/v1/search?query=$searchTerm&page=$pageNumber&per_page=$amountOfImagesPerPage&locale=$locale'),
      headers: {
        HttpHeaders.authorizationHeader: dotenv.env['IMAGE_API_KEY']!,
      },
    );
    var responseJson = jsonDecode(response.body) as Map<String, dynamic>;

    var searchResult = SearchResult.fromMap(responseJson);

    return searchResult;
  }
}
