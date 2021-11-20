import 'package:flutter/material.dart';
import 'package:mm_notes/db/database_helper.dart';
import 'package:mm_notes/models/note.dart';
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
  String columnId = DatabaseHelper.columnId;
  String columnTitle = DatabaseHelper.columnTitle;
  String columnBody = DatabaseHelper.columnBody;
  String columnDateCreated = DatabaseHelper.columnDateCreated;
  List<Map<String, dynamic>> mapOfNotes = [];

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
        dateCreated: (mapNote[columnDateCreated] as int).toDouble()))
        .toList();

    return Scaffold(
      appBar: const TopSearchCard(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          refreshListOfNotes();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      NoteDetailScreen(null, refreshListOfNotes)));
        },
        child: Icon(Icons.add, color: Theme.of(context).hintColor),
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 4,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: const FloatingBottomBar(),
      body: NotesGridView(listOfNotes, refreshListOfNotes),
      extendBody: true,
      extendBodyBehindAppBar: true,
    );
  }
}