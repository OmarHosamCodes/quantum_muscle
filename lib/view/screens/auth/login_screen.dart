// ignore_for_file: depend_on_referenced_packages

import '../../../library.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final emailTextController = TextEditingController();
    final passwordTextController = TextEditingController();
    final maxWidth = width * .6;
    final maxHeight = height * .1;
    final margin = EdgeInsets.symmetric(vertical: height * .01);

    return Scaffold(
      body: Center(
        child: ResponsiveRowColumn(
          rowMainAxisAlignment: MainAxisAlignment.center,
          rowCrossAxisAlignment: CrossAxisAlignment.center,
          columnMainAxisAlignment: MainAxisAlignment.center,
          columnCrossAxisAlignment: CrossAxisAlignment.center,
          layout: ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
              ? ResponsiveRowColumnType.COLUMN
              : ResponsiveRowColumnType.ROW,
          children: [
            ResponsiveRowColumnItem(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * .02,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AssetPathConstants.loginImgPath),
                    QMText(text: S.of(context).WelcomeBack)
                  ],
                ),
              ),
            ),
            ResponsiveRowColumnItem(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: height * .01,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    QMTextField(
                      maxWidth: maxWidth,
                      margin: margin,
                      height: maxHeight,
                      width: maxWidth,
                      controller: emailTextController,
                      hintText: S.of(context).EnterEmail,
                    ),
                    QMTextField(
                      maxWidth: maxWidth,
                      margin: margin,
                      height: maxHeight,
                      width: maxWidth,
                      controller: passwordTextController,
                      hintText: S.of(context).EnterPassword,
                      obscureText: true,
                      maxLength: 16,
                    ),
                    ForgotPasswordTextWidget(width: width),
                    QmBlock(
                      maxWidth: maxWidth,
                      onTap: () {},
                      margin: margin,
                      width: maxWidth,
                      height: maxHeight,
                      child: QMText(text: S.of(context).Login),
                    ),
                    QMText(
                      //todo: choose login or register first and pop the seccound
                      onTap: () => context.go(RouteNameConstants.registerPage),
                      text:
                          "${S.of(context).NotAMember} ${S.of(context).Register}",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ForgotPasswordTextWidget extends StatelessWidget {
  const ForgotPasswordTextWidget({
    super.key,
    required this.width,
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
      child: QMText(
        onTap: () => context.go(RouteNameConstants.forgotPasswordPage),
        isSeccoundary: true,
        text: S.of(context).ForgotPassword,
      ),
    );
  }
}
