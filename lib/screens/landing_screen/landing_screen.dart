import 'package:flutter/material.dart';
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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.lime),
      home: const LandingScreen(),
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(brightness: Brightness.dark),
    );
  }
}

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopSearchCard(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const NoteDetailScreen()));
        },
        child: Icon(Icons.add, color: Theme.of(context).hintColor),
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 4,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: const FloatingBottomBar(),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        children: [
          Container(color: Theme.of(context).primaryColor),
          Container(color: Theme.of(context).primaryColor),
          Container(color: Theme.of(context).primaryColor),
          Container(color: Theme.of(context).primaryColor),
          Container(color: Theme.of(context).primaryColor),
          Container(color: Theme.of(context).primaryColor),
          Container(color: Theme.of(context).primaryColor),
          Container(color: Theme.of(context).primaryColor),
          Container(color: Theme.of(context).primaryColor),
          Container(color: Theme.of(context).primaryColor),
          Container(color: Theme.of(context).primaryColor),
          Container(color: Theme.of(context).primaryColor),
          Container(color: Theme.of(context).primaryColor),
          Container(color: Theme.of(context).primaryColor),
          Container(color: Theme.of(context).primaryColor),
          Container(color: Theme.of(context).primaryColor),
          Container(color: Theme.of(context).primaryColor),
          Container(color: Theme.of(context).primaryColor),
          Container(color: Theme.of(context).primaryColor),
        ],
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
    );
  }
}
