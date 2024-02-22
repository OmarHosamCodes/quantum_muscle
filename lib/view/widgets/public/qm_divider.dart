import 'package:quantum_muscle/library.dart';

class QmDivider extends StatelessWidget {
  const QmDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: ColorConstants.accentColor,
      thickness: .25,
      height: 1,
    );
  }
}
