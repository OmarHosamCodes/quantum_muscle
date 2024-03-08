import 'package:quantum_muscle/library.dart';

/// A widget that represents a message bubble in a chat.
class MessageBubble extends StatelessWidget {
  /// Constructs a [MessageBubble] widget.
  ///
  /// The [message] parameter is the message model for the bubble.
  /// The [chatUserId] parameter is the ID of the user in the chat.
  /// The [messageId] parameter is the ID of the message.
  /// The [chatId] parameter is the ID of the chat.
  const MessageBubble({
    required this.message,
    required this.chatUserId,
    required this.messageId,
    required this.chatId,
    super.key,
  });

  /// The message model for the bubble.
  final MessageModel message;

  /// The ID of the user in the chat.
  final String chatUserId;

  /// The ID of the message.
  final String messageId;

  /// The ID of the chat.
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
