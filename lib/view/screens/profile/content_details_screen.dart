import 'package:expandable/expandable.dart';

import '/library.dart';

class ContentDetailsScreen extends StatelessWidget {
  const ContentDetailsScreen({super.key, this.arguments});
  final Map<String, dynamic>? arguments;
  @override
  Widget build(BuildContext context) {
    final contents = arguments![ContentModel.modelKey] as List<ContentModel>;
    final startIndex = arguments!["indexKey"] as int;
    final userID = arguments![UserModel.idKey] as String;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    ScrollController controller =
        ScrollController(initialScrollOffset: height * startIndex);

    TransformationController transformationController =
        TransformationController();
    bool isDesktop() {
      if (ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)) return false;
      return true;
    }

    bool isTablet() {
      if (ResponsiveBreakpoints.of(context).smallerThan(TABLET)) return false;
      return true;
    }

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
          return QmBlock(
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
                      scaleEnabled: false,
                      child: Hero(
                        tag: content.id,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          child: QmImageNetwork(
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Consumer(
                      builder: (_, WidgetRef ref, __) {
                        final contentWatcher =
                            ref.watch(contentProvider(userID));
                        return contentWatcher.when(
                          data: (watcherContents) {
                            var watcherContent = watcherContents[index];
                            return QmIconButton(
                              icon: watcherContent.likes.contains(userID)
                                  ? EvaIcons.heart
                                  : EvaIcons.heartOutline,
                              onPressed: () =>
                                  ProfileUtil().likeOrDislikeContent(
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
                          loading: () => const QmCircularProgressIndicator(),
                          error: (error, stack) => const QmIconButton(
                            icon: EvaIcons.heart,
                            iconColor: ColorConstants.disabledColor,
                          ),
                        );
                      },
                    ),

                    // QmIconButton(
                    //   icon: EvaIcons.shareOutline,
                    //   onPressed: () {},
                    // ),
                  ],
                ),
                QmBlock(
                  color: ColorConstants.disabledColorWithOpacity,
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
                      child: QmText(
                        text: content.title,
                      ),
                    ),
                    collapsed: QmText(
                      text: content.description,
                      softWrap: true,
                      isSeccoundary: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                    expanded: QmText(
                      text: content.description,
                      softWrap: true,
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
