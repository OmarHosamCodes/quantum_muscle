import 'package:quantum_muscle/library.dart';

/// Represents a message in a chat.
class MessageModel {
  /// Creates a new instance of [MessageModel].
  MessageModel({
    required this.id,
    required this.senderId,
    required this.message,
    required this.timestamp,
    this.messageUrl,
    this.type = MessageType.text,
    this.programRequestId,
  });

  /// Creates a new instance of [MessageModel] from a map.
  ///
  /// The [map] should contain the necessary key-value pairs to populate
  /// the message properties.
  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map[idKey] as String,
      senderId: map[senderIdKey] as String,
      message: map[messageKey] as String,
      timestamp: map[timestampKey] as Timestamp,
      messageUrl: map[messageUrlKey] as String?,
      type: MessageType.values
          .firstWhere((element) => element.name == map[typeKey]),
      programRequestId: map[programRequestIdKey] as String?,
    );
  }

  /// The unique identifier of the message.
  final String id;

  /// The identifier of the sender of the message.
  final String senderId;

  /// The content of the message.
  final String message;

  /// The timestamp when the message was sent.
  final Timestamp timestamp;

  /// The URL associated with the message, if any.
  final String? messageUrl;

  /// The type of the message.
  final MessageType type;

  /// The identifier of the program request associated with the message, if any.
  final String? programRequestId;

  /// The key for the 'id' property in the map representation of the message.
  static const String idKey = 'id';

  /// The key for the 'senderId' property in the map
  ///  representation of the message.
  static const String senderIdKey = 'senderId';

  /// The key for the 'message' property in the map
  /// representation of the message.
  static const String messageKey = 'message';

  /// The key for the 'timestamp' property in the map
  /// representation of the message.
  static const String timestampKey = 'timestamp';

  /// The key for the 'messageUrl' property in the map
  /// representation of the message.
  static const String messageUrlKey = 'messageUrl';

  /// The key for the 'type' property in the map representation of the message.
  static const String typeKey = 'type';

  /// The key for the 'programRequestId' property in the map
  /// representation of the message.
  static const String programRequestIdKey = 'programRequestId';

  /// Converts the message to a map representation.
  Map<String, dynamic> toMap() {
    return {
      idKey: id,
      senderIdKey: senderId,
      messageKey: message,
      timestampKey: timestamp,
      messageUrlKey: messageUrl,
      typeKey: type.name,
      programRequestIdKey: programRequestId,
    };
  }
}
