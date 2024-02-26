import 'package:quantum_muscle/library.dart';

final authPageController = PageController(initialPage: 1);

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  static final emailTextController = TextEditingController();
  static final passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final authScreens = <Widget>[
      ForgetPasswordScreen(
        isMobile: isMobile,
        emailTextController: emailTextController,
      ),
      LoginScreen(
        isMobile: isMobile,
        emailTextController: emailTextController,
        passwordTextController: passwordTextController,
      ),
      RegisterScreen(
        isMobile: isMobile,
        emailTextController: emailTextController,
        passwordTextController: passwordTextController,
      ),
    ];

    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      extendBodyBehindAppBar: true,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          Consumer(
            builder: (_, ref, __) {
              return QmButton.icon(
                onPressed: () =>
                    ref.read(localeProvider.notifier).toggleLocale(),
                icon: EvaIcons.globe,
              );
            },
          ),
        ],
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: authPageController,
        children: authScreens,
      ),
    );
  }
}
