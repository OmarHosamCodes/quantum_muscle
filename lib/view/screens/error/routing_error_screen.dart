import 'package:quantum_muscle/library.dart';

/// Screen to show when there is a routing error.
class RoutingErrorScreen extends StatelessWidget {
  /// const constructor for the [RoutingErrorScreen]
  const RoutingErrorScreen({
    super.key,
    this.error,
  });

  /// error message
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
              onPressed: () => RoutingController().changeRoute(Routes.homeR),
              icon: EvaIcons.home,
            ),
          ],
        ),
      ),
    );
  }
}
