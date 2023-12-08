import '/library.dart';

final chatStreamProvider = StreamProvider<QuerySnapshot<ChatModel>>(
  (ref) => FirebaseFirestore.instance
      .collection(DBPathsConstants.usersPath)
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection(DBPathsConstants.chatsPath)
      .withConverter(
        fromFirestore: ChatModel.fromMap,
        toFirestore: (ChatModel model, _) => model.toMap(),
      )
      .orderBy('timestamp', descending: true)
      .get()
      .asStream(),
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
      extendBody: true,
      drawer: isDrawerExist() ? const RoutingDrawer() : null,
      body: Consumer(builder: (context, ref, child) {
        final chatSnapshot = ref.watch(chatStreamProvider);
        final chatQuery = chatSnapshot.whenOrNull(
          data: (data) {
            if (data.docs.isEmpty) {
              return ProviderStatus.error;
            } else {
              return ProviderStatus.data;
            }
          },
          loading: () => ProviderStatus.loading,
          error: (e, s) => ProviderStatus.error,
        );
        if (chatQuery == ProviderStatus.data) {
          final data = chatQuery as QuerySnapshot<ChatModel>;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: data.docs.map((chat) {
              final chatData = chat.data();
              final chatSender = chatData.sender;
              final chatLastMessage = chatData.message;
              final chatImage = chatData.userImage;
              final chatTime = chatData.timestamp;

              return ListTile(
                onTap: () {},
                leading: QmAvatar(
                  userImage: chatImage,
                ),
                title: QmText(text: chatSender),
                subtitle: QmText(
                  text: chatLastMessage,
                  isSeccoundary: true,
                ),
                trailing: QmText(
                  text: chatTime.toString(),
                  isSeccoundary: true,
                ),
              );
            }).toList(),
          );
        } else if (chatQuery == ProviderStatus.error) {
          return Center(
            child: QmText(
              text: S.of(context).NoChat,
            ),
          );
        } else {
          return const Center(child: QmCircularProgressIndicator());
        }
      }),
    );
  }
}
