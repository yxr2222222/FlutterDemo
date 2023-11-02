import 'package:flutter/material.dart';
import 'package:flutter_demo/base/extension/BuildContextExtension.dart';
import 'package:flutter_demo/base/http/cache/CacheConfig.dart';
import 'package:flutter_demo/base/ui/page/SimpleSplashPage.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'FunctionListPage.dart';
import 'base/http/HttpManager.dart';
import 'base/http/model/BaseRespConfig.dart';

void main() async {
  /// 初始化网络请求配置
  await HttpManager.getInstance().init(
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
      home: SimpleSplashPage(
        privacyContent: PrivacyContent(
            "我们深知个人信息对您的重要性，为了给您更好的服务，您只须提供必要的信息，我们将依据国家法律法规尽全力保护您的隐私安全，同时恪守以下原则：权责一致、目的明确、选择同意、最少够用、确保安全、主体参与、公开透明。在使用APP前，请仔细阅读并同意本《用户协议》《隐私协议》。",
            [
              KeywordUrl("《用户协议》", "https://www.aliyun.com/"),
              KeywordUrl("《隐私协议》", "https://zhuanlan.zhihu.com/"),
            ]),
        onPrivacyAgree: (viewModel, context) async {
          viewModel.showLoading();
          Future.delayed(const Duration(seconds: 1), () {
            viewModel.dismissLoading();
            context.push(FunctionListPage(), finishCurr: true);
          });
        },
        icon: "images/icon_logo.png",
        title: "FlutterDemo",
      ),
    );
  }
}
