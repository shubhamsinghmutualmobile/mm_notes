import 'package:flutter/material.dart';

extension ContextUtils on BuildContext {
  void unFocus() => FocusScope.of(this).unfocus();
}
