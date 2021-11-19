import 'package:flutter/material.dart';

class NoteDetailScreen extends StatelessWidget {
  const NoteDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _titleController = TextEditingController();
    final _bodyController = TextEditingController();

    const _iconSplashRadius = 20.0;
    const _padding = 8.0;

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: kToolbarHeight + _padding),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                    splashRadius: _iconSplashRadius,
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.push_pin_outlined),
                      splashRadius: _iconSplashRadius),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add_alert_outlined),
                      splashRadius: _iconSplashRadius),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.archive_outlined),
                      splashRadius: _iconSplashRadius),
                  const SizedBox(width: _padding)
                ],
              )
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: _padding * 3),
              child: Column(
                children: [
                  TextField(
                    maxLines: null,
                    controller: _titleController,
                    decoration: const InputDecoration(
                        hintText: "Title", border: InputBorder.none),
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Expanded(
                    child: TextField(
                      maxLines: null,
                      controller: _bodyController,
                      decoration: const InputDecoration(
                          hintText: "Note", border: InputBorder.none),
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add_box_outlined),
                  splashRadius: _iconSplashRadius),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.color_lens_outlined),
                  splashRadius: _iconSplashRadius),
            ],
          ),
          const Text("Edited at 9:15 PM"),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
              splashRadius: _iconSplashRadius),
        ],
      ),
    );
  }
}
