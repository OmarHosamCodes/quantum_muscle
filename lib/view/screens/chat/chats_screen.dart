import '/library.dart';

class ChatsScreen extends ConsumerWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatsWatcher = ref.watch(chatsProvider);
    return Scaffold(
      body: chatsWatcher.when(
        data: (chats) {
          return ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {
              var chat = chats[index];
              Color lastMessageColor(String lastMessageSender) {
                if (lastMessageSender == Utils().userUid) {
                  return ColorConstants.textSeccondaryColor;
                } else {
                  return ColorConstants.textColor;
                }
              }

              return ListTile(
                leading: QmAvatar(
                  imageUrl: chat.chatUserImage,
                ),
                title: QmText(
                  text: chat.chatUserName,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: QmText(
                  text: chat.lastMessage!,
                  color: lastMessageColor(chat.lastMessageSender!),
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: QmText(
                  text: Utils().timeAgo(
                    chat.messages.first.timestamp,
                  ),
                  isSeccoundary: true,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () => context.pushNamed(
                  Routes.chatRootR,
                  pathParameters: {
                    ChatModel.chatIdKey: chat.chatId,
                    ChatModel.chatUserIdKey: chat.chatUserId,
                  },
                  extra: {
                    ChatModel.modelKey: chat,
                  },
                ),
              );
            },
          );
        },
        loading: () => const Center(
          child: QmCircularProgressIndicator(),
        ),
        error: (e, s) => Center(
          child: QmText(text: S.current.NoChat),
        ),
      ),
    );
  }
}
