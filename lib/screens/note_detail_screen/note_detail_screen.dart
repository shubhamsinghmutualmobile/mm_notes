import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mm_notes/controllers/detail_screen_controller.dart';
import 'package:mm_notes/db/database_helper.dart';
import 'package:mm_notes/models/note.dart';
import 'package:mm_notes/utils/color_utils.dart';

import 'components/detail_screen_bottom_bar.dart';
import 'components/detail_screen_top_bar.dart';

class NoteDetailScreen extends StatelessWidget {
  final Note? note;
  final Function refreshNotes;

  NoteDetailScreen(this.note, this.refreshNotes, {Key? key})
      : super(key: key);

  static const String columnId = DatabaseHelper.columnId;
  static const String columnTitle = DatabaseHelper.columnTitle;
  static const String columnBody = DatabaseHelper.columnBody;
  static const String columnDateCreated = DatabaseHelper.columnDateCreated;
  static const String columnNoteColor = DatabaseHelper.columnNoteColor;
  static const String columnIsPinned = DatabaseHelper.columnIsPinned;

  final DetailScreenController dsc = Get.put(DetailScreenController());

  @override
  Widget build(BuildContext context) {

    dsc.setupInitialViews(note);

    return WillPopScope(
      onWillPop: () {
        return _insertOrUpdateNote();
      },
      child: Scaffold(
        body: Obx(
          () => Container(
            color: dsc.currentNoteColor?.value,
            child: detailScreenTopBar(_insertOrUpdateNote),
          ),
        ),
        bottomNavigationBar: Obx(() => Container(
              color: dsc.currentNoteColor?.value,
              child: detailScreenBottomBar((Color noteColor) {
                // Get.back();
                dsc.currentNoteColor?.value = noteColor;
                dsc.currentNoteColorEnum = getNoteColorFromColor(noteColor);
              }, note, context),
            )),
      ),
    );
  }

  Future<bool> _insertOrUpdateNote() async {
    var _db = dsc.db;
    var _titleController = dsc.titleController.value;
    var _bodyController = dsc.bodyController.value;
    var _currentNoteColorEnum = dsc.currentNoteColorEnum;
    var _currentNoteIsPinned = dsc.isCurrentNotePinned.value;

    int noteTime;
    if (note != null) {
      if (note!.title != _titleController.text ||
          note!.body != _bodyController.text) {
        noteTime = DateTime.now().microsecondsSinceEpoch;
      } else {
        noteTime = note!.dateCreated.toInt();
      }
      var result = await _db.update({
        columnId: note!.id,
        columnTitle: _titleController.text,
        columnBody: _bodyController.text,
        columnDateCreated: noteTime,
        columnNoteColor: _currentNoteColorEnum.toString(),
        columnIsPinned: _currentNoteIsPinned
      });

      if (result != null) {
        if (result != 0) {
          refreshNotes();
        } else {
          print("Couldn't update note!");
        }
      }
    } else {
      if (_titleController.text.isNotEmpty || _bodyController.text.isNotEmpty) {
        var result = await _db.insert({
          columnTitle: _titleController.text,
          columnBody: _bodyController.text,
          columnDateCreated: DateTime.now().microsecondsSinceEpoch,
          columnNoteColor: _currentNoteColorEnum.toString(),
          columnIsPinned: _currentNoteIsPinned
        });
        if (result != null) {
          if (result != 0) {
            refreshNotes();
          } else {
            print("Couldn't insert note!");
          }
        }
      }
    }
    Get.back();
    return true;
  }
}
