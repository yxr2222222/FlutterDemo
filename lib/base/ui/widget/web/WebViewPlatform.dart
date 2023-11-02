import 'package:flutter/cupertino.dart';
import './WebViewApp.dart' if (dart.library.js) './WebViewHtml.dart' as js;
import 'WebViewFunction.dart';

class WebViewPlatform extends StatelessWidget {
  final String firstUrl;
  final WebViewFunction function;

  const WebViewPlatform(
      {super.key, required this.firstUrl, required this.function});

  @override
  Widget build(BuildContext context) {
    return js.WebView(
      firstUrl: firstUrl,
      function: function,
    );
  }
}
