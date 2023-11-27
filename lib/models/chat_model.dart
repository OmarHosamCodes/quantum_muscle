import '../library.dart';

class ChatModel {
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
      userImage: map['userImage'],
      sender: map['sender'],
      message: map['message'],
      timestamp: map['timestamp'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'userImage': userImage,
      'sender': sender,
      'message': message,
      'timestamp': timestamp,
    };
  }
}
