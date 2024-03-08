import 'package:quantum_muscle/library.dart';

/// A widget that represents an indicator with a colored shape and text.
class Indicator extends StatelessWidget {
  /// Creates an [Indicator] widget.
  ///
  /// The [color] parameter specifies the color of the shape.
  ///
  /// The [text] parameter specifies the text to be displayed.
  ///
  /// The [isSquare] parameter specifies whether the shape should be
  /// a square or a circle.
  ///
  /// The [key] parameter is an optional parameter used to identify this widget.
  const Indicator({
    required this.color,
    required this.text,
    required this.isSquare,
    super.key,
  });

  /// The color of the shape.
  final Color color;

  /// The text to be displayed.
  final String text;

  /// Specifies whether the shape should be a square or a circle.
  final bool isSquare;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        QmText(
          text: text,
        ),
      ],
    );
  }
}
