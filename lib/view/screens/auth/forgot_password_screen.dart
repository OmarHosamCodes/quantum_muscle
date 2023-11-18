import '../../../library.dart';

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
      body: Center(
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
                  QMTextField(
                    maxWidth: maxWidth,
                    margin: margin,
                    height: maxHeight,
                    width: maxWidth,
                    controller: forgotPasswordTextController,
                    hintText: S.of(context).EnterEmail,
                    obscureText: true,
                    maxLength: 16,
                  ),
                  QmBlock(
                    maxWidth: maxWidth,
                    onTap: () {},
                    margin: margin,
                    width: maxWidth,
                    height: maxHeight,
                    child: QMText(text: S.of(context).SendEmail),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
