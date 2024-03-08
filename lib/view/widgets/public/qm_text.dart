import 'package:quantum_muscle/library.dart';

class QmText extends StatelessWidget {
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

  final String text;
  final TextStyle style;
  final bool isSeccoundary;
  final bool isHeadline;
  final QmTextType type;
  final Color? color;

  TextOverflow get overFlow => TextOverflow.ellipsis;

  double get fontSize {
    if (isSeccoundary) {
      return 10;
    } else if (isHeadline) {
      return 20;
    } else {
      return style.fontSize!;
    }
  }

  Color? get textColor =>
      color ??
      (isSeccoundary
          ? ColorConstants.textSeccondaryColor
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

enum QmTextType {
  normal,
  simple,
}
