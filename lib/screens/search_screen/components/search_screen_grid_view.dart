import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:mm_notes/controllers/detail_screen_controller.dart';
import 'package:mm_notes/controllers/landing_screen_controller.dart';
import 'package:mm_notes/controllers/search_screen_controller.dart';
import 'package:mm_notes/db/database_helper.dart';
import 'package:mm_notes/models/note.dart';
import 'package:mm_notes/screens/note_detail_screen/note_detail_screen.dart';
import 'package:mm_notes/utils/color_utils.dart';
import 'package:mm_notes/utils/note_utils.dart';

class SearchScreenGridView extends StatelessWidget {
  SearchScreenGridView({Key? key}) : super(key: key);

  final LandingScreenController lsc = Get.put(LandingScreenController());
  final DetailScreenController dsc = Get.put(DetailScreenController());
  final SearchScreenController searchScreenController =
      Get.put(SearchScreenController());

  @override
  Widget build(BuildContext context) {
    final DatabaseHelper db = lsc.db;

    var notes = lsc.searchNotesList;

    final _paddingTop = MediaQuery.of(context).padding.top * 1.1;
    final _paddingBottom = MediaQuery.of(context).padding.bottom * 1.6;
    final _transitionColor = Get.theme.cardColor;

    return Obx(() {
      if (notes.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.lightbulb_outlined,
                size: 125,
                color: Get.theme.primaryIconTheme.color,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Notes you search appear here",
                style: Get.textTheme.subtitle2,
              ),
            ],
          ),
        );
      } else {
        return AnimatedCrossFade(
            crossFadeState: !searchScreenController.isGridModeOn.value
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: const Duration(milliseconds: 250),
            firstChild: gridWidget(
                _paddingTop, _paddingBottom, notes, _transitionColor, db),
            secondChild: listWidget(
                _paddingTop, _paddingBottom, notes, _transitionColor, db));
      }
    });
  }

  Padding listWidget(double _paddingTop, double _paddingBottom,
      RxList<Note> notes, Color _transitionColor, DatabaseHelper db) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(top: _paddingTop, bottom: _paddingBottom),
        children:
            notes.map((note) => noteCard(_transitionColor, note, db)).toList(),
      ),
    );
  }

  Padding gridWidget(double _paddingTop, double _paddingBottom,
      RxList<Note> notes, Color _transitionColor, DatabaseHelper db) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: StaggeredGridView.count(
        shrinkWrap: true,
        crossAxisCount: 4,
        padding: EdgeInsets.only(top: _paddingTop, bottom: _paddingBottom),
        children:
            notes.map((note) => noteCard(_transitionColor, note, db)).toList(),
        staggeredTiles: notes
            .map<StaggeredTile>((_) => const StaggeredTile.fit(2))
            .toList(),
        mainAxisSpacing: 3.0,
        crossAxisSpacing: 4.0,
      ),
    );
  }

  Card noteCard(Color _transitionColor, Note note, DatabaseHelper db) {
    final cardShape = BorderRadius.circular(8.0);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Get.theme.hintColor.withAlpha(100)),
          borderRadius: cardShape),
      child: OpenContainer(
        closedShape: RoundedRectangleBorder(
            side: BorderSide(color: Get.theme.hintColor.withAlpha(100)),
            borderRadius: cardShape),
        openColor: _transitionColor,
        closedColor: getColorFromNote(note),
        closedElevation: 0,
        openBuilder: (_, __) {
          return NoteDetailScreen(note, lsc.refreshListOfNotes);
        },
        closedBuilder: (_, func) => InkWell(
          customBorder: RoundedRectangleBorder(borderRadius: cardShape),
          onTap: () {
            dsc.resetData();
            func();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getCardTitle(note.title, note.isPinned),
                getCardBody(note),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
