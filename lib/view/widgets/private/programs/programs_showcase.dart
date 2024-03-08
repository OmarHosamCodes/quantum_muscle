import 'package:quantum_muscle/library.dart';

/// A widget that displays a showcase of programs.
class ProgramsShowcase extends StatelessWidget {
  /// Constructs a [ProgramsShowcase] widget.
  ///
  /// The [width] and [height] parameters specify the dimensions of the widget.
  /// The [programs] parameter is a list of [ProgramModel] objects to be displayed.
  /// The [isTrainee] parameter indicates whether the user is a trainee or not.
  /// The [key] parameter is an optional key to uniquely identify the widget.
  const ProgramsShowcase({
    required this.width,
    required this.height,
    required this.programs,
    required this.isTrainee,
    super.key,
  });

  /// The width of the widget.
  final double width;

  /// The height of the widget.
  final double height;

  /// The list of programs to display.
  final List<ProgramModel> programs;

  /// A flag indicating whether the user is a trainee or not.
  final bool isTrainee;

  @override
  Widget build(BuildContext context) {
    final itemCount = isTrainee ? programs.length : programs.length + 1;
    final scrollController = ScrollController();
    return Scrollbar(
      controller: scrollController,
      child: ResponsiveGridView.builder(
        controller: scrollController,
        gridDelegate: const ResponsiveGridDelegate(
          crossAxisSpacing: 10,
          crossAxisExtent: 200,
          mainAxisSpacing: 10,
          maxCrossAxisExtent: 200,
          minCrossAxisExtent: 100,
        ),
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          if (index == programs.length) {
            return AddProgramBlock(
              width: width,
              height: height,
              programs: programs,
            );
          }
          return ProgramBlock(
            width: width,
            height: height,
            program: programs[index],
            isTrainee: isTrainee,
          );
        },
      ),
    );
  }
}
