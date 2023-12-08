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
      openQmLoaderDialog(context: context);
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      ref.invalidate(userFutureProvider);
      ref.read(userFutureProvider);
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          if (user != null) {
            context.pop();
            RoutingController().changeRoute(0);
          } else {
            return;
          }
        },
      );
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
