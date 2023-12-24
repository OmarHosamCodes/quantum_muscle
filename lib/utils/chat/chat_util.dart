// ignore_for_file: use_build_context_synchronously

import '/library.dart';

class ChatUtil extends Utils {
  Future<void> startChat({
    required String userId,
    required BuildContext context,
  }) async {
    final String uniqueId = const Uuid().v8();
    openQmLoaderDialog(context: context);
    final userChats = await firebaseFirestore
        .collection(DBPathsConstants.usersPath)
        .doc(userId)
        .get()
        .then((value) => value.get(DBPathsConstants.chatsPath)) as List?;
    final myChats = await firebaseFirestore
        .collection(DBPathsConstants.usersPath)
        .doc(userUid)
        .get()
        .then((value) => value.get(DBPathsConstants.chatsPath)) as List?;
    // if (userChats != null && userChats.contains(uniqueId))
    try {
      await firebaseFirestore
          .collection(DBPathsConstants.usersPath)
          .doc(userUid)
          .update(
        {
          DBPathsConstants.chatsPath: FieldValue.arrayUnion([
            {
              uniqueId: userId,
            }
          ]),
        },
      );
      await firebaseFirestore
          .collection(DBPathsConstants.usersPath)
          .doc(userId)
          .update(
        {
          DBPathsConstants.chatsPath: FieldValue.arrayUnion([
            {
              uniqueId: userUid,
            }
          ]),
        },
      );
      await firebaseFirestore
          .collection(DBPathsConstants.chatsPath)
          .doc(uniqueId)
          .set(
        {
          ChatModel.messagesKey: [],
        },
      );
      context.pop();

      context.go(Routes.chatsR);
    } on FirebaseException catch (e) {
      context.pop();
      openQmDialog(
        context: context,
        title: S.of(context).Failed,
        message: e.message!,
      );
    }
  }
}
