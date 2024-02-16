// ignore_for_file: use_build_context_synchronously

import 'package:quantum_muscle/library.dart';

class LogoutUtil extends Utils {
  Future<void> logout(BuildContext context) async {
    QmLoader.openLoader(context: context);
    try {
      await firebaseAuth.signOut();
      QmLoader.closeLoader(context: context);
    } on FirebaseAuthException catch (e) {
      QmLoader.closeLoader(context: context);
      openQmDialog(
        context: context,
        title: S.current.DefaultError,
        message: e.message!,
      );
    }
  }
}
