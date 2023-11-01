import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'IWebViewFunction.dart';
import 'WebViewFunction.dart';

class WebView extends StatelessWidget implements IWebViewFunction {
  final void Function(String url, String? title)? onPageStarted;
  final void Function(String url, String? title)? onPageFinished;
  final WebViewFunction? function;
  final String firstUrl;
  WebViewController? _controller;

  WebView(
      {super.key,
      required this.firstUrl,
      this.function,
      this.onPageStarted,
      this.onPageFinished});

  @override
  Widget build(BuildContext context) {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xfff2f2f2))
      ..setNavigationDelegate(NavigationDelegate(onPageStarted: (url) async {
        if (onPageStarted != null) {
          var title = await _controller?.getTitle();
          onPageStarted!(url, title);
        }
      }, onPageFinished: (url) async {
        if (onPageFinished != null) {
          var title = await _controller?.getTitle();
          onPageFinished!(url, title);
        }
      }));
    function?.function = this;
    return WebViewWidget(controller: _controller!);
  }

  @override
  Future<bool> goBack() async {
    if (_controller != null) {
      _controller!.goBack();
      return true;
    }
    return false;
  }

  @override
  Future<bool> canGoBack() async {
    if (_controller != null) {
      return _controller!.canGoBack();
    }
    return false;
  }

  @override
  Future<bool> reload() async {
    if (_controller != null) {
      _controller!.reload();
      return true;
    }
    return false;
  }

  @override
  Future<String?> currentUrl() async {
    if (_controller != null) {
      return _controller!.currentUrl();
    }
    return null;
  }
}
