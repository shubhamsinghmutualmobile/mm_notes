import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mm_notes/controllers/detail_screen_controller.dart';
import 'package:mm_notes/controllers/landing_screen_controller.dart';
import 'package:mm_notes/db/database_helper.dart';
import 'package:mm_notes/models/note.dart';

Future<dynamic> menuBottomSheet(double _bottomPadding, Note? note,
    {bool isTrashNote = false}) {
  final dsc = Get.put(DetailScreenController());
  final lsc = Get.put(LandingScreenController());

  const String columnId = DatabaseHelper.columnId;
  const String columnTitle = DatabaseHelper.columnTitle;
  const String columnBody = DatabaseHelper.columnBody;
  const String columnDateCreated = DatabaseHelper.columnDateCreated;
  const String columnNoteColor = DatabaseHelper.columnNoteColor;
  const String columnIsPinned = DatabaseHelper.columnIsPinned;

  return isTrashNote
      ? Get.bottomSheet(
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              menuBottomSheetItem(Icons.restore, "Restore", action: () {
                if (note != null) {
                  dsc.db.insert({
                    columnTitle: note.title,
                    columnBody: note.body,
                    columnDateCreated: note.dateCreated,
                    columnNoteColor: note.noteColor.toString(),
                    columnIsPinned: note.isPinned ? 1 : 0
                  });
                  dsc.db.delete(note.id, isTrashTable: true);
                  lsc.refreshListOfNotes(isTrashTable: true);
                  Get.back(closeOverlays: true);
                }
              }),
              menuBottomSheetItem(Icons.delete_forever, "Delete forever",
                  action: () {
                if (note != null) {
                  dsc.db.delete(note.id, isTrashTable: true);
                  lsc.refreshListOfNotes(isTrashTable: true);
                  Get.back(closeOverlays: true);
                }
              }),
              SizedBox(
                height: _bottomPadding,
              ),
            ],
          ),
          backgroundColor:
              dsc.currentNoteColor?.value ?? Get.theme.backgroundColor,
        )
      : Get.bottomSheet(
          SingleChildScrollView(
            child: Column(
              children: [
                menuBottomSheetItem(Icons.delete_outlined, "Delete",
                    action: () {
                  if (note != null) {
                    // Insert into the trash table if not already coming from trash screen
                    if (!isTrashNote) {
                      dsc.db.insert({
                        columnTitle: note.title,
                        columnBody: note.body,
                        columnDateCreated: note.dateCreated,
                        columnNoteColor: note.noteColor.toString(),
                        columnIsPinned: note.isPinned ? 1 : 0
                      }, isTrashTable: true);
                    }
                    dsc.db.delete(note.id, isTrashTable: isTrashNote);
                    lsc.refreshListOfNotes(isTrashTable: isTrashNote);
                  }
                  Get.back(closeOverlays: true);
                }),
                menuBottomSheetItem(Icons.content_copy_rounded, "Make a copy"),
                menuBottomSheetItem(Icons.share_outlined, "Send"),
                menuBottomSheetItem(Icons.person_add_alt, "Collaborator"),
                menuBottomSheetItem(Icons.label_outline, "Labels"),
                SizedBox(
                  height: _bottomPadding,
                )
              ],
            ),
          ),
          backgroundColor:
              dsc.currentNoteColor?.value ?? Get.theme.backgroundColor);
}

Widget menuBottomSheetItem(IconData icon, String name, {Function? action}) {
  return InkWell(
    onTap: () {
      if (action != null) {
        action();
      }
    },
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(
            width: 24,
          ),
          Text(
            name,
            style: Get.textTheme.subtitle1,
          )
        ],
      ),
    ),
  );
}
