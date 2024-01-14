import '/library.dart';

class ProgramsShowcase extends StatefulWidget {
  const ProgramsShowcase({
    super.key,
    required this.width,
    required this.height,
    required this.programs,
  });

  final double width;
  final double height;
  final List<ProgramModel> programs;

  @override
  State<ProgramsShowcase> createState() => _ProgramsShowcaseState();
}

class _ProgramsShowcaseState extends State<ProgramsShowcase> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.programs.length + 1,
      padding: EdgeInsets.symmetric(
        horizontal: widget.width * .055,
        vertical: widget.height * .05,
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
              topRight: blockRadius(condition: index == widget.programs.length),
              bottomRight:
                  blockRadius(condition: index == widget.programs.length),
            );
          }
          return BorderRadius.only(
            topLeft: blockRadius(condition: index == widget.programs.length),
            bottomLeft: blockRadius(condition: index == widget.programs.length),
            topRight: blockRadius(condition: index == 0),
            bottomRight: blockRadius(condition: index == 0),
          );
        }

        if (index == widget.programs.length) {
          return AddProgramBlock(
            width: widget.width,
            height: widget.height,
            programs: widget.programs,
            borderRadius: borderRadius(),
          );
        }
        return ProgramBlock(
          width: widget.width,
          height: widget.height,
          program: widget.programs[index],
          programs: widget.programs,
          borderRadius: borderRadius(),
        );
      },
    );
  }
}
