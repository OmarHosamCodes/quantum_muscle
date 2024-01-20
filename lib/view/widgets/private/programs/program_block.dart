import '/library.dart';

class ProgramBlock extends ConsumerStatefulWidget {
  const ProgramBlock({
    super.key,
    required this.width,
    required this.height,
    required this.program,
    required this.programs,
    required this.borderRadius,
    required this.isTrainee,
  });

  final double width;
  final double height;
  final ProgramModel program;
  final List<ProgramModel> programs;
  final BorderRadius borderRadius;
  final bool isTrainee;

  @override
  ConsumerState<ProgramBlock> createState() => _ProgramBlockState();
}

class _ProgramBlockState extends ConsumerState<ProgramBlock> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(
        () {
          for (var element in widget.programs) {
            element.isHovered = false;
          }
          widget.program.isHovered = !widget.program.isHovered;
        },
      ),
      child: MouseRegion(
        onEnter: (_) => setState(() => widget.program.isHovered = true),
        onExit: (_) => setState(() => widget.program.isHovered = false),
        child: DragTarget<WorkoutModel>(
          onAccept: (data) => ProgramsUtil().addWorkoutToProgram(
            context: context,
            programId: widget.program.id,
            data: data,
            ref: ref,
          ),
          builder: (context, candidateData, rejectedData) {
            return QmBlock(
              color: widget.program.isHovered
                  ? ColorConstants.primaryColor
                  : ColorConstants.secondaryColor,
              isAnimated: true,
              borderRadius: widget.borderRadius,
              border: Border.all(
                color: widget.program.isHovered
                    ? ColorConstants.secondaryColor
                    : ColorConstants.primaryColor,
                width: 1.5,
              ),
              width: widget.program.isHovered
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
                        turns: widget.program.isHovered ? 0 : 0.25,
                        child: QmText(
                          text: widget.program.name,
                          maxWidth: widget.height * .4,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: AnimatedOpacity(
                      opacity: widget.program.isHovered ? 1.0 : 0.0,
                      duration: SimpleConstants.fastAnimationDuration,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          QmText(
                              text:
                                  "${S.current.Workouts}${(widget.program.workouts).length.toString()}"),
                          QmText(
                              text:
                                  "${S.current.Trainees}${(widget.program.traineesIds).length.toString()}"),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: AnimatedOpacity(
                      opacity: widget.program.isHovered ? 1.0 : 0.0,
                      duration: SimpleConstants.fastAnimationDuration,
                      child: QmIconButton(
                        onPressed: () => context.pushNamed(
                          Routes.programRootR,
                          extra: {
                            ProgramModel.modelKey: widget.program,
                            "isTrainee": widget.isTrainee,
                          },
                        ),
                        iconSize: 25.0,
                        icon: EvaIcons.arrowIosUpward,
                      ),
                    ),
                  )
                ],
              ),
            );
          },
          onWillAccept: (data) {
            return true;
          },
        ),
      ),
    );
  }
}
