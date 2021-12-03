import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mm_notes/controllers/detail_screen_controller.dart';
import 'package:mm_notes/screens/note_detail_screen/components/tappable_color_card.dart';
import 'package:mm_notes/utils/color_utils.dart';

void showBottomColorSheet(BuildContext context, Function onColorTap) {
  final DetailScreenController dsc = Get.put(DetailScreenController());
  var currentNoteColor = dsc.currentNoteColor;
  final _bottomPadding = MediaQuery.of(context).padding.bottom;

  showModalBottomSheet(
      constraints: BoxConstraints.tightForFinite(height: 100 + _bottomPadding),
      backgroundColor: currentNoteColor?.value,
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(top: 8, left: 8, bottom: _bottomPadding),
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
