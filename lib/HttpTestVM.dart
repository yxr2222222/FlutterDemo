import 'package:flutter_demo/base/vm/BaseMultiStateVM.dart';

import 'model/app_update.dart';

class HttpTestVM extends BaseMultiStateVM {
  AppUpdate? _appUpdate;

  AppUpdate? get appUpdate => _appUpdate;

  @override
  void onCreate() {
    super.onCreate();
    requestAppUpdate();
  }

  @override
  void onRetry() {
    requestAppUpdate();
  }

  /// 请求应用更新信息
  void requestAppUpdate() {
    request<AppUpdate>(
        path: "/pub/appUpdate/getAppUpdate",
        loadingTxt: "loading...",
        params: {"os": "0", "machine": "afhkeagjhakgaekl", "version": "1.0.0"},
        onFromJson: (Map<String, dynamic> json) {
          return AppUpdate.fromJson(json['data']);
        },
        onSuccess: (AppUpdate? data) {
          _appUpdate = data;
          appbarTitle = data?.title ?? "未知标题";
          notifyListeners();
        });
  }
}
