import 'package:flutter/material.dart';

InkWell settingRow(String title, String value, {Function? block}) {
  var _rowTextStyle = const TextStyle(fontSize: 17);
  return InkWell(
    onTap: (){
      if(block != null) {
        block();
      }
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: _rowTextStyle,),
          Text(value, style: _rowTextStyle,),
        ],
      ),
    ),
  );
}