class ImageModel extends Object {
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

  ImageModel copyWith({
    String? url,
    String? name,
    String? author,
    bool? bookmark,
  }) {
    return ImageModel(
      url: url ?? this.url,
      name: name ?? this.name,
      author: author ?? this.author,
      bookmark: bookmark ?? this.bookmark,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is ImageModel &&
        other.url == url &&
        other.name == name &&
        other.author == author;
  }

  @override
  int get hashCode => Object.hash(
        url,
        name,
        author,
        bookmark,
      );
}
