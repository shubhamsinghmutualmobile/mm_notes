import 'package:flutter/material.dart';

class FloatingBottomBar extends StatelessWidget {
  const FloatingBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Theme.of(context).backgroundColor,
      child: Row(
        children: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.check_box_outlined),
              splashRadius: 20),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.brush_outlined),
              splashRadius: 20),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.mic_none),
              splashRadius: 20),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.image_outlined),
              splashRadius: 20),
        ],
      ),
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
    );
  }
}
