import '/library.dart';

class UserModel {
  static const String ratIDKey = 'ratID';
  static const String nameKey = 'name';
  static const String emailKey = 'email';
  static const String ageKey = 'age';
  static const String phoneKey = 'phone';
  static const String typeKey = 'type';
  static const String heightKey = 'height';
  static const String weightKey = 'weight';
  static const String imageKey = 'image';
  static const String bioKey = 'bio';
  static const String imagesKey = 'images';
  static const String followersKey = 'followers';
  static const String followingKey = 'following';
  static const String tagsKey = 'tags';
  static const String friendsKey = 'friends';

  String? ratID;
  String? name;
  String? email;
  int? age;
  String? phone;
  String? password;
  String? type;
  Map<String, String>? height;
  Map<String, String>? weight;
  String? image;
  String? bio;
  List? images = [];
  List? followers;
  List? following;
  List? tags;
  List? friends;

  UserModel({
    this.ratID,
    this.name,
    this.email,
    this.age,
    this.phone,
    this.password,
    this.type,
    this.height,
    this.weight,
    this.image,
    this.bio,
    this.images,
    this.followers,
    this.following,
    this.tags,
    this.friends,
  });

  factory UserModel.fromMap(
      DocumentSnapshot<Map<String, dynamic>> doc, SnapshotOptions? options) {
    var map = doc.data()!;
    return UserModel(
      ratID: map[ratIDKey],
      name: map[nameKey],
      email: map[emailKey],
      age: map[ageKey],
      phone: map[phoneKey],
      type: map[typeKey],
      height: map[heightKey],
      weight: map[weightKey],
      image: map[imageKey],
      bio: map[bioKey],
      images: map[imagesKey],
      followers: map[followersKey],
      following: map[followingKey],
      tags: map[tagsKey],
      friends: map[friendsKey],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      ratIDKey: ratID,
      nameKey: name,
      emailKey: email,
      ageKey: age,
      phoneKey: phone,
      typeKey: type,
      heightKey: height,
      weightKey: weight,
      imageKey: image,
      bioKey: bio,
      imagesKey: images,
      followersKey: followers,
      followingKey: following,
      tagsKey: tags,
      friendsKey: friends,
    };
  }
}
