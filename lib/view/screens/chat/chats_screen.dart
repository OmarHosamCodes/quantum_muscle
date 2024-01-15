import '/library.dart';

class ChatsScreen extends ConsumerWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userFuture = ref.watch(userProvider(Utils().userUid!));

    return Scaffold(
        body: userFuture.whenOrNull(
      data: (model) {
        if (model.chats.isEmpty) {
          return Center(
            child: QmText(text: S.current.DefaultError),
          );
        }

        return ListView.builder(
          itemCount: model.chats.length,
          itemBuilder: (context, index) {
            final chatsElements =
                model.chats[index] as Map<String, dynamic>? ?? {};
            final chatDocId = chatsElements.keys.elementAt(index);
            final chatUserId = chatsElements.values.elementAt(index);
            return FutureBuilder(
              future: ref.watch(chatProvider(chatDocId).future),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: QmCircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: QmText(text: S.current.DefaultError),
                  );
                } else if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: QmText(text: S.current.NoChat),
                  );
                }

                final messages = snapshot.data!.docs
                    .map((e) => e.data()! as Map<String, dynamic>);
                final String lastMessage =
                    messages.last[MessageModel.messageKey] ??
                        SimpleConstants.emptyString;
                final String lastMessageSender =
                    messages.last[MessageModel.senderIdKey] ??
                        SimpleConstants.emptyString;
                Color lastMessageColor(String lastMessageSender) {
                  if (lastMessageSender == Utils().userUid) {
                    return ColorConstants.textSeccondaryColor;
                  } else {
                    return ColorConstants.textColor;
                  }
                }

                final lastMessageTimestamp =
                    messages.last[MessageModel.timestampKey];
                return FutureBuilder(
                  future: ref.watch(userProvider(chatUserId).future),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: QmCircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: QmText(text: S.current.DefaultError),
                      );
                    } else if (!snapshot.hasData) {
                      return Center(
                        child: QmText(text: S.current.NoChat),
                      );
                    }
                    final userData = snapshot.data!;
                    return ListTile(
                      leading: QmAvatar(
                        imageUrl: userData.profileImage,
                      ),
                      title: QmText(
                        text: userData.name,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: QmText(
                        text: lastMessage,
                        color: lastMessageColor(lastMessageSender),
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: QmText(
                        text: Utils().timeAgo(
                          lastMessageTimestamp,
                        ),
                        isSeccoundary: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () => context.pushNamed(
                        Routes.chatRootR,
                        pathParameters: {
                          'chatId': chatDocId,
                          'chatUserId': chatUserId,
                        },
                        extra: {
                          UserModel.nameKey: userData.name,
                          UserModel.profileImageKey: userData.profileImage,
                        },
                      ),
                    );
                  },
                );
              },
            );
          },
        );
      },
      loading: () => const Center(
        child: QmCircularProgressIndicator(),
      ),
      error: (e, s) => Center(
        child: QmText(text: S.current.DefaultError),
      ),
    ));
  }
}
