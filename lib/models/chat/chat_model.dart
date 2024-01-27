import '/library.dart';

class ChatModel {
  static const String idKey = 'id';
  static const String messagesKey = 'messages';
  static const String docIdKey = 'docId';
  static const String userIdKey = 'userId';
  static const String userNameKey = 'userName';
  static const String userProfileImageURLKey = 'userProfileImageURL';
  static const String lastMessageKey = 'lastMessage';
  static const String lastMessageSenderKey = 'lastMessageSender';
  static const String modelKey = 'chatModel';

  String id;
  List<MessageModel> messages;
  String docId;
  String userId;
  String userName;
  String userProfileImageURL;
  String? lastMessage;
  String? lastMessageSender;
  ChatModel({
    required this.id,
    required this.messages,
    required this.docId,
    required this.userId,
    required this.userName,
    required this.userProfileImageURL,
    this.lastMessage,
    this.lastMessageSender,
  });

  factory ChatModel.fromMap(Map<String, dynamic> map) => ChatModel(
        id: map[idKey],
        messages: map[messagesKey],
        docId: map[docIdKey],
        userId: map[userIdKey],
        userName: map[userNameKey],
        userProfileImageURL: map[userProfileImageURLKey],
        lastMessage: map[lastMessageKey],
        lastMessageSender: map[lastMessageSenderKey],
      );

  Map<String, dynamic> toMap() => {
        idKey: id,
        messagesKey: messages,
        docIdKey: docId,
        userIdKey: userId,
        userNameKey: userName,
        userProfileImageURLKey: userProfileImageURL,
        lastMessageKey: lastMessage,
        lastMessageSenderKey: lastMessageSender,
      };
}
