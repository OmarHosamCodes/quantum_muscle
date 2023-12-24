import '/library.dart';

class ChatModel {
  static const String chatIdKey = 'chatId';
  static const String messagesKey = 'messages';
  final String chatId;
  final List messages;
  ChatModel({
    required this.chatId,
    required this.messages,
  });
  factory ChatModel.fromMap(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final map = snapshot.data()!;
    return ChatModel(
      chatId: map[chatIdKey],
      messages: map[messagesKey],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      chatIdKey: chatId,
    };
  }
}
