import 'package:flutter/material.dart';
import 'package:yxr_flutter_basic/base/extension/BuildContextExtension.dart';
import 'package:yxr_flutter_basic/base/ui/page/BaseMultiStatePage.dart';
import 'package:yxr_flutter_basic/base/ui/widget/BaseItemWidget.dart';
import 'package:yxr_flutter_basic/base/vm/BaseListVM.dart';

class StaggeredGridPage extends BaseMultiPage {
  StaggeredGridPage({super.key});

  @override
  State<BaseMultiPage> createState() => _StaggeredGridState();
}

class _StaggeredGridState
    extends BaseMultiPageState<_StaggeredGridVM, StaggeredGridPage> {
  @override
  Widget createMultiContentWidget(
      BuildContext context, _StaggeredGridVM viewModel) {
    /// 快速构建存在item占不同列数的GridView，注意该方法不使用数据量特别多的情况
    /// 内部其实是SingleChildScrollView + StaggeredGrid
    return viewModel.staggeredGridBuilder(
        padding: const EdgeInsets.all(0),
        crossAxisCount: 3,
        mainAxisSpacing: 0.5,
        crossAxisSpacing: 0.5,
        staggeredGridTileBuilder: (item) {
          /// 构建不同类型的item所占的位置
          var i = item % 20;
          // 第二个参数可以通过比例来控制高度
          return i != 0
              ? StaggeredGridTileConfig(
                  crossAxisCellCount: 1, mainAxisCellCount: 1)
              : StaggeredGridTileConfig(
                  crossAxisCellCount: 3,
                  mainAxisCellCount: 48.0 / (context.getScreenWidth() / 3));
        },
        childItemBuilder: (item, context) {
          /// 构建item
          var i = item.item % 20;
          return Container(
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.center,
            color: i == 0 ? Colors.blue : Colors.green,
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
  _StaggeredGridVM createViewModel() => _StaggeredGridVM();
}

class _StaggeredGridVM extends BaseListVM<int> {
  @override
  void onCreate() {
    super.onCreate();
    appbarController.appbarTitle = "占不同列数的GridViewDemo";

    List<int> dataList = [];
    for (int i = 0; i < 100; i++) {
      dataList.add(i);
    }

    refreshData(isClear: true, dataList: dataList);
  }
}
