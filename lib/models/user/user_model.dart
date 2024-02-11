import 'package:quantum_muscle/library.dart';

class UserModel {
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
      id: map[idKey] as String,
      ratID: map[ratIDKey] as String,
      name: map[nameKey] as String,
      email: map[emailKey] as String,
      age: map[ageKey] as int,
      phone: map[phoneKey] as String,
      type: UserType.values.firstWhere(
        (element) => element.name == map[typeKey],
      ),
      height: map[heightKey] as Map<String, dynamic>,
      weight: map[weightKey] as Map<String, dynamic>,
      profileImageURL: map[profileImageURLKey] as String,
      bio: map[bioKey] as String,
      content: map[contentKey] as List<dynamic>,
      followers: map[followersKey] as List<dynamic>,
      following: map[followingKey] as List<dynamic>,
      tags: map[tagsKey] as List<dynamic>,
      chats: map[chatsKey] as List<dynamic>,
      programs: map[programsKey] as List<dynamic>,
    );
  }
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
  List<dynamic> content = [];
  List<dynamic> followers;
  List<dynamic> following;
  List<dynamic> tags;
  List<dynamic> chats;
  List<dynamic> programs;

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
