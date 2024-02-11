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
                    Utils().isEnglish ? const Radius.circular(10) : Radius.zero,
                bottomLeft:
                    Utils().isEnglish ? const Radius.circular(10) : Radius.zero,
                topRight:
                    Utils().isEnglish ? Radius.zero : const Radius.circular(10),
                bottomRight:
                    Utils().isEnglish ? Radius.zero : const Radius.circular(10),
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
                    Utils().isEnglish ? Radius.zero : const Radius.circular(10),
                bottomLeft:
                    Utils().isEnglish ? Radius.zero : const Radius.circular(10),
                topRight:
                    Utils().isEnglish ? const Radius.circular(10) : Radius.zero,
                bottomRight:
                    Utils().isEnglish ? const Radius.circular(10) : Radius.zero,
              ),
            ),
            child: Center(child: QmText(text: S.current.Trainee)),
          ),
        ),
      ],
    );
  }
}
