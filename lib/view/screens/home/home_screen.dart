import 'package:flutter_animate/flutter_animate.dart';

import '../../../library.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final searchBarTextController = TextEditingController();
    bool isDesktop() {
      if (ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)) return false;
      return true;
    }

    bool isTablet() {
      if (ResponsiveBreakpoints.of(context).smallerThan(TABLET)) return false;
      return true;
    }

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: QMText(
          text: S.of(context).Home,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(EvaIcons.bellOutline),
          )
        ],
      ),
      drawer: isDesktop() ? null : const RoutingDrawer(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: height * .001,
                  horizontal: width * .05,
                ),
                child: Row(
                  children: [
                    QMText(
                      text: "${S.of(context).Hi}, Name",
                      maxWidth: width,
                    ).animate().fadeIn(
                          duration: const Duration(
                            milliseconds: 300,
                          ),
                        ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * .045,
                  vertical: height * .025,
                ),
                child: HomeSearchBar(
                  controller: searchBarTextController,
                ).animate().shimmer(
                      duration: const Duration(
                        seconds: 3,
                      ),
                    ),
              ),
              Container(
                height: height * .2,
                width: isDesktop() ? width * .6 : width * .9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: ColorConstants.primaryColor,
                    width: 3,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    QMText(
                      text: S.of(context).Slogan,
                    ),
                    Image.asset(
                      AssetPathConstants.mainVectorImgPath,
                      height: height * .2,
                      width: width * .4,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * .05,
                  vertical: height * .025,
                ),
                child: Row(
                  children: [
                    QMText(text: S.of(context).Workouts),
                  ],
                ),
              ),
              GridView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: width * .05,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isDesktop()
                      ? 5
                      : isTablet()
                          ? 3
                          : 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 2,
                ),
                itemCount: 100,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return const QmBlock(
                    height: 0,
                    width: 0,
                    child: Center(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
