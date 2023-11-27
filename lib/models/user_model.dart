class UserModel {
  String? ratID;
  String? name;
  int? age;
  String? email;
  String? phone;
  String? password;
  String? userType;
  Map<String, String>? height;
  Map<String, String>? weight;
  String? image;
  String? bio;

  UserModel({
    this.ratID,
    this.name,
    this.age,
    this.email,
    this.phone,
    this.password,
    this.userType,
    this.height,
    this.weight,
    this.image,
    this.bio,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      ratID: map['ratID'],
      name: map['name'],
      age: map['age'],
      email: map['email'],
      phone: map['phone'],
      password: map['password'],
      userType: map['userType'],
      height: map['height'],
      weight: map['weight'],
      image: map['image'],
      bio: map['bio'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ratID': ratID,
      'name': name,
      'age': age,
      'email': email,
      'phone': phone,
      'password': password,
      'userType': userType,
      'height': height,
      'weight': weight,
      'image': image,
      'bio': bio,
    };
  }
}
