import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mm_notes/controllers/landing_screen_controller.dart';
import 'package:mm_notes/screens/search_screen/search_screen.dart';

class TopSearchCard extends StatelessWidget with PreferredSizeWidget {
  TopSearchCard({Key? key}) : super(key: key);

  final LandingScreenController lsc = Get.put(LandingScreenController());

  @override
  Widget build(BuildContext context) {
    const _padding = 8.0;
    const _splashRadius = _padding * 2.5;
    final _topPadding = Get.mediaQuery.padding.top;
    final _transitionColor = Get.theme.cardColor;

    return Container(
      margin: EdgeInsets.only(top: _topPadding),
      padding: const EdgeInsets.symmetric(horizontal: _padding),
      child: OpenContainer(
        closedColor: Colors.transparent,
        openColor: _transitionColor,
        closedElevation: 0,
        openElevation: 0,
        openBuilder: (_, __) => SearchScreen(),
        closedBuilder: (_, openWidget) => Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(_padding * 4)),
            color: Get.theme.secondaryHeaderColor,
            child: InkWell(
              customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(_padding * 4)),
              onTap: () {
                openWidget();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 4,
                      ),
                      IconButton(
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        icon: const Icon(Icons.menu),
                        splashRadius: _splashRadius,
                      ),
                      Text("Search your notes", style: Get.textTheme.subtitle1),
                    ],
                  ),
                  // Circular profile button
                  Row(
                    children: [
                      Obx(
                        () => IconButton(
                          onPressed: () {
                            lsc.toggleGridMode();
                          },
                          icon: lsc.gridModeIcon.value,
                          splashRadius: _splashRadius,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: _padding),
                        child: Card(
                          elevation: 0,
                          shape: const CircleBorder(),
                          child: InkWell(
                            customBorder: const CircleBorder(),
                            child: const Padding(
                              padding:
                                  EdgeInsets.all(_padding - (_padding / 4)),
                              child: Icon(Icons.person),
                            ),
                            onTap: () {},
                          ),
                          color: Get.theme.backgroundColor,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
