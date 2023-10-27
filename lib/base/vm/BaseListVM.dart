import 'package:flutter/material.dart';
import 'package:flutter_demo/base/vm/BaseMultiStateVM.dart';

import '../model/SimpleGetxController.dart';
import '../util/GetBuilderUtil.dart';
import '../widget/BaseItemWidget.dart';

abstract class BaseListVM<T> extends BaseMultiStateVM {
  final SimpleGetxController<List<T>> itemListController =
      SimpleGetxController([]);

  /// 刷新列表数据
  void refreshData({bool isClear = true, List<T>? dataList}) {
    var itemList = itemListController.data ?? [];
    if (isClear) {
      itemList = [];
    }
    itemList = List.from(itemList);
    itemList.addAll(dataList ?? []);
    itemListController.data = itemList;
  }

  /// 快速构建ListView
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

  /// 快速构建GridView
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

/// ListView/GridView item构建方法回调
typedef ChildItemBuilder<T> = Widget Function(
    BaseItemWidget<T> itemWidget, BuildContext context);

/// ListView/GridView item被点击方法回调
typedef OnItemClick<T> = void Function(
    BaseItemWidget<T> itemWidget, BuildContext context);
