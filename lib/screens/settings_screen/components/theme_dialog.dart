import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mm_notes/controllers/settings_screen_controller.dart';

void themeDialog() {
  SettingsScreenController ssc = Get.put(SettingsScreenController());

  Get.defaultDialog(
      cancel: Padding(
        padding: const EdgeInsets.only(right: 32, bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text("Cancel",
                  style: Get.textTheme.subtitle2!
                      .copyWith(color: Get.theme.primaryColor)),
            )
          ],
        ),
      ),
      radius: 32,
      contentPadding: EdgeInsets.zero,
      title: "",
      titlePadding: EdgeInsets.zero,
      titleStyle: const TextStyle(fontSize: 0),
      content: Obx(
        () => Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 18, left: 24),
                  child: Text(
                    "Choose theme",
                    style: Get.textTheme.headline5!
                        .copyWith(color: Get.theme.hintColor),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            themeOption(ssc, "Light", DeviceTheme.light),
            themeOption(ssc, "Dark", DeviceTheme.dark),
            themeOption(ssc, "System default", DeviceTheme.system),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(
                "To change the theme of your Keep widget and notifications, manage your Android screen and display settings.",
                style: TextStyle(color: Get.theme.hintColor),
              ),
            )
          ],
        ),
      ));
}

InkWell themeOption(
    SettingsScreenController ssc, String radioText, DeviceTheme theme) {
  return InkWell(
    onTap: () {
      ssc.updateDeviceTheme(theme);
    },
    child: Row(
      children: [
        const SizedBox(
          width: 12,
        ),
        Radio(
            activeColor: Get.theme.primaryColor,
            value: theme,
            groupValue: ssc.currentDeviceTheme.value,
            onChanged: (DeviceTheme? value) {
              ssc.updateDeviceTheme(theme);
            }),
        const SizedBox(
          width: 16,
        ),
        Text(
          radioText,
          style: TextStyle(color: Get.theme.hintColor),
        )
      ],
    ),
  );
}
