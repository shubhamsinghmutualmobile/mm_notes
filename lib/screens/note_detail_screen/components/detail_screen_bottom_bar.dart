import 'package:flutter/material.dart';
import 'package:mm_notes/models/note.dart';

import 'bottom_color_sheet.dart';

const iconSplashRadius = 20.0;

Container detailScreenBottomBar(
    BuildContext context,
    String formattedDate,
    Color? currentNoteColor,
    NoteColor? currentNoteColorEnum,
    Function onColorTap) {
  return Container(
    color: currentNoteColor,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add_box_outlined),
                splashRadius: iconSplashRadius),
            IconButton(
                onPressed: () {
                  showBottomColorSheet(currentNoteColor, context, onColorTap);
                },
                icon: const Icon(Icons.color_lens_outlined),
                splashRadius: iconSplashRadius),
          ],
        ),
        Text("Edited at $formattedDate"),
        IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
            splashRadius: iconSplashRadius),
      ],
    ),
  );
}
