// ignore_for_file: depend_on_referenced_packages

import 'package:quantum_muscle/library.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    required this.isMobile,
    super.key,
  });
  final bool isMobile;
  static final passwordTextController = TextEditingController();
  static final emailTextController = TextEditingController();
  static final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final maxWidth = isMobile ? width * .9 : width * .6;
    final maxHeight = height * .1;
    final margin = EdgeInsets.symmetric(vertical: height * .01);
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
                        SizedBox(
                          height: maxHeight,
                          width: maxWidth,
                          child: QmTextField(
                            textInputAction: TextInputAction.next,
                            margin: margin,
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
                        ),
                        SizedBox(
                          height: maxHeight,
                          width: maxWidth,
                          child: Consumer(
                            builder: (_, WidgetRef ref, __) {
                              return QmTextField(
                                textInputAction: TextInputAction.go,
                                margin: margin,
                                controller: passwordTextController,
                                hintText: S.current.EnterPassword,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: true,
                                maxLength: 21,
                                validator: (value) {
                                  if (ValidationController.validatePassword(
                                        value!,
                                      ) ==
                                      false) {
                                    return S.current.EnterValidPassword;
                                  }
                                  return null;
                                },
                                onEditingComplete: () => loginUtil.logUserIn(
                                  context: context,
                                  email: emailTextController.text,
                                  password: passwordTextController.text,
                                  formKey: formKey,
                                  ref: ref,
                                ),
                              );
                            },
                          ),
                        ),
                        ForgotPasswordTextWidget(width: width),
                        Consumer(
                          builder: (_, ref, __) {
                            return QmBlock(
                              isGradient: true,
                              maxWidth: maxWidth,
                              onTap: () {
                                loginUtil.logUserIn(
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
