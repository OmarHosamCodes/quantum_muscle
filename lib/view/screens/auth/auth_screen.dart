import 'package:quantum_muscle/library.dart';

final authPageController = PageController(initialPage: 1);

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final authScreens = <Widget>[
      ForgetPasswordScreen(
        isMobile: isMobile,
      ),
      LoginScreen(
        isMobile: isMobile,
      ),
      RegisterScreen(
        isMobile: isMobile,
      ),
    ];

    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          Consumer(
            builder: (_, ref, __) {
              return QmIconButton(
                onPressed: () => Utils().isEnglish
                    ? ref.read(localeProvider.notifier).state =
                        const Locale(SimpleConstants.arabicLocale)
                    : ref.read(localeProvider.notifier).state =
                        const Locale(SimpleConstants.englishLocale),
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
