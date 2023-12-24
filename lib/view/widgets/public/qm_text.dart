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
  const QmText({
    super.key,
    required this.text,
    this.style = const TextStyle(
        fontSize: 20, fontFamily: 'family', color: ColorConstants.textColor),
    this.isSeccoundary = false,
    this.isHeadline = false,
    this.onTap,
    this.maxWidth = 300,
    this.color,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Text(
          overflow: overflow,
          text,
          style: style.copyWith(
            color: color ??
                (isSeccoundary
                    ? ColorConstants.tertiaryColor
                    : ColorConstants.textColor),
            fontSize: isSeccoundary
                ? style.fontSize! - 7
                : isHeadline
                    ? style.fontSize! + 10
                    : style.fontSize!,
          ),
        ),
      ),
    );
  }
}
