// ignore_for_file: depend_on_referenced_packages

import 'package:quantum_muscle/library.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    required this.isMobile,
    required this.emailTextController,
    required this.passwordTextController,
    super.key,
  });
  final bool isMobile;

  final TextEditingController emailTextController;
  final TextEditingController passwordTextController;

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
      body: Center(
        child: ResponsiveRowColumn(
          rowMainAxisAlignment: MainAxisAlignment.center,
          columnMainAxisAlignment: MainAxisAlignment.center,
          layout: ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
              ? ResponsiveRowColumnType.COLUMN
              : ResponsiveRowColumnType.ROW,
          children: [
            ResponsiveRowColumnItem(
              child: Padding(
                padding: const EdgeInsets.all(8),
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
                        hintText: S.current.Email,
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
                            hintText: S.current.Password,
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
                        return SizedBox(
                          width: maxWidth,
                          child: QmButton.text(
                            onPressed: () {
                              loginUtil.logUserIn(
                                context: context,
                                email: emailTextController.text,
                                password: passwordTextController.text,
                                formKey: formKey,
                                ref: ref,
                              );
                            },
                            text: S.current.Login,
                          ),
                        );
                      },
                    ),
                    InkWell(
                      onTap: () => authPageController.jumpToPage(
                        2,
                      ),
                      child: QmText(
                        text: '${S.current.NotAMember} ${S.current.Register}',
                      ),
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
