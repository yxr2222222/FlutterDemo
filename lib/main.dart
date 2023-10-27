import 'package:flutter/material.dart';
import 'package:flutter_demo/HttpTestWidget.dart';
import 'package:flutter_demo/RefreshLoadTestWidget.dart';
import 'package:flutter_demo/base/extension/BuildContextExtension.dart';
import 'package:flutter_demo/base/model/PermissionReq.dart';
import 'package:flutter_demo/base/util/GetBuilderUtil.dart';
import 'package:flutter_demo/base/vm/BaseListVM.dart';
import 'package:flutter_demo/base/widget/BaseMultiStateWidget.dart';
import 'package:flutter_demo/tab/ViewPagerTest.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:permission_handler/permission_handler.dart';
import 'base/http/HttpManager.dart';
import 'base/http/model/BaseRespConfig.dart';

void main() {
  HttpManager.getInstance().init("http://192.168.1.130:8089/", true,
      BaseRespConfig(filedCode: "code", filedMsg: "message"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: _MyHomePage(),
    );
  }
}

class _MyHomePage extends BaseMultiStateWidget<_MyHomePageVM> {
  _MyHomePage() : super(viewModel: _MyHomePageVM());

  @override
  State<_MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState
    extends BaseMultiStateWidgetState<_MyHomePageVM, _MyHomePage> {
  @override
  Widget createContentView(BuildContext context, _MyHomePageVM viewModel) {
    return viewModel.listBuilder(
      onItemClick: (itemWidget, context) {
        if (_MyHomePageVM.API == itemWidget.item.title) {
          context.push(HttpTestWidget());
        } else if (_MyHomePageVM.PERMISSION == itemWidget.item.title) {
          viewModel.requestPermission(PermissionReq(
              [Permission.camera, Permission.location], onGranted: () {
            showToast("权限申请成功");
          }, onDenied: (isPermanentlyDenied) {
            showToast("权限申请失败,是否被多次拒绝或永久拒绝: $isPermanentlyDenied");
          }));
        } else if (_MyHomePageVM.REFRESH == itemWidget.item.title) {
          context.push(RefreshLoadTestWidget());
        } else if (_MyHomePageVM.VIEW_PAGER == itemWidget.item.title) {
          context.push(ViewPagerTest());
        }

        var controller = itemWidget.getController(itemWidget.item.background);
        if (controller.data?.value == Colors.white.value) {
          controller.data = Colors.blueGrey;
        } else {
          controller.data = Colors.white;
        }
      },
      childItemBuilder: (itemWidget, context) {
        var controller = itemWidget.getController(itemWidget.item.background);

        return GetBuilderUtil.builder((controller) {
          return Container(
              width: double.infinity,
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: controller.data),
              margin: const EdgeInsets.only(top: 0.5),
              child: Text(
                itemWidget.item.title,
                style: const TextStyle(fontSize: 16, color: Color(0xff333333)),
              ));
        }, init: controller);
      },
    );
  }
}

class _MyHomePageVM extends BaseListVM<MainTitle> {
  static const String API = "API请求示例";
  static const String REFRESH = "下拉刷新/上拉加载";
  static const String PERMISSION = "权限申请";
  static const String VIEW_PAGER = "ViewPager";

  @override
  void onCreate() {
    super.onCreate();

    appbarController.appbarTitle = "FlutterDemo";

    refreshData(isClear: true, dataList: [
      MainTitle(API),
      MainTitle(REFRESH),
      MainTitle(PERMISSION),
      MainTitle(VIEW_PAGER)
    ]);
  }
}

class MainTitle {
  final String title;
  Color background = Colors.white;

  MainTitle(this.title);
}
