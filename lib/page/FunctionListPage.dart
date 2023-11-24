import 'package:flutter/material.dart';
import 'package:flutter_demo/page/event/EventPage1.dart';
import 'package:flutter_demo/page/grid/GridPage.dart';
import 'package:flutter_demo/page/grid/StaggeredGridPage.dart';
import 'package:flutter_demo/page/grid/WaterfallGridPage.dart';
import 'package:flutter_demo/page/product/ProductListPage.dart';
import 'package:flutter_demo/page/tabviewpager/TabViewPagerPage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yxr_flutter_basic/base/extension/BuildContextExtension.dart';
import 'package:yxr_flutter_basic/base/model/PermissionReq.dart';
import 'package:yxr_flutter_basic/base/ui/page/BaseMultiStatePage.dart';
import 'package:yxr_flutter_basic/base/ui/page/SimpleWebPage.dart';
import 'package:yxr_flutter_basic/base/vm/BaseListVM.dart';

import 'bottomtviewpager/BottomNavigationBarViewPagerPage.dart';

class FunctionListPage extends BaseMultiPage {
  FunctionListPage({super.key});

  @override
  State<BaseMultiPage> createState() => _FunctionListState();
}

class _FunctionListState
    extends BaseMultiPageState<_FunctionListPageVM, FunctionListPage> {
  @override
  _FunctionListPageVM createViewModel() => _FunctionListPageVM();

  @override
  Widget createMultiContentWidget(
      BuildContext context, _FunctionListPageVM viewModel) {
    return viewModel.listBuilder(
      childItemBuilder: (itemWidget, context) {
        return Container(
            width: double.infinity,
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: itemWidget.item.background),
            margin: const EdgeInsets.only(top: 0.5),
            child: Text(
              itemWidget.item.title,
              style: const TextStyle(fontSize: 16, color: Color(0xff333333)),
            ));
      },
      onItemClick: (item, context) {
        if (_FunctionListPageVM.PERMISSION == item.item.title) {
          viewModel.requestPermission(PermissionReq(
              [Permission.camera, Permission.location], onGranted: () {
            showToast("权限申请成功");
          }, onDenied: (isPermanentlyDenied) {
            showToast("权限申请失败,是否被多次拒绝或永久拒绝: $isPermanentlyDenied");
          }));
        } else if (_FunctionListPageVM.LIVE_EVENT == item.item.title) {
          context.push(EventPage1());
        } else if (_FunctionListPageVM.PRODUCT_LIST == item.item.title) {
          context.push(ProductListPage());
        } else if (_FunctionListPageVM.BOTTOM_VIEW_PAGER == item.item.title) {
          context.push(BottomNavigationBarViewPagerPage());
        } else if (_FunctionListPageVM.TABBAR_VIEW_PAGER == item.item.title) {
          context.push(TabViewPagerPage());
        } else if (_FunctionListPageVM.GRID_VIEW == item.item.title) {
          context.push(GridPage());
        } else if (_FunctionListPageVM.WATERFALL_GRID_VIEW == item.item.title) {
          context.push(WaterfallGridPage());
        } else if (_FunctionListPageVM.STAGGERED_GRID_VIEW == item.item.title) {
          context.push(StaggeredGridPage());
        } else if (_FunctionListPageVM.WEB_VIEW == item.item.title) {
          context.push(SimpleWebPage(
            url: "https://www.aliyun.com/",
            title: "WebView示例",
          ));
        }
      },
    );
  }
}

class _FunctionListPageVM extends BaseListVM<MainTitle> {
  static const String PRODUCT_LIST = "商品列表界面";
  static const String PERMISSION = "权限申请";
  static const String LIVE_EVENT = "LiveEvent";
  static const String BOTTOM_VIEW_PAGER = "BottomNavigationBarViewPager";
  static const String TABBAR_VIEW_PAGER = "TabbarViewPager";
  static const String GRID_VIEW = "GridView";
  static const String WATERFALL_GRID_VIEW = "WaterfallGridView";
  static const String STAGGERED_GRID_VIEW = "StaggeredGridView";
  static const String WEB_VIEW = "WebView";

  @override
  void onCreate() {
    super.onCreate();

    appbarController.appbarBackIcon = null;
    appbarController.appbarTitle = "FlutterDemo";

    refreshData(isClear: true, dataList: [
      MainTitle(PRODUCT_LIST),
      MainTitle(PERMISSION),
      MainTitle(LIVE_EVENT),
      MainTitle(BOTTOM_VIEW_PAGER),
      MainTitle(TABBAR_VIEW_PAGER),
      MainTitle(GRID_VIEW),
      MainTitle(WATERFALL_GRID_VIEW),
      MainTitle(STAGGERED_GRID_VIEW),
      MainTitle(WEB_VIEW),
    ]);
  }

  @override
  Future<bool> onBackPressed() async => false;
}

class MainTitle {
  final String title;
  Color background = Colors.white;

  MainTitle(this.title);
}
