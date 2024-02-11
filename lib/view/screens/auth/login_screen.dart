// ignore_for_file: depend_on_referenced_packages

import 'package:quantum_muscle/library.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    required this.isMobile, super.key,
  });
  final bool isMobile;
  @override
  Widget build(BuildContext context) {
    final emailTextController = TextEditingController();
    final passwordTextController = TextEditingController();
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final maxWidth = isMobile ? width * .9 : width * .6;
    final maxHeight = height * .1;
    final margin = EdgeInsets.symmetric(vertical: height * .01);
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: QmNiceTouch(
        child: Center(
          child: ResponsiveRowColumn(
            rowMainAxisAlignment: MainAxisAlignment.center,
            columnMainAxisAlignment: MainAxisAlignment.center,
            layout: ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
                ? ResponsiveRowColumnType.COLUMN
                : ResponsiveRowColumnType.ROW,
            children: [
              ResponsiveRowColumnItem(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * .01,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AssetPathConstants.loginImgPath),
                      QmText(
                        text: S.current.WelcomeBack,
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
                          hintText: S.current.EnterEmail,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (ValidationController.validateEmail(value!) ==
                                false) {
                              return S.current.EnterValidEmail;
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
                          hintText: S.current.EnterPassword,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          maxLength: 21,
                          hasNext: false,
                          validator: (value) {
                            if (ValidationController.validatePassword(value!) ==
                                false) {
                              return S.current.EnterValidPassword;
                            }
                            return null;
                          },
                        ),
                        ForgotPasswordTextWidget(width: width),
                        Consumer(
                          builder: (_, ref, __) {
                            return QmBlock(
                              isGradient: true,
                              maxWidth: maxWidth,
                              onTap: () {
                                LoginUtil().logUserIn(
                                  context: context,
                                  email: emailTextController.text,
                                  password: passwordTextController.text,
                                  formKey: formKey,
                                  ref: ref,
                                );
                              },
                              margin: margin,
                              width: maxWidth,
                              height: maxHeight,
                              child: QmText(
                                text: S.current.Login,
                              ),
                            );
                          },
                        ),
                        QmText(
                          onTap: () => authPageController.jumpToPage(
                            2,
                          ),
                          text: '${S.current.NotAMember} ${S.current.Register}',
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
      ),
    );
  }
}
