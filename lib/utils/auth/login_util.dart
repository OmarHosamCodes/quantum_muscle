// ignore_for_file: use_build_context_synchronously

import 'package:quantum_muscle/library.dart';

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
