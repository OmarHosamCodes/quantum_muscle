class UserImageModel {
  static const String titleKey = 'title';
  static const String imageEncodedKey = 'imageEncoded';
  static const String createdAtKey = 'created_at';
  static const String descriptionKey = 'description';

  String title;
  String imageEncoded;
  String createdAt;
  String description;

  UserImageModel({
    required this.title,
    required this.imageEncoded,
    required this.createdAt,
    required this.description,
  });

  factory UserImageModel.fromMap(
    Map<String, dynamic> map,
  ) =>
      UserImageModel(
        title: map[titleKey],
        imageEncoded: map[imageEncodedKey],
        createdAt: map[createdAtKey],
        description: map[descriptionKey],
      );

  Map<String, dynamic> toMap() => {
        titleKey: title,
        imageEncodedKey: imageEncoded,
        createdAtKey: createdAt,
        descriptionKey: description,
      };
}
