// ignore_for_file: use_build_context_synchronously

import 'package:quantum_muscle/library.dart';

/// Utility class for handling chat functionality.
class ChatUtil extends Utils {
  /// Starts a chat with the user with the provided [userId].
  Future<void> startChat({
    required String userId,
    required BuildContext context,
  }) async {
    final uniqueId = const Uuid().v8();
    QmLoader.openLoader(context: context);

    final userDocRef =
        firebaseFirestore.collection(DBPathsConstants.usersPath).doc(userId);
    final myDocRef =
        firebaseFirestore.collection(DBPathsConstants.usersPath).doc(userUid);

    final userChatExists = await _checkChatExists(userDocRef);
    final myChatExists = await _checkChatExists(myDocRef);

    if (userChatExists && myChatExists) {
      QmLoader.closeLoader(context: context);
      context.go(Routes.chatsR);
      return;
    }

    try {
      final batch = firebaseFirestore.batch()
        ..update(userDocRef, {
          UserModel.chatsKey: FieldValue.arrayUnion([
            {uniqueId: userUid},
          ]),
        })
        ..update(myDocRef, {
          UserModel.chatsKey: FieldValue.arrayUnion([
            {uniqueId: userId},
          ]),
        });

      final initMessage = MessageModel(
        id: const Uuid().v8(),
        senderId: PrivateConstants.serverSenderId,
        timestamp: Timestamp.now(),
        message: PrivateConstants.serverChatInitialMessage,
        type: PrivateConstants.serverMessageType,
      );

      batch.set(
        firebaseFirestore
            .collection(UserModel.chatsKey)
            .doc(uniqueId)
            .collection(ChatModel.messagesKey)
            .doc(initMessage.id),
        initMessage.toMap(),
      );

      await batch.commit();
      context.go(Routes.chatsR);
    } catch (e) {
      QmLoader.closeLoader(context: context);
      openQmDialog(
        context: context,
        title: S.of(context).Failed,
        message: e.toString(),
      );
    }
  }

  Future<bool> _checkChatExists(DocumentReference docRef) async {
    final snapshot =
        await docRef.get() as DocumentSnapshot<Map<String, dynamic>>;
    final chats = snapshot.data()?[UserModel.chatsKey] as List<dynamic>? ?? [];

    return chats.indexWhere(
          (element) => (element as Map).values.contains(userUid),
        ) !=
        -1;
  }

  /// Adds a text message to the chat with the provided [chatId].
  Future<void> addTextMessage({
    required String chatId,
    required String message,
    required WidgetRef ref,
  }) async {
    final messageToSend = MessageModel(
      id: const Uuid().v8(),
      senderId: Utils().userUid!,
      message: message,
      timestamp: Timestamp.now(),
    );
    await firebaseFirestore
        .collection(DBPathsConstants.chatsPath)
        .doc(chatId)
        .collection(DBPathsConstants.messagesPath)
        .doc(messageToSend.id)
        .set(messageToSend.toMap());
    ref
      ..invalidate(chatsProvider)
      ..read(chatsProvider);
  }

  /// Adds a text message to the chat with the provided [chatId].
  Future<void> removeMessage({
    required String chatId,
    required String messageId,
    required BuildContext context,
  }) async {
    try {
      await firebaseFirestore
          .collection(DBPathsConstants.chatsPath)
          .doc(chatId)
          .collection(DBPathsConstants.messagesPath)
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

  /// Adds a request message to the chat with the provided [chatId].
  Future<void> addRequestMessage({
    required String chatId,
    required String message,
    required String programRequestId,
  }) async {
    final requestMessage = MessageModel(
      id: const Uuid().v8(),
      senderId: Utils().userUid!,
      message: message,
      timestamp: Timestamp.now(),
      type: MessageType.request,
      programRequestId: programRequestId,
    );
    await firebaseFirestore
        .collection(DBPathsConstants.chatsPath)
        .doc(chatId)
        .collection(DBPathsConstants.messagesPath)
        .add(requestMessage.toMap());
  }
}
