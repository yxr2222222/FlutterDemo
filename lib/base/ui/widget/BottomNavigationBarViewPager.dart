import 'package:flutter/material.dart';
import 'package:flutter_demo/base/model/SimpleGetxController.dart';
import 'package:flutter_demo/base/util/GetBuilderUtil.dart';

class BottomNavigationBarViewPager extends StatelessWidget {
  final List<ViewPagerData> viewPagerDataList;
  final Color normalTxtColor;
  final Color checkedTxtColor;
  final double normalTxtSize;
  final double checkedTxtSize;
  final bool normalTxtShow;
  final bool checkedTxtShow;
  final IconThemeData normalIconTheme;
  final IconThemeData checkedIconTheme;
  final int initIndex;
  final PageController pageController;
  final BottomNavigationBarType type;
  final bool canUserScroll;
  final SimpleGetxController<int> _currIndex = SimpleGetxController(0);

  BottomNavigationBarViewPager(
      {super.key,
      required this.viewPagerDataList,
      Color? normalTxtColor,
      Color? checkedTxtColor,
      this.normalTxtSize = 12.0,
      this.checkedTxtSize = 14.0,
      this.normalTxtShow = true,
      this.checkedTxtShow = true,
      IconThemeData? normalIconTheme,
      IconThemeData? checkedIconTheme,
      this.initIndex = 0,
      PageController? pageController,
      BottomNavigationBarType? type,
      bool? canUserScroll})
      : normalTxtColor = normalTxtColor ?? const Color(0xff999999),
        checkedTxtColor = checkedTxtColor ?? const Color(0xff333333),
        normalIconTheme = normalIconTheme ?? const IconThemeData(size: 24),
        checkedIconTheme = checkedIconTheme ?? const IconThemeData(size: 24),
        pageController =
            pageController ?? PageController(initialPage: initIndex),
        type = type ?? BottomNavigationBarType.fixed,
        canUserScroll = canUserScroll ?? true;

  int get currIndex => _currIndex.dataNotNull;

  set currIndex(int currIndex) {
    if (currIndex != _currIndex.data) {
      _currIndex.data = currIndex;
      pageController.jumpToPage(currIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    currIndex = initIndex;

    List<BottomNavigationBarItem> bottomNavigationBarItemList = [];
    for (var element in viewPagerDataList) {
      bottomNavigationBarItemList.add(element.bottomNavigationBarItem);
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: PageView.builder(
                itemBuilder: (context, index) => _getPageWidget(index),
                itemCount: viewPagerDataList.length,
                controller: pageController,
                physics:
                    canUserScroll ? null : const NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  currIndex = index;
                })),
        Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: GetBuilderUtil.builder(
              (controller) => BottomNavigationBar(
                    // 未选中颜色
                    unselectedItemColor: normalTxtColor,
                    // 选中颜色
                    selectedItemColor: checkedTxtColor,
                    // 未选中文字大小
                    unselectedFontSize: normalTxtSize,
                    // 选中文字大小
                    selectedFontSize: checkedTxtSize,
                    // 显示选中的文字
                    showSelectedLabels: checkedTxtShow,
                    // 显示不选中时的问题
                    showUnselectedLabels: normalTxtShow,
                    // 未选中图标主题
                    unselectedIconTheme: normalIconTheme,
                    // 选中图标主题
                    selectedIconTheme: checkedIconTheme,
                    // 当前下标
                    currentIndex: _currIndex.dataNotNull,
                    type: type,
                    onTap: (index) {
                      currIndex = index;
                    },
                    items: bottomNavigationBarItemList,
                  ),
              init: _currIndex),
        )
      ],
    );
  }

  Widget _getPageWidget(int index) {
    return viewPagerDataList[index].pageWidget;
  }
}

class ViewPagerData {
  final BottomNavigationBarItem bottomNavigationBarItem;
  final Widget pageWidget;

  ViewPagerData(
      {required this.pageWidget,
      required String label,
      required String icon,
      required String? activeIcon,
      double? width,
      double? height})
      : bottomNavigationBarItem = BottomNavigationBarItem(
            label: label,
            icon: _buildIcon(icon, width, height),
            activeIcon: _buildIcon(activeIcon ?? icon, width, height));

  static Widget _buildIcon(String icon, double? width, double? height) {
    return Image.asset(
      icon,
      width: width ?? 24,
      height: height ?? 24,
    );
  }
}
