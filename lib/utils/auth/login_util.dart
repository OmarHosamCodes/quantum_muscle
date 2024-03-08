// ignore_for_file: use_build_context_synchronously

import 'package:quantum_muscle/library.dart';

/// Utility class for handling login functionality.
class LoginUtil extends Utils {
  /// Logs the user in with the provided email and password.
  ///
  /// This method validates the form using the [formKey] and opens a loader
  /// using [QmLoader.openLoader] while the login process is in progress.
  /// If the login is successful, the loader is closed using [QmLoader.closeLoader].
  /// If an error occurs during the login process, a dialog is opened using
  /// [openQmDialog] to display the error message.
  ///
  /// After a successful login, the user's login event is logged using
  /// [firebaseAnalytics] and the [userProvider] is invalidated and
  /// refreshed using ref.invalidate and ref.read.
  ///
  /// Throws a [FirebaseAuthException] if an error occurs during the login process.
  Future<void> logUserIn({
    required String email,
    required String password,
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required WidgetRef ref,
  }) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    try {
      QmLoader.openLoader(context: context);
      await firebaseAuth.signInWithEmailAndPassword(
        email: email.toLowerCase(),
        password: password,
      );
      QmLoader.closeLoader(context: context);
    } on FirebaseAuthException catch (e) {
      QmLoader.closeLoader(context: context);
      openQmDialog(
        context: context,
        title: S.current.Failed,
        message: e.message!,
      );
    }
    if (user != null) {
      try {
        await firebaseAnalytics.logLogin(
          loginMethod: 'email',
        );
        ref
          ..invalidate(userProvider)
          ..read(userProvider(Utils().userUid!));
      } catch (e) {
        openQmDialog(
          context: context,
          title: S.current.Failed,
          message: e.toString(),
        );
      }
    }
  }
}
