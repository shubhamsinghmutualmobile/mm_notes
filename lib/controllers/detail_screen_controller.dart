import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mm_notes/db/database_helper.dart';
import 'package:mm_notes/models/note.dart';
import 'package:mm_notes/utils/color_utils.dart';

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

  void setupInitialViews(Note? note) {
    var _titleController = titleController.value;
    var _bodyController = bodyController.value;

    currentNoteColorEnum ??= note?.noteColor ?? NoteColor.grey;

    currentNoteColor ??= getColorFromNote(note).obs;

    if (note != null) {
      print("Is ${titleController.value.text} empty?: ${titleController.value.text.isEmpty}");
      if (_titleController.text != note.title && _titleController.text.isEmpty) {
        _titleController.text = note.title;
      }
      if (_bodyController.text != note.body && _bodyController.text.isEmpty) {
        _bodyController.text = note.body;
      }
      currentDate =
          DateTime.fromMicrosecondsSinceEpoch(note.dateCreated.toInt());
      isCurrentNotePinned.value = note.isPinned;
      updatePinnedIcon();
    }
  }
}
