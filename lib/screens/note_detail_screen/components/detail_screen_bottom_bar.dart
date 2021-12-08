import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mm_notes/controllers/detail_screen_controller.dart';

import 'bottom_color_sheet.dart';

const iconSplashRadius = 20.0;

Widget detailScreenBottomBar(Function onColorTap) {
  final DetailScreenController dsc = Get.put(DetailScreenController());
  final _bottomPadding = Get.mediaQuery.padding.bottom;
  var formattedDate =
      DateFormat('dd-MM-yyyy (kk:mm:ss)').format(dsc.currentDate);
  return Padding(
    padding: EdgeInsets.only(bottom: _bottomPadding),
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
                  showBottomColorSheet(onColorTap);
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
