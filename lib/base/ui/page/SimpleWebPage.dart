import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_demo/base/extension/StringExtension.dart';
import 'package:flutter_demo/base/ui/page/BaseMultiStatePage.dart';
import 'package:flutter_demo/base/vm/BaseMultiVM.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../util/Log.dart';

class SimpleWebPage extends BaseMultiPage<_SimpleWebVM> {
  SimpleWebPage({super.key, required String url, String? title})
      : super(viewModel: _SimpleWebVM(url: url, title: title));

  @override
  State<StatefulWidget> createState() => _SimpleWebState();
}

class _SimpleWebState extends BaseMultiPageState<_SimpleWebVM, SimpleWebPage> {
  @override
  Widget createMultiContentWidget(
      BuildContext context, _SimpleWebVM viewModel) {
    return WebViewWidget(controller: viewModel.controller);
  }
}

class _SimpleWebVM extends BaseMultiVM {
  final String? title;
  String _currUrl;

  _SimpleWebVM({required String url, this.title}) : _currUrl = url;

  late final WebViewController controller;

  @override
  void init(BuildContext context) {
    super.init(context);
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xfff2f2f2))
      ..setNavigationDelegate(NavigationDelegate(onPageStarted: (url) async {
        _currUrl = url;
        appbarController.appbarTitle = await controller.getTitle();
        showLoadingState(loadingTxt: "Loading...");
      }, onPageFinished: (url) async {
        appbarController.appbarTitle = await controller.getTitle();
        if (!url.startsWith("http://") && !url.startsWith("https://")) {
          await url.launch();
          if (url == await controller.currentUrl()) {
            await controller.goBack();
          } else {
            await controller.reload();
          }
        } else {
          showContentState();
        }
      }));
  }

  @override
  void onCreate() {
    super.onCreate();
    appbarController.appbarTitle = title;
    appbarController.appbarActions = [
      GestureDetector(
        onTap: () {
          super.onBackPressed();
        },
        child: Container(
          padding:
              const EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 8),
          child: const Text(
            "关闭",
            style: TextStyle(fontSize: 14, color: Color(0xff333333)),
          ),
        ),
      )
    ];

    loadWebUrl();
  }

  @override
  Future<bool> onBackPressed() async {
    if (await controller.canGoBack()) {
      controller.goBack();
      return false;
    }
    return super.onBackPressed();
  }

  @override
  void onRetry() {
    loadWebUrl();
  }

  /// 加载当前网页地址
  void loadWebUrl() {
    try {
      controller.loadRequest(Uri.parse(_currUrl));
    } catch (e) {
      Log.d("loadRequest failed", error: e);
    }
  }
}
