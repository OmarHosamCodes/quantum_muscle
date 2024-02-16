import 'package:quantum_muscle/library.dart';

class UserTypeChooser extends ConsumerWidget {
  const UserTypeChooser({
    super.key,
    this.width = 100,
    this.height = 100,
    this.maxWidth = 100,
    this.maxHeight = 100,
    this.margin = EdgeInsets.zero,
  });
  final double width;
  final double height;
  final double maxWidth;
  final double maxHeight;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userType = ref.watch(userTypeProvider);
    final colors = <Color>[
      ColorConstants.disabledColor,
      ColorConstants.primaryColor,
    ];
    //TODO make it responsive

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () =>
              ref.read(userTypeProvider.notifier).state = UserType.trainer,
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
                topLeft:
                    utils.isEnglish ? const Radius.circular(10) : Radius.zero,
                bottomLeft:
                    utils.isEnglish ? const Radius.circular(10) : Radius.zero,
                topRight:
                    utils.isEnglish ? Radius.zero : const Radius.circular(10),
                bottomRight:
                    utils.isEnglish ? Radius.zero : const Radius.circular(10),
              ),
            ),
            child: Center(child: QmText(text: S.current.Trainer)),
          ),
        ),
        GestureDetector(
          onTap: () =>
              ref.read(userTypeProvider.notifier).state = UserType.trainee,
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
                topLeft:
                    utils.isEnglish ? Radius.zero : const Radius.circular(10),
                bottomLeft:
                    utils.isEnglish ? Radius.zero : const Radius.circular(10),
                topRight:
                    utils.isEnglish ? const Radius.circular(10) : Radius.zero,
                bottomRight:
                    utils.isEnglish ? const Radius.circular(10) : Radius.zero,
              ),
            ),
            child: Center(child: QmText(text: S.current.Trainee)),
          ),
        ),
      ],
    );
  }
}
