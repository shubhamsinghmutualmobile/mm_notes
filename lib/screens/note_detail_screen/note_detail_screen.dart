import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mm_notes/db/database_helper.dart';
import 'package:mm_notes/models/note.dart';
import 'package:mm_notes/utils/color_utils.dart';

class NoteDetailScreen extends StatefulWidget {
  final Note? note;
  final Function refreshNotes;

  const NoteDetailScreen(this.note, this.refreshNotes, {Key? key})
      : super(key: key);

  static const colorCardSize = 32.0;

  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  final String columnId = DatabaseHelper.columnId;

  final String columnTitle = DatabaseHelper.columnTitle;

  final String columnBody = DatabaseHelper.columnBody;

  final String columnDateCreated = DatabaseHelper.columnDateCreated;

  final String columnNoteColor = DatabaseHelper.columnNoteColor;

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

    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _bodyController.text = widget.note!.body;
      currentDate =
          DateTime.fromMicrosecondsSinceEpoch(widget.note!.dateCreated.toInt());
    }

    var formattedDate = DateFormat('dd-MM-yyyy (kk:mm:ss)').format(currentDate);

    const _iconSplashRadius = 20.0;
    const _padding = 8.0;

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
          child: Column(
            children: [
              SizedBox(height: _topPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          await _insertOrUpdateNote(
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
                        icon: const Icon(Icons.arrow_back),
                        splashRadius: _iconSplashRadius,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.push_pin_outlined),
                          splashRadius: _iconSplashRadius),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.add_alert_outlined),
                          splashRadius: _iconSplashRadius),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.archive_outlined),
                          splashRadius: _iconSplashRadius),
                      const SizedBox(width: _padding)
                    ],
                  )
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: _padding * 3),
                  child: Column(
                    children: [
                      TextField(
                        maxLines: null,
                        controller: _titleController,
                        decoration: const InputDecoration(
                            hintText: "Title", border: InputBorder.none),
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Expanded(
                        child: TextField(
                          maxLines: null,
                          controller: _bodyController,
                          decoration: const InputDecoration(
                              hintText: "Note", border: InputBorder.none),
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          color: currentNoteColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add_box_outlined),
                      splashRadius: _iconSplashRadius),
                  IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                            constraints: const BoxConstraints.tightForFinite(
                                height: 100),
                            backgroundColor: currentNoteColor,
                            context: context,
                            builder: (context) {
                              return Container(
                                padding: const EdgeInsets.only(top: 8, left: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8, left: 8, bottom: 8),
                                      child: Text(
                                        "Color",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: noteColorList
                                          .map((noteColor) => InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    Navigator.pop(context);
                                                    currentNoteColor =
                                                        noteColor;
                                                    currentNoteColorEnum =
                                                        getNoteColorFromColor(
                                                            noteColor);
                                                  });
                                                },
                                                child: Card(
                                                  shape: CircleBorder(
                                                      side: BorderSide(
                                                          width: 0.5,
                                                          color:
                                                              Theme.of(context)
                                                                      .textTheme
                                                                      .bodyText1
                                                                      ?.color ??
                                                                  Colors
                                                                      .black)),
                                                  elevation: 0,
                                                  color: noteColor,
                                                  child: const SizedBox(
                                                    width: NoteDetailScreen
                                                        .colorCardSize,
                                                    height: NoteDetailScreen
                                                        .colorCardSize,
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      icon: const Icon(Icons.color_lens_outlined),
                      splashRadius: _iconSplashRadius),
                ],
              ),
              Text("Edited at $formattedDate"),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert),
                  splashRadius: _iconSplashRadius),
            ],
          ),
        ),
      ),
    );
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
