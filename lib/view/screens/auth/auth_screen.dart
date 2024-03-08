import 'package:quantum_muscle/library.dart';

/// Controller for managing the page navigation in the authentication screen
final authPageController = PageController(initialPage: 1);

/// The screen for handling user authentication.
class AuthScreen extends ConsumerWidget {
  /// const constructor for the [AuthScreen]
  const AuthScreen({super.key});

  /// email text controller
  static final emailTextController = TextEditingController();

  /// password text controller
  static final passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Check if the screen is being displayed on a mobile device
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    // List of authentication screens to be displayed in a PageView
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
