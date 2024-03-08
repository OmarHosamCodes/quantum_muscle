import 'package:quantum_muscle/library.dart';

/// A widget that represents a block for adding a program.
class AddProgramBlock extends ConsumerWidget {
  /// Creates a [AddProgramBlock] widget.
  ///
  /// The [width] and [height] parameters are required to specify the dimensions of the block.
  /// The [programs] parameter is a list of [ProgramModel] objects.
  /// The [key] parameter is an optional key to uniquely identify the widget.
  const AddProgramBlock({
    required this.width,
    required this.height,
    required this.programs,
    super.key,
  });

  /// The width of the block.
  final double width;

  /// The height of the block.
  final double height;

  /// A list of programs.
  final List<ProgramModel> programs;

  /// A global key used to identify the form state.
  static final formKey = GlobalKey<FormState>();

  /// A text controller for the program name input field.
  static final programNameTextController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isHovered = ref.watch(hoveredProvider);

    return GestureDetector(
      onTap: () {
        for (final element in programs) {
          element.isHovered = false;
        }
        ref.read(hoveredProvider.notifier).state = !isHovered;
      },
      child: MouseRegion(
        onEnter: (_) => ref.read(hoveredProvider.notifier).state = true,
        onExit: (_) => ref.read(hoveredProvider.notifier).state = false,
        child: QmBlock(
          padding: const EdgeInsets.all(10),
          color: isHovered
              ? ColorConstants.primaryColor
              : ColorConstants.accentColor,
          isAnimated: true,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isHovered
                ? ColorConstants.accentColor
                : ColorConstants.primaryColor,
            width: 1.5,
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: AnimatedRotation(
                    duration: SimpleConstants.fastAnimationDuration,
                    turns: isHovered ? 0 : 0.25,
                    child: const QmButton.icon(
                      icon: EvaIcons.plus,
                    ),
                  ),
                ),
              ),
              Align(
                child: Visibility(
                  visible: isHovered,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Form(
                        key: formKey,
                        child: QmTextField(
                          textInputAction: TextInputAction.go,
                          hintText: S.current.Name,
                          controller: programNameTextController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return S.current.EnterValidName;
                            }
                            return null;
                          },
                          onEditingComplete: () async {
                            await programUtil.addProgram(
                              context: context,
                              programName: programNameTextController.text,
                              programsLength: programs.length,
                              formKey: formKey,
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Consumer(
                        builder: (_, ref, __) {
                          return QmButton.text(
                            onPressed: () async {
                              await programUtil.addProgram(
                                context: context,
                                programName: programNameTextController.text,
                                programsLength: programs.length,
                                formKey: formKey,
                              );
                            },
                            text: S.current.Add,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Provider for hovered state
final hoveredProvider = StateProvider<bool>((ref) => false);
