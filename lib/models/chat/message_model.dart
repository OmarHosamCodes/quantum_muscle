import '/library.dart';

class MessageModel {
  static const String senderIdKey = 'senderId';
  static const String messageKey = 'message';
  static const String timestampKey = 'timestamp';
  static const String messageUrlKey = 'messageUrl';
  static const String typeKey = 'type';
  static const String programRequestIdKey = 'programRequestId';

  String senderId;
  String message;
  String? messageUrl;
  Timestamp timestamp;
  MessageType type;
  String? programRequestId;

  MessageModel({
    required this.senderId,
    required this.message,
    required this.timestamp,
    this.messageUrl,
    this.type = MessageType.text,
    this.programRequestId,
  }) : assert(message != SimpleConstants.emptyString);

  factory MessageModel.fromMap(
    Map<String, dynamic> map,
  ) =>
      MessageModel(
        senderId: map[senderIdKey],
        message: map[messageKey],
        timestamp: map[timestampKey],
        messageUrl: map[messageUrlKey],
        type: MessageType.values.firstWhere(
          (element) => element.name == map[typeKey],
        ),
        programRequestId: map[programRequestIdKey],
      );

  Map<String, dynamic> toMap() => {
        senderIdKey: senderId,
        messageKey: message,
        timestampKey: timestamp,
        messageUrlKey: messageUrl,
        typeKey: type.name,
        programRequestIdKey: programRequestId,
      };
}
