import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mm_notes/controllers/detail_screen_controller.dart';

const iconSplashRadius = 20.0;
const padding = 8.0;

Widget detailScreenTopBar(Function _insertOrUpdateNote) {
  final DetailScreenController dsc = Get.put(DetailScreenController());

  final _topPadding = Get.mediaQuery.padding.top;

  final _titleController = dsc.titleController.value;
  final _bodyController = dsc.bodyController.value;

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
                  _insertOrUpdateNote();
                },
                icon: const Icon(Icons.arrow_back),
                splashRadius: iconSplashRadius,
              ),
            ],
          ),
          Row(
            children: [
              Obx(
                () => IconButton(
                    onPressed: () {
                      dsc.isCurrentNotePinned.toggle();
                      dsc.updatePinnedIcon();
                      print(dsc.isCurrentNotePinned.value);
                    },
                    icon: dsc.pinnedIcon.value,
                    splashRadius: iconSplashRadius),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add_alert_outlined),
                  splashRadius: iconSplashRadius),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.archive_outlined),
                  splashRadius: iconSplashRadius),
              const SizedBox(width: padding)
            ],
          )
        ],
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: padding * 3),
          child: Column(
            children: [
              TextField(
                maxLines: null,
                controller: _titleController,
                decoration: const InputDecoration(
                    hintText: "Title", border: InputBorder.none),
                style: Get.textTheme.headline5,
              ),
              Expanded(
                child: TextField(
                  maxLines: null,
                  controller: _bodyController,
                  decoration: const InputDecoration(
                      hintText: "Note", border: InputBorder.none),
                  style: Get.textTheme.subtitle1,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
