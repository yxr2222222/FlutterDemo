import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../model/ItemBinding.dart';
import '../vm/BaseListVM.dart';

class BaseListWidget<T, IB extends ItemBinding<T>> extends ListView {
  BaseListWidget.builder(BaseListVM<T, IB> viewModel,
      {super.key,
        required ChildItemBuilder<T, IB> childItemBuilder,
        OnItemClick<T, IB>? onItemClick})
      : super.builder(
      itemCount: viewModel.itemBindingList.length,
      itemBuilder: (context, index) {
        IB itemBinding = viewModel.itemBindingList[index];
        return ChangeNotifierProvider(
            create: (BuildContext context) => itemBinding,
            child: GestureDetector(
                onTap: () {
                  if (onItemClick != null) {
                    onItemClick(context, index, itemBinding);
                  }
                },
                child: Consumer<IB>(
                    builder: (BuildContext context, IB itemBinding,
                        Widget? child) =>
                        childItemBuilder(context, index, itemBinding))));
      });
}

typedef ChildItemBuilder<T, IB extends ItemBinding<T>> = Widget Function(
    BuildContext context, int index, IB itemBinding);

typedef OnItemClick<T, IB extends ItemBinding<T>> = void Function(
    BuildContext context, int index, IB itemBinding);
