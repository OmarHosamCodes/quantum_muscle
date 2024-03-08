import 'package:quantum_muscle/library.dart';

void openQmDialog({
  required BuildContext context,
  required String title,
  required String message,
}) =>
    showDialog<void>(
      context: context,
      builder: (context) => _QmDialog(
        title: title,
        message: message,
      ),
    );

class _QmDialog extends StatelessWidget {
  const _QmDialog({
    required this.title,
    required this.message,
  });
  final String title;
  final String message;
  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      backgroundColor: ColorConstants.accentColor,
      title: QmText.simple(
        text: title,
        isHeadline: true,
      ),
      content: QmText.simple(
        text: message,
      ),
    );
  }
}
