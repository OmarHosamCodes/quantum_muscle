import '/library.dart';

class RoutingErrorScreen extends StatelessWidget {
  const RoutingErrorScreen({super.key, required this.exception});
  final String exception;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            QmText(
              text: exception,
              maxWidth: double.maxFinite,
            ),
            QmIconButton(
              onPressed: () => context.go(Routes.initR),
              icon: Icons.home,
            ),
          ],
        ),
      ),
    );
  }
}
