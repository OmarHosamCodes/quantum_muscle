import '/library.dart';

class RoutingErrorScreen extends StatelessWidget {
  const RoutingErrorScreen({super.key, required this.exception});
  final String exception;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          QmText(
            text: exception,
          ),
          QmIconButton(
            onPressed: () => context.go(RoutingController.authR),
            icon: Icons.home,
          ),
        ],
      ),
    );
  }
}
