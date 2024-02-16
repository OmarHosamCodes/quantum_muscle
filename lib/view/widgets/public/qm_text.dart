import 'package:quantum_muscle/library.dart';

class QmText extends StatelessWidget {
  const QmText({
    required this.text,
    super.key,
    this.style = const TextStyle(
      fontSize: 20,
      fontFamily: SimpleConstants.fontFamily,
      color: ColorConstants.textColor,
    ),
    this.isSeccoundary = false,
    this.isHeadline = false,
    this.onTap,
    this.color,
  });
  final String text;
  final TextStyle style;
  final bool isSeccoundary;
  final bool isHeadline;
  final void Function()? onTap;
  final Color? color;
  double get fontSize {
    if (isSeccoundary) {
      return 13;
    } else if (isHeadline) {
      return 30;
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
    return InkWell(
      onTap: onTap,
      child: MarqueeText(
        text: TextSpan(
          text: text,
          style: style.copyWith(
            color: textColor,
            fontSize: fontSize,
          ),
        ),
        speed: 20,
      ),
    );
  }
}

class QmSimpleText extends StatelessWidget {
  const QmSimpleText({
    required this.text,
    super.key,
    this.style = const TextStyle(
      fontSize: 20,
      fontFamily: SimpleConstants.fontFamily,
      color: ColorConstants.textColor,
    ),
    this.isSeccoundary = false,
    this.color,
    this.overFlow,
  });
  final String text;
  final TextStyle style;
  final bool isSeccoundary;
  final TextOverflow? overFlow;
  final Color? color;

  Color? get textColor =>
      color ??
      (isSeccoundary
          ? ColorConstants.textSeccondaryColor
          : ColorConstants.textColor);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style.copyWith(
        color: textColor,
        overflow: overFlow,
      ),
    );
  }
}
