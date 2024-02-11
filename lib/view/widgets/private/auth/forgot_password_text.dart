import 'package:quantum_muscle/library.dart';

class ForgotPasswordTextWidget extends StatelessWidget {
  const ForgotPasswordTextWidget({
    required this.width, super.key,
  });
  final double width;

  @override
  Widget build(BuildContext context) {
    bool isScreenBiggerThanTablet(BuildContext context) {
      return ResponsiveBreakpoints.of(context).largerThan(TABLET);
    }

    return Padding(
      padding: EdgeInsets.only(
        left: isScreenBiggerThanTablet(context) ? width * .5 : width * .4,
      ),
      child: SizedBox(
        child: QmText(
          onTap: () => authPageController.jumpToPage(0),
          isSeccoundary: true,
          text: S.current.ForgotPassword,
        ),
      ),
    );
  }
}
