import 'package:quantum_muscle/library.dart';

class MessageModel {
  static const String senderIdKey = 'senderId';
  static const String messageKey = 'message';
  static const String timestampKey = 'timestamp';

  final String senderId;
  final String message;
  final Timestamp timestamp;

  MessageModel({
    required this.senderId,
    required this.message,
    required this.timestamp,
  });

  MessageModel.fromJson(Map<String, dynamic> json)
      : senderId = json[senderIdKey],
        message = json[messageKey],
        timestamp = json[timestampKey];

  Map<String, dynamic> toJson() => {
        senderIdKey: senderId,
        messageKey: message,
        timestampKey: timestamp,
      };
}
