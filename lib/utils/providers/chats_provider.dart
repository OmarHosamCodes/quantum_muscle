// ignore_for_file: avoid_dynamic_calls

import 'package:quantum_muscle/library.dart';

final chatsProvider = StreamProvider<List<ChatModel>>(
  (ref) async* {
    final chats = <ChatModel>[];
    final userWathcer = ref.watch(userProvider(Utils().userUid!));
    final chatsMaps = userWathcer.maybeWhen(
      data: (data) {
        return data.chats.map((e) => e as Map<String, dynamic>).toList();
      },
      orElse: () => <Map<String, dynamic>>[],
    );
    for (var i = 0; i < chatsMaps.length; i++) {
      final messages = await Utils()
          .firebaseFirestore
          .collection(DBPathsConstants.chatsPath)
          .doc(chatsMaps[i].keys.elementAt(i))
          .collection(ChatModel.messagesKey)
          .orderBy(MessageModel.timestampKey, descending: true)
          .get()
          .then(
            (_) => _.docs.map((_) => MessageModel.fromMap(_.data())).toList(),
          );
      final chatUser = await Utils()
          .firebaseFirestore
          .collection(DBPathsConstants.usersPath)
          .doc(chatsMaps[i].values.elementAt(i) as String?)
          .get()
          .then((_) => UserModel.fromMap(_.data()!));

      chats.add(
        ChatModel(
          id: chatsMaps[i].keys.elementAt(i),
          messages: messages,
          docId: chatsMaps[i].keys.elementAt(i),
          userId: (chatsMaps[i].values.elementAt(i) as String?)!,
          userName: chatUser.name,
          userProfileImageURL: chatUser.profileImageURL,
          lastMessage: messages.first.message,
          lastMessageSender: messages.first.senderId,
        ),
      );
    }
    yield chats;
  },
);
