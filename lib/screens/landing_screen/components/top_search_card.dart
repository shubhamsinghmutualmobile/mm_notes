import 'package:flutter/material.dart';

class TopSearchCard extends StatelessWidget with PreferredSizeWidget {
  const TopSearchCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: kToolbarHeight),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          const SizedBox(height: 6),
          Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              elevation: 4,
              child: InkWell(
                customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32)),
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.menu),
                          splashRadius: 20,
                        ),
                        Text("Search your notes",
                            style: Theme.of(context).textTheme.subtitle1),
                      ],
                    ),
                    // Circular profile button
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.view_agenda_outlined),
                          splashRadius: 20,
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 8.0),
                          child: Card(
                            elevation: 0.1,
                            shape: const CircleBorder(),
                            child: InkWell(
                              customBorder: const CircleBorder(),
                              child: const Padding(
                                padding: EdgeInsets.all(6.0),
                                child: Icon(Icons.person),
                              ),
                              onTap: () {},
                            ),
                            color: Theme.of(context).backgroundColor,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
