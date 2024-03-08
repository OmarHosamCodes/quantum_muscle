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

  static bool isLoaded = false;

  @override
  Widget build(BuildContext context) {
    final chat = arguments[ChatModel.modelKey] as ChatModel;

    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: AppBar(
        title: Row(
          children: [
            QmAvatar(imageUrl: chat.userProfileImageURL),
            const SizedBox(width: 10),
            QmText(text: chat.userName),
          ],
        ),
        centerTitle: false,
      ),
      bottomSheet: QmBlock(
        color: ColorConstants.backgroundColor,
        height: 60,
        borderRadius: BorderRadius.zero,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
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
              FittedBox(
                child: Consumer(
                  builder: (_, ref, __) {
                    return QmButton.icon(
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
              ),
            ],
          ),
        ),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          return StreamBuilder<QuerySnapshot<Map<String, dynamic>?>?>(
            stream: utils.firebaseFirestore
                .collection(DBPathsConstants.chatsPath)
                .doc(chatId)
                .collection(DBPathsConstants.messagesPath)
                .orderBy(MessageModel.timestampKey, descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: QmText.simple(text: S.current.DefaultError),
                );
              }
              if (!snapshot.hasData && isLoaded == false) {
                isLoaded = true;
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final messages = snapshot.data!.docs;
              return ListView.builder(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 10,
                  bottom: 60,
                ),
                reverse: true,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final messageData = messages[index].data();
                  final message = MessageModel.fromMap(messageData ?? {});

                  return MessageBubble(
                    message: message,
                    chatUserId: chatUserId,
                    chatId: chatId,
                    messageId: messages[index].id,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
