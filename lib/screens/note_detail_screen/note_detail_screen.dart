import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mm_notes/db/database_helper.dart';
import 'package:mm_notes/models/note.dart';
import 'package:mm_notes/utils/color_utils.dart';

import 'components/detail_screen_bottom_bar.dart';
import 'components/detail_screen_top_bar.dart';

class NoteDetailScreen extends StatefulWidget {
  final Note? note;
  final Function refreshNotes;

  const NoteDetailScreen(this.note, this.refreshNotes, {Key? key})
      : super(key: key);

  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  static const String columnId = DatabaseHelper.columnId;
  static const String columnTitle = DatabaseHelper.columnTitle;
  static const String columnBody = DatabaseHelper.columnBody;
  static const String columnDateCreated = DatabaseHelper.columnDateCreated;
  static const String columnNoteColor = DatabaseHelper.columnNoteColor;

  final DatabaseHelper db = DatabaseHelper.instance;

  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  NoteColor? currentNoteColorEnum;
  Color? currentNoteColor;

  @override
  Widget build(BuildContext context) {
    currentNoteColorEnum ??= widget.note?.noteColor ?? NoteColor.grey;

    currentNoteColor ??= getColorFromNote(widget.note, context);

    final _topPadding = MediaQuery.of(context).padding.top;

    DateTime currentDate = DateTime.fromMicrosecondsSinceEpoch(
        DateTime.now().microsecondsSinceEpoch);

    currentDate = setupInitialViews(currentDate);

    var formattedDate = DateFormat('dd-MM-yyyy (kk:mm:ss)').format(currentDate);

    return WillPopScope(
      onWillPop: () {
        return _insertOrUpdateNote(
            db,
            columnTitle,
            _titleController,
            columnBody,
            _bodyController,
            columnDateCreated,
            context,
            columnId,
            columnNoteColor,
            currentNoteColorEnum);
      },
      child: Scaffold(
        body: Container(
          color: currentNoteColor,
          child: detailScreenTopBar(
              _topPadding,
              context,
              db,
              columnTitle,
              _titleController,
              columnBody,
              _bodyController,
              columnDateCreated,
              columnId,
              columnNoteColor,
              currentNoteColorEnum,
              _insertOrUpdateNote),
        ),
        bottomNavigationBar: detailScreenBottomBar(
            context, formattedDate, currentNoteColor, currentNoteColorEnum,
            (Color noteColor) {
          setState(() {
            Navigator.pop(context);
            currentNoteColor = noteColor;
            currentNoteColorEnum = getNoteColorFromColor(noteColor);
          });
        }),
      ),
    );
  }

  DateTime setupInitialViews(DateTime currentDate) {
    if (widget.note != null) {
      if (_titleController.text != widget.note!.title) {
        if (_titleController.text.isEmpty) {
          _titleController.text = widget.note!.title;
        }
      }
      if (_bodyController.text != widget.note!.body) {
        if (_bodyController.text.isEmpty) {
          _bodyController.text = widget.note!.body;
        }
      }
      currentDate =
          DateTime.fromMicrosecondsSinceEpoch(widget.note!.dateCreated.toInt());
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
    if (widget.note != null) {
      if (widget.note!.title != _titleController.text ||
          widget.note!.body != _bodyController.text) {
        noteTime = DateTime.now().microsecondsSinceEpoch;
      } else {
        noteTime = widget.note!.dateCreated.toInt();
      }
      var result = await db.update({
        columnId: widget.note!.id,
        columnTitle: _titleController.text,
        columnBody: _bodyController.text,
        columnDateCreated: noteTime,
        columnNoteColor: noteColor.toString()
      });

      if (result != null) {
        if (result != 0) {
          widget.refreshNotes();
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
            widget.refreshNotes();
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
