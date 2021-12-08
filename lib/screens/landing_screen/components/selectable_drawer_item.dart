import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mm_notes/controllers/landing_screen_controller.dart';
import 'package:mm_notes/screens/settings_screen/settings_screen.dart';

InkWell selectableDrawerItem(
    IconData icon, String text, bool isSelected, DrawerElements elementEnum) {
  final LandingScreenController lsc = Get.put(LandingScreenController());

  return InkWell(
    splashColor: Get.theme.primaryColor,
    onTap: () {
      lsc.updateSelectedDrawerElement(elementEnum);
      Get.back();
      Get.to(SettingsScreen(() {
        lsc.currentSelectedDrawerElement(DrawerElements.notes);
      }));
    },
    child: Card(
      margin: const EdgeInsets.only(top: 2, right: 4),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(32), bottomRight: Radius.circular(32))),
      elevation: 0,
      color: isSelected ? Get.theme.backgroundColor : Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 12,
            ),
            Icon(icon,
                color: isSelected
                    ? Get.theme.primaryColorDark
                    : Get.theme.textTheme.bodyText1!.color),
            const SizedBox(
              width: 16,
            ),
            Text(
              text,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: isSelected
                      ? Get.theme.primaryColorDark
                      : Get.theme.textTheme.bodyText1!.color),
            ),
          ],
        ),
      ),
    ),
  );
}
