import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mm_notes/controllers/landing_screen_controller.dart';
import 'package:mm_notes/controllers/search_screen_controller.dart';
import 'package:mm_notes/screens/search_screen/components/search_screen_grid_view.dart';

import 'components/search_top_bar.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  final searchScreenController = Get.put(SearchScreenController());
  final lsc = Get.put(LandingScreenController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        searchScreenController.resetData();
        lsc.searchNotesList.clear();
        return true;
      },
      child: Scaffold(
        appBar: searchTopBar(),
        body: SearchScreenGridView(),
      ),
    );
  }
}
