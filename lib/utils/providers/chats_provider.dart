import '/library.dart';

final chatProvider = FutureProvider.family<QuerySnapshot?, String>(
  (ref, chatId) {
    return Utils()
        .firebaseFirestore
        .collection(DBPathsConstants.chatsPath)
        .doc(chatId)
        .collection(ChatModel.messagesKey)
        .orderBy(MessageModel.timestampKey)
        .get();
  },
);
