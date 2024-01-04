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
    if (isValid) {
      try {
        await firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        ref.invalidate(userFutureProvider);
        ref.read(userFutureProvider(Utils().userUid!));
        // if (user != null) RoutingController.instants.changeRoute(0);
      } on FirebaseAuthException catch (e) {
        context.pop();

        openQmDialog(
          context: context,
          title: S.current.Failed,
          message: e.message!,
        );
      }
    }
  }
}
