import 'package:quantum_muscle/library.dart';

/// A screen widget for user registration.
class RegisterScreen extends StatelessWidget {
  /// Constructs a [RegisterScreen].
  ///
  /// [isMobile] specifies whether the screen is being displayed
  /// on a mobile device.
  /// [emailTextController] is a controller for the email text field.
  /// [passwordTextController] is a controller for the password text field.
  /// [key] is an optional parameter to specify a [Key] for this widget.
  const RegisterScreen({
    required this.isMobile,
    required this.emailTextController,
    required this.passwordTextController,
    super.key,
  });

  /// A controller for the email text field.
  final TextEditingController emailTextController;

  /// A controller for the password text field.
  final TextEditingController passwordTextController;

  /// Specifies whether the screen is being displayed on a mobile device.
  final bool isMobile;

  /// A controller for the name text field.
  static final nameTextController = TextEditingController();

  /// A global key for the form widget.
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
                    Image.asset(AssetPathConstants.registerImgPath),
                    QmText(
                      text: S.current.CreateAnAccount,
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
                      width: maxWidth,
                      height: maxHeight,
                      child: QmTextField(
                        textInputAction: TextInputAction.next,
                        margin: margin,
                        maxLength: 20,
                        controller: nameTextController,
                        hintText: S.current.Name,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (ValidationController.validateName(value!) ==
                              false) {
                            return S.current.EnterValidName;
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: maxWidth,
                      height: maxHeight,
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
                      width: maxWidth,
                      height: maxHeight,
                      child: QmTextField(
                        textInputAction: TextInputAction.next,
                        margin: margin,
                        controller: passwordTextController,
                        hintText: S.current.Password,
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
                      ),
                    ),
                    UserTypeChooser(
                      margin: margin,
                      maxWidth: width * 0.3,
                      width: width * .3,
                      height: maxHeight,
                    ),
                    _SubmitButton(
                      maxWidth: maxWidth,
                      email: emailTextController.text,
                      password: passwordTextController.text,
                      name: nameTextController.text,
                      formKey: formKey,
                    ),
                    InkWell(
                      onTap: () => authPageController.jumpToPage(
                        1,
                      ),
                      child: QmText(
                        text: '${S.current.AlreadyMember} ${S.current.Login}',
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

class _SubmitButton extends ConsumerWidget {
  const _SubmitButton({
    required this.maxWidth,
    required this.email,
    required this.password,
    required this.name,
    required this.formKey,
  });

  final double maxWidth;

  final String email;
  final String password;
  final String name;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userType = ref.watch(userTypeProvider);

    return SizedBox(
      width: maxWidth,
      child: QmButton.text(
        onPressed: () {
          registerUtil.register(
            email: email,
            password: password,
            userName: name,
            userType: userType,
            formKey: formKey,
            context: context,
            ref: ref,
          );
        },
        text: S.current.Register,
      ),
    );
  }
}
