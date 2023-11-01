import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_demo/base/extension/StringExtension.dart';
import 'package:flutter_demo/base/ui/page/BaseMultiStatePage.dart';
import 'package:flutter_demo/base/ui/widget/web/WebViewFunction.dart';
import 'package:flutter_demo/base/ui/widget/web/WebViewPlatform.dart';
import 'package:flutter_demo/base/vm/BaseMultiVM.dart';

class SimpleWebPage extends BaseMultiPage<_SimpleWebVM> {
  SimpleWebPage({super.key, required String url, String? title})
      : super(viewModel: _SimpleWebVM(firstUrl: url, title: title));

  @override
  State<StatefulWidget> createState() => _SimpleWebState();
}

class _SimpleWebState extends BaseMultiPageState<_SimpleWebVM, SimpleWebPage> {
  @override
  Widget createMultiContentWidget(
      BuildContext context, _SimpleWebVM viewModel) {
    return WebViewPlatform(
      firstUrl: viewModel.firstUrl,
      function: viewModel.function,
      onPageStarted: (url, title) {
        viewModel.onPageStarted(url, title);
      },
      onPageFinished: (url, title) {},
    );
  }
}

class _SimpleWebVM extends BaseMultiVM {
  final String firstUrl;
  final String? title;
  final WebViewFunction function = WebViewFunction();

  _SimpleWebVM({required this.firstUrl, this.title});

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
  }

  @override
  Future<bool> onBackPressed() async {
    if (await function.canGoBack()) {
      var goBack = await function.goBack();
      if (!goBack) {
        return super.onBackPressed();
      }
      return false;
    }
    return super.onBackPressed();
  }

  @override
  void onRetry() {
    function.reload();
  }

  void onPageStarted(String url, String? title) {
    appbarController.appbarTitle = title;
    showLoadingState(loadingTxt: "Loading...");
  }

  void onPageFinished(String url, String? title) async {
    appbarController.appbarTitle = title;
    if (!url.startsWith("http://") && !url.startsWith("https://")) {
      await url.launch();
      if (url == await function.currentUrl()) {
        await function.goBack();
      } else {
        await function.reload();
      }
    } else {
      showContentState();
    }
  }
}
