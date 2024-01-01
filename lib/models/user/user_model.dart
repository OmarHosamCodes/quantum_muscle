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
  static const String profileImageKey = 'profileImage';
  static const String bioKey = 'bio';
  static const String imagesKey = 'images';
  static const String followersKey = 'followers';
  static const String followingKey = 'following';
  static const String tagsKey = 'tags';
  static const String friendsKey = 'friends';
  static const String chatsKey = 'chats';

  String? ratID;
  String? name;
  String? email;
  int? age;
  String? phone;
  String? password;
  UserType? type;
  Map<String, String>? height;
  Map<String, String>? weight;
  String? profileImage;
  String? bio;
  List? images = [];
  List? followers;
  List? following;
  List? tags;
  List? chats;

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
    this.profileImage,
    this.bio,
    this.images,
    this.followers,
    this.following,
    this.tags,
    this.chats,
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
      type: UserType.values.firstWhere(
        (element) => element.toString() == map[typeKey],
      ),
      height: map[heightKey],
      weight: map[weightKey],
      profileImage: map[profileImageKey],
      bio: map[bioKey],
      images: map[imagesKey],
      followers: map[followersKey],
      following: map[followingKey],
      tags: map[tagsKey],
      chats: map[chatsKey],
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
      profileImageKey: profileImage,
      bioKey: bio,
      imagesKey: images,
      followersKey: followers,
      followingKey: following,
      tagsKey: tags,
      chatsKey: chats,
    };
  }
}
