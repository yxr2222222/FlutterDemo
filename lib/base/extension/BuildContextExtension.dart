import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

extension BuildContextExtension on BuildContext {
  void pop<T extends Object?>({T? result, bool cantPopExit = true}) {
    if (isUseful()) {
      if (Navigator.canPop(this)) {
        Navigator.pop(this, result);
      } else if (cantPopExit) {
        SystemNavigator.pop();
      }
    }
  }

  Future<T?> push<T>(Widget page, {bool finishCurr = false}) async {
    if (isUseful()) {
      if (finishCurr) {
        return Navigator.pushAndRemoveUntil(this,
            MaterialPageRoute(builder: (context) => page), (route) => true);
      } else {
        return Navigator.of(this)
            .push(MaterialPageRoute(builder: (context) => page));
      }
    }
    return null;
  }

  bool isUseful() {
    return mounted;
  }
}
