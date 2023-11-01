import 'package:flutter_demo/base/ui/widget/web/IWebViewFunction.dart';

class WebViewFunction implements IWebViewFunction {
  IWebViewFunction? _function;

  set function(IWebViewFunction value) {
    _function = value;
  }

  @override
  Future<bool> goBack() async {
    if (_function != null) {
      return _function!.goBack();
    }
    return false;
  }

  @override
  Future<bool> canGoBack() async {
    if (_function != null) {
      return _function!.canGoBack();
    }
    return false;
  }

  @override
  Future<bool> reload() async {
    if (_function != null) {
      return _function!.reload();
    }
    return false;
  }

  @override
  Future<String?> currentUrl() async {
    if (_function != null) {
      return _function!.currentUrl();
    }
    return null;
  }
}
