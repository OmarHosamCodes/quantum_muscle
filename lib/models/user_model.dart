class UserModel {
  final String? ratID;
  final String? name;
  final int? age;
  final String? email;
  final String? phone;
  final String? password;
  final Map<String, String>? height;
  final Map<String, String>? width;

  UserModel({
    this.ratID,
    this.name,
    this.age,
    this.email,
    this.phone,
    this.password,
    this.height,
    this.width,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      ratID: map['ratID'],
      name: map['name'],
      age: map['age'],
      email: map['email'],
      phone: map['phone'],
      password: map['password'],
      height: map['height'],
      width: map['width'],
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
      'height': height,
      'width': width,
    };
  }
}
