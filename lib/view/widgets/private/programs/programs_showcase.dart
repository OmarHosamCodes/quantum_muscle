import '/library.dart';

class ProgramsShowcase extends StatelessWidget {
  const ProgramsShowcase({
    super.key,
    required this.width,
    required this.height,
    required this.programs,
    required this.isTrainee,
  });

  final double width;
  final double height;
  final List<ProgramModel> programs;
  final bool isTrainee;

  @override
  Widget build(BuildContext context) {
    int itemCount = isTrainee ? programs.length : programs.length + 1;
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: itemCount,
      padding: EdgeInsets.symmetric(
        horizontal: width * .055,
        vertical: height * .05,
      ),
      itemBuilder: (context, index) {
        Radius blockRadius({required bool condition}) {
          if (Utils().isEnglish) {
            return Radius.circular(
              condition ? 10 : 0,
            );
          }
          return Radius.circular(
            condition ? 10 : 0,
          );
        }

        BorderRadius borderRadius() {
          if (Utils().isEnglish) {
            return BorderRadius.only(
              topLeft: blockRadius(condition: index == 0),
              bottomLeft: blockRadius(condition: index == 0),
              topRight: blockRadius(condition: index == programs.length),
              bottomRight: blockRadius(condition: index == programs.length),
            );
          }
          return BorderRadius.only(
            topLeft: blockRadius(condition: index == programs.length),
            bottomLeft: blockRadius(condition: index == programs.length),
            topRight: blockRadius(condition: index == 0),
            bottomRight: blockRadius(condition: index == 0),
          );
        }

        if (index == programs.length) {
          return AddProgramBlock(
            width: width,
            height: height,
            programs: programs,
            borderRadius: borderRadius(),
          );
        }
        return ProgramBlock(
          width: width,
          height: height,
          program: programs[index],
          programs: programs,
          borderRadius: borderRadius(),
          isTrainee: isTrainee,
        );
      },
    );
  }
}
