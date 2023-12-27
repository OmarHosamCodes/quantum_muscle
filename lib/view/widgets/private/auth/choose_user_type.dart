import '/library.dart';

class UserTypeChooser extends ConsumerWidget {
  const UserTypeChooser({
    super.key,
    this.width = 100,
    this.height = 100,
    this.maxWidth = 100,
    this.maxHeight = 100,
    this.margin = const EdgeInsets.all(0),
  });
  final double width;
  final double height;
  final double maxWidth;
  final double maxHeight;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userType = ref.watch(userTypeStateProvider);
    final List<Color> colors = [
      ColorConstants.disabledColor,
      ColorConstants.primaryColor,
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () =>
              ref.read(userTypeStateProvider.notifier).state = UserType.trainer,
          child: Container(
            margin: margin,
            constraints: BoxConstraints(
              maxWidth: maxWidth,
              maxHeight: maxHeight,
              minWidth: width,
              minHeight: height,
            ),
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: userType == UserType.trainer ? colors[1] : colors[0],
              borderRadius: BorderRadius.only(
                topLeft: Utils().isEnglish
                    ? const Radius.circular(10)
                    : const Radius.circular(0),
                bottomLeft: Utils().isEnglish
                    ? const Radius.circular(10)
                    : const Radius.circular(0),
                topRight: Utils().isEnglish
                    ? const Radius.circular(0)
                    : const Radius.circular(10),
                bottomRight: Utils().isEnglish
                    ? const Radius.circular(0)
                    : const Radius.circular(10),
              ),
            ),
            child: Center(child: QmText(text: S.current.Trainer)),
          ),
        ),
        GestureDetector(
          onTap: () =>
              ref.read(userTypeStateProvider.notifier).state = UserType.trainee,
          child: Container(
            margin: margin,
            constraints: BoxConstraints(
              maxWidth: maxWidth,
              maxHeight: maxHeight,
              minWidth: width,
              minHeight: height,
            ),
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: userType == UserType.trainee ? colors[1] : colors[0],
              borderRadius: BorderRadius.only(
                topLeft: Utils().isEnglish
                    ? const Radius.circular(0)
                    : const Radius.circular(10),
                bottomLeft: Utils().isEnglish
                    ? const Radius.circular(0)
                    : const Radius.circular(10),
                topRight: Utils().isEnglish
                    ? const Radius.circular(10)
                    : const Radius.circular(0),
                bottomRight: Utils().isEnglish
                    ? const Radius.circular(10)
                    : const Radius.circular(0),
              ),
            ),
            child: Center(child: QmText(text: S.current.Trainee)),
          ),
        ),
      ],
      // onPressed: (int index) {
      //   setState(() {
      //     isSelected[index] = !isSelected[index];
      //     _colors[index] = _colors[index] == ColorConstants.primaryColor
      //         ? ColorConstants.primaryColorDark
      //         : ColorConstants.primaryColor;
      //   });
      // },
    );
  }
}
