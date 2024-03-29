import 'package:quantum_muscle/library.dart';

/// Forget password screen.
class ForgetPasswordScreen extends StatelessWidget {
  /// const constructor for the [ForgetPasswordScreen]
  const ForgetPasswordScreen({
    required this.isMobile,
    required this.emailTextController,
    super.key,
  });

  /// isMobile flag
  final bool isMobile;

  /// email text controller
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
      body: Center(
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
                    onEditingComplete: () => forgetPasswordUtil.sendResetEmail(
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
                          SizedBox(
                            width: maxWidth,
                            child: QmButton.text(
                              onPressed: () {
                                forgetPasswordUtil.sendResetEmail(
                                  email: emailTextController.text,
                                  context: context,
                                );
                              },
                              text: S.current.SendEmail,
                            ),
                          ),
                          if (countDown > 0)
                            Text(
                              'Countdown: $countDown',
                              style: const TextStyle(fontSize: 16),
                            ),
                        ],
                      );
                    } else {
                      return SizedBox(
                        width: maxWidth,
                        child: QmButton.text(
                          onPressed: () {
                            forgetPasswordUtil.sendResetEmail(
                              email: emailTextController.text,
                              context: context,
                            );
                          },
                          text: S.current.SendEmail,
                        ),
                      );
                    }
                  },
                ),
                InkWell(
                  onTap: () => authPageController.jumpToPage(
                    1,
                  ),
                  child: QmText(
                    text: S.current.GoBackToLogin,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
