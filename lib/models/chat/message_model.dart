import '/library.dart';

class MessageModel {
  static const String senderIdKey = 'senderId';
  static const String messageKey = 'message';
  static const String timestampKey = 'timestamp';
  static const String messageUrlKey = 'messageUrl';
  static const String typeKey = 'type';

  final String senderId;
  final String message;
  final String? messageUrl;
  final Timestamp timestamp;
  final MessageType type;

  MessageModel({
    required this.senderId,
    required this.message,
    required this.timestamp,
    this.messageUrl,
    this.type = MessageType.text,
  }) : assert(message != SimpleConstants.emptyString);

  factory MessageModel.fromMap(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final map = snapshot.data()!;
    return MessageModel(
      senderId: map[senderIdKey],
      message: map[messageKey],
      timestamp: map[timestampKey],
      messageUrl: map[messageUrlKey],
      type: MessageType.values.firstWhere(
        (element) => element.name == map[typeKey],
      ),
    );
  }

  Map<String, dynamic> toMap() => {
        senderIdKey: senderId,
        messageKey: message,
        timestampKey: timestamp,
        messageUrlKey: messageUrl,
        typeKey: type.name,
      };
}
