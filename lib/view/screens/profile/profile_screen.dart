import 'package:flutter_animate/flutter_animate.dart';
import 'package:quantum_muscle/view/widgets/qm_avatar.dart';

import '../../../library.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
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
        title: QMText(text: S.of(context).Profile),
      ),
      drawer: isDesktop() ? null : const RoutingDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                QmAvatar(
                  'https://picsum.photos/250?image=9',
                ),
                Column(
                  children: [
                    QMText(text: '1150'),
                    QMText(
                      text: 'folowers',
                      isSeccoundary: true,
                    ),
                  ],
                ),
                Column(
                  children: [
                    QMText(text: '1150'),
                    QMText(
                      text: 'folowing',
                      isSeccoundary: true,
                    ),
                  ],
                ),
                Column(
                  children: [
                    QMText(text: '1150'),
                    QMText(
                      text: 'likes',
                      isSeccoundary: true,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: height * .05,
            ),
            GridView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: width * .05,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isDesktop() ? 4 : 3,
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
                childAspectRatio: 1,
              ),
              itemCount: 100,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  color: ColorConstants.primaryColor,
                  child: const Center(),
                ).animate().fade();
              },
            ),
          ],
        ),
      ),
    );
  }
}
