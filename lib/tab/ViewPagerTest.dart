import 'package:flutter/material.dart';
import 'package:flutter_demo/base/vm/BaseMultiStateVM.dart';
import 'package:flutter_demo/base/widget/BaseMultiStateWidget.dart';
import 'package:flutter_demo/base/widget/BottomNavigationBarViewPager.dart';
import 'package:flutter_demo/tab/BasketPage.dart';
import 'package:flutter_demo/tab/HomePage.dart';
import 'package:flutter_demo/tab/KindPage.dart';
import 'package:flutter_demo/tab/MinePage.dart';

class ViewPagerTest extends BaseMultiStateWidget<_ViewPagerVM> {
  ViewPagerTest({super.key}) : super(viewModel: _ViewPagerVM());

  @override
  State<StatefulWidget> createState() => _ViewPagerTestState();
}

class _ViewPagerTestState
    extends BaseMultiStateWidgetState<_ViewPagerVM, ViewPagerTest> {
  @override
  Widget createContentView(BuildContext context, _ViewPagerVM viewModel) {
    List<ViewPagerData> viewPagerDataList = [
      ViewPagerData(
          pageWidget: HomePage(),
          label: "首页",
          icon: "images/homepage.png",
          activeIcon: "images/homepage-sel.png"),
      ViewPagerData(
          pageWidget: KindPage(),
          label: "分类",
          icon: "images/category.png",
          activeIcon: "images/category-sel.png"),
      ViewPagerData(
          pageWidget: BasketPage(),
          label: "购物车",
          icon: "images/basket.png",
          activeIcon: "images/basket-sel.png"),
      ViewPagerData(
          pageWidget: MinePage(),
          label: "我的",
          icon: "images/user.png",
          activeIcon: "images/user-sel.png")
    ];
    return BottomNavigationBarViewPager(
        viewPagerDataList: viewPagerDataList, canUserScroll: false);
  }
}

class _ViewPagerVM extends BaseMultiStateVM {}
