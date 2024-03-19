// ignore_for_file: lines_longer_than_80_chars

import 'package:quantum_muscle/library.dart';

/// A widget that represents a program block.
///
/// This widget is used to display a program block with a specified width and height.
/// It requires a [ProgramModel] object to define the program details and a boolean
/// value to indicate whether the user is a trainee or not.
class ProgramBlock extends ConsumerStatefulWidget {
  /// Creates a [ProgramBlock] widget.
  ///
  /// The [width] and [height] parameters define the dimensions of the program block.
  /// The [program] parameter is a required [ProgramModel] object that contains the
  /// details of the program.
  /// The [isTrainee] parameter is a boolean value that indicates whether the user
  /// is a trainee or not.
  const ProgramBlock({
    required this.width,
    required this.height,
    required this.program,
    required this.isTrainee,
    super.key,
  });

  /// The width of the program block.
  final double width;

  /// The height of the program block
  final double height;

  /// The program to display
  final ProgramModel program;

  /// The is trianee flag
  final bool isTrainee;

  @override
  ConsumerState<ProgramBlock> createState() => _ProgramBlockState();
}

class _ProgramBlockState extends ConsumerState<ProgramBlock> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleHover,
      child: MouseRegion(
        onEnter: (_) => _setHover(true),
        onExit: (_) => _setHover(false),
        child: DragTarget<WorkoutModel>(
          onAcceptWithDetails: (workout) {
            programUtil.addWorkoutToProgram(
              programId: widget.program.id,
              workout: workout.data,
              ref: ref,
            );
          },
          builder: (context, candidateData, rejectedData) =>
              _buildProgramBlock(),
          onWillAcceptWithDetails: (data) => true,
        ),
      ),
    );
  }

  void _toggleHover() =>
      setState(() => widget.program.isHovered = !widget.program.isHovered);

  void _setHover(bool value) =>
      setState(() => widget.program.isHovered = value);

  Widget _buildProgramBlock() {
    return QmBlock(
      color: widget.program.isHovered
          ? ColorConstants.primaryColor
          : ColorConstants.accentColor,
      borderRadius: BorderRadius.circular(10),
      isAnimated: true,
      border: Border.all(
        color: widget.program.isHovered
            ? ColorConstants.accentColor
            : ColorConstants.primaryColor,
        width: 1.5,
      ),
      boxShadow: widget.program.isHovered
          ? [
              for (var i = 0; i < widget.program.workouts.length; i++)
                BoxShadow(
                  color: Colors.primaries[i % Colors.primaries.length],
                  offset: i > 3 ? const Offset(0, 16) : Offset(0, 4 * (i + 1)),
                ),
            ]
          : null,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: QmText(text: widget.program.name),
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
              child: QmButton.icon(
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
  }
}
