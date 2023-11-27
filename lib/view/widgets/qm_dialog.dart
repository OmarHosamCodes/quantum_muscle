import '/library.dart';

Future<void> openQmLoaderDialog({required BuildContext context}) => showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => const _QmLoaderDialog(),
    );

class _QmLoaderDialog extends StatelessWidget {
  const _QmLoaderDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Dialog(
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

Future<void> openQmDialog(
        {required BuildContext context,
        required String title,
        required String message}) =>
    showDialog(
      context: context,
      builder: (context) => _QmDialog(
        title: title,
        message: message,
      ),
    );

class _QmDialog extends StatelessWidget {
  const _QmDialog({
    Key? key,
    required this.title,
    required this.message,
  }) : super(key: key);
  final String title;
  final String message;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorConstants.primaryColorDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .3,
        width: MediaQuery.of(context).size.width * .3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            QmText(
              text: title,
              isHeadline: true,
            ),
            const SizedBox(
              height: 20,
            ),
            QmText(
              text: message,
              isSeccoundary: true,
              maxWidth: double.maxFinite,
            ),
          ],
        ),
      ),
    );
  }
}