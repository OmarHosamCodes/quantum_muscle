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
        email: email,
        password: password,
      );
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Future.delayed(const Duration(seconds: 1), () {
          context.pop();
        });
      });
    } on FirebaseAuthException catch (e) {
      context.pop();

      openQmDialog(
        context: context,
        title: S.current.Failed,
        message: e.message!,
      );
    }
    try {
      if (user != null) {
        firebaseAnalytics.logEvent(
          name: AnalyticsEventNamesConstants.register,
        );
        ref.invalidate(userProvider);
        ref.read(userProvider(Utils().userUid!));
        afterSignUp(
          userName: userName,
          userType: userType,
          context: context,
        );
        RoutingController().changeRoute(0);
      }
    } catch (e) {
      context.pop();

      openQmDialog(
        context: context,
        title: S.current.Failed,
        message: e.toString(),
      );
    }
  }

  Future<void> afterSignUp({
    required String userName,
    required UserType userType,
    required BuildContext context,
  }) async {
    if (user != null) {
      Set<String> tempSet = <String>{};
      for (var i = 0; i < 1; i++) {
        tempSet.addAll([
          ...userName.split(' '),
          userName,
          userName.toLowerCase(),
          userName.toUpperCase(),
          ...userName
              .split(SimpleConstants.emptyString)
              .map((e) => e.toLowerCase()),
          ...userName
              .split(SimpleConstants.emptyString)
              .map((e) => e.toUpperCase()),
          "#${user!.uid.substring(0, 16)}",
          user!.email!,
        ]);
        tempSet.remove(SimpleConstants.emptyString);
        tempSet.remove(' ');
        tempSet.remove('  ');
      }

      final userModel = UserModel(
        id: user!.uid,
        ratID: "#${user!.uid.substring(0, 16)}",
        name: userName,
        email: user!.email!,
        age: 0,
        phone: '0',
        type: userType,
        weight: {"0": "0"},
        height: {"0": "0"},
        profileImageURL: '',
        bio: '',
        followers: [],
        following: [],
        content: [],
        tags: tempSet.toList(),
        chats: [],
        programs: [],
      );

      await firebaseFirestore
          .collection(DBPathsConstants.usersPath)
          .doc(userUid)
          .set(userModel.toMap());
    }
  }
}
