// ignore_for_file: use_build_context_synchronously

import '../../library.dart';

class LoginUtil extends AuthUtil {
  Future<void> logUserIn({
    required String email,
    required String password,
    required BuildContext context,
    required GlobalKey<FormState> formKey,
  }) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    try {
      openQmLoaderDialog(context: context);
      await firebaseAuth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((_) {
        if (firebaseAuth.currentUser != null) {
          context.pop();
          context.go(Routes.homeR);
        } else {
          return;
        }
      });
    } on FirebaseAuthException catch (e) {
      context.pop();

      openQmDialog(
        context: context,
        title: S.of(context).Failed,
        message: e.message!,
      );
    }
  }
}
