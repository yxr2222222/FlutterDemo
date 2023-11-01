import 'package:flutter/material.dart';
import 'package:flutter_demo/HttpTestWidget.dart';
import 'package:flutter_demo/RefreshLoadTestWidget.dart';
import 'package:flutter_demo/base/extension/BuildContextExtension.dart';
import 'package:flutter_demo/base/http/cache/CacheConfig.dart';
import 'package:flutter_demo/base/model/PermissionReq.dart';
import 'package:flutter_demo/base/vm/BaseListVM.dart';
import 'package:flutter_demo/tab/ViewPagerTest.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:permission_handler/permission_handler.dart';
import 'base/http/HttpManager.dart';
import 'base/http/model/BaseRespConfig.dart';
import 'base/ui/page/BaseMultiStateWidget.dart';

void main() {
  /// 在main函数第一行添加这句话
  WidgetsFlutterBinding.ensureInitialized();
  /// 初始化网络请求配置
  HttpManager.getInstance().init(
      baseUrl: "http://192.168.1.116:8089/",
      cacheConfig: CacheConfig(),
      debug: true,
      respConfig: BaseRespConfig(filedCode: "code", filedMsg: "message"));
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
  Widget createMultiContentWidget(BuildContext context, _MyHomePageVM viewModel) {
    return viewModel.listBuilder(
      onItemClick: (item, context) {
        if (_MyHomePageVM.API == item.item.title) {
          context.push(HttpTestWidget());
        } else if (_MyHomePageVM.PERMISSION == item.item.title) {
          viewModel.requestPermission(PermissionReq(
              [Permission.camera, Permission.location], onGranted: () {
            showToast("权限申请成功");
          }, onDenied: (isPermanentlyDenied) {
            showToast("权限申请失败,是否被多次拒绝或永久拒绝: $isPermanentlyDenied");
          }));
        } else if (_MyHomePageVM.REFRESH == item.item.title) {
          context.push(RefreshLoadTestWidget());
        } else if (_MyHomePageVM.VIEW_PAGER == item.item.title) {
          context.push(ViewPagerTest());
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

class _MyHomePageVM extends BaseListVM<MainTitle> {
  static const String API = "API请求示例";
  static const String REFRESH = "下拉刷新/上拉加载";
  static const String PERMISSION = "权限申请";
  static const String VIEW_PAGER = "ViewPager";

  @override
  void onCreate() {
    super.onCreate();

    appbarController.appbarBackIcon = null;
    appbarController.appbarTitle = "FlutterDemo";

    refreshData(isClear: true, dataList: [
      MainTitle(API),
      MainTitle(REFRESH),
      MainTitle(PERMISSION),
      MainTitle(VIEW_PAGER)
    ]);
  }

  @override
  bool onBackPressed() => false;
}

class MainTitle {
  final String title;
  Color background = Colors.white;

  MainTitle(this.title);
}
