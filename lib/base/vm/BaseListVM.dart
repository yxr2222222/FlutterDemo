import 'package:flutter_demo/base/vm/BaseMultiStateVM.dart';

import '../widget/BaseItemWidget.dart';

abstract class BaseListVM<T, IB extends ItemBinding<T>>
    extends BaseMultiStateVM {
  final List<IB> _itemBindingList = [];

  List<IB> get itemBindingList => _itemBindingList;

  void refreshData({bool isClear = true, List<IB>? dataList}) {
    if (isClear) {
      _itemBindingList.clear();
    }
    _itemBindingList.addAll(dataList ?? []);
    notifyListeners();
  }
}
