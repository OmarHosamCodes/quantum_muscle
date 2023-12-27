class ChatModel {
  static const String chatIdKey = 'chatId';
  static const String messagesKey = 'messages';
  final String? chatId;
  final List? messages;
  ChatModel({
    this.chatId,
    this.messages,
  });
}
