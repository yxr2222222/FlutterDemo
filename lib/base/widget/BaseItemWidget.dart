import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter_demo/base/model/SimpleGetxController.dart';
import 'package:flutter_demo/base/util/Log.dart';
import '../vm/BaseListVM.dart';

class BaseItemWidget<T> extends StatelessWidget {
  final ChildItemBuilder<T> childItemBuilder;
  final T item;
  final OnItemClick<T>? onItemClick;
  final int index;
  final Map<String, SimpleGetxController<Object>> _controllerMap = HashMap();

  BaseItemWidget(
      {super.key,
      required this.childItemBuilder,
      required this.item,
      required this.index,
      this.onItemClick});

  SimpleGetxController<E> getController<E extends Object>(E defaultValue,
      {String? key}) {
    key = key ?? defaultValue.hashCode.toString();
    var controller = _controllerMap[key];
    if (controller == null) {
      controller = SimpleGetxController<E>(defaultValue);
      _controllerMap[key] = controller;
    }
    return controller as SimpleGetxController<E>;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (onItemClick != null) {
            onItemClick!(this, context);
          }
        },
        child: childItemBuilder(this, context));
  }
}

// class BaseItemWidget<T> extends StatefulWidget {
//   final ChildItemBuilder<T> childItemBuilder;
//   final T item;
//   final OnItemClick<T>? onItemClick;
//   final int index;
//
//   const BaseItemWidget(
//       {super.key,
//       required this.childItemBuilder,
//       required this.item,
//       required this.index,
//       this.onItemClick});
//
//   @override
//   State<StatefulWidget> createState() => _BaseItemWidgetState<T>();
// }
//
// class _BaseItemWidgetState<T> extends State<BaseItemWidget<T>> {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//         onTap: () {
//           if (widget.onItemClick != null) {
//             widget.onItemClick!(context, widget.index, widget.item);
//           }
//         },
//         child: widget.childItemBuilder(context, widget.index, widget.item));
//   }
// }
