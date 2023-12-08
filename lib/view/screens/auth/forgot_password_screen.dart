import '/library.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final forgotPasswordTextController = TextEditingController();
    final maxWidth = width * .6;
    final maxHeight = height * .1;
    final margin = EdgeInsets.symmetric(vertical: height * .01);
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Utils().isEnglish
                ? Alignment.centerLeft
                : Alignment.centerRight,
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 25,
                sigmaY: 25,
              ),
              child: Container(
                height: height * .25,
                width: width * .25,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: ColorConstants.primaryColor,
                      blurRadius: 200,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Center(
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
                        hintText: S.of(context).EnterEmail,
                        obscureText: true,
                        maxLength: 16,
                      ),
                      Consumer(builder: (context, ref, _) {
                        return QmBlock(
                          isGradient: true,
                          maxWidth: maxWidth,
                          onTap: () {
                            ForgotPasswordUtil().sendResetEmail(
                              email: forgotPasswordTextController.text,
                              context: context,
                            );
                          },
                          margin: margin,
                          width: maxWidth,
                          height: maxHeight,
                          child: ForgotPasswordUtil().countDown != 30
                              ? QmText(
                                  text:
                                      ForgotPasswordUtil().countDown.toString())
                              : QmText(text: S.of(context).SendEmail),
                        );
                      }),
                      QmText(
                        onTap: () => authPageController.jumpToPage(
                          1,
                        ),
                        text: S.of(context).GoBackToLogin,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
