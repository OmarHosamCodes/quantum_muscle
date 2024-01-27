import '/library.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final forgotPasswordTextController = TextEditingController();
    final maxWidth = width * .6;
    final maxHeight = height * .1;
    final margin = EdgeInsets.symmetric(vertical: height * .01);
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: QmNiceTouch(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                          child: ForgetPasswordUtil().countDown != 30
                              ? QmText(
                                  text:
                                      ForgetPasswordUtil().countDown.toString())
                              : QmText(text: S.current.SendEmail),
                        );
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
