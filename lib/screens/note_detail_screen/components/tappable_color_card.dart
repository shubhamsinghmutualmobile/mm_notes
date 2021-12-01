import 'package:flutter/material.dart';

const colorCardSize = 32.0;

Card tappableColorCard(BuildContext context, Color noteColor) {
  return Card(
    shape: CircleBorder(
        side: BorderSide(
            width: 0.5,
            color:
                Theme.of(context).textTheme.bodyText1?.color ?? Colors.black)),
    elevation: 0,
    color: noteColor,
    child: const SizedBox(
      width: colorCardSize,
      height: colorCardSize,
    ),
  );
}
