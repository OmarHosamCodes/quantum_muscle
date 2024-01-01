// ignore_for_file: use_build_context_synchronously

import '/library.dart';

class RegisterUtil extends Utils {
  Future<void> register({
    required String email,
    required String password,
    required String userName,
    required UserType userType,
    required GlobalKey<FormState> formKey,
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    try {
      openQmLoaderDialog(context: context);

      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      ref.invalidate(userFutureProvider);
      ref.read(userFutureProvider(Utils().userUid!));
      if (firebaseAuth.currentUser != null) {
        afterSignUp(
          userName: userName,
          userType: userType,
          context: context,
        );
        context.pop();
        RoutingController.instants.changeRoute(0);
      } else {
        return;
      }
    } on FirebaseAuthException catch (e) {
      context.pop();

      openQmDialog(
        context: context,
        title: S.current.Failed,
        message: e.message!,
      );
    }
  }

  Future<void> afterSignUp({
    required String userName,
    required UserType userType,
    required BuildContext context,
  }) async {
    if (user != null) {
      final userModel = UserModel();
      userModel.email = user!.email;
      userModel.ratID = "#${user!.uid.substring(0, 16)}";
      userModel.name = userName;
      userModel.bio = null;
      userModel.profileImage = null;
      userModel.type = userType;
      userModel.weight = {"0": "0"};
      userModel.height = {"0": "0"};
      userModel.followers = [];
      userModel.following = [];
      userModel.images = [];
      final tempSet = <String>{};
      for (var i = 0; i < 1; i++) {
        tempSet.addAll([
          ...userModel.name!.split(' '),
          userModel.name!,
          userModel.name!.toLowerCase(),
          userModel.name!.toUpperCase(),
          ...userModel.name!
              .split(SimpleConstants.emptyString)
              .map((e) => e.toLowerCase()),
          ...userModel.name!
              .split(SimpleConstants.emptyString)
              .map((e) => e.toUpperCase()),
          userModel.ratID!,
          userModel.email!,
          userModel.type!.name,
        ]);
        tempSet.remove(SimpleConstants.emptyString);
        tempSet.remove(' ');
        tempSet.remove('  ');
      }
      userModel.tags = tempSet.toList();
      await firebaseFirestore
          .collection(DBPathsConstants.usersPath)
          .doc(user!.uid)
          .set(userModel.toMap());
      await user!.updateDisplayName(userName);
      await user!.reload();
    }
  }
}
