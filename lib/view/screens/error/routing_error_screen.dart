import '/library.dart';

class RoutingErrorScreen extends StatelessWidget {
  const RoutingErrorScreen({
    super.key,
    this.error,
  });
  final String? error;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            QmText(
              text: error ?? 'Error',
              maxWidth: double.maxFinite,
            ),
            QmIconButton(
              onPressed: () => RoutingController().changeRoute(0),
              icon: Icons.home,
            ),
          ],
        ),
      ),
    );
  }
}
