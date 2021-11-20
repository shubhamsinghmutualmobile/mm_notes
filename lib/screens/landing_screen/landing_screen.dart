import 'package:flutter/material.dart';
import 'package:mm_notes/screens/landing_screen/components/staggered_grid_view.dart';
import 'package:mm_notes/screens/models/note.dart';
import 'package:mm_notes/screens/note_detail_screen/note_detail_screen.dart';

import 'components/floating_bottom_bar.dart';
import 'components/top_search_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Note> _notes = [
      Note(0, title: "My title", body: "MyBody", dateCreated: 123456),
      Note(1, title: "My title", body: "MyBody", dateCreated: 123456),
      Note(2, title: "My title", body: "MyBody", dateCreated: 123456),
      Note(3, title: "My title", body: "MyBody", dateCreated: 123456),
      Note(4, title: "My title", body: "MyBody", dateCreated: 123456),
      Note(5, title: "My title", body: "MyBody", dateCreated: 123456),
      Note(6, title: "My title", body: "MyBody", dateCreated: 123456),
      Note(7, title: "My title", body: "MyBody", dateCreated: 123456),
      Note(8, title: "My title", body: "MyBody", dateCreated: 123456),
      Note(9, title: "My title", body: "MyBody", dateCreated: 123456),
      Note(10, title: "My title", body: "MyBody", dateCreated: 123456),
      Note(11,
          title: "My title",
          body: "MyBody\nThis is my new text\nThis is another text",
          dateCreated: 123456),
      Note(12, title: "My title", body: "MyBody", dateCreated: 123456),
      Note(12, title: "My title", body: "MyBody", dateCreated: 123456),
      Note(12, title: "My title", body: "MyBody", dateCreated: 123456),
      Note(12, title: "My title", body: "MyBody", dateCreated: 123456),
      Note(12, title: "My title", body: "MyBody", dateCreated: 123456),
      Note(12, title: "My title", body: "MyBody", dateCreated: 123456),
      Note(12, title: "My title", body: "MyBody", dateCreated: 123456),
      Note(12, title: "My title", body: "MyBody", dateCreated: 123456),
      Note(12, title: "My title", body: "MyBody", dateCreated: 123456),
      Note(12, title: "My title", body: "MyBody", dateCreated: 123456),
    ];

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.lime),
      home: LandingScreen(_notes),
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(brightness: Brightness.dark),
    );
  }
}

class LandingScreen extends StatelessWidget {
  final List<Note> notes;

  const LandingScreen(this.notes, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopSearchCard(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const NoteDetailScreen(null)));
        },
        child: Icon(Icons.add, color: Theme.of(context).hintColor),
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 4,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: const FloatingBottomBar(),
      body: NotesGridView(notes),
      extendBody: true,
      extendBodyBehindAppBar: true,
    );
  }
}
