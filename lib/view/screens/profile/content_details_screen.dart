import 'package:expandable/expandable.dart';

import 'package:quantum_muscle/library.dart';

class ContentDetailsScreen extends StatelessWidget {
  const ContentDetailsScreen({super.key, this.arguments});
  final Map<String, dynamic>? arguments;
  @override
  Widget build(BuildContext context) {
    final contents = arguments![ContentModel.modelKey] as List<ContentModel>;
    final startIndex = arguments!['indexKey'] as int;
    final userID = arguments![UserModel.idKey] as String;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final controller =
        ScrollController(initialScrollOffset: height * startIndex);
    bool isDesktop() => !ResponsiveBreakpoints.of(context).smallerThan(DESKTOP);

    bool isTablet() => !ResponsiveBreakpoints.of(context).smallerThan(TABLET);
    EdgeInsets getResponsiveMargin() {
      if (isDesktop()) {
        return EdgeInsets.symmetric(
          horizontal: width * .25,
          vertical: 10,
        );
      } else if (isTablet()) {
        return EdgeInsets.symmetric(
          horizontal: width * .15,
          vertical: 10,
        );
      } else {
        return const EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 10,
        );
      }
    }

    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            EvaIcons.arrowBackOutline,
            color: ColorConstants.iconColor,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        controller: controller,
        itemCount: contents.length,
        itemBuilder: (_, index) {
          final content = contents[index];
          final transformationController = TransformationController();
          return QmBlock(
            isAnimated: true,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            padding: const EdgeInsets.all(10),
            margin: getResponsiveMargin(),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    height: height * 0.5,
                    child: InteractiveViewer(
                      transformationController: transformationController,
                      minScale: .1,
                      maxScale: 3,
                      panEnabled: false,
                      scaleEnabled: !kIsWeb,
                      child: Hero(
                        tag: content.id,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          child: QmImage.network(
                            source: content.contentURL,
                            fit: BoxFit.cover,
                            width: double.maxFinite,
                            height: double.maxFinite,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Consumer(
                      builder: (_, WidgetRef ref, __) {
                        final contentWatcher =
                            ref.watch(contentProvider(userID));
                        return contentWatcher.when(
                          data: (watcherContents) {
                            final watcherContent = watcherContents[index];
                            return QmButton.icon(
                              icon: watcherContent.likes.contains(userID)
                                  ? EvaIcons.heart
                                  : EvaIcons.heartOutline,
                              onPressed: () => profileUtil.likeOrDislikeContent(
                                context: context,
                                ref: ref,
                                isLiked: watcherContent.likes.contains(userID),
                                userId: userID,
                                contentDocID: watcherContent.id,
                              ),
                              iconColor: watcherContent.likes.contains(userID)
                                  ? ColorConstants.likeColor
                                  : ColorConstants.iconColor,
                            );
                          },
                          loading: () => QmShimmer.rectangle(
                            width: 20,
                            height: 20,
                            radius: 10,
                          ),
                          error: (error, stack) => QmButton.icon(
                            icon: EvaIcons.heart,
                            iconColor: ColorConstants.disabledColor,
                          ),
                        );
                      },
                    ),

                    // QmButton.icon(
                    //   icon: EvaIcons.shareOutline,
                    //   onPressed: () {},
                    // ),
                  ],
                ),
                QmBlock(
                  color: ColorConstants.disabledColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  child: ExpandablePanel(
                    header: Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      child: QmSimpleText(
                        text: content.title,
                      ),
                    ),
                    collapsed: QmSimpleText(
                      text: content.description,
                      overFlow: TextOverflow.ellipsis,
                      isSeccoundary: true,
                    ),
                    expanded: QmSimpleText(
                      text: content.description,
                    ),
                    builder: (_, collapsed, expanded) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                          bottom: 10,
                        ),
                        child: Expandable(
                          collapsed: collapsed,
                          expanded: expanded,
                        ),
                      );
                    },
                    theme: const ExpandableThemeData(
                      iconColor: ColorConstants.iconColor,
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToCollapse: true,
                      hasIcon: true,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
