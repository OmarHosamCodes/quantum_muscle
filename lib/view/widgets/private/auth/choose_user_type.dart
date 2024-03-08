import 'package:quantum_muscle/library.dart';

/// A widget that allows the user to choose a user type.
///
/// This widget is a consumer widget, which means it rebuilds when the specified
/// dependencies change. It provides a customizable user type chooser with
/// options for width, height, maximum width, maximum height, and margin.
class UserTypeChooser extends ConsumerWidget {
  /// Creates a [UserTypeChooser].
  ///
  /// The [width] and [height] parameters specify the dimensions of the widget.
  /// The [maxWidth] and [maxHeight] parameters specify the maximum dimensions
  /// the widget can have. The [margin] parameter specifies the empty space
  /// around the widget.
  const UserTypeChooser({
    super.key,
    this.width = 100,
    this.height = 100,
    this.maxWidth = 100,
    this.maxHeight = 100,
    this.margin = EdgeInsets.zero,
  });

  /// The width of the widget.
  final double width;

  /// The height of the widget.
  final double height;

  /// The maximum width of the widget.
  final double maxWidth;

  /// The maximum height of the widget.
  final double maxHeight;

  /// The margin around the widget.
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userType = ref.watch(userTypeProvider);
    final colors = <Color>[
      ColorConstants.primaryColor,
      ColorConstants.accentColor,
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
