import 'package:flutter/material.dart';

Padding settingTitle(BuildContext context, String title) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Text(title, style: Theme.of(context).textTheme.subtitle2!.copyWith(color: Colors.blueAccent, fontWeight: FontWeight.w300),),
  );
}