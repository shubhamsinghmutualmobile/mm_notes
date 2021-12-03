import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mm_notes/controllers/landing_screen_controller.dart';

class TopSearchCard extends StatelessWidget with PreferredSizeWidget {
  TopSearchCard({Key? key}) : super(key: key);

  final LandingScreenController lsc = Get.put(LandingScreenController());

  @override
  Widget build(BuildContext context) {
    const _padding = 8.0;
    const _splashRadius = _padding * 2.5;
    final _topPadding = MediaQuery.of(context).padding.top;

    return Container(
      margin: EdgeInsets.only(top: _topPadding),
      padding: const EdgeInsets.symmetric(horizontal: _padding),
      child: Column(
        children: [
          Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(_padding * 4)),
              elevation: 0,
              child: InkWell(
                customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(_padding * 4)),
                onTap: () {},
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
                        Text("Search your notes",
                            style: Theme.of(context).textTheme.subtitle1),
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
                            elevation: 0.1,
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
                            color: Theme.of(context).backgroundColor,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
