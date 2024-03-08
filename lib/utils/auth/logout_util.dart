// ignore_for_file: use_build_context_synchronously

import 'package:quantum_muscle/library.dart';

/// A utility class for handling user logout functionality.
///
/// This class provides a method to log out the user by signing them out from Firebase authentication.
/// It also handles displaying a loader while the logout process is in progress and shows an error dialog if there is an exception.
class LogoutUtil extends Utils {
  /// Logs out the user.
  ///
  /// This method signs out the user from Firebase authentication and handles the loading and error display.
  ///
  /// Parameters:
  /// - [context]: The build context to show the loader and error dialog.
  ///
  /// Throws:
  /// - [FirebaseAuthException]: If there is an error during the sign out process.
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
