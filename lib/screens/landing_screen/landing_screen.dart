import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mm_notes/controllers/detail_screen_controller.dart';
import 'package:mm_notes/controllers/landing_screen_controller.dart';
import 'package:mm_notes/db/database_helper.dart';
import 'package:mm_notes/screens/archive_screen/archive_screen.dart';
import 'package:mm_notes/screens/help_and_feedback_screen/help_and_feedback_screen.dart';
import 'package:mm_notes/screens/landing_screen/components/staggered_grid_view.dart';
import 'package:mm_notes/screens/note_detail_screen/note_detail_screen.dart';
import 'package:mm_notes/screens/reminders_screen/reminders_screen.dart';
import 'package:mm_notes/screens/trash_screen/trash_screen.dart';

import 'components/floating_bottom_bar.dart';
import 'components/side_drawer.dart';
import 'components/top_search_card.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final DatabaseHelper db = DatabaseHelper.instance;

  final LandingScreenController lsc = Get.put(LandingScreenController());
  final DetailScreenController dsc = Get.put(DetailScreenController());

  @override
  Widget build(BuildContext context) {
    context.theme;

    final _topPadding = MediaQuery.of(context).padding.top;

    SystemChrome.setSystemUIOverlayStyle(Get.isDarkMode
        ? SystemUiOverlayStyle.light
        : SystemUiOverlayStyle.dark);

    return Obx(
      () => Scaffold(
        appBar: getAppBar(),
        floatingActionButton: getFloatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: getBottomNavigationBar(),
        body: getCurrentDrawerScreen(),
        extendBody: true,
        extendBodyBehindAppBar: true,
        drawer: sideDrawer(_topPadding),
      ),
    );
  }

  Widget? getFloatingActionButton() {
    final _transitionColor = Get.theme.cardColor;

    switch (lsc.currentSelectedDrawerElement.value) {
      case DrawerElements.notes:
        return OpenContainer(
          openColor: _transitionColor,
          closedColor: _transitionColor,
          closedShape: const CircleBorder(),
          closedElevation: 4,
          openBuilder: (_, __) =>
              NoteDetailScreen(null, lsc.refreshListOfNotes),
          closedBuilder: (_, openWidget) => FloatingActionButton(
            onPressed: () {
              dsc.resetData();
              lsc.refreshListOfNotes();
              openWidget();
            },
            child: Icon(Icons.add, color: Get.theme.hintColor),
          ),
        );
      default:
        return null;
    }
  }

  Widget? getBottomNavigationBar() {
    switch (lsc.currentSelectedDrawerElement.value) {
      case DrawerElements.notes:
        return const FloatingBottomBar();
      default:
        return null;
    }
  }

  PreferredSizeWidget? getAppBar() {
    switch (lsc.currentSelectedDrawerElement.value) {
      case DrawerElements.notes:
        return TopSearchCard();
      default:
        return null;
    }
  }

  Widget getCurrentDrawerScreen() {
    switch (lsc.currentSelectedDrawerElement.value) {
      case DrawerElements.notes:
        return NotesGridView();
      case DrawerElements.reminders:
        return RemindersScreen();
      case DrawerElements.archive:
        return ArchiveScreen();
      case DrawerElements.trash:
        return TrashScreen();
      case DrawerElements.helpAndFeedback:
        return HelpAndFeedbackScreen();
      default:
        return Container();
    }
  }
}
