import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mm_notes/controllers/settings_screen_controller.dart';

import 'components/setting_row.dart';
import 'components/setting_title.dart';
import 'components/theme_dialog.dart';

class SettingsScreen extends StatelessWidget {
  final Function onBackPressed;

  const SettingsScreen(this.onBackPressed, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.theme; // Without this, themes don't rebuild correctly when user manually changes the theme
    final SettingsScreenController ssc = Get.put(SettingsScreenController());

    return WillPopScope(
      onWillPop: () {
        Get.back();
        return onBackPressed();
      },
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: Get.isDarkMode ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Get.isDarkMode ? Colors.white : Colors.black,
          titleSpacing: 0,
          title: const Text("Settings"),
        ),
        body: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              settingTitle("Display Options"),
              settingRow("Theme", ssc.currentDeviceThemeText.value, block: () {
                themeDialog();
              }),
              settingTitle("Reminder defaults"),
              settingRow("Morning", "8:00 AM"),
              settingRow("Afternoon", "1:00 PM"),
              settingRow("Evening", "6:00 PM"),
            ],
          ),
        ),
      ),
    );
  }
}
