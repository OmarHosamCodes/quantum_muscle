import '/library.dart';

final authPageController = PageController(initialPage: 1);

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> authScreens = [
      const ForgotPasswordScreen(),
      const LoginScreen(),
      const RegisterScreen(),
    ];
    return Scaffold(
      appBar: AppBar(
        actions: [
          Consumer(
            builder: (context, ref, _) {
              final locale = ref.watch(localStateProvider);
              return IconButton(
                onPressed: () => locale == const Locale('en')
                    ? ref.read(localStateProvider.notifier).state =
                        const Locale('ar')
                    : ref.read(localStateProvider.notifier).state =
                        const Locale('en'),
                icon: const Icon(Icons.language),
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
