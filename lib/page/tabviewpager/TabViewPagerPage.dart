import 'package:flutter/material.dart';
import 'package:flutter_demo/page/tabviewpager/TabViewPagerChildPage.dart';
import 'package:yxr_flutter_basic/base/model/controller/SimpleGetxController.dart';
import 'package:yxr_flutter_basic/base/ui/page/BaseMultiStatePage.dart';
import 'package:yxr_flutter_basic/base/ui/page/BasePageViewPage.dart';
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
  final KeepAliveController _keepAliveController = KeepAliveController();

  @override
  _TabViewPagerVM createViewModel() => _TabViewPagerVM();

  @override
  Widget createMultiContentWidget(
      BuildContext context, _TabViewPagerVM viewModel) {
    return GetBuilderUtil.builder((controller) {
      List<String> tabList = [];
      for (var element in controller.dataNotNull) {
        tabList.add(element.title);
      }
      return TabbarViewPager(
        tabList: tabList,
        onPageBuilder: (context, index) => TabViewPagerChildPage(
          title: controller.dataNotNull[index].content,
          pageIndex: index,
          keepAliveController: _keepAliveController,
        ),

        /// onTabBuilder为空则使用默认的tab视图
        onTabBuilder: (context, index, title) => _buildTab(title),
        tabbarIndicatorColor: const Color(0xffef4e4e),
        preNextPage: true,
        onPageChanged: (index) {
          _keepAliveController.changePage(index);
        },
      );
    }, init: viewModel.tabbarController);
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

class _TabViewPagerVM extends BaseMultiVM {
  final SimpleGetxController<List<TabData>> tabbarController =
      SimpleGetxController([]);

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

      List<TabData> dataList = [];
      for (int i = 0; i < 10; i++) {
        dataList.add(TabData("Title $i", "content $i"));
      }
      tabbarController.data = dataList;
    });
  }
}

class TabData {
  final String title;
  final String content;

  TabData(this.title, this.content);
}
