import 'package:flutter_animate/flutter_animate.dart';
import 'package:quantum_muscle/view/widgets/qm_avatar.dart';

import '../../../library.dart';

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
        title: QMText(text: S.of(context).Chat),
      ),
      drawer: isDesktop() ? null : const RoutingDrawer(),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {},
            leading: const QmAvatar(
              'https://picsum.photos/250?image=9',
            ),
            title: QMText(text: 'User $index'),
            subtitle: QMText(
              text: 'Message $index',
              isSeccoundary: true,
            ),
            trailing: const QMText(
              text: 'Time',
              isSeccoundary: true,
            ).animate().fadeIn(),
          ).animate().moveX();
        },
      ),
    );
  }
}
