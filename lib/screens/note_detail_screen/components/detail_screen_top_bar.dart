import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mm_notes/controllers/detail_screen_controller.dart';

const iconSplashRadius = 20.0;
const padding = 8.0;

Widget detailScreenTopBar(Function _insertOrUpdateNote, Function _onNoteRestore,
    {bool isTrashNote = false}) {
  final DetailScreenController dsc = Get.put(DetailScreenController());

  final _topPadding = Get.mediaQuery.padding.top;

  final _titleController = dsc.titleController.value;
  final _bodyController = dsc.bodyController.value;

  return Material(
    type: MaterialType.transparency,
    child: Column(
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
            isTrashNote
                ? Container()
                : Row(
                    children: [
                      Obx(
                        () => IconButton(
                            onPressed: isTrashNote
                                ? null
                                : () {
                                    dsc.isCurrentNotePinned.toggle();
                                    dsc.updatePinnedIcon();
                                    print(dsc.isCurrentNotePinned.value);
                                  },
                            icon: dsc.pinnedIcon.value,
                            splashRadius: iconSplashRadius),
                      ),
                      IconButton(
                          onPressed: isTrashNote ? null : () {},
                          icon: const Icon(Icons.add_alert_outlined),
                          splashRadius: iconSplashRadius),
                      IconButton(
                          onPressed: isTrashNote ? null : () {},
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
                GestureDetector(
                  onTap: () {
                    if (isTrashNote) {
                      editTrashNoteSnackBar(Get.context!,
                          onNoteRestore: _onNoteRestore);
                    }
                  },
                  child: TextField(
                    enabled: !isTrashNote,
                    maxLines: null,
                    controller: _titleController,
                    decoration: const InputDecoration(
                        hintText: "Title", border: InputBorder.none),
                    style: Get.textTheme.headline5,
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (isTrashNote) {
                        editTrashNoteSnackBar(Get.context!,
                            onNoteRestore: _onNoteRestore);
                      }
                    },
                    child: TextField(
                      enabled: !isTrashNote,
                      maxLines: null,
                      controller: _bodyController,
                      decoration: const InputDecoration(
                          hintText: "Note", border: InputBorder.none),
                      style: Get.textTheme.subtitle1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

void editTrashNoteSnackBar(BuildContext context, {Function? onNoteRestore}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Can't edit in Trash"),
        InkWell(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text("Restore",
                style: TextStyle(color: Get.theme.primaryColorDark)),
          ),
          onTap: () {
            onNoteRestore?.call();
          },
        )
      ],
    ),
    duration: const Duration(seconds: 2),
  ));
}
