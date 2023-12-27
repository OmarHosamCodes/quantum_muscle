import '/library.dart';

void openQmLoaderDialog({required BuildContext context}) => showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => const _QmLoaderDialog(),
    );

class _QmLoaderDialog extends StatelessWidget {
  const _QmLoaderDialog();

  @override
  Widget build(BuildContext context) {
    return const Dialog(
      elevation: 0,
      shadowColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      child: Center(
        child: QmCircularProgressIndicator(),
      ),
    );
  }
}

class QmCircularProgressIndicator extends StatelessWidget {
  const QmCircularProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      color: ColorConstants.primaryColor,
    );
  }
}
