import 'package:quantum_muscle/library.dart';

/// Represents a chat model.
class ChatModel {
  /// Creates a new instance of [ChatModel].
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

  /// Creates a new instance of [ChatModel] from a map.
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

  /// The unique identifier of the chat.
  final String id;

  /// The list of messages in the chat.
  final List<MessageModel> messages;

  /// The document identifier of the chat.
  final String docId;

  /// The user ID associated with the chat.
  final String userId;

  /// The username associated with the chat.
  final String userName;

  /// The URL of the user's profile image.
  final String userProfileImageURL;

  /// The last message in the chat.
  final String? lastMessage;

  /// The sender of the last message in the chat.
  final String? lastMessageSender;

  /// The key for the 'id' field in the map representation.
  static const String idKey = 'id';

  /// The key for the 'messages' field in the map representation.
  static const String messagesKey = 'messages';

  /// The key for the 'docId' field in the map representation.
  static const String docIdKey = 'docId';

  /// The key for the 'userId' field in the map representation.
  static const String userIdKey = 'userId';

  /// The key for the 'userName' field in the map representation.
  static const String userNameKey = 'userName';

  /// The key for the 'userProfileImageURL' field in the map representation.
  static const String userProfileImageURLKey = 'userProfileImageURL';

  /// The key for the 'lastMessage' field in the map representation.
  static const String lastMessageKey = 'lastMessage';

  /// The key for the 'lastMessageSender' field in the map representation.
  static const String lastMessageSenderKey = 'lastMessageSender';

  /// The key for the 'chatModel' field in the map representation.
  static const String modelKey = 'chatModel';

  /// Converts the [ChatModel] instance to a map.
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
