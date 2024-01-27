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
    final chat = arguments[ChatModel.modelKey] as ChatModel;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final messageTextController = TextEditingController();

    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: SafeArea(
        minimum: const EdgeInsets.all(10),
        maintainBottomViewPadding: true,
        child: Column(
          children: [
            SizedBox(
              height: height * 0.06,
              child: Row(
                children: [
                  QmIconButton(
                    icon: EvaIcons.arrowBack,
                    onPressed: () => context.pop(),
                  ),
                  const SizedBox(width: 10),
                  QmAvatar(imageUrl: chat.userProfileImageURL),
                  const SizedBox(width: 10),
                  QmText(text: chat.userName)
                ],
              ),
            ),
            Consumer(
              builder: (context, ref, child) {
                return SizedBox(
                  height: height * 0.8,
                  child: StreamBuilder<QuerySnapshot<Object?>>(
                    stream: Utils()
                        .firebaseFirestore
                        .collection(DBPathsConstants.chatsPath)
                        .doc(chatId)
                        .collection(DBPathsConstants.messagesPath)
                        .orderBy(MessageModel.timestampKey, descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: QmCircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: QmText(text: S.current.DefaultError),
                        );
                      }
                      final messages = snapshot.data!.docs;
                      return ListView.builder(
                        padding: const EdgeInsets.all(10),
                        reverse: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final messageData =
                              messages[index].data()! as Map<String, dynamic>;
                          final message = MessageModel.fromMap(messageData);

                          return MessageBubble(
                            message: message,
                            chatUserId: chatUserId,
                            chatId: chatId,
                            messageId: messages[index].id,
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
                      fieldColor: ColorConstants.secondaryColor,
                      height: height * 0.09,
                      width: width * .6,
                      controller: messageTextController,
                      hintText: S.current.TypeMessage,
                    ),
                  ),
                  Consumer(
                    builder: (_, ref, __) {
                      return QmIconButton(
                        icon: EvaIcons.paperPlane,
                        onPressed: () {
                          if (messageTextController.text.isNotEmpty) {
                            ChatUtil().addTextMessage(
                              chatId: chatId,
                              message: messageTextController.text,
                              ref: ref,
                            );
                            messageTextController.clear();
                          }
                        },
                      );
                    },
                  ),
                  // QmIconButton(
                  //   icon: EvaIcons.link2,
                  //   onPressed: () {},
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
