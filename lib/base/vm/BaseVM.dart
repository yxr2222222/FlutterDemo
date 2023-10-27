import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/base/extension/BuildContextExtension.dart';
import 'package:flutter_demo/base/util/Log.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../http/HttpManager.dart';
import '../http/cache/CacheMode.dart';
import '../http/exception/CstHttpException.dart';
import '../http/model/BaseRespConfig.dart';
import '../http/model/ReqType.dart';
import '../model/BaseResp.dart';
import '../model/PermissionReq.dart';
import '../util/PermissionUtil.dart';

abstract class BaseVM {
  String? _className;
  BuildContext? _context;
  final List<CancelToken> _cancelTokenList = [];
  OnShowLoading? onShowLoading;
  OnDismissLoading? onDismissLoading;

  void init(BuildContext context) {
    _context = context;
    _className = runtimeType.toString();
  }

  // 上下文
  BuildContext? get context => _context;

  void onCreate() {
    Log.d("$_className: onCreate...");
  }

  void onResume() {
    Log.d("$_className: onResume...");
  }

  void onPause() {
    Log.d("$_className: onPause...");
  }

  void onDestroy() {
    _context = null;
    onShowLoading = null;
    onDismissLoading = null;
    Log.d("$_className: onDestroy...");
  }

  /// 返回按钮点击
  bool onBackPressed() {
    if (_context != null) {
      Navigator.pop(_context!);
      return true;
    }
    return false;
  }

  /// 展示toast
  void showToast(String? msg) {
    if (msg != null) {
      Fluttertoast.showToast(msg: msg);
    }
  }

  /// 请求权限
  void requestPermission(PermissionReq permissionReq) {
    if (_context != null) {
      PermissionUtil.requestPermission(_context!, permissionReq);
    }
  }

  /// 请求网络
  void request<T>({
    required String path,
    required OnFromJson<T>? onFromJson,
    bool isNeedLoading = true,
    bool isLoadingCancelable = false,
    String? loadingTxt,
    bool isShowErrorToast = false,
    bool isShowErrorDetailToast = false,
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
    if (isNeedLoading) {
      showLoading(loadingTxt: loadingTxt, cancelable: isLoadingCancelable);
    }

    cancelToken = cancelToken ?? CancelToken();

    _cancelTokenList.add(cancelToken);

    HttpManager.getInstance().request(
        path: path,
        onFromJson: onFromJson,
        onSuccess: (T? data) {
          if (!isFinishing()) {
            if (isNeedLoading) {
              dismissLoading();
            }
            if (onSuccess != null) {
              onSuccess(data);
            }
          }
        },
        onFailed: (CstHttpException e) {
          if (!isFinishing()) {
            if (isNeedLoading) {
              dismissLoading();
            }

            if (isShowErrorDetailToast == true) {
              showToast(e.detailMessage);
            } else if (isShowErrorToast == true) {
              showToast(e.message);
            }

            if (onFailed != null) {
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

  Future<BaseResp<T>> requestWithFuture<T>({
    required String path,
    required OnFromJson<T>? onFromJson,
    ReqType reqType = ReqType.get,
    Map<String, dynamic>? params,
    Options? options,
    Object? body,
    CancelToken? cancelToken,
    BaseRespConfig? respConfig,
    CacheMode? cacheMode = CacheMode.ONLY_NETWORK,
    int? cacheTime,
    String? customCacheKey,
  }) async {
    return HttpManager.getInstance().requestWithFuture<T>(
        path: path,
        onFromJson: onFromJson,
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

  /// 展示loading弹框
  void showLoading(
      {String? loadingTxt,
      Color? barrierColor,
      bool barrierDismissible = false,
      bool cancelable = false}) {
    if (onShowLoading != null) {
      onShowLoading!(loadingTxt, barrierColor ?? Colors.transparent,
          barrierDismissible, cancelable);
    }
  }

  /// 隐藏loading弹框
  void dismissLoading() {
    if (onDismissLoading != null) {
      onDismissLoading!();
    }
  }

  /// 取消所有未完成的网络请求
  void cancelRequests() {
    for (var cancelToken in _cancelTokenList) {
      cancelRequest(cancelToken);
    }
    _cancelTokenList.clear();
  }

  /// 取消某个网络请求
  void cancelRequest(CancelToken cancelToken) {
    try {
      if (!cancelToken.isCancelled) {
        cancelToken.cancel();
      }
    } catch (e) {
      Log.d(e.toString());
    }
  }

  bool isFinishing() {
    return _context == null || !_context!.isUseful();
  }
}

typedef OnShowLoading = void Function(String? loadingTxt, Color barrierColor,
    bool barrierDismissible, bool cancelable);

typedef OnDismissLoading = void Function();
