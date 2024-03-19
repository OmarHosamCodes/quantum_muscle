// ignore_for_file: use_build_context_synchronously

import 'package:quantum_muscle/library.dart';

/// Utility class for handling forget password functionality.
class ForgetPasswordUtil extends Utils {
  /// Sends a reset email to the specified email address.
  ///
  /// Throws a [FirebaseAuthException] if an error occurs during the process.
  Future<void> sendResetEmail({
    required String email,
    required BuildContext context,
  }) async {
    try {
      if (user != null) {
        await firebaseAuth.sendPasswordResetEmail(email: email);
      }
      openQmDialog(
        context: context,
        title: S.current.Success,
        message: S.current.EmailSentSuccessfully,
      );
    } on FirebaseAuthException catch (e) {
      openQmDialog(
        context: context,
        title: S.current.DefaultError,
        message: e.message!,
      );
    }
  }
}

/// Notifier for managing the state of the forget password functionality.
class ForgetPasswordNotifier extends StateNotifier<ForgetPasswordState> {
  /// Creates a new instance of [ForgetPasswordNotifier].
  ForgetPasswordNotifier()
      : super(ForgetPasswordState(isEmailSent: false, countDown: 30));

  /// Sets the value of [setIsEmailSent] in the state.
  void setIsEmailSent({required bool value}) =>
      state = state.copyWith(isEmailSent: value);

  /// Sets the value of [setIsEmailSent] in the state.
  void setCountDown(int value) => state = state.copyWith(countDown: value);
}
