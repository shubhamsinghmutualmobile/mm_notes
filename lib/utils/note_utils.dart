import 'package:flutter/material.dart';

Widget getPinnedIcon(bool isPinned) {
  if (isPinned) {
    return const Icon(
      Icons.push_pin,
      size: 20,
    );
  } else {
    return Container();
  }
}
