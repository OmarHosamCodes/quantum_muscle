import '/library.dart';

class Utils {
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseStorage = FirebaseStorage.instance;
  UserModel userModel = UserModel();
  User? get user => firebaseAuth.currentUser;
  String? get userUid => user!.uid;
  String? get userRatID => userUid!.substring(0, 16);
  String get local => Intl.getCurrentLocale();
  bool get isEnglish => local == 'en';
  bool get isArabic => local == 'ar';
}
