import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mm_notes/controllers/settings_screen_controller.dart';

void themeDialog(BuildContext context, SettingsScreenController ssc) {
  Get.defaultDialog(
      cancel: Padding(
        padding: const EdgeInsets.only(right: 32, bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(onPressed: (){ Get.back(); }, child: Text("Cancel", style: Theme.of(context).textTheme.subtitle2!.copyWith(color: Theme.of(context).primaryColorDark)),)
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
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(
                        color: Theme.of(context).hintColor),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8,),
            themeOption(ssc, "Light", DeviceTheme.light, context),
            themeOption(ssc, "Dark", DeviceTheme.dark, context),
            themeOption(ssc, "System default", DeviceTheme.system, context),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text("To change the theme of your Keep widget and notifications, manage your Android screen and display settings.", style: TextStyle(color: Theme.of(context).hintColor),),
            )
          ],
        ),
      ));
}

InkWell themeOption(SettingsScreenController ssc, String radioText, DeviceTheme theme, BuildContext context) {
  return InkWell(
    onTap: () {
      ssc.updateDeviceTheme(theme);
    },
    child: Row(
      children: [
        const SizedBox(width: 12,),
        Radio(
            activeColor: Theme.of(context).primaryColorDark,
            value: theme,
            groupValue: ssc.currentDeviceTheme.value,
            onChanged: (DeviceTheme? value) { ssc.updateDeviceTheme(theme); }),
        const SizedBox(width: 16,),
        Text(radioText, style: TextStyle(color: Theme.of(context).hintColor),)
      ],
    ),
  );
}