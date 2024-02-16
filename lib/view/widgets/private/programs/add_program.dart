import 'package:quantum_muscle/library.dart';

class AddProgramBlock extends StatefulWidget {
  const AddProgramBlock({
    required this.width,
    required this.height,
    required this.programs,
    super.key,
  });

  final double width;
  final double height;
  final List<ProgramModel> programs;

  @override
  State<AddProgramBlock> createState() => _AddProgramBlockState();
}

class _AddProgramBlockState extends State<AddProgramBlock> {
  bool isHovered = false;
  static final programNameTextController = TextEditingController();
  static final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(
        () {
          for (final element in widget.programs) {
            element.isHovered = false;
          }
          isHovered = !isHovered;
        },
      ),
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: QmBlock(
          padding: const EdgeInsets.all(10),
          color: isHovered
              ? ColorConstants.primaryColor
              : ColorConstants.secondaryColor,
          isAnimated: true,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isHovered
                ? ColorConstants.secondaryColor
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
                    child: const QmIconButton(
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
                        child: Consumer(
                          builder: (_, WidgetRef ref, __) {
                            return QmTextField(
                              textInputAction: TextInputAction.go,
                              hintText: S.current.AddProgramName,
                              controller: programNameTextController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return S.current.EnterValidName;
                                }
                                return null;
                              },
                              onEditingComplete: () => programUtil.addProgram(
                                context: context,
                                programName: programNameTextController.text,
                                ref: ref,
                                programsLength: widget.programs.length,
                                formKey: formKey,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Consumer(
                        builder: (_, ref, __) {
                          return QmBlock(
                            onTap: () {
                              programUtil.addProgram(
                                context: context,
                                programName: programNameTextController.text,
                                ref: ref,
                                programsLength: widget.programs.length,
                                formKey: formKey,
                              );
                            },
                            color: ColorConstants.secondaryColor,
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
