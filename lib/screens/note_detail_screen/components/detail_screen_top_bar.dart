import 'package:flutter/material.dart';
import 'package:mm_notes/db/database_helper.dart';
import 'package:mm_notes/models/note.dart';

const iconSplashRadius = 20.0;
const padding = 8.0;

Column detailScreenTopBar(
    double _topPadding,
    BuildContext context,
    DatabaseHelper db,
    String columnTitle,
    TextEditingController _titleController,
    String columnBody,
    TextEditingController _bodyController,
    String columnDateCreated,
    String columnId,
    String columnNoteColor,
    NoteColor? currentNoteColorEnum,
    Function _insertOrUpdateNote) {
  return Column(
    children: [
      SizedBox(height: _topPadding),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  _insertOrUpdateNote(
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
                splashRadius: iconSplashRadius,
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.push_pin_outlined),
                  splashRadius: iconSplashRadius),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add_alert_outlined),
                  splashRadius: iconSplashRadius),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.archive_outlined),
                  splashRadius: iconSplashRadius),
              SizedBox(width: padding)
            ],
          )
        ],
      ),
      Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding * 3),
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
  );
}
