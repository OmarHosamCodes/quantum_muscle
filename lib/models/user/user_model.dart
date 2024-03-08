import 'package:quantum_muscle/library.dart';

/// Represents a user model.
class UserModel {
  /// Creates a new instance of the [UserModel] class.
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

  /// Creates an empty instance of the [UserModel] class.
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

  /// Creates a [UserModel] instance from a map.
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

  /// The unique identifier of the user.
  String id;

  /// The rat ID of the user.
  String ratID;

  /// The name of the user.
  String name;

  /// The email of the user.
  String email;

  /// The age of the user.
  int age;

  /// The phone number of the user.
  String phone;

  /// The type of the user.
  UserType type;

  /// The height of the user.
  Map<String, dynamic> height;

  /// The weight of the user.
  Map<String, dynamic> weight;

  /// The URL of the user's profile image.
  String profileImageURL;

  /// The bio of the user.
  String bio;

  /// The content created by the user.
  List<dynamic> content;

  /// The followers of the user.
  List<dynamic> followers;

  /// The users that the user is following.
  List<dynamic> following;

  /// The tags associated with the user.
  List<dynamic> tags;

  /// The chats the user is participating in.
  List<dynamic> chats;

  /// The programs the user is enrolled in.
  List<dynamic> programs;

  /// The key for the user ID.
  static const String idKey = 'id';

  /// The key for the user's rat ID.
  static const String ratIDKey = 'ratID';

  /// The key for the user's name.
  static const String nameKey = 'name';

  /// The key for the user's email.
  static const String emailKey = 'email';

  /// The key for the user's age.
  static const String ageKey = 'age';

  /// The key for the user's phone number.
  static const String phoneKey = 'phone';

  /// The key for the user's type.
  static const String typeKey = 'type';

  /// The key for the user's height.
  static const String heightKey = 'height';

  /// The key for the user's weight.
  static const String weightKey = 'weight';

  /// The key for the user's profile image URL.
  static const String profileImageURLKey = 'profileImageURL';

  /// The key for the user's bio.
  static const String bioKey = 'bio';

  /// The key for the user's content.
  static const String contentKey = 'content';

  /// The key for the user's followers.
  static const String followersKey = 'followers';

  /// The key for the user's following users.
  static const String followingKey = 'following';

  /// The key for the user's tags.
  static const String tagsKey = 'tags';

  /// The key for the user's chats.
  static const String chatsKey = 'chats';

  /// The key for the user's programs.
  static const String programsKey = 'programs';

  /// The key for the model name.
  static const String modelKey = 'UserModel';

  /// Converts the [UserModel] instance to a map.
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
