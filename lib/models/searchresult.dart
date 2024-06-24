import 'package:flutter_gallery/models/image.dart';

/// [SearchResult] is a model that contains a list of [images]
/// which are of the type [ImageModel], a [pageNumber] which is an [int],
/// [amountOfImages] which is an [int] and the [nextPage] url which is
/// a [String]
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

  /// [fromMap] uses the [map] to make a [SearchResult] object
  /// based on the values in the [map].
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
