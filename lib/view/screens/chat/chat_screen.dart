import 'package:quantum_muscle/models/chat_model.dart';

import '../../../library.dart';

final chatStreamProvider = StreamProvider<QuerySnapshot<ChatModel>>(
  (ref) => FirebaseFirestore.instance
      .collection(DBPathsConstants.usersPath)
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection(DBPathsConstants.chatsPath)
      .withConverter(
        fromFirestore: ChatModel.fromMap,
        toFirestore: (ChatModel model, _) => model.toMap(),
      )
      .get()
      .asStream(),
);

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDesktop() {
      if (ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)) return false;
      return true;
    }

    return Scaffold(
      appBar: AppBar(
        title: QmText(text: S.of(context).Chat),
      ),
      drawer: isDesktop() ? null : const RoutingDrawer(),
      body: Consumer(builder: (context, ref, child) {
        final chatSnapshot = ref.watch(chatStreamProvider);
        final chatQuery = chatSnapshot.whenOrNull(
          data: (data) {
            if (data.docs.isEmpty) {
              return FutureStatus.error;
            } else {
              return FutureStatus.data;
            }
          },
          loading: () => FutureStatus.loading,
          error: (e, s) => FutureStatus.error,
        );
        if (chatQuery == FutureStatus.data) {
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
        } else if (chatQuery == FutureStatus.error) {
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
