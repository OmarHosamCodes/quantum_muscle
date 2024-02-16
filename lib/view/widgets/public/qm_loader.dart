import 'package:quantum_muscle/library.dart';

class QmLoader {
  static void openLoader({required BuildContext context}) => showDialog<void>(
        barrierDismissible: false,
        context: context,
        builder: (context) => Dialog(
          elevation: 0,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          child: Center(
            child: indicator(),
          ),
        ),
      );
  static void closeLoader({required BuildContext context}) => context.pop();

  static Widget indicator({double? value}) {
    return CircularProgressIndicator(
      color: ColorConstants.primaryColor,
      value: value,
    );
  }
}
