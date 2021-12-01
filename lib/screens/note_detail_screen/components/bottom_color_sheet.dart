import 'package:flutter/material.dart';
import 'package:mm_notes/screens/note_detail_screen/components/tappable_color_card.dart';
import 'package:mm_notes/utils/color_utils.dart';

void showBottomColorSheet(
    Color? currentNoteColor, BuildContext context, Function onColorTap) {
  showModalBottomSheet(
      constraints: const BoxConstraints.tightForFinite(height: 100),
      backgroundColor: currentNoteColor,
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.only(top: 8, left: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 8, bottom: 8),
                child: Text(
                  "Color",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: noteColorList
                    .map((noteColor) => InkWell(
                          onTap: () {
                            onColorTap(noteColor);
                          },
                          child: tappableColorCard(context, noteColor),
                        ))
                    .toList(),
              ),
            ],
          ),
        );
      });
}
