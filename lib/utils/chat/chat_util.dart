// ignore_for_file: use_build_context_synchronously

import '/library.dart';

class ChatUtil extends Utils {
  Future<void> startChat({
    required String userId,
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    final String uniqueId = const Uuid().v8();
    openQmLoaderDialog(context: context);
    final userDocRef =
        firebaseFirestore.collection(DBPathsConstants.usersPath).doc(userId);
    final myDocRef =
        firebaseFirestore.collection(DBPathsConstants.usersPath).doc(userUid);
    if (await userDocRef.get().then((value) =>
            (value.data()![UserModel.chatsKey] as List).indexWhere(
                (element) => (element as Map).values.contains(userUid!)) !=
            -1) &&
        await myDocRef.get().then((value) =>
            (value.data()![UserModel.chatsKey] as List).indexWhere(
                (element) => (element as Map).values.contains(userId)) !=
            -1)) {
      context.pop();
      context.go(Routes.chatsR);
    } else {
      try {
        await firebaseFirestore
            .collection(DBPathsConstants.usersPath)
            .doc(userUid)
            .update({
          UserModel.chatsKey: FieldValue.arrayUnion([
            {
              uniqueId: userId,
            }
          ])
        });
        await firebaseFirestore
            .collection(DBPathsConstants.usersPath)
            .doc(userId)
            .update({
          UserModel.chatsKey: FieldValue.arrayUnion([
            {
              uniqueId: userUid,
            }
          ])
        });
        final initMessage = MessageModel(
            senderId: PrivateConstants.serverSenderId,
            timestamp: Timestamp.now(),
            message: PrivateConstants.serverChatInitialMessage,
            type: PrivateConstants.serverMessageType);
        await firebaseFirestore
            .collection(UserModel.chatsKey)
            .doc(uniqueId)
            .collection(ChatModel.messagesKey)
            .doc()
            .set(initMessage.toMap());

        ref.invalidate(chatFutureProvider(userUid!));
        ref.read(chatFutureProvider(userUid!));
        ref.invalidate(userFutureProvider(userUid!));
        ref.read(userFutureProvider(userUid!));

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

  Future<void> addTextMessage({
    required String chatId,
    required String message,
  }) async {
    await firebaseFirestore
        .collection(DBPathsConstants.chatsPath)
        .doc(chatId)
        .collection(DBPathsConstants.chatsMessagesPath)
        .add({
      MessageModel.messageKey: message,
      MessageModel.senderIdKey: Utils().userUid,
      MessageModel.timestampKey: Timestamp.now(),
      MessageModel.typeKey: MessageType.text.name,
    });
  }

  Future<void> removeMessage({
    required String chatId,
    required String messageId,
    required BuildContext context,
  }) async {
    try {
      await firebaseFirestore
          .collection(DBPathsConstants.chatsPath)
          .doc(chatId)
          .collection(DBPathsConstants.chatsMessagesPath)
          .doc(messageId)
          .delete();
    } catch (e) {
      openQmDialog(
        context: context,
        title: S.current.Failed,
        message: e.toString(),
      );
    }
  }

  Future<void> addRequestMessage({
    required String chatId,
    required String message,
  }) async {
    await firebaseFirestore
        .collection(DBPathsConstants.chatsPath)
        .doc(chatId)
        .collection(DBPathsConstants.chatsMessagesPath)
        .add({
      MessageModel.messageKey: message,
      MessageModel.senderIdKey: Utils().userUid,
      MessageModel.timestampKey: Timestamp.now(),
      MessageModel.typeKey: MessageType.request.name,
    });
  }
}
