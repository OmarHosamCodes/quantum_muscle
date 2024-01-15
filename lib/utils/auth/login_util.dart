// ignore_for_file: use_build_context_synchronously

import '/library.dart';

class LoginUtil extends Utils {
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
      await firebaseAuth.signInWithEmailAndPassword(
        email: email.toLowerCase(),
        password: password,
      );
      if (user != null) {
        ref.invalidate(userProvider);
        ref.read(userProvider(Utils().userUid!));
      }
    } on FirebaseAuthException catch (e) {
      openQmDialog(
        context: context,
        title: S.current.Failed,
        message: e.message!,
      );
    }
  }
}
