// ignore_for_file: use_build_context_synchronously

import '../../library.dart';

class RegisterUtile {
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseStorage = FirebaseStorage.instance;
  UserModel userModel = UserModel();
  late User? user = firebaseAuth.currentUser;

  Future<void> register({
    required String email,
    required String password,
    required String userName,
    required String userType,
    required GlobalKey<FormState> formKey,
    required BuildContext context,
  }) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    try {
      openQmLoaderDialog(context: context);

      await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then(
        (_) {
          if (firebaseAuth.currentUser != null) {
            afterSignUp(
              userName: userName,
              userType: userType,
              context: context,
            );
          } else {
            return;
          }
        },
      );
    } on FirebaseAuthException catch (e) {
      context.pop();

      openQmDialog(
        context: context,
        title: S.of(context).Failed,
        message: e.message!,
      );
    }
  }

  Future<void> afterSignUp({
    required String userName,
    required String userType,
    required BuildContext context,
  }) async {
    if (user != null) {
      userModel.email = user!.email;
      userModel.ratID = "#${user!.uid.substring(0, 16)}";
      userModel.name = userName;
      userModel.bio = "No Bio Yet";
      userModel.image = null;
      userModel.userType = userType;
      userModel.weight = {"0": "0"};
      userModel.height = {"0": "0"};
      await firebaseFirestore
          .collection(DBPathsConstants.usersPath)
          .doc(user!.uid)
          .set(userModel.toMap());
    }
  }
}
