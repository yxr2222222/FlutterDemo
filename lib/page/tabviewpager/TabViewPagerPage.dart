import 'package:flutter/material.dart';
import 'package:flutter_demo/page/tabviewpager/TabViewPagerChildPage.dart';
import 'package:yxr_flutter_basic/base/model/controller/SimpleGetxController.dart';
import 'package:yxr_flutter_basic/base/ui/page/BaseMultiStatePage.dart';
import 'package:yxr_flutter_basic/base/ui/widget/TabbarViewPager.dart';
import 'package:yxr_flutter_basic/base/util/GetBuilderUtil.dart';
import 'package:yxr_flutter_basic/base/vm/BaseMultiVM.dart';

class TabViewPagerPage extends BaseMultiPage {
  TabViewPagerPage({super.key});

  @override
  State<BaseMultiPage> createState() => _TabViewPagerState();
}

class _TabViewPagerState
    extends BaseMultiPageState<_TabViewPagerVM, TabViewPagerPage> {
  @override
  _TabViewPagerVM createViewModel() => _TabViewPagerVM();

  @override
  Widget createMultiContentWidget(
      BuildContext context, _TabViewPagerVM viewModel) {
    return GetBuilderUtil.builder(
        (controller) => TabbarViewPager(
              controller.data ?? [],
              tabbarIndicatorColor: const Color(0xffef4e4e),
              preNextPage: true,
              onPageChanged: (index) {
                viewModel.currPageController.data = index;
              },
            ),
        init: viewModel.tabbarController);
  }
}

class _TabViewPagerVM extends BaseMultiVM {
  final SimpleGetxController<List<TabbarViewPagerData>> tabbarController =
      SimpleGetxController([]);
  final SimpleGetxController<int> currPageController = SimpleGetxController(0);

  @override
  void onCreate() {
    super.onCreate();
    appbarController.appbarTitle = "TabbarViewPager示例";

    _mockTabbarData();
  }

  /// 模拟Tabbar的数据
  void _mockTabbarData() {
    showLoadingState();
    Future.delayed(const Duration(seconds: 2), () {
      showContentState();

      List<TabbarViewPagerData> dataList = [];
      for (int i = 0; i < 10; i++) {
        dataList.add(TabbarViewPagerData(
            _buildTab("Title $i"),

            /// ViewPager的内容控件通过GetBuilder绑定，页面改变时用来更新wantKeepAlive
            GetBuilderUtil.builder(
                (controller) => TabViewPagerChildPage(
                      title: "Title $i",
                      pageIndex: i,
                      currPage: controller.dataNotNull,
                    ),
                init: currPageController)));
      }
      tabbarController.data = dataList;
    });
  }

  /// 创建tab子控件
  Widget _buildTab(String title) => Container(
        alignment: Alignment.center,
        height: 48,
        child: Text(
          title,
          style: const TextStyle(color: Colors.black, fontSize: 16),
        ),
      );
}
