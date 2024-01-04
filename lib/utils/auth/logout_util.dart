// ignore_for_file: use_build_context_synchronously

import '/library.dart';

class LogoutUtil extends Utils {
  Future<void> logout(BuildContext context) async {
    await firebaseAuth.signOut();
  }
}
