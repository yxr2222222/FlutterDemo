import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../model/BaseGetxController.dart';

class GetBuilderUtil {
  static StatefulWidget builder<T extends BaseGetxController>(
      OnGetBuilder<T> onGetBuilder,
      {T? init, String? id}) {
    return GetBuilder<T>(
        id: id,
        init: init,
        global: init == null,
        builder: (_) {
          return onGetBuilder(init ?? _);
        });
  }
}

typedef OnGetBuilder<T extends GetxController> = Widget Function(T controller);
