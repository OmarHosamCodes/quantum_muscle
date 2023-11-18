import '../../../library.dart';

class UserTypeChooser extends StatefulWidget {
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
  State<UserTypeChooser> createState() => _UserTypeChooserState();
}

enum UserType { trainer, trainee }

class _UserTypeChooserState extends State<UserTypeChooser> {
  UserType userType = UserType.trainee;
  final List<Color> colors = [
    ColorConstants.primaryColor,
    ColorConstants.primaryColorDark
  ];
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => setState(() => userType = UserType.trainer),
          child: Container(
            margin: widget.margin,
            constraints: BoxConstraints(
              maxWidth: widget.maxWidth,
              maxHeight: widget.maxHeight,
              minWidth: widget.width,
              minHeight: widget.height,
            ),
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
                color: userType == UserType.trainer ? colors[1] : colors[0],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                )),
            child: Center(child: QMText(text: S.of(context).Trainer)),
          ),
        ),
        GestureDetector(
          onTap: () => setState(() => userType = UserType.trainee),
          child: Container(
            margin: widget.margin,
            constraints: BoxConstraints(
              maxWidth: widget.maxWidth,
              maxHeight: widget.maxHeight,
              minWidth: widget.width,
              minHeight: widget.height,
            ),
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
                color: userType == UserType.trainee ? colors[1] : colors[0],
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                )),
            child: Center(child: QMText(text: S.of(context).Trainee)),
          ),
        ),
      ],
      // onPressed: (int index) {
      //   setState(() {
      //     isSelected[index] = !isSelected[index];
      //     colors[index] = colors[index] == ColorConstants.primaryColor
      //         ? ColorConstants.primaryColorDark
      //         : ColorConstants.primaryColor;
      //   });
      // },
    );
  }
}
