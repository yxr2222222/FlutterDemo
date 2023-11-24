import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:yxr_flutter_basic/base/ui/page/BaseMultiStatePage.dart';
import 'package:yxr_flutter_basic/base/vm/BaseListVM.dart';

class WaterfallGridPage extends BaseMultiPage {
  WaterfallGridPage({super.key});

  @override
  State<BaseMultiPage> createState() => _WaterfallGridState();
}

class _WaterfallGridState
    extends BaseMultiPageState<_WaterfallGridVM, WaterfallGridPage> {
  @override
  Widget createMultiContentWidget(
      BuildContext context, _WaterfallGridVM viewModel) {
    return viewModel.waterfallBuilder(
        padding: const EdgeInsets.all(0),
        mainAxisSpacing: 8,
        crossAxisSpacing: 4,
        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
        childItemBuilder: (item, context) {
          /// 构建item
          var i = item.item % 3;
          return Container(
            width: double.infinity,
            height: i == 0
                ? 128
                : i == 1
                    ? 64
                    : 256,
            alignment: Alignment.center,
            color: i == 0
                ? Colors.blue
                : i == 1
                    ? Colors.green
                    : Colors.red,
            child: Text(
              "index: ${item.item}",
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          );
        },
        onItemClick: (item, context) {
          showToast("index: ${item.item}");
        });
  }

  @override
  _WaterfallGridVM createViewModel() => _WaterfallGridVM();
}

class _WaterfallGridVM extends BaseListVM<int> {
  @override
  void onCreate() {
    super.onCreate();
    appbarController.appbarTitle = "瀑布流GridDemo";

    List<int> dataList = [];
    for (int i = 0; i < 100; i++) {
      dataList.add(i);
    }

    refreshData(isClear: true, dataList: dataList);
  }
}
