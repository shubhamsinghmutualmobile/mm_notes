import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mm_notes/controllers/landing_screen_controller.dart';

InkWell selectableDrawerItem(IconData icon, String text, BuildContext context,
    bool isSelected, DrawerElements elementEnum) {
  final LandingScreenController lsc = Get.put(LandingScreenController());

  return InkWell(
    splashColor: Theme.of(context).primaryColor,
    onTap: () {
      lsc.updateSelectedDrawerElement(elementEnum);
      Navigator.pop(context);
    },
    child: Card(
      margin: const EdgeInsets.only(top: 4, right: 4, bottom: 4),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(32), bottomRight: Radius.circular(32))),
      elevation: 0,
      color:
          isSelected ? Theme.of(context).backgroundColor : Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 12,
            ),
            Icon(icon,
                color: isSelected
                    ? Theme.of(context).primaryColorDark
                    : Theme.of(context).textTheme.bodyText1!.color),
            const SizedBox(
              width: 18,
            ),
            Text(
              text,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: isSelected
                      ? Theme.of(context).primaryColorDark
                      : Theme.of(context).textTheme.bodyText1!.color),
            ),
          ],
        ),
      ),
    ),
  );
}
