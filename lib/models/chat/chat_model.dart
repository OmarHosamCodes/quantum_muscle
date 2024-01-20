import '/library.dart';

class ChatModel {
  static const String chatIdKey = 'chatId';
  static const String messagesKey = 'messages';
  static const String chatDocIdKey = 'chatDocId';
  static const String chatUserIdKey = 'chatUserId';
  static const String chatUserNameKey = 'chatUserName';
  static const String chatUserImageKey = 'chatUserImage';
  static const String lastMessageKey = 'lastMessage';
  static const String lastMessageSenderKey = 'lastMessageSender';
  static const String modelKey = 'chatModel';

  String chatId;
  List<MessageModel> messages;
  String chatDocId;
  String chatUserId;
  String chatUserName;
  String chatUserImage;
  String? lastMessage;
  String? lastMessageSender;
  ChatModel({
    required this.chatId,
    required this.messages,
    required this.chatDocId,
    required this.chatUserId,
    required this.chatUserName,
    required this.chatUserImage,
    this.lastMessage,
    this.lastMessageSender,
  });

  factory ChatModel.fromMap(Map<String, dynamic> map) => ChatModel(
        chatId: map[chatIdKey],
        messages: map[messagesKey],
        chatDocId: map[chatDocIdKey],
        chatUserId: map[chatUserIdKey],
        chatUserName: map[chatUserNameKey],
        chatUserImage: map[chatUserImageKey],
        lastMessage: map[lastMessageKey],
        lastMessageSender: map[lastMessageSenderKey],
      );

  Map<String, dynamic> toMap() => {
        chatIdKey: chatId,
        messagesKey: messages,
        chatDocIdKey: chatDocId,
        chatUserIdKey: chatUserId,
        chatUserNameKey: chatUserName,
        chatUserImageKey: chatUserImage,
        lastMessageKey: lastMessage,
        lastMessageSenderKey: lastMessageSender,
      };
}
