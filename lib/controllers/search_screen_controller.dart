import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreenController extends GetxController {
  var searchBoxController = TextEditingController();
  var isGridModeOn = false.obs;
  late var currentGridIcon = const Icon(Icons.grid_view).obs;

  void toggleGridIcon(bool isGridModeOn) {
    this.isGridModeOn.toggle();
    if (isGridModeOn) {
      currentGridIcon.value = const Icon(Icons.view_agenda_outlined);
    } else {
      currentGridIcon.value = const Icon(Icons.grid_view);
    }
  }

  void resetData() {
    searchBoxController.clear();
    toggleGridIcon(true);
  }
}
