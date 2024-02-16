// ignore_for_file: lines_longer_than_80_chars

import 'package:quantum_muscle/library.dart';

class ProgramBlock extends ConsumerStatefulWidget {
  const ProgramBlock({
    required this.width,
    required this.height,
    required this.program,
    required this.programs,
    required this.isTrainee,
    super.key,
  });

  final double width;
  final double height;
  final ProgramModel program;
  final List<ProgramModel> programs;
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
          for (final element in widget.programs) {
            element.isHovered = false;
          }
          widget.program.isHovered = !widget.program.isHovered;
        },
      ),
      child: MouseRegion(
        onEnter: (_) => setState(() => widget.program.isHovered = true),
        onExit: (_) => setState(() => widget.program.isHovered = false),
        child: DragTarget<WorkoutModel>(
          onAccept: (workout) {
            programUtil.addWorkoutToProgram(
              context: context,
              programId: widget.program.id,
              workout: workout,
              ref: ref,
            );
          },
          builder: (context, candidateData, rejectedData) {
            return QmBlock(
              color: widget.program.isHovered
                  ? ColorConstants.primaryColor
                  : ColorConstants.secondaryColor,
              isAnimated: true,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: widget.program.isHovered
                    ? ColorConstants.secondaryColor
                    : ColorConstants.primaryColor,
                width: 1.5,
              ),
              boxShadow: widget.program.isHovered
                  ? List.generate(
                      widget.program.workouts.length,
                      (index) => BoxShadow(
                        color:
                            Colors.primaries[index % Colors.primaries.length],
                        offset: index > 3
                            ? const Offset(0, 16)
                            : Offset(0, 4 * (index + 1)),
                      ),
                    )
                  : null,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: QmText(
                      text: widget.program.name,
                    ),
                  ),
                  Align(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        QmText(
                          text:
                              '${S.current.Workouts}${widget.program.workouts.length}',
                        ),
                        QmText(
                          text:
                              '${S.current.Trainees}${widget.program.traineesIds.length}',
                        ),
                      ],
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
                            'isTrainee': widget.isTrainee,
                          },
                        ),
                        iconSize: 25,
                        icon: EvaIcons.arrowIosUpward,
                      ),
                    ),
                  ),
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
