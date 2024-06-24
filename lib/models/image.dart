/// [ImageModel] is a Model that contains the image information.
/// Required parameters are [url] which is a [String] and is the url of the
/// image, [name] which is a [String] and is the name of the images,
/// [author] which is a [String] and the name of the author of the picture.
/// The optional parameter is [bookmark] which is a [bool] that can be used to
/// bookmark an image, it's default is [false].
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

  /// [fromMap] uses the [map] to make a [ImageModel] object
  /// based on the values in the [map].
  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      url: map['src']['medium'],
      name: map['alt'],
      author: map['photographer'],
    );
  }

  /// [copyWith] uses the optional [url], [name], [author] and [bookmark]
  /// parameters to make a new [ImageModel] object. When a parameter is not
  /// provided it will use the existing value in the model
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

  /// Overriding the [==] function is neccesary to be able to compare two
  /// [ImageModel] objects without the value of [bookmark] which does not make
  /// a difference when checking.
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

  /// Overriding the [hashCode] function was neccesary to override the [==]
  /// function.
  @override
  int get hashCode => Object.hash(
        url,
        name,
        author,
        bookmark,
      );
}
