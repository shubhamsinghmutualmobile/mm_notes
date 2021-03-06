import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mm_notes/controllers/landing_screen_controller.dart';
import 'package:mm_notes/screens/landing_screen/components/selectable_drawer_item.dart';

Drawer sideDrawer(double _topPadding) {
  final LandingScreenController lsc = Get.put(LandingScreenController());

  return Drawer(
    child: Obx(
      () => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: _topPadding,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12, left: 16),
              child: Row(
                children: const [
                  Text(
                    "Google",
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    " Keep",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            selectableDrawerItem(
                Icons.lightbulb_outline,
                "Notes",
                lsc.currentSelectedDrawerElement.value == DrawerElements.notes,
                DrawerElements.notes),
            selectableDrawerItem(
                Icons.notifications_none,
                "Reminders",
                lsc.currentSelectedDrawerElement.value ==
                    DrawerElements.reminders,
                DrawerElements.reminders),
            Divider(
              color: Get.theme.primaryColor,
              thickness: 1,
            ),
            selectableDrawerItem(
                Icons.archive_outlined,
                "Archive",
                lsc.currentSelectedDrawerElement.value ==
                    DrawerElements.archive,
                DrawerElements.archive),
            selectableDrawerItem(
                Icons.delete_outline,
                "Trash",
                lsc.currentSelectedDrawerElement.value == DrawerElements.trash,
                DrawerElements.trash),
            selectableDrawerItem(
                Icons.settings_outlined,
                "Settings",
                lsc.currentSelectedDrawerElement.value ==
                    DrawerElements.settings,
                DrawerElements.settings),
            selectableDrawerItem(
                Icons.help_outline,
                "Help & feedback",
                lsc.currentSelectedDrawerElement.value ==
                    DrawerElements.helpAndFeedback,
                DrawerElements.helpAndFeedback),
          ],
        ),
      ),
    ),
  );
}
