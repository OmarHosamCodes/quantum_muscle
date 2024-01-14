import '/library.dart';

class AddProgramBlock extends StatefulWidget {
  const AddProgramBlock({
    super.key,
    required this.width,
    required this.height,
    required this.programs,
    required this.borderRadius,
  });

  final double width;
  final double height;
  final List<ProgramModel> programs;
  final BorderRadius borderRadius;

  @override
  State<AddProgramBlock> createState() => _AddProgramBlockState();
}

class _AddProgramBlockState extends State<AddProgramBlock> {
  bool isHovered = false;
  final programNameTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(
        () {
          for (var element in widget.programs) {
            element.isHovered = false;
          }
          isHovered = !isHovered;
        },
      ),
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: QmBlock(
          color: isHovered
              ? ColorConstants.primaryColor
              : ColorConstants.secondaryColor,
          isAnimated: true,
          borderRadius: widget.borderRadius,
          border: Border.all(
            color: isHovered
                ? ColorConstants.secondaryColor
                : ColorConstants.primaryColor,
            width: 1.5,
          ),
          width: isHovered
              ? (widget.width / (widget.programs.length + 2))
              : (widget.width / (widget.programs.length + 4)),
          height: widget.height * .4,
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
                alignment: Alignment.center,
                child: AnimatedOpacity(
                  opacity: isHovered ? 1.0 : 0.0,
                  duration: SimpleConstants.fastAnimationDuration,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      QmTextField(
                        width: widget.width * .2,
                        height: widget.height * .1,
                        hintText: S.current.AddProgramName,
                        controller: programNameTextController,
                      ),
                      const SizedBox(height: 10),
                      Consumer(
                        builder: (context, ref, _) {
                          return QmBlock(
                            onTap: () => ProgramsUtil().addProgram(
                              context: context,
                              programName: programNameTextController.text,
                              ref: ref,
                            ),
                            width: widget.width * .2,
                            height: widget.height * .1,
                            color: ColorConstants.secondaryColor,
                            child: Center(
                              child: FittedBox(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: QmText(
                                    text: S.current.AddProgram,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
