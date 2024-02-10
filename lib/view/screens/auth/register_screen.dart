import '/library.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({
    super.key,
    required this.isMobile,
  });
  final bool isMobile;
  @override
  Widget build(BuildContext context) {
    final nameTextController = TextEditingController();
    final emailTextController = TextEditingController();
    final passwordTextController = TextEditingController();
    final formKey = GlobalKey<FormState>();
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
                      QmText(
                        text: S.current.CreateAnAccount,
                      )
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
                          maxLength: 20,
                          controller: nameTextController,
                          hintText: S.current.EnterName,
                          keyboardType: TextInputType.name,
                          hasNext: true,
                          validator: (value) {
                            if (ValidationController.validateName(value!) ==
                                false) {
                              return S.current.EnterValidName;
                            }
                            return null;
                          },
                        ),
                        QmTextField(
                          maxWidth: maxWidth,
                          margin: margin,
                          height: maxHeight,
                          width: maxWidth,
                          controller: emailTextController,
                          hintText: S.current.EnterEmail,
                          hasNext: true,
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
                          hasNext: false,
                          obscureText: true,
                          maxLength: 21,
                          validator: (value) {
                            if (ValidationController.validatePassword(value!) ==
                                false) {
                              return S.current.EnterValidPassword;
                            }
                            return null;
                          },
                        ),
                        UserTypeChooser(
                          margin: margin,
                          maxWidth: width * 0.3,
                          width: width * .3,
                          height: maxHeight,
                        ),
                        Consumer(
                          builder: (context, ref, child) {
                            return _SubmitButton(
                              maxWidth: maxWidth,
                              emailTextController: emailTextController,
                              passwordTextController: passwordTextController,
                              nameTextController: nameTextController,
                              formKey: formKey,
                              margin: margin,
                              maxHeight: maxHeight,
                            );
                          },
                        ),
                        QmText(
                          onTap: () => authPageController.jumpToPage(
                            1,
                          ),
                          text: "${S.current.AlreadyMember} ${S.current.Login}",
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

class _SubmitButton extends ConsumerWidget {
  const _SubmitButton({
    required this.maxWidth,
    required this.emailTextController,
    required this.passwordTextController,
    required this.nameTextController,
    required this.formKey,
    required this.margin,
    required this.maxHeight,
  });

  final double maxWidth;

  final TextEditingController emailTextController;
  final TextEditingController passwordTextController;
  final TextEditingController nameTextController;
  final GlobalKey<FormState> formKey;
  final EdgeInsets margin;
  final double maxHeight;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userType = ref.watch(userTypeProvider);

    return QmBlock(
      isGradient: true,
      maxWidth: maxWidth,
      onTap: () {
        RegisterUtil().register(
          email: emailTextController.text,
          password: passwordTextController.text,
          userName: nameTextController.text,
          userType: userType,
          formKey: formKey,
          context: context,
          ref: ref,
        );
        emailTextController.clear();
        passwordTextController.clear();
        nameTextController.clear();
      },
      margin: margin,
      width: maxWidth,
      height: maxHeight,
      child: QmText(text: S.current.Register),
    );
  }
}
