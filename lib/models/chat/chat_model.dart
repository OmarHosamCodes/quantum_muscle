class ChatModel {
  static const String chatIdKey = 'chatId';
  static const String messagesKey = 'messages';

  String? chatId;
  List? messages;

  ChatModel({
    this.chatId,
    this.messages,
  });

  factory ChatModel.fromMap(Map<String, dynamic> map) => ChatModel(
        chatId: map[chatIdKey],
        messages: map[messagesKey],
      );

  Map<String, dynamic> toMap() => {
        chatIdKey: chatId,
        messagesKey: messages,
      };
}
