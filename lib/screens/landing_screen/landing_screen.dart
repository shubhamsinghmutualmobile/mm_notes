import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mm_notes/controllers/detail_screen_controller.dart';
import 'package:mm_notes/controllers/landing_screen_controller.dart';
import 'package:mm_notes/db/database_helper.dart';
import 'package:mm_notes/screens/landing_screen/components/staggered_grid_view.dart';
import 'package:mm_notes/screens/note_detail_screen/note_detail_screen.dart';

import 'components/floating_bottom_bar.dart';
import 'components/top_search_card.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final DatabaseHelper db = DatabaseHelper.instance;

  final LandingScreenController lsc = Get.put(LandingScreenController());

  @override
  Widget build(BuildContext context) {
    final DetailScreenController dsc = Get.put(DetailScreenController());

    final _transitionColor = Theme.of(context).cardColor;

    final _topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: TopSearchCard(),
      floatingActionButton: OpenContainer(
        openColor: _transitionColor,
        closedColor: _transitionColor,
        closedShape: const CircleBorder(),
        closedElevation: 4,
        openBuilder: (_, __) => NoteDetailScreen(null, lsc.refreshListOfNotes),
        closedBuilder: (_, openWidget) => FloatingActionButton(
          onPressed: () {
            dsc.resetData();
            lsc.refreshListOfNotes();
            openWidget();
          },
          child: Icon(Icons.add, color: Theme.of(context).hintColor),
          backgroundColor: Theme.of(context).backgroundColor,
          elevation: 4,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: const FloatingBottomBar(),
      body: NotesGridView(),
      extendBody: true,
      extendBodyBehindAppBar: true,
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: _topPadding,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12, left: 16),
              child: Row(
                children: const [
                  Text(
                    "Google",
                    style: TextStyle(
                        fontFamily: 'ProductSans',
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    " Keep",
                    style: TextStyle(
                      fontFamily: 'ProductSans',
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
