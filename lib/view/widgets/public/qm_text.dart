import 'package:quantum_muscle/library.dart';

/// A custom text widget for Quantum Muscle app.
class QmText extends StatelessWidget {
  /// Constructs a [QmText] widget.
  ///
  /// The [text] parameter is required and specifies the text to be displayed.
  ///
  /// The [style] parameter is optional and specifies the text style.
  /// If not provided,
  /// a default style with a font size of 15, Quantum Muscle's font family,
  /// and the
  /// default text color will be used.
  ///
  /// The [isSeccoundary] parameter is optional and specifies whether the
  /// text is
  /// secondary. If set to true, the font size will be 10, otherwise it will
  /// use the
  /// style's font size.
  ///
  /// The [isHeadline] parameter is optional and specifies whether the text is a
  ///  headline.
  /// If set to true, the font size will be 20, otherwise it will use
  ///  the style's font size.
  ///
  /// The [color] parameter is optional and specifies the text color. If
  /// not provided,
  /// it will use the default text color for normal text or the secondary text
  /// color for
  /// secondary text.
  const QmText({
    required this.text,
    super.key,
    this.style = const TextStyle(
      fontSize: 15,
      fontFamily: SimpleConstants.fontFamily,
      color: ColorConstants.textColor,
    ),
    this.isSeccoundary = false,
    this.isHeadline = false,
    this.color,
  }) : type = QmTextType.normal;

  /// Constructs a simple [QmText] widget.
  ///
  /// The [text] parameter is required and specifies the text to be displayed.
  ///
  /// The [style] parameter is optional and specifies the text
  /// style. If not provided,
  /// a default style with a font size of 15, Quantum Muscle's font family,
  /// and the default text color will be used.
  ///
  /// The [isSeccoundary] parameter is optional and specifies whether
  /// the text is
  /// secondary. If set to true, the font size will be 10, otherwise it will
  ///  use the
  /// style's font size.
  ///
  /// The [isHeadline] parameter is optional and specifies whether the text is
  ///  a headline.
  /// If set to true, the font size will be 20, otherwise it will use the
  /// style's font size.
  ///
  /// The [color] parameter is optional and specifies the text color. If
  ///  not provided,
  /// it will use the default text color for normal text or the secondary text c
  ///
  /// secondary text.
  const QmText.simple({
    required this.text,
    super.key,
    this.style = const TextStyle(
      fontSize: 15,
      fontFamily: SimpleConstants.fontFamily,
      color: ColorConstants.textColor,
    ),
    this.isSeccoundary = false,
    this.isHeadline = false,
    this.color,
  }) : type = QmTextType.simple;

  /// The text to be displayed.
  final String text;

  /// The text style.
  final TextStyle style;

  /// Specifies whether the text is secondary.
  final bool isSeccoundary;

  /// Specifies whether the text is a headline.
  final bool isHeadline;

  /// The type of the [QmText].
  final QmTextType type;

  /// The color of the text.
  final Color? color;

  /// The text overflow mode.
  TextOverflow get overFlow => TextOverflow.ellipsis;

  /// The font size of the text.
  double get fontSize {
    if (isSeccoundary) {
      return 10;
    } else if (isHeadline) {
      return 20;
    } else {
      return style.fontSize!;
    }
  }

  /// The text color.
  Color? get textColor =>
      color ??
      (isSeccoundary
          ? ColorConstants.textSecondaryColor
          : ColorConstants.textColor);

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case QmTextType.normal:
        return buildNormal(context);
      case QmTextType.simple:
        return buildSimple(context);
    }
  }

  /// Builds the [QmText] widget with normal type.
  Widget buildNormal(BuildContext context) {
    return MarqueeText(
      text: TextSpan(
        text: text,
        style: style.copyWith(
          color: textColor,
          fontSize: fontSize,
        ),
      ),
      speed: 20,
    );
  }

  /// Builds the [QmText] widget with simple type.
  Widget buildSimple(BuildContext context) {
    return Text(
      text,
      style: style.copyWith(
        color: textColor,
        overflow: overFlow,
        fontSize: fontSize,
      ),
    );
  }
}

/// The type of the [QmText].
enum QmTextType {
  /// The normal [QmText].
  normal,

  /// The simple [QmText].
  simple,
}
