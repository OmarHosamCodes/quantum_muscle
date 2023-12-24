import '/library.dart';

final chatFutureProvider = StreamProvider.family<DocumentSnapshot?, String>(
  (ref, chatId) {
    return Utils()
        .firebaseFirestore
        .collection(DBPathsConstants.chatsPath)
        .doc(chatId)
        .snapshots(includeMetadataChanges: true);
  },
);

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDrawerExist() {
      if (ResponsiveBreakpoints.of(context).smallerThan(DESKTOP) ||
          GoRouterState.of(context).uri.toString() == Routes.authR) {
        return false;
      }
      return true;
    }

    return Scaffold(
      drawer: isDrawerExist() ? const RoutingDrawer() : null,
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
              child: QmText(text: S.of(context).DefaultError),
            );
          } else if (user == ProviderStatus.none) {
            return Center(
              child: QmText(
                onTap: () => context.go(Routes.searchR),
                text: S.of(context).NoChat,
                maxWidth: double.maxFinite,
              ),
            );
          } else {
            final data = userFuture.value!;
            final user = data.get(DBPathsConstants.chatsPath) as List;

            return ListView.builder(
              itemCount: user.length,
              itemBuilder: (context, index) {
                final chatDocId = user[index].keys.elementAt(index);
                final chatUserId = user[index].values.elementAt(index);
                return FutureBuilder(
                  future: ref.watch(chatFutureProvider(chatDocId).future),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: QmCircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: QmText(text: S.of(context).DefaultError),
                      );
                    }
                    // final chatData = snapshot.data!;
                    // final chatUserData =
                    //     chatData.data()! as Map<String, dynamic>;
                    // final messages =
                    //     chatUserData[ChatModel.messagesKey] as List<dynamic>;
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
                            child: QmText(text: S.of(context).DefaultError),
                          );
                        }
                        final userData = snapshot.data!;
                        final userUserData =
                            userData.data()! as Map<String, dynamic>;
                        final userName = userUserData[UserModel.nameKey];
                        final userImage = userUserData[UserModel.imageKey];
                        return ListTile(
                          // leading: QmAvatar(
                          //   imageUrl: userImage,
                          // ),
                          title: QmText(
                            text: userName,
                            // maxWidth: double.maxFinite,
                          ),
                          onTap: () => context.push(
                            Routes.chatsR,
                            extra: {
                              'chatId': chatDocId,
                              'chatUserId': chatUserId,
                            },
                          ),
                        );
                      },
                    );
                    // return ListTile(
                    //   leading: QmText(
                    //     text: chatUserId.toString(),
                    //     maxWidth: double.maxFinite,
                    //   ),
                    // );
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
