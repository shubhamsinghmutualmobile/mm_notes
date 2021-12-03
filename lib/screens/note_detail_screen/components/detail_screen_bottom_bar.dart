import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mm_notes/controllers/detail_screen_controller.dart';

import 'bottom_color_sheet.dart';

const iconSplashRadius = 20.0;

Widget detailScreenBottomBar(BuildContext context, Function onColorTap) {
  final DetailScreenController dsc = Get.put(DetailScreenController());
  var formattedDate =
      DateFormat('dd-MM-yyyy (kk:mm:ss)').format(dsc.currentDate);
  return Row(
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
                showBottomColorSheet(context, onColorTap);
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
  );
}
