abstract interface class IWebViewFunction {
  Future<bool> canGoBack();

  Future<bool> goBack();

  Future<bool> reload();

  Future<String?> currentUrl();
}
