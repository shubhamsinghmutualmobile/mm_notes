import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mm_notes/controllers/landing_screen_controller.dart';
import 'package:mm_notes/controllers/search_screen_controller.dart';

AppBar searchTopBar() {
  final searchScreenController = Get.put(SearchScreenController());
  final lsc = Get.put(LandingScreenController());

  return AppBar(
    elevation: 0,
    actions: [
      Obx(() => IconButton(
          onPressed: () {
            searchScreenController
                .toggleGridIcon(searchScreenController.isGridModeOn.value);
          },
          icon: searchScreenController.currentGridIcon.value))
    ],
    titleSpacing: 0,
    title: TextField(
      onChanged: (searchQuery) {
        lsc.currentSearchQuery.value = searchQuery;
        lsc.searchNotes();
      },
      controller: searchScreenController.searchBoxController,
      style: Get.textTheme.subtitle1,
      decoration: InputDecoration(
          border: InputBorder.none,
          hintStyle: Get.textTheme.subtitle1,
          hintText: "Search your notes"),
    ),
  );
}
