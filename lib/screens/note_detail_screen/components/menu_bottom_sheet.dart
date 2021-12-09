import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mm_notes/controllers/detail_screen_controller.dart';
import 'package:mm_notes/controllers/landing_screen_controller.dart';
import 'package:mm_notes/models/note.dart';

Future<dynamic> menuBottomSheet(double _bottomPadding, Note? note) {
  final dsc = Get.put(DetailScreenController());
  final lsc = Get.put(LandingScreenController());
  return Get.bottomSheet(
      SingleChildScrollView(
        child: Column(
          children: [
            menuBottomSheetItem(Icons.delete_outlined, "Delete", action: () {
              if (note != null) {
                dsc.db.delete(note.id);
                lsc.refreshListOfNotes();
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
