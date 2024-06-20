class SearchResult {
  SearchResult({
    required this.images,
    required this.pageNumber,
    required this.amountOfImages,
    required this.nextPage,
  });

  List<String> images;
  int pageNumber;
  int amountOfImages;
  String nextPage;

  factory SearchResult.fromMap(Map<String, dynamic> map) {
    return SearchResult(
        pageNumber: map['page'],
        amountOfImages: map['total_results'],
        images: map['photos'] != null
            ? List<String>.from(
                (map['photos'] as List<dynamic>).map(
                  (image) => (image as Map<String, dynamic>)['src']['medium']
                      as String,
                ),
              )
            : [],
        nextPage: map['next_page']);
  }
}
