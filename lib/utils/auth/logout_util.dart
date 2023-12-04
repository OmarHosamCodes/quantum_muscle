import '../../library.dart';

class LogoutUtil extends AuthUtil {
  void logout(BuildContext context) {
    openQmLoaderDialog(context: context);
    firebaseAuth.signOut();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      timeStamp = const Duration(seconds: 5);
      context.pop();
    });
  }
}
