import '/library.dart';

class UserModel {
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
  String? followers;
  String? following;
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
  });

  factory UserModel.fromMap(
      DocumentSnapshot<Map<String, dynamic>> doc, SnapshotOptions? options) {
    var map = doc.data()!;
    return UserModel(
      ratID: map['ratID'],
      name: map['name'],
      email: map['email'],
      age: map['age'],
      phone: map['phone'],
      type: map['type'],
      height: map['height'],
      weight: map['weight'],
      image: map['image'],
      bio: map['bio'],
      images: map['images'],
      followers: map['followers'],
      following: map['following'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ratID': ratID,
      'name': name,
      'email': email,
      'age': age,
      'phone': phone,
      'type': type,
      'height': height,
      'weight': weight,
      'image': image,
      'bio': bio,
      'images': images,
      'followers': followers,
      'following': following,
    };
  }
}
