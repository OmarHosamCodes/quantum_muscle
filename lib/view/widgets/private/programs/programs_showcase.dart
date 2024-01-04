import '/library.dart';

class ProgramsShowcase extends StatefulWidget {
  const ProgramsShowcase({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  State<ProgramsShowcase> createState() => _ProgramsShowcaseState();
}

class _ProgramsShowcaseState extends State<ProgramsShowcase> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: ProgramShowcaseBlockModel.programShowcaseList.map(
          (model) {
            Radius blockRadius(bool condition) {
              return condition
                  ? const Radius.circular(10)
                  : const Radius.circular(0);
            }

            return GestureDetector(
              onTap: () => setState(
                () {
                  for (var element
                      in ProgramShowcaseBlockModel.programShowcaseList) {
                    element.isHovered = false;
                  }
                  model.isHovered = !model.isHovered;
                },
              ),
              child: MouseRegion(
                onEnter: (_) => setState(() => model.isHovered = true),
                onExit: (_) => setState(() => model.isHovered = false),
                child: DragTarget<Map<String, dynamic>>(
                  onAccept: (data) {
                    model.imgUrl = data[WorkoutModel.imgUrlKey];
                  },
                  builder: (context, candidateData, rejectedData) {
                    return QmBlock(
                      color: model.isHovered
                          ? ColorConstants.primaryColor
                          : ColorConstants.disabledColor,
                      isAnimated: true,
                      borderRadius: BorderRadius.only(
                        topLeft: blockRadius(model ==
                            ProgramShowcaseBlockModel
                                .programShowcaseList.first),
                        bottomLeft: blockRadius(model ==
                            ProgramShowcaseBlockModel
                                .programShowcaseList.first),
                        topRight: blockRadius(model ==
                            ProgramShowcaseBlockModel.programShowcaseList.last),
                        bottomRight: blockRadius(model ==
                            ProgramShowcaseBlockModel.programShowcaseList.last),
                      ),
                      width: model.isHovered
                          ? (widget.width /
                              ProgramShowcaseBlockModel
                                  .programShowcaseList.length *
                              2)
                          : (widget.width /
                              (ProgramShowcaseBlockModel
                                      .programShowcaseList.length *
                                  1.5)),
                      height: widget.height * .3,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: AnimatedRotation(
                                duration: SimpleConstants.fastAnimationDuration,
                                turns: model.isHovered ? 0 : 0.25,
                                child: QmText(
                                  text: S.current.Programs,
                                  maxWidth: widget.height * .4,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: AnimatedOpacity(
                              opacity: model.isHovered ? 1.0 : 0.0,
                              duration: SimpleConstants.fastAnimationDuration,
                              child: Image(
                                image: CachedNetworkImageProvider(model.imgUrl),
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.error);
                                },
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return const QmCircularProgressIndicator();
                                },
                              ),
                            ),
                          )
                          // Align(
                          //   alignment: Alignment.center,
                          //   child: AnimatedOpacity(
                          //     opacity: model.isHovered ? 1.0 : 0.0,
                          //     duration: SimpleConstants.fastAnimationDuration,
                          //     child: QmText(text: model.description!),
                          //   ),
                          // ),
                        ],
                      ),
                    )
                        // .animate().saturate(
                        //       begin: model.isHovered ? 0.0 : 1.0,
                        //       end: model.isHovered ? 1.0 : 0.0,
                        //       curve: Curves.easeInCubic,
                        //       duration: SimpleConstants.fastAnimationDuration,
                        //     )
                        ;
                  },
                  onWillAccept: (data) {
                    return true;
                  },
                ),
              ),
            );
          },
        ).toList());
  }
}
