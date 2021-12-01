import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:mm_notes/db/database_helper.dart';
import 'package:mm_notes/models/note.dart';
import 'package:mm_notes/screens/landing_screen/components/staggered_grid_view.dart';
import 'package:mm_notes/screens/note_detail_screen/note_detail_screen.dart';
import 'package:mm_notes/utils/color_utils.dart';

import 'components/floating_bottom_bar.dart';
import 'components/top_search_card.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final DatabaseHelper db = DatabaseHelper.instance;
  String columnId = DatabaseHelper.columnId;
  String columnTitle = DatabaseHelper.columnTitle;
  String columnBody = DatabaseHelper.columnBody;
  String columnDateCreated = DatabaseHelper.columnDateCreated;
  String columnNoteColor = DatabaseHelper.columnNoteColor;
  List<Map<String, dynamic>> mapOfNotes = [];
  bool _isGridModeOn = true;

  void toggleGridMode() {
    setState(() {
      _isGridModeOn = !_isGridModeOn;
    });
  }

  void refreshListOfNotes() async {
    var dbList = await db.queryAll();
    if (dbList != null) {
      setState(() {
        mapOfNotes = dbList;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    refreshListOfNotes();
  }

  @override
  Widget build(BuildContext context) {
    List<Note> listOfNotes = mapOfNotes
        .map((mapNote) => Note(mapNote[columnId],
            title: mapNote[columnTitle],
            body: mapNote[columnBody],
            dateCreated: (mapNote[columnDateCreated] as int).toDouble(),
            noteColor: getNoteColorFromString(mapNote[columnNoteColor])))
        .toList();
    final _transitionColor = Theme.of(context).cardColor;

    return Scaffold(
      appBar: TopSearchCard(toggleGridMode, _isGridModeOn),
      floatingActionButton: OpenContainer(
        openColor: _transitionColor,
        closedColor: _transitionColor,
        closedShape: const CircleBorder(),
        closedElevation: 4,
        openBuilder: (_, __) => NoteDetailScreen(null, refreshListOfNotes),
        closedBuilder: (_, openWidget) => FloatingActionButton(
          onPressed: () {
            refreshListOfNotes();
            openWidget();
          },
          child: Icon(Icons.add, color: Theme.of(context).hintColor),
          backgroundColor: Theme.of(context).backgroundColor,
          elevation: 4,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: const FloatingBottomBar(),
      body: NotesGridView(listOfNotes, refreshListOfNotes, _isGridModeOn),
      extendBody: true,
      extendBodyBehindAppBar: true,
    );
  }
}
