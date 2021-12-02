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

  DateTime currentDate = DateTime.fromMicrosecondsSinceEpoch(
      DateTime.now().microsecondsSinceEpoch);

  void resetData() {
    currentNoteColorEnum = null;
    currentNoteColor = null;
    titleController.value.clear();
    bodyController.value.clear();
    currentDate = DateTime.fromMicrosecondsSinceEpoch(DateTime.now().microsecondsSinceEpoch);
  }

}