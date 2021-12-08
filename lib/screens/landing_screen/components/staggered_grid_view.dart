import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:mm_notes/controllers/detail_screen_controller.dart';
import 'package:mm_notes/controllers/landing_screen_controller.dart';
import 'package:mm_notes/db/database_helper.dart';
import 'package:mm_notes/models/note.dart';
import 'package:mm_notes/screens/note_detail_screen/note_detail_screen.dart';
import 'package:mm_notes/utils/color_utils.dart';

class NotesGridView extends StatelessWidget {
  NotesGridView({Key? key}) : super(key: key);

  final LandingScreenController lsc = Get.put(LandingScreenController());
  final DetailScreenController dsc = Get.put(DetailScreenController());

  @override
  Widget build(BuildContext context) {
    final DatabaseHelper db = lsc.db;

    var notes = lsc.listOfNotes;

    final _paddingTop = MediaQuery.of(context).padding.top * 1.1;
    final _paddingBottom = MediaQuery.of(context).padding.bottom * 1.6;
    final _transitionColor = Theme.of(context).cardColor;

    return Obx(() {
      return AnimatedCrossFade(
          crossFadeState: !lsc.isGridModeOn.value
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          duration: const Duration(milliseconds: 500),
          firstChild: gridWidget(_paddingTop, _paddingBottom, notes, context,
              _transitionColor, db),
          secondChild: listWidget(_paddingTop, _paddingBottom, notes, context,
              _transitionColor, db));
    });
  }

  Padding listWidget(
      double _paddingTop,
      double _paddingBottom,
      RxList<Note> notes,
      BuildContext context,
      Color _transitionColor,
      DatabaseHelper db) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(top: _paddingTop, bottom: _paddingBottom),
        children: notes
            .map((note) => noteCard(context, _transitionColor, note, db))
            .toList(),
      ),
    );
  }

  Padding gridWidget(
      double _paddingTop,
      double _paddingBottom,
      RxList<Note> notes,
      BuildContext context,
      Color _transitionColor,
      DatabaseHelper db) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: StaggeredGridView.count(
        shrinkWrap: true,
        crossAxisCount: 4,
        padding: EdgeInsets.only(top: _paddingTop, bottom: _paddingBottom),
        children: notes
            .map((note) => noteCard(context, _transitionColor, note, db))
            .toList(),
        staggeredTiles: notes
            .map<StaggeredTile>((_) => const StaggeredTile.fit(2))
            .toList(),
        mainAxisSpacing: 3.0,
        crossAxisSpacing: 4.0,
      ),
    );
  }

  Card noteCard(BuildContext context, Color _transitionColor, Note note,
      DatabaseHelper db) {
    return Card(
      borderOnForeground: true,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Theme.of(context).hintColor.withAlpha(100)),
          borderRadius: BorderRadius.circular(8.0)),
      child: OpenContainer(
        openColor: _transitionColor,
        closedColor: getColorFromNote(note, context),
        closedElevation: 0,
        openBuilder: (_, __) {
          dsc.resetData();
          return NoteDetailScreen(note, lsc.refreshListOfNotes);
        },
        closedBuilder: (_, func) => InkWell(
          customBorder:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          onTap: () {
            func();
          },
          onLongPress: () {
            db.delete(note.id);
            lsc.refreshListOfNotes();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(note.title,
                      style: Theme.of(context).textTheme.headline6),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(note.body,
                      style: Theme.of(context).textTheme.bodyText2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
