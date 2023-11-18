import '../../../library.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final nameTextController = TextEditingController();
    final ratIDTextController = TextEditingController();
    final emailTextController = TextEditingController();
    final passwordTextController = TextEditingController();
    final maxWidth = width * .6;
    final maxHeight = height * .1;
    final margin = EdgeInsets.symmetric(vertical: height * .01);

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
                  children: [
                    Image.asset(AssetPathConstants.registerImgPath),
                    QMText(text: S.of(context).CreateAnAccount)
                  ],
                ),
              ),
            ),
            ResponsiveRowColumnItem(
              child: Padding(
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
                      controller: nameTextController,
                      hintText: S.of(context).EnterName,
                    ),
                    QMTextField(
                      maxWidth: maxWidth,
                      margin: margin,
                      height: maxHeight,
                      width: maxWidth,
                      controller: ratIDTextController,
                      hintText: S.of(context).EnterRatID,
                    ),
                    QMTextField(
                      maxWidth: maxWidth,
                      margin: margin,
                      height: maxHeight,
                      width: maxWidth,
                      controller: emailTextController,
                      hintText: S.of(context).EnterEmail,
                    ),
                    QMTextField(
                      maxWidth: maxWidth,
                      margin: margin,
                      height: maxHeight,
                      width: maxWidth,
                      controller: passwordTextController,
                      hintText: S.of(context).EnterPassword,
                      obscureText: true,
                      maxLength: 16,
                    ),
                    UserTypeChooser(
                      margin: margin,
                      maxWidth: width * 0.3,
                      width: width * .3,
                      height: maxHeight,
                    ),
                    QmBlock(
                      maxWidth: maxWidth,
                      onTap: () {},
                      margin: margin,
                      width: maxWidth,
                      height: maxHeight,
                      child: QMText(text: S.of(context).Register),
                    ),
                    //todo: choose login or register first and pop the seccound
                    QMText(
                      onTap: () => context.go(RouteNameConstants.loginPage),
                      text:
                          "${S.of(context).AlreadyMember} ${S.of(context).Login}",
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
