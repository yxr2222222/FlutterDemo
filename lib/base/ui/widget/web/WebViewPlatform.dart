import 'package:flutter/cupertino.dart';
import './WebViewApp.dart' if (dart.library.js) './WebViewHtml.dart' as js;
import 'WebViewFunction.dart';

class WebViewPlatform extends StatelessWidget {
  final void Function(String url, String? title)? onPageStarted;
  final void Function(String url, String? title)? onPageFinished;
  final String firstUrl;
  final WebViewFunction? function;

  const WebViewPlatform(
      {super.key,
      required this.firstUrl,
      this.function,
      this.onPageStarted,
      this.onPageFinished});

  @override
  Widget build(BuildContext context) {
    return js.WebView(
      firstUrl: firstUrl,
      function: function,
      onPageStarted: onPageStarted,
      onPageFinished: onPageStarted,
    );
  }
}
