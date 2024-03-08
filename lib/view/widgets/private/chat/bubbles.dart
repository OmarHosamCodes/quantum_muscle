import 'package:quantum_muscle/library.dart';

/// A widget that represents chat bubbles for different types of messages.
class Bubbles extends StatelessWidget {
  /// Creates a text bubble.
  const Bubbles.text({
    required this.message,
    required this.padding,
    required this.crossAxisAlignment,
    required this.color,
    super.key,
  })  : chatId = null,
        messageId = null,
        context = null,
        isMe = null,
        messageType = MessageType.text;

  /// Creates a server bubble.
  const Bubbles.server({
    required this.message,
    super.key,
  })  : padding = null,
        crossAxisAlignment = null,
        color = null,
        chatId = null,
        messageId = null,
        context = null,
        isMe = null,
        messageType = MessageType.server;

  /// Creates a request bubble.
  const Bubbles.request({
    required this.message,
    required this.padding,
    required this.crossAxisAlignment,
    required this.color,
    required this.chatId,
    required this.messageId,
    required this.context,
    required this.isMe,
    super.key,
  }) : messageType = MessageType.request;

  /// The message to be displayed in the chat bubble.
  final MessageModel message;

  /// The padding around the chat bubble.
  final EdgeInsets? padding;

  /// The alignment of the chat bubble within its parent.
  final CrossAxisAlignment? crossAxisAlignment;

  /// The background color of the chat bubble.
  final Color? color;

  /// The ID of the chat that the message belongs to.
  final String? chatId;

  /// The ID of the message.
  final String? messageId;

  /// The build context.
  final BuildContext? context;

  /// Indicates whether the message is sent by the current user.
  final bool? isMe;

  /// The type of the message.
  final MessageType messageType;

  @override
  Widget build(BuildContext context) {
    return switch (messageType) {
      MessageType.text => buildText(),
      MessageType.server => buildServer(),
      MessageType.request => buildRequest(),
      _ => buildText(),
    };
  }

  /// Builds a text bubble.
  Widget buildText() {
    return Padding(
      padding: padding!,
      child: Column(
        crossAxisAlignment: crossAxisAlignment!,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: SimpleConstants.borderRadius,
            ),
            padding: const EdgeInsets.all(10),
            child: QmText.simple(
              text: message.message,
              color: ColorConstants.textColor,
            ),
          ),
          const SizedBox(height: 2),
          QmText.simple(
            text: utils.timeAgo(
              message.timestamp,
            ),
            style: const TextStyle(
              color: ColorConstants.textColor,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a server bubble.
  Widget buildServer() {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: ColorConstants.disabledColor,
          borderRadius: SimpleConstants.borderRadius,
        ),
        padding: const EdgeInsets.all(10),
        child: QmText.simple(
          text: message.message,
          color: ColorConstants.textColor,
          isSeccoundary: true,
        ),
      ),
    );
  }

  /// Builds a request bubble.
  Widget buildRequest() {
    return Padding(
      padding: padding!,
      child: Column(
        crossAxisAlignment: crossAxisAlignment!,
        children: [
          Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: SimpleConstants.borderRadius,
            ),
            padding: const EdgeInsets.all(10),
            child: FittedBox(
              child: Column(
                children: [
                  QmText.simple(
                    text: message.message,
                    color: ColorConstants.textColor,
                  ),
                  Visibility(
                    visible: !isMe!,
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorConstants.primaryColor,
                        borderRadius: SimpleConstants.borderRadius,
                      ),
                      child: Row(
                        children: [
                          Consumer(
                            builder: (_, ref, __) {
                              return QmButton.icon(
                                icon: EvaIcons.checkmark,
                                onPressed: () => programUtil.acceptRequest(
                                  context: context!,
                                  chatId: chatId!,
                                  // ref: ref,
                                  programId: message.programRequestId!,
                                  messageId: messageId!,
                                ),
                              );
                            },
                          ),
                          QmButton.icon(
                            icon: EvaIcons.close,
                            onPressed: () => chatUtil.removeMessage(
                              context: context!,
                              chatId: chatId!,
                              messageId: messageId!,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 2),
          QmText.simple(
            text: utils.timeAgo(
              message.timestamp,
            ),
            isSeccoundary: true,
          ),
        ],
      ),
    );
  }
}
