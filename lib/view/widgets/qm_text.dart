import '../../library.dart';

class QMText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final bool isSeccoundary;
  final void Function()? onTap;
  const QMText({
    Key? key,
    required this.text,
    this.style = const TextStyle(
        fontSize: 20, fontFamily: 'family', color: ColorConstants.textColor),
    this.isSeccoundary = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: style.copyWith(
            color: isSeccoundary
                ? ColorConstants.tertiaryColor
                : ColorConstants.textColor,
            fontSize: isSeccoundary ? style.fontSize! - 7 : style.fontSize!),
      ),
    );
  }
}
