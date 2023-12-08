class UserImageModel {
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
  ) {
    return UserImageModel(
      title: map['title'],
      imageEncoded: map['imageEncoded'],
      createdAt: map['created_at'],
      description: map['description'],
    );
  }

  Map<String, dynamic> toMap() => {
        'title': title,
        'imageEncoded': imageEncoded,
        'created_at': createdAt,
        'description': description,
      };
}
