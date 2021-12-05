import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreenController extends GetxController {

  var currentDeviceTheme = DeviceTheme.system.obs;

  void updateDeviceTheme(DeviceTheme userTheme) {
    Get.back();
    currentDeviceTheme.value = userTheme;
    _updateGetXThemeMode();
  }

  void _updateGetXThemeMode() {
    if(currentDeviceTheme.value == DeviceTheme.system) {
      Get.changeThemeMode(ThemeMode.system);
    }
    else if(currentDeviceTheme.value == DeviceTheme.dark) {
      Get.changeThemeMode(ThemeMode.dark);
    }
    else if(currentDeviceTheme.value == DeviceTheme.light) {
      Get.changeThemeMode(ThemeMode.light);
    }
  }

}

enum DeviceTheme {
  dark,
  light,
  system
}
