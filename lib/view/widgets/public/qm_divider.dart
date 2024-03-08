import 'package:quantum_muscle/library.dart';

/// A widget that represents a divider.
class QmDivider extends StatelessWidget {
  /// Creates a divider.
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
