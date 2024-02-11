import 'package:quantum_muscle/library.dart';

class ProgramsShowcase extends StatelessWidget {
  const ProgramsShowcase({
    required this.width,
    required this.height,
    required this.programs,
    required this.isTrainee,
    super.key,
  });

  final double width;
  final double height;
  final List<ProgramModel> programs;
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
        padding: EdgeInsets.symmetric(
          horizontal: width * .05,
        ),
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
            programs: programs,
            isTrainee: isTrainee,
          );
        },
      ),
    );
  }
}
