import 'package:quantum_muscle/library.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({
    required this.isMobile, super.key,
  });
  final bool isMobile;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final forgotPasswordTextController = TextEditingController();
    final maxWidth = isMobile ? width * .9 : width * .6;
    final maxHeight = height * .1;
    final margin = EdgeInsets.symmetric(vertical: height * .01);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: QmNiceTouch(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: height * .01,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    QmTextField(
                      maxWidth: maxWidth,
                      margin: margin,
                      height: maxHeight,
                      width: maxWidth,
                      controller: forgotPasswordTextController,
                      hintText: S.current.EnterEmail,
                    ),
                    Consumer(
                      builder: (_, ref, __) {
                        final forgetPasswordWatcher =
                            ref.watch(forgetPasswordProvider);
                        final isEmailSent = forgetPasswordWatcher.isEmailSent;
                        final countDown = forgetPasswordWatcher.countDown;

                        if (isEmailSent) {
                          return Column(
                            children: [
                              QmBlock(
                                isGradient: true,
                                maxWidth: maxWidth,
                                onTap: () {
                                  ForgetPasswordUtil().sendResetEmail(
                                    email: forgotPasswordTextController.text,
                                    context: context,
                                  );
                                },
                                margin: margin,
                                width: maxWidth,
                                height: maxHeight,
                                child: QmText(text: S.current.SendEmail),
                              ),
                              if (countDown > 0)
                                Text(
                                  'Countdown: $countDown',
                                  style: const TextStyle(fontSize: 16),
                                ),
                            ],
                          );
                        } else {
                          return QmBlock(
                            isGradient: true,
                            maxWidth: maxWidth,
                            onTap: () {
                              ForgetPasswordUtil().sendResetEmail(
                                email: forgotPasswordTextController.text,
                                context: context,
                              );
                            },
                            margin: margin,
                            width: maxWidth,
                            height: maxHeight,
                            child: QmText(text: S.current.SendEmail),
                          );
                        }
                      },
                    ),
                    QmText(
                      onTap: () => authPageController.jumpToPage(
                        1,
                      ),
                      text: S.current.GoBackToLogin,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
