import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mm_notes/db/database_helper.dart';
import 'package:mm_notes/models/note.dart';

class DetailScreenController extends GetxController {
  final DatabaseHelper db = DatabaseHelper.instance;
  final titleController = TextEditingController().obs;
  final bodyController = TextEditingController().obs;

  NoteColor? currentNoteColorEnum;
  Rx<Color>? currentNoteColor;

  var isCurrentNotePinned = false.obs;
  Rx<Icon> pinnedIcon = const Icon(Icons.push_pin_outlined).obs;

  void updatePinnedIcon() {
    if (isCurrentNotePinned.value) {
      pinnedIcon.value = const Icon(Icons.push_pin);
    } else {
      pinnedIcon.value = const Icon(Icons.push_pin_outlined);
    }
  }

  DateTime currentDate = DateTime.fromMicrosecondsSinceEpoch(
      DateTime.now().microsecondsSinceEpoch);

  void resetData() {
    isCurrentNotePinned.value = false;
    updatePinnedIcon();
    currentNoteColorEnum = null;
    currentNoteColor = null;
    titleController.value.clear();
    bodyController.value.clear();
    currentDate = DateTime.fromMicrosecondsSinceEpoch(
        DateTime.now().microsecondsSinceEpoch);
  }
}
