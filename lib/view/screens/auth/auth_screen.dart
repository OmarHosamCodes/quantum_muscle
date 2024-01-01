import '/library.dart';

final authPageController = PageController(initialPage: 1);

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> authScreens = [
      const ForgetPasswordScreen(),
      const LoginScreen(),
      const RegisterScreen(),
    ];
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          Consumer(
            builder: (context, ref, _) {
              return QmIconButton(
                onPressed: () => Utils().toggleLocale(ref),
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
