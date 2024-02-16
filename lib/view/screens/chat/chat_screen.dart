// ignore_for_file: avoid_dynamic_calls

import 'package:quantum_muscle/library.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({
    required this.chatId,
    required this.chatUserId,
    super.key,
    this.arguments = const <String, dynamic>{},
  });

  final String chatId;
  final String chatUserId;
  final Map<String, dynamic> arguments;
  static final messageTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final chat = arguments[ChatModel.modelKey] as ChatModel;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      resizeToAvoidBottomInset: true,
      body: Column(
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
                QmText(text: chat.userName),
              ],
            ),
          ),
          Consumer(
            builder: (context, ref, child) {
              return SizedBox(
                height: height * 0.8,
                child: StreamBuilder<QuerySnapshot<Object?>>(
                  stream: utils.firebaseFirestore
                      .collection(DBPathsConstants.chatsPath)
                      .doc(chatId)
                      .collection(DBPathsConstants.messagesPath)
                      .orderBy(MessageModel.timestampKey, descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: QmLoader.indicator(),
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
                  child: Consumer(
                    builder: (_, WidgetRef ref, __) {
                      return QmTextField(
                        textInputAction: TextInputAction.go,
                        controller: messageTextController,
                        hintText: S.current.TypeMessage,
                        onEditingComplete: () {
                          if (messageTextController.text.isNotEmpty) {
                            chatUtil.addTextMessage(
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
                ),
                Consumer(
                  builder: (_, ref, __) {
                    return QmIconButton(
                      icon: EvaIcons.paperPlane,
                      onPressed: () {
                        if (messageTextController.text.isNotEmpty) {
                          chatUtil.addTextMessage(
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
    );
  }
}
