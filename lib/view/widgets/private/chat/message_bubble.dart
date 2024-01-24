import '/library.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.message,
    required this.chatUserId,
    required this.messageId,
    required this.chatId,
  });

  final MessageModel message;
  final String chatUserId;
  final String messageId;
  final String chatId;

  @override
  Widget build(BuildContext context) {
    bool isMe = message.senderId == Utils().userUid;
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
        return Center(
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: ColorConstants.disabledColor,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(10),
            child: QmText(
              text: message.message,
              color: ColorConstants.textColor,
              isSeccoundary: true,
            ),
          ),
        );
      case MessageTypeConstants.text:
        return Padding(
          padding: messagePadding(message.senderId),
          child: Column(
            crossAxisAlignment: messageAlignment(message.senderId),
            children: [
              Container(
                decoration: BoxDecoration(
                  color: messageColor(message.senderId),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(10),
                child: QmText(
                  text: message.message,
                  color: ColorConstants.textColor,
                ),
              ),
              const SizedBox(height: 2),
              QmText(
                text: Utils().timeAgo(
                  message.timestamp,
                ),
                isSeccoundary: true,
              ),
            ],
          ),
        );
      case MessageTypeConstants.image:
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: messageAlignment(message.senderId),
            children: [
              Container(
                decoration: BoxDecoration(
                  color: messageColor(message.senderId),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(message.messageUrl!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    QmText(
                      text: message.message,
                      color: ColorConstants.textColor,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 2),
              QmText(
                text: Utils().timeAgo(
                  message.timestamp,
                ),
                isSeccoundary: true,
              ),
              const SizedBox(height: 2),
              GestureDetector(
                onTap: () {
                  //   context.go(
                  //   Routes.imagePreviewR,
                  //   arguments: {
                  //     MessageModel.messageUrlKey: messageUrl,
                  //   },
                  // );
                },
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(message.messageUrl!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      case MessageTypeConstants.request:
        return Padding(
          padding: messagePadding(message.senderId),
          child: Column(
            crossAxisAlignment: messageAlignment(message.senderId),
            children: [
              Container(
                decoration: BoxDecoration(
                  color: messageColor(message.senderId),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(10),
                child: FittedBox(
                  child: Column(
                    children: [
                      QmText(
                        text: message.message,
                        color: ColorConstants.textColor,
                      ),
                      Visibility(
                        visible: !isMe,
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorConstants.primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Consumer(builder: (context, ref, _) {
                                return QmIconButton(
                                  icon: EvaIcons.checkmark,
                                  iconColor: ColorConstants.iconColor,
                                  onPressed: () => ProgramsUtil().acceptRequest(
                                    context: context,
                                    chatId: chatId,
                                    ref: ref,
                                    programId: message.programRequestId!,
                                    messageId: messageId,
                                  ),
                                );
                              }),
                              QmIconButton(
                                icon: EvaIcons.close,
                                iconColor: ColorConstants.iconColor,
                                onPressed: () => ChatUtil().removeMessage(
                                  context: context,
                                  chatId: chatId,
                                  messageId: messageId,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 2),
              QmText(
                text: Utils().timeAgo(
                  message.timestamp,
                ),
                isSeccoundary: true,
              ),
            ],
          ),
        );
      default:
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: messageAlignment(message.senderId),
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: messageColor(message.senderId),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(10),
                child: QmText(
                  text: message.message,
                  color: ColorConstants.textColor,
                ),
              ),
              const SizedBox(width: 10),
              QmText(
                text: Utils().timeAgo(
                  message.timestamp,
                ),
              ),
            ],
          ),
        );
    }
  }
}
