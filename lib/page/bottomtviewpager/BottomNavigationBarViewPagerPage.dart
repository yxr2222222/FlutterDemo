import 'package:flutter/material.dart';
import 'package:yxr_flutter_basic/base/ui/page/BaseMultiStatePage.dart';
import 'package:yxr_flutter_basic/base/ui/widget/BottomNavigationBarViewPager.dart';
import 'package:yxr_flutter_basic/base/vm/BaseMultiVM.dart';

import 'TabBasketPage.dart';
import 'TabHomePage.dart';
import 'TabKindPage.dart';
import 'TabMinePage.dart';

class BottomNavigationBarViewPagerPage extends BaseMultiPage<_BottomNavigationBarViewPagerVM> {
  BottomNavigationBarViewPagerPage({super.key}) : super(viewModel: _BottomNavigationBarViewPagerVM());

  @override
  State<StatefulWidget> createState() => _BottomNavigationBarViewPagerState();
}

class _BottomNavigationBarViewPagerState
    extends BaseMultiPageState<_BottomNavigationBarViewPagerVM, BottomNavigationBarViewPagerPage> {
  @override
  Widget createMultiContentWidget(BuildContext context, _BottomNavigationBarViewPagerVM viewModel) {
    List<ViewPagerData> viewPagerDataList = [
      ViewPagerData(
          pageWidget: TabHomePage(),
          label: "首页",
          icon: "images/homepage.png",
          activeIcon: "images/homepage-sel.png"),
      ViewPagerData(
          pageWidget: TabKindPage(),
          label: "分类",
          icon: "images/category.png",
          activeIcon: "images/category-sel.png"),
      ViewPagerData(
          pageWidget: TabBasketPage(),
          label: "购物车",
          icon: "images/basket.png",
          activeIcon: "images/basket-sel.png"),
      ViewPagerData(
          pageWidget: TabMinePage(),
          label: "我的",
          icon: "images/user.png",
          activeIcon: "images/user-sel.png")
    ];
    return BottomNavigationBarViewPager(
        viewPagerDataList: viewPagerDataList, canUserScroll: false);
  }
}

class _BottomNavigationBarViewPagerVM extends BaseMultiVM {
  @override
  void onCreate() {
    super.onCreate();
    appbarController.appbarTitle = "BottomNavigationBarViewPager示例";
  }
}
