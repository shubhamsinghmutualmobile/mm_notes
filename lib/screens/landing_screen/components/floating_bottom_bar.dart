import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FloatingBottomBar extends StatelessWidget {
  const FloatingBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.theme;
    const _splashRadius = 20.0;
    const _notchMargin = 8.0;

    return BottomAppBar(
      color: Get.theme.backgroundColor,
      child: Row(
        children: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.check_box_outlined),
              splashRadius: _splashRadius),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.brush_outlined),
              splashRadius: _splashRadius),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.mic_none),
              splashRadius: _splashRadius),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.image_outlined),
              splashRadius: _splashRadius),
        ],
      ),
      shape: const CircularNotchedRectangle(),
      notchMargin: _notchMargin,
    );
  }
}
