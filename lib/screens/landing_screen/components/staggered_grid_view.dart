import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mm_notes/db/database_helper.dart';
import 'package:mm_notes/models/note.dart';
import 'package:mm_notes/screens/note_detail_screen/note_detail_screen.dart';

class NotesGridView extends StatelessWidget {
  final List<Note> notes;
  final Function refreshNotes;

  const NotesGridView(this.notes, this.refreshNotes, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DatabaseHelper db = DatabaseHelper.instance;
    final _paddingTop = MediaQuery.of(context).padding.top * 1.1;
    final _paddingBottom = MediaQuery.of(context).padding.bottom * 1.6;
    final _transitionColor = Theme.of(context).cardColor;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: StaggeredGridView.count(
        crossAxisCount: 4,
        padding: EdgeInsets.only(top: _paddingTop, bottom: _paddingBottom),
        children: notes
            .map((note) => Card(
                  borderOnForeground: true,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: Theme.of(context).hintColor.withAlpha(100)),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: OpenContainer(
                    openColor: _transitionColor,
                    closedColor: _transitionColor,
                    closedElevation: 0,
                    openBuilder: (_, __) =>
                        NoteDetailScreen(note, refreshNotes),
                    closedBuilder: (_, func) => InkWell(
                      customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      onTap: () {
                        func();
                      },
                      onLongPress: () {
                        db.delete(note.id);
                        refreshNotes();
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
                ))
            .toList(),
        staggeredTiles: notes
            .map<StaggeredTile>((_) => const StaggeredTile.fit(2))
            .toList(),
        mainAxisSpacing: 3.0,
        crossAxisSpacing: 4.0,
      ),
    );
  }
}
