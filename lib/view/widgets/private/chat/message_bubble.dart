import 'package:quantum_muscle/library.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    required this.message,
    required this.chatUserId,
    required this.messageId,
    required this.chatId,
    super.key,
  });

  final MessageModel message;
  final String chatUserId;
  final String messageId;
  final String chatId;

  @override
  Widget build(BuildContext context) {
    final isMe = message.senderId == utils.userUid;
    CrossAxisAlignment messageAlignment(String messagesenderId) {
      if (isMe) {
        return CrossAxisAlignment.end;
      } else {
        return CrossAxisAlignment.start;
      }
    }

    Color messageColor(String senderId) {
      if (isMe) {
        return ColorConstants.userChatBubbleColor;
      } else {
        return ColorConstants.otherChatBubbleColor;
      }
    }

    EdgeInsets messagePadding(String senderId) {
      if (isMe) {
        return const EdgeInsets.only(
          left: 80,
          right: 10,
        );
      } else {
        return const EdgeInsets.only(
          left: 10,
          right: 80,
        );
      }
    }

    switch (message.type.name) {
      case MessageTypeConstants.server:
        return Bubbles.server(message: message);
      case MessageTypeConstants.text:
        return Bubbles.text(
          message: message,
          padding: messagePadding(message.senderId),
          crossAxisAlignment: messageAlignment(message.senderId),
          color: messageColor(message.senderId),
        );

      case MessageTypeConstants.request:
        return Bubbles.request(
          message: message,
          padding: messagePadding(message.senderId),
          crossAxisAlignment: messageAlignment(message.senderId),
          color: messageColor(message.senderId),
          chatId: chatId,
          messageId: messageId,
          context: context,
          isMe: isMe,
        );
      default:
        return Bubbles.text(
          message: message,
          padding: messagePadding(message.senderId),
          crossAxisAlignment: messageAlignment(message.senderId),
          color: messageColor(message.senderId),
        );
    }
  }
}
