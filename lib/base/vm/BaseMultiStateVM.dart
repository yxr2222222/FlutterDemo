import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/base/model/ViewStateExt.dart';
import 'package:flutter_demo/base/model/em/ViewState.dart';
import 'package:flutter_demo/base/vm/BaseVM.dart';

import '../http/HttpManager.dart';
import '../http/cache/CacheMode.dart';
import '../http/exception/CstHttpException.dart';
import '../http/model/BaseRespConfig.dart';
import '../http/model/ReqType.dart';

abstract class BaseMultiStateVM extends BaseVM {
  // 页面状态
  ViewStateExt _state = const ViewStateExt(ViewState.content);

  ViewStateExt get viewState => _state;

  // appbar 返回图标
  IconData? _appbarBackIcon = Icons.arrow_back_ios;

  IconData? get appbarBackIcon => _appbarBackIcon;

  set appbarBackIcon(IconData? appbarBackIcon) {
    _appbarBackIcon = appbarBackIcon;
    notifyListeners();
  }

  // appbar 标题
  String? _appbarTitle;

  String? get appbarTitle => _appbarTitle;

  set appbarTitle(String? appbarTitle) {
    _appbarTitle = appbarTitle;
    notifyListeners();
  }

  // appbar 标题样式
  TextStyle? _appbarTitleStyle = const TextStyle(
      fontSize: 18, color: Color(0xff333333), fontWeight: FontWeight.bold);

  TextStyle? get appbarTitleStyle => _appbarTitleStyle;

  set appbarTitleStyle(TextStyle? appbarTitleStyle) {
    _appbarTitleStyle = appbarTitleStyle;
    notifyListeners();
  }

  // appbar 背景颜色
  Color? _appbarBackgroundColor = Colors.white;

  Color? get appbarBackgroundColor => _appbarBackgroundColor;

  set appbarBackgroundColor(Color? appbarBackgroundColor) {
    _appbarBackgroundColor = appbarBackgroundColor;
    notifyListeners();
  }

  // appbar elevation
  double? _appbarElevation = 5;

  double? get appbarElevation => _appbarElevation;

  set appbarElevation(double? appbarElevation) {
    _appbarElevation = appbarElevation;
    notifyListeners();
  }

  // appbar 右边操作控件列表
  List<Widget>? _appbarActions;

  List<Widget>? get appbarActions => _appbarActions;

  set appbarActions(List<Widget>? appbarActions) {
    _appbarActions = appbarActions;
    notifyListeners();
  }

  /// 展示内容状态的UI
  void showContentState() {
    _setViewStateExt(const ViewStateExt(ViewState.content));
  }

  /// 展示loading状态的UI
  void showLoadingState({String? loadingTxt}) {
    _setViewStateExt(ViewStateExt(ViewState.loading, hintTxt: loadingTxt));
  }

  /// 展示错误状态的UI
  void showErrorState({String? errorTxt, String? retryTxt}) {
    _setViewStateExt(
        ViewStateExt(ViewState.error, hintTxt: errorTxt, retryTxt: retryTxt));
  }

  /// 展示空状态的UI
  void showEmptyState({String? emptyTxt, String? retryTxt}) {
    _setViewStateExt(
        ViewStateExt(ViewState.empty, hintTxt: emptyTxt, retryTxt: retryTxt));
  }

  /// 重试按钮被点击
  void onRetry() {}

  /// 设置状态
  void _setViewStateExt(ViewStateExt state) {
    _state = state;
    notifyListeners();
  }

  /// 结合多状态UI的网络请求
  void requestWithState<T>({
    required String path,
    required OnFromJson<T>? onFromJson,
    String? loadingTxt,
    bool isShowErrorDetail = false,
    String? retryTxt,
    OnSuccess<T>? onSuccess,
    OnFailed? onFailed,
    ReqType reqType = ReqType.get,
    Map<String, dynamic>? params,
    Options? options,
    Object? body,
    CancelToken? cancelToken,
    BaseRespConfig? respConfig,
    CacheMode? cacheMode = CacheMode.ONLY_NETWORK,
    int? cacheTime,
    String? customCacheKey,
  }) {
    // 展示loading状态UI
    showLoadingState(loadingTxt: loadingTxt);

    super.request(
        path: path,
        onFromJson: onFromJson,
        isNeedLoading: false,
        loadingTxt: loadingTxt,
        isShowErrorToast: false,
        isShowErrorDetailToast: false,
        onSuccess: (T? data) {
          if (!isDisposed) {
            // 接口成功，展示内容状态UI
            showContentState();

            if (onSuccess != null) {
              // 成功回调，可以在此回调自定义操作
              onSuccess(data);
            }
          }
        },
        onFailed: (CstHttpException e) {
          if (!isDisposed) {
            // 接口失败，展示错误状态UI
            showErrorState(
                errorTxt: isShowErrorDetail ? e.detailMessage : e.message,
                retryTxt: retryTxt);

            if (onFailed != null) {
              // 失败回调，可以在此回调自定义操作
              onFailed(e);
            }
          }
        },
        reqType: reqType,
        params: params,
        options: options,
        body: body,
        cancelToken: cancelToken,
        respConfig: respConfig,
        cacheMode: cacheMode,
        cacheTime: cacheTime,
        customCacheKey: customCacheKey);
  }
}
