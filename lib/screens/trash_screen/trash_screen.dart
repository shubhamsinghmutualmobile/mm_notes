import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrashScreen extends StatelessWidget {
  const TrashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.more_vert, color: Get.textTheme.headline4?.color,))
        ],
        leading: IconButton(onPressed: () {
          Scaffold.of(context).openDrawer();
        }, icon: Icon(Icons.menu, color: Get.textTheme.headline4?.color,)),
        title: const Text("Trash",),
        titleTextStyle: Get.textTheme.headline4?.copyWith(fontSize: 18),
        titleSpacing: 4,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
