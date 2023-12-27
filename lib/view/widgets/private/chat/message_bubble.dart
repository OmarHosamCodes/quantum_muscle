import '/library.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.messageSender,
    required this.messageText,
    required this.messageTimestamp,
    required this.chatUserId,
    this.messageUrl,
    required this.messageType,
  });

  final String messageSender;
  final String messageText;
  final Timestamp messageTimestamp;
  final String? messageUrl;
  final String messageType;
  final String chatUserId;

  @override
  Widget build(BuildContext context) {
    CrossAxisAlignment messageAlignment(String messageSender) {
      if (messageSender == Utils().userUid) {
        return CrossAxisAlignment.end;
      } else if (messageSender == chatUserId) {
        return CrossAxisAlignment.start;
      }
      return CrossAxisAlignment.center;
    }

    switch (messageType) {
      case MessageTypeConstants.server:
        return Center(
          child: Container(
            decoration: BoxDecoration(
              color: ColorConstants.disabledColor,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(10),
            child: QmText(
              text: messageText,
              color: ColorConstants.textColor,
              isSeccoundary: true,
            ),
          ),
        );
      case MessageTypeConstants.text:
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: messageAlignment(messageSender),
            children: [
              Container(
                decoration: BoxDecoration(
                  color: messageSender == Utils().userUid
                      ? ColorConstants.userChatBubbleColor
                      : ColorConstants.otherChatBubbleColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(10),
                child: QmText(
                  text: messageText,
                  color: ColorConstants.textColor,
                ),
              ),
              const SizedBox(height: 5),
              QmText(
                text: Utils().timeAgo(
                  messageTimestamp,
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
            crossAxisAlignment: messageAlignment(messageSender),
            children: [
              Container(
                decoration: BoxDecoration(
                  color: messageSender == Utils().userUid
                      ? ColorConstants.userChatBubbleColor
                      : ColorConstants.otherChatBubbleColor,
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
                          image: NetworkImage(messageUrl!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    QmText(
                      text: messageText,
                      color: ColorConstants.textColor,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              QmText(
                text: Utils().timeAgo(
                  messageTimestamp,
                ),
                isSeccoundary: true,
              ),
              const SizedBox(height: 5),
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
                      image: NetworkImage(messageUrl!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: messageAlignment(messageSender),
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: messageSender == Utils().userUid
                  ? ColorConstants.primaryColor
                  : ColorConstants.accentColor,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(10),
            child: QmText(
              text: messageText,
              color: ColorConstants.textColor,
            ),
          ),
          const SizedBox(width: 10),
          QmText(
            text: Utils().timeAgo(
              messageTimestamp,
            ),
          ),
        ],
      ),
    );
  }
}
