import 'package:quantum_muscle/library.dart';

class MessageModel {
  MessageModel({
    required this.id,
    required this.senderId,
    required this.message,
    required this.timestamp,
    this.messageUrl,
    this.type = MessageType.text,
    this.programRequestId,
  }) : assert(
          message != SimpleConstants.emptyString,
          'Message should not be empty',
        );

  factory MessageModel.fromMap(
    Map<String, dynamic> map,
  ) =>
      MessageModel(
        id: map[idKey] as String,
        senderId: map[senderIdKey] as String,
        message: map[messageKey] as String,
        timestamp: map[timestampKey] as Timestamp,
        messageUrl: map[messageUrlKey] as String?,
        type: MessageType.values.firstWhere(
          (element) => element.name == map[typeKey],
        ),
        programRequestId: map[programRequestIdKey] as String?,
      );
  static const String idKey = 'id';
  static const String senderIdKey = 'senderId';
  static const String messageKey = 'message';
  static const String timestampKey = 'timestamp';
  static const String messageUrlKey = 'messageUrl';
  static const String typeKey = 'type';
  static const String programRequestIdKey = 'programRequestId';

  String id;
  String senderId;
  String message;
  String? messageUrl;
  Timestamp timestamp;
  MessageType type;
  String? programRequestId;

  Map<String, dynamic> toMap() => {
        idKey: id,
        senderIdKey: senderId,
        messageKey: message,
        timestampKey: timestamp,
        messageUrlKey: messageUrl,
        typeKey: type.name,
        programRequestIdKey: programRequestId,
      };
}
