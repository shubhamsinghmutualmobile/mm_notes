import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mm_notes/db/database_helper.dart';
import 'package:mm_notes/models/note.dart';
import 'package:mm_notes/utils/color_utils.dart';
import 'package:mm_notes/utils/mappers.dart';

class LandingScreenController extends GetxController {
  static const String columnId = DatabaseHelper.columnId;
  static const String columnTitle = DatabaseHelper.columnTitle;
  static const String columnBody = DatabaseHelper.columnBody;
  static const String columnDateCreated = DatabaseHelper.columnDateCreated;
  static const String columnNoteColor = DatabaseHelper.columnNoteColor;
  static const String columnIsPinned = DatabaseHelper.columnIsPinned;

  final DatabaseHelper db = DatabaseHelper.instance;
  RxList<Map<String, dynamic>> mapOfNotes = RxList();
  RxList<Note> listOfNotes = RxList();
  Rx<Icon> gridModeIcon = const Icon(Icons.grid_view).obs;
  var currentSelectedDrawerElement = DrawerElements.notes.obs;

  var currentSearchQuery = "".obs;
  RxList<Note> searchNotesList = RxList();

  void searchNotes() {
    print("Search notes called!");
    if (!currentSearchQuery.value.isBlank!) {
      searchNotesList.value = listOfNotes
          .where((note) =>
              note.title.contains(
                  RegExp(currentSearchQuery.value, caseSensitive: false)) ||
              note.body.contains(
                  RegExp(currentSearchQuery.value, caseSensitive: false)))
          .toList();
    } else {
      searchNotesList.value = RxList();
    }
  }

  void updateSelectedDrawerElement(DrawerElements element) {
    currentSelectedDrawerElement.value = element;
  }

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
            noteColor: getNoteColorFromString(mapNote[columnNoteColor]),
            isPinned: (mapNote[columnIsPinned] as int).toBoolean()))
        .toList()
        .reversed
        .toList();
    sortPinnedNotesToTop();
  }

  void sortPinnedNotesToTop() {
    List<Note> pinnedList =
        listOfNotes.value.where((note) => note.isPinned).toList();
    List<Note> unpinnedList =
        listOfNotes.value.where((note) => !note.isPinned).toList();
    listOfNotes.value = [...pinnedList, ...unpinnedList];
    searchNotes();
  }
}

enum DrawerElements {
  notes,
  reminders,
  archive,
  trash,
  settings,
  helpAndFeedback
}
