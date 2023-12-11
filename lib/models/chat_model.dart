import '/library.dart';

class ChatModel {
  static const String userImageKey = 'userImage';
  static const String senderKey = 'sender';
  static const String messageKey = 'message';
  static const String timestampKey = 'timestamp';

  final String userImage;
  final String sender;
  final String message;
  final DateTime timestamp;

  ChatModel({
    required this.userImage,
    required this.sender,
    required this.message,
    required this.timestamp,
  });
  factory ChatModel.fromMap(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final map = snapshot.data()!;
    return ChatModel(
      userImage: map[userImageKey],
      sender: map[senderKey],
      message: map[messageKey],
      timestamp: map[timestampKey].toDate(),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      userImageKey: userImage,
      senderKey: sender,
      messageKey: message,
      timestampKey: timestamp,
    };
  }
}
