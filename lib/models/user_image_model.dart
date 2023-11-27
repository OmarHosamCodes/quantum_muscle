import '../library.dart';

class UserImageModel {
  String? title;
  String? image;
  String? createdAt;
  String? description;

  UserImageModel({
    this.title,
    this.image,
    this.createdAt,
    this.description,
  });

  factory UserImageModel.fromMap(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final map = snapshot.data()!;
    return UserImageModel(
      title: map['title'],
      image: map['image'],
      createdAt: map['created_at'],
      description: map['description'],
    );
  }

  Map<String, dynamic> toMap() => {
        'title': title,
        'image': image,
        'created_at': createdAt,
        'description': description,
      };
}
