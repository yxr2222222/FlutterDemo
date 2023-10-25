import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  void pop<T extends Object?>([T? result]) {
    if (isUseful() && Navigator.canPop(this)) {
      Navigator.pop(this, result);
    }
  }

  void push(Widget page) {
    if (isUseful()) {
      Navigator.of(this).push(MaterialPageRoute(builder: (context) => page));
    }
  }

  bool isUseful() {
    return mounted;
  }
}
