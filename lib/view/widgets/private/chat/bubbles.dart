import 'package:quantum_muscle/library.dart';

class Bubbles {
  static Widget text({
    required MessageModel message,
    required EdgeInsets padding,
    required CrossAxisAlignment crossAxisAlignment,
    required Color color,
  }) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
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

  static Widget server({
    required MessageModel message,
  }) {
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

  static Widget request({
    required MessageModel message,
    required EdgeInsets padding,
    required CrossAxisAlignment crossAxisAlignment,
    required Color color,
    required String chatId,
    required String messageId,
    required BuildContext context,
    required bool isMe,
  }) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
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
                    visible: !isMe,
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
                                  context: context,
                                  chatId: chatId,
                                  // ref: ref,
                                  programId: message.programRequestId!,
                                  messageId: messageId,
                                ),
                              );
                            },
                          ),
                          QmButton.icon(
                            icon: EvaIcons.close,
                            onPressed: () => chatUtil.removeMessage(
                              context: context,
                              chatId: chatId,
                              messageId: messageId,
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
