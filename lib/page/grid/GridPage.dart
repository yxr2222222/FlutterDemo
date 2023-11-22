import 'package:flutter/material.dart';
import 'package:yxr_flutter_basic/base/ui/page/BaseMultiStatePage.dart';
import 'package:yxr_flutter_basic/base/vm/BaseListVM.dart';

class GridPage extends BaseMultiPage {
  GridPage({super.key});

  @override
  State<BaseMultiPage> createState() => _GridState();
}

class _GridState extends BaseMultiPageState<_GridVM, GridPage> {
  @override
  Widget createMultiContentWidget(BuildContext context, _GridVM viewModel) {
    /// 相比系统自带的GridView高度是可以自适应的
    return viewModel.gridBuilder(
        padding: const EdgeInsets.all(0),
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 4,
        childItemBuilder: (item, context) {
          /// 构建item
          var nextInt = item.item % 3;
          return Container(
            width: double.infinity,
            height: 128,
            alignment: Alignment.center,
            color: nextInt == 0
                ? Colors.blue
                : nextInt == 1
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
  _GridVM createViewModel() => _GridVM();
}

class _GridVM extends BaseListVM<int> {
  @override
  void onCreate() {
    super.onCreate();
    appbarController.appbarTitle = "GridViewDemo";

    List<int> dataList = [];
    for (int i = 0; i < 100; i++) {
      dataList.add(i);
    }

    refreshData(isClear: true, dataList: dataList);
  }
}
