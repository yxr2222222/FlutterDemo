import 'package:flutter/material.dart';
import 'package:flutter_demo/page/ProductDetailPage.dart';
import 'package:flutter_demo/page/ProductListPage.dart';
import 'package:flutter_demo/page/tab/ViewPagerTest.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yxr_flutter_basic/base/extension/BuildContextExtension.dart';
import 'package:yxr_flutter_basic/base/model/PermissionReq.dart';
import 'package:yxr_flutter_basic/base/ui/page/BaseMultiStatePage.dart';
import 'package:yxr_flutter_basic/base/ui/page/SimpleWebPage.dart';
import 'package:yxr_flutter_basic/base/vm/BaseListVM.dart';

class FunctionListPage extends BaseMultiPage<_FunctionListPageVM> {
  FunctionListPage({super.key}) : super(viewModel: _FunctionListPageVM());

  @override
  State<FunctionListPage> createState() => _FunctionListState();
}

class _FunctionListState
    extends BaseMultiPageState<_FunctionListPageVM, FunctionListPage> {
  @override
  Widget createMultiContentWidget(
      BuildContext context, _FunctionListPageVM viewModel) {
    return viewModel.listBuilder(
      onItemClick: (item, context) {
        if (_FunctionListPageVM.PERMISSION == item.item.title) {
          viewModel.requestPermission(PermissionReq(
              [Permission.camera, Permission.location], onGranted: () {
            showToast("权限申请成功");
          }, onDenied: (isPermanentlyDenied) {
            showToast("权限申请失败,是否被多次拒绝或永久拒绝: $isPermanentlyDenied");
          }));
        } else if (_FunctionListPageVM.PRODUCT_LIST == item.item.title) {
          context.push(ProductListPage());
        } else if (_FunctionListPageVM.VIEW_PAGER == item.item.title) {
          context.push(ViewPagerTest());
        } else if (_FunctionListPageVM.WEB_VIEW == item.item.title) {
          context.push(SimpleWebPage(
            url: "https://www.aliyun.com/",
            title: "WebView示例",
          ));
        }
      },
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
    );
  }
}

class _FunctionListPageVM extends BaseListVM<MainTitle> {
  static const String PRODUCT_LIST = "商品列表界面";
  static const String PERMISSION = "权限申请";
  static const String VIEW_PAGER = "ViewPager";
  static const String WEB_VIEW = "WebView";

  @override
  void onCreate() {
    super.onCreate();

    appbarController.appbarBackIcon = null;
    appbarController.appbarTitle = "FlutterDemo";

    refreshData(isClear: true, dataList: [
      MainTitle(PRODUCT_LIST),
      MainTitle(PERMISSION),
      MainTitle(VIEW_PAGER),
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
