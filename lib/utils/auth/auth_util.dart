import '../../library.dart';

class AuthUtil {
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseStorage = FirebaseStorage.instance;
  UserModel userModel = UserModel();
  late User? user = firebaseAuth.currentUser;
}
