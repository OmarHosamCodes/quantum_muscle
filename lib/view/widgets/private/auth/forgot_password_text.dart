import 'package:quantum_muscle/library.dart';

/// Widget to show the forgot password text.
class ForgotPasswordTextWidget extends StatelessWidget {
  /// const constructor for the [ForgotPasswordTextWidget]
  const ForgotPasswordTextWidget({
    required this.width,
    super.key,
  });

  /// width
  final double width;

  @override
  Widget build(BuildContext context) {
    bool isScreenBiggerThanTablet(BuildContext context) =>
        ResponsiveBreakpoints.of(context).largerThan(TABLET);

    return Padding(
      padding: EdgeInsets.only(
        left: isScreenBiggerThanTablet(context) ? width * .5 : width * .4,
      ),
      child: SizedBox(
        child: InkWell(
          onTap: () => authPageController.jumpToPage(0),
          child: QmText.simple(
            isSeccoundary: true,
            text: S.current.ForgotPassword,
          ),
        ),
      ),
    );
  }
}
