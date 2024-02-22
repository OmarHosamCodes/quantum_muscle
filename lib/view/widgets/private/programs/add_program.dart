import 'package:quantum_muscle/library.dart';

class AddProgramBlock extends ConsumerWidget {
  const AddProgramBlock({
    required this.width,
    required this.height,
    required this.programs,
    super.key,
  });

  final double width;
  final double height;
  final List<ProgramModel> programs;

  static final formKey = GlobalKey<FormState>();
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
                    child: QmButton.icon(
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
                          return QmBlock(
                            onTap: () async {
                              await programUtil.addProgram(
                                context: context,
                                programName: programNameTextController.text,
                                programsLength: programs.length,
                                formKey: formKey,
                              );
                            },
                            color: ColorConstants.accentColor,
                            child: Center(
                              child: FittedBox(
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: QmText(
                                    text: S.current.Add,
                                  ),
                                ),
                              ),
                            ),
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

final hoveredProvider = StateProvider<bool>((ref) => false);
