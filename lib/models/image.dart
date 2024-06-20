class ImageModel {
  ImageModel({
    required this.url,
    required this.name,
    required this.author,
    this.bookmark = false,
  });

  String url;
  String name;
  String author;
  bool bookmark;

  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      url: map['src']['medium'],
      name: map['alt'],
      author: map['photographer'],
    );
  }
}
