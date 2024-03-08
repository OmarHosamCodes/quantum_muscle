import 'package:quantum_muscle/library.dart';

class QmLoader extends StatelessWidget {
  const QmLoader.indicator({super.key, this.value});
  static void openLoader({required BuildContext context}) => showDialog<void>(
        barrierDismissible: false,
        context: context,
        builder: (context) => const Dialog(
          elevation: 0,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          child: Center(
            child: QmLoader.indicator(),
          ),
        ),
      );

  static void closeLoader({required BuildContext context}) => context.pop();

  final double? value;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: ColorConstants.accentColor,
      value: value,
    );
  }
}
