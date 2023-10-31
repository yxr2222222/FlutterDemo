import 'package:flutter/cupertino.dart';
import '../../vm/BaseListVM.dart';

class BaseItemWidget<T> extends StatefulWidget {
  final ChildItemBuilder<T> childItemBuilder;
  final T item;
  final OnItemClick<T>? onItemClick;
  final int index;

  const BaseItemWidget(
      {super.key,
      required this.childItemBuilder,
      required this.item,
      required this.index,
      this.onItemClick});

  @override
  State<StatefulWidget> createState() => BaseItemWidgetState<T>();
}

class BaseItemWidgetState<T> extends State<BaseItemWidget<T>> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (widget.onItemClick != null) {
            widget.onItemClick!(this, context);
          }
        },
        child: widget.childItemBuilder(this, context));
  }

  int get index => widget.index;

  T get item => widget.item;

  void refresh() {
    setState(() {});
  }
}