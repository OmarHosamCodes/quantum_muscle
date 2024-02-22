import 'package:quantum_muscle/library.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({
    required this.isMobile,
    required this.emailTextController,
    super.key,
  });
  final bool isMobile;
  final TextEditingController emailTextController;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: maxWidth,
                    height: maxHeight,
                    child: QmTextField(
                      textInputAction: TextInputAction.go,
                      margin: margin,
                      controller: emailTextController,
                      hintText: S.current.Email,
                      onEditingComplete: () =>
                          forgetPasswordUtil.sendResetEmail(
                        email: emailTextController.text,
                        context: context,
                      ),
                    ),
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
                              maxWidth: maxWidth,
                              onTap: () {
                                forgetPasswordUtil.sendResetEmail(
                                  email: emailTextController.text,
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
                          color: ColorConstants.accentColor,
                          maxWidth: maxWidth,
                          onTap: () {
                            forgetPasswordUtil.sendResetEmail(
                              email: emailTextController.text,
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
            ],
          ),
        ),
      ),
    );
  }
}
