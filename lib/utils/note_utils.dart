import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mm_notes/models/note.dart';

Widget getPinnedIcon(bool isPinned) {
  if (isPinned) {
    return const Icon(
      Icons.push_pin,
      size: 16,
    );
  } else {
    return Container();
  }
}

Widget getPinnedIconForBodyOnlyNote(String noteTitle, bool isNotePinned) {
  if (noteTitle.isEmpty && isNotePinned) {
    return getPinnedIcon(isNotePinned);
  } else {
    return Container();
  }
}

Widget getCardBody(Note note) {
  if (note.body.isNotEmpty) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(child: Text(note.body, style: Get.textTheme.bodyText2)),
          getPinnedIconForBodyOnlyNote(note.title, note.isPinned)
        ],
      ),
    );
  } else {
    return Container();
  }
}

Widget getCardTitle(String noteTitle, bool isNotePinned) {
  if (noteTitle.isNotEmpty) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(child: Text(noteTitle, style: Get.textTheme.headline6)),
          getPinnedIcon(isNotePinned)
        ],
      ),
    );
  } else {
    return Container();
  }
}
