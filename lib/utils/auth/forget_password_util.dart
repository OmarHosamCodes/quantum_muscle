// ignore_for_file: use_build_context_synchronously

import 'package:quantum_muscle/library.dart';

class ForgetPasswordUtil extends Utils {
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

class ForgetPasswordState {
  ForgetPasswordState({
    required this.isEmailSent,
    required this.countDown,
  });
  bool isEmailSent;
  int countDown;

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

class ForgetPasswordNotifier extends StateNotifier<ForgetPasswordState> {
  ForgetPasswordNotifier()
      : super(ForgetPasswordState(isEmailSent: false, countDown: 30));

  void setIsEmailSent({required bool value}) =>
      state = state.copyWith(isEmailSent: value);

  void setCountDown(int value) => state = state.copyWith(countDown: value);
}

final forgetPasswordProvider =
    StateNotifierProvider<ForgetPasswordNotifier, ForgetPasswordState>(
  (ref) => ForgetPasswordNotifier(),
);
