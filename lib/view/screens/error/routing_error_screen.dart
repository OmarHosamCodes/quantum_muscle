import 'package:quantum_muscle/library.dart';

class RoutingErrorScreen extends StatelessWidget {
  const RoutingErrorScreen({
    super.key,
    this.error,
  });
  final String? error;
  @override
  Widget build(BuildContext context) {
    utils.firebaseAnalytics.logEvent(
      name: AnalyticsEventNamesConstants.routingError,
      parameters: <String, dynamic>{
        AnalyticsEventNamesConstants.error: error,
      },
    );
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QmText(
              text: S.current.DefaultError,
            ),
            QmButton.icon(
              onPressed: () => RoutingController().changeRoute(0),
              icon: EvaIcons.home,
            ),
          ],
        ),
      ),
    );
  }
}
