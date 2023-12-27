import '/library.dart';

final chatFutureProvider = FutureProvider.family<QuerySnapshot?, String>(
  (ref, chatId) {
    return Utils()
        .firebaseFirestore
        .collection(DBPathsConstants.chatsPath)
        .doc(chatId)
        .collection(ChatModel.messagesKey)
        .orderBy(MessageModel.timestampKey)
        // .withConverter(
        //   fromFirestore: MessageModel.fromMap,
        //   toFirestore: (message, _) => message.toMap(),
        // )
        .get();
  },
);

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          final userFuture = ref.watch(userFutureProvider(Utils().userUid!));
          final user = userFuture.whenOrNull(
            data: (data) {
              if (data.exists) {
                return data;
              } else {
                return ProviderStatus.none;
              }
            },
            loading: () => ProviderStatus.loading,
            error: (e, s) => ProviderStatus.error,
          );
          if (user == ProviderStatus.loading) {
            return const Center(
              child: QmCircularProgressIndicator(),
            );
          } else if (user == ProviderStatus.error) {
            return Center(
              child: QmText(text: S.current.DefaultError),
            );
          } else if (user == ProviderStatus.none) {
            return Center(
              child: QmText(
                onTap: () => context.go(Routes.searchR),
                text: S.current.NoChat,
                maxWidth: double.maxFinite,
              ),
            );
          } else {
            final data = userFuture.value!;
            final user = data.get(DBPathsConstants.chatsPath) as List;

            return ListView.builder(
              itemCount: user.length,
              itemBuilder: (context, index) {
                final userElements = user[index] as Map<String, dynamic>;
                final chatDocId = userElements.keys.elementAt(index);
                final chatUserId = userElements.values.elementAt(index);
                return FutureBuilder(
                  future: ref.watch(chatFutureProvider(chatDocId).future),
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

                    final chatData = snapshot.data!.docs
                        .map((e) => e.data()! as Map<String, dynamic>);
                    final String lastMessage =
                        chatData.last[MessageModel.messageKey] ??
                            SimpleConstants.emptyString;
                    final String lastMessageSender =
                        chatData.last[MessageModel.senderIdKey] ??
                            SimpleConstants.emptyString;
                    Color lastMessageColor(String lastMessageSender) {
                      if (lastMessageSender == Utils().userUid) {
                        return ColorConstants.textSeccondaryColor;
                      } else {
                        return ColorConstants.textColor;
                      }
                    }

                    final lastMessageTimestamp =
                        chatData.last[MessageModel.timestampKey];
                    return FutureBuilder(
                      future: ref.watch(userFutureProvider(chatUserId).future),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: QmCircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: QmText(text: S.current.DefaultError),
                          );
                        }
                        final userData = snapshot.data!;
                        final userUserData =
                            userData.data()! as Map<String, dynamic>;
                        final userName = userUserData[UserModel.nameKey];
                        final userProfileImage =
                            userUserData[UserModel.profileImageKey];
                        return ListTile(
                          leading: QmAvatar(
                            imageUrl: userProfileImage,
                          ),
                          title: QmText(
                            text: userName,
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
                              UserModel.nameKey: userName,
                              UserModel.profileImageKey: userProfileImage,
                            },
                          ),
                        );
                      },
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
