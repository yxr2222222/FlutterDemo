import 'package:flutter/material.dart';
import 'package:flutter_demo/HttpTestWidget.dart';
import 'package:flutter_demo/base/callback/OnPermissionCallback.dart';
import 'package:flutter_demo/base/extension/BuildContextExtension.dart';
import 'package:flutter_demo/base/model/PermissionReq.dart';
import 'package:flutter_demo/base/vm/BaseListVM.dart';
import 'package:flutter_demo/base/widget/BaseMultiStateWidget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'base/http/HttpManager.dart';
import 'base/http/model/BaseRespConfig.dart';
import 'base/widget/BaseItemWidget.dart';

void main() {
  HttpManager.getInstance().init("http://192.168.1.113:8089/", true,
      BaseRespConfig(filedCode: "code", filedMsg: "message"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
    return ListView.builder(
      itemCount: viewModel.itemBindingList.length,
      itemBuilder: (context, index) {
        var itemBinding = viewModel.itemBindingList[index];
        return GestureDetector(
          onTap: () {
            if (_MyHomePageVM.API == itemBinding.item) {
              context.push(HttpTestWidget());
            } else if (_MyHomePageVM.REFRESH == itemBinding.item) {
              viewModel.showLoading(cancelable: true);
            } else if (_MyHomePageVM.PERMISSION == itemBinding.item) {
              viewModel.requestPermission(PermissionReq(
                  [Permission.camera, Permission.location], onGranted: () {
                showToast("权限申请成功");
              }, onDenied: (isPermanentlyDenied) {
                showToast("权限申请失败,是否被多次拒绝或永久拒绝: $isPermanentlyDenied");
              }));
            }
          },
          child: Container(
              width: double.infinity,
              height: 48,
              alignment: Alignment.center,
              decoration: const BoxDecoration(color: Color(0xffffffff)),
              margin: const EdgeInsets.only(top: 0.5),
              child: Text(
                itemBinding.item,
                style: const TextStyle(fontSize: 16, color: Color(0xff333333)),
              )),
        );
      },
    );
  }
}

class _MyHomePageVM extends BaseListVM<String, ItemBinding<String>> {
  static const String API = "API请求示例";
  static const String REFRESH = "下拉刷新/上拉加载";
  static const String PERMISSION = "权限申请";

  @override
  void onCreate() {
    super.onCreate();

    appbarTitle = "FlutterDemo";

    refreshData(isClear: true, dataList: [
      ItemBinding(API),
      ItemBinding(REFRESH),
      ItemBinding(PERMISSION)
    ]);
  }
}
