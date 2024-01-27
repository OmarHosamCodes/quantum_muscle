import '/library.dart';

class UserModel {
  static const String idKey = 'id';
  static const String ratIDKey = 'ratID';
  static const String nameKey = 'name';
  static const String emailKey = 'email';
  static const String ageKey = 'age';
  static const String phoneKey = 'phone';
  static const String typeKey = 'type';
  static const String heightKey = 'height';
  static const String weightKey = 'weight';
  static const String profileImageURLKey = 'profileImageURL';
  static const String bioKey = 'bio';
  static const String contentKey = 'content';
  static const String followersKey = 'followers';
  static const String followingKey = 'following';
  static const String tagsKey = 'tags';
  static const String friendsKey = 'friends';
  static const String chatsKey = 'chats';
  static const String programsKey = 'programs';
  static const String modelKey = 'UserModel';

  String id;
  String ratID;
  String name;
  String email;
  int age;
  String phone;
  UserType type;
  Map<String, dynamic> height;
  Map<String, dynamic> weight;
  String profileImageURL;
  String bio;
  List content = [];
  List followers;
  List following;
  List tags;
  List chats;
  List programs;

  UserModel({
    required this.id,
    required this.ratID,
    required this.name,
    required this.email,
    required this.age,
    required this.phone,
    required this.type,
    required this.height,
    required this.weight,
    required this.profileImageURL,
    required this.bio,
    required this.content,
    required this.followers,
    required this.following,
    required this.tags,
    required this.chats,
    required this.programs,
  });
  UserModel.empty()
      : id = SimpleConstants.emptyString,
        ratID = SimpleConstants.emptyString,
        name = SimpleConstants.emptyString,
        email = SimpleConstants.emptyString,
        age = 0,
        phone = SimpleConstants.emptyString,
        type = UserType.trainee,
        height = {},
        weight = {},
        profileImageURL = SimpleConstants.emptyString,
        bio = SimpleConstants.emptyString,
        content = [],
        followers = [],
        following = [],
        tags = [],
        chats = [],
        programs = [];
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map[idKey],
      ratID: map[ratIDKey],
      name: map[nameKey],
      email: map[emailKey],
      age: map[ageKey],
      phone: map[phoneKey],
      type: UserType.values.firstWhere(
        (element) => element.name == map[typeKey],
      ),
      height: map[heightKey],
      weight: map[weightKey],
      profileImageURL: map[profileImageURLKey],
      bio: map[bioKey],
      content: map[contentKey],
      followers: map[followersKey],
      following: map[followingKey],
      tags: map[tagsKey],
      chats: map[chatsKey],
      programs: map[programsKey],
    );
  }

  Map<String, dynamic> toMap() => {
        idKey: id,
        ratIDKey: ratID,
        nameKey: name,
        emailKey: email,
        ageKey: age,
        phoneKey: phone,
        typeKey: type.name,
        heightKey: height,
        weightKey: weight,
        profileImageURLKey: profileImageURL,
        bioKey: bio,
        contentKey: content,
        followersKey: followers,
        followingKey: following,
        tagsKey: tags,
        chatsKey: chats,
        programsKey: programs,
      };
}
