import '/library.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({
    super.key,
    required this.chatId,
    required this.chatUserId,
    this.arguments,
  });

  final String chatId;
  final String chatUserId;
  final dynamic arguments;
  @override
  Widget build(BuildContext context) {
    final userProfileImage = arguments[UserModel.profileImageKey] as String?;
    final userName = arguments[UserModel.nameKey] as String;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final messageTextController = TextEditingController();

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: height * 0.08,
            child: Row(
              children: [
                QmIconButton(
                  icon: EvaIcons.arrowBack,
                  onPressed: () => context.pop(),
                ),
                const SizedBox(width: 10),
                QmAvatar(imageUrl: userProfileImage),
                const SizedBox(width: 10),
                QmText(text: userName)
              ],
            ),
          ),
          Consumer(
            builder: (context, ref, child) {
              return SizedBox(
                height: height * 0.7,
                child: StreamBuilder<QuerySnapshot<Object?>>(
                  stream: Utils()
                      .firebaseFirestore
                      .collection(DBPathsConstants.chatsPath)
                      .doc(chatId)
                      .collection(DBPathsConstants.chatsMessagesPath)
                      .orderBy(MessageModel.timestampKey, descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                    } else if (snapshot.hasError) {
                      return Center(
                        child: QmText(text: S.current.DefaultError),
                      );
                    }
                    final messages = snapshot.data!.docs;
                    return ListView.builder(
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final messageData =
                            messages[index].data()! as Map<String, dynamic>;
                        final messageText =
                            messageData[MessageModel.messageKey] as String;
                        final messageSender =
                            messageData[MessageModel.senderIdKey] as String;
                        final messageTimestamp =
                            messageData[MessageModel.timestampKey] as Timestamp;
                        final messageUrl =
                            messageData[MessageModel.messageUrlKey]
                                    as String? ??
                                SimpleConstants.emptyString;
                        final messageType =
                            messageData[MessageModel.typeKey] as String;

                        return MessageBubble(
                          messageSender: messageSender,
                          messageText: messageText,
                          messageTimestamp: messageTimestamp,
                          messageUrl: messageUrl,
                          messageType: messageType,
                          chatUserId: chatUserId,
                        );
                      },
                    );
                  },
                ),
              );
            },
          ),
          SizedBox(
            height: height * 0.09,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: width * 0.6,
                  child: QmTextField(
                    fieldColor: ColorConstants.accentColor,
                    height: height * 0.09,
                    width: width * .6,
                    controller: messageTextController,
                    hintText: S.current.TypeMessage,
                  ),
                ),
                QmIconButton(
                  icon: EvaIcons.paperPlane,
                  onPressed: () {
                    if (messageTextController.text.isNotEmpty) {
                      ChatUtil().addTextMessage(
                        chatId: chatId,
                        message: messageTextController.text,
                      );
                      messageTextController.clear();
                    }
                  },
                ),
                QmIconButton(
                  icon: EvaIcons.link2,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
