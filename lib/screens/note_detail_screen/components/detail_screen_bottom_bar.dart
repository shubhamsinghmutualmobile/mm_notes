import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mm_notes/controllers/detail_screen_controller.dart';
import 'package:mm_notes/models/note.dart';
import 'package:mm_notes/utils/context_utils.dart';

import 'bottom_color_sheet.dart';
import 'menu_bottom_sheet.dart';

const iconSplashRadius = 20.0;

Widget detailScreenBottomBar(
    Function onColorTap, Note? note, BuildContext context,
    {bool isTrashNote = false}) {
  final DetailScreenController dsc = Get.put(DetailScreenController());
  final _bottomPadding = Get.mediaQuery.padding.bottom;
  var formattedDate =
      DateFormat('dd-MM-yyyy (kk:mm:ss)').format(dsc.currentDate);
  return Padding(
    padding: EdgeInsets.only(bottom: _bottomPadding),
    child: Material(
      type: MaterialType.transparency,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                  disabledColor: Get.textTheme.headline4?.color,
                  onPressed: isTrashNote
                      ? null
                      : () {
                          context.unFocus();
                        },
                  icon: const Icon(Icons.add_box_outlined),
                  splashRadius: iconSplashRadius),
              IconButton(
                  disabledColor: Get.textTheme.headline4?.color,
                  onPressed: isTrashNote
                      ? null
                      : () {
                          context.unFocus();
                          if (isTrashNote) {
                            editTrashNoteSnackBar(context);
                          } else {
                            showBottomColorSheet(onColorTap);
                          }
                        },
                  icon: const Icon(Icons.color_lens_outlined),
                  splashRadius: iconSplashRadius),
            ],
          ),
          Text("Edited at $formattedDate"),
          IconButton(
              onPressed: () {
                context.unFocus();
                menuBottomSheet(_bottomPadding, note, isTrashNote: isTrashNote);
              },
              icon: const Icon(Icons.more_vert),
              splashRadius: iconSplashRadius),
        ],
      ),
    ),
  );
}

void editTrashNoteSnackBar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    content: Text("Can't edit in Trash"),
    duration: Duration(seconds: 2),
  ));
}
