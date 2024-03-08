// ignore_for_file: avoid_dynamic_calls

import 'package:quantum_muscle/library.dart';

/// A screen widget for displaying a chat.
class ChatScreen extends StatelessWidget {
  /// Constructs a [ChatScreen] widget.
  ///
  /// The [chatId] parameter is required and represents the ID of the chat.
  ///
  /// The [chatUserId] parameter is required and represents the ID of the
  /// user in the chat.
  ///
  /// The [arguments] parameter is an optional map of additional arguments.
  ///
  /// The [key] parameter is an optional key to use for this widget.
  const ChatScreen({
    required this.chatId,
    required this.chatUserId,
    super.key,
    this.arguments = const <String, dynamic>{},
  });

  /// The ID of the chat.
  final String chatId;

  /// The ID of the user in the chat.
  final String chatUserId;

  /// Additional arguments for the chat screen.
  final Map<String, dynamic> arguments;

  /// A controller for the message text input field.
  static final messageTextController = TextEditingController();

  /// Indicates whether the chat screen is loaded.
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
