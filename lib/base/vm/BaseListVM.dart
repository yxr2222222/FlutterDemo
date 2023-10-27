import 'package:flutter/material.dart';
import 'package:flutter_demo/base/vm/BaseMultiStateVM.dart';

import '../model/SimpleGetxController.dart';
import '../util/GetBuilderUtil.dart';
import '../widget/BaseItemWidget.dart';

abstract class BaseListVM<T> extends BaseMultiStateVM {
  final SimpleGetxController<List<T>> itemListController =
      SimpleGetxController([]);

  void refreshData({bool isClear = true, List<T>? dataList}) {
    var itemList = itemListController.data ?? [];
    if (isClear) {
      itemList = [];
    }
    itemList = List.from(itemList);
    itemList.addAll(dataList ?? []);
    itemListController.data = itemList;
  }

  Widget listBuilder(
      {required ChildItemBuilder<T> childItemBuilder,
      OnItemClick<T>? onItemClick}) {
    return GetBuilderUtil.builder<SimpleGetxController<List<T>>>(
        (controller) => ListView.builder(
            itemCount: controller.dataNotNull.length,
            itemBuilder: (context, index) {
              T item = controller.dataNotNull[index];
              return BaseItemWidget(
                  childItemBuilder: childItemBuilder,
                  item: item,
                  index: index,
                  onItemClick: onItemClick);
            }),
        init: itemListController);
  }

  Widget gridBuilder(
      {required SliverGridDelegate gridDelegate,
      required ChildItemBuilder<T> childItemBuilder,
      OnItemClick<T>? onItemClick}) {
    return GetBuilderUtil.builder<SimpleGetxController<List<T>>>(
        (controller) => GridView.builder(
            gridDelegate: gridDelegate,
            itemCount: controller.dataNotNull.length,
            itemBuilder: (context, index) {
              T item = controller.dataNotNull[index];
              return BaseItemWidget(
                  childItemBuilder: childItemBuilder,
                  item: item,
                  index: index,
                  onItemClick: onItemClick);
            }),
        init: itemListController);
  }
}

typedef ChildItemBuilder<T> = Widget Function(
    BaseItemWidget<T> itemWidget, BuildContext context);

typedef OnItemClick<T> = void Function(
    BaseItemWidget<T> itemWidget, BuildContext context);
