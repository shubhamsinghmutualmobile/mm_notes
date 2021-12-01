import 'package:flutter/material.dart';
import 'package:mm_notes/models/note.dart';

Color getColorFromNote(Note? note, BuildContext context) {
  if (note != null) {
    if (note.noteColor == NoteColor.violet) {
      return Colors.deepPurple;
    } else if (note.noteColor == NoteColor.indigo) {
      return Colors.indigo;
    } else if (note.noteColor == NoteColor.blue) {
      return Colors.blue;
    } else if (note.noteColor == NoteColor.green) {
      return Colors.green;
    } else if (note.noteColor == NoteColor.yellow) {
      return Colors.yellow;
    } else if (note.noteColor == NoteColor.orange) {
      return Colors.orange;
    } else if (note.noteColor == NoteColor.red) {
      return Colors.red;
    } else {
      return Theme.of(context).cardColor;
    }
  } else {
    return Theme.of(context).cardColor;
  }
}

NoteColor getNoteColorFromString(String mapNote) {
  if (mapNote == NoteColor.violet.toString()) {
    return NoteColor.violet;
  } else if (mapNote == NoteColor.indigo.toString()) {
    return NoteColor.indigo;
  } else if (mapNote == NoteColor.blue.toString()) {
    return NoteColor.blue;
  } else if (mapNote == NoteColor.green.toString()) {
    return NoteColor.green;
  } else if (mapNote == NoteColor.yellow.toString()) {
    return NoteColor.yellow;
  } else if (mapNote == NoteColor.orange.toString()) {
    return NoteColor.orange;
  } else if (mapNote == NoteColor.red.toString()) {
    return NoteColor.red;
  } else {
    return NoteColor.grey;
  }
}
