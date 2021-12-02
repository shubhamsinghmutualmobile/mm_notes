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

  const NoteDetailScreen(this.note, this.refreshNotes, {Key? key})
      : super(key: key);

  static const String columnId = DatabaseHelper.columnId;
  static const String columnTitle = DatabaseHelper.columnTitle;
  static const String columnBody = DatabaseHelper.columnBody;
  static const String columnDateCreated = DatabaseHelper.columnDateCreated;
  static const String columnNoteColor = DatabaseHelper.columnNoteColor;

  @override
  Widget build(BuildContext context) {
    final DetailScreenController dsc = Get.put(DetailScreenController());
    final _titleController = dsc.titleController;
    final _bodyController = dsc.bodyController;
    final DatabaseHelper db = dsc.db;

    dsc.currentNoteColorEnum = note?.noteColor ?? NoteColor.grey;

    dsc.currentNoteColor = getColorFromNote(note, context).obs;

    final _topPadding = MediaQuery.of(context).padding.top;

    dsc.currentDate = setupInitialViews(
        dsc.currentDate, _titleController.value, _bodyController.value);

    return WillPopScope(
      onWillPop: () {
        return _insertOrUpdateNote(
            db,
            columnTitle,
            _titleController.value,
            columnBody,
            _bodyController.value,
            columnDateCreated,
            context,
            columnId,
            columnNoteColor,
            dsc.currentNoteColorEnum);
      },
      child: Scaffold(
        body: Obx(
          () => Container(
            color: dsc.currentNoteColor?.value,
            child:
                detailScreenTopBar(_topPadding, context, _insertOrUpdateNote),
          ),
        ),
        bottomNavigationBar: detailScreenBottomBar(context, (Color noteColor) {
          Navigator.pop(context);
          dsc.currentNoteColor?.value = noteColor;
          dsc.currentNoteColorEnum = getNoteColorFromColor(noteColor);
        }),
      ),
    );
  }

  DateTime setupInitialViews(
      DateTime currentDate,
      TextEditingController _titleController,
      TextEditingController _bodyController) {
    if (note != null) {
      if (_titleController.text != note!.title) {
        _titleController.text = note!.title;
      }
      if (_bodyController.text != note!.body) {
        _bodyController.text = note!.body;
      }
      currentDate =
          DateTime.fromMicrosecondsSinceEpoch(note!.dateCreated.toInt());
    }
    return currentDate;
  }

  Future<bool> _insertOrUpdateNote(
      DatabaseHelper db,
      String columnTitle,
      TextEditingController _titleController,
      String columnBody,
      TextEditingController _bodyController,
      String columnDateCreated,
      BuildContext context,
      String columnId,
      String columnNoteColor,
      NoteColor? noteColor) async {
    int noteTime;
    if (note != null) {
      if (note!.title != _titleController.text ||
          note!.body != _bodyController.text) {
        noteTime = DateTime.now().microsecondsSinceEpoch;
      } else {
        noteTime = note!.dateCreated.toInt();
      }
      var result = await db.update({
        columnId: note!.id,
        columnTitle: _titleController.text,
        columnBody: _bodyController.text,
        columnDateCreated: noteTime,
        columnNoteColor: noteColor.toString()
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
        var result = await db.insert({
          columnTitle: _titleController.text,
          columnBody: _bodyController.text,
          columnDateCreated: DateTime.now().microsecondsSinceEpoch,
          columnNoteColor: noteColor.toString()
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
    Navigator.pop(context);
    return true;
  }
}
