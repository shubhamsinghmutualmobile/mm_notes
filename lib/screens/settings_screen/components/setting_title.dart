import 'package:flutter/material.dart';
import 'package:get/get.dart';

Padding settingTitle(String title) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Text(title, style: Get.textTheme.subtitle2!.copyWith(color: Colors.blueAccent, fontWeight: FontWeight.w300),),
  );
}