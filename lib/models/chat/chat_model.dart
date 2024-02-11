import 'package:quantum_muscle/library.dart';

class ChatModel {
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
        id: map[idKey] as String,
        messages: map[messagesKey] as List<MessageModel>,
        docId: map[docIdKey] as String,
        userId: map[userIdKey] as String,
        userName: map[userNameKey] as String,
        userProfileImageURL: map[userProfileImageURLKey] as String,
        lastMessage: map[lastMessageKey] as String?,
        lastMessageSender: map[lastMessageSenderKey] as String?,
      );
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
