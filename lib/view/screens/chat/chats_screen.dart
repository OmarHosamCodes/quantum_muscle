import 'package:quantum_muscle/library.dart';

/// Chats screen
class ChatsScreen extends ConsumerWidget {
  /// const constructor for the [ChatsScreen]
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatsWatcher = ref.watch(chatsProvider);
    ref.watch(localeProvider);
    return Scaffold(
      body: chatsWatcher.when(
        data: (chats) {
          if (chats.isEmpty) {
            return Center(
              child: QmText(text: S.current.NoChat),
            );
          }
          return ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {
              final chat = chats[index];
              Color lastMessageColor(String lastMessageSender) {
                if (lastMessageSender == utils.userUid) {
                  return ColorConstants.textSecondaryColor;
                } else {
                  return ColorConstants.textColor;
                }
              }

              return ListTile(
                leading: QmAvatar(
                  imageUrl: chat.userProfileImageURL,
                ),
                title: QmText.simple(
                  text: chat.userName,
                  isHeadline: true,
                ),
                subtitle: QmText.simple(
                  text: chat.lastMessage!,
                  color: lastMessageColor(chat.lastMessageSender!),
                ),
                trailing: QmText.simple(
                  text: utils.timeAgo(
                    chat.messages.first.timestamp,
                  ),
                  isSeccoundary: true,
                ),
                onTap: () => context.pushNamed(
                  Routes.chatRootR,
                  pathParameters: {
                    ChatModel.idKey: chat.id,
                    ChatModel.userIdKey: chat.userId,
                  },
                  extra: {
                    ChatModel.modelKey: chat,
                  },
                ),
              );
            },
          );
        },
        loading: () => SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < 5; i++)
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      QmShimmer.round(size: 25),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          QmShimmer.rectangle(
                            width: 100,
                            height: 20,
                          ),
                          SizedBox(height: 10),
                          QmShimmer.rectangle(
                            width: 200,
                            height: 25,
                          ),
                        ],
                      ),
                      Spacer(),
                      QmShimmer.rectangle(
                        width: 50,
                        height: 10,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        error: (e, s) => Center(
          child: QmText(text: S.current.NoChat),
        ),
      ),
    );
  }
}
