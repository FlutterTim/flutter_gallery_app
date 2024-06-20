import 'package:flutter_gallery/models/image.dart';

class SearchResult {
  SearchResult({
    required this.images,
    required this.pageNumber,
    required this.amountOfImages,
    required this.nextPage,
  });

  List<ImageModel> images;
  int pageNumber;
  int amountOfImages;
  String nextPage;

  factory SearchResult.fromMap(Map<String, dynamic> map) {
    return SearchResult(
        pageNumber: map['page'],
        amountOfImages: map['total_results'],
        images: map['photos'] != null
            ? List<ImageModel>.from(
                (map['photos'] as List<dynamic>).map(
                  (image) => ImageModel.fromMap(image as Map<String, dynamic>),
                ),
              )
            : [],
        nextPage: map['next_page']);
  }
}
