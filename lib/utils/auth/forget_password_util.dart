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

/// Represents the state of the forget password functionality.
class ForgetPasswordState {
  /// Creates a new instance of [ForgetPasswordState].
  ForgetPasswordState({
    required this.isEmailSent,
    required this.countDown,
  });

  /// Indicates whether the email has been sent successfully.
  bool isEmailSent;

  /// The countdown value for the reset password functionality.
  int countDown;

  /// Creates a copy of the current [ForgetPasswordState] instance with
  /// the provided changes.
  ForgetPasswordState copyWith({
    bool? isEmailSent,
    int? countDown,
  }) {
    return ForgetPasswordState(
      isEmailSent: isEmailSent ?? this.isEmailSent,
      countDown: countDown ?? this.countDown,
    );
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

/// Provider for the forget password notifier and state.
final forgetPasswordProvider =
    StateNotifierProvider<ForgetPasswordNotifier, ForgetPasswordState>(
  (ref) => ForgetPasswordNotifier(),
);
