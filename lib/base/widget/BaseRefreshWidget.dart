import 'package:flutter_demo/base/vm/BasePageListVM.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../model/ItemBinding.dart';
import 'BaseListWidget.dart';

class BaseRefreshWidget<T, IB extends ItemBinding<T>> extends SmartRefresher {
  BaseRefreshWidget(BasePageListVM<T, IB> viewModel,
      {super.key,
      required ChildItemBuilder<T, IB> childItemBuilder,
      OnItemClick<T, IB>? onItemClick,
      super.enablePullUp = true})
      : super(
            controller: viewModel.refreshController,
            header: const ClassicHeader(),
            footer: const ClassicFooter(),
            onRefresh: () => viewModel.onRefresh(),
            onLoading: () => viewModel.onLoadMore(),
            child: BaseListWidget<T, IB>.builder(
              viewModel,
              childItemBuilder: childItemBuilder,
            ));
}
