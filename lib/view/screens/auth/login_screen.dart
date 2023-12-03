// ignore_for_file: depend_on_referenced_packages

import '../../../library.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final maxWidth = width * .6;
    final maxHeight = height * .1;
    final margin = EdgeInsets.symmetric(vertical: height * .01);
    final formKey = GlobalKey<FormState>();
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(AssetPathConstants.loginImgPath),
                    QmText(
                      text: S.of(context).WelcomeBack,
                      maxWidth: double.maxFinite,
                    ),
                  ],
                ),
              ),
            ),
            ResponsiveRowColumnItem(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: height * .01,
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      QmTextField(
                        maxWidth: maxWidth,
                        margin: margin,
                        height: maxHeight,
                        width: maxWidth,
                        controller: emailTextController,
                        hintText: S.of(context).EnterEmail,
                        keyboardType: TextInputType.emailAddress,
                        hasNext: true,
                        validator: (value) {
                          if (ValidationController.validateEmail(value!) ==
                              false) {
                            return S.of(context).EnterValidEmail;
                          }
                          return null;
                        },
                      ),
                      QmTextField(
                        maxWidth: maxWidth,
                        margin: margin,
                        height: maxHeight,
                        width: maxWidth,
                        controller: passwordTextController,
                        hintText: S.of(context).EnterPassword,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        maxLength: 21,
                        hasNext: false,
                        validator: (value) {
                          if (ValidationController.validatePassword(value!) ==
                              false) {
                            return S.of(context).EnterValidPassword;
                          }
                          return null;
                        },
                      ),
                      ForgotPasswordTextWidget(width: width),
                      Consumer(
                        builder: (context, ref, _) {
                          return QmBlock(
                            isGradient: true,
                            maxWidth: maxWidth,
                            onTap: () {
                              LoginUtile().logUserIn(
                                context: context,
                                email: emailTextController.text,
                                password: passwordTextController.text,
                                formKey: formKey,
                              );
                            },
                            margin: margin,
                            width: maxWidth,
                            height: maxHeight,
                            child: QmText(
                              text: S.of(context).Login,
                            ),
                          );
                        },
                      ),
                      QmText(
                        onTap: () => authPageController.jumpToPage(
                          2,
                        ),
                        text:
                            "${S.of(context).NotAMember} ${S.of(context).Register}",
                        maxWidth: double.maxFinite,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
