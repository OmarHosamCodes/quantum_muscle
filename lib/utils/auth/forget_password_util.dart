// ignore_for_file: unnecessary_getters_setters, unused_local_variable, use_build_context_synchronously
import '/library.dart';

class ForgetPasswordUtil extends Utils {
  bool _isEmailSent = false;
  int _countDown = 30;

  bool get isEmailSent => _isEmailSent;

  set isEmailSent(bool value) => _isEmailSent = value;

  int get countDown => _countDown;

  set countDown(int value) => _countDown = value;

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
      isEmailSent = true;
      startTimer();
    } on FirebaseAuthException catch (e) {
      openQmDialog(
        context: context,
        title: S.current.DefaultError,
        message: e.message!,
      );
    }
  }

  //todo needs testing
  void startTimer() {
    Timer timer = Timer.periodic(const Duration(seconds: 1), (internalTimer) {
      if (countDown == 0) {
        internalTimer.cancel();
        isEmailSent = false;
      } else {
        countDown--;
      }
    });
  }
}
