import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mm_notes/db/database_helper.dart';
import 'package:mm_notes/models/note.dart';
import 'package:mm_notes/utils/color_utils.dart';

class LandingScreenController extends GetxController {
  static const String columnId = DatabaseHelper.columnId;
  static const String columnTitle = DatabaseHelper.columnTitle;
  static const String columnBody = DatabaseHelper.columnBody;
  static const String columnDateCreated = DatabaseHelper.columnDateCreated;
  static const String columnNoteColor = DatabaseHelper.columnNoteColor;

  final DatabaseHelper db = DatabaseHelper.instance;
  RxList<Map<String, dynamic>> mapOfNotes = RxList();
  RxList<Note> listOfNotes = RxList();
  Rx<Icon> gridModeIcon = const Icon(Icons.grid_view).obs;

  var isGridModeOn = false.obs;

  void toggleGridMode() {
    isGridModeOn.toggle();
    updateToggleIcon();
  }

  void updateToggleIcon() {
    if (isGridModeOn.value) {
      gridModeIcon.value = const Icon(Icons.grid_view);
    } else {
      gridModeIcon.value = const Icon(Icons.view_agenda_outlined);
    }
  }

  @override
  void onInit() {
    refreshListOfNotes();
    updateToggleIcon();
    super.onInit();
  }

  void refreshListOfNotes() async {
    var dbList = await db.queryAll();
    if (dbList != null) {
      print("Updatedlist is: $mapOfNotes");
      mapOfNotes.value = dbList;
      mapListOfNotes();
    }
  }

  void mapListOfNotes() {
    listOfNotes.value = mapOfNotes
        .map((mapNote) => Note(mapNote[columnId],
            title: mapNote[columnTitle],
            body: mapNote[columnBody],
            dateCreated: (mapNote[columnDateCreated] as int).toDouble(),
            noteColor: getNoteColorFromString(mapNote[columnNoteColor])))
        .toList();
  }
}
