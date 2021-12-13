import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mm_notes/controllers/landing_screen_controller.dart';
import 'package:mm_notes/screens/landing_screen/components/staggered_grid_view.dart';

class TrashScreen extends StatelessWidget {
  const TrashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LandingScreenController lsc = Get.put(LandingScreenController());

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        actions: [
          PopupMenuButton(
              itemBuilder: (context) => [
                    PopupMenuItem(
                      child: const Text("Empty Trash"),
                      onTap: () {
                        lsc.db.emptyTrash();
                        lsc.refreshListOfNotes(isTrashTable: true);
                      },
                    )
                  ],
              icon: Icon(
                Icons.more_vert,
                color: Get.textTheme.headline4?.color,
              ))
        ],
        leading: IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(
              Icons.menu,
              color: Get.textTheme.headline4?.color,
            )),
        title: const Text(
          "Trash",
        ),
        titleTextStyle: Get.textTheme.headline4?.copyWith(fontSize: 18),
        titleSpacing: 4,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: NotesGridView(
        isTrashTable: true,
      ),
    );
  }
}
