import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreenController extends GetxController {
  static const deviceThemeSharedPref = "deviceTheme";
  static const deviceThemeSystem = "System default";
  static const deviceThemeDark = "Dark";
  static const deviceThemeLight = "Light";

  var currentDeviceTheme = DeviceTheme.system.obs;
  var currentDeviceThemeText = "".obs;
  SharedPreferences? sharedPrefs;

  @override
  void onInit() async {
    sharedPrefs = await SharedPreferences.getInstance();
    _updateCurrentDeviceTheme();
    super.onInit();
  }

  void updateDeviceTheme(DeviceTheme userTheme) {
    Get.back();
    currentDeviceTheme.value = userTheme;
    _updateGetXThemeMode();
  }

  void _updateGetXThemeMode() {
    if (currentDeviceTheme.value == DeviceTheme.system) {
      Get.changeThemeMode(ThemeMode.system);
      sharedPrefs?.setString(deviceThemeSharedPref, deviceThemeSystem);
    } else if (currentDeviceTheme.value == DeviceTheme.dark) {
      Get.changeThemeMode(ThemeMode.dark);
      sharedPrefs?.setString(deviceThemeSharedPref, deviceThemeDark);
    } else if (currentDeviceTheme.value == DeviceTheme.light) {
      Get.changeThemeMode(ThemeMode.light);
      sharedPrefs?.setString(deviceThemeSharedPref, deviceThemeLight);
    }
    _updateCurrentDeviceTheme();
  }

  void _updateCurrentDeviceTheme() {
    currentDeviceThemeText.value =
        sharedPrefs?.getString(deviceThemeSharedPref) ?? deviceThemeSystem;

    if (sharedPrefs?.getString(deviceThemeSharedPref) == deviceThemeSystem) {
      currentDeviceTheme.value = DeviceTheme.system;
    } else if (sharedPrefs?.getString(deviceThemeSharedPref) ==
        deviceThemeDark) {
      currentDeviceTheme.value = DeviceTheme.dark;
    } else if (sharedPrefs?.getString(deviceThemeSharedPref) ==
        deviceThemeLight) {
      currentDeviceTheme.value = DeviceTheme.light;
    }
  }
}

enum DeviceTheme { dark, light, system }
