import '/library.dart';

class QmText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final bool isSeccoundary;
  final bool isHeadline;
  final void Function()? onTap;
  final double maxWidth;
  final Color? color;
  final TextOverflow? overflow;
  final bool? softWrap;
  const QmText({
    super.key,
    required this.text,
    this.style = const TextStyle(
      fontSize: 20,
      fontFamily: SimpleConstants.fontFamily,
      color: ColorConstants.textColor,
    ),
    this.isSeccoundary = false,
    this.isHeadline = false,
    this.onTap,
    this.maxWidth = 300,
    this.color,
    this.overflow,
    this.softWrap,
  });
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
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Text(
          text,
          overflow: overflow,
          softWrap: softWrap,
          style: style.copyWith(
            color: textColor,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
