import 'package:flutter/material.dart';
import 'package:flutter_demo/api/ProductApi.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:yxr_flutter_basic/base/Basic.dart';
import 'package:yxr_flutter_basic/base/extension/BuildContextExtension.dart';
import 'package:yxr_flutter_basic/base/http/HttpManager.dart';
import 'package:yxr_flutter_basic/base/http/cache/CacheConfig.dart';
import 'package:yxr_flutter_basic/base/http/model/RespConfig.dart';
import 'package:yxr_flutter_basic/base/ui/CacheImage.dart';
import 'package:yxr_flutter_basic/base/ui/page/SimpleSplashPage.dart';
import 'package:yxr_flutter_basic/base/vm/BaseVM.dart';
import 'page/FunctionListPage.dart';

void main() async {
  /// 初始化Basic
  await Basic.init();

  /// 初始化网络请求配置
  await HttpManager.getInstance().init(
      // 接口请求的BaseUrl
      baseUrl: "https://portal-api.macrozheng.com",
      // 如果接口请求需要启用缓存，不需要缓存可不配置
      cacheConfig: CacheConfig(),
      debug: true,
      // 返回结果配置，接口返回之后进行内部结果解析
      respConfig: RespConfig(
          filedCode: "code", filedMsg: "message", successCode: "200"));
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
        icon: "images/icon_logo.png",
        title: "FlutterDemo",
        privacyContent: PrivacyContent(
            "我们深知个人信息对您的重要性，为了给您更好的服务，您只须提供必要的信息，我们将依据国家法律法规尽全力保护您的隐私安全，同时恪守以下原则：权责一致、目的明确、选择同意、最少够用、确保安全、主体参与、公开透明。在使用APP前，请仔细阅读并同意本《用户协议》《隐私协议》。",
            [
              KeywordUrl("《用户协议》", "https://www.aliyun.com/"),
              KeywordUrl("《隐私协议》", "https://zhuanlan.zhihu.com/"),
            ]),
        onPrivacyAgree: (viewModel, context) async {
          return _requestSplashData(viewModel, context);
        },
        onFinishJump: (viewModel, context) {
          context.push(FunctionListPage(), finishCurr: true);
        },
      ),
    );
  }

  /// 请求开屏数据
  Future<SplashContent> _requestSplashData(
      BaseVM viewModel, BuildContext context) async {
    viewModel.showLoading();
    var productApi = viewModel.createApi(ProductApi());
    var productDetail = await productApi.getProductDetail("6");
    viewModel.dismissLoading();

    var image = productDetail.data?.brand?.bigPic;
    if (image != null) {
      return SplashContent(
          content: CacheImage.simple(imageUrl: image),
          countDownSeconds: 5);
    }
    return SplashContent(
        content: null, countDownSeconds: 0, showCountDownUi: false);
  }
}
