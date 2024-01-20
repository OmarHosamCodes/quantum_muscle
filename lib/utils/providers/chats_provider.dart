import '/library.dart';

final chatsProvider = StreamProvider<List<ChatModel>>(
  (ref) async* {
    List<ChatModel> chats = [];
    final userWathcer = ref.watch(userProvider(Utils().userUid!));
    List<Map<String, dynamic>> chatsMaps = userWathcer.maybeWhen(
      data: (data) {
        return data.chats.map((e) => e as Map<String, dynamic>).toList();
      },
      orElse: () => [],
    );
    for (var i = 0; i < chatsMaps.length; i++) {
      final messages = await Utils()
          .firebaseFirestore
          .collection(DBPathsConstants.chatsPath)
          .doc(chatsMaps[i].keys.elementAt(i))
          .collection(ChatModel.messagesKey)
          .orderBy(MessageModel.timestampKey, descending: true)
          .get()
          .then((_) =>
              _.docs.map((_) => MessageModel.fromMap(_.data())).toList());
      final chatUser = await Utils()
          .firebaseFirestore
          .collection(DBPathsConstants.usersPath)
          .doc(chatsMaps[i].values.elementAt(i))
          .get()
          .then((_) => UserModel.fromMap(_.data()!));

      chats.add(
        ChatModel(
          chatId: chatsMaps[i].keys.elementAt(i),
          messages: messages,
          chatDocId: chatsMaps[i].keys.elementAt(i),
          chatUserId: chatsMaps[i].values.elementAt(i),
          chatUserName: chatUser.name,
          chatUserImage: chatUser.profileImage,
          lastMessage: messages.first.message,
          lastMessageSender: messages.first.senderId,
        ),
      );
    }
    yield chats;
  },
);
