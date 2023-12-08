// ignore_for_file: use_build_context_synchronously

import '/library.dart';

class LogoutUtil extends Utils {
  Future<void> logout(BuildContext context) async {
    openQmLoaderDialog(context: context);
    await firebaseAuth.signOut();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (firebaseAuth.currentUser == null) {
        context.pop();
      }
    });
  }
}
